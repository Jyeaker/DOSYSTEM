Main
  PROCEDURE P_PRD_DO_CALUCATION_DAILY_ALL_PROCESS AS
  BEGIN

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'08. DO SYSTEM CALUCATION OVER STD STOCK  START') ;
    COMMIT;        

    PG_PRD_DO_CALCULATION.P_PRD_DO_OVER_STD_STOCK;

     INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'08. DO SYSTEM CALUCATION OVER STD STOCK  COMPLETE') ;
    COMMIT;    
    

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'09. DO SYSTEM MAKE PLAN BALANCE QTY START') ;
    COMMIT;        
  
    
    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_BALANCE_QTY;
 
    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'09. DO SYSTEM MAKE PLAN BALANCE QTY COMPLETE') ;
    COMMIT;        


        INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'10. DO SYSTEM MAKE PLAN REF DEL LOT RATE100 START') ;
    COMMIT;        
  
    
    PG_PRD_DO_CALCULATION_SINGLE_RATE.P_PRD_DO_PLAN_REF_DEL_LOT_RATE100;

     INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'10. DO SYSTEM MAKE PLAN REF DEL LOT RATE100 COMPLETE') ;
    COMMIT;        


    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'11. DO SYSTEM MAKE PLAN REF DEL DATE/ROUND RATE100 START') ;
    COMMIT;   
    
    PG_PRD_DO_CALCULATION_SINGLE_RATE.P_PRD_DO_PLAN_REF_DEL_DATE_RATE100;

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'11. DO SYSTEM MAKE PLAN REF DEL DATE/ROUND RATE100 COMPLETE') ;
    COMMIT;

    
    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'12. DO SYSTEM PLAN SLIDE SUPPORT PRODUCTION CHANGE RATE100 START') ;
    COMMIT;   
    
    PG_PRD_DO_CALCULATION_SINGLE_RATE.PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE;

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'12. DO SYSTEM PLAN SLIDE SUPPORT PRODUCTION CHANGE RATE100 COMPLETE') ;
    COMMIT;
        


    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'13. DO SYSTEM ISSUE DO RATE100 START') ;
    COMMIT;   

    PG_PRD_DO_CALCULATION_SINGLE_RATE.P_PRD_DO_ISSUE_DO_RATE100;

     INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'13. DO SYSTEM ISSUE DO RATE100 COMPLETE') ;
    COMMIT;   



    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'14. DO SYSTEM CLEAR DATA MULTI RATE START') ;
    COMMIT;   
    
     PG_PRD_DO_CALCULATION_MULTI_RATE.P_PRD_DO_ISSUE_DO_CLEAR_DATA;

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'14. DO SYSTEM CLEAR DATA MULTI RATE COMPLETE') ;
    COMMIT;   
    


   INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'15. DO SYSTEM ISSUE DO MULTI RATE START') ;
    COMMIT;   
        
    PG_PRD_DO_CALCULATION_MULTI_RATE.P_PRD_DO_PLAN_REF_DEL_LOT_MULTI_RATE;
 
    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'15. DO SYSTEM ISSUE DO MULTI RATE COMPLETE') ;
    COMMIT;   

    ----------Support DR SUM---------------------------
    execute immediate 'TRUNCATE TABLE T_DO_PLAN_A_AND_Z_DR_SUM' ;
    INSERT INTO T_DO_PLAN_A_AND_Z_DR_SUM  
    SELECT DISTINCT
        "FACTORY_CD",
        "NO_PARTS",
        "NO_ADJ_DIM",
        "CD_USE_BLOCK",
        "CLASS",
        "PLAN_DATE",
        "PLAN_TIME",
        "PLAN_QTY",
        "TOTAL_PROCESS_LT",
        "LOGIC"
    FROM v_do_plan_a_and_z;

    INSERT INTO T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MISS'),'16. DO SYSTEM ISSUE SUPPORT DR SUM') ;
    COMMIT;   
    
    
     ----------END---------------------------   
  END P_PRD_DO_CALUCATION_DAILY_ALL_PROCESS;
  10.
   PROCEDURE P_PRD_DO_PLAN_REF_DEL_LOT_RATE100 AS

V_QT_DELV_LOT             NUMBER(20);
V_REMAIN_QTY              NUMBER(20,4);
V_SNP_LOT                 NUMBER(20);
V_QTY_REF_LOT             NUMBER(20);
vFLG_IN_HOUSE            VARCHAR2(10) := NULL;
--
vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT_DEL               VARCHAR2(8 BYTE);

CURSOR C0 IS SELECT DISTINCT LOGIC FROM T_DO_PLAN_BALANCE_QTY;
REC0		C0%rowtype; 


CURSOR C1 IS SELECT DISTINCT A.FACTORY_CD ,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.SUPPLIER_CD,A.CLASS,B.CD_SPLY_FACT
                FROM T_DO_PLAN_BALANCE_QTY A
                LEFT JOIN WBGJT002@FROM_EUC_NPIS B
                ON A.PART_NO = B.NO_PARTS
                AND A.DIM = B.NO_ADJ_DIM
                AND A.SUPPLIER_CD = B.CD_SPLY
                WHERE A.RATIO = 100 
                    AND A.PLAN_DATE||A.PLAN_TIME >= vNEXT_DEL||'0800'
                    AND A.PLAN_QTY_BALANCE > 0
                    AND A.LOGIC = REC0.LOGIC
                ORDER BY A.FACTORY_CD,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.SUPPLIER_CD,A.CLASS;
REC1		C1%rowtype; 

CURSOR C2 IS SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_BALANCE
                FROM T_DO_PLAN_BALANCE_QTY A
                LEFT JOIN WBGJT002@FROM_EUC_NPIS B
                ON A.PART_NO = B.NO_PARTS
                AND A.DIM = B.NO_ADJ_DIM
                AND A.SUPPLIER_CD = B.CD_SPLY
                WHERE RATIO = 100 
                    AND PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                    AND PLAN_QTY_BALANCE > 0
                    AND FACTORY_CD = REC1.FACTORY_CD
                    AND PART_NO = REC1.PART_NO
                    AND DIM = REC1.DIM
                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                    AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                    AND CLASS = REC1.CLASS
                    AND LOGIC = REC0.LOGIC
                    AND B.CD_SPLY_FACT = REC1.CD_SPLY_FACT
                ORDER BY PLAN_DATE,PLAN_TIME;
REC2		C2%rowtype; 



BEGIN
-- 0.) Delete data table  T_DO_PLAN_BALANCE_QTY
DELETE FROM  T_DO_PLAN_REF_DELIVERY_LOT ;

-- 1.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(sysdate,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

        -- 3.)  Open CUR 0      
        OPEN C0;
        LOOP
        FETCH C0 INTO REC0;
        EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;

                --Set value  vNEXT_DEL  
                IF REC0.LOGIC = '1' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '2' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT2_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '3' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT3_WORKING_DATE;
                    END;
                END IF;
                

                -- 6.)  Open CUR 1       
                OPEN C1;
                LOOP
                FETCH C1 INTO REC1;
                EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
                
                        BEGIN            
                        SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                        FROM T_PRD_DO_DELIVERY_MASTER
                            WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
                             SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT FROM T_PRD_DO_DELIVERY_MASTER 
                             WHERE  FACTORY_CD = REC1.FACTORY_CD--'RA'
                             AND SUPPLIER_CD = REC1.SUPPLIER_CD--'P181'
                             AND EFFECT_STA_DATE <= TO_CHAR(SYSDATE,'YYYYMMDD')
                             AND CD_SPLY_FACT = REC1.CD_SPLY_FACT--'00'
                             GROUP BY FACTORY_CD,SUPPLIER_CD,CD_SPLY_FACT);
                            
         
                        EXCEPTION WHEN NO_DATA_FOUND THEN           
                    
                    
                                vFLG_IN_HOUSE := NULL; 
                                
                        END;
                    
                    -- 8.)
                    IF vFLG_IN_HOUSE = 'Y' THEN
                    
                                OPEN C2;
                                LOOP
                                FETCH C2 INTO REC2;
                                EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
                                
                                
                                INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                                (FACTORY_CD,
                                                PART_NO,
                                                DIM,
                                                USE_BLOCK_CD,
                                                SUPPLIER_CD,
                                                RATIO,
                                                CLASS,
                                                PLAN_DATE,
                                                PLAN_TIME,
                                                PLAN_QTY_REF_LOT,
                                                CREATE_DATE,
                                                LOGIC,
                                                CD_SPLY_FACT)
                                    VALUES (REC1.FACTORY_CD	,
                                            REC1.PART_NO,
                                            REC1.DIM,
                                            REC1.USE_BLOCK_CD,
                                            REC1.SUPPLIER_CD,
                                            100,
                                            REC1.CLASS,
                                            REC2.PLAN_DATE,
                                            REC2.PLAN_TIME,
                                            REC2.PLAN_QTY_BALANCE,                                    
                                            SYSDATE,
                                            REC0.LOGIC,
                                            REC1.CD_SPLY_FACT);
                                    COMMIT;  
                                
                                
                                END LOOP; -- END LOOP CUR 2
                                CLOSE C2;  
                    
                    -- 9.)vFLG_IN_HOUSE  <>  Y
                    ELSE
                    
                                        BEGIN
                                                -- 9.1) Get lot delivery from supplier
                                                SELECT DISTINCT  QT_DELV_LOT INTO V_QT_DELV_LOT								
                                                FROM WBGJT002@FROM_EUC_NPIS							
                                                WHERE CD_SPLY = REC1.SUPPLIER_CD		
                                                    AND NO_PARTS = REC1.PART_NO				
                                                    AND NO_ADJ_DIM = REC1.DIM	
                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                    AND DT_ENTRY = (SELECT MAX(DT_ENTRY) FROM WBGJT002@FROM_EUC_NPIS	 
                                                                    WHERE CD_SPLY = REC1.SUPPLIER_CD AND NO_PARTS = REC1.PART_NO AND NO_ADJ_DIM = REC1.DIM
                                                                    GROUP BY CD_SPLY,NO_PARTS,NO_ADJ_DIM,CD_SPLY_FACT)
                                                    ;
                                                    
                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                    V_QT_DELV_LOT := 0;
                                        END;
                                        -- 9.2) Set Initial data
                                        V_REMAIN_QTY := 0;
                                        
                                        -- 9.3)  Open CUR 2
                                        OPEN C2;
                                        LOOP
                                        FETCH C2 INTO REC2;
                                        EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
                                            
                                            BEGIN
                                            
                                                -- 9.4) Check  data   PLAN_QTY_BALANCE STD   >  V_REMAIN_QTY
                                                IF REC2.PLAN_QTY_BALANCE > V_REMAIN_QTY AND V_QT_DELV_LOT <> 0 THEN --#รอบนั้นต้อง Order ของ
                                                        --คำนวนหา SNP ของ LOT ที่ต้อง ORDER
                                                        V_SNP_LOT := CEIL((REC2.PLAN_QTY_BALANCE - V_REMAIN_QTY) / V_QT_DELV_LOT);
                                                        
                                                        V_QTY_REF_LOT := V_SNP_LOT * V_QT_DELV_LOT;
                                                        
                                                        V_REMAIN_QTY := ROUND((V_QTY_REF_LOT - (REC2.PLAN_QTY_BALANCE - V_REMAIN_QTY)),4);
                                                        
                                                        INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                                                    (FACTORY_CD,
                                                                    PART_NO,
                                                                    DIM,
                                                                    USE_BLOCK_CD,
                                                                    SUPPLIER_CD,
                                                                    RATIO,
                                                                    CLASS,
                                                                    PLAN_DATE,
                                                                    PLAN_TIME,
                                                                    PLAN_QTY_REF_LOT,
                                                                    CREATE_DATE,
                                                                    LOGIC,
                                                                    CD_SPLY_FACT)
                                                        VALUES (REC1.FACTORY_CD	,
                                                                REC1.PART_NO,
                                                                REC1.DIM,
                                                                REC1.USE_BLOCK_CD,
                                                                REC1.SUPPLIER_CD,
                                                                100,
                                                                REC1.CLASS,
                                                                REC2.PLAN_DATE,
                                                                REC2.PLAN_TIME,
                                                                V_QTY_REF_LOT,                                    
                                                                SYSDATE,
                                                                REC0.LOGIC,
                                                                REC1.CD_SPLY_FACT);
                                                        COMMIT;                             
                                                        
                                                --END IF;   
                                                
                                                ELSE  --#รอบนั้นไม่ต้อง Order ของ                  
                                                        V_QTY_REF_LOT := 0;
                                                        
                                                        V_REMAIN_QTY := ROUND((V_REMAIN_QTY - REC2.PLAN_QTY_BALANCE),4);
                                                        
                                                        INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                                                    (FACTORY_CD,
                                                                    PART_NO,
                                                                    DIM,
                                                                    USE_BLOCK_CD,
                                                                    SUPPLIER_CD,
                                                                    RATIO,
                                                                    CLASS,
                                                                    PLAN_DATE,
                                                                    PLAN_TIME,
                                                                    PLAN_QTY_REF_LOT,
                                                                    CREATE_DATE,
                                                                    LOGIC,
                                                                    CD_SPLY_FACT)
                                                        VALUES (REC1.FACTORY_CD	,
                                                                REC1.PART_NO,
                                                                REC1.DIM,
                                                                REC1.USE_BLOCK_CD,
                                                                REC1.SUPPLIER_CD,
                                                                100,
                                                                REC1.CLASS,
                                                                REC2.PLAN_DATE,
                                                                REC2.PLAN_TIME,
                                                                0,                                    
                                                                SYSDATE,
                                                                REC0.LOGIC,
                                                                REC1.CD_SPLY_FACT);
                                                        COMMIT;     
                                                
                                                END IF;
                                                
                                            END;
                                        END LOOP; -- END LOOP CUR 2
                                        CLOSE C2;              
                                        
                    END IF;
        
        
                                            
                END LOOP; -- END LOOP CUR 1
                CLOSE C1;  
        END LOOP; -- END LOOP CUR 0
        CLOSE C0;  

END P_PRD_DO_PLAN_REF_DEL_LOT_RATE100;
11.
PROCEDURE P_PRD_DO_PLAN_REF_DEL_DATE_RATE100 AS

V_delivery_date             VARCHAR2(8 BYTE);
V_delivery_Time             VARCHAR2(4 BYTE);
V_Day                       VARCHAR2(3 BYTE);
V_COUNT                     NUMBER(3);
V_COUNT_HOL                 NUMBER(3);
V_MIN_DT_DELV               VARCHAR2(8 BYTE);
V_Num_Day_Slide             NUMBER(3);
V_Next_PlanDate             VARCHAR2(8 BYTE);
V_PLAN_DATETIME             VARCHAR2(12 BYTE);
VChk_Flg                    VARCHAR2(1 BYTE);
vFLG_IN_HOUSE               VARCHAR2(10) := NULL;
--
vNEXT_WORKING_DATE          VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE         VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE         VARCHAR2(8 BYTE);
vNEXT_DEL                   VARCHAR2(8 BYTE);
--20230424 Add logic for support Supplier have many location
vCnt_SPLY_FACT              NUMBER;
vPLAN_DATE                  VARCHAR2(8 BYTE);
vPLAN_TIME                  VARCHAR2(12 BYTE);
vPLAN_QTY_REF_LOT           NUMBER;

CURSOR C0 IS SELECT DISTINCT LOGIC FROM T_DO_PLAN_REF_DELIVERY_LOT;
REC0		C0%rowtype; 


CURSOR C1 IS  SELECT DISTINCT FACTORY_CD ,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,UPPER(NM_KEY_TABLE) AS V_NM_KEY_TABLE , 
'D' AS V_CombiDay,A.CD_SPLY_FACT--PD_DELV_QTY_ROUND_DEF AS V_CombiDay
                FROM T_DO_PLAN_REF_DELIVERY_LOT A
                LEFT JOIN V_DO_DELEVERY_DAY_OF_WEEK B
                ON A.PART_NO = B.NO_PARTS
                AND A.DIM = B.NO_ADJ_DIM
                LEFT JOIN ( SELECT * FROM J000_SUPPLIER_MASTER@FROM_EUC_NPIS 
                                 WHERE CD_SPLY||TO_CHAR(DT_ENTRY,'YYYYMMD HH24MISS') IN (
                                 SELECT DISTINCT  CD_SPLY||MAX(TO_CHAR(DT_ENTRY,'YYYYMMD HH24MISS')) 
                                 FROM J000_SUPPLIER_MASTER@FROM_EUC_NPIS
                                 GROUP BY CD_SPLY )) C
                ON A.SUPPLIER_CD = C.CD_SPLY
                WHERE A.PLAN_DATE||A.PLAN_TIME >= vNEXT_DEL||'0800'
                    AND A.RATIO = 100 
                    AND A.PLAN_QTY_REF_LOT > 0
                    AND A.LOGIC = REC0.LOGIC
                ORDER BY A.FACTORY_CD,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.SUPPLIER_CD,A.CLASS;
                
REC1		C1%rowtype; 


CURSOR C2 IS SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT
                FROM T_DO_PLAN_REF_DELIVERY_LOT
                WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                    AND RATIO = 100 
                    AND PLAN_QTY_REF_LOT > 0
                    AND FACTORY_CD = REC1.FACTORY_CD	
                    AND PART_NO	= REC1.PART_NO
                    AND DIM	= REC1.DIM
                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                    AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                    AND CLASS = REC1.CLASS
                    AND LOGIC = REC0.LOGIC
                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                ORDER BY PLAN_DATE,PLAN_TIME;
REC2		C2%rowtype; 



BEGIN




-- 0.) Delete data table  T_DO_PLAN_BALANCE_QTY
DELETE FROM  T_DO_PLAN_REF_DELIVERY_DATE ;

