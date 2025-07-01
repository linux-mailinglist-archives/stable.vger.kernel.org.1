Return-Path: <stable+bounces-159117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C8AEED99
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 07:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC4B1BC24E4
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 05:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F68623C4E0;
	Tue,  1 Jul 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gaKgX+W+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54045235047
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347940; cv=none; b=M9rQM8ViA6sSzY68wkvNA8DqAo5jiqrI1ehbE9TX+tEIdGoPvm/AZJHByLaxzrjjvfi0/1m8QWYbG9zYGt1cjT73Gr0UtX8a4DlLDwWMUYMXGAaNnttcFBejvSioEN/A4GyldbodoS6HR9n8+TkTTxVeX0OkI6tXyjMjk7MTpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347940; c=relaxed/simple;
	bh=Ia9bC7BliojpDQhV0cK1tnHWh30Sa7PZo14jzxTtV4U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CF/vg720lK5CMCHgY3S4e/7nYXkkFdQKxufEzn6HPRlJvYZk/m8JGa+2cRIklqQsOeda8sKopFrgAnpk54CKCcDrGs4cL1nBlwTNozs5NbmjzK7d0tJY4ahzZjgqieTfkXF7j8YVcKgfH1uGBw9Ab0+b9fXTIIGblR6HYSTowvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gaKgX+W+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D36DD3F47C
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751347929;
	bh=Th6tfyDO394CCH7+jhRsGZjGv3kV4BdFVr82r26bkjE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	b=gaKgX+W+VexCsXAJxsS4XeD9Tx0vZCGaRS578fQLBraubCjqSMKmmx7gr/RmXQKTJ
	 ruZvEBAPi02fKk2mwkYbezafpAK0Ra4x8AdxAwzH5thAQfCPJYvuf6OBXVUxsP1dOs
	 j6zLRGFjnP8eUhBzubp3nhG9H+ADrffJE+uTpwzQmxOlgIbqjaLKuMCU7/F/UzIYWR
	 P227V/wZkMmLQXXXKN0PUBjqKjrB+g5CDIRcuIzjP8csAhtYSjc1/EFSHhyHex5DqU
	 D5N0H23HfA0ZqE5aW/krq6nBsbQC2Lj7DVJ6KdR2x8pQM8nVBLuFvEX01IDAlSgbS2
	 /jw4cee3I8xMA==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3312775f8f.3
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 22:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347929; x=1751952729;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th6tfyDO394CCH7+jhRsGZjGv3kV4BdFVr82r26bkjE=;
        b=Uz3h34CfLLjIvLUSvsx4lpaeNx9yuaHsRE6Au6JQQO/35vMjxZb70kr2hSXM7XZTes
         GdQlTZ7eNaPB5SkUbOTkc8Z7t7ouhz+t89Fe/D3OuFvbCVQ8To6zPjCwb2KfOXyf+6nO
         eJ4+F7w3xRII1lxtw2o4G3p/eIF6uV8kWpHL9HfwTaTIx0joTQXhknmep7cCWNjxo7SG
         nWjZYrbHfogQm85rP2jX7Z4RmAx4DCiAzPU2O4vgoBgOHEJqnSZjOcMICh18+p32Y+Cu
         xHYg5ABpCIUwjHLWpdhFLCpfBaTFZyGvyNqjuCoixGuspHRdA/8F3DVj2yeWWLhjofZO
         DAzw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ki0BQiUy0xr5ttpW1IWBIVGAlrNFa1Cca1S1yWeqx/GxGZ4K0LZsbZaXZJc0CAjwbtAFtOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwT2Aq0uzUkKp2tXHhcITlDKwNlVwdOIjxvq6ZSqQdxlGq9Pug
	N+UnWbJ69NiVgv8vL+ly4ETuEqSI8DJZII89Rg0JWFy1EQimFiY0GafTFwpzcw5CqYFfVtvHWL6
	Mt/zUu+QD9I3xPQTAmGD2bCwIOqBI4IUjfhe+lm8hZu4v1T7nayRKMqX1HbPV8ft9ZEzg6WLydk
	M9E3SprXxc1Ot+ST5813/yxgZmyMBCRnfGnhG26hXhCnekLUK+
X-Gm-Gg: ASbGnctYcOt85iaUVPkfJSFyOJUPO+/cFsm78ZgIoZaq/3JDK9XOtCh5rJWNhBbzDcH
	O4li8FYBPZUAHwKrZQB+S2lpIqr4+bFhKFkdgjNFqVzBaLmx48BKZ++3xcULp0SiLNO0AVThwMm
	VAbQL+
