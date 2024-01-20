Return-Path: <stable+bounces-12305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF78331E3
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 01:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C361F22DBA
	for <lists+stable@lfdr.de>; Sat, 20 Jan 2024 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED84656;
	Sat, 20 Jan 2024 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="o6nkUCj4"
X-Original-To: stable@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C739C;
	Sat, 20 Jan 2024 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.6.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711387; cv=none; b=YXi4RFhlgs4bfLAReqcSXxNLgZzsUdKOpeml/wmn/obG554NE2sDAkoVuZpK0ndIx3NZWwItE6u71CRw7JRC5aYclKH75N66eRDN2E2JtQIz4E/Mc0dc8X+bK0IhjlriUUg8J7n7DtUGcaVeTw4RyBDKdzQqV7sRxyJVqGR4New=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711387; c=relaxed/simple;
	bh=rb18dRLOP/NAZC/Se2KTF2clnM92fKZ3P0ZM32RhZ0c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fE0wezsXzUMZ7KELXKLUdbJ1b/zV7LJbkaLn2HEeWLn8bKzEAYDYENQAkomor8I6EEP9kgKSNGEta8JwjqJl5xoS/rUz4UHTYNXI6HRN9HlXQKCxYIWgvnW+DKHoPxYVOSznijStO7Jq40BiZw8zXPKQV3hm8EyUWdv/WErHz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev; spf=pass smtp.mailfrom=well-founded.dev; dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b=o6nkUCj4; arc=none smtp.client-ip=81.3.6.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 74EAD10600E8;
	Sat, 20 Jan 2024 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705711377;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=rb18dRLOP/NAZC/Se2KTF2clnM92fKZ3P0ZM32RhZ0c=;
	b=o6nkUCj4hnHQj5zTL/E7bUEBxcFF3W1nyEkcMzbv1nMLuR6Bunb0i4a6oq0xfQ1V
	fOqXtykkgwWgHv2TltRBMN81W/3Mjx2ES5Ss8AtkzSJcdeUFYWGxPU7mjwg36xvcSwY
	uJNAKdWCV/ZwNzWW9gy//6UMwtuzYhx5SsvBKiPPcRPGN4KqDFr8KbXjmX/eBf8u/7I
	jPEUg5AwQXNTdNB6qPuDVz4VWLzumclF96HyZHrj8UfmZvxPtUPfFcrbfg8u2aBYdgJ
	a8fQMpb3BZmRoZqmkRSahuI00j/RAHG/p7EEDL5nZG7PWJF2Q0VjNDo7Srg6BF+xWvv
	angZ9AWzmA==
Date: Sat, 20 Jan 2024 01:42:57 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	Stable <stable@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Message-ID: <NoZJWbP--3-9@well-founded.dev>
In-Reply-To: <d3accff8-b66b-4aa3-9b9d-bd2eeb8aaf09@leemhuis.info>
References: <No21xeV--3-9@well-founded.dev> <No28BcQ--3-9@well-founded.dev> <d3accff8-b66b-4aa3-9b9d-bd2eeb8aaf09@leemhuis.info>
Subject: Re: Built-in Intel Bluetooth device disappeared after booting
 Linux
 6.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

19 janv. 2024, 14:45 de regressions@leemhuis.info:

> On 13.01.24 15:05, Ramses wrote:
>
>> I forgot to add the full kernel logs, attached the logs of 6.6.10 with w=
orking bluetooth and 6.7 where bluetooth is not working.
>>
>
> Hi! This is not my area of expertise, but as it seems nobody answered
> let me give it a shot:
>
> It seems you are using different firmware files for you Wifi device
> (compare the lines "iwlwifi 0000:01:00.0: loaded firmware version...");
> could you maybe temporarily remove the newer one to rule out it causes
> your BT problem?
>
> There are a few other differences in the dmesg that look odd; the older
> one has lines like "input: Kensington Eagle Trackball", the newer one
> does not. Did you disconnect that device in between? If not it sounds
> like there is something fishy somewhere, maybe with USB or your kernel
> config.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
>> I am also including a recent boot with 6.6.9 (after having booted with 6=
.7) where bluetooth is also not showing up, even though it did work before =
on the same kernel build.
>>
>> Thanks,
>> Ramses
>>
>>
>> Jan 13, 2024, 14:38 by ramses@well-founded.dev:
>>
>>> I am running an alder lake i7 1260P with built-in bluetooth.
>>> This adapter always worked fine with no special config, but since I boo=
ted Linux 6.7, the device completely disappeared. There's no mention of blu=
etooth in the kernel or system logs, there's no device node, and there's no=
 entry in lspci.
