<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CaminoIndividualServiceNote.ascx.cs" Inherits="Custom_CaminoIndividualServiceNote_WebPages_CaminoIndividualServiceNote" %>
<%--<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IntensiveCaseManagementNote.ascx.cs" Inherits="Custom_IntensiveCaseManagementNote_Webpages_IntensiveCaseManagementNote" %>--%>
<%--<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CrisisTab.ascx.cs"
    Inherits="SHS.SmartCare.Custom_CrisisInterventionNote_WebPages_CrisisTab" %>--%>
<%@ Register Assembly="Streamline.DotNetDropDowns" Namespace="Streamline.DotNetDropDowns"
    TagPrefix="cc2" %>
<% if (HttpContext.Current == null)
   { %>
<link href="../../../../../App_Themes/Styles/smartcare_styles.css" rel="stylesheet"
    type="text/css" />
<%} %>
<%--<script src="<%=RelativePath%>Custom/IntensiveCaseManagementNote/Scripts/IntensiveCareManagementNote.js"></script>--%>
<style type="text/css">
    .style1
    {
        height: 21px;
    }

    .style2
    {
        height: 21px;
        width: 523px;
    }

    .style3
    {
        height: 21px;
        width: 525px;
    }

    .style4
    {
        height: 21px;
        width: 526px;
    }
</style>
<input type="hidden" id="HiddenFieldPageTables" name="HiddenFieldPageTables" value="CustomDocumentIndividualServiceNotes,CustomIndividualServiceNoteGoals,CustomIndividualServiceNoteObjectives" />
<script language="javascript" type="text/javascript" src="<%=RelativePath%>Custom/CaminoIndividualServiceNote/Scripts/CustomIndividualServiceNote.js"></script>
<input id="HiddenFieldGoalsAndObjectives" name="HiddenFieldGoalsAndObjectives" type="hidden"
    runat="server" />
