Return-Path: <stable+bounces-139436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF1AA6A6F
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C00189B88F
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 06:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B781E5718;
	Fri,  2 May 2025 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hExroju+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76E1C6FE1;
	Fri,  2 May 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746166042; cv=none; b=h+8LaPpu/jhAfNWhLIrUw0cr2wVrsv/lttQrbyj+duQDg/LnxOKjLE1Gqn6dbiNJ0OKH4/EJONt42EPlx2/LaA6fhuLckPWOjXCFdB0RFk/w0UI5BjXk/8pDn8JtQpU6oCj9wKNdLm9oojbtrvBQ3zYWd5bLiySo3BM03Lq4efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746166042; c=relaxed/simple;
	bh=NrGHji43i1Hs0He3T3LAnJ2WdRVRXx9qf14faeTsndo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtcB/P8JmaU7b90acYPn7yWguOpB/QZ9C9vU+RXpHVg/HftXsQPENC+oLra+qOs+9Xy6+AdSVwWgjUaQ2IFviU8TZ/OZZnX0nXK4RoEZFU3S9Len4o8y0lMbBhFQKUO9+feKKq3j3dGJUuA6VUBL5ewmK6qRF2lVQMmIXnTDFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hExroju+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C69C4CEE4;
	Fri,  2 May 2025 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746166041;
	bh=NrGHji43i1Hs0He3T3LAnJ2WdRVRXx9qf14faeTsndo=;
	h=From:To:Cc:Subject:Date:From;
	b=hExroju+xMYZHXnEsrSJ7qeXcmBoewbkSmtfw6DOPExp2P8nWd0bevkdONPcaOXmg
	 ddezGWRIbI65zWiTqE/q3AYGmj0ciUEb/VPBxh+rk3yslXC2Bjew29zN8MuVajNFoQ
	 N0hPIV/SWk4yXUi+FGw3+Z6OGiGGaXLNx4JsULaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.237
