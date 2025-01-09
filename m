Return-Path: <stable+bounces-108101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF9A07646
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E8C7A364D
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38921883E;
	Thu,  9 Jan 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZUJ+zbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DEE21859D;
	Thu,  9 Jan 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427416; cv=none; b=pvSN7ptpqKdlhmgUwJc/yHBM7koeFxwk8Ogi4yzfqwAwx5JTCI22LfDtP80dQfFYx1gNnkh+wu2y6TA4P8FZM5IqCln0DwydxIIXO4Gk5ZHUmhcl8HJaMw3weNljCalvb5u0F+t+gZTxQSrddDWgz/CtC91yFtiRN6/n6PVEsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427416; c=relaxed/simple;
	bh=GB0VTqYcvEHfr1filRsDQovUP905B6OiSJOhjPDKH+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7Rn9gIddULxIY9U4vy4CcZDW6uDBshSLs8w2Ov3MM9y6xsImKVfN4zIMRw/gCFgHmCXBpmY3Tt5QvsdfKosikwXrfPamaBb3hM1rnZUwtF+tU7EB2NP337VwF7DwXA7vPsI1cZvYVzkstBEHMKnCXIxupg9UYpcyk3Mhz/9Qr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZUJ+zbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F96C4CED2;
	Thu,  9 Jan 2025 12:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427416;
	bh=GB0VTqYcvEHfr1filRsDQovUP905B6OiSJOhjPDKH+M=;
	h=From:To:Cc:Subject:Date:From;
	b=mZUJ+zbPsQHP5ElrMGlJJo/vtUgovLLTCjini3zRXMh+08T1nuPKI/YsjW9K4NfEb
	 n3GcMNgreVHqL+4+4ijIh07d1QiDzFZ+0WGTLv9RfdPhtiQgOuc4eejBHJiczLFG2z
	 Lp4iF8WVTkmKDy7jatZCzpN/coBpxHaz2+EcS7w4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.176
