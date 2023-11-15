defmodule HelloWeb.PersonLive.New do

  use HelloWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <.form for = {@form} phx-change = "validate" phx-submit = "save" >
          <.input type = "text" field = {@form[:id]} label = "ID"/>
          <.input type = "text" field = {@form[:name]} label = "Name" phx-debounce = "blur"/>
          <.button type = "submit">Save</.button>
        </.form>
      </div>
      """
  end

end
 
