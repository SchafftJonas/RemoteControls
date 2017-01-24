//
// RemoteControls.m
// Now Playing Cordova Plugin
//
// Created by François LASSERRE on 12/05/13.
// Copyright 2013 François LASSERRE. All rights reserved.
// MIT Licensed
//

#import "RemoteControls.h"

@implementation RemoteControls

static RemoteControls *remoteControls = nil;

- (void)pluginInitialize
{
    NSLog(@"RemoteControls plugin init.");
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveRemoteEvent:) name:@"receivedEvent" object:nil];

}

- (void)updateMetas:(CDVInvokedUrlCommand*)command
{
    
    NSString *jsStatement = [NSString stringWithFormat:@"Alert(\"h3h3\");"];
    
#ifdef __CORDOVA_4_0_0
    [self.webViewEngine evaluateJavaScript:jsStatement completionHandler:nil];
#else
    [self.webView stringByEvaluatingJavaScriptFromString:jsStatement];
#endif
    
    
}


- (void)receiveRemoteEvent:(NSNotification *)notification {
    
    UIEvent * receivedEvent = notification.object;

    if (receivedEvent.type == UIEventTypeRemoteControl) {

        NSString *subtype = @"other";

        switch (receivedEvent.subtype) {

            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"playpause clicked.");
                subtype = @"playpause";
                break;

            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"play clicked.");
                subtype = @"play";
                break;

            case UIEventSubtypeRemoteControlPause:
                NSLog(@"nowplaying pause clicked.");
                subtype = @"pause";
                break;

            case UIEventSubtypeRemoteControlPreviousTrack:
                //[self previousTrack: nil];
                NSLog(@"prev clicked.");
                subtype = @"prevTrack";
                break;

            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next clicked.");
                subtype = @"nextTrack";
                //[self nextTrack: nil];
                break;

            default:
                break;
        }

        NSDictionary *dict = @{@"subtype": subtype};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options: 0 error: nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *jsStatement = [NSString stringWithFormat:@"if(window.remoteControls)remoteControls.receiveRemoteEvent(%@);", jsonString];

#ifdef __CORDOVA_4_0_0
        [self.webViewEngine evaluateJavaScript:jsStatement completionHandler:nil];
#else
        [self.webView stringByEvaluatingJavaScriptFromString:jsStatement];
#endif
        
    }
}


-(void)dealloc {
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"receivedEvent" object:nil];
}

@end
