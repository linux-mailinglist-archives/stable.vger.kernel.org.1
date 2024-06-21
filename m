Return-Path: <stable+bounces-54814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257D91262B
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F1A1F25EE0
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55B15383B;
	Fri, 21 Jun 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFe5StW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4A153835;
	Fri, 21 Jun 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974765; cv=none; b=awY0nVpmY0yZal2yR998otpo5U+78J8hs+fCXnCe8p2hFF8MfvJtOcWjZaZWRZbVzJX3enF0ZeFkJU1tuw2qgShSh+tn/dz30/ZvBJmXDI1cDSpdyEwl+8UsPK7GH+Nu4TyfDnFWWgSJkUPeH4FWaGhi8BupIQPlkn9oySrTzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974765; c=relaxed/simple;
	bh=qQ2W6WjdWPiDOe0FT1fSV3nOUB6E+exU0xtifsbzRGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PoW4lqX9ScsCPdgSm959ji2m8k5UWiHMxPicIHSdqH7ZWPpPcUc+9DfUFH852P3Mop+3Rt2g+9HyNq2VY9g5Xp3yYyYgZJzmJlW/aPyHH+Crd5kNlFYnYF8cpvzLxgq1RjCngpQ8St0NEZeqqxre2RI6fVaRU8Q3sscqnR6BOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFe5StW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A247C2BBFC;
	Fri, 21 Jun 2024 12:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718974765;
	bh=qQ2W6WjdWPiDOe0FT1fSV3nOUB6E+exU0xtifsbzRGg=;
	h=From:To:Cc:Subject:Date:From;
	b=vFe5StW1qR2uQZAHridNnRkZm7uLoRi5D8tZZSujmkhl1Y+319eP8O/3cGgZQl6xL
	 bEuomX5QidBLqBw7FfGGyM7mldzRkCDZGHd5ClscsGnRdYhEvQQppwBs3AdeAOGSES
	 CE5Sf/AscflI4UKcNtT2G8YFSWv+94dRRTKhDzt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.6
