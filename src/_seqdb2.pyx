cdef extern from "dbread.h":
    ctypedef char * (*getType)(unsigned)
    ctypedef void (*getRecord)(long long)
    ctypedef void (*clear)()
    ctypedef long long (*getSize)()
    ctypedef unsigned (*getTypesize)()
    ctypedef struct c_dbread "dbread":
        getType getType
        getRecord getRecord
        clear clear
        getSize getSize
        getTypesize getTypesize

    c_dbread *new_dbread "new dbread" (char * filename)
    void del_dbread "delete" (c_dbread *db)

cdef class dbread:
    cdef c_dbread *thisptr              # wrapped C++ instance

    def __cinit__(self, filename):
        self.thisptr = new_dbread(filename)
        
    def __dealloc__(self):
        del_dbread(self.thisptr)

    def getRecord(self, idx):
        self.thisptr.getRecord(idx)
        return
    
    def getType(self, typ):
        return self.thisptr.getType(typ)

    def clear(self):
        self.thisptr.clear()
        return

    def getSize(self):
        return self.thisptr.getSize()

    def getTypesize(self):
        return self.thisptr.getTypesize()