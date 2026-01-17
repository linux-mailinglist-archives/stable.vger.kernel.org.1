Return-Path: <stable+bounces-210173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FAAD38F9A
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B688D3054835
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B923BCED;
	Sat, 17 Jan 2026 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OfhXqgLW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8A239E7D;
	Sat, 17 Jan 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768664875; cv=none; b=LXn+6mTGHhOEE7gFDi+dFqnhu1Ap/liUvOYStbb3zYU+ONTV90TB8Ic95DxGY9yXdh21dXnODp4eQIRV6iuukbGVOZIV7HcLif2hmT4JPLsfmJsRaIzKe7AIABVHfRizgPURj9FizyumojPB5Sq8V4U8dUjtmn0vGCc/RogPwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768664875; c=relaxed/simple;
	bh=d+bvuPJHdxY241sGOSgLgIdk18EmtzLQsEl8mYMoGbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rKjB4icXkX6KP0mxqH4P3zam7eYw73/rqN5WIBz5PDcoy37HQpDYZSIUaeJ3xDSOsKh4qLW9Kj+WTwfdwm2FyUtBAib2wO0QIHKSP05lDPJAOaFB3EhNEEdcv2el0Cy5ITMc80b6RxCDTMKcSWBiSXLD9k1CCjOSBmAnkG0oNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OfhXqgLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC83EC19423;
	Sat, 17 Jan 2026 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768664872;
	bh=d+bvuPJHdxY241sGOSgLgIdk18EmtzLQsEl8mYMoGbk=;
	h=From:To:Cc:Subject:Date:From;
	b=OfhXqgLWYaY8s45kY8trY/p1O/4PWOAdkgeUltyy/IQHe9ZrAzTgxOayyMKdHLNpM
	 PRsdPE2XzC42NJUivroFUDHPr/Fs+ytxAxnDrrRbw5NQcypNKnlkmHpvpjM2p3zc9I
	 CrU9ehFhr0eSoIvHYA9LGmx1pcHSdY6GH7KOluV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.18.6
