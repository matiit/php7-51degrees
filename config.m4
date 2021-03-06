dnl $Id$
dnl config.m4 for extension fiftyonedegrees

dnl Comments in this file start with the string 'dnl'.
dnl Remove where necessary. This file will not work
dnl without editing.

dnl If your extension references something external, use with:

PHP_ARG_WITH(fiftyonedegrees, for fiftyonedegrees support,
dnl Make sure that the comment is aligned:
[  --with-fiftyonedegrees            Include fiftyonedegrees support])

dnl Otherwise use enable:

dnl PHP_ARG_ENABLE(fiftyonedegrees, whether to enable fiftyonedegrees support,
dnl Make sure that the comment is aligned:
dnl [  --enable-fiftyonedegrees           Enable fiftyonedegrees support])

if test "$PHP_FIFTYONEDEGREES" != "no"; then
  dnl Write more examples of tests here...

  dnl # --with-fiftyonedegrees -> check with-path
  SEARCH_PATH="/usr/local /usr"     # you might want to change this
  SEARCH_FOR="/deviceDetection/pattern/51Degrees.h"  # you most likely want to change this
  if test -r $PHP_FIFTYONEDEGREES/$SEARCH_FOR; then # path given as parameter
     FIFTYONEDEGREES_DIR=$PHP_FIFTYONEDEGREES
  else # search default path list
    AC_MSG_CHECKING([for fiftyonedegrees files in default path])
    for i in $SEARCH_PATH ; do
      if test -r $i/$SEARCH_FOR; then
        FIFTYONEDEGREES_DIR=$i
        AC_MSG_RESULT(found in $i)
      fi
    done
  fi
  dnl
  if test -z "$FIFTYONEDEGREES_DIR"; then
      PHP_ADD_INCLUDE($PHP_FIFTYONEDEGREES/deviceDetection)
      PHP_ADD_BUILD_DIR($PHP_FIFTYONEDEGREES/deviceDectecion)
      PHP_ADD_BUILD_DIR($PHP_FIFTYONEDEGREES/deviceDectecion/cityhash)
      PHP_ADD_BUILD_DIR($PHP_FIFTYONEDEGREES/deviceDectecion/pattern)
      FIFTYONEDEGREES_CFLAGS= "-I$PHP_FIFTYONEDEGREES/deviceDectecion $FIFTYONEDEGREES_CFLAGS"
      deviceDectecion_src="deviceDetection/threading.c      \
                   deviceDetection/pattern/51Degrees.c       \
                   deviceDetection/cityhash/city.c"      
  else 
      dnl # --with-fiftyonedegrees -> check for lib and symbol presence
      LIBNAME=51degreess # you may want to change this
      LIBSYMBOL=fiftyoneDegreesWorkset # you most likely want to change this 

      PHP_CHECK_LIBRARY($LIBNAME,$LIBSYMBOL,
      [
        PHP_ADD_LIBRARY_WITH_PATH($LIBNAME, $FIFTYONEDEGREES_DIR/$PHP_LIBDIR, FIFTYONEDEGREES_SHARED_LIBADD)
        AC_DEFINE(HAVE_FIFTYONEDEGREESLIB,1,[ ])
      ],[
        AC_MSG_ERROR([wrong 51degreess lib version or lib not found])
      ],[
        -L$FIFTYONEDEGREES_DIR/$PHP_LIBDIR -lm
      ])
      dnl # --with-fiftyonedegrees -> add include path
      PHP_ADD_INCLUDE($FIFTYONEDEGREES_DIR/deviceDetection/pattern)
      PHP_ADD_INCLUDE($FIFTYONEDEGREES_DIR/deviceDetection/city)
      PHP_ADD_INCLUDE($FIFTYONEDEGREES_DIR/deviceDetection)
  fi


  dnl
  PHP_SUBST(FIFTYONEDEGREES_CFLAGS)
  PHP_SUBST(FIFTYONEDEGREES_SHARED_LIBADD)

  PHP_NEW_EXTENSION(fiftyonedegrees, fiftyonedegrees.c $deviceDectecion_src, $ext_shared)
fi
