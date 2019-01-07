# frozen_string_literal: true

require 'spec_helper'
include OneSignal

describe Notification do
  let(:contents) { build :contents }
  let(:headings) { build :headings }

  it 'requires at least some contents' do
    expect { described_class.new }.to raise_error ArgumentError, 'missing contents or template_id'
  end

  it 'creates a new notification' do
    expect(described_class.new(contents: contents, headings: headings, send_after: Time.now)).to be_instance_of Notification
  end

  context 'json' do
    let(:segments) { [build(:segment), build(:segment)] }
    let(:time) { Time.now }
    let(:filters) do
      [Filter.last_session.lesser_than(2).hours_ago!,
       Filter.session_count.equals(5),
       Filter::OR,
       Filter.country.equals('IT')]
    end
    let(:sounds) { build :sounds }

    subject do
      build :notification,
            contents: contents,
            headings: headings,
            included_segments: segments,
            excluded_segments: segments,
            send_after: time,
            filters: filters,
            sounds: sounds
    end

    it 'serializes as json' do
      expect(subject.as_json).to eq(
        'contents' => contents.as_json,
        'headings' => headings.as_json,
        'send_after' => time.to_s,
        'included_segments' => segments.as_json,
        'excluded_segments' => segments.as_json,
        'data' => subject.attachments.data.as_json,
        'url' => subject.attachments.url,
        'ios_attachments' => subject.attachments.ios_attachments.as_json,
        'big_picture' => subject.attachments.android_picture,
        'adm_big_picture' => subject.attachments.amazon_picture,
        'chrome_big_picture' => subject.attachments.chrome_picture,
        'filters' => filters.as_json,
        'ios_sound'     => sounds.ios.as_json,
        'android_sound' => sounds.android.as_json,
        'adm_sound'     => sounds.amazon.as_json,
        'wp_wns_sound'  => sounds.windows.as_json
      )
    end
  end
end
