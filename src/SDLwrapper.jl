#A thin SDL wrapper based on starlight and gamezero.

#https://github.com/jhigginbotham64/Starlight.jl/blob/main/src/SDL.jl
#https://github.com/aviks/GameZero.jl/blob/master/src/GameZero.jl






function initSDL(;buffers=4,samples=4,flags=MIX_INIT_FLAC|MIX_INIT_MP3|MIX_INIT_OGG)
    #From gamezero, but parameterized to make it more generic.
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, buffers)
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, samples)
    r = SDL_Init(UInt32(SDL_INIT_VIDEO | SDL_INIT_AUDIO))
    if r != 0
        error("Unable to initialise SDL: $(getSDLError())")
    end
    TTF_Init()

    inited = Mix_Init(Int32(flags))
    if inited & flags != flags
        @warn "Failed to initialise audio mixer properly. All sounds may not play correctly\n$(getSDLError())"
    end

    device = Mix_OpenAudio(Int32(22050), UInt16(MIX_DEFAULT_FORMAT), Int32(2), Int32(1024) )
    if device != 0
        @warn "No audio device available, sounds and music will not play.\n$(getSDLError())"
        Mix_CloseAudio()
    end
end



function getSDLError()
    x = SDL_GetError()
    return unsafe_string(x)
end





function quitSDL()
    #This part is from gamezero and starlight.
    #TODO: make the game also destroy windows/everything before actually quitting SDL.
    Mix_HaltMusic()
    Mix_HaltChannel(Int32(-1))
    Mix_CloseAudio()
    TTF_Quit()
    Mix_Quit()
    SDL_Quit()
end