/**
 * @description Queries for and registers all feature toggles.
 */
public with sharing class FeatureToggleService {
    /**
     * @description Queries for and caches all of the FeatureToggle__mdt records.
     */
    public static List<FeatureToggle> FeatureToggles {
        get {
            if (FeatureToggles == null) {
                populateToggleProperties();
            }

            return FeatureToggles;
        }
        private set;
    }

    /**
     * @description Queries for and caches all of the FeatureToggle__mdt records
     *              sorted by their label.
     */
    public static Map<String, FeatureToggle> FeatureTogglesByLabel {
        get {
            if (FeatureTogglesByLabel == null) {
                populateToggleProperties();
            }

            return FeatureTogglesByLabel;
        }
        private set;
    }

    /**
     * @description Queries for and caches all of the FeatureToggle__mdt records
     *              for the current org, sorted by their label.
     */
    public static Map<String, FeatureToggle> OrgFeatureTogglesByLabel {
        get {
            if (OrgFeatureTogglesByLabel == null) {
                populateToggleProperties();
            }

            return OrgFeatureTogglesByLabel;
        }
        private set;
    }

    /**
     * @description Queries for and caches all of the FeatureToggle__mdt records
     *              that are global, sorted by their label.
     */
    public static Map<String, FeatureToggle> GlobalFeatureTogglesByLabel {
        get {
            if (GlobalFeatureTogglesByLabel == null) {
                populateToggleProperties();
            }
            return GlobalFeatureTogglesByLabel;
        }
        private set;
    }

    /**
     * @description Retrieve a FeatureToggle by the label associated with it.
     * @param featureToggleLabel The FeatureToggle to retrieve.
     * @return A FeatureToggle wrapper that contains the related mdt record for
     *         the requested Feature Toggle.
     */
    public static FeatureToggle getFeatureToggleByLabel(String featureToggleLabel) {
        // If the requested label is blank, return null
        if (String.isBlank(featureToggleLabel)) return null;

        FeatureToggle featureToggle;

        // Default to using org defined toggles first
        if (OrgFeatureTogglesByLabel.get(featureToggleLabel) != null) {
            featureToggle = OrgFeatureTogglesByLabel.get(featureToggleLabel);
        } else if (GlobalFeatureTogglesByLabel.get(featureToggleLabel) != null) {
            featureToggle = GlobalFeatureTogglesByLabel.get(featureToggleLabel);
        } else if (FeatureTogglesByLabel.get(featureToggleLabel) != null) {
            featureToggle = FeatureTogglesByLabel.get(featureToggleLabel);
        }

        return featureToggle;
    }

    /**
     * @description Determine if a Feature Toggle with the given label is active
     *              or not.
     * @param featureToggleLabel The FeatureToggle to look for and validate
     *        activity.
     * @return True if the feature is active or if the feature toggle is not found.
     *         This means that if there is no record of the feature that it will
     *         always default to on. This ensures that legacy features prior to the
     *         addition of feature toggles will continue to work as expected.
     */
    public static Boolean isFeatureActive(String featureToggleLabel) {
        if (String.isBlank(featureToggleLabel)) return true;

        // Instead of sifting through the collections again here, just use the getter method
        FeatureToggle featureToggle = getFeatureToggleByLabel(featureToggleLabel);
        if (featureToggle != null) {
            return featureToggle.IsActive;
        }

        // If the feature toggle isn't found, just default to true
        return true;
    }

    private static void populateToggleProperties() {
        FeatureToggles = new List<FeatureToggle>();
        FeatureTogglesByLabel = new Map<String, FeatureToggle>();
        GlobalFeatureTogglesByLabel = new Map<String, FeatureToggle>();
        OrgFeatureTogglesByLabel = new Map<String, FeatureToggle>();

        List<FeatureToggle__mdt> featureToggleRecords = [SELECT
                                                                Active__c,
                                                                ActivationDateTime__c,
                                                                DeactivationDateTime__c,
                                                                DeveloperName,
                                                                Id,
                                                                Label,
                                                                OrgDefinition__r.OrgId__c
                                                           FROM FeatureToggle__mdt];

        sortFeatureToggles(featureToggleRecords);
    }

    private static void sortFeatureToggles(List<FeatureToggle__mdt> featureToggleRecords) {
        for (FeatureToggle__mdt featureToggleRecord : featureToggleRecords) {
            FeatureToggle featureToggle = new FeatureToggle(featureToggleRecord);

            // Add it to the FeatureToggles Property
            FeatureToggles.add(featureToggle);
            FeatureTogglesByLabel.put(featureToggle.Label, featureToggle);

            if (featureToggle.IsGlobal) {
                GlobalFeatureTogglesByLabel.put(featureToggle.Label, featureToggle);
            } else if (featureToggle.IsForCurrentOrg) {
                OrgFeatureTogglesByLabel.put(featureToggle.Label, featureToggle);
            }
        }
    }
}