//
//  EAObstacle.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


@interface EAObstacle : SKSpriteNode

+ (instancetype)obstacleWithImageNamed:(NSString *)name;
- (void)moveObstacleWithScale:(CGFloat)scale;

@end
