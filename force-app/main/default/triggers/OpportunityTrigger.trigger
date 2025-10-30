trigger OpportunityTrigger on Opportunity (after update) {
    List<Opportunity> renewalOpps = new List<Opportunity>();
    
    for (Opportunity opp : Trigger.New) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        if (opp.StageName == 'Closed Won' && oldOpp.StageName != opp.StageName) {
            Opportunity clonedOpp = opp.clone(false, false);
            clonedOpp.Type = 'Renewal';
            clonedOpp.StageName = 'Prospecting';
            clonedOpp.Renewed_From_Opportunity__c = opp.Id;
            clonedOpp.CloseDate = clonedOpp.CloseDate.addYears(1);
            renewalOpps.add(clonedOpp);
        }
    }
    
   if (!renewalOpps.isEmpty()) {
       insert renewalOpps;
   }
}