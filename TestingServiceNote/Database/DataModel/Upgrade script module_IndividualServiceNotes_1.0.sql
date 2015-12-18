----- STEP 1 ----------

------ STEP 2 ----------
--Part1 Begin
--Part1 Ends

--Part2 Begins


--Part2 Ends
-----End of Step 2 -------

------ STEP 3 ------------

------ END OF STEP 3 -----

------ STEP 4 ----------
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME='CustomDocumentIndividualServiceNotes')
BEGIN
/* 
 * TABLE: CustomDocumentIndividualServiceNotes 
 */
 CREATE TABLE CustomDocumentIndividualServiceNotes( 
		DocumentVersionId						int					 NOT NULL,
		CreatedBy								type_CurrentUser     NOT NULL,
		CreatedDate								type_CurrentDatetime NOT NULL,
		ModifiedBy								type_CurrentUser     NOT NULL,
		ModifiedDate							type_CurrentDatetime NOT NULL,
		RecordDeleted							type_YOrN			 NULL
												CHECK (RecordDeleted in ('Y','N')),
		DeletedBy								type_UserId          NULL,
		DeletedDate								datetime             NULL,
		ShowSelectedItems						type_YOrN			 NULL
												CHECK (ShowSelectedItems in ('Y','N')),	
		GoalsOutcomesStrategies					type_Comment2		NULL,
		NameOfService							type_Comment2		NULL,
		ServiceEvent							type_Comment2		NULL,
		PertinentEvent 							type_Comment2		NULL,
		Progress								type_YOrN			 NULL
												CHECK (Progress in ('Y','N')),
		LackOfProgress 							type_YOrN			 NULL
												CHECK (LackOfProgress in ('Y','N')),
		ProgressComments						type_Comment2		NULL,
		FollowUpNeeded							type_Comment2		NULL,
		CONSTRAINT CustomDocumentIndividualServiceNotes_PK PRIMARY KEY CLUSTERED (DocumentVersionId) 
 )
 
  IF OBJECT_ID('CustomDocumentIndividualServiceNotes') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomDocumentIndividualServiceNotes >>>'
ELSE
    RAISERROR('<<< FAILED CREATING TABLE CustomDocumentIndividualServiceNotes >>>', 16, 1)
/* 
 * TABLE: CustomDocumentIndividualServiceNotes 
 */   

    
ALTER TABLE CustomDocumentIndividualServiceNotes ADD CONSTRAINT DocumentVersions_CustomDocumentIndividualServiceNotes_FK
    FOREIGN KEY (DocumentVersionId)
    REFERENCES DocumentVersions(DocumentVersionId)
        
     PRINT 'STEP 4(A) COMPLETED'
END

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME='CustomIndividualServiceNoteGoals')
BEGIN
/* 
 * TABLE: CustomIndividualServiceNoteGoals 
 */
 CREATE TABLE CustomIndividualServiceNoteGoals( 
		IndividualServiceNoteGoalId				int	identity(1,1)	 NOT NULL,
		CreatedBy								type_CurrentUser     NOT NULL,
		CreatedDate								type_CurrentDatetime NOT NULL,
		ModifiedBy								type_CurrentUser     NOT NULL,
		ModifiedDate							type_CurrentDatetime NOT NULL,
		RecordDeleted							type_YOrN			 NULL
												CHECK (RecordDeleted in ('Y','N')),
		DeletedBy								type_UserId          NULL,
		DeletedDate								datetime             NULL,
		DocumentVersionId						int					 NULL,
		GoalId									int					 NULL,
		GoalNumber								decimal(18, 2)		 NULL,
		GoalText								type_Comment2		 NULL,
		CustomGoalActive						type_YOrN			 NULL
												CHECK (CustomGoalActive in ('Y','N')),
		CONSTRAINT CustomIndividualServiceNoteGoals_PK PRIMARY KEY CLUSTERED (IndividualServiceNoteGoalId) 
 )
 
  IF OBJECT_ID('CustomIndividualServiceNoteGoals') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomIndividualServiceNoteGoals >>>'
ELSE
    RAISERROR('<<< FAILED CREATING TABLE CustomIndividualServiceNoteGoals >>>', 16, 1)
    
    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomIndividualServiceNoteGoals]') AND name = N'XIE1_CustomIndividualServiceNoteGoals')
	BEGIN
		CREATE NONCLUSTERED INDEX [XIE1_CustomIndividualServiceNoteGoals] ON [dbo].[CustomIndividualServiceNoteGoals] 
		(
		[DocumentVersionId] 	
		)
		WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CustomIndividualServiceNoteGoals') AND name='XIE1_CustomIndividualServiceNoteGoals')
		PRINT '<<< CREATED INDEX CustomIndividualServiceNoteGoals.XIE1_CustomIndividualServiceNoteGoals >>>'
		ELSE
		RAISERROR('<<< FAILED CREATING INDEX CustomIndividualServiceNoteGoals.XIE1_CustomIndividualServiceNoteGoals >>>', 16, 1)		
	END

    
