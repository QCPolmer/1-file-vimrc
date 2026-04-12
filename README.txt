Personal 1-file vimrc: 
-- 'kj' to return to normal mode
-- 'df' in normal mode to bring up menu
-- windows-style-hotkeys
-- runs on dos version of vim and later (the 7.3 branch)
-- 'ctrl+s' saves and attempts to launch open file, if no launch method found, 
  makes a local '.cmd' file to allow editing/launching the file
  (if 'm.cmd' is found above open file in file tree, launches that instead 
    making custom file)
-- lines staring with '=' in edit mode will attempt to run
  as vim-code and show results 
-- a bookmarking system/condense functions built into menu
-- a ton more features, mostly self contained in functions. 
    ( see the menu, mostly functions can probably 
      be copy/pasted and used in isolation, 
      some may need 'helper' functions also copied)

(online version of vim, would need to copy-past vimrc):
https://github.com/programmerhat/vim-online-editor
https://www.vimonlineeditor.com/
