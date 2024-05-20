Return-Path: <stable+bounces-45452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4908CA0E8
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD661F21A6A
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EBF137C20;
	Mon, 20 May 2024 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=boehmke.net header.i=@boehmke.net header.b="QoCu59Up"
X-Original-To: stable@vger.kernel.org
Received: from mail.boehmke.net (elch8.fetterelch.de [159.69.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70D79EF;
	Mon, 20 May 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.48.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224009; cv=none; b=YDwvkB8X549KEPAi52KQpaZA2c6tuq5/8hAGztQcyrvAtvIKKvn7R/srPFSvMphqYJRxyfCU+RStIg23fJfPsntnI2w4gHNPW8hPtcJ6O6aucMzYx2ip4kltbWZrkl17H8K3HJ9MXX+q0MNOZfOYn1+Hw7TWdTqx4j1KYIMWXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224009; c=relaxed/simple;
	bh=E1jb9QHJ0SA9duK2Db+Tgl5ifyUnmgwNnxWSkIKRTE0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=lMClgTxaW9WO5Fpe5dIsZHPh3waRfGVcEBPrQFF6W7bjdwFmZMt7TX41CiLzyOLqyjTL+Km2OQ1M796FDyOgxpsv61bNiRff1WsTO5BC21BxsAZceh6pXOTVQUcwUGzCR7xGm707ireEFV+SKrdhZ+oC5pNmo1tMq0N3i92+IX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boehmke.net; spf=pass smtp.mailfrom=boehmke.net; dkim=pass (2048-bit key) header.d=boehmke.net header.i=@boehmke.net header.b=QoCu59Up; arc=none smtp.client-ip=159.69.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=boehmke.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boehmke.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 1BFE680CF8;
	Mon, 20 May 2024 18:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boehmke.net; s=dkim;
	t=1716224002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tkD+x3Qb4/cxY5iYM6AudCLVAg0q8yI4c9yFzJugoC8=;
	b=QoCu59Uputo1j0f5sChccA68A1jufaT9fhyRlln76pbX8GGqI2wWgbxI5FahPe18RHHFB8
	/yDEkbuRRNXelR1aCDIyZqzVk0UcUgMTzdSiplmGbaNtTXDC44qahG6D0TDsPupw3yiC1+
	hOVevU0GBo+pdyr+0pZtzv/EDzA+l8VGYs+d96x6xd72r03ueMIJmdDz1VTt3aljeSoNci
	VXfcQMybR8Ed/w78UD12lVW1btszBlRMm522ah174ggG9WZu3mxbS45PZpCxuiypZdgIQS
	2vKof1vzoF2BRB5E7TmTd1DT9pbXTk+dJ91hhy16sIRfv++2+l6jE7aKM2ru3Q==
From: =?utf-8?q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>
In-Reply-To: <20240520162100.GI1421138@black.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770> <20240520162100.GI1421138@black.fi.intel.com>
Date: Mon, 20 May 2024 18:53:18 +0200
Cc: "Mario Limonciello" <mario.limonciello@amd.com>, "Christian Heusel" <christian@heusel.eu>, "Linux regressions mailing list" <regressions@lists.linux.dev>, "Gia" <giacomo.gio@gmail.com>, =?utf-8?q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, =?utf-8?q?stable=40vger=2Ekernel=2Eorg?= <stable@vger.kernel.org>, =?utf-8?q?kernel=40micha=2Ezone?= <kernel@micha.zone>, "Andreas Noever" <andreas.noever@gmail.com>, "Michael Jamet" <michael.jamet@intel.com>, "Yehezkel Bernat" <YehezkelShB@gmail.com>, =?utf-8?q?linux-usb=40vger=2Ekernel=2Eorg?= <linux-usb@vger.kernel.org>, =?utf-8?q?S=2C_Sanath?= <Sanath.S@amd.com>
To: "Mika Westerberg" <mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d-664b8000-d-70f82e80@161590144>
Subject: =?utf-8?q?Re=3A?= [REGRESSION][BISECTED] =?utf-8?q?=22xHCI?= host 
 controller not =?utf-8?q?responding=2C?= assume =?utf-8?q?dead=22?= on 
 stable kernel > =?utf-8?q?6=2E8=2E7?=
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Monday, May 20, 2024 18:21 CEST, Mika Westerberg <mika.westerberg@li=
nux.intel.com> wrote:

> Hi,
>=20
> On Mon, May 20, 2024 at 05:12:40PM +0200, Benjamin B=C3=B6hmke wrote:
> > On Monday, May 20, 2024 16:41 CEST, Mario Limonciello <mario.limonc=
iello@amd.com> wrote:
> >=20
> > > On 5/20/2024 09:39, Christian Heusel wrote:
> > > > On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhu=
is) wrote:
> > > >> [CCing Mario, who asked for the two suspected commits to be ba=
ckported]
> > > >>
> > > >> On 06.05.24 14:24, Gia wrote:
> > > >>> Hello, from 6.8.7=3D>6.8.8 I run into a similar problem with =
my Caldigit
> > > >>> TS3 Plus Thunderbolt 3 dock.
> > > >>>
> > > >>> After the update I see this message on boot "xHCI host contro=
ller not
> > > >>> responding, assume dead" and the dock is not working anymore.=
 Kernel
> > > >>> 6.8.7 works great.
> > > >=20
> > > > We now have some further information on the matter as somebody =
was kind
> > > > enough to bisect the issue in the [Arch Linux Forums][0]:
> > > >=20
> > > >      cc4c94a5f6c4 ("thunderbolt: Reset topology created by the =
boot firmware")
> > > >=20
> > > > This is a stable commit id, the relevant mainline commit is:
> > > >=20
> > > >      59a54c5f3dbd ("thunderbolt: Reset topology created by the =
boot firmware")
> > > >=20
> > > > The other reporter created [a issue][1] in our bugtracker, whic=
h I'll
> > > > leave here just for completeness sake.
> > > >=20
> > > > Reported-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> > > > Reported-by: Gia <giacomo.gio@gmail.com>
> > > > Bisected-by: Benjamin B=C3=B6hmke <benjamin@boehmke.net>
> > > >=20
> > > > The person doing the bisection also offered to chime in here if=
 further
> > > > debugging is needed!
> > > >=20
> > > > Also CC'ing the Commitauthors & Subsystem Maintainers for this =
report.
> > > >=20
> > > > Cheers,
> > > > Christian
> > > >=20
> > > > [0]: https://bbs.archlinux.org/viewtopic.php?pid=3D2172526
> > > > [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/=
linux/-/issues/48
> > > >=20
> > > > #regzbot introduced: 59a54c5f3dbd
> > > > #regzbot link: https://gitlab.archlinux.org/archlinux/packaging=
/packages/linux/-/issues/48
> > >=20
> > > As I mentioned in my other email I would like to collate logs ont=
o a=20
> > > kernel Bugzilla.  With these two cases:
> > >=20
> > > thunderbolt.dyndbg=3D+p
> > > thunderbolt.dyndbg=3D+p thunderbolt.host=5Freset=3Dfalse
> > >=20
> > > Also what is the value for:
> > >=20
> > > $ cat /sys/bus/thunderbolt/devices/domain0/iommu=5Fdma=5Fprotecti=
on
> >=20
> > I attached the requested kernel logs as text files (hope this is ok=
).
> > In both cases I used the stable ArchLinux kernel 6.9.1
> >=20
> > The iommu=5Fdma=5Fprotection is both cases "1".
> >=20
> > Best Regards
> > Benjamin
>=20
> After reset the link comes up just fine but there is one thing that I
> noticed:
>=20
> > [    8.225355] thunderbolt 0-0:1.1: NVM version 7.0
> > [    8.225360] thunderbolt 0-0:1.1: new retimer found, vendor=3D0x8=
087 device=3D0x15ee
> > [    8.226410] thunderbolt 0000:00:0d.2: current switch config:
> > [    8.226413] thunderbolt 0000:00:0d.2:  Thunderbolt 3 Switch: 808=
6:15ef (Revision: 6, TB Version: 16)
> > [    8.226417] thunderbolt 0000:00:0d.2:   Max Port Number: 13
> > [    8.226420] thunderbolt 0000:00:0d.2:   Config:
> > [    8.226421] thunderbolt 0000:00:0d.2:    Upstream Port Number: 0=
 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
> > [    8.226424] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4:=
 0x0
> > [    8.227755] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-=
PTP, with index: 0
> > [    8.234944] thunderbolt 0000:00:0d.2: initializing Switch at 0x1=
 (depth: 1, up port: 1)
> > [    8.246755] thunderbolt 0000:00:0d.2: acking hot plug event on 1=
:2
> > [    8.267378] thunderbolt 0000:00:0d.2: 1: reading DROM (length: 0=
x6d)
> > [    8.879296] thunderbolt 0000:00:0d.2: 1: DROM version: 1
> > [    8.880631] thunderbolt 0000:00:0d.2: 1: uid: 0x3d600630c86400
> > [    8.884540] thunderbolt 0000:00:0d.2:  Port 1: 8086:15ef (Revisi=
on: 6, TB Version: 1, Type: Port (0x1))
> > [    8.884562] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/=
19
> > [    8.884564] thunderbolt 0000:00:0d.2:   Max counters: 16
> > [    8.884566] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
> > [    8.884567] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 60/2
> > [    8.887782] thunderbolt 0000:00:0d.2:  Port 2: 8086:15ef (Revisi=
on: 6, TB Version: 1, Type: Port (0x1))
> > [    8.887787] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/=
19
> > [    8.887789] thunderbolt 0000:00:0d.2:   Max counters: 16
> > [    8.887791] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
> > [    8.887792] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 60/2
> > [    8.887794] thunderbolt 0000:00:0d.2: 1:3: disabled by eeprom
> > [    8.887795] thunderbolt 0000:00:0d.2: 1:4: disabled by eeprom
> > [    8.887796] thunderbolt 0000:00:0d.2: 1:5: disabled by eeprom
> > [    8.887797] thunderbolt 0000:00:0d.2: 1:6: disabled by eeprom
> > [    8.887798] thunderbolt 0000:00:0d.2: 1:7: disabled by eeprom
> > [    8.888053] thunderbolt 0000:00:0d.2:  Port 8: 8086:15ef (Revisi=
on: 6, TB Version: 1, Type: PCIe (0x100102))
> > [    8.888056] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> > [    8.888057] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.888058] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.888059] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.888848] thunderbolt 0000:00:0d.2:  Port 9: 8086:15ef (Revisi=
on: 6, TB Version: 1, Type: PCIe (0x100101))
> > [    8.888850] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> > [    8.888851] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.888852] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.888852] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.889379] thunderbolt 0000:00:0d.2:  Port 10: 8086:15ef (Revis=
ion: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> > [    8.889381] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
> > [    8.889382] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.889383] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.889384] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.890457] thunderbolt 0000:00:0d.2:  Port 11: 8086:15ef (Revis=
ion: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> > [    8.890459] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
> > [    8.890460] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.890461] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.890462] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.890721] thunderbolt 0000:00:0d.2:  Port 12: 8086:15ea (Revis=
ion: 6, TB Version: 1, Type: Inactive (0x0))
> > [    8.890723] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> > [    8.890724] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.890725] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.890726] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.891534] thunderbolt 0000:00:0d.2:  Port 13: 8086:15ea (Revis=
ion: 6, TB Version: 1, Type: Inactive (0x0))
> > [    8.891545] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> > [    8.891551] thunderbolt 0000:00:0d.2:   Max counters: 2
> > [    8.891557] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> > [    8.891564] thunderbolt 0000:00:0d.2:   Credits (total/control):=
 8/0
