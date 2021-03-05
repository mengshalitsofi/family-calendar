class EventsController < ApplicationController

    get '/events' do
        @events = Event.all
        erb :'events/index'
    end

    get '/events/new' do
        erb :'events/new'
    end

    post '/events' do
        item = current_user.events.create(params[:event])
        redirect "events/#{event.id}"
    end

    get '/event/:id' do
        set_event
        if !@event
            redirect '/events'
        end
        erb :'events/show'
    end

    get '/events/:id/edit' do
        set_event
        if !check_owner(@event)
            redirect '/events'
        end
        erb :'events/edit'
    end

    patch '/events/:id' do
        set_event
        if check_owner(@event)
            @event.uptade(params[:event])
        end
        erb :'events/show'
    end

    delete '/events/:id' do
        set_event
        if check_owner(@event)
            @event.delete 
            redirect('/events')
        else
            erb :'events/show'
        end
    end


end
