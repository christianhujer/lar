#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/file.h>

const char *lockSuffix = ".lock";
const char *archiveSuffix = ".a";
const char *ar = "ar";

bool endsWith(const char *string, const char *suffix)
{
    const char *hit = strstr(string, suffix);
    return hit && (strlen(hit) == strlen(suffix));
}

char *strdupcat(const char *string1, const char *string2)
{
    size_t l1 = strlen(string1), l2 = strlen(string2);
    char *string = malloc(l1 + l2 + 1);
    memcpy(string, string1, l1);
    memcpy(string + l1, string2, l2);
    return string;
}

const char *getLockFileName(char *argv[])
{
    for (;*argv; argv++)
        if (endsWith(*argv, archiveSuffix))
            return strdupcat(*argv, lockSuffix);
    return NULL;
}

void attemptLock(const char *lockFileName)
{
    if (lockFileName == NULL) return;
    int fd = open(lockFileName, O_CREAT | O_WRONLY, 0666);
    if (!fd || flock(fd, LOCK_EX)) perror(NULL);
}

int main(int argc, char *argv[])
{
    attemptLock(getLockFileName(argv));
    argv[0]++; // lar -> ar, skip l prefix. That allows users to create hardlinks to other librarians, too.
    execvp(argv[0], argv);
}