-- 1.)Get Next Working Day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(sysdate,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';


-- 3.)Open CUR 0       
OPEN C0;
LOOP
FETCH C0 INTO REC0;
EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;

            -- 3.1)Set value  vNEXT_DEL  
                IF REC0.LOGIC = '1' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '2' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT2_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '3' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT3_WORKING_DATE;
                    END;
                END IF;


            -- 6.)  Open CUR 1       
            OPEN C1;
            LOOP
            FETCH C1 INTO REC1;
            EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
                            -- 7.)
                            BEGIN            
                            SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                            FROM T_PRD_DO_DELIVERY_MASTER
                                WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
                                 SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT 
                                 FROM T_PRD_DO_DELIVERY_MASTER 
                                 WHERE  FACTORY_CD = REC1.FACTORY_CD
                                 AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                 AND EFFECT_STA_DATE <= vNEXT_DEL -- TO_CHAR(SYSDATE,'YYYYMMDD')
                                 AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                 GROUP BY FACTORY_CD,SUPPLIER_CD,CD_SPLY_FACT);
                                
             
                            EXCEPTION WHEN NO_DATA_FOUND THEN           
                        
                        
                                    vFLG_IN_HOUSE := NULL; 
                                    
                            END;
            
                -- 8.)
                IF (vFLG_IN_HOUSE = 'Y') THEN
            
                        OPEN C2;
                        LOOP
                        FETCH C2 INTO REC2;
                        EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
            
                                   BEGIN
                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                 '100',
                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                 REC2.PLAN_DATE,       REC2.PLAN_TIME,
                                                                 REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                 REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                    
                                                EXCEPTION
                                                    WHEN OTHERS THEN
                                                       NULL ;
                                    END;    
                            END LOOP; -- END LOOP CUR 2
                            CLOSE C2;   
                -- 9.)vFLG_IN_HOUSE  <>  Y       
                ELSE 
                                    BEGIN
                                        -- Check count CD_SPLY_FACT 
                                        SELECT COUNT(*) INTO vCnt_SPLY_FACT
                                        FROM V_PRD_DO_DELIVERY_MASTER
                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                        AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                                    END;
                                    -- 9.0)Case Not found CD_SPLY_FACT (From Cur 1) OR table V_PRD_DO_DELIVERY_MASTER
                                    IF REC1.CD_SPLY_FACT is null OR vCnt_SPLY_FACT = 0 THEN
                                    BEGIN
                                    
                                    SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT INTO vPLAN_DATE,vPLAN_TIME,vPLAN_QTY_REF_LOT                                    
                                    FROM T_DO_PLAN_REF_DELIVERY_LOT
                                    WHERE FACTORY_CD = REC1.FACTORY_CD
                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                                    
                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                 '100',
                                                                                                 vPLAN_DATE,            vPLAN_TIME,
                                                                                                 vPLAN_DATE,            vPLAN_TIME,
                                                                                                 vPLAN_QTY_REF_LOT,     'WF0030',
                                                                                                 REC0.LOGIC,            REC1.CD_SPLY_FACT);
                                                                                        
                                                                                    EXCEPTION
                                                                                        WHEN OTHERS THEN
                                                                                           NULL ;
                                    
                                    END;
                                    END IF;
                                    
                                    -- 9.1)  Open CUR 2
                                    OPEN C2;
                                    LOOP
                                    FETCH C2 INTO REC2;
                                    EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
                                        
                                        BEGIN
                                        
                                            -- 9.2) Check  MK_DAY_INTEGRATE not null 
                                            IF REC1.V_NM_KEY_TABLE IS NOT NULL THEN
                                            
                                                    -- 9.2.1) Set Initial data 
                                                    V_delivery_date := REC2.PLAN_DATE;
                                                    V_delivery_Time := REC2.PLAN_TIME;
                                                    
                                                    BEGIN
                                                        --SELECT TO_CHAR(TO_DATE(REC2.PLAN_DATE,'YYYYMMDD')+1,'YYYYMMDD') INTO V_Next_PlanDate FROM DUAL;
                                                        SELECT MIN(dt_work) INTO V_Next_PlanDate 
                                                        FROM wbgzt051@FROM_EUC_NPIS
                                                        WHERE dt_work > REC2.PLAN_DATE
                                                            AND mk_work = 'Y';
                                                    END;
                                                    
                                                    -- Check Day on Plan data and plan Time                            
                                                    BEGIN
                                                        SELECT TO_CHAR(TO_DATE(V_delivery_date,'YYYYMMDD'),'DY') INTO V_Day
                                                        FROM DUAL;
                                                        
                                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_Day := NULL;                            
                                                    END;
                                                    
                                                     -- 9.2.2) Check MK_DAY_INTEGRATE  Like %Day% 
                                                    IF REC1.V_NM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN
                                                    
                                                            BEGIN
                                                            
                                                                SELECT NVL(COUNT(*),0) INTO V_COUNT
                                                                FROM V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = REC1.FACTORY_CD
                                                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                                    AND TIME_ETA = REC2.PLAN_TIME
                                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                                                                    
                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                    V_COUNT := 0;              
                                                            END;
                                                            -- Support milkrun
                                                            IF  REC2.PLAN_TIME IN ('0000','0100','0200','0300','0400','0500','0600','0700') THEN 
                                                            
                                                                            SELECT  COUNT(*) INTO V_COUNT_HOL
                                                                            FROM WBGZT051@FROM_EUC_NPIS 
                                                                            WHERE MK_WORK = 'N'
                                                                            --AND DT_WORK = TO_CHAR(TO_DATE(REC2.PLAN_DATE,'YYYYMMDD')+1,'YYYYMMDD') ;
                                                                            AND DT_WORK = (SELECT MIN(dt_work) FROM wbgzt051@FROM_EUC_NPIS
                                                                                            WHERE dt_work > REC2.PLAN_DATE AND mk_work = 'Y');
                                                                            
                                                                            IF V_COUNT_HOL > 0 THEN 
                                                                                     V_COUNT := 0;  
                                                                            END IF;
                         
                                                            END IF;
                                                            
                                                            
                                                            -- 9.2.2.3) วันตรงกับ Combli , รอบการส่งตรงกับ Plan
                                                            IF V_COUNT > 0 THEN                                            
                                                                        BEGIN
                                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                 '100',
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 V_delivery_date,       V_delivery_Time,
                                                                                                 REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                 REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                        
                                                                                    EXCEPTION
                                                                                        WHEN OTHERS THEN
                                                                                           NULL ;
                                                                        END;
                                                             -- 9.2.2.4) วันตรงกับ Combli , รอบการส่งไม่ตรงกับ Plan
                                                             ELSIF V_COUNT = 0 THEN 
                                                                    BEGIN
                                                                    
                                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN
                                                                                                    (REC1.FACTORY_CD,   REC1.PART_NO,
                                                                                                        REC1.DIM,       REC1.SUPPLIER_CD,
                                                                                                        V_Next_PlanDate,
                                                                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                                                                        vNEXT_DEL,      REC1.CD_SPLY_FACT,
                                                                                                        V_delivery_date,V_delivery_Time);
                                                                        IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                                                BEGIN
                                                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         V_delivery_date,       V_delivery_Time,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                                
                                                                                            EXCEPTION
                                                                                                WHEN OTHERS THEN
                                                                                                   NULL ;
                                                                                END;
                                                                        ELSE 
                                                                                BEGIN
                                                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                                
                                                                                            EXCEPTION
                                                                                                WHEN OTHERS THEN
                                                                                                   NULL ;
                                                                                END;
                                                                        
                                                                        END IF;
                                                                    END;                                                
                                                             END IF;-- V_COUNT > 0
                                                             
                                                    -- 9.2.3) วันไม่ตรงกับ Combli 
                                                    ELSE           
                                                            BEGIN
                                                                        
                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN
                                                                                            (REC1.FACTORY_CD, REC1.PART_NO,
                                                                                                REC1.DIM,       REC1.SUPPLIER_CD,
                                                                                                V_Next_PlanDate,
                                                                                                REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                                                                vNEXT_DEL,      REC1.CD_SPLY_FACT,
                                                                                                V_delivery_date,V_delivery_Time);
                                                                IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                                        BEGIN
                                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                     REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                     REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                     REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                     '100',
                                                                                                     REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                     V_delivery_date,       V_delivery_Time,
                                                                                                     REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                     REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                        
                                                                                    EXCEPTION
                                                                                        WHEN OTHERS THEN
                                                                                           NULL ;
                                                                        END;
                                                                ELSE
                                                                        BEGIN
                                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                     REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                     REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                     REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                     '100',
                                                                                                     REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                     REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                     REC2.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                                     REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                        
                                                                                    EXCEPTION
                                                                                        WHEN OTHERS THEN
                                                                                           NULL ;
                                                                        END;
                                                                
                                                                END IF;
                                                            END;        
                                                    END IF;-- V_MK_DAY_INTEGRATE LIKE '%'||V_Day||'%'
                                                    
                                            END IF;-- V_MK_DAY_INTEGRATE IS NOT NULL
                                            ----------------------------------------------------------------------------------------------
                                            -- 9.3) Check  MK_DAY_INTEGRAT Is  null 
                                            IF  REC1.V_NM_KEY_TABLE IS NULL AND REC1.V_CombiDay = 'D' THEN
                                        
                                                        BEGIN
                                                            BEGIN
                                                                SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                                FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                        From V_DO_WORKING_DAY 
                                                                                        UNION
                                                                                        SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                        From V_DO_WORKING_DAY)
                                                                          WHERE MK_WORK = 'Y' 
                                                                          ) A
                                                                JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                WHERE FACTORY_CD = REC1.FACTORY_CD
                                                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= REC2.PLAN_DATE||REC2.PLAN_TIME
                                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                ( 
                                                                                SELECT  DT_WORK||'0000' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                 UNION
                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                )C )
                                                                   --  AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800'  --- ALISA 20221203
                                                                ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                                
                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                V_PLAN_DATETIME := NULL;       
                                                            END;
                                                            
                                                            IF V_PLAN_DATETIME IS NOT NULL THEN
                                                                V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                                V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                                                
                                                            ELSE 
                                                                BEGIN
                                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                 '100',
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 REC2.PLAN_QTY_REF_LOT, 'WF0019',
                                                                                                 REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                    
                                                                                EXCEPTION
                                                                                    WHEN OTHERS THEN
                                                                                       NULL ;
                                                                    END;
                                                            END IF;
                                                               

                                                            IF V_delivery_date||V_delivery_Time >= vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                                        --    IF V_delivery_date >= vNEXT_DEL AND V_PLAN_DATETIME IS NOT NULL THEN --BY Alisa20221203
                                                                    BEGIN
                                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                 '100',
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 V_delivery_date,       V_delivery_Time,
                                                                                                 REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                 REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                    
                                                                                EXCEPTION
                                                                                    WHEN OTHERS THEN
                                                                                       NULL ;
                                                                    END;
                                                            
                                                              ELSIF V_delivery_date||V_delivery_Time < vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN

                                                         --   ELSIF V_delivery_date < vNEXT_DEL AND V_PLAN_DATETIME IS NOT NULL THEN --BY Alisa20221203
                                                                    BEGIN
                                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                 REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                 REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                 REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                 '100',
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                 REC2.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                                 REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                    
                                                                                EXCEPTION
                                                                                    WHEN OTHERS THEN
                                                                                       NULL ;
                                                                    END;
                                                            
                                                            END IF;
                                                                    
                                                                
                                                            --END IF;
                                                            
                                                        END;                                            

                                            ELSIF REC1.V_NM_KEY_TABLE IS NULL AND ( REC1.V_CombiDay <> 'D' ) THEN
            
                                                    BEGIN
                                                            -- 9.4.1) Get data MIN(DT_DELV)
                                                            SELECT MIN(DT_DELV) INTO V_MIN_DT_DELV
                                                            FROM T_PUR_PO_FOR_DO_DAILY_J300@FROM_EUC_NPIS
                                                            WHERE NM_ARGMET_STAT IN ('PG','PO','MG','FC')
                                                                AND NO_PARTS = REC1.PART_NO
                                                                AND NO_ADJ_DIM = REC1.DIM                                
                                                                AND CD_USE_BLOCK = CASE WHEN REC1.CLASS = 'M/C' THEN REC1.USE_BLOCK_CD 
                                                                                    ELSE '      ' END
                                                                AND DT_DELV >= REC2.PLAN_DATE
                                                                AND NO_ORD_CLASS = '4600'
                                                                AND CD_SPLY = REC1.SUPPLIER_CD;
                                                                
                                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                            V_MIN_DT_DELV := NULL;                                              
                                                    END;
                                                    
                                                    -- 9.4.2) If  DT_DELV  not found data  or value is null 
                                                    IF V_MIN_DT_DELV IS NULL THEN
                                                        BEGIN
                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                     REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                     REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                     REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                     '100',
                                                                                     REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                     REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                     REC2.PLAN_QTY_REF_LOT, 'WF0017',
                                                                                     REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                        
                                                                    EXCEPTION
                                                                        WHEN OTHERS THEN
                                                                           NULL ;
                                                        END; 
                                                    
                                                    -- 9.4.3)IF  ( V_CombiDay  BETWEEN '2' AND '9' ) Or V_CombiDay = W OR M
                                                    ELSIF (REC1.V_CombiDay BETWEEN '2' AND '9') OR (REC1.V_CombiDay = 'W' OR   REC1.V_CombiDay = 'M') THEN
                                                        BEGIN
                                                            
                                                            -- 9.4.3.1) Set Initial
                                                                    V_delivery_date := V_MIN_DT_DELV;
                                                                    VChk_Flg := 'Y';
                                                                    --V_delivery_Time := REC2.PLAN_TIME;
                                                                    
                                                            IF REC1.V_CombiDay = 'W' THEN
                                                                V_Num_Day_Slide := 7;
                                                            ELSIF REC1.V_CombiDay = 'M' THEN
                                                                V_Num_Day_Slide := 30;
                                                            END IF;
                                                                    
                                                            IF V_delivery_date = REC2.PLAN_DATE THEN
                                                                BEGIN
                                                                    BEGIN
                                                                        SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                                        FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                                From V_DO_WORKING_DAY 
                                                                                                UNION
                                                                                                SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                                From V_DO_WORKING_DAY)
                                                                                  WHERE MK_WORK = 'Y' 
                                                                                  ) A
                                                                        JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                        ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                                                            AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                                            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC2.PLAN_TIME
                                                                            AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                                (
                                                                                                SELECT  DT_WORK||'0000' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                 UNION
                                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                )C )
                                                                          --  AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800'  --- ALISA 20221203
                                                                        ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                                        
                                                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                        V_PLAN_DATETIME := NULL;       
                                                                    END;
                                                                    
                                                                    IF V_PLAN_DATETIME IS NOT NULL THEN
                                                                        V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                                        V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                                                        
                                                                    
                                                                    ELSE -- V_PLAN_DATETIME is  null    
                                                                        BEGIN
                                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0019',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                            
                                                                                        EXCEPTION
                                                                                            WHEN OTHERS THEN
                                                                                               NULL ;
                                                                            END;
                                                                    END IF;
                                                                       
                                                                    IF V_delivery_date||V_delivery_Time >= vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL  THEN
                                                                    --IF V_delivery_date >= vNEXT_DEL AND V_PLAN_DATETIME IS NOT NULL  THEN ---BY Alias20221203
                                                                            BEGIN
                                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         V_delivery_date,       V_delivery_Time,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                            
                                                                                        EXCEPTION
                                                                                            WHEN OTHERS THEN
                                                                                               NULL ;
                                                                            END;
                                                                            
                                                                     ELSIF V_delivery_date||V_delivery_Time < vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                                                 --   ELSIF V_delivery_date < vNEXT_DEL AND V_PLAN_DATETIME IS NOT NULL THEN ---BY Alias20221203
                                                                            BEGIN
                                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                            
                                                                                        EXCEPTION
                                                                                            WHEN OTHERS THEN
                                                                                               NULL ;
                                                                            END;
                                                                    
                                                                    END IF;
                                                                END;
                                                            -- 9.4.3.4)    
                                                            ELSIF V_delivery_date <> REC2.PLAN_DATE THEN
                                                                BEGIN
                                                                    -- 2.3.1.2) WHILE LOOP (Delivery_date||V_delivery_Time > Plan_date||Plan_Time)      
                                                                    WHILE (V_delivery_date||V_delivery_Time > REC2.PLAN_DATE||REC2.PLAN_TIME OR VChk_Flg ='N') 
                                                                    LOOP
                                                                    
                                                                        IF REC1.V_CombiDay BETWEEN '2' AND '9' THEN
                                                                            BEGIN                            
                                                                                    SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                                                    FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                                                            WHERE MK_WORK = 'Y'
                                                                                            AND DT_WORK < V_delivery_date
                                                                                            ORDER BY DT_WORK DESC )
                                                                                    WHERE ROWNUM <= REC1.V_CombiDay;
                                                                                    
                                                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                                    V_delivery_date := NULL;   
                                                                            END;
                                                                        ELSIF REC1.V_CombiDay = 'W' OR   REC1.V_CombiDay = 'M' THEN                                            
                                                                            BEGIN                            
                                                                                    SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                                                    FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                                                            WHERE DT_WORK < V_delivery_date
                                                                                            ORDER BY DT_WORK DESC )
                                                                                    WHERE ROWNUM <= V_Num_Day_Slide;
                                                                                    
                                                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                                    V_delivery_date := NULL;         
                                                                            END;
                                                                        END IF;                                        
                                                                        
                                                                        IF VChk_Flg = 'N' THEN
                                                                            BEGIN
                                                                                SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                                                FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                                        From V_DO_WORKING_DAY 
                                                                                                        UNION
                                                                                                        SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                                        From V_DO_WORKING_DAY)
                                                                                          WHERE MK_WORK = 'Y' 
                                                                                          ) A
                                                                                JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                                ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                                WHERE FACTORY_CD = REC1.FACTORY_CD
                                                                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||'9999'
                                                                                    AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                            ( 
                                                                                            SELECT  DT_WORK||'0000' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                 UNION
                                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                            )C )
                                                                                  AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800'  --- ALISA 20221203
                                                                                ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                                                
                                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                                V_PLAN_DATETIME := NULL;       
                                                                            END;
                                                                            
                                                                        ELSIF VChk_Flg = 'Y' THEN
                                                                            BEGIN
                                                                                SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                                                FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                                        From V_DO_WORKING_DAY 
                                                                                                        UNION
                                                                                                        SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                                        From V_DO_WORKING_DAY)
                                                                                          WHERE MK_WORK = 'Y' 
                                                                                          ) A
                                                                                JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                                ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                                WHERE FACTORY_CD = REC1.FACTORY_CD
                                                                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC2.PLAN_TIME
                                                                                    AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                                ( SELECT  DT_WORK||'0000' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                 UNION
                                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                )C )
                                                                                     AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800'  --- ALISA 20221203
                                                                                ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                                                
                                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                                V_PLAN_DATETIME := NULL;       
                                                                            END;
                                                                        END IF;
                                                                        
                                                                        IF V_PLAN_DATETIME IS NOT NULL THEN
                                                                            V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                                            V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                                                            VChk_Flg := 'Y';
                                                                        ELSE
                                                                        
                                                                            BEGIN
                                                                                IF V_delivery_date||REC2.PLAN_TIME <= REC2.PLAN_DATE||REC2.PLAN_TIME THEN
                                                                                    V_delivery_date := V_delivery_date;
                                                                                    VChk_Flg := 'N';
                                                                                ELSIF V_delivery_date||REC2.PLAN_TIME > REC2.PLAN_DATE||REC2.PLAN_TIME THEN
                                                                                    V_delivery_date := V_delivery_date;
                                                                                    VChk_Flg := 'Y';
                                                                                END IF;
                                                                            END;
                                                                            
                                                                        END IF;
                                                                    END LOOP;                                                                    
                                                                  
                                                                    IF V_delivery_date >= vNEXT_DEL  THEN
                                                                            BEGIN
                                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         V_delivery_date,       V_delivery_Time,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                            
                                                                                        EXCEPTION
                                                                                            WHEN OTHERS THEN
                                                                                               NULL ;
                                                                            END;
                                                                    ELSE
                                                                            BEGIN
                                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                                         REC1.FACTORY_CD,       REC1.PART_NO,
                                                                                                         REC1.DIM,              REC1.USE_BLOCK_CD,
                                                                                                         REC1.SUPPLIER_CD,      REC1.CLASS,
                                                                                                         '100',
                                                                                                         REC2.PLAN_DATE,        REC2.PLAN_TIME,
                                                                                                         V_delivery_date,       V_delivery_Time,
                                                                                                         REC2.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                                         REC0.LOGIC,           REC1.CD_SPLY_FACT);
                                                                                            
                                                                                        EXCEPTION
                                                                                            WHEN OTHERS THEN
                                                                                               NULL ;
                                                                            END;
                                                                    
                                                                    END IF;   
                                                                END;
                                                            END IF;-- V_delivery_date = REC2.PLAN_DATE
                                                        
                                                        END;
                                                
                                                    END IF;-- V_MIN_DT_DELV IS NULL
                                            END IF; -- MK_DAY_INTEGRAT Is  null 
                                            
                                        END;
                                    END LOOP; -- END LOOP CUR 2
                                    CLOSE C2;      
                
                END IF;
                
                
            
                                        
            END LOOP; -- END LOOP CUR 1
            CLOSE C1;  
            
END LOOP; -- END LOOP CUR 0
CLOSE C0;  

END P_PRD_DO_PLAN_REF_DEL_DATE_RATE100;
11.1
PROCEDURE P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pUSE_BLOCK_CD  VARCHAR2,
                                                    pSUPPLIER_CD   VARCHAR2,                                                    
                                                    pCLASS         VARCHAR2,
                                                    pRATIO         VARCHAR2,
                                                    pPLAN_DATE     VARCHAR2,
                                                    pPLAN_TIME     VARCHAR2,
                                                    pPLAN_DATE_REF_DEL_DATE  VARCHAR2,
                                                    pPLAN_TIME_REF_DEL_ROUND  VARCHAR2,
                                                    pPLAN_QTY      VARCHAR2,
                                                    pCOMMENT_MSG   VARCHAR2,
                                                    pLogic         VARCHAR2,
                                                    pCD_SPLY_FACT  VARCHAR2) AS
BEGIN

    BEGIN
        INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE
                                    (FACTORY_CD,
                                    PART_NO,
                                    DIM,
                                    USE_BLOCK_CD,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    PLAN_DATE,
                                    PLAN_TIME,
                                    PLAN_DATE_REF_DEL_DATE,
                                    PLAN_TIME_REF_DEL_ROUND,
                                    PLAN_QTY,
                                    COMMENT_MSG,
                                    CREATE_DATE,
                                    LOGIC,
                                    CD_SPLY_FACT)
                            VALUES (pFACTORY_CD,
                                    pPART_NO,
                                    pDIM,
                                    pUSE_BLOCK_CD,
                                    pSUPPLIER_CD,
                                    pRATIO,
                                    pCLASS,
                                    pPLAN_DATE,
                                    pPLAN_TIME,
                                    pPLAN_DATE_REF_DEL_DATE, 
                                    pPLAN_TIME_REF_DEL_ROUND,
                                    pPLAN_QTY,
                                    pCOMMENT_MSG,
                                    SYSDATE,
                                    pLogic,
                                    pCD_SPLY_FACT);
                        COMMIT;
                        EXCEPTION
                        WHEN OTHERS THEN
                           NULL ;
    END;
END P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS;
11.2
PROCEDURE P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pSUPPLIER_CD   VARCHAR2, 
                                                    pNEXT_PLANDATE VARCHAR2,
                                                    pPLAN_DATE     VARCHAR2,
                                                    pPLAN_TIME     VARCHAR2,
                                                    pNEXT_DEL      VARCHAR2,
                                                    pCD_SPLY_FACT   VARCHAR2,
                                                    pPLAN_DATE_SLIDE     OUT VARCHAR2,
                                                    pPLAN_TIME_SLIDE     OUT VARCHAR2) AS         
                                                    
CURSOR C3 IS SELECT * FROM V_DO_DELEVERY_DAY_OF_WEEK A
                JOIN V_DO_WORKING_DAY B
                ON UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_START||'%'
                OR UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_END||'%'
                WHERE B.MK_WORK = 'Y'
                AND B.START_TIME >= pNEXT_DEL||'0800'                
                AND B.END_TIME <= pNEXT_PLANDATE||'0700'
                AND A.NO_PARTS = pPART_NO
                AND A.NO_ADJ_DIM = pDIM
                ORDER BY END_TIME DESC;
REC3		C3%rowtype;
CNT    VARCHAR2(5) := 0 ; 
BEGIN
--Set Initial
pPLAN_DATE_SLIDE := NULL;
pPLAN_TIME_SLIDE := NULL;

-- 1.3)  Open CUR 3
    OPEN C3;
    LOOP
    FETCH C3 INTO REC3;
    EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
    BEGIN
    
    --Date modify 11-Mar-2022 :  by Alisa 
    SELECT COUNT(*) INTO CNT FROM WBGZT051@FROM_EUC_NPIS 
    WHERE MK_WORK = 'Y' 
    AND DT_WORK = SUBSTR(REC3.END_TIME,0,8);
    

    
        IF ( UPPER(REC3.NM_KEY_TABLE) LIKE '%'||REC3.DATE_END||'%' ) AND CNT > 0 THEN 
        
                pPLAN_DATE_SLIDE := SUBSTR(REC3.END_TIME,0,8);
                
                IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0000' AND '0700'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                
                ELSIF  pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0000' AND '0700'
                                    AND TIME_ETA < pPLAN_TIME
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                END IF;
                
         
        ELSE 
        
            pPLAN_DATE_SLIDE := null;  
            pPLAN_TIME_SLIDE := null;   
        
        
        END IF ;
                 
        IF ( UPPER(REC3.NM_KEY_TABLE) LIKE '%'||REC3.DATE_START||'%' ) AND pPLAN_DATE_SLIDE IS NULL AND pPLAN_TIME_SLIDE IS NULL  THEN 
                
                pPLAN_DATE_SLIDE := SUBSTR(REC3.START_TIME,0,8);
                
                IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME)  THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0800' AND '2300'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                ELSIF pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0800' AND '2300'
                                    AND TIME_ETA < pPLAN_TIME
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                END IF;
                
        ELSE
            pPLAN_DATE_SLIDE := null;  
            pPLAN_TIME_SLIDE := null;   
                
        END IF;        
        
        IF pPLAN_DATE_SLIDE IS NOT NULL AND pPLAN_TIME_SLIDE IS NOT NULL THEN
            GOTO OUT_OF_CUR3;
        END IF;
    
    END;
    END LOOP; -- END LOOP CUR 3
    
    << OUT_OF_CUR3>>
    CLOSE C3;

END P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN;
12.
PROCEDURE PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE(pFACTORY_CD      VARCHAR2,
                                            pPART_NO       VARCHAR2,
                                            pDIM           VARCHAR2,
                                            pUSE_BLOCK_CD  VARCHAR2,
                                            pSUPPLIER_CD   VARCHAR2,                                                    
                                            pCLASS         VARCHAR2,
                                            pRATIO         VARCHAR2,
                                            pLogic          VARCHAR2,
                                            pNEXT_DEL       VARCHAR2,
                                            pFLG    OUT NUMBER )
                                             AS
                                            


vNEXT_NEXT_DEL          VARCHAR2(8 BYTE);
vFirst_round            VARCHAR2(4 BYTE);

BEGIN

            BEGIN
                -- 2.1.2)Get Find first delivery round on Delivery master
                SELECT MIN(TIME_ETA) INTO vFirst_round
                FROM V_PRD_DO_DELIVERY_MASTER
                WHERE FACTORY_CD  = pFACTORY_CD
                AND SUPPLIER_CD  = pSUPPLIER_CD
                AND TIME_ETA BETWEEN '0800' AND '2300';
                
                EXCEPTION WHEN NO_DATA_FOUND THEN           
                    vFirst_round := NULL; 
            END;
            
            -- 1.1)IF vFirst_round is not null
            IF vFirst_round IS NOT NULL THEN
                BEGIN
                
                    INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE 
                    SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                            pNEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',SYSDATE,LOGIC,CD_SPLY_FACT
                    FROM T_DO_PLAN_REF_DELIVERY_DATE
                    WHERE PLAN_DATE = pNEXT_DEL
                    AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                    AND LOGIC = pLogic
                    AND RATIO NOT IN ( '100','0' )
                    AND PLAN_QTY > 0
                    AND FACTORY_CD = pFACTORY_CD
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND COMMENT_MSG =  'WF0018' ;
                
                END;
            -- 2.1) IF vFirst_round is not null    
            ELSIF vFirst_round IS NULL THEN            
 
                    BEGIN
                    
                        SELECT MIN(DT_WORK) INTO vNEXT_NEXT_DEL
                        FROM WBGZT051@FROM_EUC_NPIS
                        WHERE DT_WORK > pNEXT_DEL
                        AND MK_WORK = 'Y';                    
                    
                    END;
                    
                    BEGIN
                    
                        INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE 
                        SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                                vNEXT_NEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',SYSDATE,LOGIC,CD_SPLY_FACT
                        FROM T_DO_PLAN_REF_DELIVERY_DATE
                        WHERE PLAN_DATE||PLAN_TIME BETWEEN pNEXT_DEL||'0800' AND vNEXT_NEXT_DEL||vFirst_round
                        AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                        AND LOGIC = pLogic
                        AND RATIO NOT IN ( '100','0' )
                        AND PLAN_QTY > 0
                        AND FACTORY_CD = pFACTORY_CD
                        AND SUPPLIER_CD = pSUPPLIER_CD
                        AND COMMENT_MSG =  'WF0018' ;               
                    
                    END;
                
                
                
                     
            END IF;
            pFLG := 1 ;
        


END PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE;
13.
PROCEDURE P_PRD_DO_ISSUE_DO_RATE100 AS

vFLG_IN_HOUSE            VARCHAR2(10) := NULL;
V_ROW_CNT               NUMBER(4);
V_QT_BAL_PLAN           NUMBER(12);
V_QT_BAL_PO             NUMBER(12);
V_MIN_ROW_NUM           VARCHAR2(12 BYTE); 
v_DLV_KEY_NO            VARCHAR2(31 BYTE); 
v_QT_DELV_DIRCT_BAL     VARCHAR2(12 BYTE);
v_CD_DELV_PLACE         VARCHAR2(12 BYTE);
V_MIN_DT_DELV           VARCHAR2(8 BYTE);
--
vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT_DEL               VARCHAR2(8 BYTE);

CURSOR C0 IS    SELECT DISTINCT LOGIC 
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND COMMENT_MSG = 'WF0000';

