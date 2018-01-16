//
//  EAObstacle.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAObstacle.h"

static CGFloat const kPipeSpeed     = 4.5f;
static CGFloat const kPipeWidth     = 56.0f;
static uint32_t const kHeroCategory = 0x1 << 0;
static uint32_t const kPipeCategory = 0x1 << 1;


@implementation EAObstacle;

#pragma mark - Designated initializer

+ (instancetype)obstacleWithImageNamed:(NSString *)name
{
    NSParameterAssert(name != nil);
    NSParameterAssert([name length] > 0);
    NSParameterAssert(![name isEqualToString:@" "]);
    
    EAObstacle *obstacle = [super spriteNodeWithImageNamed:name];
    return obstacle;
}

#pragma mark - Public API

- (void)moveObstacleWithScale:(CGFloat)scale
{
    NSParameterAssert(scale > 0.0f);
    
    self.centerRect = CGRectMake(26.0f / kPipeWidth, 26.0f / kPipeWidth, 4.0f / kPipeWidth, 4.0f / kPipeWidth);
    
    //self.centerRect = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    
    if ([EAUtils isLessThanIOS_7_1]) {
        self.yScale = scale;
    }
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = NO;
    self.physicsBody.categoryBitMask = kPipeCategory;
    self.physicsBody.collisionBitMask = kHeroCategory;
    
    if ([EAUtils isGreaterThanOrEqualToIOS_7_1]) {
        self.yScale = scale;
    }
    
    SKAction *pipeAction = [SKAction moveToX:-(self.size.width / 2.0f) duration:kPipeSpeed];
    
    __weak typeof(self) weakSelf = self;
    
    SKAction *pipeSequence = [SKAction sequence:@[pipeAction, [SKAction runBlock: ^{
        [weakSelf removeFromParent];
    }]]];
    
    [self runAction:[SKAction repeatActionForever:pipeSequence]];
}

@end
