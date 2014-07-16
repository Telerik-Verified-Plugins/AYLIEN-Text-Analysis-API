/********* CDVAylien.m Cordova Plugin Implementation *******/

#import "CDVAylien.h"

@implementation CDVAylien

- (void)extract:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult* pluginResult = nil;
    
    if ([command.arguments objectAtIndex:0] != nil){
        
        NSString *arg = [command.arguments objectAtIndex:0];
        
        NSString *endpoint = [NSString stringWithFormat:@"%@extract?url=%@", BASE_URL, arg];
      
        NSURL *url = [NSURL URLWithString:endpoint];

        [self sendAsynchronousRequest:url block:^(NSDictionary *article, NSError *error) {
            if (!error){
                NSString *summary = (NSString*) [article objectForKey:@"article"];
                NSString *endpoint = [NSString stringWithFormat:@"%@hashtags?text=%@", BASE_URL, [summary stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURL *url = [NSURL URLWithString:endpoint];

                [self sendAsynchronousRequest:url block:^(NSDictionary *hashtags, NSError *error) {
                    if (!error){
                        NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
                        
                        [result setObject:[article objectForKey:@"title"] forKey:@"title"];
                        [result setObject:[hashtags objectForKey:@"hashtags"] forKey:@"tags"];
                        
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
            else{
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageToErrorObject:error.code];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                });
            }
        }];
    }
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