> > [    8.891825] thunderbolt 0000:00:0d.2: 1: current link speed 10.0=
 Gb/s
>=20
> Here it is 10G instead of 20G which limits the bandwidth available fo=
r
> DP tunneling.
>=20
> ...
>=20
> > [    9.297112] pci 0000:05:00.0: [8086:15f0] type 00 class 0x0c0330=
 PCIe Endpoint
> > [    9.297146] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
> > [    9.297249] pci 0000:05:00.0: enabling Extended Tags
> > [    9.297479] pci 0000:05:00.0: supports D1 D2
> > [    9.297481] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot=
 D3cold
> > [    9.297717] pci 0000:05:00.0: 8.000 Gb/s available PCIe bandwidt=
h, limited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 =
Gb/s with 8.0 GT/s PCIe x4 link)
>=20
> The xHCI comes up just fine though.
>=20
> > [    9.300388] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
> > [    9.300397] xhci=5Fhcd 0000:05:00.0: new USB bus registered, ass=
igned bus number 5
> > [    9.301802] xhci=5Fhcd 0000:05:00.0: hcc params 0x200077c1 hci v=
ersion 0x110 quirks 0x0000000200009810
> > [    9.302393] xhci=5Fhcd 0000:05:00.0: xHCI Host Controller
> > [    9.302398] xhci=5Fhcd 0000:05:00.0: new USB bus registered, ass=
igned bus number 6
> > [    9.302401] xhci=5Fhcd 0000:05:00.0: Host supports USB 3.1 Enhan=
ced SuperSpeed
> > [    9.302459] usb usb5: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0002, bcdDevice=3D 6.09
> > [    9.302462] usb usb5: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    9.302465] usb usb5: Product: xHCI Host Controller
> > [    9.302466] usb usb5: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
> > [    9.302468] usb usb5: SerialNumber: 0000:05:00.0
> > [    9.302783] hub 5-0:1.0: USB hub found
> > [    9.302794] hub 5-0:1.0: 2 ports detected
> > [    9.302992] usb usb6: New USB device found, idVendor=3D1d6b, idP=
roduct=3D0003, bcdDevice=3D 6.09
> > [    9.302995] usb usb6: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1
> > [    9.302997] usb usb6: Product: xHCI Host Controller
> > [    9.302998] usb usb6: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
> > [    9.303000] usb usb6: SerialNumber: 0000:05:00.0
> > [    9.303557] hub 6-0:1.0: USB hub found
> > [    9.303567] hub 6-0:1.0: 2 ports detected
> > [    9.552443] usb 5-1: new high-speed USB device number 2 using xh=
ci=5Fhcd
> > [   10.130905] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX re=
ad done
> > [   10.131029] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consume=
d bandwidth 0/17280 Mb/s
> > [   10.131047] thunderbolt 0000:00:0d.2: bandwidth consumption chan=
ged, re-calculating estimated bandwidth
> > [   10.131051] thunderbolt 0000:00:0d.2: re-calculating bandwidth e=
stimation for group 1
> > [   10.131198] thunderbolt 0000:00:0d.2: bandwidth estimation for g=
roup 1 done
> > [   10.131206] thunderbolt 0000:00:0d.2: bandwidth re-calculation d=
one
> > [   10.131212] thunderbolt 0000:00:0d.2: 1: TMU: mode change uni-di=
rectional, LowRes -> uni-directional, HiFi requested
> > [   10.135515] thunderbolt 0000:00:0d.2: 1: TMU: mode set to: uni-d=
irectional, HiFi
> > [   10.136473] thunderbolt 0000:00:0d.2: 0:6: DP IN available
> > [   10.136606] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
> > [   10.136610] thunderbolt 0000:00:0d.2: 0:6: no suitable DP OUT ad=
apter available, not tunneling
> > [   10.136743] thunderbolt 0000:00:0d.2: 1:11: DP OUT resource avai=
lable after hotplug
> > [   10.136748] thunderbolt 0000:00:0d.2: looking for DP IN <-> DP O=
UT pairs:
> > [   10.136876] thunderbolt 0000:00:0d.2: 0:5: DP IN in use
> > [   10.137568] thunderbolt 0000:00:0d.2: 0:6: DP IN available
> > [   10.137687] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
> > [   10.137820] thunderbolt 0000:00:0d.2: 1:11: DP OUT available
> > [   10.139280] thunderbolt 0000:00:0d.2: 0: allocated DP resource f=
or port 6
> > [   10.139286] thunderbolt 0000:00:0d.2: 0:6: attached to bandwidth=
 group 1