/* 
 * TABLE: CustomIndividualServiceNoteGoals 
 */   

    
ALTER TABLE CustomIndividualServiceNoteGoals ADD CONSTRAINT DocumentVersions_CustomIndividualServiceNoteGoals_FK
    FOREIGN KEY (DocumentVersionId)
    REFERENCES DocumentVersions(DocumentVersionId)

ALTER TABLE CustomIndividualServiceNoteGoals ADD CONSTRAINT CarePlanGoals_CustomIndividualServiceNoteGoals_FK
    FOREIGN KEY (GoalId)
    REFERENCES CarePlanGoals(CarePlanGoalId)    
        
     PRINT 'STEP 4(B) COMPLETED'
 END

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME='CustomIndividualServiceNoteObjectives')
BEGIN
/* 
 * TABLE: CustomIndividualServiceNoteObjectives 
 */
 CREATE TABLE CustomIndividualServiceNoteObjectives( 
		IndividualServiceNoteObjectiveId		int	identity(1,1)	 NOT NULL,
		CreatedBy								type_CurrentUser     NOT NULL,
		CreatedDate								type_CurrentDatetime NOT NULL,
		ModifiedBy								type_CurrentUser     NOT NULL,
		ModifiedDate							type_CurrentDatetime NOT NULL,
		RecordDeleted							type_YOrN			 NULL
												CHECK (RecordDeleted in ('Y','N')),
		DeletedBy								type_UserId          NULL,
		DeletedDate								datetime             NULL,
		DocumentVersionId						int					 NULL,
		GoalId									int					 NULL,
		ObjectiveNumber 						decimal(18, 2)		 NULL,		
		CustomObjectiveActive 					type_YOrN			 NULL
												CHECK (CustomObjectiveActive in ('Y','N')),
		[Status]								type_GlobalCode		 NULL,
		ObjectiveText							type_Comment2		 NULL,										
		CONSTRAINT CustomIndividualServiceNoteObjectives_PK PRIMARY KEY CLUSTERED (IndividualServiceNoteObjectiveId) 
 )
 
  IF OBJECT_ID('CustomIndividualServiceNoteObjectives') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomIndividualServiceNoteObjectives >>>'
ELSE
    RAISERROR('<<< FAILED CREATING TABLE CustomIndividualServiceNoteObjectives >>>', 16, 1)
    
  IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomIndividualServiceNoteObjectives]') AND name = N'XIE1_CustomIndividualServiceNoteObjectives')
	BEGIN
		CREATE NONCLUSTERED INDEX [XIE1_CustomIndividualServiceNoteObjectives] ON [dbo].[CustomIndividualServiceNoteObjectives] 
		(
		[DocumentVersionId] 	
		)
		WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CustomIndividualServiceNoteObjectives') AND name='XIE1_CustomIndividualServiceNoteObjectives')
		PRINT '<<< CREATED INDEX CustomIndividualServiceNoteObjectives.XIE1_CustomIndividualServiceNoteObjectives >>>'
		ELSE
		RAISERROR('<<< FAILED CREATING INDEX CustomIndividualServiceNoteObjectives.XIE1_CustomIndividualServiceNoteObjectives >>>', 16, 1)		
	END

/* 
 * TABLE: CustomIndividualServiceNoteObjectives 
 */
 
ALTER TABLE CustomIndividualServiceNoteObjectives ADD CONSTRAINT DocumentVersions_CustomIndividualServiceNoteObjectives_FK
    FOREIGN KEY (DocumentVersionId)
    REFERENCES DocumentVersions(DocumentVersionId)
    
ALTER TABLE CustomIndividualServiceNoteObjectives ADD CONSTRAINT CarePlanGoals_CustomIndividualServiceNoteObjectives_FK
    FOREIGN KEY (GoalId)
    REFERENCES CarePlanGoals(CarePlanGoalId)   
            
     PRINT 'STEP 4(C) COMPLETED'
 END

---------------------------------------------------------------
--END Of STEP 4

------ STEP 5 ----------------

-------END STEP 5-------------

------ STEP 6  ----------

------ STEP 7 -----------


If not exists (select [key] from SystemConfigurationKeys where [key] = 'CDM_IndividualServiceNotes')
BEGIN
		INSERT INTO [dbo].[SystemConfigurationKeys]
				   (CreatedBy
				   ,CreateDate 
				   ,ModifiedBy
				   ,ModifiedDate
				   ,[Key]
				   ,Value
				   )
			 VALUES    
				   ('SHSDBA'
				   ,GETDATE()
				   ,'SHSDBA'
				   ,GETDATE()
				   ,'CDM_IndividualServiceNotes'
				   ,'1.0'
				   )
		PRINT 'STEP 7 COMPLETED'
END
GO
