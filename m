Return-Path: <stable+bounces-121228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA0A54AB0
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 13:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142D77A7F46
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B020B1E4;
	Thu,  6 Mar 2025 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b="XXtd3COn"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E420AF96;
	Thu,  6 Mar 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264048; cv=none; b=noOQ4W3x/ZJdEZmWRREnFOCipcfd65Qi/wxRHST/Ie2cyaxA2qMfv9ODfrjkH9aoaT9xo61+nJiEkVPRh0NV7mKIQ8JLLyRMlPfiyqOefSMff29i7TRmxmalq2zD8FxbirJHlXfJLdO77X0QIbF9duU51+o01uWgCrIvV69QjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264048; c=relaxed/simple;
	bh=V5sCas/re5KB1WJDZeREcuolKMHYLbnme+XnEyGYqtM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EeoMOUwO/OeZ3B48JIvGeVVyM9ATKu8mCxaFq5motaLDZIkM1pxgnWOcaxy1wFDHLzUeHQlpR3J6XaGU6yt+EGBkTx60vuz3m5sRHQrKggQPG/rGIj6qBchk5PbpjQfoSZXWVLUky0cnjVibWqWu5qVyICNeuR7f/jLzAcOh0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr; spf=pass smtp.mailfrom=grabatoulnz.fr; dkim=pass (2048-bit key) header.d=grabatoulnz.fr header.i=@grabatoulnz.fr header.b=XXtd3COn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grabatoulnz.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grabatoulnz.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 79173433C9;
	Thu,  6 Mar 2025 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grabatoulnz.fr;
	s=gm1; t=1741264043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+AsgIvVpL2Pm/oq/32bmIaTO0rCvavU6LbqB7AuIneM=;
	b=XXtd3COneTenwwBY8WzDo+UO+4I3EZz3qgt1rpZrfCsIOoduqCWGLuNMMwVlAp9RSTcT11
	zLhoILXxe2ivBJn741F3tLtdg6W5RA6YaEgKHPaYTCZgiX+DbL3nnbWk14dg0yqGYTFwMI
	QuqtwULEvZTEnHyC/uj+6154DEil2arSYa4X7+ecrCPItDovJiFilRcAGC/JJZPImY2OTB
	EOPmTfieYbSYX4Y2D7mmcCGaHS29QKTcQ7k+BLd3vcdinbYpOLRpIlusWntYUiGgURoYmi
	qhsGI+HcwWvxYsQnNxet/lwSuLpbL52HBhIvaeBtxCHZtWSPJLZ0/zbYosA+rA==
Content-Type: multipart/mixed; boundary="------------DhKS6kFF4k5xkk27sIyHql4b"
Message-ID: <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
Date: Thu, 6 Mar 2025 13:27:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan> <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
Content-Language: en-US
From: Eric <eric.4.debian@grabatoulnz.fr>
In-Reply-To: <Z8l7paeRL9szo0C0@ryzen>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtkfffgggfuffvvehfhfgjsehmtderredtvdejnecuhfhrohhmpefgrhhitgcuoegvrhhitgdrgedruggvsghirghnsehgrhgrsggrthhouhhlnhiirdhfrheqnecuggftrfgrthhtvghrnhepuefflefgudfgudfhheejfedvgfdtffetffeiveegjeekgeehffffgffhfeffudeunecukfhppedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegruddphhgvlhhopeglkffrggeimedvrgdtudemtggstdegmeelgedumegsuddttdemgedvudeimeejvghffhemfhgvvdehmeelhegrudgnpdhmrghilhhfrhhomhepvghrihgtrdegrdguvggsihgrnhesghhrrggsrghtohhulhhniidrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrrhhnihhlseguvggsihgrnhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmo
 hhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepughlvghmohgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhhphesvghnughlvghsshhoshdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: eric.degenetais@grabatoulnz.fr

