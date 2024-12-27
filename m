Return-Path: <stable+bounces-106199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6059FD508
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6A61883C26
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2763F9C5;
	Fri, 27 Dec 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ksvJCs4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459F1F191B;
	Fri, 27 Dec 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307109; cv=none; b=u92cY3B2hD0/GipXCM+1zLNli0mDeLkbWETUeZRfbf81W6W/bVQisYn9waxm18iCEcdXApjNJKTgz3EHSbVZOk/ffqyGiQSoKuebNTJyBW9enZavz1RDicrQJPjK+mdGib0L7CF7OzVFtiZyaarQt0VoEnMOJ08lRv1eElSsC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307109; c=relaxed/simple;
	bh=REkr26EcW0T00fzkFhNSLhesVDkUDMSIAUpg5LZJ/jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsEzMVLXIrk340Kqow40aKfveVFKMN3DFPdcUKK5m6273lO7QrtXl1zP0nNVCOxGWJyWzLjq8vKn+97nzpYsuqFwQhfn0lelFAv5jf+VUu7WWJSENgLJcLDdbAIClBaRc7O/k9igpbYMUS4kl9UAL8FmIO0Dyle+5v5bUIvvMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ksvJCs4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA81C4CED0;
	Fri, 27 Dec 2024 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735307108;
	bh=REkr26EcW0T00fzkFhNSLhesVDkUDMSIAUpg5LZJ/jI=;
	h=From:To:Cc:Subject:Date:From;
	b=ksvJCs4pKTXGDJ5OQRxhKcFL8/lJUe/qWN73zbYh9WCvO9zEC4mzC0VHTyVFABs2d
	 2tj2fbRuT3J3hQJxXXiUD7ZNpcuSPD8w6Ph1SRf11icDBhM73n2yB2ODk1aMIqV/2Y
	 xw1pe1VVB2KWYTN0bcQUqe/IjiRBb+8LvR4LPKvE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.122
Date: Fri, 27 Dec 2024 14:45:03 +0100
Message-ID: <2024122703-enrage-panning-ebd6@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.122 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                      |    2 
 arch/hexagon/Makefile                                         |    6 
 arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts        |    1 
 arch/x86/kvm/cpuid.c                                          |   31 +
 arch/x86/kvm/cpuid.h                                          |    1 
 arch/x86/kvm/x86.c                                            |    4 
 drivers/block/zram/zram_drv.c                                 |   15 
 drivers/cxl/core/region.c                                     |   25 -
 drivers/dma-buf/udmabuf.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                       |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    7 
 drivers/gpu/drm/drm_modes.c                                   |   11 
 drivers/gpu/drm/i915/gt/intel_engine_types.h                  |    5 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c             |   41 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c                 |    4 
 drivers/hv/hv_kvp.c                                           |    6 
 drivers/hv/hv_snapshot.c                                      |    6 
 drivers/hv/hv_util.c                                          |    9 
 drivers/hv/hyperv_vmbus.h                                     |    2 
 drivers/hwmon/tmp513.c                                        |   74 +--
 drivers/i2c/busses/i2c-pnx.c                                  |    4 
 drivers/i2c/busses/i2c-riic.c                                 |    2 
 drivers/mmc/host/sdhci-tegra.c                                |    1 
 drivers/net/ethernet/broadcom/bgmac-platform.c                |    5 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c |    5 
 drivers/net/ethernet/huawei/hinic/hinic_main.c                |    2 
 drivers/net/ethernet/mscc/ocelot.c                            |    2 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c           |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c               |    4 
 drivers/net/mdio/fwnode_mdio.c                                |   13 
 drivers/net/netdevsim/health.c                                |    2 
 drivers/of/address.c                                          |    2 
 drivers/of/base.c                                             |   15 
 drivers/of/irq.c                                              |    2 
 drivers/pci/controller/pci-host-common.c                      |    4 
 drivers/pci/controller/vmd.c                                  |    8 
 drivers/pci/pcie/aer.c                                        |   18 
 drivers/pci/probe.c                                           |   20 -
 drivers/pci/quirks.c                                          |    4 
 drivers/platform/x86/p2sb.c                                   |   92 ++--
 drivers/sh/clk/core.c                                         |    2 
 drivers/thunderbolt/tb.c                                      |   41 ++
 drivers/usb/cdns3/core.h                                      |    1 
 drivers/usb/cdns3/drd.c                                       |   10 
 drivers/usb/cdns3/drd.h                                       |    3 
 drivers/usb/dwc2/gadget.c                                     |    4 
 drivers/usb/serial/option.c                                   |   27 +
 fs/btrfs/tree-checker.c                                       |   27 +
 fs/ceph/super.c                                               |    2 
 fs/efivarfs/inode.c                                           |    2 
 fs/efivarfs/internal.h                                        |    1 
 fs/efivarfs/super.c                                           |    3 
 fs/eventpoll.c                                                |    5 
 fs/nfs/pnfs.c                                                 |    2 
 fs/nilfs2/btnode.c                                            |    1 
 fs/nilfs2/gcinode.c                                           |    2 
 fs/nilfs2/inode.c                                             |   13 
 fs/nilfs2/namei.c                                             |    5 
 fs/nilfs2/nilfs.h                                             |    1 
 fs/udf/directory.c                                            |    2 
 include/linux/hyperv.h                                        |    1 
 include/linux/io_uring.h                                      |    4 
 include/linux/pci.h                                           |   15 
 include/linux/wait.h                                          |    1 
 io_uring/io_uring.c                                           |   13 
 io_uring/io_uring.h                                           |    1 
 io_uring/rw.c                                                 |   31 +
 kernel/trace/trace_events.c                                   |  197 +++++++---
 net/netfilter/ipset/ip_set_list_set.c                         |    3 
 net/sched/sch_cake.c                                          |    2 
 net/sched/sch_choke.c                                         |    2 
 net/smc/af_smc.c                                              |   15 
 net/smc/smc_clc.c                                             |    9 
 net/smc/smc_clc.h                                             |   14 
 net/smc/smc_core.c                                            |    9 
 sound/soc/intel/boards/sof_sdw.c                              |   18 
 tools/testing/selftests/bpf/sdt.h                             |    2 
 77 files changed, 723 insertions(+), 232 deletions(-)