Date: Fri,  2 May 2025 08:07:03 +0200
Message-ID: <2025050204-edging-exclaim-56c3@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.237 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    5 
 arch/arm/mach-exynos/Kconfig                                |    1 
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                    |    6 
 arch/arm64/include/asm/cputype.h                            |    4 
 arch/arm64/kernel/proton-pack.c                             |    1 
 arch/mips/dec/prom/init.c                                   |    2 
 arch/mips/include/asm/ds1287.h                              |    2 
 arch/mips/include/asm/mips-cm.h                             |   22 +
 arch/mips/kernel/cevt-ds1287.c                              |    1 
 arch/mips/kernel/mips-cm.c                                  |   14 +
 arch/parisc/kernel/pdt.c                                    |    2 
 arch/powerpc/kernel/rtas.c                                  |    4 
 arch/riscv/include/asm/kgdb.h                               |    9 
 arch/riscv/include/asm/syscall.h                            |    7 
 arch/riscv/kernel/kgdb.c                                    |    6 
 arch/s390/kvm/trace-s390.h                                  |    4 
 arch/sparc/mm/tlb.c                                         |    5 
 arch/x86/entry/entry.S                                      |    2 
 arch/x86/events/intel/ds.c                                  |    8 
 arch/x86/events/intel/uncore_snbep.c                        |   49 ---
 arch/x86/kernel/cpu/amd.c                                   |    2 
 arch/x86/kernel/cpu/bugs.c                                  |    8 
 arch/x86/kernel/e820.c                                      |   17 -
 arch/x86/kvm/svm/avic.c                                     |   60 ++--
 arch/x86/kvm/vmx/posted_intr.c                              |   28 --
 arch/x86/platform/pvh/head.S                                |    7 
 block/blk-cgroup.c                                          |   24 +
 block/blk-iocost.c                                          |    7 
 crypto/crypto_null.c                                        |   39 +-
 drivers/acpi/pptt.c                                         |    4 
 drivers/ata/ahci.c                                          |    2 
 drivers/ata/libata-eh.c                                     |   11 
 drivers/ata/pata_pxa.c                                      |    6 
 drivers/ata/sata_sx4.c                                      |  118 +++-----
 drivers/bluetooth/btrtl.c                                   |    2 
 drivers/bluetooth/hci_ldisc.c                               |   19 +
 drivers/bluetooth/hci_uart.h                                |    1 
 drivers/char/virtio_console.c                               |    7 
 drivers/clk/clk.c                                           |    4 
 drivers/clocksource/timer-stm32-lp.c                        |    4 
 drivers/cpufreq/cpufreq.c                                   |    8 
 drivers/cpufreq/scpi-cpufreq.c                              |   13 
 drivers/crypto/atmel-sha204a.c                              |    7 
 drivers/crypto/caam/qi.c                                    |    6 
 drivers/crypto/ccp/sp-pci.c                                 |   15 -
 drivers/dma-buf/udmabuf.c                                   |    2 
 drivers/dma/dmatest.c                                       |    6 
 drivers/gpio/gpio-zynq.c                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c                 |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                |    6 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                    |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c      |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   14 -
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c       |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c       |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c     |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c     |    2 
 drivers/gpu/drm/drm_atomic_helper.c                         |    2 
 drivers/gpu/drm/drm_panel.c                                 |    5 
 drivers/gpu/drm/drm_panel_orientation_quirks.c              |   10 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                   |    7 
 drivers/gpu/drm/mediatek/mtk_dpi.c                          |    9 
 drivers/gpu/drm/nouveau/nouveau_bo.c                        |    3 
 drivers/gpu/drm/nouveau/nouveau_gem.c                       |    3 
 drivers/gpu/drm/sti/Makefile                                |    2 
 drivers/gpu/drm/tiny/repaper.c                              |    4 
 drivers/hid/usbhid/hid-pidff.c                              |   60 +++-
 drivers/hsi/clients/ssi_protocol.c                          |    1 
 drivers/i2c/busses/i2c-cros-ec-tunnel.c                     |    3 
 drivers/i3c/master.c                                        |    3 
 drivers/iio/adc/ad7768-1.c                                  |    5 
 drivers/infiniband/core/umem_odp.c                          |    6 
 drivers/infiniband/hw/hns/hns_roce_main.c                   |    2 
 drivers/infiniband/hw/qib/qib_fs.c                          |    1 
 drivers/infiniband/hw/usnic/usnic_ib_main.c                 |   14 -
 drivers/iommu/amd/iommu.c                                   |    2 
 drivers/mcb/mcb-parse.c                                     |    2 
 drivers/md/dm-cache-target.c                                |   24 +
 drivers/md/dm-integrity.c                                   |    3 
 drivers/md/raid1.c                                          |   26 +
 drivers/media/common/siano/smsdvb-main.c                    |    2 
 drivers/media/i2c/adv748x/adv748x.h                         |    2 
 drivers/media/i2c/ov7251.c                                  |    4 
 drivers/media/platform/qcom/venus/Makefile                  |    3 
 drivers/media/platform/qcom/venus/core.c                    |   17 -
 drivers/media/platform/qcom/venus/core.h                    |   41 ---
 drivers/media/platform/qcom/venus/helpers.c                 |   60 ++--
 drivers/media/platform/qcom/venus/helpers.h                 |    2 
 drivers/media/platform/qcom/venus/hfi.c                     |   18 +
 drivers/media/platform/qcom/venus/hfi_parser.c              |  159 +++++++++---
 drivers/media/platform/qcom/venus/hfi_parser.h              |    2 
 drivers/media/platform/qcom/venus/hfi_platform.c            |   49 +++
 drivers/media/platform/qcom/venus/hfi_platform.h            |   61 ++++
 drivers/media/platform/qcom/venus/hfi_platform_v4.c         |   60 ++++
 drivers/media/platform/qcom/venus/hfi_venus.c               |   18 +
 drivers/media/platform/qcom/venus/pm_helpers.c              |   12 
 drivers/media/platform/qcom/venus/vdec.c                    |    8 
 drivers/media/platform/qcom/venus/venc.c                    |   91 ++++--
 drivers/media/rc/streamzap.c                                |  135 ++++------
 drivers/media/test-drivers/vim2m.c                          |    6 
 drivers/media/v4l2-core/v4l2-dv-timings.c                   |    4 
 drivers/mfd/ene-kb3930.c                                    |    2 
 drivers/misc/mei/hw-me-regs.h                               |    1 
 drivers/misc/mei/pci-me.c                                   |    1 
 drivers/misc/pci_endpoint_test.c                            |    6 
 drivers/mtd/inftlcore.c                                     |    9 
 drivers/mtd/mtdpstore.c                                     |    9 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                    |    2 
 drivers/mtd/nand/raw/r852.c                                 |    3 
 drivers/net/dsa/b53/b53_common.c                            |   10 
 drivers/net/dsa/mv88e6xxx/chip.c                            |   25 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c          |    1 
 drivers/net/ethernet/intel/igc/igc_main.c                   |    1 
 drivers/net/ethernet/intel/igc/igc_ptp.c                    |    7 
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c      |   15 -
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |   33 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h             |    3 
 drivers/net/phy/phy_led_triggers.c                          |   23 -
 drivers/net/ppp/ppp_synctty.c                               |    5 
 drivers/net/wireless/ath/ath10k/sdio.c                      |    5 
 drivers/net/wireless/atmel/at76c50x-usb.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c             |    1 
 drivers/net/wireless/ti/wl1251/tx.c                         |    4 
 drivers/ntb/hw/idt/ntb_hw_idt.c                             |   18 -
 drivers/ntb/ntb_transport.c                                 |    2 
 drivers/nvme/host/core.c                                    |   10 
 drivers/nvme/target/fc.c                                    |   14 -
 drivers/nvme/target/fcloop.c                                |    2 
 drivers/of/irq.c                                            |   13 
 drivers/pci/controller/pcie-brcmstb.c                       |   13 
 drivers/pci/pci.c                                           |  103 ++++---
 drivers/pci/probe.c                                         |   58 +++-
 drivers/pci/remove.c                                        |    7 
 drivers/perf/arm_pmu.c                                      |    8 
 drivers/phy/tegra/xusb.c                                    |    2 
 drivers/pinctrl/qcom/pinctrl-msm.c                          |   12 
 drivers/platform/x86/asus-laptop.c                          |    9 
 drivers/platform/x86/intel_speed_select_if/isst_if_common.c |    2 
 drivers/pwm/pwm-fsl-ftm.c                                   |    6 
 drivers/pwm/pwm-mediatek.c                                  |   20 +
 drivers/pwm/pwm-rcar.c                                      |   24 -
 drivers/s390/block/dasd.c                                   |    5 
 drivers/scsi/lpfc/lpfc_hbadisc.c                            |    2 
 drivers/scsi/pm8001/pm8001_sas.c                            |    1 
 drivers/scsi/scsi_transport_iscsi.c                         |    7 
 drivers/scsi/st.c                                           |    2 
 drivers/scsi/ufs/ufs_bsg.c                                  |    1 
 drivers/soc/samsung/Kconfig                                 |   12 
 drivers/soc/samsung/Makefile                                |    3 
 drivers/soc/samsung/exynos-asv.c                            |   45 ---
 drivers/soc/samsung/exynos-asv.h                            |    2 
 drivers/soc/samsung/exynos-chipid.c                         |  137 ++++++++--
 drivers/soc/ti/omap_prm.c                                   |    2 
 drivers/spi/spi-cadence-quadspi.c                           |    6 
 drivers/staging/comedi/drivers/jr3_pci.c                    |   15 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c                   |    2 
 drivers/thermal/rockchip_thermal.c                          |    1 
 drivers/tty/serial/sifive.c                                 |    6 
 drivers/usb/cdns3/gadget.c                                  |    2 
 drivers/usb/core/quirks.c                                   |    9 
 drivers/usb/dwc3/gadget.c                                   |    6 
 drivers/usb/gadget/udc/aspeed-vhub/dev.c                    |    3 
 drivers/usb/host/max3421-hcd.c                              |    7 
 drivers/usb/host/ohci-pci.c                                 |   23 +
 drivers/usb/serial/ftdi_sio.c                               |    2 
 drivers/usb/serial/ftdi_sio_ids.h                           |    5 
 drivers/usb/serial/option.c                                 |    3 
 drivers/usb/serial/usb-serial-simple.c                      |    7 
 drivers/usb/storage/unusual_uas.h                           |    7 
 drivers/vdpa/mlx5/core/mr.c                                 |    7 
 drivers/vfio/pci/vfio_pci.c                                 |   13 
 drivers/video/backlight/led_bl.c                            |    5 
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                |    6 
 drivers/xen/xenfs/xensyms.c                                 |    4 
 fs/Kconfig                                                  |    1 
 fs/btrfs/super.c                                            |    3 
 fs/cifs/cifs_debug.c                                        |    6 
 fs/cifs/cifsglob.h                                          |    9 
 fs/cifs/cifsproto.h                                         |    7 
 fs/cifs/connect.c                                           |    2 
 fs/cifs/smb2misc.c                                          |   11 
 fs/cifs/smb2ops.c                                           |   48 ++-
 fs/cifs/smb2pdu.c                                           |   10 
 fs/cifs/transport.c                                         |   43 +--
 fs/ext4/block_validity.c                                    |    5 
 fs/ext4/inode.c                                             |   76 ++++-
 fs/ext4/namei.c                                             |    2 
 fs/ext4/super.c                                             |   19 +
 fs/ext4/xattr.c                                             |   11 
 fs/f2fs/node.c                                              |    9 
 fs/fuse/virtio_fs.c                                         |    3 
 fs/hfs/bnode.c                                              |    6 
 fs/hfsplus/bnode.c                                          |    6 
 fs/isofs/export.c                                           |    2 
 fs/jbd2/journal.c                                           |    1 
 fs/jfs/jfs_dmap.c                                           |   12 
 fs/jfs/jfs_imap.c                                           |    2 
 fs/namespace.c                                              |    3 
 fs/nfs/Kconfig                                              |    2 
 fs/nfs/internal.h                                           |   22 -
 fs/nfs/nfs4session.h                                        |    4 
 fs/nfsd/Kconfig                                             |    1 
 fs/nfsd/nfs4state.c                                         |    2 
 fs/nfsd/nfsfh.h                                             |    7 
 fs/proc/array.c                                             |   52 ++-
 include/linux/backing-dev.h                                 |    1 
 include/linux/blk-cgroup.h                                  |    1 
 include/linux/filter.h                                      |    4 
 include/linux/nfs.h                                         |   13 
 include/linux/pci.h                                         |   12 
 include/linux/soc/samsung/exynos-chipid.h                   |    6 
 include/net/net_namespace.h                                 |    1 
 include/net/sctp/structs.h                                  |    3 
 include/uapi/linux/kfd_ioctl.h                              |    2 
 include/xen/interface/xen-mca.h                             |    2 
 init/Kconfig                                                |    3 
 kernel/bpf/helpers.c                                        |   11 
 kernel/bpf/syscall.c                                        |   17 -
 kernel/dma/contiguous.c                                     |    3 
 kernel/locking/lockdep.c                                    |    3 
 kernel/resource.c                                           |   41 ---
 kernel/sched/cpufreq_schedutil.c                            |   18 +
 kernel/trace/ftrace.c                                       |    1 
 kernel/trace/trace.h                                        |    4 
 kernel/trace/trace_events.c                                 |    4 
 kernel/trace/trace_events_filter.c                          |    4 
 kernel/trace/trace_events_hist.c                            |    7 
 kernel/trace/trace_events_synth.c                           |   82 ++++++
 kernel/trace/trace_synth.h                                  |    1 
 lib/sg_split.c                                              |    2 
 mm/memory.c                                                 |    4 
 mm/vmscan.c                                                 |    2 
 net/8021q/vlan_dev.c                                        |   31 --
 net/bluetooth/hci_event.c                                   |    5 
 net/core/dev.c                                              |    1 
 net/core/filter.c                                           |   80 +++---
 net/core/net_namespace.c                                    |   21 +
 net/core/page_pool.c                                        |    8 
 net/ipv4/inet_connection_sock.c                             |   19 +
 net/mac80211/iface.c                                        |    3 
 net/mac80211/mesh_hwmp.c                                    |   14 -
 net/mptcp/protocol.c                                        |   45 +++
 net/mptcp/subflow.c                                         |   15 -
 net/netfilter/ipvs/ip_vs_ctl.c                              |   10 
 net/netfilter/nft_set_pipapo_avx2.c                         |    3 
 net/openvswitch/actions.c                                   |    4 
 net/openvswitch/flow_netlink.c                              |    3 
 net/sched/sch_hfsc.c                                        |   23 +
 net/sctp/socket.c                                           |   22 +
 net/sctp/transport.c                                        |    2 
 net/tipc/link.c                                             |    1 
 net/tipc/monitor.c                                          |    3 
 net/tls/tls_main.c                                          |    6 
 sound/pci/hda/hda_intel.c                                   |   15 +
 sound/soc/codecs/wcd934x.c                                  |    2 
 sound/soc/qcom/qdsp6/q6asm-dai.c                            |   19 -
 sound/usb/midi.c                                            |   80 +++++-
 tools/objtool/check.c                                       |    3 
 tools/power/cpupower/bench/parse.c                          |    4 
 tools/testing/selftests/mincore/mincore_selftest.c          |    3 
 tools/testing/selftests/ublk/test_stripe_04.sh              |   24 +
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh       |    4 
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh      |    2 
 265 files changed, 2371 insertions(+), 1187 deletions(-)

