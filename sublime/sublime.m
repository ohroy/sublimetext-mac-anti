//  blog:  http://post.zz173.com
//
//___FILEHEADER___

#import "sublime.h"
#import "substrate.h"




void (*result)(bool arg1,unsigned int* window_list ,unsigned int* license_info);
void (*old_live_validate_license_thread)(void* arg1);
int (*old_reg)(int* arg1,int* arg2,int* arg3,int* arg4,int * arg5);
void check_for_update(bool arg1,unsigned int* window_list ,unsigned int* license_info)
{
    NSLog(@"不让更新哈哈哈!!!!");
    return;
}
void new_live_validate_license_thread(void* arg1){
    NSLog(@"想在线更新????NoWay!!!");
    return;
}
int new_reg(int* arg1,int* arg2,int* arg3,int* arg4,int * arg5)
{
    NSLog(@"来了!!!!");
    return 1;
}


static void __attribute__((constructor)) initialize(void) {
    void* antiUpdate=MSFindSymbol(NULL,"__Z16check_for_updatebP11window_listP12license_info");
    if(antiUpdate){
        NSLog(@"hook now!!!!1");
        MSHookFunction(antiUpdate, check_for_update,(void **)&result);
    }else{
        NSLog(@"antiUpdate path not found!");
    }
    
    
    void* antiLiveValidate=MSFindSymbol(NULL,"__Z28live_validate_license_threadPv");
    if(antiLiveValidate){
        NSLog(@"hook now!!!! antiLiveValidate");
        MSHookFunction(antiLiveValidate, new_live_validate_license_thread,(void **)&old_live_validate_license_thread);
    }else{
        NSLog(@"antiLiveValidate path not found!");
    }
    
    
    void* antiReg=MSFindSymbol(NULL,"__Z11apple_fruitRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPS5_PiS9_Pb");
    
    if(antiReg){
        NSLog(@"hook now!!!! reg");
        MSHookFunction(antiReg, new_reg,(void **)&old_reg);
    }else{
        NSLog(@"antiReg path not found!");
    }
    
}
