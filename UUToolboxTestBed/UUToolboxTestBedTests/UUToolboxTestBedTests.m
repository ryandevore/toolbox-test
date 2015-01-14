//
//  UUToolboxTestBedTests.m
//  UUToolboxTestBedTests
//
//  Created by Ryan DeVore on 7/2/14.
//  Copyright (c) 2014 Ryan DeVore. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UUHttpClient.h"
#import "UUHttpSession.h"

#define UUBeginAsyncTest() __block BOOL asyncTestDone = NO
#define UUEndAsyncTest() asyncTestDone = YES
#define UUWaitForAsyncTest() \
while (!asyncTestDone) \
{ \
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]]; \
} \


@interface UUHttpTestResult : NSObject

@property (nonatomic, strong) NSError* err;
@property (nonatomic, strong) id parsedResponse;

@end

@implementation UUHttpTestResult

@end

@interface UUToolboxTestBedTests : XCTestCase

@end

@implementation UUToolboxTestBedTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test methods

- (void) testGetNoArgs
{
    NSString* url = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key-";
    NSDictionary* args = nil;
    
    UUHttpTestResult* legacyResult = [self doLegacyGetTest:url args:args];
    XCTAssertNotNil(legacyResult, @"Expected a non-nil legacy result");
    
    UUHttpTestResult* sessionResult = [self doLegacyGetTest:url args:args];
    XCTAssertNotNil(sessionResult, @"Expected a non-nil session result");
    
}

#pragma mark - Test Helper methods

- (UUHttpTestResult*) doLegacyGetTest:(NSString*)url args:(NSDictionary*)d
{
    UUBeginAsyncTest();
    
    __block UUHttpTestResult* result = [UUHttpTestResult new];
    
    [UUHttpClient get:url queryArguments:d completionHandler:^(UUHttpClientResponse *response)
    {
        result.err = response.httpError;
        result.parsedResponse = response.parsedResponse;
        
        UUEndAsyncTest();
    }];
    
    UUWaitForAsyncTest();
    
    return result;
}

- (UUHttpTestResult*) doSessionGetTest:(NSString*)url args:(NSDictionary*)d
{
    UUBeginAsyncTest();
    
    __block UUHttpTestResult* result = [UUHttpTestResult new];
    
    [[UUHttpSession sharedInstance] get:url queryArguments:d completionHandler:^(UUHttpResponse *response)
    {
         result.err = response.httpError;
         result.parsedResponse = response.parsedResponse;
         
         UUEndAsyncTest();
     }];
    
    UUWaitForAsyncTest();
    
    return result;
}

@end
