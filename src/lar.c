// Argl... why does this have to be so complicated.
// What I really want is that ar becomes a monitor.
// What I would like to have therefore is a mutex.
// pthreads doesn't tell me if the mutex only works for the threads of the process, or globally.
// C11 mutexes seem to only work for the threads within the same process.
// So, right now considering to go for a binary semaphore instead, but XSI IPC *shiver* is so ugly.
// Or should I use a file and file events like <sys/inotify.h>?
// And what about portability, it shall run on Cygwin, too...
// Or maybe (advisory, as we're the sole owner of the file) record locking?

int main(int argc, const char *argv[])
{
    const char *lockFileName = getLockFileName(argv);
    obtainLock(lockFileName);
    invokeAr(argv);
    releaseLock(lockFileName);
}