Abdun Nihaal (3):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: wl1251: fix memory leak in wl1251_tx_work
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path

Abhinav Kumar (1):
      drm: allow encoder mode_set even when connectors change for crtc

Abhishek Sahu (1):
      vfio/pci: fix memory leak during D3hot to D0 transition

Adam Xue (1):
      USB: serial: option: add Sierra Wireless EM9291

Al Viro (1):
      qibfs: fix _another_ leak

Alexander Stein (1):
      usb: host: max3421-hcd: Add missing spi_device_id table

Alexander Usyskin (1):
      mei: me: add panther lake H DID

Alexandra Diupina (1):
      cifs: avoid NULL pointer dereference in dbg call

Alexandre Torgue (1):
      clocksource/drivers/stm32-lptimer: Use wakeup capable instead of init wakeup

Alexey Klimov (1):
      ASoC: qdsp6: q6asm-dai: fix q6asm_dai_compr_set_params error path

Andreas Gruenbacher (1):
      writeback: fix false warning in inode_to_wb()

Andrew Wyatt (2):
      drm: panel-orientation-quirks: Add support for AYANEO 2S
      drm: panel-orientation-quirks: Add new quirk for GPD Win 2

Andrii Nakryiko (1):
      bpf: avoid holding freeze_mutex during mmap operation

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dpi: Explicitly manage TVD clock in power on/off

