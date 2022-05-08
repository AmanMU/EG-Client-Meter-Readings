const $j = jQuery.noConflict();

const isEmpty = (elementIdentifier) => {
    const elementValue = $j(elementIdentifier).val();
    return elementValue === "" || elementValue === null || elementValue === undefined;
}

const getElementValue = (elementIdentifier) => {
    return $j(elementIdentifier).val();
}

const updateReading = async (btnId, rowValues) => {
    const rowIndex = btnId.split("_")[1];
    const meterReadingToUpdate = JSON.parse(rowValues);
    const {accountNo, year, month} = meterReadingToUpdate;
    const updatedReading = getElementValue(`#reading_${rowIndex}`);
    let updateStatusToast = new bootstrap.Toast($j("#updateStatusToast"));
    let indexOfReadingToBeUpdated;
    let allReadings = [];
    await $j.getJSON(`http://localhost/PowerConsumptionService/readings/account/${accountNo}`, {}).done(function (data) {
        indexOfReadingToBeUpdated = data.findIndex(reading => reading.accountNo === accountNo && reading.year === year && reading.month === month);
        allReadings = data;
    });

    if ((indexOfReadingToBeUpdated > 0 && Number.parseInt(updatedReading) < allReadings[indexOfReadingToBeUpdated - 1].reading)
        || (indexOfReadingToBeUpdated < allReadings.length - 1 && Number.parseInt(updatedReading) > allReadings[indexOfReadingToBeUpdated + 1].reading)) {
        $j("#updateStatusToast").removeClass("bg-success").addClass("bg-danger");
        $j("#updateStatusToastBody").text("Update Failed. New reading cannot be less than previous readings.");
        updateStatusToast.show();
        $j("#reading_" + rowIndex).val(meterReadingToUpdate.reading);
        return;
    }

    $j.ajax({
        type: "PUT",
        contentType: "application/json; charset=utf-8",
        url: `http://localhost/PowerConsumptionService/readings/account/${accountNo}?year=${year}&month=${month}`,
        data: JSON.stringify({
            reading: Number.parseInt(updatedReading)
        }),
        success: null,
        dataType: "json"
    }).done(function ({message}) {
        $j("#updateStatusToast").removeClass("bg-danger").addClass("bg-success");
        $j("#updateStatusToastBody").text(message);
        updateStatusToast.show();
    }).fail(function () {
        $j("#updateStatusToast").removeClass("bg-success").addClass("bg-danger");
        $j("#updateStatusToastBody").text("Oops! Something went wrong. Please try again later.");
        updateStatusToast.show();
    });
}
const deleteReading = (rowValues) => {
    const meterReadingToDelete = JSON.parse(rowValues);
    const {accountNo, year, month} = meterReadingToDelete;
    let deleteStatusToast = new bootstrap.Toast($j("#updateStatusToast"));
    $j.ajax({
        type: "DELETE",
        contentType: "application/json; charset=utf-8",
        url: `http://localhost/PowerConsumptionService/readings/account/${accountNo}?year=${year}&month=${month}`,
        data: null,
        success: null,
        dataType: "json"
    }).done(function ({message}) {
        $j("#updateStatusToast").removeClass("bg-danger").addClass("bg-success");
        $j("#updateStatusToastBody").text(message);
        deleteStatusToast.show();
        window.location.reload();
    }).fail(function () {
        $j("#updateStatusToast").removeClass("bg-success").addClass("bg-danger");
        $j("#updateStatusToastBody").text("Oops! Something went wrong. Please try again later.");
        deleteStatusToast.show();
    });
}

