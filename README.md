this repo isn't an *actual* CS! it's just a modified template, for myself. it has changes to the .lua and .blend which i *personally* think feels better and speeds up things overall for new CS projects i make (by using my naming conventions and etc); that being said, it's not for everyone but there isn't any harm in making it public, i guess :P

changes:
- .blend (not done)
  - remove auto pack from blend
  - model already in tpose
  - separate armature for easy physbones additions
  - fix custom_cmd on caps
- .lua
  - remove most comments
  - fix duplicate entry in voicetable
  - add more charSelect functions (like animation, character transition texture)
  - add quickly swapable name for ease of use (replace "REPLACE" with the actual character's name, case match on)
- github
  - add .gitignore path /temp, /tmp, /old

TO DO: add modeling guides here (corrective scale, wings on back, physbones additions, etc), set animation names to CHAR_ANIM_X, maybe make mario use the least amount of materials possible (he's going to get replaced anyways), attempt to remove unnecessary data from template to decrease file size

NOT PLANNED: fixing settings for animations in the new animation manager
