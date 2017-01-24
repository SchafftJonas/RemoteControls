#import <Cordova/CDVPlugin.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import "Cordova/CDVViewController.h"

@interface RemoteControls : CDVPlugin {
}

+(RemoteControls*)remoteControls;

- (void)clearMediaControlMetas:(CDVInvokedUrlCommand*)command;
- (void)updateMetas:(CDVInvokedUrlCommand*)command;
- (void)receiveRemoteEvent:(UIEvent *)receivedEvent withController:(CDVViewController*)cdvViewController;

@end
