//
//  ViewController.m
//  Matchismo
//
//  Created by Stephen Wood on 2015-01-16.
//  Copyright (c) 2015 Stephen Wood. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (weak, nonatomic) IBOutlet UILabel *matchingLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        [self changeModeSelector:self.modeSelector];
    }
    return _game;
}

- (Deck *)createDeck { //abstract
    return nil;
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender {
    self.game.matchNumber = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}

#define REDEAL_MESSAGE @"Are you sure you want to redeal?"


- (IBAction)redealButtonPressed:(UIButton *)sender {
    // Ask the user if they are sure they want to redeal.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Redeal?" message:REDEAL_MESSAGE preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *redeal = [UIAlertAction actionWithTitle:@"Redeal" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self redeal];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:redeal];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)redeal {
    self.game = nil;
    self.modeSelector.enabled = YES;
    [self updateUI];
}


- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self updateMatchDescriptionLabel];
}

- (void)updateMatchDescriptionLabel {
    
    NSString *text = @"";
    
    if (self.game) {
        NSMutableArray *contents = [[NSMutableArray alloc] init];
        
        if ([self.game.lastChosenCards count]) {
            for (id card in self.game.lastChosenCards) {
                if ([card isKindOfClass:[Card class]]) {
                    Card *pc = (Card *)card;
                    [contents addObject:pc.contents];
                }
            }
        }
        if (self.game.lastScore < 0) {
            text = [contents componentsJoinedByString:@" "];
            text = [text stringByAppendingFormat:@" Don't match! %ld point penalty!", -(long)self.game.lastScore];
        } else if (self.game.lastScore > 0) {
            text = [contents componentsJoinedByString:@" "];
            text = [@"Matched" stringByAppendingFormat:@" %@ for %ld points.", text, (long)self.game.lastScore];
        } else {
            text = [contents componentsJoinedByString:@" "];
        }
    }
    self.matchingLabel.text = text;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.modeSelector.enabled = NO;
    [self updateUI];
}

- (NSAttributedString *)titleForCard:(Card *)card {
//    return card.isChosen ? card.contents : @"" ;
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