REC0		C0%rowtype; 


CURSOR C1 IS SELECT *
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND PLAN_QTY > 0
                AND COMMENT_MSG <> 'WF0000';

REC1		C1%rowtype;

CURSOR C2 IS SELECT DISTINCT FACTORY_CD ,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,COMMENT_MSG,CD_SPLY_FACT
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND PLAN_QTY > 0
                AND COMMENT_MSG = 'WF0000'
                AND PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN vNEXT_DEL||'0800' AND 
                                                                            (SELECT MIN(DT_WORK) FROM WBGZT051@FROM_EUC_NPIS 
                                                                            WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL)||'0759'
                AND LOGIC = REC0.LOGIC
                ORDER BY FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,COMMENT_MSG;
                                            

REC2		C2%rowtype;

CURSOR C3 IS SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN vNEXT_DEL||'0800' AND 
                                                                            (SELECT MIN(DT_WORK) FROM WBGZT051@FROM_EUC_NPIS 
                                                                            WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL)||'0759'
                    AND RATIO = 100
                    AND PLAN_QTY > 0
                    AND COMMENT_MSG = 'WF0000'
                    AND FACTORY_CD = REC2.FACTORY_CD	
                    AND PART_NO	= REC2.PART_NO
                    AND DIM	= REC2.DIM
                    AND SUPPLIER_CD = REC2.SUPPLIER_CD
                    AND USE_BLOCK_CD = REC2.USE_BLOCK_CD
                    AND CLASS = REC2.CLASS
                    AND LOGIC = REC0.LOGIC
                    AND CD_SPLY_FACT = REC2.CD_SPLY_FACT
                GROUP BY FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,PLAN_DATE,PLAN_TIME  
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND;
REC3		C3%rowtype;


BEGIN

-- 0.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(sysdate,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';


--1. Clear data T_PRD_DO_RESULT

DELETE FROM T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT_WORKING_DATE||'0800'
    AND RATIO = 100;

DELETE FROM T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT2_WORKING_DATE||'0800'
    AND RATIO = 100;
    
DELETE FROM T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT3_WORKING_DATE||'0800'
    AND RATIO = 100;
    

-- #Case Result is error
-- 2.)  Open CUR 1
 OPEN C1;
LOOP
FETCH C1 INTO REC1;
EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
BEGIN
    INSERT INTO T_PRD_DO_RESULT
                                    (FACTORY_CD,
                                        DELIVERY_DATE,
                                        DELIVERY_TIME,
                                        DELIVERY_ORDER,
                                        BLOCK_CD,
                                        INVENTORY_CODE,
                                        RESULT,
                                        UPDATE_DATE,
                                        PLAN_DATE,
                                        PLAN_TIME,
                                        PART_NO,
                                        DIM,
                                        SUPPLIER_CD,
                                        RATIO,
                                        CLASS,
                                        LOGIC,
                                        CD_SPLY_FACT)
                            VALUES (REC1.FACTORY_CD,
                                    REC1.PLAN_DATE_REF_DEL_DATE,
                                    REC1.PLAN_TIME_REF_DEL_ROUND,
                                    REC1.PLAN_QTY,
                                    REC1.USE_BLOCK_CD,
                                    DECODE(REC2.CLASS,'M/T','  ', NULL),
                                    REC1.COMMENT_MSG,
                                    SYSDATE,
                                    REC1.PLAN_DATE,
                                    REC1.PLAN_TIME,
                                    REC1.PART_NO,
                                    REC1.DIM,
                                    REC1.SUPPLIER_CD,
                                    REC1.RATIO,
                                    REC1.CLASS,
                                    REC1.LOGIC,
                                    REC1.CD_SPLY_FACT);
                        COMMIT;
                        EXCEPTION
                        WHEN OTHERS THEN
                           NULL ;
END;
END LOOP; -- END LOOP CUR 1
CLOSE C1;
COMMIT ;

