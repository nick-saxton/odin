def caesar_cipher input, shift
    input_characters = input.split("")

    if shift != 0
        input_characters.map! do |character|
            # Get the integer value of the character
            character_value = character.ord

            # If the character is a letter (uppercase or lowercase) then perform the shift
            if (character_value >= "a".ord and character_value <= "z".ord) or (character_value >= "A".ord and character_value <= "Z".ord)
                # Get the direction of the shift
                if shift < 0
                    shift_direction = -1
                else
                    shift_direction = 1
                end

                # Normalize the shift
                shift = (shift * shift_direction) % 26 * shift_direction

                # Get the shifted value accounting for shifts greater than 26
                shifted_value = character_value + shift

                if shifted_value < "A".ord or (shifted_value > "Z".ord and shifted_value < "a".ord and shift_direction < 0)
                    shifted_value += 26
                elsif shifted_value > "z".ord or (shifted_value > "Z".ord and shifted_value < "a".ord and shift_direction > 0)
                    shifted_value -= 26
                end

                shifted_value.chr
            else
                character
            end
        end
    end

    input_characters.join("")
end