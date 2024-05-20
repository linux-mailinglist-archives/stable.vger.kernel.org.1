Return-Path: <stable+bounces-45451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB18CA09D
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228981F219E8
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB8137921;
	Mon, 20 May 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diOGU/qx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4D20EB;
	Mon, 20 May 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222070; cv=none; b=ruphm2ZcEEOJCoXA9kNIt5PGqFl9Z4M7S5kdQ64EZrFMgzDHvtP9u4skyUpD6+AZ1bzm2vUcEw2czC4RH56nJr9wlTO9ry6vrLQiXGanNmQhPxUORR72m6Wo91FHjGP4QL8GbNEwrhd3fYF9IBgiLwewOA9jtqcCPU8y4YvfoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222070; c=relaxed/simple;
	bh=5KW37w/qWnd5qtEIzpi8uprnEGTRl+l+6wTCcR34AFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEfKYInZUBKEJ/Hy0rhiaW9wuDlXGT7Ok/HwFf73B/aYe009fpC9TEyoETXaVVgzu1GVn9Uf14he3aKcVMbqJeQPLpfeN9GLgHsEpXOsSPF87h+8nY2C2GhsFDx2f4AAn7q9RJjoUqOhpg/IkIKqS0FuonRcwZ4hASzKv7M93JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diOGU/qx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716222066; x=1747758066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5KW37w/qWnd5qtEIzpi8uprnEGTRl+l+6wTCcR34AFw=;
  b=diOGU/qxOTYBmxoctizc19a/zGXI6Z2zzR1g0jucS8Q41KounUaRwIVr
   +n0Tyu3nPumHOyYyJplvf9e7efM/5BcQAouXLwuh7nt8PdEI/XxTjRnQJ
   nts/WKMV5Zia4TPR/fpZfVTcuWrv6cWU3aMQ9eyp83itVElZ+5715ZqFY
   gDVfd6ODcaHlq/OCSrtx8q0lz07Q6QeWFYWVID7jjRBsB+UVGe8wG1o4T
   M0rhM8/G4IARJ9B+KihbbgaKONrgDxv9gLm8TOQHjkIeIZA51PC0XkQi6
   2D795mxVuyaWVs2tKxiDhAw62NqtajJmsvHk+toK5NnkJx+OcKdQXsW+w
   g==;
X-CSE-ConnectionGUID: w0E5aKvtRmKotP5GhwP/4A==
X-CSE-MsgGUID: zV0jQ8ewRfSWu2e4u53TvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12472948"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12472948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 09:21:05 -0700
X-CSE-ConnectionGUID: q+YURvifRRisIMExg34QFg==
X-CSE-MsgGUID: jSTIi/ctSPqeK3QpymROiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37533400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 20 May 2024 09:21:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0FE8B3C8; Mon, 20 May 2024 19:21:00 +0300 (EEST)
Date: Mon, 20 May 2024 19:21:00 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Gia <giacomo.gio@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240520162100.GI1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61-664b6880-3-6826fc80@79948770>

Hi,

