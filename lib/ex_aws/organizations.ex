defmodule ExAws.Organizations do
  @moduledoc """
  Operations on AWS Organizations
  """

  import ExAws.Utils

  alias ExAws.Operation.JSON

  # @version "2016-11-28"

  @type list_tags_for_resource_opts :: [
          next_token: binary,
          max_results: integer
        ]
  @spec list_tags_for_resource(resource_id :: binary) :: ExAws.Operation.JSON.t()
  @spec list_tags_for_resource(resource_id :: binary, opts :: list_tags_for_resource_opts) ::
          ExAws.Operation.JSON.t()
  def list_tags_for_resource(resource_id, opts \\ []) do
    query_params =
      ([resource_id: resource_id] ++ opts)
      |> normalize_opts()

    request(:list_tags_for_resource, query_params)
  end

  @type list_accounts_opts :: [
          next_token: binary,
          max_results: integer
        ]
  @spec list_accounts() :: ExAws.Operation.JSON.t()
  @spec list_accounts(opts :: list_accounts_opts) :: ExAws.Operation.JSON.t()
  def list_accounts(opts \\ []) do
    query_params =
      opts
      |> normalize_opts()

    request(:list_accounts, query_params)
  end

  ####################
  # Helper Functions #
  ####################

  defp request(action, params, opts \\ %{}) do
    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    JSON.new(
      :organizations,
      %{
        data: params,
        headers: [
          {"x-amz-target", "AWSOrganizationsV20161128.#{operation}"},
          {"content-type", "application/x-amz-json-1.1"}
        ]
      }
      |> Map.merge(opts)
    )
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
