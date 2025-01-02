Return-Path: <stable+bounces-106645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C39FF928
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 13:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2AC7A1417
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 12:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC0171E49;
	Thu,  2 Jan 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JL01bkdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026923D68;
	Thu,  2 Jan 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819779; cv=none; b=fKjJI9rpeyAhoU5+GZNsj3poOtUtQENn4qKsJvp+EuiEEgcDwgs4Ca1iM8mJK9x7BeMvy345nnw7IatheDQUmANlHaZ1AoyQwe/3XJKzUmQistLIshEO/nhLWTJm6fjLdfpFWWHRwWk1zdj8L5HffFiq/gk5722uLvSm9IEjjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819779; c=relaxed/simple;
	bh=sMJPtyZMyjigSPCmtALsim94iOZFnT65mvoNFjFalX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TWBlffXctQRumitTQjnTopMwpQ8W8+CtM690Cqdr8FX/fp2tLj3zBsmzLIZCJgqMRC8690deo0BA3BpNHUmA9bBnsrYx/Lywo+5HcPWyBmXLtP0kMdm9jFMWzBIFiC5GDzTo7sa95lpz0eSJ3VMsU32u5Dy8t9QrtSctVwbwrHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JL01bkdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E0C4CED0;
	Thu,  2 Jan 2025 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735819778;
	bh=sMJPtyZMyjigSPCmtALsim94iOZFnT65mvoNFjFalX4=;
	h=From:To:Cc:Subject:Date:From;
	b=JL01bkdI6QpY5RAquKPKbUmdQxcsUid+YJnLV+lfvqwCh8Up/WBS+Oh4UZfhMVeHZ
	 WPvrDWyL3kNhuOQ4vX0O+t9P56Kef0CZ5Zqi7rFJ1wRezjj5UpAmkkkHRrAAgT9H91
	 IxXGWwDg7GUFbBGUQf5fYScFG3Sq6r1X1lnagTY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.123
Date: Thu,  2 Jan 2025 13:09:33 +0100
Message-ID: <2025010233-oops-sasquatch-e108@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.123 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/mips/Makefile                                 |    2 
 arch/mips/include/asm/mipsregs.h                   |   13 +-
 arch/powerpc/platforms/book3s/vas-api.c            |   36 ++++++
 block/blk-mq.c                                     |   15 +-
 drivers/base/power/domain.c                        |    1 
 drivers/base/regmap/regmap.c                       |    4 
 drivers/block/virtio_blk.c                         |    7 -
 drivers/dma/apple-admac.c                          |    7 -
 drivers/dma/at_xdmac.c                             |    2 
 drivers/dma/dw/acpi.c                              |    6 -
 drivers/dma/dw/internal.h                          |    8 +
 drivers/dma/dw/pci.c                               |    4 
 drivers/dma/mv_xor.c                               |    2 
 drivers/dma/tegra186-gpc-dma.c                     |   10 +
 drivers/gpu/drm/display/drm_dp_mst_topology.c      |   24 +++-
 drivers/i2c/busses/i2c-imx.c                       |    1 
 drivers/i2c/busses/i2c-microchip-corei2c.c         |  122 ++++++++++++++++-----
 drivers/media/dvb-frontends/dib3000mb.c            |    2 
 drivers/mtd/nand/raw/arasan-nand-controller.c      |   11 +
 drivers/mtd/nand/raw/atmel/pmecc.c                 |    4 
 drivers/mtd/nand/raw/diskonchip.c                  |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    4 
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  |    6 +
 drivers/phy/phy-core.c                             |   21 ++-
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            |    2 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |    2 
 drivers/platform/x86/asus-nb-wmi.c                 |    1 
 drivers/power/supply/gpio-charger.c                |    8 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |    5 
 drivers/scsi/mpt3sas/mpt3sas_base.c                |    7 +
 drivers/scsi/qla1280.h                             |   12 +-
 drivers/scsi/storvsc_drv.c                         |    7 +
 drivers/watchdog/it87_wdt.c                        |   39 ++++++
 fs/btrfs/inode.c                                   |    2 
 fs/btrfs/sysfs.c                                   |    6 -
 fs/nfsd/nfs4callback.c                             |    4 
 fs/nfsd/nfs4state.c                                |    2 
 fs/smb/server/smb_common.c                         |    4 
 include/linux/sched.h                              |    5 
 include/linux/skmsg.h                              |   11 +
 include/linux/trace_events.h                       |    2 
 include/linux/vmstat.h                             |    2 
 include/net/sock.h                                 |   10 +
 include/uapi/linux/stddef.h                        |   13 +-
 io_uring/sqpoll.c                                  |    6 +
 kernel/bpf/syscall.c                               |   13 +-
 kernel/rcu/tasks.h                                 |   82 ++++----------
 kernel/trace/trace.c                               |    3 
 kernel/trace/trace_kprobe.c                        |    2 
 mm/vmalloc.c                                       |    6 -
 net/core/filter.c                                  |   21 ++-
 net/core/skmsg.c                                   |    6 -
 net/ipv4/tcp_bpf.c                                 |    6 -
 sound/pci/hda/patch_conexant.c                     |   28 ++++
 sound/pci/hda/patch_realtek.c                      |    7 +
 tools/include/uapi/linux/stddef.h                  |   15 +-
 57 files changed, 471 insertions(+), 184 deletions(-)

