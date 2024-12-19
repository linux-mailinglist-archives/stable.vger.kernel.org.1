Return-Path: <stable+bounces-105332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FC9F823F
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4228018996F8
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5B1A4F1B;
	Thu, 19 Dec 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrEGETDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE71A4F09;
	Thu, 19 Dec 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629881; cv=none; b=aPvII0AgHvC4zy2onXsoqArd8GVJ2EoX9HgCI0kCKXNDQ2StxDAzq2IoS5YDhMnn9Jwe5Ir4JPsF1K76oJzeHwfnjoQytNjznUehXv0ijR+gIqJhQo6vDzJlmWEiWi0G1yyfotEw+tYJNCOoP+OMeobSu/ePtzCpZ/xe/QGS+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629881; c=relaxed/simple;
	bh=kVdid1FOtSSNcNMlBJhEsXZSbUN0ujDvuGwpuSRbqS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKzT9v4dpSimtaF3CFZ/DWnf3rdViMlBy3P4/qgnNpyoWXN6+uf7dVE/PXa/pPhSv1xVlFQ6pVYx3c1rIAT59+Mh5LNIRzpfcq4AYLQ4qoLweCXh794VFVuHVWyG0v+6HXCx7OSsMUrBkTBy0IdCaWSShvO3JHCNKiqnYW7pY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrEGETDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C0AC4CECE;
	Thu, 19 Dec 2024 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629881;
	bh=kVdid1FOtSSNcNMlBJhEsXZSbUN0ujDvuGwpuSRbqS8=;
	h=From:To:Cc:Subject:Date:From;
	b=nrEGETDu8IuPGkGkrx/ujIJQBLYHEW4W+SKnI2Oru2ljiFSW9ZBNLto/TGDEy1KEf
	 f4kp4fZ4Pnm90gKXb55MwA4ilc2K/B9fvdJaEhZlzumMlIDSJXbu8Y7HTb7vaOaUPE
	 og2oaCCgBnFfqqErslUQgR11z7/1as0zYwHW7Jzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.232
Date: Thu, 19 Dec 2024 18:37:53 +0100
Message-ID: <2024121953-earshot-preteen-ba26@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.232 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm/Kconfig                                          |    2 
 arch/mips/Kconfig                                         |    3 
 arch/mips/pic32/Kconfig                                   |    1 
 arch/sh/Kconfig                                           |    1 
 arch/x86/include/asm/processor.h                          |    2 
 arch/x86/include/asm/static_call.h                        |   15 ++
 arch/x86/include/asm/sync_core.h                          |    6 
 arch/x86/include/asm/xen/hypercall.h                      |   36 +++--
 arch/x86/kernel/cpu/common.c                              |   38 +++--
 arch/x86/kernel/static_call.c                             |   10 +
 arch/x86/xen/enlighten.c                                  |   65 +++++++++
 arch/x86/xen/enlighten_hvm.c                              |   13 -
 arch/x86/xen/enlighten_pv.c                               |    4 
 arch/x86/xen/enlighten_pvh.c                              |    7 
 arch/x86/xen/xen-asm.S                                    |   49 +++++-
 arch/x86/xen/xen-head.S                                   |   99 +++++++++++---
 arch/x86/xen/xen-ops.h                                    |    9 +
 block/blk-iocost.c                                        |    9 +
 drivers/acpi/acpica/evxfregn.c                            |    2 
 drivers/acpi/nfit/core.c                                  |    7 
 drivers/acpi/resource.c                                   |    6 
 drivers/ata/sata_highbank.c                               |    1 
 drivers/clk/Kconfig                                       |    6 
 drivers/clk/Makefile                                      |    3 
 drivers/clocksource/Kconfig                               |    9 -
 drivers/gpu/drm/i915/i915_scheduler.c                     |    2 
 drivers/mmc/host/Kconfig                                  |    4 
 drivers/net/bonding/bond_main.c                           |   12 -
 drivers/net/dummy.c                                       |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c           |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                |    5 
 drivers/net/ethernet/qualcomm/qca_spi.c                   |   26 +--
 drivers/net/ethernet/qualcomm/qca_spi.h                   |    1 
 drivers/net/ifb.c                                         |    3 
 drivers/net/team/team.c                                   |   12 -
 drivers/net/xen-netfront.c                                |    5 
 drivers/staging/board/Kconfig                             |    2 
 drivers/usb/dwc2/hcd.c                                    |   16 --
 drivers/usb/gadget/function/u_serial.c                    |    9 -
 drivers/usb/host/ehci-sh.c                                |    9 -
 drivers/usb/host/max3421-hcd.c                            |   16 +-
 fs/exfat/dir.c                                            |    2 
 fs/xfs/scrub/trace.h                                      |    2 
 fs/xfs/xfs_file.c                                         |    8 +
 include/linux/compiler.h                                  |   32 +++-
 include/linux/static_call.h                               |    6 
 include/net/lapb.h                                        |    2 
 kernel/bpf/verifier.c                                     |    5 
 kernel/static_call.c                                      |    2 
 kernel/trace/trace_kprobe.c                               |    2 
 net/batman-adv/translation-table.c                        |   58 +++++---
 net/core/sock_map.c                                       |    1 
 net/ipv4/tcp_output.c                                     |    6 
 net/sched/sch_netem.c                                     |   22 ++-
 net/tipc/udp_media.c                                      |    7 
 net/vmw_vsock/virtio_transport_common.c                   |    8 +
 sound/soc/dwc/Kconfig                                     |    2 
 sound/soc/rockchip/Kconfig                                |   14 -
 sound/usb/quirks.c                                        |   31 ++--
 tools/objtool/check.c                                     |   11 -
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh |   15 --
 63 files changed, 538 insertions(+), 231 deletions(-)

Alexander Lobakin (1):
      net: bonding, dummy, ifb, team: advertise NETIF_F_GSO_SOFTWARE

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Dan Carpenter (1):
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Borkmann (2):
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

Danielle Ratson (2):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired

Darrick J. Wong (2):
      xfs: don't drop errno values when we fail to ficlone the entire range
      xfs: fix scrub tracepoints when inode-rooted btrees are involved

Eduard Zingerman (1):
      bpf: sync_linked_regs() must preserve subreg_def

Eric Dumazet (2):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN

Greg Kroah-Hartman (3):
      Revert "clocksource/drivers:sp804: Make user selectable"
      Revert "clkdev: remove CONFIG_CLKDEV_LOOKUP"
      Linux 5.10.232

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error handler

Joe Hattori (1):
      ata: sata_highbank: fix OF node reference leak in highbank_initialize_phys()

Juergen Gross (9):
      xen/netfront: fix crash when removing device
      x86: make get_cpu_vendor() accessible from Xen code
      objtool/x86: allow syscall instruction
      x86/static-call: provide a way to do very early static-call updates
      x86/xen: don't do PV iret hypercall through hypercall page
      x86/xen: add central hypercall functions
      x86/xen: use new hypercall functions instead of hypercall page
      x86/xen: remove hypercall page
      x86/static-call: fix 32-bit build

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Michal Luczaj (2):
      bpf, sockmap: Fix update element with same
      virtio/vsock: Fix accept_queue memory leak

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Nathan Chancellor (1):
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Nikolay Kuratov (1):
      tracing/kprobes: Skip symbol counting logic for module symbols in create_local_trace_kprobe()

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Stefan Wahren (3):
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Sungjong Seo (1):
      exfat: fix potential deadlock on __exfat_get_dentry_set

Suraj Sonawane (1):
      acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines


