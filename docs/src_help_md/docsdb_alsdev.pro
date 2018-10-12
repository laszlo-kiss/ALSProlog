[   xpge(development_environment,'Edit Menu','Edit_Menu','Edit Menu'-1,
        [p('Edit Menu','Select actions while editing a file')]),
    xpge(development_environment,'File Menu','File_Menu','File Menu'-1,
        [p('File Menu','Select a file for editing')]),
    xpge(development_environment,'Find  dialog','Find_dialog',
        'Find Dialog'-1,
        [p('Find Dialog','Search and replace in edit windows')]),
    xpge(development_environment,'Listener Window','Listener_Window',
        'Listener Window'-1,
        [p('Listener Window','Primary interaction window')]),
    xpge(development_environment,'Preferences Dialog:','Preferences_Dialog',
        'Preferences Dialog'-1,
        [p('Preferences Dialog','Set various IDE preferences')]),
    xpge(development_environment,'Prolog Menu','Prolog_Menu',
        'Prolog Menu'-1,
        [p('Prolog Menu','Manage prolog system and settings')]),
    xpge(development_environment,'Prolog Projects Menu','Prolog_Projects_Menu',
        'Prolog Projects Menu'-1,
        [p('Prolog Projects Menu','Manage prolog projects')]),
    xpge(development_environment,'Tools Menu','Tools_Menu','Tools Menu'-1,
        [p('Tools Menu','Invoke various useful tools')]),
    xpge(gui_library,'atomic_input_dialog/[2,3,4]',atomicinputdialog234,
        atomic_input_dialog,
        [p('atomic_input_dialog/[2,3,4]','input atoms and numbers')]),
    xpge(gui_library,'display_image/[1,3]',displayimage13,create_image,
        [p('create_image/[2,3]','create an image from a GIF file'),
            p('display_image/[1,3]','display an image')]),
    xpge(gui_library,'extend_main_menubar/2',extendmainmenubar2,
        add_to_main_menu_entry,
        [p('extend_main_menubar/2','add entries to the main menubar'),
            p('menu_entries_list/[2,3]','obtain menu entries'),
            p('path_to_menu_entry/[2,3,4]',
                'obtain path to a menu entry'),
            p('add_to_main_menu_entry/2','add an item to a menu entry'),
            p('extend_cascade/3','extend a menu cascade')]),
    xpge(gui_library,'file_select_dialog/[1,2,3]',fileselectdialog123,
        file_select_dialog,
        [p('file_select_dialog/[1,2,3]','select a file')]),
    xpge(gui_library,'info_dialog/[1,2,3]',infodialog123,info_dialog,
        [p('info_dialog/[1,2,3]','present an information dialog')]),
    xpge(gui_library,'init_tk_alslib/[0,1,2]',inittkalslib012,init_tk_alslib,
        [p('init_tk_alslib/0',initialize),
            p('init_tk_alslib/1',
                'initialize GUI library, creating Tcl interpreter'),
            p('init_tk_alslib/1','initialize GUI library, creating')]),
    xpge(gui_library,'popup_select_items/[2,3,4]',popupselectitems234,
        popup_select_items,
        [   p('popup_select_items/[2,3,4]',
                'present popup selection list')]),
    xpge(gui_library,'yes_no_dialog/[2,3,4]',yesnodialog234,yes_no_dialog,
        [p('yes_no_dialog/[2,3,4]','present a yes/no dialog')]),

    xpge(prolog_objects,'create_object/2',createobject2,create_object,
        [p('create_object/2','create an object')]),
    xpge(prolog_objects,'defStruct/2',defStruct2,defStruct,
        [p('defStruct/2','specify an abstract data type')]),
    xpge(prolog_objects,'defineClass/1',defineClass1,defineClass,
        [p('defineClass/1','specify an ObjectPro class')]),
    xpge(prolog_objects,'send/2',send2,send,
        [p('send/2','send a message to an object')]),
    xpge(prolog_objects,'setObjStruct/3',setObjStruct3,cessObjStruct,
        [p('setObjStruct/3','set the value of a slot in an object'),
            p('accessObjStruct/3','access the value of a slot in an object')]),


    xpge(tcltk_interface,prolog,prolog,prolog-1,
        [p(prolog,'call a prolog term from Tcl')]),
    xpge(tcltk_interface,'tcl_call/3',tclcall3,tcl_call,
        [p('tcl_call/3','execute Tcl script'),
            p('tcl_eval/3','evaluate Tcl script')]),
    xpge(tcltk_interface,'tcl_coerce_number/3',tclcoercenumber3,
        tcl_coerce_atom,
        [p('tcl_coerce_number/3','convert Tcl entity to Prolog number'),
            p('tcl_coerce_atom/3','convert Tcl entity to Prolog atom'),
            p('tcl_coerce_list/3','convert Tcl entity to Prolog list')]),
    xpge(tcltk_interface,'tcl_delete/1',tcldelete1,tcl_delete,
        [p('tcl_delete/1','delete a Tcl interpreter'),
            p('tcl_delete_all/0','delete all Tcl interpreters')]),
    xpge(tcltk_interface,'tcl_new/1',tclnew1,tcl_new,
        [p('tcl_new/1','create a Tcl interpreter'),
            p('tk_new/1','create a Tcl interpreter initialized for Tk')])].
