/**
 * @description Test Helpers for Togglr's Feature Toggles.
 */
@isTest
public with sharing class FeatureToggleTestHelper {
    public static FeatureToggle__mdt getActiveFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Togglr Active Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }

    public static FeatureToggle__mdt getActivationFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Togglr Activation Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }

    public static FeatureToggle__mdt getInactiveFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Togglr Deactivation Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }

    public static FeatureToggle__mdt getProductionActiveFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Production Togglr Active Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }

    public static FeatureToggle__mdt getProductionActivationFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Production Togglr Activation Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }

    public static FeatureToggle__mdt getProductionInactiveFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                ActivationDateTime__c,
                Active__c,
                DeactivationDateTime__c,
                DeveloperName,
                Id,
                Label,
                OrgDefinition__r.OrgId__c
        FROM FeatureToggle__mdt
        WHERE Label = 'Production Togglr Deactivation Test Record'
        LIMIT 1];
        return featureToggleRecord;
    }
}