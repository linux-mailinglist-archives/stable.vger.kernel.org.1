Return-Path: <stable+bounces-10812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87982CCED
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 15:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560DF1F226AB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6D2134E;
	Sat, 13 Jan 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="Rr/vxPz4"
X-Original-To: stable@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C521344;
	Sat, 13 Jan 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 9A53A1060165;
	Sat, 13 Jan 2024 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705154759;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=txn98ZRrZdHWXLCBz9PliZesMlnogXqWHmmpW9Pmh1Q=;
	b=Rr/vxPz4e2Gn/kcBQxxZwvHPbwxfVQMcoaV0nvTDCbDCTUWuJheqSZH8Ld/LAjZh
	xPN3nqsInBuPIXIXRyAH0O8t6Ee7JnfjGOJKH5O0oiiGrHeUfaPp1JwqFfJDttXKXiM
	jzkZj3F94VE+1lorq5GVnCnen13afXRW6v3HeQRTc6KNzRBarpHcGl/18FJKSBFPThY
	TKOWG3n8o+tvGf8I1nF0oIjZgff0RmTmr2AtfblcB73XHg61LUYtLUvcjPNcP0kxx58
	xEZusSfWOru0tC3eVCqwxsl0riVUpa9yGnceI4rB5HLyNzJBerZZ1VhCDImtoDwIDHB
	zk2+R/OFSw==
Date: Sat, 13 Jan 2024 15:05:59 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	Stable <stable@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Message-ID: <No28BcQ--3-9@well-founded.dev>
In-Reply-To: <No21xeV--3-9@well-founded.dev>
References: <No21xeV--3-9@well-founded.dev>
Subject: Re: Built-in Intel Bluetooth device disappeared after booting Linux
 6.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3365_998781800.1705154759365"

------=_Part_3365_998781800.1705154759365
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I forgot to add the full kernel logs, attached the logs of 6.6.10 with work=
ing bluetooth and 6.7 where bluetooth is not working.

I am also including a recent boot with 6.6.9 (after having booted with 6.7)=
 where bluetooth is also not showing up, even though it did work before on =
the same kernel build.

Thanks,
Ramses


Jan 13, 2024, 14:38 by ramses@well-founded.dev:

