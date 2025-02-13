#!/bin/bash

run_mode="$1" # test or pkg

mod_name="PersonalTeslaDefenseEquipment"
mod_version=$(cat ./VERSION)
mod_zip_name="${mod_name}_${mod_version}.zip"
info_json="${mod_name}/info.json"
changelog="${mod_name}/changelog.txt"

if [ "$run_mode" == pkg ]; then
    # update version in info.json
    sed -i "s/\"version\":\"[0-9]*\.[0-9]*\.[0-9]*\"/\"version\":\"$mod_version\"/" "$info_json"

    # create a new changelog entry if the version in our VERSION file is greater than version in latest changelog entry
    changelog_version_line=$(grep -m 1 "^Version:" "$changelog")
    if [[ "$changelog_version_line" == Version:* ]]; then
        changelog_version="${changelog_version_line#Version: }"
        # somehow got a random \r in there at some point and it was screwing up the comparison...
        cleaned_changelog_version="${changelog_version//$'\r'/}"

        # echo "$cleaned_changelog_version" | od -c
        # echo "-------------------"
        # echo "$mod_version" | od -c

        # since we were able to grab a version from the changelog, check it against current VERSION file
        if [ "$mod_version" != "$cleaned_changelog_version" ]; then
            # current version does not match latest changelog so create new entry

            # prompt dev for changelog text.
            valid_change_header=""
            while [ "$valid_change_header" = "" ]; do
                # Use select to create a menu
                options=("Features" "Changes" "Bugs")
                select opt in "${options[@]}"; do
                    case $opt in
                        "Features")
                            valid_change_header="Features"
                            break
                            ;;
                        "Changes")
                            valid_change_header="Changes"
                            break
                            ;;
                        "Bugs")
                            valid_change_header="Bugs"
                            break
                            ;;
                        *) 
                            echo "Invalid option."
                            break
                            ;;
                    esac
                done
            done
            
            # had to clear IFS to make this work with the -r option, which shellcheck wants.
            IFS= read -rp "Enter a description: " change_description

            changelog_delimiter="---------------------------------------------------------------------------------------------------"
            new_entry="$changelog_delimiter\nVersion: $mod_version\nDate: $(date +"%Y.%m.%d")\n  $valid_change_header:\n    - $change_description\n"

            {
                echo -e "$new_entry"
                cat "$changelog"
            } > "$changelog.tmp"

            mv "$changelog.tmp" "$changelog"

            echo "Created placeholder changelog entry for current version."
        else
            echo "Changelog version matches VERSION file, not creating entry."
        fi
    else
        echo "Could not read a version from changelog, not creating new entry."
    fi
fi

# create the zip
mkdir -p ./pkg
rm ./pkg/"${mod_name}"*.zip
zip -rq  "pkg/$mod_zip_name" "$mod_name"

if [ "$run_mode" == test ]; then
    # cleanup old mod and copy over current
    rm "${HOME}"/.factorio/mods/"${mod_name}"*
    cp -r ./pkg/"${mod_zip_name}" "${HOME}/.factorio/mods/${mod_zip_name}"

    # now start factorio through steam
    steam steam://rungameid/427520
fi