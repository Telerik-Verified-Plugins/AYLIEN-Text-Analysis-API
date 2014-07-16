#import <Cordova/CDV.h>

#define  BASE_URL @"https://aylien-text.p.mashape.com/"

@interface CDVAylien : CDVPlugin 
- (void)extract:(CDVInvokedUrlCommand*)command;
@end