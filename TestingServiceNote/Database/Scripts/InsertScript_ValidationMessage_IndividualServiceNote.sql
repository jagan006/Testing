Delete FROM DocumentValidations WHERE DocumentCodeId = 70014 AND TableName= 'CustomServices' and TabName = 'Service' 
Delete FROM DocumentValidations WHERE DocumentCodeId = 70014  AND TableName = 'CustomIndividualServiceNoteGoals'
Delete FROM DocumentValidations WHERE DocumentCodeId = 70014  AND TableName = 'CustomIndividualServiceNoteObjectives'
Delete FROM DocumentValidations WHERE DocumentCodeId = 70014  AND TableName = 'CustomDocumentIndividualServiceNotes'

--select * from  DocumentValidations WHERE DocumentCodeId = 70014
INSERT [dbo].[DocumentValidations] (
	[Active]
	,[DocumentCodeId]
	,[DocumentType]
	,[TabName]
	,[TabOrder]
	,[TableName]
	,[ColumnName]
	,[ValidationLogic]
	,[ValidationDescription]
	,[ValidationOrder]
	,[ErrorMessage]
	)
VALUES 
--(
--	N'Y'
--	,70014
--	,NULL
--	,'Service'
--	,1
--	,N'CustomServices'
--	,N'ModeOfDelivery'
--	,N'FROM Services s inner join CustomServices cs on s.ServiceId=cs.ServiceId where cs.ServiceId = @ServiceId and (s.Status not in (72,73,76)) and isnull(cs.ModeOfDelivery, 0)= 0'
--	,N'Custom Fields – Mode of delivery is required'
--	,CAST(1 AS DECIMAL(18, 0))
--	,N'Custom Fields – Mode of delivery is required'
--	)
--	,
	
--	(
--	N'Y'
--	,70014
--	,NULL
--	,'Service'
--	,1
--	,N'CustomServices'
--	,N'Recipient'
--	,N'FROM Services s inner join CustomServices cs on s.ServiceId=cs.ServiceId where cs.ServiceId = @ServiceId and (s.[Status] not in (72,73,76)) and isnull(cs.Recipient, 0)= 0'
--	,N'Custom Fields –Recipients is required'
--	,CAST(2 AS DECIMAL(18, 0))
--	,N'Custom Fields – Recipients is required'
--	),
	--(
	--N'Y'
	--,70014
	--,NULL
	--,'Service'
	--,1
	--,N'CustomServices'
	--,N'MemberParticipated'
	--,N'FROM Services s inner join CustomServices cs on s.ServiceId=cs.ServiceId where cs.ServiceId = @ServiceId and (s.[Status] not in (72,73,76)) and isnull(cs.MemberParticipated, ''N'')= ''N'''
	--,N'Custom Fields – Client Participated is required'
	--,CAST(2 AS DECIMAL(18, 0))
	--,N'Custom Fields – Client Participated is required'
	--),
	--(
	--N'Y'
	--,70014
	--,NULL
	--,'Service'
	--,1
	--,N'CustomServices'
	--,N'CancelNoShowComment'
	--,N'FROM CustomServices cs  JOIN Services s ON s.ServiceId = cs.ServiceId   where cs.ServiceId = @ServiceId and  isnull(CancelNoShowComment, '''')= '''' AND  s.[Status] IN (72,73)'
	--,N'Custom Fields – Cancel/No Show comment is required'
	--,CAST(3 AS DECIMAL(18, 0))
	--,N'Custom Fields – Cancel/No Show comment is required'
	--),
 (
 N'Y'
 ,70014
 ,NULL
 ,'General'
 ,1
 ,N'CustomIndividualServiceNoteGoals'
 ,N'ProgramId'
 ,N'FROM CustomIndividualServiceNoteGoals  WHERE DocumentVersionId=@DocumentVersionId AND 
(Select Count(IndividualServiceNoteGoalId) from
 CustomIndividualServiceNoteGoals WHERE ISNULL(RecordDeleted,''N'')  = ''N'' AND
  ISNULL(CustomGoalActive,''N'')=''Y'' AND DocumentVersionId=@DocumentVersionId) = 0  AND @ServiceGoalObjective=0'
 ,N'Goals/Outcomes/Strategies – Goals/Objectives - Goal is required.'
 ,CAST(1 AS DECIMAL(18, 0))
 ,N'Goals/Outcomes/Strategies – Goals/Objectives - Goal is required.'
 ),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'General'
 ,1
 ,N'CustomIndividualServiceNoteObjectives'
 ,N'ProgramId'
 ,N'FROM CustomIndividualServiceNoteObjectives  WHERE DocumentVersionId=@DocumentVersionId AND 
