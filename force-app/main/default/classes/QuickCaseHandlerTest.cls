@isTest(SeeAllData= true)
public class QuickCaseHandlerTest {
    
    @isTest static void testCreateQuickCaseWithLoyaltyQueueId() {        
        List<QuickText> getQuickTextList = QuickCaseHandler.getQuickTextList();
        
        if(getQuickTextList.size() >= 0) {
            //string getQuickCaseTemplateDataList = QuickCaseHandler.getQuickCaseTemplateDataList(getQuickTextList[0].Name);
            map<String,ErrorMessages__c> ServerErrorMessage = QuickCaseHandler.getErrorMessages();
            List < string > getPriorityValues = QuickCaseHandler.getPriorityValues();
            List<User> myList = [SELECT Id, Name FROM User WHERE isActive = true LIMIT 1];
            system.debug('myList--> ' + myList[0].Name);
            string result = QuickCaseHandler.isValidOwnerCheck(myList[0].Name);
        }
    }
    
    @isTest static void testCreateQuickCaseFail() {        
        string getQuickCaseOwnerId = QuickCaseHandler.getQuickCaseTemplateDataList('');
    }
    
    @isTest static void testForAccountForRelatedOffer() {   
        List<Opportunity> offers = [SELECT Id from Opportunity LIMIT 1];
        if(offers.size() > 0) {
            QuickCaseHandler.getAccountIdBasedOnOpportunity(offers[0].Id);
        }
    }
    
    @isTest static void testgetQueues() {   
        List<Group> queues = QuickCaseHandler.getQueues();
    }
    
    @isTest static void testgetTypes() {   
        List<String> types = QuickCaseHandler.getTypeValues();
    }
    
    @isTest static void testgetTypeDependencyMap() {
 		QuickText record = new QuickText();       
        Map<String,List<String>> typeDependencyMap = QuickCaseHandler.getTypeDependencyMap(record,'Case_Record_Type__c','Case_Type__c');
    }
    
    @isTest static void testbumpCase() {   
        QuickCaseHandler.bumpCase('Now');
        QuickCaseHandler.bumpCase('Tomorrow');
    }
    
    @isTest static void testCreateCaseFromQuickCaseForm() {   
        QuickCaseHandler.createCaseFromQuickCaseForm(CaseUtils.LOYALTY_CASE_RECORDTYPEID, 'subject','High','Pick-up',userInfo.getUserId(),null,null,'description',system.now(),true,'Open');
    }
    
}