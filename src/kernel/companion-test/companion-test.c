#include <linux/init.h>
#include <linux/module.h>

static int __init companion_test_init(void)
{
    pr_info("companion-test: module loaded\n");
    return 0;
}

static void __exit companion_test_exit(void)
{
    pr_info("companion-test: module unloaded\n");
}

module_init(companion_test_init);
module_exit(companion_test_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Akshat Sharma");
MODULE_DESCRIPTION("Pi Zero Companion test kernel module");
