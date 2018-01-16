//
//  EAScrollingSprite.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


@interface EAScrollingSprite : SKSpriteNode

@property (nonatomic, assign) CGFloat scrollingSpeed;

- (void)update:(NSTimeInterval)currentTime;

@end
