//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-18.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger lastScore;
@property (nonatomic) NSUInteger matchNumber;
@property (nonatomic, readonly) NSArray *lastChosenCards;

@end
