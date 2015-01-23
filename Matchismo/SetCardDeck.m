//
//  SetDeck.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-21.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init {
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shading in [SetCard validShadings]) {
                for (NSString *symbol in [SetCard validSymbols]) {
                    for (int number = 1; number <= [SetCard maxNumber]; number += 1) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shading = shading;
                        card.color = color;
                        card.symbol = symbol;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
