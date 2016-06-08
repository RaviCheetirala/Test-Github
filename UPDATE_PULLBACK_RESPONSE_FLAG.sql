
SET SERVEROUT ON
DECLARE
PROCEDURE WRITE_LOG(p_logMessage IN VARCHAR2) AS
BEGIN
  BEGIN
    dbms_output.PUT_LINE (p_logMessage);
    EXCEPTION
    WHEN OTHERS THEN
    IF SQLCODE = -20000 THEN
      dbms_output.DISABLE();
      dbms_output.ENABLE(1000);
      dbms_output.PUT_LINE (p_logMessage);
    END IF;
  END;                          
END WRITE_LOG;

BEGIN
  dbms_output.ENABLE(1000);
 IDH_APPLIC.UPDATE_PULLBACK_RESPONSE_FLAG;
WRITE_LOG ('Pullback Site rollout table is COMPLETED');

COMMIT;

EXCEPTION
  WHEN OTHERS THEN
  raise_application_error(-20101,'Error is '|| SQLCODE ||': ' || SQLERRM);
  WRITE_LOG('Error ' || SQLCODE || ': ' || SQLERRM);
END;
/
EXIT
