//
//  EAGameCenterProvider.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

@interface EAGameCenterProvider : NSObject 

@property (nonatomic, assign) BOOL userAuthenticated;

+ (EAGameCenterProvider *)sharedInstance;
- (void)authenticateLocalUser;
- (void)reportScore:(NSUInteger)score;
- (void)showLeaderboard;

@end
