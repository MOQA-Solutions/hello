defmodule HelloWeb.PersonLive.Edit do

  use HelloWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <.form for = {@form} phx-change = "validate" phx-submit = "update" >
          <.input type = "text" field = {@form[:id]} label = "ID"/>
          <.input type = "text" field = {@form[:name]} label = "Name" phx-debounce = "blur"/>
          <.button type = "submit">Update</.button>
        </.form>
      </div>
      """
  end

end
