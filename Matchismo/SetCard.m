//
//  SetCard.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-21.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


#pragma mark - initializer

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.numberOfMatchingCards = 3;
    }
    
    return self;
}

#pragma mark - instance methods

- (NSString *)contents {
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [numbers addObject:@(self.number)];
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                
                if (![numbers containsObject:@(otherSetCard.number)]) {
                    [numbers addObject:@(otherSetCard.number)];
                }
                if (![colors containsObject:otherSetCard.color]) {
                    [colors addObject:otherSetCard.color];
                }
                if (![symbols containsObject:otherSetCard.symbol]) {
                    [symbols addObject:otherSetCard.symbol];
                }
                if (![shadings containsObject:otherSetCard.shading]) {
                    [shadings addObject:otherSetCard.shading];
                }
                
                if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
                    && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)
                    && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
                    && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    
    return score;
}

#pragma mark - setters and getters

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color {
    return _color ? _color : @"?";
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}


#pragma mark - Class Methods

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validSymbols {
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

@end
