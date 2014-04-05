//
//  TruckDetailViewController.m
//  IndyFoodTrucks
//
//  Created by Manny on 4/4/14.
//  Copyright (c) 2014 AppDar. All rights reserved.
//

#import "TruckDetailViewController.h"
#import "TruckFormViewController.h"
#import "CCActionSheet.h"
#import "UIImageView+AFNetworking.h"
#import "LocationMapCell.h"

@interface TruckDetailViewController () <UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation TruckDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", nil)
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(onEditBtnClick:)];
    //self.navigationItem.rightBarButtonItem = editBtn;
}

- (void)onEditBtnClick:(id)sender
{
    TruckFormViewController *formViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TruckForm"];
    formViewController.editTruckForm = self.truck;
    [self.navigationController pushViewController:formViewController animated:YES];
}

- (IBAction)onCheckBtnClick:(id)sender
{
    CCActionSheet *sheet = [[CCActionSheet alloc] initWithTitle:NSLocalizedString(@"Select check-in method", nil)];
    [sheet addButtonWithTitle:@"Automatic" block:^{
        
    }];
    [sheet addButtonWithTitle:@"Manuel" block:^{
        
    }];
    
    [sheet addCancelButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    [sheet showInView:self.view];
}

#pragma mark -
#pragma mark Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)index
{
    if (index == 0) return @"Current Location";
    return @"Truck Information";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)index
{
    if (index == 0) return 1;
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        return 150;
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"LocationMapCell";
        LocationMapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        
        NSString *mapURL = @"http://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=11&size=320x150&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&sensor=false";
        
        [cell.mapImageView setImageWithURL:[NSURL URLWithString:mapURL]
                           placeholderImage:nil];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *CellIdentifier = @"TruckDetailCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.truck.truckName;
            
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Description";
            cell.detailTextLabel.text = self.truck.truckInfo;
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Menu URL";
            cell.detailTextLabel.text = self.truck.truckMenuURL;
            
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"Phone";
            cell.detailTextLabel.text = self.truck.truckPhone;
            
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"Website";
            cell.detailTextLabel.text = self.truck.truckWebsite;
            
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Delegate methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end