> > [   10.139694] thunderbolt 0000:00:0d.2: 0:1: link maximum bandwidt=
h 18000/18000 Mb/s
> > [   10.140680] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX re=
ad done
> > [   10.140829] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consume=
d bandwidth 0/17280 Mb/s
> > [   10.140963] thunderbolt 0000:00:0d.2: 1:1: link maximum bandwidt=
h 18000/18000 Mb/s
> > [   10.141892] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX re=
ad done
> > [   10.142027] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consume=
d bandwidth 0/17280 Mb/s
> > [   10.142033] thunderbolt 0000:00:0d.2: available bandwidth for ne=
w DP tunnel 18000/720 Mb/s
> > [   10.142052] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): activat=
ing
> > [   10.143353] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP IN m=
aximum supported bandwidth 8100 Mb/s x4 =3D 25920 Mb/s
> > [   10.143360] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP OUT =
maximum supported bandwidth 5400 Mb/s x4 =3D 17280 Mb/s
> > [   10.143366] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): not eno=
ugh bandwidth
> > [   10.143371] thunderbolt 0000:00:0d.2: 1:11: DP tunnel activation=
 failed, aborting
>=20
> However, the second DP tunnel fails because of no bandwidth.
>=20
> > [   10.143489] thunderbolt 0000:00:0d.2: 0:6: detached from bandwid=
th group 1
> > [   10.144883] thunderbolt 0000:00:0d.2: 0: released DP resource fo=
r port 6
> > [   14.902955] usb 5-1: unable to get BOS descriptor set
> > [   14.906143] usb 5-1: New USB device found, idVendor=3D2188, idPr=
oduct=3D0610, bcdDevice=3D70.42
> > [   14.906167] usb 5-1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [   14.906175] usb 5-1: Product: USB2.1 Hub
> > [   14.906183] usb 5-1: Manufacturer: CalDigit, Inc.
> > [   14.908660] hub 5-1:1.0: USB hub found
> > [   14.909135] hub 5-1:1.0: 4 ports detected
> > [   15.026182] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device numb=
er 2 using xhci=5Fhcd
> > [   15.050199] usb 6-1: New USB device found, idVendor=3D2188, idPr=
oduct=3D0625, bcdDevice=3D70.42
> > [   15.050223] usb 6-1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [   15.050231] usb 6-1: Product: USB3.1 Gen2 Hub
> > [   15.050237] usb 6-1: Manufacturer: CalDigit, Inc.
> > [   15.053712] hub 6-1:1.0: USB hub found
> > [   15.054279] hub 6-1:1.0: 4 ports detected
> > [   15.215877] usb 5-1.4: new high-speed USB device number 3 using =
xhci=5Fhcd
> > [   15.333676] usb 5-1.4: New USB device found, idVendor=3D2188, id=
Product=3D0611, bcdDevice=3D93.06
> > [   15.333703] usb 5-1.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [   15.333711] usb 5-1.4: Product: USB2.1 Hub
> > [   15.333718] usb 5-1.4: Manufacturer: CalDigit, Inc.
> > [   15.336484] hub 5-1.4:1.0: USB hub found
> > [   15.336797] hub 5-1.4:1.0: 4 ports detected
> > [   15.402943] usb 6-1.1: new SuperSpeed USB device number 3 using =
xhci=5Fhcd
> > [   15.425589] usb 6-1.1: New USB device found, idVendor=3D2188, id=
Product=3D0754, bcdDevice=3D 0.06
> > [   15.425615] usb 6-1.1: New USB device strings: Mfr=3D3, Product=3D=
4, SerialNumber=3D2
> > [   15.425623] usb 6-1.1: Product: USB-C Pro Card Reader
> > [   15.425691] usb 6-1.1: Manufacturer: CalDigit
> > [   15.425697] usb 6-1.1: SerialNumber: 000000000006
> > [   15.432231] usb-storage 6-1.1:1.0: USB Mass Storage device detec=
ted
> > [   15.433690] scsi host0: usb-storage 6-1.1:1.0
> > [   15.506218] usb 6-1.4: new SuperSpeed USB device number 4 using =
xhci=5Fhcd
> > [   15.528220] usb 6-1.4: New USB device found, idVendor=3D2188, id=
Product=3D0620, bcdDevice=3D93.06
> > [   15.528237] usb 6-1.4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
> > [   15.528241] usb 6-1.4: Product: USB3.1 Gen1 Hub
> > [   15.528244] usb 6-1.4: Manufacturer: CalDigit, Inc.
> > [   15.531198] hub 6-1.4:1.0: USB hub found
> > [   15.531506] hub 6-1.4:1.0: 4 ports detected
> > [   15.649217] usb 5-1.4.1: new high-speed USB device number 4 usin=
g xhci=5Fhcd
> > [   15.989548] usb 6-1.4.4: new SuperSpeed USB device number 5 usin=
g xhci=5Fhcd
> > [   16.007996] usb 6-1.4.4: New USB device found, idVendor=3D0bda, =
idProduct=3D8153, bcdDevice=3D31.00
> > [   16.008021] usb 6-1.4.4: New USB device strings: Mfr=3D1, Produc=
t=3D2, SerialNumber=3D6
> > [   16.008029] usb 6-1.4.4: Product: USB 10/100/1000 LAN
> > [   16.008035] usb 6-1.4.4: Manufacturer: Realtek
> > [   16.008040] usb 6-1.4.4: SerialNumber: 001001000
> > [   16.090287] r8152-cfgselector 6-1.4.4: reset SuperSpeed USB devi=
ce number 5 using xhci=5Fhcd
> > [   16.136796] r8152 6-1.4.4:1.0: load rtl8153b-2 v2 04/27/23 succe=
ssfully
> > [   16.171430] r8152 6-1.4.4:1.0 eth0: v1.12.13
> > [   16.209513] r8152 6-1.4.4:1.0 enp5s0u1u4u4: renamed from eth0
> > [   16.453330] scsi 0:0:0:0: Direct-Access     CalDigit SD Card Rea=
der   0006 PQ: 0 ANSI: 6
> > [   16.454420] sd 0:0:0:0: Attached scsi generic sg0 type 0
> > [   16.455908] sd 0:0:0:0: [sda] Media removed, stopped polling
> > [   16.457173] sd 0:0:0:0: [sda] Attached SCSI removable disk
> > [   16.497559] usb 5-1.4.1: New USB device found, idVendor=3D2188, =
idProduct=3D4042, bcdDevice=3D 0.06
> > [   16.497567] usb 5-1.4.1: New USB device strings: Mfr=3D3, Produc=
t=3D1, SerialNumber=3D0
> > [   16.497570] usb 5-1.4.1: Product: CalDigit USB-C Pro Audio
> > [   16.497572] usb 5-1.4.1: Manufacturer: CalDigit Inc.
> > [   16.920216] ucsi=5Facpi USBC000:00: possible UCSI driver bug 1
> > [   17.494492] input: CalDigit Inc. CalDigit USB-C Pro Audio as /de=
vices/pci0000:00/0000:00:07.0/0000:03:00.0/0000:04:02.0/0000:05:00.0/us=
b5/5-1/5-1.4/5-1.4.1/5-1.4.1:1.3/0003:2188:4042.0005/input/input20
> > [   17.550258] hid-generic 0003:2188:4042.0005: input,hidraw2: USB =
HID v1.11 Device [CalDigit Inc. CalDigit USB-C Pro Audio] on usb-0000:0=
5:00.0-1.4.1/input3
> > [   19.609816] r8152 6-1.4.4:1.0 enp5s0u1u4u4: carrier on
>=20
> All the USB devices seem to work fine (assuming I read this right).

