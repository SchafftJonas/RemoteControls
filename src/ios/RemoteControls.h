#import <Cordova/CDVPlugin.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import "Cordova/CDVViewController.h"

@interface RemoteControls : CDVPlugin {
}

+(RemoteControls*)remoteControls;

- (void)updateMetas:(CDVInvokedUrlCommand*)command;

@end
