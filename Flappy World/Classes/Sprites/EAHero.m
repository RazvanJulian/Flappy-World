//
//  EAHero.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAHero.h"

static CGFloat const kHeroDirection = 28.5f;

@implementation EAHero;

- (void)flyWithYLimit:(CGFloat)yLimit
{
    NSParameterAssert(yLimit > 0.0f);
    
    if (self.position.y < yLimit - self.size.height / 2.0f) { // <-- avoid hero to fly away from top of screen
        CGFloat heroDirection = self.zRotation + (CGFloat)M_PI_2;
        self.physicsBody.velocity = CGVectorMake(0.0f, 0.0f);
        [self.physicsBody applyImpulse:CGVectorMake(kHeroDirection * cosf((float)heroDirection),
                                                    kHeroDirection * sinf((float)heroDirection))];
    }
    
    [self runAction:[SKAction playSoundFileNamed:@"Flappy Sound.mp3" waitForCompletion:YES]];
}

@end
