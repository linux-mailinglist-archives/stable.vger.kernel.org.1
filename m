Return-Path: <stable+bounces-105334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CFE9F8243
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317151896AE6
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F61A9B4D;
	Thu, 19 Dec 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywLb3BPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF811A9B46;
	Thu, 19 Dec 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629888; cv=none; b=XEIDi23w1712/nYp40Yk2gwzrYCUHk68A4UHpPYAijRaFBt8hWKdlaLdUk10wSy0BhkPDZo2m0f3F9vGeT4s4LdVBd7Hf33eQ19/E3gG3VKP1ATTC7iZEsMFx+69YZsQHUbvoQ0mEm1RhaQDaYtuTeEcPy+Bnrbt5gcnJ+UOgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629888; c=relaxed/simple;
	bh=czrS+kAk7KtRC4HX5beoW/xSDyGVqw1EY0shBD48PgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fMl/wWwPA3FEA9CX8AuUxbpONo+9eagUKtodmsDQpkUSDuvgmCK4eaDjCn012RQRk0NWatuSUVQXKHgLpTMlVqMWm4hI/+cZeq4GJcOf4uzFpcH9i68ei60ak9eSRtmg9WfEpyPYrTr+fb7PLFZJisOLVjUhsix4vRYcWUpTGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ywLb3BPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71558C4CED0;
	Thu, 19 Dec 2024 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734629887;
	bh=czrS+kAk7KtRC4HX5beoW/xSDyGVqw1EY0shBD48PgQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ywLb3BPPTE62oP/f3OGNDlW0q4e5s8AXhrmah67FJOh1VSMgSKrgtFGYTorWyYxF8
	 t1OZl0gmjhBVhPRz/dS5CDS+W+vUGOhm24PPnBLrED5tbHsCLyUucZth+ZIjuxSwB5
	 wRZ+gSJ22Q5/VcJuhyjtgnOaMBU0hSOpfiXP6SkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.175
Date: Thu, 19 Dec 2024 18:38:00 +0100
Message-ID: <2024121900-dodge-yearning-b8b0@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.175 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/power/runtime_pm.rst                        |    4 
 Makefile                                                  |    2 
 arch/parisc/Kconfig                                       |    1 
 arch/parisc/include/asm/cache.h                           |   11 -
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
 drivers/gpu/drm/i915/i915_scheduler.c                     |    2 
 drivers/net/bonding/bond_main.c                           |    1 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h                |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c           |    2 
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                |    5 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c       |   11 -
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c       |    2 
 drivers/net/ethernet/qualcomm/qca_spi.c                   |   26 +--
 drivers/net/ethernet/qualcomm/qca_spi.h                   |    1 
 drivers/net/team/team.c                                   |    3 
 drivers/net/xen-netfront.c                                |    5 
 drivers/ptp/ptp_kvm_arm.c                                 |    4 
 drivers/ptp/ptp_kvm_common.c                              |    1 
 drivers/ptp/ptp_kvm_x86.c                                 |   61 ++++++--
 drivers/usb/dwc2/hcd.c                                    |   19 +-
 drivers/usb/gadget/function/u_serial.c                    |    9 -
 drivers/usb/host/ehci-sh.c                                |    9 -
 drivers/usb/host/max3421-hcd.c                            |   16 +-
 fs/exfat/dir.c                                            |    2 
 fs/xfs/libxfs/xfs_btree.c                                 |   29 +++-
 fs/xfs/libxfs/xfs_symlink_remote.c                        |    4 
 fs/xfs/scrub/trace.h                                      |    2 
 fs/xfs/xfs_file.c                                         |    8 +
 include/linux/compiler.h                                  |   32 +++-
 include/linux/ptp_kvm.h                                   |    1 
 include/linux/static_call.h                               |    6 
 include/net/lapb.h                                        |    2 
 kernel/bpf/verifier.c                                     |    5 
 kernel/static_call_inline.c                               |    2 
 kernel/trace/trace_kprobe.c                               |    2 
 net/batman-adv/translation-table.c                        |   58 +++++---
 net/core/sock_map.c                                       |    1 
 net/ipv4/tcp_output.c                                     |    6 
 net/sched/sch_netem.c                                     |   22 ++-
 net/tipc/udp_media.c                                      |    7 
 net/vmw_vsock/virtio_transport_common.c                   |    8 +
 sound/usb/quirks.c                                        |   33 +++-
 tools/objtool/check.c                                     |   11 -
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh |   15 --
 61 files changed, 593 insertions(+), 238 deletions(-)

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Dan Carpenter (1):
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Borkmann (2):
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

Daniel Machon (2):
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix the maximum frame length register

Danielle Ratson (2):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was never acquired

Darrick J. Wong (4):
      xfs: update btree keys correctly when _insrec splits an inode root block
      xfs: don't drop errno values when we fail to ficlone the entire range
      xfs: return from xfs_symlink_verify early on V4 filesystems
      xfs: fix scrub tracepoints when inode-rooted btrees are involved

Eduard Zingerman (1):
      bpf: sync_linked_regs() must preserve subreg_def

Eric Dumazet (2):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN

Greg Kroah-Hartman (2):
      Revert "parisc: fix a possible DMA corruption"
      Linux 5.15.175

Ilpo Järvinen (1):
      ACPI: resource: Fix memory resource type union access

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

Jeremi Piotrowski (1):
      ptp: kvm: Use decrypted memory in confidential guest on x86

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

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Stefan Wahren (5):
      usb: dwc2: Fix HCD resume
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      usb: dwc2: Fix HCD port connection race
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Sungjong Seo (1):
      exfat: fix potential deadlock on __exfat_get_dentry_set

Suraj Sonawane (1):
      acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Thomas Weißschuh (1):
      ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from kvm_arch_ptp_init()

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines


