package meet

import data.utils
import future.keywords

LogEvents := utils.GetEvents("meet_logs")

##############
# GWS.MEET.1 #
##############

#
# Baseline GWS.MEET.1.1v0.3
#--
GetFriendlyValue1_1(Value) := "all users (including users not signed in with a Google account)" if {
    Value == "ALL"
} else := Value

NonCompliantOUs1_1 contains {
    "Name": OU,
    "Value": concat(" ", [
        "Who can join meetings is set to",
        GetFriendlyValue1_1(LastEvent.NewValue)
    ])
}
if {
    some OU in utils.OUsWithEvents
    Events := utils.FilterEventsOU(LogEvents, "SafetyDomainLockProto users_allowed_to_join", OU)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

NonCompliantGroups1_1 contains {
    "Name": Group,
    "Value": concat(" ", [
        "Who can join meetings is set to",
        GetFriendlyValue1_1(LastEvent.NewValue)
    ])
}
if {
    some Group in utils.GroupsWithEvents
    SettingName := "SafetyDomainLockProto users_allowed_to_join"
    Events := utils.FilterEventsGroup(LogEvents, SettingName, Group)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

tests contains {
    "PolicyId": "GWS.MEET.1.1v0.3",
    "Criticality": "Should",
    "ReportDetails": utils.NoSuchEventDetails(DefaultSafe, utils.TopLevelOU),
    "ActualValue": "No relevant event for the top-level OU in the current logs",
    "RequirementMet": DefaultSafe,
    "NoSuchEvent": true
}
if {
    DefaultSafe := false
    Events := utils.FilterEventsOU(LogEvents, "SafetyDomainLockProto users_allowed_to_join", utils.TopLevelOU)
    count(Events) == 0
}

tests contains {
    "PolicyId": "GWS.MEET.1.1v0.3",
    "Criticality": "Should",
    "ReportDetails": utils.ReportDetails(NonCompliantOUs1_1, NonCompliantGroups1_1),
    "ActualValue": {"NonCompliantOUs": NonCompliantOUs1_1, "NonCompliantGroups": NonCompliantGroups1_1},
    "RequirementMet": Status,
    "NoSuchEvent": false
}
if {
    Events := utils.FilterEventsOU(LogEvents, "SafetyDomainLockProto users_allowed_to_join", utils.TopLevelOU)
    count(Events) > 0
    Conditions := {count(NonCompliantOUs1_1) == 0, count(NonCompliantGroups1_1) == 0}
    Status := (false in Conditions) == false
}
#--

##############
# GWS.MEET.2 #
##############

#
# Baseline GWS.MEET.2.1v0.3
#--
GetFriendlyValue2_1(Value) := "any meetings, including meetings created with personal accounts" if {
    Value == "ALL"
} else := Value

NonCompliantOUs2_1 contains {
    "Name": OU,
    "Value": concat(" ", [
        "What meetings can org users join is set to",
        GetFriendlyValue2_1(LastEvent.NewValue)
    ])
}
if {
    some OU in utils.OUsWithEvents
    Events := utils.FilterEventsOU(LogEvents, "SafetyAccessLockProto meetings_allowed_to_join", OU)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

NonCompliantGroups2_1 contains {
    "Name": Group,
    "Value": concat(" ", [
        "What meetings can org users join is set to",
        GetFriendlyValue2_1(LastEvent.NewValue)
    ])
}
if {
    some Group in utils.GroupsWithEvents
    SettingName := "SafetyAccessLockProto meetings_allowed_to_join"
    Events := utils.FilterEventsGroup(LogEvents, SettingName, Group)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

tests contains {
    "PolicyId": "GWS.MEET.2.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.NoSuchEventDetails(DefaultSafe, utils.TopLevelOU),
    "ActualValue": "No relevant event in the current logs",
    "RequirementMet": DefaultSafe,
    "NoSuchEvent": true
}
if {
    DefaultSafe := false
    Events := utils.FilterEventsOU(LogEvents, "SafetyAccessLockProto meetings_allowed_to_join", utils.TopLevelOU)
    count(Events) == 0
}

tests contains {
    "PolicyId": "GWS.MEET.2.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.ReportDetails(NonCompliantOUs2_1, NonCompliantGroups2_1),
    "ActualValue": {"NonCompliantOUs": NonCompliantOUs2_1, "NonCompliantGroups": NonCompliantGroups2_1},
    "RequirementMet": Status,
    "NoSuchEvent": false
}
if {
    Events := utils.FilterEventsOU(LogEvents, "SafetyAccessLockProto meetings_allowed_to_join", utils.TopLevelOU)
    count(Events) > 0
    Conditions := {count(NonCompliantOUs2_1) == 0, count(NonCompliantGroups2_1) == 0}
    Status := (false in Conditions) == false
}
#--

##############
# GWS.MEET.3 #
##############

#
# Baseline GWS.MEET.3.1v0.3
#--
GetFriendlyValue3_1(Value) := "off" if {
    Value == "false"
} else := Value

NonCompliantOUs3_1 contains {
    "Name": OU,
    "Value": concat(" ", [
        "Host management when video calls start is set to",
        GetFriendlyValue3_1(LastEvent.NewValue)
    ])
}
if {
    some OU in utils.OUsWithEvents
    Events := utils.FilterEventsOU(LogEvents, "SafetyModerationLockProto host_management_enabled", OU)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "false"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

NonCompliantGroups3_1 contains {
    "Name": Group,
    "Value": concat(" ", [
        "Host management when video calls start is set to",
        GetFriendlyValue3_1(LastEvent.NewValue)
    ])
}
if {
    some Group in utils.GroupsWithEvents
    SettingName := "SafetyModerationLockProto host_management_enabled"
    Events := utils.FilterEventsGroup(LogEvents, SettingName, Group)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "false"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

tests contains {
        "PolicyId": "GWS.MEET.3.1v0.3",
        "Criticality": "Shall",
        "ReportDetails": utils.NoSuchEventDetails(DefaultSafe, utils.TopLevelOU),
        "ActualValue": "No relevant event in the current logs",
        "RequirementMet": DefaultSafe,
        "NoSuchEvent": true
}
if {
    DefaultSafe := false
    Events := utils.FilterEventsOU(LogEvents, "SafetyModerationLockProto host_management_enabled", utils.TopLevelOU)
    count(Events) == 0
}

tests contains {
    "PolicyId": "GWS.MEET.3.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.ReportDetails(NonCompliantOUs3_1, NonCompliantGroups3_1),
    "ActualValue": {"NonCompliantOUs": NonCompliantOUs3_1, "NonCompliantGroups": NonCompliantGroups3_1},
    "RequirementMet": Status,
    "NoSuchEvent": false
}
if {
    Events := utils.FilterEventsOU(LogEvents, "SafetyModerationLockProto host_management_enabled", utils.TopLevelOU)
    count(Events) > 0
    Conditions := {count(NonCompliantOUs3_1) == 0, count(NonCompliantGroups3_1) == 0}
    Status := (false in Conditions) == false
}
#--

##############
# GWS.MEET.4 #
##############

#
# Baseline GWS.MEET.4.1v0.3
#--
GetFriendlyValue4_1(Value) := "no warning label" if {
    Value == "false"
} else := Value

NonCompliantOUs4_1 contains {
    "Name": OU,
    "Value": concat(" ", [
        "Warning label for external or unidentified meeting participants is set to",
        GetFriendlyValue4_1(LastEvent.NewValue)
    ])
}
if {
    some OU in utils.OUsWithEvents
    SettingName := "Warn for external participants External or unidentified participants in a meeting are given a label"
    Events := utils.FilterEventsOU(LogEvents, SettingName, OU)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "false"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

NonCompliantGroups4_1 contains {
    "Name": Group,
    "Value": concat(" ", [
        "Warning label for external or unidentified meeting participants is set to",
        GetFriendlyValue4_1(LastEvent.NewValue)
    ])
}
if {
    some Group in utils.GroupsWithEvents
    SettingName := "Warn for external participants External or unidentified participants in a meeting are given a label"
    Events := utils.FilterEventsGroup(LogEvents, SettingName, Group)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "false"
    LastEvent.NewValue != "DELETE_APPLICATION_SETTING"
}

tests contains {
    "PolicyId": "GWS.MEET.4.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.NoSuchEventDetails(DefaultSafe, utils.TopLevelOU),
    "ActualValue": "No relevant event in the current logs",
    "RequirementMet": DefaultSafe,
    "NoSuchEvent": true
}
if {
    DefaultSafe := true
    SettingName := "Warn for external participants External or unidentified participants in a meeting are given a label"
    Events := utils.FilterEventsOU(LogEvents, SettingName, utils.TopLevelOU)
    count(Events) == 0
}

tests contains {
    "PolicyId": "GWS.MEET.4.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.ReportDetails(NonCompliantOUs4_1, NonCompliantGroups4_1),
    "ActualValue": {"NonCompliantOUs": NonCompliantOUs4_1, "NonCompliantGroups": NonCompliantGroups4_1},
    "RequirementMet": Status,
    "NoSuchEvent": false
}
if {
    SettingName := "Warn for external participants External or unidentified participants in a meeting are given a label"
    Events := utils.FilterEventsOU(LogEvents, SettingName, utils.TopLevelOU)
    count(Events) > 0
    Conditions := {count(NonCompliantOUs4_1) == 0, count(NonCompliantGroups4_1) == 0}
    Status := (false in Conditions) == false
}
#--

##############
# GWS.MEET.5 #
##############

#
# Baseline GWS.MEET.5.1v0.3
#--
NonCompliantOUs5_1 contains {
    "Name": OU,
    "Value": "Users can receive calls from anyone"
}
if {
    some OU in utils.OUsWithEvents
    SettingName := "Incoming call restrictions Allowed caller type"
    Events := utils.FilterEventsOU(LogEvents, SettingName, OU)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
}

NonCompliantGroups5_1 contains {
    "Name": Group,
    "Value": "Users can receive calls from anyone"
}
if {
    some Group in utils.GroupsWithEvents
    SettingName := "Incoming call restrictions Allowed caller type"
    Events := utils.FilterEventsGroup(LogEvents, SettingName, Group)
    count(Events) > 0
    LastEvent := utils.GetLastEvent(Events)
    LastEvent.NewValue == "ALL"
}

tests contains {
    "PolicyId": "GWS.MEET.5.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.NoSuchEventDetails(DefaultSafe, utils.TopLevelOU),
    "ActualValue": "No relevant event in the current logs",
    "RequirementMet": DefaultSafe,
    "NoSuchEvent": true
}
if {
    DefaultSafe := true
    SettingName := "Incoming call restrictions Allowed caller type"
    Events := utils.FilterEventsOU(LogEvents, SettingName, utils.TopLevelOU)
    count(Events) == 0
}

tests contains {
    "PolicyId": "GWS.MEET.5.1v0.3",
    "Criticality": "Shall",
    "ReportDetails": utils.ReportDetails(NonCompliantOUs5_1, NonCompliantGroups5_1),
    "ActualValue": {"NonCompliantOUs": NonCompliantOUs5_1, "NonCompliantGroups": NonCompliantGroups5_1},
    "RequirementMet": Status,
    "NoSuchEvent": false
}
if {
    SettingName := "Incoming call restrictions Allowed caller type"
    Events := utils.FilterEventsOU(LogEvents, SettingName, utils.TopLevelOU)
    count(Events) > 0
    Conditions := {count(NonCompliantOUs5_1) == 0, count(NonCompliantGroups5_1) == 0}
    Status := (false in Conditions) == false
}
