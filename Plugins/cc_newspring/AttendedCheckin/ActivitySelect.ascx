<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ActivitySelect.ascx.cs" Inherits="RockWeb.Plugins.cc_newspring.AttendedCheckin.ActivitySelect" %>

<asp:UpdatePanel ID="pnlContent" runat="server" UpdateMode="Conditional">
    <ContentTemplate>

        <asp:HiddenField ID="hfAllergyAttributeId" runat="server" />

        <asp:Panel ID="pnlActivities" runat="server" CssClass="attended">

            <Rock:ModalAlert ID="maWarning" runat="server" />

            <div class="row checkin-header">
                <div class="col-xs-3 checkin-actions">
                    <Rock:BootstrapButton ID="lbBack" CssClass="btn btn-primary btn-lg" runat="server" OnClick="lbBack_Click" EnableViewState="false">
                    <span class="fa fa-arrow-left"></span>
                    </Rock:BootstrapButton>
                </div>

                <div class="col-xs-6 text-center">
                    <h1>
                        <asp:Literal ID="lblPersonName" runat="server" /></h1>
                </div>

                <div class="col-xs-3 checkin-actions text-right">
                    <Rock:BootstrapButton ID="lbNext" CssClass="btn btn-primary btn-lg" runat="server" OnClick="lbNext_Click" EnableViewState="false">
                     <span class="fa fa-arrow-right"></span>
                    </Rock:BootstrapButton>
                </div>
            </div>

            <div class="row checkin-body">
                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlGroupTypes" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 class="text-center">Checkin Type(s)</h3>
                            <asp:ListView ID="lvGroupType" runat="server" OnItemCommand="lvGroupType_ItemCommand" OnPagePropertiesChanging="lvGroupType_PagePropertiesChanging" OnItemDataBound="lvGroupType_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbGroupType" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" CausesValidation="false" />
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpGroupType" runat="server" PageSize="5" PagedControlID="lvGroupType">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlLocations" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 id="hdrLocations" runat="server" class="text-center">Location</h3>
                            <asp:ListView ID="lvLocation" runat="server" OnPagePropertiesChanging="lvLocation_PagePropertiesChanging" OnItemCommand="lvLocation_ItemCommand" OnItemDataBound="lvLocation_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbLocation" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:ListView>
                            <asp:DataPager ID="dpLocation" runat="server" PageSize="5" PagedControlID="lvLocation">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="pagination btn btn-primary btn-checkin-select" />
                                </Fields>
                            </asp:DataPager>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3">
                    <asp:UpdatePanel ID="pnlSchedules" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <h3 class="text-center">Schedule</h3>
                            <asp:Repeater ID="rSchedule" runat="server" OnItemCommand="rSchedule_ItemCommand" OnItemDataBound="rSchedule_ItemDataBound">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSchedule" runat="server" CssClass="btn btn-primary btn-lg btn-block btn-checkin-select" CausesValidation="false" />
                                </ItemTemplate>
                            </asp:Repeater>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div class="col-xs-3 selected-grid">
                    <h3 class="text-center">Selected</h3>
                    <asp:UpdatePanel ID="pnlSelected" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="grid">
                                <Rock:Grid ID="gSelectedGrid" runat="server" ShowHeader="false" ShowFooter="false" EnableResponsiveTable="true" DisplayType="Light"
                                    DataKeyNames="GroupId, LocationId, ScheduleId" EmptyDataText="No Locations Selected">
                                    <Columns>
                                        <asp:BoundField ItemStyle-CssClass="col-xs-3" DataField="Schedule" />
                                        <asp:BoundField ItemStyle-CssClass="col-xs-8" DataField="Location" />
                                        <Rock:DeleteField ItemStyle-CssClass="col-xs-1" ControlStyle-CssClass="btn btn-lg accent-bold-color accent-bold-color-bordered" OnClick="gSelectedGrid_Delete" />
                                    </Columns>
                                </Rock:Grid>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="">
                        <asp:LinkButton ID="lbEditInfo" runat="server" Text="Edit Info" CssClass="btn btn-primary btn-block btn-checkin-select" OnClick="lbEditInfo_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- EDIT INFO MODAL -->
        <Rock:ModalDialog ID="mdlInfo" runat="server" Content-DefaultButton="lbSaveEditInfo">
            <Content>
                <div class="soft-quarter-ends">
                    <div class="row checkin-header">
                        <div class="col-xs-3 checkin-actions">
                            <Rock:BootstrapButton ID="lbCloseEditInfo" runat="server" CssClass="btn btn-lg btn-primary"
                                OnClick="lbCloseEditInfo_Click" Text="Cancel" EnableViewState="false" />
                        </div>

                        <div class="col-xs-6 text-center">
                            <h2>Edit Info</h2>
                        </div>

                        <div class="col-xs-3 checkin-actions text-right">
                            <Rock:BootstrapButton ID="lbSaveEditInfo" ValidationGroup="Person" CausesValidation="true" CssClass="btn btn-lg btn-primary" runat="server"
                                OnClick="lbSaveEditInfo_Click" Text="Save" EnableViewState="false" />
                        </div>
                    </div>

                    <div class="checkin-body">
                        <div class="row">
                            <asp:HiddenField ID="hfPersonPhotoId" runat="server" />
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbFirstName" runat="server" Label="First Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbNickname" runat="server" ValidationGroup="Person" Label="Nickname" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockTextBox ID="tbLastName" runat="server" Label="Last Name" ValidationGroup="Person" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:DatePicker ID="dpDOB" runat="server" Label="Date of Birth" ValidationGroup="Person" CssClass="date-picker" data-show-age="true" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:RockDropDownList ID="ddlAbilityGrade" runat="server" Label="Ability/Grade" />
                            </div>
                            <div class="col-xs-2">
                                <Rock:PhoneNumberBox ID="pnPhoneNumber" runat="server" CssClass="col-xs-12" Label="Cell" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4">
                                <Rock:RockTextBox ID="tbNoteText" runat="server" Label="Notes" MaxLength="40" Help="Note(s) about this person." />
                            </div>
                            <div class="col-xs-4">
                                <asp:PlaceHolder ID="phAttributes" runat="server" EnableViewState="false"></asp:PlaceHolder>
                            </div>
                            <div class="col-xs-4">
                                <p style="font-size: large"><b>Photo</b></p>
                                <Rock:BootstrapButton ID="btnTakePhoto" runat="server" Text="Take Photo" CssClass="btn btn-primary" OnClick="btnTakePhoto_Click" EnableViewState="false"> <i class="fa fa-camera"></i> </Rock:BootstrapButton>
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
                        <asp:HiddenField ID="hfPhotoId" runat="server" />
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

    var setClickEvents = function () {

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
        setClickEvents();

        
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

                    $('<%= hfPhotoId.ClientID %>').val(photoId);
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

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(setClickEvents);
</script>
