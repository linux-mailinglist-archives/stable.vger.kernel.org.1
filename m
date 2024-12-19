Return-Path: <stable+bounces-105330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFED9F8235
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B041894611
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A61A23BE;
	Thu, 19 Dec 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LujOB6m2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC31A08CC;
	Thu, 19 Dec 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629870; cv=none; b=hPLNce95O74B1JciLRu8K3vyVm4wNAoSojCtwf/NyooQJAbI1MLXvTHfxCXfIMM7v5cIMsJu5abBV3Uomgu6EKCmyEx6tSP/gdTJzyG9zGNmgaL4YZXU5QgbrMn8ejnFj4v6LaAzvAbU8rhQc/sgi8mKnDyqdvR9zvOWaFkCPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629870; c=relaxed/simple;
	bh=KjXFv8TlLPqGzQZIqC8wohyFIfj+ukFsMRciUJ2cO1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zlkrpts5x/bOFH+iebxl3O2mlrxpUdvBHYiAJqP9abhexeEsR1OC2wc3v1uevsO329njF5LAGA4mkFCqQPsV6vy7n0YtS3abcSLqk1x+V3r4ysDwVjK6XfZglQiYoJcLrCweLQCdt9cmX9pKonbZNvrdM7I2NkIFQu16p1qp86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LujOB6m2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBF7C4CED4;
	Thu, 19 Dec 2024 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629870;
	bh=KjXFv8TlLPqGzQZIqC8wohyFIfj+ukFsMRciUJ2cO1g=;
	h=From:To:Cc:Subject:Date:From;
	b=LujOB6m21AZVTIUkKB9mM+w3skRqytf4cTQb3mr5ahDB6my8JTQlzk3nPc8wqnkd9
	 CF8y+wax0hoLh3Um2og450sN1snIXBhxcz2YgDxdchSMHLBpZBVU8ZTTjvRVbkBOgn
	 nj2vkFSVpT2hwLv151b9+h6qQDqGNc05GUt1LIns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.288
Date: Thu, 19 Dec 2024 18:37:45 +0100
Message-ID: <2024121946-prelaunch-crinkly-83a2@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.288 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                |    2 -
 block/blk-iocost.c                      |   24 ++++++++++++-
 drivers/acpi/acpica/evxfregn.c          |    2 -
 drivers/acpi/resource.c                 |    6 +--
 drivers/ata/sata_highbank.c             |    1 
 drivers/net/ethernet/qualcomm/qca_spi.c |   26 ++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.h |    1 
 drivers/net/xen-netfront.c              |    5 ++
 drivers/usb/dwc2/hcd.c                  |   16 +++-----
 drivers/usb/gadget/function/u_serial.c  |    9 +++-
 drivers/usb/host/ehci-sh.c              |    9 +++-
 drivers/usb/host/max3421-hcd.c          |   16 ++++++--
 fs/xfs/xfs_file.c                       |    8 ++++
 include/net/lapb.h                      |    2 -
 kernel/trace/trace_kprobe.c             |    2 -
 net/batman-adv/translation-table.c      |   58 ++++++++++++++++++++++----------
 net/core/sock_map.c                     |    1 
 net/sched/sch_netem.c                   |   22 ++++++++----
 net/tipc/udp_media.c                    |    7 +++
 sound/usb/quirks.c                      |   31 +++++++++++------
 virt/kvm/arm/pmu.c                      |    1 
 21 files changed, 166 insertions(+), 83 deletions(-)

Dan Carpenter (1):
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired

Darrick J. Wong (1):
      xfs: don't drop errno values when we fail to ficlone the entire range

Eric Dumazet (2):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN

Greg Kroah-Hartman (1):
      Linux 5.4.288

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Joe Hattori (1):
      ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()

Juergen Gross (1):
      xen/netfront: fix crash when removing device

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Michal Luczaj (1):
      bpf, sockmap: Fix update element with same

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Nikolay Kuratov (1):
      tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()

Raghavendra Rao Ananta (1):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Stefan Wahren (3):
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Tejun Heo (2):
      blk-iocost: clamp inuse and skip noops in __propagate_weights()
      blk-iocost: fix weight updates of inner active iocgs

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines


