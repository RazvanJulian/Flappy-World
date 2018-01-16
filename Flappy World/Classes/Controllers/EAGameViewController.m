//
//  EAGameViewController.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAGameViewController.h"
#import "EAMenuScene.h"


@interface EAGameViewController () 

@property (nonatomic, strong) SKView *skView;

@end


@implementation EAGameViewController;

#pragma mark - Life cycle

- (void)loadView
{
    self.view = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.skView = (SKView *)self.view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKScene *scene = [EAMenuScene sceneWithSize:self.skView.bounds.size];
    [scene setScaleMode:SKSceneScaleModeAspectFill];
    
    [self.skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIViewController overriden API

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