Ard Biesheuvel (1):
      x86/pvh: Call C code via the kernel virtual mapping

Arnaud Lecomte (1):
      net: ppp: Add bound checking for skb data on ppp_sync_txmung

Arnd Bergmann (2):
      dma/contiguous: avoid warning about unused size_bytes
      ntb: reduce stack usage in idt_scan_mws

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Artem Sadovnikov (1):
      ext4: fix off-by-one error in do_split

Ben Dooks (1):
      bpf: Add endian modifiers to fix endian warnings

Bhupesh (1):
      ext4: ignore xattrs past end

Boqun Feng (2):
      locking/lockdep: Decrease nr_unused_locks if lock unused in zap_class()
      PCI: Introduce domain_nr in pci_host_bridge

Chao Yu (1):
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()

Chen Hanxiao (1):
      ipvs: properly dereference pe in ip_vs_add_service

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string

Chengchang Tang (1):
      RDMA/hns: Fix wrong maximum DMA segment size

Chenyuan Yang (3):
      mfd: ene-kb3930: Fix a potential NULL pointer dereference
      soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      usb: gadget: aspeed: Add NULL pointer check in ast_vhub_init_dev()

Chris Bainbridge (1):
      drm/nouveau: prime: fix ttm_bo_delayed_delete oops

