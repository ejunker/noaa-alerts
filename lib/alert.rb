require "noaa-alerts/version"

module Noaa
  class Alert
    attr_reader :url, :identifier, :sender, :sent_at, :status, :msg_type, :scope, :note,
      :category, :event, :urgency, :severity, :certainty, :event_codes, :effective_at, :expires_at, :sender_name, :headline, :description, :instruction, :parameters,
      :area_desc, :polygon, :locations, :geocodes

    def initialize(url, entry)
      @url = url || ""

      # alert
      @identifier = ""
      @sender = ""
      @sent_at = nil
      @status = ""
      @msg_type = ""
      @scope = ""
      @note = ""

      # info
      @category = ""
      @event = ""
      @urgency = ""
      @severity = ""
      @certainty = ""
      @event_codes = {}
      @effective_at = nil
      @expires_at = nil
      @sender_name = ""
      @headline = ""
      @description = ""
      @instruction = ""
      @parameters = {}

      # area
      @area_desc = ""
      @polygon = ""
      @locations = []
      @geocodes = {}

      handle_entry(entry) if entry
    end

    private
    
    def handle_entry(entry)
      @identifier = entry.fetch('identifier')
      @sender = entry.fetch('sender')
      @sent_at = Time.parse(entry.fetch('sent'))
      @status = entry.fetch('status')
      @msg_type = entry.fetch('msgType')
      @scope = entry.fetch('scope')
      @note = entry.fetch('note')

      info = entry.fetch('info')
      @category = info.fetch('category')
      @event = info.fetch('event')
      @urgency= info.fetch('urgency')
      @severity = info.fetch('severity')
      @certainty = info.fetch('certainty')
      @event_codes = info.fetch('eventCode')
      @effective_at = Time.parse(info.fetch('effective'))
      @expires_at = Time.parse(info.fetch('expires'))
      @sender_name = info.fetch('senderName')
      @headline = info.fetch('headline')
      @description = info.fetch('description')
      @instruction = info.fetch('instruction')
      @parameters = info.fetch('parameter')

      area = info.fetch('area')
      @area_desc = area.fetch('areaDesc')
      @polygon = area.fetch('polygon')
      @locations = @area_desc.split('; ')
      @geocodes = area.fetch('geocode')
    end
  end
end
