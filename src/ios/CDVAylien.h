#import <Cordova/CDV.h>

#define  BASE_URL @"https://aylien-text.p.mashape.com/"

@interface CDVAylien : CDVPlugin
- (void)summarize:(CDVInvokedUrlCommand*)command;
- (void)hashtags:(CDVInvokedUrlCommand*)command;
- (void)sentiment:(CDVInvokedUrlCommand*)command;

@end