Date: Fri, 21 Jun 2024 14:59:20 +0200
Message-ID: <2024062120-quilt-qualified-d0dd@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.6 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .editorconfig                                                         |    3 
 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml            |    1 
 MAINTAINERS                                                           |    1 
 Makefile                                                              |    2 
 arch/parisc/include/asm/cacheflush.h                                  |   15 
 arch/parisc/include/asm/pgtable.h                                     |   27 
 arch/parisc/kernel/cache.c                                            |  413 ++++++----
 arch/powerpc/include/asm/uaccess.h                                    |   16 
 arch/powerpc/platforms/85xx/smp.c                                     |    9 
 arch/riscv/kvm/aia_device.c                                           |    7 
 arch/riscv/kvm/vcpu_onereg.c                                          |    4 
 arch/riscv/mm/init.c                                                  |   24 
 arch/riscv/mm/pageattr.c                                              |   28 
 arch/x86/boot/compressed/Makefile                                     |    4 
 arch/x86/boot/main.c                                                  |    4 
 arch/x86/include/asm/alternative.h                                    |   22 
 arch/x86/include/asm/atomic64_32.h                                    |    2 
 arch/x86/include/asm/cpufeature.h                                     |    2 
 arch/x86/include/asm/irq_stack.h                                      |    2 
 arch/x86/include/asm/uaccess.h                                        |    6 
 arch/x86/kernel/amd_nb.c                                              |    9 
 arch/x86/kernel/cpu/common.c                                          |   21 
 arch/x86/kernel/machine_kexec_64.c                                    |   11 
 arch/x86/kvm/svm/sev.c                                                |   19 
 arch/x86/kvm/svm/svm.c                                                |   24 
 arch/x86/kvm/svm/svm.h                                                |    4 
 arch/x86/lib/getuser.S                                                |    6 
 arch/x86/mm/numa.c                                                    |    6 
 block/blk-flush.c                                                     |    3 
 block/sed-opal.c                                                      |    2 
 drivers/acpi/thermal.c                                                |    8 
 drivers/acpi/x86/utils.c                                              |   24 
 drivers/ata/ahci.c                                                    |    1 
 drivers/ata/libata-core.c                                             |    9 
 drivers/ata/libata-scsi.c                                             |    8 
 drivers/base/core.c                                                   |    3 
 drivers/block/null_blk/zoned.c                                        |    2 
 drivers/clk/sifive/sifive-prci.c                                      |    8 
 drivers/cpufreq/amd-pstate-ut.c                                       |    3 
 drivers/cpufreq/amd-pstate.c                                          |  209 +++--
 drivers/cpufreq/amd-pstate.h                                          |  100 ++
 drivers/cxl/core/region.c                                             |   18 
 drivers/dma-buf/st-dma-fence.c                                        |    6 
 drivers/dma/dma-axi-dmac.c                                            |    2 
 drivers/gpio/Kconfig                                                  |    2 
 drivers/gpio/gpio-tqmx86.c                                            |  110 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c             |    2 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c            |    2 
 drivers/gpu/drm/bridge/panel.c                                        |    7 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                         |    4 
 drivers/gpu/drm/drm_gem_shmem_helper.c                                |    3 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                              |    7 
 drivers/gpu/drm/exynos/exynos_hdmi.c                                  |    7 
 drivers/gpu/drm/i915/display/intel_audio.c                            |   32 
 drivers/gpu/drm/i915/display/intel_audio.h                            |    1 
 drivers/gpu/drm/i915/display/intel_display_driver.c                   |    2 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                           |    2 
 drivers/gpu/drm/i915/gem/i915_gem_object.h                            |    4 
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c                           |   15 
 drivers/gpu/drm/nouveau/dispnv04/disp.c                               |    2 
 drivers/gpu/drm/nouveau/dispnv50/disp.c                               |    4 
 drivers/gpu/drm/nouveau/nouveau_display.c                             |    6 
 drivers/gpu/drm/nouveau/nouveau_drv.h                                 |    1 
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c                        |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                   |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                   |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                   |   28 
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c                                  |   45 +
 drivers/gpu/drm/xe/xe_gt_idle.c                                       |    9 
 drivers/gpu/drm/xe/xe_guc_pc.c                                        |   70 -
 drivers/gpu/drm/xe/xe_guc_submit.c                                    |    1 
 drivers/gpu/drm/xe/xe_ring_ops.c                                      |   18 
 drivers/greybus/interface.c                                           |    1 
 drivers/hid/hid-core.c                                                |    1 
 drivers/hid/hid-logitech-dj.c                                         |    4 
 drivers/hid/hid-nvidia-shield.c                                       |    4 
 drivers/hwtracing/intel_th/pci.c                                      |   25 
 drivers/i2c/busses/i2c-at91-slave.c                                   |    3 
 drivers/i2c/busses/i2c-designware-slave.c                             |    2 
 drivers/iio/adc/ad9467.c                                              |    4 
 drivers/iio/adc/adi-axi-adc.c                                         |    5 
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c                |   15 
 drivers/iio/dac/ad5592r-base.c                                        |    2 
 drivers/iio/imu/bmi323/bmi323_core.c                                  |    5 
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c                     |    4 
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c                      |    4 
 drivers/iio/pressure/bmp280-core.c                                    |   10 
 drivers/iio/temperature/mcp9600.c                                     |    3 
 drivers/iio/temperature/mlx90635.c                                    |    6 
 drivers/iommu/amd/init.c                                              |    9 
 drivers/irqchip/irq-gic-v3-its.c                                      |   44 -
 drivers/irqchip/irq-sifive-plic.c                                     |   34 
 drivers/leds/led-class.c                                              |    6 
 drivers/md/dm-integrity.c                                             |    1 
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c                         |    9 
 drivers/misc/mei/pci-me.c                                             |    4 
 drivers/misc/mei/platform-vsc.c                                       |   39 
 drivers/misc/mei/vsc-fw-loader.c                                      |    2 
 drivers/misc/vmw_vmci/vmci_event.c                                    |    6 
 drivers/net/dsa/qca/qca8k-leds.c                                      |   12 
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                             |   51 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c                        |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                       |   12 
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c                     |   11 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                          |    8 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                          |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                       |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                       |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c               |   21 
 drivers/net/ethernet/intel/ice/ice.h                                  |   44 -
 drivers/net/ethernet/intel/ice/ice_base.c                             |    3 
 drivers/net/ethernet/intel/ice/ice_lib.c                              |   27 
 drivers/net/ethernet/intel/ice/ice_main.c                             |  118 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c                              |  116 ++
 drivers/net/ethernet/intel/ice/ice_type.h                             |   14 
 drivers/net/ethernet/intel/ice/ice_xsk.c                              |   13 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                          |    9 
 drivers/net/ethernet/intel/igc/igc_main.c                             |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                   |   33 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                           |  104 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h                           |    9 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                     |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fw.c                          |    4 
 drivers/net/ethernet/mellanox/mlx5/core/health.c                      |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c                |    8 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c                 |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                        |    3 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                       |    4 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                      |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c               |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                       |   25 
 drivers/net/geneve.c                                                  |   10 
 drivers/net/netdevsim/netdev.c                                        |    3 
 drivers/net/phy/micrel.c                                              |  104 ++
 drivers/net/phy/sfp.c                                                 |    3 
 drivers/net/virtio_net.c                                              |    2 
 drivers/net/vmxnet3/vmxnet3_drv.c                                     |    2 
 drivers/net/wireless/ath/ath11k/core.c                                |    2 
 drivers/net/wireless/ath/ath11k/mac.c                                 |   38 
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h                     |   30 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                          |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                           |   18 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                     |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                           |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                         |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                         |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                      |    4 
 drivers/net/wireless/realtek/rtlwifi/core.c                           |   15 
 drivers/net/wwan/iosm/iosm_ipc_devlink.c                              |    2 
 drivers/nvme/host/pr.c                                                |    2 
 drivers/nvme/target/passthru.c                                        |    6 
 drivers/pci/controller/pcie-rockchip-ep.c                             |    6 
 drivers/platform/x86/dell/dell-smbios-base.c                          |   92 --
 drivers/pmdomain/ti/ti_sci_pm_domains.c                               |   20 
 drivers/ptp/ptp_chardev.c                                             |    3 
 drivers/ras/amd/atl/internal.h                                        |    2 
 drivers/ras/amd/atl/system.c                                          |    2 
 drivers/ras/amd/atl/umc.c                                             |  160 ++-
 drivers/remoteproc/ti_k3_r5_remoteproc.c                              |   58 +
 drivers/scsi/mpi3mr/mpi3mr_app.c                                      |   62 +
 drivers/scsi/mpt3sas/mpt3sas_base.c                                   |   19 
 drivers/scsi/mpt3sas/mpt3sas_base.h                                   |    3 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                                    |    4 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                                  |   23 
 drivers/scsi/scsi.c                                                   |    7 
 drivers/scsi/scsi_transport_sas.c                                     |   23 
 drivers/scsi/sd.c                                                     |   17 
 drivers/spmi/hisi-spmi-controller.c                                   |    1 
 drivers/thermal/thermal_core.c                                        |   13 
 drivers/thunderbolt/debugfs.c                                         |    5 
 drivers/tty/n_tty.c                                                   |   22 
 drivers/tty/serial/8250/8250_dw.c                                     |    9 
 drivers/tty/serial/8250/8250_dwlib.c                                  |    3 
 drivers/tty/serial/8250/8250_dwlib.h                                  |    3 
 drivers/tty/serial/8250/8250_pxa.c                                    |    1 
 drivers/tty/serial/serial_port.c                                      |    7 
 drivers/ufs/core/ufs-mcq.c                                            |   17 
 drivers/ufs/core/ufshcd.c                                             |    6 
 drivers/usb/Makefile                                                  |    1 
 drivers/usb/class/cdc-wdm.c                                           |    4 
 drivers/usb/core/hcd.c                                                |   12 
 drivers/usb/host/xhci-pci.c                                           |    7 
 drivers/usb/host/xhci-ring.c                                          |   59 +
 drivers/usb/host/xhci.h                                               |    1 
 drivers/usb/storage/alauda.c                                          |    9 
 drivers/usb/typec/tcpm/tcpm.c                                         |    5 
 fs/btrfs/zoned.c                                                      |   13 
 fs/cachefiles/daemon.c                                                |    3 
 fs/cachefiles/internal.h                                              |    5 
 fs/cachefiles/ondemand.c                                              |  165 ++-
 fs/jfs/xattr.c                                                        |    4 
 fs/nfs/dir.c                                                          |   47 -
 fs/nfs/nfs4proc.c                                                     |   23 
 fs/nfsd/nfsfh.c                                                       |    4 
 fs/ocfs2/file.c                                                       |    2 
 fs/ocfs2/namei.c                                                      |    4 
 fs/proc/vmcore.c                                                      |    2 
 fs/smb/server/smb2pdu.c                                               |   22 
 fs/smb/server/vfs.c                                                   |   17 
 fs/smb/server/vfs.h                                                   |    3 
 fs/smb/server/vfs_cache.c                                             |    3 
 fs/tracefs/event_inode.c                                              |   51 -
 include/drm/bridge/aux-bridge.h                                       |    2 
 include/drm/display/drm_dp_mst_helper.h                               |    1 
 include/linux/amd-pstate.h                                            |  127 ---
 include/linux/atomic/atomic-arch-fallback.h                           |    6 
 include/linux/atomic/atomic-instrumented.h                            |    8 
 include/linux/atomic/atomic-long.h                                    |    4 
 include/linux/io_uring_types.h                                        |    3 
 include/linux/iommu.h                                                 |    2 
 include/linux/kcov.h                                                  |   47 -
 include/linux/kexec.h                                                 |    6 
 include/linux/pse-pd/pse.h                                            |    4 
 include/net/bluetooth/hci_core.h                                      |   36 
 include/net/ip_tunnels.h                                              |    5 
 include/net/rtnetlink.h                                               |    1 
 include/scsi/scsi_transport_sas.h                                     |    2 
 include/trace/events/cachefiles.h                                     |    8 
 io_uring/cancel.h                                                     |    4 
 io_uring/io-wq.c                                                      |   57 -
 io_uring/io_uring.c                                                   |    1 
 io_uring/rsrc.c                                                       |    1 
 kernel/bpf/syscall.c                                                  |   11 
 kernel/events/core.c                                                  |   13 
 kernel/gen_kheaders.sh                                                |    2 
 kernel/pid_namespace.c                                                |    1 
 kernel/time/tick-common.c                                             |   42 -
 mm/memblock.c                                                         |    4 
 mm/memory-failure.c                                                   |    7 
 net/ax25/af_ax25.c                                                    |    6 
 net/ax25/ax25_dev.c                                                   |    2 
 net/bluetooth/hci_sync.c                                              |    2 
 net/bluetooth/l2cap_core.c                                            |   12 
 net/bpf/test_run.c                                                    |    6 
 net/bridge/br_mst.c                                                   |   13 
 net/core/rtnetlink.c                                                  |   44 +
 net/core/sock_map.c                                                   |   16 
 net/ethtool/ioctl.c                                                   |    2 
 net/ipv4/devinet.c                                                    |    2 
 net/ipv4/fib_frontend.c                                               |    7 
 net/ipv4/tcp.c                                                        |    9 
 net/ipv4/tcp_timer.c                                                  |    6 
 net/ipv6/ioam6_iptunnel.c                                             |    8 
 net/ipv6/ip6_fib.c                                                    |    6 
 net/ipv6/route.c                                                      |    5 
 net/ipv6/seg6_iptunnel.c                                              |   14 
 net/ipv6/tcp_ipv6.c                                                   |    3 
 net/mac80211/cfg.c                                                    |    4 
 net/mac80211/he.c                                                     |   10 
 net/mac80211/mesh_pathtbl.c                                           |   13 
 net/mac80211/parse.c                                                  |    2 
 net/mac80211/sta_info.c                                               |    4 
 net/mptcp/pm_netlink.c                                                |   21 
 net/mptcp/protocol.c                                                  |   10 
 net/ncsi/internal.h                                                   |    2 
 net/ncsi/ncsi-manage.c                                                |   73 -
 net/ncsi/ncsi-rsp.c                                                   |    4 
 net/netfilter/ipset/ip_set_core.c                                     |   81 +
 net/netfilter/ipset/ip_set_list_set.c                                 |   30 
 net/netfilter/nft_meta.c                                              |    3 
 net/netfilter/nft_payload.c                                           |    4 
 net/sched/sch_generic.c                                               |    1 
 net/sched/sch_multiq.c                                                |    2 
 net/sched/sch_taprio.c                                                |   15 
 net/smc/af_smc.c                                                      |   22 
 net/sunrpc/auth_gss/auth_gss.c                                        |    4 
 net/unix/af_unix.c                                                    |  108 +-
 net/unix/diag.c                                                       |   12 
 net/wireless/core.c                                                   |    2 
 net/wireless/pmsr.c                                                   |    8 
 net/wireless/scan.c                                                   |    3 
 net/wireless/sysfs.c                                                  |    4 
 net/wireless/util.c                                                   |    7 
 scripts/atomic/kerneldoc/sub_and_test                                 |    2 
 scripts/mod/modpost.c                                                 |    5 
 security/integrity/ima/ima_api.c                                      |   16 
 security/integrity/ima/ima_template_lib.c                             |   17 
 security/landlock/fs.c                                                |   13 
 tools/perf/builtin-script.c                                           |    2 
 tools/perf/util/auxtrace.c                                            |    4 
 tools/testing/cxl/test/mem.c                                          |    1 
 tools/testing/selftests/alsa/Makefile                                 |    2 
 tools/testing/selftests/ftrace/test.d/dynevent/test_duplicates.tc     |    2 
 tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc |   20 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc      |    3 
 tools/testing/selftests/futex/functional/futex_requeue_pi.c           |    2 
 tools/testing/selftests/mm/compaction_test.c                          |   77 +
 tools/testing/selftests/mm/cow.c                                      |    2 
 tools/testing/selftests/mm/gup_longterm.c                             |    2 
 tools/testing/selftests/mm/gup_test.c                                 |    4 
 tools/testing/selftests/mm/ksm_functional_tests.c                     |    2 
 tools/testing/selftests/mm/madv_populate.c                            |    2 
 tools/testing/selftests/mm/mkdirty.c                                  |    2 
 tools/testing/selftests/mm/pagemap_ioctl.c                            |    4 
 tools/testing/selftests/mm/soft-dirty.c                               |    2 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                       |    5 
 tools/tracing/rtla/src/timerlat_aa.c                                  |  109 +-
 tools/tracing/rtla/src/timerlat_top.c                                 |   17 
 299 files changed, 3274 insertions(+), 1830 deletions(-)

