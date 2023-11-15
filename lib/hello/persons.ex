defmodule Hello.Persons do

  alias MyServer.Database.API

  alias Hello.Persons.Person

  import MyServer.Database.Person

  def get_all_persons(), do: API.get_all_persons()

  def get_person(id)  do
	[person] =  API.get_person(id)
	person
  end

  def delete_person(id), do: API.delete_person(id)

  def create_person(params \\ %{}) do
	new_person = Person.changeset(%Person{} , params)
	case new_person.errors do
		[] ->
			person = person(id: new_person.changes.id , name: new_person.changes.name , messages: new_person.data.messages)
			API.new_person(person)
			{:ok , person}
		_ ->
			{:error , new_person}
	end
  end

  def update_person(old_person , params) do
	new_person = Person.changeset(old_person , params)
	case new_person.errors do
		[] ->
			id = new_person.changes[:id] || new_person.data.id
			name = new_person.changes[:name] || new_person.data.name
			messages = new_person.data.messages
			person = person(id: id , name: name , messages: messages)
			API.new_person(person)
			{:ok , person}
		_ ->
			{:error , new_person}
	end
  end

  def change_person(%Person{} = person , attrs \\ %{}), do: Person.changeset(person , attrs)
  
end
