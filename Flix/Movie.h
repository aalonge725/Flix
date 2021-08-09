//
//  Movie.h
//  Flix
//
//  Created by Abraham Alonge on 6/30/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *posterURL;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSURL *backDropURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
