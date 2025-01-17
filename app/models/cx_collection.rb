class CxCollection < ApplicationRecord
  include AASM

  belongs_to :organization
  belongs_to :service
  belongs_to :service_provider
  belongs_to :user
  has_many :cx_collection_details, dependent: :delete_all

  validates :fiscal_year, presence: true
  validates :quarter, presence: true

  validates :name, presence: true
  validates :reflection, length: { maximum: 5000 }

  scope :published, -> { where(aasm_state: 'published') }

  aasm do
    state :draft, initial: true
    state :submitted
    state :published
    state :change_requested
    state :archived

    event :submit do
        transitions from: %i[draft change_requested], to: :submitted
    end

    event :publish do
      transitions from: :submitted, to: :published
    end

    event :request_change do
      transitions from: [:submitted], to: :change_requested
    end

    event :archive do
      transitions from: [:published], to: :archived
    end

    event :reset do
      transitions to: :draft
    end
  end

  def self.to_csv
    collections = CxCollection.all.order(:fiscal_year, :quarter, 'organizations.name').includes(:organization)

    attributes = %i[
      id
      name
      start_date
      end_date
      service_provider_id
      service_provider_name
      service_provider_organization_id
      service_provider_organization_name
      service_provider_organization_abbreviation
      organization_id
      organization_name
      organization_abbreviation
      user_email
      fiscal_year
      quarter
      reflection
      created_at
      updated_at
      rating
      aasm_state
      integrity_hash
      omb_cx_reporting_collections_count
    ]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      collections.each do |collection|
        csv << attributes = [
          collection.id,
          collection.name,
          collection.start_date,
          collection.end_date,
          collection.service_provider_id,
          collection.service_provider.name,
          collection.service_provider.organization_id,
          collection.service_provider.organization_name,
          collection.service_provider.organization_abbreviation,
          collection.organization_id,
          collection.organization.name,
          collection.organization.abbreviation,
          collection.user.email,
          collection.fiscal_year,
          collection.quarter,
          collection.reflection,
          collection.created_at,
          collection.updated_at,
          collection.rating,
          collection.aasm_state,
          collection.integrity_hash,
          collection.cx_collection_details.size,
        ]
      end
    end
  end
end
