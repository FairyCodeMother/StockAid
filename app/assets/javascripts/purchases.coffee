UPDATE_REMAINING_EVENT = "update.remaining"

$(document).on "keyup keypress", (event) ->
  keyCode = event.keyCode || event.which
  if keyCode == 13
    event.preventDefault()
    return false

populateItems = (category_id, element) ->
  id = parseInt category_id
  for category in data.categories
    if category.id is id
      currentCategory = category
  element.html tmpl("purchases-item-options-template", currentCategory)

addPurchaseRow = (purchaseDetail) ->
  # Add an empty row
  data.num_rows = $(".purchase-row").length
  $("#purchase-table > tbody").append tmpl("purchases-new-purchase-template", purchaseDetail)
  return unless purchaseDetail

  purchaseDetail.original_quantity_remaining = purchaseDetail.quantity_remaining
  # Populate that row if there are purchaseDetail
  row = $("#purchase-table > tbody > tr.purchase-row:last")
  purchaseDetailId = row.find(".purchase_detail_id")
  category = row.find(".category")
  item = row.find(".item")
  quantity = row.find(".quantity")
  cost = row.find(".cost")
  variance = row.find(".variance")
  itemValue = row.find(".item_value")
  showHideShipmentsButton = row.find(".show-shipment-table")

  purchaseDetailId.val purchaseDetail.id
  category.val purchaseDetail.item.category.id
  category.trigger "change"
  item.val purchaseDetail.item.id
  item.trigger "change"
  quantity.val purchaseDetail.quantity
  cost.val formatMoney(purchaseDetail.cost)
  variance.val formatMoney(purchaseDetail.variance)
  itemValue.val purchaseDetail.item.value
  quantity.trigger "change"
  cost.trigger "change"
  disablePurchaseDetailDeleteWhenShipmentsExist(purchaseDetail.id)

  purchaseShipmentTableRow = $("#purchase-table > tbody > tr.purchase-shipment-table-row:last > td")
  purchaseShipmentTableRow.html tmpl("purchases-purchase-shipment-table-template", { purchaseDetailId: purchaseDetail.id, quantityRemaining: purchaseDetail.quantity_remaining })
  if purchaseDetail.purchase_shipments.length > 0
    showHideShipmentsButton.prop('disabled', false)
    for purchaseShipment, index in purchaseDetail.purchase_shipments
      addPurchaseShipmentRow(purchaseShipmentTableRow, purchaseDetail.id, purchaseShipment, index)

expose "addPurchaseRows", ->
  $ ->
    if data.purchase && data.purchase.purchase_details && data.purchase.purchase_details.length > 0
      for purchaseDetail in data.purchase.purchase_details
        continue if purchaseDetail.quantity == 0
        addPurchaseRow(purchaseDetail)
    else
      # Add a blank row unless we have already added content to the table
      addPurchaseRow()

addPurchaseShipmentRow = (currentRow, purchaseDetailId, purchaseShipment, purchaseShipmentRowIndex = null) ->
  # simpler than the above since there's no live selects
  table = currentRow.find(".purchase-shipments-table")
  tableBody = table.find("tbody")
  if !purchaseShipmentRowIndex
    purchaseShipmentRowIndex = tableBody.find("tr.purchase-shipment-row").length

  dataForThisRow = Object.assign({}, purchaseShipment, { index: purchaseShipmentRowIndex+1, purchaseDetailId })
  tableBody.append tmpl("purchases-purchase-shipment-row-template", dataForThisRow)
  if (purchaseShipment && purchaseShipment.id)
    # this shipment has been saved
    tableBody.find("tr:last div.shipment-persisted-icon").removeClass("hidden")
    tableBody.find("tr:last button.delete-this-shipment-button").removeClass("hidden").prop("disabled", false)
  else
    tableBody.find("tr:last div.shipment-new-icon").removeClass("hidden")
  updateQuantityRemaining(table, findPurchaseDetail(purchaseDetailId))

printOrder = ->
  window.print()

