trigger AccountTrigger on Account (before insert, before update) {
    Map<String, String> accountSettingMap = new Map<String, String>();
    for (Account_Type_Setting__mdt setting : Account_Type_Setting__mdt.getAll().values()) {
        accountSettingMap.put(setting.Account_Source__c, setting.Account_Type__c);
    }
    
    for (Account a : Trigger.new) {
        a.Type = accountSettingMap.get(a.AccountSource) ?? 'Other';
    }
}