//
//  EAMenuScene.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAMenuScene.h"
#import "EAYellowBirdGameScene.h"
#import "EARedBirdGameScene.h"
#import "EABirdGameScene.h"
#import "EASpecialGameScene.h"
#import "EKMusicPlayer.h"
#import "EAHero.h"
#import "EAGameCenterProvider.h"
#import "EAScoresStoreManager.h"




@interface EAMenuScene ()

@property (nonatomic, strong) EAHero                *yellowBirdButton;
@property (nonatomic, strong) EAHero                *redBirdButton;
@property (nonatomic, strong) EAHero                *birdButton;
@property (nonatomic, strong) EAHero                *specialButton;

@property (nonatomic, strong) EAYellowBirdGameScene *yellowBirdScene;
@property (nonatomic, strong) EARedBirdGameScene    *redBirdScene;
@property (nonatomic, strong) EABirdGameScene       *birdScene;
@property (nonatomic, strong) EASpecialGameScene    *specialScene;

@property (nonatomic, strong) SKSpriteNode          *rankButton;
@property (nonatomic, strong) SKSpriteNode          *audioButton;
@property (nonatomic, strong) SKSpriteNode          *storeButton;

@end


@implementation EAMenuScene;

#pragma mark - SKScene overriden API

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    self.yellowBirdScene = [[EAYellowBirdGameScene alloc] initWithSize:self.size];
    self.redBirdScene = [[EARedBirdGameScene alloc] initWithSize:self.size];
    self.birdScene = [[EABirdGameScene alloc] initWithSize:self.size];
    self.specialScene = [[EASpecialGameScene alloc] initWithSize:self.size];
    
    [self provideBackground];
    [self addLabels];
    [self createSpriteButtons];
    
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isPlaying"]) {
        [[EKMusicPlayer sharedInstance] playMusicFileFromMainBundle:@"chill_preview_2.mp3"];
        [[EKMusicPlayer sharedInstance] setupNumberOfLoops:-1];
        
    } else {
        [[EKMusicPlayer sharedInstance] stop];
    }

    
}

- (void)willMoveFromView:(SKView *)view
{
    [super willMoveFromView:view];
    //[[EKMusicPlayer sharedInstance] stop];
}

- (void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
    
        //check & handle if player get top score during unauthorized game center state
    if ([EAScoresStoreManager getTopScore] > 0 && [EAGameCenterProvider sharedInstance].userAuthenticated) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[EAGameCenterProvider sharedInstance] reportScore:[EAScoresStoreManager getTopScore]];
        });
    }
}

BOOL isPlaying = YES;