Date: Sat, 17 Jan 2026 16:47:44 +0100
Message-ID: <2026011745-rope-stubbed-0e48@gregkh>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.18.6 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                                   |    2 
 arch/alpha/include/uapi/asm/ioctls.h                                       |    8 
 arch/arm/Kconfig                                                           |    2 
 arch/arm/boot/dts/nxp/imx/imx6q-ba16.dtsi                                  |    2 
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi                        |    1 
 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106.dts    |    2 
 arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi                        |    5 
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts                               |    3 
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi                           |    8 
 arch/arm64/boot/dts/freescale/imx95.dtsi                                   |    2 
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                                  |    2 
 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso                             |    2 
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-peb-c-010.dtso            |    7 
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-x27-gpio1-spi1-uart3.dtso |    8 
 arch/arm64/include/asm/suspend.h                                           |    2 
 arch/arm64/mm/proc.S                                                       |    8 
 arch/csky/mm/fault.c                                                       |    4 
 arch/riscv/boot/Makefile                                                   |    4 
 arch/riscv/include/asm/pgtable.h                                           |    4 
 arch/riscv/kernel/cpufeature.c                                             |   23 
 arch/sparc/kernel/pci.c                                                    |   23 
 block/blk-integrity.c                                                      |   23 
 block/blk-settings.c                                                       |    7 
 drivers/accel/amdxdna/aie2_pci.c                                           |    6 
 drivers/android/binder/page_range.rs                                       |    3 
 drivers/ata/libata-core.c                                                  |    3 
 drivers/atm/he.c                                                           |    3 
 drivers/block/ublk_drv.c                                                   |   49 -
 drivers/counter/104-quad-8.c                                               |   20 
 drivers/counter/interrupt-cnt.c                                            |    3 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                              |    2 
 drivers/gpio/gpio-it87.c                                                   |   11 
 drivers/gpio/gpio-mpsse.c                                                  |  227 +++++++
 drivers/gpio/gpio-pca953x.c                                                |   25 
 drivers/gpio/gpio-rockchip.c                                               |    1 
 drivers/gpio/gpiolib-cdev.c                                                |    2 
 drivers/gpio/gpiolib-sysfs.c                                               |    2 
 drivers/gpio/gpiolib.c                                                     |  128 ++--
 drivers/gpio/gpiolib.h                                                     |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                                    |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c                                |    2 
 drivers/gpu/drm/amd/display/dc/dml/Makefile                                |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                  |   11 
 drivers/gpu/drm/amd/display/include/audio_types.h                          |   12 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                            |   33 -
 drivers/gpu/drm/drm_atomic_helper.c                                        |  122 +++-
 drivers/gpu/drm/mediatek/mtk_dsi.c                                         |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c                            |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c                            |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c                            |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c                            |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h                             |   23 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c                            |   15 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c                            |    3 
 drivers/gpu/drm/pl111/pl111_drv.c                                          |    2 
 drivers/gpu/drm/radeon/pptable.h                                           |    2 
 drivers/gpu/drm/tidss/tidss_kms.c                                          |   30 -
 drivers/gpu/nova-core/Kconfig                                              |    2 
 drivers/hid/hid-quirks.c                                                   |    9 
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c                        |    4 
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c                        |    4 
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.h                        |    2 
 drivers/irqchip/irq-gic-v5-its.c                                           |    2 
 drivers/md/dm-exception-store.h                                            |    2 
 drivers/md/dm-snap.c                                                       |   73 +-
 drivers/md/dm-verity-fec.c                                                 |    4 
 drivers/md/dm-verity-fec.h                                                 |    3 
 drivers/md/dm-verity-target.c                                              |    2 
 drivers/misc/mei/hw-me-regs.h                                              |    2 
 drivers/misc/mei/pci-me.c                                                  |    2 
 drivers/net/dsa/mv88e6xxx/chip.c                                           |   23 
 drivers/net/dsa/mv88e6xxx/chip.h                                           |    4 
 drivers/net/dsa/mv88e6xxx/serdes.c                                         |   46 -
 drivers/net/dsa/mv88e6xxx/serdes.h                                         |    5 
 drivers/net/ethernet/3com/3c59x.c                                          |    2 
 drivers/net/ethernet/airoha/airoha_ppe.c                                   |    9 
 drivers/net/ethernet/amazon/ena/ena_devlink.c                              |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                  |   21 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                  |    4 
 drivers/net/ethernet/freescale/enetc/enetc.h                               |    4 
 drivers/net/ethernet/intel/idpf/idpf.h                                     |   19 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                             |  100 ++-
 drivers/net/ethernet/intel/idpf/idpf_idc.c                                 |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                 |  294 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c                        |    2 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                |   48 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                |    6 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                            |   17 
 drivers/net/ethernet/intel/idpf/xdp.c                                      |    2 
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c                   |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c                     |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                         |    9 
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c                           |    9 
 drivers/net/ethernet/mellanox/mlx5/core/port.c                             |    3 
 drivers/net/ethernet/mscc/ocelot.c                                         |    6 
 drivers/net/netdevsim/bus.c                                                |    8 
 drivers/net/phy/mxl-86110.c                                                |    3 
 drivers/net/phy/sfp.c                                                      |    4 
 drivers/net/usb/pegasus.c                                                  |    2 
 drivers/net/virtio_net.c                                                   |    6 
 drivers/net/wireless/virtual/mac80211_hwsim.c                              |    2 
 drivers/net/wwan/iosm/iosm_ipc_mux.c                                       |    6 
 drivers/of/unittest.c                                                      |    8 
 drivers/pci/controller/dwc/pci-meson.c                                     |   39 -
 drivers/pci/vgaarb.c                                                       |    7 
 drivers/pinctrl/mediatek/pinctrl-mt8189.c                                  |    2 
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                                   |    2 
 drivers/powercap/powercap_sys.c                                            |   22 
 drivers/scsi/ipr.c                                                         |   28 
 drivers/scsi/libsas/sas_internal.h                                         |   14 
 drivers/scsi/mpi3mr/mpi3mr.h                                               |    4 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                            |    4 
 drivers/scsi/sg.c                                                          |   20 
 drivers/spi/spi-cadence-quadspi.c                                          |   10 
 drivers/spi/spi-mt65xx.c                                                   |    2 
 drivers/ufs/core/ufshcd.c                                                  |   36 -
 fs/btrfs/delayed-inode.c                                                   |   32 -
 fs/btrfs/extent_io.c                                                       |   31 -
 fs/btrfs/inode.c                                                           |   19 
 fs/btrfs/ordered-data.c                                                    |    5 
 fs/btrfs/qgroup.c                                                          |   21 
 fs/btrfs/super.c                                                           |   12 
 fs/btrfs/tree-log.c                                                        |    8 
 fs/erofs/super.c                                                           |   19 
 fs/netfs/read_collect.c                                                    |    2 
 fs/nfs/namespace.c                                                         |    5 
 fs/nfs/nfs4proc.c                                                          |   13 
 fs/nfs/nfs4trace.h                                                         |    1 
 fs/nfs_common/common.c                                                     |    1 
 fs/nfsd/netns.h                                                            |    2 
 fs/nfsd/nfs4proc.c                                                         |    2 
 fs/nfsd/nfs4state.c                                                        |   49 +
 fs/nfsd/nfsctl.c                                                           |   12 
 fs/nfsd/nfsd.h                                                             |    1 
 fs/nfsd/nfssvc.c                                                           |   30 -
 fs/nfsd/state.h                                                            |    6 
 fs/nfsd/vfs.c                                                              |    4 
 fs/smb/client/nterr.h                                                      |    6 
 include/drm/drm_atomic_helper.h                                            |   22 
 include/drm/drm_bridge.h                                                   |  249 ++------
 include/linux/netdevice.h                                                  |    3 
 include/linux/soc/airoha/airoha_offload.h                                  |    8 
 include/linux/trace_recursion.h                                            |    9 
 include/net/netfilter/nf_tables.h                                          |   34 -
 include/trace/events/btrfs.h                                               |    3 
 include/trace/misc/nfs.h                                                   |    2 
 include/uapi/linux/nfs.h                                                   |    1 
 io_uring/io-wq.c                                                           |    6 
 kernel/events/core.c                                                       |    6 
 kernel/power/swap.c                                                        |   14 
 kernel/trace/trace.c                                                       |    8 
 lib/crypto/aes.c                                                           |    4 
 net/bpf/test_run.c                                                         |   25 
 net/bridge/br_vlan_tunnel.c                                                |   11 
 net/can/j1939/transport.c                                                  |    2 
 net/ceph/messenger_v2.c                                                    |    2 
 net/ceph/mon_client.c                                                      |    2 
 net/ceph/osd_client.c                                                      |   14 
 net/ceph/osdmap.c                                                          |   24 
 net/core/skbuff.c                                                          |    8 
 net/core/sock.c                                                            |    7 
 net/ipv4/arp.c                                                             |    7 
 net/ipv4/inet_fragment.c                                                   |    2 
 net/ipv4/ping.c                                                            |    4 
 net/ipv4/tcp.c                                                             |    8 
 net/ipv4/udp.c                                                             |    1 
 net/mac80211/tx.c                                                          |    2 
 net/netfilter/nf_conncount.c                                               |    2 
 net/netfilter/nf_tables_api.c                                              |   72 ++
 net/netfilter/nft_set_pipapo.c                                             |    4 
 net/netfilter/nft_synproxy.c                                               |    6 
 net/sched/act_api.c                                                        |    2 
 net/sched/sch_qfq.c                                                        |    2 
 net/unix/af_unix.c                                                         |    8 
 net/vmw_vsock/af_vsock.c                                                   |    4 
 net/wireless/wext-core.c                                                   |    4 
 net/wireless/wext-priv.c                                                   |    4 
 sound/ac97/bus.c                                                           |   10 
 sound/hda/codecs/realtek/alc269.c                                          |    2 
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c                             |    4 
 sound/hda/core/intel-dsp-config.c                                          |    3 
 sound/soc/amd/yc/acp6x-mach.c                                              |    7 
 sound/soc/fsl/fsl_sai.c                                                    |    3 
 sound/soc/rockchip/rockchip_pdm.c                                          |    2 
 sound/usb/quirks.c                                                         |   10 
 tools/testing/selftests/drivers/net/hw/lib/py/__init__.py                  |    4 
 tools/testing/selftests/net/lib/py/__init__.py                             |    4 
 187 files changed, 1763 insertions(+), 1093 deletions(-)

