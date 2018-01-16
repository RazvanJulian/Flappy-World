//
//  EAUtils.h
//  Flappy World
//
//  Created by Razvan Julian on 17/08/17.
//  Copyright © 2017 Razvan Julian. All rights reserved.
//


@interface EAUtils : NSObject

+ (float)randomFloatWithMin:(CGFloat)min max:(CGFloat)max;
+ (BOOL)isIPhone5;
+ (BOOL)isLessThanIOS_7_1;
+ (BOOL)isGreaterThanOrEqualToIOS_7_1;
+ (NSString *)assetName;

@end