<div id="divNursingNoteTab" style="width: 830px;" class="DocumentScreen">
    <table width="820px" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="left" width="100%">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="height1"></td>
                    </tr>
                    <tr>
                        <td align="left" class="content_tab_left" nowrap="nowrap">General</td>
                        <td width="17">
                            <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_sep.gif" style="vertical-align: top;" width="17" />
                        </td>
                        <td class="content_tab_top" width="100%"></td>
                        <td width="7">
                            <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_right.gif" style="vertical-align: top;" width="7" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>

            <td class="content_tab_bg">
                <table border="0" cellpadding="0" cellspacing="0" width="98%">
                    <tr>
                        <td style="padding-left: 10px; padding-right: 5px; padding-bottom: 2px">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <%-- <tr>
                                    <td class="height2"></td>
                                </tr--%>
                                <%-- <tr>
                                    <td class="checkbox_container" allign="right" style="padding-left: 220px; padding-bottom: 10px">
                                        <input id="CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems" type="checkbox" />
                                        <label for="CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems">
                                            Show only selected items</label>

                                    </td>
                                </tr>--%>
                                <tr>
                                    <td align="left" colspan="2" width="100%">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="height1"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="content_tab_left" nowrap="nowrap">Goals/Outcomes/Strategies</td>
                                                <td width="17">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_sep.gif" style="vertical-align: top;" width="17" />
                                                </td>
                                                <td class="content_tab_top" width="100%">
                                                    <table width="50%" style="padding-left: 5px;">
                                                        <tr>
                                                            <td width="5%" class="checkbox_container" align="right" style="padding-left: 10px">
                                                                <input id="CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems" type="checkbox" />
                                                                <label for="CheckBox_CustomDocumentIndividualServiceNotes_ShowSelectedItems">
                                                                    Show only selected items</label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height1"></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td width="7">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_right.gif" style="vertical-align: top;" width="7" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content_tab_bg" style="padding-left: 10px; padding-right: 10px;">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">

                                            <%--<tr>
                                                <td align="left" style="padding-left: 3px;">
                                                    <span class="form_label" id="Span83" name="SpanCrisis">Goals/ Outcomes/Strategies</span>
                                                </td>
                                            </tr>--%>
                                            <tr>
                                                <td style="padding-left: 15px">
                                                    <table width="100%" id="GoalObj">
                                                        <tr>
                                                            <td>
                                                                <div id="GoalsObj">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="height2"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" style="padding-left: 2px;">
                                                    <span class="form_label" id="Span88" name="SpanGoals">Goals/Outcomes/Strategies</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="height2"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="6" style="padding-left: 3px">
                                                    <textarea id="TextArea_CustomDocumentIndividualServiceNotes_GoalsOutcomesStrategies" name="TextArea_CustomDocumentIndividualServiceNotes_GoalsOutcomesStrategies"
                                                        cols="158" class="form_textarea" rows="5" style="width: 99%; height: 50px;"></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="2" class="right_bottom_cont_bottom_bg">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_left.gif"
                                                        height="7" alt="" />
                                                </td>
                                                <td class="right_bottom_cont_bottom_bg" width="100%"></td>
                                                <td width="2" class="right_bottom_cont_bottom_bg" align="right">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_right.gif"
                                                        height="7" alt="" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="height2"></td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 10px; padding-right: 5px;">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td align="left" colspan="2" width="100%">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="height1"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="content_tab_left" nowrap="nowrap">Service</td>
                                                <td width="17">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_sep.gif" style="vertical-align: top;" width="17" />
                                                </td>
                                                <td class="content_tab_top" width="100%"></td>
                                                <td width="7">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_right.gif" style="vertical-align: top;" width="7" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content_tab_bg" style="padding-left: 10px; padding-right: 9px;">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="left" style="padding-left: 10px">
                                                                <span>Name of the service</span>
                                                                <input name="TextBox_CustomDocumentIndividualServiceNotes_NameOfService" class="form_textbox element"
                                                                    id="TextBox_CustomDocumentIndividualServiceNotes_NameOfService" style="width: 105px;" type="text"
                                                                    maxlength="20" style="Padddi">
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" style="padding-left: 5px;">
                                                                <span class="form_label" id="Span11" name="SpanCrisis">What Occurred during this service event</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" colspan="6" style="padding-left: 5px">
                                                                <textarea id="TextArea_CustomDocumentIndividualServiceNotes_ServiceEvent" name="TextArea_CustomDocumentIndividualServiceNotes_ServiceEvent"
                                                                    cols="158" class="form_textarea" rows="5" style="width: 99%; height: 50px;"></textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" style="padding-left: 5px;">
                                                                <span class="form_label" id="Span8" name="SpanCrisis">Describe any pertinent event or behavior relating to the individual which occurs during the provision of this service</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>

                                                        <tr>
                                                            <td align="left" colspan="6" style="padding-left: 5px">
                                                                <textarea id="TextArea_CustomDocumentIndividualServiceNotes_PertinentEvent" name="TextArea_CustomDocumentIndividualServiceNotes_PertinentEvent"
                                                                    cols="158" class="form_textarea" rows="5" style="width: 99%; height: 50px;"></textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="2" class="right_bottom_cont_bottom_bg">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_left.gif"
                                                        height="7" alt="" />
                                                </td>
                                                <td class="right_bottom_cont_bottom_bg" width="100%"></td>
                                                <td width="2" class="right_bottom_cont_bottom_bg" align="right">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_right.gif"
                                                        height="7" alt="" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="height2"></td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 10px; padding-right: 5px;">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td align="left" colspan="2" width="100%">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="height1"></td>
                                            </tr>
                                            <tr>
                                                <td align="left" class="content_tab_left" nowrap="nowrap">Follow Up</td>
                                                <td width="17">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_sep.gif" style="vertical-align: top;" width="17" />
                                                </td>
                                                <td class="content_tab_top" width="100%"></td>
                                                <td width="7">
                                                    <img alt="" height="26" src="<%=RelativePath%>App_Themes/Includes/images/content_tab_right.gif" style="vertical-align: top;" width="7" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="content_tab_bg" style="padding-left: 10px; padding-right: 10px;">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <%--<td align="left" style="padding-left: 15px;">
                                                                <input name="RadioButton_CustomDocumentIndividualServiceNotes_Progress" class="element" id="RadioButton_CustomDocumentIndividualServiceNotes_Progress"
                                                                    type="radio" value="Y" />
                                                                <label for="RadioButton_CustomDocumentIndividualServiceNotes_Progress" class="form_label" style="vertical-align: top">
                                                                    Progress</label>
                                                                &nbsp; &nbsp;
                                                                <input name="RadioButton_CustomDocumentIndividualServiceNotes_LackOfProgress" class="element" id="RadioButton_CustomDocumentIndividualServiceNotes_LackOfProgress"
                                                                    type="radio" value="Y" />
                                                                <label for="RadioButton_CustomDocumentIndividualServiceNotes_LackOfProgress" class="form_label" style="vertical-align: top">
                                                                    Lack of Progress
                                                                </label>
                                                            </td>--%>
                                                            <td align="left" style="padding-left: 15px;">
                                                                <input name="RadioButton_CustomDocumentIndividualServiceNotes_Progress" class="element" id="RadioButton_CustomDocumentIndividualServiceNotes_Progress_Y"
                                                                    type="radio" value="Y" />
                                                                <label for="RadioButton_CustomDocumentIndividualServiceNotes_Progress_Y" class="form_label" style="vertical-align: top">
                                                                    Progress</label>
                                                                &nbsp; &nbsp;
                                                                <input name="RadioButton_CustomDocumentIndividualServiceNotes_Progress" class="element" id="RadioButton_CustomDocumentIndividualServiceNotes_Progress_N"
                                                                    type="radio" value="N" />
                                                                <label for="RadioButton_CustomDocumentIndividualServiceNotes_Progress_N" class="form_label" style="vertical-align: top">
                                                                    Lack of Progress
                                                                </label>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" colspan="6" style="padding-left: 5px">
                                                                <textarea id="TextArea_CustomDocumentIndividualServiceNotes_ProgressComments" name="TextArea_CustomDocumentIndividualServiceNotes_ProgressComments"
                                                                    cols="158" class="form_textarea" rows="5" style="width: 99%; height: 50px;"></textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" style="padding-left: 5px;">
                                                                <span class="form_label" id="Span2" name="SpanCrisis">What follow up is needed</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>

                                                        <tr>
                                                            <td align="left" colspan="6" style="padding-left: 5px">
                                                                <textarea id="TextArea_CustomDocumentIndividualServiceNotes_FollowUpNeeded" name="TextArea_CustomDocumentIndividualServiceNotes_FollowUpNeeded"
                                                                    cols="158" class="form_textarea" rows="5" style="width: 99%; height: 50px;"></textarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="height2"></td>
                                                        </tr>

                                                        <tr>
                                                    </table>
                                                </td>
                                            </tr>


                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="2" class="right_bottom_cont_bottom_bg">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_left.gif"
                                                        height="7" alt="" />
                                                </td>
                                                <td class="right_bottom_cont_bottom_bg" width="100%"></td>
                                                <td width="2" class="right_bottom_cont_bottom_bg" align="right">
                                                    <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_right.gif"
                                                        height="7" alt="" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="height2"></td>
                                </tr>

                            </table>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>


        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="2" class="right_bottom_cont_bottom_bg">
                            <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_left.gif"
                                height="7" alt="" />
                        </td>
                        <td class="right_bottom_cont_bottom_bg" width="100%"></td>
                        <td width="2" class="right_bottom_cont_bottom_bg" align="right">
                            <img style="vertical-align: top" src="<%=RelativePath%>App_Themes/Includes/Images/right_bottom_cont_bottom_right.gif"
                                height="7" alt="" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="height2"></td>
        </tr>


    </table>
</div>
<%--<input id="HiddenFieldPageTables" name="HiddenFieldPageTables" type="hidden" value="CustomDocumentIndividualServiceNotes" />--%>