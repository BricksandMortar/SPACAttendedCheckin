<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FamilySelect.ascx.cs" Inherits="RockWeb.Plugins.cc_newspring.AttendedCheckin.FamilySelect" %>

<asp:UpdatePanel ID="pnlContent" runat="server" UpdateMode="Conditional">
    <ContentTemplate>

        <Rock:ModalAlert ID="maWarning" runat="server" />

        <asp:Panel ID="pnlSelections" runat="server" CssClass="attended">

            <asp:HiddenField ID="hfNewPersonType" runat="server" />            

            <div class="row checkin-header">
                <div class="col-xs-2 checkin-actions">
                    <Rock:BootstrapButton ID="lbBack" CssClass="btn btn-lg btn-primary" runat="server" OnClick="lbBack_Click" EnableViewState="false">
                        <span class="fa fa-arrow-left" />
                    </Rock:BootstrapButton>
                </div>

                <div class="col-xs-8 text-center">
                    <h1 id="lblFamilyTitle" runat="server">Search Results</h1>
                </div>

                <div class="col-xs-2 checkin-actions text-right">
                    <Rock:BootstrapButton ID="lbNext" CssClass="btn btn-lg btn-primary" runat="server" OnClick="lbNext_Click" EnableViewState="false">
                        <span class="fa fa-arrow-right" />
                    </Rock:BootstrapButton>
                </div>
            </div>

            <div class="row checkin-body">
                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlFamily" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <h3 class="text-center">Families</h3>

                            <asp:ListView ID="lvFamily" runat="server" OnPagePropertiesChanging="lvFamily_PagePropertiesChanging"
                                OnItemCommand="lvFamily_ItemCommand" OnItemDataBound="lvFamily_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSelectFamily" runat="server" CausesValidation="false" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select family" OnClientClick="toggleFamily(this);" />
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpFamilyPager" runat="server" PageSize="4" PagedControlID="lvFamily">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-lg btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlPerson" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <h3 class="text-center">People</h3>
                            <asp:HiddenField ID="hfPersonIds" runat="server" />

                            <asp:ListView ID="lvPerson" runat="server" OnItemDataBound="lvPeople_ItemDataBound"
                                OnPagePropertiesChanging="lvPerson_PagePropertiesChanging">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSelectPerson" runat="server" data-id='<%# Eval("Person.Id") %>' CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" OnClientClick="togglePerson(this); return false;" />
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <div class="text-center large-font">
                                        <asp:Literal ID="lblPersonTitle" runat="server" Text="No family member(s) are eligible for check-in." />
                                    </div>
                                </EmptyDataTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpPersonPager" runat="server" PageSize="4" PagedControlID="lvPerson">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-lg btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlVisitor" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <h3 class="text-center">Visitors</h3>

                            <asp:ListView ID="lvVisitor" runat="server" OnItemDataBound="lvPeople_ItemDataBound" OnPagePropertiesChanging="lvVisitor_PagePropertiesChanging">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSelectPerson" runat="server" data-id='<%# Eval("Person.Id") %>' CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" OnClientClick="togglePerson(this); return false;" />
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <div class="text-center large-font">
                                        <asp:Literal ID="lblPersonTitle" runat="server" Text="No visitor(s) are eligible for check-in." />
                                    </div>
                                </EmptyDataTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpVisitorPager" runat="server" PageSize="4" PagedControlID="lvVisitor">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-lg btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <!-- Nothing Found State -->
                <h3 id="divNothingFound" runat="server" class="col-xs-9 centered" visible="false">
                    <asp:Literal ID="lblNothingFound" runat="server" EnableViewState="false" />
                </h3>

                <!-- Add Buttons -->
                <div id="divActions" runat="server" class="col-xs-3">
                    <h3 id="actions" runat="server" class="text-center">Actions</h3>

                    <asp:LinkButton ID="lbAddVisitor" runat="server" Text="Add Visitor" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" OnClick="lbAddVisitor_Click" CausesValidation="false" EnableViewState="false" />
                    <asp:LinkButton ID="lbAddFamilyMember" runat="server" Text="Add Person" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" OnClick="lbAddFamilyMember_Click" CausesValidation="false" EnableViewState="false" />
                    <asp:LinkButton ID="lbNewFamily" runat="server" Text="New Family" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" OnClick="lbNewFamily_Click" CausesValidation="false" EnableViewState="false" />
                </div>
            </div>
        </asp:Panel>

        <!-- ADD PERSON MODAL -->
        <Rock:ModalDialog ID="mdlAddPerson" runat="server">
            <Content>
                <div class="soft-quarter-ends">
                    <!-- Modal Header -->
                    <div class="row checkin-header">
                        <div class="checkin-actions">
                            <div class="col-xs-3">
                                <Rock:BootstrapButton ID="lbClosePerson" runat="server" CssClass="btn btn-lg btn-primary" OnClick="lbClosePerson_Click" Text="Cancel" EnableViewState="false" />
                            </div>

                            <div class="col-xs-6">
                                <h2 class="text-center">
                                    <asp:Literal ID="lblAddPersonHeader" runat="server" /></h2>
                            </div>

                            <div class="col-xs-3 text-right">
                                <Rock:BootstrapButton ID="lbPersonSearch" runat="server" CssClass="btn btn-lg btn-primary" OnClick="lbPersonSearch_Click" Text="Search" EnableViewState="false" />
                            </div>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="checkin-body">
                        <div class="row">
                            <asp:HiddenField ID="hfPersonPhotoId" runat="server" />
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbPersonFirstName" runat="server" CssClass="col-xs-12" Label="First Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbPersonLastName" runat="server" CssClass="col-xs-12" Label="Last Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2" runat="server" id="dobContainer">
                                <Rock:DatePicker ID="dpPersonDOB" runat="server" Label="Date of Birth" CssClass="col-xs-12 date-picker" ValidationGroup="Person" data-show-age="true" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockDropDownList ID="ddlPersonGender" runat="server" Label="Gender" CssClass="col-xs-12" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockDropDownList ID="ddlPersonAbilityGrade" runat="server" Label="Ability/Grade" CssClass="col-xs-12" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:PhoneNumberBox ID="pnPhoneNumber" runat="server" CssClass="col-xs-12" Label="Cell" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbAllergies"  Label="Allergies" runat="server" CssClass="col-xs-12" />
                            </div>
                            <div class="col-xs-4">
                                <Rock:RockTextBox ID="tbNotes" Label="Notes" runat="server" CssClass="col-xs-12"/>
                            </div>
                            <div class="col-xs-2">
                                <p style="font-size: large"><b>Photo</b></p>
                                <Rock:BootstrapButton ID="btnTakePhoto" runat="server" Text="Take Photo" CssClass="btn btn-primary" OnClick="btnTakePhoto_Click" EnableViewState="false"> <i class="fa fa-camera"></i> </Rock:BootstrapButton>
                            </div>

                            <div class="row flush-sides">
                                <div class="grid full-width soft-quarter-sides">
                                    <Rock:Grid ID="rGridPersonResults" runat="server" OnRowCommand="rGridPersonResults_AddExistingPerson" EnableResponsiveTable="true"
                                        OnGridRebind="rGridPersonResults_GridRebind" ShowActionRow="false" PageSize="4" DataKeyNames="Id" AllowSorting="true">
                                        <Columns>
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-2" ItemStyle-CssClass="col-xs-2" HeaderText="First Name" DataField="FirstName" SortExpression="FirstName" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-2" ItemStyle-CssClass="col-xs-2" HeaderText="Last Name" DataField="LastName" SortExpression="LastName" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-1" ItemStyle-CssClass="col-xs-1" HeaderText="Suffix" DataField="SuffixValue" SortExpression="SuffixValue" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-1" ItemStyle-CssClass="col-xs-1" HeaderText="DOB" DataField="BirthDate" DataFormatString="{0:MM/dd/yy}" HtmlEncode="false" SortExpression="BirthDate" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-1" ItemStyle-CssClass="col-xs-1" HeaderText="Age" DataField="Age" SortExpression="Age" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-2" ItemStyle-CssClass="col-xs-2" HeaderText="Gender" DataField="Gender" SortExpression="Gender" />
                                            <Rock:RockBoundField HeaderStyle-CssClass="col-xs-2" ItemStyle-CssClass="col-xs-2" HeaderText="Ability/Grade" DataField="Attribute" SortExpression="Attribute" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <Rock:BootstrapButton ID="lbAdd" runat="server" CssClass="btn btn-lg btn-primary" CommandName="Add"
                                                        Text="Add" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CausesValidation="false">
                                                    </Rock:BootstrapButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </Rock:Grid>
                                </div>
                            </div>

                            <div class="row">
                                <div class="soft-quarter-sides">
                                    <div class="col-xs-12 text-right">
                                        <Rock:BootstrapButton ID="lbNewPerson" runat="server" Text="None of these, add a new person" CssClass="btn btn-lg btn-primary btn-checkin-select"
                                            OnClick="lbNewPerson_Click" ValidationGroup="Person">
                                        </Rock:BootstrapButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </Content>
        </Rock:ModalDialog>

        <!-- ADD FAMILY MODAL -->
        <Rock:ModalDialog ID="mdlNewFamily" runat="server" Content-DefaultButton="lbSaveFamily">
            <Content>
                <div class="soft-quarter-ends">
                    <!-- Modal Header -->
                    <div class="row checkin-header">
                        <div class="col-xs-3 checkin-actions">
                            <Rock:BootstrapButton ID="lbCloseFamily" runat="server" Text="Cancel" CssClass="btn btn-lg btn-primary" OnClick="lbCloseFamily_Click" EnableViewState="false" />
                        </div>

                        <div class="col-xs-6 text-center">
                            <h2>New Family</h2>
                        </div>

                        <div class="col-xs-3 checkin-actions text-right">
                            <Rock:BootstrapButton ID="lbSaveFamily" CssClass="btn btn-lg btn-primary" runat="server" Text="Save" OnClick="lbSaveFamily_Click" ValidationGroup="Family" CausesValidation="true" />
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="checkin-body">
                        <asp:ListView ID="lvNewFamily" runat="server" OnPagePropertiesChanging="lvNewFamily_PagePropertiesChanging" OnItemDataBound="lvNewFamily_ItemDataBound">
                            <LayoutTemplate>
                                <%--                                <div class="row large-font">--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>First Name</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>Last Name</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>Date of Birth</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>Gender</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label id="famAbilityGrade" runat="server">Ability/Grade</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>Cell</label>--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
                                <%--                                <div class="row large-font">--%>
                                <%--                                    <div class="col-xs-4">--%>
                                <%--                                        <label>Cell Number</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-2">--%>
                                <%--                                        <label>Allergies</label>--%>
                                <%--                                    </div>--%>
                                <%--                                    <div class="col-xs-4">--%>
                                <%--                                        <label>Notes</label>--%>
                                <%--                                    </div>--%>
                                <%--                                </div>--%>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </LayoutTemplate>
                            <ItemTemplate>
                                <div class="row margin-b-sm">
                                    <asp:HiddenField ID="hfFamilyPhotoId" runat="server" />
                                    <div class="col-xs-2">
                                        <Rock:RockTextBox ID="tbFirstName" runat="server" Placeholder="First Name" Text='<%# ((SerializedPerson)Container.DataItem).FirstName %>' ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-2">
                                        <Rock:RockTextBox ID="tbLastName" runat="server" Placeholder="Last Name" Text='<%# ((SerializedPerson)Container.DataItem).LastName %>' ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-2">
                                        <Rock:DatePicker ID="dpBirthDate" runat="server" Placeholder="Date of Birth" SelectedDate='<%# ((SerializedPerson)Container.DataItem).BirthDate %>' ValidationGroup="Family" CssClass="date-picker" data-show-age="true" />
                                    </div>
                                    <div class="col-xs-2">
                                        <Rock:RockDropDownList ID="ddlGender" Placeholder="Gender" runat="server" ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-4">
                                        <Rock:RockDropDownList ID="ddlAbilityGrade" runat="server" />
                                    </div>
                               </div>
                                <div class="row margin-b-md">
                                    <div class="col-xs-3">
                                        <Rock:PhoneNumberBox ID="pnPhoneNumber" Placeholder="Cell" runat="server" ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-3">
                                        <Rock:RockTextBox ID="tbAllergies" Placeholder="Allergies" runat="server" ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-3">
                                        <Rock:RockTextBox ID="tbNotes" Placeholder="Notes" runat="server" ValidationGroup="Family" />
                                    </div>
                                    <div class="col-xs-3">
                                        <Rock:BootstrapButton ID="btnFamilyTakePhoto" runat="server" Text="Take Photo" CssClass="btn btn-primary" OnClick="btnFamilyTakePhoto_Click" EnableViewState="false"> <i class="fa fa-camera"></i> </Rock:BootstrapButton>

                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                        <div class="row">
                            <div class="col-xs-offset-9 col-xs-3 text-right">
                                <asp:DataPager ID="dpNewFamily" runat="server" PageSize="4" PagedControlID="lvNewFamily">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-lg btn-primary btn-checkin-select" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </div>
                    </div>
                </div>
            </Content>
        </Rock:ModalDialog>

        <!-- TAKE PHOTO MODAL -->
        <Rock:ModalDialog ID="mdlPhoto" runat="server">
            <Content>
                <div class="soft-quarter-ends">
                    <!-- Modal Header -->
                    <div class="row checkin-header">
                        <div class="checkin-actions">
                            <div class="col-xs-3">
                                <Rock:BootstrapButton ID="btnCancel" runat="server" CssClass="btn btn-lg btn-primary" OnClick="btnCancel_Click" Text="Cancel" EnableViewState="false" />
                            </div>

                            <div class="col-xs-6">
                                <h2 class="text-center">Take Photo</h2>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <div class="checkin-body">
                        <asp:HiddenField ID="hfSourceModal" runat="server" />
                        <asp:HiddenField ID="hfPersonRowNumber" runat="server" />
                        <asp:TextBox ID="tbPhotoId" runat="server" Style="display: none;" />
                        <asp:Button runat="server" ID="btnPhotoId" Style="display: none;" OnClick="btnPhotoId_Click" />
                        <center>
                        <div id="video_box">
                            <video id="video" width="425" height="425" autoplay>Your browser does not support this streaming content.</video>
                        </div>
                        <canvas id="canvas" width="425" height="425" style="display: none"></canvas>
                        </center>
                        <div id="uploadProgress" class="progress" style="display: none">
                            <div class="progress-bar progress-bar-striped active" style="width: 100%;"></div>
                        </div>
                        <div id="photoUploadMessage" class="alert alert-success" style="display: none; width: 80%;"></div>

                        <div class="well" id="wellDiv">
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <asp:Button runat="server" ID="btnStart" Text="Start" class="btn btn-primary btn-lg" OnClientClick="return false;" UseSubmitBehavior="false" CausesValidation="false" />
                                    <asp:Button runat="server" ID="btnPhoto" Text="Take photo" class="btn btn-success btn-lg" Style="display: none;" OnClientClick="return false;" UseSubmitBehavior="false" CausesValidation="false" />
                                    <asp:Button runat="server" ID="btnRedo" Text="Re-do" class="btn btn-default btn-lg" Style="display: none;" OnClientClick="return false;" UseSubmitBehavior="false" CausesValidation="false" />
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <asp:Button runat="server" ID="btnUpload" Text="Upload" class="btn btn-warning btn-lg" Style="display: none;" OnClientClick="return false;" UseSubmitBehavior="false" CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </Content>
        </Rock:ModalDialog>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">

    function toggleFamily(element) {
        $(element).toggleClass('active');
        $(element).siblings('.family').removeClass('active');
    }

    function togglePerson(element) {
        $(element).toggleClass('active').blur();
        var selectedIds = $("input[id$='hfPersonIds']").val();
        var personId = element.getAttribute('data-id');
        if (selectedIds.indexOf(personId) >= 0) { // already selected, remove id
            var selectedIdRegex = new RegExp(personId + ',*', "g");
            $("input[id$='hfPersonIds']").val(selectedIds.replace(selectedIdRegex, ''));
        } else { // newly selected, add id
            $("input[id$='hfPersonIds']").val(personId + ',' + selectedIds);
        }
    }

    var setModalEvents = function () {

        // begin standard modal input functions
        var setFocus = function () {
            $('.btn').blur();
            $('input[type=text]').first().focus();
        };

        var calculateAge = function (birthday) {
            var ageDifMs = Date.now() - birthday.getTime();
            var ageDate = new Date(ageDifMs);
            return ageDate.getUTCFullYear() - 1970;
        };

        var _previousDOB = '';
        var showAgeOnBirthdatePicker = function () {
            $('body').on('change', '[data-show-age=true]', function () {
                var input = $(this);
                var newVal = input.val();

                if (_previousDOB !== newVal) {
                    _previousDOB = newVal;

                    if (newVal === '') {
                        input.next("span").find("i").text('').addClass("fa-calendar");
                        return;
                    }

                    var birthDate = new Date(newVal);
                    var age = calculateAge(birthDate);

                    var iTag = input.next("span").find("i");
                    iTag.text(age).removeClass("fa-calendar");

                    if (age < 0) {
                        iTag.css('color', '#f00');
                    }
                    else {
                        iTag.css('color', 'inherit');
                    }
                }
            });
        };
        // end standardized modal input functions
    };

    $(document).ready(function () {
        setModalEvents();

        var constraints = {
            video: {
                mandatory: {
                    maxWidth: 425,
                    maxHeight: 425,
                    minWidth: 425,
                    minHeight: 425
                }
            }
        };

        function getAndStartVideo(constraints)
        {
            var video = document.getElementById("video");
            navigator.mediaDevices.getUserMedia(constraints).then((stream) =>
            {
                video.srcObject = stream;
            });
        }

        function stopVideo()
        {
            var video = document.getElementById("video");

            video.srcObject.getVideoTracks().forEach(track => track.stop());
            $('canvas[id$="canvas"]').fadeOut("slow");
            $('#video_box').fadeOut("slow");
            $('input[id$="btnStop"]').hide();
            $('input[id$="btnStart"]').show();
            $('input[id$="btnPhoto"]').hide();
            $('input[id$="btnRedo"]').hide();
            $('input[id$="btnUpload"]').hide().attr('disabled', 'disabled');
        }

        $(document).on("click", 'input[id$="btnStart"]', function ()
        {

            $('input[id$="btnPhoto"]').removeAttr('disabled');
            $('input[id$="btnStart"]').hide();
            $('input[id$="btnStop"]').show();
            $('input[id$="btnPhoto"]').show();
            $('canvas[id$="canvas"]').hide();
            $('#video_box').fadeIn('fast');

            var localMediaStream;
            getAndStartVideo(constraints);

        });

        $(document).on("click", 'input[id$="btnPhoto"]', function ()
        {
            var canvas = document.getElementById("canvas");
            var context = canvas.getContext("2d");

            context.drawImage(video, 0, 0, 425, 425);
            $('#video_box').hide();
            $('canvas[id$="canvas"]').fadeIn();
            $('input[id$="btnPhoto"]').hide();
            $('input[id$="btnUpload"]').show().removeAttr('disabled');
            $('input[id$="btnRedo"]').show();
            $('#photoUploadMessage').hide();
            // Stop all video streams.

            video.srcObject.getVideoTracks().forEach(track => track.stop());
        });

        $(document).on("click", 'input[id$="btnRedo"]', function ()
        {
            $('canvas[id$="canvas"]').hide();
            $('#video_box').show();
            $('input[id$="btnRedo"]').hide();
            $('input[id$="btnPhoto"]').show().removeAttr('disabled');
            $('input[id$="btnUpload"]').attr('disabled', 'disabled');
            $('#photoUploadMessage').hide();
            getAndStartVideo(constraints);
        });

        $(document).on("click", 'input[id$="btnCancel"]', function ()
        {
            stopVideo();
        });

        $(document).on("click", 'input[id$="btnUpload"]', function ()
        {
            // This png often errors out trying to parse base64 on the server.
            //var dataUrl = canvas.toDataURL("png");
            var canvas = document.getElementById("canvas")
            var dataUrl = canvas.toDataURL("image/jpeg", 0.95);

            $('#uploadProgress').fadeIn('fast');
            var data = {
                img64: dataUrl
            }

            // post the photo image to the server for the selected person.
            var request = $.ajax({
                type: "POST",
                url: '<%=ResolveUrl("~/api/ProfilePicture/AddPhoto") %>',
                data: JSON.stringify(dataUrl),
                contentType: "application/json",
                dataType: "json",
                success: function (result)
                {
                    var photoId = result;
                    $('#uploadProgress').hide();
                    $('#photoUploadMessage').removeClass('alert-error').addClass('alert-success').html('<i class="icon-ok"></i> Success');
                    $('#photoUploadMessage').fadeIn('fast').delay(9000).fadeOut('slow');
                    $('input[id$="btnUpload"]').attr('disabled', 'disabled');
                    stopVideo();

                    $('input[id$="tbPhotoId"]').val(photoId);

                    $('input[id$="btnPhotoId"]').click();
                    return true;
                },
                error: function (req, status, err)
                {
                    $('#uploadProgress').fadeOut('fast');
                    console.log("something went wrong: " + status + " error " + err);
                    $('#photoUploadMessage').removeClass('alert-success').addClass('alert-error').html(err).fadeIn('fast');
                    return false;
                }
            });
        });
    });

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(setModalEvents);
</script>
