//function onIndividualTabSelected(sender, args) {
//    SubTabIndex = args.tab.index;
//    onTabSelected(sender, args);
//}

function SetScreenSpecificValues() {
   
    if (TabIndex == 0) {
        SubTabIndex = 0;
        var myDate = new Date();
        //$('[id$=divClientInformationNotesLink] > table tr').each(function () {
        //    $(this).find('td').each(function () {
        //        var obj = $(this).find('span').next();
        //        if ($(obj).length > 0) {
        //            $.post(GetRelativePath() + "CommonUserControls/AjaxCallForInformationIconToolTip.aspx?ClientInformationNotes=Y&StoredProcedureName=" + $(obj).attr('TooltipSP') + "&Date=" + myDate, function (data) {
        //                $(obj).wTooltip({
        //                    content: data,
        //                    style: {
        //                        border: "1px solid black",
        //                        background: "yellow",
        //                        color: "black",
        //                        padding: "1px,1px,10px,1px",
        //                        top: "5px"
        //                    }
        //                });

        //            });
        //        }
        //    });
        //});

        //EnableOrDiableCheckBoxes();
        //EnableOrDiableHarmToOthersCheckBoxes();
        //EnableOrDisableHarmToPropertyCheckBoxes();

        // Goals and objectives
        
       // alert($("[id$=HiddenFieldGoalsAndObjectives]").val());
        var goalsAndObjectives = $("[id$=HiddenFieldGoalsAndObjectives]").val();
        //alert(goalsAndObjectives);
        $('#GoalsObj').html(goalsAndObjectives);
        var check = false;
        if ($('#CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems').attr('checked') == true) {
            $('#GoalsObj input:checkbox:not(:checked)').parent().parent().hide();
            $('#GoalsObj input:text:not(:checked)').parent().parent().hide();
            check = true;
        }
        else {
            $('#GoalsObj input:checkbox:not(:checked)').parent().parent().show();
            $('#GoalsObj input:text:not(:checked)').parent().parent().show();
        }
        var status = $('[#GoalsObj][id=CheckBoxGoal]');
        if (status.length > 0) {
            var count = 0;
            $(status).each(function () {
                var id = $(this).attr('goalidtohide');
                if (check == true) {
                    if ($(this).attr('checked') == true) {
                        if (count == 0) {
                            $('#spanStatus_' + id).show()
                            count = 1;
                        }
                        else {
                            $('#spanStatus_' + id).hide();
                        }
                    }
                }
                else {
                    if (count == 0) {
                        $('#spanStatus_' + id).show()
                        count = 1;
                    }
                    else {
                        $('#spanStatus_' + id).hide();
                    }
                }
            });
        }
    }
}

function CheckBoxJavascript(htmldata, row) {
    var vSelectedContactTable = GetAutoSaveXMLDomNode('CustomIndividualServiceNoteGoals');
    var items = vSelectedContactTable.length > 0 ? $(vSelectedContactTable).XMLExtract() : [];
    var vSelectedContactId = '';
    if (items.length > 0) {
        $(items).each(function () {
            if ($(this)[0].RecordDeleted != 'Y' && $(this)[0].GoalId == htmldata) {
                vSelectedContactId = $(this)[0].IndividualServiceNoteGoalId;
                return false;
            }

        });
    }
    var contactitem = ArrayHelpers.GetItem(items, vSelectedContactId, 'IndividualServiceNoteGoalId');
    //var DropDownListProgramId = parent.$('select[id$=DropDownList_Services_ProgramId]');
    //pgmid = DropDownListProgramId.val();
    if ($(row).attr('checked') == true) {
        chk = "true";
        contactitem["CustomGoalActive"] = "Y";
        //contactitem["ProgramId"] = pgmid;
        uncheckObj(htmldata, "false");
    }
    else {
        contactitem["CustomGoalActive"] = "N";
        uncheckObj(htmldata, "disabled");
    }
    CreateAutoSaveXMLObjArray('CustomIndividualServiceNoteGoals', 'IndividualServiceNoteGoalId', contactitem, false);
}

function uncheckObj(htmldata, type, pNotSaveFlag) {
    $('[#GoalsObj][GoalID=' + htmldata + ']').each(function () {
        if (type == "disabled") {
            $(this).attr("disabled", "disabled");
            $(this).attr("checked", false);
            if (!pNotSaveFlag)
                CheckBoxJavascriptObj($(this).attr('ObjectiveNumber'), this, pNotSaveFlag);
        }
        else {
            $(this).removeAttr("disabled");
        }
    });
    $('[#GoalsObj][ObjGoalID=' + htmldata + ']').each(function () {
        if (type == "disabled") {
            $(this).attr("disabled", "disabled");
        }
        else {
            $(this).removeAttr("disabled");
        }
    });
}

