Return-Path: <stable+bounces-10809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250182CCDB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 14:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4FD1F226CE
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 13:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DE21116;
	Sat, 13 Jan 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="a41tjqs+"
X-Original-To: stable@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F721103;
	Sat, 13 Jan 2024 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 8D619106015F;
	Sat, 13 Jan 2024 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705153126;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=PEwPOHk55gedfNGO3FG/nBqySEcIwjYgfqG+lIOScDE=;
	b=a41tjqs+k0a9vy82/Mw+MBLTtmy9d8cJ79mjYR7IcahxnJYc9HG5a5Ld0CeJ4PF9
	VcfGmK6Ys3fxF2MMgH9RSx6hJRCORWruGyVWTbLJ5IUq0RFsVdmujMCMX3YFmcwz580
	kMc9shckiqadRlr6UgbMyH8wTg11y6F1ZOPkONEb9xel/k+wOpDfh3HXbHhmc1Tt0LA
	jIWXMs38hx0CQngslU4j7JxIbsLwCsEQ2ugL+LnCJ5XtKzx1iPdAPt9em+8clBHZLDj
	sZNkIjMT9ukDSKZnIHcq0Lon1MuAdCbrrLl+DXoaIHkq7i/ocro1zmpP3H55cVxZ+if
	x0ER8KkYYw==
Date: Sat, 13 Jan 2024 14:38:46 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	Stable <stable@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Message-ID: <No21xeV--3-9@well-founded.dev>
Subject: Built-in Intel Bluetooth device disappeared after booting Linux 6.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I am running an alder lake i7 1260P with built-in bluetooth.
This adapter always worked fine with no special config, but since I booted =
Linux 6.7, the device completely disappeared. There's no mention of bluetoo=
th in the kernel or system logs, there's no device node, and there's no ent=
ry in lspci.
When I boot the last working kernel again (6.6.10), the device also doesn't=
 appear (even though it did before, see logs below).

I also tried booting a ubuntu live ISO to exclude any configuration issues =
with my distro's (NixOS) kernel or such, and also there the device did not =
show up.

