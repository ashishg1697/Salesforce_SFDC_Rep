/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-16-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class OrderTriggerService {
    /**
     * Handles before insert logic for Order records.
     */
    public static void beforeInsert(List<Order> newOrders) {
        // Example: Set default status if not provided
        for (Order ord : newOrders) {
            if (String.isBlank(ord.Status)) {
                ord.Status = 'Draft';
            }
        }
    }

    /**
     * Handles before update logic for Order records.
     */
    public static void beforeUpdate(List<Order> oldOrders, List<Order> newOrders, Map<Id, Order> oldMap, Map<Id, Order> newMap) {
        // Example: Prevent status change from 'Activated' to any other status
        for (Order ord : newOrders) {
            Order oldOrd = oldMap.get(ord.Id);
            if (oldOrd.Status == 'Activated' && ord.Status != 'Activated') {
                ord.addError('Cannot change status from Activated to another status.');
            }
        }
    }

    /**
     * Handles after insert logic for Order records.
     */
    public static void afterInsert(List<Order> newOrders) {
        // Example: Send notifications or create related records
    }

    /**
     * Handles after update logic for Order records.
     */
    public static void afterUpdate(List<Order> oldOrders, List<Order> newOrders, Map<Id, Order> oldMap, Map<Id, Order> newMap) {
        // Example: Perform actions when status changes to 'Activated'
        List<Order> activatedOrders = new List<Order>();
        for (Order ord : newOrders) {
            Order oldOrd = oldMap.get(ord.Id);
            if (oldOrd.Status != 'Activated' && ord.Status == 'Activated') {
                activatedOrders.add(ord);
            }
        }
        // Further processing for activatedOrders if needed
    }

    /**
     * Handles before delete logic for Order records.
     */
    public static void beforeDelete(List<Order> oldOrders, Map<Id, Order> oldMap) {
        // Example: Prevent deletion of activated orders
        for (Order ord : oldOrders) {
            if (ord.Status == 'Activated') {
                ord.addError('Cannot delete an activated order.');
            }
        }
    }

    /**
     * Handles after delete logic for Order records.
     */
    public static void afterDelete(List<Order> oldOrders, Map<Id, Order> oldMap) {
        // Example: Cleanup related records if needed
    }
}