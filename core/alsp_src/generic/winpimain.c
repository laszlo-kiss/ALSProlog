/*=====================================================================*
 |		pimain.c
 |	Copyright (c) 1988-1995, Applied Logic Systems, Inc.
 |
 |		-- default main() that initializes prolog and starts
 |			the development shell.
 |
 *=====================================================================*/

#ifdef HAVE_CONFIG_H
	/* In ALS-Prolog source tree */

#include "defs.h"

#else /* !HAVE_CONFIG_H */
	/* Not in ALS-Prolog source tree... */

#include <stdio.h>
#include <stdlib.h>

#include "alspi.h"

#endif /* !HAVE_CONFIG_H */

#include "pi_init.h"
#include "pi_cfg.h"


#include <windows.h>
#include <winsock.h>


static int ConsoleIO(int port, char *buf, size_t size)
{
    HANDLE f;
    int result;
    
    switch(port) {
    case CONSOLE_READ:
    	f = GetStdHandle(STD_INPUT_HANDLE);
    	if (ReadFile(f, buf, size, &result, NULL)) return result;
    	else return -1; 
    	break;
    case CONSOLE_WRITE:
    	f = GetStdHandle(STD_OUTPUT_HANDLE);
    	if (WriteFile(f, buf, size, &result, NULL)) return result;
    	else return -1;
    	break;
    case CONSOLE_ERROR:
    	f = GetStdHandle(STD_ERROR_HANDLE);
    	if (WriteFile(f, buf, size, &result, NULL)) return result;
    	else return -1;
    	break;
    }
    
}


static int ProcessCmdLine(HINSTANCE hInstance, LPSTR lpCmdLine, char ***argh)
{
	char *line, *w;
	int s, c;
	char filename[1000];
	
	GetModuleFileName(hInstance, filename, 1000);
	s = strlen(lpCmdLine) + strlen(filename);
	line = malloc(s+1);
	strcpy(line, filename);
	strcat(line, " ");
	strcat(line, lpCmdLine);
	
	*argh = malloc(50*sizeof(char *));
	c = 0;
	w = strtok(line, " ");
	while (w) {
	    c++;
	    *argh = realloc(*argh, c*sizeof(char *));
	    (*argh)[c-1] = w;
	    w = strtok(NULL, " ");
	}
	
	return c;
}


extern HINSTANCE WinMain_Instance;
extern HINSTANCE WinMain_PrevInstance;
extern LPSTR WinMain_CmdLine;
extern int WinMain_CmdShow;

int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
    int   exit_status;
    int argc;
    char **argv;
    
    WinMain_Instance = hInstance;
    WinMain_PrevInstance = hPrevInstance;
    WinMain_CmdLine = lpCmdLine;
    WinMain_CmdShow = nCmdShow;
    
    argc = ProcessCmdLine(hInstance, lpCmdLine, &argv);

#ifdef APP_PRINTF_CALLBACK 
    PI_set_app_printf_callback(app_printf);
#endif

    if (!AllocConsole()) exit(EXIT_FAILURE);
    PI_set_console_callback(ConsoleIO);

    if ((exit_status = PI_prolog_init(argc, argv)) != 0) {
	PI_app_printf(PI_app_printf_error, "Prolog init failed !\n");
	exit(EXIT_FAILURE);
    }

    pi_init();

    if ((exit_status = PI_toplevel()) != 0) {
	PI_app_printf(PI_app_printf_error, "Prolog shell crashed !\n");
	exit(EXIT_FAILURE);
    }

    PI_shutdown();
    
    exit(EXIT_SUCCESS);
}