Aapo Vienamo (1):
      thunderbolt: debugfs: Fix margin debugfs node creation condition

Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Adam Rizkalla (1):
      iio: pressure: bmp280: Fix BMP580 temperature reading

Aditya Kumar Singh (1):
      wifi: mac80211: pass proper link id for channel switch started notification

Adrian Hunter (2):
      perf auxtrace: Fix multiple use of --itrace option
      perf script: Show also errors for --insn-trace option

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Aleksandr Mishin (4):
      net/mlx5: Fix tainted pointer delete is case of flow rules creation fail
      net: wwan: iosm: Fix tainted pointer delete is case of region creation fail
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_packet
      bnxt_en: Adjust logging of firmware messages in case of released token in __hwrm_send()

Alexander Shishkin (5):
      intel_th: pci: Add Granite Rapids support
      intel_th: pci: Add Granite Rapids SOC support
      intel_th: pci: Add Sapphire Rapids SOC support
      intel_th: pci: Add Meteor Lake-S support
      intel_th: pci: Add Lunar Lake support

Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix use-after-free case in tcpm_register_source_caps

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrey Konovalov (1):
      kcov, usb: disable interrupts in kcov_remote_start_usb_softirq

Andrzej Hajda (1):
      drm/xe: flush engine buffers before signalling user fence on all engines

