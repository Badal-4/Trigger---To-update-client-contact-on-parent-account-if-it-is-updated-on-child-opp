trigger trg3 on Opportunity(after Update,after Insert)
{
    Set<Id> accIds = new Set<Id>();
    
    if(trigger.isAfter && (trigger.isUpdate || trigger.isInsert))
    {
        for(Opportunity op : trigger.new)
        {
            if(op.AccountId != null)
                {
                 accIds.add(op.AccountId);   
                }
        }
    }
    
    Map<Id,Account> accMap = new Map<id,Account>([Select Id,Client_Contact__c from Account where Id IN : accIds]);
    List<Account> accList = new List<Account>();
    
    for(Opportunity opp : trigger.new)
    {
        if(accMap.containsKey(opp.AccountId))
        {
            Account acc = accMap.get(opp.AccountId);
            acc.Client_Contact__c = opp.Client_Contact__c;
            accList.add(acc);
        }
    }
    update accList;
}