--#Case Result is OK
-- 2.)  Open CUR 0
OPEN C0;
LOOP
FETCH C0 INTO REC0;
EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;
BEGIN
            
            --Set value  vNEXT_DEL  
                IF REC0.LOGIC = '1' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '2' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT2_WORKING_DATE;
                    END;
                    
                ELSIF REC0.LOGIC = '3' THEN
                    BEGIN
                        vNEXT_DEL := vNEXT3_WORKING_DATE;
                    END;
                END IF;
            
            -- 2.)  Open CUR 2
            OPEN C2;
            LOOP
            FETCH C2 INTO REC2;
            EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
            BEGIN
                --Set Initial Data
                
                        BEGIN            
                            SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                            FROM T_PRD_DO_DELIVERY_MASTER
                                WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD IN (
                                 SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD FROM T_PRD_DO_DELIVERY_MASTER 
                                 WHERE  FACTORY_CD = REC2.FACTORY_CD
                                 AND SUPPLIER_CD = REC2.SUPPLIER_CD
                                 AND EFFECT_STA_DATE <= TO_CHAR(SYSDATE,'YYYYMMDD')
                                 --AND CD_SPLY_FACT = REC2.CD_SPLY_FACT
                                 GROUP BY FACTORY_CD,SUPPLIER_CD);
                                
             
                            EXCEPTION WHEN NO_DATA_FOUND THEN           
                        
                        
                                    vFLG_IN_HOUSE := NULL; 
                                    
                            END;
                
                
                    IF (vFLG_IN_HOUSE = 'Y') THEN
            
                        OPEN C3;
                        LOOP
                        FETCH C3 INTO REC3;
                        EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
            
                                                     BEGIN
                                                            INSERT INTO T_PRD_DO_RESULT
                                                                        (FACTORY_CD,
                                                                            DELIVERY_KEY,
                                                                            DELIVERY_DATE,
                                                                            DELIVERY_TIME,
                                                                            DELIVERY_ORDER,
                                                                            BLOCK_CD,
                                                                            INVENTORY_CODE,
                                                                            DELIVERY_LOCATION,
                                                                            RESULT,
                                                                            UPDATE_DATE,
                                                                            PLAN_DATE,
                                                                            PLAN_TIME,
                                                                            PART_NO,
                                                                            DIM,
                                                                            SUPPLIER_CD,
                                                                            RATIO,
                                                                            CLASS,
                                                                            LOGIC,
                                                                            CD_SPLY_FACT)
                                                                VALUES (REC2.FACTORY_CD,
                                                                        NULL,
                                                                        REC3.PLAN_DATE_REF_DEL_DATE,
                                                                        REC3.PLAN_TIME_REF_DEL_ROUND,
                                                                        REC3.PLAN_QTY,
                                                                        DECODE(REC2.CLASS,'M/T','    ', REC2.USE_BLOCK_CD),
                                                                        DECODE(REC2.CLASS,'M/T','  ', NULL),
                                                                         NULL,
                                                                        'WF0000',
                                                                        SYSDATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            COMMIT;
                                                            EXCEPTION
                                                            WHEN OTHERS THEN
                                                               NULL ;
                                                        END; 
                            END LOOP; -- END LOOP CUR 2
                            CLOSE C3;    
                ELSE 
                
                
                
                                V_ROW_CNT := 0;
                                V_QT_BAL_PLAN := NULL;
                                V_QT_BAL_PO := 0;
                                -- 2.)  Open CUR 3
                                OPEN C3;
                                LOOP
                                FETCH C3 INTO REC3;
                                EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
                                BEGIN
                                     --Set Initial Data 
                                     V_QT_BAL_PLAN := REC3.PLAN_QTY;
                                      V_MIN_DT_DELV := '00000000';
                                     
                                     WHILE V_QT_BAL_PLAN > 0 AND ( V_MIN_DT_DELV <= REC3.PLAN_DATE )
                                     LOOP
                                    IF V_QT_BAL_PO = 0 THEN
                                            BEGIN
                                                PG_PRD_DO_CALCULATION.P_PRD_DO_GET_DLV_KEY_NO( REC2.FACTORY_CD,
                                                                         REC2.PART_NO,          REC2.DIM,              
                                                                         REC2.USE_BLOCK_CD,     REC2.SUPPLIER_CD,
                                                                         V_ROW_CNT,             REC3.PLAN_DATE_REF_DEL_DATE,--vNEXT_DEL,  
                                                                         --output
                                                                         V_MIN_ROW_NUM,         v_DLV_KEY_NO, 
                                                                         V_QT_BAL_PO,           v_CD_DELV_PLACE ,
                                                                         V_MIN_DT_DELV);
                                                            
                                                        EXCEPTION
                                                            WHEN OTHERS THEN
                                                               NULL ;
                                            END;
                                            
                                                    IF ( V_MIN_DT_DELV > REC3.PLAN_DATE OR V_MIN_DT_DELV IS NULL)THEN
                                                          V_QT_BAL_PO := 0;
                                                            BEGIN
                                                                        INSERT INTO T_PRD_DO_RESULT
                                                                                    (FACTORY_CD,
                                                                                        DELIVERY_DATE,
                                                                                        DELIVERY_TIME,
                                                                                        DELIVERY_ORDER,
                                                                                        BLOCK_CD,
                                                                                        INVENTORY_CODE,
                                                                                        RESULT,
                                                                                        UPDATE_DATE,
                                                                                        PLAN_DATE,
                                                                                        PLAN_TIME,
                                                                                        PART_NO,
                                                                                        DIM,
                                                                                        SUPPLIER_CD,
                                                                                        RATIO,
                                                                                        CLASS,
                                                                                        LOGIC,
                                                                                        CD_SPLY_FACT)
                                                                            VALUES (REC2.FACTORY_CD,
                                                                                    REC3.PLAN_DATE_REF_DEL_DATE,
                                                                                    REC3.PLAN_TIME_REF_DEL_ROUND,
                                                                                    V_QT_BAL_PLAN,
                                                                                    DECODE(REC2.CLASS,'M/T','    ', REC2.USE_BLOCK_CD),
                                                                                    DECODE(REC2.CLASS,'M/T','  ', NULL),
                                                                                    'WF0020',
                                                                                    SYSDATE,
                                                                                    REC3.PLAN_DATE,
                                                                                    REC3.PLAN_TIME,
                                                                                    REC2.PART_NO,
                                                                                    REC2.DIM,
                                                                                    REC2.SUPPLIER_CD,
                                                                                    100,
                                                                                    REC2.CLASS,
                                                                                    REC0.LOGIC,
                                                                                    REC2.CD_SPLY_FACT);
                                                                        COMMIT;
                                                                        EXCEPTION
                                                                        WHEN OTHERS THEN
                                                                           NULL ;
                                                                    END;
                                                
                                                    END IF;
                                            
                                        ELSIF  V_QT_BAL_PO > 0 THEN
                                            BEGIN
                                                IF V_QT_BAL_PLAN > V_QT_BAL_PO THEN
                                                    BEGIN
                                                        BEGIN
                                                            INSERT INTO T_PRD_DO_RESULT
                                                                        (FACTORY_CD,
                                                                            DELIVERY_KEY,
                                                                            DELIVERY_DATE,
                                                                            DELIVERY_TIME,
                                                                            DELIVERY_ORDER,
                                                                            BLOCK_CD,
                                                                            INVENTORY_CODE,
                                                                            DELIVERY_LOCATION,
                                                                            RESULT,
                                                                            UPDATE_DATE,
                                                                            PLAN_DATE,
                                                                            PLAN_TIME,
                                                                            PART_NO,
                                                                            DIM,
                                                                            SUPPLIER_CD,
                                                                            RATIO,
                                                                            CLASS,
                                                                            LOGIC,
                                                                            CD_SPLY_FACT)
                                                                VALUES (REC2.FACTORY_CD,
                                                                        v_DLV_KEY_NO,
                                                                        REC3.PLAN_DATE_REF_DEL_DATE,
                                                                        REC3.PLAN_TIME_REF_DEL_ROUND,
                                                                        V_QT_BAL_PO,
                                                                        DECODE(REC2.CLASS,'M/T','    ', REC2.USE_BLOCK_CD),
                                                                        DECODE(REC2.CLASS,'M/T','  ', NULL),
                                                                        v_CD_DELV_PLACE,
                                                                        'WF0000',
                                                                        SYSDATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            COMMIT;
                                                            EXCEPTION
                                                            WHEN OTHERS THEN
                                                               NULL ;
                                                        END;
                                                        --Set Value
                                                        V_QT_BAL_PLAN := V_QT_BAL_PLAN - V_QT_BAL_PO;
                                                        V_QT_BAL_PO := 0;
                                                        V_ROW_CNT := V_MIN_ROW_NUM;
                                                        
                                                    END;
                                                
                                                ELSIF  V_QT_BAL_PLAN <= V_QT_BAL_PO THEN
                                                    BEGIN
                                                        BEGIN
                                                            INSERT INTO T_PRD_DO_RESULT
                                                                        (FACTORY_CD,
                                                                            DELIVERY_KEY,
                                                                            DELIVERY_DATE,
                                                                            DELIVERY_TIME,
                                                                            DELIVERY_ORDER,
                                                                            BLOCK_CD,
                                                                            INVENTORY_CODE,
                                                                            DELIVERY_LOCATION,
                                                                            RESULT,
                                                                            UPDATE_DATE,
                                                                            PLAN_DATE,
                                                                            PLAN_TIME,
                                                                            PART_NO,
                                                                            DIM,
                                                                            SUPPLIER_CD,
                                                                            RATIO,
                                                                            CLASS,
                                                                            LOGIC,
                                                                            CD_SPLY_FACT)
                                                                VALUES (REC2.FACTORY_CD,
                                                                        v_DLV_KEY_NO,
                                                                        REC3.PLAN_DATE_REF_DEL_DATE,
                                                                        REC3.PLAN_TIME_REF_DEL_ROUND,
                                                                        V_QT_BAL_PLAN,
                                                                        DECODE(REC2.CLASS,'M/T','    ', REC2.USE_BLOCK_CD),
                                                                        DECODE(REC2.CLASS,'M/T','  ', NULL),
                                                                        v_CD_DELV_PLACE,
                                                                        'WF0000',
                                                                        SYSDATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            COMMIT;
                                                            EXCEPTION
                                                            WHEN OTHERS THEN
                                                               NULL ;
                                                        END;
                                                        --Set Value
                                                        V_QT_BAL_PO := V_QT_BAL_PO - V_QT_BAL_PLAN;
                                                        V_QT_BAL_PLAN := 0;
                                                        V_ROW_CNT := V_MIN_ROW_NUM;
                                                    END;
                                                END IF; --V_QT_BAL_PLAN > V_QT_BAL_PO 
                                                
                                            END;
                                        ELSIF V_QT_BAL_PO IS NULL THEN 
                                            BEGIN
                                                BEGIN
                                                    INSERT INTO T_PRD_DO_RESULT
                                                                (FACTORY_CD,
                                                                    DELIVERY_DATE,
                                                                    DELIVERY_TIME,
                                                                    DELIVERY_ORDER,
                                                                    BLOCK_CD,
                                                                    INVENTORY_CODE,
                                                                    RESULT,
                                                                    UPDATE_DATE,
                                                                    PLAN_DATE,
                                                                    PLAN_TIME,
                                                                    PART_NO,
                                                                    DIM,
                                                                    SUPPLIER_CD,
                                                                    RATIO,
                                                                    CLASS,
                                                                    LOGIC,
                                                                    CD_SPLY_FACT)
                                                        VALUES (REC2.FACTORY_CD,
                                                                REC3.PLAN_DATE_REF_DEL_DATE,
                                                                REC3.PLAN_TIME_REF_DEL_ROUND,
                                                                V_QT_BAL_PLAN,
                                                                DECODE(REC2.CLASS,'M/T','    ', REC2.USE_BLOCK_CD),
                                                                DECODE(REC2.CLASS,'M/T','  ', NULL),
                                                                'WF0020',
                                                                SYSDATE,
                                                                REC3.PLAN_DATE,
                                                                REC3.PLAN_TIME,
                                                                REC2.PART_NO,
                                                                REC2.DIM,
                                                                REC2.SUPPLIER_CD,
                                                                100,
                                                                REC2.CLASS,
                                                                REC0.LOGIC,
                                                                REC2.CD_SPLY_FACT);
                                                    COMMIT;
                                                    EXCEPTION
                                                    WHEN OTHERS THEN
                                                       NULL ;
                                                END;
                                                --Set Value
                                                V_QT_BAL_PO := NULL;
                                                V_QT_BAL_PLAN := 0;
                                            END;
                                        END IF;
                                     END LOOP;
                                    
                                END;
                                END LOOP; -- END LOOP CUR 3
                                CLOSE C3;    
                                
                        END IF;
                                
            END;
            END LOOP; -- END LOOP CUR 2
            CLOSE C2;
END;
END LOOP; -- END LOOP CUR 0
CLOSE C0;

COMMIT ;

END P_PRD_DO_ISSUE_DO_RATE100;
14.
PROCEDURE P_PRD_DO_ISSUE_DO_CLEAR_DATA AS

vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT_DEL               VARCHAR2(8 BYTE);

--1.get Logic
    Cursor Cur0 IS   Select Distinct LOGIC 
                    FROM T_DO_PLAN_BALANCE_QTY
                     WHERE RATIO NOT IN ('100','0');
    REC0       Cur0%rowtype;   
   
    Cursor Cur1 IS   SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,LOGIC   
                     FROM T_DO_PLAN_BALANCE_QTY
                     WHERE RATIO NOT IN ('100','0')
                     AND LOGIC = REC0.LOGIC;
    REC_CUR1   Cur1%rowtype;  
    
    

BEGIN

--
DELETE FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY  ;

-- Clear data DELIVERY LOT   

DELETE FROM T_DO_PLAN_REF_DELIVERY_LOT		
WHERE RATIO <> 100;

-- Clear data DELIVERY DATE
DELETE FROM T_DO_PLAN_REF_DELIVERY_DATE		
WHERE RATIO <> 100; 
    

--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@from_euc_npis
WHERE DT_WORK > TO_CHAR(sysdate,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@from_euc_npis
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@from_euc_npis
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

OPEN Cur0;
     LOOP
            FETCH Cur0 INTO REC0;
            EXIT WHEN Cur0%NOTFOUND OR Cur0%NOTFOUND IS NULL;
            IF REC0.LOGIC = '1' THEN
                BEGIN
                    vNEXT_DEL := vNEXT_WORKING_DATE;
                END;
                
            ELSIF REC0.LOGIC = '2' THEN
                BEGIN
                    vNEXT_DEL := vNEXT2_WORKING_DATE;
                END;
                
            ELSIF REC0.LOGIC = '3' THEN
                BEGIN
                    vNEXT_DEL := vNEXT3_WORKING_DATE;
                END;
            END IF; 

    OPEN Cur1;
     LOOP 
         FETCH Cur1 INTO REC_CUR1;
            EXIT WHEN Cur1%NOTFOUND OR Cur1%NOTFOUND IS NULL;   
            
            BEGIN
                DELETE FROM T_PRD_DO_RESULT
                WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'	
                AND RATIO NOT IN ('100','0')
                AND FACTORY_CD = REC_CUR1.FACTORY_CD
                AND PART_NO = REC_CUR1.PART_NO
                AND DIM = REC_CUR1.DIM ;
               --   AND BLOCK_CD = REC_CUR1.USE_BLOCK_CD
               -- AND LOGIC  = REC_CUR1.LOGIC;
            END;
     END LOOP; 
     CLOSE Cur1;
 End LOOP;
CLOSE Cur0;
    

COMMIT;
END P_PRD_DO_ISSUE_DO_CLEAR_DATA;
15.
PROCEDURE P_PRD_DO_PLAN_REF_DEL_LOT_MULTI_RATE AS

vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
V_NEXT_WORKING_DAY      VARCHAR2(8 BYTE);
V_NEXT_DELV             VARCHAR2(8);
vNEXT_DEL               VARCHAR2(8);
V_TOTAL_PLAN            NUMBER := 0;
V_PLAN_BY_RATE          NUMBER := 0;
V_REMAIN_PLAN_BY_RATE   NUMBER := 0;
V_SUM_QTY_DO            NUMBER := 0;
V_PLAN_REMAIN_BY_LOT    NUMBER := 0;
V_PLAN_RF_LT_AND_BALANCE NUMBER := 0;
V_PLAN_RF_LT            NUMBER := 0;
V_PLAN_REMAIN           NUMBER := 0;
pFLAG                   NUMBER := 0;
V_NEXT_DELV_TIME        VARCHAR2(8);
CHK_SUM_QTY_DO          NUMBER := 0;
    
--1.get Logic
    Cursor C0 IS   Select Distinct LOGIC 
                     FROM T_DO_PLAN_BALANCE_QTY
                     WHERE RATIO NOT IN ('100','0')
                     AND PLAN_QTY_BALANCE > 0;
    REC0       C0%rowtype;   
    
             
CURSOR C1 IS SELECT DISTINCT A.FACTORY_CD ,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.CLASS
                FROM T_DO_PLAN_BALANCE_QTY A
                WHERE A.RATIO NOT IN (100,0)
                    AND A.PLAN_DATE||A.PLAN_TIME >= vNEXT_DEL||'0800'
                    AND A.PLAN_QTY_BALANCE > 0
                    AND A.LOGIC = REC0.LOGIC
                ORDER BY A.FACTORY_CD,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.CLASS;
               
    REC1		C1%rowtype;

                    
    CURSOR C2 IS    SELECT DISTINCT A.FACTORY_CD, A.PART_NO, A.DIM, A.BLOCK_CD,
                                    A.SUPPLIER_CD, A.RK_PRIO_DIVI, A.PT_RATIO ,B.CD_SPLY_FACT
                    FROM T_PRD_DO_PART_AND_STRUCTURE A
                    LEFT JOIN WBGJT002@FROM_EUC_NPIS B
                    ON A.PART_NO = B.NO_PARTS
                    AND A.DIM = B.NO_ADJ_DIM
                    AND A.SUPPLIER_CD = B.CD_SPLY
                    WHERE A.FACTORY_CD =REC1.FACTORY_CD
                        AND A.CLASS = REC1.CLASS
                        AND A.PART_NO = REC1.PART_NO 
                        AND A.DIM = REC1.DIM
                        AND A.BLOCK_CD IN DECODE(REC1.CLASS ,'M/C',REC1.USE_BLOCK_CD , ( -- #Modify 14-Mar-2022 by Alisa
                                SELECT DISTINCT BLOCK_CD
                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                WHERE FACTORY_CD =REC1.FACTORY_CD
                                    AND CLASS = 'M/T'
                                    AND PART_NO = REC1.PART_NO AND DIM = REC1.DIM )
                        )
                    ORDER BY A.RK_PRIO_DIVI;
                    
    REC2		C2%rowtype;
    
    -- List [Plan Date / Plan Time]                  
    CURSOR C3 IS    SELECT DISTINCT FACTORY_CD, PART_NO, DIM,CLASS, PLAN_DATE,PLAN_TIME, USE_BLOCK_CD, PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT,CREATE_DATE
                    FROM T_DO_PLAN_BALANCE_QTY
                    WHERE PART_NO = REC1.PART_NO
                        AND FACTORY_CD = REC1.FACTORY_CD
                        AND  DIM = REC1.DIM  
                        AND CLASS = REC1.CLASS
                        AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                        AND PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                       AND PLAN_DATE||PLAN_TIME <= V_NEXT_DELV||V_NEXT_DELV_TIME
                       AND PLAN_QTY_BALANCE > 0
                        AND PLAN_DATE||PLAN_TIME >= (SELECT NVL(MAX(PLAN_DATE||PLAN_TIME),'0') FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    WHERE FACTORY_CD = REC1.FACTORY_CD
                                                        AND PART_NO =  REC1.PART_NO 
                                                        AND  DIM = REC1.DIM  
                                                        AND CLASS = REC1.CLASS
                                                        AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                                                    )
                    ORDER BY PLAN_DATE,PLAN_TIME; 
    REC3		C3%rowtype;
    
    REC4        C3%rowtype;



BEGIN


-- 1.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(SYSDATE, 'YYYYMMDD')
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';


    ---1. Cal Next del all target
    PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_FOR_MULTI_RATE; 

OPEN C0;
LOOP
FETCH C0 INTO REC0;
EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;


    --Set value  vNEXT_DEL  
    IF REC0.LOGIC = '1' THEN
        BEGIN
            vNEXT_DEL := vNEXT_WORKING_DATE;
            V_NEXT_WORKING_DAY := vNEXT_WORKING_DATE;
        END;
        
    ELSIF REC0.LOGIC = '2' THEN
        BEGIN
            vNEXT_DEL := vNEXT2_WORKING_DATE;
             V_NEXT_WORKING_DAY := vNEXT2_WORKING_DATE;
        END;
        
    ELSIF REC0.LOGIC = '3' THEN
        BEGIN
            vNEXT_DEL := vNEXT3_WORKING_DATE;
             V_NEXT_WORKING_DAY := vNEXT3_WORKING_DATE;
        END;
    END IF;

 

    
    -- START CUR1 Target Part 
    OPEN C1;
    LOOP
    FETCH C1 INTO REC1;
    EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
    BEGIN

    
        
        BEGIN
            -- 2.3) หา DT_DELV ถัดไปที่เร็วที่สุดที่ของจะมาถึง


         SELECT PLAN_DATE,MIN(PLAN_TIME)
         INTO V_NEXT_DELV ,  V_NEXT_DELV_TIME
            FROM T_DO_FIND_DEL_FOR_MULTI_RATE
            WHERE FACTORY_CD = REC1.FACTORY_CD
                AND PART_NO =  REC1.PART_NO
                AND DIM = REC1.DIM 
              --  AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                AND USE_BLOCK_CD IN DECODE(REC1.CLASS ,'M/C',REC1.USE_BLOCK_CD , ( -- #Modify 14-Mar-2022 by Alisa
                                SELECT DISTINCT BLOCK_CD
                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                WHERE FACTORY_CD =REC1.FACTORY_CD
                                    AND CLASS = 'M/T'
                                    AND PART_NO = REC1.PART_NO AND DIM = REC1.DIM )
                        )
                 AND PLAN_DATE	IS NOT NULL
                 AND PLAN_TIME	IS NOT NULL
                AND CLASS = REC1.CLASS  
                GROUP BY PLAN_DATE;

            
            EXCEPTION WHEN NO_DATA_FOUND THEN
                V_NEXT_DELV := NULL;
                V_NEXT_DELV_TIME  := NULL;
        END;
        -- #If not found NEXT_DELV
        IF V_NEXT_DELV IS NULL OR V_NEXT_DELV_TIME IS NULL  THEN
            BEGIN
                SELECT DISTINCT FACTORY_CD, PART_NO, DIM,CLASS, PLAN_DATE,PLAN_TIME, USE_BLOCK_CD, PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT,SYSDATE AS CREATE_DATE 
                INTO REC4
                FROM T_DO_PLAN_BALANCE_QTY
                WHERE PART_NO = REC1.PART_NO
                        AND FACTORY_CD = REC1.FACTORY_CD
                        AND  DIM = REC1.DIM  
                        AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                        AND CLASS = REC1.CLASS
                        AND PLAN_DATE||PLAN_TIME IN (SELECT MIN(PLAN_DATE||PLAN_TIME)
                                            FROM T_DO_PLAN_BALANCE_QTY
                                            WHERE PART_NO = REC1.PART_NO
                                            AND FACTORY_CD = REC1.FACTORY_CD
                                            AND  DIM = REC1.DIM  
                                            AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                                            AND CLASS = REC1.CLASS
                                            AND PLAN_DATE||PLAN_TIME >= V_NEXT_WORKING_DAY||'0800' );
                
                INSERT INTO T_PRD_DO_RESULT
                                    (FACTORY_CD,
                                    DELIVERY_DATE,
                                    DELIVERY_TIME,
                                    BLOCK_CD,
                                    RESULT,
                                    UPDATE_DATE,
                                    PART_NO,
                                    DIM,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    PLAN_DATE,
                                    PLAN_TIME,
                                    DELIVERY_ORDER,
                                    CD_SPLY_FACT
                                    )
                            VALUES  (REC4.FACTORY_CD,
                                    REC4.PLAN_DATE,
                                    REC4.PLAN_TIME,
                                    REC4.USE_BLOCK_CD,
                                    'WF0017',
                                    SYSDATE,
                                    REC4.PART_NO,
                                    REC4.DIM,
                                    REC2.SUPPLIER_CD,
                                    REC2.PT_RATIO,
                                    REC1.CLASS,
                                     REC4.PLAN_DATE,
                                    REC4.PLAN_TIME,
                                    REC4.PLAN_QTY_RF_LT,
                                    REC2.CD_SPLY_FACT
                                    );
                                    
                                    
                             
                            COMMIT;
            END;
            
        -- #If  found NEXT_DELV    
        ELSIF V_NEXT_DELV IS NOT NULL AND V_NEXT_DELV_TIME IS NOT NULL THEN
            BEGIN
                BEGIN
                    -- 2.4) หา Total Plan ของ PART_NO
                    SELECT SUM(PLAN_QTY_RF_LT) INTO V_TOTAL_PLAN
                    FROM (
                            SELECT DISTINCT FACTORY_CD,PART_NO,DIM,PLAN_DATE,PLAN_TIME,USE_BLOCK_CD,PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT
                            FROM T_DO_PLAN_BALANCE_QTY
                             WHERE PART_NO = REC1.PART_NO
                                            AND FACTORY_CD = REC1.FACTORY_CD
                                            AND  DIM = REC1.DIM  
                                            AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                                            AND CLASS = REC1.CLASS
                                AND PLAN_DATE||PLAN_TIME BETWEEN V_NEXT_WORKING_DAY||'0800' AND V_NEXT_DELV||V_NEXT_DELV_TIME  -- BY Alisa  --AND V_NEXT_DELV||'0000'
                        );
                    
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    V_TOTAL_PLAN := NULL;
                END;
                

                
                V_PLAN_REMAIN := V_TOTAL_PLAN;
                
                -- CUR Piority
                OPEN C2;        
                LOOP
                FETCH C2 INTO REC2;
                EXIT WHEN C2%NOTFOUND OR C2%NOTFOUND IS NULL;
                BEGIN
                
                                BEGIN
                                 SELECT SUM(NVL(DELIVERY_ORDER,0))  INTO CHK_SUM_QTY_DO
                                    FROM T_PRD_DO_RESULT
                                    WHERE FACTORY_CD = REC1.FACTORY_CD
                                    AND RESULT = 'WF0000'
                                    AND BLOCK_CD = REC1.USE_BLOCK_CD
                                    AND PART_NO = REC1.PART_NO
                                    AND DIM = REC1.DIM
                                    AND RATIO NOT IN ( 0,100)
                                    AND CLASS = REC1.CLASS
                                    AND PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800';
                                                                        
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                    CHK_SUM_QTY_DO := 0;
                                END;
                                
                                
                                IF ( CHK_SUM_QTY_DO IS NULL ) THEN
                                
                                    CHK_SUM_QTY_DO := 0 ;
                                
                                END IF ;
                                
                                
                 
                    
                    V_PLAN_BY_RATE := CEIL(NVL(V_TOTAL_PLAN,0) * (NVL(REC2.PT_RATIO,0) /100)); -- PLAN BY RATE
                    
                    IF ( NVL(V_PLAN_BY_RATE,0) <= ( NVL(V_TOTAL_PLAN,0) - NVL(CHK_SUM_QTY_DO,0) )) THEN 
                    
                                 V_REMAIN_PLAN_BY_RATE := NVL(V_PLAN_BY_RATE,0);
                    
                    ELSE
                                IF NVL(V_TOTAL_PLAN,0) - NVL(CHK_SUM_QTY_DO,0) > 0 THEN
                                
                                         V_REMAIN_PLAN_BY_RATE := NVL(V_PLAN_BY_RATE,0);
                                         
                                ELSE
                                
                                        V_REMAIN_PLAN_BY_RATE := 0;
                                
                                END IF;
                                
                    
                    END IF;
                    
                 --CUR Plan Date/Time
                    OPEN C3;    
                    LOOP
                    FETCH C3 INTO REC3;
                    EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
                    BEGIN
                
                    -- #Case1: For Each Priority
                    IF REC2.RK_PRIO_DIVI IS NOT NULL THEN
                    BEGIN
                    
                        IF REC2.RK_PRIO_DIVI <> '1' AND pFLAG = 0 THEN
                        BEGIN
                        -- 3.2) Get PLAN_QTY_RF_LT + PLAN_QTY_BALANCE  
                            SELECT SUM(PLAN_QTY_RF_LT + PLAN_QTY_BALANCE) INTO  V_PLAN_RF_LT_AND_BALANCE  
                            FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                            WHERE FACTORY_CD = REC1.FACTORY_CD
                                 AND   PART_NO  = REC1.PART_NO
                                 AND   DIM = REC1.DIM
                                 AND   USE_BLOCK_CD =  REC1.USE_BLOCK_CD
                                 AND   CLASS = REC1.CLASS
                                 AND   PLAN_DATE||PLAN_TIME = (SELECT MAX(PLAN_DATE||PLAN_TIME)
                                                                  FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                                  WHERE FACTORY_CD =  REC1.FACTORY_CD
                                                                  AND PART_NO = REC1.PART_NO
                                                                  AND DIM =   REC1.DIM
                                                                  AND USE_BLOCK_CD =  REC1.USE_BLOCK_CD
                                                                  AND CLASS = REC1.CLASS);
                                                                  
                            --3.3) Get PLAN_QTY_RF_LT       
                            BEGIN
                            
                            SELECT DISTINCT PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT INTO V_PLAN_RF_LT  
                            FROM T_DO_PLAN_BALANCE_QTY
                            WHERE FACTORY_CD = REC1.FACTORY_CD
                             AND   PART_NO  = REC1.PART_NO
                             AND   DIM = REC1.DIM
                             AND   USE_BLOCK_CD =  REC1.USE_BLOCK_CD
                             AND  CLASS = REC1.CLASS
                             AND   PLAN_DATE||PLAN_TIME = (SELECT MAX(PLAN_DATE||PLAN_TIME)
                                                          FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                          WHERE FACTORY_CD =  REC1.FACTORY_CD
                                                          AND PART_NO = REC1.PART_NO
                                                          AND DIM =   REC1.DIM
                                                          AND CLASS = REC1.CLASS
                                                          AND USE_BLOCK_CD =  REC1.USE_BLOCK_CD);
                                                          
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_PLAN_RF_LT := 0;
                                END;
                                                          
                                                          
                                                          
                            -- 3.4) Compare PLAN between T_DO_PLAN_BALANCE_QTY_BY_SPLY (3.2) and T_DO_PLAN_BALANCE_QTY (3.3)                              
                            IF V_PLAN_RF_LT > V_PLAN_RF_LT_AND_BALANCE THEN
                                INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    (FACTORY_CD,
                                                    PART_NO,
                                                    DIM,
                                                    SUPPLIER_CD,
                                                    RATIO,
                                                    CLASS,
                                                    PLAN_DATE,
                                                    PLAN_TIME,
                                                    PLAN_QTY_RF_LT,
                                                    PLAN_QTY_BALANCE,
                                                    USE_BLOCK_CD,
                                                    CREATE_DATE)
                                            VALUES  (REC3.FACTORY_CD,
                                                    REC3.PART_NO,
                                                    REC3.DIM,
                                                    REC2.SUPPLIER_CD,
                                                    REC2.PT_RATIO,
                                                    REC3.CLASS,
                                                    REC3.PLAN_DATE,
                                                    REC3.PLAN_TIME,
                                                    V_PLAN_RF_LT-V_PLAN_RF_LT_AND_BALANCE,
                                                    0,
                                                    REC3.USE_BLOCK_CD,
                                                    REC3.CREATE_DATE);
                                            
                                            V_REMAIN_PLAN_BY_RATE :=  V_REMAIN_PLAN_BY_RATE - (V_PLAN_RF_LT-V_PLAN_RF_LT_AND_BALANCE);                                                  
                                            COMMIT;
                                            pFLAG := 1;
                                            GOTO NEXT_PLAN_DATETIME_C3; 
                                            
                            ELSIF V_PLAN_RF_LT = V_PLAN_RF_LT_AND_BALANCE THEN
                                pFLAG := 1;
                                GOTO NEXT_PLAN_DATETIME_C3;
                                                        
                            END IF;
                        END;
                        END IF;
                        
                        IF V_PLAN_REMAIN_BY_LOT > 0  THEN 
                        BEGIN
                            IF V_PLAN_REMAIN_BY_LOT > REC3.PLAN_QTY_RF_LT THEN
                            BEGIN
                                INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                        (FACTORY_CD,
                                                        PART_NO,
                                                        DIM,
                                                        SUPPLIER_CD,
                                                        RATIO,
                                                        CLASS,
                                                        PLAN_DATE,
                                                        PLAN_TIME,
                                                        PLAN_QTY_RF_LT,
                                                        PLAN_QTY_BALANCE,
                                                        USE_BLOCK_CD,
                                                        CREATE_DATE)
                                                VALUES  (REC3.FACTORY_CD,
                                                        REC3.PART_NO,
                                                        REC3.DIM,
                                                        REC2.SUPPLIER_CD,
                                                        REC2.PT_RATIO,
                                                        REC3.CLASS,
                                                        REC3.PLAN_DATE,
                                                        REC3.PLAN_TIME,
                                                        0,
                                                        REC3.PLAN_QTY_RF_LT,
                                                        REC3.USE_BLOCK_CD,
                                                        REC3.CREATE_DATE);
                                                        
                                V_PLAN_REMAIN_BY_LOT := V_PLAN_REMAIN_BY_LOT - REC3.PLAN_QTY_RF_LT;
                                COMMIT;
                                GOTO NEXT_PLAN_DATETIME_C3;
                            END;  
                            
                            ELSIF V_PLAN_REMAIN_BY_LOT <= REC3.PLAN_QTY_RF_LT  THEN
                            BEGIN
                            
                                INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                        (FACTORY_CD,
                                                        PART_NO,
                                                        DIM,
                                                        SUPPLIER_CD,
                                                        RATIO,
                                                        CLASS,
                                                        PLAN_DATE,
                                                        PLAN_TIME,
                                                        PLAN_QTY_RF_LT,
                                                        PLAN_QTY_BALANCE,
                                                        USE_BLOCK_CD,
                                                        CREATE_DATE)
                                                VALUES  (REC3.FACTORY_CD,
                                                        REC3.PART_NO,
                                                        REC3.DIM,
                                                        REC2.SUPPLIER_CD,
                                                        REC2.PT_RATIO,
                                                        REC3.CLASS,
                                                        REC3.PLAN_DATE,
                                                        REC3.PLAN_TIME,
                                                        0,
                                                        V_PLAN_REMAIN_BY_LOT,
                                                        REC3.USE_BLOCK_CD,
                                                        REC3.CREATE_DATE);
                                                        
                                V_PLAN_REMAIN_BY_LOT := 0; 
                                COMMIT;
                                GOTO CALCULATE_PLAN_REMAIN;
                            
                            END;
                            END IF;
                        
                        END;
                        END IF;
                    
                        -- Total Plan ของ PART นั้น * RATIO ของ Supplier
                        --V_PLAN_BY_RATE := CEIL(V_TOTAL_PLAN * (REC2.PT_RATIO /100));
                        --V_REMAIN_PLAN_BY_RATE := V_PLAN_BY_RATE;
                        
                        --OPEN C3;    
                        --LOOP
                        --FETCH C3 INTO REC3;
                        --EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
                        --BEGIN
                            
                            IF V_REMAIN_PLAN_BY_RATE > REC3.PLAN_QTY_RF_LT  THEN
                            BEGIN
                                    INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    (FACTORY_CD,
                                                    PART_NO,
                                                    DIM,
                                                    SUPPLIER_CD,
                                                    RATIO,
                                                    CLASS,
                                                    PLAN_DATE,
                                                    PLAN_TIME,
                                                    PLAN_QTY_RF_LT,
                                                    PLAN_QTY_BALANCE,
                                                    USE_BLOCK_CD,
                                                    CREATE_DATE)
                                            VALUES  (REC3.FACTORY_CD,
                                                    REC3.PART_NO,
                                                    REC3.DIM,
                                                    REC2.SUPPLIER_CD,
                                                    REC2.PT_RATIO,
                                                    REC3.CLASS,
                                                    REC3.PLAN_DATE,
                                                    REC3.PLAN_TIME,
                                                    REC3.PLAN_QTY_RF_LT,
                                                    0,
                                                    REC3.USE_BLOCK_CD,
                                                    REC3.CREATE_DATE);
                                COMMIT;
                               IF ( V_NEXT_DELV||V_NEXT_DELV_TIME =  REC3.PLAN_DATE||REC3.PLAN_TIME )THEN
                               
                                        GOTO CALLING_NEXT_PG;
                               
                               ELSE
                               
                                       V_REMAIN_PLAN_BY_RATE :=   V_REMAIN_PLAN_BY_RATE - REC3.PLAN_QTY_RF_LT;
                                        GOTO NEXT_PLAN_DATETIME_C3;
                               
                               END IF;
                                
                              
                            END;
                            
                            ELSIF V_REMAIN_PLAN_BY_RATE <= REC3.PLAN_QTY_RF_LT  THEN
                            BEGIN
                                    INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    (FACTORY_CD,
                                                    PART_NO,
                                                    DIM,
                                                    SUPPLIER_CD,
                                                    RATIO,
                                                    CLASS,
                                                    PLAN_DATE,
                                                    PLAN_TIME,
                                                    PLAN_QTY_RF_LT,
                                                    PLAN_QTY_BALANCE,
                                                    USE_BLOCK_CD,
                                                    CREATE_DATE)
                                            VALUES  (REC3.FACTORY_CD,
                                                    REC3.PART_NO,
                                                    REC3.DIM,
                                                    REC2.SUPPLIER_CD,
                                                    REC2.PT_RATIO,
                                                    REC3.CLASS,
                                                    REC3.PLAN_DATE,
                                                    REC3.PLAN_TIME,
                                                    V_REMAIN_PLAN_BY_RATE,
                                                    0,
                                                    REC3.USE_BLOCK_CD,
                                                    REC3.CREATE_DATE);
                                                    
                                            --V_PLAN_BY_RATE := 0;
                                            COMMIT;
                                            GOTO CALLING_NEXT_PG;
                            END;                                                    
                            
                            ELSIF V_REMAIN_PLAN_BY_RATE = 0  THEN
                            BEGIN
                                    INSERT INTO T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                    (FACTORY_CD,
                                                    PART_NO,
                                                    DIM,
                                                    SUPPLIER_CD,
                                                    RATIO,
                                                    CLASS,
                                                    PLAN_DATE,
                                                    PLAN_TIME,
                                                    PLAN_QTY_RF_LT,
                                                    PLAN_QTY_BALANCE,
                                                    USE_BLOCK_CD,
                                                    CREATE_DATE)
                                            VALUES  (REC3.FACTORY_CD,
                                                    REC3.PART_NO,
                                                    REC3.DIM,
                                                    REC2.SUPPLIER_CD,
                                                    REC2.PT_RATIO,
                                                    REC3.CLASS,
                                                    REC3.PLAN_DATE,
                                                    REC3.PLAN_TIME,
                                                    REC3.PLAN_QTY_RF_LT,-- = 0
                                                    0,
                                                    REC3.USE_BLOCK_CD,
                                                    REC3.CREATE_DATE);  
                                            
                                            COMMIT;        
                                            GOTO CALLING_NEXT_PG;
                            END;                                     
                            END IF;
    
                        --END;
                        --END LOOP; -- END LOOP CUR 3
                        --CLOSE C3;   
                        
                        << CALLING_NEXT_PG >>
                            PG_PRD_DO_CALCULATION_MULTI_RATE.P_PRD_DO_PLAN_REF_DEL_LOT
                                                                                    (REC1.FACTORY_CD,
                                                                                     REC1.PART_NO,
                                                                                     REC1.DIM,
                                                                                     REC1.USE_BLOCK_CD,
                                                                                     REC2.SUPPLIER_CD,
                                                                                     REC1.CLASS,
                                                                                     REC2.PT_RATIO,
                                                                                     REC0.LOGIC,
                                                                                     V_NEXT_WORKING_DAY,
                                                                                     REC2.CD_SPLY_FACT,
                                                                                     V_SUM_QTY_DO
                                                                                    
                                                                                    );  
                        
                        -- 3.1) Calculate PLAN REMAIN BY LOT

                        V_PLAN_REMAIN_BY_LOT  := V_SUM_QTY_DO - V_PLAN_BY_RATE;
                        
                        IF V_PLAN_REMAIN_BY_LOT = 0 THEN
                        BEGIN
                            -- Next step Goto 4.) Calculate Plan Remain
                            GOTO CALCULATE_PLAN_REMAIN;                    
                        END;
                        
                        ELSIF V_PLAN_REMAIN_BY_LOT > 0 THEN
                        BEGIN
                        
                            -- 3.2) Get PLAN_QTY_RF_LT + PLAN_QTY_BALANCE  
                            SELECT SUM(DISTINCT PLAN_QTY_RF_LT + PLAN_QTY_BALANCE) INTO  V_PLAN_RF_LT_AND_BALANCE  
                            FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                            WHERE FACTORY_CD = REC1.FACTORY_CD
                                 AND   PART_NO  = REC1.PART_NO
                                 AND   DIM = REC1.DIM
                                 AND   USE_BLOCK_CD =  REC1.USE_BLOCK_CD
                                 AND   CLASS= REC1.CLASS
                                 AND   PLAN_DATE||PLAN_TIME = (SELECT MAX(PLAN_DATE||PLAN_TIME)
                                                                  FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                                  WHERE FACTORY_CD =  REC1.FACTORY_CD
                                                                  AND PART_NO = REC1.PART_NO
                                                                  AND DIM =   REC1.DIM
                                                                  AND CLASS = REC1.CLASS
                                                                  AND USE_BLOCK_CD =  REC1.USE_BLOCK_CD);
                                                                  
                            --3.3) Get PLAN_QTY_RF_LT                              
                            SELECT DISTINCT PLAN_QTY_BALANCE AS PLAN_QTY_RF_LT INTO V_PLAN_RF_LT  
                            FROM T_DO_PLAN_BALANCE_QTY
                            WHERE FACTORY_CD = REC1.FACTORY_CD
                             AND   PART_NO  = REC1.PART_NO
                             AND   DIM = REC1.DIM
                             AND   USE_BLOCK_CD =  REC1.USE_BLOCK_CD
                             AND   CLASS = REC1.CLASS
                             AND   PLAN_DATE||PLAN_TIME = (SELECT MAX(PLAN_DATE||PLAN_TIME)
                                                          FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                                          WHERE FACTORY_CD =  REC1.FACTORY_CD
                                                          AND PART_NO = REC1.PART_NO
                                                          AND DIM =   REC1.DIM
                                                          AND CLASS = REC1.CLASS
                                                          AND USE_BLOCK_CD =  REC1.USE_BLOCK_CD);
                            -- 3.4) Compare PLAN between T_DO_PLAN_BALANCE_QTY_BY_SPLY (3.2) and T_DO_PLAN_BALANCE_QTY (3.3)                              
                            IF V_PLAN_RF_LT > V_PLAN_RF_LT_AND_BALANCE THEN
                                        UPDATE T_DO_PLAN_BALANCE_QTY_BY_SPLY
                                        SET   PLAN_QTY_BALANCE = V_PLAN_RF_LT-V_PLAN_RF_LT_AND_BALANCE
                                        WHERE  FACTORY_CD =  REC1.FACTORY_CD
                                        AND    PART_NO = REC1.PART_NO
                                        AND    DIM =   REC1.DIM
                                        AND    SUPPLIER_CD = REC2.SUPPLIER_CD
                                        AND    PLAN_DATE = REC3.PLAN_DATE 
                                        AND    PLAN_TIME = REC3.PLAN_TIME
                                        AND    CLASS = REC1.CLASS;
                                        
                                        COMMIT;
                                        
                                        -- PLAN REMAIN BY LOT = PLAN REMAIN BY LOT - PLAN_QTY_BALANCE
                                        V_PLAN_REMAIN_BY_LOT := V_PLAN_REMAIN_BY_LOT-(V_PLAN_RF_LT - V_PLAN_RF_LT_AND_BALANCE) ;   
                                        
                                        IF V_PLAN_REMAIN_BY_LOT > 0 THEN                                            
                                            GOTO NEXT_PLAN_DATETIME_C3;
                                        ELSIF V_PLAN_REMAIN_BY_LOT = 0 THEN
                                            GOTO CALCULATE_PLAN_REMAIN;
                                        END IF;
                            
                            END IF;
                        
                        END;                    
                        END IF;
                        
                        -- 4.) Calculate Plan Remain
                        << CALCULATE_PLAN_REMAIN >>
                        
                            --V_PLAN_REMAIN := V_TOTAL_PLAN - V_SUM_QTY_DO;                            
                            V_PLAN_REMAIN := V_PLAN_REMAIN - V_SUM_QTY_DO;
                            
                            IF V_PLAN_REMAIN <= 0  THEN
                                GOTO NEXT_TARGET_PART_C1;
                            ELSIF V_PLAN_REMAIN > 0 THEN
                                GOTO NEXT_PIORITY_C2;
                            END IF;
                        
                        
                        << NEXT_PLAN_DATETIME_C3 >>
                            NULL;
                    END;
                    END IF;-- #Case1: For First Priority
                    
                    IF REC2.RK_PRIO_DIVI IS NULL THEN
                        INSERT INTO T_PRD_DO_RESULT
                                    (FACTORY_CD,
                                    BLOCK_CD,
                                    RESULT,
                                    UPDATE_DATE,
                                    PART_NO,
                                    DIM,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    CD_SPLY_FACT
                                    )
                            VALUES  (REC1.FACTORY_CD,
                                    REC1.USE_BLOCK_CD,
                                    'Not found NEXT PRIORITY',
                                    SYSDATE,
                                    REC1.PART_NO,
                                    REC1.DIM,
                                    REC2.SUPPLIER_CD,
                                    REC2.PT_RATIO,
                                    REC1.CLASS,
                                    REC2.CD_SPLY_FACT
                                    );
                            COMMIT;
                    END IF;
                    
                    END;
                    END LOOP; -- CUR 3 Plan DateTime Part
                    
                    << NEXT_PIORITY_C2 >> 
                    pFLAG := 0;
                    NULL;
                    
                    
                    CLOSE C3;
                    
                
                END;
                END LOOP; -- CUR 2 Piority Part
                CLOSE C2;   
                
            END;
        END IF;
        
