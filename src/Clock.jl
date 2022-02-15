#My take based on starlight engine.

#TODO: examine the message_fires, examine whether it should fire multiple messages or not, or if we should just have different clocks.

#=
mutable struct Clock
    started::Base.Event
    stopped::Bool
    message_fires::Vector{Tuple{float,Function,String}}
    freq::AbstractFloat
    #TODO: add this.
    #log::Message_receiver
    #The clock would receive this message. Then, 
end


Clock() = Clock(Base.Event(), true, [], (1.0/60)) # default frequency of approximately 60 Hz
  
  
  # RT == "real time"
  # Δ carries the "actual" number of given time units elapsed
struct RT_SCALE{scale, signature}
    Δ::Float
end
const SIG_TIME_COUNT = 0
const SIG_TIME_TICK = 1
RT_SEC = RT_SCALE{1.0, SIG_TIME_COUNT}
RT_MSEC = RT_SCALE{1e-3, SIG_TIME_COUNT}
RT_USEC = RT_SCALE{1e-6, SIG_TIME_COUNT}
RT_NSEC = RT_SCALE{1e-9, SIG_TIME_COUNT}
TICK = RT_SCALE{1.0, SIG_TIME_TICK}


struct SLEEP_TIME
  Δ::UInt # time in nanoseconds to sleep for
end

function Base.sleep(s::SLEEP_TIME)
  t1 = time_ns()
  while true
    if time_ns() - t1 >= s.Δ break end
    yield()
  end
  return time_ns() - t1
end

function sleep_with_message(sleep_time,timescale, message, debug)
  δ = sleep(SLEEP_TIME(sleep_time*timescale))
  sendMessage(message(δ/timescale))
  #TODO: define sendMessage.
  #@debug debug
end

nsleep(Δ) = sleep_with_message(Δ,1.0, RT_NSEC, "nanosecond")
usleep(Δ) = sleep_with_message(Δ,1e3, RT_USEC, "microsecond")
msleep(Δ) = sleep_with_message(Δ,1e6, RT_MSEC, "millisecond")
ssleep(Δ) = sleep_with_message(Δ,1e9, RT_SEC, "second")
tick(Δ) = sleep_with_message(Δ,1e9, TICK, "tick")

function job!(c::Clock, f, arg=1)
  function job()
    Base.wait(c.started)
    while !c.stopped
      f(arg)
    end
  end
  schedule(Task(job))
end

function awake!(c::Clock)
  for i in c.message_fires
    job!(c, Δ-> sleep_with_message(Δ,i[1], i[2], i[3]))
  end

  job!(c, tick, c.freq)

  c.stopped = false

  Base.notify(c.started)

  return true
end

function shutdown!(c::Clock)
  c.stopped = true
  c.started = Base.Event() # old one remains signaled no matter what, replace
  return false
end


=#



abstract type Relay{info_in, info_out} end
abstract type Clock{tick}<:Relay{Nothing, tick} end
struct Clock_handle{info}<:Relay{info, info}
    C::Channel{info}
end

function tick!(X::Clock_handle)
    wait(X.C)
    return take!(X.C)
end

struct standard_clock<:Relay{Float64}
    t::float64
end

struct Functional_relay{info_in, info_out} <: Relay{info_in, info_out}
    C::Channel{info_in}
    Out::Vector{Channel{info_out}}
    func::Function
end