#pragma mark - UIResponder overriden API

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    
    if (CGRectContainsPoint(self.yellowBirdButton.frame, positionInScene)) {
        [self.scene.view presentScene:self.yellowBirdScene];
    }
    else if (CGRectContainsPoint(self.redBirdButton.frame, positionInScene)) {
        [self.scene.view presentScene:self.redBirdScene];
        
    }
    
    else if (CGRectContainsPoint(self.birdButton.frame, positionInScene)) {
            [self.scene.view presentScene:self.birdScene];
    }
    
    else if (CGRectContainsPoint(self.specialButton.frame, positionInScene)) {
            [self.scene.view presentScene:self.specialScene];
    
    }
    
    else if (CGRectContainsPoint(self.rankButton.frame, positionInScene)) {
        [[EAGameCenterProvider sharedInstance] showLeaderboard];
    }
    
    else if (CGRectContainsPoint(self.audioButton.frame, positionInScene)) {
        
        
        if (isPlaying) {
            
            [[EKMusicPlayer sharedInstance] stop];
            self.audioButton.texture = [SKTexture textureWithImageNamed:@"speaker-off"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPlaying"];

            
        } else {
            
            [[EKMusicPlayer sharedInstance] play];
            self.audioButton.texture = [SKTexture textureWithImageNamed:@"speaker-on"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPlaying"];

        }
        
        isPlaying = !isPlaying;
        
        
        
    }
}

#pragma mark - Private API

- (void)createSpriteButtons
{
    [self createUfoButton];
    [self createRocketButton];
    [self createBirdButton];
    [self createSpecialButton];
    [self createRankButton];
    [self createAudioButton];
    //[self createStoreButton];
}

- (void)createUfoButton
{
    self.yellowBirdButton = [EAHero spriteNodeWithImageNamed:@"bird7"];
    self.yellowBirdButton.size = CGSizeMake(101.0f / 2.0f, 75.0f / 2.0f);
    [self.yellowBirdButton setPosition:CGPointMake(CGRectGetMidX(self.view.frame) - 70.0f,
                                            CGRectGetMidY(self.view.frame) - 60.0f)];
    
    NSArray *animationFrames = @[[SKTexture textureWithImageNamed:@"bird7"],
                                 [SKTexture textureWithImageNamed:@"bird8"],
                                 [SKTexture textureWithImageNamed:@"bird9"]];
    
    SKAction *heroAction = [SKAction repeatActionForever:[SKAction animateWithTextures:animationFrames
                                                                          timePerFrame:0.1f
                                                                                resize:NO
                                                                               restore:YES]];
    [self.yellowBirdButton runAction:heroAction];
    [self addChild:self.yellowBirdButton];
}

- (void)createRocketButton
{
    self.redBirdButton = [EAHero spriteNodeWithImageNamed:@"bird4"];
    self.redBirdButton.size = CGSizeMake(111.0f / 2.0f, 85.0f / 2.0f);
    [self.redBirdButton setPosition:CGPointMake(CGRectGetMidX(self.view.frame) + 70.0f,
                                               CGRectGetMidY(self.view.frame) - 60.0f)];
    
    NSArray *animationFrames = @[[SKTexture textureWithImageNamed:@"bird4"],
                                 [SKTexture textureWithImageNamed:@"bird5"],
                                 [SKTexture textureWithImageNamed:@"bird6"]];
    
    SKAction *heroAction = [SKAction repeatActionForever:[SKAction animateWithTextures:animationFrames
                                                                          timePerFrame:0.1f
                                                                                resize:NO
                                                                               restore:YES]];
    [self.redBirdButton runAction:heroAction];
    [self addChild:self.redBirdButton];
}


- (void)createBirdButton
{
    self.birdButton = [EAHero spriteNodeWithImageNamed:@"bird1"];
    self.birdButton.size = CGSizeMake(111.0f / 2.0f, 85.0f / 2.0f);
    [self.birdButton setPosition:CGPointMake(CGRectGetMidX(self.view.frame) - 70.0f,
                                               CGRectGetMidY(self.view.frame) - 160.0f)];
    
    NSArray *animationFrames = @[[SKTexture textureWithImageNamed:@"bird1"],
                                 [SKTexture textureWithImageNamed:@"bird2"],//,
                                 [SKTexture textureWithImageNamed:@"bird3"]];
    
    SKAction *heroAction = [SKAction repeatActionForever:[SKAction animateWithTextures:animationFrames
                                                                          timePerFrame:0.1f
                                                                                resize:NO
                                                                               restore:YES]];
    [self.birdButton runAction:heroAction];
    [self addChild:self.birdButton];
}


- (void)createSpecialButton {
    
    
    self.specialButton = [EAHero spriteNodeWithImageNamed:@"bird4"];
    self.specialButton.size = CGSizeMake(111.0f / 2.0f, 85.0f / 2.0f);
    [self.specialButton setPosition:CGPointMake(CGRectGetMidX(self.view.frame) + 70.0f,
                                             CGRectGetMidY(self.view.frame) - 160.0f)];
    
    NSArray *animationFrames = @[[SKTexture textureWithImageNamed:@"bird12"]];//,
                                 //[SKTexture textureWithImageNamed:@"bird12"],//,
                                 //[SKTexture textureWithImageNamed:@"bird12"]];
    
    SKAction *heroAction = [SKAction repeatActionForever:[SKAction animateWithTextures:animationFrames
                                                                          timePerFrame:0.1f
                                                                                resize:NO
                                                                               restore:YES]];
    [self.specialButton runAction:heroAction];
    [self addChild:self.specialButton];
    
    
}

- (void)createRankButton
{
    self.rankButton = [EAHero spriteNodeWithImageNamed:@"Places"];
    self.rankButton.position = CGPointMake(CGRectGetMidX(self.view.frame) + 125.0f,//self.rankButton.frame.size.width / 60.0f,
                                           self.position.y + 580.0f);
    [self addChild:self.rankButton];
}

- (void)createAudioButton {
    self.audioButton = [EAHero spriteNodeWithImageNamed:@"speaker-on"];
    self.audioButton.position = CGPointMake(CGRectGetMidX(self.view.frame) - 175.0f, self.position.y + 125.0f);
    self.audioButton.size = CGSizeMake(85.0f/2.0f, 85.0f/2.0f);
    
    [self addChild:self.audioButton];
}

//- (void)createStoreButton {
//    
//    self.storeButton = [EAHero spriteNodeWithImageNamed:@"shopping-cart"];
//    self.storeButton.position = CGPointMake(CGRectGetMidX(self.view.frame) + 175.0f, self.position.y + 125.0f);
//    self.storeButton.size = CGSizeMake(85.0f/2.0f, 85.0f/2.0f);
//    
//    [self addChild:self.storeButton];
//}


- (void)provideBackground {
    
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:[EAUtils assetName]];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture size:self.view.frame.size];
    background.position = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    background.zPosition = 0.0;
    [self addChild:background];
}

- (void)addLabels
{
    SKLabelNode *titleLabel = [[SKLabelNode alloc] initWithFontNamed:@"PressStart2P"];
    titleLabel.text = @"Flappy";
    titleLabel.fontSize = 50.0f;
    titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    titleLabel.fontColor = [SKColor whiteColor];//yellowColor];
    titleLabel.position = CGPointMake(self.frame.origin.x + 35.0f, self.frame.size.height - 110.0f);
    [self addChild:titleLabel];
    
    SKLabelNode *titleLabel2 = [[SKLabelNode alloc] initWithFontNamed:@"PressStart2P"];
    titleLabel2.text = @"World";
    titleLabel2.fontSize = 50.0f;
    titleLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    titleLabel2.fontColor = [SKColor whiteColor];//yellowColor];
    titleLabel2.position = CGPointMake(self.frame.origin.x + 15.0f, self.frame.size.height - 170.0f);
    [self addChild:titleLabel2];
    
    SKLabelNode *titleLabel3 = [[SKLabelNode alloc] initWithFontNamed:@"PressStart2P"];
    titleLabel3.text = @"Get Started!"; //@"select flight";
    titleLabel3.fontSize = 15.0f;
    titleLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    titleLabel3.fontColor = [SKColor yellowColor];
    titleLabel3.position = CGPointMake(CGRectGetMidX(self.view.frame) - titleLabel3.frame.size.width / 2.0f, self.frame.size.height - 250.0f);
    [self addChild:titleLabel3];
}

@end