> I am running an alder lake i7 1260P with built-in bluetooth.
> This adapter always worked fine with no special config, but since I boote=
d Linux 6.7, the device completely disappeared. There's no mention of bluet=
ooth in the kernel or system logs, there's no device node, and there's no e=
ntry in lspci.
> When I boot the last working kernel again (6.6.10), the device also doesn=
't appear (even though it did before, see logs below).
>
> I also tried booting a ubuntu live ISO to exclude any configuration issue=
s with my distro's (NixOS) kernel or such, and also there the device did no=
t show up.
>
> I am not sure at all that this is related to the kernel, but I wouldn't k=
now where else to look. I am including below my system logs (journalctl -g =
'blue|Blue|Linux') showing the kernel version and the bluetooth related ent=
ries. As you can see, on 6.6.10 the bluetooth module got loaded, /dev/hci0 =
gets created, and user space sets up the bluetooth stack.
>
> The next boot entry is the first time I booted 6.7, and there's no mentio=
n of bluetooth at all in the logs. I tried to load the bluetooth module man=
ually, which succeeds but doesn't create a device node.
>
> When I boot 6.6.10 again now, I get exactly the same as on 6.7. I don't k=
now if the kernel could have done anything persistent to the device that ma=
kes that it doesn't get initialised anymore?
>
> I'm not sure how to debug this further, let me know if there's a way to g=
et more detailed info in the kernel logs or such.
>
> Thanks,
> Ramses
>
>
> Logs with 6.6.10:
>
> -- Boot 7847b5595e1d40a8bf2624542e5fff74 --
> jan 09 02:03:50 localhost kernel: Linux version 6.6.10 (nixbld@localhost)=
 (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMI=
C Fri Jan=C2=A0 5 14:19:45 UTC 2024
> jan 09 02:03:50 localhost kernel: SELinux:=C2=A0 Initializing.
> jan 09 02:03:50 localhost kernel: usb usb1: Manufacturer: Linux 6.6.10 xh=
ci-hcd
> jan 09 02:03:50 localhost kernel: usb usb2: Manufacturer: Linux 6.6.10 xh=
ci-hcd
> jan 09 02:04:02 starbook kernel: Linux agpgart interface v0.103
> jan 09 02:04:02 starbook kernel: mc: Linux media interface: v0.10
> jan 09 02:04:02 starbook kernel: Bluetooth: Core ver 2.22
> jan 09 02:04:02 starbook kernel: Bluetooth: HCI device and connection man=
ager initialized
> jan 09 02:04:02 starbook kernel: Bluetooth: HCI socket layer initialized
> jan 09 02:04:02 starbook kernel: Bluetooth: L2CAP socket layer initialize=
d
> jan 09 02:04:02 starbook kernel: Bluetooth: SCO socket layer initialized
> jan 09 02:04:03 starbook kernel: videodev: Linux video capture interface:=
 v2.00
> jan 09 02:04:03 starbook kernel: Intel(R) Wireless WiFi driver for Linux
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware timestamp 2023=
.42 buildtype 1 build 73111
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: No support for _PRR ACP=
I method
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Found device firmware: =
intel/ibt-0041-0041.sfi
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Boot Address: 0x100800
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware Version: 151-4=
2.23
> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware already loaded
> jan 09 02:04:03 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate nam=
e 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate nam=
e 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-=
bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
> jan 09 02:04:04 starbook systemd[1]: Starting Bluetooth service...
> jan 09 02:04:04 starbook (uetoothd)[1275]: bluetooth.service: Configurati=
onDirectory 'bluetooth' already exists but the mode is different. (File sys=
tem: 755 ConfigurationDirectoryMode: 555)
> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP (Ethernet Emulation) ver=
 1.3
> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP socket layer initialized
> jan 09 02:04:04 starbook kernel: Bluetooth: MGMT ver 1.22
> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth daemon 5.70
> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth management interface=
 1.22 initialized
> jan 09 02:04:04 starbook systemd[1]: Started Bluetooth service.
> jan 09 02:04:04 starbook systemd[1]: Reached target Bluetooth Support.
> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad=
5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM TTY layer initialized
> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM socket layer initializ=
ed
> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM ver 1.11
> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iwad=
5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
> jan 09 09:22:05 starbook systemd[1]: Stopped target Bluetooth Support.
> jan 09 09:22:05 starbook systemd[1]: Stopping Bluetooth service...
> jan 09 09:22:05 starbook systemd[1]: bluetooth.service: Deactivated succe=
ssfully.
> jan 09 09:22:05 starbook systemd[1]: Stopped Bluetooth service.
>
>
>
> With 6.7
>
> -- Boot 7840f56ab2434c9fb1b899e7abea32cc --
> jan 09 09:26:07 localhost kernel: Linux version 6.7.0 (nixbld@localhost) =
(gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC=
 Sun Jan=C2=A0 7 20:18:38 UTC 2024
> jan 09 09:26:07 localhost kernel: SELinux:=C2=A0 Initializing.
> jan 09 09:26:07 localhost kernel: usb usb1: Manufacturer: Linux 6.7.0 xhc=
i-hcd
> jan 09 09:26:07 localhost kernel: usb usb2: Manufacturer: Linux 6.7.0 xhc=
i-hcd
> jan 09 09:26:17 starbook kernel: mc: Linux media interface: v0.10
> jan 09 09:26:17 starbook kernel: Linux agpgart interface v0.103
> jan 09 09:26:17 starbook kernel: videodev: Linux video capture interface:=
 v2.00
> jan 09 09:26:17 starbook kernel: Intel(R) Wireless WiFi driver for Linux
> jan 09 09:26:17 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate nam=
e 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate nam=
e 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0w-=
bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33b=
clwa-system-path/share/dbus-1/services/org.bluez.obex.s>
> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj33b=
clwa-system-path/share/dbus-1/services/org.bluez.obex.s>
> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate nam=
e 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh9=
8j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
> jan 09 09:26:43 starbook systemd[1]: Bluetooth service was skipped becaus=
e of an unmet condition check (ConditionPathIsDirectory=3D/sys/class/blueto=
oth).
>
>
> lspci output (on 6.7):
>
> =E2=9E=9C lspci -v
> 00:00.0 Host bridge: Intel Corporation Device 4621 (rev 02)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: igen6_ed=
ac
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: igen6_edac
>
> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P GT2 [Ir=
is Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceName: VGA compatible con=
troller
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation A=
lder Lake-P GT2 [Iris Xe Graphics]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 158
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 81000000 (64-bit, no=
n-prefetchable) [size=3D16M]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 90000000 (64-bit, pr=
efetchable) [size=3D256M]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at 1000 [size=3D64]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expansion ROM at 000c0000 [vir=
tual] [disabled] [size=3D128K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i915
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i915
>
> 00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor Gaus=
sian & Neural Accelerator (rev 02)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 255
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80720000 (64-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
>
> 00:0a.0 Signal processing controller: Intel Corporation Platform Monitori=
ng Technology (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: fast devsel
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80710000 (64-bit, no=
n-prefetchable) [size=3D32K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel_vs=
ec
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_vsec
>
> 00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI Hos=
t Controller (rev 01) (prog-if 30 [XHCI])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, medium devs=
el, latency 0, IRQ 124
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80700000 (64-bit, no=
n-prefetchable) [size=3D64K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: xhci_hcd
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: xhci_pci
>
> 00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80718000 (64-bit, no=
n-prefetchable) [size=3D16K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80721000 (64-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
>
> 00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO=
 I2C Controller #0 (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 37
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80722000 (64-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-lp=
ss
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_pci
>
> 00:1c.0 PCI bridge: Intel Corporation Device 51bc (rev 01) (prog-if 00 [N=
ormal decode])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 122
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=
=3D01, subordinate=3D01, sec-latency=3D0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: [disabled] =
[16-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 80400000=
-804fffff [size=3D1M] [32-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bri=
dge: [disabled] [64-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport
>
> 00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port #9=
 (rev 01) (prog-if 00 [Normal decode])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 123
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=
=3D02, subordinate=3D02, sec-latency=3D0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 2000-2fff [=
size=3D4K] [16-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 80500000=
-805fffff [size=3D1M] [32-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bri=
dge: 87fc00000-87fdfffff [size=3D2M] [32-bit]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport
>
> 00:1e.0 Communication controller: Intel Corporation Alder Lake PCH UART #=
0 (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 23
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at fe03e000 (64-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80724000 (64-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-lp=
ss
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_pci
>
> 00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller (rev=
 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0
>
> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High Definition =
Audio Controller (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 64, IRQ 159
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 8071c000 (64-bit, no=
n-prefetchable) [size=3D16K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80600000 (64-bit, no=
n-prefetchable) [size=3D1M]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: snd_hda_=
intel
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_intel,=
 snd_sof_pci_intel_tgl
>
> 00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host Controller (=
rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: medium devsel, IRQ 23
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80726000 (64-bit, no=
n-prefetchable) [size=3D256]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at efa0 [size=3D32]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i801_smb=
us
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i2c_i801
>
> 00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI Con=
troller (rev 01)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation D=
evice 7270
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80725000 (32-bit, no=
n-prefetchable) [size=3D4K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-sp=
i
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: spi_intel_pci
>
> 01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411 1=
60MHz (rev 1a)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation W=
i-Fi 6 AX210 160MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 16
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80400000 (64-bit, no=
n-prefetchable) [size=3D16K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: iwlwifi
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: iwlwifi
>
> 02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe S=
SD Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electronics=
 Co Ltd Device a801
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical Slot: 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel=
, latency 0, IRQ 16
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80500000 (64-bit, no=
n-prefetchable) [size=3D16K]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: nvme
>
>
>


------=_Part_3365_998781800.1705154759365
Content-Type: text/plain; charset=us-ascii; name=dmesg_6_7_no_bluetooth.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg_6_7_no_bluetooth.txt

jan 13 14:17:13 localhost kernel: Linux version 6.7.0 (nixbld@localhost) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Sun Jan  7 20:18:38 UTC 2024
jan 13 14:17:13 localhost kernel: Command line: initrd=\efi\nixos\jmgscj8cqwj87hjjh8cx2rmfc7fwmifg-initrd-linux-6.7-initrd.efi init=/nix/store/v4i4ivmgwz4zvlp6k4b0lq4lwc3rch2w-nixos-system-starbook-20240108.317484b.20240113.a707985/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 13 14:17:13 localhost kernel: x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
jan 13 14:17:13 localhost kernel: BIOS-provided physical RAM map:
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000000100000-0x0000000076733fff] usable
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000076734000-0x0000000076933fff] reserved
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000076934000-0x0000000076940fff] usable
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000076941000-0x0000000076958fff] ACPI data
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000076959000-0x0000000076959fff] usable
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x000000007695a000-0x00000000803fffff] reserved
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x00000000ff030000-0x00000000ff06ffff] reserved
jan 13 14:17:13 localhost kernel: BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
jan 13 14:17:13 localhost kernel: NX (Execute Disable) protection: active
jan 13 14:17:13 localhost kernel: APIC: Static calls initialized
jan 13 14:17:13 localhost kernel: efi: EFI v2.7 by EDK II
jan 13 14:17:13 localhost kernel: efi: SMBIOS=0x7691b000 SMBIOS 3.0=0x76919000 ACPI=0x76958000 ACPI 2.0=0x76958014 MEMATTR=0x73c95298 INITRD=0x736aae98 
jan 13 14:17:13 localhost kernel: efi: Remove mem99: MMIO range=[0xff030000-0xff06ffff] (0MB) from e820 map
jan 13 14:17:13 localhost kernel: e820: remove [mem 0xff030000-0xff06ffff] reserved
jan 13 14:17:13 localhost kernel: SMBIOS 3.0.0 present.
jan 13 14:17:13 localhost kernel: DMI: Star Labs StarBook/StarBook, BIOS 9.00 12/07/2023
jan 13 14:17:13 localhost kernel: tsc: Detected 2500.000 MHz processor
jan 13 14:17:13 localhost kernel: tsc: Detected 2496.000 MHz TSC
jan 13 14:17:13 localhost kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
jan 13 14:17:13 localhost kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
jan 13 14:17:13 localhost kernel: last_pfn = 0x87fc00 max_arch_pfn = 0x400000000
jan 13 14:17:13 localhost kernel: MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
jan 13 14:17:13 localhost kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
jan 13 14:17:13 localhost kernel: last_pfn = 0x7695a max_arch_pfn = 0x400000000
jan 13 14:17:13 localhost kernel: Using GB pages for direct mapping
jan 13 14:17:13 localhost kernel: Incomplete global flushes, disabling PCID
jan 13 14:17:13 localhost kernel: Secure boot disabled
jan 13 14:17:13 localhost kernel: RAMDISK: [mem 0x6ecf9000-0x707cefff]
jan 13 14:17:13 localhost kernel: ACPI: Early table checksum verification disabled
jan 13 14:17:13 localhost kernel: ACPI: RSDP 0x0000000076958014 000024 (v02 COREv4)
jan 13 14:17:13 localhost kernel: ACPI: XSDT 0x00000000769570E8 000074 (v01 COREv4 COREBOOT 00000000      01000013)
jan 13 14:17:13 localhost kernel: ACPI: FACP 0x0000000076956000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: DSDT 0x0000000076950000 005063 (v02 COREv4 COREBOOT 20220930 INTL 20230628)
jan 13 14:17:13 localhost kernel: ACPI: FACS 0x0000000076967240 000040
jan 13 14:17:13 localhost kernel: ACPI: SSDT 0x000000007694B000 0045F7 (v02 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: MCFG 0x000000007694A000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: TPM2 0x0000000076949000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: LPIT 0x0000000076948000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: APIC 0x0000000076947000 0000D2 (v03 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: DMAR 0x0000000076946000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: DBG2 0x0000000076945000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: HPET 0x0000000076944000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 13 14:17:13 localhost kernel: ACPI: BGRT 0x0000000076943000 000038 (v01 INTEL  EDK2     00000002      01000013)
jan 13 14:17:13 localhost kernel: ACPI: Reserving FACP table memory at [mem 0x76956000-0x76956113]
jan 13 14:17:13 localhost kernel: ACPI: Reserving DSDT table memory at [mem 0x76950000-0x76955062]
jan 13 14:17:13 localhost kernel: ACPI: Reserving FACS table memory at [mem 0x76967240-0x7696727f]
jan 13 14:17:13 localhost kernel: ACPI: Reserving SSDT table memory at [mem 0x7694b000-0x7694f5f6]
jan 13 14:17:13 localhost kernel: ACPI: Reserving MCFG table memory at [mem 0x7694a000-0x7694a03b]
jan 13 14:17:13 localhost kernel: ACPI: Reserving TPM2 table memory at [mem 0x76949000-0x7694904b]
jan 13 14:17:13 localhost kernel: ACPI: Reserving LPIT table memory at [mem 0x76948000-0x76948093]
jan 13 14:17:13 localhost kernel: ACPI: Reserving APIC table memory at [mem 0x76947000-0x769470d1]
jan 13 14:17:13 localhost kernel: ACPI: Reserving DMAR table memory at [mem 0x76946000-0x76946087]
jan 13 14:17:13 localhost kernel: ACPI: Reserving DBG2 table memory at [mem 0x76945000-0x76945060]
jan 13 14:17:13 localhost kernel: ACPI: Reserving HPET table memory at [mem 0x76944000-0x76944037]
jan 13 14:17:13 localhost kernel: ACPI: Reserving BGRT table memory at [mem 0x76943000-0x76943037]
jan 13 14:17:13 localhost kernel: No NUMA configuration found
jan 13 14:17:13 localhost kernel: Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
jan 13 14:17:13 localhost kernel: NODE_DATA(0) allocated [mem 0x87fbfa000-0x87fbfffff]
jan 13 14:17:13 localhost kernel: Zone ranges:
jan 13 14:17:13 localhost kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
jan 13 14:17:13 localhost kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
jan 13 14:17:13 localhost kernel:   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
jan 13 14:17:13 localhost kernel:   Device   empty
jan 13 14:17:13 localhost kernel: Movable zone start for each node
jan 13 14:17:13 localhost kernel: Early memory node ranges
jan 13 14:17:13 localhost kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
jan 13 14:17:13 localhost kernel:   node   0: [mem 0x0000000000100000-0x0000000076733fff]
jan 13 14:17:13 localhost kernel:   node   0: [mem 0x0000000076934000-0x0000000076940fff]
jan 13 14:17:13 localhost kernel:   node   0: [mem 0x0000000076959000-0x0000000076959fff]
jan 13 14:17:13 localhost kernel:   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
jan 13 14:17:13 localhost kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbfffff]
jan 13 14:17:13 localhost kernel: On node 0, zone DMA: 1 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: On node 0, zone DMA: 96 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: On node 0, zone DMA32: 512 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: On node 0, zone DMA32: 24 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: On node 0, zone Normal: 5798 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: On node 0, zone Normal: 1024 pages in unavailable ranges
jan 13 14:17:13 localhost kernel: Reserving Intel graphics memory at [mem 0x7c800000-0x803fffff]
jan 13 14:17:13 localhost kernel: ACPI: PM-Timer IO Port: 0x1808
jan 13 14:17:13 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
jan 13 14:17:13 localhost kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
jan 13 14:17:13 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
jan 13 14:17:13 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
jan 13 14:17:13 localhost kernel: ACPI: Using ACPI (MADT) for SMP configuration information
jan 13 14:17:13 localhost kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
jan 13 14:17:13 localhost kernel: e820: update [mem 0x736ce000-0x736f5fff] usable ==> reserved
jan 13 14:17:13 localhost kernel: TSC deadline timer available
jan 13 14:17:13 localhost kernel: smpboot: Allowing 16 CPUs, 0 hotplug CPUs
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x736ce000-0x736f5fff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76734000-0x76933fff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76941000-0x76958fff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x7695a000-0x803fffff]
jan 13 14:17:13 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x80400000-0xffffffff]
jan 13 14:17:13 localhost kernel: [mem 0x80400000-0xffffffff] available for PCI devices
jan 13 14:17:13 localhost kernel: Booting paravirtualized kernel on bare hardware
jan 13 14:17:13 localhost kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
jan 13 14:17:13 localhost kernel: setup_percpu: NR_CPUS:384 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
jan 13 14:17:13 localhost kernel: percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u524288
jan 13 14:17:13 localhost kernel: pcpu-alloc: s221184 r8192 d114688 u524288 alloc=1*2097152
jan 13 14:17:13 localhost kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
jan 13 14:17:13 localhost kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
jan 13 14:17:13 localhost kernel: Kernel command line: initrd=\efi\nixos\jmgscj8cqwj87hjjh8cx2rmfc7fwmifg-initrd-linux-6.7-initrd.efi init=/nix/store/v4i4ivmgwz4zvlp6k4b0lq4lwc3rch2w-nixos-system-starbook-20240108.317484b.20240113.a707985/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 13 14:17:13 localhost kernel: random: crng init done
jan 13 14:17:13 localhost kernel: Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
jan 13 14:17:13 localhost kernel: Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
jan 13 14:17:13 localhost kernel: Fallback order for Node 0: 0 
jan 13 14:17:13 localhost kernel: Built 1 zonelists, mobility grouping on.  Total pages: 8216356
jan 13 14:17:13 localhost kernel: Policy zone: Normal
jan 13 14:17:13 localhost kernel: mem auto-init: stack:all(zero), heap alloc:off, heap free:off
jan 13 14:17:13 localhost kernel: software IO TLB: area num 16.
jan 13 14:17:13 localhost kernel: Memory: 32626336K/33393540K available (14336K kernel code, 2319K rwdata, 9404K rodata, 2988K init, 2924K bss, 766944K reserved, 0K cma-reserved)
jan 13 14:17:13 localhost kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
jan 13 14:17:13 localhost kernel: ftrace: allocating 40185 entries in 157 pages
jan 13 14:17:13 localhost kernel: ftrace: allocated 157 pages with 5 groups
jan 13 14:17:13 localhost kernel: Dynamic Preempt: voluntary
jan 13 14:17:13 localhost kernel: rcu: Preemptible hierarchical RCU implementation.
jan 13 14:17:13 localhost kernel: rcu:         RCU event tracing is enabled.
jan 13 14:17:13 localhost kernel: rcu:         RCU restricting CPUs from NR_CPUS=384 to nr_cpu_ids=16.
jan 13 14:17:13 localhost kernel:         Trampoline variant of Tasks RCU enabled.
jan 13 14:17:13 localhost kernel:         Rude variant of Tasks RCU enabled.
jan 13 14:17:13 localhost kernel:         Tracing variant of Tasks RCU enabled.
jan 13 14:17:13 localhost kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
jan 13 14:17:13 localhost kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
jan 13 14:17:13 localhost kernel: NR_IRQS: 24832, nr_irqs: 2184, preallocated irqs: 16
jan 13 14:17:13 localhost kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
jan 13 14:17:13 localhost kernel: spurious 8259A interrupt: IRQ7.
jan 13 14:17:13 localhost kernel: Console: colour dummy device 80x25
jan 13 14:17:13 localhost kernel: printk: legacy console [tty0] enabled
jan 13 14:17:13 localhost kernel: ACPI: Core revision 20230628
jan 13 14:17:13 localhost kernel: hpet: HPET dysfunctional in PC10. Force disabled.
jan 13 14:17:13 localhost kernel: APIC: Switch to symmetric I/O mode setup
jan 13 14:17:13 localhost kernel: DMAR: Host address width 39
jan 13 14:17:13 localhost kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0x0
jan 13 14:17:13 localhost kernel: DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
jan 13 14:17:13 localhost kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0x1
jan 13 14:17:13 localhost kernel: DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
jan 13 14:17:13 localhost kernel: DMAR: RMRR base: 0x0000007c000000 end: 0x000000803fffff
jan 13 14:17:13 localhost kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
jan 13 14:17:13 localhost kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91000
jan 13 14:17:13 localhost kernel: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
jan 13 14:17:13 localhost kernel: DMAR-IR: Enabled IRQ remapping in x2apic mode
jan 13 14:17:13 localhost kernel: x2apic enabled
jan 13 14:17:13 localhost kernel: APIC: Switched APIC routing to: cluster x2apic
jan 13 14:17:13 localhost kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 13 14:17:13 localhost kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.00 BogoMIPS (lpj=2496000)
jan 13 14:17:13 localhost kernel: CPU0: Thermal monitoring enabled (TM1)
jan 13 14:17:13 localhost kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
jan 13 14:17:13 localhost kernel: process: using mwait in idle threads
jan 13 14:17:13 localhost kernel: CET detected: Indirect Branch Tracking enabled
jan 13 14:17:13 localhost kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
jan 13 14:17:13 localhost kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
jan 13 14:17:13 localhost kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
jan 13 14:17:13 localhost kernel: Spectre V2 : Mitigation: Enhanced / Automatic IBRS
jan 13 14:17:13 localhost kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
jan 13 14:17:13 localhost kernel: Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
jan 13 14:17:13 localhost kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
jan 13 14:17:13 localhost kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
jan 13 14:17:13 localhost kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
jan 13 14:17:13 localhost kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
jan 13 14:17:13 localhost kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
jan 13 14:17:13 localhost kernel: x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
jan 13 14:17:13 localhost kernel: x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
jan 13 14:17:13 localhost kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
jan 13 14:17:13 localhost kernel: x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
jan 13 14:17:13 localhost kernel: x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
jan 13 14:17:13 localhost kernel: x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
jan 13 14:17:13 localhost kernel: Freeing SMP alternatives memory: 36K
jan 13 14:17:13 localhost kernel: pid_max: default: 32768 minimum: 301
jan 13 14:17:13 localhost kernel: LSM: initializing lsm=capability,landlock,yama,selinux,bpf,integrity
jan 13 14:17:13 localhost kernel: landlock: Up and running.
jan 13 14:17:13 localhost kernel: Yama: becoming mindful.
jan 13 14:17:13 localhost kernel: SELinux:  Initializing.
jan 13 14:17:13 localhost kernel: LSM support for eBPF active
jan 13 14:17:13 localhost kernel: Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 13 14:17:13 localhost kernel: Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 13 14:17:13 localhost kernel: smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
jan 13 14:17:13 localhost kernel: RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 13 14:17:13 localhost kernel: RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 13 14:17:13 localhost kernel: RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 13 14:17:13 localhost kernel: Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
jan 13 14:17:13 localhost kernel: core: cpu_core PMU driver: 
jan 13 14:17:13 localhost kernel: ... version:                5
jan 13 14:17:13 localhost kernel: ... bit width:              48
jan 13 14:17:13 localhost kernel: ... generic registers:      8
jan 13 14:17:13 localhost kernel: ... value mask:             0000ffffffffffff
jan 13 14:17:13 localhost kernel: ... max period:             00007fffffffffff
jan 13 14:17:13 localhost kernel: ... fixed-purpose events:   4
jan 13 14:17:13 localhost kernel: ... event mask:             0001000f000000ff
jan 13 14:17:13 localhost kernel: signal: max sigframe size: 3632
jan 13 14:17:13 localhost kernel: Estimated ratio of average max frequency by base frequency (times 1024): 1556
jan 13 14:17:13 localhost kernel: rcu: Hierarchical SRCU implementation.
jan 13 14:17:13 localhost kernel: rcu:         Max phase no-delay instances is 400.
jan 13 14:17:13 localhost kernel: smp: Bringing up secondary CPUs ...
jan 13 14:17:13 localhost kernel: smpboot: x86: Booting SMP configuration:
jan 13 14:17:13 localhost kernel: .... node  #0, CPUs:        #2  #4  #6  #8  #9 #10 #11 #12 #13 #14 #15
jan 13 14:17:13 localhost kernel: core: cpu_atom PMU driver: PEBS-via-PT 
jan 13 14:17:13 localhost kernel: ... version:                5
jan 13 14:17:13 localhost kernel: ... bit width:              48
jan 13 14:17:13 localhost kernel: ... generic registers:      6
jan 13 14:17:13 localhost kernel: ... value mask:             0000ffffffffffff
jan 13 14:17:13 localhost kernel: ... max period:             00007fffffffffff
jan 13 14:17:13 localhost kernel: ... fixed-purpose events:   3
jan 13 14:17:13 localhost kernel: ... event mask:             000000070000003f
jan 13 14:17:13 localhost kernel:   #1  #3  #5  #7
jan 13 14:17:13 localhost kernel: smp: Brought up 1 node, 16 CPUs
jan 13 14:17:13 localhost kernel: smpboot: Max logical packages: 1
jan 13 14:17:13 localhost kernel: smpboot: Total of 16 processors activated (79872.00 BogoMIPS)
jan 13 14:17:13 localhost kernel: devtmpfs: initialized
jan 13 14:17:13 localhost kernel: x86/mm: Memory block size: 128MB
jan 13 14:17:13 localhost kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
jan 13 14:17:13 localhost kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
jan 13 14:17:13 localhost kernel: pinctrl core: initialized pinctrl subsystem
jan 13 14:17:13 localhost kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
jan 13 14:17:13 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
jan 13 14:17:13 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
jan 13 14:17:13 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
jan 13 14:17:13 localhost kernel: audit: initializing netlink subsys (disabled)
jan 13 14:17:13 localhost kernel: audit: type=2000 audit(1705151833.015:1): state=initialized audit_enabled=0 res=1
jan 13 14:17:13 localhost kernel: thermal_sys: Registered thermal governor 'bang_bang'
jan 13 14:17:13 localhost kernel: thermal_sys: Registered thermal governor 'step_wise'
jan 13 14:17:13 localhost kernel: thermal_sys: Registered thermal governor 'user_space'
jan 13 14:17:13 localhost kernel: cpuidle: using governor menu
jan 13 14:17:13 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
jan 13 14:17:13 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 13 14:17:13 localhost kernel: PCI: not using MMCONFIG
jan 13 14:17:13 localhost kernel: PCI: Using configuration type 1 for base access
jan 13 14:17:13 localhost kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
jan 13 14:17:13 localhost kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
jan 13 14:17:13 localhost kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
jan 13 14:17:13 localhost kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
jan 13 14:17:13 localhost kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
jan 13 14:17:13 localhost kernel: ACPI: Added _OSI(Module Device)
jan 13 14:17:13 localhost kernel: ACPI: Added _OSI(Processor Device)
jan 13 14:17:13 localhost kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
jan 13 14:17:13 localhost kernel: ACPI: Added _OSI(Processor Aggregator Device)
jan 13 14:17:13 localhost kernel: ACPI: 2 ACPI AML tables successfully acquired and loaded
jan 13 14:17:13 localhost kernel: ACPI: _OSC evaluation for CPUs failed, trying _PDC
jan 13 14:17:13 localhost kernel: ACPI: EC: EC started
jan 13 14:17:13 localhost kernel: ACPI: EC: interrupt blocked
jan 13 14:17:13 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
jan 13 14:17:13 localhost kernel: ACPI: Interpreter enabled
jan 13 14:17:13 localhost kernel: ACPI: PM: (supports S0 S3 S4 S5)
jan 13 14:17:13 localhost kernel: ACPI: Using IOAPIC for interrupt routing
jan 13 14:17:13 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 13 14:17:13 localhost kernel: PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved as ACPI motherboard resource
jan 13 14:17:13 localhost kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
jan 13 14:17:13 localhost kernel: PCI: Ignoring E820 reservations for host bridge windows
jan 13 14:17:13 localhost kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.RP01.RTD3: New power resource
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.RP09.RTD3: New power resource
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.TBT0: New power resource
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.TBT1: New power resource
jan 13 14:17:13 localhost kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
jan 13 14:17:13 localhost kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
jan 13 14:17:13 localhost kernel: acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
jan 13 14:17:13 localhost kernel: PCI host bridge to bus 0000:00
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x80400000-0xdfffffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x87fc00000-0x7fffffffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
jan 13 14:17:13 localhost kernel: pci 0000:00:00.0: [8086:4621] type 00 class 0x060000
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: reg 0x10: [mem 0x81000000-0x81ffffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: reg 0x20: [io  0x1000-0x103f]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: BAR 2: assigned to efifb
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
jan 13 14:17:13 localhost kernel: pci 0000:00:08.0: [8086:464f] type 00 class 0x088000
jan 13 14:17:13 localhost kernel: pci 0000:00:08.0: reg 0x10: [mem 0x80720000-0x80720fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000
jan 13 14:17:13 localhost kernel: pci 0000:00:0a.0: reg 0x10: [mem 0x80710000-0x80717fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:0a.0: enabling Extended Tags
jan 13 14:17:13 localhost kernel: pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330
jan 13 14:17:13 localhost kernel: pci 0000:00:14.0: reg 0x10: [mem 0x80700000-0x8070ffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
jan 13 14:17:13 localhost kernel: pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000
jan 13 14:17:13 localhost kernel: pci 0000:00:14.2: reg 0x10: [mem 0x80718000-0x8071bfff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:14.2: reg 0x18: [mem 0x80721000-0x80721fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000
jan 13 14:17:13 localhost kernel: pci 0000:00:15.0: reg 0x10: [mem 0x80722000-0x80722fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0: [8086:51bc] type 01 class 0x060400
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
jan 13 14:17:13 localhost kernel: pci 0000:00:1e.0: [8086:51a8] type 00 class 0x078000
jan 13 14:17:13 localhost kernel: pci 0000:00:1e.0: reg 0x10: [mem 0xfe03e000-0xfe03efff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1e.0: reg 0x18: [mem 0x80724000-0x80724fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040300
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.3: reg 0x10: [mem 0x8071c000-0x8071ffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.3: reg 0x20: [mem 0x80600000-0x806fffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.3: PME# supported from D3hot D3cold
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.4: reg 0x10: [mem 0x80726000-0x807260ff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000
jan 13 14:17:13 localhost kernel: pci 0000:00:1f.5: reg 0x10: [mem 0x80725000-0x80725fff]
jan 13 14:17:13 localhost kernel: pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
jan 13 14:17:13 localhost kernel: pci 0000:01:00.0: reg 0x10: [mem 0x80400000-0x80403fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 13 14:17:13 localhost kernel: pci 0000:02:00.0: [144d:a80c] type 00 class 0x010802
jan 13 14:17:13 localhost kernel: pci 0000:02:00.0: reg 0x10: [mem 0x80500000-0x80503fff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1d.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 13 14:17:13 localhost kernel: ACPI: EC: interrupt unblocked
jan 13 14:17:13 localhost kernel: ACPI: EC: event unblocked
jan 13 14:17:13 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 13 14:17:13 localhost kernel: ACPI: EC: GPE=0x6e
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC initialization complete
jan 13 14:17:13 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
jan 13 14:17:13 localhost kernel: iommu: Default domain type: Translated
jan 13 14:17:13 localhost kernel: iommu: DMA domain TLB invalidation policy: lazy mode
jan 13 14:17:13 localhost kernel: efivars: Registered efivars operations
jan 13 14:17:13 localhost kernel: NetLabel: Initializing
jan 13 14:17:13 localhost kernel: NetLabel:  domain hash size = 128
jan 13 14:17:13 localhost kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
jan 13 14:17:13 localhost kernel: NetLabel:  unlabeled traffic allowed by default
jan 13 14:17:13 localhost kernel: PCI: Using ACPI for IRQ routing
jan 13 14:17:13 localhost kernel: PCI: pci_cache_line_size set to 64 bytes
jan 13 14:17:13 localhost kernel: e820: reserve RAM buffer [mem 0x736ce000-0x73ffffff]
jan 13 14:17:13 localhost kernel: e820: reserve RAM buffer [mem 0x76734000-0x77ffffff]
jan 13 14:17:13 localhost kernel: e820: reserve RAM buffer [mem 0x76941000-0x77ffffff]
jan 13 14:17:13 localhost kernel: e820: reserve RAM buffer [mem 0x7695a000-0x77ffffff]
jan 13 14:17:13 localhost kernel: e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: vgaarb: bridge control possible
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
jan 13 14:17:13 localhost kernel: vgaarb: loaded
jan 13 14:17:13 localhost kernel: clocksource: Switched to clocksource tsc-early
jan 13 14:17:13 localhost kernel: VFS: Disk quotas dquot_6.6.0
jan 13 14:17:13 localhost kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
jan 13 14:17:13 localhost kernel: pnp: PnP ACPI init
jan 13 14:17:13 localhost kernel: pnp 00:00: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfedc0000-0xfeddffff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfeda0000-0xfeda0fff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfeda1000-0xfeda1fff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfe000000-0xffffffff] could not be reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xf8000000-0xf9ffffff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
jan 13 14:17:13 localhost kernel: system 00:03: [io  0x1800-0x18fe] has been reserved
jan 13 14:17:13 localhost kernel: pnp: PnP ACPI: found 7 devices
jan 13 14:17:13 localhost kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
jan 13 14:17:13 localhost kernel: NET: Registered PF_INET protocol family
jan 13 14:17:13 localhost kernel: IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 13 14:17:13 localhost kernel: tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
jan 13 14:17:13 localhost kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
jan 13 14:17:13 localhost kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 13 14:17:13 localhost kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
jan 13 14:17:13 localhost kernel: TCP: Hash tables configured (established 262144 bind 65536)
jan 13 14:17:13 localhost kernel: MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
jan 13 14:17:13 localhost kernel: UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 13 14:17:13 localhost kernel: UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 13 14:17:13 localhost kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
jan 13 14:17:13 localhost kernel: NET: Registered PF_XDP protocol family
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: BAR 9: assigned [mem 0x880000000-0x95fffffff 64bit pref]
jan 13 14:17:13 localhost kernel: pci 0000:00:02.0: BAR 7: assigned [mem 0x960000000-0x966ffffff 64bit]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: BAR 15: assigned [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x2fff]
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 13 14:17:13 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0:   bridge window [io  0x2000-0x2fff]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 13 14:17:13 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 7 [mem 0x80400000-0xdfffffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 8 [mem 0x87fc00000-0x7fffffffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed47fff window]
jan 13 14:17:13 localhost kernel: pci_bus 0000:01: resource 1 [mem 0x80400000-0x804fffff]
jan 13 14:17:13 localhost kernel: pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
jan 13 14:17:13 localhost kernel: pci_bus 0000:02: resource 1 [mem 0x80500000-0x805fffff]
jan 13 14:17:13 localhost kernel: pci_bus 0000:02: resource 2 [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 13 14:17:13 localhost kernel: PCI: CLS 64 bytes, default 64
jan 13 14:17:13 localhost kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
jan 13 14:17:13 localhost kernel: software IO TLB: mapped [mem 0x000000006acf9000-0x000000006ecf9000] (64MB)
jan 13 14:17:13 localhost kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 13 14:17:13 localhost kernel: Trying to unpack rootfs image as initramfs...
jan 13 14:17:13 localhost kernel: clocksource: Switched to clocksource tsc
jan 13 14:17:13 localhost kernel: Initialise system trusted keyrings
jan 13 14:17:13 localhost kernel: workingset: timestamp_bits=40 max_order=23 bucket_order=0
jan 13 14:17:13 localhost kernel: zbud: loaded
jan 13 14:17:13 localhost kernel: Key type asymmetric registered
jan 13 14:17:13 localhost kernel: Asymmetric key parser 'x509' registered
jan 13 14:17:13 localhost kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
jan 13 14:17:13 localhost kernel: io scheduler mq-deadline registered
jan 13 14:17:13 localhost kernel: io scheduler kyber registered
jan 13 14:17:13 localhost kernel: pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
jan 13 14:17:13 localhost kernel: pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
jan 13 14:17:13 localhost kernel: pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
jan 13 14:17:13 localhost kernel: efifb: probing for efifb
jan 13 14:17:13 localhost kernel: efifb: showing boot graphics
jan 13 14:17:13 localhost kernel: efifb: framebuffer at 0x90000000, using 8100k, total 8100k
jan 13 14:17:13 localhost kernel: efifb: mode is 1920x1080x32, linelength=7680, pages=1
jan 13 14:17:13 localhost kernel: efifb: scrolling: redraw
jan 13 14:17:13 localhost kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
jan 13 14:17:13 localhost kernel: fbcon: Deferring console take-over
jan 13 14:17:13 localhost kernel: fb0: EFI VGA frame buffer device
jan 13 14:17:13 localhost kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
jan 13 14:17:13 localhost kernel: hpet_acpi_add: no address or irqs in _CRS
jan 13 14:17:13 localhost kernel: intel_pstate: Intel P-state driver initializing
jan 13 14:17:13 localhost kernel: intel_pstate: HWP enabled
jan 13 14:17:13 localhost kernel: drop_monitor: Initializing network drop monitor service
jan 13 14:17:13 localhost kernel: NET: Registered PF_INET6 protocol family
jan 13 14:17:13 localhost kernel: Freeing initrd memory: 27480K
jan 13 14:17:13 localhost kernel: Segment Routing with IPv6
jan 13 14:17:13 localhost kernel: In-situ OAM (IOAM) with IPv6
jan 13 14:17:13 localhost kernel: microcode: Current revision: 0x00000430
jan 13 14:17:13 localhost kernel: microcode: Updated early from: 0x00000430
jan 13 14:17:13 localhost kernel: IPI shorthand broadcast: enabled
jan 13 14:17:13 localhost kernel: sched_clock: Marking stable (408000746, 16213742)->(451578554, -27364066)
jan 13 14:17:13 localhost kernel: registered taskstats version 1
jan 13 14:17:13 localhost kernel: Loading compiled-in X.509 certificates
jan 13 14:17:13 localhost kernel: Key type .fscrypt registered
jan 13 14:17:13 localhost kernel: Key type fscrypt-provisioning registered
jan 13 14:17:13 localhost kernel: clk: Disabling unused clocks
jan 13 14:17:13 localhost kernel: Freeing unused decrypted memory: 2028K
jan 13 14:17:13 localhost kernel: Freeing unused kernel image (initmem) memory: 2988K
jan 13 14:17:13 localhost kernel: Write protecting the kernel read-only data: 24576k
jan 13 14:17:13 localhost kernel: Freeing unused kernel image (rodata/data gap) memory: 836K
jan 13 14:17:13 localhost kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
jan 13 14:17:13 localhost kernel: Run /init as init process
jan 13 14:17:13 localhost kernel:   with arguments:
jan 13 14:17:13 localhost kernel:     /init
jan 13 14:17:13 localhost kernel:   with environment:
jan 13 14:17:13 localhost kernel:     HOME=/
jan 13 14:17:13 localhost kernel:     TERM=linux
jan 13 14:17:13 localhost systemd[1]: Inserted module 'autofs4'
jan 13 14:17:13 localhost systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 13 14:17:13 localhost systemd[1]: Detected architecture x86-64.
jan 13 14:17:13 localhost systemd[1]: Running in initrd.
jan 13 14:17:13 localhost kernel: fbcon: Taking over console
jan 13 14:17:13 localhost systemd[1]: No hostname configured, using default hostname.
jan 13 14:17:13 localhost systemd[1]: Hostname set to <localhost>.
jan 13 14:17:13 localhost systemd[1]: Initializing machine ID from random generator.
jan 13 14:17:13 localhost kernel: Console: switching to colour frame buffer device 240x67
jan 13 14:17:13 localhost systemd[1]: Queued start job for default target Initrd Default Target.
jan 13 14:17:13 localhost systemd[1]: Created slice Slice /system/systemd-cryptsetup.
jan 13 14:17:13 localhost systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 13 14:17:13 localhost systemd[1]: Reached target Initrd Root Device.
jan 13 14:17:13 localhost systemd[1]: Reached target Path Units.
jan 13 14:17:13 localhost systemd[1]: Reached target Slice Units.
jan 13 14:17:13 localhost systemd[1]: Reached target Swaps.
jan 13 14:17:13 localhost systemd[1]: Reached target Timer Units.
jan 13 14:17:13 localhost systemd[1]: Listening on Journal Socket (/dev/log).
jan 13 14:17:13 localhost systemd[1]: Listening on Journal Socket.
jan 13 14:17:13 localhost systemd[1]: Listening on udev Control Socket.
jan 13 14:17:13 localhost systemd[1]: Listening on udev Kernel Socket.
jan 13 14:17:13 localhost systemd[1]: Reached target Socket Units.
jan 13 14:17:13 localhost systemd[1]: Starting Create List of Static Device Nodes...
jan 13 14:17:13 localhost systemd[1]: Starting Journal Service...
jan 13 14:17:13 localhost systemd[1]: Starting Load Kernel Modules...
jan 13 14:17:13 localhost systemd[1]: Starting Create Static Device Nodes in /dev...
jan 13 14:17:13 localhost systemd[1]: Starting Coldplug All udev Devices...
jan 13 14:17:13 localhost systemd[1]: Finished Create List of Static Device Nodes.
jan 13 14:17:13 localhost systemd[1]: Finished Create Static Device Nodes in /dev.
jan 13 14:17:13 localhost systemd[1]: Reached target Preparation for Local File Systems.
jan 13 14:17:13 localhost systemd[1]: Reached target Local File Systems.
jan 13 14:17:13 localhost systemd[1]: Mounting /sysroot...
jan 13 14:17:13 localhost systemd[1]: Starting Rule-based Manager for Device Events and Files...
jan 13 14:17:13 localhost systemd-journald[164]: Collecting audit messages is disabled.
jan 13 14:17:13 localhost systemd[1]: Mounted /sysroot.
jan 13 14:17:13 localhost systemd[1]: Reached target Initrd Root File System.
jan 13 14:17:13 localhost systemd[1]: Starting Mountpoints Configured in the Real Root...
jan 13 14:17:13 localhost systemd[1]: Reloading requested from client PID 176 ('systemd-fstab-g') (unit initrd-parse-etc.service)...
jan 13 14:17:13 localhost systemd[1]: Reloading...
jan 13 14:17:13 localhost kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
jan 13 14:17:13 localhost kernel: raid6: avx2x4   gen() 31939 MB/s
jan 13 14:17:13 localhost kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
jan 13 14:17:13 localhost kernel: rtc_cmos 00:04: RTC can wake from S4
jan 13 14:17:13 localhost kernel: raid6: avx2x2   gen() 32020 MB/s
jan 13 14:17:13 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
jan 13 14:17:13 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
jan 13 14:17:13 localhost kernel: cryptd: max_cpu_qlen set to 1000
jan 13 14:17:13 localhost kernel: rtc_cmos 00:04: registered as rtc0
jan 13 14:17:13 localhost kernel: rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
jan 13 14:17:13 localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
jan 13 14:17:13 localhost kernel: ACPI: bus type USB registered
jan 13 14:17:13 localhost kernel: usbcore: registered new interface driver usbfs
jan 13 14:17:13 localhost kernel: usbcore: registered new interface driver hub
jan 13 14:17:13 localhost kernel: usbcore: registered new device driver usb
jan 13 14:17:13 localhost kernel: AVX2 version of gcm_enc/dec engaged.
jan 13 14:17:13 localhost kernel: AES CTR mode by8 optimization enabled
jan 13 14:17:13 localhost kernel: raid6: avx2x1   gen() 25987 MB/s
jan 13 14:17:13 localhost kernel: raid6: using algorithm avx2x2 gen() 32020 MB/s
jan 13 14:17:13 localhost kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
jan 13 14:17:13 localhost kernel: xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
jan 13 14:17:13 localhost kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.07
jan 13 14:17:13 localhost kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 13 14:17:13 localhost kernel: usb usb1: Product: xHCI Host Controller
jan 13 14:17:13 localhost kernel: usb usb1: Manufacturer: Linux 6.7.0 xhci-hcd
jan 13 14:17:13 localhost kernel: usb usb1: SerialNumber: 0000:00:14.0
jan 13 14:17:13 localhost kernel: hub 1-0:1.0: USB hub found
jan 13 14:17:13 localhost kernel: hub 1-0:1.0: 12 ports detected
jan 13 14:17:13 localhost kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.07
jan 13 14:17:13 localhost kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 13 14:17:13 localhost kernel: usb usb2: Product: xHCI Host Controller
jan 13 14:17:13 localhost kernel: usb usb2: Manufacturer: Linux 6.7.0 xhci-hcd
jan 13 14:17:13 localhost kernel: usb usb2: SerialNumber: 0000:00:14.0
jan 13 14:17:13 localhost kernel: hub 2-0:1.0: USB hub found
jan 13 14:17:13 localhost kernel: hub 2-0:1.0: 4 ports detected
jan 13 14:17:13 localhost kernel: raid6: .... xor() 21106 MB/s, rmw enabled
jan 13 14:17:13 localhost kernel: raid6: using avx2x2 recovery algorithm
jan 13 14:17:13 localhost kernel: nvme nvme0: pci function 0000:02:00.0
jan 13 14:17:13 localhost kernel: xor: automatically using best checksumming function   avx       
jan 13 14:17:13 localhost systemd[1]: Reloading finished in 90 ms.
jan 13 14:17:13 localhost kernel: nvme nvme0: Shutdown timeout set to 10 seconds
jan 13 14:17:13 localhost kernel: nvme nvme0: 16/0/0 default/read/poll queues
jan 13 14:17:13 localhost kernel:  nvme0n1: p1 p2
jan 13 14:17:13 localhost systemd[1]: Started Journal Service.
jan 13 14:17:13 localhost kernel: Btrfs loaded, zoned=no, fsverity=no
jan 13 14:17:13 localhost kernel: usb 1-1: new full-speed USB device number 2 using xhci_hcd
jan 13 14:17:13 localhost kernel: usb 1-1: New USB device found, idVendor=413c, idProduct=b07c, bcdDevice= 0.00
jan 13 14:17:13 localhost kernel: usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 13 14:17:13 localhost kernel: usb 1-1: Product: Dell USB-C to HDMI/DP
jan 13 14:17:13 localhost kernel: usb 1-1: Manufacturer: Dell
jan 13 14:17:13 localhost kernel: usb 1-1: SerialNumber: 11AD1D0A92AE3E1209240B00
jan 13 14:17:13 localhost kernel: usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
jan 13 14:17:14 localhost kernel: usb 2-1: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 13 14:17:14 localhost kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:14 localhost kernel: usb 2-1: Product: USB3.0 Hub
jan 13 14:17:14 localhost kernel: usb 2-1: Manufacturer: VIA Labs, Inc.
jan 13 14:17:14 localhost kernel: hub 2-1:1.0: USB hub found
jan 13 14:17:14 localhost kernel: hub 2-1:1.0: 4 ports detected
jan 13 14:17:14 localhost kernel: usb 1-3: new high-speed USB device number 3 using xhci_hcd
jan 13 14:17:14 localhost kernel: usb 1-3: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 13 14:17:14 localhost kernel: usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:14 localhost kernel: usb 1-3: Product: USB2.0 Hub
jan 13 14:17:14 localhost kernel: usb 1-3: Manufacturer: VIA Labs, Inc.
jan 13 14:17:14 localhost kernel: hub 1-3:1.0: USB hub found
jan 13 14:17:14 localhost kernel: hub 1-3:1.0: 4 ports detected
jan 13 14:17:14 localhost kernel: usb 1-4: new high-speed USB device number 4 using xhci_hcd
jan 13 14:17:14 localhost kernel: usb 1-4: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=60.90
jan 13 14:17:14 localhost kernel: usb 1-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 13 14:17:14 localhost kernel: usb 1-4: Product: USB2.0 Hub
jan 13 14:17:14 localhost kernel: hub 1-4:1.0: USB hub found
jan 13 14:17:14 localhost kernel: hub 1-4:1.0: 4 ports detected
jan 13 14:17:14 localhost kernel: usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
jan 13 14:17:14 localhost kernel: usb 2-1.1: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 13 14:17:14 localhost kernel: usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 13 14:17:14 localhost kernel: usb 2-1.1: Product: Dell D3100 USB3.0 Dock
jan 13 14:17:14 localhost kernel: usb 2-1.1: Manufacturer: DisplayLink
jan 13 14:17:14 localhost kernel: usb 2-1.1: SerialNumber: 2209282137B
jan 13 14:17:14 localhost kernel: usb 1-3.2: new high-speed USB device number 5 using xhci_hcd
jan 13 14:17:14 localhost kernel: usb 1-3.2: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 13 14:17:14 localhost kernel: usb 1-3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:14 localhost kernel: usb 1-3.2: Product: USB2.0 Hub
jan 13 14:17:14 localhost kernel: usb 1-3.2: Manufacturer: VIA Labs, Inc.
jan 13 14:17:14 localhost kernel: hub 1-3.2:1.0: USB hub found
jan 13 14:17:14 localhost kernel: hub 1-3.2:1.0: 4 ports detected
jan 13 14:17:14 localhost kernel: usb 1-5: new high-speed USB device number 6 using xhci_hcd
jan 13 14:17:15 localhost kernel: usb 1-5: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
jan 13 14:17:15 localhost kernel: usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=3
jan 13 14:17:15 localhost kernel: usb 1-5: Product: USB 2.0 Camera
jan 13 14:17:15 localhost kernel: usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
jan 13 14:17:15 localhost kernel: usb 1-5: SerialNumber: SN0001
jan 13 14:17:15 localhost kernel: usb 2-1.2: new SuperSpeed USB device number 4 using xhci_hcd
jan 13 14:17:15 localhost kernel: usb 2-1.2: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 13 14:17:15 localhost kernel: usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:15 localhost kernel: usb 2-1.2: Product: USB3.0 Hub
jan 13 14:17:15 localhost kernel: usb 2-1.2: Manufacturer: VIA Labs, Inc.
jan 13 14:17:15 localhost kernel: hub 2-1.2:1.0: USB hub found
jan 13 14:17:15 localhost kernel: hub 2-1.2:1.0: 4 ports detected
jan 13 14:17:15 localhost kernel: usb 1-4.1: new high-speed USB device number 7 using xhci_hcd
jan 13 14:17:15 localhost kernel: usb 1-4.1: New USB device found, idVendor=05e3, idProduct=0761, bcdDevice=24.02
jan 13 14:17:15 localhost kernel: usb 1-4.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 13 14:17:15 localhost kernel: usb 1-4.1: Product: USB Storage
jan 13 14:17:15 localhost kernel: usb 1-4.1: SerialNumber: 000000002402
jan 13 14:17:15 localhost kernel: SCSI subsystem initialized
jan 13 14:17:15 localhost kernel: usb-storage 1-4.1:1.0: USB Mass Storage device detected
jan 13 14:17:15 localhost kernel: scsi host0: usb-storage 1-4.1:1.0
jan 13 14:17:15 localhost kernel: usbcore: registered new interface driver usb-storage
jan 13 14:17:15 localhost kernel: usb 1-3.4: new full-speed USB device number 8 using xhci_hcd
jan 13 14:17:15 localhost kernel: usb 1-3.4: New USB device found, idVendor=3434, idProduct=0320, bcdDevice= 1.02
jan 13 14:17:15 localhost kernel: usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:15 localhost kernel: usb 1-3.4: Product: Keychron V2
jan 13 14:17:15 localhost kernel: usb 1-3.4: Manufacturer: Keychron
jan 13 14:17:15 localhost kernel: hid: raw HID events driver (C) Jiri Kosina
jan 13 14:17:15 localhost kernel: usbcore: registered new interface driver usbhid
jan 13 14:17:15 localhost kernel: usbhid: USB HID core driver
jan 13 14:17:15 localhost kernel: input: Keychron Keychron V2 as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/0003:3434:0320.0001/input/input2
jan 13 14:17:15 localhost kernel: usb 1-3.2.2: new high-speed USB device number 9 using xhci_hcd
jan 13 14:17:15 localhost kernel: hid-generic 0003:3434:0320.0001: input,hidraw0: USB HID v1.11 Keyboard [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input0
jan 13 14:17:15 localhost kernel: hid-generic 0003:3434:0320.0002: hiddev96,hidraw1: USB HID v1.11 Device [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input1
jan 13 14:17:15 localhost kernel: input: Keychron Keychron V2 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input3
jan 13 14:17:15 localhost kernel: input: Keychron Keychron V2 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input4
jan 13 14:17:15 localhost kernel: input: Keychron Keychron V2 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input5
jan 13 14:17:15 localhost kernel: input: Keychron Keychron V2 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input6
jan 13 14:17:15 localhost kernel: hid-generic 0003:3434:0320.0003: input,hidraw2: USB HID v1.11 Mouse [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input2
jan 13 14:17:15 localhost kernel: usb 1-3.2.2: New USB device found, idVendor=0bda, idProduct=5409, bcdDevice= 1.36
jan 13 14:17:15 localhost kernel: usb 1-3.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:15 localhost kernel: usb 1-3.2.2: Product: 3-Port USB 2.1 Hub
jan 13 14:17:15 localhost kernel: usb 1-3.2.2: Manufacturer: Generic
jan 13 14:17:15 localhost kernel: hub 1-3.2.2:1.0: USB hub found
jan 13 14:17:15 localhost kernel: hub 1-3.2.2:1.0: 3 ports detected
jan 13 14:17:15 localhost kernel: usb 1-6: new full-speed USB device number 10 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 1-6: New USB device found, idVendor=27c6, idProduct=6584, bcdDevice= 1.00
jan 13 14:17:16 localhost kernel: usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 13 14:17:16 localhost kernel: usb 1-6: Product: Goodix USB2.0 MISC
jan 13 14:17:16 localhost kernel: usb 1-6: Manufacturer: Goodix Technology Co., Ltd.
jan 13 14:17:16 localhost kernel: usb 1-6: SerialNumber: UIDDC8A8C35_XXXX_MOC_B0
jan 13 14:17:16 localhost kernel: usb 2-1.3: new SuperSpeed USB device number 5 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 2-1.3: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 13 14:17:16 localhost kernel: usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 13 14:17:16 localhost kernel: usb 2-1.3: Product: Dell D3100 USB3.0 Dock
jan 13 14:17:16 localhost kernel: usb 2-1.3: Manufacturer: DisplayLink
jan 13 14:17:16 localhost kernel: usb 2-1.3: SerialNumber: 2209282137
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: new SuperSpeed USB device number 6 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: New USB device found, idVendor=1058, idProduct=10a2, bcdDevice=10.33
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: Product: Elements 10A2
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: Manufacturer: Western Digital
jan 13 14:17:16 localhost kernel: usb 2-1.2.1: SerialNumber: 57585131453832484C525938
jan 13 14:17:16 localhost kernel: usb-storage 2-1.2.1:1.0: USB Mass Storage device detected
jan 13 14:17:16 localhost kernel: scsi host1: usb-storage 2-1.2.1:1.0
jan 13 14:17:16 localhost kernel: usb 1-3.2.4: new low-speed USB device number 11 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 1-3.2.4: New USB device found, idVendor=047d, idProduct=2048, bcdDevice= 1.20
jan 13 14:17:16 localhost kernel: usb 1-3.2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 13 14:17:16 localhost kernel: usb 1-3.2.4: Product: Kensington Eagle Trackball
jan 13 14:17:16 localhost kernel: input: Kensington Eagle Trackball as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.2/1-3.2.4/1-3.2.4:1.0/0003:047D:2048.0004/input/input7
jan 13 14:17:16 localhost kernel: hid-generic 0003:047D:2048.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Eagle Trackball] on usb-0000:00:14.0-3.2.4/input0
jan 13 14:17:16 localhost kernel: scsi 0:0:0:0: Direct-Access     Generic  MassStorageClass 2402 PQ: 0 ANSI: 6
jan 13 14:17:16 localhost kernel: sd 0:0:0:0: [sda] Media removed, stopped polling
jan 13 14:17:16 localhost kernel: sd 0:0:0:0: [sda] Attached SCSI removable disk
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.1: new high-speed USB device number 12 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 2-1.2.2: new SuperSpeed USB device number 7 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.1: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.21
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.1: Product: C270 HD WEBCAM
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.1: SerialNumber: 200901010001
jan 13 14:17:16 localhost kernel: usb 2-1.2.2: New USB device found, idVendor=0bda, idProduct=0409, bcdDevice= 1.36
jan 13 14:17:16 localhost kernel: usb 2-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:16 localhost kernel: usb 2-1.2.2: Product: 2-Port USB 3.1 Hub
jan 13 14:17:16 localhost kernel: usb 2-1.2.2: Manufacturer: Generic
jan 13 14:17:16 localhost kernel: hub 2-1.2.2:1.0: USB hub found
jan 13 14:17:16 localhost kernel: hub 2-1.2.2:1.0: 2 ports detected
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.3: new high-speed USB device number 13 using xhci_hcd
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.3: New USB device found, idVendor=0bda, idProduct=1100, bcdDevice= 1.01
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.3: Product: Hub Controller
jan 13 14:17:16 localhost kernel: usb 1-3.2.2.3: Manufacturer: Realtek
jan 13 14:17:16 localhost kernel: hid-generic 0003:0BDA:1100.0005: hiddev97,hidraw4: USB HID v1.11 Device [Realtek Hub Controller] on usb-0000:00:14.0-3.2.2.3/input0
jan 13 14:17:17 localhost kernel: scsi 1:0:0:0: Direct-Access     WD       Elements 10A2    1033 PQ: 0 ANSI: 6
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] 1953458176 512-byte logical blocks: (1.00 TB/931 GiB)
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] Write Protect is off
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] Mode Sense: 53 00 10 08
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] No Caching mode page found
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] Assuming drive cache: write through
jan 13 14:17:17 localhost kernel:  sdb: sdb2
jan 13 14:17:17 localhost kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
jan 13 14:17:20 localhost kernel: Key type trusted registered
jan 13 14:17:20 localhost kernel: Key type encrypted registered
jan 13 14:17:20 localhost kernel: BTRFS: device label nixos devid 1 transid 367087 /dev/mapper/volgroup-nixos scanned by mount (351)
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): first mount of filesystem f02feaa7-3d81-4624-8650-0839b5d11da4
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algorithm
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): use zstd compression, level 1
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): enabling auto defrag
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): using free space tree
jan 13 14:17:20 localhost kernel: BTRFS info (device dm-2): enabling ssd optimizations
jan 13 14:17:21 starbook systemd-journald[164]: Received SIGTERM from PID 1 (systemd).
jan 13 14:17:21 starbook systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 13 14:17:21 starbook systemd[1]: Detected architecture x86-64.
jan 13 14:17:21 starbook systemd[1]: Hostname set to <starbook>.
jan 13 14:17:21 starbook systemd[1]: bpf-lsm: LSM BPF program attached
jan 13 14:17:21 starbook kernel: zram: Added device: zram0
jan 13 14:17:21 starbook systemd[1]: initrd-switch-root.service: Deactivated successfully.
jan 13 14:17:21 starbook systemd[1]: Stopped initrd-switch-root.service.
jan 13 14:17:21 starbook systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
jan 13 14:17:21 starbook systemd[1]: Created slice Virtual Machine and Container Slice.
jan 13 14:17:21 starbook systemd[1]: Created slice Slice /system/getty.
jan 13 14:17:21 starbook systemd[1]: Created slice Slice /system/modprobe.
jan 13 14:17:21 starbook systemd[1]: Created slice Slice /system/systemd-zram-setup.
jan 13 14:17:21 starbook systemd[1]: Created slice User and Session Slice.
jan 13 14:17:21 starbook systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 13 14:17:21 starbook systemd[1]: Started Forward Password Requests to Wall Directory Watch.
jan 13 14:17:21 starbook systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
jan 13 14:17:21 starbook systemd[1]: Reached target Local Encrypted Volumes.
jan 13 14:17:21 starbook systemd[1]: Stopped target initrd-fs.target.
jan 13 14:17:21 starbook systemd[1]: Stopped target initrd-root-fs.target.
jan 13 14:17:21 starbook systemd[1]: Stopped target initrd-switch-root.target.
jan 13 14:17:21 starbook systemd[1]: Reached target Containers.
jan 13 14:17:21 starbook systemd[1]: Reached target Path Units.
jan 13 14:17:21 starbook systemd[1]: Reached target Remote File Systems.
jan 13 14:17:21 starbook systemd[1]: Reached target Slice Units.
jan 13 14:17:21 starbook systemd[1]: Listening on Process Core Dump Socket.
jan 13 14:17:21 starbook systemd[1]: Listening on Network Service Netlink Socket.
jan 13 14:17:21 starbook systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Killer Socket.
jan 13 14:17:21 starbook systemd[1]: Listening on udev Control Socket.
jan 13 14:17:21 starbook systemd[1]: Listening on udev Kernel Socket.
jan 13 14:17:21 starbook systemd[1]: Activating swap /dev/volgroup/swap...
jan 13 14:17:21 starbook systemd[1]: Mounting Huge Pages File System...
jan 13 14:17:21 starbook systemd[1]: Mounting POSIX Message Queue File System...
jan 13 14:17:21 starbook systemd[1]: Mounting Kernel Debug File System...
jan 13 14:17:21 starbook systemd[1]: Starting Create List of Static Device Nodes...
jan 13 14:17:21 starbook systemd[1]: Starting Load Kernel Module configfs...
jan 13 14:17:21 starbook kernel: Adding 15728636k swap on /dev/mapper/volgroup-swap.  Priority:-2 extents:1 across:15728636k SS
jan 13 14:17:21 starbook systemd[1]: Starting Load Kernel Module drm...
jan 13 14:17:21 starbook systemd[1]: Starting Load Kernel Module efi_pstore...
jan 13 14:17:21 starbook systemd[1]: Starting Load Kernel Module fuse...
jan 13 14:17:21 starbook systemd[1]: Starting mount-pstore.service...
jan 13 14:17:21 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/gh/hosts.yml' to '/home/ramses/.config/gh/hosts.yml'...
jan 13 14:17:21 starbook kernel: pstore: Using crash dump compression: deflate
jan 13 14:17:21 starbook kernel: pstore: Registered efi_pstore as persistent store backend
jan 13 14:17:21 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/htop/htoprc' to '/home/ramses/.config/htop/htoprc'...
jan 13 14:17:21 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/monitors.xml' to '/home/ramses/.config/monitors.xml'...
jan 13 14:17:21 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.bash_history' to '/home/ramses/.bash_history'...
jan 13 14:17:21 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.python_history' to '/home/ramses/.python_history'...
jan 13 14:17:21 starbook systemd[1]: Starting Create SUID/SGID Wrappers...
jan 13 14:17:21 starbook systemd[1]: systemd-cryptsetup@decrypted.service: Deactivated successfully.
jan 13 14:17:21 starbook systemd[1]: Stopped systemd-cryptsetup@decrypted.service.
jan 13 14:17:21 starbook kernel: fuse: init (API version 7.39)
jan 13 14:17:21 starbook systemd[1]: Starting Journal Service...
jan 13 14:17:21 starbook systemd[1]: Starting Load Kernel Modules...
jan 13 14:17:21 starbook systemd[1]: Starting Remount Root and Kernel File Systems...
jan 13 14:17:21 starbook systemd[1]: Starting Coldplug All udev Devices...
jan 13 14:17:21 starbook systemd[1]: Activated swap /dev/volgroup/swap.
jan 13 14:17:21 starbook systemd-journald[822]: Collecting audit messages is disabled.
jan 13 14:17:21 starbook systemd[1]: Mounted Huge Pages File System.
jan 13 14:17:21 starbook systemd[1]: Mounted POSIX Message Queue File System.
jan 13 14:17:21 starbook systemd[1]: Mounted Kernel Debug File System.
jan 13 14:17:21 starbook kernel: ACPI: bus type drm_connector registered
jan 13 14:17:21 starbook kernel: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
jan 13 14:17:21 starbook kernel: tun: Universal TUN/TAP device driver, 1.6
jan 13 14:17:21 starbook systemd[1]: Finished Create List of Static Device Nodes.
jan 13 14:17:21 starbook systemd[1]: Started Journal Service.
jan 13 14:17:21 starbook kernel: loop: module loaded
jan 13 14:17:22 starbook systemd-journald[822]: Received client request to flush runtime journal.
jan 13 14:17:22 starbook systemd-journald[822]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/system.journal: Journal file uses a different sequence number ID, rotating.
jan 13 14:17:22 starbook systemd-journald[822]: Rotating system journal.
jan 13 14:17:22 starbook kernel: intel_pmc_core INT33A1:00:  initialized
jan 13 14:17:22 starbook kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/PNP0C09:00/PNP0C0D:00/input/input8
jan 13 14:17:22 starbook kernel: EDAC MC: Ver: 3.0.0
jan 13 14:17:22 starbook kernel: input: Intel HID events as /devices/platform/INTC1051:00/input/input9
jan 13 14:17:22 starbook kernel: ACPI: button: Lid Switch [LID0]
jan 13 14:17:22 starbook kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
jan 13 14:17:22 starbook kernel: ACPI: button: Power Button [PWRF]
jan 13 14:17:22 starbook kernel: EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
jan 13 14:17:22 starbook kernel: EDAC MC1: Giving out device to module igen6_edac controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
jan 13 14:17:22 starbook kernel: EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
jan 13 14:17:22 starbook kernel: EDAC igen6 MC1: ADDR 0x7fffffffe0 
jan 13 14:17:22 starbook kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 13 14:17:22 starbook kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0 
jan 13 14:17:22 starbook kernel: EDAC igen6: v2.5.1
jan 13 14:17:22 starbook kernel: zram0: detected capacity change from 0 to 52348520
jan 13 14:17:22 starbook kernel: mousedev: PS/2 mouse device common for all mice
jan 13 14:17:22 starbook kernel: mc: Linux media interface: v0.10
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver uas
jan 13 14:17:22 starbook kernel: Linux agpgart interface v0.103
jan 13 14:17:22 starbook kernel: ACPI: battery: Slot [BAT0] (battery present)
jan 13 14:17:22 starbook kernel: ACPI: AC: AC Adapter [ADP1] (on-line)
jan 13 14:17:22 starbook kernel: i801_smbus 0000:00:1f.4: SPD Write Disable is set
jan 13 14:17:22 starbook kernel: i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
jan 13 14:17:22 starbook kernel: i2c i2c-0: 2/2 memory slots populated (from DMI)
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver cdc_ether
jan 13 14:17:22 starbook kernel: i2c i2c-0: Successfully instantiated SPD at 0x50
jan 13 14:17:22 starbook kernel: ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
jan 13 14:17:22 starbook kernel: RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
jan 13 14:17:22 starbook kernel: RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
jan 13 14:17:22 starbook kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
jan 13 14:17:22 starbook kernel: RAPL PMU: hw unit of domain psys 2^-14 Joules
jan 13 14:17:22 starbook kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
jan 13 14:17:22 starbook kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
jan 13 14:17:22 starbook kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
jan 13 14:17:22 starbook kernel: spi-nor spi0.0: w25q256 (32768 Kbytes)
jan 13 14:17:22 starbook kernel: videodev: Linux video capture interface: v2.00
jan 13 14:17:22 starbook kernel: idma64 idma64.0: Found Intel integrated DMA 64-bit
jan 13 14:17:22 starbook kernel: Creating 1 MTD partitions on "0000:00:1f.5":
jan 13 14:17:22 starbook kernel: 0x000000000000-0x000002000000 : "BIOS"
jan 13 14:17:22 starbook kernel: iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
jan 13 14:17:22 starbook kernel: iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
jan 13 14:17:22 starbook kernel: cdc_ncm 2-1.3:1.5: MAC-Address: 0c:37:96:96:28:5d
jan 13 14:17:22 starbook kernel: cdc_ncm 2-1.3:1.5: setting rx_max = 16384
jan 13 14:17:22 starbook kernel: cdc_ncm 2-1.3:1.5: setting tx_max = 16384
jan 13 14:17:22 starbook kernel: idma64 idma64.1: Found Intel integrated DMA 64-bit
jan 13 14:17:22 starbook kernel: Intel(R) Wireless WiFi driver for Linux
jan 13 14:17:22 starbook kernel: cdc_ncm 2-1.3:1.5 eth0: register 'cdc_ncm' at usb-0000:00:14.0-1.3, CDC NCM (SEND ZLP), 0c:37:96:96:28:5d
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver cdc_ncm
jan 13 14:17:22 starbook kernel: iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
jan 13 14:17:22 starbook kernel: iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
jan 13 14:17:22 starbook kernel: iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
jan 13 14:17:22 starbook kernel: iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
jan 13 14:17:22 starbook kernel: iwlwifi 0000:01:00.0: loaded firmware version 86.fb5c9aeb.0 ty-a0-gf-a0-86.ucode op_mode iwlmvm
jan 13 14:17:22 starbook kernel: Adding 26174256k swap on /dev/zram0.  Priority:5 extents:1 across:26174256k SSDsc
jan 13 14:17:22 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input12
jan 13 14:17:22 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input13
jan 13 14:17:22 starbook kernel: hid-generic 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 13 14:17:22 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
jan 13 14:17:22 starbook kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver cdc_wdm
jan 13 14:17:22 starbook kernel: PTP clock support registered
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver cdc_mbim
jan 13 14:17:22 starbook kernel: cdc_ncm 2-1.3:1.5 enp0s20f0u1u3i5: renamed from eth0
jan 13 14:17:22 starbook kernel: dw-apb-uart.1: ttyS0 at MMIO 0xfe03e000 (irq = 23, base_baud = 114825) is a 16550A
jan 13 14:17:22 starbook kernel: usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:636b)
jan 13 14:17:22 starbook kernel: input: USB 2.0 Camera: USB Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input14
jan 13 14:17:22 starbook kernel: usb 1-3.2.2.1: Found UVC 1.00 device C270 HD WEBCAM (046d:0825)
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver uvcvideo
jan 13 14:17:22 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=511), cval->res is probably wrong.
jan 13 14:17:22 starbook kernel: usb 2-1.3: [15] FU [Dell USB Audio Playback Volume] ch = 6, val = -8176/0/16
jan 13 14:17:22 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=767), cval->res is probably wrong.
jan 13 14:17:22 starbook kernel: usb 2-1.3: [12] FU [Mic Capture Volume] ch = 2, val = -4592/7680/16
jan 13 14:17:22 starbook kernel: usb 1-3.2.2.1: current rate 16000 is different from the runtime rate 32000
jan 13 14:17:22 starbook kernel: usb 1-3.2.2.1: current rate 24000 is different from the runtime rate 16000
jan 13 14:17:22 starbook kernel: usb 1-3.2.2.1: 3:3: cannot set freq 24000 to ep 0x82
jan 13 14:17:22 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input15
jan 13 14:17:22 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input16
jan 13 14:17:22 starbook kernel: hid-multitouch 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 13 14:17:22 starbook kernel: usb 1-3.2.2.1: set resolution quirk: cval->res = 384
jan 13 14:17:22 starbook kernel: usbcore: registered new interface driver snd-usb-audio
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
jan 13 14:17:23 starbook kernel: thermal thermal_zone0: failed to read out thermal zone (-61)
jan 13 14:17:23 starbook kernel: Setting dangerous option enable_fbc - tainting kernel
jan 13 14:17:23 starbook kernel: Setting dangerous option enable_psr - tainting kernel
jan 13 14:17:23 starbook kernel: intel_tcc_cooling: Programmable TCC Offset detected
jan 13 14:17:23 starbook kernel: Console: switching to colour dummy device 80x25
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: vgaarb: deactivate vga console
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] Using Transparent Hugepages
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 13 14:17:23 starbook kernel: intel_rapl_msr: PL4 support detected.
jan 13 14:17:23 starbook kernel: intel_rapl_common: Found RAPL domain package
jan 13 14:17:23 starbook kernel: intel_rapl_common: Found RAPL domain core
jan 13 14:17:23 starbook kernel: intel_rapl_common: Found RAPL domain uncore
jan 13 14:17:23 starbook kernel: intel_rapl_common: Found RAPL domain psys
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adlp_dmc.bin (v2.20)
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.13.1
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: loaded PNVM version e28bb9d7
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: Detected RF GF, rfid=0x10d000
jan 13 14:17:23 starbook kernel: [drm] Initialized i915 1.6.0 20230929 for 0000:00:02.0 on minor 0
jan 13 14:17:23 starbook kernel: i915 display info: display version: 13
jan 13 14:17:23 starbook kernel: i915 display info: cursor_needs_physical: no
jan 13 14:17:23 starbook kernel: i915 display info: has_cdclk_crawl: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_cdclk_squash: no
jan 13 14:17:23 starbook kernel: i915 display info: has_ddi: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_dp_mst: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_dsb: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_fpga_dbg: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_gmch: no
jan 13 14:17:23 starbook kernel: i915 display info: has_hotplug: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_hti: no
jan 13 14:17:23 starbook kernel: i915 display info: has_ipc: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_overlay: no
jan 13 14:17:23 starbook kernel: i915 display info: has_psr: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_psr_hw_tracking: no
jan 13 14:17:23 starbook kernel: i915 display info: overlay_needs_physical: no
jan 13 14:17:23 starbook kernel: i915 display info: supports_tv: no
jan 13 14:17:23 starbook kernel: i915 display info: has_hdcp: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_dmc: yes
jan 13 14:17:23 starbook kernel: i915 display info: has_dsc: yes
jan 13 14:17:23 starbook kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: base HW address: 7c:b5:66:65:be:72
jan 13 14:17:23 starbook kernel: fbcon: i915drmfb (fb0) is primary device
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
jan 13 14:17:23 starbook kernel: Console: switching to colour frame buffer device 240x67
jan 13 14:17:23 starbook kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:    inputs:
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:      Mic=0x18
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:      Mic=0x19
jan 13 14:17:23 starbook kernel: snd_hda_codec_realtek hdaudioC2D0:      Internal Mic=0x12
jan 13 14:17:23 starbook kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card2/input17
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card2/input18
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card2/input19
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card2/input20
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card2/input21
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card2/input22
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card2/input23
jan 13 14:17:23 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card2/input24
jan 13 14:17:23 starbook systemd-journald[822]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/user-1000.journal: Journal file uses a different sequence number ID, rotating.
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 13 14:17:23 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 13 14:17:24 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 13 14:17:24 starbook kernel: NET: Registered PF_PACKET protocol family
jan 13 14:17:26 starbook kernel: usb 1-3.2.2.1: reset high-speed USB device number 12 using xhci_hcd
jan 13 14:17:26 starbook kernel: NET: Registered PF_QIPCRTR protocol family
jan 13 14:17:27 starbook kernel: wlp1s0: authenticate with 30:67:a1:14:f9:c7 (local address=7c:b5:66:65:be:72)
jan 13 14:17:27 starbook kernel: wlp1s0: send auth to 30:67:a1:14:f9:c7 (try 1/3)
jan 13 14:17:28 starbook kernel: wlp1s0: authenticated
jan 13 14:17:28 starbook kernel: wlp1s0: associate with 30:67:a1:14:f9:c7 (try 1/3)
jan 13 14:17:28 starbook kernel: wlp1s0: RX AssocResp from 30:67:a1:14:f9:c7 (capab=0x1011 status=0 aid=10)
jan 13 14:17:28 starbook kernel: wlp1s0: associated
jan 13 14:17:28 starbook kernel: wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 30:67:a1:14:f9:c7
jan 13 14:17:37 starbook kernel: warning: `.gnome-shell-wr' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211

------=_Part_3365_998781800.1705154759365
Content-Type: text/plain; charset=us-ascii; 
	name=dmesg_6_6_10_working_bluetooth.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg_6_6_10_working_bluetooth.txt

jan 09 02:03:50 localhost kernel: Linux version 6.6.10 (nixbld@localhost) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Fri Jan  5 14:19:45 UTC 2024
jan 09 02:03:50 localhost kernel: Command line: initrd=\efi\nixos\9vbz5hrfl3xbxq2zrx9mdpwv0clbzwnd-initrd-linux-6.6.10-initrd.efi init=/nix/store/2j74m1lmj4zaijr6dhnnak3fzlm81j7i-nixos-system-starbook-20240102.bd645e8.20240106.db12804/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 09 02:03:50 localhost kernel: x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
jan 09 02:03:50 localhost kernel: BIOS-provided physical RAM map:
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000000100000-0x0000000076733fff] usable
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000076734000-0x0000000076933fff] reserved
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000076934000-0x0000000076940fff] usable
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000076941000-0x0000000076958fff] ACPI data
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000076959000-0x0000000076959fff] usable
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x000000007695a000-0x00000000803fffff] reserved
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x00000000ff030000-0x00000000ff06ffff] reserved
jan 09 02:03:50 localhost kernel: BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
jan 09 02:03:50 localhost kernel: NX (Execute Disable) protection: active
jan 09 02:03:50 localhost kernel: APIC: Static calls initialized
jan 09 02:03:50 localhost kernel: efi: EFI v2.7 by EDK II
jan 09 02:03:50 localhost kernel: efi: SMBIOS=0x7691b000 SMBIOS 3.0=0x76919000 ACPI=0x76958000 ACPI 2.0=0x76958014 MEMATTR=0x73c7f118 INITRD=0x73685e18 
jan 09 02:03:50 localhost kernel: efi: Remove mem103: MMIO range=[0xff030000-0xff06ffff] (0MB) from e820 map
jan 09 02:03:50 localhost kernel: e820: remove [mem 0xff030000-0xff06ffff] reserved
jan 09 02:03:50 localhost kernel: SMBIOS 3.0.0 present.
jan 09 02:03:50 localhost kernel: DMI: Star Labs StarBook/StarBook, BIOS 9.00 12/07/2023
jan 09 02:03:50 localhost kernel: tsc: Detected 2500.000 MHz processor
jan 09 02:03:50 localhost kernel: tsc: Detected 2496.000 MHz TSC
jan 09 02:03:50 localhost kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
jan 09 02:03:50 localhost kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
jan 09 02:03:50 localhost kernel: last_pfn = 0x87fc00 max_arch_pfn = 0x400000000
jan 09 02:03:50 localhost kernel: MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
jan 09 02:03:50 localhost kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
jan 09 02:03:50 localhost kernel: last_pfn = 0x7695a max_arch_pfn = 0x400000000
jan 09 02:03:50 localhost kernel: Using GB pages for direct mapping
jan 09 02:03:50 localhost kernel: Incomplete global flushes, disabling PCID
jan 09 02:03:50 localhost kernel: Secure boot disabled
jan 09 02:03:50 localhost kernel: RAMDISK: [mem 0x700d2000-0x71ba4fff]
jan 09 02:03:50 localhost kernel: ACPI: Early table checksum verification disabled
jan 09 02:03:50 localhost kernel: ACPI: RSDP 0x0000000076958014 000024 (v02 COREv4)
jan 09 02:03:50 localhost kernel: ACPI: XSDT 0x00000000769570E8 000074 (v01 COREv4 COREBOOT 00000000      01000013)
jan 09 02:03:50 localhost kernel: ACPI: FACP 0x0000000076956000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: DSDT 0x0000000076950000 005063 (v02 COREv4 COREBOOT 20220930 INTL 20230628)
jan 09 02:03:50 localhost kernel: ACPI: FACS 0x0000000076967240 000040
jan 09 02:03:50 localhost kernel: ACPI: SSDT 0x000000007694B000 0045F7 (v02 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: MCFG 0x000000007694A000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: TPM2 0x0000000076949000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: LPIT 0x0000000076948000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: APIC 0x0000000076947000 0000D2 (v03 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: DMAR 0x0000000076946000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: DBG2 0x0000000076945000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: HPET 0x0000000076944000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 09 02:03:50 localhost kernel: ACPI: BGRT 0x0000000076943000 000038 (v01 INTEL  EDK2     00000002      01000013)
jan 09 02:03:50 localhost kernel: ACPI: Reserving FACP table memory at [mem 0x76956000-0x76956113]
jan 09 02:03:50 localhost kernel: ACPI: Reserving DSDT table memory at [mem 0x76950000-0x76955062]
jan 09 02:03:50 localhost kernel: ACPI: Reserving FACS table memory at [mem 0x76967240-0x7696727f]
jan 09 02:03:50 localhost kernel: ACPI: Reserving SSDT table memory at [mem 0x7694b000-0x7694f5f6]
jan 09 02:03:50 localhost kernel: ACPI: Reserving MCFG table memory at [mem 0x7694a000-0x7694a03b]
jan 09 02:03:50 localhost kernel: ACPI: Reserving TPM2 table memory at [mem 0x76949000-0x7694904b]
jan 09 02:03:50 localhost kernel: ACPI: Reserving LPIT table memory at [mem 0x76948000-0x76948093]
jan 09 02:03:50 localhost kernel: ACPI: Reserving APIC table memory at [mem 0x76947000-0x769470d1]
jan 09 02:03:50 localhost kernel: ACPI: Reserving DMAR table memory at [mem 0x76946000-0x76946087]
jan 09 02:03:50 localhost kernel: ACPI: Reserving DBG2 table memory at [mem 0x76945000-0x76945060]
jan 09 02:03:50 localhost kernel: ACPI: Reserving HPET table memory at [mem 0x76944000-0x76944037]
jan 09 02:03:50 localhost kernel: ACPI: Reserving BGRT table memory at [mem 0x76943000-0x76943037]
jan 09 02:03:50 localhost kernel: No NUMA configuration found
jan 09 02:03:50 localhost kernel: Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
jan 09 02:03:50 localhost kernel: NODE_DATA(0) allocated [mem 0x87fbfa000-0x87fbfffff]
jan 09 02:03:50 localhost kernel: Zone ranges:
jan 09 02:03:50 localhost kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
jan 09 02:03:50 localhost kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
jan 09 02:03:50 localhost kernel:   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
jan 09 02:03:50 localhost kernel:   Device   empty
jan 09 02:03:50 localhost kernel: Movable zone start for each node
jan 09 02:03:50 localhost kernel: Early memory node ranges
jan 09 02:03:50 localhost kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
jan 09 02:03:50 localhost kernel:   node   0: [mem 0x0000000000100000-0x0000000076733fff]
jan 09 02:03:50 localhost kernel:   node   0: [mem 0x0000000076934000-0x0000000076940fff]
jan 09 02:03:50 localhost kernel:   node   0: [mem 0x0000000076959000-0x0000000076959fff]
jan 09 02:03:50 localhost kernel:   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
jan 09 02:03:50 localhost kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbfffff]
jan 09 02:03:50 localhost kernel: On node 0, zone DMA: 1 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: On node 0, zone DMA: 96 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: On node 0, zone DMA32: 512 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: On node 0, zone DMA32: 24 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: On node 0, zone Normal: 5798 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: On node 0, zone Normal: 1024 pages in unavailable ranges
jan 09 02:03:50 localhost kernel: Reserving Intel graphics memory at [mem 0x7c800000-0x803fffff]
jan 09 02:03:50 localhost kernel: ACPI: PM-Timer IO Port: 0x1808
jan 09 02:03:50 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
jan 09 02:03:50 localhost kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
jan 09 02:03:50 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
jan 09 02:03:50 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
jan 09 02:03:50 localhost kernel: ACPI: Using ACPI (MADT) for SMP configuration information
jan 09 02:03:50 localhost kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
jan 09 02:03:50 localhost kernel: e820: update [mem 0x736aa000-0x736d1fff] usable ==> reserved
jan 09 02:03:50 localhost kernel: TSC deadline timer available
jan 09 02:03:50 localhost kernel: smpboot: Allowing 16 CPUs, 0 hotplug CPUs
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x736aa000-0x736d1fff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76734000-0x76933fff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76941000-0x76958fff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x7695a000-0x803fffff]
jan 09 02:03:50 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x80400000-0xffffffff]
jan 09 02:03:50 localhost kernel: [mem 0x80400000-0xffffffff] available for PCI devices
jan 09 02:03:50 localhost kernel: Booting paravirtualized kernel on bare hardware
jan 09 02:03:50 localhost kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
jan 09 02:03:50 localhost kernel: setup_percpu: NR_CPUS:384 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
jan 09 02:03:50 localhost kernel: percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u524288
jan 09 02:03:50 localhost kernel: pcpu-alloc: s221184 r8192 d114688 u524288 alloc=1*2097152
jan 09 02:03:50 localhost kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
jan 09 02:03:50 localhost kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
jan 09 02:03:50 localhost kernel: Kernel command line: initrd=\efi\nixos\9vbz5hrfl3xbxq2zrx9mdpwv0clbzwnd-initrd-linux-6.6.10-initrd.efi init=/nix/store/2j74m1lmj4zaijr6dhnnak3fzlm81j7i-nixos-system-starbook-20240102.bd645e8.20240106.db12804/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 09 02:03:50 localhost kernel: random: crng init done
jan 09 02:03:50 localhost kernel: Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
jan 09 02:03:50 localhost kernel: Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
jan 09 02:03:50 localhost kernel: Fallback order for Node 0: 0 
jan 09 02:03:50 localhost kernel: Built 1 zonelists, mobility grouping on.  Total pages: 8216356
jan 09 02:03:50 localhost kernel: Policy zone: Normal
jan 09 02:03:50 localhost kernel: mem auto-init: stack:all(zero), heap alloc:off, heap free:off
jan 09 02:03:50 localhost kernel: software IO TLB: area num 16.
jan 09 02:03:50 localhost kernel: Memory: 32626440K/33393540K available (14336K kernel code, 2310K rwdata, 9252K rodata, 2956K init, 2996K bss, 766844K reserved, 0K cma-reserved)
jan 09 02:03:50 localhost kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
jan 09 02:03:50 localhost kernel: ftrace: allocating 39703 entries in 156 pages
jan 09 02:03:50 localhost kernel: ftrace: allocated 156 pages with 4 groups
jan 09 02:03:50 localhost kernel: Dynamic Preempt: voluntary
jan 09 02:03:50 localhost kernel: rcu: Preemptible hierarchical RCU implementation.
jan 09 02:03:50 localhost kernel: rcu:         RCU event tracing is enabled.
jan 09 02:03:50 localhost kernel: rcu:         RCU restricting CPUs from NR_CPUS=384 to nr_cpu_ids=16.
jan 09 02:03:50 localhost kernel:         Trampoline variant of Tasks RCU enabled.
jan 09 02:03:50 localhost kernel:         Rude variant of Tasks RCU enabled.
jan 09 02:03:50 localhost kernel:         Tracing variant of Tasks RCU enabled.
jan 09 02:03:50 localhost kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
jan 09 02:03:50 localhost kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
jan 09 02:03:50 localhost kernel: NR_IRQS: 24832, nr_irqs: 2184, preallocated irqs: 16
jan 09 02:03:50 localhost kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
jan 09 02:03:50 localhost kernel: spurious 8259A interrupt: IRQ7.
jan 09 02:03:50 localhost kernel: Console: colour dummy device 80x25
jan 09 02:03:50 localhost kernel: printk: console [tty0] enabled
jan 09 02:03:50 localhost kernel: ACPI: Core revision 20230628
jan 09 02:03:50 localhost kernel: hpet: HPET dysfunctional in PC10. Force disabled.
jan 09 02:03:50 localhost kernel: APIC: Switch to symmetric I/O mode setup
jan 09 02:03:50 localhost kernel: DMAR: Host address width 39
jan 09 02:03:50 localhost kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0x0
jan 09 02:03:50 localhost kernel: DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
jan 09 02:03:50 localhost kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0x1
jan 09 02:03:50 localhost kernel: DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
jan 09 02:03:50 localhost kernel: DMAR: RMRR base: 0x0000007c000000 end: 0x000000803fffff
jan 09 02:03:50 localhost kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
jan 09 02:03:50 localhost kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91000
jan 09 02:03:50 localhost kernel: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
jan 09 02:03:50 localhost kernel: DMAR-IR: Enabled IRQ remapping in x2apic mode
jan 09 02:03:50 localhost kernel: x2apic enabled
jan 09 02:03:50 localhost kernel: APIC: Switched APIC routing to: cluster x2apic
jan 09 02:03:50 localhost kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 09 02:03:50 localhost kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.00 BogoMIPS (lpj=2496000)
jan 09 02:03:50 localhost kernel: CPU0: Thermal monitoring enabled (TM1)
jan 09 02:03:50 localhost kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
jan 09 02:03:50 localhost kernel: process: using mwait in idle threads
jan 09 02:03:50 localhost kernel: CET detected: Indirect Branch Tracking enabled
jan 09 02:03:50 localhost kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
jan 09 02:03:50 localhost kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
jan 09 02:03:50 localhost kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
jan 09 02:03:50 localhost kernel: Spectre V2 : Mitigation: Enhanced / Automatic IBRS
jan 09 02:03:50 localhost kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
jan 09 02:03:50 localhost kernel: Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
jan 09 02:03:50 localhost kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
jan 09 02:03:50 localhost kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
jan 09 02:03:50 localhost kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
jan 09 02:03:50 localhost kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
jan 09 02:03:50 localhost kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
jan 09 02:03:50 localhost kernel: x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
jan 09 02:03:50 localhost kernel: x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
jan 09 02:03:50 localhost kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
jan 09 02:03:50 localhost kernel: x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
jan 09 02:03:50 localhost kernel: x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
jan 09 02:03:50 localhost kernel: x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
jan 09 02:03:50 localhost kernel: Freeing SMP alternatives memory: 36K
jan 09 02:03:50 localhost kernel: pid_max: default: 32768 minimum: 301
jan 09 02:03:50 localhost kernel: LSM: initializing lsm=capability,landlock,yama,selinux,bpf,integrity
jan 09 02:03:50 localhost kernel: landlock: Up and running.
jan 09 02:03:50 localhost kernel: Yama: becoming mindful.
jan 09 02:03:50 localhost kernel: SELinux:  Initializing.
jan 09 02:03:50 localhost kernel: LSM support for eBPF active
jan 09 02:03:50 localhost kernel: Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 09 02:03:50 localhost kernel: Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 09 02:03:50 localhost kernel: smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
jan 09 02:03:50 localhost kernel: RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 09 02:03:50 localhost kernel: RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 09 02:03:50 localhost kernel: RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 09 02:03:50 localhost kernel: Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
jan 09 02:03:50 localhost kernel: core: cpu_core PMU driver: 
jan 09 02:03:50 localhost kernel: ... version:                5
jan 09 02:03:50 localhost kernel: ... bit width:              48
jan 09 02:03:50 localhost kernel: ... generic registers:      8
jan 09 02:03:50 localhost kernel: ... value mask:             0000ffffffffffff
jan 09 02:03:50 localhost kernel: ... max period:             00007fffffffffff
jan 09 02:03:50 localhost kernel: ... fixed-purpose events:   4
jan 09 02:03:50 localhost kernel: ... event mask:             0001000f000000ff
jan 09 02:03:50 localhost kernel: signal: max sigframe size: 3632
jan 09 02:03:50 localhost kernel: Estimated ratio of average max frequency by base frequency (times 1024): 1556
jan 09 02:03:50 localhost kernel: rcu: Hierarchical SRCU implementation.
jan 09 02:03:50 localhost kernel: rcu:         Max phase no-delay instances is 400.
jan 09 02:03:50 localhost kernel: smp: Bringing up secondary CPUs ...
jan 09 02:03:50 localhost kernel: smpboot: x86: Booting SMP configuration:
jan 09 02:03:50 localhost kernel: .... node  #0, CPUs:        #2  #4  #6  #8  #9 #10 #11 #12 #13 #14 #15
jan 09 02:03:50 localhost kernel: core: cpu_atom PMU driver: PEBS-via-PT 
jan 09 02:03:50 localhost kernel: ... version:                5
jan 09 02:03:50 localhost kernel: ... bit width:              48
jan 09 02:03:50 localhost kernel: ... generic registers:      6
jan 09 02:03:50 localhost kernel: ... value mask:             0000ffffffffffff
jan 09 02:03:50 localhost kernel: ... max period:             00007fffffffffff
jan 09 02:03:50 localhost kernel: ... fixed-purpose events:   3
jan 09 02:03:50 localhost kernel: ... event mask:             000000070000003f
jan 09 02:03:50 localhost kernel:   #1  #3  #5  #7
jan 09 02:03:50 localhost kernel: smp: Brought up 1 node, 16 CPUs
jan 09 02:03:50 localhost kernel: smpboot: Max logical packages: 1
jan 09 02:03:50 localhost kernel: smpboot: Total of 16 processors activated (79872.00 BogoMIPS)
jan 09 02:03:50 localhost kernel: devtmpfs: initialized
jan 09 02:03:50 localhost kernel: x86/mm: Memory block size: 128MB
jan 09 02:03:50 localhost kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
jan 09 02:03:50 localhost kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
jan 09 02:03:50 localhost kernel: pinctrl core: initialized pinctrl subsystem
jan 09 02:03:50 localhost kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
jan 09 02:03:50 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
jan 09 02:03:50 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
jan 09 02:03:50 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
jan 09 02:03:50 localhost kernel: audit: initializing netlink subsys (disabled)
jan 09 02:03:50 localhost kernel: audit: type=2000 audit(1704762230.017:1): state=initialized audit_enabled=0 res=1
jan 09 02:03:50 localhost kernel: thermal_sys: Registered thermal governor 'bang_bang'
jan 09 02:03:50 localhost kernel: thermal_sys: Registered thermal governor 'step_wise'
jan 09 02:03:50 localhost kernel: thermal_sys: Registered thermal governor 'user_space'
jan 09 02:03:50 localhost kernel: cpuidle: using governor menu
jan 09 02:03:50 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
jan 09 02:03:50 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 09 02:03:50 localhost kernel: PCI: not using MMCONFIG
jan 09 02:03:50 localhost kernel: PCI: Using configuration type 1 for base access
jan 09 02:03:50 localhost kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
jan 09 02:03:50 localhost kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
jan 09 02:03:50 localhost kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
jan 09 02:03:50 localhost kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
jan 09 02:03:50 localhost kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
jan 09 02:03:50 localhost kernel: ACPI: Added _OSI(Module Device)
jan 09 02:03:50 localhost kernel: ACPI: Added _OSI(Processor Device)
jan 09 02:03:50 localhost kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
jan 09 02:03:50 localhost kernel: ACPI: Added _OSI(Processor Aggregator Device)
jan 09 02:03:50 localhost kernel: ACPI: 2 ACPI AML tables successfully acquired and loaded
jan 09 02:03:50 localhost kernel: ACPI: _OSC evaluation for CPUs failed, trying _PDC
jan 09 02:03:50 localhost kernel: ACPI: EC: EC started
jan 09 02:03:50 localhost kernel: ACPI: EC: interrupt blocked
jan 09 02:03:50 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
jan 09 02:03:50 localhost kernel: ACPI: Interpreter enabled
jan 09 02:03:50 localhost kernel: ACPI: PM: (supports S0 S3 S4 S5)
jan 09 02:03:50 localhost kernel: ACPI: Using IOAPIC for interrupt routing
jan 09 02:03:50 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 09 02:03:50 localhost kernel: PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved as ACPI motherboard resource
jan 09 02:03:50 localhost kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
jan 09 02:03:50 localhost kernel: PCI: Ignoring E820 reservations for host bridge windows
jan 09 02:03:50 localhost kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.RP01.RTD3: New power resource
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.RP09.RTD3: New power resource
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.TBT0: New power resource
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.TBT1: New power resource
jan 09 02:03:50 localhost kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
jan 09 02:03:50 localhost kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
jan 09 02:03:50 localhost kernel: acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
jan 09 02:03:50 localhost kernel: PCI host bridge to bus 0000:00
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x80400000-0xdfffffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x87fc00000-0x7fffffffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
jan 09 02:03:50 localhost kernel: pci 0000:00:00.0: [8086:4621] type 00 class 0x060000
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: reg 0x10: [mem 0x81000000-0x81ffffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: reg 0x20: [io  0x1000-0x103f]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: BAR 2: assigned to efifb
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
jan 09 02:03:50 localhost kernel: pci 0000:00:08.0: [8086:464f] type 00 class 0x088000
jan 09 02:03:50 localhost kernel: pci 0000:00:08.0: reg 0x10: [mem 0x80720000-0x80720fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000
jan 09 02:03:50 localhost kernel: pci 0000:00:0a.0: reg 0x10: [mem 0x80710000-0x80717fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:0a.0: enabling Extended Tags
jan 09 02:03:50 localhost kernel: pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330
jan 09 02:03:50 localhost kernel: pci 0000:00:14.0: reg 0x10: [mem 0x80700000-0x8070ffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
jan 09 02:03:50 localhost kernel: pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000
jan 09 02:03:50 localhost kernel: pci 0000:00:14.2: reg 0x10: [mem 0x80718000-0x8071bfff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:14.2: reg 0x18: [mem 0x80721000-0x80721fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000
jan 09 02:03:50 localhost kernel: pci 0000:00:15.0: reg 0x10: [mem 0x80722000-0x80722fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0: [8086:51bc] type 01 class 0x060400
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
jan 09 02:03:50 localhost kernel: pci 0000:00:1e.0: [8086:51a8] type 00 class 0x078000
jan 09 02:03:50 localhost kernel: pci 0000:00:1e.0: reg 0x10: [mem 0xfe03e000-0xfe03efff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1e.0: reg 0x18: [mem 0x80724000-0x80724fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040300
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.3: reg 0x10: [mem 0x8071c000-0x8071ffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.3: reg 0x20: [mem 0x80600000-0x806fffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.3: PME# supported from D3hot D3cold
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.4: reg 0x10: [mem 0x80726000-0x807260ff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000
jan 09 02:03:50 localhost kernel: pci 0000:00:1f.5: reg 0x10: [mem 0x80725000-0x80725fff]
jan 09 02:03:50 localhost kernel: pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
jan 09 02:03:50 localhost kernel: pci 0000:01:00.0: reg 0x10: [mem 0x80400000-0x80403fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 09 02:03:50 localhost kernel: pci 0000:02:00.0: [144d:a80c] type 00 class 0x010802
jan 09 02:03:50 localhost kernel: pci 0000:02:00.0: reg 0x10: [mem 0x80500000-0x80503fff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1d.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 09 02:03:50 localhost kernel: ACPI: EC: interrupt unblocked
jan 09 02:03:50 localhost kernel: ACPI: EC: event unblocked
jan 09 02:03:50 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 09 02:03:50 localhost kernel: ACPI: EC: GPE=0x6e
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC initialization complete
jan 09 02:03:50 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
jan 09 02:03:50 localhost kernel: iommu: Default domain type: Translated
jan 09 02:03:50 localhost kernel: iommu: DMA domain TLB invalidation policy: lazy mode
jan 09 02:03:50 localhost kernel: efivars: Registered efivars operations
jan 09 02:03:50 localhost kernel: NetLabel: Initializing
jan 09 02:03:50 localhost kernel: NetLabel:  domain hash size = 128
jan 09 02:03:50 localhost kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
jan 09 02:03:50 localhost kernel: NetLabel:  unlabeled traffic allowed by default
jan 09 02:03:50 localhost kernel: PCI: Using ACPI for IRQ routing
jan 09 02:03:50 localhost kernel: PCI: pci_cache_line_size set to 64 bytes
jan 09 02:03:50 localhost kernel: e820: reserve RAM buffer [mem 0x736aa000-0x73ffffff]
jan 09 02:03:50 localhost kernel: e820: reserve RAM buffer [mem 0x76734000-0x77ffffff]
jan 09 02:03:50 localhost kernel: e820: reserve RAM buffer [mem 0x76941000-0x77ffffff]
jan 09 02:03:50 localhost kernel: e820: reserve RAM buffer [mem 0x7695a000-0x77ffffff]
jan 09 02:03:50 localhost kernel: e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: vgaarb: bridge control possible
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
jan 09 02:03:50 localhost kernel: vgaarb: loaded
jan 09 02:03:50 localhost kernel: clocksource: Switched to clocksource tsc-early
jan 09 02:03:50 localhost kernel: VFS: Disk quotas dquot_6.6.0
jan 09 02:03:50 localhost kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
jan 09 02:03:50 localhost kernel: pnp: PnP ACPI init
jan 09 02:03:50 localhost kernel: pnp 00:00: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfedc0000-0xfeddffff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfeda0000-0xfeda0fff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfeda1000-0xfeda1fff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfe000000-0xffffffff] could not be reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xf8000000-0xf9ffffff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
jan 09 02:03:50 localhost kernel: system 00:03: [io  0x1800-0x18fe] has been reserved
jan 09 02:03:50 localhost kernel: pnp: PnP ACPI: found 7 devices
jan 09 02:03:50 localhost kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
jan 09 02:03:50 localhost kernel: NET: Registered PF_INET protocol family
jan 09 02:03:50 localhost kernel: IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 09 02:03:50 localhost kernel: tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
jan 09 02:03:50 localhost kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
jan 09 02:03:50 localhost kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 09 02:03:50 localhost kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
jan 09 02:03:50 localhost kernel: TCP: Hash tables configured (established 262144 bind 65536)
jan 09 02:03:50 localhost kernel: MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
jan 09 02:03:50 localhost kernel: UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 09 02:03:50 localhost kernel: UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 09 02:03:50 localhost kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
jan 09 02:03:50 localhost kernel: NET: Registered PF_XDP protocol family
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: BAR 9: assigned [mem 0x880000000-0x95fffffff 64bit pref]
jan 09 02:03:50 localhost kernel: pci 0000:00:02.0: BAR 7: assigned [mem 0x960000000-0x966ffffff 64bit]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: BAR 15: assigned [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x2fff]
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 09 02:03:50 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0:   bridge window [io  0x2000-0x2fff]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 09 02:03:50 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 7 [mem 0x80400000-0xdfffffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 8 [mem 0x87fc00000-0x7fffffffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed47fff window]
jan 09 02:03:50 localhost kernel: pci_bus 0000:01: resource 1 [mem 0x80400000-0x804fffff]
jan 09 02:03:50 localhost kernel: pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
jan 09 02:03:50 localhost kernel: pci_bus 0000:02: resource 1 [mem 0x80500000-0x805fffff]
jan 09 02:03:50 localhost kernel: pci_bus 0000:02: resource 2 [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 09 02:03:50 localhost kernel: PCI: CLS 64 bytes, default 64
jan 09 02:03:50 localhost kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
jan 09 02:03:50 localhost kernel: software IO TLB: mapped [mem 0x000000006c0d2000-0x00000000700d2000] (64MB)
jan 09 02:03:50 localhost kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 09 02:03:50 localhost kernel: clocksource: Switched to clocksource tsc
jan 09 02:03:50 localhost kernel: Trying to unpack rootfs image as initramfs...
jan 09 02:03:50 localhost kernel: Initialise system trusted keyrings
jan 09 02:03:50 localhost kernel: workingset: timestamp_bits=40 max_order=23 bucket_order=0
jan 09 02:03:50 localhost kernel: zbud: loaded
jan 09 02:03:50 localhost kernel: Key type asymmetric registered
jan 09 02:03:50 localhost kernel: Asymmetric key parser 'x509' registered
jan 09 02:03:50 localhost kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
jan 09 02:03:50 localhost kernel: io scheduler mq-deadline registered
jan 09 02:03:50 localhost kernel: io scheduler kyber registered
jan 09 02:03:50 localhost kernel: pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
jan 09 02:03:50 localhost kernel: pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
jan 09 02:03:50 localhost kernel: pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
jan 09 02:03:50 localhost kernel: efifb: probing for efifb
jan 09 02:03:50 localhost kernel: efifb: showing boot graphics
jan 09 02:03:50 localhost kernel: efifb: framebuffer at 0x90000000, using 8100k, total 8100k
jan 09 02:03:50 localhost kernel: efifb: mode is 1920x1080x32, linelength=7680, pages=1
jan 09 02:03:50 localhost kernel: efifb: scrolling: redraw
jan 09 02:03:50 localhost kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
jan 09 02:03:50 localhost kernel: fbcon: Deferring console take-over
jan 09 02:03:50 localhost kernel: fb0: EFI VGA frame buffer device
jan 09 02:03:50 localhost kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
jan 09 02:03:50 localhost kernel: hpet_acpi_add: no address or irqs in _CRS
jan 09 02:03:50 localhost kernel: intel_pstate: Intel P-state driver initializing
jan 09 02:03:50 localhost kernel: intel_pstate: HWP enabled
jan 09 02:03:50 localhost kernel: drop_monitor: Initializing network drop monitor service
jan 09 02:03:50 localhost kernel: NET: Registered PF_INET6 protocol family
jan 09 02:03:50 localhost kernel: Freeing initrd memory: 27468K
jan 09 02:03:50 localhost kernel: Segment Routing with IPv6
jan 09 02:03:50 localhost kernel: In-situ OAM (IOAM) with IPv6
jan 09 02:03:50 localhost kernel: microcode: Microcode Update Driver: v2.2.
jan 09 02:03:50 localhost kernel: IPI shorthand broadcast: enabled
jan 09 02:03:50 localhost kernel: sched_clock: Marking stable (411001464, 15982006)->(455282772, -28299302)
jan 09 02:03:50 localhost kernel: registered taskstats version 1
jan 09 02:03:50 localhost kernel: Loading compiled-in X.509 certificates
jan 09 02:03:50 localhost kernel: Key type .fscrypt registered
jan 09 02:03:50 localhost kernel: Key type fscrypt-provisioning registered
jan 09 02:03:50 localhost kernel: clk: Disabling unused clocks
jan 09 02:03:50 localhost kernel: Freeing unused decrypted memory: 2028K
jan 09 02:03:50 localhost kernel: Freeing unused kernel image (initmem) memory: 2956K
jan 09 02:03:50 localhost kernel: Write protecting the kernel read-only data: 24576k
jan 09 02:03:50 localhost kernel: Freeing unused kernel image (rodata/data gap) memory: 988K
jan 09 02:03:50 localhost kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
jan 09 02:03:50 localhost kernel: Run /init as init process
jan 09 02:03:50 localhost kernel:   with arguments:
jan 09 02:03:50 localhost kernel:     /init
jan 09 02:03:50 localhost kernel:   with environment:
jan 09 02:03:50 localhost kernel:     HOME=/
jan 09 02:03:50 localhost kernel:     TERM=linux
jan 09 02:03:50 localhost systemd[1]: Inserted module 'autofs4'
jan 09 02:03:50 localhost systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 09 02:03:50 localhost systemd[1]: Detected architecture x86-64.
jan 09 02:03:50 localhost systemd[1]: Running in initrd.
jan 09 02:03:50 localhost kernel: fbcon: Taking over console
jan 09 02:03:50 localhost systemd[1]: No hostname configured, using default hostname.
jan 09 02:03:50 localhost systemd[1]: Hostname set to <localhost>.
jan 09 02:03:50 localhost systemd[1]: Initializing machine ID from random generator.
jan 09 02:03:50 localhost kernel: Console: switching to colour frame buffer device 240x67
jan 09 02:03:50 localhost systemd[1]: Queued start job for default target Initrd Default Target.
jan 09 02:03:50 localhost systemd[1]: Created slice Slice /system/systemd-cryptsetup.
jan 09 02:03:50 localhost systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 09 02:03:50 localhost systemd[1]: Reached target Initrd Root Device.
jan 09 02:03:50 localhost systemd[1]: Reached target Path Units.
jan 09 02:03:50 localhost systemd[1]: Reached target Slice Units.
jan 09 02:03:50 localhost systemd[1]: Reached target Swaps.
jan 09 02:03:50 localhost systemd[1]: Reached target Timer Units.
jan 09 02:03:50 localhost systemd[1]: Listening on Journal Socket (/dev/log).
jan 09 02:03:50 localhost systemd[1]: Listening on Journal Socket.
jan 09 02:03:50 localhost systemd[1]: Listening on udev Control Socket.
jan 09 02:03:50 localhost systemd[1]: Listening on udev Kernel Socket.
jan 09 02:03:50 localhost systemd[1]: Reached target Socket Units.
jan 09 02:03:50 localhost systemd[1]: Starting Create List of Static Device Nodes...
jan 09 02:03:50 localhost systemd[1]: Starting Journal Service...
jan 09 02:03:50 localhost systemd[1]: Starting Load Kernel Modules...
jan 09 02:03:50 localhost systemd[1]: Starting Create Static Device Nodes in /dev...
jan 09 02:03:50 localhost systemd[1]: Starting Coldplug All udev Devices...
jan 09 02:03:50 localhost systemd[1]: Finished Create List of Static Device Nodes.
jan 09 02:03:50 localhost systemd[1]: Finished Create Static Device Nodes in /dev.
jan 09 02:03:50 localhost systemd[1]: Reached target Preparation for Local File Systems.
jan 09 02:03:50 localhost systemd[1]: Reached target Local File Systems.
jan 09 02:03:50 localhost systemd[1]: Mounting /sysroot...
jan 09 02:03:50 localhost systemd[1]: Starting Rule-based Manager for Device Events and Files...
jan 09 02:03:50 localhost systemd-journald[173]: Collecting audit messages is disabled.
jan 09 02:03:50 localhost systemd[1]: Mounted /sysroot.
jan 09 02:03:50 localhost systemd[1]: Reached target Initrd Root File System.
jan 09 02:03:50 localhost systemd[1]: Starting Mountpoints Configured in the Real Root...
jan 09 02:03:50 localhost systemd[1]: Reloading requested from client PID 183 ('systemd-fstab-g') (unit initrd-parse-etc.service)...
jan 09 02:03:50 localhost systemd[1]: Reloading...
jan 09 02:03:50 localhost kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
jan 09 02:03:50 localhost kernel: raid6: avx2x4   gen() 36798 MB/s
jan 09 02:03:50 localhost kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
jan 09 02:03:50 localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
jan 09 02:03:50 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
jan 09 02:03:50 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
jan 09 02:03:50 localhost kernel: rtc_cmos 00:04: RTC can wake from S4
jan 09 02:03:50 localhost kernel: rtc_cmos 00:04: registered as rtc0
jan 09 02:03:50 localhost kernel: rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
jan 09 02:03:50 localhost kernel: cryptd: max_cpu_qlen set to 1000
jan 09 02:03:50 localhost kernel: AVX2 version of gcm_enc/dec engaged.
jan 09 02:03:50 localhost kernel: AES CTR mode by8 optimization enabled
jan 09 02:03:50 localhost kernel: raid6: avx2x2   gen() 32058 MB/s
jan 09 02:03:50 localhost kernel: ACPI: bus type USB registered
jan 09 02:03:50 localhost kernel: usbcore: registered new interface driver usbfs
jan 09 02:03:50 localhost kernel: usbcore: registered new interface driver hub
jan 09 02:03:50 localhost kernel: usbcore: registered new device driver usb
jan 09 02:03:50 localhost kernel: raid6: avx2x1   gen() 31428 MB/s
jan 09 02:03:50 localhost kernel: raid6: using algorithm avx2x4 gen() 36798 MB/s
jan 09 02:03:50 localhost kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
jan 09 02:03:50 localhost kernel: nvme nvme0: pci function 0000:02:00.0
jan 09 02:03:50 localhost kernel: nvme nvme0: Shutdown timeout set to 10 seconds
jan 09 02:03:50 localhost kernel: raid6: .... xor() 7526 MB/s, rmw enabled
jan 09 02:03:50 localhost kernel: raid6: using avx2x2 recovery algorithm
jan 09 02:03:50 localhost kernel: nvme nvme0: 16/0/0 default/read/poll queues
jan 09 02:03:50 localhost kernel:  nvme0n1: p1 p2
jan 09 02:03:50 localhost kernel: xor: automatically using best checksumming function   avx       
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
jan 09 02:03:50 localhost kernel: xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
jan 09 02:03:50 localhost kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
jan 09 02:03:50 localhost kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 09 02:03:50 localhost kernel: usb usb1: Product: xHCI Host Controller
jan 09 02:03:50 localhost kernel: usb usb1: Manufacturer: Linux 6.6.10 xhci-hcd
jan 09 02:03:50 localhost kernel: usb usb1: SerialNumber: 0000:00:14.0
jan 09 02:03:50 localhost kernel: hub 1-0:1.0: USB hub found
jan 09 02:03:50 localhost kernel: hub 1-0:1.0: 12 ports detected
jan 09 02:03:50 localhost kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
jan 09 02:03:50 localhost kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 09 02:03:50 localhost kernel: usb usb2: Product: xHCI Host Controller
jan 09 02:03:50 localhost kernel: usb usb2: Manufacturer: Linux 6.6.10 xhci-hcd
jan 09 02:03:50 localhost kernel: usb usb2: SerialNumber: 0000:00:14.0
jan 09 02:03:50 localhost kernel: hub 2-0:1.0: USB hub found
jan 09 02:03:50 localhost kernel: hub 2-0:1.0: 4 ports detected
jan 09 02:03:50 localhost systemd[1]: Found device Samsung SSD 990 PRO 1TB disk-main-primary.
jan 09 02:03:50 localhost systemd[1]: Reloading finished in 106 ms.
jan 09 02:03:50 localhost systemd[1]: Started Journal Service.
jan 09 02:03:50 localhost kernel: Btrfs loaded, zoned=no, fsverity=no
jan 09 02:03:50 localhost kernel: usb 1-1: new full-speed USB device number 2 using xhci_hcd
jan 09 02:03:50 localhost kernel: usb 1-1: New USB device found, idVendor=413c, idProduct=b07c, bcdDevice= 0.00
jan 09 02:03:50 localhost kernel: usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 09 02:03:50 localhost kernel: usb 1-1: Product: Dell USB-C to HDMI/DP
jan 09 02:03:50 localhost kernel: usb 1-1: Manufacturer: Dell
jan 09 02:03:50 localhost kernel: usb 1-1: SerialNumber: 11AD1D0A92AE3E1209240B00
jan 09 02:03:50 localhost kernel: usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
jan 09 02:03:51 localhost kernel: usb 2-1: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 09 02:03:51 localhost kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:51 localhost kernel: usb 2-1: Product: USB3.0 Hub
jan 09 02:03:51 localhost kernel: usb 2-1: Manufacturer: VIA Labs, Inc.
jan 09 02:03:51 localhost kernel: hub 2-1:1.0: USB hub found
jan 09 02:03:51 localhost kernel: hub 2-1:1.0: 4 ports detected
jan 09 02:03:51 localhost kernel: usb 1-3: new high-speed USB device number 3 using xhci_hcd
jan 09 02:03:51 localhost kernel: usb 1-3: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 09 02:03:51 localhost kernel: usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:51 localhost kernel: usb 1-3: Product: USB2.0 Hub
jan 09 02:03:51 localhost kernel: usb 1-3: Manufacturer: VIA Labs, Inc.
jan 09 02:03:51 localhost kernel: hub 1-3:1.0: USB hub found
jan 09 02:03:51 localhost kernel: hub 1-3:1.0: 4 ports detected
jan 09 02:03:51 localhost kernel: usb 1-4: new high-speed USB device number 4 using xhci_hcd
jan 09 02:03:51 localhost kernel: usb 1-4: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=60.90
jan 09 02:03:51 localhost kernel: usb 1-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 09 02:03:51 localhost kernel: usb 1-4: Product: USB2.0 Hub
jan 09 02:03:51 localhost kernel: hub 1-4:1.0: USB hub found
jan 09 02:03:51 localhost kernel: hub 1-4:1.0: 4 ports detected
jan 09 02:03:51 localhost kernel: usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
jan 09 02:03:51 localhost kernel: usb 2-1.1: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 09 02:03:51 localhost kernel: usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 09 02:03:51 localhost kernel: usb 2-1.1: Product: Dell D3100 USB3.0 Dock
jan 09 02:03:51 localhost kernel: usb 2-1.1: Manufacturer: DisplayLink
jan 09 02:03:51 localhost kernel: usb 2-1.1: SerialNumber: 2209282137B
jan 09 02:03:51 localhost kernel: usb 1-3.2: new high-speed USB device number 5 using xhci_hcd
jan 09 02:03:51 localhost kernel: usb 1-3.2: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 09 02:03:51 localhost kernel: usb 1-3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:51 localhost kernel: usb 1-3.2: Product: USB2.0 Hub
jan 09 02:03:51 localhost kernel: usb 1-3.2: Manufacturer: VIA Labs, Inc.
jan 09 02:03:51 localhost kernel: hub 1-3.2:1.0: USB hub found
jan 09 02:03:51 localhost kernel: hub 1-3.2:1.0: 4 ports detected
jan 09 02:03:51 localhost kernel: usb 1-5: new high-speed USB device number 6 using xhci_hcd
jan 09 02:03:52 localhost kernel: usb 1-5: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
jan 09 02:03:52 localhost kernel: usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=3
jan 09 02:03:52 localhost kernel: usb 1-5: Product: USB 2.0 Camera
jan 09 02:03:52 localhost kernel: usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
jan 09 02:03:52 localhost kernel: usb 1-5: SerialNumber: SN0001
jan 09 02:03:52 localhost kernel: usb 2-1.2: new SuperSpeed USB device number 4 using xhci_hcd
jan 09 02:03:52 localhost kernel: usb 2-1.2: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 09 02:03:52 localhost kernel: usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:52 localhost kernel: usb 2-1.2: Product: USB3.0 Hub
jan 09 02:03:52 localhost kernel: usb 2-1.2: Manufacturer: VIA Labs, Inc.
jan 09 02:03:52 localhost kernel: hub 2-1.2:1.0: USB hub found
jan 09 02:03:52 localhost kernel: hub 2-1.2:1.0: 4 ports detected
jan 09 02:03:52 localhost kernel: usb 1-4.1: new high-speed USB device number 7 using xhci_hcd
jan 09 02:03:52 localhost kernel: usb 1-4.1: New USB device found, idVendor=05e3, idProduct=0761, bcdDevice=24.02
jan 09 02:03:52 localhost kernel: usb 1-4.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 09 02:03:52 localhost kernel: usb 1-4.1: Product: USB Storage
jan 09 02:03:52 localhost kernel: usb 1-4.1: SerialNumber: 000000002402
jan 09 02:03:52 localhost kernel: SCSI subsystem initialized
jan 09 02:03:52 localhost kernel: usb-storage 1-4.1:1.0: USB Mass Storage device detected
jan 09 02:03:52 localhost kernel: scsi host0: usb-storage 1-4.1:1.0
jan 09 02:03:52 localhost kernel: usbcore: registered new interface driver usb-storage
jan 09 02:03:52 localhost kernel: usb 1-3.4: new full-speed USB device number 8 using xhci_hcd
jan 09 02:03:52 localhost kernel: usb 1-3.4: New USB device found, idVendor=3434, idProduct=0320, bcdDevice= 1.02
jan 09 02:03:52 localhost kernel: usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:52 localhost kernel: usb 1-3.4: Product: Keychron V2
jan 09 02:03:52 localhost kernel: usb 1-3.4: Manufacturer: Keychron
jan 09 02:03:52 localhost kernel: hid: raw HID events driver (C) Jiri Kosina
jan 09 02:03:52 localhost kernel: usbcore: registered new interface driver usbhid
jan 09 02:03:52 localhost kernel: usbhid: USB HID core driver
jan 09 02:03:52 localhost kernel: input: Keychron Keychron V2 as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/0003:3434:0320.0001/input/input2
jan 09 02:03:52 localhost kernel: hid-generic 0003:3434:0320.0001: input,hidraw0: USB HID v1.11 Keyboard [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input0
jan 09 02:03:52 localhost kernel: hid-generic 0003:3434:0320.0002: hiddev96,hidraw1: USB HID v1.11 Device [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input1
jan 09 02:03:52 localhost kernel: input: Keychron Keychron V2 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input3
jan 09 02:03:52 localhost kernel: input: Keychron Keychron V2 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input4
jan 09 02:03:52 localhost kernel: usb 1-3.2.2: new high-speed USB device number 9 using xhci_hcd
jan 09 02:03:52 localhost kernel: input: Keychron Keychron V2 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input5
jan 09 02:03:52 localhost kernel: input: Keychron Keychron V2 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input6
jan 09 02:03:52 localhost kernel: hid-generic 0003:3434:0320.0003: input,hidraw2: USB HID v1.11 Mouse [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input2
jan 09 02:03:52 localhost kernel: usb 1-3.2.2: New USB device found, idVendor=0bda, idProduct=5409, bcdDevice= 1.36
jan 09 02:03:52 localhost kernel: usb 1-3.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:52 localhost kernel: usb 1-3.2.2: Product: 3-Port USB 2.1 Hub
jan 09 02:03:52 localhost kernel: usb 1-3.2.2: Manufacturer: Generic
jan 09 02:03:52 localhost kernel: hub 1-3.2.2:1.0: USB hub found
jan 09 02:03:52 localhost kernel: hub 1-3.2.2:1.0: 3 ports detected
jan 09 02:03:52 localhost kernel: usb 1-6: new full-speed USB device number 10 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 1-6: New USB device found, idVendor=27c6, idProduct=6584, bcdDevice= 1.00
jan 09 02:03:53 localhost kernel: usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 09 02:03:53 localhost kernel: usb 1-6: Product: Goodix USB2.0 MISC
jan 09 02:03:53 localhost kernel: usb 1-6: Manufacturer: Goodix Technology Co., Ltd.
jan 09 02:03:53 localhost kernel: usb 1-6: SerialNumber: UIDDC8A8C35_XXXX_MOC_B0
jan 09 02:03:53 localhost kernel: usb 2-1.3: new SuperSpeed USB device number 5 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 2-1.3: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 09 02:03:53 localhost kernel: usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 09 02:03:53 localhost kernel: usb 2-1.3: Product: Dell D3100 USB3.0 Dock
jan 09 02:03:53 localhost kernel: usb 2-1.3: Manufacturer: DisplayLink
jan 09 02:03:53 localhost kernel: usb 2-1.3: SerialNumber: 2209282137
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: new SuperSpeed USB device number 6 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: New USB device found, idVendor=1058, idProduct=10a2, bcdDevice=10.33
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: Product: Elements 10A2
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: Manufacturer: Western Digital
jan 09 02:03:53 localhost kernel: usb 2-1.2.1: SerialNumber: 57585131453832484C525938
jan 09 02:03:53 localhost kernel: usb-storage 2-1.2.1:1.0: USB Mass Storage device detected
jan 09 02:03:53 localhost kernel: scsi host1: usb-storage 2-1.2.1:1.0
jan 09 02:03:53 localhost kernel: usb 1-3.2.4: new low-speed USB device number 11 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 1-3.2.4: New USB device found, idVendor=047d, idProduct=2048, bcdDevice= 1.20
jan 09 02:03:53 localhost kernel: usb 1-3.2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 09 02:03:53 localhost kernel: usb 1-3.2.4: Product: Kensington Eagle Trackball
jan 09 02:03:53 localhost kernel: input: Kensington Eagle Trackball as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.2/1-3.2.4/1-3.2.4:1.0/0003:047D:2048.0004/input/input7
jan 09 02:03:53 localhost kernel: hid-generic 0003:047D:2048.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Eagle Trackball] on usb-0000:00:14.0-3.2.4/input0
jan 09 02:03:53 localhost kernel: scsi 0:0:0:0: Direct-Access     Generic  MassStorageClass 2402 PQ: 0 ANSI: 6
jan 09 02:03:53 localhost kernel: sd 0:0:0:0: [sda] Media removed, stopped polling
jan 09 02:03:53 localhost kernel: sd 0:0:0:0: [sda] Attached SCSI removable disk
jan 09 02:03:53 localhost kernel: usb 1-3.2.2.1: new high-speed USB device number 12 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 1-3.2.2.1: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.21
jan 09 02:03:53 localhost kernel: usb 1-3.2.2.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 09 02:03:53 localhost kernel: usb 1-3.2.2.1: Product: C270 HD WEBCAM
jan 09 02:03:53 localhost kernel: usb 1-3.2.2.1: SerialNumber: 200901010001
jan 09 02:03:53 localhost kernel: usb 1-10: new full-speed USB device number 13 using xhci_hcd
jan 09 02:03:53 localhost kernel: usb 1-10: New USB device found, idVendor=8087, idProduct=0032, bcdDevice= 0.00
jan 09 02:03:53 localhost kernel: usb 1-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
jan 09 02:03:54 localhost kernel: usb 2-1.2.2: new SuperSpeed USB device number 7 using xhci_hcd
jan 09 02:03:54 localhost kernel: usb 2-1.2.2: New USB device found, idVendor=0bda, idProduct=0409, bcdDevice= 1.36
jan 09 02:03:54 localhost kernel: usb 2-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:54 localhost kernel: usb 2-1.2.2: Product: 2-Port USB 3.1 Hub
jan 09 02:03:54 localhost kernel: usb 2-1.2.2: Manufacturer: Generic
jan 09 02:03:54 localhost kernel: hub 2-1.2.2:1.0: USB hub found
jan 09 02:03:54 localhost kernel: hub 2-1.2.2:1.0: 2 ports detected
jan 09 02:03:54 localhost kernel: usb 1-3.2.2.3: new high-speed USB device number 14 using xhci_hcd
jan 09 02:03:54 localhost kernel: usb 1-3.2.2.3: New USB device found, idVendor=0bda, idProduct=1100, bcdDevice= 1.01
jan 09 02:03:54 localhost kernel: usb 1-3.2.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 09 02:03:54 localhost kernel: usb 1-3.2.2.3: Product: Hub Controller
jan 09 02:03:54 localhost kernel: usb 1-3.2.2.3: Manufacturer: Realtek
jan 09 02:03:54 localhost kernel: hid-generic 0003:0BDA:1100.0005: hiddev97,hidraw4: USB HID v1.11 Device [Realtek Hub Controller] on usb-0000:00:14.0-3.2.2.3/input0
jan 09 02:03:54 localhost kernel: scsi 1:0:0:0: Direct-Access     WD       Elements 10A2    1033 PQ: 0 ANSI: 6
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] 1953458176 512-byte logical blocks: (1.00 TB/931 GiB)
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] Write Protect is off
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] Mode Sense: 53 00 10 08
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] No Caching mode page found
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] Assuming drive cache: write through
jan 09 02:03:54 localhost kernel:  sdb: sdb2
jan 09 02:03:54 localhost kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
jan 09 02:03:54 localhost kernel: BTRFS: device label wd_digital devid 1 transid 764 /dev/sdb2 scanned by (udev-worker) (191)
jan 09 02:04:00 localhost kernel: Key type trusted registered
jan 09 02:04:00 localhost kernel: Key type encrypted registered
jan 09 02:04:00 localhost kernel: BTRFS: device label nixos devid 1 transid 357754 /dev/dm-2 scanned by (udev-worker) (312)
jan 09 02:04:00 localhost kernel: BTRFS info (device dm-2): first mount of filesystem f02feaa7-3d81-4624-8650-0839b5d11da4
jan 09 02:04:00 localhost kernel: BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algorithm
jan 09 02:04:00 localhost kernel: BTRFS info (device dm-2): use zstd compression, level 1
jan 09 02:04:00 localhost kernel: BTRFS info (device dm-2): enabling auto defrag
jan 09 02:04:00 localhost kernel: BTRFS info (device dm-2): using free space tree
jan 09 02:04:01 localhost kernel: BTRFS info (device dm-2): enabling ssd optimizations
jan 09 02:04:02 starbook systemd-journald[173]: Received SIGTERM from PID 1 (systemd).
jan 09 02:04:02 starbook systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 09 02:04:02 starbook systemd[1]: Detected architecture x86-64.
jan 09 02:04:02 starbook systemd[1]: Hostname set to <starbook>.
jan 09 02:04:02 starbook systemd[1]: bpf-lsm: LSM BPF program attached
jan 09 02:04:02 starbook kernel: zram: Added device: zram0
jan 09 02:04:02 starbook systemd[1]: initrd-switch-root.service: Deactivated successfully.
jan 09 02:04:02 starbook systemd[1]: Stopped initrd-switch-root.service.
jan 09 02:04:02 starbook systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
jan 09 02:04:02 starbook systemd[1]: Created slice Virtual Machine and Container Slice.
jan 09 02:04:02 starbook systemd[1]: Created slice Slice /system/getty.
jan 09 02:04:02 starbook systemd[1]: Created slice Slice /system/modprobe.
jan 09 02:04:02 starbook systemd[1]: Created slice Slice /system/systemd-zram-setup.
jan 09 02:04:02 starbook systemd[1]: Created slice User and Session Slice.
jan 09 02:04:02 starbook systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 09 02:04:02 starbook systemd[1]: Started Forward Password Requests to Wall Directory Watch.
jan 09 02:04:02 starbook systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
jan 09 02:04:02 starbook systemd[1]: Reached target Local Encrypted Volumes.
jan 09 02:04:02 starbook systemd[1]: Stopped target initrd-fs.target.
jan 09 02:04:02 starbook systemd[1]: Stopped target initrd-root-fs.target.
jan 09 02:04:02 starbook systemd[1]: Stopped target initrd-switch-root.target.
jan 09 02:04:02 starbook systemd[1]: Reached target Containers.
jan 09 02:04:02 starbook systemd[1]: Reached target Path Units.
jan 09 02:04:02 starbook systemd[1]: Reached target Remote File Systems.
jan 09 02:04:02 starbook systemd[1]: Reached target Slice Units.
jan 09 02:04:02 starbook systemd[1]: Listening on Process Core Dump Socket.
jan 09 02:04:02 starbook systemd[1]: Listening on Network Service Netlink Socket.
jan 09 02:04:02 starbook systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Killer Socket.
jan 09 02:04:02 starbook systemd[1]: Listening on udev Control Socket.
jan 09 02:04:02 starbook systemd[1]: Listening on udev Kernel Socket.
jan 09 02:04:02 starbook systemd[1]: Activating swap /dev/volgroup/swap...
jan 09 02:04:02 starbook systemd[1]: Mounting Huge Pages File System...
jan 09 02:04:02 starbook systemd[1]: Mounting POSIX Message Queue File System...
jan 09 02:04:02 starbook systemd[1]: Mounting Kernel Debug File System...
jan 09 02:04:02 starbook systemd[1]: Starting Create List of Static Device Nodes...
jan 09 02:04:02 starbook systemd[1]: Starting Load Kernel Module configfs...
jan 09 02:04:02 starbook kernel: Adding 15728636k swap on /dev/mapper/volgroup-swap.  Priority:-2 extents:1 across:15728636k SS
jan 09 02:04:02 starbook systemd[1]: Starting Load Kernel Module drm...
jan 09 02:04:02 starbook systemd[1]: Starting Load Kernel Module efi_pstore...
jan 09 02:04:02 starbook systemd[1]: Starting Load Kernel Module fuse...
jan 09 02:04:02 starbook systemd[1]: Starting mount-pstore.service...
jan 09 02:04:02 starbook kernel: pstore: Using crash dump compression: deflate
jan 09 02:04:02 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/gh/hosts.yml' to '/home/ramses/.config/gh/hosts.yml'...
jan 09 02:04:02 starbook kernel: pstore: Registered efi_pstore as persistent store backend
jan 09 02:04:02 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/htop/htoprc' to '/home/ramses/.config/htop/htoprc'...
jan 09 02:04:02 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/monitors.xml' to '/home/ramses/.config/monitors.xml'...
jan 09 02:04:02 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.bash_history' to '/home/ramses/.bash_history'...
jan 09 02:04:02 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.python_history' to '/home/ramses/.python_history'...
jan 09 02:04:02 starbook systemd[1]: Starting Create SUID/SGID Wrappers...
jan 09 02:04:02 starbook kernel: fuse: init (API version 7.39)
jan 09 02:04:02 starbook systemd[1]: systemd-cryptsetup@decrypted.service: Deactivated successfully.
jan 09 02:04:02 starbook systemd[1]: Stopped systemd-cryptsetup@decrypted.service.
jan 09 02:04:02 starbook systemd[1]: Starting Journal Service...
jan 09 02:04:02 starbook systemd[1]: Starting Load Kernel Modules...
jan 09 02:04:02 starbook systemd[1]: Starting Remount Root and Kernel File Systems...
jan 09 02:04:02 starbook systemd[1]: Starting Coldplug All udev Devices...
jan 09 02:04:02 starbook systemd-journald[818]: Collecting audit messages is disabled.
jan 09 02:04:02 starbook systemd[1]: Activated swap /dev/volgroup/swap.
jan 09 02:04:02 starbook systemd[1]: Mounted Huge Pages File System.
jan 09 02:04:02 starbook systemd[1]: Started Journal Service.
jan 09 02:04:02 starbook kernel: ACPI: bus type drm_connector registered
jan 09 02:04:02 starbook kernel: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
jan 09 02:04:02 starbook kernel: tun: Universal TUN/TAP device driver, 1.6
jan 09 02:04:02 starbook kernel: loop: module loaded
jan 09 02:04:02 starbook systemd-journald[818]: Received client request to flush runtime journal.
jan 09 02:04:02 starbook systemd-journald[818]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/system.journal: Journal file uses a different sequence number ID, rotating.
jan 09 02:04:02 starbook systemd-journald[818]: Rotating system journal.
jan 09 02:04:02 starbook kernel: BTRFS info: devid 1 device path /dev/mapper/volgroup-nixos changed to /dev/dm-2 scanned by (udev-worker) (986)
jan 09 02:04:02 starbook kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/PNP0C09:00/PNP0C0D:00/input/input8
jan 09 02:04:02 starbook kernel: ACPI: button: Lid Switch [LID0]
jan 09 02:04:02 starbook kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input10
jan 09 02:04:02 starbook kernel: EDAC MC: Ver: 3.0.0
jan 09 02:04:02 starbook kernel: input: Intel HID events as /devices/platform/INTC1051:00/input/input9
jan 09 02:04:02 starbook kernel: ACPI: button: Power Button [PWRF]
jan 09 02:04:02 starbook kernel: intel_pmc_core INT33A1:00:  initialized
jan 09 02:04:02 starbook kernel: EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
jan 09 02:04:02 starbook kernel: zram0: detected capacity change from 0 to 52348520
jan 09 02:04:02 starbook kernel: EDAC MC1: Giving out device to module igen6_edac controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
jan 09 02:04:02 starbook kernel: EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
jan 09 02:04:02 starbook kernel: EDAC igen6 MC1: ADDR 0x7fffffffe0 
jan 09 02:04:02 starbook kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 09 02:04:02 starbook kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0 
jan 09 02:04:02 starbook kernel: EDAC igen6: v2.5.1
jan 09 02:04:02 starbook kernel: Linux agpgart interface v0.103
jan 09 02:04:02 starbook kernel: ACPI: AC: AC Adapter [ADP1] (on-line)
jan 09 02:04:02 starbook kernel: ACPI: battery: Slot [BAT0] (battery present)
jan 09 02:04:02 starbook kernel: mc: Linux media interface: v0.10
jan 09 02:04:02 starbook kernel: i801_smbus 0000:00:1f.4: SPD Write Disable is set
jan 09 02:04:02 starbook kernel: i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
jan 09 02:04:02 starbook kernel: i2c i2c-0: 2/2 memory slots populated (from DMI)
jan 09 02:04:02 starbook kernel: i2c i2c-0: Successfully instantiated SPD at 0x50
jan 09 02:04:02 starbook kernel: idma64 idma64.0: Found Intel integrated DMA 64-bit
jan 09 02:04:02 starbook kernel: usbcore: registered new interface driver uas
jan 09 02:04:02 starbook kernel: idma64 idma64.1: Found Intel integrated DMA 64-bit
jan 09 02:04:02 starbook kernel: Bluetooth: Core ver 2.22
jan 09 02:04:02 starbook kernel: NET: Registered PF_BLUETOOTH protocol family
jan 09 02:04:02 starbook kernel: Bluetooth: HCI device and connection manager initialized
jan 09 02:04:02 starbook kernel: Bluetooth: HCI socket layer initialized
jan 09 02:04:02 starbook kernel: Bluetooth: L2CAP socket layer initialized
jan 09 02:04:02 starbook kernel: Bluetooth: SCO socket layer initialized
jan 09 02:04:02 starbook kernel: mousedev: PS/2 mouse device common for all mice
jan 09 02:04:02 starbook kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
jan 09 02:04:02 starbook kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
jan 09 02:04:02 starbook kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
jan 09 02:04:02 starbook kernel: ee1004 0-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
jan 09 02:04:03 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input12
jan 09 02:04:03 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input13
jan 09 02:04:03 starbook kernel: hid-generic 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 09 02:04:03 starbook kernel: iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
jan 09 02:04:03 starbook kernel: spi-nor spi0.0: w25q256 (32768 Kbytes)
jan 09 02:04:03 starbook kernel: iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver cdc_ether
jan 09 02:04:03 starbook kernel: videodev: Linux video capture interface: v2.00
jan 09 02:04:03 starbook kernel: RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
jan 09 02:04:03 starbook kernel: RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
jan 09 02:04:03 starbook kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
jan 09 02:04:03 starbook kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
jan 09 02:04:03 starbook kernel: RAPL PMU: hw unit of domain psys 2^-14 Joules
jan 09 02:04:03 starbook kernel: dw-apb-uart.1: ttyS0 at MMIO 0xfe03e000 (irq = 23, base_baud = 114825) is a 16550A
jan 09 02:04:03 starbook kernel: Creating 1 MTD partitions on "0000:00:1f.5":
jan 09 02:04:03 starbook kernel: 0x000000000000-0x000002000000 : "BIOS"
jan 09 02:04:03 starbook kernel: Intel(R) Wireless WiFi driver for Linux
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver btusb
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware timestamp 2023.42 buildtype 1 build 73111
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: No support for _PRR ACPI method
jan 09 02:04:03 starbook kernel: usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:636b)
jan 09 02:04:03 starbook kernel: input: USB 2.0 Camera: USB Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input14
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Boot Address: 0x100800
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware Version: 151-42.23
jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware already loaded
jan 09 02:04:03 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=511), cval->res is probably wrong.
jan 09 02:04:03 starbook kernel: usb 2-1.3: [15] FU [Dell USB Audio Playback Volume] ch = 6, val = -8176/0/16
jan 09 02:04:03 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=767), cval->res is probably wrong.
jan 09 02:04:03 starbook kernel: usb 2-1.3: [12] FU [Mic Capture Volume] ch = 2, val = -4592/7680/16
jan 09 02:04:03 starbook kernel: Adding 26174256k swap on /dev/zram0.  Priority:5 extents:1 across:26174256k SSDsc
jan 09 02:04:03 starbook kernel: usb 1-3.2.2.1: current rate 16000 is different from the runtime rate 32000
jan 09 02:04:03 starbook kernel: usb 1-3.2.2.1: current rate 24000 is different from the runtime rate 16000
jan 09 02:04:03 starbook kernel: usb 1-3.2.2.1: 3:3: cannot set freq 24000 to ep 0x82
jan 09 02:04:03 starbook kernel: cdc_ncm 2-1.3:1.5: MAC-Address: 0c:37:96:96:28:5d
jan 09 02:04:03 starbook kernel: cdc_ncm 2-1.3:1.5: setting rx_max = 16384
jan 09 02:04:03 starbook kernel: cdc_ncm 2-1.3:1.5: setting tx_max = 16384
jan 09 02:04:03 starbook kernel: cdc_ncm 2-1.3:1.5 eth0: register 'cdc_ncm' at usb-0000:00:14.0-1.3, CDC NCM (SEND ZLP), 0c:37:96:96:28:5d
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver cdc_ncm
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
jan 09 02:04:03 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input15
jan 09 02:04:03 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-STAR0001:00/0018:093A:0255.0006/input/input16
jan 09 02:04:03 starbook kernel: hid-multitouch 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver cdc_wdm
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver cdc_mbim
jan 09 02:04:03 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
jan 09 02:04:03 starbook kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
jan 09 02:04:03 starbook kernel: PTP clock support registered
jan 09 02:04:03 starbook kernel: cdc_ncm 2-1.3:1.5 enp0s20f0u1u3i5: renamed from eth0
jan 09 02:04:03 starbook kernel: usb 1-3.2.2.1: set resolution quirk: cval->res = 384
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver snd-usb-audio
jan 09 02:04:03 starbook kernel: usb 1-3.2.2.1: Found UVC 1.00 device C270 HD WEBCAM (046d:0825)
jan 09 02:04:03 starbook kernel: usbcore: registered new interface driver uvcvideo
jan 09 02:04:03 starbook kernel: Setting dangerous option enable_fbc - tainting kernel
jan 09 02:04:03 starbook kernel: Setting dangerous option enable_psr - tainting kernel
jan 09 02:04:03 starbook kernel: Console: switching to colour dummy device 80x25
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: vgaarb: deactivate vga console
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] Using Transparent Hugepages
jan 09 02:04:03 starbook kernel: intel_tcc_cooling: Programmable TCC Offset detected
jan 09 02:04:03 starbook kernel: intel_rapl_msr: PL4 support detected.
jan 09 02:04:03 starbook kernel: intel_rapl_common: Found RAPL domain package
jan 09 02:04:03 starbook kernel: intel_rapl_common: Found RAPL domain core
jan 09 02:04:03 starbook kernel: intel_rapl_common: Found RAPL domain uncore
jan 09 02:04:03 starbook kernel: intel_rapl_common: Found RAPL domain psys
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
jan 09 02:04:03 starbook kernel: thermal thermal_zone1: failed to read out thermal zone (-61)
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adlp_dmc.bin (v2.20)
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.13.1
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: loaded PNVM version e28bb9d7
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: Detected RF GF, rfid=0x10d000
jan 09 02:04:03 starbook kernel: [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
jan 09 02:04:03 starbook kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
jan 09 02:04:03 starbook kernel: fbcon: i915drmfb (fb0) is primary device
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0: base HW address: 7c:b5:66:65:be:72
jan 09 02:04:03 starbook kernel: iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
jan 09 02:04:03 starbook kernel: Console: switching to colour frame buffer device 240x67
jan 09 02:04:03 starbook kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
jan 09 02:04:03 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
jan 09 02:04:04 starbook kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
jan 09 02:04:04 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input24
jan 09 02:04:04 starbook systemd-journald[818]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/user-1000.journal: Journal file uses a different sequence number ID, rotating.
jan 09 02:04:04 starbook kernel: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
jan 09 02:04:04 starbook kernel: Bluetooth: BNEP socket layer initialized
jan 09 02:04:04 starbook kernel: Bluetooth: MGMT ver 1.22
jan 09 02:04:04 starbook kernel: NET: Registered PF_ALG protocol family
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 09 02:04:04 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 09 02:04:04 starbook kernel: NET: Registered PF_PACKET protocol family
jan 09 02:04:05 starbook kernel: .gnome-session-[1782]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
jan 09 02:04:07 starbook kernel: usb 1-3.2.2.1: reset high-speed USB device number 12 using xhci_hcd
jan 09 02:04:07 starbook kernel: NET: Registered PF_QIPCRTR protocol family
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM TTY layer initialized
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM socket layer initialized
jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM ver 1.11
jan 09 02:04:08 starbook kernel: wlp1s0: authenticate with 30:67:a1:14:f9:c7
jan 09 02:04:08 starbook kernel: wlp1s0: send auth to 30:67:a1:14:f9:c7 (try 1/3)
jan 09 02:04:08 starbook kernel: wlp1s0: authenticated
jan 09 02:04:08 starbook kernel: wlp1s0: associate with 30:67:a1:14:f9:c7 (try 1/3)
jan 09 02:04:08 starbook kernel: wlp1s0: RX AssocResp from 30:67:a1:14:f9:c7 (capab=0x1011 status=0 aid=9)
jan 09 02:04:08 starbook kernel: wlp1s0: associated
jan 09 02:04:08 starbook kernel: wlp1s0: Limiting TX power to 30 (30 - 0) dBm as advertised by 30:67:a1:14:f9:c7
jan 09 02:08:16 starbook kernel: input: Keychron Keychron V2 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0007/input/input25
jan 09 02:08:16 starbook kernel: input: Keychron Keychron V2 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0007/input/input26
jan 09 02:08:16 starbook kernel: input: Keychron Keychron V2 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0007/input/input27
jan 09 02:08:16 starbook kernel: input: Keychron Keychron V2 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0007/input/input28
jan 09 02:08:16 starbook kernel: hid-generic 0003:3434:0320.0007: input,hidraw0: USB HID v1.11 Mouse [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input2
jan 09 02:08:16 starbook kernel: hid-generic 0003:3434:0320.0008: hiddev96,hidraw1: USB HID v1.11 Device [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input1
jan 09 02:08:16 starbook kernel: input: Keychron Keychron V2 as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/0003:3434:0320.0009/input/input29
jan 09 02:08:16 starbook kernel: hid-generic 0003:3434:0320.0009: input,hidraw2: USB HID v1.11 Keyboard [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input0
jan 09 02:08:16 starbook kernel: input: Kensington Eagle Trackball as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.2/1-3.2.4/1-3.2.4:1.0/0003:047D:2048.000A/input/input30
jan 09 02:08:16 starbook kernel: hid-generic 0003:047D:2048.000A: input,hidraw3: USB HID v1.11 Mouse [Kensington Eagle Trackball] on usb-0000:00:14.0-3.2.4/input0
jan 09 02:08:16 starbook kernel: hid-generic 0003:0BDA:1100.000B: hiddev97,hidraw4: USB HID v1.11 Device [Realtek Hub Controller] on usb-0000:00:14.0-3.2.2.3/input0
jan 09 02:15:31 starbook kernel: warning: `.gnome-shell-wr' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
jan 09 02:16:37 starbook kernel: wlp1s0: deauthenticating from 30:67:a1:14:f9:c7 by local choice (Reason: 3=DEAUTH_LEAVING)
jan 09 02:16:38 starbook kernel: PM: suspend entry (deep)
jan 09 02:16:38 starbook kernel: Filesystems sync: 0.010 seconds
jan 09 09:20:03 starbook kernel: Freezing user space processes
jan 09 09:20:03 starbook kernel: Freezing user space processes completed (elapsed 0.001 seconds)
jan 09 09:20:03 starbook kernel: OOM killer disabled.
jan 09 09:20:03 starbook kernel: Freezing remaining freezable tasks
jan 09 09:20:03 starbook kernel: Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
jan 09 09:20:03 starbook kernel: printk: Suspending console(s) (use no_console_suspend to debug)
jan 09 09:20:03 starbook kernel: ACPI: EC: interrupt blocked
jan 09 09:20:03 starbook kernel: ACPI: PM: Preparing to enter system sleep state S3
jan 09 09:20:03 starbook kernel: ACPI: EC: event blocked
jan 09 09:20:03 starbook kernel: ACPI: EC: EC stopped
jan 09 09:20:03 starbook kernel: ACPI: PM: Saving platform NVS memory
jan 09 09:20:03 starbook kernel: Disabling non-boot CPUs ...
jan 09 09:20:03 starbook kernel: smpboot: CPU 1 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 2 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 3 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 4 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 5 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 6 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 7 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 8 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 9 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 10 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 11 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 12 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 13 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 14 is now offline
jan 09 09:20:03 starbook kernel: smpboot: CPU 15 is now offline
jan 09 09:20:03 starbook kernel: ACPI: PM: Low-level resume complete
jan 09 09:20:03 starbook kernel: ACPI: EC: EC started
jan 09 09:20:03 starbook kernel: ACPI: PM: Restoring platform NVS memory
jan 09 09:20:03 starbook kernel: Enabling non-boot CPUs ...
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 1 APIC 0x1
jan 09 09:20:03 starbook kernel: CPU1 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 2 APIC 0x8
jan 09 09:20:03 starbook kernel: CPU2 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 3 APIC 0x9
jan 09 09:20:03 starbook kernel: CPU3 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 4 APIC 0x10
jan 09 09:20:03 starbook kernel: CPU4 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 5 APIC 0x11
jan 09 09:20:03 starbook kernel: CPU5 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 6 APIC 0x18
jan 09 09:20:03 starbook kernel: CPU6 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 7 APIC 0x19
jan 09 09:20:03 starbook kernel: CPU7 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 8 APIC 0x20
jan 09 09:20:03 starbook kernel: core: cpu_atom PMU driver: PEBS-via-PT 
jan 09 09:20:03 starbook kernel: ... version:                5
jan 09 09:20:03 starbook kernel: ... bit width:              48
jan 09 09:20:03 starbook kernel: ... generic registers:      6
jan 09 09:20:03 starbook kernel: ... value mask:             0000ffffffffffff
jan 09 09:20:03 starbook kernel: ... max period:             00007fffffffffff
jan 09 09:20:03 starbook kernel: ... fixed-purpose events:   3
jan 09 09:20:03 starbook kernel: ... event mask:             000000070000003f
jan 09 09:20:03 starbook kernel: CPU8 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 9 APIC 0x22
jan 09 09:20:03 starbook kernel: CPU9 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 10 APIC 0x24
jan 09 09:20:03 starbook kernel: CPU10 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 11 APIC 0x26
jan 09 09:20:03 starbook kernel: CPU11 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 12 APIC 0x28
jan 09 09:20:03 starbook kernel: CPU12 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 13 APIC 0x2a
jan 09 09:20:03 starbook kernel: CPU13 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 14 APIC 0x2c
jan 09 09:20:03 starbook kernel: CPU14 is up
jan 09 09:20:03 starbook kernel: smpboot: Booting Node 0 Processor 15 APIC 0x2e
jan 09 09:20:03 starbook kernel: CPU15 is up
jan 09 09:20:03 starbook kernel: ACPI: PM: Waking up from system sleep state S3
jan 09 09:20:03 starbook kernel: ACPI: EC: interrupt unblocked
jan 09 09:20:03 starbook kernel: ACPI: EC: event unblocked
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.13.1
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
jan 09 09:20:03 starbook kernel: nvme nvme0: Shutdown timeout set to 10 seconds
jan 09 09:20:03 starbook kernel: nvme nvme0: 16/0/0 default/read/poll queues
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
jan 09 09:20:03 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 09 09:20:03 starbook kernel: usb 1-5: reset high-speed USB device number 6 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.4: reset full-speed USB device number 8 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.2: reset high-speed USB device number 5 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.2.2: reset high-speed USB device number 9 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.2.4: reset low-speed USB device number 11 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.2.2.1: reset high-speed USB device number 12 using xhci_hcd
jan 09 09:20:03 starbook kernel: usb 1-3.2.2.3: reset high-speed USB device number 14 using xhci_hcd
jan 09 09:20:03 starbook kernel: OOM killer enabled.
jan 09 09:20:03 starbook kernel: Restarting tasks ... done.
jan 09 09:20:03 starbook kernel: random: crng reseeded on system resumption
jan 09 09:20:03 starbook kernel: PM: suspend exit
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 09 09:20:03 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 09 09:20:07 starbook kernel: wlp1s0: authenticate with 30:67:a1:14:f9:c7
jan 09 09:20:07 starbook kernel: wlp1s0: send auth to 30:67:a1:14:f9:c7 (try 1/3)
jan 09 09:20:07 starbook kernel: wlp1s0: authenticated
jan 09 09:20:07 starbook kernel: wlp1s0: associate with 30:67:a1:14:f9:c7 (try 1/3)
jan 09 09:20:07 starbook kernel: wlp1s0: RX AssocResp from 30:67:a1:14:f9:c7 (capab=0x1011 status=0 aid=11)
jan 09 09:20:07 starbook kernel: wlp1s0: associated
jan 09 09:20:07 starbook kernel: wlp1s0: Limiting TX power to 30 (30 - 0) dBm as advertised by 30:67:a1:14:f9:c7
jan 09 09:22:05 starbook kernel: traps: .gnome-shell-wr[6522] general protection fault ip:7fb813f20a2b sp:7fb7d3ffe180 error:0 in libglib-2.0.so.0.7800.1[7fb813ee9000+97000]
jan 09 09:22:06 starbook kernel: wlp1s0: deauthenticating from 30:67:a1:14:f9:c7 by local choice (Reason: 3=DEAUTH_LEAVING)

------=_Part_3365_998781800.1705154759365
Content-Type: text/plain; charset=us-ascii; 
	name=dmesg_6_6_9_no_bluetooth.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg_6_6_9_no_bluetooth.txt

jan 11 10:18:08 localhost kernel: Linux version 6.6.9 (nixbld@localhost) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAMIC Mon Jan  1 12:42:47 UTC 2024
jan 11 10:18:08 localhost kernel: Command line: initrd=\efi\nixos\6mc1kw8bwhl09lszcr09z8sjpd5mz94z-initrd-linux-6.6.9-initrd.efi init=/nix/store/ii0n3yl3qpjylwc1r3qifn77cr6gfr7w-nixos-system-starbook-20240102.bd645e8.20240111.a0207ce/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 11 10:18:08 localhost kernel: x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
jan 11 10:18:08 localhost kernel: BIOS-provided physical RAM map:
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000000100000-0x0000000076733fff] usable
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000076734000-0x0000000076933fff] reserved
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000076934000-0x0000000076940fff] usable
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000076941000-0x0000000076958fff] ACPI data
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000076959000-0x0000000076959fff] usable
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x000000007695a000-0x00000000803fffff] reserved
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x00000000ff030000-0x00000000ff06ffff] reserved
jan 11 10:18:08 localhost kernel: BIOS-e820: [mem 0x0000000100000000-0x000000087fbfffff] usable
jan 11 10:18:08 localhost kernel: NX (Execute Disable) protection: active
jan 11 10:18:08 localhost kernel: APIC: Static calls initialized
jan 11 10:18:08 localhost kernel: efi: EFI v2.7 by EDK II
jan 11 10:18:08 localhost kernel: efi: SMBIOS=0x7691b000 SMBIOS 3.0=0x76919000 ACPI=0x76958000 ACPI 2.0=0x76958014 MEMATTR=0x73c95298 INITRD=0x736aae98 
jan 11 10:18:08 localhost kernel: efi: Remove mem99: MMIO range=[0xff030000-0xff06ffff] (0MB) from e820 map
jan 11 10:18:08 localhost kernel: e820: remove [mem 0xff030000-0xff06ffff] reserved
jan 11 10:18:08 localhost kernel: SMBIOS 3.0.0 present.
jan 11 10:18:08 localhost kernel: DMI: Star Labs StarBook/StarBook, BIOS 9.00 12/07/2023
jan 11 10:18:08 localhost kernel: tsc: Detected 2500.000 MHz processor
jan 11 10:18:08 localhost kernel: tsc: Detected 2496.000 MHz TSC
jan 11 10:18:08 localhost kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
jan 11 10:18:08 localhost kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
jan 11 10:18:08 localhost kernel: last_pfn = 0x87fc00 max_arch_pfn = 0x400000000
jan 11 10:18:08 localhost kernel: MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
jan 11 10:18:08 localhost kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
jan 11 10:18:08 localhost kernel: last_pfn = 0x7695a max_arch_pfn = 0x400000000
jan 11 10:18:08 localhost kernel: Using GB pages for direct mapping
jan 11 10:18:08 localhost kernel: Incomplete global flushes, disabling PCID
jan 11 10:18:08 localhost kernel: Secure boot disabled
jan 11 10:18:08 localhost kernel: RAMDISK: [mem 0x70108000-0x71bd1fff]
jan 11 10:18:08 localhost kernel: ACPI: Early table checksum verification disabled
jan 11 10:18:08 localhost kernel: ACPI: RSDP 0x0000000076958014 000024 (v02 COREv4)
jan 11 10:18:08 localhost kernel: ACPI: XSDT 0x00000000769570E8 000074 (v01 COREv4 COREBOOT 00000000      01000013)
jan 11 10:18:08 localhost kernel: ACPI: FACP 0x0000000076956000 000114 (v06 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: DSDT 0x0000000076950000 005063 (v02 COREv4 COREBOOT 20220930 INTL 20230628)
jan 11 10:18:08 localhost kernel: ACPI: FACS 0x0000000076967240 000040
jan 11 10:18:08 localhost kernel: ACPI: SSDT 0x000000007694B000 0045F7 (v02 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: MCFG 0x000000007694A000 00003C (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: TPM2 0x0000000076949000 00004C (v04 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: LPIT 0x0000000076948000 000094 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: APIC 0x0000000076947000 0000D2 (v03 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: DMAR 0x0000000076946000 000088 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: DBG2 0x0000000076945000 000061 (v00 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: HPET 0x0000000076944000 000038 (v01 COREv4 COREBOOT 00000000 CORE 20230628)
jan 11 10:18:08 localhost kernel: ACPI: BGRT 0x0000000076943000 000038 (v01 INTEL  EDK2     00000002      01000013)
jan 11 10:18:08 localhost kernel: ACPI: Reserving FACP table memory at [mem 0x76956000-0x76956113]
jan 11 10:18:08 localhost kernel: ACPI: Reserving DSDT table memory at [mem 0x76950000-0x76955062]
jan 11 10:18:08 localhost kernel: ACPI: Reserving FACS table memory at [mem 0x76967240-0x7696727f]
jan 11 10:18:08 localhost kernel: ACPI: Reserving SSDT table memory at [mem 0x7694b000-0x7694f5f6]
jan 11 10:18:08 localhost kernel: ACPI: Reserving MCFG table memory at [mem 0x7694a000-0x7694a03b]
jan 11 10:18:08 localhost kernel: ACPI: Reserving TPM2 table memory at [mem 0x76949000-0x7694904b]
jan 11 10:18:08 localhost kernel: ACPI: Reserving LPIT table memory at [mem 0x76948000-0x76948093]
jan 11 10:18:08 localhost kernel: ACPI: Reserving APIC table memory at [mem 0x76947000-0x769470d1]
jan 11 10:18:08 localhost kernel: ACPI: Reserving DMAR table memory at [mem 0x76946000-0x76946087]
jan 11 10:18:08 localhost kernel: ACPI: Reserving DBG2 table memory at [mem 0x76945000-0x76945060]
jan 11 10:18:08 localhost kernel: ACPI: Reserving HPET table memory at [mem 0x76944000-0x76944037]
jan 11 10:18:08 localhost kernel: ACPI: Reserving BGRT table memory at [mem 0x76943000-0x76943037]
jan 11 10:18:08 localhost kernel: No NUMA configuration found
jan 11 10:18:08 localhost kernel: Faking a node at [mem 0x0000000000000000-0x000000087fbfffff]
jan 11 10:18:08 localhost kernel: NODE_DATA(0) allocated [mem 0x87fbfa000-0x87fbfffff]
jan 11 10:18:08 localhost kernel: Zone ranges:
jan 11 10:18:08 localhost kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
jan 11 10:18:08 localhost kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
jan 11 10:18:08 localhost kernel:   Normal   [mem 0x0000000100000000-0x000000087fbfffff]
jan 11 10:18:08 localhost kernel:   Device   empty
jan 11 10:18:08 localhost kernel: Movable zone start for each node
jan 11 10:18:08 localhost kernel: Early memory node ranges
jan 11 10:18:08 localhost kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
jan 11 10:18:08 localhost kernel:   node   0: [mem 0x0000000000100000-0x0000000076733fff]
jan 11 10:18:08 localhost kernel:   node   0: [mem 0x0000000076934000-0x0000000076940fff]
jan 11 10:18:08 localhost kernel:   node   0: [mem 0x0000000076959000-0x0000000076959fff]
jan 11 10:18:08 localhost kernel:   node   0: [mem 0x0000000100000000-0x000000087fbfffff]
jan 11 10:18:08 localhost kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000087fbfffff]
jan 11 10:18:08 localhost kernel: On node 0, zone DMA: 1 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: On node 0, zone DMA: 96 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: On node 0, zone DMA32: 512 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: On node 0, zone DMA32: 24 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: On node 0, zone Normal: 5798 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: On node 0, zone Normal: 1024 pages in unavailable ranges
jan 11 10:18:08 localhost kernel: Reserving Intel graphics memory at [mem 0x7c800000-0x803fffff]
jan 11 10:18:08 localhost kernel: ACPI: PM-Timer IO Port: 0x1808
jan 11 10:18:08 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
jan 11 10:18:08 localhost kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
jan 11 10:18:08 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
jan 11 10:18:08 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
jan 11 10:18:08 localhost kernel: ACPI: Using ACPI (MADT) for SMP configuration information
jan 11 10:18:08 localhost kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
jan 11 10:18:08 localhost kernel: e820: update [mem 0x736cf000-0x736f6fff] usable ==> reserved
jan 11 10:18:08 localhost kernel: TSC deadline timer available
jan 11 10:18:08 localhost kernel: smpboot: Allowing 16 CPUs, 0 hotplug CPUs
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x736cf000-0x736f6fff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76734000-0x76933fff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x76941000-0x76958fff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x7695a000-0x803fffff]
jan 11 10:18:08 localhost kernel: PM: hibernation: Registered nosave memory: [mem 0x80400000-0xffffffff]
jan 11 10:18:08 localhost kernel: [mem 0x80400000-0xffffffff] available for PCI devices
jan 11 10:18:08 localhost kernel: Booting paravirtualized kernel on bare hardware
jan 11 10:18:08 localhost kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
jan 11 10:18:08 localhost kernel: setup_percpu: NR_CPUS:384 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
jan 11 10:18:08 localhost kernel: percpu: Embedded 84 pages/cpu s221184 r8192 d114688 u524288
jan 11 10:18:08 localhost kernel: pcpu-alloc: s221184 r8192 d114688 u524288 alloc=1*2097152
jan 11 10:18:08 localhost kernel: pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
jan 11 10:18:08 localhost kernel: pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
jan 11 10:18:08 localhost kernel: Kernel command line: initrd=\efi\nixos\6mc1kw8bwhl09lszcr09z8sjpd5mz94z-initrd-linux-6.6.9-initrd.efi init=/nix/store/ii0n3yl3qpjylwc1r3qifn77cr6gfr7w-nixos-system-starbook-20240102.bd645e8.20240111.a0207ce/init video=DP-1:3840x2160@60 iomem=relaxed i915.enable_fbc=1 i915.enable_psr=2 mem_sleep_default=deep nvme.noacpi=1 systemd.gpt_auto=false loglevel=4
jan 11 10:18:08 localhost kernel: random: crng init done
jan 11 10:18:08 localhost kernel: Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
jan 11 10:18:08 localhost kernel: Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
jan 11 10:18:08 localhost kernel: Fallback order for Node 0: 0 
jan 11 10:18:08 localhost kernel: Built 1 zonelists, mobility grouping on.  Total pages: 8216356
jan 11 10:18:08 localhost kernel: Policy zone: Normal
jan 11 10:18:08 localhost kernel: mem auto-init: stack:all(zero), heap alloc:off, heap free:off
jan 11 10:18:08 localhost kernel: software IO TLB: area num 16.
jan 11 10:18:08 localhost kernel: Memory: 32626512K/33393540K available (14336K kernel code, 2310K rwdata, 9252K rodata, 2956K init, 2996K bss, 766772K reserved, 0K cma-reserved)
jan 11 10:18:08 localhost kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
jan 11 10:18:08 localhost kernel: ftrace: allocating 39702 entries in 156 pages
jan 11 10:18:08 localhost kernel: ftrace: allocated 156 pages with 4 groups
jan 11 10:18:08 localhost kernel: Dynamic Preempt: voluntary
jan 11 10:18:08 localhost kernel: rcu: Preemptible hierarchical RCU implementation.
jan 11 10:18:08 localhost kernel: rcu:         RCU event tracing is enabled.
jan 11 10:18:08 localhost kernel: rcu:         RCU restricting CPUs from NR_CPUS=384 to nr_cpu_ids=16.
jan 11 10:18:08 localhost kernel:         Trampoline variant of Tasks RCU enabled.
jan 11 10:18:08 localhost kernel:         Rude variant of Tasks RCU enabled.
jan 11 10:18:08 localhost kernel:         Tracing variant of Tasks RCU enabled.
jan 11 10:18:08 localhost kernel: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
jan 11 10:18:08 localhost kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
jan 11 10:18:08 localhost kernel: NR_IRQS: 24832, nr_irqs: 2184, preallocated irqs: 16
jan 11 10:18:08 localhost kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
jan 11 10:18:08 localhost kernel: spurious 8259A interrupt: IRQ7.
jan 11 10:18:08 localhost kernel: Console: colour dummy device 80x25
jan 11 10:18:08 localhost kernel: printk: console [tty0] enabled
jan 11 10:18:08 localhost kernel: ACPI: Core revision 20230628
jan 11 10:18:08 localhost kernel: hpet: HPET dysfunctional in PC10. Force disabled.
jan 11 10:18:08 localhost kernel: APIC: Switch to symmetric I/O mode setup
jan 11 10:18:08 localhost kernel: DMAR: Host address width 39
jan 11 10:18:08 localhost kernel: DMAR: DRHD base: 0x000000fed90000 flags: 0x0
jan 11 10:18:08 localhost kernel: DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
jan 11 10:18:08 localhost kernel: DMAR: DRHD base: 0x000000fed91000 flags: 0x1
jan 11 10:18:08 localhost kernel: DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
jan 11 10:18:08 localhost kernel: DMAR: RMRR base: 0x0000007c000000 end: 0x000000803fffff
jan 11 10:18:08 localhost kernel: DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
jan 11 10:18:08 localhost kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed91000
jan 11 10:18:08 localhost kernel: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
jan 11 10:18:08 localhost kernel: DMAR-IR: Enabled IRQ remapping in x2apic mode
jan 11 10:18:08 localhost kernel: x2apic enabled
jan 11 10:18:08 localhost kernel: APIC: Switched APIC routing to: cluster x2apic
jan 11 10:18:08 localhost kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 11 10:18:08 localhost kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.00 BogoMIPS (lpj=2496000)
jan 11 10:18:08 localhost kernel: CPU0: Thermal monitoring enabled (TM1)
jan 11 10:18:08 localhost kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
jan 11 10:18:08 localhost kernel: process: using mwait in idle threads
jan 11 10:18:08 localhost kernel: CET detected: Indirect Branch Tracking enabled
jan 11 10:18:08 localhost kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
jan 11 10:18:08 localhost kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
jan 11 10:18:08 localhost kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
jan 11 10:18:08 localhost kernel: Spectre V2 : Mitigation: Enhanced / Automatic IBRS
jan 11 10:18:08 localhost kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
jan 11 10:18:08 localhost kernel: Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
jan 11 10:18:08 localhost kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
jan 11 10:18:08 localhost kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
jan 11 10:18:08 localhost kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
jan 11 10:18:08 localhost kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
jan 11 10:18:08 localhost kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
jan 11 10:18:08 localhost kernel: x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
jan 11 10:18:08 localhost kernel: x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
jan 11 10:18:08 localhost kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
jan 11 10:18:08 localhost kernel: x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
jan 11 10:18:08 localhost kernel: x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
jan 11 10:18:08 localhost kernel: x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
jan 11 10:18:08 localhost kernel: Freeing SMP alternatives memory: 36K
jan 11 10:18:08 localhost kernel: pid_max: default: 32768 minimum: 301
jan 11 10:18:08 localhost kernel: LSM: initializing lsm=capability,landlock,yama,selinux,bpf,integrity
jan 11 10:18:08 localhost kernel: landlock: Up and running.
jan 11 10:18:08 localhost kernel: Yama: becoming mindful.
jan 11 10:18:08 localhost kernel: SELinux:  Initializing.
jan 11 10:18:08 localhost kernel: LSM support for eBPF active
jan 11 10:18:08 localhost kernel: Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 11 10:18:08 localhost kernel: Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
jan 11 10:18:08 localhost kernel: smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
jan 11 10:18:08 localhost kernel: RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 11 10:18:08 localhost kernel: RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 11 10:18:08 localhost kernel: RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
jan 11 10:18:08 localhost kernel: Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
jan 11 10:18:08 localhost kernel: core: cpu_core PMU driver: 
jan 11 10:18:08 localhost kernel: ... version:                5
jan 11 10:18:08 localhost kernel: ... bit width:              48
jan 11 10:18:08 localhost kernel: ... generic registers:      8
jan 11 10:18:08 localhost kernel: ... value mask:             0000ffffffffffff
jan 11 10:18:08 localhost kernel: ... max period:             00007fffffffffff
jan 11 10:18:08 localhost kernel: ... fixed-purpose events:   4
jan 11 10:18:08 localhost kernel: ... event mask:             0001000f000000ff
jan 11 10:18:08 localhost kernel: signal: max sigframe size: 3632
jan 11 10:18:08 localhost kernel: Estimated ratio of average max frequency by base frequency (times 1024): 1556
jan 11 10:18:08 localhost kernel: rcu: Hierarchical SRCU implementation.
jan 11 10:18:08 localhost kernel: rcu:         Max phase no-delay instances is 400.
jan 11 10:18:08 localhost kernel: smp: Bringing up secondary CPUs ...
jan 11 10:18:08 localhost kernel: smpboot: x86: Booting SMP configuration:
jan 11 10:18:08 localhost kernel: .... node  #0, CPUs:        #2  #4  #6  #8  #9 #10 #11 #12 #13 #14 #15
jan 11 10:18:08 localhost kernel: core: cpu_atom PMU driver: PEBS-via-PT 
jan 11 10:18:08 localhost kernel: ... version:                5
jan 11 10:18:08 localhost kernel: ... bit width:              48
jan 11 10:18:08 localhost kernel: ... generic registers:      6
jan 11 10:18:08 localhost kernel: ... value mask:             0000ffffffffffff
jan 11 10:18:08 localhost kernel: ... max period:             00007fffffffffff
jan 11 10:18:08 localhost kernel: ... fixed-purpose events:   3
jan 11 10:18:08 localhost kernel: ... event mask:             000000070000003f
jan 11 10:18:08 localhost kernel:   #1  #3  #5  #7
jan 11 10:18:08 localhost kernel: smp: Brought up 1 node, 16 CPUs
jan 11 10:18:08 localhost kernel: smpboot: Max logical packages: 1
jan 11 10:18:08 localhost kernel: smpboot: Total of 16 processors activated (79872.00 BogoMIPS)
jan 11 10:18:08 localhost kernel: devtmpfs: initialized
jan 11 10:18:08 localhost kernel: x86/mm: Memory block size: 128MB
jan 11 10:18:08 localhost kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
jan 11 10:18:08 localhost kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
jan 11 10:18:08 localhost kernel: pinctrl core: initialized pinctrl subsystem
jan 11 10:18:08 localhost kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
jan 11 10:18:08 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
jan 11 10:18:08 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
jan 11 10:18:08 localhost kernel: DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
jan 11 10:18:08 localhost kernel: audit: initializing netlink subsys (disabled)
jan 11 10:18:08 localhost kernel: audit: type=2000 audit(1704964688.017:1): state=initialized audit_enabled=0 res=1
jan 11 10:18:08 localhost kernel: thermal_sys: Registered thermal governor 'bang_bang'
jan 11 10:18:08 localhost kernel: thermal_sys: Registered thermal governor 'step_wise'
jan 11 10:18:08 localhost kernel: thermal_sys: Registered thermal governor 'user_space'
jan 11 10:18:08 localhost kernel: cpuidle: using governor menu
jan 11 10:18:08 localhost kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
jan 11 10:18:08 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 11 10:18:08 localhost kernel: PCI: not using MMCONFIG
jan 11 10:18:08 localhost kernel: PCI: Using configuration type 1 for base access
jan 11 10:18:08 localhost kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
jan 11 10:18:08 localhost kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
jan 11 10:18:08 localhost kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
jan 11 10:18:08 localhost kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
jan 11 10:18:08 localhost kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
jan 11 10:18:08 localhost kernel: ACPI: Added _OSI(Module Device)
jan 11 10:18:08 localhost kernel: ACPI: Added _OSI(Processor Device)
jan 11 10:18:08 localhost kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
jan 11 10:18:08 localhost kernel: ACPI: Added _OSI(Processor Aggregator Device)
jan 11 10:18:08 localhost kernel: ACPI: 2 ACPI AML tables successfully acquired and loaded
jan 11 10:18:08 localhost kernel: ACPI: _OSC evaluation for CPUs failed, trying _PDC
jan 11 10:18:08 localhost kernel: ACPI: EC: EC started
jan 11 10:18:08 localhost kernel: ACPI: EC: interrupt blocked
jan 11 10:18:08 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
jan 11 10:18:08 localhost kernel: ACPI: Interpreter enabled
jan 11 10:18:08 localhost kernel: ACPI: PM: (supports S0 S3 S4 S5)
jan 11 10:18:08 localhost kernel: ACPI: Using IOAPIC for interrupt routing
jan 11 10:18:08 localhost kernel: PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
jan 11 10:18:08 localhost kernel: PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved as ACPI motherboard resource
jan 11 10:18:08 localhost kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
jan 11 10:18:08 localhost kernel: PCI: Ignoring E820 reservations for host bridge windows
jan 11 10:18:08 localhost kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.RP01.RTD3: New power resource
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.RP09.RTD3: New power resource
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.TBT0: New power resource
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.TBT1: New power resource
jan 11 10:18:08 localhost kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
jan 11 10:18:08 localhost kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
jan 11 10:18:08 localhost kernel: acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
jan 11 10:18:08 localhost kernel: PCI host bridge to bus 0000:00
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x80400000-0xdfffffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [mem 0x87fc00000-0x7fffffffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: root bus resource [bus 00-ff]
jan 11 10:18:08 localhost kernel: pci 0000:00:00.0: [8086:4621] type 00 class 0x060000
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: reg 0x10: [mem 0x81000000-0x81ffffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: reg 0x18: [mem 0x90000000-0x9fffffff 64bit pref]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: reg 0x20: [io  0x1000-0x103f]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: BAR 2: assigned to efifb
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffffff 64bit] (contains BAR0 for 7 VFs)
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bit pref]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffffff 64bit pref] (contains BAR2 for 7 VFs)
jan 11 10:18:08 localhost kernel: pci 0000:00:08.0: [8086:464f] type 00 class 0x088000
jan 11 10:18:08 localhost kernel: pci 0000:00:08.0: reg 0x10: [mem 0x80720000-0x80720fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000
jan 11 10:18:08 localhost kernel: pci 0000:00:0a.0: reg 0x10: [mem 0x80710000-0x80717fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:0a.0: enabling Extended Tags
jan 11 10:18:08 localhost kernel: pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330
jan 11 10:18:08 localhost kernel: pci 0000:00:14.0: reg 0x10: [mem 0x80700000-0x8070ffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:14.0: PME# supported from D3hot D3cold
jan 11 10:18:08 localhost kernel: pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000
jan 11 10:18:08 localhost kernel: pci 0000:00:14.2: reg 0x10: [mem 0x80718000-0x8071bfff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:14.2: reg 0x18: [mem 0x80721000-0x80721fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000
jan 11 10:18:08 localhost kernel: pci 0000:00:15.0: reg 0x10: [mem 0x80722000-0x80722fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0: [8086:51bc] type 01 class 0x060400
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
jan 11 10:18:08 localhost kernel: pci 0000:00:1e.0: [8086:51a8] type 00 class 0x078000
jan 11 10:18:08 localhost kernel: pci 0000:00:1e.0: reg 0x10: [mem 0xfe03e000-0xfe03efff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1e.0: reg 0x18: [mem 0x80724000-0x80724fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040300
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.3: reg 0x10: [mem 0x8071c000-0x8071ffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.3: reg 0x20: [mem 0x80600000-0x806fffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.3: PME# supported from D3hot D3cold
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.4: reg 0x10: [mem 0x80726000-0x807260ff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000
jan 11 10:18:08 localhost kernel: pci 0000:00:1f.5: reg 0x10: [mem 0x80725000-0x80725fff]
jan 11 10:18:08 localhost kernel: pci 0000:01:00.0: [8086:2725] type 00 class 0x028000
jan 11 10:18:08 localhost kernel: pci 0000:01:00.0: reg 0x10: [mem 0x80400000-0x80403fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 11 10:18:08 localhost kernel: pci 0000:02:00.0: [144d:a80c] type 00 class 0x010802
jan 11 10:18:08 localhost kernel: pci 0000:02:00.0: reg 0x10: [mem 0x80500000-0x80503fff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:1d.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 11 10:18:08 localhost kernel: ACPI: EC: interrupt unblocked
jan 11 10:18:08 localhost kernel: ACPI: EC: event unblocked
jan 11 10:18:08 localhost kernel: ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
jan 11 10:18:08 localhost kernel: ACPI: EC: GPE=0x6e
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC initialization complete
jan 11 10:18:08 localhost kernel: ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events
jan 11 10:18:08 localhost kernel: iommu: Default domain type: Translated
jan 11 10:18:08 localhost kernel: iommu: DMA domain TLB invalidation policy: lazy mode
jan 11 10:18:08 localhost kernel: efivars: Registered efivars operations
jan 11 10:18:08 localhost kernel: NetLabel: Initializing
jan 11 10:18:08 localhost kernel: NetLabel:  domain hash size = 128
jan 11 10:18:08 localhost kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
jan 11 10:18:08 localhost kernel: NetLabel:  unlabeled traffic allowed by default
jan 11 10:18:08 localhost kernel: PCI: Using ACPI for IRQ routing
jan 11 10:18:08 localhost kernel: PCI: pci_cache_line_size set to 64 bytes
jan 11 10:18:08 localhost kernel: e820: reserve RAM buffer [mem 0x736cf000-0x73ffffff]
jan 11 10:18:08 localhost kernel: e820: reserve RAM buffer [mem 0x76734000-0x77ffffff]
jan 11 10:18:08 localhost kernel: e820: reserve RAM buffer [mem 0x76941000-0x77ffffff]
jan 11 10:18:08 localhost kernel: e820: reserve RAM buffer [mem 0x7695a000-0x77ffffff]
jan 11 10:18:08 localhost kernel: e820: reserve RAM buffer [mem 0x87fc00000-0x87fffffff]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: vgaarb: setting as boot VGA device
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: vgaarb: bridge control possible
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
jan 11 10:18:08 localhost kernel: vgaarb: loaded
jan 11 10:18:08 localhost kernel: clocksource: Switched to clocksource tsc-early
jan 11 10:18:08 localhost kernel: VFS: Disk quotas dquot_6.6.0
jan 11 10:18:08 localhost kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
jan 11 10:18:08 localhost kernel: pnp: PnP ACPI init
jan 11 10:18:08 localhost kernel: pnp 00:00: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfedc0000-0xfeddffff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfeda0000-0xfeda0fff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfeda1000-0xfeda1fff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfed90000-0xfed93fff] could not be reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfe000000-0xffffffff] could not be reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xf8000000-0xf9ffffff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:02: [mem 0xfed00000-0xfed003ff] has been reserved
jan 11 10:18:08 localhost kernel: system 00:03: [io  0x1800-0x18fe] has been reserved
jan 11 10:18:08 localhost kernel: pnp: PnP ACPI: found 7 devices
jan 11 10:18:08 localhost kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
jan 11 10:18:08 localhost kernel: NET: Registered PF_INET protocol family
jan 11 10:18:08 localhost kernel: IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 11 10:18:08 localhost kernel: tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
jan 11 10:18:08 localhost kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
jan 11 10:18:08 localhost kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
jan 11 10:18:08 localhost kernel: TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
jan 11 10:18:08 localhost kernel: TCP: Hash tables configured (established 262144 bind 65536)
jan 11 10:18:08 localhost kernel: MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
jan 11 10:18:08 localhost kernel: UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 11 10:18:08 localhost kernel: UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
jan 11 10:18:08 localhost kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
jan 11 10:18:08 localhost kernel: NET: Registered PF_XDP protocol family
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: BAR 9: assigned [mem 0x880000000-0x95fffffff 64bit pref]
jan 11 10:18:08 localhost kernel: pci 0000:00:02.0: BAR 7: assigned [mem 0x960000000-0x966ffffff 64bit]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: BAR 15: assigned [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: BAR 13: assigned [io  0x2000-0x2fff]
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0: PCI bridge to [bus 01]
jan 11 10:18:08 localhost kernel: pci 0000:00:1c.0:   bridge window [mem 0x80400000-0x804fffff]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0: PCI bridge to [bus 02]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0:   bridge window [io  0x2000-0x2fff]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x80500000-0x805fffff]
jan 11 10:18:08 localhost kernel: pci 0000:00:1d.0:   bridge window [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 7 [mem 0x80400000-0xdfffffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 8 [mem 0x87fc00000-0x7fffffffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed47fff window]
jan 11 10:18:08 localhost kernel: pci_bus 0000:01: resource 1 [mem 0x80400000-0x804fffff]
jan 11 10:18:08 localhost kernel: pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
jan 11 10:18:08 localhost kernel: pci_bus 0000:02: resource 1 [mem 0x80500000-0x805fffff]
jan 11 10:18:08 localhost kernel: pci_bus 0000:02: resource 2 [mem 0x87fc00000-0x87fdfffff 64bit pref]
jan 11 10:18:08 localhost kernel: PCI: CLS 64 bytes, default 64
jan 11 10:18:08 localhost kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
jan 11 10:18:08 localhost kernel: software IO TLB: mapped [mem 0x000000006c108000-0x0000000070108000] (64MB)
jan 11 10:18:08 localhost kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
jan 11 10:18:08 localhost kernel: Trying to unpack rootfs image as initramfs...
jan 11 10:18:08 localhost kernel: clocksource: Switched to clocksource tsc
jan 11 10:18:08 localhost kernel: Initialise system trusted keyrings
jan 11 10:18:08 localhost kernel: workingset: timestamp_bits=40 max_order=23 bucket_order=0
jan 11 10:18:08 localhost kernel: zbud: loaded
jan 11 10:18:08 localhost kernel: Key type asymmetric registered
jan 11 10:18:08 localhost kernel: Asymmetric key parser 'x509' registered
jan 11 10:18:08 localhost kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
jan 11 10:18:08 localhost kernel: io scheduler mq-deadline registered
jan 11 10:18:08 localhost kernel: io scheduler kyber registered
jan 11 10:18:08 localhost kernel: pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
jan 11 10:18:08 localhost kernel: pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
jan 11 10:18:08 localhost kernel: pcieport 0000:00:1d.0: pciehp: Slot #8 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
jan 11 10:18:08 localhost kernel: efifb: probing for efifb
jan 11 10:18:08 localhost kernel: efifb: showing boot graphics
jan 11 10:18:08 localhost kernel: efifb: framebuffer at 0x90000000, using 8100k, total 8100k
jan 11 10:18:08 localhost kernel: efifb: mode is 1920x1080x32, linelength=7680, pages=1
jan 11 10:18:08 localhost kernel: efifb: scrolling: redraw
jan 11 10:18:08 localhost kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
jan 11 10:18:08 localhost kernel: fbcon: Deferring console take-over
jan 11 10:18:08 localhost kernel: fb0: EFI VGA frame buffer device
jan 11 10:18:08 localhost kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
jan 11 10:18:08 localhost kernel: hpet_acpi_add: no address or irqs in _CRS
jan 11 10:18:08 localhost kernel: intel_pstate: Intel P-state driver initializing
jan 11 10:18:08 localhost kernel: intel_pstate: HWP enabled
jan 11 10:18:08 localhost kernel: drop_monitor: Initializing network drop monitor service
jan 11 10:18:08 localhost kernel: NET: Registered PF_INET6 protocol family
jan 11 10:18:08 localhost kernel: Freeing initrd memory: 27432K
jan 11 10:18:08 localhost kernel: Segment Routing with IPv6
jan 11 10:18:08 localhost kernel: In-situ OAM (IOAM) with IPv6
jan 11 10:18:08 localhost kernel: microcode: Microcode Update Driver: v2.2.
jan 11 10:18:08 localhost kernel: IPI shorthand broadcast: enabled
jan 11 10:18:08 localhost kernel: sched_clock: Marking stable (412000722, 15979636)->(456641791, -28661433)
jan 11 10:18:08 localhost kernel: registered taskstats version 1
jan 11 10:18:08 localhost kernel: Loading compiled-in X.509 certificates
jan 11 10:18:08 localhost kernel: Key type .fscrypt registered
jan 11 10:18:08 localhost kernel: Key type fscrypt-provisioning registered
jan 11 10:18:08 localhost kernel: clk: Disabling unused clocks
jan 11 10:18:08 localhost kernel: Freeing unused decrypted memory: 2028K
jan 11 10:18:08 localhost kernel: Freeing unused kernel image (initmem) memory: 2956K
jan 11 10:18:08 localhost kernel: Write protecting the kernel read-only data: 24576k
jan 11 10:18:08 localhost kernel: Freeing unused kernel image (rodata/data gap) memory: 988K
jan 11 10:18:08 localhost kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
jan 11 10:18:08 localhost kernel: Run /init as init process
jan 11 10:18:08 localhost kernel:   with arguments:
jan 11 10:18:08 localhost kernel:     /init
jan 11 10:18:08 localhost kernel:   with environment:
jan 11 10:18:08 localhost kernel:     HOME=/
jan 11 10:18:08 localhost kernel:     TERM=linux
jan 11 10:18:08 localhost systemd[1]: Inserted module 'autofs4'
jan 11 10:18:08 localhost systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 11 10:18:08 localhost systemd[1]: Detected architecture x86-64.
jan 11 10:18:08 localhost systemd[1]: Running in initrd.
jan 11 10:18:08 localhost kernel: fbcon: Taking over console
jan 11 10:18:08 localhost systemd[1]: No hostname configured, using default hostname.
jan 11 10:18:08 localhost systemd[1]: Hostname set to <localhost>.
jan 11 10:18:08 localhost systemd[1]: Initializing machine ID from random generator.
jan 11 10:18:08 localhost kernel: Console: switching to colour frame buffer device 240x67
jan 11 10:18:08 localhost systemd[1]: Queued start job for default target Initrd Default Target.
jan 11 10:18:08 localhost systemd[1]: Created slice Slice /system/systemd-cryptsetup.
jan 11 10:18:08 localhost systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 11 10:18:08 localhost systemd[1]: Reached target Initrd Root Device.
jan 11 10:18:08 localhost systemd[1]: Reached target Path Units.
jan 11 10:18:08 localhost systemd[1]: Reached target Slice Units.
jan 11 10:18:08 localhost systemd[1]: Reached target Swaps.
jan 11 10:18:08 localhost systemd[1]: Reached target Timer Units.
jan 11 10:18:08 localhost systemd[1]: Listening on Journal Socket (/dev/log).
jan 11 10:18:08 localhost systemd[1]: Listening on Journal Socket.
jan 11 10:18:08 localhost systemd[1]: Listening on udev Control Socket.
jan 11 10:18:08 localhost systemd[1]: Listening on udev Kernel Socket.
jan 11 10:18:08 localhost systemd[1]: Reached target Socket Units.
jan 11 10:18:08 localhost systemd[1]: Starting Create List of Static Device Nodes...
jan 11 10:18:08 localhost systemd[1]: Starting Journal Service...
jan 11 10:18:08 localhost systemd[1]: Starting Load Kernel Modules...
jan 11 10:18:08 localhost systemd[1]: Starting Create Static Device Nodes in /dev...
jan 11 10:18:08 localhost systemd[1]: Starting Coldplug All udev Devices...
jan 11 10:18:08 localhost systemd[1]: Finished Create List of Static Device Nodes.
jan 11 10:18:08 localhost systemd[1]: Finished Create Static Device Nodes in /dev.
jan 11 10:18:08 localhost systemd[1]: Reached target Preparation for Local File Systems.
jan 11 10:18:08 localhost systemd[1]: Reached target Local File Systems.
jan 11 10:18:08 localhost systemd[1]: Mounting /sysroot...
jan 11 10:18:08 localhost systemd[1]: Starting Rule-based Manager for Device Events and Files...
jan 11 10:18:08 localhost systemd[1]: Mounted /sysroot.
jan 11 10:18:08 localhost systemd[1]: Reached target Initrd Root File System.
jan 11 10:18:08 localhost systemd-journald[174]: Collecting audit messages is disabled.
jan 11 10:18:08 localhost systemd[1]: Starting Mountpoints Configured in the Real Root...
jan 11 10:18:08 localhost systemd[1]: Reloading requested from client PID 183 ('systemd-fstab-g') (unit initrd-parse-etc.service)...
jan 11 10:18:08 localhost systemd[1]: Reloading...
jan 11 10:18:08 localhost kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
jan 11 10:18:08 localhost kernel: raid6: avx2x4   gen() 33909 MB/s
jan 11 10:18:08 localhost kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
jan 11 10:18:08 localhost kernel: rtc_cmos 00:04: RTC can wake from S4
jan 11 10:18:08 localhost kernel: rtc_cmos 00:04: registered as rtc0
jan 11 10:18:08 localhost kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1B, rev-id 22)
jan 11 10:18:08 localhost kernel: rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
jan 11 10:18:08 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
jan 11 10:18:08 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
jan 11 10:18:08 localhost kernel: cryptd: max_cpu_qlen set to 1000
jan 11 10:18:08 localhost kernel: raid6: avx2x2   gen() 34620 MB/s
jan 11 10:18:08 localhost kernel: AVX2 version of gcm_enc/dec engaged.
jan 11 10:18:08 localhost kernel: AES CTR mode by8 optimization enabled
jan 11 10:18:08 localhost kernel: ACPI: bus type USB registered
jan 11 10:18:08 localhost kernel: usbcore: registered new interface driver usbfs
jan 11 10:18:08 localhost kernel: usbcore: registered new interface driver hub
jan 11 10:18:08 localhost kernel: usbcore: registered new device driver usb
jan 11 10:18:08 localhost kernel: raid6: avx2x1   gen() 29058 MB/s
jan 11 10:18:08 localhost kernel: raid6: using algorithm avx2x2 gen() 34620 MB/s
jan 11 10:18:08 localhost kernel: nvme nvme0: pci function 0000:02:00.0
jan 11 10:18:08 localhost kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
jan 11 10:18:08 localhost kernel: raid6: .... xor() 23608 MB/s, rmw enabled
jan 11 10:18:08 localhost kernel: raid6: using avx2x2 recovery algorithm
jan 11 10:18:08 localhost kernel: nvme nvme0: Shutdown timeout set to 10 seconds
jan 11 10:18:08 localhost kernel: nvme nvme0: 16/0/0 default/read/poll queues
jan 11 10:18:08 localhost systemd[1]: Reloading finished in 92 ms.
jan 11 10:18:08 localhost kernel:  nvme0n1: p1 p2
jan 11 10:18:08 localhost kernel: xor: automatically using best checksumming function   avx       
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: xHCI Host Controller
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
jan 11 10:18:08 localhost kernel: xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
jan 11 10:18:08 localhost kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
jan 11 10:18:08 localhost kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 11 10:18:08 localhost kernel: usb usb1: Product: xHCI Host Controller
jan 11 10:18:08 localhost kernel: usb usb1: Manufacturer: Linux 6.6.9 xhci-hcd
jan 11 10:18:08 localhost kernel: usb usb1: SerialNumber: 0000:00:14.0
jan 11 10:18:08 localhost kernel: hub 1-0:1.0: USB hub found
jan 11 10:18:08 localhost kernel: hub 1-0:1.0: 12 ports detected
jan 11 10:18:08 localhost kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.06
jan 11 10:18:08 localhost kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
jan 11 10:18:08 localhost kernel: usb usb2: Product: xHCI Host Controller
jan 11 10:18:08 localhost kernel: usb usb2: Manufacturer: Linux 6.6.9 xhci-hcd
jan 11 10:18:08 localhost kernel: usb usb2: SerialNumber: 0000:00:14.0
jan 11 10:18:08 localhost kernel: hub 2-0:1.0: USB hub found
jan 11 10:18:08 localhost kernel: hub 2-0:1.0: 4 ports detected
jan 11 10:18:08 localhost systemd[1]: Started Journal Service.
jan 11 10:18:08 localhost kernel: Btrfs loaded, zoned=no, fsverity=no
jan 11 10:18:08 localhost kernel: usb 1-1: new full-speed USB device number 2 using xhci_hcd
jan 11 10:18:08 localhost kernel: usb 1-1: New USB device found, idVendor=413c, idProduct=b07c, bcdDevice= 0.00
jan 11 10:18:08 localhost kernel: usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:08 localhost kernel: usb 1-1: Product: Dell USB-C to HDMI/DP
jan 11 10:18:08 localhost kernel: usb 1-1: Manufacturer: Dell
jan 11 10:18:08 localhost kernel: usb 1-1: SerialNumber: 11AD1D0A92AE3E1209240B00
jan 11 10:18:08 localhost kernel: usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
jan 11 10:18:09 localhost kernel: usb 2-1: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 11 10:18:09 localhost kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:09 localhost kernel: usb 2-1: Product: USB3.0 Hub
jan 11 10:18:09 localhost kernel: usb 2-1: Manufacturer: VIA Labs, Inc.
jan 11 10:18:09 localhost kernel: hub 2-1:1.0: USB hub found
jan 11 10:18:09 localhost kernel: hub 2-1:1.0: 4 ports detected
jan 11 10:18:09 localhost kernel: usb 1-3: new high-speed USB device number 3 using xhci_hcd
jan 11 10:18:09 localhost kernel: usb 1-3: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 11 10:18:09 localhost kernel: usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:09 localhost kernel: usb 1-3: Product: USB2.0 Hub
jan 11 10:18:09 localhost kernel: usb 1-3: Manufacturer: VIA Labs, Inc.
jan 11 10:18:09 localhost kernel: hub 1-3:1.0: USB hub found
jan 11 10:18:09 localhost kernel: hub 1-3:1.0: 4 ports detected
jan 11 10:18:09 localhost kernel: usb 1-4: new high-speed USB device number 4 using xhci_hcd
jan 11 10:18:09 localhost kernel: usb 1-4: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=60.90
jan 11 10:18:09 localhost kernel: usb 1-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 11 10:18:09 localhost kernel: usb 1-4: Product: USB2.0 Hub
jan 11 10:18:09 localhost kernel: hub 1-4:1.0: USB hub found
jan 11 10:18:09 localhost kernel: hub 1-4:1.0: 4 ports detected
jan 11 10:18:09 localhost kernel: usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
jan 11 10:18:09 localhost kernel: usb 2-1.1: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 11 10:18:09 localhost kernel: usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:09 localhost kernel: usb 2-1.1: Product: Dell D3100 USB3.0 Dock
jan 11 10:18:09 localhost kernel: usb 2-1.1: Manufacturer: DisplayLink
jan 11 10:18:09 localhost kernel: usb 2-1.1: SerialNumber: 2209282137B
jan 11 10:18:09 localhost kernel: usb 1-3.2: new high-speed USB device number 5 using xhci_hcd
jan 11 10:18:09 localhost kernel: usb 1-3.2: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=35.04
jan 11 10:18:09 localhost kernel: usb 1-3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:09 localhost kernel: usb 1-3.2: Product: USB2.0 Hub
jan 11 10:18:09 localhost kernel: usb 1-3.2: Manufacturer: VIA Labs, Inc.
jan 11 10:18:09 localhost kernel: hub 1-3.2:1.0: USB hub found
jan 11 10:18:09 localhost kernel: hub 1-3.2:1.0: 4 ports detected
jan 11 10:18:09 localhost kernel: usb 1-5: new high-speed USB device number 6 using xhci_hcd
jan 11 10:18:10 localhost kernel: usb 1-5: New USB device found, idVendor=0c45, idProduct=636b, bcdDevice= 1.00
jan 11 10:18:10 localhost kernel: usb 1-5: New USB device strings: Mfr=2, Product=1, SerialNumber=3
jan 11 10:18:10 localhost kernel: usb 1-5: Product: USB 2.0 Camera
jan 11 10:18:10 localhost kernel: usb 1-5: Manufacturer: Sonix Technology Co., Ltd.
jan 11 10:18:10 localhost kernel: usb 1-5: SerialNumber: SN0001
jan 11 10:18:10 localhost kernel: usb 2-1.2: new SuperSpeed USB device number 4 using xhci_hcd
jan 11 10:18:10 localhost kernel: usb 2-1.2: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=35.05
jan 11 10:18:10 localhost kernel: usb 2-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:10 localhost kernel: usb 2-1.2: Product: USB3.0 Hub
jan 11 10:18:10 localhost kernel: usb 2-1.2: Manufacturer: VIA Labs, Inc.
jan 11 10:18:10 localhost kernel: hub 2-1.2:1.0: USB hub found
jan 11 10:18:10 localhost kernel: hub 2-1.2:1.0: 4 ports detected
jan 11 10:18:10 localhost kernel: usb 1-4.1: new high-speed USB device number 7 using xhci_hcd
jan 11 10:18:10 localhost kernel: usb 1-4.1: New USB device found, idVendor=05e3, idProduct=0761, bcdDevice=24.02
jan 11 10:18:10 localhost kernel: usb 1-4.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 11 10:18:10 localhost kernel: usb 1-4.1: Product: USB Storage
jan 11 10:18:10 localhost kernel: usb 1-4.1: SerialNumber: 000000002402
jan 11 10:18:10 localhost kernel: SCSI subsystem initialized
jan 11 10:18:10 localhost kernel: usb-storage 1-4.1:1.0: USB Mass Storage device detected
jan 11 10:18:10 localhost kernel: scsi host0: usb-storage 1-4.1:1.0
jan 11 10:18:10 localhost kernel: usbcore: registered new interface driver usb-storage
jan 11 10:18:10 localhost kernel: usb 1-3.4: new full-speed USB device number 8 using xhci_hcd
jan 11 10:18:10 localhost kernel: usb 1-3.4: New USB device found, idVendor=3434, idProduct=0320, bcdDevice= 1.02
jan 11 10:18:10 localhost kernel: usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:10 localhost kernel: usb 1-3.4: Product: Keychron V2
jan 11 10:18:10 localhost kernel: usb 1-3.4: Manufacturer: Keychron
jan 11 10:18:10 localhost kernel: hid: raw HID events driver (C) Jiri Kosina
jan 11 10:18:10 localhost kernel: usbcore: registered new interface driver usbhid
jan 11 10:18:10 localhost kernel: usbhid: USB HID core driver
jan 11 10:18:10 localhost kernel: input: Keychron Keychron V2 as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.0/0003:3434:0320.0001/input/input2
jan 11 10:18:10 localhost kernel: usb 1-3.2.2: new high-speed USB device number 9 using xhci_hcd
jan 11 10:18:10 localhost kernel: hid-generic 0003:3434:0320.0001: input,hidraw0: USB HID v1.11 Keyboard [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input0
jan 11 10:18:10 localhost kernel: hid-generic 0003:3434:0320.0002: hiddev96,hidraw1: USB HID v1.11 Device [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input1
jan 11 10:18:10 localhost kernel: input: Keychron Keychron V2 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input3
jan 11 10:18:10 localhost kernel: input: Keychron Keychron V2 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input4
jan 11 10:18:10 localhost kernel: input: Keychron Keychron V2 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input5
jan 11 10:18:10 localhost kernel: input: Keychron Keychron V2 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.4/1-3.4:1.2/0003:3434:0320.0003/input/input6
jan 11 10:18:10 localhost kernel: hid-generic 0003:3434:0320.0003: input,hidraw2: USB HID v1.11 Mouse [Keychron Keychron V2] on usb-0000:00:14.0-3.4/input2
jan 11 10:18:10 localhost kernel: usb 1-3.2.2: New USB device found, idVendor=0bda, idProduct=5409, bcdDevice= 1.36
jan 11 10:18:10 localhost kernel: usb 1-3.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:10 localhost kernel: usb 1-3.2.2: Product: 3-Port USB 2.1 Hub
jan 11 10:18:10 localhost kernel: usb 1-3.2.2: Manufacturer: Generic
jan 11 10:18:10 localhost kernel: hub 1-3.2.2:1.0: USB hub found
jan 11 10:18:10 localhost kernel: hub 1-3.2.2:1.0: 3 ports detected
jan 11 10:18:10 localhost kernel: usb 1-6: new full-speed USB device number 10 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 1-6: New USB device found, idVendor=27c6, idProduct=6584, bcdDevice= 1.00
jan 11 10:18:11 localhost kernel: usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:11 localhost kernel: usb 1-6: Product: Goodix USB2.0 MISC
jan 11 10:18:11 localhost kernel: usb 1-6: Manufacturer: Goodix Technology Co., Ltd.
jan 11 10:18:11 localhost kernel: usb 1-6: SerialNumber: UIDDC8A8C35_XXXX_MOC_B0
jan 11 10:18:11 localhost kernel: usb 2-1.3: new SuperSpeed USB device number 5 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 2-1.3: New USB device found, idVendor=17e9, idProduct=436e, bcdDevice=31.34
jan 11 10:18:11 localhost kernel: usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:11 localhost kernel: usb 2-1.3: Product: Dell D3100 USB3.0 Dock
jan 11 10:18:11 localhost kernel: usb 2-1.3: Manufacturer: DisplayLink
jan 11 10:18:11 localhost kernel: usb 2-1.3: SerialNumber: 2209282137
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: new high-speed USB device number 11 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: New USB device found, idVendor=18d1, idProduct=4ee1, bcdDevice= 4.40
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: Product: Pixel 5
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: Manufacturer: Google
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: SerialNumber: 0B101FDD4000DU
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: new SuperSpeed USB device number 6 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: New USB device found, idVendor=1058, idProduct=10a2, bcdDevice=10.33
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: Product: Elements 10A2
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: Manufacturer: Western Digital
jan 11 10:18:11 localhost kernel: usb 2-1.2.1: SerialNumber: 57585131453832484C525938
jan 11 10:18:11 localhost kernel: usb-storage 2-1.2.1:1.0: USB Mass Storage device detected
jan 11 10:18:11 localhost kernel: scsi host1: usb-storage 2-1.2.1:1.0
jan 11 10:18:11 localhost kernel: scsi 0:0:0:0: Direct-Access     Generic  MassStorageClass 2402 PQ: 0 ANSI: 6
jan 11 10:18:11 localhost kernel: sd 0:0:0:0: [sda] Media removed, stopped polling
jan 11 10:18:11 localhost kernel: sd 0:0:0:0: [sda] Attached SCSI removable disk
jan 11 10:18:11 localhost kernel: usb 1-3.2.2.1: new high-speed USB device number 12 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 1-3.2.2.1: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.21
jan 11 10:18:11 localhost kernel: usb 1-3.2.2.1: New USB device strings: Mfr=0, Product=1, SerialNumber=2
jan 11 10:18:11 localhost kernel: usb 1-3.2.2.1: Product: C270 HD WEBCAM
jan 11 10:18:11 localhost kernel: usb 1-3.2.2.1: SerialNumber: 200901010001
jan 11 10:18:11 localhost kernel: usb 1-3.2.4: new low-speed USB device number 13 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 1-3.2.4: New USB device found, idVendor=047d, idProduct=2048, bcdDevice= 1.20
jan 11 10:18:11 localhost kernel: usb 1-3.2.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
jan 11 10:18:11 localhost kernel: usb 1-3.2.4: Product: Kensington Eagle Trackball
jan 11 10:18:11 localhost kernel: input: Kensington Eagle Trackball as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3.2/1-3.2.4/1-3.2.4:1.0/0003:047D:2048.0004/input/input7
jan 11 10:18:11 localhost kernel: hid-generic 0003:047D:2048.0004: input,hidraw3: USB HID v1.11 Mouse [Kensington Eagle Trackball] on usb-0000:00:14.0-3.2.4/input0
jan 11 10:18:11 localhost kernel: usb 2-1.2.2: new SuperSpeed USB device number 7 using xhci_hcd
jan 11 10:18:11 localhost kernel: usb 2-1.2.2: New USB device found, idVendor=0bda, idProduct=0409, bcdDevice= 1.36
jan 11 10:18:11 localhost kernel: usb 2-1.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:11 localhost kernel: usb 2-1.2.2: Product: 2-Port USB 3.1 Hub
jan 11 10:18:11 localhost kernel: usb 2-1.2.2: Manufacturer: Generic
jan 11 10:18:11 localhost kernel: hub 2-1.2.2:1.0: USB hub found
jan 11 10:18:11 localhost kernel: hub 2-1.2.2:1.0: 2 ports detected
jan 11 10:18:11 localhost kernel: usb 1-3.2.3: USB disconnect, device number 11
jan 11 10:18:12 localhost kernel: usb 1-3.2.2.3: new high-speed USB device number 14 using xhci_hcd
jan 11 10:18:12 localhost kernel: usb 1-3.2.2.3: New USB device found, idVendor=0bda, idProduct=1100, bcdDevice= 1.01
jan 11 10:18:12 localhost kernel: usb 1-3.2.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
jan 11 10:18:12 localhost kernel: usb 1-3.2.2.3: Product: Hub Controller
jan 11 10:18:12 localhost kernel: usb 1-3.2.2.3: Manufacturer: Realtek
jan 11 10:18:12 localhost kernel: hid-generic 0003:0BDA:1100.0005: hiddev97,hidraw4: USB HID v1.11 Device [Realtek Hub Controller] on usb-0000:00:14.0-3.2.2.3/input0
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: new high-speed USB device number 15 using xhci_hcd
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: New USB device found, idVendor=18d1, idProduct=4ee1, bcdDevice= 4.40
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: Product: Pixel 5
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: Manufacturer: Google
jan 11 10:18:12 localhost kernel: usb 1-3.2.3: SerialNumber: 0B101FDD4000DU
jan 11 10:18:12 localhost kernel: scsi 1:0:0:0: Direct-Access     WD       Elements 10A2    1033 PQ: 0 ANSI: 6
jan 11 10:18:12 localhost kernel: sd 1:0:0:0: [sdb] Spinning up disk...
jan 11 10:18:13 localhost kernel: .ready
jan 11 10:18:13 localhost kernel: sd 1:0:0:0: [sdb] 1953458176 512-byte logical blocks: (1.00 TB/931 GiB)
jan 11 10:18:13 localhost kernel: sd 1:0:0:0: [sdb] Write Protect is off
jan 11 10:18:13 localhost kernel: sd 1:0:0:0: [sdb] Mode Sense: 53 00 10 08
jan 11 10:18:13 localhost kernel: sd 1:0:0:0: [sdb] No Caching mode page found
jan 11 10:18:13 localhost kernel: sd 1:0:0:0: [sdb] Assuming drive cache: write through
jan 11 10:18:16 localhost kernel:  sdb: sdb2
jan 11 10:18:16 localhost kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
jan 11 10:18:16 localhost kernel: BTRFS: device label wd_digital devid 1 transid 773 /dev/sdb2 scanned by (udev-worker) (203)
jan 11 10:18:18 localhost kernel: Key type trusted registered
jan 11 10:18:18 localhost kernel: Key type encrypted registered
jan 11 10:18:18 localhost kernel: BTRFS: device label nixos devid 1 transid 361756 /dev/dm-2 scanned by (udev-worker) (215)
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): first mount of filesystem f02feaa7-3d81-4624-8650-0839b5d11da4
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): using crc32c (crc32c-intel) checksum algorithm
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): use zstd compression, level 1
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): enabling auto defrag
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): using free space tree
jan 11 10:18:18 localhost kernel: BTRFS info (device dm-2): enabling ssd optimizations
jan 11 10:18:19 starbook systemd-journald[174]: Received SIGTERM from PID 1 (systemd).
jan 11 10:18:19 starbook systemd[1]: systemd 254.6 running in system mode (+PAM +AUDIT -SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
jan 11 10:18:19 starbook systemd[1]: Detected architecture x86-64.
jan 11 10:18:19 starbook systemd[1]: Hostname set to <starbook>.
jan 11 10:18:19 starbook systemd[1]: bpf-lsm: LSM BPF program attached
jan 11 10:18:19 starbook kernel: zram: Added device: zram0
jan 11 10:18:19 starbook systemd[1]: initrd-switch-root.service: Deactivated successfully.
jan 11 10:18:19 starbook systemd[1]: Stopped initrd-switch-root.service.
jan 11 10:18:19 starbook systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
jan 11 10:18:19 starbook systemd[1]: Created slice Virtual Machine and Container Slice.
jan 11 10:18:19 starbook systemd[1]: Created slice Slice /system/getty.
jan 11 10:18:19 starbook systemd[1]: Created slice Slice /system/modprobe.
jan 11 10:18:19 starbook systemd[1]: Created slice Slice /system/systemd-zram-setup.
jan 11 10:18:19 starbook systemd[1]: Created slice User and Session Slice.
jan 11 10:18:19 starbook systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
jan 11 10:18:19 starbook systemd[1]: Started Forward Password Requests to Wall Directory Watch.
jan 11 10:18:19 starbook systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
jan 11 10:18:19 starbook systemd[1]: Reached target Local Encrypted Volumes.
jan 11 10:18:19 starbook systemd[1]: Stopped target initrd-fs.target.
jan 11 10:18:19 starbook systemd[1]: Stopped target initrd-root-fs.target.
jan 11 10:18:19 starbook systemd[1]: Stopped target initrd-switch-root.target.
jan 11 10:18:19 starbook systemd[1]: Reached target Containers.
jan 11 10:18:19 starbook systemd[1]: Reached target Path Units.
jan 11 10:18:19 starbook systemd[1]: Reached target Remote File Systems.
jan 11 10:18:19 starbook systemd[1]: Reached target Slice Units.
jan 11 10:18:19 starbook systemd[1]: Listening on Process Core Dump Socket.
jan 11 10:18:19 starbook systemd[1]: Listening on Network Service Netlink Socket.
jan 11 10:18:19 starbook systemd[1]: Listening on Userspace Out-Of-Memory (OOM) Killer Socket.
jan 11 10:18:19 starbook systemd[1]: Listening on udev Control Socket.
jan 11 10:18:19 starbook systemd[1]: Listening on udev Kernel Socket.
jan 11 10:18:19 starbook systemd[1]: Activating swap /dev/volgroup/swap...
jan 11 10:18:19 starbook systemd[1]: Mounting Huge Pages File System...
jan 11 10:18:19 starbook systemd[1]: Mounting POSIX Message Queue File System...
jan 11 10:18:19 starbook systemd[1]: Mounting Kernel Debug File System...
jan 11 10:18:19 starbook systemd[1]: Starting Create List of Static Device Nodes...
jan 11 10:18:19 starbook systemd[1]: Starting Load Kernel Module configfs...
jan 11 10:18:19 starbook systemd[1]: Starting Load Kernel Module drm...
jan 11 10:18:19 starbook kernel: Adding 15728636k swap on /dev/mapper/volgroup-swap.  Priority:-2 extents:1 across:15728636k SS
jan 11 10:18:19 starbook systemd[1]: Starting Load Kernel Module efi_pstore...
jan 11 10:18:19 starbook systemd[1]: Starting Load Kernel Module fuse...
jan 11 10:18:19 starbook systemd[1]: Starting mount-pstore.service...
jan 11 10:18:19 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/gh/hosts.yml' to '/home/ramses/.config/gh/hosts.yml'...
jan 11 10:18:19 starbook kernel: pstore: Using crash dump compression: deflate
jan 11 10:18:19 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/htop/htoprc' to '/home/ramses/.config/htop/htoprc'...
jan 11 10:18:19 starbook kernel: pstore: Registered efi_pstore as persistent store backend
jan 11 10:18:19 starbook systemd[1]: Starting Bind mount or link '/vol/persisted/home/ramses/.config/monitors.xml' to '/home/ramses/.config/monitors.xml'...
jan 11 10:18:19 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.bash_history' to '/home/ramses/.bash_history'...
jan 11 10:18:19 starbook systemd[1]: Starting Bind mount or link '/vol/volatile/home/ramses/.python_history' to '/home/ramses/.python_history'...
jan 11 10:18:19 starbook systemd[1]: Starting Create SUID/SGID Wrappers...
jan 11 10:18:19 starbook systemd[1]: systemd-cryptsetup@decrypted.service: Deactivated successfully.
jan 11 10:18:19 starbook systemd[1]: Stopped systemd-cryptsetup@decrypted.service.
jan 11 10:18:19 starbook kernel: fuse: init (API version 7.39)
jan 11 10:18:19 starbook systemd[1]: Starting Journal Service...
jan 11 10:18:19 starbook systemd[1]: Starting Load Kernel Modules...
jan 11 10:18:19 starbook systemd[1]: Starting Remount Root and Kernel File Systems...
jan 11 10:18:19 starbook systemd[1]: Starting Coldplug All udev Devices...
jan 11 10:18:19 starbook systemd-journald[821]: Collecting audit messages is disabled.
jan 11 10:18:19 starbook systemd[1]: Activated swap /dev/volgroup/swap.
jan 11 10:18:19 starbook systemd[1]: Mounted Huge Pages File System.
jan 11 10:18:19 starbook systemd[1]: Started Journal Service.
jan 11 10:18:19 starbook kernel: ACPI: bus type drm_connector registered
jan 11 10:18:19 starbook kernel: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
jan 11 10:18:19 starbook kernel: tun: Universal TUN/TAP device driver, 1.6
jan 11 10:18:19 starbook kernel: loop: module loaded
jan 11 10:18:20 starbook systemd-journald[821]: Received client request to flush runtime journal.
jan 11 10:18:20 starbook systemd-journald[821]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/system.journal: Journal file uses a different sequence number ID, rotating.
jan 11 10:18:20 starbook systemd-journald[821]: Rotating system journal.
jan 11 10:18:20 starbook kernel: BTRFS info: devid 1 device path /dev/mapper/volgroup-nixos changed to /dev/dm-2 scanned by (udev-worker) (971)
jan 11 10:18:20 starbook kernel: input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/PNP0C09:00/PNP0C0D:00/input/input8
jan 11 10:18:20 starbook kernel: ACPI: button: Lid Switch [LID0]
jan 11 10:18:20 starbook kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input9
jan 11 10:18:20 starbook kernel: input: Intel HID events as /devices/platform/INTC1051:00/input/input10
jan 11 10:18:20 starbook kernel: intel_pmc_core INT33A1:00:  initialized
jan 11 10:18:20 starbook kernel: EDAC MC: Ver: 3.0.0
jan 11 10:18:20 starbook kernel: ACPI: button: Power Button [PWRF]
jan 11 10:18:20 starbook kernel: EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
jan 11 10:18:20 starbook kernel: EDAC MC1: Giving out device to module igen6_edac controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
jan 11 10:18:20 starbook kernel: EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
jan 11 10:18:20 starbook kernel: EDAC igen6 MC1: ADDR 0x7fffffffe0 
jan 11 10:18:20 starbook kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 11 10:18:20 starbook kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0 
jan 11 10:18:20 starbook kernel: EDAC igen6: v2.5.1
jan 11 10:18:20 starbook kernel: idma64 idma64.0: Found Intel integrated DMA 64-bit
jan 11 10:18:20 starbook kernel: zram0: detected capacity change from 0 to 52348520
jan 11 10:18:20 starbook kernel: Linux agpgart interface v0.103
jan 11 10:18:20 starbook kernel: ACPI: AC: AC Adapter [ADP1] (on-line)
jan 11 10:18:20 starbook kernel: idma64 idma64.1: Found Intel integrated DMA 64-bit
jan 11 10:18:20 starbook kernel: ACPI: battery: Slot [BAT0] (battery present)
jan 11 10:18:20 starbook kernel: mc: Linux media interface: v0.10
jan 11 10:18:20 starbook kernel: mousedev: PS/2 mouse device common for all mice
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver uas
jan 11 10:18:20 starbook kernel: i801_smbus 0000:00:1f.4: SPD Write Disable is set
jan 11 10:18:20 starbook kernel: i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
jan 11 10:18:20 starbook kernel: i2c i2c-1: 2/2 memory slots populated (from DMI)
jan 11 10:18:20 starbook kernel: i2c i2c-1: Successfully instantiated SPD at 0x50
jan 11 10:18:20 starbook kernel: dw-apb-uart.1: ttyS0 at MMIO 0xfe03e000 (irq = 23, base_baud = 114825) is a 16550A
jan 11 10:18:20 starbook kernel: videodev: Linux video capture interface: v2.00
jan 11 10:18:20 starbook kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
jan 11 10:18:20 starbook kernel: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
jan 11 10:18:20 starbook kernel: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
jan 11 10:18:20 starbook kernel: RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
jan 11 10:18:20 starbook kernel: RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
jan 11 10:18:20 starbook kernel: RAPL PMU: hw unit of domain package 2^-14 Joules
jan 11 10:18:20 starbook kernel: RAPL PMU: hw unit of domain psys 2^-14 Joules
jan 11 10:18:20 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-STAR0001:00/0018:093A:0255.0006/input/input12
jan 11 10:18:20 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-STAR0001:00/0018:093A:0255.0006/input/input13
jan 11 10:18:20 starbook kernel: hid-generic 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver cdc_ether
jan 11 10:18:20 starbook kernel: ee1004 1-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
jan 11 10:18:20 starbook kernel: iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
jan 11 10:18:20 starbook kernel: usb 1-5: Found UVC 1.00 device USB 2.0 Camera (0c45:636b)
jan 11 10:18:20 starbook kernel: iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
jan 11 10:18:20 starbook kernel: spi-nor spi0.0: w25q256 (32768 Kbytes)
jan 11 10:18:20 starbook kernel: Intel(R) Wireless WiFi driver for Linux
jan 11 10:18:20 starbook kernel: Creating 1 MTD partitions on "0000:00:1f.5":
jan 11 10:18:20 starbook kernel: 0x000000000000-0x000002000000 : "BIOS"
jan 11 10:18:20 starbook kernel: input: USB 2.0 Camera: USB Camera as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input14
jan 11 10:18:20 starbook kernel: cdc_ncm 2-1.3:1.5: MAC-Address: 0c:37:96:96:28:5d
jan 11 10:18:20 starbook kernel: cdc_ncm 2-1.3:1.5: setting rx_max = 16384
jan 11 10:18:20 starbook kernel: cdc_ncm 2-1.3:1.5: setting tx_max = 16384
jan 11 10:18:20 starbook kernel: cdc_ncm 2-1.3:1.5 eth0: register 'cdc_ncm' at usb-0000:00:14.0-1.3, CDC NCM (SEND ZLP), 0c:37:96:96:28:5d
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver cdc_ncm
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver cdc_wdm
jan 11 10:18:20 starbook kernel: Adding 26174256k swap on /dev/zram0.  Priority:5 extents:1 across:26174256k SSDsc
jan 11 10:18:20 starbook kernel: iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
jan 11 10:18:20 starbook kernel: iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
jan 11 10:18:20 starbook kernel: usb 1-3.2.2.1: Found UVC 1.00 device C270 HD WEBCAM (046d:0825)
jan 11 10:18:20 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=511), cval->res is probably wrong.
jan 11 10:18:20 starbook kernel: usb 2-1.3: [15] FU [Dell USB Audio Playback Volume] ch = 6, val = -8176/0/16
jan 11 10:18:20 starbook kernel: usb 2-1.3: Warning! Unlikely big volume range (=767), cval->res is probably wrong.
jan 11 10:18:20 starbook kernel: usb 2-1.3: [12] FU [Mic Capture Volume] ch = 2, val = -4592/7680/16
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver cdc_mbim
jan 11 10:18:20 starbook kernel: usbcore: registered new interface driver uvcvideo
jan 11 10:18:20 starbook kernel: usb 1-3.2.2.1: current rate 16000 is different from the runtime rate 32000
jan 11 10:18:20 starbook kernel: input: STAR0001:00 093A:0255 Mouse as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-STAR0001:00/0018:093A:0255.0006/input/input15
jan 11 10:18:20 starbook kernel: input: STAR0001:00 093A:0255 Touchpad as /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-STAR0001:00/0018:093A:0255.0006/input/input16
jan 11 10:18:20 starbook kernel: hid-multitouch 0018:093A:0255.0006: input,hidraw5: I2C HID v1.00 Mouse [STAR0001:00 093A:0255] on i2c-STAR0001:00
jan 11 10:18:20 starbook kernel: cdc_ncm 2-1.3:1.5 enp0s20f0u1u3i5: renamed from eth0
jan 11 10:18:20 starbook kernel: usb 1-3.2.2.1: current rate 24000 is different from the runtime rate 16000
jan 11 10:18:20 starbook kernel: usb 1-3.2.2.1: 3:3: cannot set freq 24000 to ep 0x82
jan 11 10:18:20 starbook kernel: iwlwifi 0000:01:00.0: api flags index 2 larger than supported by driver
jan 11 10:18:20 starbook kernel: iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.41
jan 11 10:18:20 starbook kernel: iwlwifi 0000:01:00.0: loaded firmware version 83.e8f84e98.0 ty-a0-gf-a0-83.ucode op_mode iwlmvm
jan 11 10:18:20 starbook kernel: pps_core: LinuxPPS API ver. 1 registered
jan 11 10:18:20 starbook kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
jan 11 10:18:20 starbook kernel: PTP clock support registered
jan 11 10:18:21 starbook kernel: intel_tcc_cooling: Programmable TCC Offset detected
jan 11 10:18:21 starbook kernel: intel_rapl_msr: PL4 support detected.
jan 11 10:18:21 starbook kernel: intel_rapl_common: Found RAPL domain package
jan 11 10:18:21 starbook kernel: intel_rapl_common: Found RAPL domain core
jan 11 10:18:21 starbook kernel: intel_rapl_common: Found RAPL domain psys
jan 11 10:18:21 starbook kernel: usb 1-3.2.2.1: set resolution quirk: cval->res = 384
jan 11 10:18:21 starbook kernel: usbcore: registered new interface driver snd-usb-audio
jan 11 10:18:21 starbook kernel: Setting dangerous option enable_fbc - tainting kernel
jan 11 10:18:21 starbook kernel: Setting dangerous option enable_psr - tainting kernel
jan 11 10:18:21 starbook kernel: Console: switching to colour dummy device 80x25
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: vgaarb: deactivate vga console
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] Using Transparent Hugepages
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX210 160MHz, REV=0x420
jan 11 10:18:21 starbook kernel: thermal thermal_zone1: failed to read out thermal zone (-61)
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adlp_dmc.bin (v2.20)
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.13.1
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: loaded PNVM version e28bb9d7
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: Detected RF GF, rfid=0x10d000
jan 11 10:18:21 starbook kernel: [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
jan 11 10:18:21 starbook kernel: snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
jan 11 10:18:21 starbook kernel: fbcon: i915drmfb (fb0) is primary device
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0: base HW address: 7c:b5:66:65:be:72
jan 11 10:18:21 starbook kernel: iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
jan 11 10:18:21 starbook kernel: Console: switching to colour frame buffer device 240x67
jan 11 10:18:21 starbook kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:    inputs:
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Mic=0x19
jan 11 10:18:21 starbook kernel: snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
jan 11 10:18:21 starbook kernel: input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input23
jan 11 10:18:21 starbook kernel: input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input24
jan 11 10:18:21 starbook systemd-journald[821]: /var/log/journal/fe642a2c01fc4d9c80a6978863b6682e/user-1000.journal: Journal file uses a different sequence number ID, rotating.
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, with index: 0
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WRT: Invalid buffer destination
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
jan 11 10:18:22 starbook kernel: iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
jan 11 10:18:22 starbook kernel: NET: Registered PF_PACKET protocol family
jan 11 10:18:23 starbook kernel: .gnome-session-[1689]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
jan 11 10:18:25 starbook kernel: usb 1-3.2.2.1: reset high-speed USB device number 12 using xhci_hcd
jan 11 10:18:25 starbook kernel: NET: Registered PF_QIPCRTR protocol family
jan 11 10:18:25 starbook kernel: wlp1s0: authenticate with 30:67:a1:14:f9:c7
jan 11 10:18:25 starbook kernel: wlp1s0: send auth to 30:67:a1:14:f9:c7 (try 1/3)
jan 11 10:18:25 starbook kernel: wlp1s0: authenticated
jan 11 10:18:25 starbook kernel: wlp1s0: associate with 30:67:a1:14:f9:c7 (try 1/3)
jan 11 10:18:25 starbook kernel: wlp1s0: RX AssocResp from 30:67:a1:14:f9:c7 (capab=0x1011 status=0 aid=9)
jan 11 10:18:25 starbook kernel: wlp1s0: associated
jan 11 10:18:25 starbook kernel: wlp1s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 30:67:a1:14:f9:c7
jan 11 10:18:38 starbook kernel: warning: `.gnome-shell-wr' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
jan 11 10:24:48 starbook kernel: Bluetooth: Core ver 2.22
jan 11 10:24:48 starbook kernel: NET: Registered PF_BLUETOOTH protocol family
jan 11 10:24:48 starbook kernel: Bluetooth: HCI device and connection manager initialized
jan 11 10:24:48 starbook kernel: Bluetooth: HCI socket layer initialized
jan 11 10:24:48 starbook kernel: Bluetooth: L2CAP socket layer initialized
jan 11 10:24:48 starbook kernel: Bluetooth: SCO socket layer initialized
jan 11 10:29:53 starbook kernel: wlp1s0: deauthenticating from 30:67:a1:14:f9:c7 by local choice (Reason: 3=DEAUTH_LEAVING)

------=_Part_3365_998781800.1705154759365--

