@isTest(SeeAllData=true)
private class AccountOperationHoursHelperTest {
    static testMethod void myUnitTest() {
        AccountOperationHoursHelper.testMode = true;
        DateTime dt = null;
        dt = System.now();
        string accountId = '58';
        Account acc = [Select Id,Name,ShippingPostalCode,GMTOffset__c,IsDSTObserved__c  From Account Where RecordTypeId = :AccountUtils.BUYER_ACCOUNT_RECORDTYPEID LIMIT 1];
        AccountOperationHoursHelper.getSepcifiedBusinessDayAccountWorkingDateTime(acc, 2);
        AccountOperationHoursHelper.getAccountCurrentWorkingDateTimeInGMT(acc);
        AccountOperationHoursHelper.getSepcificBusinessDayBasedOnGivenDateTime(acc,dt,4);
    }
}