Date: Thu,  9 Jan 2025 13:56:38 +0100
Message-ID: <2025010939-skied-preshow-8b19@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.176 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml |    2 
 Makefile                                                          |    2 
 arch/arc/Makefile                                                 |    2 
 arch/arm64/mm/context.c                                           |   22 -
 arch/mips/Makefile                                                |    2 
 arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts            |    1 
 arch/x86/kernel/cpu/mshyperv.c                                    |   58 ++
 arch/x86/kvm/x86.c                                                |    2 
 drivers/base/regmap/regmap.c                                      |    4 
 drivers/block/virtio_blk.c                                        |    7 
 drivers/block/zram/zram_drv.c                                     |    6 
 drivers/clocksource/hyperv_timer.c                                |   14 
 drivers/dma-buf/udmabuf.c                                         |    2 
 drivers/dma/at_xdmac.c                                            |    2 
 drivers/dma/dw/acpi.c                                             |    6 
 drivers/dma/dw/internal.h                                         |    8 
 drivers/dma/dw/pci.c                                              |    4 
 drivers/dma/mv_xor.c                                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                            |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |    4 
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c                    |   14 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                          |    2 
 drivers/gpu/drm/drm_dp_mst_topology.c                             |   34 +
 drivers/gpu/drm/drm_modes.c                                       |   11 
 drivers/gpu/drm/i915/gt/intel_rc6.c                               |    2 
 drivers/hv/hv_kvp.c                                               |    6 
 drivers/hv/hv_snapshot.c                                          |    6 
 drivers/hv/hv_util.c                                              |    9 
 drivers/hv/hyperv_vmbus.h                                         |    2 
 drivers/hwmon/tmp513.c                                            |   74 +--
 drivers/i2c/busses/i2c-pnx.c                                      |    4 
 drivers/i2c/busses/i2c-riic.c                                     |    2 
 drivers/infiniband/core/uverbs_cmd.c                              |   16 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |   28 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                          |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   49 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |   17 
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |    5 
 drivers/infiniband/hw/mlx5/main.c                                 |    6 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                            |    2 
 drivers/irqchip/irq-gic.c                                         |    2 
 drivers/media/dvb-frontends/dib3000mb.c                           |    2 
 drivers/mmc/host/sdhci-tegra.c                                    |    1 
 drivers/mtd/nand/raw/arasan-nand-controller.c                     |   11 
 drivers/mtd/nand/raw/atmel/pmecc.c                                |    4 
 drivers/mtd/nand/raw/diskonchip.c                                 |    2 
 drivers/net/ethernet/broadcom/bcmsysport.c                        |   21 
 drivers/net/ethernet/broadcom/bgmac-platform.c                    |    5 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c     |    5 
 drivers/net/ethernet/huawei/hinic/hinic_main.c                    |    2 
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |   14 
 drivers/net/ethernet/marvell/sky2.c                               |    1 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c               |    4 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                   |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c             |  151 +++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h             |    2 
 drivers/net/mdio/fwnode_mdio.c                                    |   13 
 drivers/net/netdevsim/health.c                                    |    2 
 drivers/net/usb/qmi_wwan.c                                        |    3 
 drivers/net/wwan/iosm/iosm_ipc_mmio.c                             |    2 
 drivers/of/address.c                                              |    2 
 drivers/of/base.c                                                 |   15 
 drivers/of/irq.c                                                  |    1 
 drivers/pci/controller/pci-host-common.c                          |    4 
 drivers/pci/controller/vmd.c                                      |    8 
 drivers/pci/pcie/aer.c                                            |   18 
 drivers/pci/probe.c                                               |   20 
 drivers/pci/quirks.c                                              |    4 
 drivers/phy/phy-core.c                                            |   21 
 drivers/pinctrl/pinctrl-mcp23s08.c                                |    6 
 drivers/platform/x86/asus-nb-wmi.c                                |    1 
 drivers/power/supply/gpio-charger.c                               |    8 
 drivers/scsi/megaraid/megaraid_sas_base.c                         |    5 
 drivers/scsi/mpt3sas/mpt3sas_base.c                               |    7 
 drivers/scsi/qla1280.h                                            |   12 
 drivers/scsi/storvsc_drv.c                                        |    7 
 drivers/sh/clk/core.c                                             |    2 
 drivers/thunderbolt/icm.c                                         |    5 
 drivers/thunderbolt/nhi.c                                         |   24 +
 drivers/thunderbolt/nhi.h                                         |   13 
 drivers/usb/cdns3/core.h                                          |    1 
 drivers/usb/cdns3/drd.c                                           |   10 
 drivers/usb/cdns3/drd.h                                           |    3 
 drivers/usb/dwc2/gadget.c                                         |    4 
 drivers/usb/host/xhci-ring.c                                      |   42 +
 drivers/usb/host/xhci.c                                           |   21 
 drivers/usb/host/xhci.h                                           |    2 
 drivers/usb/serial/option.c                                       |   27 +
 drivers/watchdog/it87_wdt.c                                       |   39 +
 fs/btrfs/ctree.c                                                  |   37 -
 fs/btrfs/ctree.h                                                  |    7 
 fs/btrfs/disk-io.c                                                |    9 
 fs/btrfs/inode.c                                                  |    2 
 fs/btrfs/sysfs.c                                                  |   93 ++--
 fs/btrfs/tree-checker.c                                           |   27 +
 fs/ceph/super.c                                                   |    2 
 fs/efivarfs/inode.c                                               |    2 
 fs/efivarfs/internal.h                                            |    1 
 fs/efivarfs/super.c                                               |    3 
 fs/erofs/inode.c                                                  |   20 
 fs/eventpoll.c                                                    |    5 
 fs/ksmbd/auth.c                                                   |    2 
 fs/ksmbd/mgmt/user_session.c                                      |    6 
 fs/ksmbd/server.c                                                 |    4 
 fs/ksmbd/smb2pdu.c                                                |   33 -
 fs/nfs/pnfs.c                                                     |    2 
 fs/nfsd/nfs4callback.c                                            |    4 
 fs/nfsd/nfs4state.c                                               |    2 
 fs/nilfs2/inode.c                                                 |    8 
 fs/nilfs2/namei.c                                                 |    5 
 include/clocksource/hyperv_timer.h                                |    2 
 include/linux/hyperv.h                                            |    1 
 include/linux/if_vlan.h                                           |   16 
 include/linux/mlx5/driver.h                                       |    6 
 include/linux/skmsg.h                                             |   11 
 include/linux/trace_events.h                                      |    2 
 include/linux/vmstat.h                                            |    2 
 include/linux/wait.h                                              |    1 
 include/net/netfilter/nf_tables.h                                 |    7 
 include/net/sock.h                                                |   10 
 kernel/bpf/core.c                                                 |    6 
 kernel/bpf/syscall.c                                              |   13 
 kernel/kcov.c                                                     |    2 
 kernel/trace/trace.c                                              |    3 
 kernel/trace/trace_events.c                                       |  211 ++++++++--
 kernel/trace/trace_kprobe.c                                       |    2 
 lib/test_stackinit.c                                              |    1 
 mm/vmalloc.c                                                      |    3 
 mm/vmscan.c                                                       |    9 
 net/core/filter.c                                                 |   21 
 net/core/skmsg.c                                                  |    6 
 net/core/sock.c                                                   |    5 
 net/dsa/dsa2.c                                                    |    7 
 net/ipv4/tcp_bpf.c                                                |    6 
 net/ipv4/tcp_input.c                                              |    1 
 net/ipv6/ila/ila_xlat.c                                           |   16 
 net/llc/llc_input.c                                               |    2 
 net/mac80211/util.c                                               |    3 
 net/netfilter/ipset/ip_set_list_set.c                             |    3 
 net/netrom/nr_route.c                                             |    6 
 net/packet/af_packet.c                                            |   28 -
 net/sched/sch_cake.c                                              |    2 
 net/sched/sch_choke.c                                             |    2 
 net/sctp/associola.c                                              |    3 
 net/smc/af_smc.c                                                  |   13 
 net/smc/smc_clc.c                                                 |    9 
 net/smc/smc_clc.h                                                 |   14 
 scripts/mod/file2alias.c                                          |    4 
 security/selinux/ss/services.c                                    |    8 
 sound/pci/hda/patch_conexant.c                                    |   28 +
 sound/soc/intel/boards/sof_sdw.c                                  |    9 
 sound/usb/format.c                                                |    7 
 sound/usb/mixer.c                                                 |    7 
 sound/usb/mixer_us16x08.c                                         |    2 
 sound/usb/quirks.c                                                |    2 
 156 files changed, 1353 insertions(+), 476 deletions(-)

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Ajit Khaparde (1):
      PCI: Add ACS quirk for Broadcom BCM5760X NIC