>>> When I boot the last working kernel again (6.6.10), the device also doe=
sn't appear (even though it did before, see logs below).
>>>
>>> I also tried booting a ubuntu live ISO to exclude any configuration iss=
ues with my distro's (NixOS) kernel or such, and also there the device did =
not show up.
>>>
>>> I am not sure at all that this is related to the kernel, but I wouldn't=
 know where else to look. I am including below my system logs (journalctl -=
g 'blue|Blue|Linux') showing the kernel version and the bluetooth related e=
ntries. As you can see, on 6.6.10 the bluetooth module got loaded, /dev/hci=
0 gets created, and user space sets up the bluetooth stack.
>>>
>>> The next boot entry is the first time I booted 6.7, and there's no ment=
ion of bluetooth at all in the logs. I tried to load the bluetooth module m=
anually, which succeeds but doesn't create a device node.
>>>
>>> When I boot 6.6.10 again now, I get exactly the same as on 6.7. I don't=
 know if the kernel could have done anything persistent to the device that =
makes that it doesn't get initialised anymore?
>>>
>>> I'm not sure how to debug this further, let me know if there's a way to=
 get more detailed info in the kernel logs or such.
>>>
>>> Thanks,
>>> Ramses
>>>
>>>
>>> Logs with 6.6.10:
>>>
>>> -- Boot 7847b5595e1d40a8bf2624542e5fff74 --
>>> jan 09 02:03:50 localhost kernel: Linux version 6.6.10 (nixbld@localhos=
t) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNA=
MIC Fri Jan=C2=A0 5 14:19:45 UTC 2024
>>> jan 09 02:03:50 localhost kernel: SELinux:=C2=A0 Initializing.
>>> jan 09 02:03:50 localhost kernel: usb usb1: Manufacturer: Linux 6.6.10 =
xhci-hcd
>>> jan 09 02:03:50 localhost kernel: usb usb2: Manufacturer: Linux 6.6.10 =
xhci-hcd
>>> jan 09 02:04:02 starbook kernel: Linux agpgart interface v0.103
>>> jan 09 02:04:02 starbook kernel: mc: Linux media interface: v0.10
>>> jan 09 02:04:02 starbook kernel: Bluetooth: Core ver 2.22
>>> jan 09 02:04:02 starbook kernel: Bluetooth: HCI device and connection m=
anager initialized
>>> jan 09 02:04:02 starbook kernel: Bluetooth: HCI socket layer initialize=
d
>>> jan 09 02:04:02 starbook kernel: Bluetooth: L2CAP socket layer initiali=
zed
>>> jan 09 02:04:02 starbook kernel: Bluetooth: SCO socket layer initialize=
d
>>> jan 09 02:04:03 starbook kernel: videodev: Linux video capture interfac=
e: v2.00
>>> jan 09 02:04:03 starbook kernel: Intel(R) Wireless WiFi driver for Linu=
x
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware timestamp 20=
23.42 buildtype 1 build 73111
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: No support for _PRR A=
CPI method
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Found device firmware=
: intel/ibt-0041-0041.sfi
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Boot Address: 0x10080=
0
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware Version: 151=
-42.23
>>> jan 09 02:04:03 starbook kernel: Bluetooth: hci0: Firmware already load=
ed
>>> jan 09 02:04:03 starbook kernel: pps_core: LinuxPPS API ver. 1 register=
ed
>>> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate n=
ame 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
>>> jan 09 02:04:04 starbook dbus-broker-launch[1265]: Ignoring duplicate n=
ame 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0=
w-bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
>>> jan 09 02:04:04 starbook systemd[1]: Starting Bluetooth service...
>>> jan 09 02:04:04 starbook (uetoothd)[1275]: bluetooth.service: Configura=
tionDirectory 'bluetooth' already exists but the mode is different. (File s=
ystem: 755 ConfigurationDirectoryMode: 555)
>>> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP (Ethernet Emulation) v=
er 1.3
>>> jan 09 02:04:04 starbook kernel: Bluetooth: BNEP socket layer initializ=
ed
>>> jan 09 02:04:04 starbook kernel: Bluetooth: MGMT ver 1.22
>>> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth daemon 5.70
>>> jan 09 02:04:04 starbook bluetoothd[1275]: Bluetooth management interfa=
ce 1.22 initialized
>>> jan 09 02:04:04 starbook systemd[1]: Started Bluetooth service.
>>> jan 09 02:04:04 starbook systemd[1]: Reached target Bluetooth Support.
>>> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iw=
ad5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
>>> jan 09 02:04:05 starbook dbus-broker-launch[1774]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM TTY layer initialize=
d
>>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM socket layer initial=
ized
>>> jan 09 02:04:08 starbook kernel: Bluetooth: RFCOMM ver 1.11
>>> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/hkws1iw1422s6jifkv2n6xc3iw=
ad5pyg-system-path/share/dbus-1/services/org.bluez.obex.s>
>>> jan 09 02:04:15 starbook dbus-broker-launch[2343]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>>> jan 09 09:22:05 starbook systemd[1]: Stopped target Bluetooth Support.
>>> jan 09 09:22:05 starbook systemd[1]: Stopping Bluetooth service...
>>> jan 09 09:22:05 starbook systemd[1]: bluetooth.service: Deactivated suc=
cessfully.
>>> jan 09 09:22:05 starbook systemd[1]: Stopped Bluetooth service.
>>>
>>>
>>>
>>> With 6.7
>>>
>>> -- Boot 7840f56ab2434c9fb1b899e7abea32cc --
>>> jan 09 09:26:07 localhost kernel: Linux version 6.7.0 (nixbld@localhost=
) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.40) #1-NixOS SMP PREEMPT_DYNAM=
IC Sun Jan=C2=A0 7 20:18:38 UTC 2024
>>> jan 09 09:26:07 localhost kernel: SELinux:=C2=A0 Initializing.
>>> jan 09 09:26:07 localhost kernel: usb usb1: Manufacturer: Linux 6.7.0 x=
hci-hcd
>>> jan 09 09:26:07 localhost kernel: usb usb2: Manufacturer: Linux 6.7.0 x=
hci-hcd
>>> jan 09 09:26:17 starbook kernel: mc: Linux media interface: v0.10
>>> jan 09 09:26:17 starbook kernel: Linux agpgart interface v0.103
>>> jan 09 09:26:17 starbook kernel: videodev: Linux video capture interfac=
e: v2.00
>>> jan 09 09:26:17 starbook kernel: Intel(R) Wireless WiFi driver for Linu=
x
>>> jan 09 09:26:17 starbook kernel: pps_core: LinuxPPS API ver. 1 register=
ed
>>> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate n=
ame 'org.bluez.mesh' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/system-services/org.bluez.>
>>> jan 09 09:26:18 starbook dbus-broker-launch[1198]: Ignoring duplicate n=
ame 'org.bluez' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igxh98j0=
w-bluez-5.70/share/dbus-1/system-services/org.bluez.servi>
>>> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj3=
3bclwa-system-path/share/dbus-1/services/org.bluez.obex.s>
>>> jan 09 09:26:20 starbook dbus-broker-launch[1691]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>>> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/faz2vqhyjls6xvblgv959qpsj3=
3bclwa-system-path/share/dbus-1/services/org.bluez.obex.s>
>>> jan 09 09:26:39 starbook dbus-broker-launch[2309]: Ignoring duplicate n=
ame 'org.bluez.obex' in service file '/nix/store/6dln0pmd1zb9xg4c81l3k08igx=
h98j0w-bluez-5.70/share/dbus-1/services/org.bluez.obex.se>
>>> jan 09 09:26:43 starbook systemd[1]: Bluetooth service was skipped beca=
use of an unmet condition check (ConditionPathIsDirectory=3D/sys/class/blue=
tooth).
>>>
>>>
>>> lspci output (on 6.7):
>>>
>>> =E2=9E=9C lspci -v
>>> 00:00.0 Host bridge: Intel Corporation Device 4621 (rev 02)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: igen6_=
edac
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: igen6_edac
>>>
>>> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P GT2 [=
Iris Xe Graphics] (rev 0c) (prog-if 00 [VGA controller])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceName: VGA compatible c=
ontroller
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Alder Lake-P GT2 [Iris Xe Graphics]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 158
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 81000000 (64-bit, =
non-prefetchable) [size=3D16M]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 90000000 (64-bit, =
prefetchable) [size=3D256M]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at 1000 [size=3D64=
]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Expansion ROM at 000c0000 [v=
irtual] [disabled] [size=3D128K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i915
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i915
>>>
>>> 00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor Ga=
ussian & Neural Accelerator (rev 02)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 255
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80720000 (64-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>>
>>> 00:0a.0 Signal processing controller: Intel Corporation Platform Monito=
ring Technology (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: fast devsel
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80710000 (64-bit, =
non-prefetchable) [size=3D32K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel_=
vsec
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_vsec
>>>
>>> 00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI H=
ost Controller (rev 01) (prog-if 30 [XHCI])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, medium de=
vsel, latency 0, IRQ 124
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80700000 (64-bit, =
non-prefetchable) [size=3D64K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: xhci_h=
cd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: xhci_pci
>>>
>>> 00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev 0=
1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80718000 (64-bit, =
non-prefetchable) [size=3D16K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80721000 (64-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>>
>>> 00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH Serial =
IO I2C Controller #0 (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 37
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80722000 (64-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-=
lpss
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_p=
ci
>>>
>>> 00:1c.0 PCI bridge: Intel Corporation Device 51bc (rev 01) (prog-if 00 =
[Normal decode])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 122
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=
=3D01, subordinate=3D01, sec-latency=3D0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: [disabled=
] [16-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 804000=
00-804fffff [size=3D1M] [32-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind b=
ridge: [disabled] [64-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pciepo=
rt
>>>
>>> 00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port =
#9 (rev 01) (prog-if 00 [Normal decode])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 123
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=
=3D02, subordinate=3D02, sec-latency=3D0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 2000-2fff=
 [size=3D4K] [16-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: 805000=
00-805fffff [size=3D1M] [32-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind b=
ridge: 87fc00000-87fdfffff [size=3D2M] [32-bit]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pciepo=
rt
>>>
>>> 00:1e.0 Communication controller: Intel Corporation Alder Lake PCH UART=
 #0 (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 23
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at fe03e000 (64-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80724000 (64-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-=
lpss
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: intel_lpss_p=
ci
>>>
>>> 00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller (r=
ev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0
>>>
>>> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High Definitio=
n Audio Controller (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 64, IRQ 159
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 8071c000 (64-bit, =
non-prefetchable) [size=3D16K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80600000 (64-bit, =
non-prefetchable) [size=3D1M]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: snd_hd=
a_intel
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_inte=
l, snd_sof_pci_intel_tgl
>>>
>>> 00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host Controller=
 (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: medium devsel, IRQ 23
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80726000 (64-bit, =
non-prefetchable) [size=3D256]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at efa0 [size=3D32=
]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: i801_s=
mbus
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: i2c_i801
>>>
>>> 00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI C=
ontroller (rev 01)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Device 7270
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80725000 (32-bit, =
non-prefetchable) [size=3D4K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: intel-=
spi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: spi_intel_pc=
i
>>>
>>> 01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX210/AX211/AX411=
 160MHz (rev 1a)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Intel Corporation=
 Wi-Fi 6 AX210 160MHz
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80400000 (64-bit, =
non-prefetchable) [size=3D16K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: iwlwif=
i
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: iwlwifi
>>>
>>> 02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe=
 SSD Controller S4LV008[Pascal] (prog-if 02 [NVM Express])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electroni=
cs Co Ltd Device a801
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical Slot: 8
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devs=
el, latency 0, IRQ 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at 80500000 (64-bit, =
non-prefetchable) [size=3D16K]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: <access denied=
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: nvme
>>>

Hi Thorsten

Thanks a lot for your reply!

I was initially hoping that it was simply a version issue, but when I compi=
led and booted 6.6.9, with the same iwlwifi driver version that I had befor=
e, Bluetooth was still not working (the dmesg for that boot was attached to=
 the original email).

So I was hoping that there's maybe some microcode or other persistent state=
 or such that may explain why the Bluetooth suddenly disappeared, as the on=
ly other option that I can think of, would be sudden hardware failure (not =
sure if that happens, I haven't heard of that with integrated chips).

Thanks again for your reply, I appreciate it!
Ramses

