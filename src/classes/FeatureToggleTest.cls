@isTest
private class FeatureToggleTest {
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
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getActiveFeatureToggleTestRecord();

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
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getActiveFeatureToggleTestRecord();

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
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getActiveFeatureToggleTestRecord();

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
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getActivationFeatureToggleTestRecord();

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
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getInactiveFeatureToggleTestRecord();

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

    @isTest
    private static void isGlobal_nullOrgId_expectTrue() {
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getActivationFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isGlobal = featureToggle.IsGlobal;
        Test.stopTest();

        System.assert(isGlobal, 'Expected the feature toggle to be globally assigned.');
    }

    @isTest
    private static void isGlobal_orgIdSet_expectFalse() {
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getProductionActivationFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isGlobal = featureToggle.IsGlobal;
        Test.stopTest();

        System.assert(!isGlobal, 'Expected the feature toggle to be org specific.');
    }

    @isTest
    private static void isForCurrentOrg_orgIdDoesNotMatch_expectFalse() {
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getProductionActivationFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        // To ensure that the Org Id doesn't match, manipulate it
        featureToggleRecord.OrgDefinition__r.OrgId__c = UserInfo.getOrganizationId().substring(0,12) + '000111';

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isForCurrentOrg = featureToggle.IsForCurrentOrg;
        Test.stopTest();

        System.assert(!isForCurrentOrg, 'Expected the feature toggle to not be for the current org.');
    }

    @isTest
    private static void isForCurrentOrg_orgIdMatches_expectTrue() {
        FeatureToggle__mdt featureToggleRecord = FeatureToggleTestHelper.getProductionActivationFeatureToggleTestRecord();

        if (featureToggleRecord == null) {
            System.assert(true, 'An admin in the containing org has deleted the test records. Assert true and exit.');
            return;
        }

        // To ensure that the Org Id matches, manipulate it
        featureToggleRecord.OrgDefinition__r.OrgId__c = UserInfo.getOrganizationId();

        FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

        Test.startTest();
        Boolean isForCurrentOrg = featureToggle.IsForCurrentOrg;
        Test.stopTest();

        System.assert(isForCurrentOrg, 'Expected the feature toggle to be for the current org.');
    }
}