Akhil R (1):
      dmaengine: tegra: Return correct DMA status when paused

Alexander Lobakin (1):
      stddef: make __struct_group() UAPI C++-friendly

Andy Shevchenko (1):
      dmaengine: dw: Select only supported masters for ACPI devices

Armin Wolf (1):
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Bart Van Assche (1):
      mm/vmstat: fix a W=1 clang compiler warning

Brahmajit Das (1):
      smb: server: Fix building with GCC 15

Carlos Song (1):
      i2c: imx: add imx7d compatible string for applying erratum ERR007805

Cathy Avery (1):
      scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error

Chen Ridong (2):
      dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      freezer, sched: Report frozen tasks as 'D' instead of 'R'

Chris Chiu (1):
      ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops

Christian Göttsche (1):
      tracing: Constify string literal data member in struct trace_event_call

Chukun Pan (1):
      phy: rockchip: naneng-combphy: fix phy reset

Colin Ian King (1):
      ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"

Cong Wang (2):
      tcp_bpf: Charge receive socket buffer in bpf_tcp_ingress()
      bpf: Check negative offsets in __bpf_skb_min_len()

Conor Dooley (2):
      i2c: microchip-core: actually use repeated sends
      i2c: microchip-core: fix "ghost" detections

Cosmin Ratiu (1):
      net/mlx5e: Don't call cleanup on profile rollback failure

Dan Carpenter (1):
      mtd: rawnand: fix double free in atmel_pmecc_create_user()

Dimitri Fedrau (1):
      power: supply: gpio-charger: Fix set charge current limits

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i

Filipe Manana (1):
      btrfs: avoid monopolizing a core when activating a swap file

Greg Kroah-Hartman (2):
      Revert "rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()"
      Linux 6.1.123

Haren Myneni (1):
      powerpc/pseries/vas: Add close() callback in vas_vm_ops struct

Hou Tao (1):
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Imre Deak (1):
      drm/dp_mst: Ensure mst_primary pointer is valid in drm_dp_mst_handle_up_req()

James Hilliard (1):
      watchdog: it87_wdt: add PWRGD enable quirk for Qotom QCML04

Javier Carrasco (1):
      dmaengine: mv_xor: fix child node refcount handling in early exit

Jiaxun Yang (2):
      MIPS: Probe toolchain support of -msym32
      MIPS: mipsregs: Set proper ISA level for virt extensions

Justin Chen (1):
      phy: usb: Toggle the PHY power during init

Krishna Kurapati (1):
      phy: qcom-qmp: Fix register name in RX Lane config of SC8280XP

Lizhi Xu (1):
      tracing: Prevent bad count for tracing_cpumask_write

Maciej Andrzejewski (2):
      mtd: rawnand: arasan: Fix double assertion of chip-select
      mtd: rawnand: arasan: Fix missing de-registration of NAND

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

Masami Hiramatsu (Google) (1):
      tracing/kprobe: Make trace_kprobe's module callback called after jump_label update

Matthew Wilcox (Oracle) (1):
      vmalloc: fix accounting with i915

Ming Lei (2):
      virtio-blk: don't keep queue frozen during system suspend
      blk-mq: register cpuhp callback after hctx is added to xarray table

NeilBrown (2):
      nfsd: restore callback functionality for NFSv4.0
      sched/core: Report correct state for TASK_IDLE | TASK_FREEZABLE

Nikita Zhandarovich (1):
      media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg

Pavel Begunkov (1):
      io_uring/sqpoll: fix sqpoll error handling races

Qu Wenruo (1):
      btrfs: sysfs: fix direct super block member reads

Ranjan Kumar (1):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during driver load time

Sasha Finkelstein (1):
      dmaengine: apple-admac: Avoid accessing registers in probe

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Ulf Hansson (1):
      pmdomain: core: Add missing put_device()

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

Zichen Xie (1):
      mtd: diskonchip: Cast an operand to prevent potential overflow

Zijian Zhang (1):
      tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection

Zijun Hu (5):
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue


