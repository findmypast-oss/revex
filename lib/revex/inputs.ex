defmodule Revex.Inputs do
  @moduledoc """
  API routes starting /inputs in Rev
  """

  @doc """
  Route to send an audio file off for transcription.
  """
  @spec send_for_transcription(String.t, String.t) :: {:ok, map()}
  def send_for_transcription(file_location, content_type) do
    multipart_form = multipart_form_for_file_upload(file_location, content_type)
    options = [recv_timeout: 100000, timeout: 100000]

    response =
      "/inputs"
      |> Rev.post!(multipart_form, create_headers(file_location), options)

    if response.status_code == 201 do
      :ok
    else
      {:error, response.body}
    end
  end

  defp create_headers(file_location) do
    filename = Path.basename(file_location)

    [{"Content-Type", "multipart/form-data"},
     {"Content-Disposition", "filename=#{filename}"}]
  end

  defp multipart_form_for_file_upload(file, content_type) do
    filename = Path.basename(file)

    {:multipart, [{:file,
                   "#{file}",
                   {["form-data"], [name: "\"data_file\"", filename: "\"#{filename}\""]},
                   []},
                  {"Content-Type", content_type}]}
  end
end