function CheckBoxJavascriptObj(htmldata, chk) {
    var vSelectedContactTable = GetAutoSaveXMLDomNode('CustomIndividualServiceNoteObjectives');
    var items = vSelectedContactTable.length > 0 ? $(vSelectedContactTable).XMLExtract() : [];
    var vSelectedContactId = '';
    //    vSelectedContactId = AutoSaveXMLDom.find("CustomPeerSupportContactNoteObjectives").find('ObjectiveNumber[text=' + htmldata + ']').parent().find("CustomPeerSupportContactNoteObjectiveId").text();
    if (items.length > 0) {
        $(items).each(function () {
            if ($(this)[0].RecordDeleted != 'Y' && $(this)[0].ObjectiveNumber == htmldata) {
                vSelectedContactId = $(this)[0].IndividualServiceNoteObjectiveId;
                return false;
            }

        });
    }
    var contactitem = ArrayHelpers.GetItem(items, vSelectedContactId, 'IndividualServiceNoteObjectiveId');
    if ($(chk).attr('checked') == true) {
        chk = "true";
        contactitem["CustomObjectiveActive"] = "Y";
    }
    else {
        contactitem["CustomObjectiveActive"] = "N";
        contactitem["Status"] = '';
        $('#DropDownList_CustomIndividualServiceNoteObjectives_Status_' + vSelectedContactId).val('');
    }
    CreateAutoSaveXMLObjArray('CustomIndividualServiceNoteObjectives', 'IndividualServiceNoteObjectiveId', contactitem, false);
}

function ShowCheckedGoalsObjectives(select) {
    var check = false;
    if ($(select).attr('checked') == true) {
        $('#GoalsObj input:checkbox:not(:checked)').parent().parent().hide();
        //$('#GoalsObj input:text:not(:checked)').parent().parent().hide();
        check = true;
    }
    else {
        $('#GoalsObj input:checkbox:not(:checked)').parent().parent().show();
        // $('#GoalsObj input:text:not(:checked)').parent().parent().show();
    }

    var status = $('[#GoalsObj][id=CheckBoxGoal]');
    if (status.length > 0) {
        var count = 0;
        $(status).each(function () {
            var id = $(this).attr('goalidtohide');
            if (check == true) {
                if ($(this).attr('checked') == true) {
                    if (count == 0) {
                        $('#spanStatus_' + id).show()
                        count = 1;
                    }
                    else {
                        $('#spanStatus_' + id).hide();
                    }
                }
            }
            else {
                if (count == 0) {
                    $('#spanStatus_' + id).show()
                    count = 1;
                }
                else {
                    $('#spanStatus_' + id).hide();
                }
            }
        });
    }
}

function AddEventHandlers() {
    if (KeyScreenTabIndex == 1) {
        
      var DocumentVersionId = AutoSaveXMLDom.find("DocumentVersions:first DocumentVersionId").text();
        if (parseInt(DocumentVersionId) <= 0) {
            var ProcedureCodeId = AutoSaveXMLDom.find("Services:first ProcedureCodeId").text();
            var GoalProcedureCodeId = AutoSaveXMLDom.find("CustomIndividualServiceNoteGoals:first ProcedureCodeId").text();
            if (ProcedureCodeId != GoalProcedureCodeId) {
                AutoSaveXMLDom.find('DataSetServiceNote>CustomIndividualServiceNoteGoals').remove();
                AutoSaveXMLDom.find('DataSetServiceNote>CustomIndividualServiceNoteObjectives').remove();
                var requestParametersValues = "FunctionName=RefreshGoalsAndObjectives";
                if ($('#GoalsObj').length > 0) {
                    PopupProcessing();
                    $.ajax({
                        type: "POST",
                        url: _ApplicationBasePath + "Custom/CaminoIndividualServiceNote/WebPages/IndividualServiceNote.ashx",
                        data: requestParametersValues,
                        success: function (data) {
                            if (data != '') {
                                HidePopupProcessing();
                                AppendGoalsAndObjective(data);
                            }
                            else {
                                RefreshGoalsAndObjectives();
                            }
                        },
                        error: function (result, err, Message) {
                            HidePopupProcessing();
                        }
                    });
                }
            }
        }
    }
}

RefreshGoalsAndObjectives = (function () {
    var requestParametersValues = "FunctionName=GetXMLGoalsAndObjectives";
    if ($('#GoalsObj').length > 0) {
        $.ajax({
            type: "POST",
            url: _ApplicationBasePath + "Custom/CaminoIndividualServiceNote/WebPages/IndividualServiceNote.ashx",
            data: requestParametersValues,
            success: function (data) {
                if (data != '') {
                    HidePopupProcessing();
                    AppendGoalsAndObjective(data);
                }
                else {
                    RefreshGoalsAndObjectives();
                }
            },
            error: function (result, err, Message) {
                HidePopupProcessing();
            }
        });
    }
});

