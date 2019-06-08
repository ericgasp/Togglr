<h1>Togglr</h1>
<h4>A Salesforce Feature Toggle Framework</h4>
<div>
    <a href="https://githubsfdeploy.herokuapp.com">
      <img alt="Deploy to Salesforce"
           src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
    </a>
</div>
<h5>Abstract</h5>
<div>
    You can utilize the custom metadata object FeatureToggle__mdt to set for:
    <ul>
        <li>On/Off Feature Toggles
        <li>Scheduled activation
        <li>Scheduled deactivation
    </ul>
</div>
<h5>How</h5>
<div>
    <ol>
        <li>Create a FeatureToggle__mdt record with the active checkbox checked.
        <li>If you want an activation to occur in the future, set the Activation Date Time field.
        <li>If you want to set a deactivation point (e.g. limited time offers), set the Deactivation Date Time field.
        <li>In your Apex code, reference `FeatureToggleService.isFeatureActive(featureLabel)` to determine if the feature should be active.
    </ol>
    
    Note: If you reference a Feature Toggle record label that does not exist it will assume the feature is active.
</div>