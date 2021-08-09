//
//  Movie.m
//  Flix
//
//  Created by Abraham Alonge on 6/30/21.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.title = dictionary[@"title"];
    self.synopsis = dictionary[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    NSString *posterURLString = dictionary[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    self.posterURL = [NSURL URLWithString:fullPosterURLString];
    
    NSString *backdropURLString = dictionary[@"backdrop_path"];
    if ([backdropURLString isKindOfClass:[NSString class]]) {
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        self.backDropURL = [NSURL URLWithString:fullBackdropURLString];

    }
    
    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    NSArray *movies = [[NSArray alloc] init];
    for(NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        movies = [movies arrayByAddingObject:movie];
    }
    return movies;
}

@end
