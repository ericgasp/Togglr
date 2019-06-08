/**
 * @description Queries for and registers all feature toggles.
 */
public with sharing class FeatureToggleService {
    /**
     * @description Queries for and caches the FeatureToggle__mdt records.
     */
    public static List<FeatureToggle> FeatureToggles {
        get {
            if (FeatureToggles == null) {
                FeatureToggles = new List<FeatureToggle>();
                List<FeatureToggle__mdt> featureToggleRecords =
                        [SELECT
                                DeveloperName,
                                Id,
                                Label
                           FROM FeatureToggle__mdt];

                for (FeatureToggle__mdt featureToggleRecord : featureToggleRecords) {
                    FeatureToggles.add(new FeatureToggle(featureToggleRecord));
                }
            }
            return FeatureToggles;
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

        for (FeatureToggle featureToggle : FeatureToggles) {
            if (featureToggle.Label == featureToggleLabel) return featureToggle;
        }

        return null;
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

        for (FeatureToggle featureToggle : FeatureToggles) {
            if (featureToggle.Label == featureToggleLabel) {
                return featureToggle.IsActive;
            }
        }

        return true;
    }
}