This is a multi-part message in MIME format.
--------------DhKS6kFF4k5xkk27sIyHql4b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/03/2025 à 11:40, Niklas Cassel a écrit :
> On Thu, Mar 06, 2025 at 11:37:08AM +0100, Niklas Cassel wrote:
>> On Mon, Mar 03, 2025 at 03:58:30PM +0100, Eric wrote:
>>> Hi Niklas
>>>
>>> Le 03/03/2025 à 07:25, Niklas Cassel a écrit :
>>>> Do you see your SSD in the kexec'd kernel?
>>> Sorry, I've tried that using several methods (systemctl kexec / kexec --load
>>> + kexec -e / kexec --load + shutdown --reboot now) and it failed each time.
>>> I *don't* think it is related to this bug, however, because each time the
>>> process got stuck just after displaying "kexec_core: Starting new kernel".
>> I just tired (as root):
>> # kexec -l /boot/vmlinuz-6.13.5-200.fc41.x86_64 --initrd=/boot/initramfs-6.13.5-200.fc41.x86_64.img --reuse-cmd
>> # kexec -e
>>
>> and FWIW, kexec worked fine.
>>
>> Did you specify an initrd ? did you specify --reuse-cmd ?

At one time, I did yes. I can't figure out what's wrong, but working 
from the assumption that another way of working around the UEFI's 
failure to wake the disk might yield the same information that you're 
looking for,

I installed the same system on a USB stick, on which I also installed 
grub, so that the reboot is made independent of weather the UEFI sees 
the SSD disk or not. I'll attach dmesg extracts (grep on ata or ahci) to 
this mail.

One is the dmesg after coldbooting from the USB stick, the other is 
rebooting on the USB stick. First of all, the visible result : the SSD 
is not detected by linux at reboot (but is when coldbooting).

Here is what changes :

eric@gwaihir:~$ diff 
/media/eric/trixieUSB/home/eric/dmesg-ahci-ata-coldboot.untimed.txt 
/media/eric/trixieUSB/home/eric/dmesg-ahci-ata-reboot.untimed.txt

4c4
<  ahci 0000:00:11.0: 4/4 ports implemented (port mask 0x3c)
---
 >  ahci 0000:00:11.0: 3/3 ports implemented (port mask 0x38)
14c14
<  ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19 
lpm-pol 3
---
 >  ata3: DUMMY
27,28d26
<  ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
<  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
29a28
 >  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
31,34d29
<  ata3.00: Model 'Samsung SSD 870 QVO 2TB', rev 'SVQ02B6Q', applying 
quirks: noncqtrim zeroaftertrim noncqonati
<  ata3.00: supports DRM functions and may not be fully accessible
<  ata3.00: ATA-11: Samsung SSD 870 QVO 2TB, SVQ02B6Q, max UDMA/133
<  ata3.00: 3907029168 sectors, multi 1: LBA48 NCQ (not used)
37a33
 >  ata5.00: configured for UDMA/100
40d35
<  ata5.00: configured for UDMA/100
43,46d37
<  ata3.00: Features: Trust Dev-Sleep
<  ata3.00: supports DRM functions and may not be fully accessible
<  ata3.00: configured for UDMA/133
<  scsi 2:0:0:0: Direct-Access     ATA      Samsung SSD 870 2B6Q PQ: 0 
ANSI: 5
50,51d40
<  ata3.00: Enabling discard_zeroes_data
<  ata3.00: Enabling discard_zeroes_data

I hope this is useful for diagnosing the problem.

> Sorry, typo:
>
> s/--reuse-cmd/--reuse-cmdline/
>
>
> Kind regards,
> Niklas

Kind regards,

Eric

--------------DhKS6kFF4k5xkk27sIyHql4b
Content-Type: text/plain; charset=UTF-8; name="dmesg-ahci-ata-reboot.txt"
Content-Disposition: attachment; filename="dmesg-ahci-ata-reboot.txt"
Content-Transfer-Encoding: base64

