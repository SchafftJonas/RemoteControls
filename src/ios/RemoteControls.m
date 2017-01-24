
#import "RemoteControls.h"

@implementation RemoteControls
static RemoteControls *remoteControls = nil;

static NSString *currenttrackid = @"missing";
static NSString *currenttracksrc = @"missing";
static NSString *currenttitle = @"missing";
static NSString *currentartitst = @"missing";
static NSString *currentalbum = @"missing";
static NSNumber *currentDuration = 0;


- (void)pluginInitialize
{
    NSLog(@"RemoteControls plugin init.");
}

- (void)updateMetas:(CDVInvokedUrlCommand*)command
{
    
    NSString *artist = [command.arguments objectAtIndex:0];
    NSString *title = [command.arguments objectAtIndex:1];
    NSString *album = [command.arguments objectAtIndex:2];
    NSNumber *duration = [command.arguments objectAtIndex:4];
    NSNumber *elapsed = [command.arguments objectAtIndex:5];
    NSNumber *pause = [command.arguments objectAtIndex:8];
    currenttrackid = [command.arguments objectAtIndex:6];
    currenttracksrc = [command.arguments objectAtIndex:7];
    if(artist != nil){
        currentartitst = artist;
    }
    if(album != nil){
        currentalbum = album;
    }
    currentDuration = duration;
    if(title != nil){
        currenttitle = title;
    }
    
    // NSNumber *sum = [NSNumber numberWithFloat:((1 + [duration floatValue]) - [elapsed floatValue])];
    
    NSInteger *numb = 1;
    
    if([pause integerValue] == 1){
        numb = 0;
    }
    
    NSLog(@"######## ################################# ########");
    
    NSLog(@"######## Update Remote Audio Data Controls ########");
    
    NSLog(@"######## Artist: %@", currentartitst);
    
    NSLog(@"######## Title: %@", currenttitle);
    
    NSLog(@"######## Duration: %@", duration);
    
    NSLog(@"######## Elapsed Time: %@", elapsed);
    
    NSLog(@"######## isNotPause?: %zd", numb);
    
    NSLog(@"######## End Update Remote Audio Data Controls ########");
    
    NSLog(@"######## ################################# ########");
    
    // Wir stellen sicher dass alle benötigten Buttons nicht von Cordova überschrieben wurden:
    
    MPRemoteCommandCenter * cc = [MPRemoteCommandCenter sharedCommandCenter];
    
    [cc.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cc.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cc.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cc.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // Update der Media Controls:
    
    if ([MPNowPlayingInfoCenter class])  {
        
        NSDictionary *currentlyPlayingTrackInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:currentartitst,currenttitle,duration,[NSNumber numberWithInteger:numb],elapsed, nil]
                                                                              forKeys:[NSArray arrayWithObjects:MPMediaItemPropertyArtist,MPMediaItemPropertyTitle, MPMediaItemPropertyPlaybackDuration,MPNowPlayingInfoPropertyPlaybackRate,             MPNowPlayingInfoPropertyElapsedPlaybackTime,nil]];
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = currentlyPlayingTrackInfo;
    }
    
    // Update der Media Controls mit einer leichten Verzögerung um alle evtl. auftretenden Änderungen von Cordova Plugins zu überschrieben:
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        if ([MPNowPlayingInfoCenter class])  {
            
            NSDictionary *currentlyPlayingTrackInfo = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:currentartitst,currenttitle,duration,[NSNumber numberWithInteger:numb],elapsed, nil]
                                                                                  forKeys:[NSArray arrayWithObjects:MPMediaItemPropertyArtist,MPMediaItemPropertyTitle, MPMediaItemPropertyPlaybackDuration,MPNowPlayingInfoPropertyPlaybackRate,             MPNowPlayingInfoPropertyElapsedPlaybackTime,nil]];
            [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = currentlyPlayingTrackInfo;
        }
        
    });
    
    
}


+(RemoteControls *)remoteControls
{
    
    if (!remoteControls)
    {
        remoteControls = [[RemoteControls alloc] init];
    }
    
    return remoteControls;
}


@end