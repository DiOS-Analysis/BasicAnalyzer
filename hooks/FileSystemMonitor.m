#import <Foundation/Foundation.h>
#import <stdio.h>
#import "substrate.h"
#import "FileSystemMonitor.h"
#import "../Broker.h"

// Sample DiOS hook to monitor app file system accesses
static int (*original_open)(const char *path, int oflag, mode_t mode);
static FILE* (*original_fopen) ( const char * filename, const char * mode );

static void handleOpen(const char* path) {

    if(path != NULL) {
       
        NSString *pathString = [[NSString stringWithUTF8String:path] stringByResolvingSymlinksInPath];

        // Results are cached within the broker instance 
        // and are delivered to the DiOS backend when app execution has finished
        [[Broker sharedInstance] saveOpenPath:pathString];
        
    }

}

static int replaced_open(const char *path, int oflag, mode_t mode) {

  	handleOpen(path);  
    return original_open(path, oflag, mode);
}

static FILE* replaced_fopen(const char *filename, const char * mode) {
    
    handleOpen(filename); 
    return original_fopen(filename, mode);
}


@implementation FileSystemMonitor : NSObject

+(void) enableHooks {
	MSHookFunction((void*)open, (void*)replaced_open, (void**)&original_open);
    MSHookFunction((void*)fopen, (void*)replaced_fopen, (void**)&original_fopen);
}

@end