c3VkbyBkbWVzZyB8IGdyZXAgLWlFICIoIGF0YXxhaGNpKSIKWyAgICAxLjg4NDI2M10gYWhj
aSAwMDAwOjAwOjExLjA6IHZlcnNpb24gMy4wClsgICAgMS44ODQ0MDFdIGFoY2kgMDAwMDow
MDoxMS4wOiBBSENJIHZlcnMgMDAwMS4wMjAwLCAzMiBjb21tYW5kIHNsb3RzLCA2IEdicHMs
IFNBVEEgbW9kZQpbICAgIDEuODg0NDA0XSBhaGNpIDAwMDA6MDA6MTEuMDogMy8zIHBvcnRz
IGltcGxlbWVudGVkIChwb3J0IG1hc2sgMHgzOCkKWyAgICAxLjg4NDQwN10gYWhjaSAwMDAw
OjAwOjExLjA6IGZsYWdzOiA2NGJpdCBuY3Egc250ZiBpbGNrIHBtIGxlZCBjbG8gcG1wIHBp
byBzbHVtIHBhcnQgClsgICAgMS44OTAzNzJdIHNjc2kgaG9zdDA6IGFoY2kKWyAgICAxLjg5
MTU4N10gc2NzaSBob3N0MTogYWhjaQpbICAgIDEuODkxNzUxXSBzY3NpIGhvc3QyOiBhaGNp
ClsgICAgMS44OTE5MjRdIHNjc2kgaG9zdDM6IGFoY2kKWyAgICAxLjg5MjA3OV0gc2NzaSBo
b3N0NDogYWhjaQpbICAgIDEuODkyMjM0XSBzY3NpIGhvc3Q1OiBhaGNpClsgICAgMS44OTIy
OThdIGF0YTE6IERVTU1ZClsgICAgMS44OTIzMDBdIGF0YTI6IERVTU1ZClsgICAgMS44OTIz
MDBdIGF0YTM6IERVTU1ZClsgICAgMS44OTIzMDJdIGF0YTQ6IFNBVEEgbWF4IFVETUEvMTMz
IGFiYXIgbTEwMjRAMHhmZWIwYjAwMCBwb3J0IDB4ZmViMGIyODAgaXJxIDE5IGxwbS1wb2wg
MwpbICAgIDEuODkyMzA1XSBhdGE1OiBTQVRBIG1heCBVRE1BLzEzMyBhYmFyIG0xMDI0QDB4
ZmViMGIwMDAgcG9ydCAweGZlYjBiMzAwIGlycSAxOSBscG0tcG9sIDMKWyAgICAxLjg5MjMw
N10gYXRhNjogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtMTAyNEAweGZlYjBiMDAwIHBvcnQg
MHhmZWIwYjM4MCBpcnEgMTkgbHBtLXBvbCAzClsgICAgMS44OTI0ODddIGFoY2kgMDAwMDow
NDowMC4wOiBTU1MgZmxhZyBzZXQsIHBhcmFsbGVsIGJ1cyBzY2FuIGRpc2FibGVkClsgICAg
MS44OTI1MDhdIGFoY2kgMDAwMDowNDowMC4wOiBBSENJIHZlcnMgMDAwMS4wMjAwLCAzMiBj
b21tYW5kIHNsb3RzLCA2IEdicHMsIFNBVEEgbW9kZQpbICAgIDEuODkyNTExXSBhaGNpIDAw
MDA6MDQ6MDAuMDogMi8yIHBvcnRzIGltcGxlbWVudGVkIChwb3J0IG1hc2sgMHgzKQpbICAg
IDEuODkyNTEzXSBhaGNpIDAwMDA6MDQ6MDAuMDogZmxhZ3M6IDY0Yml0IG5jcSBzbnRmIHN0
YWcgbGVkIGNsbyBwbXAgcGlvIHNsdW0gcGFydCBjY2Mgc3hzIApbICAgIDEuODkyOTI3XSBz
Y3NpIGhvc3Q2OiBhaGNpClsgICAgMS44OTMwNzNdIHNjc2kgaG9zdDc6IGFoY2kKWyAgICAx
Ljg5MzE0NF0gYXRhNzogU0FUQSBtYXggVURNQS8xMzMgYWJhciBtNTEyQDB4ZmU4MDAwMDAg
cG9ydCAweGZlODAwMTAwIGlycSA0MyBscG0tcG9sIDAKWyAgICAxLjg5MzE0OF0gYXRhODog
U0FUQSBtYXggVURNQS8xMzMgYWJhciBtNTEyQDB4ZmU4MDAwMDAgcG9ydCAweGZlODAwMTgw
IGlycSA0MyBscG0tcG9sIDAKWyAgICAyLjIwMzU4Nl0gYXRhNzogU0FUQSBsaW5rIGRvd24g
KFNTdGF0dXMgMCBTQ29udHJvbCAzMDApClsgICAgMi4zNTk5ODBdIGF0YTQ6IFNBVEEgbGlu
ayB1cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQpbICAgIDIuMzYwMDE0
XSBhdGE2OiBTQVRBIGxpbmsgdXAgMy4wIEdicHMgKFNTdGF0dXMgMTIzIFNDb250cm9sIDMw
MCkKWyAgICAyLjM2MDA0N10gYXRhNTogU0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVz
IDExMyBTQ29udHJvbCAzMDApClsgICAgMi4zNjA1OTJdIGF0YTQuMDA6IEFUQS03OiBNQVhU
T1IgU1RNMzI1MDMxMEFTLCAzLkFBQywgbWF4IFVETUEvMTMzClsgICAgMi4zNjA1OTddIGF0
YTQuMDA6IDQ4ODM5NzE2OCBzZWN0b3JzLCBtdWx0aSAxNjogTEJBNDggTkNRIChkZXB0aCAz
MikKWyAgICAyLjM2MDYxMl0gYXRhNS4wMDogQVRBUEk6IEFTVVMgICAgQkMtMTJEMkhULCAx
LjAwLCBtYXggVURNQS8xMDAKWyAgICAyLjM2MTE1OV0gYXRhNS4wMDogY29uZmlndXJlZCBm
b3IgVURNQS8xMDAKWyAgICAyLjM2MTE3OV0gYXRhNi4wMDogQVRBLTg6IFNUMzEwMDA1MjhB
UywgQ0MzOCwgbWF4IFVETUEvMTMzClsgICAgMi4zNjExODRdIGF0YTYuMDA6IDE5NTM1MjUx
Njggc2VjdG9ycywgbXVsdGkgMTY6IExCQTQ4IE5DUSAoZGVwdGggMzIpClsgICAgMi4zNjEz
MTddIGF0YTQuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzClsgICAgMi4zNjI1OTldIGF0
YTYuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzClsgICAgMi4zNzQ4MDddIHNjc2kgMzow
OjA6MDogRGlyZWN0LUFjY2VzcyAgICAgQVRBICAgICAgTUFYVE9SIFNUTTMyNTAzMSBDICAg
IFBROiAwIEFOU0k6IDUKWyAgICAyLjQyNDUwMV0gc2NzaSA1OjA6MDowOiBEaXJlY3QtQWNj
ZXNzICAgICBBVEEgICAgICBTVDMxMDAwNTI4QVMgICAgIENDMzggUFE6IDAgQU5TSTogNQpb
ICAgIDIuNzM1ODYwXSBhdGE4OiBTQVRBIGxpbmsgZG93biAoU1N0YXR1cyAwIFNDb250cm9s
IDMwMCkK
--------------DhKS6kFF4k5xkk27sIyHql4b
Content-Type: text/plain; charset=UTF-8; name="dmesg-ahci-ata-coldboot.txt"
Content-Disposition: attachment; filename="dmesg-ahci-ata-coldboot.txt"
Content-Transfer-Encoding: base64

