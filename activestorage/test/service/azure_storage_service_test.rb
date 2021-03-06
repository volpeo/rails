require "service/shared_service_tests"
require "uri"

if SERVICE_CONFIGURATIONS[:azure]
  class ActiveStorage::Service::AzureStorageServiceTest < ActiveSupport::TestCase
    SERVICE = ActiveStorage::Service.configure(:azure, SERVICE_CONFIGURATIONS)

    include ActiveStorage::Service::SharedServiceTests

    test "signed URL generation" do
      url = @service.url(FIXTURE_KEY, expires_in: 5.minutes,
        disposition: :inline, filename: "avatar.png", content_type: "image/png")

      assert_match(/(\S+)&rsct=image%2Fpng&rscd=inline%3B\+filename%3D%22avatar.png/, url)
      assert_match SERVICE_CONFIGURATIONS[:azure][:container], url
    end
  end
else
  puts "Skipping Azure Storage Service tests because no Azure configuration was supplied"
end
