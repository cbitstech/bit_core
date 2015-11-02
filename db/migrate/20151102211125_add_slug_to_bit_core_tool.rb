class AddSlugToBitCoreTool < ActiveRecord::Migration
  def change
    add_column :bit_core_tools, :slug, :string
  end
end