c3VkbyBkbWVzZyB8IGdyZXAgLWlFICIoIGF0YXxhaGNpKSIKWyAgICAxLjczOTE4NV0gYWhj
aSAwMDAwOjAwOjExLjA6IHZlcnNpb24gMy4wClsgICAgMS43MzkzMTNdIGFoY2kgMDAwMDow
MDoxMS4wOiBBSENJIHZlcnMgMDAwMS4wMjAwLCAzMiBjb21tYW5kIHNsb3RzLCA2IEdicHMs
IFNBVEEgbW9kZQpbICAgIDEuNzM5MzE2XSBhaGNpIDAwMDA6MDA6MTEuMDogNC80IHBvcnRz
IGltcGxlbWVudGVkIChwb3J0IG1hc2sgMHgzYykKWyAgICAxLjczOTMxOF0gYWhjaSAwMDAw
OjAwOjExLjA6IGZsYWdzOiA2NGJpdCBuY3Egc250ZiBpbGNrIHBtIGxlZCBjbG8gcG1wIHBp
byBzbHVtIHBhcnQgClsgICAgMS43NDA3NDZdIHNjc2kgaG9zdDA6IGFoY2kKWyAgICAxLjc0
MDk4N10gc2NzaSBob3N0MTogYWhjaQpbICAgIDEuNzQxMTM3XSBzY3NpIGhvc3QyOiBhaGNp
ClsgICAgMS43NDEyODhdIHNjc2kgaG9zdDM6IGFoY2kKWyAgICAxLjc0MTQzNV0gc2NzaSBo
b3N0NDogYWhjaQpbICAgIDEuNzQxNTgyXSBzY3NpIGhvc3Q1OiBhaGNpClsgICAgMS43NDE2
MzVdIGF0YTE6IERVTU1ZClsgICAgMS43NDE2MzddIGF0YTI6IERVTU1ZClsgICAgMS43NDE2
MzldIGF0YTM6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTEwMjRAMHhmZWIwYjAwMCBwb3J0
IDB4ZmViMGIyMDAgaXJxIDE5IGxwbS1wb2wgMwpbICAgIDEuNzQxNjQxXSBhdGE0OiBTQVRB
IG1heCBVRE1BLzEzMyBhYmFyIG0xMDI0QDB4ZmViMGIwMDAgcG9ydCAweGZlYjBiMjgwIGly
cSAxOSBscG0tcG9sIDMKWyAgICAxLjc0MTY0NF0gYXRhNTogU0FUQSBtYXggVURNQS8xMzMg
YWJhciBtMTAyNEAweGZlYjBiMDAwIHBvcnQgMHhmZWIwYjMwMCBpcnEgMTkgbHBtLXBvbCAz
ClsgICAgMS43NDE2NDZdIGF0YTY6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTEwMjRAMHhm
ZWIwYjAwMCBwb3J0IDB4ZmViMGIzODAgaXJxIDE5IGxwbS1wb2wgMwpbICAgIDEuNzQxODQ1
XSBhaGNpIDAwMDA6MDQ6MDAuMDogU1NTIGZsYWcgc2V0LCBwYXJhbGxlbCBidXMgc2NhbiBk
aXNhYmxlZApbICAgIDEuNzQxODY3XSBhaGNpIDAwMDA6MDQ6MDAuMDogQUhDSSB2ZXJzIDAw
MDEuMDIwMCwgMzIgY29tbWFuZCBzbG90cywgNiBHYnBzLCBTQVRBIG1vZGUKWyAgICAxLjc0
MTg2OV0gYWhjaSAwMDAwOjA0OjAwLjA6IDIvMiBwb3J0cyBpbXBsZW1lbnRlZCAocG9ydCBt
YXNrIDB4MykKWyAgICAxLjc0MTg3MV0gYWhjaSAwMDAwOjA0OjAwLjA6IGZsYWdzOiA2NGJp
dCBuY3Egc250ZiBzdGFnIGxlZCBjbG8gcG1wIHBpbyBzbHVtIHBhcnQgY2NjIHN4cyAKWyAg
ICAxLjc0MjE5MV0gc2NzaSBob3N0NjogYWhjaQpbICAgIDEuNzQyNDIwXSBzY3NpIGhvc3Q3
OiBhaGNpClsgICAgMS43NDI0ODhdIGF0YTc6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTUx
MkAweGZlODAwMDAwIHBvcnQgMHhmZTgwMDEwMCBpcnEgNDMgbHBtLXBvbCAwClsgICAgMS43
NDI0OTJdIGF0YTg6IFNBVEEgbWF4IFVETUEvMTMzIGFiYXIgbTUxMkAweGZlODAwMDAwIHBv
cnQgMHhmZTgwMDE4MCBpcnEgNDMgbHBtLXBvbCAwClsgICAgMi4wNTE4MjJdIGF0YTc6IFNB
VEEgbGluayBkb3duIChTU3RhdHVzIDAgU0NvbnRyb2wgMzAwKQpbICAgIDIuMjA4MTM4XSBh
dGEzOiBTQVRBIGxpbmsgdXAgNi4wIEdicHMgKFNTdGF0dXMgMTMzIFNDb250cm9sIDMwMCkK
WyAgICAyLjIwODE3Ml0gYXRhNjogU0FUQSBsaW5rIHVwIDMuMCBHYnBzIChTU3RhdHVzIDEy
MyBTQ29udHJvbCAzMDApClsgICAgMi4yMDgxOTddIGF0YTQ6IFNBVEEgbGluayB1cCAxLjUg
R2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQpbICAgIDIuMjA4MjI5XSBhdGE1OiBT
QVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMwMCkKWyAgICAy
LjIwODM1MV0gYXRhMy4wMDogTW9kZWwgJ1NhbXN1bmcgU1NEIDg3MCBRVk8gMlRCJywgcmV2
ICdTVlEwMkI2UScsIGFwcGx5aW5nIHF1aXJrczogbm9uY3F0cmltIHplcm9hZnRlcnRyaW0g
bm9uY3FvbmF0aQpbICAgIDIuMjA4MzkyXSBhdGEzLjAwOiBzdXBwb3J0cyBEUk0gZnVuY3Rp
b25zIGFuZCBtYXkgbm90IGJlIGZ1bGx5IGFjY2Vzc2libGUKWyAgICAyLjIwODM5NF0gYXRh
My4wMDogQVRBLTExOiBTYW1zdW5nIFNTRCA4NzAgUVZPIDJUQiwgU1ZRMDJCNlEsIG1heCBV
RE1BLzEzMwpbICAgIDIuMjA4Mzk2XSBhdGEzLjAwOiAzOTA3MDI5MTY4IHNlY3RvcnMsIG11
bHRpIDE6IExCQTQ4IE5DUSAobm90IHVzZWQpClsgICAgMi4yMDg3NTFdIGF0YTQuMDA6IEFU
QS03OiBNQVhUT1IgU1RNMzI1MDMxMEFTLCAzLkFBQywgbWF4IFVETUEvMTMzClsgICAgMi4y
MDg3NTVdIGF0YTQuMDA6IDQ4ODM5NzE2OCBzZWN0b3JzLCBtdWx0aSAxNjogTEJBNDggTkNR
IChkZXB0aCAzMikKWyAgICAyLjIwODgyMF0gYXRhNS4wMDogQVRBUEk6IEFTVVMgICAgQkMt
MTJEMkhULCAxLjAwLCBtYXggVURNQS8xMDAKWyAgICAyLjIwOTI5MF0gYXRhNi4wMDogQVRB
LTg6IFNUMzEwMDA1MjhBUywgQ0MzOCwgbWF4IFVETUEvMTMzClsgICAgMi4yMDkyOTRdIGF0
YTYuMDA6IDE5NTM1MjUxNjggc2VjdG9ycywgbXVsdGkgMTY6IExCQTQ4IE5DUSAoZGVwdGgg
MzIpClsgICAgMi4yMDkzODhdIGF0YTUuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTAwClsg
ICAgMi4yMDk0NjddIGF0YTQuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzClsgICAgMi4y
MTA1NzJdIGF0YTYuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMzClsgICAgMi4yMTI4NzFd
IGF0YTMuMDA6IEZlYXR1cmVzOiBUcnVzdCBEZXYtU2xlZXAKWyAgICAyLjIxMzE4M10gYXRh
My4wMDogc3VwcG9ydHMgRFJNIGZ1bmN0aW9ucyBhbmQgbWF5IG5vdCBiZSBmdWxseSBhY2Nl
c3NpYmxlClsgICAgMi4yMTgyMzFdIGF0YTMuMDA6IGNvbmZpZ3VyZWQgZm9yIFVETUEvMTMz
ClsgICAgMi4yMjg1OTJdIHNjc2kgMjowOjA6MDogRGlyZWN0LUFjY2VzcyAgICAgQVRBICAg
ICAgU2Ftc3VuZyBTU0QgODcwICAyQjZRIFBROiAwIEFOU0k6IDUKWyAgICAyLjIyODk2MV0g
c2NzaSAzOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBBVEEgICAgICBNQVhUT1IgU1RNMzI1
MDMxIEMgICAgUFE6IDAgQU5TSTogNQpbICAgIDIuMjg4NjgxXSBzY3NpIDU6MDowOjA6IERp
cmVjdC1BY2Nlc3MgICAgIEFUQSAgICAgIFNUMzEwMDA1MjhBUyAgICAgQ0MzOCBQUTogMCBB
TlNJOiA1ClsgICAgMi41OTk3MTddIGF0YTg6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAg
U0NvbnRyb2wgMzAwKQpbICAgIDIuNjA4MzgzXSBhdGEzLjAwOiBFbmFibGluZyBkaXNjYXJk
X3plcm9lc19kYXRhClsgICAgMi42MDkyMTFdIGF0YTMuMDA6IEVuYWJsaW5nIGRpc2NhcmRf
emVyb2VzX2RhdGEK

--------------DhKS6kFF4k5xkk27sIyHql4b--

