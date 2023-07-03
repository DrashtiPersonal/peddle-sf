@isTest(SeeAllData = true)
private class EmailMessageTriggerTest {
    
    static testMethod void myUnitTest1() {
        List<Opportunity> oppList = [Select Id,Name From Opportunity LIMIT 1];
        List<Account> accList = [Select Id From Account LIMIT 1];
        Case c = new Case();
        c.Subject = 'Test Subject';
        c.Description = 'Test Description';
        c.Status = 'New';
        c.Reported_by__c = userInfo.getUserId();
        c.Origin = 'Email';
        c.due__c = system.now();
        c.SuppliedEmail = 'arjun.kansagara77@marutitech.com'; 
        insert c;
        
        EmailMessage em6 = new EmailMessage();
        em6.ParentId = c.Id;
        em6.FromAddress = 'vishal.thoriya@swautoinspections.com';
        em6.ToAddress = 'devtitles@gmail.com';
        //em6.Subject = 'RE: Release Problem Notification - Stock#' +oppList[0].Name;
        em6.Subject = 'RE: Release Problem Notification - Stock#';
        em6.Incoming = false;
        //em6.HtmlBody = 'claim '+oppList[0].Name;
        em6.HtmlBody = 'claim ';
        insert em6;
        
        EmailMessage em2 = new EmailMessage();
        em2.ParentId = c.Id;
        em2.FromAddress = 'vishal.thoriya@swautoinspections.com';
        em2.ToAddress = 'kajal.thakkar@marutitech.com';
        //em2.Subject = 'Vehicle Status Change Claim Number:'+oppList[0].Name;
        em2.Subject = 'SWIS ID'+ oppList[0].Name;
        em2.Incoming = false;
        //em2.HtmlBody = 'claim '+oppList[0].Name;
        insert em2 ;
        
        EmailMessage em9 = new EmailMessage();
        em9.ParentId = c.Id;
        em9.FromAddress = 'vishal.thoriya@swautoinspections.com';
        em9.ToAddress = 'devloyalty@gmail.com';
        em9.Subject = 'Vehicle Status Change Claim Number:'+oppList[0].Name;
        em9.Incoming = false;
        em9.HtmlBody = 'claim '+oppList[0].Name;
        insert em9;
        
        EmailMessage em3 = new EmailMessage();
        em3.ParentId = c.Id;
        em3.FromAddress = 'vishal.thoriya@test.com';
        em3.ToAddress = 'loyalty@peddle.com';
        em3.Subject = 'Finance Alert: Invalid Offer Update';
        em3.Incoming = true;
        em3.TextBody = 'Test Claim_Ref##'+oppList[0].Id+'## Account_Ref##'+accList[0].Id+'##';
        insert em3;
        
        EmailMessage em4 = new EmailMessage();
        em4.ParentId = c.Id;
        em4.FromAddress = 'vishal.thoriya@test.com';
        em4.ToAddress = 'loyalty@peddle.com';
        em4.Subject = 'Bid Reduction';
        em4.Incoming = true;
        em4.TextBody = 'Test Claim_Ref##'+oppList[0].Id+'## Account_Ref##'+accList[0].Id+'##';
        insert em4;
        
        EmailMessage em5 = new EmailMessage();
        em5.ParentId = c.Id;
        em5.FromAddress = 'vishal.thoriya@test.com';
        em5.ToAddress = 'loyalty@peddle.com';
        em5.Subject = 'Test';
        em5.Incoming = true;
        em5.TextBody = 'claim number '+oppList[0].Name;
        insert em5;
        
        
        EmailMessage em7 = new EmailMessage();
        em7.ParentId = c.Id;
        em7.FromAddress = 'vishal.thoriya@test.com';
        em7.ToAddress = 'loyalty@peddle.com';
        em7.Subject = 'Test';
        em7.Incoming = true;
        em7.TextBody = 'claim# '+oppList[0].Name;
        insert em7;
        
        EmailMessage em8 = new EmailMessage();
        em8.ParentId = c.Id;
        em8.FromAddress = 'vishal.thoriya@test.com';
        em8.ToAddress = 'loyalty@peddle.com';
        em8.Subject = 'Test';
        em8.Incoming = true;
        em8.TextBody = 'claim '+oppList[0].Name;
        insert em8;
    }
    static testMethod void myUnitTest2() {
        List<Opportunity> oppList = [Select Id,Name From Opportunity LIMIT 1];
        List<Account> accList = [Select Id From Account LIMIT 1];
        Case c = new Case();
        c.Subject = 'Test Subject';
        c.Description = 'Test Description';
        c.Status = 'New';
        c.due__c = system.now();
        c.Reported_by__c = userInfo.getUserId();
        c.Origin = 'Email';
        c.SuppliedEmail = 'arjun.kansagara77@marutitech.com';
        insert c;
        
        EmailMessage em3 = new EmailMessage();
        em3.ParentId = c.Id;
        em3.FromAddress = 'vishal.thoriya@test.com';
        em3.ToAddress = 'loyalty@peddle.com';
        em3.Subject = 'Finance Alert: Invalid Offer Update';
        em3.Incoming = true;
        em3.HtmlBody = 'Test Claim_Ref##'+oppList[0].Id+'## Account_Ref##'+accList[0].Id+'##';
        insert em3;
    }
    
