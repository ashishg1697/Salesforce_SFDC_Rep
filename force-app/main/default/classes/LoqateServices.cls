/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-16-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountTriggerService {
    /**
     * Handles logic for Account creation in bulkified manner.
     * @param newAccounts List of newly inserted Account records.
     */
    public static void handleAfterInsert(List<Account> newAccounts) {
        // Example: Set a custom field on all new Accounts
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : newAccounts) {
            // Example logic: Set a flag if Industry is not null
            if (acc.Industry != null) {
                Account updateAcc = new Account(Id = acc.Id);
                updateAcc.Custom_Flag__c = true;
                accountsToUpdate.add(updateAcc);
            }
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}