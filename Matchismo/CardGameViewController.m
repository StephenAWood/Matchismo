//
//  ViewController.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-16.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *playingCardDeck;
@end

@implementation CardGameViewController

- (Deck *)playingCardDeck
{
    if (!_playingCardDeck) {
        _playingCardDeck = [[PlayingCardDeck alloc] init];
    }
    return _playingCardDeck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//    NSLog(@"Flipcount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"]
                          forState:UIControlStateNormal];
        
        [sender setTitle:@"" forState:UIControlStateNormal];
        
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
        [sender setTitle:@"A♣️" forState:UIControlStateNormal];
    }
    
    self.flipCount += 1;
     
}

@end