<< NEXT_TARGET_PART_C1 >>
    NULL;
    
    --CLOSE C3;
    --CLOSE C2;  
END;
END LOOP; -- CUR 1 Target Part 
CLOSE C1;
-- STOP CUR1 Target Part 
 
END LOOP; -- END LOOP CUR 0
CLOSE C0; 
COMMIT ;


END P_PRD_DO_PLAN_REF_DEL_LOT_MULTI_RATE;
15.1PROCEDURE P_PRD_DO_FIND_DEL_FOR_MULTI_RATE AS

V_delivery_date             VARCHAR2(20 BYTE);
V_delivery_time             VARCHAR2(20 BYTE);
V_NM_KEY_TABLE              VARCHAR2(100 BYTE);
V_CombiDay                  VARCHAR2(1 BYTE);
V_PLAN_DATETIME             VARCHAR2(12 BYTE);
vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT_DEL               VARCHAR2(8);
--1.get Logic
    Cursor C0 IS   Select Distinct LOGIC 
                     FROM T_DO_PLAN_BALANCE_QTY
                     WHERE RATIO NOT IN ('100','0')
                     AND PLAN_QTY_BALANCE > 0;
    REC0       C0%rowtype;   
    
    
  CURSOR C1 IS    SELECT DISTINCT A.FACTORY_CD, A.PART_NO, A.DIM,A.USE_BLOCK_CD,A.CLASS,B.CD_SPLY_FACT
                    FROM T_DO_PLAN_BALANCE_QTY A
                    LEFT JOIN WBGJT002@FROM_EUC_NPIS B
                        ON A.PART_NO = B.NO_PARTS
                        AND A.DIM = B.NO_ADJ_DIM
                        AND A.SUPPLIER_CD = B.CD_SPLY
                    WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                     AND  RATIO NOT IN ('0','100' )
                     AND LOGIC = REC0.LOGIC 
                     AND PLAN_QTY_BALANCE > 0
                    ORDER BY FACTORY_CD, PART_NO , DIM, USE_BLOCK_CD;
    REC1		C1%rowtype;

    -- 2.1) Get Target Part Multi Suppulier 
  



BEGIN
DELETE  T_DO_FIND_DEL_FOR_MULTI_RATE ;



-- 1.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(SYSDATE, 'YYYYMMDD')
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

OPEN C0;
LOOP
FETCH C0 INTO REC0;
EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;


    --Set value  vNEXT_DEL  
    IF REC0.LOGIC = '1' THEN
        BEGIN
            vNEXT_DEL := vNEXT_WORKING_DATE;

        END;
        
    ELSIF REC0.LOGIC = '2' THEN
        BEGIN
            vNEXT_DEL := vNEXT2_WORKING_DATE;

        END;
        
    ELSIF REC0.LOGIC = '3' THEN
        BEGIN
            vNEXT_DEL := vNEXT3_WORKING_DATE;

        END;
    END IF;

    
        OPEN C1;
        LOOP
        FETCH C1 INTO REC1;
        EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
        BEGIN
        NULL;
        PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_FOR_MULTI_RATE(REC1.FACTORY_CD,REC1.PART_NO,REC1.DIM,REC1.CLASS,REC1.USE_BLOCK_CD,vNEXT_DEL,REC1.CD_SPLY_FACT,V_delivery_date,V_delivery_time,V_NM_KEY_TABLE,V_CombiDay,V_PLAN_DATETIME); 


                    INSERT INTO T_DO_FIND_DEL_FOR_MULTI_RATE
                                    ( FACTORY_CD,
                                        PART_NO,
                                        DIM,
                                        CLASS,
                                        USE_BLOCK_CD,
                                        PLAN_DATE,
                                        PLAN_TIME,
                                        DEL_DATE,
                                        DAY_OF_WEEK,
                                        COMBIDAY,
                                        UPDATE_DATE,
                                        CD_SPLY_FACT
                                    )
                            VALUES  (   REC1.FACTORY_CD,
                                        REC1.PART_NO,
                                        REC1.DIM,
                                        REC1.CLASS,
                                        REC1.USE_BLOCK_CD,
                                        V_delivery_date,
                                        V_delivery_time,
                                        V_PLAN_DATETIME,
                                        V_NM_KEY_TABLE,
                                        V_CombiDay,
                                        SYSDATE,
                                        REC1.CD_SPLY_FACT
                                    );
COMMIT;

END;
END LOOP; -- CUR 1 Target Part 
CLOSE C1;


END LOOP; -- CUR 0 Target Part 
CLOSE C0;


COMMIT ;                     
    
END P_PRD_DO_FIND_DEL_FOR_MULTI_RATE;    
15.1.2
PROCEDURE P_PRD_DO_FIND_DEL_FOR_MULTI_RATE (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pCLASS VARCHAR2,
                                                    pUSE_BLOCK_CD VARCHAR2,
                                                    pNEXT_DEL VARCHAR2,
                                                    pCD_SPLY_FACT VARCHAR2,
                                                    pPLAN_DATE_SLIDE     OUT VARCHAR2,
                                                    pPLAN_TIME_SLIDE     OUT VARCHAR2,
                                                    pNM_KEY_TABLE  OUT VARCHAR2, 
                                                    pCombiDay  OUT VARCHAR2,
                                                    pPLAN_DATETIME OUT VARCHAR2
                                                    ) AS 

V_Next_Working_Day          VARCHAR2(8 BYTE); 
V_Next_del                  VARCHAR2(8 BYTE); 
V_NM_KEY_TABLE              VARCHAR2(100 BYTE);
V_delivery_date             VARCHAR2(20 BYTE);
V_MIN_DT_DELV               VARCHAR2(8 BYTE);
V_delivery_Time             VARCHAR2(20 BYTE);
V_CombiDay                  VARCHAR2(1 BYTE);
V_Day                       VARCHAR2(3 BYTE);
V_COUNT                     NUMBER(3);
V_Num_Day_Slide             NUMBER(3);
V_Next_PlanDate             VARCHAR2(8 BYTE);
V_PLAN_DATETIME             VARCHAR2(12 BYTE);
VChk_Flg                    VARCHAR2(1 BYTE);
vFLG                        VARCHAR2(1 BYTE);
vTime                       VARCHAR2(4 BYTE);
V_delivery_date_temp        VARCHAR2(20 BYTE);
BEGIN

    V_Next_Working_Day := pNEXT_DEL ;
    
    SELECT MIN(DT_WORK) INTO V_Next_del
    FROM WBGZT051@FROM_EUC_NPIS
    WHERE MK_WORK = 'Y'
    AND DT_WORK > V_Next_Working_Day;

  
            IF (pCLASS = 'M/T')THEN

                    BEGIN    
                    
                        SELECT DISTINCT UPPER(DAY_OF_WEEK) INTO V_NM_KEY_TABLE --UPPER(COMBINE_DAY)  INTO V_NM_KEY_TABLE ,V_CombiDay  
                        FROM V_DO_DELEVERY_DAY_BY_PARTNO 
                        WHERE FACTORY_CD = pFACTORY_CD
                        AND NO_PARTS = pPART_NO
                        AND NO_ADJ_DIM = pDIM 
                        AND CLASS = pCLASS
                        AND DAY_OF_WEEK IS NOT NULL
                        AND CD_SPLY_FACT = pCD_SPLY_FACT;
                        
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    
                                BEGIN    
                                    SELECT DISTINCT UPPER(COMBINE_DAY)  INTO V_CombiDay  
                                    FROM V_DO_DELEVERY_DAY_BY_PARTNO
                                    WHERE FACTORY_CD = pFACTORY_CD
                                    AND NO_PARTS = pPART_NO
                                    AND NO_ADJ_DIM = pDIM 
                                    AND CLASS = pCLASS
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_CombiDay := NULL;
                                    V_NM_KEY_TABLE := NULL ;
                                END;            
                   
                    END;     

            ELSIF (pCLASS = 'M/C')THEN

                    BEGIN  
            
                        SELECT DISTINCT UPPER(DAY_OF_WEEK) INTO V_NM_KEY_TABLE  
                        FROM V_DO_DELEVERY_DAY_BY_PARTNO
                        WHERE FACTORY_CD = pFACTORY_CD
                        AND NO_PARTS = pPART_NO
                        AND NO_ADJ_DIM = pDIM 
                        AND CLASS = pCLASS
                        AND USE_BLOCK_CD = pUSE_BLOCK_CD
                        AND DAY_OF_WEEK IS NOT NULL
                        AND CD_SPLY_FACT = pCD_SPLY_FACT;
                        
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    
                                BEGIN  
                                    SELECT DISTINCT UPPER(COMBINE_DAY)  INTO V_CombiDay   
                                    FROM V_DO_DELEVERY_DAY_BY_PARTNO
                                    WHERE FACTORY_CD = pFACTORY_CD
                                    AND NO_PARTS = pPART_NO
                                    AND NO_ADJ_DIM = pDIM 
                                    AND CLASS = pCLASS
                                    AND USE_BLOCK_CD = pUSE_BLOCK_CD
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;

                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_CombiDay := NULL;
                                    V_NM_KEY_TABLE := NULL ;
                                END;   
                    END;
                    
                    
            ELSE
            
                    V_CombiDay := NULL ;
                    V_NM_KEY_TABLE := NULL ;
            
            END IF;
  
  
    -- A Day of the Week
     IF V_NM_KEY_TABLE IS NOT NULL THEN
                       
                  PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_FIRST_PRIORITY
                  ( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD, pCD_SPLY_FACT,V_Next_Working_Day,V_NM_KEY_TABLE,V_delivery_date,V_delivery_time);
                  
                  pPLAN_DATE_SLIDE := V_delivery_date ;
                  pPLAN_TIME_SLIDE := V_delivery_time;

                    
    -- Combine Day
      ELSE 
          
          -- BEGIN
            --  #CombineDay

             IF V_CombiDay = 'D' THEN
             
             
                        IF  pCLASS = 'M/T' THEN

                                       BEGIN
             
                                            SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                            SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME  
                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                    From V_DO_WORKING_DAY
                                                                    UNION
                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                    From V_DO_WORKING_DAY)
                                                      WHERE MK_WORK = 'Y' 
                                                      ) A
                                            JOIN V_PRD_DO_DELIVERY_MASTER B
                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                            WHERE FACTORY_CD = pFACTORY_CD
                                                AND SUPPLIER_CD IN (    SELECT DISTINCT  SUPPLIER_CD
                                                                        FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                        WHERE FACTORY_CD = pFACTORY_CD
                                                                        AND PT_RATIO NOT IN ( '0' ,'100')
                                                                        AND PART_NO =  pPART_NO
                                                                        AND DIM = pDIM
                                                                        AND CLASS = 'M/T' ) 
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA >= V_Next_del||'0800'
                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                GROUP BY SUPPLIER_CD );
                                                
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_PLAN_DATETIME := NULL;       
                                        END;                         
                        
                        ELSIF pCLASS = 'M/C' THEN

                                       BEGIN
             
                                            SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                            SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME  
                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                    From V_DO_WORKING_DAY
                                                                    UNION
                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                    From V_DO_WORKING_DAY)
                                                      WHERE MK_WORK = 'Y' 
                                                      ) A
                                            JOIN V_PRD_DO_DELIVERY_MASTER B
                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                            WHERE FACTORY_CD = pFACTORY_CD
                                                AND SUPPLIER_CD IN (    SELECT DISTINCT  SUPPLIER_CD
                                                                        FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                        WHERE FACTORY_CD = pFACTORY_CD
                                                                        AND PT_RATIO NOT IN ( '0' ,'100')
                                                                        AND PART_NO =  pPART_NO
                                                                        AND DIM = pDIM
                                                                        AND BLOCK_CD = pUSE_BLOCK_CD
                                                                        AND CLASS = 'M/C' ) 
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA >= V_Next_del||'0800'
                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                GROUP BY SUPPLIER_CD );
                                                
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_PLAN_DATETIME := NULL;       
                                        END;                         
                        
                        END IF;
             
                                           
                                        IF V_PLAN_DATETIME IS NOT NULL THEN
                                        
                                                    pPLAN_DATE_SLIDE := SUBSTR(V_PLAN_DATETIME,1,8);
                                                    pPLAN_TIME_SLIDE := SUBSTR(V_PLAN_DATETIME,9,4);
                                                    
                                        ELSE
                                                    pPLAN_DATE_SLIDE := NULL ;
                                                    pPLAN_TIME_SLIDE := NULL ;
                                        

                                        END IF;
                                        
                ELSIF (V_CombiDay BETWEEN '2' AND '9') OR (V_CombiDay = 'W' OR   V_CombiDay = 'M') THEN
                            
                             IF V_CombiDay = 'W' THEN
                             
                                V_Num_Day_Slide := 7;
                                
                             ELSIF V_CombiDay = 'M' THEN
                             
                                V_Num_Day_Slide := 30;
                                
                             ELSE
                                V_Num_Day_Slide := V_CombiDay ;
                            
                            END IF;
                            
                            
                                BEGIN
                                        -- 1.) Get data MIN(DT_DELV)
                                        SELECT MIN(DT_DELV) INTO V_MIN_DT_DELV
                                        FROM T_PUR_PO_FOR_DO_DAILY_J300@FROM_EUC_NPIS
                                        WHERE NM_ARGMET_STAT IN ('PG','PO','MG','FC')
                                            AND NO_PARTS = pPART_NO
                                            AND NO_ADJ_DIM = pDIM                                
                                            AND CD_USE_BLOCK = CASE WHEN pCLASS = 'M/C' THEN pUSE_BLOCK_CD 
                                                                ELSE '      ' END
                                            AND DT_DELV > V_Next_Working_Day
                                            AND NO_ORD_CLASS = '4600';
                                            
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_MIN_DT_DELV := NULL;                                              
                                END;
                                
                                
-- 1
       IF V_MIN_DT_DELV = V_Next_del THEN  
             --- 1.1
                    IF  pCLASS = 'M/T' THEN

                                             BEGIN
                     
                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME  
                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                            From V_DO_WORKING_DAY 
                                                                            UNION
                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                            From V_DO_WORKING_DAY)
                                                              WHERE MK_WORK = 'Y' 
                                                              ) A
                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                        AND SUPPLIER_CD IN (     SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                               --AND PT_RATIO NOT IN ( '0')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND CLASS = 'M/T') 
                                                        AND SUBSTR(END_DATE,1,8)||TIME_ETA >= V_Next_del||'0800'
                                                       AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                        GROUP BY SUPPLIER_CD );
                                                        
                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                V_PLAN_DATETIME := NULL;       
                                                END;                        
                    
                    
             --- 1.2                   
                    ELSIF pCLASS = 'M/C' THEN

                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME  
                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                            From V_DO_WORKING_DAY 
                                                                            UNION
                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                            From V_DO_WORKING_DAY)
                                                              WHERE MK_WORK = 'Y' 
                                                              ) A
                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                        AND SUPPLIER_CD IN (     SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND BLOCK_CD = pUSE_BLOCK_CD
                                                                                AND CLASS = 'M/C') 
                                                        AND SUBSTR(END_DATE,1,8)||TIME_ETA >= V_Next_del||'0800'
                                                        AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                        GROUP BY SUPPLIER_CD );                        
                    
                    
                    
                    END IF;
                    
                    IF V_PLAN_DATETIME IS NOT NULL THEN
                    
                                pPLAN_DATE_SLIDE := SUBSTR(V_PLAN_DATETIME,1,8);
                                pPLAN_TIME_SLIDE := SUBSTR(V_PLAN_DATETIME,9,4);
                                
                    ELSE
                                pPLAN_DATE_SLIDE := NULL ;
                                pPLAN_TIME_SLIDE := NULL ;
                    

                    END IF;
  --2                                                  
          ELSIF V_MIN_DT_DELV IS NULL THEN
                                
                    pPLAN_DATE_SLIDE := NULL ;
                    pPLAN_TIME_SLIDE := NULL ;
                                                
  --3                                              
         ELSE
                                
                    V_delivery_date := V_MIN_DT_DELV;
                    V_delivery_Time := '2300';
                    VChk_Flg := 'Y';

             
                 WHILE (V_delivery_date||V_delivery_Time > V_Next_del||'0800' OR VChk_Flg ='N') 
                 LOOP    
                        IF V_CombiDay BETWEEN '2' AND '9' THEN
                                    BEGIN                            
                                            SELECT MIN(DT_WORK) INTO V_delivery_date_temp 
                                            FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                    WHERE MK_WORK = 'Y'
                                                    AND DT_WORK < V_delivery_date
                                                    ORDER BY DT_WORK DESC )
                                            WHERE ROWNUM <= V_CombiDay;
                                            
                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                            V_delivery_date_temp := NULL;   
                                    END;
                        ELSIF V_CombiDay = 'W' OR   V_CombiDay = 'M' THEN                                            
                                    BEGIN                            
                                            SELECT MIN(DT_WORK) INTO V_delivery_date_temp 
                                            FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                    WHERE DT_WORK < V_delivery_date
                                                    ORDER BY DT_WORK DESC )
                                            WHERE ROWNUM <= V_Num_Day_Slide;
                                            
                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                            V_delivery_date_temp := NULL;         
                                    END;
                        END IF;
                        
                        IF V_delivery_date_temp >= V_Next_del THEN
                                        
                                         V_delivery_date := V_delivery_date_temp ;
                        ELSE
                        
                                         V_delivery_date := V_delivery_date ;
                        
                        END IF;
                                                
                                                            
                                                            
                                                    
            
                       IF ( VChk_Flg = 'N' OR V_MIN_DT_DELV = V_delivery_date)THEN
                                    
                           IF  pCLASS = 'M/T' THEN                                                            
                                    
                                       BEGIN
                                          
                                          
                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME
                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                            From V_DO_WORKING_DAY 
                                                                            UNION
                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                            From V_DO_WORKING_DAY)
                                                              WHERE MK_WORK = 'Y' 
                                                              ) A
                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                        AND SUPPLIER_CD IN   ( SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND CLASS = 'M/T'  )
                                                        AND SUBSTR(END_DATE,1,8)||TIME_ETA BETWEEN  V_Next_del||'0800' AND V_Next_del||'9999'
                                                        AND SUBSTR(END_DATE,1,8) = V_Next_del
                                                        AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                        GROUP BY SUPPLIER_CD );
                                        
                                        
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_PLAN_DATETIME := NULL;       
                                        END;
                                                
                           ELSIF  pCLASS = 'M/C' THEN

                                       BEGIN
                                          
                                          
                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME
                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                            From V_DO_WORKING_DAY 
                                                                            UNION
                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                            From V_DO_WORKING_DAY)
                                                              WHERE MK_WORK = 'Y' 
                                                              ) A
                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                        AND SUPPLIER_CD IN   ( SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND BLOCK_CD = pUSE_BLOCK_CD
                                                                                AND CLASS = 'M/C'  )
                                                        AND SUBSTR(END_DATE,1,8)||TIME_ETA BETWEEN  V_Next_del||'0800' AND V_Next_del||'9999'
                                                        AND SUBSTR(END_DATE,1,8) = V_Next_del
                                                       AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                        GROUP BY SUPPLIER_CD );
                                        
                                        
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_PLAN_DATETIME := NULL;       
                                        END;                                                                
                                        
                                        
                                        
                                        END IF;

                                                
                                        ELSIF ( VChk_Flg = 'Y' ) THEN
                                        
                                                IF  pCLASS = 'M/T' THEN     

                                                                BEGIN

                                                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME
                                                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                                            From V_DO_WORKING_DAY 
                                                                                                            UNION
                                                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                                            From V_DO_WORKING_DAY)
                                                                                              WHERE MK_WORK = 'Y' 
                                                                                              ) A
                                                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                                                        AND SUPPLIER_CD IN ( SELECT DISTINCT  SUPPLIER_CD
                                                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                                                AND PART_NO =  pPART_NO
                                                                                                                AND DIM = pDIM
                                                                                                                AND CLASS = 'M/T') 
                                                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_Next_del||'0800'
                                                                                            AND SUBSTR(END_DATE,1,8) = V_Next_del
                                                                                            AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                                        GROUP BY SUPPLIER_CD );
                                                                                        
                                                                    
                                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                    V_PLAN_DATETIME := NULL;       
                                                                END;
                                                                                                          

                                                ELSIF  pCLASS = 'M/C' THEN  

                                                                BEGIN

                                                                                    SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS V_PLAN_DATETIME
                                                                                    FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                                            From V_DO_WORKING_DAY 
                                                                                                            UNION
                                                                                                            SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                                            From V_DO_WORKING_DAY)
                                                                                              WHERE MK_WORK = 'Y' 
                                                                                              ) A
                                                                                    JOIN V_PRD_DO_DELIVERY_MASTER B
                                                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                                                    WHERE FACTORY_CD = pFACTORY_CD
                                                                                        AND SUPPLIER_CD IN ( SELECT DISTINCT  SUPPLIER_CD
                                                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                                                AND PART_NO =  pPART_NO
                                                                                                                AND DIM = pDIM
                                                                                                                AND BLOCK_CD = pUSE_BLOCK_CD
                                                                                                                AND CLASS = 'M/C') 
                                                                                        AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_Next_del||'0800'
                                                                                        AND SUBSTR(END_DATE,1,8) = V_Next_del
                                                                                        AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                                        GROUP BY SUPPLIER_CD );
                                                                                        
                                                                    
                                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                    V_PLAN_DATETIME := NULL;       
                                                                END;                                                                        
                                                
                                                
                                                
                                                
                                                END IF;

                                        END IF;   
                                        
                                        IF V_PLAN_DATETIME IS NOT NULL THEN
                                        
                                                IF SUBSTR(V_PLAN_DATETIME,1,8)||SUBSTR(V_PLAN_DATETIME,9,4) < V_Next_del||'0800' THEN
                                                   -- End 
                                                   pPLAN_DATE_SLIDE  :=  V_delivery_date ;
                                                   pPLAN_TIME_SLIDE  :=  V_delivery_Time ;
                                                   VChk_Flg := 'Y';
                                                   V_delivery_date := '0' ;
                                                   V_delivery_Time := '0' ;
                                                   
                                                ELSIF SUBSTR(V_PLAN_DATETIME,1,8)||SUBSTR(V_PLAN_DATETIME,9,4) > V_Next_del||'0800' THEN
                                                
                                                    IF SUBSTR(V_PLAN_DATETIME,1,8) = V_Next_del THEN
                                                    
                                                           -- End 
                                                           pPLAN_DATE_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,1,8) ;
                                                           pPLAN_TIME_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,9,4) ;
                                                           VChk_Flg := 'Y';
                                                           V_delivery_date := '0' ;
                                                           V_delivery_Time := '0' ;                                                    
                                                    
                                                    ELSE
                                                    
                                                                                                               -- End 
                                                           pPLAN_DATE_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,1,8) ;
                                                           pPLAN_TIME_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,9,4) ;
                                                           VChk_Flg := 'N';
                                                           V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8) ;
                                                           V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4) ;    
                                                    
                                                    
                                                    END IF;
                                                
                                                
                                                
                                                ELSIF SUBSTR(V_PLAN_DATETIME,1,8)||SUBSTR(V_PLAN_DATETIME,9,4) = V_Next_del||'0800' THEN
                                                   
                                                    -- End 
                                                   pPLAN_DATE_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,1,8) ;
                                                   pPLAN_TIME_SLIDE  :=  SUBSTR(V_PLAN_DATETIME,9,4) ;
                                                   VChk_Flg := 'Y';
                                                   V_delivery_date := '0' ;
                                                   V_delivery_Time := '0' ;
                                                   
                                                
                                                END IF;
                                        
                                        
                                        
                                        
                                        
                                        END IF;
                                        
                                        
                                        
                                        

                                             
                                             END LOOP;
                                

                            
                                END IF;
                            
                
                ELSE
                                    pPLAN_DATE_SLIDE := NULL ;
                                    pPLAN_TIME_SLIDE := NULL ;
                
                                                
                END IF;
        

            END IF;