Anand Jain (1):
      btrfs: sysfs: convert scnprintf and snprintf to sysfs_emit

Andrew Halaney (1):
      net: stmmac: don't create a MDIO bus if unnecessary

Andy Shevchenko (4):
      hwmon: (tmp513) Don't use "proxy" headers
      hwmon: (tmp513) Simplify with dev_err_probe()
      hwmon: (tmp513) Use SI constants from units.h
      dmaengine: dw: Select only supported masters for ACPI devices

Anton Protopopov (1):
      bpf: fix potential error return

Antonio Pastor (1):
      net: llc: reset skb->transport_header

Armin Wolf (1):
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Arnd Bergmann (1):
      kcov: mark in_softirq_really() as __always_inline

Bart Van Assche (1):
      mm/vmstat: fix a W=1 clang compiler warning

Bartosz Golaszewski (1):
      net: stmmac: platform: provide devm_stmmac_probe_config_dt()

Biju Das (2):
      drm: adv7511: Drop dsi single lane support
      dt-bindings: display: adi,adv7533: Drop single lane support

Brett Creeley (1):
      ionic: Fix netdev notifier unregister on failure

Catalin Marinas (1):
      arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs

Cathy Avery (1):
      scsi: storvsc: Do not flag MAINTENANCE_IN return of SRB_STATUS_DATA_OVERRUN as an error

Chen Ridong (1):
      dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset

Chengchang Tang (2):
      RDMA/hns: Fix warning storm caused by invalid input in IO path
      RDMA/hns: Fix missing flush CQE for DWQE

Christian Göttsche (1):
      tracing: Constify string literal data member in struct trace_event_call

