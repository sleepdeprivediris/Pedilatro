--- STEAMODDED HEADER
--- MOD_NAME: Pedilatro
--- MOD_ID: Pedilatro
--- MOD_AUTHOR: [Pediluves]
--- MOD_DESCRIPTION: I <3 Gambling.
--- PREFIX: petro
--- badge_colour": "A1A6F0",
--- badge_text_colour: "000000",
----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas({
        key = "modicon",
        path = "pedicon.png",
        px = 32,
        py = 32
    })

SMODS.Atlas {
    key = 'Jokers',      --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71,             --width of one card
    py = 95              -- height of one card
}

-- Fursuit
SMODS.Joker {
    key = "Fursuit",
    loc_txt = { -- local text
        name = 'Fursuit',
        text = {
            '{C:chips}+#1#{} Chips',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            chips = 69,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Sal2B1
SMODS.Joker {
    key = "Sal2B1",
    loc_txt = { -- local text
        name = 'Sal2B1',
        text = {
            'Gains {X:mult,C:white}X0.5{} Mult each time',
            'a {C:attention}Fursuit{} is sold.',
            '{C:inactive}Currently{} {X:mult,C:white}X#1#{} {C:inactive}Mult{}',
        }
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 9 },
    config = {
        extra = {
            xmult = 1,
            xmult_gain = 0.5,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.selling_card == true and context.cardarea == G.jokers and context.card.config.center.key == 'j_petro_Fursuit'
        then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}
-- E Le Rap
SMODS.Joker {
    key = "ELeRap",
    loc_txt = { -- local text
        name = 'E, Le Rap',
        text = {
            'Gives a {C:dark_edition}Negative{} Tag',
            'for every unique numbers',
            'after {C:attention,s:2}e{}.'
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            chips = 69, --configurable value
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } } --#1# is replaced with card.ability.extra.chips
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Rampe d’Escalier
SMODS.Joker {
    key = "RampeEscalier",
    loc_txt = { -- local text
        name = "Rampe D'Escalier",
        text = {
            'If played hand contains a {C:attention}Straight{}',
            'then adds one to the rank',
            'of all cards played',
            '{C:inactive,s:0.7}A 5 becomes a 6 and so on..{}',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 5, y = 0 },
    config = {
    },
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Straight'])
        then
            do
                -- flips all cards
                for i = 1, #G.play.cards do
                    local percent = 1.15 - (i - 0.999) / (#G.play.cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            G.play.cards[i]:flip()
                            play_sound('card1', percent)
                            G.play.cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                delay(0.2)
                -- adds one to rank
                for i = 1, #G.play.cards do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            assert(SMODS.modify_rank(G.play.cards[i], 1))
                            return true
                        end
                    }))
                end
                --unflips
                for i = 1, #G.play.cards do
                    local percent = 0.85 + (i - 0.999) / (#G.play.cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            G.play.cards[i]:flip()
                            G.play.cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
        end
    end
}

-- K-Pri$un
SMODS.Joker {
    key = "KPriSun",
    loc_txt = { -- local text
        name = 'K-Pri$un',
        text = {
            'At the end of round',
            'has {C:green}#1# in #2#{} chance of creating',
            'a {C:dark_edition}Negative{} {C:spectral}Soul{}.',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 9, y = 9 },
    soul_pos = { x = 6, y = 0 },
    config = {
        extra = {
            denominator = 10,
            numerator = 1, --configurable value
        }
    },
    loc_vars = function(self, info_queue, card)
    		local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_KPriSun') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
            return {vars = {new_numerator, new_denominator}}
    		end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and SMODS.pseudorandom_probability(card, 'prout', card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_KPriSun') then
            return {
                SMODS.add_card({ key = 'c_soul', edition = 'e_negative' })
            }
        end
    end
}

-- Pediluves
SMODS.Joker {
    key = "Pediluves",
    loc_txt = { -- local text
        name = 'Pediluves',
        text = {
            '{C:chips}+#1#{} Chips',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    pos = { x = 7, y = 0 },
    config = {
        extra = {
            chips = 69, --configurable value
        }
    },
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- L’Imitateur
SMODS.Joker {
    key = "m2",
    loc_txt = { -- local text
        name = 'M2',
        text = {
            "Copies the joker on",
            'his right, {C:mult,s:1.5}BUT{}',
            '{C:green}#1# in #2#{} chance to destroy it.',
            '#3#',
        },
    },
    atlas = 'Jokers',
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            numerator = 1,
            denominator = 4,
        }
    },
    -- check if joker on left is blueprint compatible and puts it the joker description at #1#
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end}
        end
       local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_m2') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
       return {vars = {new_numerator, new_denominator}}
    end,
    -- destroy triggers all rounds, fix
    calculate = function(self, card, context)
        if context.post_trigger and SMODS.pseudorandom_probability(card, 'MIMIC', card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_m2') then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end
          end
             local other_joker = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
                end
                return SMODS.blueprint_effect(card, other_joker, context)
        end
}
--Will Wood
SMODS.Joker {
    key = "WillWood",
    loc_txt = { -- local text
        name = 'Will Wood',
        text = {
            'Swap {C:chips}Chips{} and {C:mult}Mult{} ',
            'then {C:green}#1# in #2#{} to {X:mult,C:white}x1.5{} Mult{}',
            'or {C:green}#1# in #2#{} to {X:chips,C:white}x1.5{} Chips{}',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 8, y = 0 },
    config = {
        extra = {
            x_chips = 1.5,
            xmult = 1.5,
            numerator = 1,
            denominator = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        		local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_WillWood_1') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
                return {vars = {new_numerator, new_denominator}}
        		end,
    calculate = function(self, card, context)
        if context.joker_main and SMODS.pseudorandom_probability(card, 'Will', card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_WillWood_1') then
            return {
                swap = true,
                message = localize({
                    type = "variable",
                    key = "a_xchips",
                    vars = { number_format(card.ability.extra.x_chips) },
                }),
                Xchip_mod = lenient_bignum(card.ability.extra.x_chips),
                colour = G.C.CHIPS,
            }
        elseif context.joker_main and SMODS.pseudorandom_probability(card, 'Wood', card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_WillWood_2') then
            return {
                swap = true,
                xmult = card.ability.extra.xmult,
                message = "x 1.5 Mult",
                colour = G.C.MULT,
            }
        end
    end
}

--Starwalker
SMODS.Joker {
    key = "Starwalker",
    loc_txt = { -- local text
        name = 'The Original,      Starwalker',
        text = {
            'This blind is {C:red,s:1.5}Pissing me off...{}',
            "I'm the original             {C:attention,s:1.5}Starwalker{}",
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 9, y = 0 },
    config = {
        extra = {
            numerator = 1,
            denominator = 10,
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind and SMODS.pseudorandom_probability(card, 'piss', card.ability.extra.numerator, card.ability.extra.denominator, 'j_petro_Starwalker') then
            return {

                message = 'THIS',
                colour = G.C.GOLD,
                delay = 1.5,
                extra =
                {
                    message = "BLIND",
                    colour = G.C.GOLD,
                    delay = 1.5,
                    extra =

                    {
                        message = 'IS',
                        colour = G.C.GOLD,
                        delay = 1.5,
                        extra =
                        {
                            message = 'PISSING',
                            colour = G.C.RED,
                            delay = 1.5,
                            extra =
                            {
                                message = 'ME',
                                colour = G.C.RED,
                                delay = 1.5,
                                scale = 1.5,
                                extra =
                                {
                                    message = 'OFF',
                                    colour = G.C.RED,
                                    scale = 2,
                                    delay = 1.5,
                                }
                            }
                        }
                    }
                },
                func = function()
                    G.E_MANAGER:add_event(
                        Event({
                            trigger = "immediate",
                            func = function()
                                if G.STATE ~= G.STATES.SELECTING_HAND then
                                    return false
                                end
                                G.GAME.chips = G.GAME.blind.chips
                                G.STATE = G.STATES.HAND_PLAYED
                                G.STATE_COMPLETE = true
                                end_round()
                                return true
                            end,
                        }),
                        "other"
                    )
                end
            }
        end
    end
}


-- John Crypto
SMODS.Joker {
    key = "JohnCrypto",
    loc_txt = { -- local text
        name = 'John Crypto',
        text = {
            '{C:chips}+#1#{} Chips',
        },
    },
    atlas = 'Jokers', --atlas' key
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            chips = 69, --configurable value
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } } --#1# is replaced with card.ability.extra.chips
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
----------------------------------------------
------------MOD CODE END----------------------
