//
//  EAYellowBirdGameScene.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAYellowBirdGameScene.h"

#import "EAHero.h"
#import "EKMusicPlayer.h"
#import "EAScrollingSprite.h"

static uint32_t const kHeroCategory   = 0x1 << 0;
static uint32_t const kGroundCategory = 0x1 << 2;


@interface EAYellowBirdGameScene ()

@property (nonatomic, strong) SKSpriteNode *ground;
@property (nonatomic, strong) EAScrollingSprite *clouds;

@end


@implementation EAYellowBirdGameScene;

#pragma mark - SKScene overriden API

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.ground = [SKSpriteNode spriteNodeWithImageNamed:@"purple_ground"];
    self.ground.size = CGSizeMake(self.size.width, 30.0f);
    self.ground.centerRect = CGRectMake(26.0f / 20.0f, 26.0f / 20.0f, 4.0f / 20.0f, 4.0f / 20.0f);
    self.ground.xScale = self.size.width / 20.0f;
    self.ground.zPosition = 1.0f;
    self.ground.position = CGPointMake(self.size.width / 2.0f, self.ground.size.height / 2.0f);
    self.ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.ground.size];
    self.ground.physicsBody.categoryBitMask = kGroundCategory;
    self.ground.physicsBody.collisionBitMask = kHeroCategory;
    self.ground.physicsBody.affectedByGravity = NO;
    self.ground.physicsBody.dynamic = NO;
    [self addChild:self.ground];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isPlaying"]) {
        [[EKMusicPlayer sharedInstance] playMusicFileFromMainBundle:@"chill_preview_2.mp3"];
        [[EKMusicPlayer sharedInstance] setupNumberOfLoops:-1];
        
    } else {
        [[EKMusicPlayer sharedInstance] stop];
    }
    
    
    //self.clouds = [EAScrollingSprite spriteNodeWithImageNamed:@"Clouds"];
    //self.clouds.position = CGPointMake(0, self.size.height - 15.0f);
    //self.clouds.scrollingSpeed = 1.0f;
    //[self addChild:self.clouds];
}

- (void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
    [self.clouds update:currentTime];
}

#pragma mark - Overriden inherited private API

- (NSString *)backgroundImageName
{
    return @"Day_Background";
}

- (NSString *)heroImageStateOne
{
    return @"bird10";
}

- (NSString *)heroImageStateTwo
{
    return @"bird11";
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