Ajit Khaparde (1):
      PCI: Add ACS quirk for Broadcom BCM5760X NIC

Andy Shevchenko (4):
      PCI: Introduce pci_resource_n()
      hwmon: (tmp513) Don't use "proxy" headers
      hwmon: (tmp513) Simplify with dev_err_probe()
      hwmon: (tmp513) Use SI constants from units.h

Brett Creeley (1):
      ionic: Fix netdev notifier unregister on failure

Dan Carpenter (2):
      net: hinic: Fix cleanup in create_rxqs/txqs()
      chelsio/chtls: prevent potential integer overflow on 32bit

Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (1):
      USB: serial: option: add Telit FE910C04 rmnet compositions

Edward Adam Davis (1):
      nilfs2: prevent use of deleted inode

Eric Dumazet (1):
      netdevsim: prevent bad user input in nsim_dev_health_break_write()

Geert Uytterhoeven (2):
      i2c: riic: Always round-up when calculating bus period
      sh: clk: Fix clk_enable() to return 0 on NULL clk

Greg Kroah-Hartman (1):
      Linux 6.1.122

Guangguan Wang (5):
      net/smc: protect link down work from execute after lgr freed
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
      net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
      net/smc: check smcd_v2_ext_offset when receiving proposal msg
      net/smc: check return value of sock_recvmsg when draining clc data

Hans de Goede (1):
      platform/x86: p2sb: Make p2sb_get_devfn() return void

Herve Codina (1):
      of: Fix error path in of_parse_phandle_with_args_map()

Huaisheng Ye (1):
      cxl/region: Fix region creation for greater than x2 switches

Ilya Dryomov (1):
      ceph: validate snapdirname option length when mounting

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

James Bottomley (1):
      efivarfs: Fix error on non-existent file

Jan Kara (1):
      udf: Fix directory iteration for longer tail extents

Jann Horn (2):
      io_uring: Fix registered ring file refcount leak
      udmabuf: also check for F_SEAL_FUTURE_WRITE

Jens Axboe (2):
      io_uring/rw: split io_read() into a helper
      io_uring/rw: treat -EOPNOTSUPP for IOCB_NOWAIT like -EAGAIN

Jiaxun Yang (1):
      MIPS: Loongson64: DTS: Fix msi node for ls7a

Jiwei Sun (1):
      PCI: vmd: Create domain symlink before pci_bus_add_devices()

Joe Hattori (2):
      net: ethernet: bgmac-platform: fix an OF node reference leak
      net: mdiobus: fix an OF node reference leak

Kai-Heng Feng (1):
      PCI/AER: Disable AER service on suspend

Kairui Song (2):
      zram: refuse to use zero sized block device as backing device
      zram: fix uninitialized ZRAM not releasing backing device

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Michael Kelley (1):
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

Michel Dänzer (1):
      drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update

Mika Westerberg (1):
      thunderbolt: Improve redrive mode handling

Murad Masimov (3):
      hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers
      hwmon: (tmp513) Fix Current Register value interpretation
      hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers

Nathan Chancellor (1):
      hexagon: Disable constant extender optimization for LLVM prior to 19.1.0

Pavel Begunkov (2):
      io_uring: check if iowq is killed before queuing
      io_uring/rw: avoid punting to io-wq directly

Peng Hongchi (1):
      usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: don't access invalid sched

Pierre-Louis Bossart (2):
      ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP
      ASoC: Intel: sof_sdw: add quirk for Dell SKU 0B8C

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Qu Wenruo (1):
      btrfs: tree-checker: reject inline extent items with 0 ref count

Roger Quadros (1):
      usb: cdns3: Add quirk flag to enable suspend residency

Ryusuke Konishi (1):
      nilfs2: fix buffer head leaks in calls to truncate_inode_pages()

Sean Christopherson (2):
      KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init
      KVM: x86: Play nice with protected guests in complete_hypercall_exit()

Shannon Nelson (1):
      ionic: use ee->offset when returning sprom data

Shin'ichiro Kawasaki (4):
      p2sb: Factor out p2sb_read_from_cache()
      p2sb: Introduce the global flag p2sb_hidden_by_bios
      p2sb: Move P2SB hide and unhide code to p2sb_scan_and_cache()
      p2sb: Do not scan and remove the P2SB device when it is unhidden

Steven Rostedt (3):
      tracing: Fix test_event_printk() to process entire print argument
      tracing: Add missing helper functions in event pointer dereference check
      tracing: Add "%s" check in test_event_printk()

Tiezhu Yang (1):
      selftests/bpf: Use asm constraint "m" for LoongArch

Trond Myklebust (1):
      NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Umesh Nerlige Ramappa (3):
      i915/guc: Reset engine utilization buffer before registration
      i915/guc: Ensure busyness counter increases motonically
      i915/guc: Accumulate active runtime on gt reset

Vidya Sagar (1):
      PCI: Use preserve_config in place of pci_flags

Ville Syrjälä (1):
      drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Vladimir Oltean (1):
      net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Yang Yingliang (1):
      drm/panel: novatek-nt35950: fix return value check in nt35950_probe()

Zijun Hu (3):
      of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()
      of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()