Abdun Nihaal (1):
      gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths

Alan Liu (1):
      drm/amdgpu: Fix query for VPE block_type and ip_count

Alex Deucher (1):
      drm/radeon: Remove __counted_by from ClockInfoArray.clockInfo[]

Alexander Stein (2):
      arm64: dts: mba8mx: Fix Ethernet PHY IRQ support
      ASoC: fsl_sai: Add missing registers to cache default

Alexander Sverdlin (1):
      counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Alexander Usyskin (1):
      mei: me: add nova lake point S DID

Alexandre Courbot (1):
      gpu: nova-core: select RUST_FW_LOADER_ABSTRACTIONS

Alexandre Knecht (1):
      bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

Alexei Lazar (1):
      net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group

Alice Ryhl (1):
      rust_binder: remove spin_lock() in rust_shrink_free_page()

Alok Tiwari (1):
      net: marvell: prestera: fix NULL dereference on devlink_alloc() failure

Andrew Elantsev (1):
      ASoC: amd: yc: Add quirk for Honor MagicBook X16 2025

August Wikerfors (1):
      ALSA: hda/tas2781: properly initialize speaker_id for TAS2563

Bartosz Golaszewski (5):
      gpio: rockchip: mark the GPIO controller as sleeping
      pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping
      gpio: it87: balance superio enter/exit calls in error path
      gpiolib: remove unnecessary 'out of memory' messages
      gpiolib: rename GPIO chip printk macros

