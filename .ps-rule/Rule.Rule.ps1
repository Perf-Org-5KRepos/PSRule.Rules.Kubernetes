# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Synopsis: Use short rule names
Rule 'Rule.Name' -Type 'PSRule.Rules.Rule' {
    Recommend 'Rule name should be less than 35 characters to prevent being truncated.'
    Reason "The rule name is too long."
    $TargetObject.RuleName.Length -le 35
    $TargetObject.RuleName.StartsWith('Kubernetes.')
}

# Synopsis: Complete help documentation
Rule 'Rule.Help' -Type 'PSRule.Rules.Rule' {
    $Assert.HasFieldValue($TargetObject, 'Info.Synopsis')
    $Assert.HasFieldValue($TargetObject, 'Info.Description')
    $Assert.HasFieldValue($TargetObject, 'Info.Recommendation')
}

# Synopsis: Rules must flag if the Kubernetes feature is core or AKS
Rule 'Rule.Tags' -Type 'PSRule.Rules.Rule' {
    Recommend 'Add a group tag to the rule.'
    $TargetObject.Tag.ToHashtable() | Within 'group' 'core', 'AKS' -CaseSensitive
}

# Synopsis: Use severity and category annotations
Rule 'Rule.Annotations' -Type 'PSRule.Rules.Rule' {
    $Assert.HasFieldValue($TargetObject, 'Info.Annotations.severity')
    $Assert.HasFieldValue($TargetObject, 'Info.Annotations.category')
}

# Synopsis: Use online help
Rule 'Rule.OnlineHelp' -Type 'PSRule.Rules.Rule' {
    $Assert.HasFieldValue($TargetObject, 'Info.Annotations.''online version''')
}
