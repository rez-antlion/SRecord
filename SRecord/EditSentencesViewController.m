//
//  EditSentencesViewController.m
//  SRecord
//
//  Created by Cédric Foucault on 5/26/13.
//  Copyright (c) 2013 Cédric Foucault. All rights reserved.
//

#import "EditSentencesViewController.h"
#import "SentenceCell.h"

@interface EditSentencesViewController ()

- (BOOL)indexPathPointToSentenceCell:(NSIndexPath *)indexPath;
- (void)addNewSentence;

@end

@implementation EditSentencesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of sentences + 1 for insertion
    return [self.sentences count] + 1;
}

- (BOOL)indexPathPointToSentenceCell:(NSIndexPath *)indexPath {
    return indexPath.row < [self.sentences count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self indexPathPointToSentenceCell:indexPath]) {
        // Retrieve the cell
        static NSString *SentenceCellIdentifier = @"DefaultSentenceCell";
        SentenceCell *cell = (SentenceCell *) [tableView dequeueReusableCellWithIdentifier:SentenceCellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        NSString *sentence = [self.sentences objectAtIndex:indexPath.row];
        cell.sentenceInput.text = sentence;
        cell.index = indexPath;
        cell.delegate = self;
        return cell;
    } else {
        // Insertion cell
        static NSString *InsertionCellIdentifier = @"InsertionCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InsertionCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self indexPathPointToSentenceCell:indexPath]) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteSentenceAtIndexPath:indexPath];
    } else {
        if (editingStyle == UITableViewCellEditingStyleInsert) {
            [self addNewSentence];
        }
    }
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)deleteSentenceAtIndexPath:(NSIndexPath *)indexPath {
    [self.sentences removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)addNewSentence {
    if ([self.sentences respondsToSelector:@selector(addObject)]) {
        NSLog(@"sentences responds to addObject selector");
    }
    [self.sentences addObject:@""];
    [self.tableView reloadData];
}

- (IBAction)switchEditMode:(UIBarButtonItem *)sender {
    if (self.editing) {
        sender.title = @"Edit";
        [self setEditing:NO animated:YES];
    } else {
        sender.title = @"Done";
        [self setEditing:YES animated:YES];
    }
}

- (void)sentenceCellContentDidChange:(SentenceCell *)sender {
    [self.sentences replaceObjectAtIndex:sender.index.row withObject:sender.sentenceInput.text];
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:editing animated:animated];
//    [self.tableView setEditing:editing animated:animated];
//}


@end