To keep the log small I unplugged all USB devices from the dock.
But even if connected I don't have issues with them.

>=20
> There is the DP tunneling limitation but other than that how the dock
> does not work? At least reading this log everything else seems to be
> fine except the second monitor?

Exactly only the second monitor is/was not working.

>=20
> Now it is interesting why the link is only 20G and not 40G. I do have
> this same device and it gets the link up as 40G just fine:
>=20
> [   17.867868] thunderbolt 0000:00:0d.2: 1: current link speed 20.0 G=
b/s
> [   17.867869] thunderbolt 0000:00:0d.2: 1: current link width symmet=
ric, single lane
> [   17.868437] thunderbolt 0000:00:0d.2: 0:1: total credits changed 1=
20 -> 60
> [   17.868625] thunderbolt 0000:00:0d.2: 0:2: total credits changed 0=
 -> 60
> [   17.872472] thunderbolt 0000:00:0d.2: 1: TMU: current mode: bi-dir=
ectional, HiFi
> [   17.872608] thunderbolt 0-1: new device found, vendor=3D0x3d devic=
e=3D0x11
> [   17.879102] thunderbolt 0-1: CalDigit, Inc. TS3 Plus
>=20

My dock is a little different model (see https://www.caldigit.com/usb-c=
-pro-dock/)
I don't have a CalDigit TS3 Plus.

> Do you use a Thunderbolt cable or some regular type-C one? There is t=
he
> lightning symbol on the connector when it is Thunderbolt one.

The dock was connected with a Thunderbolt cable, that I used for a coup=
le of years without any issues.
Based on the hint I replaced the cable and the issue is now gone for me=
.

I still don't understand why this happened as it was working great for =
years and is still working with kernels 6.8.7 or older.
But nevertheless sorry if I wasted time of anyone because of broken har=
dware.

Best Regards
Benjamin


