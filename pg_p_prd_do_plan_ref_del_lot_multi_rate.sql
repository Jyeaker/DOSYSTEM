-- FUNCTION: dosystem.p_prd_do_plan_ref_del_lot_multi_rate()

-- DROP FUNCTION IF EXISTS dosystem.p_prd_do_plan_ref_del_lot_multi_rate();

CREATE OR REPLACE FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate(
	)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

    vNEXT_WORKING_DATE       character varying(8);
    vNEXT2_WORKING_DATE      character varying(8);
    vNEXT3_WORKING_DATE      character varying(8);
    V_NEXT_WORKING_DAY       character varying(8);
    V_NEXT_DELV              character varying(8);
    vNEXT_DEL                character varying(8);
    V_TOTAL_PLAN             numeric := 0;
    V_PLAN_BY_RATE           numeric := 0;
    V_REMAIN_PLAN_BY_RATE    numeric := 0;
    V_SUM_QTY_DO             numeric := 0;
    V_PLAN_REMAIN_BY_LOT     numeric := 0;
    V_PLAN_RF_LT_AND_BALANCE numeric := 0;
    V_PLAN_RF_LT             numeric := 0;
    V_PLAN_REMAIN            numeric := 0;
    pFLAG                    numeric := 0;
    V_NEXT_DELV_TIME         character varying(8);
    CHK_SUM_QTY_DO           numeric := 0;

    -- ตัวแปรจำลอง GOTO
    v_goto_calling_next_pg      boolean := false;
    v_goto_calc_plan_remain     boolean := false;
    v_goto_next_target_part_c1  boolean := false;
    v_goto_next_priority_c2     boolean := false;

    rec0 record;
    rec1 record;
    rec2 record;
    rec3 record;
    rec4 record;
