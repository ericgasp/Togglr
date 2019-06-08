/**
 * @description Apex wrapper for the FeatureToggle__mdt SObject.
 */
public with sharing class FeatureToggle {
    @testVisible private static final String FEATURE_TOGGLE_PARAM = 'featureToggle';

    @testVisible private FeatureToggle__mdt record;

    /**
     * @description Determines if the record is not null and that the Active__c
     *              field is set to true. Explicitly check for true, as null
     *              does not resolve to false.
     */
    @AuraEnabled
    public Boolean IsActive {
        get {
            // Return early if either the record is null or the active flag is false/null.
            if (this.record == null || this.record.Active__c != true) return false;

            // Determine whether the activation and deactivation time frames have been met.
            Datetime today = System.now();
            Boolean active = true;
            active &= (IsGlobal || IsForCurrentOrg);
            active &= (ActivationDateTime == null) ? true : (today >= ActivationDateTime);
            active &= (DeactivationDateTime == null) ? true : (today <= DeactivationDateTime);

            return active;
        }
    }

    /**
     * @description Returns true if this feature toggle is globally assigned, else false.
     *              Globally assigned refers to the OrgDefinition__c field not being set.
     */
    public Boolean IsGlobal {
        get {
            return !hasOrgDefinition();
        }
    }

    /**
     * @description Returns true if the Org Id is set and it matches the current Org's Id.
     */
    public Boolean IsForCurrentOrg {
        get {
            return (OrgId != null && UserInfo.getOrganizationId().equalsIgnoreCase(OrgId));
        }
    }

    /**
     * @description The label of the stored FeatureToggle__mdt record.
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
     * @description The Org Id defined on the related OrgDefinition__mdt record.
     */
    @AuraEnabled
    public Id OrgId {
        get {
            if (hasOrgDefinition()) {
                return (Id) this.record.OrgDefinition__r.OrgId__c;
            }
            return null;
        }
    }

    /**
     * @description The ActivationDateTime__c of the stored FeatureToggle__mdt record.
     */
    @AuraEnabled
    public Datetime ActivationDateTime {
        get {
            if (this.record != null) {
                return this.record.ActivationDateTime__c;
            }
            return null;
        }
    }

    /**
     * @description The ActivationDateTime__c of the stored FeatureToggle__mdt record.
     */
    @AuraEnabled
    public Datetime DeactivationDateTime {
        get {
            if (this.record != null) {
                return this.record.DeactivationDateTime__c;
            }
            return null;
        }
    }

    /**
     * @description Constructor that accepts in a FeatureToggle__mdt record and
     *              stores it in the current instance of the wrapper class.
     * @param featureToggle The FeatureToggle__mdt record to store and wrap.
     * @throws An ArgumentNullException if featureToggle is null.
     */
    public FeatureToggle(FeatureToggle__mdt featureToggle) {
        ArgumentNullException.throwIfNull(featureToggle, FEATURE_TOGGLE_PARAM);

        this.record = featureToggle;
    }

    private Boolean hasOrgDefinition() {
        return (this.record.OrgDefinition__c != null &&
                this.record.OrgDefinition__r.OrgId__c != null &&
                this.record.OrgDefinition__r.OrgId__c instanceof Id);
    }
}