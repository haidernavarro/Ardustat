divvers = {}

divvers['links'] = '\
<a href="/">Home</a>&nbsp;|&nbsp; \
<a href="/cycler">Cycling</a>&nbsp;|&nbsp; \
<a href="/debug">Calibration, Setting ID, Direct Commands, Installing Firmware</a>&nbsp;|&nbsp; \
<a href="/cv">Cyclic Voltometry</a>&nbsp;|&nbsp; \
<a href="/getlogs">View Logs</a>'

divvers['commanders'] = '\
<select id="mode_choices"> \
  <option>potentiostat</option> \
  <option>galvanostat</option> \
  <option>moveground</option> \
\
</select><input type="textbox" id="input"></input><button id="send">send</button><span id="status"></span><br> \
<button id="blink">blink</button><button id="ocv">ocv</button><br><br>'

divvers['calibrate'] = '\
Calibration resistor value:<br> \
<input type="textbox" id="calibrate_r_fixed" /><br> \
<button id="send_calibrate">Calibrate</button>'

divvers['idset'] = '\
<input type="textbox" id="idset_value" /><br> \
<button id="set_id">Set ID</button>'

divvers['directcmd'] = '\
<input type="textbox" id="directcmd_value" /> <br> \
<button id="send_directcmd" disabled="disabled">send</button>'

divvers['loggers'] = '\
<div id="logentrybox">Log Name<input type="textbox" id="logfile"> </input><br> \
Log Every <input type="textbox" id="everyxlog" value="1"> </input> events (roughly 100 ms per event)</div> \
<button id="logger">Start Log</button> <span id="log_file_name"> </span>'

divvers['cvcommanders'] = '\
V max<input type="textbox" id="v_max" value="1"> </input><br>\
V min<input type="textbox" id="v_min" value="-1"> </input><br>\
V start<input type="textbox" id="v_start" value ="0"> </input><br>\
CV rate<input type="textbox" id="rate" value="1"> </input> (mV/s)<br>\
Cycle Count<input type="textbox" id="cycles" value="1"> </input> <br>\
<button id="startcv">CV Start</button></span><br><br>'

divvers['finding_error']='\
Measured Current<input type="textbox" id="input_current"> </input> \
<button id="find_error">Find!</button><br>'

divvers['cyclingcommanders'] = '\
<div class="cyclecmds"> \
<select id="c-1" class="cycle_mode_choices"> \
  <option>potentiostat</option> \
  <option>galvanostat</option> \
</select> \
<span id="o-1" class="dependent_options"> \
Voltage: <input type="text" id="cycle_value" class="setting_input"> \
Cutoff Time: <input type="text" id="cycle_cutoff_time" class="setting_input"> <br> \
</span> \
</div> \
<button id="addrow">Add Cycling Command</button> \
<button id="remrow" disabled="true">Remove Cycling Command</button> \
<button id="startcycling">Start Cycling (Current Parameters)</button><br><br> \
Name: <input id="cyclingname"></input><button id="cyclingsave">Save New Cycling Parameters</button><br>\
<select id="cyclingpresets"></select> \
<button id="startsavedcycling">Start Cycling (Saved Parameters)</button>'

divvers['upload_firmware_div'] = '\
<button id="upload_firmware">Upload Firmware</button> \
<span id="status"></span>'

divvers['check_firmware_div'] = '\
<button id="check_firmware">Check Firmware</button> \
<span id="check_firmware_result"></span>'

divvers['customres_div'] = '\
<input type="textbox" id="customres_value" /> <br> \
<button id="send_customres">Override</button>'

divvers['customres_clear_div'] = '\
<button id="send_customres_clear">Clear</button>'


for (key in divvers)
{
	divved = "#"+key;
	if ($(divved).length == 1) 
	{
		console.log(divved)
	$(divved).html(divvers[key])	
	}
}
