Return-Path: <stable+bounces-12269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE3832AAF
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97391F252FE
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3356652F79;
	Fri, 19 Jan 2024 13:45:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BB41A8F;
	Fri, 19 Jan 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671945; cv=none; b=aSb/5XFU3Ucs7OVYjhqPB2ZLo981p9BvwfD4RjnUSovxyJ64gEIKByM9vlyvUo2tNxOZ8pLq0yCrBZ5+pQM3i5eYvAzg6WyDdMwPHP0rJpUfQfwX7GWN3ui8RzWpDwnoKPo16lv0J7pyranxbkyoEfgwzXK7mdNRMyCtDdwBmvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671945; c=relaxed/simple;
	bh=F0kCq/EQXrub5I4+t5Qsu2HZ7JV8GDxo7h9+Ffv6U24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VAB4DLmUpL3S5OPdj3R3cFTllGART/5y84neXnd5EpS7ifmz6jOUjMSAkhD/mLh4tKwa9rbbszePayBYDSB2ZIp8XGSeLDrpnJ8pdpPqXVef6uLdaPjyaFpN+vZsQEc0On3oVEBSdOhA7HL7umqzUPD9D3zY6beA4IrDoGz5yyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rQpBk-0002c8-2u; Fri, 19 Jan 2024 14:45:40 +0100
Message-ID: <d3accff8-b66b-4aa3-9b9d-bd2eeb8aaf09@leemhuis.info>
Date: Fri, 19 Jan 2024 14:45:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Built-in Intel Bluetooth device disappeared after booting Linux
 6.7
Content-Language: en-US, de-DE
To: Ramses <ramses@well-founded.dev>,
 Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
 Stable <stable@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
References: <No21xeV--3-9@well-founded.dev> <No28BcQ--3-9@well-founded.dev>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <No28BcQ--3-9@well-founded.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705671942;e45edfd1;
X-HE-SMSGID: 1rQpBk-0002c8-2u

On 13.01.24 15:05, Ramses wrote:
> I forgot to add the full kernel logs, attached the logs of 6.6.10 with working bluetooth and 6.7 where bluetooth is not working.

Hi! This is not my area of expertise, but as it seems nobody answered
let me give it a shot:

It seems you are using different firmware files for you Wifi device
(compare the lines "iwlwifi 0000:01:00.0: loaded firmware version...");
could you maybe temporarily remove the newer one to rule out it causes
your BT problem?