On Mon, May 20, 2024 at 05:12:40PM +0200, Benjamin Böhmke wrote:
> On Monday, May 20, 2024 16:41 CEST, Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
> > On 5/20/2024 09:39, Christian Heusel wrote:
> > > On 24/05/06 02:53PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >> [CCing Mario, who asked for the two suspected commits to be backported]
> > >>
> > >> On 06.05.24 14:24, Gia wrote:
> > >>> Hello, from 6.8.7=>6.8.8 I run into a similar problem with my Caldigit
> > >>> TS3 Plus Thunderbolt 3 dock.
> > >>>
> > >>> After the update I see this message on boot "xHCI host controller not
> > >>> responding, assume dead" and the dock is not working anymore. Kernel
> > >>> 6.8.7 works great.
> > > 
> > > We now have some further information on the matter as somebody was kind
> > > enough to bisect the issue in the [Arch Linux Forums][0]:
> > > 
> > >      cc4c94a5f6c4 ("thunderbolt: Reset topology created by the boot firmware")
> > > 
> > > This is a stable commit id, the relevant mainline commit is:
> > > 
> > >      59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
> > > 
> > > The other reporter created [a issue][1] in our bugtracker, which I'll
> > > leave here just for completeness sake.
> > > 
> > > Reported-by: Benjamin Böhmke <benjamin@boehmke.net>
> > > Reported-by: Gia <giacomo.gio@gmail.com>
> > > Bisected-by: Benjamin Böhmke <benjamin@boehmke.net>
> > > 
> > > The person doing the bisection also offered to chime in here if further
> > > debugging is needed!
> > > 
> > > Also CC'ing the Commitauthors & Subsystem Maintainers for this report.
> > > 
> > > Cheers,
> > > Christian
> > > 
> > > [0]: https://bbs.archlinux.org/viewtopic.php?pid=2172526
> > > [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/48
> > > 
> > > #regzbot introduced: 59a54c5f3dbd
> > > #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/48
> > 
> > As I mentioned in my other email I would like to collate logs onto a 
> > kernel Bugzilla.  With these two cases:
> > 
> > thunderbolt.dyndbg=+p
> > thunderbolt.dyndbg=+p thunderbolt.host_reset=false
> > 
> > Also what is the value for:
> > 
> > $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection
> 
> I attached the requested kernel logs as text files (hope this is ok).
> In both cases I used the stable ArchLinux kernel 6.9.1
> 
> The iommu_dma_protection is both cases "1".
> 
> Best Regards
> Benjamin

After reset the link comes up just fine but there is one thing that I
noticed:

> [    8.225355] thunderbolt 0-0:1.1: NVM version 7.0
> [    8.225360] thunderbolt 0-0:1.1: new retimer found, vendor=0x8087 device=0x15ee
> [    8.226410] thunderbolt 0000:00:0d.2: current switch config:
> [    8.226413] thunderbolt 0000:00:0d.2:  Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB Version: 16)
> [    8.226417] thunderbolt 0000:00:0d.2:   Max Port Number: 13
> [    8.226420] thunderbolt 0000:00:0d.2:   Config:
> [    8.226421] thunderbolt 0000:00:0d.2:    Upstream Port Number: 0 Depth: 0 Route String: 0x0 Enabled: 0, PlugEventsDelay: 10ms
> [    8.226424] thunderbolt 0000:00:0d.2:    unknown1: 0x0 unknown4: 0x0
> [    8.227755] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0
> [    8.234944] thunderbolt 0000:00:0d.2: initializing Switch at 0x1 (depth: 1, up port: 1)
> [    8.246755] thunderbolt 0000:00:0d.2: acking hot plug event on 1:2
> [    8.267378] thunderbolt 0000:00:0d.2: 1: reading DROM (length: 0x6d)
> [    8.879296] thunderbolt 0000:00:0d.2: 1: DROM version: 1
> [    8.880631] thunderbolt 0000:00:0d.2: 1: uid: 0x3d600630c86400
> [    8.884540] thunderbolt 0000:00:0d.2:  Port 1: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
> [    8.884562] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
> [    8.884564] thunderbolt 0000:00:0d.2:   Max counters: 16
> [    8.884566] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
> [    8.884567] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/2
> [    8.887782] thunderbolt 0000:00:0d.2:  Port 2: 8086:15ef (Revision: 6, TB Version: 1, Type: Port (0x1))
> [    8.887787] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 19/19
> [    8.887789] thunderbolt 0000:00:0d.2:   Max counters: 16
> [    8.887791] thunderbolt 0000:00:0d.2:   NFC Credits: 0x3c00000
> [    8.887792] thunderbolt 0000:00:0d.2:   Credits (total/control): 60/2
> [    8.887794] thunderbolt 0000:00:0d.2: 1:3: disabled by eeprom
> [    8.887795] thunderbolt 0000:00:0d.2: 1:4: disabled by eeprom
> [    8.887796] thunderbolt 0000:00:0d.2: 1:5: disabled by eeprom
> [    8.887797] thunderbolt 0000:00:0d.2: 1:6: disabled by eeprom
> [    8.887798] thunderbolt 0000:00:0d.2: 1:7: disabled by eeprom
> [    8.888053] thunderbolt 0000:00:0d.2:  Port 8: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100102))
> [    8.888056] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> [    8.888057] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.888058] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.888059] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.888848] thunderbolt 0000:00:0d.2:  Port 9: 8086:15ef (Revision: 6, TB Version: 1, Type: PCIe (0x100101))
> [    8.888850] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> [    8.888851] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.888852] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.888852] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.889379] thunderbolt 0000:00:0d.2:  Port 10: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> [    8.889381] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
> [    8.889382] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.889383] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.889384] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.890457] thunderbolt 0000:00:0d.2:  Port 11: 8086:15ef (Revision: 6, TB Version: 1, Type: DP/HDMI (0xe0102))
> [    8.890459] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 9/9
> [    8.890460] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.890461] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.890462] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.890721] thunderbolt 0000:00:0d.2:  Port 12: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
> [    8.890723] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> [    8.890724] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.890725] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.890726] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.891534] thunderbolt 0000:00:0d.2:  Port 13: 8086:15ea (Revision: 6, TB Version: 1, Type: Inactive (0x0))
> [    8.891545] thunderbolt 0000:00:0d.2:   Max hop id (in/out): 8/8
> [    8.891551] thunderbolt 0000:00:0d.2:   Max counters: 2
> [    8.891557] thunderbolt 0000:00:0d.2:   NFC Credits: 0x800000
> [    8.891564] thunderbolt 0000:00:0d.2:   Credits (total/control): 8/0
> [    8.891825] thunderbolt 0000:00:0d.2: 1: current link speed 10.0 Gb/s