Andy Shevchenko (2):
      net dsa: qca8k: fix usages of device_get_named_child_node()
      serial: 8250_dw: Don't use struct dw8250_data outside of 8250_dw

Apurva Nandan (1):
      remoteproc: k3-r5: Wait for core0 power-up before powering up core1

Armin Wolf (1):
      platform/x86: dell-smbios: Fix wrong token data in sysfs

Arnd Bergmann (1):
      cpufreq: amd-pstate: remove global header file

Baochen Qiang (1):
      wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP

Baokun Li (9):
      cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
      cachefiles: remove requests from xarray during flushing requests
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
      cachefiles: add spin_lock for cachefiles_ondemand_info
      cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
      cachefiles: never get a new anonymous fd if ondemand_id is valid
      cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
      cachefiles: flush all requests after setting CACHEFILES_DEAD

Baoquan He (1):
      kexec: fix the unexpected kexec_dprintk() macro

Beleswar Padhi (2):
      remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs
      remoteproc: k3-r5: Jump to error handling labels in start/stop errors

Benjamin Segall (1):
      x86/boot: Don't add the EFI stub to targets, again

Bitterblue Smith (1):
      wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS

Borislav Petkov (AMD) (1):
      x86/cpu: Get rid of an unnecessary local variable in get_cpu_address_sizes()