BEGIN
    SET statement_timeout = 0;
    SET work_mem = '512MB';

    SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > TO_CHAR(CURRENT_DATE, 'YYYYMMDD') AND MK_WORK = 'Y';

    SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT_WORKING_DATE AND MK_WORK = 'Y';

    SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT2_WORKING_DATE AND MK_WORK = 'Y';

    PERFORM dosystem.P_PRD_DO_FIND_DEL_FOR_MULTI_RATE();

    FOR rec0 IN
        SELECT DISTINCT LOGIC
        FROM dosystem.T_DO_PLAN_BALANCE_QTY
        WHERE RATIO NOT IN ('100', '0') AND PLAN_QTY_BALANCE > 0
    LOOP
        IF rec0.LOGIC = '1' THEN
            vNEXT_DEL          := vNEXT_WORKING_DATE;
            V_NEXT_WORKING_DAY := vNEXT_WORKING_DATE;
        ELSIF rec0.LOGIC = '2' THEN
            vNEXT_DEL          := vNEXT2_WORKING_DATE;
            V_NEXT_WORKING_DAY := vNEXT2_WORKING_DATE;
        ELSIF rec0.LOGIC = '3' THEN
            vNEXT_DEL          := vNEXT3_WORKING_DATE;
            V_NEXT_WORKING_DAY := vNEXT3_WORKING_DATE;
        END IF;

        FOR rec1 IN
            SELECT DISTINCT A.FACTORY_CD, A.PART_NO, A.DIM, A.USE_BLOCK_CD, A.CLASS
            FROM dosystem.T_DO_PLAN_BALANCE_QTY A
            WHERE A.RATIO NOT IN ('100', '0')
              AND A.PLAN_DATE || A.PLAN_TIME >= vNEXT_DEL || '0800'
              AND A.PLAN_QTY_BALANCE > 0
              AND A.LOGIC = rec0.LOGIC
            ORDER BY A.FACTORY_CD, A.PART_NO, A.DIM, A.USE_BLOCK_CD, A.CLASS
        LOOP
            v_goto_next_target_part_c1 := false;

            BEGIN
                SELECT PLAN_DATE, MIN(PLAN_TIME)
                INTO V_NEXT_DELV, V_NEXT_DELV_TIME
                FROM dosystem.T_DO_FIND_DEL_FOR_MULTI_RATE
                WHERE FACTORY_CD  = rec1.FACTORY_CD
                  AND PART_NO     = rec1.PART_NO
                  AND DIM         = rec1.DIM
                  AND USE_BLOCK_CD IN (
                        CASE WHEN rec1.CLASS = 'M/C' THEN rec1.USE_BLOCK_CD
                        ELSE (
                            SELECT DISTINCT BLOCK_CD
                            FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
                            WHERE FACTORY_CD = rec1.FACTORY_CD
                              AND CLASS       = 'M/T'
                              AND PART_NO     = rec1.PART_NO
                              AND DIM         = rec1.DIM
                        ) END
                  )
                  AND PLAN_DATE IS NOT NULL AND PLAN_TIME IS NOT NULL
                  AND CLASS = rec1.CLASS
                GROUP BY PLAN_DATE;
                
                IF NOT FOUND OR V_NEXT_DELV IS NULL THEN
                    V_NEXT_DELV      := NULL;
                    V_NEXT_DELV_TIME := NULL;
                END IF;

                IF V_NEXT_DELV IS NULL OR V_NEXT_DELV_TIME IS NULL THEN
                    BEGIN
                        SELECT DISTINCT FACTORY_CD, PART_NO, DIM, CLASS, PLAN_DATE, PLAN_TIME,
                                        USE_BLOCK_CD, PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT, CURRENT_DATE AS CREATE_DATE
                        INTO rec4
                        FROM dosystem.T_DO_PLAN_BALANCE_QTY
                        WHERE PART_NO     = rec1.PART_NO
                          AND FACTORY_CD  = rec1.FACTORY_CD
                          AND DIM         = rec1.DIM
                          AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                          AND CLASS       = rec1.CLASS
                          AND PLAN_DATE || PLAN_TIME IN (
                                SELECT MIN(PLAN_DATE || PLAN_TIME)
                                FROM dosystem.T_DO_PLAN_BALANCE_QTY
                                WHERE PART_NO     = rec1.PART_NO
                                  AND FACTORY_CD  = rec1.FACTORY_CD
                                  AND DIM         = rec1.DIM
                                  AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                                  AND CLASS       = rec1.CLASS
                                  AND PLAN_DATE || PLAN_TIME >= V_NEXT_WORKING_DAY || '0800'
                          );

                        INSERT INTO dosystem.T_PRD_DO_RESULT
                            (FACTORY_CD, DELIVERY_DATE, DELIVERY_TIME, BLOCK_CD, RESULT, UPDATE_DATE,
                             PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, DELIVERY_ORDER, CD_SPLY_FACT)
                        VALUES
                            (rec4.FACTORY_CD,
                             rec4.PLAN_DATE,
                             rec4.PLAN_TIME,
                             rec4.USE_BLOCK_CD,                            
                             'WF0017',
                             CURRENT_DATE,
                             rec4.PART_NO,
                             rec4.DIM,
                             null, -- ตรงตามที่คุณแก้ เพราะ C2 ยังไม่ทำงาน
                             null, 
                             rec1.CLASS,
                             rec4.PLAN_DATE,
                             rec4.PLAN_TIME,
                             rec4.PLAN_QTY_RF_LT,
                             null); 
                    END;

                ELSIF V_NEXT_DELV IS NOT NULL AND V_NEXT_DELV_TIME IS NOT NULL THEN
                    BEGIN
                        SELECT SUM(PLAN_QTY_RF_LT) INTO V_TOTAL_PLAN
                        FROM (
                            SELECT DISTINCT FACTORY_CD, PART_NO, DIM, PLAN_DATE, PLAN_TIME,
                                            USE_BLOCK_CD, PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT
                            FROM dosystem.T_DO_PLAN_BALANCE_QTY
                            WHERE PART_NO     = rec1.PART_NO
                              AND FACTORY_CD  = rec1.FACTORY_CD
                              AND DIM         = rec1.DIM
                              AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                              AND CLASS       = rec1.CLASS
                              AND PLAN_DATE || PLAN_TIME BETWEEN V_NEXT_WORKING_DAY || '0800' AND V_NEXT_DELV || V_NEXT_DELV_TIME
                        ) sub;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        V_TOTAL_PLAN := NULL;
                    END;

                    V_PLAN_REMAIN := V_TOTAL_PLAN;

                    FOR rec2 IN
                        SELECT DISTINCT A.FACTORY_CD, A.PART_NO, A.DIM, A.BLOCK_CD,
                                        A.SUPPLIER_CD, A.RK_PRIO_DIVI, A.PT_RATIO, B.CD_SPLY_FACT
                        FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE A
                        LEFT JOIN dosystem.WBGJT002 B
                            ON A.PART_NO    = B.NO_PARTS
                           AND A.DIM        = B.NO_ADJ_DIM
                           AND A.SUPPLIER_CD = B.CD_SPLY
                        WHERE A.FACTORY_CD = rec1.FACTORY_CD
                          AND A.CLASS      = rec1.CLASS
                          AND A.PART_NO    = rec1.PART_NO
                          AND A.DIM        = rec1.DIM
                          AND A.BLOCK_CD IN (
                                CASE WHEN rec1.CLASS = 'M/C' THEN rec1.USE_BLOCK_CD
                                ELSE (
                                    SELECT DISTINCT BLOCK_CD
                                    FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
                                    WHERE FACTORY_CD = rec1.FACTORY_CD AND CLASS = 'M/T' AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                ) END
                          )
                        ORDER BY A.RK_PRIO_DIVI
                    LOOP
                        v_goto_next_priority_c2 := false;
                        v_goto_next_target_part_c1 := false;

                        BEGIN
                            SELECT SUM(COALESCE(DELIVERY_ORDER, 0)) INTO CHK_SUM_QTY_DO
                            FROM dosystem.T_PRD_DO_RESULT
                            WHERE FACTORY_CD  = rec1.FACTORY_CD
                              AND RESULT      = 'WF0000'
                              AND BLOCK_CD    = rec1.USE_BLOCK_CD
                              AND PART_NO     = rec1.PART_NO
                              AND DIM         = rec1.DIM
                              AND RATIO NOT IN (0, 100)
                              AND CLASS       = rec1.CLASS
                              AND PLAN_DATE || PLAN_TIME >= vNEXT_DEL || '0800';
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                            CHK_SUM_QTY_DO := 0;
                        END;
                        IF CHK_SUM_QTY_DO IS NULL THEN CHK_SUM_QTY_DO := 0; END IF;

                        -- ใช้ / 100.0 ป้องกันปัญหา Integer Division จาก Postgres ปัดเศษทิ้ง
                        V_PLAN_BY_RATE := CEIL(COALESCE(V_TOTAL_PLAN, 0) * (COALESCE(rec2.PT_RATIO, 0) / 100.0));

                        IF COALESCE(V_PLAN_BY_RATE, 0) <= (COALESCE(V_TOTAL_PLAN, 0) - COALESCE(CHK_SUM_QTY_DO, 0)) THEN
                            V_REMAIN_PLAN_BY_RATE := COALESCE(V_PLAN_BY_RATE, 0);
                        ELSE
                            IF COALESCE(V_TOTAL_PLAN, 0) - COALESCE(CHK_SUM_QTY_DO, 0) > 0 THEN
                                V_REMAIN_PLAN_BY_RATE := COALESCE(V_PLAN_BY_RATE, 0);
                            ELSE
                                V_REMAIN_PLAN_BY_RATE := 0;
                            END IF;
                        END IF;

                        FOR rec3 IN
                            SELECT DISTINCT FACTORY_CD, PART_NO, DIM, CLASS, PLAN_DATE, PLAN_TIME,
                                          USE_BLOCK_CD, PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT, CREATE_DATE
                            FROM dosystem.T_DO_PLAN_BALANCE_QTY
                            WHERE PART_NO      = rec1.PART_NO
                              AND FACTORY_CD   = rec1.FACTORY_CD
                              AND DIM          = rec1.DIM
                              AND CLASS        = rec1.CLASS
                              AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                              AND PLAN_DATE || PLAN_TIME >= vNEXT_DEL || '0800'
                              AND PLAN_DATE || PLAN_TIME <= V_NEXT_DELV || V_NEXT_DELV_TIME
                              AND PLAN_QTY_BALANCE > 0
                              AND PLAN_DATE || PLAN_TIME >= (
                                    SELECT COALESCE(MAX(PLAN_DATE || PLAN_TIME), '0')
                                    FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                    WHERE FACTORY_CD  = rec1.FACTORY_CD
                                      AND PART_NO     = rec1.PART_NO
                                      AND DIM         = rec1.DIM
                                      AND CLASS       = rec1.CLASS
                                      AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                              )
                            ORDER BY PLAN_DATE, PLAN_TIME
                        LOOP
                            v_goto_calling_next_pg   := false;
                            v_goto_calc_plan_remain  := false;

                            IF rec2.RK_PRIO_DIVI IS NOT NULL THEN
                                IF rec2.RK_PRIO_DIVI <> '1' AND pFLAG = 0 THEN
                                    SELECT SUM(COALESCE(PLAN_QTY_RF_LT,0) + COALESCE(PLAN_QTY_BALANCE,0)) INTO V_PLAN_RF_LT_AND_BALANCE
                                    FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                    WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                      AND USE_BLOCK_CD = rec1.USE_BLOCK_CD AND CLASS = rec1.CLASS
                                      AND PLAN_DATE || PLAN_TIME = (
                                            SELECT MAX(PLAN_DATE || PLAN_TIME)
                                            FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                              AND USE_BLOCK_CD = rec1.USE_BLOCK_CD AND CLASS = rec1.CLASS
                                      );

                                    BEGIN
                                        SELECT DISTINCT PLAN_QTY_BALANCE INTO V_PLAN_RF_LT
                                        FROM dosystem.T_DO_PLAN_BALANCE_QTY
                                        WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                          AND USE_BLOCK_CD = rec1.USE_BLOCK_CD AND CLASS = rec1.CLASS
                                          AND PLAN_DATE || PLAN_TIME = (
                                                SELECT MAX(PLAN_DATE || PLAN_TIME)
                                                FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                                  AND CLASS = rec1.CLASS AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                                           );
                                    EXCEPTION WHEN NO_DATA_FOUND THEN V_PLAN_RF_LT := 0; END;

                                    IF V_PLAN_RF_LT IS NULL THEN V_PLAN_RF_LT := 0; END IF;
                                    IF V_PLAN_RF_LT_AND_BALANCE IS NULL THEN V_PLAN_RF_LT_AND_BALANCE := 0; END IF;

                                    IF V_PLAN_RF_LT > V_PLAN_RF_LT_AND_BALANCE THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, V_PLAN_RF_LT - V_PLAN_RF_LT_AND_BALANCE, 0, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);
                                          
                                        V_REMAIN_PLAN_BY_RATE := V_REMAIN_PLAN_BY_RATE - (V_PLAN_RF_LT - V_PLAN_RF_LT_AND_BALANCE);
                                        pFLAG := 1;
                                        CONTINUE; 
                                    ELSIF V_PLAN_RF_LT = V_PLAN_RF_LT_AND_BALANCE THEN
                                        pFLAG := 1;
                                        CONTINUE; 
                                    END IF;
                                END IF; 

                                IF V_PLAN_REMAIN_BY_LOT > 0 THEN
                                    IF V_PLAN_REMAIN_BY_LOT > rec3.PLAN_QTY_RF_LT THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, 0, rec3.PLAN_QTY_RF_LT, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);
                                          
                                        V_PLAN_REMAIN_BY_LOT := V_PLAN_REMAIN_BY_LOT - rec3.PLAN_QTY_RF_LT;
                                        CONTINUE; 

                                    ELSIF V_PLAN_REMAIN_BY_LOT <= rec3.PLAN_QTY_RF_LT THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, 0, V_PLAN_REMAIN_BY_LOT, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);
                                          
                                        V_PLAN_REMAIN_BY_LOT := 0;
                                        v_goto_calc_plan_remain := true; 
                                    END IF;
                                END IF;

                                IF NOT v_goto_calc_plan_remain THEN
                                    IF V_REMAIN_PLAN_BY_RATE > rec3.PLAN_QTY_RF_LT THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, rec3.PLAN_QTY_RF_LT, 0, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);

                                        IF (V_NEXT_DELV || V_NEXT_DELV_TIME = rec3.PLAN_DATE || rec3.PLAN_TIME) THEN
                                            v_goto_calling_next_pg := true;
                                        ELSE
                                            V_REMAIN_PLAN_BY_RATE := V_REMAIN_PLAN_BY_RATE - rec3.PLAN_QTY_RF_LT;
                                            CONTINUE; 
                                        END IF;

                                    ELSIF V_REMAIN_PLAN_BY_RATE <= rec3.PLAN_QTY_RF_LT THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, V_REMAIN_PLAN_BY_RATE, 0, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);
                                          
                                        v_goto_calling_next_pg := true;

                                    ELSIF V_REMAIN_PLAN_BY_RATE = 0 THEN
                                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE)
                                        VALUES (rec3.FACTORY_CD, rec3.PART_NO, rec3.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec3.CLASS, rec3.PLAN_DATE, rec3.PLAN_TIME, rec3.PLAN_QTY_RF_LT, 0, rec3.USE_BLOCK_CD, rec3.CREATE_DATE);

                                        v_goto_calling_next_pg := true;
                                    END IF;
                                END IF;

                                -- [ส่วนที่แก้ไขจำลอง GOTO: CALLING_NEXT_PG]
                                IF v_goto_calling_next_pg THEN
                                    v_goto_calling_next_pg := false;

                                    SELECT * INTO V_SUM_QTY_DO 
                                    FROM dosystem.P_PRD_DO_PLAN_REF_DEL_LOT(
                                        rec1.FACTORY_CD, rec1.PART_NO, rec1.DIM, rec1.USE_BLOCK_CD,
                                        rec2.SUPPLIER_CD, rec1.CLASS, rec2.PT_RATIO, rec0.LOGIC, V_NEXT_WORKING_DAY, rec2.CD_SPLY_FACT
                                    );

                                    V_PLAN_REMAIN_BY_LOT := V_SUM_QTY_DO - V_PLAN_BY_RATE;

                                    IF V_PLAN_REMAIN_BY_LOT > 0 THEN
                                        SELECT SUM(COALESCE(PLAN_QTY_RF_LT,0) + COALESCE(PLAN_QTY_BALANCE,0)) INTO V_PLAN_RF_LT_AND_BALANCE
                                        FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                        WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                          AND USE_BLOCK_CD = rec1.USE_BLOCK_CD AND CLASS = rec1.CLASS
                                          AND PLAN_DATE || PLAN_TIME = (
                                                SELECT MAX(PLAN_DATE || PLAN_TIME)
                                                FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                                  AND CLASS = rec1.CLASS AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                                          );

                                        BEGIN
                                            SELECT DISTINCT PLAN_QTY_BALANCE INTO V_PLAN_RF_LT
                                            FROM dosystem.T_DO_PLAN_BALANCE_QTY
                                            WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                              AND USE_BLOCK_CD = rec1.USE_BLOCK_CD AND CLASS = rec1.CLASS
                                              AND PLAN_DATE || PLAN_TIME = (
                                                    SELECT MAX(PLAN_DATE || PLAN_TIME)
                                                    FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    WHERE FACTORY_CD  = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                                      AND CLASS = rec1.CLASS AND USE_BLOCK_CD = rec1.USE_BLOCK_CD
                                              );
                                        EXCEPTION WHEN NO_DATA_FOUND THEN V_PLAN_RF_LT := 0; END;
                                        
                                        IF V_PLAN_RF_LT IS NULL THEN V_PLAN_RF_LT := 0; END IF;
                                        IF V_PLAN_RF_LT_AND_BALANCE IS NULL THEN V_PLAN_RF_LT_AND_BALANCE := 0; END IF;

                                        IF V_PLAN_RF_LT > V_PLAN_RF_LT_AND_BALANCE THEN
                                            UPDATE dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                            SET    PLAN_QTY_BALANCE = V_PLAN_RF_LT - V_PLAN_RF_LT_AND_BALANCE
                                            WHERE  FACTORY_CD   = rec1.FACTORY_CD AND PART_NO = rec1.PART_NO AND DIM = rec1.DIM
                                              AND  SUPPLIER_CD  = rec2.SUPPLIER_CD AND PLAN_DATE = rec3.PLAN_DATE
                                              AND  PLAN_TIME    = rec3.PLAN_TIME AND CLASS = rec1.CLASS;

                                            V_PLAN_REMAIN_BY_LOT := V_PLAN_REMAIN_BY_LOT - (V_PLAN_RF_LT - V_PLAN_RF_LT_AND_BALANCE);

                                            IF V_PLAN_REMAIN_BY_LOT > 0 THEN
                                                CONTINUE; 
                                            END IF;
                                        END IF;
                                    END IF;
                                    
                                    v_goto_calc_plan_remain := true;
                                END IF;

                                -- [ส่วนที่แก้ไขจำลอง GOTO: CALCULATE_PLAN_REMAIN]
                                IF v_goto_calc_plan_remain THEN
                                    v_goto_calc_plan_remain := false;
                                    
                                    V_PLAN_REMAIN := V_PLAN_REMAIN - V_SUM_QTY_DO;
                                    
                                    IF V_PLAN_REMAIN <= 0 THEN
                                        v_goto_next_target_part_c1 := true;
                                        EXIT; 
                                    ELSIF V_PLAN_REMAIN > 0 THEN
                                        v_goto_next_priority_c2 := true;
                                        EXIT; 
                                    END IF;
                                END IF;

                            END IF; 

                            IF rec2.RK_PRIO_DIVI IS NULL THEN
                                INSERT INTO dosystem.T_PRD_DO_RESULT
                                    (FACTORY_CD, BLOCK_CD, RESULT, UPDATE_DATE, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, CD_SPLY_FACT)
                                VALUES
                                    (rec1.FACTORY_CD, rec1.USE_BLOCK_CD, 'Not found NEXT PRIORITY', CURRENT_DATE,
                                     rec1.PART_NO, rec1.DIM, rec2.SUPPLIER_CD, rec2.PT_RATIO, rec1.CLASS, rec2.CD_SPLY_FACT);
                            END IF;

                        END LOOP; 

                        IF v_goto_next_target_part_c1 THEN
                            EXIT; 
                        END IF;

                        pFLAG := 0;

                    END LOOP; 
                END IF; 
            END;

        END LOOP; 
    END LOOP; 

    RETURN 1;
END;
$BODY$;

ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate()
    OWNER TO dosystem;