Cong Wang (2):
      tcp_bpf: Charge receive socket buffer in bpf_tcp_ingress()
      bpf: Check negative offsets in __bpf_skb_min_len()

Dan Carpenter (4):
      net: hinic: Fix cleanup in create_rxqs/txqs()
      chelsio/chtls: prevent potential integer overflow on 32bit
      mtd: rawnand: fix double free in atmel_pmecc_create_user()
      RDMA/uverbs: Prevent integer overflow issue

Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (2):
      USB: serial: option: add Telit FE910C04 rmnet compositions
      net: usb: qmi_wwan: add Telit FE910C04 compositions

Dimitri Fedrau (1):
      power: supply: gpio-charger: Fix set charge current limits

Edward Adam Davis (1):
      nilfs2: prevent use of deleted inode

Emmanuel Grumbach (1):
      wifi: mac80211: wake the queues in case of failure in resume

Eric Dumazet (5):
      netdevsim: prevent bad user input in nsim_dev_health_break_write()
      net: restrict SO_REUSEPORT to inet sockets
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Evgenii Shatokhin (1):
      pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking

Filipe Manana (4):
      btrfs: avoid monopolizing a core when activating a swap file
      btrfs: rename and export __btrfs_cow_block()
      btrfs: fix use-after-free when COWing tree bock and tracing is enabled
      btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount

Gao Xiang (1):
      erofs: fix incorrect symlink detection in fast symlink

Geert Uytterhoeven (2):
      i2c: riic: Always round-up when calculating bus period
      sh: clk: Fix clk_enable() to return 0 on NULL clk

George D Sworo (1):
      thunderbolt: Add support for Intel Raptor Lake

Greg Kroah-Hartman (1):
      Linux 5.15.176

Guangguan Wang (4):
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll
      net/smc: check iparea_offset and ipv6_prefixes_cnt when receiving proposal msg
      net/smc: check smcd_v2_ext_offset when receiving proposal msg
      net/smc: check return value of sock_recvmsg when draining clc data

Herve Codina (1):
      of: Fix error path in of_parse_phandle_with_args_map()

Hou Tao (1):
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Ilya Dryomov (1):
      ceph: validate snapdirname option length when mounting

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Imre Deak (2):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Verify request type in the corresponding down message reply

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

James Bottomley (1):
      efivarfs: Fix error on non-existent file

James Hilliard (1):
      watchdog: it87_wdt: add PWRGD enable quirk for Qotom QCML04

Jann Horn (1):
      udmabuf: also check for F_SEAL_FUTURE_WRITE

Javier Carrasco (1):
      dmaengine: mv_xor: fix child node refcount handling in early exit

Jiaxun Yang (2):
      MIPS: Loongson64: DTS: Fix msi node for ls7a
      MIPS: Probe toolchain support of -msym32

Jiwei Sun (1):
      PCI: vmd: Create domain symlink before pci_bus_add_devices()

Joe Hattori (4):
      net: ethernet: bgmac-platform: fix an OF node reference leak
      net: mdiobus: fix an OF node reference leak
      net: stmmac: restructure the error path of stmmac_probe_config_dt()
      net: mv643xx_eth: fix an OF node reference leak

Jordy Zomer (2):
      ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
      ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Kai-Heng Feng (1):
      PCI/AER: Disable AER service on suspend

Kairui Song (1):
      zram: refuse to use zero sized block device as backing device

Kalesh AP (1):
      RDMA/bnxt_re: Fix reporting hw_ver in query_device

Kees Cook (1):
      lib: stackinit: hide never-taken branch from compiler

Leon Romanovsky (1):
      ARC: build: Try to guess GCC variant of cross compiler

Li Zhijian (1):
      RDMA/rtrs: Ensure 'ib_sge list' is accessible

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Lizhi Xu (1):
      tracing: Prevent bad count for tracing_cpumask_write

Maciej Andrzejewski (2):
      mtd: rawnand: arasan: Fix double assertion of chip-select
      mtd: rawnand: arasan: Fix missing de-registration of NAND

Maciej S. Szmigiero (1):
      net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

