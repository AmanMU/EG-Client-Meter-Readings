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
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-lg">
    <div class="container-fluid">
        <a class="navbar-brand translate-top-y" href="#"><img src="Logo.png" alt="" width="64" height="64" class="d-inline-block align-text-top"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
            <ul class="nav nav-pills flex-column flex-sm-row">
                <li class="nav-item me-0 ms-3">
                    <a class="flex-md-fill text-md-center nav-link" style="padding-left: -2rem; margin-left:-2rem; font-size:1.5rem; font-weight:700; color: #880034" aria-current="page" href="#">ELECTRO GRID</a>
                </li>
                <li class="nav-item">
                    <a class="flex-md-fill text-md-center nav-link" style="color: #880034" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item ">
                    <a class=" flex-md-fill text-md-center nav-link active" style="background-color: #880034" href="#">Meter Reading Management</a>
                </li>
                <li class="nav-item">
                    <a class="flex-md-fill text-md-center nav-link" aria-current="page" style="color: #880034" href="#">Profile</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

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
                <input class="btn btn-warning btn-lg mx-auto" value="Insert" type="submit" id="btnInsertMeterReading">
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
            <table class="table table-hover border-start border-end border-top" aria-describedby="All the meter readings">
                <thead>
                <tr>
                    <th scope="col" style="width: 10%">Meter Reader    </th>
                    <th scope="col" style="width: 10%">Account Number  </th>
                    <th scope="col" style="width: 10%">Year            </th>
                    <th scope="col" style="width: 10%">Month           </th>
                    <th scope="col" style="width: 15%">Reading         </th>
                    <th scope="col" colspan="2" style="width: 7.5%">Actions</th>
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