Here it is 10G instead of 20G which limits the bandwidth available for
DP tunneling.

...

> [    9.297112] pci 0000:05:00.0: [8086:15f0] type 00 class 0x0c0330 PCIe Endpoint
> [    9.297146] pci 0000:05:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
> [    9.297249] pci 0000:05:00.0: enabling Extended Tags
> [    9.297479] pci 0000:05:00.0: supports D1 D2
> [    9.297481] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    9.297717] pci 0000:05:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 0000:00:07.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)

The xHCI comes up just fine though.

> [    9.300388] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [    9.300397] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 5
> [    9.301802] xhci_hcd 0000:05:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> [    9.302393] xhci_hcd 0000:05:00.0: xHCI Host Controller
> [    9.302398] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus number 6
> [    9.302401] xhci_hcd 0000:05:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> [    9.302459] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.09
> [    9.302462] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    9.302465] usb usb5: Product: xHCI Host Controller
> [    9.302466] usb usb5: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
> [    9.302468] usb usb5: SerialNumber: 0000:05:00.0
> [    9.302783] hub 5-0:1.0: USB hub found
> [    9.302794] hub 5-0:1.0: 2 ports detected
> [    9.302992] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.09
> [    9.302995] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    9.302997] usb usb6: Product: xHCI Host Controller
> [    9.302998] usb usb6: Manufacturer: Linux 6.9.1-arch1-1 xhci-hcd
> [    9.303000] usb usb6: SerialNumber: 0000:05:00.0
> [    9.303557] hub 6-0:1.0: USB hub found
> [    9.303567] hub 6-0:1.0: 2 ports detected
> [    9.552443] usb 5-1: new high-speed USB device number 2 using xhci_hcd
> [   10.130905] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read done
> [   10.131029] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed bandwidth 0/17280 Mb/s
> [   10.131047] thunderbolt 0000:00:0d.2: bandwidth consumption changed, re-calculating estimated bandwidth
> [   10.131051] thunderbolt 0000:00:0d.2: re-calculating bandwidth estimation for group 1
> [   10.131198] thunderbolt 0000:00:0d.2: bandwidth estimation for group 1 done
> [   10.131206] thunderbolt 0000:00:0d.2: bandwidth re-calculation done
> [   10.131212] thunderbolt 0000:00:0d.2: 1: TMU: mode change uni-directional, LowRes -> uni-directional, HiFi requested
> [   10.135515] thunderbolt 0000:00:0d.2: 1: TMU: mode set to: uni-directional, HiFi
> [   10.136473] thunderbolt 0000:00:0d.2: 0:6: DP IN available
> [   10.136606] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
> [   10.136610] thunderbolt 0000:00:0d.2: 0:6: no suitable DP OUT adapter available, not tunneling
> [   10.136743] thunderbolt 0000:00:0d.2: 1:11: DP OUT resource available after hotplug
> [   10.136748] thunderbolt 0000:00:0d.2: looking for DP IN <-> DP OUT pairs:
> [   10.136876] thunderbolt 0000:00:0d.2: 0:5: DP IN in use
> [   10.137568] thunderbolt 0000:00:0d.2: 0:6: DP IN available
> [   10.137687] thunderbolt 0000:00:0d.2: 1:10: DP OUT in use
> [   10.137820] thunderbolt 0000:00:0d.2: 1:11: DP OUT available
> [   10.139280] thunderbolt 0000:00:0d.2: 0: allocated DP resource for port 6
> [   10.139286] thunderbolt 0000:00:0d.2: 0:6: attached to bandwidth group 1
> [   10.139694] thunderbolt 0000:00:0d.2: 0:1: link maximum bandwidth 18000/18000 Mb/s
> [   10.140680] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read done
> [   10.140829] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed bandwidth 0/17280 Mb/s
> [   10.140963] thunderbolt 0000:00:0d.2: 1:1: link maximum bandwidth 18000/18000 Mb/s
> [   10.141892] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): DPRX read done
> [   10.142027] thunderbolt 0000:00:0d.2: 0:5 <-> 1:10 (DP): consumed bandwidth 0/17280 Mb/s
> [   10.142033] thunderbolt 0000:00:0d.2: available bandwidth for new DP tunnel 18000/720 Mb/s
> [   10.142052] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): activating
> [   10.143353] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP IN maximum supported bandwidth 8100 Mb/s x4 = 25920 Mb/s
> [   10.143360] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): DP OUT maximum supported bandwidth 5400 Mb/s x4 = 17280 Mb/s
> [   10.143366] thunderbolt 0000:00:0d.2: 0:6 <-> 1:11 (DP): not enough bandwidth
> [   10.143371] thunderbolt 0000:00:0d.2: 1:11: DP tunnel activation failed, aborting