Breno Leitao (2):
      scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory
      io_uring/io-wq: Use set_bit() and test_bit() at worker->flags

Carl Huang (1):
      wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

Carlos Llamas (1):
      locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

Chanwoo Lee (1):
      scsi: ufs: mcq: Fix error output and clean up ufshcd_mcq_abort()

Chen Hanxiao (1):
      SUNRPC: return proper error from gss_wrap_req_priv

Chen Ni (2):
      HID: nvidia-shield: Add missing check for input_ff_create_memless
      drm/panel: sitronix-st7789v: Add check for of_drm_get_panel_orientation

Chengming Zhou (1):
      block: fix request.queuelist usage in flush

Chris Wilson (1):
      drm/i915/gt: Disarm breadcrumbs if engines are already idle

Cong Wang (1):
      bpf: Fix a potential use-after-free in bpf_link_free()

Csókás, Bence (1):
      net: sfp: Always call `sfp_sm_mod_remove()` on remove

Damien Le Moal (4):
      ata: libata-scsi: Set the RMB bit only for removable media devices
      scsi: core: Disable CDL by default
      scsi: mpi3mr: Fix ATA NCQ priority support
      null_blk: Print correct max open zones limit in null_init_zoned_dev()

Daniel Bristot de Oliveira (2):
      rtla/timerlat: Simplify "no value" printing on top
      rtla/auto-analysis: Replace \t with spaces