I am not sure at all that this is related to the kernel, but I wouldn't kno=
w where else to look. I am including below my system logs (journalctl -g 'b=
lue|Blue|Linux') showing the kernel version and the bluetooth related entri=
es. As you can see, on 6.6.10 the bluetooth module got loaded, /dev/hci0 ge=
ts created, and user space sets up the bluetooth stack.

The next boot entry is the first time I booted 6.7, and there's no mention =
of bluetooth at all in the logs. I tried to load the bluetooth module manua=
lly, which succeeds but doesn't create a device node.

When I boot 6.6.10 again now, I get exactly the same as on 6.7. I don't kno=
w if the kernel could have done anything persistent to the device that make=
s that it doesn't get initialised anymore?

I'm not sure how to debug this further, let me know if there's a way to get=
 more detailed info in the kernel logs or such.

Thanks,
Ramses


Logs with 6.6.10:

-- Boot 7847b5595e1d40a8bf2624542e5fff74 --
jan 09 02:03:50 localhost kernel: Linux version 6.6.10 (nixbld@localhost) (=
gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC =
Fri Jan=C2=A0 5 14:19:45 UTC 2024
jan 09 02:03:50 localhost kernel: SELinux:=C2=A0 Initializing.
jan 09 02:03:50 localhost kernel: usb usb1: Manufacturer: Linux 6.6.10 xhci=
-hcd
jan 09 02:03:50 localhost kernel: usb usb2: Manufacturer: Linux 6.6.10 xhci=
-hcd
jan 09 02:04:02 starbook kernel: Linux agpgart interface v0.103
jan 09 02:04:02 starbook kernel: mc: Linux media interface: v0.10
jan 09 02:04:02 starbook kernel: Bluetooth: Core ver 2.22
jan 09 02:04:02 starbook kernel: Bluetooth: HCI device and connection manag=
er initialized
jan 09 02:04:02 starbook kernel: Bluetooth: HCI socket layer initialized
jan 09 02:04:02 starbook kernel: Bluetooth: L2CAP socket layer initialized
jan 09 02:04:02 starbook kernel: Bluetooth: SCO socket layer initialized
jan 09 02:04:03 starbook kernel: videodev: Linux video capture interface: v=
2.00
jan 09 02:04:03 starbook kernel: Intel(R) Wireless WiFi driver for Linux
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware timestamp 2023.4=
2 buildtype 1 build 73111
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: No support for _PRR ACPI =
method
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Found device firmware: in=
tel/ibt-0041-0041.sfi
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Boot Address: 0x100800
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware Version: 151-42.=
23
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware already loaded
jan 09 02:04:03 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate name =
'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate name =
'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bl=
uez-5.70/share/dbus-1/system-services/org.bluez.servi>
jan 09 02:04:04 starbook systemd[1]: Starting Bluetooth service...
jan 09 02:04:04 starbook (uetoothd)[1275]: bluetooth.service: Configuration=
Directory 'bluetooth' already exists but the mode is different. (File syste=
m: 755 ConfigurationDirectoryMode: 555)
jan 09 02:04:04 starbook kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1=
.3
jan 09 02:04:04 starbook kernel: Bluetooth: BNEP socket layer initialized
jan 09 02:04:04 starbook kernel: Bluetooth: MGMT ver 1.22
jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth daemon 5.70
jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth management interface 1=
.22 initialized
jan 09 02:04:04 starbook systemd[1]: Started Bluetooth service.
jan 09 02:04:04 starbook systemd[1]: Reached target Bluetooth Support.
jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad5p=
yg-system-path/share/dbus-1/services/org.bluez.obex.s>
jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM TTY layer initialized
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM socket layer initialized
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM ver 1.11
jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad5p=
yg-system-path/share/dbus-1/services/org.bluez.obex.s>
jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
jan 09 09:22:05 starbook systemd[1]: Stopped target Bluetooth Support.
jan 09 09:22:05 starbook systemd[1]: Stopping Bluetooth service...
jan 09 09:22:05 starbook systemd[1]: bluetooth.service: Deactivated success=
fully.
jan 09 09:22:05 starbook systemd[1]: Stopped Bluetooth service.


With 6.7

-- Boot 7840f56ab2434c9fb1b899e7abea32cc --
jan 09 09:26:07 localhost kernel: Linux version 6.7.0 (nixbld@localhost) (g=
cc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC S=
un Jan=C2=A0 7 20:18:38 UTC 2024
jan 09 09:26:07 localhost kernel: SELinux:=C2=A0 Initializing.
jan 09 09:26:07 localhost kernel: usb usb1: Manufacturer: Linux 6.7.0 xhci-=
hcd
jan 09 09:26:07 localhost kernel: usb usb2: Manufacturer: Linux 6.7.0 xhci-=
hcd
jan 09 09:26:17 starbook kernel: mc: Linux media interface: v0.10
jan 09 09:26:17 starbook kernel: Linux agpgart interface v0.103
jan 09 09:26:17 starbook kernel: videodev: Linux video capture interface: v=
2.00
jan 09 09:26:17 starbook kernel: Intel(R) Wireless WiFi driver for Linux
jan 09 09:26:17 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate name =
'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate name =
'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-bl=
uez-5.70/share/dbus-1/system-services/org.bluez.servi>
jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33bcl=
wa-system-path/share/dbus-1/services/org.bluez.obex.s>
jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33bcl=
wa-system-path/share/dbus-1/services/org.bluez.obex.s>
jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate name =
'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j=
0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
jan 09 09:26:43 starbook systemd[1]: Bluetooth service was skipped because =
of an unmet condition check (ConditionPathIsDirectory=3D/sys/class/bluetoot=
h).


lspci output (on 6.7):

=E2=9E=9C lspci -v
00:00.0 Host bridge: Intel Corporation Device 4621 (rev 02)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: igen6_edac
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: igen6_edac

00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P GT2 [Iris=
 Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceName: VGA compatible contr=
oller
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Ald=
er Lake-P GT2 [Iris Xe Graphics]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 158
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 81000000 (64-bit, non-=
prefetchable) [size=3D16M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 90000000 (64-bit, pref=
etchable) [size=3D256M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at 1000 [size=3D64]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expansion ROM at 000c0000 [virtu=
al] [disabled] [size=3D128K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i915
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i915

00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor Gaussi=
an & Neural Accelerator (rev 02)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 255
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80720000 (64-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>

00:0a.0 Signal processing controller: Intel Corporation Platform Monitoring=
 Technology (rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: fast devsel
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80710000 (64-bit, non-=
prefetchable) [size=3D32K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel_vsec
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_vsec

00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host =
Controller (rev 01) (prog-if 30 [XHCI])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, medium devsel=
, latency 0, IRQ 124
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80700000 (64-bit, non-=
prefetchable) [size=3D64K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: xhci_hcd
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: xhci_pci

00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80718000 (64-bit, non-=
prefetchable) [size=3D16K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80721000 (64-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>

00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO I=
2C Controller #0 (rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 37
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80722000 (64-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-lpss
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_pci

00:1c.0 PCI bridge: Intel Corporation Device 51bc (rev 01) (prog-if 00 [Nor=
mal decode])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 122
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D0=
1, subordinate=3D01, sec-latency=3D0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: [disabled] [1=
6-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 80400000-8=
04fffff [size=3D1M] [32-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridg=
e: [disabled] [64-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport

00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port #9 (=
rev 01) (prog-if 00 [Normal decode])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 123
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D0=
2, subordinate=3D02, sec-latency=3D0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 2000-2fff [si=
ze=3D4K] [16-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 80500000-8=
05fffff [size=3D1M] [32-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridg=
e: 87fc00000-87fdfffff [size=3D2M] [32-bit]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport

00:1e.0 Communication controller: Intel Corporation Alder Lake PCH UART #0 =
(rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 23
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at fe03e000 (64-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80724000 (64-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-lpss
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_pci

00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller (rev 0=
1)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0

00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High Definition Au=
dio Controller (rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 64, IRQ 159
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 8071c000 (64-bit, non-=
prefetchable) [size=3D16K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80600000 (64-bit, non-=
prefetchable) [size=3D1M]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: snd_hda_in=
tel
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_intel, s=
nd_sof_pci_intel_tgl

00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host Controller (re=
v 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: medium devsel, IRQ 23
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80726000 (64-bit, non-=
prefetchable) [size=3D256]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at efa0 [size=3D32]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i801_smbus
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i2c_i801

00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI Contr=
oller (rev 01)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Dev=
ice 7270
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80725000 (32-bit, non-=
prefetchable) [size=3D4K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-spi
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: spi_intel_pci

01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160=
MHz (rev 1a)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation Wi-=
Fi 6 AX210 160MHz
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 16
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80400000 (64-bit, non-=
prefetchable) [size=3D16K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: iwlwifi
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: iwlwifi

02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD=
 Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electronics C=
o Ltd Device a801
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical Slot: 8
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, =
latency 0, IRQ 16
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80500000 (64-bit, non-=
prefetchable) [size=3D16K]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: nvme


