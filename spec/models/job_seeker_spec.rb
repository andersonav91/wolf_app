require 'rails_helper'

RSpec.describe JobSeeker, type: :model do
  describe ".find_candidates" do
    let(:role) { create(:role) }
    let(:today) { Date.today.to_s }
    let(:yesterday) { 2.day.ago.to_s }
    let(:tomorrow) { 1.day.from_now.to_s }

    context "when searching within New York" do
      let!(:job_seeker_in_ny) { create(:job_seeker, location: create(:location), availability_start: yesterday, availability_end: tomorrow) }
      let!(:job_seeker_role_in_ny) { create(:job_seeker_role, job_seeker: job_seeker_in_ny, role: role, status: true) }

      it "returns candidates within 30 miles of New York" do
        candidates = JobSeeker.find_candidates(role.id, 40.7128, -74.0060, [today])
        expect(candidates).to include(job_seeker_in_ny)
      end
    end

    context "when searching outside of New York" do
      let!(:job_seeker_outside_ny) { create(:job_seeker, location: create(:location_outside_30_miles), availability_start: yesterday, availability_end: tomorrow) }
      let!(:job_seeker_role_outside_ny) { create(:job_seeker_role, job_seeker: job_seeker_outside_ny, role: role, status: true) }

      it "does not return candidates more than 30 miles from New York" do
        candidates = JobSeeker.find_candidates(role.id, 40.7128, -74.0060, [today])
        expect(candidates).not_to include(job_seeker_outside_ny)
      end
    end

    context "with invalid availability dates" do
      let!(:job_seeker_unavailable) { create(:job_seeker, location: create(:location), availability_start: tomorrow, availability_end: 2.days.from_now.to_s) }
      let!(:job_seeker_role_unavailable) { create(:job_seeker_role, job_seeker: job_seeker_unavailable, role: role, status: true) }

      it "does not return candidates who are not available on the specified dates" do
        candidates = JobSeeker.find_candidates(role.id, 40.7128, -74.0060, [yesterday])
        expect(candidates).not_to include(job_seeker_unavailable)
      end
    end

    context "with valid availability dates" do
      let!(:job_seeker_available) { create(:job_seeker, location: create(:location), availability_start: yesterday, availability_end: tomorrow) }
      let!(:job_seeker_role_available) { create(:job_seeker_role, job_seeker: job_seeker_available, role: role, status: true) }

      it "returns candidates who are available on the specified dates" do
        candidates = JobSeeker.find_candidates(role.id, 40.7128, -74.0060, [today])
        expect(candidates).to include(job_seeker_available)
      end
    end
  end
end