Chris Wilson (1):
      drm/i915/gt: Cleanup partial engine discovery failures

Christopher S M Hall (2):
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails

Chunguang Xu (1):
      nvme: avoid double free special payload

Colin Ian King (1):
      media: venus: Fix uninitialized variable count being checked for zero

Cong Wang (2):
      net_sched: hfsc: Fix a UAF vulnerability in class handling
      net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too

Craig Hesling (1):
      USB: serial: simple: add OWON HDS200 series oscilloscope support

Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Daniel Golle (1):
      pwm: mediatek: always use bus clock for PWM on MT7622

Daniel Kral (1):
      ahci: add PCI ID for Marvell 88SE9215 SATA Controller

Daniel Wagner (1):
      nvmet-fcloop: swap list_add_tail arguments

Dapeng Mi (1):
      perf/x86/intel: Allow to update user space GPRs from PEBS records

David Yat Sin (1):
      drm/amdkfd: clamp queue size to minimum

Denis Arefev (4):
      asus-laptop: Fix an uninitialized variable
      drm/amd/pm/powerplay: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/smu7_thermal: Prevent division by zero
      drm/amd/pm/powerplay/hwmgr/vega20_thermal: Prevent division by zero

Douglas Anderson (3):
      arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
      arm64: cputype: Add MIDR_CORTEX_A76AE
      arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list

Douglas Raillard (1):
      tracing: Fix synth event printk format for str fields

Duoming Zhou (1):
      drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()

Edward Adam Davis (3):
      jfs: Prevent copying of nlink with value 0 from disk inode
      jfs: add sanity check for agwidth in dbMount
      isofs: Prevent the use of too small fid

Enzo Matsumiya (2):
      smb: client: fix UAF in async decryption
      cifs: print TIDs as hex

Eric Biggers (2):
      ext4: reject casefold inode flag without casefold feature
      nfs: add missing selections of CONFIG_CRC32

Eric Dumazet (1):
      net: defer final 'struct net' free in netns dismantle

Fabien Parent (1):
      pwm: mediatek: Always use bus clock

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Felix Huettner (1):
      net: openvswitch: fix race on port output

Florian Westphal (1):
      nft_set_pipapo: fix incorrect avx2 match of 5th field octet

Frode Isaksen (1):
      usb: dwc3: gadget: check that event count does not exceed event buffer length

Gabriele Paoloni (1):
      tracing: fix return value in __ftrace_event_enable_disable for TRACE_REG_UNREGISTER

Gang Yan (1):
      mptcp: fix NULL pointer in can_accept_new_subflow

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geert Uytterhoeven (1):
      pwm: rcar: Simplify multiplication/shift logic

Greg Kroah-Hartman (1):
      Linux 5.10.237

Gregory CLEMENT (1):
      MIPS: cm: Detect CM quirks from device tree

Guixin Liu (1):
      scsi: ufs: bsg: Set bsg_queue to NULL after removal

Halil Pasic (1):
      virtio_console: fix missing byte order handling for cols and rows

Hannes Reinecke (4):
      ata: sata_sx4: Drop pointless VPRINTK() calls and convert the remaining ones
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes
      nvme: fixup scan failure for non-ANA multipath controllers

Hans de Goede (1):
      drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()

Haoxiang Li (1):
      mcb: fix a double free bug in chameleon_parse_gdd()

