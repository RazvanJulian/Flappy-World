//
//  EKMusicPlayer.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


@interface EKMusicPlayer : NSObject

+ (EKMusicPlayer *)sharedInstance;
- (void)playMusicFile:(NSData *)file;
- (void)playMusicFileFromMainBundle:(NSString *)fileNameWithExtension;
- (NSTimeInterval)currentTime;
- (NSTimeInterval)duration;
- (void)pause;
- (void)play;
- (void)stop;
- (void)setupNumberOfLoops:(NSInteger)loops;

@end
