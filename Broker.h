#import <Foundation/Foundation.h>

@interface Broker : NSObject

- (void) saveOpenPath:(NSString*) path;
- (void) setBool:(BOOL) result forKey:(NSString*) key;
- (void) setObject:(id) result forKey:(NSString*) key;
- (void) sendResults;
- (void) registerExitHook;

+ (Broker*) sharedInstance;

@property BOOL enabled;
@property (strong, nonatomic) NSDictionary* boolResults;
@property (strong, nonatomic) NSDictionary* objectResults;
@property (strong, nonatomic) NSMutableArray* openPaths;

@end