(Select Count(IndividualServiceNoteObjectiveId) from
 CustomIndividualServiceNoteObjectives WHERE ISNULL(RecordDeleted,''N'')  = ''N'' AND
  ISNULL(CustomObjectiveActive,''N'')=''Y'' AND DocumentVersionId=@DocumentVersionId) = 0  AND @ServiceGoalObjective=0'
 ,N'Goals/Outcomes/Strategies – Goals/Objectives - Objective is required.'
 ,CAST(2 AS DECIMAL(18, 0))
 ,N'Goals/Outcomes/Strategies – Goals/Objectives - Objective is required.'
 ),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'Note'
 ,1
 ,N'CustomDocumentIndividualServiceNotes'
 ,N'GoalsOutcomesStrategies'
 ,N'FROM CustomDocumentIndividualServiceNotes CN inner join CustomIndividualServiceNoteGoals cg on CN.DocumentVersionId = cg.DocumentVersionId  join CustomIndividualServiceNoteObjectives co on co.DocumentVersionId=cg.DocumentVersionId  WHERE CN.DocumentVersionId=@DocumentVersionId
  AND ISNULL(CN.RecordDeleted,''N'')  = ''N''
 AND ISNULL(cg.CustomGoalActive,''N'')=''N''
 AND ISNULL(co.CustomObjectiveActive,''N'')=''N''
 AND ISNULL(CN.GoalsOutcomesStrategies,'''') = '''''
 ,N'Service – Goals/Outcomes/Strategies textbox is required.'
 ,CAST(3 AS DECIMAL(18, 0))
 ,N'Service – Goals/Outcomes/Strategies textbox is required.'
 ),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'Note'
 ,1
 ,N'CustomDocumentIndividualServiceNotes'
 ,N'ServiceEvent'
 ,N'FROM CustomDocumentIndividualServiceNotes WHERE DocumentVersionId=@DocumentVersionId AND ISNULL(RecordDeleted,''N'') = ''N'' AND ISNULL(ServiceEvent,'''') = '''''
 ,N'Service – What Occurred during this service event is required.'
 ,CAST(4 AS DECIMAL(18, 0))
 ,N'Service – What Occurred during this service event is required.'
 ),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'Note'
 ,1
 ,N'CustomDocumentIndividualServiceNotes'
 ,N'PertinentEvent'
 ,N'FROM CustomDocumentIndividualServiceNotes WHERE DocumentVersionId=@DocumentVersionId AND ISNULL(RecordDeleted,''N'') = ''N'' AND ISNULL(PertinentEvent,'''') = '''''
 ,N'Service – Describe any pertinent event or behavior relating to the individual which occurs during the provision of this service is required.'
 ,CAST(5 AS DECIMAL(18, 0))
 ,N'Service – Describe any pertinent event or behavior relating to the individual which occurs during the provision of this service is required.'
 ),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'Note'
 ,1
 ,N'CustomDocumentIndividualServiceNotes'
 ,N'Progress'
 ,N'FROM CustomDocumentIndividualServiceNotes WHERE DocumentVersionId=@DocumentVersionId AND ISNULL(Progress,'''')=''''  AND ISNULL(RecordDeleted,''N'') = ''N''' 
 ,N'Follow Up – Either the Progress  or Lack of Progress radio button is required.'
 ,CAST(6 AS DECIMAL(18, 0))
 ,N'Follow Up – Either the Progress  or Lack of Progress radio button is required.'
 ),
 
 --(
 --N'Y'
 --,70014
 --,NULL
 --,'Note'
 --,1
 --,N'CustomDocumentIndividualServiceNotes'
 --,N'LackOfProgress'
 --,N'FROM CustomDocumentIndividualServiceNotes WHERE DocumentVersionId=@DocumentVersionId AND ISNULL(RecordDeleted,''N'') = ''N'' AND ISNULL(LackOfProgress,''N'') = ''N'''
 --,N'Follow Up – Lack Of Progress is required.'
 --,CAST(9 AS DECIMAL(18, 0))
 --,N'Follow Up – Lack Of Progress is required.'
 --),
 
 (
 N'Y'
 ,70014
 ,NULL
 ,'Note'
 ,1
 ,N'CustomDocumentIndividualServiceNotes'
 ,N'FollowUpNeeded'
 ,N'FROM CustomDocumentIndividualServiceNotes WHERE DocumentVersionId=@DocumentVersionId AND ISNULL(RecordDeleted,''N'') = ''N'' AND ISNULL(FollowUpNeeded,'''') = '''''
 ,N'Follow Up- What follow up is needed is required.'
 ,CAST(7 AS DECIMAL(18, 0))
 ,N'Follow Up- What follow up is needed is required.'
 )
		
