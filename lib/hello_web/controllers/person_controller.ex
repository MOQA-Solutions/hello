defmodule HelloWeb.PersonController do

  use HelloWeb, :controller

  alias Hello.Persons

  alias Hello.Persons.Person

  import MyServer.Database.Person

  def index(conn , _params) do
	persons = Persons.get_all_persons()
	render(conn , :index , persons: persons)
  end

  def show(conn , %{"id" => id}) do
	[person] = Persons.get_person(id)
	render(conn , :show , person: person)
  end

  def delete(conn , %{"id" => id}) do
	:ok = Persons.delete_person(id)
	conn
	|> put_flash(:info , "person deleted successfully")
	|> redirect(to: ~p"/persons")
  end

  def new(conn , _params) do
	changeset = Persons.change_person(%Person{})
	render(conn , :new , changeset: changeset)
  end

  def create(conn , %{"person" => params}) do
	case Persons.create_person(params) do
		{:ok , person} ->
			person_id = person(person , :id)
			conn
			|> put_flash(:info , "person created successfully")
			|> redirect(to: ~p"/persons/#{person_id}")
		{:error , changeset} ->
			render(conn , :new , changeset: changeset)
	end
  end

end