calculateLineCostAndVariance = (activeElement) ->
  purchaseRow = activeElement.parents(".purchase-row")
  quantityElement = purchaseRow.find ".quantity"
  costElement = purchaseRow.find ".cost"
  lineCostElement = purchaseRow.find ".line-cost"
  varianceElement = purchaseRow.find ".variance"
  itemValue = getCurrentItemValue(purchaseRow)

  lineCost = costElement.val() * quantityElement.val()
  variance = costElement.val() - itemValue
  lineCostElement.val(formatMoney(lineCost))
  varianceElement.val(formatMoney(variance) + " (from " + formatMoney(itemValue) + ")")

calcuateSubtotal = ->
  lineCostElements = $(".line-cost")
  subtotal = 0
  for element in lineCostElements
    subtotal += parseFloat($(element).val())

  $(".subtotal").val(formatMoney(subtotal))

calculateTotal = ->
  subTotal = parseFloat($("#blank_subtotal").val())
  tax = parseFloat($("#purchase_tax").val())
  shipping = parseFloat($("#purchase_shipping_cost").val())
  $("#blank_total").val(formatMoney(subTotal + tax + shipping))

deletePurchaseDetail = (purchaseRow) ->
  shipmentTableRow = purchaseRow.next()
  tableBody = purchaseRow.parent("tbody")
  idFieldName = purchaseRow.find(".purchase_detail_id").attr("name")
  destroyFieldName = idFieldName.replace("[id]", "[_destroy]")
  purchaseId = parseInt(purchaseRow.data("purchaseId"))
  templateData = {
    rowName: idFieldName,
    rowValue: purchaseId,
    destroyName: destroyFieldName
  }
  purchaseRow.remove()
  shipmentTableRow.remove()
  tableBody.append(tmpl("delete-purchase-detail-row-template", templateData))

expose "disableFormWhenClosed", ->
  $ ->
    if (data.purchase && data.purchase.status && data.purchase.status == "closed")
      $("input").prop("disabled", true)
      $("select").prop("disabled", true)
      $("button#purchase-add-row").prop("disabled", true)
      $("button.delete-purchase-row").prop("disabled", true)

disablePurchaseDetailDeleteWhenShipmentsExist = (purchaseDetailId) ->
  detail = findPurchaseDetail(purchaseDetailId)
  deletePurchaseButton = $("#delete-purchase-button-" + purchaseDetailId)
  deletePurchaseButton.prop("disabled", (detail.purchase_shipments.length > 0))

findPurchaseDetail = (purchaseDetailId) ->
  details = data.purchase.purchase_details
  for detail in details
    return detail if detail.id == purchaseDetailId
  return null

expose "formatTotalsBlock", ->
  $ ->
    subtotalElement = $("input.subtotal")
    subtotalElement.val(formatMoney(subtotalElement.val()))
    taxElement = $("input.tax")
    taxElement.val(formatMoney(taxElement.val()))
    shippingCostElement = $("input.shipping-cost")
    shippingCostElement.val(formatMoney(shippingCostElement.val()))
    totalElement = $("input.total")
    totalElement.val(formatMoney(totalElement.val()))

getCurrentItemValue = (row) ->
  itemElement = row.find(".item")
  optionSelected = itemElement.find("option:selected")
  itemValue = optionSelected.data().itemValue
  return itemValue

expose "setVendorInfo", ->
  $ ->
    if data.purchase && data.purchase.vendor_id
      vendor = $("#purchase_vendor_id")
      vendor.val = data.purchase.vendor_id
      vendor.trigger "change"

updateQuantityRemaining = (shipmentTable, purchaseDetail) ->
  foot = shipmentTable
    .find("tfoot")
  quantitiyRemaining =
    foot.find("span.displayed-quantity-remaining")
  quantitiyRemaining.html(purchaseDetail.quantity_remaining)
  foot
    .find("button.purchases-purchase-detail-add-shipment-button")
    .prop("disabled", (purchaseDetail.quantity_remaining == 0))

updateVendorInfo = (selectedVendorId) ->
  vendors = data.vendors
  for vendor in vendors
    if parseInt(vendor.id) == parseInt(selectedVendorId)
      $(".vendor-website").html(vendor.website)
      $(".vendor-phone").html(vendor.phone_number)
      $(".vendor-email").html(vendor.email)
      $(".vendor-contact-name").html(vendor.contact_name)