Ben Dooks (1):
      trace: ftrace_dump_on_oops[] is not exported, make it static

Benjamin Berg (1):
      wifi: mac80211_hwsim: fix typo in frequency notification

Bjorn Helgaas (1):
      PCI: meson: Report that link is up while in ASPM L0s and L1 states

Boris Burkov (1):
      btrfs: fix qgroup_snapshot_quick_inherit() squota bug

Breno Leitao (1):
      bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable during error cleanup

Brian Kao (1):
      scsi: ufs: core: Fix EH failure after W-LUN resume error

Brian Kocoloski (1):
      drm/amdkfd: Fix improper NULL termination of queue restore SMI event string

Caleb Sander Mateos (2):
      block: don't merge bios with different app_tags
      block: validate pi_offset integrity limit

Carlos Song (1):
      arm64: dts: imx95: correct I3C2 pclk to IMX95_CLK_BUSWAKEUP

Charlene Liu (1):
      drm/amd/display: Fix DP no audio issue

ChenXiaoSong (3):
      smb/client: fix NT_STATUS_UNABLE_TO_FREE_VM value
      smb/client: fix NT_STATUS_DEVICE_DOOR_OPEN value
      smb/client: fix NT_STATUS_NO_DATA_DETECTED value

Chuck Lever (1):
      NFSD: Remove NFSERR_EAGAIN

Cosmin Ratiu (1):
      net/mlx5e: Dealloc forgotten PSP RX modify header

Dave Airlie (1):
      nouveau: don't attempt fwsec on sb on newer platforms.

David Howells (1):
      netfs: Fix early read unlock of page with EOF in middle

Di Zhu (1):
      netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates

Edward Adam Davis (1):
      NFSD: net ref data still needs to be freed even if net hasn't startup

Emil Tantilov (6):
      idpf: keep the netdev when a reset fails
      idpf: convert vport state to bitmap
      idpf: detach and close netdevs while handling a reset
      idpf: fix memory leak in idpf_vport_rel()
      idpf: fix memory leak in idpf_vc_core_deinit()
      idpf: fix error handling in the init_task on load