pNM_KEY_TABLE := V_NM_KEY_TABLE ;
pCombiDay  := V_CombiDay ;
pPLAN_DATETIME :=  V_PLAN_DATETIME ;


END P_PRD_DO_FIND_DEL_FOR_MULTI_RATE;
15.1.3
PROCEDURE P_PRD_DO_FIND_DEL_FIRST_PRIORITY (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pCLASS VARCHAR2,
                                                    pUSE_BLOCK_CD VARCHAR2,
                                                    pCD_SPLY_FACT VARCHAR2,
                                                    pNEXT_WORK_DAY     VARCHAR2,
                                                    pNM_KEY_TABLE      VARCHAR2,
                                                    pPLAN_DATE_SLIDE     OUT VARCHAR2,
                                                    pPLAN_TIME_SLIDE     OUT VARCHAR2
                                                    ) AS 


vFLG    VARCHAR2(1 BYTE) := 0;   
V_Next_Working_Day   VARCHAR2(8 BYTE); 
V_PLAN_DATE_SLIDE VARCHAR2(20 BYTE); 
V_PLAN_TIME_SLIDE VARCHAR2(20 BYTE); 
V_Next_Working_Day2  VARCHAR2(8 BYTE); 
V_Next_PlanDate     VARCHAR2(8 BYTE); 
V_Day               VARCHAR2(3 BYTE);
vTime               VARCHAR2(4 BYTE);
BEGIN 
V_Next_Working_Day := pNEXT_WORK_DAY ;
pPLAN_DATE_SLIDE := NULL;
pPLAN_TIME_SLIDE := NULL;
V_PLAN_DATE_SLIDE := NULL;
V_PLAN_DATE_SLIDE := NULL;
                     WHILE ( vFLG = 0 )
                     LOOP
                                      
                    
                                 BEGIN
                                    SELECT MIN(DT_WORK) INTO V_Next_Working_Day
                                    FROM WBGZT051@FROM_EUC_NPIS
                                    WHERE MK_WORK = 'Y'
                                    AND DT_WORK > V_Next_Working_Day;  
                                END;
                                
                                
                               --  Check Day on Plan data and plan Time                            
                                BEGIN
                                    SELECT TO_CHAR(TO_DATE(V_Next_Working_Day,'YYYYMMDD'),'DY') INTO V_Day
                                    FROM DUAL;
                                    
                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_Day := NULL;                            
                                END;
                                
                             -- Check MK_DAY_INTEGRATE  Like %Day% 
                                IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN -- Support Time 08.00 - 23.00
                                
                                
                                         -- #Modify 14-Mar-2022 by Alisa
                                           
                                                            PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT ,V_Next_Working_Day,'0800' ,'2300',vTime);
                                                
                                                            IF vTime IS NULL THEN
                                                            
                                                                    SELECT MIN(DT_WORK) INTO V_Next_Working_Day
                                                                    FROM WBGZT051@FROM_EUC_NPIS
                                                                    WHERE DT_WORK > V_Next_Working_Day;
                                                                     
                                                                     
                                                                       BEGIN
                                                                            SELECT TO_CHAR(TO_DATE(V_Next_Working_Day,'YYYYMMDD'),'DY') INTO V_Day
                                                                            FROM DUAL;
                                                                            
                                                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                            V_Day := NULL;                            
                                                                        END;
                                                                    
                                                                     IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN
                                                                     
                                                                     
                                                                                PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT,V_Next_Working_Day ,'0000' ,'0700',vTime);
                                                                    
                                                                            IF vTime IS NOT NULL THEN
                                                                            
                                                                                 V_PLAN_DATE_SLIDE := V_Next_Working_Day ;
                                                                                 V_PLAN_TIME_SLIDE := vTime ;
                                                                                 vFLG := 1 ;

                                                                            END IF;
                                                                    
                                                                    END IF;
                                                            
                                                            ELSE
                                                            
                                                            
                                                                     V_PLAN_DATE_SLIDE := V_Next_Working_Day ;
                                                                     V_PLAN_TIME_SLIDE := vTime ;
                                                                     vFLG := 1 ;
                                                                    
                                                            END IF;

                               ELSE
                                        
                                        -- Support Time 00.00 - 07.00
                                        
                                         SELECT MIN(DT_WORK) INTO V_Next_Working_Day2
                                         FROM WBGZT051@FROM_EUC_NPIS
                                         WHERE DT_WORK > V_Next_Working_Day;
                                         
                                         
                                           BEGIN
                                                SELECT TO_CHAR(TO_DATE(V_Next_Working_Day2,'YYYYMMDD'),'DY') INTO V_Day
                                                FROM DUAL;
                                                
                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                V_Day := NULL;                            
                                           END;
                                            
                                          IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN
                                          
                                                PG_PRD_DO_FIND_DEL_FOR_MULTI_RATE.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT,V_Next_Working_Day2 ,'0000' ,'0700',vTime);

                                                 IF vTime IS NOT NULL THEN
                                                                            
                                                         V_PLAN_DATE_SLIDE := V_Next_Working_Day2 ;
                                                         V_PLAN_TIME_SLIDE := vTime ;
                                                         vFLG := 1 ;

                                                 END IF;
                                          END IF;
                                       
                                            
                                            
                             END IF;
                               
                    END LOOP ; 
                    pPLAN_DATE_SLIDE := V_PLAN_DATE_SLIDE ;
                    pPLAN_TIME_SLIDE := V_PLAN_TIME_SLIDE ;
                                                    
END P_PRD_DO_FIND_DEL_FIRST_PRIORITY;
15.1.4
PROCEDURE P_PRD_DO_FIND_DEL_PLAN_TIME (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pCLASS VARCHAR2,
                                                    pUSE_BLOCK_CD VARCHAR2,
                                                    pPLAN_DATE     VARCHAR2,
                                                    pPLAN_TIME_START     VARCHAR2,
                                                    pPLAN_TIME_END     VARCHAR2,
                                                    pCD_SPLY_FACT      VARCHAR2,
                                                    pPLAN_TIME_SLIDE     OUT VARCHAR2) AS 
V_PLAN_DATETIME    VARCHAR2(12 BYTE);  
vCOUNT NUMBER;
BEGIN
              
                    BEGIN
                        SELECT COUNT(*) INTO vCOUNT
                        FROM WBGZT051@FROM_EUC_NPIS
                        WHERE MK_WORK = 'Y'
                        AND DT_WORK = pPLAN_DATE;  
                    END;
                    
                    
                            IF (vCOUNT = 1)THEN
                            
                                
                                
                                              
                                               
                                               
                                                IF ( pCLASS = 'M/T' )THEN
                                                    
                                                        BEGIN
                                                             SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME  
                                                                 FROM (
                                                                SELECT SUPPLIER_CD,MIN(TIME_ETA) AS V_PLAN_DATETIME
                                                                FROM V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND CLASS = 'M/T'
                                                                              )
                                                                AND TIME_ETA BETWEEN pPLAN_TIME_START AND '2300'
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                GROUP BY SUPPLIER_CD );
                                                                
                                                        EXCEPTION
                                                            WHEN OTHERS THEN
                                                                        V_PLAN_DATETIME := NULL ;
                                                            
                                                         END ;
                                                    
                                                    
                                                    ELSIF ( pCLASS = 'M/C' )THEN
                                                    
                                                        BEGIN
                                                             SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME  
                                                                 FROM (
                                                                SELECT SUPPLIER_CD,MIN(TIME_ETA) AS V_PLAN_DATETIME
                                                                FROM V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND BLOCK_CD = pUSE_BLOCK_CD
                                                                                AND CLASS = 'M/C'
                                                                              )
                                                                AND TIME_ETA BETWEEN pPLAN_TIME_START AND '2300'
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                GROUP BY SUPPLIER_CD );
                                                                
                                                        EXCEPTION
                                                            WHEN OTHERS THEN
                                                                        V_PLAN_DATETIME := NULL ;
                                                            
                                                         END ;                                                    
                                                    
                                                    
                                                    END IF;
                            
                            ELSE
                            
                            
                                                 IF ( pCLASS = 'M/T' )THEN
                                                    
                                                        BEGIN
                                                             SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME  
                                                                 FROM (
                                                                SELECT SUPPLIER_CD,MIN(TIME_ETA) AS V_PLAN_DATETIME
                                                                FROM V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND CLASS = 'M/T'
                                                                              )
                                                                AND TIME_ETA BETWEEN  pPLAN_TIME_START AND pPLAN_TIME_END
                                                               AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                GROUP BY SUPPLIER_CD );
                                                                
                                                        EXCEPTION
                                                            WHEN OTHERS THEN
                                                                        V_PLAN_DATETIME := NULL ;
                                                            
                                                         END ;
                                                    
                                                    
                                                    ELSIF ( pCLASS = 'M/C' )THEN
                                                    
                                                        BEGIN
                                                             SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME  
                                                                 FROM (
                                                                SELECT SUPPLIER_CD,MIN(TIME_ETA) AS V_PLAN_DATETIME
                                                                FROM V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM T_PRD_DO_PART_AND_STRUCTURE
                                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                                AND PT_RATIO NOT IN ( '0' ,'100')
                                                                                AND PART_NO =  pPART_NO
                                                                                AND DIM = pDIM
                                                                                AND BLOCK_CD = pUSE_BLOCK_CD
                                                                                AND CLASS = 'M/C'
                                                                              )
                                                                AND TIME_ETA BETWEEN  pPLAN_TIME_START AND pPLAN_TIME_END
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                GROUP BY SUPPLIER_CD );
                                                                
                                                        EXCEPTION
                                                            WHEN OTHERS THEN
                                                                        V_PLAN_DATETIME := NULL ;
                                                            
                                                         END ;                                                    
                                                    
                                                    
                                                    END IF;
                            
                     
                            END IF;


                                 
                                    




pPLAN_TIME_SLIDE := V_PLAN_DATETIME ;

END P_PRD_DO_FIND_DEL_PLAN_TIME;
15.4
  PROCEDURE P_PRD_DO_PLAN_REF_DEL_LOT(pFACTORY_CD      VARCHAR2,
                                            pPART_NO       VARCHAR2,
                                            pDIM           VARCHAR2,
                                            pUSE_BLOCK_CD  VARCHAR2,
                                            pSUPPLIER_CD   VARCHAR2,                                                    
                                            pCLASS         VARCHAR2,
                                            pRATIO         VARCHAR2,
                                            pLOGIC         VARCHAR2,
                                            pNEXT_DEL      VARCHAR2,
                                            pCD_SPLY_FACT   VARCHAR2,
                                            pSUM_QTY_DO    OUT NUMBER
                                           ) AS
                                            
CURSOR C1 IS SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_RF_LT --NVL(PLAN_QTY_RF_LT,0)+NVL(PLAN_QTY_BALANCE,0)	AS PLAN_QTY_RF_LT
                FROM T_DO_PLAN_BALANCE_QTY_BY_SPLY	
                WHERE PLAN_DATE||PLAN_TIME >= pNEXT_DEL||'0800' --20221018 CN
                    AND RATIO = pRATIO
                    AND PLAN_QTY_RF_LT > 0 
                    AND FACTORY_CD = pFACTORY_CD
                    AND PART_NO = pPART_NO
                    AND DIM = pDIM
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND USE_BLOCK_CD = pUSE_BLOCK_CD
                    AND CLASS = pCLASS
                    
                 --   AND LOGIC = pLOGIC
                ORDER BY PLAN_DATE,PLAN_TIME;
REC1		C1%rowtype;

V_QT_DELV_LOT             NUMBER(20);  
V_REMAIN_QTY              NUMBER(20);
V_SNP_LOT                 NUMBER(20);
V_QTY_REF_LOT             NUMBER(20);
vFLG_IN_HOUSE             VARCHAR2(2);


BEGIN


    BEGIN            
    SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
    FROM T_PRD_DO_DELIVERY_MASTER
        WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD IN (
         SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD FROM T_PRD_DO_DELIVERY_MASTER 
         WHERE  FACTORY_CD = pFACTORY_CD
         AND SUPPLIER_CD = pSUPPLIER_CD
         AND EFFECT_STA_DATE <= TO_CHAR(SYSDATE,'YYYYMMDD')
         AND CD_SPLY_FACT = pCD_SPLY_FACT
         GROUP BY FACTORY_CD,SUPPLIER_CD);
        

    EXCEPTION WHEN NO_DATA_FOUND THEN     
    
        vFLG_IN_HOUSE := NULL ;
    
    END ;
    
    
    
    IF (vFLG_IN_HOUSE = 'Y') THEN
            
            
            OPEN C1;
            LOOP
            FETCH C1 INTO REC1;
            EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
            BEGIN  

                                INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                            (FACTORY_CD,
                                            PART_NO,
                                            DIM,
                                            USE_BLOCK_CD,
                                            SUPPLIER_CD,
                                            RATIO,
                                            CLASS,
                                            PLAN_DATE,
                                            PLAN_TIME,
                                            PLAN_QTY_REF_LOT,
                                            CREATE_DATE,
                                            LOGIC,
                                            CD_SPLY_FACT)
                                    VALUES (pFACTORY_CD,
                                            pPART_NO,
                                            pDIM,
                                            pUSE_BLOCK_CD,
                                            pSUPPLIER_CD,
                                            pRATIO,
                                            pCLASS,
                                            REC1.PLAN_DATE,
                                            REC1.PLAN_TIME,
                                            REC1.PLAN_QTY_RF_LT,                                    
                                            SYSDATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);  
                                            COMMIT;  
            
            END;
            END LOOP; -- END LOOP CUR 1
            CLOSE C1;  
    
    
    ELSE 
    
                    -- Get data DISTINCT  QT_DELV_LOT
                    BEGIN
                        SELECT DISTINCT  QT_DELV_LOT INTO V_QT_DELV_LOT
                        FROM WBGJT002@FROM_EUC_NPIS
                        WHERE CD_SPLY	=	pSUPPLIER_CD 
                            AND NO_PARTS	=	pPART_NO 
                            AND NO_ADJ_DIM	=	pDIM 
                            AND CD_SPLY_FACT = pCD_SPLY_FACT
                            AND DT_ENTRY	=	(SELECT MAX(DT_ENTRY) FROM WBGJT002@FROM_EUC_NPIS
                                                 WHERE CD_SPLY	=	pSUPPLIER_CD 
                                                    AND NO_PARTS	=	pPART_NO 
                                                    AND NO_ADJ_DIM	=	pDIM
                                                    AND CD_SPLY_FACT = pCD_SPLY_FACT);
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                        
                                        V_QT_DELV_LOT := 0; 
                            
                    END;
                    
                    -- Set Initial data
                    V_REMAIN_QTY := 0; --#ของที่สั่งเกินจากรอบก่อน
                
                    -- 2.)  Open CUR 1
                    OPEN C1;
                    LOOP
                    FETCH C1 INTO REC1;
                    EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
                    BEGIN
                        --#รอบนั้นต้อง Order ของ
                        IF REC1.PLAN_QTY_RF_LT > V_REMAIN_QTY THEN
                            BEGIN
                                V_SNP_LOT := CEIL((REC1.PLAN_QTY_RF_LT - V_REMAIN_QTY) / V_QT_DELV_LOT);
                                                
                                V_QTY_REF_LOT := V_SNP_LOT * V_QT_DELV_LOT;
                                
                                V_REMAIN_QTY := V_QTY_REF_LOT - (REC1.PLAN_QTY_RF_LT - V_REMAIN_QTY);
                                
                                INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                            (FACTORY_CD,
                                            PART_NO,
                                            DIM,
                                            USE_BLOCK_CD,
                                            SUPPLIER_CD,
                                            RATIO,
                                            CLASS,
                                            PLAN_DATE,
                                            PLAN_TIME,
                                            PLAN_QTY_REF_LOT,
                                            CREATE_DATE,
                                            LOGIC,
                                            CD_SPLY_FACT)
                                    VALUES (pFACTORY_CD,
                                            pPART_NO,
                                            pDIM,
                                            pUSE_BLOCK_CD,
                                            pSUPPLIER_CD,
                                            pRATIO,
                                            pCLASS,
                                            REC1.PLAN_DATE,
                                            REC1.PLAN_TIME,
                                            V_QTY_REF_LOT,                                    
                                            SYSDATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);
                                    COMMIT;  
                                    --pSUM_QTY_DO := 0;
                            END;
                        --#รอบนั้นไม่ต้อง Order ของ    
                        ELSIF REC1.PLAN_QTY_RF_LT <= V_REMAIN_QTY THEN
                            BEGIN    
                                V_QTY_REF_LOT := 0;
                                                
                                V_REMAIN_QTY := V_REMAIN_QTY - REC1.PLAN_QTY_RF_LT;
                                
                                INSERT INTO T_DO_PLAN_REF_DELIVERY_LOT
                                            (FACTORY_CD,
                                            PART_NO,
                                            DIM,
                                            USE_BLOCK_CD,
                                            SUPPLIER_CD,
                                            RATIO,
                                            CLASS,
                                            PLAN_DATE,
                                            PLAN_TIME,
                                            PLAN_QTY_REF_LOT,
                                            CREATE_DATE,
                                            LOGIC,
                                            CD_SPLY_FACT)
                                    VALUES (pFACTORY_CD	,
                                            pPART_NO,
                                            pDIM,
                                            pUSE_BLOCK_CD,
                                            pSUPPLIER_CD,
                                            pRATIO,
                                            pCLASS,
                                            REC1.PLAN_DATE,
                                            REC1.PLAN_TIME,
                                            0,                                    
                                            SYSDATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);
                                    COMMIT;  
                                     --pSUM_QTY_DO := 2;
                            END;
                        END IF;
                        
                    END;
                    END LOOP; -- END LOOP CUR 1
                    CLOSE C1;        
    
    
    END IF ;

    COMMIT;
    -- Calling PG  P_PRD_DO_PLAN_REF_DEL_DATE
    PG_PRD_DO_CALCULATION_MULTI_RATE.P_PRD_DO_PLAN_REF_DEL_DATE( 
                                                                 pFACTORY_CD,       pPART_NO,
                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,      pCLASS,
                                                                 pRATIO,            pLOGIC,            
                                                                 pNEXT_DEL,         pCD_SPLY_FACT, 
                                                                 pSUM_QTY_DO
                                                                );
                                                                 
END P_PRD_DO_PLAN_REF_DEL_LOT;
15.4.1
PROCEDURE P_PRD_DO_PLAN_REF_DEL_DATE(pFACTORY_CD      VARCHAR2,
                                            pPART_NO       VARCHAR2,
                                            pDIM           VARCHAR2,
                                            pUSE_BLOCK_CD  VARCHAR2,
                                            pSUPPLIER_CD   VARCHAR2,                                                    
                                            pCLASS         VARCHAR2,
                                            pRATIO         VARCHAR2,
                                            pLogic          VARCHAR2,
                                            pNEXT_DEL       VARCHAR2,
                                            pCD_SPLY_FACT   VARCHAR2,
                                            pSUM_QTY_DO    OUT NUMBER )
                                             AS
                                            
CURSOR C1 IS SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT
                FROM T_DO_PLAN_REF_DELIVERY_LOT
                WHERE PLAN_DATE||PLAN_TIME >= pNEXT_DEL||'0800' --20201018 CN
                    AND RATIO = pRATIO 
                    AND PLAN_QTY_REF_LOT > 0
                    AND FACTORY_CD = pFACTORY_CD	
                    AND PART_NO	= pPART_NO
                    AND DIM	= pDIM
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND USE_BLOCK_CD = pUSE_BLOCK_CD
                    AND CLASS = pCLASS
                    AND LOGIC = pLogic
                    AND CD_SPLY_FACT = pCD_SPLY_FACT
                ORDER BY PLAN_DATE,PLAN_TIME;
REC1		C1%rowtype;

