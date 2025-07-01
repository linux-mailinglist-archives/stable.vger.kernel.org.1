Return-Path: <stable+bounces-159142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51DAEF90C
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A26188E41C
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E89273D93;
	Tue,  1 Jul 2025 12:44:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7E18DB27;
	Tue,  1 Jul 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373869; cv=none; b=knShxpzA/XXOz9XaaNlawMZtP3ZK54ojN7f5fVz2/xSO4QEM5WohzYqaKsdnMGDvdidKTG5TMwcKNvKBsxneQSsKlyvX6qKXfXdInbAsWt6SwhPtgAbPQtAJlPkbzqxSHwgp0QZoCuP47KNEpNoMsjSaAqulJjF78VS3A5aG/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373869; c=relaxed/simple;
	bh=QbmbZQXsamqdNlHYd+X8ksgbc1iaoTp8ZFQxBPWYZ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvNJViOppNpXCmAbzUwE5Rb2EN78kpX3XPIhzwzd8DUgEueGxpnhd+4h4rXOMX9EYw8AVZs2qXd6pwm8mfNyHfzYObgnxl7CMVKTPxipCHNQl9tEKa/IG3KO8tMEl4K/lJmHSjC6fCd/gpb/a8+ltz1LqG1f/GNLyWIVfq+4H8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b10594812so3805046e87.1;
        Tue, 01 Jul 2025 05:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373865; x=1751978665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7HVFMPJAt1WeX7ij/W3jz0RpayYJ4zFyBYCplxep88=;
        b=Ff4Q8UPDwnmiG/RNN1rkz4u4gGI3oa3qXvp01B/Q8gHjvrCGhXT+8WquN3iW/mS6Bh
         DGFqAeJu5Fd4EqhOR/SeMeyW9TKfwpNpD8snCL9owdTSwY8yZ0YEmL3t9nQUxnpkiiDe
         8b+DNdkmrf1qgTDXXKYPoyNFqf6cwhz2XW4fTrmQG6XXTa2VHnD5SoM+/JVJHwV6Q2pZ
         qu5EIvAyuC5qWr7xKoLfVXNvnCqXY97682EFP27JWkB/hZ8wjmKfRn8uAKYdK0Nj8UZd
         Zx48rhCVGwTKSPcSur/ksgZf4a8Ev/nkDy6ayMbsEOQZRPA5Y8tgavu5q8LEZGuBONrx
         ZtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6LjEIWH/J1hASHgRk9OBEY6EOcbkD/Vs9YJvmPotvRmpT8d6oY7JEa4bdg4U4iOGk9TqcoQE=@vger.kernel.org, AJvYcCXbH+5qQpjCdgt4zC8uhIvAjXzJkrc3ptj6IumLwNLyX5jN2rM0BW/s+utzm1SW7zNB2JWedb1M@vger.kernel.org
X-Gm-Message-State: AOJu0YztzRtHpHpnhPM64TkDvJsD1WlUwpOy9TG2t/ZcxoMsasxe8o7+
	bqxhrkiohEtKmx36QLHv0jg68ykHOPYqSj1guAWZCWn7ik+NLwAn39NP
X-Gm-Gg: ASbGncuD7ACOq+Cb/gwyk+vas5AkKd7K+9lGea1B5S50TpjnhtbyQsLFdRbJExv3v5i
	LsjzBUfbq3WC7c+9pHwbZFyPsZnVTt5OSBSbQfDEMG0zMlnXwjnQtnn3haffZq+k+YoDGJjHpzf
	kCiv/g5Gu52RtdKDkcdxoCv5Jr0J9VMBSFfuio2HrYgORviKwaiv4HfWC8ehvs1yuWcTPFkr3yy
	t1Of2OkMGxCXHQyg0OJFHU83p9rSNRMapgCmM+/yRPGpWzdp6PTSGG62R+jxxPrC2aYu1qD8+SI
	fFUrad313XIcyJy8xRr5REKmhFd8u4gd8FhA0U1Uhj9Hp9xfXNUvlWMrudOVq3QFLSJ3CBcSXjs
	lV18PKZSp60oKuhcFisBz
X-Google-Smtp-Source: AGHT+IEBV0/jUI6S0AOqcejoj0LNvQaJQtl1dQ8lichKDf56ZXv2ttjcgUReFpC0tfClg4HsVD1pdQ==
X-Received: by 2002:a05:6512:3083:b0:549:5866:6489 with SMTP id 2adb3069b0e04-5550ba224f5mr5695523e87.47.1751373865250;
        Tue, 01 Jul 2025 05:44:25 -0700 (PDT)
Received: from onyx.my.domain (88-112-35-58.elisa-laajakaista.fi. [88.112.35.58])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2c615fsm1839514e87.154.2025.07.01.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:44:25 -0700 (PDT)
Date: Tue, 1 Jul 2025 15:44:23 +0300
From: Timo Teras <timo.teras@iki.fi>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: En-Wei WU <en-wei.wu@canonical.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <regressions@lists.linux.dev>,
 <stable@vger.kernel.org>, <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] Packet loss after hot-plugging
 ethernet cable on HP Zbook (Arrow Lake)
Message-ID: <20250701154423.1917c3de@onyx.my.domain>
In-Reply-To: <3023fe74-29c7-4a41-b805-c6b00fb0b3cc@intel.com>
References: <CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com>
	<3023fe74-29c7-4a41-b805-c6b00fb0b3cc@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Jul 2025 14:46:18 +0300