Daniel Wagner (1):
      nvmet-passthru: propagate status from id override functions

Dave Hansen (1):
      x86/cpu: Provide default cache line size if not enumerated

Dave Jiang (1):
      cxl/test: Add missing vmalloc.h for tools/testing/cxl/test/mem.c

David Kaplan (1):
      x86/kexec: Fix bug with call depth tracking

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

David Wei (1):
      netdevsim: fix backwards compatibility in nsim_get_iflink()

Davide Ornaghi (1):
      netfilter: nft_inner: validate mandatory meta and payload

DelphineCCChiu (1):
      net/ncsi: Fix the multi thread manner of NCSI driver

Dev Jain (1):
      selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation

Dimitri Fedrau (1):
      iio: temperature: mcp9600: Fix temperature reading for negative values

Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Dmitry Baryshkov (1):
      drm/bridge: aux-hpd-bridge: correct devm_drm_dp_hpd_bridge_add() stub

Doug Brown (1):
      serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

Douglas Anderson (1):
      serial: port: Don't block system suspend even if bytes are left to xmit

Duoming Zhou (1):
      ax25: Replace kfree() in ax25_dev_free() with ax25_dev_put()

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation
      wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8
      wifi: iwlwifi: mvm: fix a crash on 7265

Eric Dumazet (6):
      ipv6: ioam: block BH from ioam6_output()
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      ipv6: fix possible race in __fib6_drop_pcpu_from()
      tcp: fix race in tcp_v6_syn_recv_sock()
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()

Fedor Pchelkin (1):
      dma-buf: handle testing kthreads creation failure

Filipe Manana (1):
      btrfs: zoned: fix use-after-free due to race with dev replace

Frank Wunderlich (1):
      net: ethernet: mtk_eth_soc: handle dma buffer size soc specific

Gal Pressman (2):
      geneve: Fix incorrect inner network header offset when innerprotoinherit is set
      net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets

Greg Kroah-Hartman (3):
      .editorconfig: remove trim_trailing_whitespace option
      jfs: xattr: fix buffer overflow for invalid xattr
      Linux 6.9.6

Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Hagar Gamal Halim Hemdan (1):
      vmci: prevent speculation leaks by sanitizing event in event_deliver()

Hagar Hemdan (1):
      irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_update()

Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Hans de Goede (2):
      leds: class: Revert: "If no default trigger is given, make hw_control trigger the default trigger"
      mei: vsc: Fix wrong invocation of ACPI SID method

Hari Bathini (1):
      powerpc/85xx: fix compile error without CONFIG_CRASH_DUMP

Harshit Mogalapalli (1):
      iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()

Hector Martin (1):
      xhci: Handle TD clearing for multiple streams case

Heng Qi (1):
      virtio_net: fix possible dim status unrecoverable

Ian Forbes (4):
      drm/vmwgfx: Filter modes which exceed graphics memory
      drm/vmwgfx: 3D disabled should not effect STDU memory limits
      drm/vmwgfx: Remove STDU logic from generic mode_valid function
      drm/vmwgfx: Don't memcmp equivalent pointers

Ilpo Järvinen (1):
      tty: n_tty: Fix buffer offsets when lookahead is used

Imre Deak (1):
      drm/i915: Fix audio component initialization

Jacob Keller (2):
      ice: fix iteration of TLVs in Preserved Fields Area
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Jakub Kicinski (2):
      net: tls: fix marking packets as decrypted
      rtnetlink: make the "split" NLM_DONE handling generic

Jan Beulich (2):
      x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()
      memblock: make memblock_set_node() also warn about use of MAX_NUMNODES

Jani Nikula (1):
      drm/exynos/vidi: fix memory leak in .get_modes()

Jason Nader (1):
      ata: ahci: Do not apply Intel PCS quirk on Intel Alder Lake

Jason Xing (2):
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
      mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

Jean Delvare (2):
      i2c: at91: Fix the functionality flags of the slave-only interface
      i2c: designware: Fix the functionality flags of the slave-only interface

Jean-Baptiste Maneyrol (3):
      iio: invensense: fix odr switching to same value
      iio: imu: inv_icm42600: delete unneeded update watermark call
      iio: invensense: fix interrupt timestamp alignment

Jie Wang (1):
      net: hns3: add cond_resched() to hns3 ring buffer init process

Jiri Olsa (1):
      bpf: Set run context for rawtp test_run callback