X-Received: by 2002:adf:e68d:0:b0:3a4:fc3f:b7fd with SMTP id ffacd0b85a97d-3a90d69c1ebmr9798639f8f.19.1751347929278;
        Mon, 30 Jun 2025 22:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQS3XawVxrrKMLZsnhzsHuYQTttD0IeJ90NQXWb6KtNxi3msiWFQZXCQ9dWC8kYKoB37mb6mkCcsSe0DFPtYM=
X-Received: by 2002:adf:e68d:0:b0:3a4:fc3f:b7fd with SMTP id
 ffacd0b85a97d-3a90d69c1ebmr9798628f8f.19.1751347928826; Mon, 30 Jun 2025
 22:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 1 Jul 2025 13:31:57 +0800
X-Gm-Features: Ac12FXzfag1g2nwhulkJ_FDCmz-gasu-2kJw2gi7_6NbhQZX4c5tIUv2dN6Kb-g
Message-ID: <CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.com>
Subject: [REGRESSION] Packet loss after hot-plugging ethernet cable on HP
 Zbook (Arrow Lake)
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: regressions@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm seeing a regression on an HP ZBook using the e1000e driver
(chipset PCI ID: [8086:57a0]) -- the system can't get an IP address
after hot-plugging an Ethernet cable. In this case, the Ethernet cable
was unplugged at boot. The network interface eno1 was present but
stuck in the DHCP process. Using tcpdump, only TX packets were visible
and never got any RX -- indicating a possible packet loss or
link-layer issue.

This is on the vanilla Linux 6.16-rc4 (commit
62f224733431dbd564c4fe800d4b67a0cf92ed10).

Bisect says it's this commit:

commit efaaf344bc2917cbfa5997633bc18a05d3aed27f
Author: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date:   Thu Mar 13 16:05:56 2025 +0200

    e1000e: change k1 configuration on MTP and later platforms

    Starting from Meteor Lake, the Kumeran interface between the integrated
    MAC and the I219 PHY works at a different frequency. This causes sporadic
    MDI errors when accessing the PHY, and in rare circumstances could lead
    to packet corruption.

    To overcome this, introduce minor changes to the Kumeran idle
    state (K1) parameters during device initialization. Hardware reset
    reverts this configuration, therefore it needs to be applied in a few
    places.

    Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
    Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
    Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
    Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

 drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 80
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  4 ++++
 3 files changed, 82 insertions(+), 5 deletions(-)

Reverting this patch resolves the issue.

Based on the symptoms and the bisect result, this issue might be
similar to https://lore.kernel.org/intel-wired-lan/20250626153544.1853d106@onyx.my.domain/


Affected machine is:
HP ZBook X G1i 16 inch Mobile Workstation PC, BIOS 01.02.03 05/27/2025
(see end of message for dmesg from boot)

CPU model name:
Intel(R) Core(TM) Ultra 7 265H (Arrow Lake)

ethtool output:
driver: e1000e
version: 6.16.0-061600rc4-generic
firmware-version: 0.1-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

lspci output:
0:1f.6 Ethernet controller [0200]: Intel Corporation Device [8086:57a0]
        DeviceName: Onboard Ethernet
        Subsystem: Hewlett-Packard Company Device [103c:8e1d]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 162
        IOMMU group: 17
        Region 0: Memory at 92280000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00798  Data: 0000
        Kernel driver in use: e1000e
        Kernel modules: e1000e

The relevant dmesg:
<<<cable disconnected>>>

[    0.927394] e1000e: Intel(R) PRO/1000 Network Driver
[    0.927398] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.927933] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)
[    0.928249] e1000e 0000:00:1f.6: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    1.155716] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):
registered PHC clock
[    1.220694] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width
x1) 24:fb:e3:bf:28:c6
[    1.220721] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    1.220903] e1000e 0000:00:1f.6 eth0: MAC: 16, PHY: 12, PBA No: FFFFFF-0FF
[    1.222632] e1000e 0000:00:1f.6 eno1: renamed from eth0

<<<cable connected>>>

[  153.932626] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Half
Duplex, Flow Control: None
[  153.934527] e1000e 0000:00:1f.6 eno1: NIC Link is Down
[  157.622238] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full
Duplex, Flow Control: None

No error message seen after hot-plugging the Ethernet cable.

-- 
Best Regards,
En-Wei.