V_NM_KEY_TABLE              VARCHAR2(100 BYTE);
V_CombiDay                  VARCHAR2(1 BYTE);
V_delivery_date             VARCHAR2(8 BYTE);
V_delivery_Time             VARCHAR2(4 BYTE);
V_Next_PlanDate             VARCHAR2(8 BYTE);
V_Day                       VARCHAR2(3 BYTE);
V_COUNT                     NUMBER(3);
V_MIN_DT_DELV               VARCHAR2(8 BYTE);
V_PLAN_DATETIME             VARCHAR2(12 BYTE);
V_Next_Working_Day          VARCHAR2(8 BYTE);
VChk_Flg                    VARCHAR2(1 BYTE);
V_Num_Day_Slide             NUMBER(3);
vFLG_IN_HOUSE               VARCHAR2(1 BYTE);
V_COUNT_HOL                 NUMBER(3);
pFLG                        NUMBER(1);
vCnt_SPLY_FACT              NUMBER;
vPLAN_DATE                  VARCHAR2(8 BYTE);
vPLAN_TIME                  VARCHAR2(12 BYTE);
vPLAN_QTY_REF_LOT           NUMBER;
BEGIN


    BEGIN            
    SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
    FROM T_PRD_DO_DELIVERY_MASTER
        WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
         SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT FROM T_PRD_DO_DELIVERY_MASTER 
         WHERE  FACTORY_CD = pFACTORY_CD
         AND SUPPLIER_CD = pSUPPLIER_CD
         AND EFFECT_STA_DATE <= pNEXT_DEL
         AND CD_SPLY_FACT = pCD_SPLY_FACT
         GROUP BY FACTORY_CD,SUPPLIER_CD,CD_SPLY_FACT);
        
    EXCEPTION WHEN NO_DATA_FOUND THEN           


            vFLG_IN_HOUSE := NULL;
            
   END;

    IF (vFLG_IN_HOUSE = 'Y') THEN 
 
                    OPEN C1;
                    LOOP
                    FETCH C1 INTO REC1;
                    EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;

                    
                    BEGIN
                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                             pFACTORY_CD,           pPART_NO,
                                             pDIM,                  pUSE_BLOCK_CD,
                                             pSUPPLIER_CD,          pCLASS,
                                             pRATIO,
                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                             REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                             pLogic,                pCD_SPLY_FACT);
                               
                            EXCEPTION
                                WHEN OTHERS THEN
                                   NULL ;
                    END;
                    COMMIT;  

                    END LOOP; -- END LOOP CUR 1
                    CLOSE C1;     
    ELSE
                    BEGIN
                        -- Check count CD_SPLY_FACT 
                        SELECT COUNT(*) INTO vCnt_SPLY_FACT
                        FROM V_PRD_DO_DELIVERY_MASTER
                        WHERE FACTORY_CD = pFACTORY_CD
                        AND SUPPLIER_CD = pSUPPLIER_CD
                        AND CD_SPLY_FACT = pCD_SPLY_FACT;
                    END;
                    -- 9.0)Case Not found CD_SPLY_FACT (From Cur 1) OR table V_PRD_DO_DELIVERY_MASTER
                    IF pCD_SPLY_FACT is null OR vCnt_SPLY_FACT = 0 THEN
                    BEGIN
                    
                    SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT INTO vPLAN_DATE,vPLAN_TIME,vPLAN_QTY_REF_LOT                                    
                    FROM T_DO_PLAN_REF_DELIVERY_LOT
                    WHERE FACTORY_CD = pFACTORY_CD
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                    
                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,       pPART_NO,
                                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,      pCLASS,
                                                                                 pRATIO,
                                                                                 vPLAN_DATE,            vPLAN_TIME,
                                                                                 vPLAN_DATE,            vPLAN_TIME,
                                                                                 vPLAN_QTY_REF_LOT,     'WF0030',
                                                                                 pLogic,            pCD_SPLY_FACT);
                                                                        
                                                                    EXCEPTION
                                                                        WHEN OTHERS THEN
                                                                           NULL ;
                    
                    END;
                    END IF;

                    BEGIN
                            -- 1.) Get data NM_KEY_TABLE -- #A Day of the Week
                            SELECT DISTINCT UPPER(NM_KEY_TABLE) INTO V_NM_KEY_TABLE --SUBSTR(NM_KEY_TABLE,3,3)
                            FROM V_DO_DELEVERY_DAY_OF_WEEK
                            WHERE NO_PARTS = pPART_NO
                                AND NO_ADJ_DIM = pDIM;
                                
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                V_NM_KEY_TABLE := NULL;
                    END;
                    
                    BEGIN
                            -- 2.) Get data PD_DELV_QTY_ROUND_DEF -- #CombineDay
                            /*
                            SELECT DISTINCT  PD_DELV_QTY_ROUND_DEF INTO V_CombiDay
                            FROM J000_SUPPLIER_MASTER@FROM_EUC_NPIS
                            WHERE CD_SPLY = pSUPPLIER_CD
                                AND DT_ENTRY = (SELECT MAX(DT_ENTRY) 
                                                FROM J000_SUPPLIER_MASTER@FROM_EUC_NPIS
                                                WHERE CD_SPLY = pSUPPLIER_CD
                                                GROUP BY CD_SPLY);
                                                
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                V_CombiDay := NULL;
                           */
                           
                           V_CombiDay := 'D' ;
                
                    END;
                   

                    
                    V_Next_Working_Day := pNEXT_DEL ;
                
                    -- 3.)  Open CUR 1
                    OPEN C1;
                    LOOP
                    FETCH C1 INTO REC1;
                    EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
                    BEGIN
                            -- 4.) Check  MK_DAY_INTEGRATE not null 
                            IF V_NM_KEY_TABLE IS NOT NULL THEN
                            BEGIN
                                -- 4.1) Set Initial data 
                                V_delivery_date := REC1.PLAN_DATE;
                                V_delivery_Time := REC1.PLAN_TIME; 
                                
                                -- Set Next_PlanDate = PLAN_DATE + 1 Day
                                BEGIN
                                    SELECT TO_CHAR(TO_DATE(REC1.PLAN_DATE,'YYYYMMDD')+1,'YYYYMMDD') INTO V_Next_PlanDate FROM DUAL;
                                END;
                                
                                -- 4.2) Check Day on Plan data and plan Time                            
                                BEGIN
                                    SELECT TO_CHAR(TO_DATE(V_delivery_date,'YYYYMMDD'),'DY') INTO V_Day
                                    FROM DUAL;
                                    
                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_Day := NULL;                            
                                END;
                                
                                 -- 4.3.1) Check MK_DAY_INTEGRATE  Like %Day% 
                                IF V_NM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN
                                
                                        BEGIN
                                        
                                            SELECT NVL(COUNT(*),0) INTO V_COUNT
                                            FROM V_PRD_DO_DELIVERY_MASTER
                                            WHERE FACTORY_CD = pFACTORY_CD
                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                AND TIME_ETA = REC1.PLAN_TIME
                                                AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                                
                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                V_COUNT := 0;              
                                        END;
                                        
                                        
                                        -- Support milkrun
                                                            IF  REC1.PLAN_TIME IN ('0000','0100','0200','0300','0400','0500','0600','0700') THEN 
                                                            
                                                                            SELECT  COUNT(*) INTO V_COUNT_HOL
                                                                            FROM WBGZT051@FROM_EUC_NPIS 
                                                                            WHERE MK_WORK = 'N'
                                                                            AND DT_WORK = (SELECT MIN(dt_work) FROM wbgzt051@FROM_EUC_NPIS
                                                                                            WHERE dt_work > REC1.PLAN_TIME AND mk_work = 'Y');
                                                                            
                                                                            IF V_COUNT_HOL > 0 THEN 
                                                                                     V_COUNT := 0;  
                                                                            END IF;
                         
                                                            END IF;
                                        
                                        -- A.) วันตรงกับ Combli , รอบการส่งตรงกับ Plan
                                        IF V_COUNT > 0 THEN                                            
                                                    BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                             pFACTORY_CD,           pPART_NO,
                                                                             pDIM,                  pUSE_BLOCK_CD,
                                                                             pSUPPLIER_CD,          pCLASS,
                                                                             pRATIO,
                                                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                             V_delivery_date,       V_delivery_Time,
                                                                             REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                             pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                         -- B.) วันตรงกับ Combli , รอบการส่งไม่ตรงกับ Plan
                                         ELSIF V_COUNT = 0 THEN 
                                                BEGIN
                                                
                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN
                                                                                (pFACTORY_CD,       pPART_NO,
                                                                                    pDIM,           pSUPPLIER_CD,
                                                                                    V_Next_PlanDate,
                                                                                    REC1.PLAN_DATE, REC1.PLAN_TIME,
                                                                                    pNEXT_DEL,      pCD_SPLY_FACT,
                                                                                    V_delivery_date,V_delivery_Time);
                                                    IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                            BEGIN
                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                     pFACTORY_CD,           pPART_NO,
                                                                                     pDIM,                  pUSE_BLOCK_CD,
                                                                                     pSUPPLIER_CD,          pCLASS,
                                                                                     pRATIO,
                                                                                     REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                     V_delivery_date,       V_delivery_Time,
                                                                                     REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                     pLogic,                pCD_SPLY_FACT);
                                                                            
                                                                        EXCEPTION
                                                                            WHEN OTHERS THEN
                                                                               NULL ;
                                                            END;
                                                    ELSE 
                                                            BEGIN
                                                                PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                     pFACTORY_CD,           pPART_NO,
                                                                                     pDIM,                  pUSE_BLOCK_CD,
                                                                                     pSUPPLIER_CD,          pCLASS,
                                                                                     pRATIO,
                                                                                     REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                     REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                     REC1.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                     pLogic,                pCD_SPLY_FACT);
                                                                            
                                                                        EXCEPTION
                                                                            WHEN OTHERS THEN
                                                                               NULL ;
                                                            END;
                                                    
                                                    END IF;
                                                END;                                                
                                         END IF;-- V_COUNT > 0
                                         
                                -- 4.3.2) วันไม่ตรงกับ Combli 
                                ELSE           
                                        BEGIN
                                                    
                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN
                                                                        (pFACTORY_CD,       pPART_NO,
                                                                            pDIM,           pSUPPLIER_CD,
                                                                            V_Next_PlanDate,
                                                                            REC1.PLAN_DATE, REC1.PLAN_TIME,
                                                                            pNEXT_DEL,      pCD_SPLY_FACT,
                                                                            V_delivery_date,V_delivery_Time);
                                            IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                    BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,           pPART_NO,
                                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,          pCLASS,
                                                                                 pRATIO,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 V_delivery_date,       V_delivery_Time,
                                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                 pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                            ELSE
                                                    BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,           pPART_NO,
                                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,          pCLASS,
                                                                                 pRATIO,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                 pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                            
                                            END IF;
                                        END;        
                                END IF;-- V_MK_DAY_INTEGRATE LIKE '%'||V_Day||'%'
                                
                            END;            
                            END IF;-- V_MK_DAY_INTEGRATE IS NOT NULL
                            
                            ----------------------------------------------------------------------------------------------
                            -- 3.7) Check  MK_DAY_INTEGRAT Is  null 
                            IF  V_NM_KEY_TABLE  IS NULL   THEN
                            BEGIN
                                BEGIN
                                        -- 1.) Get data MIN(DT_DELV)
                                        SELECT MIN(DT_DELV) INTO V_MIN_DT_DELV
                                        FROM T_PUR_PO_FOR_DO_DAILY_J300@FROM_EUC_NPIS
                                        WHERE NM_ARGMET_STAT IN ('PG','PO','MG','FC')
                                            AND NO_PARTS = pPART_NO
                                            AND NO_ADJ_DIM = pDIM                                
                                            AND DT_DELV >= REC1.PLAN_DATE
                                            AND NO_ORD_CLASS = '4600'
                                            AND CD_SPLY = pSUPPLIER_CD;
                                            
                                        EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_MIN_DT_DELV := NULL;                                              
                                END;
                                
                                -- 2.1) If  DT_DELV  not found data  or value is null 
                                IF V_MIN_DT_DELV IS NULL AND V_CombiDay <> 'D' THEN
                                    BEGIN
                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                 pFACTORY_CD,           pPART_NO,
                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,          pCLASS,
                                                                 pRATIO,
                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0017',
                                                                 pLogic,                pCD_SPLY_FACT);
                                                    
                                                EXCEPTION
                                                    WHEN OTHERS THEN
                                                       NULL ;
                                    END; 
                                
                                -- 2.2) If  PD_DELV_QTY_ROUND_DEF (Combine day)= D    
                                ELSIF V_CombiDay = 'D' THEN
                                    BEGIN
                                        BEGIN
                                            SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                    From V_DO_WORKING_DAY 
                                                                    UNION
                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                    From V_DO_WORKING_DAY)
                                                      WHERE MK_WORK = 'Y' 
                                                      ) A
                                            JOIN V_PRD_DO_DELIVERY_MASTER B
                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                            WHERE FACTORY_CD = pFACTORY_CD
                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= REC1.PLAN_DATE||REC1.PLAN_TIME
                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                ( 
                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                 UNION
                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                              
                                                                                )C )
                                            ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                            
                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                            V_PLAN_DATETIME := NULL;       
                                        END;
                                        
                                        IF V_PLAN_DATETIME IS NOT NULL THEN
                                            V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                            V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                            
                                        ELSE 
                                            BEGIN
                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                             pFACTORY_CD,           pPART_NO,
                                                                             pDIM,                  pUSE_BLOCK_CD,
                                                                             pSUPPLIER_CD,          pCLASS,
                                                                             pRATIO,
                                                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                             V_delivery_date,       V_delivery_Time,
                                                                             REC1.PLAN_QTY_REF_LOT, 'WF0019',
                                                                             pLogic,                pCD_SPLY_FACT);
                                                                
                                                            EXCEPTION
                                                                WHEN OTHERS THEN
                                                                   NULL ;
                                                END;
                                        END IF;
                                           
                                        IF V_delivery_date >= V_Next_Working_Day AND V_PLAN_DATETIME IS NOT NULL THEN
                                                BEGIN
                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                             pFACTORY_CD,           pPART_NO,
                                                                             pDIM,                  pUSE_BLOCK_CD,
                                                                             pSUPPLIER_CD,          pCLASS,
                                                                             pRATIO,
                                                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                             V_delivery_date,       V_delivery_Time,
                                                                             REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                             pLogic,                pCD_SPLY_FACT);
                                                                
                                                            EXCEPTION
                                                                WHEN OTHERS THEN
                                                                   NULL ;
                                                END;
                                        ELSIF V_delivery_date < V_Next_Working_Day AND V_PLAN_DATETIME IS NOT NULL THEN
                                                BEGIN
                                                    PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                             pFACTORY_CD,           pPART_NO,
                                                                             pDIM,                  pUSE_BLOCK_CD,
                                                                             pSUPPLIER_CD,          pCLASS,
                                                                             pRATIO,
                                                                             REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                             V_delivery_date,       V_delivery_Time,
                                                                             REC1.PLAN_QTY_REF_LOT, 'WF0018',
                                                                             pLogic,                pCD_SPLY_FACT);
                                                                
                                                            EXCEPTION
                                                                WHEN OTHERS THEN
                                                                   NULL ;
                                                END;                        
                                        END IF;
                                    END;
                                    
                                ELSIF (V_CombiDay BETWEEN '2' AND '9') OR (V_CombiDay = 'W' OR   V_CombiDay = 'M') THEN
                                    BEGIN
                                        
                                        -- 2.3.1.1) Set Initial
                                                V_delivery_date := V_MIN_DT_DELV;
                                                VChk_Flg := 'Y';
                                                --V_delivery_Time := REC2.PLAN_TIME;
                                                
                                        IF V_CombiDay = 'W' THEN
                                            V_Num_Day_Slide := 7;
                                        ELSIF V_CombiDay = 'M' THEN
                                            V_Num_Day_Slide := 30;
                                        END IF;
                                                    
                                        IF V_delivery_date = REC1.PLAN_DATE THEN
                                        BEGIN
                                            BEGIN
                                                SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                        From V_DO_WORKING_DAY 
                                                                        UNION
                                                                        SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                        From V_DO_WORKING_DAY)
                                                          WHERE MK_WORK = 'Y' 
                                                          ) A
                                                JOIN V_PRD_DO_DELIVERY_MASTER B
                                                ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                WHERE FACTORY_CD = pFACTORY_CD
                                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC1.PLAN_TIME
                                                    AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                    AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                (
                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                 UNION
                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                              
                                                                                )C )
                                                ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                
                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                V_PLAN_DATETIME := NULL;       
                                            END;
                                            
                                            IF V_PLAN_DATETIME IS NOT NULL THEN
                                                V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                                
                                            ELSE 
                                                BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,           pPART_NO,
                                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,          pCLASS,
                                                                                 pRATIO,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0019',
                                                                                 pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                            END IF;
                                               
                                            IF V_delivery_date >= V_Next_Working_Day AND V_PLAN_DATETIME IS NOT NULL  THEN
                                                    BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,           pPART_NO,
                                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,          pCLASS,
                                                                                 pRATIO,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 V_delivery_date,       V_delivery_Time,
                                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                 pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                            ELSIF V_delivery_date < V_Next_Working_Day AND V_PLAN_DATETIME IS NOT NULL THEN
                                                    BEGIN
                                                        PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                 pFACTORY_CD,           pPART_NO,
                                                                                 pDIM,                  pUSE_BLOCK_CD,
                                                                                 pSUPPLIER_CD,          pCLASS,
                                                                                 pRATIO,
                                                                                 REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                 V_delivery_date,       V_delivery_Time,
                                                                                 REC1.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                 pLogic,                pCD_SPLY_FACT);
                                                                    
                                                                EXCEPTION
                                                                    WHEN OTHERS THEN
                                                                       NULL ;
                                                    END;
                                            
                                            END IF;
                                        END;
                                                
                                        ELSIF V_delivery_date <> REC1.PLAN_DATE THEN
                                            BEGIN
                                                -- 2.3.1.2) WHILE LOOP (Delivery_date||V_delivery_Time > Plan_date||Plan_Time)      
                                                WHILE (V_delivery_date||V_delivery_Time > REC1.PLAN_DATE||REC1.PLAN_TIME OR VChk_Flg ='N') 
                                                LOOP
                                                
                                                    --(V_CombiDay BETWEEN '2' AND '9') OR (V_CombiDay = 'W' OR   V_CombiDay = 'M')
                                                    IF V_CombiDay BETWEEN '2' AND '9' THEN
                                                        BEGIN                            
                                                                SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                                FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                                        WHERE MK_WORK = 'Y'
                                                                        AND DT_WORK < V_delivery_date
                                                                        ORDER BY DT_WORK DESC )
                                                                WHERE ROWNUM <= V_CombiDay;
                                                                
                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                V_delivery_date := NULL;   
                                                        END;
                                                    ELSIF V_CombiDay = 'W' OR   V_CombiDay = 'M' THEN                                            
                                                        BEGIN                            
                                                                SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                                FROM( SELECT * FROM WBGZT051@FROM_EUC_NPIS
                                                                        WHERE DT_WORK < V_delivery_date
                                                                        ORDER BY DT_WORK DESC )
                                                                WHERE ROWNUM <= V_Num_Day_Slide;
                                                                
                                                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                                                V_delivery_date := NULL;         
                                                        END;
                                                    END IF;                                        
                                                    
                                                    IF VChk_Flg = 'N' THEN
                                                        BEGIN
                                                            SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                    From V_DO_WORKING_DAY 
                                                                                    UNION
                                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                    From V_DO_WORKING_DAY)
                                                                      WHERE MK_WORK = 'Y' 
                                                                      ) A
                                                            JOIN V_PRD_DO_DELIVERY_MASTER B
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                            WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||'9999'
                                                                AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                 AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                            ( 
                                                                                              SELECT  DT_WORK||'0000' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                 UNION
                                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                                FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                              
                                                                                            )C )
                                                            ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                            
                                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                            V_PLAN_DATETIME := NULL;       
                                                        END;
                                                        
                                                    ELSIF VChk_Flg = 'Y' THEN
                                                        BEGIN
                                                            SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                    From V_DO_WORKING_DAY 
                                                                                    UNION
                                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                    From V_DO_WORKING_DAY)
                                                                      WHERE MK_WORK = 'Y' 
                                                                      ) A
                                                            JOIN V_PRD_DO_DELIVERY_MASTER B
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                            WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC1.PLAN_TIME
                                                                AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                                ( 
                                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0100' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                     UNION
                                                                                                    SELECT  DT_WORK||'0200' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0300' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0400' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0500' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0600' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0700' AS HOL
                                                                                                    FROM WBGZT051@FROM_EUC_NPIS 
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(SYSDATE-2,'YYYYMMDD') AND TO_CHAR(SYSDATE+14,'YYYYMMDD')
                                                                                                  
                                                                                                )C )
                                                            ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                            
                                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                            V_PLAN_DATETIME := NULL;       
                                                        END;
                                                    END IF;
                                                    
                                                    IF V_PLAN_DATETIME IS NOT NULL THEN
                                                        V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                        V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                                        VChk_Flg := 'Y';
                                                    ELSE
                                                    
                                                        BEGIN
                                                            IF V_delivery_date||REC1.PLAN_TIME <= REC1.PLAN_DATE||REC1.PLAN_TIME THEN
                                                                V_delivery_date := V_delivery_date;
                                                                VChk_Flg := 'N';
                                                            ELSIF V_delivery_date||REC1.PLAN_TIME > REC1.PLAN_DATE||REC1.PLAN_TIME THEN
                                                                V_delivery_date := V_delivery_date;
                                                                VChk_Flg := 'Y';
                                                            END IF;
                                                        END;
                                                        
                                                    END IF;
                                                END LOOP;
                                                
                                                IF V_delivery_date >= V_Next_Working_Day  THEN
                                                        BEGIN
                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                     pFACTORY_CD,           pPART_NO,
                                                                                     pDIM,                  pUSE_BLOCK_CD,
                                                                                     pSUPPLIER_CD,          pCLASS,
                                                                                     pRATIO,
                                                                                     REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                     V_delivery_date,       V_delivery_Time,
                                                                                     REC1.PLAN_QTY_REF_LOT, 'WF0000',
                                                                                     pLogic,                pCD_SPLY_FACT);
                                                                        
                                                                    EXCEPTION
                                                                        WHEN OTHERS THEN
                                                                           NULL ;
                                                        END;
                                                ELSE
                                                        BEGIN
                                                            PG_PRD_DO_CALCULATION.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                                                     pFACTORY_CD,           pPART_NO,
                                                                                     pDIM,                  pUSE_BLOCK_CD,
                                                                                     pSUPPLIER_CD,          pCLASS,
                                                                                     pRATIO,
                                                                                     REC1.PLAN_DATE,        REC1.PLAN_TIME,
                                                                                     V_delivery_date,       V_delivery_Time,
                                                                                     REC1.PLAN_QTY_REF_LOT, 'WF0018',
                                                                                     pLogic,                pCD_SPLY_FACT);
                                                                        
                                                                    EXCEPTION
                                                                        WHEN OTHERS THEN
                                                                           NULL ;
                                                        END;
                                                
                                                END IF;   
                                            END;
                                        END IF;-- V_delivery_date = REC2.PLAN_DATE                    
                                    END;
                                
                                END IF;--V_MIN_DT_DELV IS NULL
                            END;
                            END IF;-- V_NM_KEY_TABLE IS NULL
                    END;
                    END LOOP; -- END LOOP CUR 1
                    CLOSE C1; 
                    
    END IF ;
    COMMIT;
    
    -- Calling PG  P_PRD_DO_PLAN_REF_DEL_DATE
    PG_PRD_DO_CALCULATION_MULTI_RATE.PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE( 
                                                                 pFACTORY_CD,       pPART_NO,
                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,      pCLASS,
                                                                  pRATIO,           pLogic,
                                                                  pNEXT_DEL,  pFLG);
    
    
    -- Calling PG  P_PRD_DO_PLAN_REF_DEL_DATE
    PG_PRD_DO_CALCULATION_MULTI_RATE.P_PRD_DO_ISSUE_DO_MULTI_RATE( 
                                                                 pFACTORY_CD,       pPART_NO,
                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,      pCLASS,
                                                                 pRATIO,            pNEXT_DEL, 
                                                                 pLogic,            pCD_SPLY_FACT,
                                                                 pSUM_QTY_DO);
    
END P_PRD_DO_PLAN_REF_DEL_DATE;
15.4.1.1
  PROCEDURE P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pUSE_BLOCK_CD  VARCHAR2,
                                                    pSUPPLIER_CD   VARCHAR2,                                                    
                                                    pCLASS         VARCHAR2,
                                                    pRATIO         VARCHAR2,
                                                    pPLAN_DATE     VARCHAR2,
                                                    pPLAN_TIME     VARCHAR2,
                                                    pPLAN_DATE_REF_DEL_DATE  VARCHAR2,
                                                    pPLAN_TIME_REF_DEL_ROUND  VARCHAR2,
                                                    pPLAN_QTY      VARCHAR2,
                                                    pCOMMENT_MSG   VARCHAR2,
                                                    pLogic         VARCHAR2,
                                                    pCD_SPLY_FACT  VARCHAR2) AS
BEGIN

    BEGIN
        INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE
                                    (FACTORY_CD,
                                    PART_NO,
                                    DIM,
                                    USE_BLOCK_CD,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    PLAN_DATE,
                                    PLAN_TIME,
                                    PLAN_DATE_REF_DEL_DATE,
                                    PLAN_TIME_REF_DEL_ROUND,
                                    PLAN_QTY,
                                    COMMENT_MSG,
                                    CREATE_DATE,
                                    LOGIC,
                                    CD_SPLY_FACT)
                            VALUES (pFACTORY_CD,
                                    pPART_NO,
                                    pDIM,
                                    pUSE_BLOCK_CD,
                                    pSUPPLIER_CD,
                                    pRATIO,
                                    pCLASS,
                                    pPLAN_DATE,
                                    pPLAN_TIME,
                                    pPLAN_DATE_REF_DEL_DATE, 
                                    pPLAN_TIME_REF_DEL_ROUND,
                                    pPLAN_QTY,
                                    pCOMMENT_MSG,
                                    SYSDATE,
                                    pLogic,
                                    pCD_SPLY_FACT);
                        COMMIT;
                        EXCEPTION
                        WHEN OTHERS THEN
                           NULL ;
    END;