    static testMethod void myUnitTest3() {
        List<Opportunity> oppList = [Select Id,Name From Opportunity LIMIT 1];
        List<Account> accList = [Select Id From Account LIMIT 1];
        
        Case c = new Case();
        c.Subject = 'Test Subject';
        c.Description = 'Test Description';
        c.Status = 'New';
        c.due__c = system.now();
        c.Reported_by__c = userInfo.getUserId();
        c.Origin = 'Email';
        c.SuppliedEmail = 'arjun.kansagara77@marutitech.com';
        insert c;
        
        EmailMessage em8 = new EmailMessage();
        em8.ParentId = c.Id;
        em8.FromAddress = 'vishal.thoriya@test.com';
        em8.ToAddress = 'loyalty@peddle.com';
        em8.Subject = 'Test';
        em8.Incoming = true;
        em8.HtmlBody = 'claim '+oppList[0].Name;
        insert em8;
        
        EmailMessage em9 = new EmailMessage();
        em9.ParentId = c.Id;
        em9.FromAddress = 'vishal.thoriya@swautoinspections.com';
        em9.ToAddress = 'loyalty@peddle.com';
        em9.Subject = 'Claim Number:'+oppList[0].Name;
        em9.Incoming = true;
        em9.HtmlBody = 'claim ';
        insert em9;
        
        EmailMessage em10 = new EmailMessage();
        em10.ParentId = c.Id;
        em10.FromAddress = 'vishal.thoriya@swautoinspections.com';
        em10.ToAddress = 'loyalty@peddle.com';
        em10.Subject = 'SWIS ID: 356795, Claim #:'+oppList[0].Name;
        em10.Incoming = true;
        em10.HtmlBody = 'claim ';
        insert em10;
        
    }
    
    static testMethod void myUnitTest4() {
        List<Opportunity> oppList = [Select Id,Name From Opportunity LIMIT 1];
        List<Account> accList = [Select Id From Account LIMIT 1];
        EmailMessage em4 = new EmailMessage();
        
        Case c = new Case();
        c.Subject = 'Test Subject';
        c.Claim_ID__c = oppList[0].Id;
        c.Description = 'Test Description';
        c.Status = 'New';
        c.due__c = system.now();
        c.Reported_by__c = userInfo.getUserId();
        c.Origin = 'Email';
        c.SuppliedEmail = 'arjun.kansagara77@marutitech.com';
        insert c;
        
        em4.ParentId = c.Id;
        em4.FromAddress = 'vishal.thoriya@test.com';
        em4.ToAddress = 'loyalty@peddle.com';
        em4.Subject = 'Bid Reduction';
        em4.Incoming = true;
        em4.HtmlBody = 'Test Claim_Ref##'+oppList[0].Id+'## Account_Ref##'+accList[0].Id+'##';
        insert em4;
        
        EmailMessage em5 = new EmailMessage();
        em5.ParentId = c.Id;
        em5.FromAddress = 'vishal.thoriya@test.com';
        em5.ToAddress = 'loyalty@peddle.com';
        em5.Subject = 'Test';
        em5.Incoming = true;
        em5.HtmlBody = 'claim number '+oppList[0].Name;
        insert em5;
        
        
        EmailMessage em7 = new EmailMessage();
        em7.ParentId = c.Id;
        em7.FromAddress = 'vishal.thoriya@test.com';
        em7.ToAddress = 'loyalty@peddle.com';
        em7.Subject = 'Test';
        em7.Incoming = true;
        em7.HtmlBody = 'claim# '+oppList[0].Name;
        insert em7;
        
    }
    
