//
//  FavoriteViewCell.h
//  
//
//  Created by Stephanie Lampotang on 6/28/18.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *faveLabel;
@property (strong, nonatomic) NSMutableArray *myFaves;

@end
