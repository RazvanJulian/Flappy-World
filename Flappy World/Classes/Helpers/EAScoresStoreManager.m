//
//  EAScoresStoreManager.m
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//

#import "EAScoresStoreManager.h"

static  NSString * kTopScore= @"kTopScore";


@implementation EAScoresStoreManager;

+ (void)setTopScore:(NSUInteger)topScore
{
    NSString *valueToSave = [NSString stringWithFormat:@"%lu", (unsigned long)topScore];
    
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:kTopScore];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSUInteger)getTopScore
{
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:kTopScore];
    
    return (NSUInteger)[savedValue integerValue];
}

@end
