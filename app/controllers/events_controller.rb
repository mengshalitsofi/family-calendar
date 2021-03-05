class EventsController < ApplicationController

    get '/events' do
        redirect_if_not_logged_in
        @events = Event.all
        erb :'events/index'
    end

    post '/events' do
        redirect_if_not_logged_in
        event = current_user.events.create(
            :title => params[:title],
            :description => params[:description],
            :event_time => params[:event_time],
            :location => params[:location]
        )
        redirect "/events"
    end

    get '/events/new' do
        redirect_if_not_logged_in
        erb :'events/new'
    end

    get '/events/:id' do
        redirect_if_not_logged_in
        set_event
        if !@event
            redirect '/events'
        end
        erb :'events/show'
    end

    get '/events/:id/edit' do
        redirect_if_not_logged_in
        set_event
        if !check_owner(@event)
            redirect '/events'
        end
        erb :'events/edit'
    end

    patch '/events/:id' do
        redirect_if_not_logged_in
        set_event
        if check_owner(@event)
            @event.update(
                :event_time => params[:event_time],
                :title => params[:title],
                :location => params[:location]
            )
        end
        erb :'events/show'
    end

    get '/events/:id/delete' do
        redirect_if_not_logged_in
        set_event
        if check_owner(@event)
            @event.delete 
            redirect('/events')
        else
            erb :'events/show'
        end
    end

    def set_event
        @event = Event.find_by(id: params[:id])
    end
end
