/**
 * @description Apex wrapper for the OrgDefinition__mdt SObject.
 */
public with sharing class OrgDefinition {
    @testVisible private static final String ORG_DEFINITION_PARAM = 'orgDefinition';

    @testVisible private OrgDefinition__mdt record;

    /**
     * @description Determines if the record is associated with the current org and
     *              returns true if it is, else false.
     */
    @AuraEnabled
    public Boolean IsCurrentOrg {
        get {
            if (this.record != null && !String.isBlank(this.record.OrgId__c)) {
                return (UserInfo.getOrganizationId() == this.record.OrgId__c);
            }
            return false;
        }
    }

    /**
     * @description The label of the stored OrgDefinition__mdt record.
     */
    @AuraEnabled
    public String Label {
        get {
            if (this.record != null && !String.isBlank(this.record.Label)) {
                return this.record.Label;
            }
            return null;
        }
    }

    /**
     * @description Constructor that accepts in a OrgDefinition__mdt record and
     *              stores it in the current instance of the wrapper class.
     * @param orgDefinition The OrgDefinition__mdt record to store and wrap.
     * @throws An ArgumentNullException if orgDefinition is null.
     */
    public OrgDefinition(OrgDefinition__mdt orgDefinition) {
        ArgumentNullException.throwIfNull(orgDefinition, ORG_DEFINITION_PARAM);

        this.record = orgDefinition;
    }
}