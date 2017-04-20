defmodule Revex.InputsTest do
  use ExUnit.Case, async: false

  alias Revex.Inputs

  setup_all do
    :meck.new(Rev)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "successful audio file submission" do
    stub = fn("/inputs", _multipart_form, _headers, _options) ->
      %HTTPoison.Response{status_code: 201, body: ""}
    end
    :meck.expect(Rev, :post!, stub)

    actual = Inputs.send_for_transcription("/home/developer/talking.mp3", "audio/mpeg")

    assert :ok == actual
  end

  test "unsuccessful audio file submission" do
    stub = fn("/inputs", _multipart_form, _headers, _options) ->
      %HTTPoison.Response{status_code: 400, body: "error message"}
    end
    :meck.expect(Rev, :post!, stub)

    actual = Inputs.send_for_transcription("/home/developer/talking.mp3", "audio/mpeg")

    assert {:error, "error message"} == actual
  end
end