Heiko Stuebner (1):
      clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()

Henry Martin (2):
      ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Herbert Xu (2):
      crypto: caam/qi - Fix drv_ctx refcount bug
      crypto: null - Use spin lock instead of mutex

Hersen Wu (1):
      drm/amd/display: Stop amdgpu_dm initialize when link nums greater than max_links

Herve Codina (1):
      backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()

Hou Tao (1):
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers

Huacai Chen (1):
      USB: OHCI: Add quirk for LS7A OHCI controller (rev 0x02)

Ian Abbott (1):
      comedi: jr3_pci: Fix synchronous deletion of timer

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Igor Pylypiv (1):
      scsi: pm80xx: Set phy_attached to zero when device is gone

Ilya Maximets (2):
      net: openvswitch: fix nested key length validation in the set() action
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (1):
      net: tls: explicitly disallow disconnect

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Jan Kara (1):
      jbd2: remove wrong sb->s_sequence check

Jann Horn (1):
      ext4: don't treat fhandle lookup of ea_inode as FS corruption

Jason Xing (1):
      page_pool: avoid infinite loop to schedule delayed worker

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Jeff Layton (1):
      nfs: move nfs_fhandle_hash to common include file

Jiasheng Jiang (1):
      mtd: Replace kcalloc() with devm_kcalloc()

Johannes Berg (1):
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Johannes Kimmel (1):
      btrfs: correctly escape subvol in btrfs_show_options()

Jonas Gorski (1):
      net: b53: enable BPDU reception for management port

Jonathan Cameron (1):
      iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check

Josh Poimboeuf (5):
      pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()
      objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
      objtool: Stop UNRET validation on UD2
      x86/bugs: Use SBPB in write_ibpb() if applicable
      x86/bugs: Don't fill RSB on VMEXIT with eIBRS+retpoline

Kai Mäkisara (1):
      scsi: st: Fix array overflow in st_setup()

Kai-Heng Feng (1):
      PCI: Coalesce host bridge contiguous apertures

Kaixin Wang (1):
      HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition

Kamal Dasu (1):
      mtd: rawnand: brcmnand: fix PM resume warning

Kan Liang (2):
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR
      perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX

Kang Yang (1):
      wifi: ath10k: avoid NULL pointer error during sdio remove

Karina Yankevich (1):
      media: v4l2-dv-timings: prevent possible overflow in v4l2_detect_gtf()

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Kirill A. Shutemov (1):
      mm: fix apply_to_existing_page_range()

Krzysztof Kozlowski (5):
      gpio: zynq: Fix wakeup source leaks on device unbind
      soc: samsung: exynos-chipid: initialize later - with arch_initcall
      soc: samsung: exynos-chipid: convert to driver and merge exynos-asv
      soc: samsung: exynos-chipid: avoid soc_device_to_device()
      soc: samsung: exynos-chipid: correct helpers __init annotation

Kunihiko Hayashi (3):
      misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
      misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
      misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Kunwu Chan (1):
      pmdomain: ti: Add a null pointer check to the omap_prm_domain_init

Lee Jones (1):
      drm/amd/amdgpu/amdgpu_vram_mgr: Add missing descriptions for 'dev' and 'dir'

Leonid Arapov (1):
      fbdev: omapfb: Add 'plane' value check

Li Lingfeng (1):
      nfsd: decrease sc_count directly if fail to queue dl_recall

Li Nan (1):
      blk-iocost: do not WARN if iocg was already offlined

Luca Ceresoli (1):
      drm/bridge: panel: forbid initializing a panel with unknown connector type

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Ma Ke (2):
      PCI: Fix reference leak in pci_alloc_child_bus()
      PCI: Fix reference leak in pci_register_host_bridge()

Manjunatha Venkatesh (1):
      i3c: Add NULL pointer check in i3c_master_queue_ibi()

Marek Behún (3):
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      crypto: atmel-sha204a - Set hwrng quality to lowest possible

Mark Brown (1):
      selftests/mm: generate a temporary mountpoint for cgroup filesystem

Mark Rutland (1):
      perf: arm_pmu: Don't disable counter in armpmu_add()

Mathieu Desnoyers (1):
      mm: add missing release barrier on PGDAT_RECLAIM_LOCKED unlock

Matthew Auld (1):
      drm/amdgpu/dma_buf: fix page_link check

Matthew Majewski (1):
      media: vim2m: print device name after registering device

Matthieu Baerts (NGI0) (2):
      mptcp: only inc MPJoinAckHMacFailure for HMAC failures
      mptcp: sockopt: fix getting IPV6_V6ONLY

Max Grobecker (1):
      x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine

Maxim Mikityanskiy (1):
      ALSA: hda: intel: Fix Optimus when GPU has no sound

