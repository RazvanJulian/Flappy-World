//
//  EARedBirdGameScene.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EARedBirdGameScene.h"
#import "Constants.h"
#import "EKMusicPlayer.h"
#import "EAHero.h"

@interface EARedBirdGameScene ()

@property (nonatomic, strong) SKSpriteNode *ground;

@end


@implementation EARedBirdGameScene;

#pragma mark - Overriden SKScene API

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.hero.size = CGSizeMake(116.0f / 2.0f, 91.0f / 2.0f);
    [self addBottom];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isPlaying"]) {
        [[EKMusicPlayer sharedInstance] playMusicFileFromMainBundle:@"chill_preview_2.mp3"];
        [[EKMusicPlayer sharedInstance] setupNumberOfLoops:-1];
        
    } else {
        [[EKMusicPlayer sharedInstance] stop];
    }
    
}

#pragma mark - Private API

- (void)addBottom
{
    self.ground = [SKSpriteNode spriteNodeWithImageNamed:@"purple_ground"];
    self.ground.size = CGSizeMake(self.size.width, 30.0f);
    self.ground.centerRect = CGRectMake(26.0f / 20.0f, 26.0f / 20.0f, 4.0f / 20.0f, 4.0f / 20.0f);
    self.ground.xScale = self.size.width / 20.0f;
    self.ground.zPosition = 1.0f;
    self.ground.position = CGPointMake(self.size.width / 2.0f, self.ground.size.height / 2.0f - self.ground.size.height - 50.0f);
    self.ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.ground.size];
    self.ground.physicsBody.categoryBitMask = kGroundCategory;
    self.ground.physicsBody.collisionBitMask = kHeroCategory;
    self.ground.physicsBody.affectedByGravity = NO;
    self.ground.physicsBody.dynamic = NO;
    [self addChild:self.ground];
}

#pragma mark - Overriden private API

- (void)addBottomPipe:(CGFloat)centerY
{
    [super addBottomPipe:centerY];
    
    EAObstacle *pipeBottom = [EAObstacle obstacleWithImageNamed:[self bottomObstacleImage]];
    [self addChild:pipeBottom];
    
    CGFloat pipeBottomHeight = self.size.height - (centerY + (kPipeGap / 2.0f));
    [pipeBottom moveObstacleWithScale:(pipeBottomHeight) / kPipeWidth];
    pipeBottom.position = CGPointMake(self.size.width + (pipeBottom.size.width / 2.0f), (pipeBottom.size.height / 2.0f));
}

- (NSString *)backgroundImageName
{
    return @"purple_background";
}

- (NSString *)heroImageStateOne
{
    return @"bird4";
}

- (NSString *)heroImageStateTwo
{
    return @"bird5";
}

- (NSString *)topObstacleImage
{
    return @"red_up_pipe";
}

- (NSString *)bottomObstacleImage
{
    return @"red_down_pipe";
}

@end
