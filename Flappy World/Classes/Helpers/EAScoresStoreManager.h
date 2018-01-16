//
//  EAScoresStoreManager.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


@interface EAScoresStoreManager : NSObject

+ (void)setTopScore:(NSUInteger)topScore;
+ (NSUInteger)getTopScore;

@end
