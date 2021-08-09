//
//  DetailsViewController.h
//  Flix
//
//  Created by Abraham Alonge on 6/23/21.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Movie *movie;

- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
