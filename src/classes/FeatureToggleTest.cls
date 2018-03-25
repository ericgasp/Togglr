@isTest
private class FeatureToggleTest {
    private static FeatureToggle__mdt getActiveFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                                                         ActivationDateTime__c,
                                                         Active__c,
                                                         DeactivationDateTime__c,
                                                         DeveloperName,
                                                         Id,
                                                         Label
                                                    FROM FeatureToggle__mdt
                                                   WHERE Label = 'Togglr Active Test Record'
                                                   LIMIT 1];
        return featureToggleRecord;
    }

    private static FeatureToggle__mdt getActivationFeatureToggleTestRecord() {
        FeatureToggle__mdt featureToggleRecord = [SELECT
                                                         ActivationDateTime__c,
                                                         Active__c,
                                                         DeactivationDateTime__c,
                                                         DeveloperName,
                                                         Id,
                                                         Label
                                                    FROM FeatureToggle__mdt
                                                   WHERE Label = 'Togglr Activation Test Record'
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
                                                         Label
                                                    FROM FeatureToggle__mdt
                                                   WHERE Label = 'Togglr Deactivation Test Record'
                                                   LIMIT 1];
        return featureToggleRecord;
    }

    @isTest
    private static void constructor_nullRecord_expectArgumentNullException() {
        try {
            test.startTest();
            new FeatureToggle(null);

            TestHelper.expectedArgumentNullException();
        } catch (Exception e) {
            TestHelper.assertArgumentNullException(e, FeatureToggle.FEATURE_TOGGLE_PARAM);
        } finally {
            test.stopTest();
        }
    }

    @isTest
    private static void constructor_recordProvided_expectRecordStored() {
        FeatureToggle__mdt featureToggleRecord = getActiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        Test.startTest();
        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);
        Test.stopTest();

        System.assertNotEquals(null, featureToggle.record, 'Expected the FeatureToggle to have a record stored.');
        System.assertEquals(featureToggleRecord, featureToggle.record,
                'Expected the stored record to match the given record.');
    }

    @isTest
    private static void label_expectLabelMatchesRecord() {
        FeatureToggle__mdt featureToggleRecord = getActiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        String featureToggleLabel = featureToggle.Label;
        Test.stopTest();

        System.assertEquals(featureToggleRecord.Label, featureToggleLabel,
                'Expected the feature toggle labels to match.');
    }

    @isTest
    private static void isActive_activeTrue_expectActive() {
        FeatureToggle__mdt featureToggleRecord = getActiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isActive = featureToggle.IsActive;
        Test.stopTest();

        System.assert(isActive, 'Expected the feature toggle to be active.');
    }

    @isTest
    private static void isActive_activationDateExceeded_expectActive() {
        FeatureToggle__mdt featureToggleRecord = getActivationFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isActive = featureToggle.IsActive;
        Test.stopTest();

        System.assert(isActive, 'Expected the feature toggle to be active.');
    }

    @isTest
    private static void isActive_deactivationDateExceeded_expectInactive() {
        FeatureToggle__mdt featureToggleRecord = getDeactiveFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isActive = featureToggle.IsActive;
        Test.stopTest();

        System.assert(!isActive, 'Expected the feature toggle to be inactive.');
    }
}