Johannes Berg (5):
      wifi: cfg80211: fully move wiphy work to unbound workqueue
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64
      net/sched: initialize noop_qdisc owner
      wifi: cfg80211: validate HE operation element parsing
      wifi: mt76: mt7615: add missing chanctx ops

John David Anglin (1):
      parisc: Try to fix random segmentation faults in package builds

John Ernberg (1):
      USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is selected

John Hubbard (1):
      selftests/futex: don't pass a const char* to asprintf(3)

Joshua Washington (1):
      gve: ignore nonrelevant GSO type bits when processing TSO headers

José Expósito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Kees Cook (1):
      x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking

Kory Maincent (1):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Kuniyuki Iwashima (15):
      af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
      af_unix: Annodate data-races around sk->sk_state for writers.
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
      af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-races around sk->sk_sndbuf.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().
      af_unix: Annotate data-race of sk->sk_state in unix_accept().

Kyle Tso (1):
      usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state

Lars Kellogg-Stedman (1):
      ax25: Fix refcount imbalance on inbound connections

Larysa Zaremba (3):
      ice: remove af_xdp_zc_qps bitmap
      ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
      ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

Li Zhijian (1):
      cxl/region: Fix memregion leaks in devm_cxl_add_region()

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (2):
      wifi: mac80211: fix Spatial Reuse element size check
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not using correct handle
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no EDID found

Mario Limonciello (1):
      ACPI: x86: Force StorageD3Enable on more products

Mark Brown (1):
      kselftest/alsa: Ensure _GNU_SOURCE is defined

Martin K. Petersen (1):
      scsi: sd: Use READ(16) when reading block zero on large capacity disks

Masahiro Yamada (1):
      modpost: do not warn about missing MODULE_DESCRIPTION() for vmlinux.o

Masami Hiramatsu (Google) (2):
      selftests/ftrace: Fix to check required event file
      selftests/tracing: Fix event filter test to retry up to 10 times

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Matthias Maennich (1):
      kheaders: explicitly define file modes for archived headers

Matthias Schiffer (3):
      gpio: tqmx86: introduce shadow register for GPIO output value
      gpio: tqmx86: store IRQ trigger type and unmask status separately
      gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH interrupt type

Matthias Stocker (1):
      vmxnet3: disable rx data ring on dma allocation failure

Miaohe Lin (1):
      mm/huge_memory: don't unpoison huge_zero_folio

Michael Chan (1):
      bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response

Michael Ellerman (1):
      powerpc/uaccess: Fix build errors seen with GCC 13/14

Mickaël Salaün (1):
      landlock: Fix d_parent walk

Mikulas Patocka (1):
      dm-integrity: set discard_granularity to logical block size

Miri Korenblit (2):
      wifi: iwlwifi: mvm: don't initialize csa_work twice
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Mordechay Goodstein (1):
      wifi: iwlwifi: mvm: set properly mac header

Moshe Shemesh (1):
      net/mlx5: Stop waiting for PCI if pci channel is offline

Nam Cao (3):
      riscv: fix overlap of allocated page and PTR_ERR
      riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context
      riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled

Namjae Jeon (2):
      ksmbd: move leading slash check to smb2_get_name()
      ksmbd: fix missing use of get_write in in smb2_set_ea()

Nathan Chancellor (1):
      selftests/mm: ksft_exit functions do not return

NeilBrown (1):
      NFS: add barriers when testing for NFS_FSDATA_BLOCKED

Nicolas Escande (1):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

Nikita Zhandarovich (1):
      HID: core: remove unnecessary WARN_ON() in implement()

Niklas Cassel (3):
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial CT240BX500SSD1
      ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3 SSD

Nikolay Aleksandrov (2):
      net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
      net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

Niranjana Vishwanathapura (1):
      drm/xe: Properly handle alloc_guc_id() failure

Nuno Sa (2):
      dmaengine: axi-dmac: fix possible race in remove()
      iio: adc: axi-adc: make sure AXI clock is enabled

Oleg Nesterov (2):
      tick/nohz_full: Don't abuse smp_call_function_single() in tick_setup_device()
      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING

Olga Kornievskaia (1):
      NFSv4.1 enforce rootpath check in fs_location query

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

Pauli Virtanen (1):
      Bluetooth: fix connection setup in l2cap_connect

Pavel Begunkov (2):
      io_uring/rsrc: don't lock while !TASK_RUNNING
      io_uring: fix cancellation overwriting req->flags

Perry Yuan (2):
      cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq
      cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities missing

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Quan Zhou (1):
      RISC-V: KVM: Fix incorrect reg_subtype labels in kvm_riscv_vcpu_set_reg_isa_ext function