$j(document).ready(function () {
    $j("#statusMessage").hide();
    $j("#monthValidation").hide();
    $j("#readingValidation").hide();
    $j("#updateStatusToastBody").text("");
    $j("#numReadingYear").val(new Date().getFullYear());
    $j("#numReadingMonth").val(new Date().getMonth() + 1);

    $j.getJSON("http://localhost/PowerConsumptionService/readings", {}).done(function (data) {
        $j.each(data, function (index, value) {
            $j("#meterReadingTblBody").append($j(`<tr id="row_${index}">
                                        <td>${value.meterReaderId}</td>
                                        <td>${value.accountNo}</td>
                                        <td>${value.year}</td>
                                        <td>${value.month}</td>
                                        <th scope=\"row\"><input class="my-0 py-2" id="reading_${index}" type="number" min="0" value="${value.reading}" /></th>
                                        <td><button class="btn btn-primary" id="update_${index}" value=${JSON.stringify(value)} onclick="updateReading(this.id, this.value)">Update</button></td>
                                        <td><button class="btn btn-danger" value=${JSON.stringify(value)} onclick="deleteReading(this.value)">Delete</button></td>
                                   </tr>`));
        });
    });

    $j("#formMeterReading").submit(async function (e) {
        e.preventDefault();
        $j("#monthValidation").hide();
        $j("#readingValidation").hide();
        let isValid = true;
        if (!isEmpty("#numReadingYear")
            && !isEmpty("#numReadingMonth")
            && new Date(`${getElementValue("#numReadingYear")}-${getElementValue("#numReadingMonth")}`) > new Date()) {
            $j("#monthValidation").show().html(`<strong>Error!</strong> Year and month cannot be a future year and month.`);
            isValid = false;
        }
        const accountNumber = getElementValue("#txtAccountNo");
        let readingsByAccount;

        await $j.getJSON(`http://localhost/PowerConsumptionService/readings/account/${accountNumber}`, {})
            .done(function (data) {
                readingsByAccount = data;
            });
        
        const prevMaxReading = (!isEmpty("#numReadingMonth") && !isEmpty("#numReadingYear")) ? Math.max(...readingsByAccount
            .filter(reading => reading.accountNo === accountNumber
                && new Date($j("#numReadingYear").val() + "-" + $j("#numReadingMonth").val()) >= new Date(reading.year.toString() + "-" + reading.month.toString()))
            .map(readingObj => readingObj.reading)) : 0;
        const futureMinReading = (!isEmpty("#numReadingMonth") && !isEmpty("#numReadingYear")) ? Math.min(...readingsByAccount
            .filter(reading => reading.accountNo === accountNumber
                && new Date($j("#numReadingYear").val() + "-" + $j("#numReadingMonth").val()) <= new Date(reading.year.toString() + "-" + reading.month.toString()))
            .map(readingObj => readingObj.reading)) : 0;
        if (Number.parseInt($j("#numReading").val()) < prevMaxReading || Number.parseInt($j("#numReading").val()) > futureMinReading) {
            $j("#readingValidation").show()
                .html(`<strong>Error!</strong> The reading must be greater be between ${(prevMaxReading || 0) - 1} and ${futureMinReading + 1}`);
            isValid = false;
        }

        if (!isValid) {
            return;
        }
        const insertingMeterReading = $j.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "http://localhost/PowerConsumptionService/readings",
            data: JSON.stringify({
                meterReaderId: Number.parseInt($j("#numMeterReader").val()),
                accountNo: $j("#txtAccountNo").val(),
                year: Number.parseInt($j("#numReadingYear").val()),
                month: Number.parseInt($j("#numReadingMonth").val()),
                reading: Number.parseInt($j("#numReading").val())
            }),
            success: null,
            dataType: "json"
        });
        insertingMeterReading.done(function () {
            $j("#statusMessage").removeClass().addClass("alert alert-success").html("<strong>Success!</strong>");
            window.location.reload();
        });
        insertingMeterReading.fail(function (jqXHR) {
            $j("#statusMessage").show().removeClass().addClass("alert alert-danger").html(`<strong>Error!</strong> ${JSON.parse(jqXHR.responseText).message}`);
        });
    });
});


