//
//  EABaseGameScene.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAHero.h"
#import "EAObstacle.h"

@interface EABaseGameScene : SKScene

@property (nonatomic, strong) EAHero *hero;

- (void)addBottomPipe:(CGFloat)centerY;

@end
