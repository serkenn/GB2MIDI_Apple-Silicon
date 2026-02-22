-- GB2MIDI Apple Silicon build source
-- Converts GarageBand loop .aif/.aiff files to .mid via bundled Perl script.

use scripting additions

on run
  set selected_items to choose file with prompt "Select GarageBand loop .aif/.aiff files" with multiple selections allowed
  my convert_items(selected_items)
end run

on open dropped_items
  my convert_items(dropped_items)
end open

on convert_items(item_list)
  if item_list is {} then return

  set script_folder to POSIX path of (path to me)
  set perl_path to script_folder & "Contents/Resources/Scripts/gb2midi.pl"

  repeat with an_item in item_list
    set file_info to info for an_item
    set ext to name extension of file_info
    if ext is "aif" or ext is "aiff" then
      set gb_file to POSIX path of an_item
      set base_len to (length of ext) + 1
      set mid_file to (text 1 thru -base_len of gb_file) & "mid"
      do shell script "/usr/bin/perl " & quoted form of perl_path & " " & quoted form of gb_file & " " & quoted form of mid_file
    end if
  end repeat

  tell application "Finder" to open (container of (item 1 of item_list)) as alias
end convert_items
