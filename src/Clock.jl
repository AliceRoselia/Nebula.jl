mutable struct Clock <: System
    started::Base.Event
    stopped::Bool
    #fire_sec::Bool
    #fire_msec::Bool
    #fire_usec::Bool
    #fire_nsec::Bool
    message_fires::Vector{Tuple{float,Function,String}}
    freq::AbstractFloat
  end