Meir Elisha (1):
      md/raid1: Add check for missing source disk in process_checks()

Miao Li (2):
      usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
      usb: quirks: Add delay init quirk for SanDisk 3.2Gen1 Flash Drive

Miaohe Lin (1):
      kernel/resource: fix kfree() of bootmem memory again

Miaoqian Lin (2):
      scsi: iscsi: Fix missing scsi_host_put() in error path
      phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function

Michael Ehrenreich (1):
      USB: serial: ftdi_sio: add support for Abacus Electrics Optical Probe

Mikulas Patocka (1):
      dm-integrity: set ti->error on memory allocation failure

Ming Lei (1):
      selftests: ublk: fix test_stripe_04

Ming-Hung Tsai (1):
      dm cache: fix flushing uninitialized delayed_work on cache_ctr error

Miquel Raynal (1):
      spi: cadence-qspi: Fix probe on AM62A LP SK

Miroslav Franc (1):
      s390/dasd: fix double module refcount decrement

Murad Masimov (2):
      media: streamzap: prevent processing IR data on URB failure
      media: streamzap: fix race between device disconnection and urb callback

Myrrh Periwinkle (1):
      x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

Nathan Chancellor (2):
      riscv: Avoid fortify warning in syscall_get_arguments()
      kbuild: Add '-fno-builtin-wcslen'

Nathan Lynch (1):
      powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()

Nikita Zhandarovich (1):
      drm/repaper: fix integer overflows in repeat functions

Niklas Cassel (1):
      ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode

Niklas Söderlund (1):
      media: i2c: adv748x: Fix test pattern selection mask

Ojaswin Mujoo (2):
      ext4: protect ext4_release_dquot against freezing
      ext4: make block validity check resistent to sb bh corruption

Oleg Nesterov (2):
      fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
      sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

Oliver Neukum (2):
      USB: storage: quirk for ADATA Portable HDD CH94
      USB: VLI disk crashes if LPM is used

Pali Rohár (1):
      PCI: Assign PCI domain IDs by ida_alloc()

Paulo Alcantara (5):
      smb: client: fix potential UAF in cifs_debug_files_proc_show()
      smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
      smb: client: fix potential deadlock when releasing mids
      smb: client: fix potential UAF in cifs_stats_proc_show()
      smb: client: fix NULL ptr deref in crypto_aead_setkey()

Pei Li (1):
      jfs: Fix shift-out-of-bounds in dbDiscardAG

Philip Yang (1):
      drm/amdkfd: Fix pqm_destroy_queue race with GPU reset

Qingfang Deng (1):
      net: phy: leds: fix memory leak

Qiuxu Zhuo (1):
      selftests/mincore: Allow read-ahead pages to reach the end of the file

Rafael J. Wysocki (2):
      cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
      cpufreq: Reference count policy in cpufreq_update_limits()

Ralph Siemsen (1):
      usb: cdns3: Fix deadlock when using NCM gadget

Ramesh Errabolu (1):
      drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)

Rand Deeb (2):
      fs/jfs: cast inactags to s64 to prevent potential overflow
      fs/jfs: Prevent integer overflow in AG size calculation

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Ricard Wanderlof (1):
      ALSA: usb-audio: Fix CME quirk for UF series keyboards

Ricardo Cañuelo Navarro (1):
      sctp: detect and prevent references to a freed transport in sendmsg

Rob Herring (1):
      PCI: Fix use-after-free in pci_bus_release_domain_nr()

Rolf Eike Beer (1):
      drm/sti: remove duplicate object names

Ryan Roberts (1):
      sparc/mm: disable preemption in lazy mmu mode

Ryo Takakura (1):
      serial: sifive: lock port in startup()/shutdown() callbacks

Sakari Ailus (2):
      media: i2c: ov7251: Set enable GPIO low in probe
      media: i2c: ov7251: Introduce 1 ms delay between regulators and en GPIO

Sam Protsenko (1):
      soc: samsung: exynos-chipid: Pass revision reg offsets

Sean Christopherson (3):
      iommu/amd: Return an error if vCPU affinity is set for non-vCPU IRTE
      KVM: SVM: Allocate IR data using atomic allocation
      KVM: x86: Reset IRTE to host control if *new* route isn't postable

Sean Young (4):
      media: streamzap: remove unnecessary ir_raw_event_reset and handle
      media: streamzap: no need for usb pid/vid in device name
      media: streamzap: less chatter
      media: streamzap: remove unused struct members

Sebastian Andrzej Siewior (1):
      xdp: Reset bpf_redirect_info before running a xdp's BPF prog.

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Fix conversion result sign

Shay Drory (1):
      RDMA/core: Silence oversized kvmalloc() warning

Si-Wei Liu (1):
      vdpa/mlx5: Fix oversized null mkey longer than 32bit

