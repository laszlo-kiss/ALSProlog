#include <SysTypes.r>

#include "version.h"

resource 'vers' (1, purgeable) {
	VERSION_MAJOR, VERSION_MINOR, release, 0, verUS,
	VERSION_STRING,
	VERSION_STRING " � Applied Logic Systems, Inc. 1997"
};