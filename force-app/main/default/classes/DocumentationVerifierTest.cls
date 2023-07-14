/**
* 
* Name: DocumentationVerifierTest
* Created By: Nuvola Partners
* Description: Test Class for DocumentationVerifier.
* 
**/

@isTest(SeeAllData=true)
private class DocumentationVerifierTest {
    
    // Mock HTTP Class
    public class HttpMockResponseGenerator implements HttpCalloutMock {
        
        public String jsonBody;
        public Integer statusCode;
        
        public HttpMockResponseGenerator(String jsonBody, Integer statusCode) {
            this.jsonBody = jsonBody;
            this.statusCode = statusCode;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            // Pseudo response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(jsonBody);
            res.setStatusCode(statusCode);
            return res;
        }
        
    }
    
    @isTest static void testInstantiateDocumentationTask() {
        Account acct = [SELECT Id, OwnerId FROM Account WHERE RecordType.Name = 'Buyer' LIMIT 1];
        Task documentationTask = DocumentationVerifier.instantiateDocumentationTask(acct, acct.OwnerId, '12345', 'https://peddle.app.box.com', '/f/12345', 14, 'Test Task');
    }
    
    /*@isTest static void testDocumentationVerifier() {
        
        // Set mock response
        DocumentationVerifierTest.HttpMockResponseGenerator fakeResponse = new DocumentationVerifierTest.HttpMockResponseGenerator(
            '{"entries": [{"id": 12345,"etag": 1,"type": "file","sequence_id": 3,"name": "Contract.pdf","sha1": "85136C79CBF9FE36BB9D05D0639C70C265C18D37","file_version": {"id": 12345,"type": "file_version","sha1": "134b65991ed521fcfe4724b7d814ab8ded5185dc"}}],"limit": 1000,"offset": 2000,"order": [{"by": "type","direction": "ASC"}],"total_count": 5000}',
            200
        );
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        DocumentationVerifier dV = new DocumentationVerifier();
        Id batchId = Database.executeBatch(dV);
        Test.stopTest();
    }*/
    
}