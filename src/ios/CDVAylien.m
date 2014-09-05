/********* CDVAylien.m Cordova Plugin Implementation *******/

#import "CDVAylien.h"

@implementation CDVAylien

- (void)hashtags:(CDVInvokedUrlCommand*)command;
{
    [self processCommand:command];
}

- (void)summarize:(CDVInvokedUrlCommand *)command
{
    [self processCommand:command];
}

- (void)sentiment:(CDVInvokedUrlCommand *)command
{
    [self processCommand:command];
}

- (void)processCommand:(CDVInvokedUrlCommand*)command{

    __block CDVPluginResult* pluginResult = nil;

    NSString *arg = [command.arguments objectAtIndex:0];

    NSString *endpoint = [NSString stringWithFormat:@"%@%@?url=%@", BASE_URL, [command.methodName lowercaseString] , arg];

    NSURL *url = [NSURL URLWithString:endpoint];


    [self sendAsynchronousRequest:url block:^(NSDictionary *result, NSError *error) {
        if (!error){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
        }
        else{
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageToErrorObject:error.code];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        });
    }];
}

- (void)sendAsynchronousRequest:(NSURL*)url block:(void (^)(NSDictionary * result, NSError *error))block
{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

        NSString *clientId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"AylienClientID"];

        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:clientId forHTTPHeaderField:@"X-Mashape-Authorization"];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

            NSError *jsonParsingError = nil;

            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments  error:&jsonParsingError];

            if (jsonParsingError)
                error = jsonParsingError;

            block(result, error);

        }];

        [task resume];

}

@end