Masahiro Yamada (2):
      modpost: fix input MODULE_DEVICE_TABLE() built for 64-bit on 32-bit host
      modpost: fix the missed iteration for the max bit in do_input()

Masami Hiramatsu (Google) (1):
      tracing/kprobe: Make trace_kprobe's module callback called after jump_label update

Mathias Nyman (1):
      xhci: Turn NEC specific quirk for handling Stop Endpoint errors generic

Matthew Wilcox (Oracle) (1):
      vmalloc: fix accounting with i915

Michael Kelley (1):
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

Michal Pecio (3):
      xhci: retry Stop Endpoint on buggy NEC controllers
      usb: xhci: Limit Stop Endpoint retries
      usb: xhci: Avoid queuing redundant Stop Endpoint commands

Michel Dänzer (1):
      drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update

Mika Westerberg (4):
      thunderbolt: Add support for Intel Meteor Lake
      thunderbolt: Add Intel Barlow Ridge PCI ID
      thunderbolt: Add support for Intel Lunar Lake
      thunderbolt: Add support for Intel Panther Lake-M/P

Ming Lei (1):
      virtio-blk: don't keep queue frozen during system suspend

Murad Masimov (3):
      hwmon: (tmp513) Fix interpretation of values of Shunt Voltage and Limit Registers
      hwmon: (tmp513) Fix Current Register value interpretation
      hwmon: (tmp513) Fix interpretation of values of Temperature Result and Limit Registers

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation

Namjae Jeon (1):
      ksmbd: fix racy issue from session lookup and expire

NeilBrown (1):
      nfsd: restore callback functionality for NFSv4.0

Nikita Zhandarovich (1):
      media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Peng Hongchi (1):
      usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: fix jack detection on ADL-N variant RVP

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Qu Wenruo (2):
      btrfs: tree-checker: reject inline extent items with 0 ref count
      btrfs: sysfs: fix direct super block member reads

Ranjan Kumar (1):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during driver load time

Rodrigo Vivi (1):
      drm/i915/dg1: Fix power gate sequence.

Roger Quadros (1):
      usb: cdns3: Add quirk flag to enable suspend residency

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Sean Christopherson (1):
      KVM: x86: Play nice with protected guests in complete_hypercall_exit()

Seiji Nishikawa (1):
      mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()

Selvin Xavier (2):
      RDMA/bnxt_re: Fix max_qp_wrs reported
      RDMA/bnxt_re: Fix the locking while accessing the QP table

Shannon Nelson (1):
      ionic: use ee->offset when returning sprom data

Stefan Ekenberg (1):
      drm/bridge: adv7511_audio: Update Audio InfoFrame properly

Steven Rostedt (4):
      tracing: Fix test_event_printk() to process entire print argument
      tracing: Add missing helper functions in event pointer dereference check
      tracing: Add "%s" check in test_event_printk()
      tracing: Have process_string() also allow arrays

Takashi Iwai (1):
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()

Tanya Agarwal (1):
      ALSA: usb-audio: US16x08: Initialize array before use

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Trond Myklebust (1):
      NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

Vidya Sagar (1):
      PCI: Use preserve_config in place of pci_flags

Ville Syrjälä (1):
      drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()

Vitalii Mordan (1):
      eth: bcmsysport: fix call balance of priv->clk handling routines

Vladimir Oltean (1):
      net: dsa: improve shutdown sequence

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Wang Liang (1):
      net: fix memory leak in tcp_conn_request()

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdown_net

Yixing Liu (1):
      RDMA/hns: Remove redundant 'attr_mask' in modify_qp_init_to_init()

Yunfeng Ye (1):
      arm64: mm: Rename asid2idx() to ctxid2asid()

Yunsheng Lin (1):
      RDMA/hns: Remove redundant 'bt_level' for hem_list_alloc_item()

Zichen Xie (1):
      mtd: diskonchip: Cast an operand to prevent potential overflow

Zijian Zhang (1):
      tcp_bpf: Add sk_rmem_alloc related logic for tcp_bpf ingress redirection

Zijun Hu (7):
      of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue

wenglianfa (1):
      RDMA/hns: Fix mapping error of zero-hop WQE buffer


