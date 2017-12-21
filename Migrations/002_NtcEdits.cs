// <copyright>
// Copyright 2013 by the Spark Development Network
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// </copyright>
//

using Rock.Plugin;

namespace cc.newspring.AttendedCheckIn.Migrations
{
    [MigrationNumber( 2, "1.6.10" )]
    public class NtcEdits : Migration
    {
        public string PersonSNAttributeGuid = "8B562561-2F59-4F5F-B7DC-92B2BB7BB7CF";
        public string GroupSNAttributeGuid = "9210EC95-7B85-4D11-A82E-0B677B32704E";
        public string AttendedCheckinSiteGuid = "30FB46F7-4814-4691-852A-04FB56CC07F0";

        /// <summary>
        /// The commands to run to migrate plugin to the specific version
        /// </summary>
        public override void Up()
        {
            // Workflow Update
            RockMigrationHelper.UpdateEntityType( "Rock.Workflow.Action.CheckIn.LoadGroupsIgnoringCheckinRule", "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", false, true );
            RockMigrationHelper.UpdateWorkflowActionEntityAttribute( "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", "18E29E23-B43B-4CF7-AE41-C85672C09F50", "Group Type To Ignore Checkin Rules For", "IgnoredGroupType", "", 0, @"2C42B2D4-1C5F-4AD5-A9AD-08631B872AC4", "16F845B5-3F53-473D-8F1E-7BBEE5274D4D" ); // Rock.Workflow.Action.CheckIn.LoadGroupsIgnoringCheckinRule:Group Type To Ignore Checkin Rules For
            RockMigrationHelper.UpdateWorkflowActionEntityAttribute( "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", "1EDAFDED-DFE6-4334-B019-6EECBA89E05A", "Active", "Active", "Should Service be used?", 0, @"False", "19508A9C-BD7C-4B7E-B843-3CD46070482F" ); // Rock.Workflow.Action.CheckIn.LoadGroupsIgnoringCheckinRule:Active
            RockMigrationHelper.UpdateWorkflowActionEntityAttribute( "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", "1EDAFDED-DFE6-4334-B019-6EECBA89E05A", "Load All", "LoadAll", "By default groups are only loaded for the selected person, group type, and location.  Select this option to load groups for all the loaded people and group types.", 0, @"False", "E4A9B09E-BEE8-4C96-B18D-B46BAC054C7C" ); // Rock.Workflow.Action.CheckIn.LoadGroupsIgnoringCheckinRule:Load All
            RockMigrationHelper.UpdateWorkflowActionEntityAttribute( "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", "A75DFC58-7A1B-4799-BF31-451B2BBE38FF", "Order", "Order", "The order that this service should be used (priority)", 0, @"", "48CD0C88-4D91-4B2D-B117-381C187E133A" ); // Rock.Workflow.Action.CheckIn.LoadGroupsIgnoringCheckinRule:Order
            RockMigrationHelper.UpdateWorkflowActionType( "6D8CC755-0140-439A-B5A3-97D2F7681697", "Load Groups", 3, "E9DC97C8-1F57-4B4E-8CD3-3CF5A764C1EB", true, false, "", "", 1, "", "9DFD5255-CC94-4B88-AE2E-2FC32F35D9D9" ); // Attended Check-in:Person Search:Load Groups
            RockMigrationHelper.AddActionTypeAttributeValue( "9DFD5255-CC94-4B88-AE2E-2FC32F35D9D9", "19508A9C-BD7C-4B7E-B843-3CD46070482F", @"False" ); // Attended Check-in:Person Search:Load Groups:Active
            RockMigrationHelper.AddActionTypeAttributeValue( "9DFD5255-CC94-4B88-AE2E-2FC32F35D9D9", "E4A9B09E-BEE8-4C96-B18D-B46BAC054C7C", @"True" ); // Attended Check-in:Person Search:Load Groups:Load All
            RockMigrationHelper.AddActionTypeAttributeValue( "9DFD5255-CC94-4B88-AE2E-2FC32F35D9D9", "48CD0C88-4D91-4B2D-B117-381C187E133A", @"" ); // Attended Check-in:Person Search:Load Groups:Order
            RockMigrationHelper.AddActionTypeAttributeValue( "9DFD5255-CC94-4B88-AE2E-2FC32F35D9D9", "16F845B5-3F53-473D-8F1E-7BBEE5274D4D", @"2c42b2d4-1c5f-4ad5-a9ad-08631b872ac4" ); // Attended Check-in:Person Search:Load Groups:Group Type To Ignore Checkin Rules For
        }

        /// <summary>
        /// The commands to undo a migration from a specific version
        /// </summary>
        public override void Down()
        {
            
        }
    }
}