#import "Broker.h"
#import "NSDistributedNotificationCenter.h"
#import "AAClientLib.h"
#import "AAPilotNotification.h"

// The broker class is responsible for caching analysis results and for transmitting them to the backend  
@implementation Broker : NSObject

- (void) setBool:(BOOL) result forKey:(NSString*) key {
    if(result && key != nil) {
        if([key length]>0) {
            DLog(@"Broker: setBool: %@ forKey: %@", result ? @"YES" : @"NO", key);
            @synchronized(self.boolResults) {
                [self.boolResults setValue:[NSNumber numberWithBool:result] forKey:key];
            }
        }
    }
}

- (void) setObject:(id) result forKey:(NSString*) key {
    if(result != nil && key != nil) {
        if([key length]>0) {
            DLog(@"Broker: setObject: %@ forKey: %@", result, key);
            @synchronized(self.objectResults) {
                [self.objectResults setValue:result forKey:key];
            }
        }
    }
}

- (void) saveOpenPath:(NSString*) path {
    @synchronized(self.openPaths) {
        if (![self.openPaths containsObject:path]) {
            [self.openPaths addObject:path];
        }
    }
}

- (void) sendResults {
	AAClientLib* client = [AAClientLib sharedInstance];
	NSDictionary* taskInfo = client.taskInfo;

	if (taskInfo != nil && [taskInfo objectForKey:@"bundleId"] != nil) {
        if ([[taskInfo objectForKey:@"bundleId"] isEqualToString:[[NSBundle mainBundle] bundleIdentifier]]) {
        	
        	DLog(@"Delivering results for %@ to DiOS backend", [[NSBundle mainBundle] bundleIdentifier]);

        	@synchronized(self.boolResults) {
                if(self.boolResults != nil) {
                    if([self.boolResults count]>0) {
                        [client saveResult:self.boolResults withType:AACResultTypeCriteria];
                    }
                }
            }

            @synchronized(self.objectResults) {
                if(self.objectResults != nil) {
                    if([self.objectResults count]>0) {
                        for (id key in self.objectResults) {
                            id value = [self.objectResults objectForKey:key];
                            [client saveResult:value withType:key];
                        }
                    }
                }
            }

            @synchronized(self.openPaths) {
                if(self.openPaths != nil) {
                    if([self.openPaths count]>0) {
                        [client saveResult:self.openPaths withType:@"open_paths"];
                    }
                }
            }

        }
    }

}

- (void) registerExitHook {
	 [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(sendResults) name:AAPilotAppExecutionFinished object:nil];
     self.enabled = YES;
}

- (id) init {
    self = [super init];

    if (self) {
        self.boolResults = [NSMutableDictionary dictionary];
        self.objectResults = [NSMutableDictionary dictionary];
        self.openPaths = [NSMutableArray array];
    }

    return self;
}

+ (Broker*) sharedInstance {
	static Broker* sharedSingleton;
    
    @synchronized(self) {
        if (!sharedSingleton) {
            sharedSingleton = [[Broker alloc] init];
        }
        
        return sharedSingleton;
    }
}

@end