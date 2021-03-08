<div align="center">
<h1>HDD Tools Hass.io Add-on</h1>
</div>

## General

This add-on provides information about HDD Temperature from S.M.A.R.T using smartmontools.
Temperature is visible in Home-Assistant via sensor sensor.hdd_temp.
SMART attributes are mapped to sensor.hdd_temp sensor attributes.

## NOTE

This is a fork of the official repo (https://github.com/Draggon/hassio-hdd-tools) used only to test changes. Please use the official repo. This fork can change or become unavailable without previous notice.

## Installation

Add the repository URL under **Supervisor (Hass.io) → Add-on Store** in your Home Assistant front-end:

    https://github.com/McGiverGim/hassio-hdd-tools


## Configuration

Configure the add-on via your Home Assistant front-end under **Supervisor (Hass.io) → Dashboard → HDD Tools**.

### Configuration parameters

| Parameter | Description |
|-----------|-------------|
| sensor_name | Name for the sensor which is exposed to home-assistant
| friendly_name | Friendly name for the sensor which is exposed to home-assistant
| performance_check | flag to enable or disable the execution of performance check at startup
| hdd_path | path to drive to monitor
| check_period | interval in minutes / how often to read temperature
| debug | flag to enable or disable debugging. Activate this if you want to debug which property from the JSON output of `smartctl` you want to be merged to the sensor.
| output_file | log file
| attributes_property | attribute you want to merge with the attributes in your sensor. Check the `output_file` for the available properties.
| attributes_format | one of `object` or `list`. See more details [here](#attributes).

### Attributes

`smartctl` returns multiple formats of the attributes, depending on what setup is used.

This addon supports either a `list` (table) of attributes or an `object` of attributes:


#### Attributes as an object

This is returned for a NVMe setup for example: 

```json
{
  "nvme_smart_health_information_log": {
    "critical_warning": 0,
    "temperature": 36,
    "available_spare": 100,
    "available_spare_threshold": 5,
    "percentage_used": 0,
    "data_units_read": 519679,
    "data_units_written": 326973,
    "host_reads": 8780844,
    "host_writes": 7257199,
    "controller_busy_time": 472,
    "power_cycles": 33,
    "power_on_hours": 153,
    "unsafe_shutdowns": 13,
    "media_errors": 0,
    "num_err_log_entries": 0,
    "warning_temp_time": 0,
    "critical_comp_time": 0
  }
}
```

The addon configuration for this setup would look like:

```yaml
attributes_property: nvme_smart_health_information_log
attributes_format: object
```

#### Attributes as a list (table)

This is returned for a SATA setup for example:

```json
{
  "ata_smart_attributes": {
    "revision": 1,
    "table": [
      {
        "id": 1,
        "name": "Raw_Read_Error_Rate",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 47,
          "string": "POSR-K ",
          "prefailure": true,
          "updated_online": true,
          "performance": true,
          "error_rate": true,
          "event_count": false,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 5,
        "name": "Reallocate_NAND_Blk_Cnt",
        "value": 100,
        "worst": 100,
        "thresh": 10,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 9,
        "name": "Power_On_Hours",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 744,
          "string": "744"
        }
      },
      {
        "id": 12,
        "name": "Power_Cycle_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 35,
          "string": "35"
        }
      },
      {
        "id": 171,
        "name": "Program_Fail_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 172,
        "name": "Erase_Fail_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 173,
        "name": "Ave_Block-Erase_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 9,
          "string": "9"
        }
      },
      {
        "id": 174,
        "name": "Unexpect_Power_Loss_Ct",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 24,
          "string": "24"
        }
      },
      {
        "id": 180,
        "name": "Unused_Reserve_NAND_Blk",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 100,
          "string": "100"
        }
      },
      {
        "id": 183,
        "name": "SATA_Interfac_Downshift",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 184,
        "name": "Error_Correction_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 187,
        "name": "Reported_Uncorrect",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 194,
        "name": "Temperature_Celsius",
        "value": 64,
        "worst": 48,
        "thresh": 50,
        "when_failed": "past",
        "flags": {
          "value": 34,
          "string": "-O---K ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": false,
          "auto_keep": true
        },
        "raw": {
          "value": 223340199972,
          "string": "36 (Min/Max 29/52)"
        }
      },
      {
        "id": 196,
        "name": "Reallocated_Event_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 197,
        "name": "Current_Pending_Sector",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 198,
        "name": "Offline_Uncorrectable",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 48,
          "string": "----CK ",
          "prefailure": false,
          "updated_online": false,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 199,
        "name": "UDMA_CRC_Error_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 29,
          "string": "29"
        }
      },
      {
        "id": 202,
        "name": "Percent_Lifetime_Remain",
        "value": 100,
        "worst": 100,
        "thresh": 1,
        "when_failed": "",
        "flags": {
          "value": 48,
          "string": "----CK ",
          "prefailure": false,
          "updated_online": false,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 100,
          "string": "100"
        }
      },
      {
        "id": 206,
        "name": "Write_Error_Rate",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 46,
          "string": "-OSR-K ",
          "prefailure": false,
          "updated_online": true,
          "performance": true,
          "error_rate": true,
          "event_count": false,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 210,
        "name": "Success_RAIN_Recov_Cnt",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 0,
          "string": "0"
        }
      },
      {
        "id": 246,
        "name": "Total_LBAs_Written",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 619033175,
          "string": "619033175"
        }
      },
      {
        "id": 247,
        "name": "Host_Program_Page_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 19344786,
          "string": "19344786"
        }
      },
      {
        "id": 248,
        "name": "FTL_Program_Page_Count",
        "value": 100,
        "worst": 100,
        "thresh": 50,
        "when_failed": "",
        "flags": {
          "value": 50,
          "string": "-O--CK ",
          "prefailure": false,
          "updated_online": true,
          "performance": false,
          "error_rate": false,
          "event_count": true,
          "auto_keep": true
        },
        "raw": {
          "value": 16994048,
          "string": "16994048"
        }
      }
    ]
  }
}
```

The addon configuration for this setup would look like:

```yaml
attributes_property: ata_smart_attributes.table
attributes_format: list
```

## Notes

Addon reguires Protection Mode to be disabled to access S.M.A.R.T data

## Credits

- https://www.smartmontools.org/
