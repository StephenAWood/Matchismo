//
//  Card.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-16.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (NSUInteger)numberOfMatchingCards {
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    
    return score;
}

@end
