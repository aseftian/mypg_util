SELECT 	pgprc.proname, pg_get_functiondef(COALESCE(trg1.tgfoid,pgprc.oid))||';' AS src,
				(SELECT event_object_table FROM information_schema.triggers WHERE trigger_name=trg1.tgname LIMIT 1) AS tablename,
				replace(pg_get_triggerdef(trg1.oid), 'CREATE TRIGGER '||trg1.tgname||' ','') AS definition
FROM pg_proc pgprc
LEFT JOIN pg_trigger trg1 ON trg1.tgname=pgprc.proname
WHERE (pgprc.prosrc) like '%WORD_SCRIPT_TO_SEARCH%';
