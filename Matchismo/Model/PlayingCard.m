//
//  PlayingCard.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-16.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
//    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count]) {
        
        for (Card *card in otherCards) {
            if ([card isKindOfClass:[PlayingCard class]]) {
                PlayingCard *otherCard = (PlayingCard *)card;
                if (otherCard.rank == self.rank) {
                    score += 4;
                } else if ([otherCard.suit isEqualToString:self.suit]) {
                    score += 1;
                }
            }
        }
    }
    
    if ([otherCards count] > 1) {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] - 1)]];
    }
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♠️", @"♥️", @"♣️", @"♦️"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