    /*static testMethod void unitTest() {
        
        Map<String,Routing_Names__c> routingNames = Routing_Names__c.getAll();
        Map<String,Constants__c> constants = Constants__c.getAll();
        Map<String,EmailConstants__c> emailConstant = EmailConstants__c.getAll();
        
        try{
            
            List<Opportunity> offers = [Select Id, Name From Opportunity WHERE RecordType.Name = 'Auction' LIMIT 3];
            
            List<Case> cases = new List<Case>();
            
            List<EmailMessage> emails = new List<EmailMessage>();
            
            for(Integer i = 0; i < 5; i++) {
                Case c = new Case();
                c.Subject = 'Test Subject ' + i;
                c.Description = 'Test Description ' + i;
                c.Status = 'Open';
                c.Reported_by__c = UserInfo.getUserId();
                c.Origin = 'Email';
                c.Claim_ID__c = offers[0].Id;
                c.RecordTypeId = CaseUtils.EMAIL_SUPPORT_CASE_RECORDTYPEID;
                c.OwnerId = QueueUtils.Title_Solutions_QueueId;
                c.SuppliedEmail = 'gdummar33@gmail.com';
                cases.add(c);
            }
            
            for(Integer i = 0; i < 5; i++) {
                Case c = new Case();
                c.Subject = 'Test Subject ' + i;
                c.Description = 'Test Description ' + i;
                c.Status = 'Open';
                c.Reported_by__c = UserInfo.getUserId();
                c.Origin = 'Email';
                c.Claim_ID__c = offers[1].Id;
                c.RecordTypeId = CaseUtils.EMAIL_SUPPORT_CASE_RECORDTYPEID;
                c.OwnerId = QueueUtils.Loyalty_QueueId;
                c.SuppliedEmail = 'gdummar33@gmail.com';
                cases.add(c);
            }
            
            for(Integer i = 0; i < 5; i++) {
                Case c = new Case();
                c.Subject = 'Test Subject ' + i;
                c.Description = 'Test Description ' + i;
                c.Status = 'Open';
                c.Reported_by__c = UserInfo.getUserId();
                c.Origin = 'Email';
                c.Type = 'Pick-up';
                c.Claim_ID__c = offers[2].Id;
                c.SuppliedEmail = 'gdummar33@gmail.com';
                cases.add(c);
            }
            
            insert cases;
            
            EmailMessage email1 = new EmailMessage();
            email1.ParentId = cases[0].Id;
            email1.FromAddress = 'george.dummar@swautoinspections.com';
            email1.ToAddress = routingNames.get('Auction').Email__c;
            email1.Subject = 'Vehicle Status Change';
            email1.Incoming = true;
            email1.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email1);
            
            EmailMessage email2 = new EmailMessage();
            email2.ParentId = cases[1].Id;
            email2.FromAddress = 'george.dummar@swautoinspections.com';
            email2.ToAddress = routingNames.get('Inspections').Email__c;
            email2.Subject = 'Vehicle Status Change';
            email2.Incoming = true;
            email2.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email2);
            
            EmailMessage email3 = new EmailMessage();
            email3.ParentId = cases[2].Id;
            email3.FromAddress = 'george.dummar@swautoinspections.com';
            email3.ToAddress = routingNames.get('Loyalty').Email__c;
            email3.Subject = 'Vehicle Status Change';
            email3.Incoming = true;
            email3.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email3);
            
            EmailMessage email4 = new EmailMessage();
            email4.ParentId = cases[2].Id;
            email4.FromAddress = 'george.dummar@swautoinspections.com';
            email4.ToAddress = routingNames.get('Loyalty').Email__c;
            email4.Subject = constants.get('CopartVehicleStatusEmailSubject').Text__c;
            email4.Incoming = true;
            email4.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email4);
            
            EmailMessage email5 = new EmailMessage();
            email5.ParentId = cases[3].Id;
            email5.FromAddress = 'george.dummar@swautoinspections.com';
            email5.ToAddress = routingNames.get('Titles').Email__c;
            email5.Subject = 'Vehicle Status Change';
            email5.Incoming = true;
            email5.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email5);
            
            EmailMessage email6 = new EmailMessage();
            email6.ParentId = cases[4].Id;
            email6.FromAddress = 'george.dummar@swautoinspections.com';
            email6.ToAddress = routingNames.get('Carrier').Email__c;
            email6.Subject = 'Claim Number ' + offers[0].Name;
            email6.Incoming = true;
            email6.HtmlBody = 'Offer ' + offers[0].Name;
            emails.add(email6);
            
            insert emails;
            
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
    
    }*/

}