Srinivas Pandruvada (1):
      platform/x86: ISST: Correct command storage data length

Srinivasan Shanmugam (1):
      drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'

Stanimir Varbanov (10):
      PCI: brcmstb: Fix missing of_node_put() in brcm_pcie_probe()
      media: venus: venc: Init the session only once in queue_setup
      media: venus: Limit HFI sessions to the maximum supported
      media: venus: hfi: Correct session init return error
      media: venus: pm_helpers: Check instance state when calculate instance frequency
      media: venus: Create hfi platform and move vpp/vsp there
      media: venus: Rename venus_caps to hfi_plat_caps
      media: venus: hfi_plat: Add codecs and capabilities ops
      media: venus: Get codecs and capabilities from hfi platform
      media: venus: hfi_parser: Check for instance after hfi platform get

Stanislav Fomichev (1):
      net: vlan: don't propagate flags on open

Stephan Gerhold (1):
      pinctrl: qcom: Clear latched interrupt status when changing IRQ type

Steven Rostedt (1):
      tracing: Fix filter string testing

Steven Rostedt (Google) (1):
      tracing: Allow synthetic events to pass around stacktraces

T Pratham (1):
      lib: scatterlist: fix sg_split_phys to preserve original scatterlist offsets

Thadeu Lima de Souza Cascardo (1):
      i2c: cros-ec-tunnel: defer probe if parent EC is not present

Thomas Bogendoerfer (1):
      MIPS: cm: Fix warning if MIPS_CM is disabled

Thomas Weißschuh (1):
      KVM: s390: Don't use %pK through tracepoints

Thorsten Leemhuis (1):
      module: sign with sha512 instead of sha1 by default

Tom Lendacky (1):
      crypto: ccp - Fix check for the primary ASP device

Tomasz Pakuła (3):
      HID: pidff: Convert infinite length from Linux API to PID standard
      HID: pidff: Do not send effect envelope if it's empty
      HID: pidff: Fix null pointer dereference in pidff_find_fields

Trevor Woerner (1):
      thermal/drivers/rockchip: Add missing rk3328 mapping entry

Trond Myklebust (1):
      umount: Allow superblock owners to force umount

Tung Nguyen (2):
      tipc: fix memory leak in tipc_link_xmit
      tipc: fix NULL pointer dereference in tipc_mon_reinit_self()

Tuo Li (1):
      scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()

Uwe Kleine-König (2):
      pwm: rcar: Improve register calculation
      pwm: fsl-ftm: Handle clk_get_rate() returning 0

Vasiliy Kovalev (1):
      hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key

Vikash Garodia (4):
      media: venus: hfi: add a check to handle OOB in sfr region
      media: venus: hfi: add check to handle incorrect queue size
      media: venus: hfi_parser: add check to avoid out of bound access
      media: venus: hfi_parser: refactor hfi packet parsing logic

Vinicius Costa Gomes (1):
      dmaengine: dmatest: Fix dmatest waiting less when interrupted

Vlad Buslov (1):
      net/mlx5e: Fix use-after-free of encap entry in neigh update handler

WangYuli (6):
      riscv: KGDB: Do not inline arch_kgdb_breakpoint()
      riscv: KGDB: Remove ".option norvc/.option rvc" for kgdb_compiled_break
      nvmet-fc: Remove unused functions
      MIPS: dec: Declare which_prom() as static
      MIPS: cevt-ds1287: Add missing ds1287.h include
      MIPS: ds1287: Match ds1287_set_base_clock() function types

Wentao Liang (3):
      ata: sata_sx4: Add error handling in pdc20621_i2c_read()
      mtd: inftlcore: Add error check for inftl_read_oob()
      mtd: rawnand: Add status chack in r852_ready()

Willem de Bruijn (1):
      bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags

Xiangsheng Hou (1):
      virtiofs: add filesystem context source name check

Xiaogang Chen (1):
      udmabuf: fix a buf size overflow issue during udmabuf creation

Xiaxi Shen (1):
      ext4: fix timer use-after-free on failed mount

Yu Kuai (1):
      blk-cgroup: support to track if policy is online

Yu-Chun Lin (1):
      parisc: PDT: Fix missing prototype warning

Yuan Can (1):
      media: siano: Fix error handling in smsdvb_module_init()

Yue Haibing (1):
      RDMA/usnic: Fix passing zero to PTR_ERR in usnic_ib_pci_probe()

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zhongqiu Han (1):
      pm: cpupower: bench: Prevent NULL dereference on malloc failure

Zijun Hu (3):
      of/irq: Fix device node refcount leakages in of_irq_count()
      of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
      of/irq: Fix device node refcount leakages in of_irq_init()

zhoumin (1):
      ftrace: Add cond_resched() to ftrace_graph_set_hash()


