@isTest(SeeAllData=true)
public class AccountTriggerTest {

    static testMethod void myUnitTest1() {
        AccountTriggerHandler.testMode = true;
        Map<String,Constants__c> constants = Constants__c.getAll();
        String systemUserId = constants.get('SystemUserSFID').Text__c;
        List<Account> accList = [Select Id,Rating,OwnerId,Name,Past_Due_Amount__c,NoTitle__c,ParentId,Agreement_Signed_Date__c From Account
                                 Where RecordTypeId = :AccountUtils.BUYER_ACCOUNT_RECORDTYPEID 
                                 AND Stage__c = 'Active' AND Rating = 'High' AND OwnerId != :systemUserId
                                 AND Agreement_Signed_Date__c!= null  AND Parent.ParentId =Null AND ParentId = null LIMIT 1];
        
        try{
        if(accList.size() > 0) {
            AccountTriggerHandler ath = new AccountTriggerHandler();
            ath.getBuyerUserContacts(accList[0]);
            ath.getUser(UserInfo.getUserId());
            ath.autoClosePastDueCase(accList[0]);
            ath.updateAcceptWithoutTitleOfChildBuyers(accList,accList[0]);
            AccountTriggerHandler.setOffestAndDSTObserved(new Set<String>{accList[0].Id},new Set<String>{'10001'});
            List<Account> childAccounts = [Select Id,ParentId From Account 
                                           Where RecordTypeId = :AccountUtils.BUYER_ACCOUNT_RECORDTYPEID AND Stage__c = 'Active' 
                                           AND ParentId != null AND Id != :accList[0].Id AND Primary_User__c != null AND Fee_Tier__c != null  LIMIT 1];
            if(childAccounts.size() > 0) {
                accList[0].ParentId = childAccounts[0].ParentId;
            }
            update accList;
        }
        }catch(Exception ex){ 
            //System.assertEquals('Child buyer can not be a parent of any other buyer account. Code:ACC-065', ex.getMessage());
            Boolean expectedExceptionThrown =  ex.getMessage().contains('Child buyer can not be a parent of any other buyer account. Code:ACC-065') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
        
    }  
    
    static testMethod void testInsertCharityAccount() {
        AccountTriggerHandler.testMode = true;
        Account charityAcct = TestDataFactory.getAccountObject('Franklin Charity', 'In Processing',AccountUtils.CHARITY_ACCOUNT_RECORDTYPEID );
        Database.insert(charityAcct);
    }
    static testMethod void testCloseDateChangeCarrierAccount() {
        try{
        AccountTriggerHandler.testMode = true;
        Account carrierAcct = TestDataFactory.getAccountObject('Franklin Carrier', 'In Processing',AccountUtils.CARRIER_ACCOUNT_RECORDTYPEID );
        insert(carrierAcct);
        Operation_Hours__c  oprtionHr = new Operation_Hours__c(Account__c= carrierAcct.id,FridayCloseTime__c = 'All Hours', FridayOpenTime__c= 'All Hours',
                                                               MondayCloseTime__c= 'All Hours', MondayOpenTime__c= 'All Hours',
                                                               SaturdayCloseTime__c= 'All Hours', SaturdayOpenTime__c= 'All Hours',
                                                               SundayCloseTime__c= 'All Hours', SundayOpenTime__c= 'All Hours', 
                                                               ThursdayCloseTime__c= 'All Hours', ThursdayOpenTime__c= 'All Hours',
                                                               TuesdayCloseTime__c= 'All Hours', TuesdayOpenTime__c= 'All Hours', 
                                                               WednesdayCloseTime__c= 'All Hours', WednesdayOpenTime__c= 'All Hours');
        
        Database.insert(oprtionHr);
        Test.startTest();
        Account updateAcct = new Account();
        updateAcct.id=carrierAcct.id;
        updateAcct.Stage__c='Active';
        updateAcct.Close_Date__c= System.today();
        update updateAcct;
        Test.stopTest();
       }catch(Exception ex){
            Boolean expectedExceptionThrown =  ex.getMessage().contains(System.label.CloseDate_Change_Error) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
       }
    }
    
    static testMethod void testInsertAuctionAccount() {
        AccountTriggerHandler.testMode = true;
        Account parentAuctionAcct = TestDataFactory.getAccountObject('Copart', 'In Processing',AccountUtils.AUCTION_ACCOUNT_RECORDTYPEID );
        parentAuctionAcct.Auction_Yard_Number__c='5566';
        parentAuctionAcct.Fee_Tier__c= null;
        parentAuctionAcct.Alias__c = 'ALS';
        parentAuctionAcct.Type = 'Salvage';
        Database.insert(parentAuctionAcct);
        
        Account childAuctionAcct = TestDataFactory.getAccountObject('Rexo Auction-west', 'In Processing',AccountUtils.AUCTION_ACCOUNT_RECORDTYPEID );
        childAuctionAcct.ParentId=parentAuctionAcct.id;
        childAuctionAcct.Auction_Yard_Number__c='5566';
        childAuctionAcct.VIN_Requirement__c= null;
        Database.insert(childAuctionAcct);
        
    }
    static testMethod void testCharityAccountUpdate() {
        AccountTriggerHandler.testMode = true;
        Account charityAcct = TestDataFactory.getAccountObject('Rexo Auction', 'In Processing',AccountUtils.CHARITY_ACCOUNT_RECORDTYPEID );
        charityAcct.Auction_Yard_Number__c='5566';
        Database.insert(charityAcct);
        
        Contact con = TestDataFactory.getContactObject('Full','Active',ContactUtils.CHARITY_USER_CONTACT_RECORDTYPEID);
        con.AccountId=charityAcct.id;
        Database.insert(con);
        
        charityAcct.Primary_User__c=con.id;
        update charityAcct;
        
        
    }
    static testMethod void testBuyerAccountUpdate() {
        try{  
            AccountTriggerHandler.testMode = true;
            Account buyerAcct = TestDataFactory.getAccountObject('Rexo Auction', 'In Processing',AccountUtils.BUYER_ACCOUNT_RECORDTYPEID );
            Database.insert(buyerAcct);

            Test.startTest();
            buyerAcct.Stage__c='Active';
            buyerAcct.Close_Date__c=System.today();
            buyerAcct.Last_Login__c =System.today();
            Database.update(buyerAcct);
            Test.stopTest();
           }catch(Exception ex){
               Boolean expectedExceptionThrown =  ex.getMessage().contains('Active or Offline accounts must have a Primary User. Code:ACC-091') ? true : false;
               System.AssertEquals(expectedExceptionThrown, true); 
           }
        
    }
    static testMethod void myUnitTest2() {
        AccountTriggerHandler.testMode = true;
        List<Account> publishers = [Select Id From Account Where Status__c = 'Active' AND RecordTypeId = :AccountUtils.PUBLISHER_ACCOUNT_RECORDTYPEID AND ParentId != null AND Primary_User__c != null LIMIT 1];
        if(publishers.size() > 0) {
            update publishers;
        }
    }
    
    static testMethod void myUnitTest3() {
        AccountTriggerHandler.testMode = true;
        List<Account> charity = [Select Id From Account Where Status__c = 'Active' AND RecordTypeId = :AccountUtils.CHARITY_ACCOUNT_RECORDTYPEID LIMIT 1];
        if(charity.size() > 0) {
            update charity;
        }
    }
    
    static testMethod void myUnitTest4() {
        AccountTriggerHandler.testMode = true;
        List<Account> sellers = [Select Id From Account Where Status__c = 'Active' AND RecordTypeId = :AccountUtils.SELLER_ACCOUNT_RECORDTYPEID LIMIT 1];
        if(sellers.size() > 0) {
            update sellers;
        }
    }
    
    static testMethod void myUnitTest5() {
        AccountTriggerHandler.testMode = true;
        List<Account> carriers = [Select Id From Account Where Stage__c = 'Active' AND RecordTypeId = :AccountUtils.CARRIER_ACCOUNT_RECORDTYPEID LIMIT 1];
        if(carriers.size() > 0) {
            update carriers;
        }
    }
    
    static testMethod void myUnitTest6() {
        AccountTriggerHandler.testMode = true;
        Map<String,Constants__c> constants = Constants__c.getAll();
        String systemUserId = constants.get('SystemUserSFID').Text__c;
            account acc = new Account();
            acc.name = 'test ';
            acc.Industry = 'Test';
            acc.Rating = 'High';
            acc.Phone = '(999) 999-9999';
            acc.Email__c= 'abc@def.com';
            acc.Dealer_License__c= 'Test';
            acc.BillingStreet = 'Test';
            acc.BillingState = 'TX';
            acc.BillingPostalCode = '10001';
            acc.BillingCountry = 'USA';
            acc.BillingCity = 'Test';
            acc.ShippingCity = 'Test';
            acc.ShippingCountry = 'USA';
            acc.ShippingPostalCode = '10001';
            acc.ShippingState = 'TX';
            acc.ShippingStreet = 'Test';
            acc.Website = 'www.abc.com';
            acc.Credit_Limit__c= 500;
            //acc.Salutation = 'Test';
            acc.Contact_First_Name__c= 'Test';
            acc.Contact_Last_Name__c= 'Test';
            //acc.PersonTitle = 'Test';
            acc.Description = 'Test';
            acc.Stage__c = 'In processing';
            acc.Closed_Won_by__c = UserInfo.getUserId();
            //acc.PersonMobilePhone = '(999) 999-9999';
            acc.recordtypeid =  AccountUtils.BUYER_ACCOUNT_RECORDTYPEID;
            acc.ownerId = systemUserId;
            acc.Agreement_Signed_Date__c = Date.today();
            insert acc;
       
        
    }
    
}