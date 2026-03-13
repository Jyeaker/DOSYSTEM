--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dosystem; Type: SCHEMA; Schema: -; Owner: dosystem
--

CREATE SCHEMA dosystem;


ALTER SCHEMA dosystem OWNER TO dosystem;

--
-- Name: p_do_delivery_round_master_del(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_delivery_round_master_del(pfactory character varying, psullier_cd character varying, peffect_date character varying, pvendor_fctry character varying, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
    rec1 RECORD;
BEGIN
    
    -- Loop through records to backup to history
    FOR rec1 IN 
        SELECT a.* 
        FROM dosystem.t_prd_do_delivery_master a 
        WHERE factory_cd = pfactory 
            AND supplier_cd = psullier_cd 
            AND cd_sply_fact = pvendor_fctry 
            AND effect_sta_date LIKE peffect_date
    LOOP
        
        INSERT INTO dosystem.t_prd_do_delivery_master_his (
            type,
            factory_cd,
            supplier_cd,
            effect_sta_date,
            supplier_name,
            time_eta_1,
            time_eta_2,
            time_eta_3,
            time_eta_4,
            time_eta_5,
            time_eta_6,
            time_eta_7,
            time_eta_8,
            time_eta_9,
            time_eta_10,
            time_eta_11,
            time_eta_12,
            time_eta_13,
            time_eta_14,
            time_eta_15,
            time_eta_16,
            time_eta_17,
            time_eta_18,
            time_eta_19,
            time_eta_20,
            time_eta_21,
            time_eta_22,
            time_eta_23,
            time_eta_24,
            flg_in_house,
            create_date,
            create_by,
            update_date,
            update_by,
            history_entry_date,
            history_entry_by,
            cd_sply_fact
        )
        VALUES (
            'DEL',
            rec1.factory_cd,
            rec1.supplier_cd,
            rec1.effect_sta_date,
            rec1.supplier_name,
            rec1.time_eta_1,
            rec1.time_eta_2,
            rec1.time_eta_3,
            rec1.time_eta_4,
            rec1.time_eta_5,
            rec1.time_eta_6,
            rec1.time_eta_7,
            rec1.time_eta_8,
            rec1.time_eta_9,
            rec1.time_eta_10,
            rec1.time_eta_11,
            rec1.time_eta_12,
            rec1.time_eta_13,
            rec1.time_eta_14,
            rec1.time_eta_15,
            rec1.time_eta_16,
            rec1.time_eta_17,
            rec1.time_eta_18,
            rec1.time_eta_19,
            rec1.time_eta_20,
            rec1.time_eta_21,
            rec1.time_eta_22,
            rec1.time_eta_23,
            rec1.time_eta_24,
            rec1.flg_in_house,
            rec1.create_date,
            rec1.create_by,
            rec1.update_date,
            rec1.update_by,
            CURRENT_DATE,
            puser_id,
            pvendor_fctry
        );
        
    END LOOP;
    
    -- Delete from main table
    DELETE FROM dosystem.t_prd_do_delivery_master 
    WHERE factory_cd = pfactory 
        AND supplier_cd = psullier_cd 
        AND cd_sply_fact = pvendor_fctry 
        AND effect_sta_date LIKE peffect_date;
    
    pflag := 1;
    
    RETURN pflag;
    
EXCEPTION
    WHEN OTHERS THEN
        pflag := 0;
        RETURN pflag;
        
END;
$$;


ALTER FUNCTION dosystem.p_do_delivery_round_master_del(pfactory character varying, psullier_cd character varying, peffect_date character varying, pvendor_fctry character varying, puser_id character varying) OWNER TO dosystem;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: t_prd_do_delivery_master; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_delivery_master (
    factory_cd character varying(2) NOT NULL,
    supplier_cd character varying(4) NOT NULL,
    effect_sta_date character varying(8) NOT NULL,
    supplier_name character varying(100),
    time_eta_1 character varying(4),
    time_eta_2 character varying(4),
    time_eta_3 character varying(4),
    time_eta_4 character varying(4),
    time_eta_5 character varying(4),
    time_eta_6 character varying(4),
    time_eta_7 character varying(4),
    time_eta_8 character varying(4),
    time_eta_9 character varying(4),
    time_eta_10 character varying(4),
    time_eta_11 character varying(4),
    time_eta_12 character varying(4),
    time_eta_13 character varying(4),
    time_eta_14 character varying(4),
    time_eta_15 character varying(4),
    time_eta_16 character varying(4),
    time_eta_17 character varying(4),
    time_eta_18 character varying(4),
    time_eta_19 character varying(4),
    time_eta_20 character varying(4),
    time_eta_21 character varying(4),
    time_eta_22 character varying(4),
    time_eta_23 character varying(4),
    time_eta_24 character varying(4),
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    flg_in_house character varying(1),
    cd_sply_fact character varying(2) NOT NULL
);


ALTER TABLE dosystem.t_prd_do_delivery_master OWNER TO dosystem;

--
-- Name: p_do_delivery_round_master_inq(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_delivery_round_master_inq(pfactory character varying, psullier_cd character varying, psullier_name character varying, peffect_date character varying) RETURNS TABLE("like" dosystem.t_prd_do_delivery_master)
    LANGUAGE plpgsql
    AS $$
DECLARE
    wk_select TEXT;
    wk_where TEXT := '';
BEGIN
    
    IF pfactory IS NOT NULL THEN
        wk_where := wk_where || ' AND factory_cd LIKE ' || quote_literal(pfactory);
    END IF;
     
    IF psullier_cd IS NOT NULL THEN          
        wk_where := wk_where || ' AND supplier_cd LIKE ' || quote_literal(psullier_cd);
    END IF;
    
    IF psullier_name IS NOT NULL THEN
        wk_where := wk_where || ' AND supplier_name LIKE ' || quote_literal(psullier_name);
    END IF;
    
    IF peffect_date IS NOT NULL THEN
        wk_where := wk_where || ' AND effect_sta_date LIKE ' || quote_literal(peffect_date);
    END IF;
    
    IF wk_where <> '' THEN
        wk_where := ' WHERE ' || SUBSTR(wk_where, 5);
    END IF;

    wk_select := 'SELECT * FROM dosystem.t_prd_do_delivery_master ' || wk_where || ' ORDER BY update_date DESC';
    
    RETURN QUERY EXECUTE wk_select;
    
END;
$$;


ALTER FUNCTION dosystem.p_do_delivery_round_master_inq(pfactory character varying, psullier_cd character varying, psullier_name character varying, peffect_date character varying) OWNER TO dosystem;

--
-- Name: p_do_delivery_round_master_ins_upd(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_delivery_round_master_ins_upd(pfactory character varying, psullier_cd character varying, psullier_name character varying, peffect_date character varying, pvendor_fctry character varying, puser_id character varying, ptime_eta_1 character varying, ptime_eta_2 character varying, ptime_eta_3 character varying, ptime_eta_4 character varying, ptime_eta_5 character varying, ptime_eta_6 character varying, ptime_eta_7 character varying, ptime_eta_8 character varying, ptime_eta_9 character varying, ptime_eta_10 character varying, ptime_eta_11 character varying, ptime_eta_12 character varying, ptime_eta_13 character varying, ptime_eta_14 character varying, ptime_eta_15 character varying, ptime_eta_16 character varying, ptime_eta_17 character varying, ptime_eta_18 character varying, ptime_eta_19 character varying, ptime_eta_20 character varying, ptime_eta_21 character varying, ptime_eta_22 character varying, ptime_eta_23 character varying, ptime_eta_24 character varying, pflg_in_house character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
BEGIN
    -- Try INSERT first
    BEGIN
        INSERT INTO dosystem.t_prd_do_delivery_master (
            factory_cd,
            supplier_cd,
            effect_sta_date,
            supplier_name,
            time_eta_1,
            time_eta_2,
            time_eta_3,
            time_eta_4,
            time_eta_5,
            time_eta_6,
            time_eta_7,
            time_eta_8,
            time_eta_9,
            time_eta_10,
            time_eta_11,
            time_eta_12,
            time_eta_13,
            time_eta_14,
            time_eta_15,
            time_eta_16,
            time_eta_17,
            time_eta_18,
            time_eta_19,
            time_eta_20,
            time_eta_21,
            time_eta_22,
            time_eta_23,
            time_eta_24,
            flg_in_house,
            create_date,
            create_by,
            update_date,
            update_by,
            cd_sply_fact
        )
        VALUES (
            pfactory,
            psullier_cd,
            peffect_date,
            psullier_name,
            ptime_eta_1,
            ptime_eta_2,
            ptime_eta_3,
            ptime_eta_4,
            ptime_eta_5,
            ptime_eta_6,
            ptime_eta_7,
            ptime_eta_8,
            ptime_eta_9,
            ptime_eta_10,
            ptime_eta_11,
            ptime_eta_12,
            ptime_eta_13,
            ptime_eta_14,
            ptime_eta_15,
            ptime_eta_16,
            ptime_eta_17,
            ptime_eta_18,
            ptime_eta_19,
            ptime_eta_20,
            ptime_eta_21,
            ptime_eta_22,
            ptime_eta_23,
            ptime_eta_24,
            pflg_in_house,
            CURRENT_DATE,
            puser_id,
            CURRENT_DATE,
            puser_id,
            pvendor_fctry
        );
        
        -- Insert history for INSERT
        INSERT INTO dosystem.t_prd_do_delivery_master_his (
            type,
            factory_cd,
            supplier_cd,
            effect_sta_date,
            supplier_name,
            time_eta_1,
            time_eta_2,
            time_eta_3,
            time_eta_4,
            time_eta_5,
            time_eta_6,
            time_eta_7,
            time_eta_8,
            time_eta_9,
            time_eta_10,
            time_eta_11,
            time_eta_12,
            time_eta_13,
            time_eta_14,
            time_eta_15,
            time_eta_16,
            time_eta_17,
            time_eta_18,
            time_eta_19,
            time_eta_20,
            time_eta_21,
            time_eta_22,
            time_eta_23,
            time_eta_24,
            flg_in_house,
            create_date,
            create_by,
            update_date,
            update_by,
            history_entry_date,
            history_entry_by,
            cd_sply_fact
        )
        VALUES (
            'INS',
            pfactory,
            psullier_cd,
            peffect_date,
            psullier_name,
            ptime_eta_1,
            ptime_eta_2,
            ptime_eta_3,
            ptime_eta_4,
            ptime_eta_5,
            ptime_eta_6,
            ptime_eta_7,
            ptime_eta_8,
            ptime_eta_9,
            ptime_eta_10,
            ptime_eta_11,
            ptime_eta_12,
            ptime_eta_13,
            ptime_eta_14,
            ptime_eta_15,
            ptime_eta_16,
            ptime_eta_17,
            ptime_eta_18,
            ptime_eta_19,
            ptime_eta_20,
            ptime_eta_21,
            ptime_eta_22,
            ptime_eta_23,
            ptime_eta_24,
            pflg_in_house,
            CURRENT_DATE,
            puser_id,
            CURRENT_DATE,
            puser_id,
            CURRENT_DATE,
            puser_id,
            pvendor_fctry
        );
        
        pflag := 1;
        
    EXCEPTION
        WHEN unique_violation THEN
            -- Duplicate key - do UPDATE instead
            BEGIN
                -- Insert history for UPDATE
                INSERT INTO dosystem.t_prd_do_delivery_master_his (
                    type,
                    factory_cd,
                    supplier_cd,
                    effect_sta_date,
                    supplier_name,
                    time_eta_1,
                    time_eta_2,
                    time_eta_3,
                    time_eta_4,
                    time_eta_5,
                    time_eta_6,
                    time_eta_7,
                    time_eta_8,
                    time_eta_9,
                    time_eta_10,
                    time_eta_11,
                    time_eta_12,
                    time_eta_13,
                    time_eta_14,
                    time_eta_15,
                    time_eta_16,
                    time_eta_17,
                    time_eta_18,
                    time_eta_19,
                    time_eta_20,
                    time_eta_21,
                    time_eta_22,
                    time_eta_23,
                    time_eta_24,
                    flg_in_house,
                    create_date,
                    create_by,
                    update_date,
                    update_by,
                    history_entry_date,
                    history_entry_by,
                    cd_sply_fact
                )
                SELECT 
                    'UPD',
                    pfactory,
                    psullier_cd,
                    peffect_date,
                    psullier_name,
                    ptime_eta_1,
                    ptime_eta_2,
                    ptime_eta_3,
                    ptime_eta_4,
                    ptime_eta_5,
                    ptime_eta_6,
                    ptime_eta_7,
                    ptime_eta_8,
                    ptime_eta_9,
                    ptime_eta_10,
                    ptime_eta_11,
                    ptime_eta_12,
                    ptime_eta_13,
                    ptime_eta_14,
                    ptime_eta_15,
                    ptime_eta_16,
                    ptime_eta_17,
                    ptime_eta_18,
                    ptime_eta_19,
                    ptime_eta_20,
                    ptime_eta_21,
                    ptime_eta_22,
                    ptime_eta_23,
                    ptime_eta_24,
                    pflg_in_house,
                    CURRENT_DATE,
                    puser_id,
                    CURRENT_DATE,
                    puser_id,
                    CURRENT_DATE,
                    puser_id,
                    pvendor_fctry
                FROM dosystem.t_prd_do_delivery_master
                WHERE factory_cd = pfactory
                    AND supplier_cd = psullier_cd
                    AND effect_sta_date = peffect_date
                    AND cd_sply_fact = pvendor_fctry;
                
                -- Update main table
                UPDATE dosystem.t_prd_do_delivery_master
                SET supplier_name = psullier_name,
                    time_eta_1 = ptime_eta_1,
                    time_eta_2 = ptime_eta_2,
                    time_eta_3 = ptime_eta_3,
                    time_eta_4 = ptime_eta_4,
                    time_eta_5 = ptime_eta_5,
                    time_eta_6 = ptime_eta_6,
                    time_eta_7 = ptime_eta_7,
                    time_eta_8 = ptime_eta_8,
                    time_eta_9 = ptime_eta_9,
                    time_eta_10 = ptime_eta_10,
                    time_eta_11 = ptime_eta_11,
                    time_eta_12 = ptime_eta_12,
                    time_eta_13 = ptime_eta_13,
                    time_eta_14 = ptime_eta_14,
                    time_eta_15 = ptime_eta_15,
                    time_eta_16 = ptime_eta_16,
                    time_eta_17 = ptime_eta_17,
                    time_eta_18 = ptime_eta_18,
                    time_eta_19 = ptime_eta_19,
                    time_eta_20 = ptime_eta_20,
                    time_eta_21 = ptime_eta_21,
                    time_eta_22 = ptime_eta_22,
                    time_eta_23 = ptime_eta_23,
                    time_eta_24 = ptime_eta_24,
                    flg_in_house = pflg_in_house,
                    update_by = puser_id,
                    update_date = CURRENT_DATE
                WHERE factory_cd = pfactory
                    AND supplier_cd = psullier_cd
                    AND effect_sta_date = peffect_date;
                
                pflag := 2;
                
            EXCEPTION
                WHEN OTHERS THEN
                    pflag := 0;
            END;
            
        WHEN OTHERS THEN
            pflag := 0;
    END;
    
    RETURN pflag;
    
END;
$$;


ALTER FUNCTION dosystem.p_do_delivery_round_master_ins_upd(pfactory character varying, psullier_cd character varying, psullier_name character varying, peffect_date character varying, pvendor_fctry character varying, puser_id character varying, ptime_eta_1 character varying, ptime_eta_2 character varying, ptime_eta_3 character varying, ptime_eta_4 character varying, ptime_eta_5 character varying, ptime_eta_6 character varying, ptime_eta_7 character varying, ptime_eta_8 character varying, ptime_eta_9 character varying, ptime_eta_10 character varying, ptime_eta_11 character varying, ptime_eta_12 character varying, ptime_eta_13 character varying, ptime_eta_14 character varying, ptime_eta_15 character varying, ptime_eta_16 character varying, ptime_eta_17 character varying, ptime_eta_18 character varying, ptime_eta_19 character varying, ptime_eta_20 character varying, ptime_eta_21 character varying, ptime_eta_22 character varying, ptime_eta_23 character varying, ptime_eta_24 character varying, pflg_in_house character varying) OWNER TO dosystem;

--
-- Name: p_do_part_master_del(character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_del(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
BEGIN
    
    -- Insert history record before delete
    INSERT INTO dosystem.t_prd_do_part_master_his (
        type,
        factory_cd,
        part_no,
        dim,
        block_cd,
        supplier_cd,
        total_process_lt,
        create_date,
        create_by,
        update_date,
        update_by,
        history_date,
        history_by,
        logic,
        sp_plan_slide
    )
    SELECT 
        'DEL',
        a.factory_cd,
        a.part_no,
        a.dim,
        a.block_cd,
        a.supplier_cd,
        a.total_process_lt,
        a.create_date,
        a.create_by,
        a.update_date,
        a.update_by,
        CURRENT_DATE,
        puser_id,
        a.logic,
        a.sp_plan_slide
    FROM dosystem.t_prd_do_part_master a
    WHERE factory_cd = pfactory_cd
        AND part_no = ppart_no
        AND dim = pdim
        AND block_cd = pblock_cd
        AND supplier_cd = psupplier_cd;
    
    -- Delete from main table
    DELETE FROM dosystem.t_prd_do_part_master 
    WHERE factory_cd = pfactory_cd 
        AND part_no = ppart_no 
        AND dim LIKE pdim 
        AND block_cd = pblock_cd 
        AND supplier_cd = psupplier_cd;
    
    pflag := 1;
    
    RETURN pflag;
    
EXCEPTION
    WHEN OTHERS THEN
        pflag := 0;
        RETURN pflag;
        
END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_del(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, puser_id character varying) OWNER TO dosystem;

--
-- Name: p_do_part_master_inq(character varying, character varying, character varying, character varying, character varying, numeric); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_inq(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, plogic numeric) RETURNS TABLE(factory_cd character varying, part_no character varying, dim character varying, block_cd character varying, supplier_cd character varying, total_process_lt integer, create_date date, create_by character varying, update_date date, update_by character varying, logic smallint, sp_plan_slide smallint, create_date2 text, update_date2 text)
    LANGUAGE plpgsql
    AS $$
DECLARE										 
 
wk_select TEXT ; 
wk_where TEXT := '';
    begin
    
        if pfactory_cd is not null then
        
          wk_where := wk_where||' and a.factory_cd like '||quote_literal(pfactory_cd);
        end if;
         
        if ppart_no is not null then          
          wk_where := wk_where||' and a.part_no like '||quote_literal(ppart_no);
        end if;

        if pdim is not null then
          wk_where := wk_where||' and a.dim like '||quote_literal(pdim);
        end if;
        
        if pblock_cd is not null then
          wk_where := wk_where||' and a.block_cd like '||quote_literal(thenpblock_cd);
        end if;
        
        if psupplier_cd is not null then
          wk_where := wk_where||' and a.supplier_cd like '||quote_literal(psupplier_cd);
        end if;
        
        if plogic is not null then
          wk_where := wk_where||' and a.logic = '||plogic;
        end if;

        if wk_where is not null then
            wk_where :=  ' where '||substr(wk_where,5);
        end if;
    
        wk_select := 'select a.*,(to_char(a.create_date, ''dd/mm/yyyy'')) as create_date2 , (to_char(a.create_date, ''dd/mm/yyyy'')) as update_date2 from  dosystem.t_prd_do_part_master a '||wk_where||' order by update_date2 desc';

   	RETURN QUERY EXECUTE wk_select;
END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_inq(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, plogic numeric) OWNER TO dosystem;

--
-- Name: p_do_part_master_ins(character varying, character varying, character varying, character varying, character varying, smallint, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_ins(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, ptotal_process_lt smallint, pdo_logic smallint, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE										 
 vsp_plan_slide INTEGER ;   
 vlogic INTEGER ;   
 vprocess INTEGER ; 
 pflag INTEGER := 0;
BEGIN	    
	BEGIN 
        select max(sp_plan_slide) into vsp_plan_slide 
        from dosystem.t_prd_do_part_master 
        where factory_cd = pfactory_cd ;

	EXCEPTION
        WHEN OTHERS THEN        
             vsp_plan_slide := 0 ;            
	END ;

	begin 
        select coalesce(max(logic),pdo_logic)
		into vlogic
        from dosystem.t_prd_do_part_master 
        where factory_cd = pfactory_cd
        and  part_no = ppart_no
        and  dim = pdim;       
	end ;
	
	begin 
	    select coalesce(max(total_process_lt), ptotal_process_lt)
	    into vprocess
        from dosystem.t_prd_do_part_master 
        where factory_cd = pfactory_cd
        and  part_no = ppart_no
        and  dim = pdim;	           
	end ;
	
	if vlogic is null then 
	        vlogic := pdo_logic ;
	end if ;
	
	if vprocess is null then 
	        vprocess := ptotal_process_lt ;
	end if ;

	insert into dosystem.t_prd_do_part_master    (factory_cd,
                                            part_no,
                                            dim,
                                            block_cd,
                                            supplier_cd,
                                            total_process_lt,
                                            logic,
                                            sp_plan_slide,
                                            create_date,
                                            create_by,
                                            update_date,
                                            update_by)
                                    values (pfactory_cd,
                                            ppart_no,
                                            pdim,
                                            pblock_cd,
                                            psupplier_cd,
                                            vprocess,
                                            vlogic,
                                            vsp_plan_slide,
                                            CURRENT_DATE,
                                            puser_id,
                                            CURRENT_DATE,
                                            puser_id); 
											
    insert into dosystem.t_prd_do_part_master_his    (type,
                                                factory_cd,
                                                part_no,
                                                dim,
                                                block_cd,
                                                supplier_cd,
                                                total_process_lt,
                                                create_date,
                                                create_by,
                                                update_date,
                                                update_by,
                                                history_date,
                                                history_by,
                                                logic,
                                                sp_plan_slide)
                                            values ('INS',
                                                    pfactory_cd,
                                                    ppart_no,
                                                    pdim,
                                                    pblock_cd,
                                                    psupplier_cd,
                                                    vprocess,
                                                    CURRENT_DATE,
                                                    puser_id,
                                                    CURRENT_DATE,
                                                    puser_id,
                                                    CURRENT_DATE,
                                                    puser_id,
                                                    vlogic,
                                                    vsp_plan_slide);    	
pflag := 1;  
RETURN pflag;

END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_ins(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, ptotal_process_lt smallint, pdo_logic smallint, puser_id character varying) OWNER TO dosystem;

--
-- Name: p_do_part_master_upd(character varying, character varying, character varying, character varying, character varying, integer, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_upd(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, ptotal_process_lt integer, pdo_logic smallint, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
    vlogic NUMERIC;
    vprocess NUMERIC;
BEGIN
    
    -- Insert history record
    INSERT INTO dosystem.t_prd_do_part_master_his (
        type,
        factory_cd,
        part_no,
        dim,
        block_cd,
        supplier_cd,
        total_process_lt,
        create_date,
        create_by,
        update_date,
        update_by,
        history_date,
        history_by,
        logic,
        sp_plan_slide
    )
    SELECT 
        'UPD',
        a.factory_cd,
        a.part_no,
        a.dim,
        a.block_cd,
        a.supplier_cd,
        a.total_process_lt,
        a.create_date,
        a.create_by,
        a.update_date,
        a.update_by,
        CURRENT_DATE,
        puser_id,
        a.logic,
        a.sp_plan_slide
    FROM dosystem.t_prd_do_part_master a
    WHERE factory_cd = pfactory_cd
        AND part_no = ppart_no
        AND dim = pdim;
   
    -- Update main table
    UPDATE dosystem.t_prd_do_part_master
    SET total_process_lt = ptotal_process_lt,
        logic = pdo_logic,
        update_by = puser_id,
        update_date = CURRENT_DATE
    WHERE factory_cd = pfactory_cd
        AND part_no = ppart_no
        AND dim = pdim;
    
    pflag := 1;
    
    RETURN pflag;
    
EXCEPTION
    WHEN OTHERS THEN
        pflag := 0;
        RETURN pflag;
        
END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_upd(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, ptotal_process_lt integer, pdo_logic smallint, puser_id character varying) OWNER TO dosystem;

--
-- Name: p_do_part_master_upd_logic(character varying, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_upd_logic(pfactory_cd character varying, plogic smallint, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
BEGIN

    -- Insert history records
    INSERT INTO dosystem.t_prd_do_part_master_his (
        type,
        factory_cd,
        part_no,
        dim,
        block_cd,
        supplier_cd,
        total_process_lt,
        create_date,
        create_by,
        update_date,
        update_by,
        history_date,
        history_by,
        logic,
        sp_plan_slide
    )
    SELECT
        'UPD',
        a.factory_cd,
        a.part_no,
        a.dim,
        a.block_cd,
        a.supplier_cd,
        a.total_process_lt,
        a.create_date,
        a.create_by,
        a.update_date,
        a.update_by,
        CURRENT_DATE,
        puser_id,
        a.logic,
        a.sp_plan_slide
    FROM dosystem.t_prd_do_part_master a
    WHERE factory_cd = pfactory_cd;

    -- Update main table
    UPDATE dosystem.t_prd_do_part_master
    SET logic = plogic,
        update_by = puser_id,
        update_date = CURRENT_DATE
    WHERE factory_cd = pfactory_cd;

    pflag := 1;

    RETURN pflag;

EXCEPTION
    WHEN OTHERS THEN
        pflag := 0;
        RETURN pflag;

END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_upd_logic(pfactory_cd character varying, plogic smallint, puser_id character varying) OWNER TO dosystem;

--
-- Name: p_do_part_master_upd_plan_sp(character varying, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_part_master_upd_plan_sp(pfactory_cd character varying, psp_plan_slide smallint, puser_id character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    pflag INTEGER := 0;
BEGIN
    
    -- Insert history records
    INSERT INTO dosystem.t_prd_do_part_master_his (
        type,
        factory_cd,
        part_no,
        dim,
        block_cd,
        supplier_cd,
        total_process_lt,
        create_date,
        create_by,
        update_date,
        update_by,
        history_date,
        history_by,
        logic,
        sp_plan_slide
    )
    SELECT 
        'UPD',
        a.factory_cd,
        a.part_no,
        a.dim,
        a.block_cd,
        a.supplier_cd,
        a.total_process_lt,
        a.create_date,
        a.create_by,
        a.update_date,
        a.update_by,
        CURRENT_DATE,
        puser_id,
        a.logic,
        a.sp_plan_slide
    FROM dosystem.t_prd_do_part_master a
    WHERE factory_cd = pfactory_cd;
       
    -- Update main table
    UPDATE dosystem.t_prd_do_part_master
    SET sp_plan_slide = psp_plan_slide,
        update_by = puser_id,
        update_date = CURRENT_DATE
    WHERE factory_cd = pfactory_cd;
      
    pflag := 1;
    
    RETURN pflag;
    
EXCEPTION
    WHEN OTHERS THEN
        pflag := 0;
        RETURN pflag;
        
END;
$$;


ALTER FUNCTION dosystem.p_do_part_master_upd_plan_sp(pfactory_cd character varying, psp_plan_slide smallint, puser_id character varying) OWNER TO dosystem;

--
-- Name: p_do_prd_result_inq(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_prd_result_inq(pfactory_cd character varying, pdelivery_key character varying, pdelivery_location character varying, pblock_cd character varying, pdatefrom character varying, pdateto character varying, presult character varying, plogic character varying, pcalculation_date character varying) RETURNS TABLE(delivery_key character varying, delivery_date text, delivery_time character varying, delivery_order numeric, delivery_location character varying, block_cd character varying, inventory_code character varying, comment character varying, approver character varying, result text, factory_cd character varying, part_no character varying, dim character varying, supplier_cd character varying, ratio numeric, class character varying, logic smallint, update_date text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    wk_select character varying := '';
    wk_where character varying := '';
    vwork_next VARCHAR(8) := '';
BEGIN

    IF pfactory_cd IS NOT NULL THEN
        wk_where := wk_where || ' AND a.factory_cd LIKE ' || quote_literal(pfactory_cd);
    END IF;

    IF pdelivery_key IS NOT NULL THEN
        wk_where := wk_where || ' AND a.delivery_key LIKE ' || quote_literal(pdelivery_key);
    END IF;

    IF pdelivery_location IS NOT NULL THEN
        wk_where := wk_where || ' AND a.delivery_location LIKE ' || quote_literal(pdelivery_location);
    END IF;

    IF pblock_cd IS NOT NULL THEN
        wk_where := wk_where || ' AND a.block_cd LIKE ' || quote_literal(pblock_cd);
    END IF;

    IF presult IS NOT NULL THEN
        wk_where := wk_where || ' AND SUBSTR(a.result, 1, 6) LIKE ' || quote_literal(presult);
    END IF;

    IF plogic IS NOT NULL THEN
        wk_where := wk_where || ' AND a.logic::text LIKE ' || quote_literal(plogic);
    END IF;

    IF pcalculation_date IS NOT NULL THEN
        wk_where := wk_where || ' AND TO_CHAR(a.update_date, ''YYYYMMDD'') LIKE ' || quote_literal(pcalculation_date);
    END IF;

    IF pdatefrom IS NOT NULL AND pdateto IS NOT NULL THEN
        SELECT TO_CHAR(TO_DATE(pdateto, 'YYYYMMDD') + INTERVAL '1 day', 'YYYYMMDD')
        INTO vwork_next;

        wk_where := wk_where || ' AND a.delivery_date || a.delivery_time BETWEEN ' ||
                    quote_literal(pdatefrom) || ' || ''0800'' AND ' ||
                    quote_literal(vwork_next) || ' || ''0800''';
    END IF;

    IF wk_where IS NOT NULL THEN
        wk_where := ' WHERE ' || SUBSTR(wk_where, 5);
    END IF;

    wk_select :=
        'SELECT delivery_key::character varying, ' ||
        'delivery_date::text, ' ||
        'delivery_time::character varying, ' ||
        'SUM(delivery_order)::numeric AS delivery_order, ' ||
        'delivery_location::character varying, ' ||
        'block_cd::character varying, ' ||
        'inventory_code::character varying, ' ||
        'comment::character varying, ' ||
        'approver::character varying, ' ||
        'result::text, ' ||
        'factory_cd::character varying, ' ||
        'part_no::character varying, ' ||
        'dim::character varying, ' ||
        'supplier_cd::character varying, ' ||
        'ratio::numeric, ' ||
        'class::character varying, ' ||
        'logic::smallint, ' ||
        'a.update_date::text ' ||
        'FROM ( ' ||
        '    SELECT ' ||
        '        delivery_key, ' ||
        '        CASE WHEN delivery_date IS NULL THEN NULL ' ||
        '             ELSE SUBSTR(delivery_date, 1, 4) || ''/'' || SUBSTR(delivery_date, 5, 2) || ''/'' || SUBSTR(delivery_date, 7, 2) ' ||
        '        END AS delivery_date, ' ||
        '        delivery_time, delivery_order, delivery_location, block_cd, inventory_code, comment, approver, ' ||
        '        CASE WHEN b.message_en IS NULL THEN a.result ' ||
        '             ELSE a.result || '' : '' || b.message_en ' ||
        '        END AS result, ' ||
        '        factory_cd, part_no, dim, supplier_cd, ratio, class, logic, ' ||
        '        TO_CHAR(a.update_date, ''YYYYMMDD'') AS update_date ' ||
        '    FROM dosystem.t_prd_do_result a ' ||
        '    LEFT JOIN dosystem.error_message b ON a.result = b.error_message ' ||
        wk_where ||
        ') a ' ||
        'GROUP BY delivery_key, delivery_date, delivery_time, delivery_location, block_cd, ' ||
        'inventory_code, comment, approver, result, factory_cd, part_no, dim, supplier_cd, ' ||
        'ratio, class, logic, update_date ' ||
        'ORDER BY delivery_key, delivery_date, delivery_time';

    RETURN QUERY EXECUTE wk_select;

END;
$$;


ALTER FUNCTION dosystem.p_do_prd_result_inq(pfactory_cd character varying, pdelivery_key character varying, pdelivery_location character varying, pblock_cd character varying, pdatefrom character varying, pdateto character varying, presult character varying, plogic character varying, pcalculation_date character varying) OWNER TO dosystem;

--
-- Name: p_do_prd_result_inq_export(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_do_prd_result_inq_export(pfactory_cd character varying, pdelivery_key character varying, pdelivery_location character varying, pblock_cd character varying, pdatefrom character varying, pdateto character varying, presult character varying, plogic character varying, pcalculation_date character varying) RETURNS TABLE(delivery_key character varying, delivery_date text, delivery_time character varying, delivery_order numeric, delivery_location character varying, block_cd character varying, inventory_code character varying, comment character varying, approver character varying, logic smallint, result text, factory_cd character varying, part_no character varying, dim character varying, supplier_cd character varying, ratio numeric, class character varying, update_date text, cd_sply_fact character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    wk_select character varying := '';
    wk_where character varying := '';
    vwork_next VARCHAR(8) := NULL;
BEGIN

    IF pfactory_cd IS NOT NULL THEN
        wk_where := wk_where || ' AND a.factory_cd LIKE ' || quote_literal(pfactory_cd);
    END IF;

    IF pdelivery_key IS NOT NULL THEN
        wk_where := wk_where || ' AND a.delivery_key LIKE ' || quote_literal(pdelivery_key);
    END IF;

    IF pdelivery_location IS NOT NULL THEN
        wk_where := wk_where || ' AND a.delivery_location LIKE ' || quote_literal(pdelivery_location);
    END IF;

    IF pblock_cd IS NOT NULL THEN
        wk_where := wk_where || ' AND a.block_cd LIKE ' || quote_literal(pblock_cd);
    END IF;

    IF presult IS NOT NULL THEN
        wk_where := wk_where || ' AND SUBSTR(a.result, 1, 6) LIKE ' || quote_literal(presult);
    END IF;

    IF plogic IS NOT NULL THEN
        wk_where := wk_where || ' AND a.logic::text LIKE ' || quote_literal(plogic);
    END IF;

    IF pcalculation_date IS NOT NULL THEN
        wk_where := wk_where || ' AND TO_CHAR(a.update_date, ''YYYYMMDD'') LIKE ' || quote_literal(pcalculation_date);
    END IF;

    IF pdatefrom IS NOT NULL AND pdateto IS NOT NULL THEN
        SELECT TO_CHAR(TO_DATE(pdateto, 'YYYYMMDD') + INTERVAL '1 day', 'YYYYMMDD')
        INTO vwork_next;

        wk_where := wk_where || ' AND a.delivery_date || a.delivery_time BETWEEN ' ||
                    quote_literal(pdatefrom) || ' || ''0800'' AND ' ||
                    quote_literal(vwork_next) || ' || ''0800''';
    END IF;

    IF wk_where IS NOT NULL THEN
        wk_where := ' WHERE ' || SUBSTR(wk_where, 5);
    END IF;

    wk_select :=
        'SELECT delivery_key::character varying, ' ||
        'delivery_date::text, ' ||
        'delivery_time::character varying, ' ||
        'SUM(delivery_order)::numeric AS delivery_order, ' ||
        'delivery_location::character varying, ' ||
        'block_cd::character varying, ' ||
        'inventory_code::character varying, ' ||
        'comment::character varying, ' ||
        'approver::character varying, ' ||
        'logic::smallint, ' ||
        'result::text, ' ||
        'factory_cd::character varying, ' ||
        'part_no::character varying, ' ||
        'dim::character varying, ' ||
        'supplier_cd::character varying, ' ||
        'ratio::numeric, ' ||
        'class::character varying, ' ||
        'a.update_date::text, ' ||
        'cd_sply_fact::character varying ' ||
        'FROM ( ' ||
        '    SELECT ' ||
        '        delivery_key, ' ||
        '        CASE WHEN delivery_date IS NULL THEN NULL ' ||
        '             ELSE SUBSTR(delivery_date, 1, 4) || ''/'' || SUBSTR(delivery_date, 5, 2) || ''/'' || SUBSTR(delivery_date, 7, 2) ' ||
        '        END AS delivery_date, ' ||
        '        delivery_time, delivery_order, delivery_location, block_cd, inventory_code, comment, approver, ' ||
        '        CASE WHEN b.message_en IS NULL THEN a.result ' ||
        '             ELSE a.result || '' : '' || b.message_en ' ||
        '        END AS result, ' ||
        '        factory_cd, part_no, dim, supplier_cd, ratio, class, ' ||
        '        TO_CHAR(a.update_date, ''YYYYMMDD'') AS update_date, logic, cd_sply_fact ' ||
        '    FROM dosystem.t_prd_do_result a ' ||
        '    LEFT JOIN dosystem.error_message b ON a.result = b.error_message ' ||
        wk_where ||
        ') a ' ||
        'GROUP BY delivery_key, delivery_date, delivery_time, delivery_location, block_cd, ' ||
        'inventory_code, comment, approver, result, factory_cd, part_no, dim, supplier_cd, ' ||
        'ratio, class, logic, update_date, cd_sply_fact ' ||
        'ORDER BY delivery_key, delivery_date, delivery_time';

    RETURN QUERY EXECUTE wk_select;

END;
$$;


ALTER FUNCTION dosystem.p_do_prd_result_inq_export(pfactory_cd character varying, pdelivery_key character varying, pdelivery_location character varying, pblock_cd character varying, pdatefrom character varying, pdateto character varying, presult character varying, plogic character varying, pcalculation_date character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_calucation_daily_all_process(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_calucation_daily_all_process() RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN
    SET statement_timeout = 0;
    SET work_mem = '512MB';

----- CALULATION DO
    ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'08. DO SYSTEM CALUCATION OVER STD STOCK  START') ;
    

    PERFORM  dosystem.P_PRD_DO_OVER_STD_STOCK();

     INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'08. DO SYSTEM CALUCATION OVER STD STOCK  COMPLETE') ;
    
    
    
    ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'09. DO SYSTEM MAKE PLAN BALANCE QTY START') ;
        
  
    
    PERFORM  dosystem.P_PRD_DO_PLAN_BALANCE_QTY();
 
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'09. DO SYSTEM MAKE PLAN BALANCE QTY COMPLETE') ;
    
    ------------------------------------------------------------------------------------------------------------

    -- SINGLE RATE PROCESS
        INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'10. DO SYSTEM MAKE PLAN REF DEL LOT RATE100 START') ;
      
  
    
    PERFORM  dosystem.P_PRD_DO_PLAN_REF_DEL_LOT_RATE100();

     INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'10. DO SYSTEM MAKE PLAN REF DEL LOT RATE100 COMPLETE') ;
          
    ------------------------------------------------------------------------------------------------------------

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'11. DO SYSTEM MAKE PLAN REF DEL DATE/ROUND RATE100 START') ;
      
    
    PERFORM dosystem.P_PRD_DO_PLAN_REF_DEL_DATE_RATE100();

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'11. DO SYSTEM MAKE PLAN REF DEL DATE/ROUND RATE100 COMPLETE') ;
    
    ------------------------------------------------------------------------------------------------------------

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'12. DO SYSTEM PLAN SLIDE SUPPORT PRODUCTION CHANGE RATE100 START') ;
    
    
    PERFORM  dosystem.PG_PRD_DO_SLIDE_DEL_CASE_PLAN_CHANGE();

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'12. DO SYSTEM PLAN SLIDE SUPPORT PRODUCTION CHANGE RATE100 COMPLETE') ;
    
        
    ------------------------------------------------------------------------------------------------------------

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'13. DO SYSTEM ISSUE DO RATE100 START') ;
    

    PERFORM  dosystem.P_PRD_DO_ISSUE_DO_RATE100();

     INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'13. DO SYSTEM ISSUE DO RATE100 COMPLETE') ;
     

     ------------------------------------------------------------------------------------------------------------

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'14. DO SYSTEM CLEAR DATA MULTI RATE START') ;
    
    
     PERFORM  dosystem.P_PRD_DO_ISSUE_DO_CLEAR_DATA();

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'14. DO SYSTEM CLEAR DATA MULTI RATE COMPLETE') ;
    
    

      ------------------------------------------------------------------------------------------------------------
   INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'15. DO SYSTEM ISSUE DO MULTI RATE START') ;
    
        
    PERFORM  dosystem.P_PRD_DO_PLAN_REF_DEL_LOT_MULTI_RATE();
 
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'15. DO SYSTEM ISSUE DO MULTI RATE COMPLETE') ;
    

    -------------------------------------------------------------------------------------------------------------

return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_calucation_daily_all_process() OWNER TO dosystem;

--
-- Name: p_prd_do_calucation_daily_plan(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_calucation_daily_plan() RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';
----- CALULATION PLAN

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'02. DO SYSTEM MAKE PLAN REFER DNM START') ;
        
    
    PERFORM  dosystem.P_PRD_DO_MAKE_PLAN_REFER_DNM() ;

            INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'02. DO SYSTEM MAKE PLAN REFER DNM COMPLETE') ;
        
    ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'03. DO SYSTEM MAKE PLAN LINE BYHOUSR START') ;
        
    
    PERFORM  dosystem.P_PRD_DO_PLAN_PLANBYHOUR() ;

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'03. DO SYSTEM MAKE PLAN LINE BYHOUSR COMPLETE') ;
      
    
   ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'04. DO SYSTEM MAKE PLAN BY HR BEFORE START') ;
        
    
    PERFORM  dosystem.P_PRD_DO_PLAN_PLAN_PART_BYHOUSR_BF() ;

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'04. DO SYSTEM MAKE PLAN BY HR BEFORE COMPLETE') ;
    
    ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'05. DO SYSTEM SLIDE PLAN SPACIAL START') ;
        
    
    PERFORM  dosystem.P_PRD_DO_SLIDE_PLAN_NOT_CONTINUE() ;

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'05. DO SYSTEM SLIDE PLAN SPACIAL COMPLETE') ;
    
     ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'06. DO SYSTEM MAKE PLAN PART BYHOUSR START') ;
         
    
    PERFORM  dosystem.P_PRD_DO_PLAN_PLAN_PART_BYHOUSR();

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'06. DO SYSTEM MAKE PLAN PART BYHOUSR COMPLETE') ;
        

    ------------------------------------------------------------------------------------------------------------
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'07. DO SYSTEM MAKE PLAN REFER LT  START') ;
           
    
    PERFORM  dosystem.P_PRD_DO_MAKE_PLAN_REFER_LT();

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'07. DO SYSTEM MAKE PLAN REFER LT  COMPLETE') ;
        

 

return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_calucation_daily_plan() OWNER TO dosystem;

--
-- Name: p_prd_do_delete_data_his(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_delete_data_his() RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN

                DELETE FROM dosystem.T_DO_PLAN_BALANCE_QTY
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_PLANBYHOUSR
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_PLANBYSHIFT
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
                WHERE TO_CHAR(CREATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
                DELETE FROM dosystem.T_PRD_DO_RESULT
                WHERE TO_CHAR(UPDATE_DATE,'YYYYMMDD') <= TO_CHAR(CURRENT_DATE-30,'YYYYMMDD') ;
                -------------------------------------------------------------
return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_delete_data_his() OWNER TO dosystem;

--
-- Name: p_prd_do_find_del_first_priority(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_find_del_first_priority(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pcd_sply_fact character varying, pnext_work_day character varying, pnm_key_table character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
vFLG    CHARACTER VARYING(1) := 0;   
V_Next_Working_Day   CHARACTER VARYING(8); 
V_PLAN_DATE_SLIDE CHARACTER VARYING(20); 
V_PLAN_TIME_SLIDE CHARACTER VARYING(20); 
V_Next_Working_Day2  CHARACTER VARYING(8); 
V_Next_PlanDate     CHARACTER VARYING(8); 
V_Day               CHARACTER VARYING(3);
vTime               CHARACTER VARYING(4);

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
FROM dosystem.WBGZT051
WHERE MK_WORK = 'Y'
AND DT_WORK > V_Next_Working_Day;  
END;

--  Check Day on Plan data and plan Time                            
BEGIN
SELECT TO_CHAR(TO_DATE(V_Next_Working_Day,'YYYYMMDD'),'DY') INTO V_Day;

EXCEPTION WHEN NO_DATA_FOUND THEN
V_Day := NULL;                            
END;

-- Check MK_DAY_INTEGRATE  Like %Day% 
IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN -- Support Time 08.00 - 23.00

-- #Modify 14-Mar-2022 by Alisa

select * from dosystem.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT ,V_Next_Working_Day,'0800' ,'2300',vTime);

IF vTime IS NULL THEN

SELECT MIN(DT_WORK) INTO V_Next_Working_Day
FROM dosystem.WBGZT051
WHERE DT_WORK > V_Next_Working_Day;

BEGIN
SELECT TO_CHAR(TO_DATE(V_Next_Working_Day,'YYYYMMDD'),'DY') INTO V_Day;

EXCEPTION WHEN NO_DATA_FOUND THEN
V_Day := NULL;                            
END;

IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN

select * from dosystem.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT,V_Next_Working_Day ,'0000' ,'0700',vTime);

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
FROM dosystem.WBGZT051
WHERE DT_WORK > V_Next_Working_Day;

BEGIN
SELECT TO_CHAR(TO_DATE(V_Next_Working_Day2,'YYYYMMDD'),'DY') INTO V_Day;

EXCEPTION WHEN NO_DATA_FOUND THEN
V_Day := NULL;                            
END;

IF pNM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN

select * from dosystem.P_PRD_DO_FIND_DEL_PLAN_TIME( pFACTORY_CD,pPART_NO  ,pDIM ,pCLASS ,pUSE_BLOCK_CD,pCD_SPLY_FACT,V_Next_Working_Day2 ,'0000' ,'0700',vTime);

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

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_find_del_first_priority(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pcd_sply_fact character varying, pnext_work_day character varying, pnm_key_table character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_find_del_for_multi_rate(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_find_del_for_multi_rate() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
v_delivery_date             character varying(20);
v_delivery_time             character varying(20);
v_nm_key_table              character varying(100);
v_combiday                  character varying(1);
v_plan_datetime             character varying(12);
vnext_working_date      character varying(8);
vnext2_working_date     character varying(8);
vnext3_working_date     character varying(8);
vnext_del               character varying(8);

	rec0 record;
    rec1 record;

BEGIN
    SET  LOCAL statement_timeout = 10;
    SET  LOCAL work_mem = '512MB';  
DELETE  from dosystem.T_DO_FIND_DEL_FOR_MULTI_RATE ;

-- 1.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

    FOR rec0 IN
	Select Distinct LOGIC 
	FROM dosystem.T_DO_PLAN_BALANCE_QTY
	WHERE RATIO NOT IN ('100','0')
	AND PLAN_QTY_BALANCE > 0
	
    LOOP
        -- TODO: logic
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

    FOR rec1 IN
	SELECT DISTINCT A.FACTORY_CD, A.PART_NO, A.DIM,A.USE_BLOCK_CD,A.CLASS,B.CD_SPLY_FACT
                    FROM dosystem.T_DO_PLAN_BALANCE_QTY A
                    LEFT JOIN dosystem.WBGJT002 B
                        ON A.PART_NO = B.NO_PARTS
                        AND A.DIM = B.NO_ADJ_DIM
                        AND A.SUPPLIER_CD = B.CD_SPLY
                    WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                     AND  RATIO NOT IN ('0','100' )
                     AND LOGIC = REC0.LOGIC 
                     AND PLAN_QTY_BALANCE > 0
                    ORDER BY FACTORY_CD, PART_NO , DIM, USE_BLOCK_CD
	
    LOOP
        -- TODO: logic
        BEGIN
        NULL;
        
		select * into V_delivery_date,V_delivery_time,V_NM_KEY_TABLE,V_CombiDay,V_PLAN_DATETIME		
		from dosystem.p_prd_do_find_del_for_multi_rate
		(REC1.FACTORY_CD,REC1.PART_NO,REC1.DIM,REC1.CLASS,REC1.USE_BLOCK_CD,vNEXT_DEL,REC1.CD_SPLY_FACT); 
                    INSERT INTO dosystem.T_DO_FIND_DEL_FOR_MULTI_RATE
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
                                        CURRENT_DATE,
                                        REC1.CD_SPLY_FACT
                                    );

END;
		
    END LOOP;--END rec1
	
    END LOOP;-- END rec0

	
RETURN 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_find_del_for_multi_rate() OWNER TO dosystem;

--
-- Name: p_prd_do_find_del_for_multi_rate(character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_find_del_for_multi_rate(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pnext_del character varying, pcd_sply_fact character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying, OUT pnm_key_table character varying, OUT pcombiday character varying, OUT pplan_datetime character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    V_Next_Working_Day   character varying(8);
    V_Next_del           character varying(8);
    V_NM_KEY_TABLE       character varying(100);
    V_delivery_date      character varying(20);
    V_MIN_DT_DELV        character varying(8);
    V_delivery_Time      character varying(20);
    V_CombiDay           character varying(1);
    V_Num_Day_Slide      numeric(3);
    V_PLAN_DATETIME      character varying(14);
    VChk_Flg             character varying(1);
    V_delivery_date_temp character varying(20);
BEGIN
    SET  LOCAL statement_timeout = 10;
    SET  LOCAL work_mem = '512MB';  
    V_Next_Working_Day := pNEXT_DEL;

    SELECT MIN(DT_WORK) INTO V_Next_del
    FROM dosystem.WBGZT051
    WHERE MK_WORK = 'Y'
      AND DT_WORK > V_Next_Working_Day;

    IF pCLASS = 'M/T' THEN
        SELECT DISTINCT UPPER(DAY_OF_WEEK) INTO V_NM_KEY_TABLE
        FROM dosystem.V_DO_DELEVERY_DAY_BY_PARTNO
        WHERE FACTORY_CD = pFACTORY_CD 
		AND NO_PARTS = pPART_NO 
		AND NO_ADJ_DIM = pDIM
        AND CLASS = pCLASS 
		AND DAY_OF_WEEK IS NOT NULL 
		AND CD_SPLY_FACT = pCD_SPLY_FACT;
		--Ex V_NM_KEY_TABLE NO_DATA_FOUND 
        IF V_NM_KEY_TABLE IS NULL THEN
            SELECT DISTINCT UPPER(COMBINE_DAY) INTO V_CombiDay
            FROM dosystem.V_DO_DELEVERY_DAY_BY_PARTNO
            WHERE FACTORY_CD = pFACTORY_CD 
			AND NO_PARTS = pPART_NO 
			AND NO_ADJ_DIM = pDIM
            AND CLASS = pCLASS 
			AND CD_SPLY_FACT = pCD_SPLY_FACT;

			----Ex V_CombiDay NO_DATA_FOUND 
			IF V_CombiDay IS NULL THEN
				V_CombiDay := NULL;
				V_NM_KEY_TABLE := NULL ;
			END IF;
			
        END IF;

    ELSIF pCLASS = 'M/C' THEN
        SELECT DISTINCT UPPER(DAY_OF_WEEK) INTO V_NM_KEY_TABLE
        FROM dosystem.V_DO_DELEVERY_DAY_BY_PARTNO
        WHERE FACTORY_CD = pFACTORY_CD 
		AND NO_PARTS = pPART_NO 
		AND NO_ADJ_DIM = pDIM
        AND CLASS = pCLASS 
		AND USE_BLOCK_CD = pUSE_BLOCK_CD 
        AND DAY_OF_WEEK IS NOT NULL 
		AND CD_SPLY_FACT = pCD_SPLY_FACT;

			----Ex V_CombiDay NO_DATA_FOUND 
			IF V_NM_KEY_TABLE IS NULL THEN
			
				SELECT DISTINCT UPPER(COMBINE_DAY)  INTO V_CombiDay   
				FROM V_DO_DELEVERY_DAY_BY_PARTNO
				WHERE FACTORY_CD = pFACTORY_CD
				AND NO_PARTS = pPART_NO
				AND NO_ADJ_DIM = pDIM 
				AND CLASS = pCLASS
				AND USE_BLOCK_CD = pUSE_BLOCK_CD
				AND CD_SPLY_FACT = pCD_SPLY_FACT;

				----Ex V_CombiDay NO_DATA_FOUND
				IF V_CombiDay IS NULL THEN
				V_CombiDay := NULL;
				V_NM_KEY_TABLE := NULL ;
				END IF;   
                  
			END IF;
			
    ELSE
        V_CombiDay := NULL;
        V_NM_KEY_TABLE := NULL;
    END IF;

    -- A Day of the Week
    IF V_NM_KEY_TABLE IS NOT NULL THEN
        SELECT v_date, v_time FROM dosystem.p_prd_do_find_del_first_priority(
            pFACTORY_CD, pPART_NO, pDIM, pCLASS, pUSE_BLOCK_CD, pCD_SPLY_FACT,
            V_Next_Working_Day, V_NM_KEY_TABLE)
        INTO V_delivery_date, V_delivery_time;

        pPLAN_DATE_SLIDE := V_delivery_date;
        pPLAN_TIME_SLIDE := V_delivery_time;
    
	-- Combine Day
    ELSE
	
        IF V_CombiDay = 'D' THEN
			IF  pCLASS = 'M/T' THEN
                                            SELECT MAX(PLAN_DATETIME)  INTO V_PLAN_DATETIME FROM (
                                            SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME  
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
                                                
                                        --EXCEPTION WHEN V_PLAN_DATETIME NO_DATA_FOUND THEN
										    IF V_PLAN_DATETIME IS  NULL THEN
                                              V_PLAN_DATETIME := NULL;       
                                        	END IF ; 

			ELSIF pCLASS = 'M/C' THEN
                                            SELECT MAX(PLAN_DATETIME)  INTO V_PLAN_DATETIME FROM (
                                            SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME  
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
                                                
                                        --EXCEPTION WHEN V_PLAN_DATETIME NO_DATA_FOUND THEN
										IF V_PLAN_DATETIME is null then
                                                        V_PLAN_DATETIME := NULL;  
										END IF;				
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
                                        -- 1.) Get data MIN(DT_DELV)
                                        SELECT MIN(DT_DELV) INTO V_MIN_DT_DELV
                                        FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
                                        WHERE NM_ARGMET_STAT IN ('PG','PO','MG','FC')
                                            AND NO_PARTS = pPART_NO
                                            AND NO_ADJ_DIM = pDIM                                
                                            AND CD_USE_BLOCK = CASE WHEN pCLASS = 'M/C' THEN pUSE_BLOCK_CD 
                                                                ELSE '      ' END
                                            AND DT_DELV > V_Next_Working_Day
                                            AND NO_ORD_CLASS = '4600';
                                            
                                        --EXCEPTION WHEN V_MIN_DT_DELV NO_DATA_FOUND THEN
										IF V_MIN_DT_DELV IS NULL THEN
                                        V_MIN_DT_DELV := NULL;            
										END IF;
                                
-- 1
       IF V_MIN_DT_DELV = V_Next_del THEN  
             --- 1.1
                    IF  pCLASS = 'M/T' THEN

                                             BEGIN
                     
                                                    SELECT MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME  
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
                                                        
                                                --EXCEPTION WHEN V_PLAN_DATETIMENO_DATA_FOUND THEN
												IF V_PLAN_DATETIME IS NULL THEN
                                                                V_PLAN_DATETIME := NULL;       
												END IF;
                                               END;                        
                                              --- 1.2                   
                    ELSIF pCLASS = 'M/C' THEN

                                                    SELECT MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME  
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
                                            FROM( SELECT * FROM dosystem.WBGZT051
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
                                            FROM( SELECT * FROM dosystem.WBGZT051
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
                                                                                    
                                                    SELECT MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME
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
                                        
                                        
                                        --EXCEPTION WHEN V_PLAN_DATETIME NO_DATA_FOUND 
										 IF V_PLAN_DATETIME IS NULL THEN
                                        V_PLAN_DATETIME := NULL;    
										 END IF;
                                        END;
										
                           ELSIF  pCLASS = 'M/C' THEN
                                       BEGIN
                                                    SELECT MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
                                                    SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME
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
                                                                                
                                        
                                        --EXCEPTION WHEN V_PLAN_DATETIME NO_DATA_FOUND 
										 IF V_PLAN_DATETIME IS NULL THEN
                                        V_PLAN_DATETIME := NULL;   
										 END IF; 
										 
                                        END;                                                                
                                                                                                                        
                                        END IF;
										
										ELSIF (VCHK_FLG = 'Y') THEN 
											IF PCLASS = 'M/T' THEN
										BEGIN
										SELECT
											MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME
										FROM
											(
												SELECT
													SUPPLIER_CD,
													MIN(SUBSTR(END_DATE, 1, 8) || TIME_ETA) AS PLAN_DATETIME
												FROM
													(
														SELECT
															*
														FROM
															(
																SELECT
																	DT_WORK,
																	MK_WORK,
																	DATE_START,
																	START_TIME AS BEGIN_DATE,
																	SUBSTR(START_TIME, 1, 8) || '2300' END_DATE
																FROM
																	V_DO_WORKING_DAY
																UNION
																SELECT
																	DT_WORK,
																	MK_WORK,
																	DATE_END,
																	SUBSTR(END_TIME, 1, 8) || '0000' AS BEGIN_DATE,
																	END_TIME AS END_DATE
																FROM
																	V_DO_WORKING_DAY
															)
														WHERE
															MK_WORK = 'Y'
													) A
													JOIN V_PRD_DO_DELIVERY_MASTER B ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE, 9, 4) AND SUBSTR(END_DATE, 9, 4)
												WHERE
													FACTORY_CD = PFACTORY_CD
													AND SUPPLIER_CD IN (
														SELECT DISTINCT
															SUPPLIER_CD
														FROM
															T_PRD_DO_PART_AND_STRUCTURE
														WHERE
															FACTORY_CD = PFACTORY_CD
															AND PT_RATIO NOT IN ('0', '100')
															AND PART_NO = PPART_NO
															AND DIM = PDIM
															AND CLASS = 'M/T'
													)
													AND SUBSTR(END_DATE, 1, 8) || TIME_ETA <= V_NEXT_DEL || '0800'
													AND SUBSTR(END_DATE, 1, 8) = V_NEXT_DEL
													AND CD_SPLY_FACT = PCD_SPLY_FACT
												GROUP BY
													SUPPLIER_CD
											);
										
										--EXCEPTION WHEN NO_DATA_FOUND 
										IF V_PLAN_DATETIME IS NULL THEN 
										V_PLAN_DATETIME := NULL;
										END IF;
										
										END;
										
						ELSIF  pCLASS = 'M/C' THEN  
						BEGIN
						SELECT MAX(PLAN_DATETIME) INTO V_PLAN_DATETIME FROM (
						SELECT SUPPLIER_CD ,MIN(SUBSTR(END_DATE,1,8)||TIME_ETA ) AS PLAN_DATETIME
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
						
						
						--EXCEPTION WHEN NO_DATA_FOUND THEN
						IF V_PLAN_DATETIME IS NULL or '' THEN
						V_PLAN_DATETIME := NULL;       
						END IF;                                                                        
						
						END ;
						
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

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_find_del_for_multi_rate(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pnext_del character varying, pcd_sply_fact character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying, OUT pnm_key_table character varying, OUT pcombiday character varying, OUT pplan_datetime character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_find_del_plan_time(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_find_del_plan_time(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pplan_date character varying, pplan_time_start character varying, pplan_time_end character varying, pcd_sply_fact character varying, OUT pplan_time_slide character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE

V_PLAN_DATETIME    character varying(12);  
vCOUNT numeric;

BEGIN
              
                    BEGIN
                        SELECT COUNT(*) INTO vCOUNT
                        FROM dosystem.WBGZT051
                        WHERE MK_WORK = 'Y'
                        AND DT_WORK = pPLAN_DATE;  
                    END;                                       
                            IF (vCOUNT = 1)THEN
                                                IF ( pCLASS = 'M/T' )THEN
                                                    
                                                        BEGIN
                                                             SELECT MAX(V_PLAN_DATETIME) INTO V_PLAN_DATETIME  
                                                                 FROM (
                                                                SELECT SUPPLIER_CD,MIN(TIME_ETA) AS V_PLAN_DATETIME
                                                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
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
                                                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
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
                                                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
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
                                                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                                                WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD IN (   SELECT DISTINCT  SUPPLIER_CD
                                                                                FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
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
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_find_del_plan_time(pfactory_cd character varying, ppart_no character varying, pdim character varying, pclass character varying, puse_block_cd character varying, pplan_date character varying, pplan_time_start character varying, pplan_time_end character varying, pcd_sply_fact character varying, OUT pplan_time_slide character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_get_dlv_key_no(character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_get_dlv_key_no(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, prow_cnt character varying, pnext_del character varying, OUT prow_num numeric, OUT pdlv_key_no character varying, OUT pqt_delv_dirct_bal numeric, OUT pcd_delv_place character varying, OUT pdt_delv character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
vWORKING_NEXTDAY  character varying(8);
BEGIN

pROW_NUM := 0 ;
SELECT MIN (DT_WORK) INTO  vWORKING_NEXTDAY 
FROM dosystem.WBGZT051
WHERE MK_WORK =  'Y'
AND DT_WORK >= pNEXT_DEL;

    BEGIN

SELECT 
    1,                       -- ค่า ROWNUM ในที่นี้จะเป็น 1 เสมอเพราะเลือกมาแถวเดียว
    DLV_KEY_NO, 
    QT_DELV_DIRCT_BAL, 
    DT_DELV
INTO 
    pROW_NUM, 
    pDLV_KEY_NO, 
    pQT_DELV_DIRCT_BAL, 
    pDT_DELV
FROM (
    SELECT 
        A.NO_PO || A.MK_PO_CHK_DIGIT AS DLV_KEY_NO, 
        (A.QT_DELV_DIRCT_BAL - COALESCE(B.DELIVERY_COMPLETE, 0)) AS QT_DELV_DIRCT_BAL,
        A.DT_DELV
    FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300 A  
    LEFT JOIN (
        SELECT 
            PART_NO, 
            DIM, 
            SUPPLIER_CD, 
            DELIVERY_KEY AS KEY, 
            SUM(DELIVERY_ORDER) AS DELIVERY_COMPLETE
        FROM dosystem.T_PRD_DO_RESULT 
        WHERE TO_CHAR(UPDATE_DATE, 'YYYYMMDD') = TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
          AND RESULT = 'WF0000'
          AND DELIVERY_KEY IS NOT NULL
        GROUP BY PART_NO, DIM, SUPPLIER_CD, DELIVERY_KEY 
    ) B ON A.NO_PARTS = B.PART_NO
       AND A.NO_ADJ_DIM = B.DIM
       AND A.CD_SPLY = B.SUPPLIER_CD
       AND (A.NO_PO || A.MK_PO_CHK_DIGIT) = B.KEY
    WHERE A.NM_ARGMET_STAT IN ('AO', 'PO')
      AND A.NO_PARTS = pPART_NO
      AND A.NO_ADJ_DIM = pDIM
      AND A.DT_DELV <= vWORKING_NEXTDAY
      AND A.QT_DELV_DIRCT_BAL > 0
      AND A.CD_SPLY = pSUPPLIER_CD
      AND A.QT_DELV_DIRCT_BAL <> COALESCE(B.DELIVERY_COMPLETE, 0)
    ORDER BY 
        A.DT_DELV ASC, 
        A.TM_DELV ASC, 
        (A.NO_PO || A.MK_PO_CHK_DIGIT) ASC
) 
LIMIT 1;
            
        EXCEPTION WHEN NO_DATA_FOUND THEN
            pDLV_KEY_NO := NULL;  
            pQT_DELV_DIRCT_BAL := NULL;    
            
          END;
		  
        BEGIN
                SELECT DISTINCT CD_DELV_PLACE INTO pCD_DELV_PLACE
                FROM dosystem.WBGHT009
                  WHERE NO_PARTS = pPART_NO
                  AND NO_ADJ_DIM = pDIM 
                  AND CD_BS_BLOCK = pSUPPLIER_CD 
                  AND CD_BLOCK = CASE WHEN pUSE_BLOCK_CD = '8888' THEN '      ' 
                                                    ELSE pUSE_BLOCK_CD END ;        
         EXCEPTION WHEN NO_DATA_FOUND THEN           
                 pCD_DELV_PLACE := NULL;                  
         END;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_get_dlv_key_no(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, prow_cnt character varying, pnext_del character varying, OUT prow_num numeric, OUT pdlv_key_no character varying, OUT pqt_delv_dirct_bal numeric, OUT pcd_delv_place character varying, OUT pdt_delv character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_issue_do_clear_data(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_issue_do_clear_data() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
vnext_working_date	character varying(8);                                                    
vnext2_working_dat	character varying(8);
vnext3_working_dat	character varying(8);
vnext_del			character varying(8);
rec0 record;
rec1 record;

BEGIN
    SET  statement_timeout = 0;

    SET  work_mem = '512MB';  
 
--
DELETE FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY  ;

-- Clear data DELIVERY LOT   

DELETE FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT		
WHERE RATIO <> 100;

-- Clear data DELIVERY DATE
DELETE FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE		
WHERE RATIO <> 100; 
    

--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vnext2_working_dat
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vnext3_working_dat
FROM dosystem.WBGZT051
WHERE DT_WORK > vnext2_working_dat 
AND MK_WORK = 'Y';

FOR rec0 IN
Select Distinct LOGIC 
FROM dosystem.T_DO_PLAN_BALANCE_QTY
WHERE RATIO NOT IN ('100','0')
LOOP
            IF REC0.LOGIC = '1' THEN
                BEGIN
                    vNEXT_DEL := vNEXT_WORKING_DATE;
                END;
                
            ELSIF REC0.LOGIC = '2' THEN
                BEGIN
                    vNEXT_DEL := vnext2_working_dat;
                END;
                
            ELSIF REC0.LOGIC = '3' THEN
                BEGIN
                    vNEXT_DEL := vNEXT3_WORKING_DATE;
                END;
            END IF; 

		FOR rec1 IN
		SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,LOGIC   
		FROM dosystem.T_DO_PLAN_BALANCE_QTY
		WHERE RATIO NOT IN ('100','0')
		AND LOGIC = REC0.LOGIC
		LOOP
		            BEGIN
		                DELETE FROM dosystem.T_PRD_DO_RESULT
		                WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'	
		                AND RATIO NOT IN ('100','0')
		                AND FACTORY_CD = rec1.FACTORY_CD
		                AND PART_NO = rec1.PART_NO
		                AND DIM = rec1.DIM ;
		               --   AND BLOCK_CD = REC_CUR1.USE_BLOCK_CD
		               -- AND LOGIC  = REC_CUR1.LOGIC;
		            END;
		END LOOP;
END LOOP;	
return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_issue_do_clear_data() OWNER TO dosystem;

--
-- Name: p_prd_do_issue_do_multi_rate(character varying, character varying, character varying, character varying, character varying, character varying, numeric, character varying, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_issue_do_multi_rate(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, pnext_del character varying, plogic smallint, pcd_sply_fact character varying, OUT psum_qty_do numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE
    rec1 record;
	rec3 record;

v_row_cnt               numeric(4);
v_qt_bal_plan           numeric(12);
v_qt_bal_po             numeric(12);
v_min_row_num           character varying(12);
v_dlv_key_no            character varying(31);
v_qt_delv_dirct_bal     character varying(12);
v_cd_delv_place         character varying(12);
vflg_in_house           character varying(10) := null;
v_min_dt_delv           character varying(8);

BEGIN
-- #Case Result is error
-- 2.)  Open CUR 1
    FOR rec1 IN
				SELECT *
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
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
                                                                    AND 
																			(SELECT to_char(
																			    to_date(next_working_day, 'YYYYMMDD') + INTERVAL '1 day',
																			    'YYYYMMDD'
																			)
                                                                        FROM (  SELECT MIN(DT_WORK) AS NEXT_WORKING_DAY 
																		FROM dosystem.WBGZT051 
                                                                                WHERE MK_WORK = 'Y' AND DT_WORK > pNEXT_DEL
                                                                              ))||'0759'
    LOOP
        -- TODO: logic	
		BEGIN
		    INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                    CURRENT_DATE,
                                    REC1.PLAN_DATE,
                                    REC1.PLAN_TIME,
                                    REC1.PART_NO,
                                    REC1.DIM,
                                    REC1.SUPPLIER_CD,
                                    REC1.RATIO,
                                    REC1.CLASS,
                                    pLOGIC,
                                    pCD_SPLY_FACT);        
                                    
                        EXCEPTION
                        WHEN OTHERS THEN
                           NULL ;
						END;						
    END LOOP;

--#Case Result is OK

                BEGIN            
                SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                FROM dosystem.T_PRD_DO_DELIVERY_MASTER
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

	FOR rec3 in 
	SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM dosystem.t_do_plan_ref_delivery_date
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN  pNEXT_DEL||'0800'  
                                                                    AND (SELECT TO_CHAR(TO_DATE(NEXT_WORKING_DAY,'YYYYMMDD')+ INTERVAL '1 day','YYYYMMDD')
                                                                        FROM (  SELECT MIN(DT_WORK) AS NEXT_WORKING_DAY FROM dosystem.WBGZT051 
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
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND
	LOOP
                        BEGIN
                        
                        
                                                INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                            CURRENT_DATE,
                                                            REC3.PLAN_DATE,
                                                            REC3.PLAN_TIME,
                                                            pPART_NO,
                                                            pDIM,
                                                            pSUPPLIER_CD,
                                                            pRATIO,
                                                            pCLASS,
                                                            pLOGIC,
                                                            pCD_SPLY_FACT);
                                                EXCEPTION
                                                WHEN OTHERS THEN
                                                   NULL ;
                                
                        END;
                        END LOOP; -- END LOOP CUR 3
 
ELSE 
                         
--Set Initial Data
V_ROW_CNT := 0;
V_QT_BAL_PLAN := NULL;
V_QT_BAL_PO := 0;
-- 2.)  Open CUR 3
	FOR rec3 in 
	SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM dosystem.t_do_plan_ref_delivery_date
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN  pNEXT_DEL||'0800'  
                                                                    AND (SELECT TO_CHAR(TO_DATE(NEXT_WORKING_DAY,'YYYYMMDD')+ INTERVAL '1 day','YYYYMMDD')
                                                                        FROM (  SELECT MIN(DT_WORK) AS NEXT_WORKING_DAY FROM dosystem.WBGZT051 
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
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND
	LOOP            
        V_MIN_DT_DELV := '00000000';
     --Set Initial Data 
     V_QT_BAL_PLAN := REC3.PLAN_QTY;
     

    WHILE V_QT_BAL_PLAN > 0 AND ( V_MIN_DT_DELV <= REC3.PLAN_DATE )
     LOOP
        IF V_QT_BAL_PO = 0 THEN
            BEGIN
                select * from dosystem.p_prd_do_get_dlv_key_no( pFACTORY_CD,
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
                    INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                CURRENT_DATE,
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
                --แก้ 11/3/26
			-- [เพิ่ม 2 บรรทัดนี้ตรงนี้] --
            V_QT_BAL_PO := NULL;
            V_QT_BAL_PLAN := 0;
            --------------------------				
            END IF;
            
        ELSIF V_QT_BAL_PO > 0 THEN
            BEGIN
                IF V_QT_BAL_PLAN > V_QT_BAL_PO THEN
                    BEGIN
                        BEGIN
                            INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                        CURRENT_DATE,
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
                            INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                        CURRENT_DATE,
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
                    INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                CURRENT_DATE,
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
                --Comment 11/3/26
                --V_QT_BAL_PO := NULL;
                --V_QT_BAL_PLAN := 0;
            END;
			-- [เพิ่ม 1 บรรทัดนี้ตรงนี้] --
        	V_QT_BAL_PLAN := 0;
        	--------------------------
        END IF;
     END LOOP;
    
END LOOP; -- END LOOP CUR 3  
END IF ;

-- #Summary Qty for return
BEGIN
    SELECT SUM(DELIVERY_ORDER) AS SUM_QTY_DO INTO pSUM_QTY_DO
    FROM dosystem.T_PRD_DO_RESULT
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

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_issue_do_multi_rate(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, pnext_del character varying, plogic smallint, pcd_sply_fact character varying, OUT psum_qty_do numeric) OWNER TO dosystem;

--
-- Name: p_prd_do_issue_do_rate100(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_issue_do_rate100() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE

vflg_in_house           character varying(10) := null;
v_row_cnt               numeric(4);
v_qt_bal_plan           numeric(12);
v_qt_bal_po             numeric(12);
v_min_row_num           character varying(12); 
v_dlv_key_no            character varying(31); 
v_qt_delv_dirct_bal     character varying(12);
v_cd_delv_place         character varying(12);
v_min_dt_delv           character varying(8);
--
vnext_working_date      character varying(8);
vnext2_working_date     character varying(8);
vnext3_working_date     character varying(8);
vnext_del               character varying(8);

rec0 record;
rec1 record;
rec2 record;
rec3 record;

BEGIN
    SET  statement_timeout = 0;

    SET  work_mem = '512MB';  
 
-- 0.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

--1. Clear data T_PRD_DO_RESULT

DELETE FROM dosystem.T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT_WORKING_DATE||'0800'
    AND RATIO = 100;

DELETE FROM dosystem.T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT2_WORKING_DATE||'0800'
    AND RATIO = 100;
    
DELETE FROM dosystem.T_PRD_DO_RESULT 
WHERE DELIVERY_DATE||DELIVERY_TIME >= vNEXT3_WORKING_DATE||'0800'
    AND RATIO = 100;
    

-- #Case Result is error
-- 2.)  Open CUR 1

    FOR rec1 IN
        SELECT *
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND PLAN_QTY > 0
                AND COMMENT_MSG <> 'WF0000'
    LOOP
        -- TODO: logic
BEGIN
    INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                    CASE WHEN REC1.CLASS = 'M/T' THEN '  ' ELSE NULL END,
                                    REC1.COMMENT_MSG,
                                    CURRENT_DATE,
                                    REC1.PLAN_DATE,
                                    REC1.PLAN_TIME,
                                    REC1.PART_NO,
                                    REC1.DIM,
                                    REC1.SUPPLIER_CD,
                                    REC1.RATIO,
                                    REC1.CLASS,
                                    REC1.LOGIC,
                                    REC1.CD_SPLY_FACT);
                        EXCEPTION WHEN OTHERS THEN NULL ;
END;		
    END LOOP; --END rec1

    FOR rec0 IN
        SELECT DISTINCT LOGIC 
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND COMMENT_MSG = 'WF0000'
    LOOP
        -- TODO: logic
	BEGIN --BEGIN 1
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
    FOR rec2 IN
        SELECT DISTINCT FACTORY_CD ,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,COMMENT_MSG,CD_SPLY_FACT
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE RATIO = 100
                AND PLAN_QTY > 0
                AND COMMENT_MSG = 'WF0000'
                AND PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN vNEXT_DEL||'0800' AND 
                                                                            (SELECT MIN(DT_WORK) FROM dosystem.WBGZT051 
                                                                            WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL)||'0759'
                AND LOGIC = REC0.LOGIC
                ORDER BY FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,COMMENT_MSG
    LOOP
        -- TODO: logic
                        BEGIN --BEGIN2
                            SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                            FROM T_PRD_DO_DELIVERY_MASTER
                                WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD IN (
                                 SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD FROM T_PRD_DO_DELIVERY_MASTER 
                                 WHERE  FACTORY_CD = REC2.FACTORY_CD
                                 AND SUPPLIER_CD = REC2.SUPPLIER_CD
                                 AND EFFECT_STA_DATE <= TO_CHAR(CURRENT_DATE,'YYYYMMDD')
                                 --AND CD_SPLY_FACT = REC2.CD_SPLY_FACT
                                 GROUP BY FACTORY_CD,SUPPLIER_CD);
                                
             
                            EXCEPTION WHEN NO_DATA_FOUND THEN                                                           
                                    vFLG_IN_HOUSE := NULL; 
                                    
                            END; --BEGIN2	
							
				IF (vFLG_IN_HOUSE = 'Y') THEN

    FOR rec3 IN
        SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN vNEXT_DEL||'0800' AND 
                                                                            (SELECT MIN(DT_WORK) FROM dosystem.WBGZT051 
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
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND
    LOOP
        -- TODO: logic
                                                     BEGIN
                                                            INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                                        CASE WHEN REC2.CLASS = 'M/T' THEN '    '
																		 ELSE REC2.USE_BLOCK_CD END,
                                                                        CASE WHEN REC2.CLASS = 'M/T' THEN '  ' 
																		 ELSE NULL END,
                                                                         NULL,
                                                                        'WF0000',
                                                                        CURRENT_DATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            EXCEPTION WHEN OTHERS THEN NULL ;
                                                        END; 
    END LOOP; --END rec3	
	
				ELSE

                                V_ROW_CNT := 0;
                                V_QT_BAL_PLAN := NULL;
                                V_QT_BAL_PO := 0;
                                -- 2.)  Open CUR 3
    FOR rec3 IN
        SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,CLASS,PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND,COMMENT_MSG,SUM(PLAN_QTY)AS PLAN_QTY,PLAN_DATE,PLAN_TIME
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE_REF_DEL_DATE||PLAN_TIME_REF_DEL_ROUND BETWEEN vNEXT_DEL||'0800' AND 
                                                                            (SELECT MIN(DT_WORK) FROM dosystem.WBGZT051 
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
                ORDER BY PLAN_DATE_REF_DEL_DATE,PLAN_TIME_REF_DEL_ROUND
    LOOP
        -- TODO: logic
		BEGIN --Begin3
                                     --Set Initial Data 
                                     V_QT_BAL_PLAN := REC3.PLAN_QTY;
                                      V_MIN_DT_DELV := '00000000';

                                     WHILE V_QT_BAL_PLAN > 0 AND ( V_MIN_DT_DELV <= REC3.PLAN_DATE )
                                     LOOP
                                    IF V_QT_BAL_PO = 0 THEN
                                            BEGIN
												SELECT *
												INTO
												    V_MIN_ROW_NUM,
												    v_DLV_KEY_NO,
												    V_QT_BAL_PO,
												    v_CD_DELV_PLACE,
												    V_MIN_DT_DELV
												FROM dosystem.p_prd_do_get_dlv_key_no(
												    REC2.FACTORY_CD,
												    REC2.PART_NO,
												    REC2.DIM,
												    REC2.USE_BLOCK_CD,
												    REC2.SUPPLIER_CD,
												    V_ROW_CNT::varchar,
												    REC3.PLAN_DATE_REF_DEL_DATE
												);
                                                            
                                                        EXCEPTION WHEN OTHERS THEN NULL ;
                                            END;
                                            
                                                    IF ( V_MIN_DT_DELV > REC3.PLAN_DATE OR V_MIN_DT_DELV IS NULL)THEN
                                                          V_QT_BAL_PO := 0;
                                                            BEGIN
                                                                        INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                                                    CASE WHEN REC2.CLASS = 'M/T' 
																						THEN '    ' 
																						ELSE REC2.USE_BLOCK_CD END,
                                                                                    CASE WHEN REC2.CLASS = 'M/T'
																						THEN '  '
																						ELSE NULL END,
                                                                                    'WF0020',
                                                                                    CURRENT_DATE,
                                                                                    REC3.PLAN_DATE,
                                                                                    REC3.PLAN_TIME,
                                                                                    REC2.PART_NO,
                                                                                    REC2.DIM,
                                                                                    REC2.SUPPLIER_CD,
                                                                                    100,
                                                                                    REC2.CLASS,
                                                                                    REC0.LOGIC,
                                                                                    REC2.CD_SPLY_FACT);
                                                                        EXCEPTION WHEN OTHERS THEN NULL ;
                                                                    END;
                                                	--แก้ 11/3/26
													-- [เพิ่ม 2 บรรทัดนี้ตรงนี้] --
										            V_QT_BAL_PO := NULL;
										            V_QT_BAL_PLAN := 0;
										            --------------------------
                                                    END IF;
                                            
                                        ELSIF  V_QT_BAL_PO > 0 THEN
                                            BEGIN
                                                IF V_QT_BAL_PLAN > V_QT_BAL_PO THEN
                                                    BEGIN
                                                        BEGIN
                                                            INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                                        CASE WHEN REC2.CLASS = 'M/T' 
																			THEN '    ' 
																		ELSE REC2.USE_BLOCK_CD END,
                                                                        CASE WHEN REC2.CLASS = 'M/T'
																			THEN '  '
																		ELSE NULL END,
                                                                        v_CD_DELV_PLACE,
                                                                        'WF0000',
                                                                        CURRENT_DATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            EXCEPTION WHEN OTHERS THEN NULL ;
                                                        END;
                                                        --Set Value
                                                        V_QT_BAL_PLAN := V_QT_BAL_PLAN - V_QT_BAL_PO;
                                                        V_QT_BAL_PO := 0;
                                                        V_ROW_CNT := V_MIN_ROW_NUM;
                                                        
                                                    END;
                                                
                                                ELSIF  V_QT_BAL_PLAN <= V_QT_BAL_PO THEN
                                                    BEGIN
                                                        BEGIN
                                                            INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                                        CASE WHEN REC2.CLASS = 'M/T' 
																			THEN '    ' 
																		ELSE REC2.USE_BLOCK_CD END,
                                                                        CASE WHEN REC2.CLASS = 'M/T'
																			THEN '  '
																		ELSE NULL END,
                                                                        v_CD_DELV_PLACE,
                                                                        'WF0000',
                                                                        CURRENT_DATE,
                                                                        REC3.PLAN_DATE,
                                                                        REC3.PLAN_TIME,
                                                                        REC2.PART_NO,
                                                                        REC2.DIM,
                                                                        REC2.SUPPLIER_CD,
                                                                        100,
                                                                        REC2.CLASS,
                                                                        REC0.LOGIC,
                                                                        REC2.CD_SPLY_FACT);
                                                            EXCEPTION WHEN OTHERS THEN NULL ;
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
                                                    INSERT INTO dosystem.T_PRD_DO_RESULT
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
                                                                CASE WHEN REC2.CLASS = 'M/T' 
																			THEN '    ' 
																 ELSE REC2.USE_BLOCK_CD END,
                                                                CASE WHEN REC2.CLASS = 'M/T'
																			THEN '  '
															     ELSE NULL END,
                                                                'WF0020',
                                                                CURRENT_DATE,
                                                                REC3.PLAN_DATE,
                                                                REC3.PLAN_TIME,
                                                                REC2.PART_NO,
                                                                REC2.DIM,
                                                                REC2.SUPPLIER_CD,
                                                                100,
                                                                REC2.CLASS,
                                                                REC0.LOGIC,
                                                                REC2.CD_SPLY_FACT);
                                                    EXCEPTION WHEN OTHERS THEN NULL ;
                                                END;
                                                --Set Value
												/*commemt 11/3/26
                                                V_QT_BAL_PO := NULL;
                                                V_QT_BAL_PLAN := 0;
												*/
                                            END;
											--แก้ 11/3/26
											V_QT_BAL_PLAN := 0;
                                        END IF;
                                     END LOOP; -- While

		END; --Begin3
    END LOOP; --END rec3	

	
				END IF;
    END LOOP; --END rec2
			
	END; --BEGIN1
    END LOOP; --END rec0
	
    RETURN 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_issue_do_rate100() OWNER TO dosystem;

--
-- Name: p_prd_do_make_plan_refer_dnm(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_make_plan_refer_dnm() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    vWORKSHIFT_CD_DAY    CHARACTER VARYING(50);
    vOVERTIME_CD_DAY     CHARACTER VARYING(50);
    vWORKSHIFT_CD_NIGHT  CHARACTER VARYING(50);
    vOVERTIME_CD_NIGHT   CHARACTER VARYING(50);
    vCAP_QTY             NUMERIC(15,0);
    vWORKINGTIME_MIN     NUMERIC(4);
    vOVERTIME_MIN        NUMERIC(4);
    vTOTALTIME_MIN       NUMERIC(8);
    vCAP_QTY_MIN         NUMERIC(15,6);
    vCNT_TIME            NUMERIC(2);
    vWORK_DATE_START     CHARACTER VARYING(8);
    vWORK_DATE_END       CHARACTER VARYING(8);
    vWORK_DATE_END2      CHARACTER VARYING(8);
    vWORK_DATE_END_TEMP  CHARACTER VARYING(8);
    vWORK_TIME_START     CHARACTER VARYING(5);
    vWORK_TIME_END       CHARACTER VARYING(5);
    vWORK_TIME_END2      CHARACTER VARYING(5);
    NEXT_PLAN            CHARACTER VARYING(20);
    vDATE_PLAN           CHARACTER VARYING(20);
    vWORK_BEGIN          CHARACTER VARYING(4);
    vWORK_END            CHARACTER VARYING(4);
    vCHK_DATE            CHARACTER VARYING(8);
    vSEQ                 CHARACTER VARYING(1);
    vFIRST_DATE          CHARACTER VARYING(20);
    vSECODE_DATE         CHARACTER VARYING(20);
    vTIME_CAL            NUMERIC(10);
    vCAP_QTY_HR          NUMERIC(15,2);
    vCAP_QTY_CHK         NUMERIC(15,2);
    vFLG                 NUMERIC(1);
    flag                 INTEGER := 0;

    -- ----------------------------------------------------------------
    -- C1: ดึง plan ที่ต้องคำนวณ (14 วันทำการข้างหน้า)
    -- ----------------------------------------------------------------
    c1 CURSOR FOR
        SELECT DISTINCT factory_cd, plan_date, shift, line_cd, cell_name,
               SUM(plan_qty) AS plan_qty
        FROM dosystem.t_prd_plan_a3_assy_plan
        WHERE plan_date >= TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
          AND plan_date <= (
              SELECT dt_work
              FROM (
                  SELECT ROW_NUMBER() OVER (ORDER BY dt_work) AS next_day, dt_work
                  FROM dosystem.wbgzt051
                  WHERE dt_work > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
                    AND mk_work = 'Y'
              ) sub
              WHERE next_day = 14
          )
        GROUP BY factory_cd, plan_date, shift, line_cd, cell_name
        ORDER BY factory_cd, plan_date, shift, line_cd, cell_name;

    rec1 RECORD;

    -- ----------------------------------------------------------------
    -- C2: ดึง time slot ของแต่ละ shift (work + overtime)
    --     *** แก้ไข: ใช้ตัวแปรที่ถูกต้องสำหรับ OVERTIME_CD ***
    -- ----------------------------------------------------------------
    /*c2 CURSOR FOR
        SELECT SEQ,
               -- แก้ไข: SUBSTR ใน PostgreSQL เริ่มที่ index 1 (ไม่ใช่ 0)
               SUBSTR(WORK_BEGIN, 1, 2) || SUBSTR(WORK_BEGIN, 4, 2) AS WORK_BEGIN,
               SUBSTR(WORK_END,   1, 2) || SUBSTR(WORK_END,   4, 2) AS WORK_END
        FROM (
            SELECT '1' AS SEQ, WORK1_BEGIN AS WORK_BEGIN, WORK1_END AS WORK_END
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND WORKSHIFT_CD = CASE WHEN rec1.SHIFT = 'D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND SHIFT = rec1.SHIFT

            UNION

            SELECT '2' AS SEQ, WORK2_BEGIN AS WORK_BEGIN, WORK2_END AS WORK_END
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND WORKSHIFT_CD = CASE WHEN rec1.SHIFT = 'D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND SHIFT = rec1.SHIFT

            UNION

            SELECT '3' AS SEQ, WORK3_BEGIN AS WORK_BEGIN, WORK3_END AS WORK_END
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND WORKSHIFT_CD = CASE WHEN rec1.SHIFT = 'D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND SHIFT = rec1.SHIFT

            UNION

            SELECT '4' AS SEQ, WORK4_BEGIN AS WORK_BEGIN, WORK4_END AS WORK_END
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND WORKSHIFT_CD = CASE WHEN rec1.SHIFT = 'D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND SHIFT = rec1.SHIFT

            UNION

            -- *** แก้ไข Bug: เปลี่ยนจาก vWORKSHIFT_CD_DAY/NIGHT เป็น vOVERTIME_CD_DAY/NIGHT ***
            SELECT '5' AS SEQ, OVERTIME_BEGIN AS WORK_BEGIN, OVERTIME_END AS WORK_END
            FROM dosystem.T_PRD_PLAN_A3_OVERTIME_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND OVERTIME_CD = CASE WHEN rec1.SHIFT = 'D' THEN vOVERTIME_CD_DAY ELSE vOVERTIME_CD_NIGHT END
              AND SHIFT = rec1.SHIFT

            ORDER BY SEQ
        ) time_slots;

    rec2 RECORD;
	*/

	c2 refcursor;
	  rec2  RECORD; 
BEGIN
    -- ----------------------------------------------------------------
    -- แก้ไข: statement_timeout ควรเป็นหน่วย ms (0 = ไม่ timeout)
    --        ค่าเดิม 10 = 10ms ซึ่งน้อยมากจนอาจ timeout ก่อนทำงานเสร็จ
    -- ----------------------------------------------------------------
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';

    -- แก้ไข: ใช้ TRUNCATE แทน DELETE (เร็วกว่าสำหรับลบทั้งตาราง)
    TRUNCATE TABLE dosystem.T_DO_PLAN_PLANBYSHIFT;

    OPEN c1;
    LOOP
        FETCH c1 INTO rec1;
        EXIT WHEN NOT FOUND;

        -- ----------------------------------------------------------------
        -- ดึง WORKSHIFT_CD และ OVERTIME_CD สำหรับ factory/date/line/shift นี้
        -- ----------------------------------------------------------------
        BEGIN
            SELECT DISTINCT WORKSHIFT_CD_DAY, OVERTIME_CD_DAY,
                            WORKSHIFT_CD_NIGHT, OVERTIME_CD_NIGHT
            INTO vWORKSHIFT_CD_DAY, vOVERTIME_CD_DAY,
                 vWORKSHIFT_CD_NIGHT, vOVERTIME_CD_NIGHT
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_N_CAP
            WHERE FACTORY_CD = rec1.FACTORY_CD
              AND PLAN_DATE  = rec1.PLAN_DATE
              AND SUBSTR(LINE_CD, 1, 2) = rec1.LINE_CD   -- แก้ไข: SUBSTR เริ่มที่ 1
              AND SHIFT      = rec1.SHIFT;

            IF NOT FOUND THEN
                vWORKSHIFT_CD_DAY   := NULL;
                vOVERTIME_CD_DAY    := NULL;
                vWORKSHIFT_CD_NIGHT := NULL;
                vOVERTIME_CD_NIGHT  := NULL;
                vCAP_QTY            := 0;
            END IF;
        END;

        vCAP_QTY_HR  := 0;
        vCAP_QTY     := COALESCE(rec1.PLAN_QTY, 0);
        vCAP_QTY_CHK := vCAP_QTY;

        -- ดึงเวลาทำงานปกติ (WORKSHIFT)
        BEGIN
            SELECT COALESCE(WORKINGTIME_MIN, 0)
            INTO vWORKINGTIME_MIN
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE FACTORY_CD  = rec1.FACTORY_CD
              AND WORKSHIFT_CD = CASE WHEN rec1.SHIFT = 'D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND SHIFT        = rec1.SHIFT;

            IF NOT FOUND THEN
                vWORKINGTIME_MIN := 0;
            END IF;
        END;

        -- ดึงเวลา overtime
        BEGIN
            SELECT COALESCE(WORKINGTIME_MIN, 0)
            INTO vOVERTIME_MIN
            FROM dosystem.T_PRD_PLAN_A3_OVERTIME_CD
            WHERE FACTORY_CD = rec1.FACTORY_CD
              -- *** แก้ไข: ใช้ vOVERTIME_CD_DAY/NIGHT (ไม่ใช่ vWORKSHIFT_CD) ***
              AND OVERTIME_CD = CASE WHEN rec1.SHIFT = 'D' THEN vOVERTIME_CD_DAY ELSE vOVERTIME_CD_NIGHT END
              AND SHIFT       = rec1.SHIFT;

            IF NOT FOUND THEN
                vOVERTIME_MIN := 0;
            END IF;
        END;

        -- รวมเวลาทั้งหมด (นาที)
        vTOTALTIME_MIN := COALESCE(vWORKINGTIME_MIN, 0) + COALESCE(vOVERTIME_MIN, 0);

        -- คำนวณ capacity ต่อนาที
        IF COALESCE(vCAP_QTY, 0) <> 0 AND COALESCE(vTOTALTIME_MIN, 0) <> 0 THEN
            vCAP_QTY_MIN := COALESCE(vCAP_QTY, 0) / COALESCE(vTOTALTIME_MIN, 0);
        ELSE
            vCAP_QTY_MIN := 0;
        END IF;

        vWORK_TIME_START := NULL;
        vWORK_TIME_END   := NULL;
        vWORK_DATE_START := rec1.PLAN_DATE;
        vWORK_DATE_END   := NULL;
        vCHK_DATE        := NULL;

        IF vTOTALTIME_MIN <> 0 THEN

    OPEN c2 FOR
        SELECT seq,
               SUBSTR(work_begin,1,2) || SUBSTR(work_begin,4,2) AS work_begin,
               SUBSTR(work_end,1,2)   || SUBSTR(work_end,4,2)   AS work_end
        FROM (
            SELECT '1' AS seq, work1_begin AS work_begin, work1_end AS work_end
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE factory_cd   = rec1.factory_cd
              AND workshift_cd = CASE WHEN rec1.shift='D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND shift        = rec1.shift
            UNION ALL
            SELECT '2', work2_begin, work2_end
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE factory_cd   = rec1.factory_cd
              AND workshift_cd = CASE WHEN rec1.shift='D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND shift        = rec1.shift
            UNION ALL
            SELECT '3', work3_begin, work3_end
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE factory_cd   = rec1.factory_cd
              AND workshift_cd = CASE WHEN rec1.shift='D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND shift        = rec1.shift
            UNION ALL
            SELECT '4', work4_begin, work4_end
            FROM dosystem.T_PRD_PLAN_A3_WORKSHIFT_CD
            WHERE factory_cd   = rec1.factory_cd
              AND workshift_cd = CASE WHEN rec1.shift='D' THEN vWORKSHIFT_CD_DAY ELSE vWORKSHIFT_CD_NIGHT END
              AND shift        = rec1.shift
            UNION ALL
            SELECT '5', overtime_begin, overtime_end
            FROM dosystem.T_PRD_PLAN_A3_OVERTIME_CD
            WHERE factory_cd  = rec1.factory_cd
              AND overtime_cd = CASE WHEN rec1.shift='D' THEN vOVERTIME_CD_DAY ELSE vOVERTIME_CD_NIGHT END
              AND shift       = rec1.shift
            ORDER BY seq
        ) time_slots;


			
            LOOP
                FETCH c2 INTO rec2;
                EXIT WHEN NOT FOUND;

                vFLG := 0;

                IF rec2.WORK_BEGIN IS NOT NULL THEN

                    vWORK_TIME_START := rec2.WORK_BEGIN;

                    WHILE (vFLG = 0) LOOP

                        -- ถ้าเวลาเริ่มอยู่ช่วง 00-07 ให้ใช้วันถัดไป (กะกลางคืน)
                        IF vWORK_TIME_START BETWEEN '0000' AND '0700' THEN
                            -- แก้ไข: ใช้ INTERVAL '1 day' แทน +1
                            SELECT TO_CHAR(TO_DATE(rec1.PLAN_DATE, 'YYYYMMDD') + INTERVAL '1 day', 'YYYYMMDD')
                            INTO vWORK_DATE_START;
                        END IF;

                        -- สร้าง timestamp เริ่มต้น (ปัดนาทีเป็น xx:00)
                        -- แก้ไข: SUBSTR เริ่มที่ 1
                        NEXT_PLAN := vWORK_DATE_START || ' ' || SUBSTR(vWORK_TIME_START, 1, 2) || '00';

                        -- คำนวณเวลาสิ้นสุด (+1 ชั่วโมง)
                        -- แก้ไข: TO_TIMESTAMP + INTERVAL '1 hour' แทน TO_DATE + 1/24
                        SELECT SUBSTR(NEXT_PLAN_VAL, 1, 8), SUBSTR(NEXT_PLAN_VAL, 10, 4)
                        INTO vWORK_DATE_END, vWORK_TIME_END
                        FROM (
                            SELECT TO_CHAR(
                                TO_TIMESTAMP(NEXT_PLAN, 'YYYYMMDD HH24MI') + INTERVAL '1 hour',
                                'YYYYMMDD HH24MI'
                            ) AS NEXT_PLAN_VAL
                        ) t;

                        -- กรณีข้ามวัน: เวลาสิ้นสุดอยู่ในช่วง 20-23 แต่ WORK_END อยู่ 00-07
                        IF (SUBSTR(vWORK_TIME_END, 1, 2) BETWEEN '20' AND '23')
                           AND (SUBSTR(rec2.WORK_END, 1, 2) BETWEEN '00' AND '07') THEN

                            -- แก้ไข: ใช้ INTERVAL '1 day' แทน -1
                            SELECT TO_CHAR(TO_DATE(vWORK_DATE_END, 'YYYYMMDD') - INTERVAL '1 day', 'YYYYMMDD')
                            INTO vCHK_DATE;

                            IF vCHK_DATE || vWORK_TIME_END > vWORK_DATE_END || rec2.WORK_END THEN
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || rec2.WORK_END;
                                vWORK_TIME_END := vWORK_TIME_END;
                                vFLG := 1;

                            ELSIF vWORK_TIME_END = rec2.WORK_END THEN
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || vWORK_TIME_END;
                                vFLG := 1;

                            ELSE
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || vWORK_TIME_END;
                            END IF;

                        ELSE
                            IF vWORK_TIME_END > rec2.WORK_END THEN
                                -- เวลา slot เกิน work_end แล้ว
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || rec2.WORK_END;
                                vWORK_TIME_END := vWORK_TIME_END;
                                vFLG := 1;

                            ELSIF vWORK_TIME_END = rec2.WORK_END THEN
                                -- เวลาพอดี
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || vWORK_TIME_END;
                                vFLG := 1;

                            ELSE
                                -- ยังไม่ถึง work_end ให้วนต่อ
                                vFIRST_DATE  := vWORK_DATE_START || ' ' || vWORK_TIME_START;
                                vSECODE_DATE := vWORK_DATE_END   || ' ' || vWORK_TIME_END;
                            END IF;
                        END IF;

                        -- ตรวจสอบ boundary กรณีข้ามเที่ยงคืน (00 / 23)
                        IF SUBSTR(vWORK_TIME_END, 1, 2) = '00' AND SUBSTR(rec2.WORK_END, 1, 2) = '23' THEN
                            IF vSECODE_DATE > vWORK_DATE_START || ' ' || rec2.WORK_END THEN
                                vWORK_TIME_END := rec2.WORK_END;
                                vSECODE_DATE   := vWORK_DATE_START || ' ' || vWORK_TIME_END;
                            END IF;
                        ELSE
                            IF rec2.WORK_END BETWEEN '0000' AND '0700' THEN
                                -- แก้ไข: ใช้ INTERVAL '1 day' แทน +1
                                SELECT TO_CHAR(TO_DATE(rec1.PLAN_DATE, 'YYYYMMDD') + INTERVAL '1 day', 'YYYYMMDD')
                                INTO vWORK_DATE_END_TEMP;
                            ELSE
                                vWORK_DATE_END_TEMP := vWORK_DATE_END;
                            END IF;

                            IF vSECODE_DATE > vWORK_DATE_END_TEMP || ' ' || rec2.WORK_END THEN
                                vWORK_TIME_END := rec2.WORK_END;
                                vSECODE_DATE   := vWORK_DATE_END_TEMP || ' ' || vWORK_TIME_END;
                            END IF;
                        END IF;

                        -- คำนวณจำนวนนาทีใน slot นี้
                        -- แก้ไข: ใช้ EXTRACT EPOCH สำหรับ timestamp diff ใน PostgreSQL
                        SELECT COALESCE(ROUND(
                            EXTRACT(EPOCH FROM (
                                TO_TIMESTAMP(vSECODE_DATE, 'YYYYMMDD HH24MI') -
                                TO_TIMESTAMP(vFIRST_DATE,  'YYYYMMDD HH24MI')
                            )) / 60, 2), 0)
                        INTO vTIME_CAL;

                        -- คำนวณ plan qty ใน slot นี้
                        vCAP_QTY_HR := CEIL(COALESCE(vTIME_CAL, 0) * COALESCE(vCAP_QTY_MIN, 0));

                        IF vCAP_QTY_CHK < vCAP_QTY_HR THEN
                            -- qty ที่เหลือน้อยกว่า slot capacity → ใช้ qty ที่เหลือ
                            vCAP_QTY_HR  := vCAP_QTY_CHK;
                            vFLG         := 1;
                            vCAP_QTY_CHK := 0;

                        ELSIF vCAP_QTY_CHK = vCAP_QTY_HR THEN
                            -- qty ที่เหลือเท่ากับ slot capacity → จบพอดี
                            vFLG         := 1;
                            vCAP_QTY_CHK := 0;

                        ELSE
                            -- qty ที่เหลือมากกว่า slot capacity → หัก qty และวนต่อ
                            vCAP_QTY_CHK := vCAP_QTY_CHK - vCAP_QTY_HR;
                        END IF;

                        IF vCAP_QTY_HR <> 0 THEN

                            -- แก้ไข: SUBSTR เริ่มที่ 1 ทุกจุด
                            IF SUBSTR(vWORK_TIME_START, 1, 2) || '00' = SUBSTR(vWORK_TIME_END, 1, 2) || '00' THEN
                                -- กรณี start/end อยู่ใน hour เดียวกัน → ใช้ end ของ hour ถัดไป
                                SELECT SUBSTR(NEXT_PLAN_VAL2, 1, 8), SUBSTR(NEXT_PLAN_VAL2, 10, 4)
                                INTO vWORK_DATE_END2, vWORK_TIME_END2
                                FROM (
                                    -- แก้ไข: TO_TIMESTAMP + INTERVAL '1 hour' แทน TO_DATE + 1/24
                                    SELECT TO_CHAR(
                                        TO_TIMESTAMP(vWORK_DATE_START || ' ' || SUBSTR(vWORK_TIME_START, 1, 2) || '00',
                                                'YYYYMMDD HH24MI') + INTERVAL '1 hour',
                                        'YYYYMMDD HH24MI'
                                    ) AS NEXT_PLAN_VAL2
                                ) t;

                                BEGIN
                                    PERFORM dosystem.p_prd_do_plan_planbyshift_ins(
                                        rec1.FACTORY_CD,
                                        vWORK_DATE_START,
                                        SUBSTR(vWORK_TIME_START, 1, 2) || '00' :: character varying,
                                        vWORK_DATE_END,
                                        vWORK_TIME_END2,
                                        rec1.SHIFT,
                                        rec1.LINE_CD,
                                        vCAP_QTY_HR,
                                        rec1.PLAN_DATE
                                    );
                                --EXCEPTION
                                --    WHEN OTHERS THEN NULL;
                                END;

                            ELSE
                                -- กรณีปกติ: start/end ต่าง hour กัน
                                BEGIN
                                    PERFORM dosystem.p_prd_do_plan_planbyshift_ins(
                                        rec1.FACTORY_CD,
                                        vWORK_DATE_START,
                                        SUBSTR(vWORK_TIME_START, 1, 2) || '00' :: character varying,
                                        vWORK_DATE_END,
                                        SUBSTR(vWORK_TIME_END, 1, 2) || '00' :: character varying,
                                        rec1.SHIFT,
                                        rec1.LINE_CD,
                                        vCAP_QTY_HR,
                                        rec1.PLAN_DATE
                                    );
                                --EXCEPTION
                                --    WHEN OTHERS THEN NULL;
                                END;
                            END IF;

                        ELSE
                            -- qty = 0 → หยุด loop
                            vFLG := 1;
                        END IF;

                        vWORK_TIME_START := vWORK_TIME_END;
                        vWORK_DATE_START := vWORK_DATE_END;

                        -- ถ้าเวลา start ถึง work_end แล้ว → หยุด
                        IF vWORK_TIME_START >= rec2.WORK_END THEN
                            IF SUBSTR(vWORK_TIME_START, 1, 2) <> '23'
                               AND SUBSTR(rec2.WORK_END, 1, 2) <> '00' THEN
                                vFLG := 1;
                            END IF;
                        END IF;

                    END LOOP; -- WHILE vFLG = 0

                END IF; -- rec2.WORK_BEGIN IS NOT NULL

            END LOOP; -- Loop c2
            CLOSE c2;

        END IF; -- vTOTALTIME_MIN <> 0

    END LOOP; -- Loop c1
    CLOSE c1;

    RETURN vFLG;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_make_plan_refer_dnm() OWNER TO dosystem;

--
-- Name: p_prd_do_make_plan_refer_lt(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_make_plan_refer_lt() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    vFLG                NUMERIC(3);
    vTOTAL_PLAN_QTY     NUMERIC(6);
    vTOTAL_PROCESS_LT   NUMERIC(6);
    vPLAN_DATE_RF_LT    CHARACTER VARYING(8);
    vPLAN_TIME_RF_LT    CHARACTER VARYING(4);
    vPLAN_DATE_LT_SLIDE CHARACTER VARYING(8);
    vPLAN_TIME_LT_SLIDE CHARACTER VARYING(4);
    l_sql               CHARACTER VARYING(1000);
    vNext_work          CHARACTER VARYING(8);
    vNext7_work         CHARACTER VARYING(8);
    c1 CURSOR FOR
        SELECT DISTINCT PLAN_DATE, PLAN_TIME, TOTAL_PROCESS_LT
        FROM dosystem.T_DO_PLAN_PLAN_PART_BYHOUSR
        WHERE PLAN_DATE||PLAN_TIME >= (
            SELECT MIN(dt_work) FROM dosystem.wbgzt051
            WHERE dt_work > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
              AND mk_work = 'Y'
        )||'0800'
          AND PLAN_QTY <> 0
        ORDER BY PLAN_DATE, PLAN_TIME;
    rec1 RECORD;
BEGIN
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';

    SELECT MIN(dt_work) INTO vNext_work
    FROM dosystem.wbgzt051
    WHERE dt_work > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
      AND mk_work = 'Y';

    SELECT DT_WORK INTO vNext7_work
    FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY DT_WORK) AS CNT, DT_WORK
        FROM dosystem.wbgzt051
        WHERE dt_work > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
          AND mk_work = 'Y'
    ) sub
    WHERE CNT = 14;

    DELETE FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT;

    OPEN c1;
    LOOP
        FETCH c1 INTO rec1;
        EXIT WHEN NOT FOUND;

        -- ใช้ STRICT เพื่อให้ raise NO_DATA_FOUND เหมือน Oracle
        BEGIN
            SELECT DT_PLAN, PLAN_TIME
              INTO STRICT vPLAN_DATE_RF_LT, vPLAN_TIME_RF_LT
            FROM (
                SELECT ROW_NUMBER() OVER (ORDER BY DT_PLAN DESC, PLAN_TIME DESC) AS SLIDE_LT,
                       PLAN_TIME, DT_PLAN
                FROM dosystem.V_DO_WORKING_TIME
                WHERE DT_PLAN||PLAN_TIME < rec1.PLAN_DATE||rec1.PLAN_TIME
            ) sub
            WHERE SLIDE_LT = rec1.TOTAL_PROCESS_LT;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            CONTINUE;
        END;

        INSERT INTO dosystem.T_DO_PLAN_PART_REF_PROCESS_LT (
            FACTORY_CD, PART_NO, DIM, TOTAL_PROCESS_LT, CLASS,
            PLAN_QTY, PLAN_DATE, PLAN_TIME,
            PLAN_DATE_RF_LT, PLAN_TIME_RF_LT,
            USE_BLOCK_CD, CREATE_DATE, LOGIC
        )
        SELECT
            FACTORY_CD, PART_NO, DIM, TOTAL_PROCESS_LT, CLASS,
            ROUND(SUM(PLAN_QTY), 4) AS PLAN_QTY,
            PLAN_DATE, PLAN_TIME,
            vPLAN_DATE_RF_LT AS PLAN_DATE_RF_LT,
            vPLAN_TIME_RF_LT AS PLAN_TIME_RF_LT,
            BLOCK_CD_NEW AS USE_BLOCK_CD,
            CURRENT_TIMESTAMP AS CREATE_DATE,
            LOGIC
        FROM (
            SELECT DISTINCT
                FACTORY_CD, PART_NO, DIM, BLOCK_CD,
                CASE WHEN CLASS = 'M/T' THEN '8888'
                     ELSE BLOCK_CD
                END AS BLOCK_CD_NEW,
                CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY,
                TOTAL_PROCESS_LT, MERCHANDISE_CD, LOGIC
            FROM dosystem.T_DO_PLAN_PLAN_PART_BYHOUSR
            WHERE PLAN_DATE        = rec1.PLAN_DATE
              AND PLAN_TIME        = rec1.PLAN_TIME
              AND TOTAL_PROCESS_LT = rec1.TOTAL_PROCESS_LT
              AND RK_PRIO_DIVI     = '1'
        ) A
        GROUP BY FACTORY_CD, PART_NO, DIM, BLOCK_CD_NEW, CLASS,
                 PLAN_DATE, PLAN_TIME, TOTAL_PROCESS_LT, LOGIC;

    END LOOP;
    CLOSE c1;

    -- Support A and Z plan
    INSERT INTO dosystem.T_DO_PLAN_PART_REF_PROCESS_LT (
        FACTORY_CD, PART_NO, DIM, TOTAL_PROCESS_LT, CLASS,
        PLAN_QTY, PLAN_DATE, PLAN_TIME,
        PLAN_DATE_RF_LT, PLAN_TIME_RF_LT,
        USE_BLOCK_CD, CREATE_DATE, LOGIC
    )
    SELECT
        FACTORY_CD, NO_PARTS, NO_ADJ_DIM, TOTAL_PROCESS_LT, CLASS,
        ROUND(PLAN_QTY, 4),
        PLAN_DATE, PLAN_TIME,
        PLAN_DATE, PLAN_TIME,
        CD_USE_BLOCK, CURRENT_TIMESTAMP, LOGIC
    FROM dosystem.V_DO_PLAN_A_AND_Z
    WHERE PLAN_DATE BETWEEN vNext_work AND vNext7_work;

    -- Support Main body
    INSERT INTO dosystem.T_DO_PLAN_PART_REF_PROCESS_LT (
        FACTORY_CD, PART_NO, DIM, TOTAL_PROCESS_LT, CLASS,
        PLAN_QTY, PLAN_DATE, PLAN_TIME,
        PLAN_DATE_RF_LT, PLAN_TIME_RF_LT,
        USE_BLOCK_CD, CREATE_DATE, LOGIC
    )
    SELECT
        FACTORY_CD, NO_PARTS, NO_ADJ_DIM, TOTAL_PROCESS_LT, CLASS,
        ROUND(PLAN_QTY, 4),
        PLAN_DATE, PLAN_TIME,
        PLAN_DATE, PLAN_TIME,
        CD_USE_BLOCK, CURRENT_TIMESTAMP, LOGIC
    FROM dosystem.V_DO_PLAN_MAIN_AND_BODY
    WHERE PLAN_DATE BETWEEN vNext_work AND vNext7_work;

    RETURN 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_make_plan_refer_lt() OWNER TO dosystem;

--
-- Name: p_prd_do_over_std_stock(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_over_std_stock() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    vnext_working_date  CHARACTER VARYING(8);
    vnext2_working_date CHARACTER VARYING(8);
    vnext3_working_date CHARACTER VARYING(8);
    vnext_del           CHARACTER VARYING(8);
    v_qt_invent         NUMERIC(20,4);
    v_qt_delv           NUMERIC(20,4);
    qt_delv_do          NUMERIC(20,4);
    qt_delv_ui          NUMERIC(20,4);
    v_qt_plan_today     NUMERIC(20,4);
    v_qty_stock_nextday NUMERIC(20,4);
    v_std_stock         NUMERIC(20,4);
    v_over_std_stock    NUMERIC(20,4);
    vtotal_process_lt   NUMERIC(6);
    vplan_date_rf_lt    CHARACTER VARYING(8);
    vplan_time_rf_lt    CHARACTER VARYING(4);
    vworking_day_chk    NUMERIC(1);
    vflg                NUMERIC(3);
    vqty_morning        NUMERIC(20);
    plan_qty_a          NUMERIC(20,4);
    plan_qty_main       NUMERIC(20,4);

    c1 CURSOR FOR
        SELECT DISTINCT FACTORY_CD, PART_NO, DIM,
            CASE WHEN CLASS = 'M/C' THEN BLOCK_CD ELSE '8888' END AS USE_BLOCK_CD,
            LOGIC, CLASS, MAX(TOTAL_PROCESS_LT) AS TOTAL_PROCESS_LT
        FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
        GROUP BY FACTORY_CD, PART_NO, DIM,
            CASE WHEN CLASS = 'M/C' THEN BLOCK_CD ELSE '8888' END,
            LOGIC, CLASS;

    rec1 RECORD;

BEGIN
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';

    -- A.) Delete data
    DELETE FROM dosystem.T_DO_PLAN_STD_STOCK;

    -- B.) Get Next Working dates
    SELECT MIN(DT_WORK) INTO vnext_working_date
    FROM dosystem.WBGZT051
    WHERE DT_WORK > TO_CHAR(CURRENT_DATE, 'YYYYMMDD') AND MK_WORK = 'Y';

    SELECT MIN(DT_WORK) INTO vnext2_working_date
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vnext_working_date AND MK_WORK = 'Y';

    SELECT MIN(DT_WORK) INTO vnext3_working_date
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vnext2_working_date AND MK_WORK = 'Y';

    -- ✅ Cache V_DO_PLAN_PART_FOR_FC (ไม่มี lower bound เพื่อครอบคลุมทุก logic)
    DROP TABLE IF EXISTS temp_plan_part_for_fc;
    CREATE TEMP TABLE temp_plan_part_for_fc AS
    SELECT FACTORY_CD, PART_NO, DIM, USE_BLOCK, CLASS, PLAN_DATE, PLAN_QTY
    FROM dosystem.V_DO_PLAN_PART_FOR_FC
    WHERE PLAN_DATE <= TO_CHAR(CURRENT_DATE + 30, 'YYYYMMDD');

    CREATE INDEX idx_temp_plan_fc ON temp_plan_part_for_fc
        (FACTORY_CD, PART_NO, DIM, USE_BLOCK, CLASS, PLAN_DATE);

    -- ✅ Cache V_DO_PLAN_A_AND_Z (ไม่มี date filter — ครอบคลุม plan_date เก่าทุก logic)
    DROP TABLE IF EXISTS temp_plan_a_and_z;
    CREATE TEMP TABLE temp_plan_a_and_z AS
    SELECT DISTINCT
        FACTORY_CD, NO_PARTS, NO_ADJ_DIM, CD_USE_BLOCK,
        CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY, TOTAL_PROCESS_LT, LOGIC
    FROM dosystem.V_DO_PLAN_A_AND_Z;

    CREATE INDEX idx_temp_plan_az ON temp_plan_a_and_z
        (FACTORY_CD, NO_PARTS, NO_ADJ_DIM, CD_USE_BLOCK, CLASS, PLAN_DATE);

    -- ✅ Cache V_DO_PLAN_MAIN_AND_BODY (ไม่มี date filter — ครอบคลุม plan_date เก่าทุก logic)
    DROP TABLE IF EXISTS temp_plan_main;
    CREATE TEMP TABLE temp_plan_main AS
    SELECT
        FACTORY_CD, NO_PARTS, NO_ADJ_DIM, CD_USE_BLOCK,
        CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY, TOTAL_PROCESS_LT, LOGIC
    FROM dosystem.V_DO_PLAN_MAIN_AND_BODY;

    CREATE INDEX idx_temp_plan_main ON temp_plan_main
        (FACTORY_CD, NO_PARTS, NO_ADJ_DIM, CD_USE_BLOCK, CLASS, PLAN_DATE);

    OPEN c1;
    LOOP
        FETCH c1 INTO rec1;
        EXIT WHEN NOT FOUND;

        -- Set vNEXT_DEL by LOGIC
        IF rec1.LOGIC = '1' THEN
            vnext_del := vnext_working_date;
        ELSIF rec1.LOGIC = '2' THEN
            vnext_del := vnext2_working_date;
        ELSIF rec1.LOGIC = '3' THEN
            vnext_del := vnext3_working_date;
        END IF;

        -- 1.1 Get Inventory
        IF rec1.USE_BLOCK_CD = '8888' THEN
            SELECT ROUND(COALESCE(SUM(QT_INVENT), 0), 4) INTO v_qt_invent
            FROM dosystem.T_INV_DAILY_WIP_E001
            WHERE NO_PARTS = rec1.PART_NO
              AND NO_ADJ_DIM = rec1.DIM
              AND (CD_BLOCK IN (
                      SELECT DISTINCT BLOCK_CD
                      FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
                      WHERE FACTORY_CD = rec1.FACTORY_CD
                        AND PART_NO = rec1.PART_NO
                        AND DIM = rec1.DIM
                  ) OR CD_BLOCK = '8888')
              AND MK_MRP_OBJ = 'Y';
        ELSE
            SELECT ROUND(COALESCE(SUM(QT_INVENT), 0), 4) INTO v_qt_invent
            FROM dosystem.T_INV_DAILY_WIP_E001
            WHERE NO_PARTS = rec1.PART_NO
              AND NO_ADJ_DIM = rec1.DIM
              AND CD_BLOCK = rec1.USE_BLOCK_CD
              AND MK_MRP_OBJ = 'Y';

            IF v_qt_invent IS NULL THEN
                v_qt_invent := 0;
            END IF;
        END IF;

        -- 1.2 Get Delivery Order
        IF rec1.USE_BLOCK_CD = '8888' THEN
            BEGIN
                SELECT ROUND(COALESCE(SUM(QT_ACPTC_BAL), 0), 4) INTO qt_delv_do
                FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
                WHERE NO_PARTS = rec1.PART_NO
                  AND NO_ADJ_DIM = rec1.DIM
                  AND NM_ARGMET_STAT = 'DO' AND MK_SUM_FLG = '1'
                  AND DT_DELV||TM_DELV < vnext_del||'080000'
                  AND CD_USE_BLOCK = '      ';
            EXCEPTION WHEN NO_DATA_FOUND THEN
                qt_delv_do := 0;
            END;

            BEGIN
                SELECT ROUND(COALESCE(SUM(QT_ACPTC_BAL), 0), 4) INTO qt_delv_ui
                FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
                WHERE NO_PARTS = rec1.PART_NO
                  AND NO_ADJ_DIM = rec1.DIM
                  AND NM_ARGMET_STAT = 'UI' AND MK_SUM_FLG = '1'
                  AND DT_DELV||TM_DELV < vnext_del||'080000'
                  AND CD_USE_BLOCK = '      ';
            EXCEPTION WHEN NO_DATA_FOUND THEN
                qt_delv_ui := 0;
            END;
        ELSE
            BEGIN
                -- ✅ แก้ไข: QT_DELV_DIRCT → QT_ACPTC_BAL ให้ตรงกับ Oracle
                SELECT ROUND(COALESCE(SUM(QT_ACPTC_BAL), 0), 4) INTO qt_delv_do
                FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
                WHERE NO_PARTS = rec1.PART_NO
                  AND NO_ADJ_DIM = rec1.DIM
                  AND NM_ARGMET_STAT = 'DO' AND MK_SUM_FLG = '1'
                  AND DT_DELV||TM_DELV < vnext_del||'080000'
                  AND CD_USE_BLOCK = rec1.USE_BLOCK_CD;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                qt_delv_do := 0;
            END;

            BEGIN
                SELECT ROUND(COALESCE(SUM(QT_ACPTC_BAL), 0), 4) INTO qt_delv_ui
                FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
                WHERE NO_PARTS = rec1.PART_NO
                  AND NO_ADJ_DIM = rec1.DIM
                  AND NM_ARGMET_STAT = 'UI' AND MK_SUM_FLG = '1'
                  AND DT_DELV||TM_DELV < vnext_del||'080000'
                  AND CD_USE_BLOCK = rec1.USE_BLOCK_CD;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                qt_delv_ui := 0;
            END;
        END IF;

        v_qt_delv := ROUND((qt_delv_do + qt_delv_ui), 4);

        -- 1.3 Get Plan Today (จาก temp table)
        SELECT ROUND(COALESCE(SUM(PLAN_QTY), 0), 4) INTO v_qt_plan_today
        FROM temp_plan_part_for_fc
        WHERE FACTORY_CD = rec1.FACTORY_CD
          AND PART_NO = rec1.PART_NO
          AND DIM = rec1.DIM
          AND USE_BLOCK = rec1.USE_BLOCK_CD
          AND CLASS = rec1.CLASS
          AND PLAN_DATE >= TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
          AND PLAN_DATE < vnext_del;

        -- Support A and Z plan (จาก temp table ที่ไม่มี date filter)
        SELECT ROUND(SUM(COALESCE(PLAN_QTY, 0)), 4) INTO plan_qty_a
        FROM temp_plan_a_and_z
        WHERE FACTORY_CD = rec1.FACTORY_CD
          AND NO_PARTS = rec1.PART_NO
          AND NO_ADJ_DIM = rec1.DIM
          AND CD_USE_BLOCK = rec1.USE_BLOCK_CD
          AND CLASS = rec1.CLASS
          AND PLAN_DATE < vnext_del;

        IF plan_qty_a IS NULL THEN
            plan_qty_a := 0;
        END IF;

        -- Support Main and Body plan (จาก temp table ที่ไม่มี date filter)
        SELECT ROUND(SUM(COALESCE(PLAN_QTY, 0)), 4) INTO plan_qty_main
        FROM temp_plan_main
        WHERE FACTORY_CD = rec1.FACTORY_CD
          AND NO_PARTS = rec1.PART_NO
          AND NO_ADJ_DIM = rec1.DIM
          AND CD_USE_BLOCK = rec1.USE_BLOCK_CD
          AND CLASS = rec1.CLASS
          AND PLAN_DATE < vnext_del;

        IF plan_qty_main IS NULL THEN
            plan_qty_main := 0;
        END IF;

        -- 1.4 Calculate Stock next day
        v_qty_stock_nextday := ROUND(
            (COALESCE(v_qt_invent, 0) + COALESCE(v_qt_delv, 0)) -
            (COALESCE(v_qt_plan_today, 0) + COALESCE(plan_qty_main, 0) + COALESCE(plan_qty_a, 0)),
        4);

        -- 1.5 Get TOTAL_PROCESS_LT
        vtotal_process_lt := rec1.TOTAL_PROCESS_LT;

        -- 1.5.2 Get Plan date and Plan Time
        -- ✅ แก้ไข: เพิ่ม ORDER BY ใน OVER()
        BEGIN
            SELECT DT_PLAN, PLAN_TIME INTO vplan_date_rf_lt, vplan_time_rf_lt
            FROM (
                SELECT ROW_NUMBER() OVER (ORDER BY DT_PLAN||PLAN_TIME ASC) AS NUM_ROW,
                       PLAN_TIME, DT_PLAN
                FROM dosystem.V_DO_WORKING_TIME
                WHERE DT_PLAN||PLAN_TIME >= vnext_del||'0800'
            ) sub
            WHERE NUM_ROW = COALESCE(vtotal_process_lt, 0);
        EXCEPTION WHEN NO_DATA_FOUND THEN
            vplan_date_rf_lt := NULL;
            vplan_time_rf_lt := NULL;
        END;

        -- 1.5.3 Get Summary plan (STD Stock)
        SELECT ROUND(COALESCE(SUM(PLAN_QTY), 0), 4) INTO v_std_stock
        FROM dosystem.T_DO_PLAN_PLAN_PART_BYHOUSR_BF
        WHERE FACTORY_CD = rec1.FACTORY_CD
          AND PART_NO = rec1.PART_NO
          AND DIM = rec1.DIM
          AND BLOCK_CD = rec1.USE_BLOCK_CD
          AND LOGIC = rec1.LOGIC
          AND RK_PRIO_DIVI IN (
              SELECT MIN(RK_PRIO_DIVI)
              FROM dosystem.T_DO_PLAN_PLAN_PART_BYHOUSR_BF
              WHERE FACTORY_CD = rec1.FACTORY_CD
                AND PART_NO = rec1.PART_NO
                AND DIM = rec1.DIM
                AND BLOCK_CD = rec1.USE_BLOCK_CD
                AND LOGIC = rec1.LOGIC
          )
          AND PLAN_DATE||PLAN_TIME
              BETWEEN vnext_del||'0800' AND vplan_date_rf_lt||vplan_time_rf_lt;

        -- 1.6 Calculate Over STD Stock
        v_over_std_stock := ROUND((v_qty_stock_nextday - v_std_stock), 4);

        -- 1.7 Insert
        INSERT INTO dosystem.T_DO_PLAN_STD_STOCK (
            FACTORY_CD, PART_NO, DIM, CLASS, USE_BLOCK_CD,
            QTY_INVENTORY, QTY_DELIVERY_ORDER, QTY_PLAN,
            QTY_STOCK_NEXTDAY, QTY_STD_STOCK, QTY_OVER_STOCK,
            STD_STOCK_PLAN_DATE, STD_STOCK_PLAN_TIME,
            TOTAL_PROCESS_LT, CREATE_DATE,
            PLAN_QTY_A_AND_Z, PLAN_QTY_MAIN_AND_UNIT, LOGIC
        ) VALUES (
            rec1.FACTORY_CD, rec1.PART_NO, rec1.DIM, rec1.CLASS, rec1.USE_BLOCK_CD,
            v_qt_invent, v_qt_delv, v_qt_plan_today,
            v_qty_stock_nextday, v_std_stock, v_over_std_stock,
            vplan_date_rf_lt, vplan_time_rf_lt,
            vtotal_process_lt, CURRENT_DATE,
            COALESCE(plan_qty_a, 0), COALESCE(plan_qty_main, 0), rec1.LOGIC
        );

    END LOOP;
    CLOSE c1;

    -- Cleanup temp tables
    DROP TABLE IF EXISTS temp_plan_part_for_fc;
    DROP TABLE IF EXISTS temp_plan_a_and_z;
    DROP TABLE IF EXISTS temp_plan_main;

    RETURN 1;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_over_std_stock() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_balance_qty(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_balance_qty() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec0 record;
    rec1 record;
    rec2 record;	
	
    v_qty_over_stock        numeric(20,4);
    v_over_stock            numeric(20,4);
    vnext_working_date      character varying(8);
    vnext2_working_date     character varying(8);
    vnext3_working_date     character varying(8);
    vnext_del               character varying(8);
    plan_date_0800          character varying(8);
    plan_time_0800          character varying(4);
    plan_qty_0800           numeric(20,4);
BEGIN
    SET statement_timeout = 0;
    SET work_mem = '512MB';

    -- 0.) Delete data table T_DO_PLAN_BALANCE_QTY
    DELETE FROM dosystem.T_DO_PLAN_BALANCE_QTY;

    -- 1. Get data Next Working 
    --N+1
    SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
    AND MK_WORK = 'Y';

    --N+2
    SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT_WORKING_DATE
    AND MK_WORK = 'Y';

    --N+3
    SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT2_WORKING_DATE 
    AND MK_WORK = 'Y';

    -- 3.) Open CUR 0       
    FOR rec0 IN 
        SELECT DISTINCT LOGIC FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT
    LOOP
        --TO DO rec0
        IF REC0.LOGIC = '1' THEN
            vNEXT_DEL := vNEXT_WORKING_DATE;
        ELSIF REC0.LOGIC = '2' THEN
            vNEXT_DEL := vNEXT2_WORKING_DATE;
        ELSIF REC0.LOGIC = '3' THEN
            vNEXT_DEL := vNEXT3_WORKING_DATE;
        END IF;		

        FOR rec1 IN
            --SQL
            SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,CLASS ,CD_BLOCK,PT_RATIO FROM (                
                SELECT DISTINCT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,CLASS  FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT
                WHERE PLAN_QTY > 0 
                AND LOGIC = REC0.LOGIC
            ) A JOIN (
                SELECT NO_PARTS , NO_ADJ_DIM , MIN(DT_E_VALID) ,CD_BLOCK,PT_RATIO
                FROM dosystem.WBGHT005
                WHERE PT_RATIO > 0
                AND DT_E_VALID >= vNEXT_DEL
                GROUP BY NO_PARTS,NO_ADJ_DIM,CD_BLOCK,PT_RATIO 
            ) B
            ON A.PART_NO = B.NO_PARTS
            AND A.DIM = B.NO_ADJ_DIM 
            ORDER BY FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD 
        LOOP
            --TO DO rec1
            BEGIN                    
                -- 6.) Summary data QTY_OVER_STOCK 
                SELECT ROUND(COALESCE(SUM(QTY_OVER_STOCK),0),4) INTO V_QTY_OVER_STOCK
                FROM dosystem.T_DO_PLAN_STD_STOCK
                WHERE FACTORY_CD = REC1.FACTORY_CD	
                    AND PART_NO	= REC1.PART_NO
                    AND DIM	= REC1.DIM
                    AND CLASS = REC1.CLASS	
                    AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                    AND LOGIC = REC0.LOGIC;
                
                IF V_QTY_OVER_STOCK IS NULL THEN
                    V_QTY_OVER_STOCK := 0;
                END IF;
            END;
            
            -- 7.) Set Initial data
            V_OVER_STOCK := V_QTY_OVER_STOCK;
            
            BEGIN                     
                SELECT DISTINCT PLAN_DATE_RF_LT ,PLAN_TIME_RF_LT  , SUM(PLAN_QTY) 
                INTO PLAN_DATE_0800 ,PLAN_TIME_0800 , PLAN_QTY_0800
                FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT
                WHERE FACTORY_CD = REC1.FACTORY_CD	
                    AND PART_NO	= REC1.PART_NO
                    AND DIM	= REC1.DIM
                    AND CLASS = REC1.CLASS	
                    AND USE_BLOCK_CD = REC1.USE_BLOCK_CD	
                    -- *** แก้ไขจุดที่ 1: ใช้ COALESCE ป้องกัน NULL ***
                    AND COALESCE(PLAN_DATE_RF_LT,'')||COALESCE(PLAN_TIME_RF_LT,'') = vNEXT_DEL||'0800'
                    AND LOGIC = REC0.LOGIC
                GROUP BY PLAN_DATE_RF_LT,PLAN_TIME_RF_LT
                ORDER BY PLAN_DATE_RF_LT,PLAN_TIME_RF_LT ;
                
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    PLAN_QTY_0800 := 0;
            END;

            IF PLAN_QTY_0800 IS NULL THEN                                   
                PLAN_QTY_0800 := 0;
            END IF;									

            IF (V_OVER_STOCK < 0 ) THEN 
                INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                    (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                VALUES 
                    (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, vNEXT_DEL, '0800', PLAN_QTY_0800, ROUND(((V_OVER_STOCK * (-1))+ PLAN_QTY_0800),4), REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC); 
                    -- *** แก้ไขจุดที่ 2: เปลี่ยน CURRENT_DATE เป็น LOCALTIMESTAMP ทุกจุดของการ Insert ***
                V_OVER_STOCK := 0 ;
            ELSE
                BEGIN
                    -- 1.5.1) Check data OVER STD > PLAN_QTY_RF_LT
                    IF V_OVER_STOCK > PLAN_QTY_0800 THEN
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, vNEXT_DEL, '0800', PLAN_QTY_0800, 0, REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := ROUND(V_OVER_STOCK - PLAN_QTY_0800,4);
                    
                    ELSIF V_OVER_STOCK < 0 THEN -- By Alisa 20220222
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, vNEXT_DEL, '0800', PLAN_QTY_0800, ROUND((PLAN_QTY_0800 - V_OVER_STOCK),4), REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := 0;
                    
                    ELSE
                        -- 1.5.2) Check data OVER STD < = PLAN_QTY_RF_LT
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, vNEXT_DEL, '0800', PLAN_QTY_0800, ROUND((PLAN_QTY_0800 - V_OVER_STOCK),4), REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := 0;
                    END IF;
                END;
            END IF ;

            --Open cur2
            FOR rec2 IN
                SELECT DISTINCT PLAN_DATE_RF_LT AS PLAN_DATE, PLAN_TIME_RF_LT AS PLAN_TIME , SUM(PLAN_QTY) AS PLAN_QTY_RF_LT
                FROM dosystem.T_DO_PLAN_PART_REF_PROCESS_LT
                WHERE FACTORY_CD = REC1.FACTORY_CD	
                    AND PART_NO	= REC1.PART_NO
                    AND DIM	= REC1.DIM
                    AND CLASS = REC1.CLASS	
                    AND USE_BLOCK_CD = REC1.USE_BLOCK_CD	
                    -- *** แก้ไขจุดที่ 3: ใช้ COALESCE ป้องกัน NULL ***
                    AND COALESCE(PLAN_DATE_RF_LT,'')||COALESCE(PLAN_TIME_RF_LT,'') > vNEXT_DEL||'0800'
                    AND LOGIC = REC0.LOGIC
                    AND PLAN_QTY > 0
                GROUP BY PLAN_DATE_RF_LT,PLAN_TIME_RF_LT
                ORDER BY PLAN_DATE_RF_LT,PLAN_TIME_RF_LT
            LOOP
                --TO DO rec2
                BEGIN
                    -- 1.5.1) Check data OVER STD > PLAN_QTY_RF_LT
                    IF V_OVER_STOCK > REC2.PLAN_QTY_RF_LT THEN
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, REC2.PLAN_DATE, REC2.PLAN_TIME, REC2.PLAN_QTY_RF_LT, 0, REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := ROUND(V_OVER_STOCK - REC2.PLAN_QTY_RF_LT,4);
                    
                    ELSIF V_OVER_STOCK < 0 THEN -- By Alisa 20220222
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, REC2.PLAN_DATE, REC2.PLAN_TIME, REC2.PLAN_QTY_RF_LT, ROUND((REC2.PLAN_QTY_RF_LT - V_OVER_STOCK),4), REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := 0;
                    
                    ELSE
                        -- 1.5.2) Check data OVER STD < = PLAN_QTY_RF_LT
                        INSERT INTO dosystem.T_DO_PLAN_BALANCE_QTY
                            (FACTORY_CD, PART_NO, DIM, SUPPLIER_CD, RATIO, CLASS, PLAN_DATE, PLAN_TIME, PLAN_QTY_RF_LT, PLAN_QTY_BALANCE, USE_BLOCK_CD, CREATE_DATE, LOGIC)
                        VALUES 
                            (REC1.FACTORY_CD, REC1.PART_NO, REC1.DIM, REC1.CD_BLOCK, REC1.PT_RATIO, REC1.CLASS, REC2.PLAN_DATE, REC2.PLAN_TIME, REC2.PLAN_QTY_RF_LT, ROUND((REC2.PLAN_QTY_RF_LT - V_OVER_STOCK),4), REC1.USE_BLOCK_CD, LOCALTIMESTAMP, REC0.LOGIC);
                        V_OVER_STOCK := 0;
                    END IF;
                END;		
            END LOOP; --END rec2						  
        END LOOP; --END rec1
    END LOOP; --END rec0
    
    RETURN 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_balance_qty() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_plan_part_byhousr(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_plan_part_byhousr() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
    SET  LOCAL statement_timeout = 10;
    SET  LOCAL work_mem = '512MB';  
 DELETE from dosystem.t_do_plan_plan_part_byhousr  ; 

                                                  INSERT INTO dosystem.T_DO_PLAN_PLAN_PART_BYHOUSR 
                                                            (   FACTORY_CD,
                                                                PART_NO,
                                                                DIM,
                                                                BLOCK_CD,
                                                                SUPPLIER_CD,
                                                                TOTAL_PROCESS_LT,
                                                                RK_PRIO_DIVI,
                                                                PT_RATIO,
                                                                DT_B_VALID,
                                                                DT_E_VALID,
                                                                MERCHANDISE_CD,
                                                                CLASS,
                                                                PLAN_QTY,
                                                                PLAN_DATE,
                                                                PLAN_TIME,
                                                                UPDATE_DATE,
                                                                LOGIC
                                                            ) 
                                                      SELECT 
                                                            B.FACTORY_CD,
                                                            A.PART_NO,
                                                            A.DIM,
                                                            A.BLOCK_CD,
                                                            A.SUPPLIER_CD,
                                                            A.TOTAL_PROCESS_LT,
                                                            A.RK_PRIO_DIVI,
                                                            A.PT_RATIO,
                                                            A.DT_B_VALID,
                                                            A.DT_E_VALID,
                                                            A.MERCHANDISE_CD,
                                                            A.CLASS,
                                                            ROUND((B.SUM_PLAN_QTY)*(A.USED),4),
                                                            B.PLAN_DATE_FROM,
                                                            B.PLAN_TIME_FROM,
                                                            CURRENT_DATE,
                                                            A.LOGIC
                                                            FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE A
                                                            JOIN 
                                                            ( SELECT FACTORY_CD,PLAN_DATE,PLAN_DATE_FROM,PLAN_TIME_FROM,MERCHANDISE_CD ,SUM(PLAN_QTY)
                                                                    AS SUM_PLAN_QTY,LOGIC
                                                                    FROM dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN
                                                                    WHERE PLAN_DATE >=  TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
                                                                    GROUP BY FACTORY_CD,PLAN_DATE,PLAN_DATE_FROM,PLAN_TIME_FROM,MERCHANDISE_CD,LOGIC )B
                                                            ON A.FACTORY_CD = B.FACTORY_CD
                                                            AND A.MERCHANDISE_CD = B.MERCHANDISE_CD
                                                            AND A.LOGIC = B.LOGIC;

return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_plan_part_byhousr() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_plan_part_byhousr_bf(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_plan_part_byhousr_bf() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	
BEGIN

    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';  

    DELETE FROM dosystem.t_do_plan_plan_part_byhousr_bf;

    INSERT INTO dosystem.t_do_plan_plan_part_byhousr_bf (
        factory_cd,
        part_no,
        dim,
        block_cd,
        supplier_cd,
        total_process_lt,
        rk_prio_divi,
        pt_ratio,
        dt_b_valid,
        dt_e_valid,
        merchandise_cd,
        class,
        plan_qty,
        plan_date,
        plan_time,
        update_date,
        logic
    )
    SELECT 
        a.factory_cd,
        b.part_no,
        b.dim,
        CASE WHEN b.class = 'M/T' THEN '8888' ELSE b.block_cd END AS block_cd,
        b.supplier_cd,
        b.total_process_lt,
        b.rk_prio_divi,
        b.pt_ratio,
        b.dt_b_valid,
        b.dt_e_valid,
        a.merchandise_cd,
        b.class,
        ROUND((a.sum_plan_qty) * (b.used), 4),
        a.plan_date_from,
        a.plan_time_from,
        NOW(),
        b.logic
    FROM (
        SELECT 
            DISTINCT factory_cd,
            plan_date,
            plan_date_from,
            plan_time_from,
            merchandise_cd,
            SUM(plan_qty) AS sum_plan_qty
        FROM dosystem.t_do_plan_planbyhousr
        WHERE plan_date >= TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
        GROUP BY factory_cd, plan_date, plan_date_from, plan_time_from, merchandise_cd
    ) a
    JOIN dosystem.t_prd_do_part_and_structure b 
        ON a.factory_cd = b.factory_cd 
        AND a.merchandise_cd = b.merchandise_cd;

    RETURN 1;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_plan_part_byhousr_bf() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_planbyhour(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_planbyhour() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    c1 CURSOR FOR
        SELECT DISTINCT FACTORY_CD, PLAN_DATE, LINE_CD, SHIFT
        FROM dosystem.T_DO_PLAN_PLANBYSHIFT
        WHERE PLAN_DATE >= TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
        ORDER BY FACTORY_CD, PLAN_DATE, LINE_CD, SHIFT;

    rec1 RECORD;

    c2 CURSOR FOR
        SELECT * FROM dosystem.T_DO_PLAN_PLANBYSHIFT
        WHERE FACTORY_CD = rec1.FACTORY_CD
          AND PLAN_DATE  = rec1.PLAN_DATE
          AND SHIFT      = rec1.SHIFT
      	  AND LINE_CD IS NOT DISTINCT FROM rec1.LINE_CD 
        ORDER BY FACTORY_CD, PLAN_DATE, SHIFT, LINE_CD, PLAN_DATE_FROM, PLAN_TIME_FROM ;

    rec2 RECORD;

    vPLAN_BYSHIFT    NUMERIC;
    vPLAN_MER        NUMERIC;
    vPRIORITY_MER    NUMERIC;
    vMERCHANDISE_CD  CHARACTER VARYING(100);
    vROW_COUNT       NUMERIC;

BEGIN
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';

    DELETE FROM dosystem.T_DO_PLAN_PLANBYHOUSR;

    OPEN c1;
    LOOP
        FETCH c1 INTO rec1;
        EXIT WHEN NOT FOUND;

        vPRIORITY_MER := 1;
        vPLAN_MER     := 0;
        vPLAN_BYSHIFT := 0;

        OPEN c2;
        LOOP
            FETCH c2 INTO rec2;
            EXIT WHEN NOT FOUND;

            vPLAN_BYSHIFT := rec2.PLAN_QTY;

            IF vPLAN_MER = 0 THEN
                BEGIN
                    SELECT PRIORITY_NEW, MERCHANDISE_CD, PLAN_QTY
                    INTO vROW_COUNT, vMERCHANDISE_CD, vPLAN_MER
                    FROM (
						SELECT ROW_NUMBER() OVER (ORDER BY priority, priority_for_minus NULLS LAST) AS PRIORITY_NEW, A.*
                        FROM (
    						SELECT MERCHANDISE_CD, PLAN_QTY, priority, priority_for_minus  
                            FROM dosystem.V_DO_PLAN_A3_PLANBYSHIFT
                            WHERE FACTORY_CD = rec1.FACTORY_CD
                              AND PLAN_DATE  = rec1.PLAN_DATE
                              AND SHIFT      = rec1.SHIFT
                              --AND LINE_CD    = rec1.LINE_CD
							  AND LINE_CD IS NOT DISTINCT FROM rec1.LINE_CD
                        ) A
                    ) sub
                    WHERE PRIORITY_NEW = vPRIORITY_MER;

                    IF vROW_COUNT IS NULL THEN
                        vMERCHANDISE_CD := NULL;
                        vPLAN_MER       := 0;
                    END IF;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    vMERCHANDISE_CD := NULL;
                    vPLAN_MER       := 0;
                END;
            END IF;

            WHILE (vPLAN_BYSHIFT <> 0 AND vMERCHANDISE_CD IS NOT NULL) LOOP

                IF vPLAN_BYSHIFT = vPLAN_MER THEN
                    INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR (
                        FACTORY_CD, MERCHANDISE_CD, PLAN_DATE,
                        PLAN_DATE_FROM, PLAN_TIME_FROM,
                        PLAN_DATE_TO, PLAN_TIME_TO,
                        SHIFT, LINE_CD, PLAN_QTY, CREATE_DATE
                    ) VALUES (
                        rec2.FACTORY_CD, vMERCHANDISE_CD, rec2.PLAN_DATE,
                        rec2.PLAN_DATE_FROM, rec2.PLAN_TIME_FROM,
                        rec2.PLAN_DATE_TO, rec2.PLAN_TIME_TO,
                        rec2.SHIFT, rec2.LINE_CD,
                        vPLAN_BYSHIFT,
                        NOW() 
                    );

                    vPLAN_BYSHIFT := 0;
                    vPLAN_MER     := 0;
                    vPRIORITY_MER := vPRIORITY_MER + 1;

                ELSIF vPLAN_BYSHIFT > vPLAN_MER THEN
                    INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR (
                        FACTORY_CD, MERCHANDISE_CD, PLAN_DATE,
                        PLAN_DATE_FROM, PLAN_TIME_FROM,
                        PLAN_DATE_TO, PLAN_TIME_TO,
                        SHIFT, LINE_CD, PLAN_QTY, CREATE_DATE
                    ) VALUES (
                        rec2.FACTORY_CD, vMERCHANDISE_CD, rec2.PLAN_DATE,
                        rec2.PLAN_DATE_FROM, rec2.PLAN_TIME_FROM,
                        rec2.PLAN_DATE_TO, rec2.PLAN_TIME_TO,
                        rec2.SHIFT, rec2.LINE_CD,
                        vPLAN_MER,
                        NOW()
                    );

                    vPRIORITY_MER := vPRIORITY_MER + 1;
                    vPLAN_BYSHIFT := vPLAN_BYSHIFT - vPLAN_MER;
                    vPLAN_MER     := 0;

                ELSIF vPLAN_BYSHIFT < vPLAN_MER THEN
                    INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR (
                        FACTORY_CD, MERCHANDISE_CD, PLAN_DATE,
                        PLAN_DATE_FROM, PLAN_TIME_FROM,
                        PLAN_DATE_TO, PLAN_TIME_TO,
                        SHIFT, LINE_CD, PLAN_QTY, CREATE_DATE
                    ) VALUES (
                        rec2.FACTORY_CD, vMERCHANDISE_CD, rec2.PLAN_DATE,
                        rec2.PLAN_DATE_FROM, rec2.PLAN_TIME_FROM,
                        rec2.PLAN_DATE_TO, rec2.PLAN_TIME_TO,
                        rec2.SHIFT, rec2.LINE_CD,
                        vPLAN_BYSHIFT,
                        NOW()
                    );

                    vPLAN_MER     := vPLAN_MER - vPLAN_BYSHIFT;
                    vPLAN_BYSHIFT := 0;
                END IF;

                IF vPLAN_BYSHIFT <> 0 THEN
                    BEGIN
                        SELECT PRIORITY_NEW, MERCHANDISE_CD, PLAN_QTY
                        INTO vROW_COUNT, vMERCHANDISE_CD, vPLAN_MER
                        FROM (
							SELECT ROW_NUMBER() OVER (ORDER BY priority, priority_for_minus NULLS LAST) AS PRIORITY_NEW, A.*
                            FROM (
							    SELECT MERCHANDISE_CD, PLAN_QTY, priority, priority_for_minus  
                                FROM dosystem.V_DO_PLAN_A3_PLANBYSHIFT 
                                WHERE FACTORY_CD = rec1.FACTORY_CD
                                  AND PLAN_DATE  = rec1.PLAN_DATE
                                  AND SHIFT      = rec1.SHIFT
                                  --AND LINE_CD    = rec1.LINE_CD
								  AND LINE_CD IS NOT DISTINCT FROM rec1.LINE_CD
                            ) A
                        ) sub
                        WHERE PRIORITY_NEW = vPRIORITY_MER;

                        IF vROW_COUNT IS NULL THEN
                            vMERCHANDISE_CD := NULL;
                            vPLAN_MER       := 0;
                        END IF;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        vMERCHANDISE_CD := NULL;
                        vPLAN_MER       := 0;
                    END;
                END IF;

            END LOOP; -- WHILE vPLAN_BYSHIFT <> 0

        END LOOP; -- Loop c2
        CLOSE c2;  

    END LOOP; -- Loop c1
    CLOSE c1;

    RETURN 1;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_planbyhour() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_planbyshift_ins(character varying, character varying, character varying, character varying, character varying, character varying, character varying, numeric, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_planbyshift_ins(pfactory_cd character varying, pplan_date_from character varying, pplan_time_from character varying, pplan_date_to character varying, pplan_time_to character varying, pshift character varying, pline_cd character varying, pplan_qty numeric, pplan_date character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE

flag INTEGER := 0;
	

BEGIN
	
	BEGIN
	SET  LOCAL statement_timeout = 0;
    SET  LOCAL work_mem = '512MB';  
                   INSERT INTO dosystem.T_DO_PLAN_PLANBYSHIFT(
                            FACTORY_CD
                            ,PLAN_DATE_FROM
                            ,PLAN_TIME_FROM
                            ,PLAN_DATE_TO
                            ,PLAN_TIME_TO
                            ,SHIFT
                            ,LINE_CD
                            ,PLAN_QTY
                            ,CREATE_DATE
                            ,PLAN_DATE
                        )
                    VALUES (
                             pFACTORY_CD
                            ,pPLAN_DATE_FROM
                            ,pPLAN_TIME_FROM
                            ,pPLAN_DATE_TO
                            ,pPLAN_TIME_TO
                            ,pSHIFT
                            ,pLINE_CD
                            ,pPLAN_QTY
                            ,CURRENT_DATE
                            ,pPLAN_DATE
                            );
							
                             flag := 1;   
                     EXCEPTION
                            WHEN OTHERS THEN
                               NULL ;
                               flag := 0; 
                    END ;
	
    RETURN flag;
    
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_planbyshift_ins(pfactory_cd character varying, pplan_date_from character varying, pplan_time_from character varying, pplan_date_to character varying, pplan_time_to character varying, pshift character varying, pline_cd character varying, pplan_qty numeric, pplan_date character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_date(character varying, character varying, character varying, character varying, character varying, character varying, numeric, smallint, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_date(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, pcd_sply_fact character varying, OUT psum_qty_do numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE

v_nm_key_table              character varying(100);
v_combiday                  character varying(1);
v_delivery_date             character varying(8);
v_delivery_time             character varying(4 );
v_next_plandate             character varying(8);
v_day                       character varying(3);
v_count                     numeric(3);
v_min_dt_delv               character varying(8);
v_plan_datetime             character varying(12);
v_next_working_day          character varying(8);
vchk_flg                    character varying(1);
v_num_day_slide             numeric(3);
vflg_in_house               character varying(1);
v_count_hol                 numeric(3);
pflg                        numeric(1);
vcnt_sply_fact              numeric;
vplan_date                  character varying(8);
vplan_time                  character varying(12);
vplan_qty_ref_lot           numeric;

rec1 record;

BEGIN --Begin1

    BEGIN --Begin2           
    SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
    FROM dosystem.T_PRD_DO_DELIVERY_MASTER
        WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
         SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT FROM T_PRD_DO_DELIVERY_MASTER 
         WHERE  FACTORY_CD = pFACTORY_CD
         AND SUPPLIER_CD = pSUPPLIER_CD
         AND EFFECT_STA_DATE <= pNEXT_DEL
         AND CD_SPLY_FACT = pCD_SPLY_FACT
         GROUP BY FACTORY_CD,SUPPLIER_CD,CD_SPLY_FACT);
        
    EXCEPTION WHEN NO_DATA_FOUND THEN           
            vFLG_IN_HOUSE := NULL;            

    IF (vFLG_IN_HOUSE = 'Y') THEN --IF 1
	
    FOR rec1 IN
	SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT
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
	                ORDER BY PLAN_DATE,PLAN_TIME
	    LOOP
	        -- TODO: logic
                    BEGIN
                    select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
	    END LOOP;	

	ELSE

                    BEGIN
                        -- Check count CD_SPLY_FACT 
                        SELECT COUNT(*) INTO vCnt_SPLY_FACT
                        FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                        WHERE FACTORY_CD = pFACTORY_CD
                        AND SUPPLIER_CD = pSUPPLIER_CD
                        AND CD_SPLY_FACT = pCD_SPLY_FACT;
                    END;
                    -- 9.0)Case Not found CD_SPLY_FACT (From Cur 1) OR table V_PRD_DO_DELIVERY_MASTER
                    IF pCD_SPLY_FACT is null OR vCnt_SPLY_FACT = 0 THEN
                    BEGIN
                    
                    SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT INTO vPLAN_DATE,vPLAN_TIME,vPLAN_QTY_REF_LOT                                    
                    FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
                    WHERE FACTORY_CD = pFACTORY_CD
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                    
                    select * from dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
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
                            FROM dosystem.V_DO_DELEVERY_DAY_OF_WEEK
                            WHERE NO_PARTS = pPART_NO
                                AND NO_ADJ_DIM = pDIM;                                
                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                V_NM_KEY_TABLE := NULL;
                    END;
                    
                    BEGIN
                            -- 2.) Get data PD_DELV_QTY_ROUND_DEF -- #CombineDay                           
                           V_CombiDay := 'D' ;                
                    END;                                       
                    V_Next_Working_Day := pNEXT_DEL ;
                    -- 3.)  Open CUR 1
					FOR rec1 IN
					SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_REF_LOT
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
					                ORDER BY PLAN_DATE,PLAN_TIME
					    LOOP
					        -- TODO: logic

                            -- 4.) Check  MK_DAY_INTEGRATE not null 
                            IF V_NM_KEY_TABLE IS NOT NULL THEN
                            BEGIN
                                -- 4.1) Set Initial data 
                                V_delivery_date := REC1.PLAN_DATE;
                                V_delivery_Time := REC1.PLAN_TIME; 
                                
                                -- Set Next_PlanDate = PLAN_DATE + 1 Day
                                BEGIN
                                    SELECT TO_CHAR(TO_DATE(REC1.PLAN_DATE,'YYYYMMDD')+1,'YYYYMMDD') INTO V_Next_PlanDate ;
                                END;
                                
                                -- 4.2) Check Day on Plan data and plan Time                            
                                BEGIN
                                    SELECT TO_CHAR(TO_DATE(V_delivery_date,'YYYYMMDD'),'DY') INTO V_Day;
                                    
                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_Day := NULL;                            
                                END;
                                
                                 -- 4.3.1) Check MK_DAY_INTEGRATE  Like %Day% 
                                IF V_NM_KEY_TABLE LIKE '%'||V_Day||'%'  THEN
                                
                                        BEGIN
                                        
                                            SELECT COALESCE(COUNT(*),0) INTO V_COUNT
                                            FROM dosystem.V_PRD_DO_DELIVERY_MASTER
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
                                                                            FROM dosystem.WBGZT051
                                                                            WHERE MK_WORK = 'N'
                                                                            AND DT_WORK = (SELECT MIN(dt_work) FROM dosystem.wbgzt051
                                                                                            WHERE dt_work > REC1.PLAN_TIME AND mk_work = 'Y');
                                                                            
                                                                            IF V_COUNT_HOL > 0 THEN 
                                                                                     V_COUNT := 0;  
                                                                            END IF;
                         
                                                            END IF;
                                        
                                        -- A.) วันตรงกับ Combli , รอบการส่งตรงกับ Plan
                                        IF V_COUNT > 0 THEN                                            
                                                    BEGIN
                                                        select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                
                                                    select * from dosystem.p_prd_do_plan_ref_del_date_find_plan
                                                                                (pFACTORY_CD,       pPART_NO,
                                                                                    pDIM,           pSUPPLIER_CD,
                                                                                    V_Next_PlanDate,
                                                                                    REC1.PLAN_DATE, REC1.PLAN_TIME,
                                                                                    pNEXT_DEL,      pCD_SPLY_FACT,
                                                                                    V_delivery_date,V_delivery_Time);
                                                    IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                            BEGIN
                                                                select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                                select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                    
                                            select * from dosystem.p_prd_do_plan_ref_del_date_find_plan
                                                                        (pFACTORY_CD,       pPART_NO,
                                                                            pDIM,           pSUPPLIER_CD,
                                                                            V_Next_PlanDate,
                                                                            REC1.PLAN_DATE, REC1.PLAN_TIME,
                                                                            pNEXT_DEL,      pCD_SPLY_FACT,
                                                                            V_delivery_date,V_delivery_Time);
                                            IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL  THEN
                                                    BEGIN
                                                        select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                        select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                        FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
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
                                        select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                                    From dosystem.V_DO_WORKING_DAY 
                                                                    UNION
                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                    From dosystem.V_DO_WORKING_DAY)
                                                      WHERE MK_WORK = 'Y' 
                                                      ) A
                                            JOIN dosystem.V_PRD_DO_DELIVERY_MASTER B
                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                            WHERE FACTORY_CD = pFACTORY_CD
                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= REC1.PLAN_DATE||REC1.PLAN_TIME
                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                ( 
                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                 UNION
                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                              
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
                                                    select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                    select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                     select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                                        From dosystem.V_DO_WORKING_DAY 
                                                                        UNION
                                                                        SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                        From dosystem.V_DO_WORKING_DAY)
                                                          WHERE MK_WORK = 'Y' 
                                                          ) A
                                                JOIN dosystem.V_PRD_DO_DELIVERY_MASTER B
                                                ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                WHERE FACTORY_CD = pFACTORY_CD
                                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC1.PLAN_TIME
                                                    AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                    AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                (
                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                 UNION
                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                UNION
                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                FROM dosystem.WBGZT051
                                                                                WHERE MK_WORK = 'N'
                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                              
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
                                                         select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                         select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                         select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                                FROM( SELECT * FROM dosystem.wbgzt051
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
                                                                FROM( SELECT * FROM dosystem.wbgzt051
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
                                                                                    From dosystem.V_DO_WORKING_DAY 
                                                                                    UNION
                                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                    From dosystem.V_DO_WORKING_DAY)
                                                                      WHERE MK_WORK = 'Y' 
                                                                      ) A
                                                            JOIN dosystem.V_PRD_DO_DELIVERY_MASTER B
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                            WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||'9999'
                                                                AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                 AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                            ( 
                                                                                              SELECT  DT_WORK||'0000' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0100' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                 UNION
                                                                                                SELECT  DT_WORK||'0200' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0300' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0400' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0500' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0600' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                UNION
                                                                                                SELECT  DT_WORK||'0700' AS HOL
                                                                                                FROM dosystem.WBGZT051
                                                                                                WHERE MK_WORK = 'N'
                                                                                                AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                              
                                                                                            )C )
                                                            ORDER BY SUBSTR(END_DATE,1,8)||TIME_ETA DESC;
                                                            
                                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                            V_PLAN_DATETIME := NULL;       
                                                        END;
                                                   
                                                    ELSIF VChk_Flg = 'Y' THEN
                                                        BEGIN
                                                            SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA )  INTO V_PLAN_DATETIME
                                                            FROM ( SELECT * FROM ( SELECT DT_WORK,MK_WORK,DATE_START,START_TIME AS BEGIN_DATE,SUBSTR(START_TIME,1,8)||'2300' END_DATE 
                                                                                    From dosystem.V_DO_WORKING_DAY 
                                                                                    UNION
                                                                                    SELECT DT_WORK,MK_WORK,DATE_END,SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,END_TIME  AS END_DATE  
                                                                                    From dosystem.V_DO_WORKING_DAY)
                                                                      WHERE MK_WORK = 'Y' 
                                                                      ) A
                                                            JOIN dosystem.V_PRD_DO_DELIVERY_MASTER B
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                            WHERE FACTORY_CD = pFACTORY_CD
                                                                AND SUPPLIER_CD = pSUPPLIER_CD
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC1.PLAN_TIME
                                                                AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                                AND CD_SPLY_FACT = pCD_SPLY_FACT
                                                                AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN   ( SELECT HOL FROM -- Support time milkrun
                                                                                                ( 
                                                                                                  SELECT  DT_WORK||'0000' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0100' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                     UNION
                                                                                                    SELECT  DT_WORK||'0200' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0300' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0400' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0500' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0600' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                    UNION
                                                                                                    SELECT  DT_WORK||'0700' AS HOL
                                                                                                    FROM dosystem.WBGZT051
                                                                                                    WHERE MK_WORK = 'N'
                                                                                                    AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE-2,'YYYYMMDD') AND TO_CHAR(CURRENT_DATE+14,'YYYYMMDD')
                                                                                                  
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
                                                            select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                                                            select * from dosystem.p_prd_do_plan_ref_delivery_date_ins( 
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
                    
					    END LOOP;

	END IF; --IF 1 

	END; --Begin2

    
    -- Calling PG  P_PRD_DO_PLAN_REF_DEL_DATE
    select * into pFLG from dosystem.pg_prd_do_slide_del_case_plan_change( 
                                                                 pFACTORY_CD,       pPART_NO,
                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,      pCLASS,
                                                                  pRATIO,           pLogic,
                                                                  pNEXT_DEL);
    
    
    -- Calling PG  P_PRD_DO_PLAN_REF_DEL_DATE
    select * into pSUM_QTY_DO from dosystem.p_prd_do_issue_do_multi_rate( 
                                                                 pFACTORY_CD,       pPART_NO,
                                                                 pDIM,              pUSE_BLOCK_CD,
                                                                 pSUPPLIER_CD,      pCLASS,
                                                                 pRATIO,            pNEXT_DEL, 
                                                                 pLogic,            pCD_SPLY_FACT
                                                                 );

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_date(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, pcd_sply_fact character varying, OUT psum_qty_do numeric) OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_date_find_plan(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_date_find_plan(pfactory_cd character varying, ppart_no character varying, pdim character varying, psupplier_cd character varying, pnext_plandate character varying, pplan_date character varying, pplan_time character varying, pnext_del character varying, pcd_sply_fact character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
DECLARE
    c3 cursor FOR
SELECT * FROM dosystem.V_DO_DELEVERY_DAY_OF_WEEK A
                JOIN dosystem.V_DO_WORKING_DAY B
                ON UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_START||'%'
                OR UPPER(A.NM_KEY_TABLE) LIKE '%'||B.DATE_END||'%'
                WHERE B.MK_WORK = 'Y'
                AND B.START_TIME >= pNEXT_DEL||'0800'                
                AND B.END_TIME <= pNEXT_PLANDATE||'0700'
                AND A.NO_PARTS = pPART_NO
                AND A.NO_ADJ_DIM = pDIM
                ORDER BY END_TIME DESC;
                
    rec3 record;
    CNT  numeric(5) := 0 ; 

BEGIN
--Set Initial
pplan_date_slide := NULL;
pplan_time_slide := NULL;

-- 1.3)  Open CUR 3
OPEN c3;
LOOP
FETCH c3 into rec3;
EXIT when not found;

BEGIN
    SELECT COUNT(*) INTO CNT FROM dosystem.WBGZT051 
    WHERE MK_WORK = 'Y' 
    AND DT_WORK = SUBSTR(REC3.END_TIME,1,8);  -- แก้จาก 0 เป็น 1

        IF ( UPPER(REC3.NM_KEY_TABLE) LIKE '%'||REC3.DATE_END||'%' ) AND CNT > 0 THEN 
        
                pPLAN_DATE_SLIDE := SUBSTR(REC3.END_TIME,1,8);  -- แก้จาก 0 เป็น 1
                
				IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||COALESCE(pPLAN_TIME_SLIDE,'') <= pPLAN_DATE||pPLAN_TIME) THEN

                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0000' AND '0700'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
                
				ELSIF pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||COALESCE(pPLAN_TIME_SLIDE,'') <= pPLAN_DATE||pPLAN_TIME)THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
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
                
                pPLAN_DATE_SLIDE := SUBSTR(REC3.START_TIME,1,8);  -- แก้จาก 0 เป็น 1
                
				IF pPLAN_DATE <> pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||COALESCE(pPLAN_TIME_SLIDE,'') <= pPLAN_DATE||pPLAN_TIME)THEN 
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                                WHERE FACTORY_CD = pFACTORY_CD
                                    AND SUPPLIER_CD = pSUPPLIER_CD
                                    AND TIME_ETA BETWEEN '0800' AND '2300'
                                    AND CD_SPLY_FACT = pCD_SPLY_FACT;
                                    
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                pPLAN_TIME_SLIDE := null;    
                        END;
				ELSIF pPLAN_DATE = pPLAN_DATE_SLIDE AND (pPLAN_DATE_SLIDE||COALESCE(pPLAN_TIME_SLIDE,'') <= pPLAN_DATE||pPLAN_TIME)THEN
                        BEGIN
                                SELECT MAX(TIME_ETA) INTO pPLAN_TIME_SLIDE
                                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
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
        EXIT;
        END IF;
        
END;

END LOOP;
CLOSE c3;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_date_find_plan(pfactory_cd character varying, ppart_no character varying, pdim character varying, psupplier_cd character varying, pnext_plandate character varying, pplan_date character varying, pplan_time character varying, pnext_del character varying, pcd_sply_fact character varying, OUT pplan_date_slide character varying, OUT pplan_time_slide character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_date_rate100(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_date_rate100() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    
V_delivery_date             character varying(8);
V_delivery_Time             character varying(4);
V_Day                       character varying(3);
V_COUNT                     numeric(3);
V_COUNT_HOL                 numeric(3);
V_MIN_DT_DELV               character varying(8);
V_Num_Day_Slide             numeric(3);
V_Next_PlanDate             character varying(8);
V_PLAN_DATETIME             character varying(12);
VChk_Flg                    character varying(1);
vFLG_IN_HOUSE               character varying(10) := NULL;
--
vNEXT_WORKING_DATE          character varying(8);
vNEXT2_WORKING_DATE         character varying(8);
vNEXT3_WORKING_DATE         character varying(8);
vNEXT_DEL                   character varying(8);
--20230424 Add logic for support Supplier have many location
vCnt_SPLY_FACT              numeric;
vPLAN_DATE                  character varying(8);
vPLAN_TIME                  character varying(12);
vPLAN_QTY_REF_LOT           numeric;
--BF20230622
vDELIVERY_CHK               numeric;
vPLAN_TIME_CHK              character varying(4);
vEFFECT_STA_DATE_MAX        character varying(8);	
	
	rec0 record;    
	rec1 record;
	rec2 record;	
	
BEGIN
    SET statement_timeout = 0;
    SET work_mem = '512MB';

-- ============================================================
-- PRE-LOAD: Materialize Views/Tables ที่ใช้บ่อยใน Loop
-- ทำครั้งเดียวก่อนเข้า Loop เพื่อประสิทธิภาพ
-- ============================================================

    -- Temp: Working Day (ใช้ซ้ำหลายร้อยครั้งใน Loop)
    CREATE TEMP TABLE tmp_working_day ON COMMIT DROP AS
    SELECT * FROM (
        SELECT DT_WORK, MK_WORK, DATE_START,
               START_TIME AS BEGIN_DATE,
               SUBSTR(START_TIME,1,8)||'2300' AS END_DATE
        FROM dosystem.V_DO_WORKING_DAY
        UNION
        SELECT DT_WORK, MK_WORK, DATE_END,
               SUBSTR(END_TIME,1,8)||'0000' AS BEGIN_DATE,
               END_TIME AS END_DATE
        FROM dosystem.V_DO_WORKING_DAY
    ) X
    WHERE MK_WORK = 'Y';

    CREATE INDEX ON tmp_working_day (SUBSTR(END_DATE,1,8));
    CREATE INDEX ON tmp_working_day (SUBSTR(BEGIN_DATE,9,4), SUBSTR(END_DATE,9,4));

    -- Temp: Delivery Master (ใช้ซ้ำหลายร้อยครั้งใน Loop)
    CREATE TEMP TABLE tmp_delivery_master ON COMMIT DROP AS
    SELECT * FROM dosystem.V_PRD_DO_DELIVERY_MASTER;

    CREATE INDEX ON tmp_delivery_master (FACTORY_CD, SUPPLIER_CD, CD_SPLY_FACT);
    CREATE INDEX ON tmp_delivery_master (FACTORY_CD, SUPPLIER_CD, CD_SPLY_FACT, TIME_ETA);

    -- Temp: Delivery Master CHK
    CREATE TEMP TABLE tmp_delivery_master_chk ON COMMIT DROP AS
    SELECT * FROM dosystem.V_PRD_DO_DELIVERY_MASTER_CHK;

    CREATE INDEX ON tmp_delivery_master_chk (FACTORY_CD, SUPPLIER_CD, CD_SPLY_FACT, EFFECT_STA_DATE);

    -- Temp: Holiday list (ใช้ซ้ำใน NOT IN ทุก iteration)
-- แก้ตรงนี้ใน function (ส่วนสร้าง tmp_holiday)
CREATE TEMP TABLE tmp_holiday ON COMMIT DROP AS
SELECT DT_WORK||'0000' AS HOL FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0100' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0200' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0300' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0400' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0500' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0600' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD')
UNION SELECT DT_WORK||'0700' FROM dosystem.wbgzt051 
WHERE MK_WORK = 'N'
AND DT_WORK BETWEEN TO_CHAR(CURRENT_DATE - 2, 'YYYYMMDD') 
                AND TO_CHAR(CURRENT_DATE + 14, 'YYYYMMDD');

    CREATE INDEX ON tmp_holiday (HOL);

-- ============================================================
-- 0.) Delete data table
-- ============================================================
    DELETE FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE;

-- ============================================================
-- 1.) Get Next Working Day
-- ============================================================
    --N+1
    SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
    AND MK_WORK = 'Y';

    --N+2
    SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT_WORKING_DATE
    AND MK_WORK = 'Y';

    --N+3
    SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT2_WORKING_DATE 
    AND MK_WORK = 'Y';

-- ============================================================
-- 3.) Open CUR 0
-- ============================================================
    FOR rec0 IN
        SELECT DISTINCT LOGIC FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
    LOOP

        -- 3.1) Set value vNEXT_DEL  
        IF REC0.LOGIC = '1' THEN
            vNEXT_DEL := vNEXT_WORKING_DATE;
        ELSIF REC0.LOGIC = '2' THEN
            vNEXT_DEL := vNEXT2_WORKING_DATE;
        ELSIF REC0.LOGIC = '3' THEN
            vNEXT_DEL := vNEXT3_WORKING_DATE;
        END IF;

        -- 6.) Open CUR 1
        FOR rec1 IN
            SELECT DISTINCT FACTORY_CD, PART_NO, DIM, USE_BLOCK_CD, SUPPLIER_CD, CLASS,
                   UPPER(NM_KEY_TABLE) AS V_NM_KEY_TABLE,
                   'D' AS V_CombiDay,
                   A.CD_SPLY_FACT
            FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT A
            LEFT JOIN dosystem.V_DO_DELEVERY_DAY_OF_WEEK B
                ON A.PART_NO = B.NO_PARTS AND A.DIM = B.NO_ADJ_DIM
            LEFT JOIN (
                SELECT * FROM dosystem.J000_SUPPLIER_MASTER 
                WHERE CD_SPLY||TO_CHAR(DT_ENTRY,'YYYYMMD HH24MISS') IN (
                    SELECT DISTINCT CD_SPLY||MAX(TO_CHAR(DT_ENTRY,'YYYYMMD HH24MISS')) 
                    FROM dosystem.J000_SUPPLIER_MASTER
                    GROUP BY CD_SPLY
                )
            ) C ON A.SUPPLIER_CD = C.CD_SPLY
            WHERE A.PLAN_DATE||A.PLAN_TIME >= vNEXT_DEL||'0800'
                AND A.RATIO = 100 
                AND A.PLAN_QTY_REF_LOT > 0
                AND A.LOGIC = REC0.LOGIC
            ORDER BY A.FACTORY_CD, A.PART_NO, A.DIM, A.USE_BLOCK_CD, A.SUPPLIER_CD, A.CLASS
        LOOP

            -- 7.) Check FLG_IN_HOUSE
            BEGIN            
                SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                FROM dosystem.T_PRD_DO_DELIVERY_MASTER
                WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
                    SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT 
                    FROM dosystem.T_PRD_DO_DELIVERY_MASTER 
                    WHERE FACTORY_CD = REC1.FACTORY_CD
                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                    AND EFFECT_STA_DATE <= vNEXT_DEL
                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                    GROUP BY FACTORY_CD, SUPPLIER_CD, CD_SPLY_FACT
                );
            EXCEPTION WHEN NO_DATA_FOUND THEN           
                vFLG_IN_HOUSE := NULL; 
            END;
            
            -- 8.) Case IN_HOUSE = Y
            IF (vFLG_IN_HOUSE = 'Y') THEN
            
                FOR rec2 IN
                    SELECT PLAN_DATE, PLAN_TIME, PLAN_QTY_REF_LOT
                    FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
                    WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                        AND RATIO = 100 
                        AND PLAN_QTY_REF_LOT > 0
                        AND FACTORY_CD = REC1.FACTORY_CD	
                        AND PART_NO = REC1.PART_NO
                        AND DIM = REC1.DIM
                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                        AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                        AND CLASS = REC1.CLASS
                        AND LOGIC = REC0.LOGIC
                        AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                    ORDER BY PLAN_DATE, PLAN_TIME
                LOOP
                    BEGIN
                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                            REC1.FACTORY_CD, REC1.PART_NO,
                            REC1.DIM, REC1.USE_BLOCK_CD,
                            REC1.SUPPLIER_CD, REC1.CLASS,
                            100,
                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                            REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                    EXCEPTION WHEN OTHERS THEN NULL;
                    END;    
                END LOOP;

            -- 9.) Case IN_HOUSE <> Y
            ELSE 
                BEGIN
                    SELECT COUNT(*) INTO vCnt_SPLY_FACT
                    FROM tmp_delivery_master
                    WHERE FACTORY_CD = REC1.FACTORY_CD
                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                END;

                -- 9.0) Case Not found CD_SPLY_FACT
                IF REC1.CD_SPLY_FACT IS NULL OR vCnt_SPLY_FACT = 0 THEN
                    BEGIN
                        SELECT PLAN_DATE, PLAN_TIME, PLAN_QTY_REF_LOT 
                        INTO vPLAN_DATE, vPLAN_TIME, vPLAN_QTY_REF_LOT                                    
                        FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
                        WHERE FACTORY_CD = REC1.FACTORY_CD
                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                        AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                        
                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                            REC1.FACTORY_CD, REC1.PART_NO,
                            REC1.DIM, REC1.USE_BLOCK_CD,
                            REC1.SUPPLIER_CD, REC1.CLASS,
                            100,
                            vPLAN_DATE, vPLAN_TIME,
                            vPLAN_DATE, vPLAN_TIME,
                            vPLAN_QTY_REF_LOT, 'WF0030':: varchar,
                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                    EXCEPTION WHEN OTHERS THEN NULL;
                    END;
                END IF;

                -- 9.1) Open CUR 2
                FOR rec2 IN
                    SELECT PLAN_DATE, PLAN_TIME, PLAN_QTY_REF_LOT
                    FROM dosystem.T_DO_PLAN_REF_DELIVERY_LOT
                    WHERE PLAN_DATE||PLAN_TIME >= vNEXT_DEL||'0800'
                        AND RATIO = 100 
                        AND PLAN_QTY_REF_LOT > 0
                        AND FACTORY_CD = REC1.FACTORY_CD	
                        AND PART_NO = REC1.PART_NO
                        AND DIM = REC1.DIM
                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                        AND USE_BLOCK_CD = REC1.USE_BLOCK_CD
                        AND CLASS = REC1.CLASS
                        AND LOGIC = REC0.LOGIC
                        AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                    ORDER BY PLAN_DATE, PLAN_TIME
                LOOP
                    BEGIN

                        -- 9.2) Check V_NM_KEY_TABLE not null 
                        IF REC1.V_NM_KEY_TABLE IS NOT NULL THEN
                        
                            V_delivery_date := REC2.PLAN_DATE;
                            V_delivery_Time := REC2.PLAN_TIME;
                            
                            BEGIN
                                SELECT MIN(dt_work) INTO V_Next_PlanDate 
                                FROM dosystem.wbgzt051
                                WHERE dt_work > REC2.PLAN_DATE AND mk_work = 'Y';
                            END;
                            
                            BEGIN
                                SELECT TO_CHAR(TO_DATE(V_delivery_date,'YYYYMMDD'),'DY') INTO V_Day;
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                V_Day := NULL;                            
                            END;
                            
                            -- 9.2.2) Check day match
                            IF REC1.V_NM_KEY_TABLE LIKE '%'||V_Day||'%' THEN
                            
                                BEGIN
                                    SELECT COALESCE(COUNT(*),0) INTO V_COUNT
                                    FROM tmp_delivery_master   -- ใช้ tmp แทน View
                                    WHERE FACTORY_CD = REC1.FACTORY_CD
                                        AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                        AND TIME_ETA = REC2.PLAN_TIME
                                        AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                                EXCEPTION WHEN NO_DATA_FOUND THEN
                                    V_COUNT := 0;              
                                END;

                                -- Support milkrun
                                IF REC2.PLAN_TIME IN ('0000','0100','0200','0300','0400','0500','0600','0700') THEN 
                                    SELECT COUNT(*) INTO V_COUNT_HOL
                                    FROM dosystem.wbgzt051 
                                    WHERE MK_WORK = 'N'
                                    AND DT_WORK = (
                                        SELECT MIN(dt_work) FROM dosystem.wbgzt051
                                        WHERE dt_work > REC2.PLAN_DATE AND mk_work = 'Y'
                                    );
                                    IF V_COUNT_HOL > 0 THEN 
                                        V_COUNT := 0;  
                                    END IF;
                                END IF;
                                
                                -- 9.2.2.3) วันตรง รอบตรง
                                IF V_COUNT > 0 THEN                                            
                                    BEGIN
                                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                            REC1.FACTORY_CD, REC1.PART_NO,
                                            REC1.DIM, REC1.USE_BLOCK_CD,
                                            REC1.SUPPLIER_CD, REC1.CLASS,
                                            100,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            V_delivery_date, V_delivery_Time,
                                            REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                                    EXCEPTION WHEN OTHERS THEN NULL;
                                    END;

                                -- 9.2.2.4) วันตรง รอบไม่ตรง
                                ELSIF V_COUNT = 0 THEN 
                                    BEGIN
                                        SELECT pplan_date_slide, pplan_time_slide 
INTO V_delivery_date, V_delivery_Time
FROM dosystem.p_prd_do_plan_ref_del_date_find_plan(
    REC1.FACTORY_CD, REC1.PART_NO,
    REC1.DIM, REC1.SUPPLIER_CD,
    V_Next_PlanDate,
    REC2.PLAN_DATE, REC2.PLAN_TIME,
    vNEXT_DEL, REC1.CD_SPLY_FACT
     );

                                        IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL THEN
                                            BEGIN
                                                PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                    REC1.FACTORY_CD, REC1.PART_NO,
                                                    REC1.DIM, REC1.USE_BLOCK_CD,
                                                    REC1.SUPPLIER_CD, REC1.CLASS,
                                                    100,
                                                    REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                    V_delivery_date, V_delivery_Time,
                                                    REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                                    REC0.LOGIC, REC1.CD_SPLY_FACT);
                                            EXCEPTION WHEN OTHERS THEN NULL;
                                            END;
                                        ELSE 
                                            BEGIN
                                                PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                    REC1.FACTORY_CD, REC1.PART_NO,
                                                    REC1.DIM, REC1.USE_BLOCK_CD,
                                                    REC1.SUPPLIER_CD, REC1.CLASS,
                                                    100,
                                                    REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                    REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                    REC2.PLAN_QTY_REF_LOT, 'WF0018':: varchar,
                                                    REC0.LOGIC, REC1.CD_SPLY_FACT);
                                            EXCEPTION WHEN OTHERS THEN NULL;
                                            END;
                                        END IF;
                                    END;                                                
                                END IF; -- V_COUNT > 0

                            -- 9.2.3) วันไม่ตรง Combli
                            ELSE           
                                BEGIN
                                   SELECT pplan_date_slide, pplan_time_slide 
INTO V_delivery_date, V_delivery_Time
FROM dosystem.p_prd_do_plan_ref_del_date_find_plan(
    REC1.FACTORY_CD, REC1.PART_NO,
    REC1.DIM, REC1.SUPPLIER_CD,
    V_Next_PlanDate,
    REC2.PLAN_DATE, REC2.PLAN_TIME,
    vNEXT_DEL, REC1.CD_SPLY_FACT
     );

                                    IF V_delivery_date IS NOT NULL AND V_delivery_Time IS NOT NULL THEN
                                        BEGIN
                                            PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                REC1.FACTORY_CD, REC1.PART_NO,
                                                REC1.DIM, REC1.USE_BLOCK_CD,
                                                REC1.SUPPLIER_CD, REC1.CLASS,
                                                100,
                                                REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                V_delivery_date, V_delivery_Time,
                                                REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                                REC0.LOGIC, REC1.CD_SPLY_FACT);
                                        EXCEPTION WHEN OTHERS THEN NULL;
                                        END;
                                    ELSE
                                        BEGIN
                                            PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                REC1.FACTORY_CD, REC1.PART_NO,
                                                REC1.DIM, REC1.USE_BLOCK_CD,
                                                REC1.SUPPLIER_CD, REC1.CLASS,
                                                100,
                                                REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                REC2.PLAN_QTY_REF_LOT, 'WF0018':: varchar,
                                                REC0.LOGIC, REC1.CD_SPLY_FACT);
                                        EXCEPTION WHEN OTHERS THEN NULL;
                                        END;
                                    END IF;
                                END;        
                            END IF; -- V_NM_KEY_TABLE LIKE day

                        END IF; -- V_NM_KEY_TABLE IS NOT NULL

                        -- ============================================================
                        -- 9.3) V_NM_KEY_TABLE IS NULL AND V_CombiDay = 'D'
                        -- ============================================================
                        IF REC1.V_NM_KEY_TABLE IS NULL AND REC1.V_CombiDay = 'D' THEN
                            BEGIN
                                SELECT COUNT(*) INTO vDELIVERY_CHK FROM (
                                    SELECT DISTINCT FACTORY_CD, SUPPLIER_CD, EFFECT_STA_DATE, CD_SPLY_FACT
                                    FROM dosystem.T_PRD_DO_DELIVERY_MASTER
                                    WHERE EFFECT_STA_DATE >= TO_CHAR(CURRENT_DATE,'YYYYMMDD')
                                    AND FACTORY_CD = REC1.FACTORY_CD
                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                    AND EFFECT_STA_DATE <= TO_CHAR(CURRENT_DATE + 10, 'YYYYMMDD')
                                ) X;

                                IF (vDELIVERY_CHK >= 2) THEN
                                
                                    IF REC2.PLAN_TIME BETWEEN '0000' AND '0070' THEN
                                        SELECT TO_CHAR(TO_DATE(REC2.PLAN_TIME,'YYYYMMDD') -1,'YYYYMMDD') INTO vPLAN_TIME_CHK;
                                    ELSE 
                                        vPLAN_TIME_CHK := REC2.PLAN_TIME;
                                    END IF;
                                    
                                    SELECT MAX(EFFECT_STA_DATE) INTO vEFFECT_STA_DATE_MAX  
                                    FROM tmp_delivery_master_chk   -- ใช้ tmp แทน View
                                    WHERE FACTORY_CD = REC1.FACTORY_CD
                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                    AND EFFECT_STA_DATE <= vPLAN_TIME_CHK;

                                    BEGIN
                                        SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA) INTO V_PLAN_DATETIME
                                        FROM tmp_working_day A   -- ใช้ tmp แทน View
                                        JOIN (
                                            SELECT * FROM tmp_delivery_master_chk 
                                            WHERE EFFECT_STA_DATE = vEFFECT_STA_DATE_MAX
                                        ) B ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                            AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= REC2.PLAN_DATE||REC2.PLAN_TIME
                                            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN (
                                                SELECT HOL FROM tmp_holiday  -- ใช้ tmp แทน UNION ซ้ำๆ
                                            );
                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_PLAN_DATETIME := NULL;       
                                    END;                                                        
                                
                                ELSE 
                                    BEGIN
                                        SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA) INTO V_PLAN_DATETIME
                                        FROM tmp_working_day A   -- ใช้ tmp แทน View
                                        JOIN tmp_delivery_master B   -- ใช้ tmp แทน View
                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                            AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= REC2.PLAN_DATE||REC2.PLAN_TIME
                                            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN (
                                                SELECT HOL FROM tmp_holiday  -- ใช้ tmp แทน UNION ซ้ำๆ
                                            );
                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                        V_PLAN_DATETIME := NULL;       
                                    END;
                                END IF;

                                IF V_PLAN_DATETIME IS NOT NULL THEN
                                    V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                    V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                ELSE 
                                    BEGIN
                                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                            REC1.FACTORY_CD, REC1.PART_NO,
                                            REC1.DIM, REC1.USE_BLOCK_CD,
                                            REC1.SUPPLIER_CD, REC1.CLASS,
                                            100,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            REC2.PLAN_QTY_REF_LOT, 'WF0019':: varchar,
                                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                                    EXCEPTION WHEN OTHERS THEN NULL;
                                    END;
                                END IF;

                                IF V_delivery_date||V_delivery_Time >= vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                    BEGIN
                                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                            REC1.FACTORY_CD, REC1.PART_NO,
                                            REC1.DIM, REC1.USE_BLOCK_CD,
                                            REC1.SUPPLIER_CD, REC1.CLASS,
                                            100,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            V_delivery_date, V_delivery_Time,
                                            REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                                    EXCEPTION WHEN OTHERS THEN NULL;
                                    END;
                                ELSIF V_delivery_date||V_delivery_Time < vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                    BEGIN
                                        PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                            REC1.FACTORY_CD, REC1.PART_NO,
                                            REC1.DIM, REC1.USE_BLOCK_CD,
                                            REC1.SUPPLIER_CD, REC1.CLASS,
                                            100,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            REC2.PLAN_DATE, REC2.PLAN_TIME,
                                            REC2.PLAN_QTY_REF_LOT, 'WF0018':: varchar,
                                            REC0.LOGIC, REC1.CD_SPLY_FACT);
                                    EXCEPTION WHEN OTHERS THEN NULL;
                                    END;
                                END IF;

                            END; -- END V_CombiDay = 'D'

                        -- ============================================================
                        -- 9.4) V_NM_KEY_TABLE IS NULL AND V_CombiDay <> 'D'
                        -- ============================================================
                        ELSIF REC1.V_NM_KEY_TABLE IS NULL AND (REC1.V_CombiDay <> 'D') THEN
                            BEGIN
                                SELECT MIN(DT_DELV) INTO V_MIN_DT_DELV
                                FROM dosystem.T_PUR_PO_FOR_DO_DAILY_J300
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
                            
                            -- 9.4.2) DT_DELV not found
                            IF V_MIN_DT_DELV IS NULL THEN
                                BEGIN
                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                        REC1.FACTORY_CD, REC1.PART_NO,
                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                        100,
                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                        REC2.PLAN_QTY_REF_LOT, 'WF0017':: varchar,
                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                EXCEPTION WHEN OTHERS THEN NULL;
                                END; 
                            
                            -- 9.4.3) V_CombiDay BETWEEN '2' AND '9' OR W OR M
                            ELSIF (REC1.V_CombiDay BETWEEN '2' AND '9') OR (REC1.V_CombiDay = 'W' OR REC1.V_CombiDay = 'M') THEN
                                BEGIN
                                    V_delivery_date := V_MIN_DT_DELV;
                                    VChk_Flg := 'Y';
                                    
                                    IF REC1.V_CombiDay = 'W' THEN
                                        V_Num_Day_Slide := 7;
                                    ELSIF REC1.V_CombiDay = 'M' THEN
                                        V_Num_Day_Slide := 30;
                                    END IF;
                                    
                                    IF V_delivery_date = REC2.PLAN_DATE THEN
                                        BEGIN
                                            BEGIN
                                                SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA) INTO V_PLAN_DATETIME
                                                FROM tmp_working_day A   -- ใช้ tmp แทน View
                                                JOIN tmp_delivery_master B   -- ใช้ tmp แทน View
                                                    ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                WHERE FACTORY_CD = REC1.FACTORY_CD
                                                    AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC2.PLAN_TIME
                                                    AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                    AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN (
                                                        SELECT HOL FROM tmp_holiday  -- ใช้ tmp แทน UNION ซ้ำๆ
                                                    );
                                            EXCEPTION WHEN NO_DATA_FOUND THEN
                                                V_PLAN_DATETIME := NULL;       
                                            END;
                                            
                                            IF V_PLAN_DATETIME IS NOT NULL THEN
                                                V_delivery_date := SUBSTR(V_PLAN_DATETIME,1,8);
                                                V_delivery_Time := SUBSTR(V_PLAN_DATETIME,9,4);
                                            ELSE
                                                BEGIN
                                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                        REC1.FACTORY_CD, REC1.PART_NO,
                                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                                        100,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        REC2.PLAN_QTY_REF_LOT, 'WF0019':: varchar,
                                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                                EXCEPTION WHEN OTHERS THEN NULL;
                                                END;
                                            END IF;
                                               
                                            IF V_delivery_date||V_delivery_Time >= vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                                BEGIN
                                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                        REC1.FACTORY_CD, REC1.PART_NO,
                                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                                        100,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        V_delivery_date, V_delivery_Time,
                                                        REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                                EXCEPTION WHEN OTHERS THEN NULL;
                                                END;
                                            ELSIF V_delivery_date||V_delivery_Time < vNEXT_DEL||'0800' AND V_PLAN_DATETIME IS NOT NULL THEN
                                                BEGIN
                                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                        REC1.FACTORY_CD, REC1.PART_NO,
                                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                                        100,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        REC2.PLAN_QTY_REF_LOT, 'WF0018':: varchar,
                                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                                EXCEPTION WHEN OTHERS THEN NULL;
                                                END;
                                            END IF;
                                        END;

                                    -- 9.4.3.4) V_delivery_date <> PLAN_DATE
                                    ELSIF V_delivery_date <> REC2.PLAN_DATE THEN
                                        BEGIN
                                            WHILE (V_delivery_date||V_delivery_Time > REC2.PLAN_DATE||REC2.PLAN_TIME OR VChk_Flg = 'N') 
                                            LOOP
                                                IF REC1.V_CombiDay BETWEEN '2' AND '9' THEN
                                                    BEGIN                            
                                                        SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                        FROM (
                                                            SELECT DT_WORK FROM dosystem.wbgzt051
                                                            WHERE MK_WORK = 'Y'
                                                            AND DT_WORK < V_delivery_date
                                                            ORDER BY DT_WORK DESC
                                                            LIMIT REC1.V_CombiDay::integer  -- แก้ ROWNUM เป็น LIMIT
                                                        ) X;
                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_delivery_date := NULL;   
                                                    END;
                                                ELSIF REC1.V_CombiDay = 'W' OR REC1.V_CombiDay = 'M' THEN                                            
                                                    BEGIN                            
                                                        SELECT MIN(DT_WORK) INTO V_delivery_date 
                                                        FROM (
                                                            SELECT DT_WORK FROM dosystem.wbgzt051
                                                            WHERE DT_WORK < V_delivery_date
                                                            ORDER BY DT_WORK DESC
                                                            LIMIT V_Num_Day_Slide::integer  -- แก้ ROWNUM เป็น LIMIT
                                                        ) X;
                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_delivery_date := NULL;         
                                                    END;
                                                END IF;                                        
                                                
                                                IF VChk_Flg = 'N' THEN
                                                    BEGIN
                                                        SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA) INTO V_PLAN_DATETIME
                                                        FROM tmp_working_day A   -- ใช้ tmp แทน View
                                                        JOIN tmp_delivery_master B   -- ใช้ tmp แทน View
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                                            AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||'9999'
                                                            AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN (
                                                                SELECT HOL FROM tmp_holiday
                                                            )
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800';
                                                    EXCEPTION WHEN NO_DATA_FOUND THEN
                                                        V_PLAN_DATETIME := NULL;       
                                                    END;
                                                    
                                                ELSIF VChk_Flg = 'Y' THEN
                                                    BEGIN
                                                        SELECT MAX(SUBSTR(END_DATE,1,8)||TIME_ETA) INTO V_PLAN_DATETIME
                                                        FROM tmp_working_day A   -- ใช้ tmp แทน View
                                                        JOIN tmp_delivery_master B   -- ใช้ tmp แทน View
                                                            ON TIME_ETA BETWEEN SUBSTR(BEGIN_DATE,9,4) AND SUBSTR(END_DATE,9,4) 
                                                        WHERE FACTORY_CD = REC1.FACTORY_CD
                                                            AND SUPPLIER_CD = REC1.SUPPLIER_CD
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA <= V_delivery_date||REC2.PLAN_TIME
                                                            AND SUBSTR(END_DATE,1,8) = V_delivery_date
                                                            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA NOT IN (
                                                                SELECT HOL FROM tmp_holiday
                                                            )
                                                            AND SUBSTR(END_DATE,1,8)||TIME_ETA >= vNEXT_DEL||'0800';
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
                                          
                                            IF V_delivery_date >= vNEXT_DEL THEN
                                                BEGIN
                                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                        REC1.FACTORY_CD, REC1.PART_NO,
                                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                                        100,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        V_delivery_date, V_delivery_Time,
                                                        REC2.PLAN_QTY_REF_LOT, 'WF0000':: varchar,
                                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                                EXCEPTION WHEN OTHERS THEN NULL;
                                                END;
                                            ELSE
                                                BEGIN
                                                    PERFORM dosystem.P_PRD_DO_PLAN_REF_DELIVERY_DATE_INS( 
                                                        REC1.FACTORY_CD, REC1.PART_NO,
                                                        REC1.DIM, REC1.USE_BLOCK_CD,
                                                        REC1.SUPPLIER_CD, REC1.CLASS,
                                                        100,
                                                        REC2.PLAN_DATE, REC2.PLAN_TIME,
                                                        V_delivery_date, V_delivery_Time,
                                                        REC2.PLAN_QTY_REF_LOT, 'WF0018':: varchar,
                                                        REC0.LOGIC, REC1.CD_SPLY_FACT);
                                                EXCEPTION WHEN OTHERS THEN NULL;
                                                END;
                                            END IF;   
                                        END;
                                    END IF; -- V_delivery_date = REC2.PLAN_DATE
                                END;
                            END IF; -- V_MIN_DT_DELV IS NULL
                        END IF; -- V_NM_KEY_TABLE IS NULL

                    END;
                END LOOP; -- END LOOP rec2
            END IF; -- vFLG_IN_HOUSE

        END LOOP; -- END rec1
    END LOOP; -- END rec0

    RETURN 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_date_rate100() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_lot(character varying, character varying, character varying, character varying, character varying, character varying, numeric, smallint, character varying, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_lot(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, pcd_sply_fact character varying, OUT psum_qty_do numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE

V_QT_DELV_LOT             NUMERIC(20);  
V_REMAIN_QTY              NUMERIC(20);
V_SNP_LOT                 NUMERIC(20);
V_QTY_REF_LOT             NUMERIC(20);
vFLG_IN_HOUSE             character varying(2);

    rec1 record;
BEGIN

    BEGIN            
    SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
    FROM dosystem.T_PRD_DO_DELIVERY_MASTER
        WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD IN (
         SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD FROM dosystem.T_PRD_DO_DELIVERY_MASTER 
         WHERE  FACTORY_CD = pFACTORY_CD
         AND SUPPLIER_CD = pSUPPLIER_CD
         AND EFFECT_STA_DATE <= TO_CHAR(CURRENT_DATE,'YYYYMMDD')
         AND CD_SPLY_FACT = pCD_SPLY_FACT
         GROUP BY FACTORY_CD,SUPPLIER_CD);
        

    EXCEPTION WHEN NO_DATA_FOUND THEN         
        vFLG_IN_HOUSE := NULL ;    
    END ;
    
    
    
    IF (vFLG_IN_HOUSE = 'Y') THEN
            
    FOR rec1 IN
	SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_RF_LT 
                FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY	
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
                ORDER BY PLAN_DATE,PLAN_TIME
    LOOP

            BEGIN  

                                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                            CURRENT_DATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);  
                                           
            
            END;
            END LOOP; -- END LOOP CUR 1    
    
    ELSE 
    
                    -- Get data DISTINCT  QT_DELV_LOT
                    BEGIN
                        SELECT DISTINCT  QT_DELV_LOT INTO V_QT_DELV_LOT
                        FROM dosystem.WBGJT002
                        WHERE CD_SPLY	=	pSUPPLIER_CD 
                            AND NO_PARTS	=	pPART_NO 
                            AND NO_ADJ_DIM	=	pDIM 
                            AND CD_SPLY_FACT = pCD_SPLY_FACT
                            AND DT_ENTRY	=	(SELECT MAX(DT_ENTRY) FROM dosystem.WBGJT002
                                                 WHERE CD_SPLY	=	pSUPPLIER_CD 
                                                    AND NO_PARTS	=	pPART_NO 
                                                    AND NO_ADJ_DIM	=	pDIM
                                                    AND CD_SPLY_FACT = pCD_SPLY_FACT);
													
                        IF V_QT_DELV_LOT IS NULL THEN                  
                                        V_QT_DELV_LOT := 0; 
                        END IF;
						
                    END;
                    
                    -- Set Initial data
                    V_REMAIN_QTY := 0; --#ของที่สั่งเกินจากรอบก่อน
				    FOR rec1 IN
					SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_RF_LT 
				                FROM dosystem.T_DO_PLAN_BALANCE_QTY_BY_SPLY	
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
				                ORDER BY PLAN_DATE,PLAN_TIME
				    LOOP
                    BEGIN
                        --#รอบนั้นต้อง Order ของ
                        IF REC1.PLAN_QTY_RF_LT > V_REMAIN_QTY THEN
                            BEGIN
                                V_SNP_LOT := CEIL((REC1.PLAN_QTY_RF_LT - V_REMAIN_QTY) / V_QT_DELV_LOT);
                                                
                                V_QTY_REF_LOT := V_SNP_LOT * V_QT_DELV_LOT;
                                
                                V_REMAIN_QTY := V_QTY_REF_LOT - (REC1.PLAN_QTY_RF_LT - V_REMAIN_QTY);
                                
                                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                            CURRENT_DATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);
                                 
                                    --pSUM_QTY_DO := 0;
                            END;
                        --#รอบนั้นไม่ต้อง Order ของ    
                        ELSIF REC1.PLAN_QTY_RF_LT <= V_REMAIN_QTY THEN
                            BEGIN    
                                V_QTY_REF_LOT := 0;
                                                
                                V_REMAIN_QTY := V_REMAIN_QTY - REC1.PLAN_QTY_RF_LT;
                                
                                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                            CURRENT_DATE,
                                            pLOGIC,
                                            pCD_SPLY_FACT);
                                     --pSUM_QTY_DO := 2;
                            END;
                        END IF;
                        
                    END;
                    END LOOP; -- END LOOP CUR 1
    
    END IF ;

			SELECT
				* INTO PSUM_QTY_DO
			FROM
				DOSYSTEM.P_PRD_DO_PLAN_REF_DEL_DATE (
					PFACTORY_CD,
					PPART_NO,
					PDIM,
					PUSE_BLOCK_CD,
					PSUPPLIER_CD,
					PCLASS,
					PRATIO,
					PLOGIC,
					PNEXT_DEL,
					PCD_SPLY_FACT
				);

   
END;

$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_lot(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, pcd_sply_fact character varying, OUT psum_qty_do numeric) OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_lot_multi_rate(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate() RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_lot_multi_rate_bk1303(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate_bk1303() RETURNS integer
    LANGUAGE plpgsql
    AS $$
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
							 --rec2.SUPPLIER_CD,
							 null,
                             --rec2.PT_RATIO,
							 null,
							 rec1.CLASS,
							 rec4.PLAN_DATE,
							 rec4.PLAN_TIME,
							 rec4.PLAN_QTY_RF_LT,
							 --rec2.CD_SPLY_FACT
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

                        V_PLAN_BY_RATE := CEIL(COALESCE(V_TOTAL_PLAN, 0) * (COALESCE(rec2.PT_RATIO, 0) / 100));

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
                                    (rec1.FACTORY_CD, rec1.USE_BLOCK_CD, 'Not found NEXT PRIORITY', CURRENT_DATE, rec1.PART_NO, rec1.DIM,
                                     rec2.SUPPLIER_CD, rec2.PT_RATIO, rec1.CLASS, rec2.CD_SPLY_FACT);
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
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_lot_multi_rate_bk1303() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_del_lot_rate100(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_del_lot_rate100() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE										 
v_qt_delv_lot             numeric(20);
v_remain_qty              numeric(20,4);
v_snp_lot                 numeric(20);
v_qty_ref_lot             numeric(20);
vflg_in_house            character varying(10) := null;
--
vnext_working_date      character varying(8);
vnext2_working_date     character varying(8);
vnext3_working_date     character varying(8);
vnext_del               character varying(8);

rec0 record;
rec1 record;
rec2 record;
pflg numeric := 1;
BEGIN	    
-- 0.) Delete data table  T_DO_PLAN_BALANCE_QTY
    SET  statement_timeout = 0;
    SET  work_mem = '512MB';  
DELETE FROM  dosystem.T_DO_PLAN_REF_DELIVERY_LOT ;

-- 1.)Get next working day
--N+1
SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
AND MK_WORK = 'Y';

--N+2
SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT_WORKING_DATE
AND MK_WORK = 'Y';

--N+3
SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
FROM dosystem.WBGZT051
WHERE DT_WORK > vNEXT2_WORKING_DATE 
AND MK_WORK = 'Y';

FOR rec0 IN
SELECT DISTINCT LOGIC FROM dosystem.T_DO_PLAN_BALANCE_QTY
LOOP -- Start rec0

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
				FOR rec1 IN 
				SELECT DISTINCT A.FACTORY_CD ,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.SUPPLIER_CD,A.CLASS,B.CD_SPLY_FACT
				                FROM dosystem.T_DO_PLAN_BALANCE_QTY A
				                LEFT JOIN dosystem.WBGJT002 B
				                ON A.PART_NO = B.NO_PARTS
				                AND A.DIM = B.NO_ADJ_DIM
				                AND A.SUPPLIER_CD = B.CD_SPLY
				                WHERE A.RATIO = 100 
				                    AND A.PLAN_DATE||A.PLAN_TIME >= vNEXT_DEL||'0800'
				                    AND A.PLAN_QTY_BALANCE > 0
				                    AND A.LOGIC = REC0.LOGIC
				                ORDER BY A.FACTORY_CD,A.PART_NO,A.DIM,A.USE_BLOCK_CD,A.SUPPLIER_CD,A.CLASS
				LOOP--Start rec1
                        BEGIN            
                        SELECT DISTINCT FLG_IN_HOUSE INTO vFLG_IN_HOUSE  
                        FROM dosystem.T_PRD_DO_DELIVERY_MASTER
                            WHERE EFFECT_STA_DATE||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT IN (
                             SELECT MAX(EFFECT_STA_DATE)||FACTORY_CD||SUPPLIER_CD||CD_SPLY_FACT FROM T_PRD_DO_DELIVERY_MASTER 
                             WHERE  FACTORY_CD = REC1.FACTORY_CD--'RA'
                             AND SUPPLIER_CD = REC1.SUPPLIER_CD--'P181'
                             AND EFFECT_STA_DATE <= TO_CHAR(CURRENT_DATE,'YYYYMMDD')
                             AND CD_SPLY_FACT = REC1.CD_SPLY_FACT--'00'
                             GROUP BY FACTORY_CD,SUPPLIER_CD,CD_SPLY_FACT);                            
         
                        EXCEPTION WHEN NO_DATA_FOUND THEN           
                                vFLG_IN_HOUSE := NULL;                                 
                        END;

                    -- 8.)
                    IF vFLG_IN_HOUSE = 'Y' THEN
                                                   
								FOR rec2 IN
								SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_BALANCE
								                FROM dosystem.T_DO_PLAN_BALANCE_QTY A
								                LEFT JOIN dosystem.WBGJT002 B
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
								                ORDER BY PLAN_DATE,PLAN_TIME
								LOOP--Start rec2
																						
                                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                            CURRENT_DATE,
                                            REC0.LOGIC,
                                            REC1.CD_SPLY_FACT);                                
                                
                                END LOOP;  -- END LOOP CUR 2
                    
                    -- 9.)vFLG_IN_HOUSE  <>  Y
                    ELSE
                    
                                        BEGIN
                                                -- 9.1) Get lot delivery from supplier
                                                SELECT DISTINCT  QT_DELV_LOT INTO V_QT_DELV_LOT								
                                                FROM dosystem.WBGJT002							
                                                WHERE CD_SPLY = REC1.SUPPLIER_CD		
                                                    AND NO_PARTS = REC1.PART_NO				
                                                    AND NO_ADJ_DIM = REC1.DIM	
                                                    AND CD_SPLY_FACT = REC1.CD_SPLY_FACT
                                                    AND DT_ENTRY = (SELECT MAX(DT_ENTRY) FROM dosystem.WBGJT002	 
                                                                    WHERE CD_SPLY = REC1.SUPPLIER_CD AND NO_PARTS = REC1.PART_NO AND NO_ADJ_DIM = REC1.DIM
                                                                    GROUP BY CD_SPLY,NO_PARTS,NO_ADJ_DIM,CD_SPLY_FACT);
                                                    
												IF V_QT_DELV_LOT is null then
                                                    V_QT_DELV_LOT := 0;
												END IF;
                                        END;
                                        -- 9.2) Set Initial data
                                        V_REMAIN_QTY := 0;
                                        
                                        -- 9.3)  Open CUR 2
										FOR rec2 IN
										SELECT PLAN_DATE,PLAN_TIME,PLAN_QTY_BALANCE
										                FROM dosystem.T_DO_PLAN_BALANCE_QTY A
										                LEFT JOIN dosystem.WBGJT002 B
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
										                ORDER BY PLAN_DATE,PLAN_TIME
										LOOP--Start rec2										
                                            BEGIN                                            
                                                -- 9.4) Check  data   PLAN_QTY_BALANCE STD   >  V_REMAIN_QTY
                                                IF REC2.PLAN_QTY_BALANCE > V_REMAIN_QTY AND V_QT_DELV_LOT <> 0 THEN --#รอบนั้นต้อง Order ของ
                                                        --คำนวนหา SNP ของ LOT ที่ต้อง ORDER
                                                        V_SNP_LOT := CEIL((REC2.PLAN_QTY_BALANCE - V_REMAIN_QTY) / V_QT_DELV_LOT);
                                                        
                                                        V_QTY_REF_LOT := V_SNP_LOT * V_QT_DELV_LOT;
                                                        
                                                        V_REMAIN_QTY := ROUND((V_QTY_REF_LOT - (REC2.PLAN_QTY_BALANCE - V_REMAIN_QTY)),4);
                                                        
                                                        INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                                                CURRENT_DATE,
                                                                REC0.LOGIC,
                                                                REC1.CD_SPLY_FACT);                                                        
                                                --END IF;   
                                                
                                                ELSE  --#รอบนั้นไม่ต้อง Order ของ                  
                                                        V_QTY_REF_LOT := 0;
                                                        
                                                        V_REMAIN_QTY := ROUND((V_REMAIN_QTY - REC2.PLAN_QTY_BALANCE),4);
                                                        
                                                        INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_LOT
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
                                                                CURRENT_DATE,
                                                                REC0.LOGIC,
                                                                REC1.CD_SPLY_FACT);
												END IF;
                                            END;
                                        END LOOP; -- END LOOP CUR 2
                    END IF;				
				END LOOP;--end rec1

END LOOP; --End rec0

return pflg;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_del_lot_rate100() OWNER TO dosystem;

--
-- Name: p_prd_do_plan_ref_delivery_date_ins(character varying, character varying, character varying, character varying, character varying, character varying, numeric, character varying, character varying, character varying, character varying, numeric, character varying, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_plan_ref_delivery_date_ins(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, pplan_date character varying, pplan_time character varying, pplan_date_ref_del_date character varying, pplan_time_ref_del_round character varying, pplan_qty numeric, pcomment_msg character varying, plogic smallint, pcd_sply_fact character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE

BEGIN
        INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_DATE
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
                                    CURRENT_DATE,
                                    pLogic,
                                    pCD_SPLY_FACT);
                        --EXCEPTION
                        --WHEN OTHERS THEN
                           --NULL ;
						   
return 1;						   
END;

$$;


ALTER FUNCTION dosystem.p_prd_do_plan_ref_delivery_date_ins(pfactory_cd character varying, ppart_no character varying, pdim character varying, puse_block_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, pplan_date character varying, pplan_time character varying, pplan_date_ref_del_date character varying, pplan_time_ref_del_round character varying, pplan_qty numeric, pcomment_msg character varying, plogic smallint, pcd_sply_fact character varying) OWNER TO dosystem;

--
-- Name: p_prd_do_slide_plan_not_continue(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_slide_plan_not_continue() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    vnext_working_date      CHARACTER VARYING(8);
    vnext2_working_date     CHARACTER VARYING(8);
    vnext3_working_date     CHARACTER VARYING(8);
    vnext_del               CHARACTER VARYING(8);
    chk_plan_night          NUMERIC;
    chk_plan_next_day       NUMERIC;
    vplan_date_from_new     CHARACTER VARYING(8);
    vplan_time_from_new     CHARACTER VARYING(4);
    vplan_date_from_check   CHARACTER VARYING(8);
    vplan_time_from_check   CHARACTER VARYING(4);
    vplan_date_to_new       CHARACTER VARYING(8);
    vplan_time_to_new       CHARACTER VARYING(4);
    next_plan               CHARACTER VARYING(20);
    vstart_slide            CHARACTER VARYING(20);
    vend_slide              CHARACTER VARYING(20);
    flg_holiday             NUMERIC;

    -- ✅ แก้ไข: ลบ AND LINE_CD = 'KU' ออก
    c0 CURSOR FOR
        SELECT DISTINCT A.FACTORY_CD,
            CASE
                WHEN LOGIC IS NULL THEN '1'
                ELSE LOGIC
            END AS LOGIC,
            LINE_CD, C.SP_PLAN_SLIDE
        FROM dosystem.T_DO_PLAN_PLANBYHOUSR A
        LEFT JOIN dosystem.T_PRD_DO_PART_AND_STRUCTURE B
            ON A.FACTORY_CD = B.FACTORY_CD
            AND A.MERCHANDISE_CD = B.MERCHANDISE_CD
        LEFT JOIN (
            SELECT FACTORY_CD, MAX(SP_PLAN_SLIDE) AS SP_PLAN_SLIDE
            FROM dosystem.T_PRD_DO_PART_AND_STRUCTURE
            GROUP BY FACTORY_CD
        ) C ON A.FACTORY_CD = C.FACTORY_CD
        WHERE PLAN_DATE > TO_CHAR(CURRENT_DATE, 'YYYYMMDD');

    rec0 RECORD;

    c1 CURSOR FOR
        SELECT DISTINCT FACTORY_CD, LINE_CD
        FROM dosystem.T_DO_PLAN_PLANBYHOUSR
        WHERE FACTORY_CD = REC0.FACTORY_CD
          AND PLAN_DATE  = vNEXT_DEL
          AND LINE_CD    = REC0.LINE_CD
          AND FACTORY_CD||LINE_CD NOT IN (
              SELECT DISTINCT FACTORY_CD||LINE_CD
              FROM (
                  SELECT FACTORY_CD, LINE_CD, COUNT(*) AS CNT
                  FROM (
                      SELECT DISTINCT FACTORY_CD, LINE_CD, PLAN_DATE, SHIFT
                      FROM dosystem.T_DO_PLAN_PLANBYHOUSR
                      WHERE PLAN_DATE = vNEXT_DEL
                        AND SHIFT = 'N'
                        AND FACTORY_CD = REC0.FACTORY_CD
                      UNION
                      SELECT DISTINCT FACTORY_CD, LINE_CD, PLAN_DATE, SHIFT
                      FROM dosystem.T_DO_PLAN_PLANBYHOUSR
                      WHERE PLAN_DATE = (
                          SELECT MIN(DT_WORK)
                          FROM dosystem.WBGZT051
                          WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL
                      )
                        AND SHIFT = 'D'
                        AND FACTORY_CD = REC0.FACTORY_CD
                  ) t
                  GROUP BY FACTORY_CD, LINE_CD
              ) t2
              WHERE CNT = '2'
          );

    rec1 RECORD;

    c2 CURSOR FOR
        SELECT DISTINCT FACTORY_CD, PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM, SHIFT, LINE_CD
        FROM dosystem.T_DO_PLAN_PLANBYHOUSR
        WHERE FACTORY_CD = REC1.FACTORY_CD
          AND LINE_CD = REC1.LINE_CD
          AND PLAN_DATE_FROM||PLAN_TIME_FROM BETWEEN vSTART_SLIDE AND vEND_SLIDE
          AND PLAN_DATE <= (
              SELECT MIN(DT_WORK)
              FROM dosystem.WBGZT051
              WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL
          )
        ORDER BY PLAN_DATE_FROM, PLAN_TIME_FROM;

    rec2 RECORD;

BEGIN
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';

    BEGIN
        DELETE FROM dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN;

        -- 1.) Get next working day
        -- N+1
        SELECT MIN(DT_WORK) INTO vnext_working_date
        FROM dosystem.WBGZT051
        WHERE DT_WORK > TO_CHAR(CURRENT_DATE, 'YYYYMMDD')
          AND MK_WORK = 'Y';

        -- N+2
        SELECT MIN(DT_WORK) INTO vnext2_working_date
        FROM dosystem.WBGZT051
        WHERE DT_WORK > vnext_working_date
          AND MK_WORK = 'Y';

        -- N+3
        SELECT MIN(DT_WORK) INTO vnext3_working_date
        FROM dosystem.WBGZT051
        WHERE DT_WORK > vnext2_working_date
          AND MK_WORK = 'Y';

        OPEN c0;
        LOOP
            FETCH c0 INTO rec0;
            EXIT WHEN NOT FOUND;

            IF REC0.LOGIC = '1' THEN
                vNEXT_DEL := vnext_working_date;
            ELSIF REC0.LOGIC = '2' THEN
                vNEXT_DEL := vnext2_working_date;
            ELSIF REC0.LOGIC = '3' THEN
                vNEXT_DEL := vnext3_working_date;
            END IF;

            OPEN c1;
            LOOP
                FETCH c1 INTO rec1;
                EXIT WHEN NOT FOUND;

                SELECT COUNT(*) INTO chk_plan_night
                FROM dosystem.T_DO_PLAN_PLANBYSHIFT
                WHERE FACTORY_CD = REC1.FACTORY_CD
                  AND PLAN_DATE  = vNEXT_DEL
                  AND SHIFT      = 'N'
                  AND LINE_CD    = REC1.LINE_CD;

                IF chk_plan_night = 0 THEN

                    BEGIN
                        SELECT MIN(PLAN_DATE_FROM||PLAN_TIME_FROM) INTO vstart_slide
                        FROM dosystem.T_DO_PLAN_PLANBYSHIFT
                        WHERE PLAN_DATE_FROM||PLAN_TIME_FROM > vNEXT_DEL||'2000'
                          AND PLAN_DATE <= (
                              SELECT DISTINCT MIN(DT_WORK)
                              FROM dosystem.WBGZT051
                              WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL
                          )
                          AND FACTORY_CD = REC1.FACTORY_CD
                          AND LINE_CD    = REC1.LINE_CD;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        vstart_slide := NULL;
                    END;

                    SELECT COUNT(*) INTO flg_holiday
                    FROM dosystem.V_DO_WORKING_TIME
                    WHERE DT_PLAN||PLAN_TIME = vstart_slide;

                    IF flg_holiday > 0 THEN
                        BEGIN
                            SELECT DT_PLAN||PLAN_TIME INTO vend_slide
                            FROM (
                                SELECT ROW_NUMBER() OVER (ORDER BY DT_PLAN||PLAN_TIME ASC) AS SLIDE_LT,
                                       PLAN_TIME, DT_PLAN
                                FROM dosystem.V_DO_WORKING_TIME
                                WHERE DT_PLAN||PLAN_TIME >= vstart_slide
                            ) sub
                            WHERE SLIDE_LT = REC0.SP_PLAN_SLIDE;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                            vend_slide := NULL;
                        END;
                    ELSE
                        BEGIN
                            SELECT DT_PLAN||PLAN_TIME INTO vend_slide
                            FROM (
                                SELECT ROW_NUMBER() OVER (ORDER BY DT_PLAN||PLAN_TIME ASC) AS SLIDE_LT,
                                       PLAN_TIME, DT_PLAN
                                FROM dosystem.V_DO_NOT_WORKING_TIME
                                WHERE DT_PLAN||PLAN_TIME >= vstart_slide
                            ) sub
                            WHERE SLIDE_LT = REC0.SP_PLAN_SLIDE;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                            vend_slide := NULL;
                        END;
                    END IF;

                    vplan_date_from_check := vNEXT_DEL;
                    vplan_time_from_check := '1900';

                    OPEN c2;
                    LOOP
                        FETCH c2 INTO rec2;
                        EXIT WHEN NOT FOUND;

                        SELECT SUBSTR(DT_WORK, 1, 8), SUBSTR(DT_WORK, 9, 4)
                        INTO vplan_date_from_new, vplan_time_from_new
                        FROM (
                            SELECT MIN(DT_WORK||PLAN_TIME) AS DT_WORK
                            FROM dosystem.V_DO_WORKING_TIME
                            WHERE DT_WORK||PLAN_TIME > vplan_date_from_check||vplan_time_from_check
                        ) t;

                        vplan_date_from_check := vplan_date_from_new;
                        vplan_time_from_check := vplan_time_from_new;
                        next_plan := vplan_date_from_new||' '||vplan_time_from_new;

                        SELECT SUBSTR(next_plan_val, 1, 8), SUBSTR(next_plan_val, 10, 4)
                        INTO vplan_date_to_new, vplan_time_to_new
                        FROM (
                            SELECT TO_CHAR(
                                TO_TIMESTAMP(next_plan, 'YYYYMMDD HH24MI') + INTERVAL '1 hour',
                                'YYYYMMDD HH24MI'
                            ) AS next_plan_val
                        ) t;

                        INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN (
                            FACTORY_CD, MERCHANDISE_CD,
                            PLAN_DATE_BF, PLAN_DATE_FROM_BF, PLAN_TIME_FROM_BF,
                            PLAN_DATE_TO_BF, PLAN_TIME_TO_BF, SHIFT_BF,
                            PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
                            PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
                            LINE_CD, PLAN_QTY, LOGIC, SP_PLAN_SLIDE, CREATE_DATE, CHANGE_FLG
                        )
                        SELECT
                            FACTORY_CD, MERCHANDISE_CD,
                            PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
                            PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
                            vNEXT_DEL, vplan_date_from_new, vplan_time_from_new,
                            vplan_date_to_new, vplan_time_to_new, 'N',
                            LINE_CD, PLAN_QTY, REC0.LOGIC, REC0.SP_PLAN_SLIDE, CURRENT_DATE, 'Y'
                        FROM dosystem.T_DO_PLAN_PLANBYHOUSR
                        WHERE FACTORY_CD    = REC2.FACTORY_CD
                          AND PLAN_DATE_FROM = REC2.PLAN_DATE_FROM
                          AND PLAN_TIME_FROM = REC2.PLAN_TIME_FROM
                          AND SHIFT          = REC2.SHIFT
                          AND LINE_CD        = REC2.LINE_CD;

                    END LOOP;
                    CLOSE c2;

                ELSE

                    SELECT COUNT(*) INTO chk_plan_next_day
                    FROM dosystem.T_DO_PLAN_PLANBYSHIFT
                    WHERE FACTORY_CD = REC1.FACTORY_CD
                      AND PLAN_DATE  = (
                          SELECT MIN(DT_WORK)
                          FROM dosystem.WBGZT051
                          WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL
                      )
                      AND SHIFT   = 'D'
                      AND LINE_CD = REC1.LINE_CD;

                    IF chk_plan_next_day = 0 THEN

                        BEGIN
                            SELECT MIN(PLAN_DATE_FROM||PLAN_TIME_FROM) INTO vstart_slide
                            FROM dosystem.T_DO_PLAN_PLANBYSHIFT
                            WHERE PLAN_DATE_FROM||PLAN_TIME_FROM > (
                                SELECT MIN(DT_WORK)
                                FROM dosystem.WBGZT051
                                WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL
                            )||'1900'
                              AND FACTORY_CD = REC1.FACTORY_CD
                              AND LINE_CD    = REC1.LINE_CD;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                            vstart_slide := NULL;
                        END;

                        BEGIN
                            SELECT DT_PLAN||PLAN_TIME INTO vend_slide
                            FROM (
                                SELECT ROW_NUMBER() OVER (ORDER BY DT_PLAN||PLAN_TIME ASC) AS SLIDE_LT,
                                       PLAN_TIME, DT_PLAN
                                FROM dosystem.V_DO_WORKING_TIME
                                WHERE DT_PLAN||PLAN_TIME >= vstart_slide
                            ) sub
                            WHERE SLIDE_LT = REC0.SP_PLAN_SLIDE;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                            vend_slide := NULL;
                        END;

                        SELECT MIN(DT_WORK) INTO vplan_date_from_check
                        FROM dosystem.WBGZT051
                        WHERE MK_WORK = 'Y' AND DT_WORK > vNEXT_DEL;

                        vplan_time_from_check := '0700';

                        OPEN c2;
                        LOOP
                            FETCH c2 INTO rec2;
                            EXIT WHEN NOT FOUND;

                            SELECT SUBSTR(DT_WORK, 1, 8), SUBSTR(DT_WORK, 9, 4)
                            INTO vplan_date_from_new, vplan_time_from_new
                            FROM (
                                SELECT MIN(DT_WORK||PLAN_TIME) AS DT_WORK
                                FROM dosystem.V_DO_WORKING_TIME
                                WHERE DT_WORK||PLAN_TIME > vplan_date_from_check||vplan_time_from_check
                            ) t;

                            vplan_date_from_check := vplan_date_from_new;
                            vplan_time_from_check := vplan_time_from_new;
                            next_plan := vplan_date_from_new||' '||vplan_time_from_new;

                            SELECT SUBSTR(next_plan_val, 1, 8), SUBSTR(next_plan_val, 10, 4)
                            INTO vplan_date_to_new, vplan_time_to_new
                            FROM (
                                SELECT TO_CHAR(
                                    TO_TIMESTAMP(next_plan, 'YYYYMMDD HH24MI') + INTERVAL '1 hour',
                                    'YYYYMMDD HH24MI'
                                ) AS next_plan_val
                            ) t;

                            INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN (
                                FACTORY_CD, MERCHANDISE_CD,
                                PLAN_DATE_BF, PLAN_DATE_FROM_BF, PLAN_TIME_FROM_BF,
                                PLAN_DATE_TO_BF, PLAN_TIME_TO_BF, SHIFT_BF,
                                PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
                                PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
                                LINE_CD, PLAN_QTY, LOGIC, SP_PLAN_SLIDE, CREATE_DATE, CHANGE_FLG
                            )
                            SELECT
                                FACTORY_CD, MERCHANDISE_CD,
                                PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
                                PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
                                vplan_date_from_new, vplan_date_from_new, vplan_time_from_new,
                                vplan_date_to_new, vplan_time_to_new, 'D',
                                LINE_CD, PLAN_QTY, REC0.LOGIC, REC0.SP_PLAN_SLIDE, CURRENT_DATE, 'Y'
                            FROM dosystem.T_DO_PLAN_PLANBYHOUSR
                            WHERE FACTORY_CD    = REC2.FACTORY_CD
                              AND PLAN_DATE_FROM = REC2.PLAN_DATE_FROM
                              AND PLAN_TIME_FROM = REC2.PLAN_TIME_FROM
                              AND SHIFT          = REC2.SHIFT
                              AND LINE_CD        = REC2.LINE_CD;

                        END LOOP;
                        CLOSE c2;

                    END IF; -- chk_plan_next_day

                END IF; -- chk_plan_night

            END LOOP;
            CLOSE c1;

        END LOOP;
        CLOSE c0;

        INSERT INTO dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN (
            FACTORY_CD, MERCHANDISE_CD,
            PLAN_DATE_BF, PLAN_DATE_FROM_BF, PLAN_TIME_FROM_BF,
            PLAN_DATE_TO_BF, PLAN_TIME_TO_BF, SHIFT_BF,
            PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
            PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
            LINE_CD, PLAN_QTY, LOGIC, SP_PLAN_SLIDE, CREATE_DATE, CHANGE_FLG
        )
        SELECT
            FACTORY_CD, MERCHANDISE_CD,
            PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
            PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
            PLAN_DATE, PLAN_DATE_FROM, PLAN_TIME_FROM,
            PLAN_DATE_TO, PLAN_TIME_TO, SHIFT,
            LINE_CD, PLAN_QTY, LOGIC, SP_PLAN_SLIDE, CURRENT_DATE, 'N'
        FROM (
            SELECT DISTINCT A.*,
                CASE WHEN LOGIC IS NULL THEN '1' ELSE LOGIC END AS LOGIC,
                SP_PLAN_SLIDE
            FROM dosystem.T_DO_PLAN_PLANBYHOUSR A
            LEFT JOIN dosystem.T_PRD_DO_PART_AND_STRUCTURE B
                ON A.FACTORY_CD    = B.FACTORY_CD
                AND A.MERCHANDISE_CD = B.MERCHANDISE_CD
        ) t
        WHERE FACTORY_CD||PLAN_DATE||PLAN_DATE_FROM||PLAN_TIME_FROM||SHIFT||LINE_CD||LOGIC
              NOT IN (
                  SELECT DISTINCT FACTORY_CD||PLAN_DATE_BF||PLAN_DATE_FROM_BF||PLAN_TIME_FROM_BF||SHIFT_BF||LINE_CD||LOGIC
                  FROM dosystem.T_DO_PLAN_PLANBYHOUSR_BF_SLIDE_PLAN
              );

    END;

    RETURN 1;

END;
$$;


ALTER FUNCTION dosystem.p_prd_do_slide_plan_not_continue() OWNER TO dosystem;

--
-- Name: p_prd_do_target_structure(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_target_structure() RETURNS integer
    LANGUAGE plpgsql
    AS $$

BEGIN
    
    SET LOCAL statement_timeout = 0;
    SET LOCAL work_mem = '512MB';
	
    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'01. DO SYSTEM TARGET STRUCTURE PART START') ;
   

    PERFORM  dosystem.p_prd_do_target_structure_part() ;  

    INSERT INTO dosystem.T_DO_OPERATION_LOG
    ( OPERATION_DATE , OPERATION_TIME ,OPERATION_NAME ) 
    VALUES (TO_CHAR(CURRENT_DATE,'YYYYMMDD') ,TO_CHAR(clock_timestamp(),'HH24MISS'),'01. DO SYSTEM TARGET STRUCTURE PART COMPLETE') ;
       
 
    ------------------------------------------------------------------------------------------------------------  
return 1;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_target_structure() OWNER TO dosystem;

--
-- Name: p_prd_do_target_structure_part(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.p_prd_do_target_structure_part() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE

c1 CURSOR FOR
select distinct factory_cd,part_no,dim,block_cd,supplier_cd,total_process_lt,
rk_prio_divi,pt_ratio,dt_b_valid,dt_e_valid,logic,sp_plan_slide
from dosystem.v_do_part_target ;

rec1 record;

c2 CURSOR FOR
select distinct merchandise_cd,merchandise_dim,merchandise_block,cf_supply_class,cf_odr_class
from dosystem.v_do_part_structure
where part_no = rec1.part_no	
and dim = rec1.dim	
and use_block = rec1.block_cd 
and suppiler =  rec1.supplier_cd ;

rec2 record;
vused NUMERIC(20,11) ;
flag integer := 0;
BEGIN
    SET  LOCAL statement_timeout = 10;
    SET  LOCAL work_mem = '512MB';  
	DELETE from dosystem.T_PRD_DO_PART_AND_STRUCTURE ;
	
	OPEN c1;
    LOOP
        FETCH c1 INTO rec1;		
        EXIT WHEN NOT FOUND; 
		
		OPEN c2;
    	LOOP
        FETCH c2 INTO rec2;		
        EXIT WHEN NOT FOUND; 
                                begin
                                 select  sum(coalesce(used,0))  into vused ---max(used) into vused
                                 from    ( 
                                   select distinct merchandise_cd,merchandise_dim,merchandise_cntl_poi,merchandise_block,
                                   part_no,dim,use_block,part_no_cntl_poi,suppiler,used,cf_supply_class,cf_odr_class
                                   from dosystem.v_do_part_structure
                                    where part_no	= rec1.part_no
                                    and   dim = rec1.dim	
                                    and use_block = rec1.block_cd 
                                    and merchandise_cd = rec2.merchandise_cd
                                    and cf_supply_class =  rec2.cf_supply_class
                                    and cf_odr_class = rec2.cf_odr_class  );
                                    
                                    exception
                                     when no_data_found then                                     
                                     vused := 0 ;
                                     
                                    end ;
                                    
                                    if ( vused is null ) then
                                    
                                        vused := 0 ;
                                    
                                    end if ;

                                                  insert into dosystem.t_prd_do_part_and_structure 
                                                            (   factory_cd ,
                                                                part_no ,
                                                                dim ,
                                                                block_cd ,
                                                                supplier_cd ,
                                                                total_process_lt ,
                                                                rk_prio_divi ,
                                                                pt_ratio ,
                                                                dt_b_valid ,
                                                                dt_e_valid ,
                                                                merchandise_cd ,
                                                                merchandise_dim ,
                                                                merchandise_block ,
                                                                used ,
                                                                class ,
                                                                update_date,
                                                                logic,
                                                                sp_plan_slide
                                                            ) 
                                                        values(
                                                            rec1.factory_cd,
                                                            rec1.part_no,
                                                            rec1.dim,
                                                            rec1.block_cd,
                                                            rec1.supplier_cd,
                                                            rec1.total_process_lt,
                                                            rec1.rk_prio_divi,
                                                            rec1.pt_ratio,
                                                            rec1.dt_b_valid,
                                                            rec1.dt_e_valid,
                                                            rec2.merchandise_cd,
                                                            rec2.merchandise_dim,
                                                            rec2.merchandise_block,
                                                            vused,
                                                            rec2.cf_supply_class||'/'||rec2.cf_odr_class,
                                                            CURRENT_DATE,
                                                            rec1.logic,
                                                            rec1.sp_plan_slide
                                                            );
		flag := flag + 1;

		END LOOP;
		CLOSE c2; 
	END LOOP;
	CLOSE c1; 

	return flag;
END;
$$;


ALTER FUNCTION dosystem.p_prd_do_target_structure_part() OWNER TO dosystem;

--
-- Name: pg_prd_do_slide_del_case_plan_change(); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.pg_prd_do_slide_del_case_plan_change() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE                                         
    vnext_working_date      character varying(8);
    vnext2_working_date     character varying(8);
    vnext3_working_date     character varying(8);
    vnext_del               character varying(8);
    vnext_next_del          character varying(8);
    vfirst_round            character varying(4);
    
    rec0 record;
    rec1 record;
    pflg numeric := 0;
BEGIN   
    SET statement_timeout = 0;
    SET work_mem = '512MB';  
 
    -- 0.)Get next working day
    --N+1
    SELECT MIN(DT_WORK) INTO vNEXT_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > TO_CHAR(CURRENT_DATE,'YYYYMMDD') 
    AND MK_WORK = 'Y';

    --N+2
    SELECT MIN(DT_WORK) INTO vNEXT2_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT_WORKING_DATE
    AND MK_WORK = 'Y';

    --N+3
    SELECT MIN(DT_WORK) INTO vNEXT3_WORKING_DATE
    FROM dosystem.WBGZT051
    WHERE DT_WORK > vNEXT2_WORKING_DATE 
    AND MK_WORK = 'Y';

    FOR rec0 IN
        SELECT DISTINCT LOGIC FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE WHERE RATIO = 100 AND COMMENT_MSG =  'WF0018' 
    LOOP
        -- 2.1)Set value  vNEXT_DEL  
        IF REC0.LOGIC = '1' THEN
            vNEXT_DEL := vNEXT_WORKING_DATE;
        ELSIF REC0.LOGIC = '2' THEN
            vNEXT_DEL := vNEXT2_WORKING_DATE;
        ELSIF REC0.LOGIC = '3' THEN
            vNEXT_DEL := vNEXT3_WORKING_DATE;
        END IF;

        FOR rec1 IN
            SELECT DISTINCT FACTORY_CD ,SUPPLIER_CD,CD_SPLY_FACT
            FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
            WHERE PLAN_DATE = vNEXT_DEL
            AND LOGIC = REC0.LOGIC
            AND RATIO = 100
            AND PLAN_QTY > 0
            AND COMMENT_MSG =  'WF0018'
        LOOP
            -- 2.1.2)Get Find first delivery round on Delivery master
            SELECT MIN(TIME_ETA) INTO vFirst_round
            FROM dosystem.V_PRD_DO_DELIVERY_MASTER
            WHERE FACTORY_CD  = REC1.FACTORY_CD
            AND SUPPLIER_CD  = REC1.SUPPLIER_CD
            AND TIME_ETA BETWEEN '0800' AND '2300'
            AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
            
            -- 1.1)IF vFirst_round is not null
            IF vFirst_round IS NOT NULL THEN
                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_DATE 
                SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                        vNEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',LOCALTIMESTAMP,LOGIC,CD_SPLY_FACT  -- เปลี่ยนเป็น LOCALTIMESTAMP
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                WHERE PLAN_DATE = vNEXT_DEL
                AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                AND LOGIC = REC0.LOGIC
                AND RATIO = 100
                AND PLAN_QTY > 0
                AND FACTORY_CD = REC1.FACTORY_CD
                AND SUPPLIER_CD = REC1.SUPPLIER_CD
                AND COMMENT_MSG =  'WF0018' 
                AND CD_SPLY_FACT = REC1.CD_SPLY_FACT;
                
            -- 2.1) IF vFirst_round is null    
            ELSIF vFirst_round IS NULL THEN            
                SELECT MIN(DT_WORK) INTO vNEXT_NEXT_DEL
                FROM dosystem.WBGZT051
                WHERE DT_WORK > vNEXT_DEL
                AND MK_WORK = 'Y';                    
                
                INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_DATE 
                SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                        vNEXT_NEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',LOCALTIMESTAMP,LOGIC,CD_SPLY_FACT -- เปลี่ยนเป็น LOCALTIMESTAMP
                FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                -- แก้ไขจุดสำคัญ: ใช้ COALESCE เพื่อจัดการ NULL string concatenation
                WHERE PLAN_DATE||PLAN_TIME BETWEEN vNEXT_DEL||'0800' AND vNEXT_NEXT_DEL||COALESCE(vFirst_round, '')
                AND PLAN_TIME  BETWEEN '0800' AND COALESCE(vFirst_round, '2359') -- ป้องกันกรณีแผนเวลา error ถ้า vFirst_round เป็น null (Oracle จะ ignore, แต่เพื่อความชัวร์ควรจัดการ)
                AND LOGIC = REC0.LOGIC
                AND RATIO = 100
                AND PLAN_QTY > 0
                AND FACTORY_CD = REC1.FACTORY_CD
                AND SUPPLIER_CD = REC1.SUPPLIER_CD
                AND COMMENT_MSG =  'WF0018';                
            END IF;
        END LOOP;--END rec1
    END LOOP;--End rec0

    pflg := 1;
    RETURN pflg;
END;
$$;


ALTER FUNCTION dosystem.pg_prd_do_slide_del_case_plan_change() OWNER TO dosystem;

--
-- Name: pg_prd_do_slide_del_case_plan_change(character varying, character varying, character varying, character varying, character varying, character varying, numeric, smallint, character varying); Type: FUNCTION; Schema: dosystem; Owner: dosystem
--

CREATE FUNCTION dosystem.pg_prd_do_slide_del_case_plan_change(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, OUT pflg numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE										 

vnext_next_del          character varying(8);
vfirst_round            character varying(4);

BEGIN	
    SET  statement_timeout = 0;
    SET  work_mem = '512MB';  
 
	BEGIN
                -- 2.1.2)Get Find first delivery round on Delivery master
                SELECT MIN(TIME_ETA) INTO vFirst_round
                FROM dosystem.V_PRD_DO_DELIVERY_MASTER
                WHERE FACTORY_CD  = pFACTORY_CD
                AND SUPPLIER_CD  = pSUPPLIER_CD
                AND TIME_ETA BETWEEN '0800' AND '2300';
                
                EXCEPTION WHEN NO_DATA_FOUND THEN           
                    vFirst_round := NULL; 	
	END;

            IF vFirst_round IS NOT NULL THEN
                BEGIN
                
                    INSERT INTO T_DO_PLAN_REF_DELIVERY_DATE 
                    SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                            pNEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',CURRENT_DATE,LOGIC,CD_SPLY_FACT
                    FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
                    WHERE PLAN_DATE = pNEXT_DEL
                    AND PLAN_TIME  BETWEEN '0800' AND vFirst_round
                    AND LOGIC = pLogic
                    AND RATIO NOT IN ( '100','0' )
                    AND PLAN_QTY > 0
                    AND FACTORY_CD = pFACTORY_CD
                    AND SUPPLIER_CD = pSUPPLIER_CD
                    AND COMMENT_MSG =  'WF0018' ;
                
                END;
            ELSIF vFirst_round IS NULL THEN            
 
                    BEGIN
                    
                        SELECT MIN(DT_WORK) INTO vNEXT_NEXT_DEL
                        FROM dosystem.WBGZT051
                        WHERE DT_WORK > pNEXT_DEL
                        AND MK_WORK = 'Y';                    
                    
                    END;
                    
                    BEGIN
                    
                        INSERT INTO dosystem.T_DO_PLAN_REF_DELIVERY_DATE 
                        SELECT FACTORY_CD,PART_NO,DIM,USE_BLOCK_CD,SUPPLIER_CD,RATIO,CLASS,PLAN_DATE,PLAN_TIME,
                                vNEXT_NEXT_DEL,vFirst_round,PLAN_QTY,'WF0000',CURRENT_DATE,LOGIC,CD_SPLY_FACT
                        FROM dosystem.T_DO_PLAN_REF_DELIVERY_DATE
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

				

END;
$$;


ALTER FUNCTION dosystem.pg_prd_do_slide_del_case_plan_change(pfactory_cd character varying, ppart_no character varying, pdim character varying, pblock_cd character varying, psupplier_cd character varying, pclass character varying, pratio numeric, plogic smallint, pnext_del character varying, OUT pflg numeric) OWNER TO dosystem;

--
-- Name: error_message; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.error_message (
    error_message character varying(6) NOT NULL,
    message_th character varying(80),
    message_en character varying(80),
    create_userid character varying(10),
    create_date timestamp(0) without time zone,
    update_userid character varying(10),
    update_date timestamp(0) without time zone
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'ERROR_MESSAGE'
);
ALTER FOREIGN TABLE ONLY dosystem.error_message ALTER COLUMN error_message OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.error_message OWNER TO dosystem;

--
-- Name: j000_supplier_master; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.j000_supplier_master (
    cd_data_cntl character varying(1) NOT NULL,
    cd_sply_class character varying(1) NOT NULL,
    cd_glbl_sply character varying(9) NOT NULL,
    cd_fact character varying(2) NOT NULL,
    cd_sply character varying(4) NOT NULL,
    cf_invent_dem character varying(2) NOT NULL,
    no_arrange character varying(6) NOT NULL,
    cd_sply_fact character varying(2) NOT NULL,
    cd_sply_ofic_class character varying(1) NOT NULL,
    nm_sply_local character varying(60) NOT NULL,
    nm_sply_eng character varying(60) NOT NULL,
    nm_presid character varying(40) NOT NULL,
    am_capital bigint NOT NULL,
    cd_curr character varying(3) NOT NULL,
    mk_subcon character varying(1) NOT NULL,
    pd_oblig_purch smallint NOT NULL,
    dt_contr character varying(8) NOT NULL,
    dt_wins_contr character varying(8) NOT NULL,
    dt_busin_start character varying(8) NOT NULL,
    cd_post character varying(9) NOT NULL,
    ad_sply character varying(230) NOT NULL,
    nm_sply_sect character varying(100) NOT NULL,
    nm_person character varying(40) NOT NULL,
    no_tel character varying(20) NOT NULL,
    no_fax character varying(20) NOT NULL,
    ad_mail character varying(50) NOT NULL,
    mk_direct_delv_posb character varying(1) NOT NULL,
    mk_fix_delv_dirct_qty character varying(1) NOT NULL,
    mk_wins_instal character varying(1) NOT NULL,
    mk_ord_edi character varying(1) NOT NULL,
    mk_estim_edi character varying(1) NOT NULL,
    mk_guart_edi character varying(1) NOT NULL,
    mk_invent_edi character varying(1) NOT NULL,
    mk_proxy_acptc_edi character varying(1) NOT NULL,
    mk_insp_result_edi character varying(1) NOT NULL,
    mk_pay_edi character varying(1) NOT NULL,
    mk_draw_edi character varying(1) NOT NULL,
    mk_deduc_edi character varying(1) NOT NULL,
    cd_ord_class_def character varying(1) NOT NULL,
    cd_procur_person_def character varying(10) NOT NULL,
    cd_estim_person_def character varying(10) NOT NULL,
    pd_delv_dirct_def smallint NOT NULL,
    pd_fix_period_requi_def smallint NOT NULL,
    pd_po_issue_def smallint NOT NULL,
    pd_prdc_guart_def smallint NOT NULL,
    pd_mtrl_guart_def smallint NOT NULL,
    pd_prdc_info_def smallint NOT NULL,
    pd_delv_qty_round_def character varying(1) NOT NULL,
    mk_resv_bal_ord_def character varying(1) NOT NULL,
    mk_procur_auth_def character varying(1) NOT NULL,
    cd_trade_terms_def character varying(3) NOT NULL,
    cd_corpo character varying(4) NOT NULL,
    sp_corpo character varying(3) NOT NULL,
    wd_sply_sprvisr character varying(3) NOT NULL,
    cd_cosmos_maker character varying(9) NOT NULL,
    cd_maker character varying(9) NOT NULL,
    in_phyci_dis character varying(20) NOT NULL,
    ar_remk character varying(30) NOT NULL,
    mk_grat_char character varying(1) NOT NULL,
    cd_proc_class character varying(1) NOT NULL,
    pd_eta character varying(2) NOT NULL,
    cf_return character varying(1) NOT NULL,
    cf_ret character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone NOT NULL,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone NOT NULL,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'J000_SUPPLIER_MASTER'
);


ALTER FOREIGN TABLE dosystem.j000_supplier_master OWNER TO dosystem;

--
-- Name: t_do_delivery_date_master; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_delivery_date_master (
    combine_day character varying(1),
    day_of_week character varying(1),
    day_delivery character varying(100),
    comment character varying(200),
    create_date date,
    create_by character varying(7),
    update_date date,
    update_by character varying(7)
);


ALTER TABLE dosystem.t_do_delivery_date_master OWNER TO dosystem;

--
-- Name: t_do_find_del_for_multi_rate; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_find_del_for_multi_rate (
    factory_cd character varying(10),
    part_no character varying(40),
    dim character varying(9),
    use_block_cd character varying(10),
    class character varying(10),
    plan_date character varying(20),
    plan_time character varying(20),
    del_date character varying(20),
    day_of_week character varying(20),
    combiday character varying(20),
    update_date date,
    cd_sply_fact character varying(2)
);


ALTER TABLE dosystem.t_do_find_del_for_multi_rate OWNER TO dosystem;

--
-- Name: t_do_operation_log; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_operation_log (
    operation_date character varying(8),
    operation_time character varying(8),
    operation_name character varying(100)
);


ALTER TABLE dosystem.t_do_operation_log OWNER TO dosystem;

--
-- Name: t_do_plan_a_and_z_dr_sum; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_a_and_z_dr_sum (
    factory_cd character varying(2),
    no_parts character varying(36) NOT NULL,
    no_adj_dim character varying(9) NOT NULL,
    cd_use_block character varying(18),
    class character varying(6),
    plan_date character varying(24) NOT NULL,
    plan_time character varying(4),
    plan_qty numeric(12,0) NOT NULL,
    total_process_lt numeric(6,0),
    logic numeric(1,0)
);


ALTER TABLE dosystem.t_do_plan_a_and_z_dr_sum OWNER TO dosystem;

--
-- Name: t_do_plan_balance_qty; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_balance_qty (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    supplier_cd character varying(6),
    ratio numeric(5,2),
    class character varying(6),
    plan_date character varying(8),
    plan_time character varying(4),
    plan_qty_rf_lt numeric(20,4),
    plan_qty_balance numeric(20,4),
    use_block_cd character varying(4),
    create_date date,
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_balance_qty OWNER TO dosystem;

--
-- Name: t_do_plan_balance_qty_by_sply; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_balance_qty_by_sply (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    supplier_cd character varying(6),
    ratio numeric(5,2),
    class character varying(6),
    plan_date character varying(8),
    plan_time character varying(4),
    plan_qty_rf_lt numeric(20,4),
    plan_qty_balance numeric(20,4),
    use_block_cd character varying(4),
    create_date date,
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_balance_qty_by_sply OWNER TO dosystem;

--
-- Name: t_do_plan_part_ref_process_lt; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_part_ref_process_lt (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    total_process_lt integer,
    class character varying(6),
    plan_qty numeric(8,4),
    plan_date character varying(8),
    plan_time character varying(4),
    plan_date_rf_lt character varying(8),
    plan_time_rf_lt character varying(4),
    use_block_cd character varying(4),
    create_date date,
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_part_ref_process_lt OWNER TO dosystem;

--
-- Name: t_do_plan_plan_part_byhousr; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_plan_part_byhousr (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    block_cd character varying(4),
    supplier_cd character varying(4),
    total_process_lt integer,
    rk_prio_divi integer,
    pt_ratio numeric(5,2),
    dt_b_valid character varying(24),
    dt_e_valid character varying(24),
    merchandise_cd character varying(36),
    class character varying(6),
    plan_qty numeric(12,4),
    plan_date character varying(8),
    plan_time character varying(4),
    update_date date,
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_plan_part_byhousr OWNER TO dosystem;

--
-- Name: t_do_plan_plan_part_byhousr_bf; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_plan_part_byhousr_bf (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    block_cd character varying(4),
    supplier_cd character varying(4),
    total_process_lt integer,
    rk_prio_divi integer,
    pt_ratio numeric(5,2),
    dt_b_valid character varying(24),
    dt_e_valid character varying(24),
    merchandise_cd character varying(36),
    class character varying(6),
    plan_qty numeric(12,4),
    plan_date character varying(8),
    plan_time character varying(4),
    update_date date,
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_plan_part_byhousr_bf OWNER TO dosystem;

--
-- Name: t_do_plan_planbyhousr; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_planbyhousr (
    factory_cd character varying(2),
    merchandise_cd character varying(12),
    plan_date character varying(8),
    plan_date_from character varying(8),
    plan_time_from character varying(4),
    plan_date_to character varying(8),
    plan_time_to character varying(4),
    shift character varying(1),
    line_cd character varying(2),
    plan_qty integer,
    create_date date
);


ALTER TABLE dosystem.t_do_plan_planbyhousr OWNER TO dosystem;

--
-- Name: t_do_plan_planbyhousr_bf_slide_plan; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_planbyhousr_bf_slide_plan (
    factory_cd character varying(2),
    merchandise_cd character varying(12),
    plan_date_bf character varying(8),
    plan_date_from_bf character varying(8),
    plan_time_from_bf character varying(4),
    plan_date_to_bf character varying(8),
    plan_time_to_bf character varying(4),
    shift_bf character varying(1),
    plan_date character varying(8),
    plan_date_from character varying(8),
    plan_time_from character varying(4),
    plan_date_to character varying(8),
    plan_time_to character varying(4),
    shift character varying(1),
    line_cd character varying(2),
    plan_qty integer,
    logic smallint,
    sp_plan_slide smallint,
    create_date date,
    change_flg character varying(1)
);


ALTER TABLE dosystem.t_do_plan_planbyhousr_bf_slide_plan OWNER TO dosystem;

--
-- Name: t_do_plan_planbyshift; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_planbyshift (
    factory_cd character varying(2),
    plan_date_from character varying(8),
    plan_time_from character varying(4),
    plan_date_to character varying(8),
    plan_time_to character varying(4),
    shift character varying(1),
    line_cd character varying(2),
    plan_qty integer,
    create_date date,
    plan_date character varying(8)
);


ALTER TABLE dosystem.t_do_plan_planbyshift OWNER TO dosystem;

--
-- Name: t_do_plan_ref_delivery_date; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_ref_delivery_date (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    use_block_cd character varying(4),
    supplier_cd character varying(6),
    ratio numeric(5,2),
    class character varying(6),
    plan_date character varying(8),
    plan_time character varying(4),
    plan_date_ref_del_date character varying(8),
    plan_time_ref_del_round character varying(4),
    plan_qty numeric(12,2),
    comment_msg character varying(100),
    create_date date,
    logic smallint,
    cd_sply_fact character varying(2)
);


ALTER TABLE dosystem.t_do_plan_ref_delivery_date OWNER TO dosystem;

--
-- Name: t_do_plan_ref_delivery_lot; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_ref_delivery_lot (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    use_block_cd character varying(4),
    supplier_cd character varying(6),
    ratio numeric(5,2),
    class character varying(6),
    plan_date character varying(8),
    plan_time character varying(4),
    plan_qty_ref_lot numeric(12,2),
    create_date date,
    logic smallint,
    cd_sply_fact character varying(2)
);


ALTER TABLE dosystem.t_do_plan_ref_delivery_lot OWNER TO dosystem;

--
-- Name: t_do_plan_std_stock; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_std_stock (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    class character varying(6),
    use_block_cd character varying(4),
    qty_inventory numeric(20,4),
    qty_delivery_order numeric(20,4),
    qty_plan numeric(20,4),
    qty_stock_nextday numeric(20,4),
    qty_std_stock numeric(20,4),
    qty_over_stock numeric(20,4),
    create_date date,
    std_stock_plan_date character varying(8),
    std_stock_plan_time character varying(4),
    total_process_lt integer,
    plan_qty_a_and_z numeric(20,4),
    plan_qty_main_and_unit numeric(20,4),
    logic smallint
);


ALTER TABLE dosystem.t_do_plan_std_stock OWNER TO dosystem;

--
-- Name: t_do_plan_stock_begin_nextday; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_stock_begin_nextday (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    class character varying(6),
    use_block_cd character varying(4),
    qty_inventory numeric(20,2),
    qty_delivery_order numeric(20,2),
    qty_plan numeric(20,2),
    qty_stock numeric(20,2),
    create_date date
);


ALTER TABLE dosystem.t_do_plan_stock_begin_nextday OWNER TO dosystem;

--
-- Name: t_do_plan_working_time_master; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_do_plan_working_time_master (
    no_id numeric,
    plan_time character varying(4)
);


ALTER TABLE dosystem.t_do_plan_working_time_master OWNER TO dosystem;

--
-- Name: t_inv_daily_wip_e001; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_inv_daily_wip_e001 (
    cd_fact character varying(2) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    no_line character varying(2) NOT NULL,
    no_stock_poi character varying(9) NOT NULL,
    cd_block character varying(6),
    cd_stock_poi_seq smallint,
    mk_process character varying(2),
    mk_use_obj character varying(1),
    mk_delete character varying(1),
    mk_comp_supp_to character varying(1),
    mk_comp_supp_from character varying(1),
    mk_supp_to character varying(1),
    mk_supp_from character varying(1),
    mk_mrp_obj character varying(1),
    cf_supply_class character varying(1),
    qt_invent numeric(12,3),
    filler character varying(5)
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'T_INV_DAILY_WIP_E001'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN cd_fact OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN no_parts OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN no_adj_dim OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN no_invent_cntl_poi OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN no_line OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_inv_daily_wip_e001 ALTER COLUMN no_stock_poi OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.t_inv_daily_wip_e001 OWNER TO dosystem;

--
-- Name: t_prd_do_delivery_master_bk; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_delivery_master_bk (
    factory_cd character varying(2) NOT NULL,
    supplier_cd character varying(4) NOT NULL,
    effect_sta_date character varying(8) NOT NULL,
    supplier_name character varying(100),
    time_eta_1 character varying(4),
    time_eta_2 character varying(4),
    time_eta_3 character varying(4),
    time_eta_4 character varying(4),
    time_eta_5 character varying(4),
    time_eta_6 character varying(4),
    time_eta_7 character varying(4),
    time_eta_8 character varying(4),
    time_eta_9 character varying(4),
    time_eta_10 character varying(4),
    time_eta_11 character varying(4),
    time_eta_12 character varying(4),
    time_eta_13 character varying(4),
    time_eta_14 character varying(4),
    time_eta_15 character varying(4),
    time_eta_16 character varying(4),
    time_eta_17 character varying(4),
    time_eta_18 character varying(4),
    time_eta_19 character varying(4),
    time_eta_20 character varying(4),
    time_eta_21 character varying(4),
    time_eta_22 character varying(4),
    time_eta_23 character varying(4),
    time_eta_24 character varying(4),
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    flg_in_house character varying(1)
);


ALTER TABLE dosystem.t_prd_do_delivery_master_bk OWNER TO dosystem;

--
-- Name: t_prd_do_delivery_master_his; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_delivery_master_his (
    type character varying(3),
    factory_cd character varying(2),
    supplier_cd character varying(4),
    effect_sta_date character varying(8),
    supplier_name character varying(100),
    time_eta_1 character varying(4),
    time_eta_2 character varying(4),
    time_eta_3 character varying(4),
    time_eta_4 character varying(4),
    time_eta_5 character varying(4),
    time_eta_6 character varying(4),
    time_eta_7 character varying(4),
    time_eta_8 character varying(4),
    time_eta_9 character varying(4),
    time_eta_10 character varying(4),
    time_eta_11 character varying(4),
    time_eta_12 character varying(4),
    time_eta_13 character varying(4),
    time_eta_14 character varying(4),
    time_eta_15 character varying(4),
    time_eta_16 character varying(4),
    time_eta_17 character varying(4),
    time_eta_18 character varying(4),
    time_eta_19 character varying(4),
    time_eta_20 character varying(4),
    time_eta_21 character varying(4),
    time_eta_22 character varying(4),
    time_eta_23 character varying(4),
    time_eta_24 character varying(4),
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    history_entry_date date,
    history_entry_by character varying(10),
    flg_in_house character varying(1),
    cd_sply_fact character varying(2)
);


ALTER TABLE dosystem.t_prd_do_delivery_master_his OWNER TO dosystem;

--
-- Name: t_prd_do_delivery_master_his_bk; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_delivery_master_his_bk (
    type character varying(3),
    factory_cd character varying(2),
    supplier_cd character varying(4),
    effect_sta_date character varying(8),
    supplier_name character varying(100),
    time_eta_1 character varying(4),
    time_eta_2 character varying(4),
    time_eta_3 character varying(4),
    time_eta_4 character varying(4),
    time_eta_5 character varying(4),
    time_eta_6 character varying(4),
    time_eta_7 character varying(4),
    time_eta_8 character varying(4),
    time_eta_9 character varying(4),
    time_eta_10 character varying(4),
    time_eta_11 character varying(4),
    time_eta_12 character varying(4),
    time_eta_13 character varying(4),
    time_eta_14 character varying(4),
    time_eta_15 character varying(4),
    time_eta_16 character varying(4),
    time_eta_17 character varying(4),
    time_eta_18 character varying(4),
    time_eta_19 character varying(4),
    time_eta_20 character varying(4),
    time_eta_21 character varying(4),
    time_eta_22 character varying(4),
    time_eta_23 character varying(4),
    time_eta_24 character varying(4),
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    history_entry_date date,
    history_entry_by character varying(10),
    flg_in_house character varying(1)
);


ALTER TABLE dosystem.t_prd_do_delivery_master_his_bk OWNER TO dosystem;

--
-- Name: t_prd_do_part_and_structure; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_part_and_structure (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    block_cd character varying(4),
    supplier_cd character varying(4),
    total_process_lt integer,
    rk_prio_divi integer,
    pt_ratio numeric(5,2),
    dt_b_valid character varying(24),
    dt_e_valid character varying(24),
    merchandise_cd character varying(36),
    merchandise_dim character varying(9),
    merchandise_block character varying(18),
    used numeric(20,11),
    class character varying(6),
    update_date date,
    logic smallint,
    sp_plan_slide smallint
);


ALTER TABLE dosystem.t_prd_do_part_and_structure OWNER TO dosystem;

--
-- Name: t_prd_do_part_and_structure_test; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_part_and_structure_test (
    factory_cd character varying(2),
    part_no character varying(12),
    dim character varying(3),
    block_cd character varying(4),
    supplier_cd character varying(4),
    total_process_lt integer,
    rk_prio_divi integer,
    pt_ratio numeric(5,2),
    dt_b_valid character varying(24),
    dt_e_valid character varying(24),
    merchandise_cd character varying(36),
    merchandise_dim character varying(9),
    merchandise_block character varying(18),
    used numeric(20,11),
    class character varying(6),
    update_date date,
    logic smallint,
    sp_plan_slide smallint
);


ALTER TABLE dosystem.t_prd_do_part_and_structure_test OWNER TO dosystem;

--
-- Name: t_prd_do_part_master; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_part_master (
    factory_cd character varying(2) NOT NULL,
    part_no character varying(12) NOT NULL,
    dim character varying(3) NOT NULL,
    block_cd character varying(4) NOT NULL,
    supplier_cd character varying(4) NOT NULL,
    total_process_lt integer NOT NULL,
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    logic smallint,
    sp_plan_slide smallint
);


ALTER TABLE dosystem.t_prd_do_part_master OWNER TO dosystem;

--
-- Name: t_prd_do_part_master_his; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_part_master_his (
    type character varying(3),
    factory_cd character varying(2) NOT NULL,
    part_no character varying(12) NOT NULL,
    dim character varying(3) NOT NULL,
    block_cd character varying(4) NOT NULL,
    supplier_cd character varying(4) NOT NULL,
    total_process_lt integer NOT NULL,
    create_date date,
    create_by character varying(10),
    update_date date,
    update_by character varying(10),
    history_date date,
    history_by character varying(10),
    logic smallint,
    sp_plan_slide smallint
);


ALTER TABLE dosystem.t_prd_do_part_master_his OWNER TO dosystem;

--
-- Name: t_prd_do_result; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.t_prd_do_result (
    factory_cd character varying(2),
    delivery_key character varying(30),
    delivery_date character varying(10),
    delivery_time character varying(4),
    delivery_order numeric(20,2),
    block_cd character varying(4),
    delivery_location character varying(20),
    inventory_code character varying(50),
    comment character varying(100),
    approver character varying(100),
    result character varying(100),
    update_date timestamp without time zone,
    plan_date character varying(8),
    plan_time character varying(4),
    part_no character varying(12),
    dim character varying(3),
    supplier_cd character varying(6),
    ratio numeric(5,2),
    class character varying(6),
    logic numeric(1,0),
    cd_sply_fact character varying(2)
);


ALTER TABLE dosystem.t_prd_do_result OWNER TO dosystem;

--
-- Name: t_prd_h401_euc; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_h401_euc (
    no_seq character varying(8) NOT NULL,
    no_consistant_seq character varying(7) NOT NULL,
    cd_in_fact character varying(2) NOT NULL,
    no_in_parts character varying(12) NOT NULL,
    no_in_adj_dim character varying(3) NOT NULL,
    no_in_invent_ctl_poi character varying(4) NOT NULL,
    no_in_line character varying(2) NOT NULL,
    cd_in_block character varying(6) NOT NULL,
    no_in_const_patt character varying(2) NOT NULL,
    cf_in_chg_stat_clss character varying(1) NOT NULL,
    dt_in_date character varying(8) NOT NULL,
    mk_in_unused character varying(1) NOT NULL,
    mk_in_lt character varying(1) NOT NULL,
    dt_in_ship_enable character varying(8) NOT NULL,
    no_construction character varying(1000) NOT NULL,
    no_level character varying(3) NOT NULL,
    no_path character varying(4000) NOT NULL,
    no_consump_divi_path character varying(4000) NOT NULL,
    cf_supply_class_all character varying(100) NOT NULL,
    cf_odr_class_all character varying(100) NOT NULL,
    mk_stock character varying(1) NOT NULL,
    mk_next_exist character varying(1) NOT NULL,
    mk_products character varying(1) NOT NULL,
    qt_supply_cnt smallint NOT NULL,
    mk_re_clss character varying(3) NOT NULL,
    qt_mother_deliv_level smallint NOT NULL,
    mk_mother_deliv character varying(3) NOT NULL,
    qt_consump_divi numeric(20,11) NOT NULL,
    qt_consumption_all numeric(20,11) NOT NULL,
    qt_division_all numeric(20,11) NOT NULL,
    mk_consump_divi_all character varying(1) NOT NULL,
    qt_consump_divi_all numeric(20,11) NOT NULL,
    qt_consump_divi_all_sum numeric(20,11) NOT NULL,
    qt_consump_divi_all_cnt smallint NOT NULL,
    cf_child_base character varying(3) NOT NULL,
    cd_piece character varying(3) NOT NULL,
    nm_parts_eng character varying(40) NOT NULL,
    nm_parts_local character varying(60) NOT NULL,
    pd_lead_time_all smallint NOT NULL,
    ar_parts_flow character varying(200) NOT NULL,
    dt_start_expec character varying(8) NOT NULL,
    dt_ship_enable character varying(8) NOT NULL,
    dt_mother_start_expec character varying(8) NOT NULL,
    dt_chld_ship_enable character varying(8) NOT NULL,
    dt_start_expec_slide character varying(8),
    dt_ship_enable_slide character varying(8),
    dt_mother_start_expec_slide character varying(8),
    dt_chld_ship_enable_slide character varying(8),
    cd_fact character varying(2) NOT NULL,
    no_mother_parts character varying(12) NOT NULL,
    no_mother_adj_dim character varying(3) NOT NULL,
    no_mother_invent_ctl_poi character varying(4) NOT NULL,
    no_mother_line character varying(2) NOT NULL,
    cd_block character varying(6) NOT NULL,
    no_chld_parts character varying(12) NOT NULL,
    no_chld_adj_dim character varying(3) NOT NULL,
    no_chld_invent_ctl_poi character varying(4) NOT NULL,
    no_chld_line character varying(2) NOT NULL,
    no_hist_change character varying(9) NOT NULL,
    no_hist_change_sfx character varying(4) NOT NULL,
    cf_chg_stat_clss character varying(1) NOT NULL,
    no_chg_notification character varying(8) NOT NULL,
    dt_b_valid character varying(8) NOT NULL,
    dt_e_valid character varying(8) NOT NULL,
    mk_ope character varying(1) NOT NULL,
    cd_chg_obj character varying(2) NOT NULL,
    dt_entry_date character varying(8) NOT NULL,
    dt_entry_time character varying(6) NOT NULL,
    no_hist_change_h001 character varying(9) NOT NULL,
    no_hist_change_sfx_h001 character varying(4) NOT NULL,
    cf_chg_stat_clss_h001 character varying(1) NOT NULL,
    no_chg_notification_h001 character varying(8) NOT NULL,
    cd_block_h001 character varying(6) NOT NULL,
    cd_process_h001 character varying(2) NOT NULL,
    no_draw_h001 character varying(6) NOT NULL,
    dt_b_valid_h001 character varying(8) NOT NULL,
    dt_e_valid_h001 character varying(8) NOT NULL,
    mk_ope_h001 character varying(1) NOT NULL,
    cd_chg_obj_h001 character varying(2) NOT NULL,
    cf_re_clss_h001 character varying(1) NOT NULL,
    dt_entry_date_h001 character varying(8) NOT NULL,
    dt_entry_time_h001 character varying(6) NOT NULL,
    no_post_h002 character varying(3) NOT NULL,
    dt_b_valid_h003 character varying(8) NOT NULL,
    dt_e_valid_h003 character varying(8) NOT NULL,
    mk_substit_h003 character varying(1) NOT NULL,
    no_parts_h003 character varying(12) NOT NULL,
    no_adj_dim_h003 character varying(3) NOT NULL,
    cd_block_h003 character varying(6) NOT NULL,
    no_legular_parts_h003 character varying(12) NOT NULL,
    no_legular_adj_dim_h003 character varying(3) NOT NULL,
    no_substit_parts_h003 character varying(12) NOT NULL,
    no_substit_adj_dim_h003 character varying(3) NOT NULL,
    pt_substit_h003 numeric(5,2) NOT NULL,
    cd_block_h005 character varying(6) NOT NULL,
    rk_prio_divi_h005 smallint NOT NULL,
    pt_ratio_h005 numeric(5,2) NOT NULL,
    dt_b_valid_h005 character varying(8) NOT NULL,
    dt_e_valid_h005 character varying(8) NOT NULL,
    tm_store_lead_h005 smallint NOT NULL,
    pd_process_h005 smallint NOT NULL,
    cf_io_h005 character varying(1) NOT NULL,
    mk_pile_prio_h005 character varying(1) NOT NULL,
    cf_supply_class_h007 character varying(1) NOT NULL,
    cf_odr_class_h007 character varying(1) NOT NULL,
    qt_consumption_h007 numeric(12,5) NOT NULL,
    qt_division_h007 numeric(12,5) NOT NULL,
    pd_lt_entry_h007 smallint NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone NOT NULL,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone NOT NULL,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'T_PRD_H401_EUC'
);


ALTER FOREIGN TABLE dosystem.t_prd_h401_euc OWNER TO dosystem;

--
-- Name: t_prd_plan_a3_assy_plan; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_plan_a3_assy_plan (
    factory_cd character varying(2),
    model_seq character varying(10),
    plan_date character varying(8),
    shift character varying(1),
    line_cd character varying(2),
    cell_name character varying(20),
    priority_for_minus character varying(2),
    priority character varying(2),
    merchandise_cd character varying(12),
    plan_qty integer,
    diff_cum_minus_flag character varying(1),
    plus_qty integer,
    create_date timestamp(0) without time zone,
    create_by character varying(10),
    update_date timestamp(0) without time zone,
    update_by character varying(10),
    comment_assy character varying(100),
    autotype character varying(10),
    old_line_cd character varying(2)
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'T_PRD_PLAN_A3_ASSY_PLAN'
);


ALTER FOREIGN TABLE dosystem.t_prd_plan_a3_assy_plan OWNER TO dosystem;

--
-- Name: t_prd_plan_a3_overtime_cd; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_plan_a3_overtime_cd (
    factory_cd character varying(2) NOT NULL,
    overtime_cd character varying(50) NOT NULL,
    shift character varying(1) NOT NULL,
    overtime_begin character varying(5) NOT NULL,
    overtime_end character varying(5) NOT NULL,
    workingtime_min smallint,
    create_date timestamp(0) without time zone,
    create_by character varying(10),
    update_date timestamp(0) without time zone,
    update_by character varying(10)
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'T_PRD_PLAN_A3_OVERTIME_CD'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_overtime_cd ALTER COLUMN factory_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_overtime_cd ALTER COLUMN overtime_cd OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.t_prd_plan_a3_overtime_cd OWNER TO dosystem;

--
-- Name: t_prd_plan_a3_planbyshift; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_plan_a3_planbyshift (
    factory_cd character varying(2) NOT NULL,
    model_seq character varying(10) NOT NULL,
    plan_date character varying(8) NOT NULL,
    shift character varying(1) NOT NULL,
    line_cd character varying(2) NOT NULL,
    cell_name character varying(20),
    priority character varying(2) NOT NULL,
    merchandise_cd character varying(12) NOT NULL,
    plan_qty integer,
    create_date timestamp(0) without time zone,
    create_by character varying(10),
    update_date timestamp(0) without time zone,
    update_by character varying(10)
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'T_PRD_PLAN_A3_PLANBYSHIFT'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN factory_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN model_seq OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN plan_date OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN shift OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN line_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN priority OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_planbyshift ALTER COLUMN merchandise_cd OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.t_prd_plan_a3_planbyshift OWNER TO dosystem;

--
-- Name: t_prd_plan_a3_workshift_cd; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_plan_a3_workshift_cd (
    factory_cd character varying(2) NOT NULL,
    workshift_cd character varying(50) NOT NULL,
    shift character varying(1) NOT NULL,
    work1_begin character varying(5) NOT NULL,
    work1_end character varying(5) NOT NULL,
    break1_begin character varying(5) NOT NULL,
    break1_end character varying(5) NOT NULL,
    work2_begin character varying(5) NOT NULL,
    work2_end character varying(5) NOT NULL,
    break2_begin character varying(5) NOT NULL,
    break2_end character varying(5) NOT NULL,
    work3_begin character varying(5) NOT NULL,
    work3_end character varying(5) NOT NULL,
    break3_begin character varying(5) NOT NULL,
    break3_end character varying(5) NOT NULL,
    work4_begin character varying(5) NOT NULL,
    work4_end character varying(5) NOT NULL,
    workingtime_min smallint,
    create_date timestamp(0) without time zone,
    create_by character varying(10),
    update_date timestamp(0) without time zone,
    update_by character varying(10)
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'T_PRD_PLAN_A3_WORKSHIFT_CD'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_cd ALTER COLUMN factory_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_cd ALTER COLUMN workshift_cd OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.t_prd_plan_a3_workshift_cd OWNER TO dosystem;

--
-- Name: t_prd_plan_a3_workshift_n_cap; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_prd_plan_a3_workshift_n_cap (
    factory_cd character varying(2) NOT NULL,
    plan_date character varying(8) NOT NULL,
    line_cd character varying(3) NOT NULL,
    shift character varying(1) NOT NULL,
    workshift_cd_day character varying(50),
    overtime_cd_day character varying(50),
    workshift_cd_night character varying(50),
    overtime_cd_night character varying(50),
    cap_qty integer,
    cycle_time numeric(7,2),
    create_date timestamp(0) without time zone,
    create_by character varying(10),
    update_date timestamp(0) without time zone,
    update_by character varying(10)
)
SERVER oracle_prodtest_prod
OPTIONS (
    schema 'PROD',
    "table" 'T_PRD_PLAN_A3_WORKSHIFT_N_CAP'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_n_cap ALTER COLUMN factory_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_n_cap ALTER COLUMN plan_date OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_n_cap ALTER COLUMN line_cd OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.t_prd_plan_a3_workshift_n_cap ALTER COLUMN shift OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.t_prd_plan_a3_workshift_n_cap OWNER TO dosystem;

--
-- Name: t_pur_po_for_do_daily_j300; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.t_pur_po_for_do_daily_j300 (
    nm_argmet_stat character varying(2) NOT NULL,
    cd_sply character varying(4) NOT NULL,
    cd_ord_class character varying(1) NOT NULL,
    mk_sum_flg character varying(1) NOT NULL,
    no_po character varying(9) NOT NULL,
    mk_po_chk_digit smallint NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    dt_delv character varying(8) NOT NULL,
    tm_delv character varying(6) NOT NULL,
    qt_delv_dirct_bal numeric(12,3) NOT NULL,
    qt_delv_dirct numeric(12,3) NOT NULL,
    qt_acptc_bal numeric(12,3) NOT NULL,
    dt_acptc character varying(8) NOT NULL,
    cd_delv_place character varying(4) NOT NULL,
    cd_use_block character varying(6) NOT NULL,
    no_ord_class character varying(4) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'T_PUR_PO_FOR_DO_DAILY_J300'
);


ALTER FOREIGN TABLE dosystem.t_pur_po_for_do_daily_j300 OWNER TO dosystem;

--
-- Name: v_combiday; Type: TABLE; Schema: dosystem; Owner: dosystem
--

CREATE TABLE dosystem.v_combiday (
    upper text
);


ALTER TABLE dosystem.v_combiday OWNER TO dosystem;

--
-- Name: wbgzt051; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbgzt051 (
    cd_foothold character varying(4) NOT NULL,
    dt_work character varying(8) NOT NULL,
    mk_work character varying(1) NOT NULL,
    cf_day numeric NOT NULL,
    dt_month_work numeric NOT NULL,
    dt_week_work numeric NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGZT051'
);
ALTER FOREIGN TABLE ONLY dosystem.wbgzt051 ALTER COLUMN cd_foothold OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbgzt051 ALTER COLUMN dt_work OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.wbgzt051 OWNER TO dosystem;

--
-- Name: v_do_check_plan_not_continue; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_check_plan_not_continue AS
 SELECT a.factory_cd,
    a.line_cd,
    b.dt_work,
    c.shift
   FROM ((( SELECT DISTINCT t_do_plan_planbyhousr.factory_cd,
            t_do_plan_planbyhousr.line_cd,
            'C'::text AS for_join
           FROM dosystem.t_do_plan_planbyhousr
          WHERE ((t_do_plan_planbyhousr.plan_date)::text >= to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text))) a
     JOIN ( SELECT wbgzt051.dt_work,
            'C'::text AS for_join
           FROM dosystem.wbgzt051
          WHERE (((wbgzt051.mk_work)::text = 'Y'::text) AND ((wbgzt051.dt_work)::text >= to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)))) b ON ((a.for_join = b.for_join)))
     JOIN ( SELECT 'D'::text AS shift,
            'C'::text AS for_join
        UNION
         SELECT 'N'::text AS shift,
            'C'::text AS for_join) c ON ((a.for_join = c.for_join)));


ALTER VIEW dosystem.v_do_check_plan_not_continue OWNER TO dosystem;

--
-- Name: wbght006; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbght006 (
    cd_fact character varying(2) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    no_line character varying(2) NOT NULL,
    cf_arrange_way character varying(1) NOT NULL,
    pt_poor smallint NOT NULL,
    qt_safe_stock numeric(12,3) NOT NULL,
    dt_renew_p_ss character varying(8) NOT NULL,
    cf_mesh character varying(1) NOT NULL,
    pd_gross_add smallint NOT NULL,
    cd_cal character varying(1) NOT NULL,
    mk_day_integrate character varying(1) NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGHT006'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght006 ALTER COLUMN cd_fact OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght006 ALTER COLUMN no_parts OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght006 ALTER COLUMN no_adj_dim OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght006 ALTER COLUMN no_invent_cntl_poi OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght006 ALTER COLUMN no_line OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.wbght006 OWNER TO dosystem;

--
-- Name: wbgzt031; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbgzt031 (
    nm_item character varying(25) NOT NULL,
    cd_fact character varying(2) NOT NULL,
    ky_table character varying(30) NOT NULL,
    nm_key_table character varying(20) NOT NULL,
    ar_key_table character varying(100) NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGZT031'
);
ALTER FOREIGN TABLE ONLY dosystem.wbgzt031 ALTER COLUMN nm_item OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbgzt031 ALTER COLUMN cd_fact OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbgzt031 ALTER COLUMN ky_table OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.wbgzt031 OWNER TO dosystem;

--
-- Name: v_do_delevery_day_of_week; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_delevery_day_of_week AS
 SELECT DISTINCT h006.no_parts,
    h006.no_adj_dim,
    h006.mk_day_integrate,
    COALESCE(z031.nm_key_table, ' '::character varying) AS nm_key_table
   FROM (( SELECT wbght006.no_parts,
            wbght006.no_adj_dim,
            wbght006.mk_day_integrate
           FROM dosystem.wbght006
          WHERE ((((wbght006.no_parts)::text || (wbght006.no_adj_dim)::text) || wbght006.dt_entry) IN ( SELECT (((wbght006_1.no_parts)::text || (wbght006_1.no_adj_dim)::text) || max(wbght006_1.dt_entry))
                   FROM dosystem.wbght006 wbght006_1
                  GROUP BY wbght006_1.no_parts, wbght006_1.no_adj_dim))) h006
     LEFT JOIN ( SELECT
                CASE
                    WHEN ((z031_1.nm_key_table)::text = 'Y:Mon/Tue/Wed/Thu/Fr'::text) THEN 'Y:Mon/Tue/Wed/Thu/Fri'::character varying
                    ELSE z031_1.nm_key_table
                END AS nm_key_table,
            z031_1.ar_key_table
           FROM dosystem.wbgzt031 z031_1
          WHERE (((z031_1.nm_item)::text = 'GG250023'::text) AND ((TRIM(BOTH FROM z031_1.cd_fact) IS NULL) OR ((z031_1.cd_fact)::text = 'VH'::text)))) z031 ON (((h006.mk_day_integrate)::text = (z031.ar_key_table)::text)))
  WHERE ((h006.mk_day_integrate)::text <> ' '::text);


ALTER VIEW dosystem.v_do_delevery_day_of_week OWNER TO dosystem;

--
-- Name: wbght005; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbght005 (
    cd_fact character varying(2) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    no_line character varying(2) NOT NULL,
    cd_block character varying(6) NOT NULL,
    dt_b_valid character varying(8) NOT NULL,
    mk_para_produc_divi character varying(1) NOT NULL,
    rk_prio_divi smallint NOT NULL,
    pt_ratio numeric(5,2) NOT NULL,
    qt_fix numeric(12,3) NOT NULL,
    qt_bundle numeric(12,3) NOT NULL,
    tm_store_lead smallint NOT NULL,
    pd_process smallint NOT NULL,
    tm_dirct_bill_pub_lead smallint NOT NULL,
    dt_renew_lead character varying(8) NOT NULL,
    dt_e_valid character varying(8) NOT NULL,
    cd_release_no character varying(1) NOT NULL,
    cf_io character varying(1) NOT NULL,
    mk_indicate_out character varying(1) NOT NULL,
    mk_pile_prio character varying(1) NOT NULL,
    cd_cal character varying(1) NOT NULL,
    cf_customer_setting_clss character varying(1) NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGHT005'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN cd_fact OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN no_parts OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN no_adj_dim OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN no_invent_cntl_poi OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN no_line OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN cd_block OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght005 ALTER COLUMN dt_b_valid OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.wbght005 OWNER TO dosystem;

--
-- Name: wbgjt002; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbgjt002 (
    cd_data_cntl character varying(1) NOT NULL,
    cd_fact character varying(2) NOT NULL,
    cd_sply character varying(4) NOT NULL,
    cf_invent_dem character varying(2) NOT NULL,
    no_arrange character varying(6) NOT NULL,
    cd_sply_fact character varying(2) NOT NULL,
    cd_glbl_sply character varying(9) NOT NULL,
    cd_ord_class character varying(1) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    cd_process character varying(2) NOT NULL,
    cd_tape character varying(3) NOT NULL,
    qt_snp numeric(10,3) NOT NULL,
    mk_fix_delv_lot character varying(1) NOT NULL,
    qt_delv_lot numeric(10,3) NOT NULL,
    cf_patt character varying(2) NOT NULL,
    cd_argmet_type character varying(1) NOT NULL,
    cd_packag_spec character varying(10) NOT NULL,
    cd_procur_person character varying(10) NOT NULL,
    cd_estim_person character varying(10) NOT NULL,
    pd_delv_dirct smallint NOT NULL,
    pd_fix_period_requi smallint NOT NULL,
    pd_po_issue smallint NOT NULL,
    pd_prdc_guart smallint NOT NULL,
    pd_mtrl_guart smallint NOT NULL,
    pd_prdc_info smallint NOT NULL,
    pd_delv_qty_round character varying(1) NOT NULL,
    pd_mrp_delv_qty_round character varying(1) NOT NULL,
    pd_oblig_purch smallint NOT NULL,
    pd_price_undet_warn smallint NOT NULL,
    pd_tole smallint NOT NULL,
    mk_procur_auth character varying(1) NOT NULL,
    cd_kind_parts character varying(4) NOT NULL,
    cd_ctry_orig character varying(2) NOT NULL,
    mk_import_item character varying(1) NOT NULL,
    cd_trade_terms character varying(3) NOT NULL,
    cd_item_oper character varying(2) NOT NULL,
    cf_item_type character varying(1) NOT NULL,
    no_vend_mdl character varying(30) NOT NULL,
    cr_strat_lot_def smallint NOT NULL,
    ar_dirct_atch character varying(30) NOT NULL,
    cd_piece character varying(3) NOT NULL,
    mk_tax_free character varying(1) NOT NULL,
    mk_duty_custom character varying(1) NOT NULL,
    mk_req_certif_origi character varying(1) NOT NULL,
    cd_end_prdc_class character varying(1) NOT NULL,
    dt_end_prdc_dirct_rcpt character varying(8) NOT NULL,
    cd_cosmos_maker character varying(9) NOT NULL,
    cd_maker character varying(9) NOT NULL,
    cd_arriv_port_def character varying(5) NOT NULL,
    cd_leav_port_def character varying(5) NOT NULL,
    cf_transp_meth_def character varying(2) NOT NULL,
    cd_contain_load_def character varying(1) NOT NULL,
    nm_trade_terms_po_def character varying(20) NOT NULL,
    cd_inl_deliv_place_def character varying(4) NOT NULL,
    mk_resv_bal_ord character varying(1) NOT NULL,
    cd_procur_sort character varying(3) NOT NULL,
    cd_vmi_manage character varying(4) NOT NULL,
    mk_discon character varying(1) NOT NULL,
    cd_hs character varying(12) NOT NULL,
    dt_entry timestamp(0) without time zone NOT NULL,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone NOT NULL,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGJT002'
);


ALTER FOREIGN TABLE dosystem.wbgjt002 OWNER TO dosystem;

--
-- Name: v_do_delevery_day_by_partno; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_delevery_day_by_partno AS
 SELECT DISTINCT f.factory_cd,
    a.no_parts,
    a.no_adj_dim,
    a.cd_block,
    a.rk_prio_divi,
    a.pt_ratio,
    upper((b.nm_key_table)::text) AS day_of_week,
        CASE
            WHEN ((d.flg_in_house)::text = 'Y'::text) THEN
            CASE
                WHEN (c.pd_delv_qty_round IS NULL) THEN 'D'::character varying
                ELSE c.pd_delv_qty_round
            END
            ELSE c.pd_delv_qty_round
        END AS combine_day,
    d.flg_in_house,
    e.block_cd AS use_block_cd,
    a.dt_e_valid,
    f.class,
    d.cd_sply_fact
   FROM (((((dosystem.wbght005 a
     LEFT JOIN dosystem.v_do_delevery_day_of_week b ON ((((a.no_parts)::text = (b.no_parts)::text) AND ((a.no_adj_dim)::text = (b.no_adj_dim)::text))))
     LEFT JOIN ( SELECT DISTINCT wbgjt002.cd_sply,
            wbgjt002.no_parts,
            wbgjt002.no_adj_dim,
            wbgjt002.pd_delv_qty_round,
            wbgjt002.cd_sply_fact
           FROM dosystem.wbgjt002
          WHERE ((((((wbgjt002.cd_sply)::text || (wbgjt002.no_parts)::text) || (wbgjt002.no_adj_dim)::text) || to_char(wbgjt002.dt_entry, 'YYYYMMDDHH24MISS'::text)) || (wbgjt002.cd_sply_fact)::text) IN ( SELECT (((((wbgjt002_1.cd_sply)::text || (wbgjt002_1.no_parts)::text) || (wbgjt002_1.no_adj_dim)::text) || max(to_char(wbgjt002_1.dt_entry, 'YYYYMMDDHH24MISS'::text))) || (wbgjt002_1.cd_sply_fact)::text)
                   FROM dosystem.wbgjt002 wbgjt002_1
                  GROUP BY wbgjt002_1.cd_sply, wbgjt002_1.no_parts, wbgjt002_1.no_adj_dim, wbgjt002_1.cd_sply_fact))) c ON ((((a.cd_block)::text = (c.cd_sply)::text) AND ((a.no_parts)::text = (c.no_parts)::text) AND ((a.no_adj_dim)::text = (c.no_adj_dim)::text))))
     LEFT JOIN dosystem.t_prd_do_delivery_master d ON ((((a.cd_block)::text = (d.supplier_cd)::text) AND ((d.cd_sply_fact)::text = (c.cd_sply_fact)::text))))
     LEFT JOIN dosystem.t_prd_do_part_master e ON ((((a.cd_block)::text = (e.supplier_cd)::text) AND ((a.no_parts)::text = (e.part_no)::text) AND ((a.no_adj_dim)::text = (e.dim)::text) AND ((d.factory_cd)::text = (e.factory_cd)::text))))
     LEFT JOIN dosystem.t_prd_do_part_and_structure f ON ((((a.no_parts)::text = (f.part_no)::text) AND ((a.no_adj_dim)::text = (f.dim)::text) AND ((e.block_cd)::text = (f.block_cd)::text) AND ((a.cd_block)::text = (f.supplier_cd)::text) AND ((e.factory_cd)::text = (f.factory_cd)::text))))
  WHERE ((a.pt_ratio <> '0'::numeric) AND ((a.dt_e_valid)::text > to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)) AND (d.supplier_cd IS NOT NULL) AND (e.block_cd IS NOT NULL))
  ORDER BY a.no_parts, a.no_adj_dim, a.rk_prio_divi;


ALTER VIEW dosystem.v_do_delevery_day_by_partno OWNER TO dosystem;

--
-- Name: v_do_not_working_time; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_not_working_time AS
 SELECT a.dt_work,
    b.plan_time,
        CASE b.plan_time
            WHEN '0100'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0200'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0300'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0400'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            ELSE a.dt_work
        END AS dt_plan
   FROM (( SELECT 'A'::text AS id_join,
            a_1.cd_foothold,
            a_1.dt_work,
            a_1.mk_work,
            a_1.cf_day,
            a_1.dt_month_work,
            a_1.dt_week_work,
            a_1.cd_data_cntl,
            a_1.dt_entry,
            a_1.nm_entry_person,
            a_1.dt_renew,
            a_1.nm_renew_person,
            a_1.cd_trans
           FROM dosystem.wbgzt051 a_1) a
     JOIN ( SELECT 'A'::text AS id_join,
            b_1.no_id,
            b_1.plan_time
           FROM dosystem.t_do_plan_working_time_master b_1) b ON ((a.id_join = b.id_join)))
  WHERE (((a.dt_work)::text >= to_char((CURRENT_DATE - '14 days'::interval), 'YYYYMMDD'::text)) AND ((a.dt_work)::text <= to_char((CURRENT_DATE + '15 days'::interval), 'YYYYMMDD'::text)))
  ORDER BY
        CASE b.plan_time
            WHEN '0100'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0200'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0300'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0400'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            ELSE a.dt_work
        END DESC, b.plan_time DESC;


ALTER VIEW dosystem.v_do_not_working_time OWNER TO dosystem;

--
-- Name: wbght443; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbght443 (
    cd_fact character varying(2) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    cd_block character varying(6) NOT NULL,
    cd_model_grp character varying(4) NOT NULL,
    nm_model character varying(40) NOT NULL,
    no_chld_parts character varying(12) NOT NULL,
    no_chld_adj_dim character varying(3) NOT NULL,
    no_chld_invent_ctl_poi character varying(4) NOT NULL,
    cd_chld_block character varying(6) NOT NULL,
    nm_parts_local character varying(60) NOT NULL,
    cf_child_base character varying(3) NOT NULL,
    qt_consumption_chained numeric(20,11) NOT NULL,
    mk_consump_divi character varying(1) NOT NULL,
    qt_consump_divi_substit_chain numeric(20,11) NOT NULL,
    mk_substit character varying(1) NOT NULL,
    cf_supply_class character varying(1) NOT NULL,
    cf_odr_class character varying(1) NOT NULL,
    mk_para_produc character varying(1) NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGHT443'
);


ALTER FOREIGN TABLE dosystem.wbght443 OWNER TO dosystem;

--
-- Name: v_do_part_structure; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_part_structure AS
 SELECT a.no_parts AS merchandise_cd,
    a.no_adj_dim AS merchandise_dim,
    a.no_invent_cntl_poi AS merchandise_cntl_poi,
    a.cd_block AS merchandise_block,
    a.no_chld_parts AS part_no,
    a.no_chld_adj_dim AS dim,
        CASE
            WHEN (b.cd_block IS NULL) THEN a.cd_block
            ELSE b.cd_block
        END AS use_block,
    a.no_chld_invent_ctl_poi AS part_no_cntl_poi,
    a.cd_chld_block AS suppiler,
    a.qt_consump_divi_substit_chain AS used,
    a.cf_supply_class,
    a.cf_odr_class
   FROM (( SELECT a_1.no_parts,
            a_1.no_adj_dim,
            a_1.no_invent_cntl_poi,
            a_1.cd_block,
            a_1.no_chld_parts,
            a_1.no_chld_adj_dim,
            a_1.no_chld_invent_ctl_poi,
            a_1.cd_chld_block,
            a_1.qt_consumption_chained,
            max(a_1.qt_consump_divi_substit_chain) AS qt_consump_divi_substit_chain,
            a_1.cf_supply_class,
            a_1.cf_odr_class
           FROM dosystem.wbght443 a_1
          WHERE ((length((a_1.no_chld_parts)::text) <> 10) AND (a_1.qt_consump_divi_substit_chain <> (0)::numeric) AND ((a_1.cf_supply_class)::text = 'M'::text) AND ((a_1.cf_odr_class)::text = ANY ((ARRAY['C'::character varying, 'T'::character varying])::text[])))
          GROUP BY a_1.no_parts, a_1.no_adj_dim, a_1.no_invent_cntl_poi, a_1.cd_block, a_1.no_chld_parts, a_1.no_chld_adj_dim, a_1.no_chld_invent_ctl_poi, a_1.cd_chld_block, a_1.qt_consumption_chained, a_1.cf_supply_class, a_1.cf_odr_class) a
     LEFT JOIN dosystem.t_prd_h401_euc b ON ((((a.no_chld_parts)::text = (b.no_chld_parts)::text) AND ((a.no_chld_adj_dim)::text = (b.no_chld_adj_dim)::text) AND ((a.no_chld_invent_ctl_poi)::text = (b.no_chld_invent_ctl_poi)::text) AND ((a.cd_block)::text = (b.cd_in_block)::text) AND ((a.no_parts)::text = (b.no_in_parts)::text))));


ALTER VIEW dosystem.v_do_part_structure OWNER TO dosystem;

--
-- Name: v_do_part_target; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_part_target AS
 SELECT DISTINCT a.factory_cd,
    a.part_no,
    a.dim,
    a.block_cd,
    a.supplier_cd,
    a.total_process_lt,
    a.logic,
    a.sp_plan_slide,
    c.rk_prio_divi,
    c.pt_ratio,
    c.dt_b_valid,
    c.dt_e_valid
   FROM ((dosystem.t_prd_do_part_master a
     JOIN dosystem.t_prd_do_delivery_master b ON ((((a.factory_cd)::text = (b.factory_cd)::text) AND ((a.supplier_cd)::text = (b.supplier_cd)::text))))
     JOIN dosystem.wbght005 c ON ((((a.part_no)::text = (c.no_parts)::text) AND ((a.dim)::text = (c.no_adj_dim)::text) AND ((a.supplier_cd)::text = (c.cd_block)::text))))
  WHERE ((c.pt_ratio > (0)::numeric) AND ((c.dt_e_valid)::text > to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)));


ALTER VIEW dosystem.v_do_part_target OWNER TO dosystem;

--
-- Name: v_do_plan_a3_planbyshift; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_plan_a3_planbyshift AS
 SELECT plan.factory_cd,
    plan.model_seq,
    plan.plan_date,
    plan.shift,
    plan.line_cd,
    plan.merchandise_cd,
    plan.plan_qty,
    plan.priority,
    plan.priority_for_minus
   FROM ( SELECT unnamed_subquery.factory_cd,
            unnamed_subquery.model_seq,
            unnamed_subquery.plan_date,
            unnamed_subquery.shift,
            unnamed_subquery.line_cd,
            unnamed_subquery.merchandise_cd,
            unnamed_subquery.plan_qty,
            unnamed_subquery.priority,
            unnamed_subquery.priority_for_minus
           FROM ( SELECT a.factory_cd,
                    a.model_seq,
                    a.plan_date,
                    a.shift,
                    a.line_cd,
                    a.merchandise_cd,
                    a.plan_qty,
                    b.priority,
                    b.priority_for_minus
                   FROM (( SELECT t_prd_plan_a3_assy_plan.factory_cd,
                            t_prd_plan_a3_assy_plan.model_seq,
                            t_prd_plan_a3_assy_plan.plan_date,
                            t_prd_plan_a3_assy_plan.shift,
                            t_prd_plan_a3_assy_plan.line_cd,
                            t_prd_plan_a3_assy_plan.merchandise_cd,
                            t_prd_plan_a3_assy_plan.priority,
                            sum(t_prd_plan_a3_assy_plan.plan_qty) AS plan_qty
                           FROM dosystem.t_prd_plan_a3_assy_plan
                          WHERE ((t_prd_plan_a3_assy_plan.priority)::text <> ALL ((ARRAY['++'::character varying, '**'::character varying])::text[]))
                          GROUP BY t_prd_plan_a3_assy_plan.factory_cd, t_prd_plan_a3_assy_plan.model_seq, t_prd_plan_a3_assy_plan.plan_date, t_prd_plan_a3_assy_plan.shift, t_prd_plan_a3_assy_plan.line_cd, t_prd_plan_a3_assy_plan.merchandise_cd, t_prd_plan_a3_assy_plan.priority) a
                     LEFT JOIN dosystem.t_prd_plan_a3_assy_plan b ON ((((a.factory_cd)::text = (b.factory_cd)::text) AND ((a.model_seq)::text = (b.model_seq)::text) AND ((a.plan_date)::text = (b.plan_date)::text) AND ((a.shift)::text = (b.shift)::text) AND ((a.line_cd)::text = (b.line_cd)::text) AND ((a.merchandise_cd)::text = (b.merchandise_cd)::text) AND ((a.priority)::text = (b.priority)::text))))
                  WHERE (((a.priority)::text <> ALL ((ARRAY['++'::character varying, '**'::character varying])::text[])) AND (a.plan_qty <> 0))
                UNION
                 SELECT t_prd_plan_a3_assy_plan.factory_cd,
                    t_prd_plan_a3_assy_plan.model_seq,
                    t_prd_plan_a3_assy_plan.plan_date,
                    t_prd_plan_a3_assy_plan.shift,
                    t_prd_plan_a3_assy_plan.line_cd,
                    t_prd_plan_a3_assy_plan.merchandise_cd,
                    t_prd_plan_a3_assy_plan.plan_qty,
                    t_prd_plan_a3_assy_plan.priority,
                    t_prd_plan_a3_assy_plan.priority_for_minus
                   FROM dosystem.t_prd_plan_a3_assy_plan
                  WHERE ((t_prd_plan_a3_assy_plan.priority)::text = '**'::text)) unnamed_subquery) plan
UNION
 SELECT a.factory_cd,
    a.model_seq,
    a.plan_date,
    a.shift,
    a.line_cd,
    a.merchandise_cd,
    a.plan_qty,
    a.priority,
    a.priority_for_minus
   FROM (dosystem.t_prd_plan_a3_assy_plan a
     JOIN ( SELECT t_prd_plan_a3_assy_plan.factory_cd,
            t_prd_plan_a3_assy_plan.plan_date,
            t_prd_plan_a3_assy_plan.shift,
            t_prd_plan_a3_assy_plan.line_cd,
            t_prd_plan_a3_assy_plan.merchandise_cd,
            count(*) AS cnt
           FROM dosystem.t_prd_plan_a3_assy_plan
          WHERE ((t_prd_plan_a3_assy_plan.priority)::text <> '**'::text)
          GROUP BY t_prd_plan_a3_assy_plan.factory_cd, t_prd_plan_a3_assy_plan.plan_date, t_prd_plan_a3_assy_plan.shift, t_prd_plan_a3_assy_plan.line_cd, t_prd_plan_a3_assy_plan.merchandise_cd) b ON ((((a.factory_cd)::text = (b.factory_cd)::text) AND ((a.plan_date)::text = (b.plan_date)::text) AND ((a.shift)::text = (b.shift)::text) AND ((a.line_cd)::text = (b.line_cd)::text) AND ((a.merchandise_cd)::text = (b.merchandise_cd)::text) AND (b.cnt > 1) AND ((a.priority)::text <> '**'::text) AND (a.priority_for_minus IS NOT NULL))))
  ORDER BY 8, 9;


ALTER VIEW dosystem.v_do_plan_a3_planbyshift OWNER TO dosystem;

--
-- Name: wbgbt302; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbgbt302 (
    cd_fact character varying(2) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    no_line character varying(2) NOT NULL,
    cf_argmet_form character varying(1) NOT NULL,
    no_manufact character varying(18) NOT NULL,
    cd_use_block character varying(6) NOT NULL,
    mk_mesh_pln character varying(1) NOT NULL,
    rk_necess_prio character varying(1) NOT NULL,
    dt_necess_expec character varying(8) NOT NULL,
    tm_necess_expec character varying(6) NOT NULL,
    qt_necess_expec numeric(12,3) NOT NULL,
    qt_no_ship_dem numeric(12,3) NOT NULL,
    cf_dem_cre character varying(1) NOT NULL,
    cf_dem_stat character varying(1) NOT NULL,
    cf_separ_arrang character varying(1) NOT NULL,
    no_parts_upper_fact character varying(2) NOT NULL,
    no_parts_upper_item character varying(12) NOT NULL,
    no_parts_upper_dim character varying(3) NOT NULL,
    no_parts_upper_ctrl character varying(4) NOT NULL,
    no_parts_upper_line character varying(2) NOT NULL,
    no_construct character varying(19) NOT NULL,
    no_inside_ord character varying(30) NOT NULL,
    dt_delibery_upper_ord character varying(8) NOT NULL,
    qt_argmet_upper_ord numeric(12,3) NOT NULL,
    rk_accept_odr character varying(1) NOT NULL,
    cf_supply character varying(1) NOT NULL,
    dt_designate character varying(8) NOT NULL,
    cf_pegging character varying(1) NOT NULL,
    cf_io_upper character varying(1) NOT NULL,
    cd_odr_person_u character varying(10) NOT NULL,
    dt_end_valid character varying(8) NOT NULL,
    mk_short_necess_expec character varying(1) NOT NULL,
    mk_max_smry_ovr_flg character varying(1) NOT NULL,
    dt_necess_expec_old character varying(8) NOT NULL,
    qt_necess_expec_old numeric(12,3) NOT NULL,
    qt_ship_uncomplete_old numeric(12,3) NOT NULL,
    pd_ord_cancel smallint NOT NULL,
    mk_accel_ala character varying(1) NOT NULL,
    mk_late_alarm character varying(1) NOT NULL,
    mk_ala_cancel character varying(1) NOT NULL,
    cf_ext_dem character varying(1) NOT NULL,
    ar_inher_itma_arrang_u character varying(1) NOT NULL,
    no_draw character varying(6) NOT NULL,
    no_chg_hist character varying(9) NOT NULL,
    no_chg_hist_sfx character varying(4) NOT NULL,
    cd_process character varying(2) NOT NULL,
    cd_tape character varying(3) NOT NULL,
    ar_inher_itmd_const character varying(1) NOT NULL,
    cd_cust character varying(10) NOT NULL,
    no_po_no character varying(20) NOT NULL,
    cf_ord character varying(10) NOT NULL,
    cd_delv_place character varying(4) NOT NULL,
    tm_delv character varying(6) NOT NULL,
    cf_tape character varying(1) NOT NULL,
    cd_packag_spec character varying(10) NOT NULL,
    qt_box_containing integer NOT NULL,
    no_seq character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGBT302'
);


ALTER FOREIGN TABLE dosystem.wbgbt302 OWNER TO dosystem;

--
-- Name: v_do_plan_a_and_z; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_plan_a_and_z AS
 SELECT b.factory_cd,
    a.no_parts,
    a.no_adj_dim,
        CASE
            WHEN ((b.class)::text = 'M/T'::text) THEN '8888'::character varying
            ELSE a.cd_use_block
        END AS cd_use_block,
    b.class,
    a.dt_necess_expec AS plan_date,
    '0800'::text AS plan_time,
    a.qt_necess_expec AS plan_qty,
    b.total_process_lt,
    b.logic
   FROM dosystem.wbgbt302 a,
    ( SELECT DISTINCT t_prd_do_part_and_structure.factory_cd,
            t_prd_do_part_and_structure.part_no,
            t_prd_do_part_and_structure.dim,
            t_prd_do_part_and_structure.block_cd,
            t_prd_do_part_and_structure.supplier_cd,
            t_prd_do_part_and_structure.rk_prio_divi,
            t_prd_do_part_and_structure.pt_ratio,
            t_prd_do_part_and_structure.class,
            t_prd_do_part_and_structure.total_process_lt,
            t_prd_do_part_and_structure.logic
           FROM dosystem.t_prd_do_part_and_structure
          WHERE ((t_prd_do_part_and_structure.rk_prio_divi = 1) AND (t_prd_do_part_and_structure.pt_ratio > (0)::numeric))) b
  WHERE (((a.no_parts)::text = (b.part_no)::text) AND ((a.no_adj_dim)::text = (b.dim)::text) AND (((a.cd_use_block)::text = (
        CASE
            WHEN ((b.class)::text = 'M/T'::text) THEN '      '::character varying
            ELSE b.block_cd
        END)::text) OR ((a.cd_use_block)::text = (b.block_cd)::text)) AND ((a.cf_ext_dem)::text = ANY ((ARRAY['Z'::character varying, 'A'::character varying])::text[])));


ALTER VIEW dosystem.v_do_plan_a_and_z OWNER TO dosystem;

--
-- Name: v_do_plan_main_and_body; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_plan_main_and_body AS
 SELECT b.factory_cd,
    a.no_parts,
    a.no_adj_dim,
        CASE
            WHEN ((b.class)::text = 'M/T'::text) THEN '8888'::character varying
            ELSE a.cd_use_block
        END AS cd_use_block,
    b.class,
    a.dt_necess_expec AS plan_date,
    '0800'::text AS plan_time,
    a.qt_necess_expec AS plan_qty,
    b.total_process_lt,
    b.logic
   FROM (( SELECT a_1.cd_fact,
            a_1.no_parts,
            a_1.no_adj_dim,
            a_1.no_invent_cntl_poi,
            a_1.no_line,
            a_1.cf_argmet_form,
            a_1.no_manufact,
            a_1.cd_use_block,
            a_1.mk_mesh_pln,
            a_1.rk_necess_prio,
            a_1.dt_necess_expec,
            a_1.tm_necess_expec,
            a_1.qt_necess_expec,
            a_1.qt_no_ship_dem,
            a_1.cf_dem_cre,
            a_1.cf_dem_stat,
            a_1.cf_separ_arrang,
            a_1.no_parts_upper_fact,
            a_1.no_parts_upper_item,
            a_1.no_parts_upper_dim,
            a_1.no_parts_upper_ctrl,
            a_1.no_parts_upper_line,
            a_1.no_construct,
            a_1.no_inside_ord,
            a_1.dt_delibery_upper_ord,
            a_1.qt_argmet_upper_ord,
            a_1.rk_accept_odr,
            a_1.cf_supply,
            a_1.dt_designate,
            a_1.cf_pegging,
            a_1.cf_io_upper,
            a_1.cd_odr_person_u,
            a_1.dt_end_valid,
            a_1.mk_short_necess_expec,
            a_1.mk_max_smry_ovr_flg,
            a_1.dt_necess_expec_old,
            a_1.qt_necess_expec_old,
            a_1.qt_ship_uncomplete_old,
            a_1.pd_ord_cancel,
            a_1.mk_accel_ala,
            a_1.mk_late_alarm,
            a_1.mk_ala_cancel,
            a_1.cf_ext_dem,
            a_1.ar_inher_itma_arrang_u,
            a_1.no_draw,
            a_1.no_chg_hist,
            a_1.no_chg_hist_sfx,
            a_1.cd_process,
            a_1.cd_tape,
            a_1.ar_inher_itmd_const,
            a_1.cd_cust,
            a_1.no_po_no,
            a_1.cf_ord,
            a_1.cd_delv_place,
            a_1.tm_delv,
            a_1.cf_tape,
            a_1.cd_packag_spec,
            a_1.qt_box_containing,
            a_1.no_seq
           FROM dosystem.wbgbt302 a_1
          WHERE (((a_1.dt_necess_expec)::text <= (( SELECT sub.dt_work
                   FROM ( SELECT row_number() OVER () AS cnt,
                            wbgzt051.dt_work
                           FROM dosystem.wbgzt051
                          WHERE (((wbgzt051.dt_work)::text > to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)) AND ((wbgzt051.mk_work)::text = 'Y'::text))) sub
                  WHERE (sub.cnt = 7)))::text) AND ((a_1.no_parts_upper_item)::text <> '            '::text) AND (length((a_1.no_parts_upper_item)::text) = 12))) a
     JOIN ( SELECT DISTINCT t_prd_do_part_and_structure.factory_cd,
            t_prd_do_part_and_structure.part_no,
            t_prd_do_part_and_structure.dim,
            t_prd_do_part_and_structure.block_cd,
            t_prd_do_part_and_structure.supplier_cd,
            t_prd_do_part_and_structure.rk_prio_divi,
            t_prd_do_part_and_structure.pt_ratio,
            t_prd_do_part_and_structure.class,
            t_prd_do_part_and_structure.total_process_lt,
            t_prd_do_part_and_structure.logic
           FROM dosystem.t_prd_do_part_and_structure
          WHERE ((t_prd_do_part_and_structure.rk_prio_divi = 1) AND (t_prd_do_part_and_structure.pt_ratio > (0)::numeric))) b ON ((((a.no_parts)::text = (b.part_no)::text) AND ((a.no_adj_dim)::text = (b.dim)::text) AND (((a.cd_use_block)::text = (
        CASE
            WHEN ((b.class)::text = 'M/T'::text) THEN '      '::character varying
            ELSE b.block_cd
        END)::text) OR ((a.cd_use_block)::text = (b.block_cd)::text)))));


ALTER VIEW dosystem.v_do_plan_main_and_body OWNER TO dosystem;

--
-- Name: v_do_plan_part_for_fc; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_plan_part_for_fc AS
 SELECT a.factory_cd,
    a.part_no,
    a.dim,
        CASE
            WHEN ((a.class)::text = 'M/T'::text) THEN '8888'::character varying
            ELSE a.block_cd
        END AS use_block,
    a.merchandise_cd,
    b.shift,
    b.line_cd,
    a.used,
    a.class,
    b.plan_date,
    (a.used * (b.plan_qty)::numeric) AS plan_qty,
    COALESCE(a.logic, '1'::smallint) AS logic
   FROM (( SELECT DISTINCT t_prd_do_part_and_structure.factory_cd,
            t_prd_do_part_and_structure.part_no,
            t_prd_do_part_and_structure.dim,
            t_prd_do_part_and_structure.block_cd,
            t_prd_do_part_and_structure.merchandise_cd,
            t_prd_do_part_and_structure.used,
            t_prd_do_part_and_structure.class,
            t_prd_do_part_and_structure.logic
           FROM dosystem.t_prd_do_part_and_structure) a
     JOIN ( SELECT t_prd_plan_a3_assy_plan.factory_cd,
            t_prd_plan_a3_assy_plan.merchandise_cd,
            t_prd_plan_a3_assy_plan.plan_qty,
            t_prd_plan_a3_assy_plan.plan_date,
            t_prd_plan_a3_assy_plan.shift,
            t_prd_plan_a3_assy_plan.line_cd
           FROM dosystem.t_prd_plan_a3_assy_plan
          WHERE ((t_prd_plan_a3_assy_plan.plan_date)::text >= to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text))) b ON ((((a.merchandise_cd)::text = (b.merchandise_cd)::text) AND ((a.factory_cd)::text = (b.factory_cd)::text))));


ALTER VIEW dosystem.v_do_plan_part_for_fc OWNER TO dosystem;

--
-- Name: v_do_plan_part_today; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_plan_part_today AS
 SELECT factory_cd,
    part_no,
    dim,
    use_block,
    class,
    sum((used * (total_plan)::numeric)) AS total_plan
   FROM ( SELECT a.factory_cd,
            a.part_no,
            a.dim,
                CASE
                    WHEN ((a.class)::text = 'M/T'::text) THEN '8888'::character varying
                    ELSE a.block_cd
                END AS use_block,
            a.merchandise_cd,
            a.used,
            a.class,
            b.total_plan
           FROM (( SELECT DISTINCT t_prd_do_part_and_structure.factory_cd,
                    t_prd_do_part_and_structure.part_no,
                    t_prd_do_part_and_structure.dim,
                    t_prd_do_part_and_structure.block_cd,
                    t_prd_do_part_and_structure.merchandise_cd,
                    t_prd_do_part_and_structure.used,
                    t_prd_do_part_and_structure.class
                   FROM dosystem.t_prd_do_part_and_structure) a
             JOIN ( SELECT t_prd_plan_a3_assy_plan.factory_cd,
                    t_prd_plan_a3_assy_plan.merchandise_cd,
                    sum(t_prd_plan_a3_assy_plan.plan_qty) AS total_plan
                   FROM dosystem.t_prd_plan_a3_assy_plan
                  WHERE (((t_prd_plan_a3_assy_plan.plan_date)::text >= to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)) AND ((t_prd_plan_a3_assy_plan.plan_date)::text < ( SELECT min((wbgzt051.dt_work)::text) AS min
                           FROM dosystem.wbgzt051
                          WHERE (((wbgzt051.dt_work)::text > to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text)) AND ((wbgzt051.mk_work)::text = 'Y'::text)))))
                  GROUP BY t_prd_plan_a3_assy_plan.factory_cd, t_prd_plan_a3_assy_plan.merchandise_cd) b ON ((((a.merchandise_cd)::text = (b.merchandise_cd)::text) AND ((a.factory_cd)::text = (b.factory_cd)::text))))) unnamed_subquery
  GROUP BY factory_cd, part_no, dim, use_block, class;


ALTER VIEW dosystem.v_do_plan_part_today OWNER TO dosystem;

--
-- Name: v_do_target_plan_planbyshift; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_target_plan_planbyshift AS
 SELECT b.factory_cd,
    b.part_no,
    b.dim,
    b.block_cd,
    b.supplier_cd,
    b.total_process_lt,
    b.rk_prio_divi,
    b.pt_ratio,
    b.dt_b_valid,
    b.dt_e_valid,
    b.merchandise_cd,
    b.merchandise_dim,
    b.merchandise_block,
    b.used,
    b.class,
    b.update_date,
    a.plan_date,
    a.shift,
    a.line_cd,
    a.cell_name,
    a.priority,
    ((a.plan_qty)::numeric * b.used) AS plan_qty
   FROM (( SELECT DISTINCT t_prd_plan_a3_planbyshift.factory_cd,
            t_prd_plan_a3_planbyshift.plan_date,
            t_prd_plan_a3_planbyshift.shift,
            t_prd_plan_a3_planbyshift.line_cd,
            t_prd_plan_a3_planbyshift.cell_name,
            t_prd_plan_a3_planbyshift.priority,
            t_prd_plan_a3_planbyshift.merchandise_cd,
            t_prd_plan_a3_planbyshift.plan_qty
           FROM dosystem.t_prd_plan_a3_planbyshift
          WHERE ((t_prd_plan_a3_planbyshift.plan_date)::text > to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text))) a
     JOIN dosystem.t_prd_do_part_and_structure b ON ((((a.factory_cd)::text = (b.factory_cd)::text) AND ((a.merchandise_cd)::text = (b.merchandise_cd)::text))))
  ORDER BY b.factory_cd, a.plan_date, a.shift, a.line_cd, a.cell_name, a.priority;


ALTER VIEW dosystem.v_do_target_plan_planbyshift OWNER TO dosystem;

--
-- Name: v_do_working_day; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_working_day AS
 SELECT dt_work,
    mk_work,
    to_char((to_date(((dt_work)::text || '0000'::text), 'YYYYMMDDHH24MI'::text))::timestamp with time zone, 'DY'::text) AS date_start,
    ((dt_work)::text || '0800'::text) AS start_time,
    to_char((to_date((to_char(((to_date((dt_work)::text, 'YYYYMMDD'::text) + 1))::timestamp with time zone, 'YYYYMMDD'::text) || '0000'::text), 'YYYYMMDDHH24MI'::text))::timestamp with time zone, 'DY'::text) AS date_end,
    (to_char(((to_date((dt_work)::text, 'YYYYMMDD'::text) + 1))::timestamp with time zone, 'YYYYMMDD'::text) || '0700'::text) AS end_time
   FROM dosystem.wbgzt051
  WHERE (((dt_work)::text >= to_char(((CURRENT_DATE - 5))::timestamp with time zone, 'YYYYMMDD'::text)) AND ((dt_work)::text <= to_char(((CURRENT_DATE + 30))::timestamp with time zone, 'YYYYMMDD'::text)));


ALTER VIEW dosystem.v_do_working_day OWNER TO dosystem;

--
-- Name: v_do_working_time; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_do_working_time AS
 SELECT a.dt_work,
    b.plan_time,
        CASE b.plan_time
            WHEN '0100'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0200'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0300'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0400'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            ELSE a.dt_work
        END AS dt_plan
   FROM (( SELECT 'A'::text AS id_join,
            a_1.cd_foothold,
            a_1.dt_work,
            a_1.mk_work,
            a_1.cf_day,
            a_1.dt_month_work,
            a_1.dt_week_work,
            a_1.cd_data_cntl,
            a_1.dt_entry,
            a_1.nm_entry_person,
            a_1.dt_renew,
            a_1.nm_renew_person,
            a_1.cd_trans
           FROM dosystem.wbgzt051 a_1) a
     JOIN ( SELECT 'A'::text AS id_join,
            b_1.no_id,
            b_1.plan_time
           FROM dosystem.t_do_plan_working_time_master b_1) b ON ((a.id_join = b.id_join)))
  WHERE (((a.mk_work)::text = 'Y'::text) AND (((a.dt_work)::text >= to_char((CURRENT_DATE - '14 days'::interval), 'YYYYMMDD'::text)) AND ((a.dt_work)::text <= to_char((CURRENT_DATE + '15 days'::interval), 'YYYYMMDD'::text))))
  ORDER BY
        CASE b.plan_time
            WHEN '0100'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0200'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0300'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            WHEN '0400'::text THEN (to_char((to_date((a.dt_work)::text, 'YYYYMMDD'::text) + '1 day'::interval), 'YYYYMMDD'::text))::character varying
            ELSE a.dt_work
        END DESC, b.plan_time DESC;


ALTER VIEW dosystem.v_do_working_time OWNER TO dosystem;

--
-- Name: v_prd_do_delivery_master; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_prd_do_delivery_master AS
 SELECT factory_cd,
    supplier_cd,
    round,
    time_eta,
    effect_sta_date,
    cd_sply_fact
   FROM ( SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '001'::text AS round,
            t_prd_do_delivery_master.time_eta_1 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '002'::text AS round,
            t_prd_do_delivery_master.time_eta_2 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '003'::text AS round,
            t_prd_do_delivery_master.time_eta_3 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '004'::text AS round,
            t_prd_do_delivery_master.time_eta_4 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '005'::text AS round,
            t_prd_do_delivery_master.time_eta_5 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '006'::text AS round,
            t_prd_do_delivery_master.time_eta_6 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '007'::text AS round,
            t_prd_do_delivery_master.time_eta_7 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '008'::text AS round,
            t_prd_do_delivery_master.time_eta_8 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '009'::text AS round,
            t_prd_do_delivery_master.time_eta_9 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '010'::text AS round,
            t_prd_do_delivery_master.time_eta_10 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '011'::text AS round,
            t_prd_do_delivery_master.time_eta_11 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '012'::text AS round,
            t_prd_do_delivery_master.time_eta_12 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '013'::text AS round,
            t_prd_do_delivery_master.time_eta_13 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '014'::text AS round,
            t_prd_do_delivery_master.time_eta_14 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '015'::text AS round,
            t_prd_do_delivery_master.time_eta_15 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '016'::text AS round,
            t_prd_do_delivery_master.time_eta_16 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '017'::text AS round,
            t_prd_do_delivery_master.time_eta_17 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '018'::text AS round,
            t_prd_do_delivery_master.time_eta_18 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '019'::text AS round,
            t_prd_do_delivery_master.time_eta_19 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '020'::text AS round,
            t_prd_do_delivery_master.time_eta_20 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '021'::text AS round,
            t_prd_do_delivery_master.time_eta_21 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '022'::text AS round,
            t_prd_do_delivery_master.time_eta_22 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '023'::text AS round,
            t_prd_do_delivery_master.time_eta_23 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '024'::text AS round,
            t_prd_do_delivery_master.time_eta_24 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master) sub
  WHERE ((((((factory_cd)::text || (supplier_cd)::text) || (effect_sta_date)::text) || (cd_sply_fact)::text) IN ( SELECT ((((t_prd_do_delivery_master.factory_cd)::text || (t_prd_do_delivery_master.supplier_cd)::text) || max((t_prd_do_delivery_master.effect_sta_date)::text)) || (t_prd_do_delivery_master.cd_sply_fact)::text)
           FROM dosystem.t_prd_do_delivery_master
          WHERE ((t_prd_do_delivery_master.effect_sta_date)::text <= to_char((CURRENT_DATE)::timestamp with time zone, 'YYYYMMDD'::text))
          GROUP BY t_prd_do_delivery_master.factory_cd, t_prd_do_delivery_master.supplier_cd, t_prd_do_delivery_master.cd_sply_fact)) AND (time_eta IS NOT NULL))
  ORDER BY factory_cd, supplier_cd, round;


ALTER VIEW dosystem.v_prd_do_delivery_master OWNER TO dosystem;

--
-- Name: v_prd_do_delivery_master_chk; Type: VIEW; Schema: dosystem; Owner: dosystem
--

CREATE VIEW dosystem.v_prd_do_delivery_master_chk AS
 SELECT factory_cd,
    supplier_cd,
    round,
    time_eta,
    effect_sta_date,
    cd_sply_fact
   FROM ( SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '001'::text AS round,
            t_prd_do_delivery_master.time_eta_1 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '002'::text AS round,
            t_prd_do_delivery_master.time_eta_2 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '003'::text AS round,
            t_prd_do_delivery_master.time_eta_3 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '004'::text AS round,
            t_prd_do_delivery_master.time_eta_4 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '005'::text AS round,
            t_prd_do_delivery_master.time_eta_5 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '006'::text AS round,
            t_prd_do_delivery_master.time_eta_6 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '007'::text AS round,
            t_prd_do_delivery_master.time_eta_7 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '008'::text AS round,
            t_prd_do_delivery_master.time_eta_8 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '009'::text AS round,
            t_prd_do_delivery_master.time_eta_9 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '010'::text AS round,
            t_prd_do_delivery_master.time_eta_10 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '011'::text AS round,
            t_prd_do_delivery_master.time_eta_11 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '012'::text AS round,
            t_prd_do_delivery_master.time_eta_12 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '013'::text AS round,
            t_prd_do_delivery_master.time_eta_13 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '014'::text AS round,
            t_prd_do_delivery_master.time_eta_14 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '015'::text AS round,
            t_prd_do_delivery_master.time_eta_15 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '016'::text AS round,
            t_prd_do_delivery_master.time_eta_16 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '017'::text AS round,
            t_prd_do_delivery_master.time_eta_17 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '018'::text AS round,
            t_prd_do_delivery_master.time_eta_18 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '019'::text AS round,
            t_prd_do_delivery_master.time_eta_19 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '020'::text AS round,
            t_prd_do_delivery_master.time_eta_20 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '021'::text AS round,
            t_prd_do_delivery_master.time_eta_21 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '022'::text AS round,
            t_prd_do_delivery_master.time_eta_22 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '023'::text AS round,
            t_prd_do_delivery_master.time_eta_23 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master
        UNION
         SELECT t_prd_do_delivery_master.factory_cd,
            t_prd_do_delivery_master.supplier_cd,
            '024'::text AS round,
            t_prd_do_delivery_master.time_eta_24 AS time_eta,
            t_prd_do_delivery_master.effect_sta_date,
            t_prd_do_delivery_master.cd_sply_fact
           FROM dosystem.t_prd_do_delivery_master) sub
  WHERE (((effect_sta_date)::text <= to_char((CURRENT_DATE + '10 days'::interval), 'YYYYMMDD'::text)) AND (time_eta IS NOT NULL));


ALTER VIEW dosystem.v_prd_do_delivery_master_chk OWNER TO dosystem;

--
-- Name: wbght009; Type: FOREIGN TABLE; Schema: dosystem; Owner: dosystem
--

CREATE FOREIGN TABLE dosystem.wbght009 (
    cd_fact character varying(2) NOT NULL,
    cd_bs_block character varying(6) NOT NULL,
    cd_block character varying(6) NOT NULL,
    no_parts character varying(12) NOT NULL,
    no_adj_dim character varying(3) NOT NULL,
    no_invent_cntl_poi character varying(4) NOT NULL,
    no_line character varying(2) NOT NULL,
    cd_delv_place character varying(4) NOT NULL,
    mk_cd_delv_place character varying(1) NOT NULL,
    cf_palletize character varying(3) NOT NULL,
    mk_cf_palletize character varying(1) NOT NULL,
    cd_shelf_address character varying(4) NOT NULL,
    mk_cd_shelf_address character varying(1) NOT NULL,
    cd_delv_place_insp character varying(4) NOT NULL,
    mk_cd_delv_place_insp character varying(1) NOT NULL,
    cd_data_cntl character varying(1) NOT NULL,
    dt_entry timestamp(0) without time zone,
    nm_entry_person character varying(10) NOT NULL,
    dt_renew timestamp(0) without time zone,
    nm_renew_person character varying(10) NOT NULL,
    cd_trans character varying(8) NOT NULL
)
SERVER oracle_eucactual
OPTIONS (
    schema 'NPIS',
    "table" 'WBGHT009'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN cd_fact OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN cd_bs_block OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN cd_block OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN no_parts OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN no_adj_dim OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN no_invent_cntl_poi OPTIONS (
    key 'true'
);
ALTER FOREIGN TABLE ONLY dosystem.wbght009 ALTER COLUMN no_line OPTIONS (
    key 'true'
);


ALTER FOREIGN TABLE dosystem.wbght009 OWNER TO dosystem;

--
-- Name: t_prd_do_delivery_master_bk t_prd_do_delivery_master_bk_pkey; Type: CONSTRAINT; Schema: dosystem; Owner: dosystem
--

ALTER TABLE ONLY dosystem.t_prd_do_delivery_master_bk
    ADD CONSTRAINT t_prd_do_delivery_master_bk_pkey PRIMARY KEY (factory_cd, supplier_cd, effect_sta_date);


--
-- Name: t_prd_do_delivery_master t_prd_do_delivery_master_pkey; Type: CONSTRAINT; Schema: dosystem; Owner: dosystem
--

ALTER TABLE ONLY dosystem.t_prd_do_delivery_master
    ADD CONSTRAINT t_prd_do_delivery_master_pkey PRIMARY KEY (cd_sply_fact, factory_cd, supplier_cd, effect_sta_date);


--
-- Name: t_prd_do_part_master t_prd_do_part_master_pkey; Type: CONSTRAINT; Schema: dosystem; Owner: dosystem
--

ALTER TABLE ONLY dosystem.t_prd_do_part_master
    ADD CONSTRAINT t_prd_do_part_master_pkey PRIMARY KEY (factory_cd, part_no, dim, block_cd, supplier_cd, total_process_lt);


--
-- Name: t_do_plan_balance_by_sply_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_by_sply_idx1 ON dosystem.t_do_plan_balance_qty_by_sply USING btree (factory_cd, part_no, dim, class, use_block_cd);


--
-- Name: t_do_plan_balance_by_sply_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_by_sply_idx2 ON dosystem.t_do_plan_balance_qty_by_sply USING btree (factory_cd, part_no, dim, class, use_block_cd, (((plan_date)::text || (plan_time)::text)));


--
-- Name: t_do_plan_balance_by_sply_idx3; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_by_sply_idx3 ON dosystem.t_do_plan_balance_qty_by_sply USING btree (factory_cd, part_no, dim, supplier_cd, plan_date, plan_time, class);


--
-- Name: t_do_plan_balance_by_sply_idx4; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_by_sply_idx4 ON dosystem.t_do_plan_balance_qty_by_sply USING btree ((((plan_date)::text || (plan_time)::text)), ratio, plan_qty_rf_lt, factory_cd, part_no, dim, supplier_cd, use_block_cd, class);


--
-- Name: t_do_plan_balance_qty_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_qty_idx1 ON dosystem.t_do_plan_balance_qty USING btree (ratio, (((plan_date)::text || (plan_time)::text)), plan_qty_balance);


--
-- Name: t_do_plan_balance_qty_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_balance_qty_idx2 ON dosystem.t_do_plan_balance_qty USING btree (ratio, (((plan_date)::text || (plan_time)::text)), plan_qty_balance, factory_cd, part_no, dim, supplier_cd, use_block_cd, class);


--
-- Name: t_do_plan_part_ref_process_lt_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_part_ref_process_lt_idx1 ON dosystem.t_do_plan_part_ref_process_lt USING btree (factory_cd, part_no, dim, (((plan_date)::text || (plan_time)::text)), use_block_cd);


--
-- Name: t_do_plan_part_ref_process_lt_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_part_ref_process_lt_idx2 ON dosystem.t_do_plan_part_ref_process_lt USING btree (factory_cd, part_no, dim, (((plan_date_rf_lt)::text || (plan_time_rf_lt)::text)), use_block_cd, class, plan_qty);


--
-- Name: t_do_plan_part_ref_process_lt_idx3; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_part_ref_process_lt_idx3 ON dosystem.t_do_plan_part_ref_process_lt USING btree (plan_date);


--
-- Name: t_do_plan_plan_part_bf_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx1 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree (factory_cd, part_no, dim, class, plan_date, plan_time);


--
-- Name: t_do_plan_plan_part_bf_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx2 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree (factory_cd, part_no, dim, class, (((plan_date)::text || (plan_time)::text)), block_cd);


--
-- Name: t_do_plan_plan_part_bf_idx3; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx3 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree (factory_cd, part_no, dim, plan_date, plan_time, class, block_cd);


--
-- Name: t_do_plan_plan_part_bf_idx4; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx4 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree ((((plan_date)::text || (plan_time)::text)));


--
-- Name: t_do_plan_plan_part_bf_idx5; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx5 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree (plan_date, plan_time, total_process_lt);


--
-- Name: t_do_plan_plan_part_bf_idx6; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_bf_idx6 ON dosystem.t_do_plan_plan_part_byhousr_bf USING btree ((((plan_date)::text || (plan_time)::text)), plan_qty);


--
-- Name: t_do_plan_plan_part_byhousr_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx1 ON dosystem.t_do_plan_plan_part_byhousr USING btree (factory_cd, part_no, dim, class, plan_date, plan_time);


--
-- Name: t_do_plan_plan_part_byhousr_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx2 ON dosystem.t_do_plan_plan_part_byhousr USING btree (factory_cd, part_no, dim, class, (((plan_date)::text || (plan_time)::text)), block_cd);


--
-- Name: t_do_plan_plan_part_byhousr_idx3; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx3 ON dosystem.t_do_plan_plan_part_byhousr USING btree (factory_cd, part_no, dim, plan_date, plan_time, class, block_cd);


--
-- Name: t_do_plan_plan_part_byhousr_idx4; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx4 ON dosystem.t_do_plan_plan_part_byhousr USING btree ((((plan_date)::text || (plan_time)::text)));


--
-- Name: t_do_plan_plan_part_byhousr_idx5; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx5 ON dosystem.t_do_plan_plan_part_byhousr USING btree (plan_date, plan_time, total_process_lt);


--
-- Name: t_do_plan_plan_part_byhousr_idx6; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx6 ON dosystem.t_do_plan_plan_part_byhousr USING btree ((((plan_date)::text || (plan_time)::text)), plan_qty);


--
-- Name: t_do_plan_plan_part_byhousr_idx7; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx7 ON dosystem.t_do_plan_plan_part_byhousr USING btree (factory_cd, part_no, dim, block_cd, class, plan_date, plan_time, total_process_lt, logic);


--
-- Name: t_do_plan_plan_part_byhousr_idx8; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_plan_part_byhousr_idx8 ON dosystem.t_do_plan_plan_part_byhousr USING btree (plan_date, plan_time, total_process_lt, rk_prio_divi);


--
-- Name: t_do_plan_planbyshift_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_planbyshift_idx1 ON dosystem.t_do_plan_planbyshift USING btree (factory_cd, (((plan_date_to)::text || (plan_time_to)::text)), shift, line_cd, plan_date);


--
-- Name: t_do_plan_planbyshift_idx3; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_planbyshift_idx3 ON dosystem.t_do_plan_planbyshift USING btree ((((plan_date_from)::text || (plan_time_from)::text)), plan_date, factory_cd, line_cd);


--
-- Name: t_do_plan_ref_delivery_date_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_ref_delivery_date_idx1 ON dosystem.t_do_plan_ref_delivery_date USING btree (factory_cd, part_no, dim, (((plan_date_ref_del_date)::text || (plan_time_ref_del_round)::text)), use_block_cd, supplier_cd, ratio, class, plan_qty, comment_msg);


--
-- Name: t_do_plan_ref_delivery_date_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_ref_delivery_date_idx2 ON dosystem.t_do_plan_ref_delivery_date USING btree ((((plan_date_ref_del_date)::text || (plan_time_ref_del_round)::text)), ratio, plan_qty, comment_msg);


--
-- Name: t_do_plan_ref_delivery_lot_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_ref_delivery_lot_idx1 ON dosystem.t_do_plan_ref_delivery_lot USING btree ((((plan_date)::text || (plan_time)::text)), ratio, plan_qty_ref_lot);


--
-- Name: t_do_plan_ref_delivery_lot_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_ref_delivery_lot_idx2 ON dosystem.t_do_plan_ref_delivery_lot USING btree (factory_cd, part_no, dim, (((plan_date)::text || (plan_time)::text)), use_block_cd, supplier_cd, ratio, class, plan_qty_ref_lot);


--
-- Name: t_do_plan_std_stock_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_do_plan_std_stock_idx1 ON dosystem.t_do_plan_std_stock USING btree (factory_cd, part_no, dim, class, use_block_cd);


--
-- Name: t_prd_do_part_and_structure_idx1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_prd_do_part_and_structure_idx1 ON dosystem.t_prd_do_part_and_structure USING btree (rk_prio_divi, pt_ratio);


--
-- Name: t_prd_do_part_and_structure_idx2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_prd_do_part_and_structure_idx2 ON dosystem.t_prd_do_part_and_structure USING btree (part_no, dim, class, block_cd);


--
-- Name: t_prd_do_part_master_index1; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_prd_do_part_master_index1 ON dosystem.t_prd_do_part_master USING btree (part_no, dim, supplier_cd);


--
-- Name: t_prd_do_part_master_index2; Type: INDEX; Schema: dosystem; Owner: dosystem
--

CREATE INDEX t_prd_do_part_master_index2 ON dosystem.t_prd_do_part_master USING btree (part_no, dim, supplier_cd, block_cd);


--
-- PostgreSQL database dump complete
--

