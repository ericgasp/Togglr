/**
 * @description Queries for and validates all Org Definitions defined in Custom Metadata.
 */
public with sharing class OrgDefinitionService {
    /**
     * @description Queries for and caches the OrgDefinition__mdt records.
     */
    public static List<OrgDefinition> OrgDefinitions {
        get {
            if (OrgDefinitions == null) {
                OrgDefinitions = new List<OrgDefinition>();
                List<OrgDefinition__mdt> orgDefinitionRecords =
                [SELECT
                        DeveloperName,
                        Id,
                        Label
                FROM OrgDefinition__mdt];

                for (OrgDefinition__mdt orgDefinitionRecord : orgDefinitionRecords) {
                    OrgDefinitions.add(new OrgDefinition(orgDefinitionRecord));
                }
            }
            return OrgDefinitions;
        }
        private set;
    }

    /**
     * @description Retrieve a OrgDefinition associated with the organization that is
     *              currently executing this body of code and return it.
     */
    public static OrgDefinition CurrentOrgDefinition {
        get {
            if (CurrentOrgDefinition != null) {
                return CurrentOrgDefinition;
            }

            for (OrgDefinition orgDefinition : OrgDefinitions) {
                if (orgDefinition.IsCurrentOrg) {
                    CurrentOrgDefinition = orgDefinition;
                    break;
                }
            }

            return CurrentOrgDefinition;
        }
        private set;
    }
}