
simple-sessions.vim: A very simple way to manage vim sessions


Author: Andres Rodriguez


Installation
============

Installing using vim-plug:
 *  `Plug 'lostgoat/vim-simple-session'`

Similar instructions should also work for other plugin managers.

Instructions
============

This plugin will automatically restore a session based on your current directory.

If vim is started with any arguments, no session is loaded.

This plugin provides the following commands:
  * SaveSession
  * RestoreSession

Mappings
========

You might want to create some shortcuts:
```
map <leader>s :SaveSession<CR>
map <leader>r :RestoreSession<CR>
```
