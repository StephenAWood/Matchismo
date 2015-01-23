//
//  SetCard.h
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-21.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
