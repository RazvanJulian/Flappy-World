//
//  EASpecialGameScene.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


#import "EASpecialGameScene.h"
#import "EAHero.h"
#import "EKMusicPlayer.h"
#import "EAScrollingSprite.h"


static uint32_t const kHeroCategory   = 0x1 << 0;
static uint32_t const kGroundCategory = 0x1 << 2;
@interface EASpecialGameScene ()

@property (nonatomic, strong) SKSpriteNode *ground;
@property (nonatomic, strong) EAScrollingSprite *clouds;

@end

@implementation EASpecialGameScene;

#pragma mark - SKScene overiden API


- (void)didMoveToView:(SKView *)view {
    
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
    
    
//    [[EKMusicPlayer sharedInstance] playMusicFileFromMainBundle:@"chill_preview_2.mp3"];
//    [[EKMusicPlayer sharedInstance] setupNumberOfLoops:-1];
    
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
    return @"purple_background";
}

- (NSString *)heroImageStateOne
{
    return @"bird12";
}

- (NSString *)heroImageStateTwo
{
    return @"bird12";
}

- (NSString *)topObstacleImage
{
    return @"blue_top_pipe";
}

- (NSString *)bottomObstacleImage
{
    return @"blue_down_pipe";
}


@end