There are a few other differences in the dmesg that look odd; the older
one has lines like "input: Kensington Eagle Trackball", the newer one
does not. Did you disconnect that device in between? If not it sounds
like there is something fishy somewhere, maybe with USB or your kernel
config.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> I am also including a recent boot with 6.6.9 (after having booted with 6.7) where bluetooth is also not showing up, even though it did work before on the same kernel build.
> 
> Thanks,
> Ramses
> 
> 
> Jan 13, 2024, 14:38 by ramses@well-founded.dev:
> 
>> I am running an alder lake i7 1260P with built-in bluetooth.
>> This adapter always worked fine with no special config, but since I booted Linux 6.7, the device completely disappeared. There's no mention of bluetooth in the kernel or system logs, there's no device node, and there's no entry in lspci.
>> When I boot the last working kernel again (6.6.10), the device also doesn't appear (even though it did before, see logs below).
>>
>> I also tried booting a ubuntu live ISO to exclude any configuration issues with my distro's (NixOS) kernel or such, and also there the device did not show up.
>>
>> I am not sure at all that this is related to the kernel, but I wouldn't know where else to look. I am including below my system logs (journalctl -g 'blue|Blue|Linux') showing the kernel version and the bluetooth related entries. As you can see, on 6.6.10 the bluetooth module got loaded, /dev/hci0 gets created, and user space sets up the bluetooth stack.
>>
>> The next boot entry is the first time I booted 6.7, and there's no mention of bluetooth at all in the logs. I tried to load the bluetooth module manually, which succeeds but doesn't create a device node.
>>
>> When I boot 6.6.10 again now, I get exactly the same as on 6.7. I don't know if the kernel could have done anything persistent to the device that makes that it doesn't get initialised anymore?
>>
>> I'm not sure how to debug this further, let me know if there's a way to get more detailed info in the kernel logs or such.
>>
>> Thanks,
>> Ramses
>>
>>
>> Logs with 6.6.10:
>>
>> -- Boot 7847b5595e1d40a8bf2624542e5fff74 --
>> jan 09 02:03:50 localhost kernel: Linux version 6.6.10 (nixbld@localhost) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Fri Jan  5 14:19:45 UTC 2024
>> jan 09 02:03:50 localhost kernel: SELinux:  Initializing.
>> jan 09 02:03:50 localhost kernel: usb usb1: Manufacturer: Linux 6.6.10 xhci-hcd
>> jan 09 02:03:50 localhost kernel: usb usb2: Manufacturer: Linux 6.6.10 xhci-hcd
>> jan 09 02:04:02 starbook kernel: Linux agpgart interface v0.103
>> jan 09 02:04:02 starbook kernel: mc: Linux media interface: v0.10
>> jan 09 02:04:02 starbook kernel: Bluetooth: Core ver 2.22
>> jan 09 02:04:02 starbook kernel: Bluetooth: HCI device and connection manager initialized
>> jan 09 02:04:02 starbook kernel: Bluetooth: HCI socket layer initialized
>> jan 09 02:04:02 starbook kernel: Bluetooth: L2CAP socket layer initialized
>> jan 09 02:04:02 starbook kernel: Bluetooth: SCO socket layer initialized
>> jan 09 02:04:03 starbook kernel: videodev: Linux video capture interface: v2.00
>> jan 09 02:04:03 starbook kernel: Intel(R) Wireless WiFi driver for Linux
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware timestamp 2023.42 buildtype 1 build 73111
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: No support for _PRR ACPI method
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Boot Address: 0x100800
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware Version: 151-42.23
>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware already loaded
>> jan 09 02:04:03 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
>> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate name 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
>> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate name 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
>> jan 09 02:04:04 starbook systemd[1]: Starting Bluetooth service...
>> jan 09 02:04:04 starbook (uetoothd)[1275]: bluetooth.service: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)
>> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP socket layer initialized
>> jan 09 02:04:04 starbook kernel: Bluetooth: MGMT ver 1.22
>> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth daemon 5.70
>> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth management interface 1.22 initialized
>> jan 09 02:04:04 starbook systemd[1]: Started Bluetooth service.
>> jan 09 02:04:04 starbook systemd[1]: Reached target Bluetooth Support.
>> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
>> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM TTY layer initialized
>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM socket layer initialized
>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM ver 1.11
>> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
>> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>> jan 09 09:22:05 starbook systemd[1]: Stopped target Bluetooth Support.
>> jan 09 09:22:05 starbook systemd[1]: Stopping Bluetooth service...
>> jan 09 09:22:05 starbook systemd[1]: bluetooth.service: Deactivated successfully.
>> jan 09 09:22:05 starbook systemd[1]: Stopped Bluetooth service.
>>
>>
>>
>> With 6.7
>>
>> -- Boot 7840f56ab2434c9fb1b899e7abea32cc --
>> jan 09 09:26:07 localhost kernel: Linux version 6.7.0 (nixbld@localhost) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Sun Jan  7 20:18:38 UTC 2024
>> jan 09 09:26:07 localhost kernel: SELinux:  Initializing.
>> jan 09 09:26:07 localhost kernel: usb usb1: Manufacturer: Linux 6.7.0 xhci-hcd
>> jan 09 09:26:07 localhost kernel: usb usb2: Manufacturer: Linux 6.7.0 xhci-hcd
>> jan 09 09:26:17 starbook kernel: mc: Linux media interface: v0.10
>> jan 09 09:26:17 starbook kernel: Linux agpgart interface v0.103
>> jan 09 09:26:17 starbook kernel: videodev: Linux video capture interface: v2.00
>> jan 09 09:26:17 starbook kernel: Intel(R) Wireless WiFi driver for Linux
>> jan 09 09:26:17 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
>> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate name 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
>> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate name 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
>> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33bclwa-system-path/share/dbus-1/services/org.bluez.obex.s>
>> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33bclwa-system-path/share/dbus-1/services/org.bluez.obex.s>
>> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate name 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>> jan 09 09:26:43 starbook systemd[1]: Bluetooth service was skipped because of an unmet condition check (ConditionPathIsDirectory=/sys/class/bluetooth).
>>
>>
>> lspci output (on 6.7):
>>
>> ➜ lspci -v
>> 00:00.0 Host bridge: Intel Corporation Device 4621 (rev 02)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0
>>         Capabilities: <access denied>
>>         Kernel driver in use: igen6_edac
>>         Kernel modules: igen6_edac
>>
>> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P GT2 [Iris Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
>>         DeviceName: VGA compatible controller
>>         Subsystem: Intel Corporation Alder Lake-P GT2 [Iris Xe Graphics]
>>         Flags: bus master, fast devsel, latency 0, IRQ 158
>>         Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
>>         Memory at 90000000 (64-bit, prefetchable) [size=256M]
>>         I/O ports at 1000 [size=64]
>>         Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: i915
>>         Kernel modules: i915
>>
>> 00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor Gaussian & Neural Accelerator (rev 02)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0, IRQ 255
>>         Memory at 80720000 (64-bit, non-prefetchable) [size=4K]
>>         Capabilities: <access denied>
>>
>> 00:0a.0 Signal processing controller: Intel Corporation Platform Monitoring Technology (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: fast devsel
>>         Memory at 80710000 (64-bit, non-prefetchable) [size=32K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: intel_vsec
>>         Kernel modules: intel_vsec
>>
>> 00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Controller (rev 01) (prog-if 30 [XHCI])
>>         Flags: bus master, medium devsel, latency 0, IRQ 124
>>         Memory at 80700000 (64-bit, non-prefetchable) [size=64K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: xhci_hcd
>>         Kernel modules: xhci_pci
>>
>> 00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0
>>         Memory at 80718000 (64-bit, non-prefetchable) [size=16K]
>>         Memory at 80721000 (64-bit, non-prefetchable) [size=4K]
>>         Capabilities: <access denied>
>>
>> 00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO I2C Controller #0 (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0, IRQ 37
>>         Memory at 80722000 (64-bit, non-prefetchable) [size=4K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: intel-lpss
>>         Kernel modules: intel_lpss_pci
>>
>> 00:1c.0 PCI bridge: Intel Corporation Device 51bc (rev 01) (prog-if 00 [Normal decode])
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0, IRQ 122
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         I/O behind bridge: [disabled] [16-bit]
>>         Memory behind bridge: 80400000-804fffff [size=1M] [32-bit]
>>         Prefetchable memory behind bridge: [disabled] [64-bit]
>>         Capabilities: <access denied>
>>         Kernel driver in use: pcieport
>>
>> 00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port #9 (rev 01) (prog-if 00 [Normal decode])
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0, IRQ 123
>>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>>         I/O behind bridge: 2000-2fff [size=4K] [16-bit]
>>         Memory behind bridge: 80500000-805fffff [size=1M] [32-bit]
>>         Prefetchable memory behind bridge: 87fc00000-87fdfffff [size=2M] [32-bit]
>>         Capabilities: <access denied>
>>         Kernel driver in use: pcieport
>>
>> 00:1e.0 Communication controller: Intel Corporation Alder Lake PCH UART #0 (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0, IRQ 23
>>         Memory at fe03e000 (64-bit, non-prefetchable) [size=4K]
>>         Memory at 80724000 (64-bit, non-prefetchable) [size=4K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: intel-lpss
>>         Kernel modules: intel_lpss_pci
>>
>> 00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0
>>
>> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High Definition Audio Controller (rev 01)
>>         Flags: bus master, fast devsel, latency 64, IRQ 159
>>         Memory at 8071c000 (64-bit, non-prefetchable) [size=16K]
>>         Memory at 80600000 (64-bit, non-prefetchable) [size=1M]
>>         Capabilities: <access denied>
>>         Kernel driver in use: snd_hda_intel
>>         Kernel modules: snd_hda_intel, snd_sof_pci_intel_tgl
>>
>> 00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host Controller (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: medium devsel, IRQ 23
>>         Memory at 80726000 (64-bit, non-prefetchable) [size=256]
>>         I/O ports at efa0 [size=32]
>>         Kernel driver in use: i801_smbus
>>         Kernel modules: i2c_i801
>>
>> 00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI Controller (rev 01)
>>         Subsystem: Intel Corporation Device 7270
>>         Flags: bus master, fast devsel, latency 0
>>         Memory at 80725000 (32-bit, non-prefetchable) [size=4K]
>>         Kernel driver in use: intel-spi
>>         Kernel modules: spi_intel_pci
>>
>> 01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz (rev 1a)
>>         Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
>>         Flags: bus master, fast devsel, latency 0, IRQ 16
>>         Memory at 80400000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: iwlwifi
>>         Kernel modules: iwlwifi
>>
>> 02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
>>         Subsystem: Samsung Electronics Co Ltd Device a801
>>         Physical Slot: 8
>>         Flags: bus master, fast devsel, latency 0, IRQ 16
>>         Memory at 80500000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: <access denied>
>>         Kernel driver in use: nvme
>>         Kernel modules: nvme
>>
>>
>>
> 

