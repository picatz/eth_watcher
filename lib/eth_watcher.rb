require "eth_watcher/version"
require 'thread'
require 'packetgen'
require 'trollop'

ARGV[0] = '-h' if ARGV.empty?

opts = Trollop::options do
  opt :threads,     "Use a given ammount of threads for parsing",  default: 3,              type: :int  
  opt :interface,   "Use a given interface for packet capturing",  default: Pcap.lookupdev, type: :string
  opt :snap_length, "Use a given snapshot length for the capture", default: 65535,          type: :int 
  opt :promiscuous, "Use promiscuous for the capture",             default: true,           type: :bool
end

module EthWatcher

  @threads   = Array.new
  @parsed    = Queue.new
  @semaphore = Mutex.new

  def self.start_capture(interface:, snaplen:, promisc:)
    @capture = Pcap.open_live(interface, snaplen, promisc, 0)
  end

  trap "SIGINT" do
    exit
  end

  def self.spawn_threads(count:)
    count.times do 
      Thread.new do
        loop do
          begin
            packet = PacketGen.parse(@capture.next_packet.to_s)
            next unless packet.headers.first.ethertype
            packet = packet.headers[0]
            @semaphore.synchronize {  puts packet.src << " -> " << packet.dst }
          rescue
            # YOLO!
          end
        end
      end
    end
  end

end

EthWatcher.start_capture(interface: opts[:interface], snaplen: opts[:snap_length], promisc: opts[:promiscuous]) 

EthWatcher.spawn_threads(count: opts[:threads])

loop do
  # CTL+C to exit program 
end
