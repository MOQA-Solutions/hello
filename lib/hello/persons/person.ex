defmodule Hello.Persons.Person do

  use Ecto.Schema
  
  import Ecto.Changeset

  @primary_key {:id , :string , []}

  schema "persons" do
	field :name, :string
	field :messages, {:array , :string}, default: []
	
	timestamps()
  end

  def changeset(person , params \\ %{}) do
	person
	|> cast(params , [:id , :name])
	|> validate_required([:id , :name , :messages])
	|> validate_format(:name , ~r/@/)
  end

end


  

  
