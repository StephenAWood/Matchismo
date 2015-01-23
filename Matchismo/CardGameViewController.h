//
//  ViewController.h
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-16.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//
//  Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // Abstract Method


- (void)updateUI;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSAttributedString *)titleForCard:(Card *)card;

@end

