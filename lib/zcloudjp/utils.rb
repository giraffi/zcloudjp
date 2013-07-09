# encoding: utf-8

module Zcloudjp
  module Utils

    # Parses given params or file and returns Hash including the given key.
    def parse_params(params, key_word)
      body = params.has_key?(:path) ? load_file(params[:path], key_word) : params
      body = { key_word => body } unless body.has_key?(key_word.to_sym)
      body
    end

    # Loads a specified file and returns Hash including the given key.
    def load_file(path, key_word)
      begin
        data = MultiJson.load(IO.read(File.expand_path(path)), symbolize_keys: true)
      rescue RuntimeError, Errno::ENOENT => e
        raise e.message
      rescue MultiJson::LoadError => e
        raise e.message
      end
        if data.has_key?(key_word)
        data[key_word].map { |k,v| data[key_word][k] = v } if data[key_word].is_a? Hash
      end
      data
    end
  end
end
