# To use this module:
# - add "approved" column to database model
# - make sure it shows up in the view as something
# - edit the create method accordingly
# 
module Approvable
  extend ActiveSupport::Concern

  included do

    before_action -> {has_permission :approve}, only: [:approve, :reject]
    before_action -> {has_permission :faculty_mod}, only: [:finalize]

    def approve
      @object = linked_model.find_by_hash_id(params[:id])
      @object.update_attribute(:approved, true)
      @object.update_column(:rejected, false)
      current_user.mod_actions.create(description: "Approved #{linked_model} #{@object.hash_id}", link: linked_model.to_s.downcase + 's/' + @object.hash_id)
    end

    def reject
      @object = linked_model.find_by_hash_id(params[:id])
      @object.update_attribute(:approved, false)
      @object.update_column(:rejected, true)
      @object.update_column(:final, false)
      current_user.mod_actions.create(description: "Rejected #{linked_model} #{@object.hash_id}", link: linked_model.to_s.downcase + 's/' + @object.hash_id)

    end

    def finalize
      @object = linked_model.find_by_hash_id(params[:id])
      @object.update_attribute(:approved, true)
      @object.update_column(:final, true)
      @object.update_column(:rejected, false)
      current_user.mod_actions.create(description: "Finalized #{linked_model} #{@object.hash_id}", link: linked_model.to_s.downcase + 's/' + @object.hash_id)
    end

    def get_partial
      render partial: linked_model.find_by_hash_id(params[:id])
    end
  end

end