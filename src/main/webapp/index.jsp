<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="Components/main.js"></script>
    <script>
    </script>
    <title>Meter Reading Service</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-8">
            <h1 class="m-3">Meter Readings</h1>
            <form id="formMeterReading">
                <div class="input-group input-group-sm mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="lblMeterReader">Meter Reader ID: </span>
                    </div>
                    <input required type="number" id="numMeterReader" name="numMeterReader">
                </div>
                <div class="input-group input-group-sm mb-3">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="lblAccountNo">Account Number: </span>
                    </div>
                    <input required type="text" id="txtAccountNo" name="txtAccountNo">
                </div>
                <div class="input-group input-group-sm">
                    <div class="input-group-prepend col-2">
                        <span class="input-group-text" id="lblReadingYear">Year: </span>
                    </div>
                    <input required type="number" id="numReadingYear" name="numReadingYear">
                    <div class="input-group-prepend col-2">
                        <span class="input-group-text" id="lblReadingMonth">Month: </span>
                    </div>
                    <input required type="number" min="1" max="12" id="numReadingMonth" name="numReadingMonth">
                </div>
                <div class="row ms-0 mb-3">
                    <div id="monthValidation" class="alert alert-danger" role="alert">

                    </div>
                </div>
                <div class="input-group input-group-sm mb-0">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="lblReading">Total Reading: </span>
                    </div>
                    <input required type="number" min="0" id="numReading" name="numReading">
                </div>
                <div class="row ms-0 mb-3">
                    <div id="readingValidation" class="alert alert-danger" role="alert">

                    </div>
                </div>
                <input class="btn btn-primary mx-auto" type="submit" id="btnInsertMeterReading">
            </form>
        </div>
    </div>
    <br>
    <div class="row">
        <div id="statusMessage" class="alert alert-primary" role="alert">
        </div>
    </div>
<div class="row">
        <div class="col-12" id="colMeterReadings">
            <table class="table table-hover" aria-describedby="All the meter readings">
                <thead>
                <tr>
                    <th scope="col">Meter Reader</th>
                    <th scope="col">Account Number</th>
                    <th scope="col">Year</th>
                    <th scope="col">Month</th>
                    <th scope="col">Reading</th>
                    <th scope="col" colspan="2">Action</th>
                </tr>
                </thead>
                <tbody id="meterReadingTblBody">
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="toast align-items-center text-white bg-success border-0 position-absolute translate-middle bottom-10 start-50 translate-middle"
     role="alert"
     aria-live="assertive"
     aria-atomic="true"
     id="updateStatusToast">
    <div class="d-flex">
        <div class="toast-body" id="updateStatusToastBody">

        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>
</body>
</html>