END P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS; 
15.4.1.2
PROCEDURE P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN (pFACTORY_CD      VARCHAR2,
                                                    pPART_NO       VARCHAR2,
                                                    pDIM           VARCHAR2,
                                                    pSUPPLIER_CD   VARCHAR2, 
                                                    pNEXT_PLANDATE VARCHAR2,
                                                    pPLAN_DATE     VARCHAR2,
                                                    pPLAN_TIME     VARCHAR2,
                                                    pNEXT_DEL      VARCHAR2,
                                                    pCD_SPLY_FACT   VARCHAR2,
                                                    pPLAN_DATE_SLIDE     OUT VARCHAR2,
                                                    pPLAN_TIME_SLIDE     OUT VARCHAR2) AS         
                                                    
CURSOR C3 IS SELECT * FROM V_DO_DELEVERY_DAY_OF_WEEK A
                JOIN V_DO_WORKING_DAY B
                ON UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_START||'%'
                OR UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_END||'%'
                WHERE B.MK_WORK = 'Y'
                AND B.START_TIME >= pNEXT_DEL||'0800'                
                AND B.END_TIME <= pNEXT_PLANDATE||'0700'
                AND A.NO_PARTS = pPART_NO
                AND A.NO_ADJ_DIM = pDIM
                ORDER BY END_TIME DESC;
REC3		C3%rowtype;
CNT    VARCHAR2(5) := 0 ; 
BEGIN
--Set Initial
pPLAN_DATE_SLIDE := NULL;
pPLAN_TIME_SLIDE := NULL;

-- 1.3)  Open CUR 3
    OPEN C3;
    LOOP
    FETCH C3 INTO REC3;
    EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
    BEGIN
    
    --Date modify 11-Mar-2022 :  by Alisa 
    SELECT COUNT(*) INTO CNT FROM WBGZT051@FROM_EUC_NPIS 
    WHERE MK_WORK = 'Y' 
    AND DT_WORK = SUBSTR(REC3.END_TIME,0,8);
    

    
        IF ( UPPER(REC3.NM_KEY_TABLE) LIKE '%'||REC3.DATE_END||'%' ) AND CNT > 0 THEN 
        
                pPLAN_DATE_SLIDE := SUBSTR(REC3.END_TIME,0,8);
                
                IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0000' AND '0700'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                
                ELSIF  pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0000' AND '0700'
                                    AND TIME_ETA < pPLAN_TIME
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                END IF;
                
         
        ELSE 
        
            pPLAN_DATE_SLIDE := null;  
            pPLAN_TIME_SLIDE := null;   
        
        
        END IF ;
                 
        IF ( UPPER(REC3.NM_KEY_TABLE) LIKE '%'||REC3.DATE_START||'%' ) AND pPLAN_DATE_SLIDE IS NULL AND pPLAN_TIME_SLIDE IS NULL  THEN 
                
                pPLAN_DATE_SLIDE := SUBSTR(REC3.START_TIME,0,8);
                
                IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME)  THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0800' AND '2300'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                ELSIF pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||pPLAN_TIME_SLIDE <= pPLAN_DATE||pPLAN_TIME) THEN
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0800' AND '2300'
                                    AND TIME_ETA < pPLAN_TIME
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                END IF;
                
        ELSE
            pPLAN_DATE_SLIDE := null;  
            pPLAN_TIME_SLIDE := null;   
                
        END IF;        
        
        IF pPLAN_DATE_SLIDE IS NOT NULL AND pPLAN_TIME_SLIDE IS NOT NULL THEN
            GOTO OUT_OF_CUR3;
        END IF;
    
    END;
    END LOOP; -- END LOOP CUR 3
    
    << OUT_OF_CUR3>>
    CLOSE C3;

END P_PRD_DO_PLAN_REF_DEL_DATE_FIND_PLAN;

15.4.1.3
PROCEDURE PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE AS
vNEXT_WORKING_DATE      VARCHAR2(8 BYTE);
vNEXT2_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT3_WORKING_DATE     VARCHAR2(8 BYTE);
vNEXT_DEL               VARCHAR2(8 BYTE);
vNEXT_NEXT_DEL          VARCHAR2(8 BYTE);
vFirst_round            VARCHAR2(4 BYTE);

CURSOR C0 IS SELECT DISTINCT LOGIC FROM T_DO_PLAN_REF_DELIVERY_DATE WHERE RATIO = 100 AND COMMENT_MSG =  'WF0018';

REC0		C0%rowtype;

CURSOR C1 IS SELECT DISTINCT FACTORY_CD ,SUPPLIER_CD,CD_SPLY_FACT
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE = vNEXT_DEL
                AND LOGIC = REC0.LOGIC
                AND RATIO = 100
                AND PLAN_QTY > 0
                AND COMMENT_MSG =  'WF0018';

REC1		C1%rowtype;


BEGIN

-- 0.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > TO_CHAR(sysdate,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM WBGZT051@FROM_EUC_NPIS
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

-- 2.)  Open CUR 0
OPEN C0;
LOOP
FETCH C0 INTO REC0;
EXIT WHEN C0%NOTFOUND OR C0%NOTFOUND IS NULL;
BEGIN

        -- 2.1)Set value  vNEXT_DEL  
        IF REC0.LOGIC = '1' THEN
            BEGIN
                vNEXT_DEL := vNEXT_WORKING_DATE;
            END;
            
        ELSIF REC0.LOGIC = '2' THEN
            BEGIN
                vNEXT_DEL := vNEXT2_WORKING_DATE;
            END;
            
        ELSIF REC0.LOGIC = '3' THEN
            BEGIN
                vNEXT_DEL := vNEXT3_WORKING_DATE;
            END;
        END IF;
        
        -- 2.1.1)  Open CUR 1
        OPEN C1;
        LOOP
        FETCH C1 INTO REC1;
        EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
        BEGIN
        
            BEGIN
                -- 2.1.2)Get Find first delivery round on Delivery master
                SELECT MIN(TIME_ETA) INTO vFirst_round
                FROM V_PRD_DO_DELIVERY_MASTER
                WHERE FACTORY_CD  = REC1.FACTORY_CD
                AND SUPPLIER_CD  = REC1.SUPPLIER_CD
                AND TIME_ETA BETWEEN '0800' AND '2300'
                AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                
                EXCEPTION WHEN NO_DATA_FOUND THEN           
                    vFirst_round := NULL; 
            END;
            
            -- 1.1)IF vFirst_round is not null
            IF vFirst_round IS NOT NULL THEN
                BEGIN
                
                    INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE 
                    SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                            vNEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',SYSDATE,LOGIC,CD_SPLY_FACT 
                    FROM T_DO_PLAN_REF_DELIVERY_DATE
                    WHERE PLAN_DATE = vNEXT_DEL
                    AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                    AND LOGIC = REC0.LOGIC
                    AND RATIO = 100
                    AND PLAN_QTY > 0
                    AND FACTORY_CD = REC1.FACTORY_CD
                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                    AND COMMENT_MSG =  'WF0018' 
                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                
                END;
            -- 2.1) IF vFirst_round is not null    
            ELSIF vFirst_round IS NULL THEN            
                BEGIN
                    BEGIN
                    
                        SELECT MIN(DT_WORK) INTO vNEXT_NEXT_DEL
                        FROM WBGZT051@FROM_EUC_NPIS
                        WHERE DT_WORK > vNEXT_DEL
                        AND MK_WORK = 'Y';                    
                    
                    END;
                    
                    BEGIN
                    
                        INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE 
                        SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                                vNEXT_NEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',SYSDATE,LOGIC,CD_SPLY_FACT 
                        FROM T_DO_PLAN_REF_DELIVERY_DATE
                        WHERE PLAN_DATE||PLAN_TIME BETWEEN vNEXT_DEL||'0800' AND vNEXT_NEXT_DEL||vFirst_round
                        AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                        AND LOGIC = REC0.LOGIC
                        AND RATIO = 100
                        AND PLAN_QTY > 0
                        AND FACTORY_CD = REC1.FACTORY_CD
                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                        AND COMMENT_MSG =  'WF0018' ;               
                    
                    END;
                
                
                
                END;            
            END IF;
        
        END;
        END LOOP; -- END LOOP CUR 1
        CLOSE C1;

END;
END LOOP; -- END LOOP CUR 0
CLOSE C0;
COMMIT ;


END PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE;
15.4.1.4
PROCEDURE P_PRD_DO_ISSUE_DO_MULTI_RATE(pFACTORY_CD      VARCHAR2,
                                            pPART_NO       VARCHAR2,
                                            pDIM           VARCHAR2,
                                            pUSE_BLOCK_CD  VARCHAR2,
                                            pSUPPLIER_CD   VARCHAR2,                                                    
                                            pCLASS         VARCHAR2,
                                            pRATIO         VARCHAR2,
                                            pNEXT_DEL      VARCHAR2,
                                            pLOGIC          VARCHAR2,
                                            pCD_SPLY_FACT   VARCHAR2,
                                            pSUM_QTY_DO    OUT NUMBER) AS
                                            
CURSOR C1 IS SELECT *
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_QTY > 0
                AND COMMENT_MSG <> 'WF0000'
                AND FACTORY_CD = pFACTORY_CD	
                AND PART_NO	= pPART_NO
                AND DIM	= pDIM
                AND SUPPLIER_CD = pSUPPLIER_CD
                AND CLASS = pCLASS
                AND RATIO = pRATIO
                AND LOGIC = pLOGIC
                AND PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN  pNEXT_DEL||'0800'  
                                                                    AND (SELECT TO_CHAR(TO_DATE(NEXT_WORKING_DAY,'YYYYMMDD')+1,'YYYYMMDD')
                                                                        FROM (  SELECT MIN(DT_WORK) AS NEXT_WORKING_DAY FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'Y' AND DT_WORK > pNEXT_DEL
                                                                              ))||'0759';
REC1		C1%rowtype;


CURSOR C3 IS SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN  pNEXT_DEL||'0800'  
                                                                    AND (SELECT TO_CHAR(TO_DATE(NEXT_WORKING_DAY,'YYYYMMDD')+1,'YYYYMMDD')
                                                                        FROM (  SELECT MIN(DT_WORK) AS NEXT_WORKING_DAY FROM WBGZT051@FROM_EUC_NPIS 
                                                                                WHERE MK_WORK = 'Y' AND DT_WORK > pNEXT_DEL
                                                                              ))||'0759'              
                    AND PLAN_QTY > 0
                    AND FACTORY_CD = pFACTORY_CD	
                    AND PART_NO	= pPART_NO
                    AND DIM	= pDIM
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND CLASS = pCLASS
                    AND COMMENT_MSG = 'WF0000'
                    AND LOGIC = pLOGIC
                    AND RATIO = pRATIO
                    AND CD_SPLY_FACT = pCD_SPLY_FACT
                GROUP BY FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,PLAN_DATE,PLAN_TIME  
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND;
REC3		C3%rowtype;

V_ROW_CNT               NUMBER(4);
V_QT_BAL_PLAN           NUMBER(12);
V_QT_BAL_PO             NUMBER(12);
V_MIN_ROW_NUM           VARCHAR2(12 BYTE); 
v_DLV_KEY_NO            VARCHAR2(31 BYTE); 
v_QT_DELV_DIRCT_BAL     VARCHAR2(12 BYTE);
v_CD_DELV_PLACE         VARCHAR2(12 BYTE);
vFLG_IN_HOUSE           VARCHAR2(10) := NULL;
V_MIN_DT_DELV           VARCHAR2(8 BYTE);

BEGIN

-- #Case Result is error
-- 2.)  Open CUR 1
OPEN C1;
LOOP
FETCH C1 INTO REC1;
EXIT WHEN C1%NOTFOUND OR C1%NOTFOUND IS NULL;
BEGIN
    INSERT INTO T_PRD_DO_RESULT
                                    (FACTORY_CD,
                                        DELIVERY_DATE,
                                        DELIVERY_TIME,
                                        DELIVERY_ORDER,
                                        BLOCK_CD,
                                        RESULT,
                                        UPDATE_DATE,
                                        PLAN_DATE,
                                        PLAN_TIME,
                                        PART_NO,
                                        DIM,
                                        SUPPLIER_CD,
                                        RATIO,
                                        CLASS,
                                        LOGIC,
                                        CD_SPLY_FACT)
                            VALUES (REC1.FACTORY_CD,
                                    REC1.PLAN_DATE_REF_DEL_DATE,
                                    REC1.PLAN_TIME_REF_DEL_ROUND,
                                    REC1.PLAN_QTY,
                                    REC1.USE_BLOCK_CD,
                                    REC1.COMMENT_MSG,
                                    SYSDATE,
                                    REC1.PLAN_DATE,
                                    REC1.PLAN_TIME,
                                    REC1.PART_NO,
                                    REC1.DIM,
                                    REC1.SUPPLIER_CD,
                                    REC1.RATIO,
                                    REC1.CLASS,
                                    pLOGIC,
                                    pCD_SPLY_FACT);        
                                    COMMIT;  
                        EXCEPTION
                        WHEN OTHERS THEN
                           NULL ;
END;
END LOOP; -- END LOOP CUR 1
CLOSE C1;
COMMIT ;

--#Case Result is OK

                BEGIN            
                SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                FROM T_PRD_DO_DELIVERY_MASTER
                    WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD IN (
                     SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD FROM T_PRD_DO_DELIVERY_MASTER 
                     WHERE  FACTORY_CD = pFACTORY_CD
                     AND SUPPLIER_CD = pSUPPLIER_CD
                     AND EFFECT_STA_DATE <= pNEXT_DEL
                     GROUP BY FACTORY_CD,SUPPLIER_CD);
                    
 
                EXCEPTION WHEN NO_DATA_FOUND THEN           
            
            
                        vFLG_IN_HOUSE := NULL; 
                        
                END;

IF vFLG_IN_HOUSE = 'Y' THEN


                        OPEN C3;
                        LOOP
                        FETCH C3 INTO REC3;
                        EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
                        BEGIN
                        
                        
                                                INSERT INTO T_PRD_DO_RESULT
                                                            (FACTORY_CD,
                                                                DELIVERY_KEY,
                                                                DELIVERY_DATE,
                                                                DELIVERY_TIME,
                                                                DELIVERY_ORDER,
                                                                BLOCK_CD,
                                                                DELIVERY_LOCATION,
                                                                RESULT,
                                                                UPDATE_DATE,
                                                                PLAN_DATE,
                                                                PLAN_TIME,
                                                                PART_NO,
                                                                DIM,
                                                                SUPPLIER_CD,
                                                                RATIO,
                                                                CLASS,
                                                                LOGIC,
                                                                CD_SPLY_FACT)
                                                    VALUES (pFACTORY_CD,
                                                            NULL,
                                                            REC3.PLAN_DATE_REF_DEL_DATE,
                                                            REC3.PLAN_TIME_REF_DEL_ROUND,
                                                            REC3.PLAN_QTY,
                                                            pUSE_BLOCK_CD,
                                                            NULL,
                                                            'WF0000',
                                                            SYSDATE,
                                                            REC3.PLAN_DATE,
                                                            REC3.PLAN_TIME,
                                                            pPART_NO,
                                                            pDIM,
                                                            pSUPPLIER_CD,
                                                            pRATIO,
                                                            pCLASS,
                                                            pLOGIC,
                                                            pCD_SPLY_FACT);
                                                COMMIT;
                                                EXCEPTION
                                                WHEN OTHERS THEN
                                                   NULL ;
                                
                        END;
                        END LOOP; -- END LOOP CUR 3
                        CLOSE C3; 
 
ELSE 
 
                        



--Set Initial Data
V_ROW_CNT := 0;
V_QT_BAL_PLAN := NULL;
V_QT_BAL_PO := 0;
-- 2.)  Open CUR 3
OPEN C3;
LOOP
FETCH C3 INTO REC3;
EXIT WHEN C3%NOTFOUND OR C3%NOTFOUND IS NULL;
BEGIN



            
        V_MIN_DT_DELV := '00000000';
     --Set Initial Data 
     V_QT_BAL_PLAN := REC3.PLAN_QTY;
     

    WHILE V_QT_BAL_PLAN > 0 AND ( V_MIN_DT_DELV <= REC3.PLAN_DATE )
     LOOP
        IF V_QT_BAL_PO = 0 THEN
            BEGIN
                PG_PRD_DO_CALCULATION.P_PRD_DO_GET_DLV_KEY_NO( pFACTORY_CD,
                                         pPART_NO,          pDIM,              
                                         pUSE_BLOCK_CD,     pSUPPLIER_CD,
                                         V_ROW_CNT,         pNEXT_DEL,    
                                         V_MIN_ROW_NUM,
                                         v_DLV_KEY_NO,          V_QT_BAL_PO,
                                         v_CD_DELV_PLACE ,V_MIN_DT_DELV);
                            
                        EXCEPTION
                            WHEN OTHERS THEN
                               NULL ;
            END;
            
               IF ( V_MIN_DT_DELV > REC3.PLAN_DATE  )THEN
                        V_QT_BAL_PO := 0;
                        
                   BEGIN
                    INSERT INTO T_PRD_DO_RESULT
                                (FACTORY_CD,
                                    DELIVERY_DATE,
                                    DELIVERY_TIME,
                                    DELIVERY_ORDER,
                                    BLOCK_CD,
                                    RESULT,
                                    UPDATE_DATE,
                                    PLAN_DATE,
                                    PLAN_TIME,
                                    PART_NO,
                                    DIM,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    LOGIC,
                                    CD_SPLY_FACT)
                        VALUES (pFACTORY_CD,
                                REC3.PLAN_DATE_REF_DEL_DATE,
                                REC3.PLAN_TIME_REF_DEL_ROUND,
                                V_QT_BAL_PLAN,
                                pUSE_BLOCK_CD,
                                'WF0020',
                                SYSDATE,
                                REC3.PLAN_DATE,
                                REC3.PLAN_TIME,
                                pPART_NO,
                                pDIM,
                                pSUPPLIER_CD,
                                pRATIO,
                                pCLASS,
                                pLOGIC,
                                pCD_SPLY_FACT);
                    COMMIT;
                    EXCEPTION
                    WHEN OTHERS THEN
                       NULL ;
                END;
                
            END IF;
            
        ELSIF V_QT_BAL_PO > 0 THEN
            BEGIN
                IF V_QT_BAL_PLAN > V_QT_BAL_PO THEN
                    BEGIN
                        BEGIN
                            INSERT INTO T_PRD_DO_RESULT
                                        (FACTORY_CD,
                                            DELIVERY_KEY,
                                            DELIVERY_DATE,
                                            DELIVERY_TIME,
                                            DELIVERY_ORDER,
                                            BLOCK_CD,
                                            DELIVERY_LOCATION,
                                            RESULT,
                                            UPDATE_DATE,
                                            PLAN_DATE,
                                            PLAN_TIME,
                                            PART_NO,
                                            DIM,
                                            SUPPLIER_CD,
                                            RATIO,
                                            CLASS,
                                            LOGIC,
                                            CD_SPLY_FACT)
                                VALUES (pFACTORY_CD,
                                        v_DLV_KEY_NO,
                                        REC3.PLAN_DATE_REF_DEL_DATE,
                                        REC3.PLAN_TIME_REF_DEL_ROUND,
                                        V_QT_BAL_PO,
                                        pUSE_BLOCK_CD,
                                        v_CD_DELV_PLACE,
                                        'WF0000',
                                        SYSDATE,
                                        REC3.PLAN_DATE,
                                        REC3.PLAN_TIME,
                                        pPART_NO,
                                        pDIM,
                                        pSUPPLIER_CD,
                                        pRATIO,
                                        pCLASS,
                                        pLOGIC,
                                        pCD_SPLY_FACT);
                            COMMIT;
                            EXCEPTION
                            WHEN OTHERS THEN
                               NULL ;
                        END;
                        --Set Value
                        V_QT_BAL_PLAN := V_QT_BAL_PLAN - V_QT_BAL_PO;
                        V_QT_BAL_PO := 0;
                        V_ROW_CNT := V_MIN_ROW_NUM;
                        
                    END;
                
                ELSIF  V_QT_BAL_PLAN <= V_QT_BAL_PO THEN
                    BEGIN
                        BEGIN
                            INSERT INTO T_PRD_DO_RESULT
                                        (FACTORY_CD,
                                            DELIVERY_KEY,
                                            DELIVERY_DATE,
                                            DELIVERY_TIME,
                                            DELIVERY_ORDER,
                                            BLOCK_CD,
                                            DELIVERY_LOCATION,
                                            RESULT,
                                            UPDATE_DATE,
                                            PLAN_DATE,
                                            PLAN_TIME,
                                            PART_NO,
                                            DIM,
                                            SUPPLIER_CD,
                                            RATIO,
                                            CLASS,
                                            LOGIC,
                                            CD_SPLY_FACT)
                                VALUES (pFACTORY_CD,
                                        v_DLV_KEY_NO,
                                        REC3.PLAN_DATE_REF_DEL_DATE,
                                        REC3.PLAN_TIME_REF_DEL_ROUND,
                                        V_QT_BAL_PLAN,
                                        pUSE_BLOCK_CD,
                                        v_CD_DELV_PLACE,
                                        'WF0000',
                                        SYSDATE,
                                        REC3.PLAN_DATE,
                                        REC3.PLAN_TIME,
                                        pPART_NO,
                                        pDIM,
                                        pSUPPLIER_CD,
                                        pRATIO,
                                        pCLASS,
                                        pLOGIC,
                                        pCD_SPLY_FACT);
                            COMMIT;
                            EXCEPTION
                            WHEN OTHERS THEN
                               NULL ;
                        END;
                        --Set Value
                        V_QT_BAL_PO := V_QT_BAL_PO - V_QT_BAL_PLAN;
                        V_QT_BAL_PLAN := 0;
                        V_ROW_CNT := V_MIN_ROW_NUM;
                    END;
                END IF; --V_QT_BAL_PLAN > V_QT_BAL_PO 
                
            END;
        ELSIF V_QT_BAL_PO IS NULL THEN 
            BEGIN
                BEGIN
                    INSERT INTO T_PRD_DO_RESULT
                                (FACTORY_CD,
                                    DELIVERY_DATE,
                                    DELIVERY_TIME,
                                    DELIVERY_ORDER,
                                    BLOCK_CD,
                                    RESULT,
                                    UPDATE_DATE,
                                    PLAN_DATE,
                                    PLAN_TIME,
                                    PART_NO,
                                    DIM,
                                    SUPPLIER_CD,
                                    RATIO,
                                    CLASS,
                                    LOGIC,
                                    CD_SPLY_FACT)
                        VALUES (pFACTORY_CD,
                                REC3.PLAN_DATE_REF_DEL_DATE,
                                REC3.PLAN_TIME_REF_DEL_ROUND,
                                V_QT_BAL_PLAN,
                                pUSE_BLOCK_CD,
                                'WF0020',
                                SYSDATE,
                                REC3.PLAN_DATE,
                                REC3.PLAN_TIME,
                                pPART_NO,
                                pDIM,
                                pSUPPLIER_CD,
                                pRATIO,
                                pCLASS,
                                pLOGIC,
                                pCD_SPLY_FACT);
                    COMMIT;
                    EXCEPTION
                    WHEN OTHERS THEN
                       NULL ;
                END;
                --Set Value
                V_QT_BAL_PO := NULL;
                V_QT_BAL_PLAN := 0;
            END;
        END IF;
     END LOOP;
    
END;
END LOOP; -- END LOOP CUR 3
CLOSE C3;    
END IF ;
COMMIT ;



-- #Summary Qty for return
BEGIN
    SELECT SUM(DELIVERY_ORDER) AS SUM_QTY_DO INTO pSUM_QTY_DO
    FROM T_PRD_DO_RESULT
    WHERE FACTORY_CD = pFACTORY_CD
    AND RESULT = 'WF0000'
    AND BLOCK_CD = pUSE_BLOCK_CD
    AND SUPPLIER_CD = pSUPPLIER_CD
    AND PART_NO = pPART_NO
    AND DIM = pDIM
    AND RATIO = pRATIO
    AND CLASS = pCLASS
    AND LOGIC = pLOGIC
    AND PLAN_DATE||PLAN_TIME >= pNEXT_DEL||'0800';

    

    EXCEPTION WHEN NO_DATA_FOUND THEN
    pSUM_QTY_DO := NULL;  
END;

IF pSUM_QTY_DO IS NULL THEN

    pSUM_QTY_DO := 0 ;

END IF ;

END P_PRD_DO_ISSUE_DO_MULTI_RATE;