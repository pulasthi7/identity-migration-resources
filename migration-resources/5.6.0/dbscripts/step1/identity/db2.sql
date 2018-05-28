ALTER TABLE IDN_OAUTH_CONSUMER_APPS ADD ID_TOKEN_EXPIRE_TIME BIGINT DEFAULT 3600000
/
CREATE TABLE IDN_AUTH_TEMP_SESSION_DATA_STORE (
            SESSION_ID VARCHAR (100) NOT NULL,
            SESSION_TYPE VARCHAR(100) NOT NULL,
            OPERATION VARCHAR(10) NOT NULL,
            SESSION_OBJECT BLOB,
            TIME_CREATED BIGINT NOT NULL,
            TENANT_ID INTEGER DEFAULT -1,
            PRIMARY KEY (SESSION_ID, SESSION_TYPE, TIME_CREATED, OPERATION)
)
/
CREATE TABLE IF NOT EXISTS SP_CLAIM_DIALECT (
	   	ID INTEGER NOT NULL,
	   	TENANT_ID INTEGER NOT NULL,
	   	SP_DIALECT VARCHAR (512) NOT NULL,
	   	APP_ID INTEGER NOT NULL,
	   	PRIMARY KEY (ID))
/
CREATE SEQUENCE SP_CLAIM_DIALECT_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/
CREATE TRIGGER SP_CLAIM_DIALECT_TRIG NO CASCADE
            BEFORE INSERT
            ON SP_CLAIM_DIALECT
            REFERENCING NEW AS NEW
            FOR EACH ROW MODE DB2SQL
                BEGIN ATOMIC
                    SET (NEW.ID) = (NEXTVAL FOR SP_CLAIM_DIALECT_SEQ);
                END
/
ALTER TABLE SP_CLAIM_DIALECT ADD CONSTRAINT DIALECTID_APPID_CONSTRAINT FOREIGN KEY (APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE
/