# Add an empty purchase detail row
$(document).on "click", "#purchase-add-row", (event) ->
  event.preventDefault()
  addPurchaseRow()

# Delete a purchase detail row
$(document).on "click", ".delete-purchase-row", (event) ->
  event.preventDefault()
  purchaseRow = $(@).closest("tr.purchase-row")
  deletePurchaseDetail(purchaseRow)

# Toggle the shipments table for a row
$(document).on "click", ".show-shipment-table", (event) ->
  event.preventDefault()
  purchaseShipmentRow = $(@).parents(".purchase-row").next()
  purchaseShipmentRow.toggleClass("hidden")

# Add a new purchase shipment row
$(document).on "click", ".purchases-purchase-detail-add-shipment-button", (event) ->
  event.preventDefault()
  purchaseDetailId = $(@).data("forPurchaseDetailId")
  purchassShipmentTableRow = $(@).parents(".purchase-shipment-table-row")
  detail = findPurchaseDetail(purchaseDetailId)
  newPurchaseShipment = {
    quantity_received: detail.quantity_remaining
  }
  detail.quantity_remaining = 0
  addPurchaseShipmentRow(purchassShipmentTableRow, purchaseDetailId, newPurchaseShipment)
  shipmentTable = purchassShipmentTableRow.find("table")
  updateQuantityRemaining(shipmentTable, detail)

$(document).on "change", "input.quantity-received", (event) ->
  # update the quantity remaining
  shipmentRow = $(@).parents(".purchase-shipment-row")
  purchaseDetailId = parseInt(shipmentRow.data("forPurchaseDetail"))
  newNumber = parseInt(event.target.value)
  detail = findPurchaseDetail(purchaseDetailId)
  return if !detail
  detail.quantity_remaining = detail.original_quantity_remaining - newNumber
  updateQuantityRemaining(shipmentRow.closest("table"), detail)

# Print the Purhcase
$(document).on "click", "#print-purchase", (event) ->
  printOrder()

$(document).on "click", "button.suggested-name", ->
  $("#purchase_ship_to_name").val $(@).text()

$(document).on "click", "button.suggested-address", ->
  $("#purchase_ship_to_address").val $(@).text()

$(document).on "change", ".purchase-row .category", ->
  item_element = $(@).parents(".purchase-row").find ".item"
  populateItems $(@).val(), item_element

$(document).on "change", ".purchase-row .item", ->
  calculateLineCostAndVariance($(@))

$(document).on "change", ".purchase-row .quantity", ->
  calculateLineCostAndVariance($(@))
  calcuateSubtotal()
  calculateTotal()

$(document).on "change", ".purchase-row .cost", ->
  $(@).val(formatMoney($(@).val()))
  calculateLineCostAndVariance($(@))
  calcuateSubtotal()
  calculateTotal()

$(document).on "change", ".purchase-row .line-cost", ->
  purchaseRow = $(@).parents(".purchase-row")
  quantityElement = purchaseRow.find ".quantity"
  costElement = purchaseRow.find ".cost"
  lineCostElement = purchaseRow.find ".line-cost"
  itemValue = getCurrentItemValue(purchaseRow)

  cost = lineCostElement.val() / quantityElement.val()
  variance = cost - itemValue
  costElement.val(formatMoney(cost))
  varianceElement.val(formatMoney(variance) + " (from " + itemValue + ")")
  calcuateSubtotal()
  calculateTotal()

$(document).on "change", "#purchase_tax", ->
  tax = $(@).val()
  $(@).val(formatMoney(tax))
  calculateTotal()

$(document).on "change", "#purchase_shipping_cost", ->
  shipping = $(@).val()
  $(@).val(formatMoney(shipping))
  calculateTotal()

$(document).on "change", "#purchase_vendor_id", ->
  if parseInt($(@).val()) > 0
    updateVendorInfo($(@).val())
  else
    $(".vendor-website").html("")
    $(".vendor-phone").html("")
    $(".vendor-email").html("")

$(document).on UPDATE_REMAINING_EVENT, ".quantity-remaining", ->
  alert("Update Remaining")
  purchaseDetailId = $(@).data("purchaseId")
  detail = findPurchaseDetail(purchaseDetailId)
  $(@).html(detail.quantity_remaining)
