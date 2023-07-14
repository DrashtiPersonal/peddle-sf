/**
* 
* Name: OpenCaseCountActionTest
* Created By: BigSolve
* Description: Test Class for OpenCaseCountAction.
* 
**/

@isTest(SeeAllData=true)
private class OpenCaseCountActionTest {
    
    // Method to Test OpenCaseCountAction
    @isTest static void testOpenCaseCountAction() {
        
        Map<ID,Opportunity> offers = new Map<ID,Opportunity>([SELECT Id FROM Opportunity WHERE CreatedDate = LAST_N_DAYS:365 LIMIT 200]);
        List<Id> offerIds = new List<Id>(offers.keySet());
        
        Test.startTest();
            //OpenCaseCountAction.countOpenCases(offerIds);
        Test.stopTest();
        
    }
    
}