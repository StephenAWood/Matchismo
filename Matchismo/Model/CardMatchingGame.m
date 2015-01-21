//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-18.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastScore;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSArray *lastChosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSUInteger)matchNumber {
    if (_matchNumber < 2) _matchNumber = 2;
    return _matchNumber;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i += 1) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//static const int MISMATCH_PENALTY = 2;
#define MISMATCH_PENALTY 2
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            
            if ([otherCards count] + 1 == self.matchNumber) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.lastScore += matchScore * MATCH_BONUS;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                } else {
                    self.lastScore -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    }
}

@end