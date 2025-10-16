/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-16-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class LoqateService {
    /**
     * Bulkified method to validate addresses using Loqate API.
     * @param addresses List of Address__c records to validate.
     * @return Map of Address Id to validation result.
     */
    public static Map<Id, Boolean> validateAddresses(List<Address__c> addresses) {
        Map<Id, Boolean> results = new Map<Id, Boolean>();
        // Simulate bulk API call (replace with actual callout logic)
        for (Address__c addr : addresses) {
            // Dummy validation: mark as valid if Postal_Code__c is not null
            results.put(addr.Id, String.isNotBlank(addr.Postal_Code__c));
        }
        return results;
    }
}

@isTest
private class LoqateServiceTest {
    @isTest static void testValidateAddressesGovernorLimits() {
        List<Address__c> addresses = new List<Address__c>();
        // Create 200 records to test bulk processing
        for (Integer i = 0; i < 200; i++) {
            addresses.add(new Address__c(
                Name = 'Test Address ' + i,
                Postal_Code__c = (i % 2 == 0) ? '12345' : null
            ));
        }
        insert addresses;

        Test.startTest();
        Map<Id, Boolean> results = LoqateService.validateAddresses(addresses);
        Test.stopTest();

        System.assertEquals(200, results.size());
        Integer validCount = 0;
        for (Boolean isValid : results.values()) {
            if (isValid) validCount++;
        }
        System.assertEquals(100, validCount, 'Half should be valid');
    }
}