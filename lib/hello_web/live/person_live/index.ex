defmodule HelloWeb.PersonLive.Index do
  use HelloWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <h1>Listing Persons</h1>
        <table>
          <thead>
            <tr>
	      <th>Id</th>
	      <th>Name</th>  
	      <th></th>
            </tr>
          </thead>
          <tbody>
            <%= for person <- @persons do %>
              <tr>
                <td><%= elem(person , 1) %></td>
	        <td><%= elem(person , 2) %></td>
                <%= key = elem(person , 1) %>
                <td><.link href = {~p"/livepersons/#{key}/edit"}>Edit</.link></td>
                <!-- <td><.link href = {~p"/livepersons/ -->
	      </tr>
  	    <% end %>
          </tbody>
        </table>
          <.link href = {~p"/livepersons/new"}>New</.link>
      </div>
      """
  end
end



