//
//  MovieAPIManager.h
//  Flix
//
//  Created by Abraham Alonge on 6/30/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieAPIManager : NSObject

- (id)init;
- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;
- (void)fetchPopular:(void(^)(NSArray *movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
