USE testing_system_02;
-- VARIABLES
-- LOCAL SCOPE: within the command BEGIN ... END
-- SESSION SCOPE: within the session
-- GLOBAL: within the whole connection
SHOW VARIABLES;
SET GLOBAL connection_timeout = 5;
SET @global.conenct_timeout = 10;
SELECT @@connection_timeout;

-- TRIGGER
-- Ex1: create Trigger to check created date, set to the current time if it is larger than the current time
DROP TRIGGER IF EXISTS trigger_demo_01;
DELIMITER $$
CREATE TRIGGER trigger_demo_01
BEFORE INSERT ON `group`
FOR EACH ROW
BEGIN
	IF NEW.created_date > NOW() THEN
		-- SET NEW.created_date = NOW();
        
        -- error and send back message
        SIGNAL SQLSTATE '12345';
        SET MESSAGE_TEXT = 'Created date cannot be in the future';
	END IF;
END $$
DELIMITER ;

SELECT * FROM `group`;