Eric Biggers (1):
      lib/crypto: aes: Fix missing MMU protection for AES S-box

Eric Dumazet (3):
      wifi: avoid kernel-infoleak from struct iw_point
      udp: call skb_orphan() before skb_attempt_defer_free()
      arp: do not assume dev_hard_header() does not change skb->head

Erik Gabriel Carrillo (1):
      idpf: fix issue with ethtool -n command display

Ernest Van Hoecke (1):
      gpio: pca953x: handle short interrupt pulses on PCAL devices

Even Xu (1):
      HID: Intel-thc-hid: Intel-thc: Fix wrong register reading

Fei Shao (1):
      spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ

Fernando Fernandez Mancera (2):
      netfilter: nft_synproxy: avoid possible data-race on update operation
      netfilter: nf_conncount: update last_gc only when GC has been performed

Filipe Manana (4):
      btrfs: always detect conflicting inodes when logging inode refs
      btrfs: release path before initializing extent tree in btrfs_read_locked_inode()
      btrfs: truncate ordered extent when skipping writeback past i_size
      btrfs: use variable for end offset in extent_writepage_io()

Florian Westphal (3):
      netfilter: nft_set_pipapo: fix range overlap detection
      inet: frags: drop fraglist conntrack references
      netfilter: nf_tables: avoid chain re-validation if possible

Frank Liang (1):
      net/ena: fix missing lock when update devlink params

Gal Pressman (2):
      net/mlx5e: Don't print error message due to invalid module
      selftests: drv-net: Bring back tool() to driver __init__s

Gao Xiang (2):
      erofs: don't bother with s_stack_depth increasing for now
      erofs: fix file-backed mounts no longer working on EROFS partitions

Greg Kroah-Hartman (1):
      Linux 6.18.6

Guo Ren (Alibaba DAMO Academy) (1):
      riscv: pgtable: Cleanup useless VA_USER_XXX definitions

Guodong Xu (1):
      riscv: cpufeature: Fix Zk bundled extension missing Zknh

Haibo Chen (2):
      arm64: dts: imx8qm-mek: correct the light sensor interrupt type to low level
      arm64: dts: add off-on-delay-us for usdhc2 regulator

Haotian Zhang (1):
      counter: 104-quad-8: Fix incorrect return value in IRQ handler

Haoxiang Li (1):
      ALSA: ac97: fix a double free in snd_ac97_controller_register()

Harshita Bhilwaria (1):
      crypto: qat - fix duplicate restarting msg during AER error

Ian Ray (1):
      ARM: dts: imx6q-ba16: fix RTC interrupt level

Ilpo Järvinen (1):
      sparc/PCI: Correct 64-bit non-pref -> pref BAR resources

Ilya Dryomov (3):
      libceph: replace overzealous BUG_ON in osdmap_apply_incremental()
      libceph: return the handler error from mon_handle_auth_done()
      libceph: make calc_target() set t->paused, not just clear it

Jens Axboe (1):
      io_uring/io-wq: fix incorrect io_wq_for_each_worker() termination logic

Jerry Wu (1):
      net: mscc: ocelot: Fix crash when adding interface under a lag

Johannes Berg (1):
      wifi: mac80211: restore non-chanctx injection behaviour

Joshua Hay (1):
      idpf: cap maximum Rx buffer size

Jussi Laako (1):
      ALSA: usb-audio: Update for native DSD support quirks

Kai Vehmanen (1):
      ALSA: hda/realtek: enable woofer speakers on Medion NM14LNL

Kommula Shiva Shankar (1):
      virtio_net: fix device mismatch in devm_kzalloc/devm_kfree

Krzysztof Kozlowski (1):
      ASoC: rockchip: Fix Wvoid-pointer-to-enum-cast warning (again)

Larysa Zaremba (1):
      idpf: fix aux device unplugging when rdma is not supported by vport

Leo Martins (1):
      btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node()

Linus Walleij (1):
      drm/atomic-helper: Export and namespace some functions

Lorenzo Bianconi (2):
      net: airoha: Fix npu rx DMA definitions
      net: airoha: Fix schedule while atomic in airoha_ppe_deinit()