Rafael J. Wysocki (2):
      thermal: core: Do not fail cdev registration because of invalid initial state
      thermal: ACPI: Invalidate trip points with temperature of 0 or below

Rao Shoaib (1):
      af_unix: Read with MSG_PEEK loops if the first unread byte is OOB

Ravi Bangoria (2):
      KVM: SEV-ES: Disallow SEV-ES guests when X86_FEATURE_LBRV is absent
      KVM: SEV-ES: Delegate LBR virtualization to the processor

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Riana Tauro (2):
      drm/xe/xe_gt_idle: use GT forcewake domain assertion
      drm/xe: move disable_c6 call

Rick Wertenbroek (1):
      PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore

Rob Herring (Arm) (1):
      dt-bindings: usb: realtek,rts5411: Add missing "additionalProperties" on child nodes

Rodrigo Vivi (1):
      drm/xe: Remove mem_access from guc_pc calls

Sagar Cheluvegowda (1):
      net: stmmac: dwmac-qcom-ethqos: Configure host DMA width

Samuel Holland (2):
      clk: sifive: Do not register clkdevs for PRCI clocks
      irqchip/sifive-plic: Chain to parent IRQ after handlers are ready

Sasha Neftin (1):
      igc: Fix Energy Efficient Ethernet support declaration

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

Shay Drory (1):
      net/mlx5: Always stop health timer during driver removal

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

Sicong Huang (1):
      greybus: Fix use-after-free bug in gb_interface_release due to race condition.

Stefan Berger (1):
      ima: Fix use-after-free on a dentry's dname.name

Steven Rostedt (Google) (2):
      eventfs: Update all the eventfs_inodes from the events descriptor
      tracing/selftests: Fix kprobe event name test for .isra. functions

Su Hui (3):
      net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtool()
      io_uring/io-wq: avoid garbage value of 'match' in io_wq_enqueue()
      block: sed-opal: avoid possible wrong address reference in read_sed_opal_key()

Su Yue (3):
      ocfs2: update inode fsync transaction id in ocfs2_unlink and ocfs2_link
      ocfs2: use coarse time for new created files
      ocfs2: fix races between hole punching and AIO+DIO

Subbaraya Sundeep (1):
      octeontx2-af: Always allocate PF entries from low prioriy zone

Taehee Yoo (2):
      ionic: fix kernel panic in XDP_TX action
      ionic: fix use after netif_napi_del()

Thadeu Lima de Souza Cascardo (1):
      sock_map: avoid race between sock_map_close and sk_psock_put

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Tomi Valkeinen (1):
      pmdomain: ti-sci: Fix duplicate PD referrals

Tristram Ha (2):
      net: phy: micrel: fix KSZ9477 PHY issues after suspend/resume
      net: phy: Micrel KSZ8061: fix errata solution not taking effect problem

Trond Myklebust (1):
      knfsd: LOOKUP can return an illegal error value

Uros Bizjak (1):
      x86/asm: Use %c/%n instead of %P operand modifier in asm templates

Vamshi Gajjela (1):
      spmi: hisi-spmi-controller: Do not override device identifier

Vasileios Amoiridis (1):
      iio: imu: bmi323: Fix trigger notification in case of error

Vasily Khoruzhick (1):
      drm/nouveau: don't attempt to schedule hpd_work on headless cards

Vidya Srinivas (1):
      drm/i915/dpt: Make DPT object unshrinkable

Wachowski, Karol (1):
      drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

Wayne Lin (1):
      drm/mst: Fix NULL pointer dereference at drm_dp_add_payload_part2

Weiwen Hu (1):
      nvme: fix nvme_pr_* status code parsing

Wen Gu (1):
      net/smc: avoid overwriting when adjusting sock bufsizes

Wentong Wu (1):
      mei: vsc: Don't stop/restart mei device during system suspend/resume

Xiaolei Wang (1):
      net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters

Yazen Ghannam (3):
      RAS/AMD/ATL: Fix MI300 bank hash
      RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation
      x86/amd_nb: Check for invalid SMN reads

Yong-Xuan Wang (1):
      RISC-V: KVM: No need to use mask when hart-index-bit is 0

Yonglong Liu (1):
      net: hns3: fix kernel crash problem in concurrent scenario

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

Yongzhi Liu (2):
      misc: microchip: pci1xxxx: fix double free in the error handling of gp_aux_bus_probe()
      misc: microchip: pci1xxxx: Fix a memory leak in the error handling of gp_aux_bus_probe()

Ziqi Chen (1):
      scsi: ufs: core: Quiesce request queues before checking pending cmds

Ziwei Xiao (1):
      gve: Clear napi->skb before dev_kfree_skb_any()