AppendGoalsAndObjective = (function (data) {
    var XmlSplit = data.split('$R1Y9N5ATNRD$');
    var GoalData = "";
    var GoalXML = "No goals linked to procedure code.";
    if (XmlSplit.length > 0)
        GoalXML = XmlSplit[0];
    if (XmlSplit.length > 1)
        GoalData = XmlSplit[1];

    var xmlobj = $.xmlDOM(GoalXML);
    var XMLGoals = $("CustomIndividualServiceNoteGoals", xmlobj);
    var XMLGoalitems = $(XMLGoals).XMLExtract();
    for (var i = 0; i < XMLGoalitems.length; i++) {
        var newitem = ArrayHelpers.GetItem(XMLGoalitems, XMLGoalitems[i].IndividualServiceNoteGoalId, 'IndividualServiceNoteGoalId');
        newitem['IndividualServiceNoteGoalId'] = XMLGoalitems[i].IndividualServiceNoteGoalId;
        newitem['CreatedDate'] = ISODateString(new Date());
        newitem['CreatedBy'] = objectPageResponse.LoggedInUserCode;
        newitem['ModifiedBy'] = objectPageResponse.LoggedInUserCode;
        newitem['ModifiedDate'] = ISODateString(new Date());
        newitem['DocumentVersionId'] = XMLGoalitems[i].DocumentVersionId;
        newitem['GoalId'] = XMLGoalitems[i].GoalId;
        newitem['GoalNumber'] = XMLGoalitems[i].GoalNumber;
        newitem['GoalText'] = XMLGoalitems[i].GoalText;
        newitem['CustomGoalActive'] = XMLGoalitems[i].CustomGoalActive;
        newitem['ProcedureCodeId'] = XMLGoalitems[i].ProcedureCodeId;
        CreateAutoSaveXMLObjArray('CustomIndividualServiceNoteGoals', 'IndividualServiceNoteGoalId', newitem, false, 'N');
    }

    var XMLObjectives = $("CustomIndividualServiceNoteObjectives", xmlobj);
    var XMLObjectiveitems = $(XMLObjectives).XMLExtract();
    for (var i = 0; i < XMLObjectiveitems.length; i++) {
        var newitem = ArrayHelpers.GetItem(XMLObjectiveitems, XMLObjectiveitems[i].IndividualServiceNoteObjectiveId, 'IndividualServiceNoteObjectiveId');
        newitem['IndividualServiceNoteObjectiveId'] = XMLObjectiveitems[i].IndividualServiceNoteObjectiveId;
        newitem['CreatedDate'] = ISODateString(new Date());
        newitem['CreatedBy'] = objectPageResponse.LoggedInUserCode;
        newitem['ModifiedBy'] = objectPageResponse.LoggedInUserCode;
        newitem['ModifiedDate'] = ISODateString(new Date());
        newitem['DocumentVersionId'] = XMLObjectiveitems[i].DocumentVersionId;
        newitem['GoalId'] = XMLObjectiveitems[i].GoalId;
        newitem['ObjectiveNumber'] = XMLObjectiveitems[i].ObjectiveNumber;
        newitem['ObjectiveText'] = XMLObjectiveitems[i].ObjectiveText;
        newitem['CustomObjectiveActive'] = XMLObjectiveitems[i].CustomObjectiveActive;
        CreateAutoSaveXMLObjArray('CustomIndividualServiceNoteObjectives', 'IndividualServiceNoteObjectiveId', newitem, false, 'N');
    }


    $('#GoalsObj').html(GoalData);
    var check = false;
    if ($('#CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems').attr('checked') == true) {
        $('#GoalsObj input:checkbox:not(:checked)').parent().parent().hide();
        $('#GoalsObj input:text:not(:checked)').parent().parent().hide();
        check = true;
    }
    else {
        $('#GoalsObj input:checkbox:not(:checked)').parent().parent().show();
        $('#GoalsObj input:text:not(:checked)').parent().parent().show();
    }
    var status = $('[#GoalsObj][id=CheckBoxGoal]');
    if (status.length > 0) {
        var count = 0;
        $(status).each(function () {
            var id = $(this).attr('goalidtohide');
            if (check == true) {
                if ($(this).attr('checked') == true) {
                    if (count == 0) {
                        $('#spanStatus_' + id).show()
                        count = 1;
                    }
                    else {
                        $('#spanStatus_' + id).hide();
                    }
                }
            }
            else {
                if (count == 0) {
                    $('#spanStatus_' + id).show()
                    count = 1;
                }
                else {
                    $('#spanStatus_' + id).hide();
                }
            }
        });
    }
});