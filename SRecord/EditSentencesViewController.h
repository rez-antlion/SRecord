//
//  EditSentencesViewController.h
//  SRecord
//
//  Created by Cédric Foucault on 5/26/13.
//  Copyright (c) 2013 Cédric Foucault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SentenceCell.h"
@class SentencesManager;

@interface EditSentencesViewController : UITableViewController <SentenceCellDelegate>

@property (strong, nonatomic) NSMutableArray *sentences;

- (IBAction)switchEditMode:(UIBarButtonItem *)sender;
- (IBAction)addAction:(UIBarButtonItem *)sender;

@end