"Lifshits, Vitaly" <vitaly.lifshits@intel.com> wrote:

> On 7/1/2025 8:31 AM, En-Wei WU wrote:
> > Hi,
> > 
> > I'm seeing a regression on an HP ZBook using the e1000e driver
> > (chipset PCI ID: [8086:57a0]) -- the system can't get an IP address
> > after hot-plugging an Ethernet cable. In this case, the Ethernet
> > cable was unplugged at boot. The network interface eno1 was present
> > but stuck in the DHCP process. Using tcpdump, only TX packets were
> > visible and never got any RX -- indicating a possible packet loss or
> > link-layer issue.
> > 
> > This is on the vanilla Linux 6.16-rc4 (commit
> > 62f224733431dbd564c4fe800d4b67a0cf92ed10).
> > 
> > Bisect says it's this commit:
> > 
> > commit efaaf344bc2917cbfa5997633bc18a05d3aed27f
> > Author: Vitaly Lifshits <vitaly.lifshits@intel.com>
> > Date:   Thu Mar 13 16:05:56 2025 +0200
> > 
> >      e1000e: change k1 configuration on MTP and later platforms
> > 
> >      Starting from Meteor Lake, the Kumeran interface between the
> > integrated MAC and the I219 PHY works at a different frequency.
> > This causes sporadic MDI errors when accessing the PHY, and in rare
> > circumstances could lead to packet corruption.
> > 
> >      To overcome this, introduce minor changes to the Kumeran idle
> >      state (K1) parameters during device initialization. Hardware
> > reset reverts this configuration, therefore it needs to be applied
> > in a few places.
> > 
> >      Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
> >      Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> >      Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> >      Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > 
> >   drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
> >   drivers/net/ethernet/intel/e1000e/ich8lan.c | 80
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >   drivers/net/ethernet/intel/e1000e/ich8lan.h |  4 ++++
> >   3 files changed, 82 insertions(+), 5 deletions(-)
> > 
> > Reverting this patch resolves the issue.
> > 
> > Based on the symptoms and the bisect result, this issue might be
> > similar to
> > https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.my.domain/
> > 
> > 
> > Affected machine is:
> > HP ZBook X G1i 16 inch Mobile Workstation PC, BIOS 01.02.03
> > 05/27/2025 (see end of message for dmesg from boot)
> > 
> > CPU model name:
> > Intel(R) Core(TM) Ultra 7 265H (Arrow Lake)
> > 
> > ethtool output:
> > driver: e1000e
> > version: 6.16.0-061600rc4-generic
> > firmware-version: 0.1-4
> > expansion-rom-version:
> > bus-info: 0000:00:1f.6
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
> > 
> > lspci output:
> > 0:1f.6 Ethernet controller [0200]: Intel Corporation Device
> > [8086:57a0] DeviceName: Onboard Ethernet
> >          Subsystem: Hewlett-Packard Company Device [103c:8e1d]
> >          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> >          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >          Latency: 0
> >          Interrupt: pin D routed to IRQ 162
> >          IOMMU group: 17
> >          Region 0: Memory at 92280000 (32-bit, non-prefetchable)
> > [size=128K] Capabilities: [c8] Power Management version 3
> >                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >                  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1
> > PME- Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
> >                  Address: 00000000fee00798  Data: 0000
> >          Kernel driver in use: e1000e
> >          Kernel modules: e1000e
> > 
> > The relevant dmesg:
> > <<<cable disconnected>>>
> > 
> > [    0.927394] e1000e: Intel(R) PRO/1000 Network Driver
> > [    0.927398] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [    0.927933] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
> > [    0.928249] e1000e 0000:00:1f.6: Interrupt Throttling Rate
> > (ints/sec) set to dynamic conservative mode
> > [    1.155716] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):
> > registered PHC clock
> > [    1.220694] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width
> > x1) 24:fb:e3:bf:28:c6
> > [    1.220721] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network
> > Connection [    1.220903] e1000e 0000:00:1f.6 eth0: MAC: 16, PHY:
> > 12, PBA No: FFFFFF-0FF [    1.222632] e1000e 0000:00:1f.6 eno1:
> > renamed from eth0
> > 
> > <<<cable connected>>>
> > 
> > [  153.932626] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps
> > Half Duplex, Flow Control: None
> > [  153.934527] e1000e 0000:00:1f.6 eno1: NIC Link is Down
> > [  157.622238] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps
> > Full Duplex, Flow Control: None
> > 
> > No error message seen after hot-plugging the Ethernet cable.
> >   
> 
> Thank your for the report.
> 
> We did not encounter this issue during our patch testing. However, we 
> will attempt to reproduce it in our lab.
> 
> One detail that caught my attention is that flow control is disabled
> in both scenarios. Could you please check whether the issue persists
> when flow control is enabled? This might require connecting to a link
> partner that supports flow control.

I wrote the other similar report from Dell Pro referenced earlier.
Additional testing on the Dell provided the following insight:

- A fast cable out/in will work. The cable should be disconnected
  for 10-15 seconds for the issue to trigger.

- Sometimes the first spurious link up is 1000 mbps/half and sometimes
  10 mbps/half.

- Using ethtool -r to renegotiate the link will make things work in
  the defunct state.

And yes, my issue seems to be exactly the same.

Thanks,
Timo

