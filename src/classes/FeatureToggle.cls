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
            // TODO: Fix the logic that determines if it is active or not based on org definitions
            // TODO: Ideally we will make it so the definition on this record overrides the org -
            // TODO: defintion
            /*
            // Return early if either the record is null or the active flag is false/null.
            if (this.record == null || this.record.Active__c != true) return false;

            // Determine whether the activation and deactivation timeframes have been met.
            Datetime today = System.now();
            Boolean active = true;
            active &= (ActivationDateTime == null) ? true : (today >= ActivationDateTime);
            active &= (DeactivationDateTime == null) ? true : (today <= DeactivationDateTime);

            return active;
            */
            return true;
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
     * @description The ActivationDateTime__c of the stored FeatureToggle__mdt record.
     */
    @AuraEnabled
    public Datetime ActivationDateTime {
        get {
            // TODO: Fix the logic that determines the activation date time, flowing from this record to
            // TODO: the org definition record if this is null.
            /*
            if (this.record != null) {
                return this.record.ActivationDateTime__c;
            }*/
            return null;
        }
    }

    /**
     * @description The ActivationDateTime__c of the stored FeatureToggle__mdt record.
     */
    @AuraEnabled
    public Datetime DeactivationDateTime {
        get {
            // TODO: Fix the logic that determines the de-activation date time, flowing from this record to
            // TODO: the org definition record if this is null.
            /*
            if (this.record != null) {
                return this.record.DeactivationDateTime__c;
            }*/
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
}