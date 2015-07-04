require 'mechanize/progressbar'

# The File resource of an Episode.
class ElixirSipsDownloader::Downloadables::File <
                                              ElixirSipsDownloader::Downloadable

  # @return [String] the name of the File.
  attr_reader :name

  # @return [String] the link to download the File.
  attr_reader :link

  def initialize name, link
    @name = name
    @link = link
  end

  # Download the File.
  #
  # @param (see: ElixirSipsDownloader::Downloadables::Catalog#download)
  def download(basepath, agent)
    FileUtils.mkdir_p basepath

    file_path = File.join(basepath, name)
    ElixirSipsDownloader.logger.info "Starting download of file `#{ name }' in `#{ file_path }'..."
    unless File.exists? file_path
      agent.progressbar {
        agent.download link, file_path
      }
    end
  end

  def == other
    name == other.name && link == other.link
  end

  def eql? other
    name.eql?(other.name) && link.eql?(other.link)
  end

  def hash
    name.hash + link.hash
  end
end