However, the second DP tunnel fails because of no bandwidth.

> [   10.143489] thunderbolt 0000:00:0d.2: 0:6: detached from bandwidth group 1
> [   10.144883] thunderbolt 0000:00:0d.2: 0: released DP resource for port 6
> [   14.902955] usb 5-1: unable to get BOS descriptor set
> [   14.906143] usb 5-1: New USB device found, idVendor=2188, idProduct=0610, bcdDevice=70.42
> [   14.906167] usb 5-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   14.906175] usb 5-1: Product: USB2.1 Hub
> [   14.906183] usb 5-1: Manufacturer: CalDigit, Inc.
> [   14.908660] hub 5-1:1.0: USB hub found
> [   14.909135] hub 5-1:1.0: 4 ports detected
> [   15.026182] usb 6-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
> [   15.050199] usb 6-1: New USB device found, idVendor=2188, idProduct=0625, bcdDevice=70.42
> [   15.050223] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   15.050231] usb 6-1: Product: USB3.1 Gen2 Hub
> [   15.050237] usb 6-1: Manufacturer: CalDigit, Inc.
> [   15.053712] hub 6-1:1.0: USB hub found
> [   15.054279] hub 6-1:1.0: 4 ports detected
> [   15.215877] usb 5-1.4: new high-speed USB device number 3 using xhci_hcd
> [   15.333676] usb 5-1.4: New USB device found, idVendor=2188, idProduct=0611, bcdDevice=93.06
> [   15.333703] usb 5-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   15.333711] usb 5-1.4: Product: USB2.1 Hub
> [   15.333718] usb 5-1.4: Manufacturer: CalDigit, Inc.
> [   15.336484] hub 5-1.4:1.0: USB hub found
> [   15.336797] hub 5-1.4:1.0: 4 ports detected
> [   15.402943] usb 6-1.1: new SuperSpeed USB device number 3 using xhci_hcd
> [   15.425589] usb 6-1.1: New USB device found, idVendor=2188, idProduct=0754, bcdDevice= 0.06
> [   15.425615] usb 6-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=2
> [   15.425623] usb 6-1.1: Product: USB-C Pro Card Reader
> [   15.425691] usb 6-1.1: Manufacturer: CalDigit
> [   15.425697] usb 6-1.1: SerialNumber: 000000000006
> [   15.432231] usb-storage 6-1.1:1.0: USB Mass Storage device detected
> [   15.433690] scsi host0: usb-storage 6-1.1:1.0
> [   15.506218] usb 6-1.4: new SuperSpeed USB device number 4 using xhci_hcd
> [   15.528220] usb 6-1.4: New USB device found, idVendor=2188, idProduct=0620, bcdDevice=93.06
> [   15.528237] usb 6-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   15.528241] usb 6-1.4: Product: USB3.1 Gen1 Hub
> [   15.528244] usb 6-1.4: Manufacturer: CalDigit, Inc.
> [   15.531198] hub 6-1.4:1.0: USB hub found
> [   15.531506] hub 6-1.4:1.0: 4 ports detected
> [   15.649217] usb 5-1.4.1: new high-speed USB device number 4 using xhci_hcd
> [   15.989548] usb 6-1.4.4: new SuperSpeed USB device number 5 using xhci_hcd
> [   16.007996] usb 6-1.4.4: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=31.00
> [   16.008021] usb 6-1.4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> [   16.008029] usb 6-1.4.4: Product: USB 10/100/1000 LAN
> [   16.008035] usb 6-1.4.4: Manufacturer: Realtek
> [   16.008040] usb 6-1.4.4: SerialNumber: 001001000
> [   16.090287] r8152-cfgselector 6-1.4.4: reset SuperSpeed USB device number 5 using xhci_hcd
> [   16.136796] r8152 6-1.4.4:1.0: load rtl8153b-2 v2 04/27/23 successfully
> [   16.171430] r8152 6-1.4.4:1.0 eth0: v1.12.13
> [   16.209513] r8152 6-1.4.4:1.0 enp5s0u1u4u4: renamed from eth0
> [   16.453330] scsi 0:0:0:0: Direct-Access     CalDigit SD Card Reader   0006 PQ: 0 ANSI: 6
> [   16.454420] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   16.455908] sd 0:0:0:0: [sda] Media removed, stopped polling
> [   16.457173] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [   16.497559] usb 5-1.4.1: New USB device found, idVendor=2188, idProduct=4042, bcdDevice= 0.06
> [   16.497567] usb 5-1.4.1: New USB device strings: Mfr=3, Product=1, SerialNumber=0
> [   16.497570] usb 5-1.4.1: Product: CalDigit USB-C Pro Audio
> [   16.497572] usb 5-1.4.1: Manufacturer: CalDigit Inc.
> [   16.920216] ucsi_acpi USBC000:00: possible UCSI driver bug 1
> [   17.494492] input: CalDigit Inc. CalDigit USB-C Pro Audio as /devices/pci0000:00/0000:00:07.0/0000:03:00.0/0000:04:02.0/0000:05:00.0/usb5/5-1/5-1.4/5-1.4.1/5-1.4.1:1.3/0003:2188:4042.0005/input/input20
> [   17.550258] hid-generic 0003:2188:4042.0005: input,hidraw2: USB HID v1.11 Device [CalDigit Inc. CalDigit USB-C Pro Audio] on usb-0000:05:00.0-1.4.1/input3
> [   19.609816] r8152 6-1.4.4:1.0 enp5s0u1u4u4: carrier on

All the USB devices seem to work fine (assuming I read this right).

There is the DP tunneling limitation but other than that how the dock
does not work? At least reading this log everything else seems to be
fine except the second monitor?

Now it is interesting why the link is only 20G and not 40G. I do have
this same device and it gets the link up as 40G just fine:

[   17.867868] thunderbolt 0000:00:0d.2: 1: current link speed 20.0 Gb/s
[   17.867869] thunderbolt 0000:00:0d.2: 1: current link width symmetric, single lane
[   17.868437] thunderbolt 0000:00:0d.2: 0:1: total credits changed 120 -> 60
[   17.868625] thunderbolt 0000:00:0d.2: 0:2: total credits changed 0 -> 60
[   17.872472] thunderbolt 0000:00:0d.2: 1: TMU: current mode: bi-directional, HiFi
[   17.872608] thunderbolt 0-1: new device found, vendor=0x3d device=0x11
[   17.879102] thunderbolt 0-1: CalDigit, Inc. TS3 Plus

Do you use a Thunderbolt cable or some regular type-C one? There is the
lightning symbol on the connector when it is Thunderbolt one.