Lorenzo Pieralisi (1):
      irqchip/gic-v5: Fix gicv5_its_map_event() ITTE read endianness

Louis-Alexis Eyraud (1):
      pinctrl: mediatek: mt8189: restore previous register base name array order

Malaya Kumar Rout (1):
      PM: hibernate: Fix crash when freeing invalid crypto compressor

Marcus Hughes (1):
      net: sfp: extend Potron XGSPON quirk to cover additional EEPROM variant

Marek Vasut (1):
      arm64: dts: imx8mp: Fix LAN8740Ai PHY reference clock on DH electronics i.MX8M Plus DHCOM

Mario Limonciello (AMD) (2):
      PCI/VGA: Don't assume the only VGA device on a system is `boot_vga`
      accel/amdxdna: Block running under a hypervisor

Mary Strodl (2):
      gpio: mpsse: ensure worker is torn down
      gpio: mpsse: add quirk support

Mateusz Litwin (1):
      spi: cadence-quadspi: Prevent lost complete() call during indirect read

Maud Spierings (2):
      arm64: dts: freescale: moduline-display: fix compatible
      arm64: dts: freescale: tx8p-ml81: fix eqos nvmem-cells

Maxime Chevallier (1):
      net: sfp: return the number of written bytes for smbus single byte access

Miaoqian Lin (1):
      drm/pl111: Fix error handling in pl111_amba_probe

Michal Luczaj (1):
      vsock: Make accept()ed sockets use custom setsockopt()

Michal Rábek (1):
      scsi: sg: Fix occasional bogus elapsed time that exceeds timeout

Mikulas Patocka (2):
      dm-verity: disable recursive forward error correction
      dm-snapshot: fix 'scheduling while atomic' on real-time kernels

Ming Lei (2):
      ublk: reorder tag_set initialization before queue allocation
      ublk: fix use-after-free in ublk_partition_scan_work

Miquel Sabaté Solà (1):
      btrfs: fix NULL dereference on root when tracing inode eviction

Mohammad Heib (1):
      net: fix memory leak in skb_segment_list for GRO packets

Nathan Chancellor (1):
      drm/amd/display: Apply e4479aecf658 to dml

NeilBrown (2):
      nfsd: provide locking for v4_end_grace
      nfsd: use correct loop termination in nfsd4_revoke_states()

Niklas Cassel (1):
      ata: libata-core: Disable LPM on ST2000DM008-2FR102

Olga Kornievskaia (1):
      nfsd: check that server is running in unlock_filesystem

Patrisious Haddad (1):
      net/mlx5: Lag, multipath, give priority for routes with smaller network prefix

Paweł Narewski (1):
      gpiolib: fix race condition for gdev->srcu

Peter Zijlstra (1):
      perf: Ensure swevent hrtimer is properly destroyed

Petko Manolov (1):
      net: usb: pegasus: fix memory leak in update_eth_regs_async()

Qu Wenruo (3):
      btrfs: qgroup: update all parent qgroups when doing quick inherit
      btrfs: only enforce free space tree if v1 cache is required for bs < ps cases
      btrfs: fix beyond-EOF write handling

René Rebe (1):
      HID: quirks: work around VID/PID conflict for appledisplay

Rosen Penev (1):
      drm/amd/display: shrink struct members

Sam Edwards (1):
      libceph: reset sparse-read state in osd_fault()

Sam James (1):
      alpha: don't reference obsolete termio struct for TC* constants

Scott Mayhew (2):
      NFSD: Fix permission check for read access to executable-only files
      NFSv4: ensure the open stateid seqid doesn't go backwards

Sebastian Andrzej Siewior (1):
      ARM: 9461/1: Disable HIGHPTE on PREEMPT_RT kernels

Sherry Sun (1):
      arm64: dts: imx8qm-ss-dma: correct the dma channels of lpuart

Shivani Gupta (1):
      net/sched: act_api: avoid dereferencing ERR_PTR in tcf_idrinfo_destroy

