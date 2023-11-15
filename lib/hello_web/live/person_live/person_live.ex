defmodule HelloWeb.PersonLive.PersonLive do

  use HelloWeb, :live_view

  import Phoenix.Component

  import MyServer.Database.Person

  alias Hello.Persons.Person

  alias Hello.Persons

  def mount(_params , _session , socket) do
  	{:ok , socket}
  end

  def handle_params(params , _url , socket) do
	{:noreply , apply_action(socket , socket.assigns.live_action , params)}
  end

  def handle_event("validate" , %{"person" => params} , socket) do
	form = %Person{}
		|> Persons.change_person(params)
		|> Map.put(:action , :insert)
		|> to_form
	{:noreply , assign(socket , form: form)}
  end	

  def handle_event("save" , %{"person" => params} , socket) do
	case Persons.create_person(params) do
		{:ok , _person} ->
			{:noreply , socket
				    |> put_flash(:info , "person created successfully")
				    |> push_patch(to: ~p"/livepersons")
			}
		{:error , changeset} ->
			{:noreply , assign(socket , form: changeset
							  |> Map.put(:action , :insert)
							  |> to_form
					)
		}
	end
  end

  def handle_event("update" , %{"person" => params} , socket) do
	person = socket.assigns.person
	case Persons.update_person(person , params) do
		{:ok , _person} ->
			{:noreply , socket
				    |> put_flash(:info , "person updated successfully")
				    |> push_patch(to: ~p"/livepersons")
			}
		{:error , changeset} ->
			{:noreply , assign(socket , form: changeset
							  |> Map.put(:action , :insert)
							  |> to_form
					)
		}
	end
  end		

  defp apply_action(socket , :index , _params) do
	persons = Persons.get_all_persons()
	assign(socket , persons: persons)
  end

  defp apply_action(socket , :new , _params) do
	form = %Person{}
		|> Persons.change_person()
		|> to_form	
	assign(socket , form: form)
  end

  defp apply_action(socket , :edit , %{"id" => id}) do
	person = Persons.get_person(id)
		 |> to_struct()
	
	form = person
		|> Persons.change_person()
		|> to_form()
	assign(socket , id: id , form: form , person: person)
  end
	
  defp to_struct(person) do
	%Person{id: person(person , :id) , name: person(person , :name) , messages: person(person , :messages)}

  end

end 
	
