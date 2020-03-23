#!/usr/bin/env sh

number_of_sticky_windows=$(
        yabai -m query --windows |
                jq -r "[.[] | select(.sticky == 1) | .id] | unique | length"
)

params=$(
        yabai -m query --spaces |
                jq -r "[.[] | select((.windows | length > ${number_of_sticky_windows}) or .focused == 1)]
                        | reduce .[] as \$i (
                                {shift: 0, focused: 0, spaces: []};
                                if \$i.\"native-fullscreen\" == 1 then
                                        {shift: (.shift + 1), focused: .focused, spaces: (.spaces + [\"'f'\"])}
                                elif \$i.focused == 1 then
                                        {shift: .shift, focused: (\$i.index - .shift | tostring), spaces: (.spaces + [\$i.index - .shift | tostring])}
                                else
                                        {shift: .shift, focused: .focused, spaces: (.spaces + [\$i.index - .shift | tostring])}
                                end
                            )
                        | [(.spaces | join(\",\") | \"{\" + . + \"}\"), .focused]
                        | join(\",\")
                "
)

hs -c "spaces.update($params)"
