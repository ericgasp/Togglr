@isTest
private class FeatureToggleServiceTest {
    private static FeatureToggle__mdt getActiveFeatureToggleTestRecord() {
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

    private static FeatureToggle__mdt getDeactiveFeatureToggleTestRecord() {
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

    @isTest
    private static void featureToggles_expectRecordsMatch() {
        List<FeatureToggle__mdt> featureToggleRecords = [SELECT Id FROM FeatureToggle__mdt];

        Test.startTest();
        List<FeatureToggle> featureToggles = FeatureToggleService.FeatureToggles;
        Test.stopTest();

        System.assertEquals(featureToggleRecords.size(), featureToggles.size(),
                'Expected there to be the same amount of feature toggles.');
    }

    @isTest
    private static void getFeatureToggleByLabel_provideActiveFeatureToggle_expectFeatureToggleReturned() {
        FeatureToggle__mdt featureToggleRecord = getActiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        Test.startTest();
        FeatureToggle featureToggle = FeatureToggleService.getFeatureToggleByLabel('Togglr Active Test Record');
        Test.stopTest();

        System.assertEquals(featureToggleRecord.Label, featureToggle.Label, 'Expected the feature toggles to match.');
    }

    @isTest
    private static void getFeatureToggleByLabel_nullFeatureToggle_expectNullReturned() {
        Test.startTest();
        FeatureToggle featureToggle = FeatureToggleService.getFeatureToggleByLabel(
                'A completely guaranteed non-existent record 123.');
        Test.stopTest();

        System.assertEquals(null, featureToggle, 'Expected the feature toggle to be null.');
    }

    @isTest
    private static void isFeatureActive_undocumentedFeatureToggleProvided_expectTrue() {
        Test.startTest();
        Boolean isActive = FeatureToggleService.isFeatureActive('A completely guaranteed non-existent record 123.');
        Test.stopTest();

        System.assert(isActive, 'Expected the feature toggle to be active.');
    }

    @isTest
    private static void isFeatureActive_activeFeatureToggleProvided_expectTrue() {
        FeatureToggle__mdt featureToggleRecord = getActiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        Test.startTest();
        Boolean isActive = FeatureToggleService.isFeatureActive(featureToggleRecord.Label);
        Test.stopTest();

        System.assert(isActive, 'Expected the feature toggle to be active.');
    }

    @isTest
    private static void isFeatureActive_inactiveFeatureToggleProvided_expectFalse() {
        FeatureToggle__mdt featureToggleRecord = getDeactiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        Test.startTest();
        Boolean isActive = FeatureToggleService.isFeatureActive(featureToggleRecord.Label);
        Test.stopTest();

        System.assert(!isActive, 'Expected the feature toggle to be inactive.');
    }
}