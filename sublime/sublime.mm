//  blog:  http://post.zz173.com
//
//___FILEHEADER___
#import "sublime.h"
#import "substrate.h"
#import <string>
#import <unistd.h>
#import <sys/mman.h>
void (*result)(bool arg1,unsigned int* window_list ,unsigned int* license_info);
void (*old_live_validate_license_thread)(void* arg1);
int (*old_reg)(std::string arg1,std::string* arg2,int* arg3,int* arg4,bool arg5);
void (*old_remove_license)(int * license_info);
std::string (*old_get_license_path)();

void * dontneed;




void check_for_update(bool arg1,unsigned int* window_list ,unsigned int* license_info)
{
    NSLog(@"不让更新哈哈哈!!!!");
    return;
}
void new_live_validate_license_thread(void* arg1){
    NSLog(@"想在线校验????NoWay!!!");
    return;
}
int new_reg(std::string arg1,std::string* arg2,int* arg3,int* arg4,bool isReg)
{
    NSLog(@"来了!!!!%s",arg1.c_str());
    int ret=old_reg(arg1,arg2,arg3,arg4,isReg);
    NSLog(@"======%d",ret);
    NSLog(@"======%d",isReg);
    if(isReg){
        ret=1;
    }
    return ret;
}

void new_remove_license(int * license_info)
{
    NSLog(@"anti remove");
}

std::string new_get_license_path(){
    std::string s=old_get_license_path();
    NSLog(@"%s",s.c_str());
    return s;
}
int new_verify_signature(std::string arg1,std::string arg2,std::string arg3)
{
    //NSLog(@"%s_%s_%s",arg1.c_str(),arg2.c_str(),arg3.c_str());
    return 1;
}




static void __attribute__((constructor)) initialize(void) {
    void* antiUpdate=MSFindSymbol(NULL,"__Z16check_for_updatebP11window_listP12license_info");
    if(antiUpdate){
        NSLog(@"hook now!!!!1");
        MSHookFunction( antiUpdate, (void *)check_for_update,(void **)&result);
    }else{
        NSLog(@"antiUpdate path not found!");
    }
    
    
    void* antiLiveValidate=MSFindSymbol(NULL,"__Z28live_validate_license_threadPv");
    if(antiLiveValidate){
        NSLog(@"hook now!!!! antiLiveValidate");
        MSHookFunction(antiLiveValidate, (void *)new_live_validate_license_thread,(void **)&old_live_validate_license_thread);
    }else{
        NSLog(@"antiLiveValidate path not found!");
    }
    

//    void* antiReg=MSFindSymbol(NULL,"__Z11apple_fruitRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEPS5_PiS9_Pb");
//    
//    if(antiReg){
//        NSLog(@"hook now!!!! reg");
//        MSHookFunction(antiReg, (void *)new_reg,(void **)&old_reg);
//    }else{
//        NSLog(@"antiReg path not found!");
//    }
    
//    void* antiRemove=MSFindSymbol(NULL,"__Z14remove_licenseP12license_info");
//    
//    if(antiRemove){
//        NSLog(@"hook antiRemove");
//        MSHookFunction(antiRemove, (void *)new_remove_license,(void **)&old_remove_license);
//    }else{
//        NSLog(@"antiRemove path not found!");
//    }
    
    void* antiRemove2=MSFindSymbol(NULL,"__Z16verify_signatureRKNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEES7_S7_");
    if(antiRemove2){
        NSLog(@"hook antiRemove");
        MSHookFunction(antiRemove2, (void *)new_verify_signature,(void **)&dontneed);
    }else{
        NSLog(@"antiRemove path not found!");
    }
}