Sreedevi Joshi (5):
      idpf: fix memory leak of flow steer list on rmmod
      idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
      idpf: Fix RSS LUT configuration on down interfaces
      idpf: Fix RSS LUT NULL ptr issue after soft reset
      idpf: Fix error handling in idpf_vport_open()

Srijit Bose (1):
      bnxt_en: Fix potential data corruption with HW GRO/LRO

Stefan Binding (1):
      ALSA: hda/realtek: Add support for ASUS UM3406GA

Stefano Radaelli (1):
      net: phy: mxl-86110: Add power management and soft reset support

Steven Rostedt (1):
      tracing: Add recursion protection in kernel stack trace recording

Suchit Karunakaran (1):
      btrfs: fix NULL pointer dereference in do_abort_log_replay()

Suganath Prabu S (1):
      scsi: mpi3mr: Prevent duplicate SAS/SATA device entries in channel 1

Sumeet Pawnikar (2):
      powercap: fix race condition in register_control_type()
      powercap: fix sscanf() error return value handling

Takashi Iwai (1):
      ALSA: hda: intel-dsp-config: Prefer legacy driver as fallback

Tetsuo Handa (2):
      bpf: Fix reference count leak in bpf_prog_test_run_xdp()
      can: j1939: make j1939_session_activate() fail if device is no longer registered

Thomas Fourier (3):
      atm: Fix dma_free_coherent() size
      net: 3com: 3c59x: fix possible null dereference in vortex_probe1()
      HID: Intel-thc-hid: Intel-thc: fix dma_unmap_sg() nents value

Toke Høiland-Jørgensen (1):
      bpf, test_run: Subtract size of xdp_frame from allowed metadata size

Tomi Valkeinen (3):
      Revert "drm/atomic-helper: Re-order bridge chain pre-enable and post-disable"
      drm/tidss: Fix enable/disable order
      Revert "drm/mediatek: dsi: Fix DSI host and panel bridge pre-enable order"

Trond Myklebust (1):
      NFS: Fix up the automount fs_context to use the correct cred

Tuo Li (1):
      libceph: make free_choose_arg_map() resilient to partial allocation

Vivian Wang (1):
      riscv: boot: Always make Image from vmlinux, not vmlinux.unstripped

Vladimir Oltean (1):
      Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable"

Wadim Egorov (3):
      arm64: dts: ti: k3-am642-phyboard-electra-peb-c-010: Fix icssg-prueth schema warning
      arm64: dts: ti: k3-am642-phyboard-electra-x27-gpio1-spi1-uart3: Fix schema warnings
      arm64: dts: ti: k3-am62-lp-sk-nand: Rename pinctrls to fix schema warnings

Wei Fang (1):
      net: enetc: fix build warning when PAGE_SIZE is greater than 128K

Weiming Shi (1):
      net: sock: fix hardened usercopy panic in sock_recv_errqueue

Wen Xiong (1):
      scsi: ipr: Enable/disable IRQD_NO_BALANCING during reset

Willem de Bruijn (1):
      net: do not write to msg_get_inq in callee

Xiang Mei (1):
      net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset

Xingui Yang (1):
      scsi: Revert "scsi: libsas: Fix exp-attached device scan after probe failure scanned in again after probe failed"

Yang Li (1):
      csky: fix csky_cmpxchg_fixup not working

Yang Wang (2):
      drm/amd/pm: fix wrong pcie parameter on navi1x
      drm/amd/pm: force send pcie parmater on navi1x

Yeoreum Yun (1):
      arm64: Fix cleared E0POE bit after cpu_suspend()/resume()

Yohei Kojima (1):
      net: netdevsim: fix inconsistent carrier state after link/unlink

Zilin Guan (3):
      of: unittest: Fix memory leak in unittest_data_add()
      netfilter: nf_tables: fix memory leak in nf_tables_newrule()
      net: wwan: iosm: Fix memory leak in ipc_mux_deinit()

yuan.gao (1):
      inet: ping: Fix icmp out counting

ziming zhang (1):
      libceph: prevent potential out-of-bounds reads in handle_auth_done()


