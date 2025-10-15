Return-Path: <stable+bounces-185775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD45BDDF70
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1783E4EA23D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073F31C576;
	Wed, 15 Oct 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uuapSTWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF131BCAB;
	Wed, 15 Oct 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523952; cv=none; b=dPLrK729+EviQ/Fz1X8zfUuzkd6/h4oqLTfuOPaZa6Rx7WPIU3oHtu+XS7yzHrsMTfig/A01msqWJBksXqTYdddpGlisaALULKjZQPPesCNT21L+b+sLb0mDiu5emo29qKVRFFIykiVBVe86vUk/+u2XV30/CT5BXaFfQ/PndZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523952; c=relaxed/simple;
	bh=WyKtRyL5zjaEEumRAC4VBGeg3HsZtOmKKrovVNSETgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kw2eEflzGMySWMMjTjrq32FAZoDYC3cdoF7W59lvqUxMqoB+4+YpnObfoHeY4V6GnJOW+2SMjcrRu3j4MZOfPD3M53wbSVgAE7HcNo4tYHr6KYaBADHBkie6INDoq4YS2ii4FguT0Oav9H3o7pcCTeoVSurCVc+VGLxznpcWIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uuapSTWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE71C4CEF8;
	Wed, 15 Oct 2025 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760523952;
	bh=WyKtRyL5zjaEEumRAC4VBGeg3HsZtOmKKrovVNSETgU=;
	h=From:To:Cc:Subject:Date:From;
	b=uuapSTWl4SpzFkzLfvugYsN8WHlXlZyWLoqRmUJfm3vRkUrtxr/YUDwwn9NhCfjBi
	 MSVb9PckIbsDrHVVSO6vC59acOl++TMk/wN1hY93UzBSPzxPWfukOm7ImWea0Pea+2
	 QcTCzLsIZDY7qFeAyfrHIoLv8/mMSJF/12tWNt9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.53
Date: Wed, 15 Oct 2025 12:25:42 +0200
Message-ID: <2025101542-rogue-wired-4c6c@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.53 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/trace/histogram-design.rst                             |    4 
 Makefile                                                             |    2 
 arch/arm/boot/dts/renesas/r8a7791-porter.dts                         |    2 
 arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi                         |    2 
 arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts                         |    2 
 arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi           |    2 
 arch/arm/mach-at91/pm_suspend.S                                      |    4 
 arch/arm64/boot/dts/apple/t8103-j457.dts                             |   12 
 arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts             |   32 -
 arch/arm64/boot/dts/freescale/imx95.dtsi                             |    4 
 arch/arm64/boot/dts/mediatek/mt6331.dtsi                             |   10 
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts               |    2 
 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi              |    8 
 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts |    4 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                             |    3 
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts        |   16 
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts                      |    2 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                |    1 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi                        |    5 
 arch/arm64/net/bpf_jit_comp.c                                        |    3 
 arch/loongarch/kernel/relocate.c                                     |    4 
 arch/powerpc/include/asm/book3s/32/pgalloc.h                         |   10 
 arch/powerpc/include/asm/nohash/pgalloc.h                            |    2 
 arch/powerpc/kernel/head_8xx.S                                       |    9 
 arch/riscv/net/bpf_jit_comp64.c                                      |   42 +
 arch/sparc/lib/M7memcpy.S                                            |   20 
 arch/sparc/lib/Memcpy_utils.S                                        |    9 
 arch/sparc/lib/NG4memcpy.S                                           |    2 
 arch/sparc/lib/NGmemcpy.S                                            |   29 -
 arch/sparc/lib/U1memcpy.S                                            |   19 
 arch/sparc/lib/U3memcpy.S                                            |    2 
 arch/x86/include/asm/segment.h                                       |    8 
 arch/x86/kvm/svm/svm.c                                               |   12 
 block/blk-mq-sysfs.c                                                 |    6 
 block/blk-settings.c                                                 |    3 
 crypto/asymmetric_keys/x509_cert_parser.c                            |   16 
 drivers/acpi/acpica/aclocal.h                                        |    2 
 drivers/acpi/nfit/core.c                                             |    2 
 drivers/acpi/processor_idle.c                                        |    3 
 drivers/base/node.c                                                  |    4 
 drivers/base/power/main.c                                            |   14 
 drivers/base/regmap/regmap.c                                         |    2 
 drivers/block/nbd.c                                                  |    8 
 drivers/block/null_blk/main.c                                        |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                      |    3 
 drivers/char/hw_random/Kconfig                                       |    1 
 drivers/char/hw_random/ks-sa-rng.c                                   |    4 
 drivers/char/tpm/Kconfig                                             |    2 
 drivers/cpufreq/scmi-cpufreq.c                                       |   10 
 drivers/cpuidle/cpuidle-qcom-spm.c                                   |    7 
 drivers/crypto/hisilicon/debugfs.c                                   |    1 
 drivers/crypto/hisilicon/hpre/hpre_main.c                            |    3 
 drivers/crypto/hisilicon/qm.c                                        |    7 
 drivers/crypto/hisilicon/sec2/sec_main.c                             |   80 +--
 drivers/crypto/hisilicon/zip/zip_main.c                              |   17 
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c                  |    5 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c                  |    2 
 drivers/devfreq/event/rockchip-dfi.c                                 |    7 
 drivers/devfreq/mtk-cci-devfreq.c                                    |    3 
 drivers/edac/i10nm_base.c                                            |   14 
 drivers/firmware/arm_scmi/transports/virtio.c                        |    3 
 drivers/firmware/meson/Kconfig                                       |    2 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                |   29 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                 |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c    |    1 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                         |    7 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                           |   92 ++--
 drivers/gpu/drm/bridge/Kconfig                                       |    1 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                  |    2 
 drivers/gpu/drm/panel/panel-novatek-nt35560.c                        |    2 
 drivers/gpu/drm/radeon/r600_cs.c                                     |    4 
 drivers/hid/hidraw.c                                                 |  224 +++++-----
 drivers/hwmon/mlxreg-fan.c                                           |   24 -
 drivers/hwtracing/coresight/coresight-catu.c                         |   22 
 drivers/hwtracing/coresight/coresight-catu.h                         |    1 
 drivers/hwtracing/coresight/coresight-core.c                         |    5 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                   |   31 +
 drivers/hwtracing/coresight/coresight-etm4x.h                        |    6 
 drivers/hwtracing/coresight/coresight-tmc-core.c                     |   22 
 drivers/hwtracing/coresight/coresight-tmc.h                          |    2 
 drivers/hwtracing/coresight/coresight-tpda.c                         |    3 
 drivers/hwtracing/coresight/coresight-trbe.c                         |   11 
 drivers/i2c/busses/i2c-designware-platdrv.c                          |    5 
 drivers/i2c/busses/i2c-mt65xx.c                                      |   17 
 drivers/i3c/master/svc-i3c-master.c                                  |   31 +
 drivers/iio/inkern.c                                                 |   30 -
 drivers/infiniband/core/addr.c                                       |   10 
 drivers/infiniband/core/cm.c                                         |    4 
 drivers/infiniband/core/sa_query.c                                   |    6 
 drivers/infiniband/hw/mlx5/main.c                                    |   67 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                 |    1 
 drivers/infiniband/sw/rxe/rxe_task.c                                 |    8 
 drivers/infiniband/sw/siw/siw_verbs.c                                |   25 -
 drivers/input/misc/uinput.c                                          |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                             |    2 
 drivers/iommu/intel/debugfs.c                                        |   17 
 drivers/iommu/intel/iommu.h                                          |    3 
 drivers/leds/flash/leds-qcom-flash.c                                 |   62 +-
 drivers/leds/leds-lp55xx-common.c                                    |    2 
 drivers/md/dm-core.h                                                 |    1 
 drivers/md/dm-vdo/indexer/volume-index.c                             |    4 
 drivers/md/dm.c                                                      |   13 
 drivers/media/i2c/rj54n1cb0c.c                                       |    9 
 drivers/media/pci/zoran/zoran.h                                      |    6 
 drivers/media/pci/zoran/zoran_driver.c                               |    3 
 drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c                |   20 
 drivers/mfd/rz-mtu3.c                                                |    2 
 drivers/mfd/vexpress-sysreg.c                                        |    6 
 drivers/misc/fastrpc.c                                               |   89 ++-
 drivers/misc/genwqe/card_ddcb.c                                      |    2 
 drivers/mmc/core/block.c                                             |    6 
 drivers/mtd/nand/raw/atmel/nand-controller.c                         |    4 
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                        |    5 
 drivers/net/ethernet/dlink/dl2k.c                                    |    7 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                          |    8 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                      |    6 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h             |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                    |   17 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                   |   24 +
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c                  |    7 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                 |    2 
 drivers/net/usb/asix_devices.c                                       |   29 +
 drivers/net/usb/rtl8150.c                                            |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                                |   39 -
 drivers/net/wireless/ath/ath12k/ce.c                                 |    2 
 drivers/net/wireless/ath/ath12k/debug.h                              |    1 
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h                   |    1 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                      |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                      |   29 -
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                     |    8 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                   |   11 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                      |    2 
 drivers/net/wireless/realtek/rtw89/ser.c                             |    3 
 drivers/nvme/target/fc.c                                             |   19 
 drivers/pci/controller/cadence/pci-j721e.c                           |    2 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                          |   26 +
 drivers/pci/controller/dwc/pcie-tegra194.c                           |    4 
 drivers/pci/controller/pci-tegra.c                                   |    2 
 drivers/pci/pci-acpi.c                                               |    6 
 drivers/perf/arm_spe_pmu.c                                           |    3 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                   |   12 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                            |   10 
 drivers/pinctrl/pinmux.c                                             |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                              |    2 
 drivers/pinctrl/renesas/pinctrl.c                                    |    3 
 drivers/power/supply/cw2015_battery.c                                |    3 
 drivers/pps/kapi.c                                                   |    5 
 drivers/pps/pps.c                                                    |    5 
 drivers/ptp/ptp_private.h                                            |    1 
 drivers/ptp/ptp_sysfs.c                                              |    2 
 drivers/pwm/pwm-tiehrpwm.c                                           |  154 ++----
 drivers/regulator/scmi-regulator.c                                   |    3 
 drivers/remoteproc/pru_rproc.c                                       |    3 
 drivers/remoteproc/qcom_q6v5.c                                       |    3 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                             |    8 
 drivers/scsi/myrs.c                                                  |    8 
 drivers/scsi/pm8001/pm8001_sas.c                                     |    9 
 drivers/scsi/qla2xxx/qla_edif.c                                      |    4 
 drivers/scsi/qla2xxx/qla_init.c                                      |    4 
 drivers/scsi/qla2xxx/qla_nvme.c                                      |    2 
 drivers/soc/mediatek/mtk-svs.c                                       |   23 +
 drivers/soc/qcom/rpmh-rsc.c                                          |    7 
 drivers/spi/spi.c                                                    |    2 
 drivers/tee/tee_shm.c                                                |    8 
 drivers/thermal/qcom/Kconfig                                         |    3 
 drivers/thermal/qcom/lmh.c                                           |    2 
 drivers/tty/n_gsm.c                                                  |   25 +
 drivers/tty/serial/max310x.c                                         |    2 
 drivers/uio/uio_hv_generic.c                                         |    7 
 drivers/usb/cdns3/cdnsp-pci.c                                        |    5 
 drivers/usb/gadget/configfs.c                                        |    2 
 drivers/usb/host/max3421-hcd.c                                       |    2 
 drivers/usb/host/xhci-ring.c                                         |   11 
 drivers/usb/misc/Kconfig                                             |    1 
 drivers/usb/misc/qcom_eud.c                                          |   33 +
 drivers/usb/phy/phy-twl6030-usb.c                                    |    3 
 drivers/usb/typec/tipd/core.c                                        |   24 -
 drivers/usb/usbip/vhci_hcd.c                                         |   22 
 drivers/vfio/pci/pds/dirty.c                                         |    2 
 drivers/vhost/vringh.c                                               |   14 
 drivers/video/fbdev/simplefb.c                                       |   31 +
 drivers/watchdog/mpc8xxx_wdt.c                                       |    2 
 fs/btrfs/extent_io.c                                                 |    9 
 fs/ext4/ext4.h                                                       |   10 
 fs/ext4/file.c                                                       |    2 
 fs/ext4/inode.c                                                      |    2 
 fs/ext4/orphan.c                                                     |    6 
 fs/ext4/super.c                                                      |    4 
 fs/f2fs/data.c                                                       |    9 
 fs/f2fs/f2fs.h                                                       |    4 
 fs/f2fs/file.c                                                       |   49 +-
 fs/gfs2/glock.c                                                      |    2 
 fs/nfs/nfs4proc.c                                                    |    2 
 fs/ntfs3/index.c                                                     |   10 
 fs/ntfs3/run.c                                                       |   12 
 fs/ocfs2/stack_user.c                                                |    1 
 fs/smb/client/smb2ops.c                                              |   17 
 fs/smb/server/ksmbd_netlink.h                                        |    5 
 fs/smb/server/mgmt/user_session.c                                    |   26 -
 fs/smb/server/server.h                                               |    1 
 fs/smb/server/smb2pdu.c                                              |    3 
 fs/smb/server/transport_ipc.c                                        |    3 
 fs/smb/server/transport_rdma.c                                       |   99 +++-
 fs/smb/server/transport_tcp.c                                        |   27 -
 fs/squashfs/inode.c                                                  |    7 
 fs/squashfs/squashfs_fs_i.h                                          |    2 
 fs/udf/inode.c                                                       |    3 
 include/asm-generic/vmlinux.lds.h                                    |    1 
 include/linux/bpf.h                                                  |    1 
 include/linux/btf.h                                                  |    2 
 include/linux/once.h                                                 |    4 
 include/trace/events/filelock.h                                      |    3 
 include/uapi/linux/hidraw.h                                          |    2 
 include/vdso/gettime.h                                               |    1 
 init/Kconfig                                                         |    1 
 io_uring/waitid.c                                                    |    3 
 kernel/bpf/core.c                                                    |    5 
 kernel/bpf/verifier.c                                                |    4 
 kernel/events/uprobes.c                                              |    2 
 kernel/seccomp.c                                                     |   12 
 kernel/smp.c                                                         |   11 
 kernel/trace/bpf_trace.c                                             |    9 
 mm/hugetlb.c                                                         |    2 
 net/9p/trans_usbg.c                                                  |   16 
 net/bluetooth/hci_sync.c                                             |   10 
 net/bluetooth/iso.c                                                  |   11 
 net/bluetooth/mgmt.c                                                 |   10 
 net/core/filter.c                                                    |   16 
 net/ipv4/ping.c                                                      |   14 
 net/ipv4/tcp.c                                                       |    9 
 net/mac80211/rx.c                                                    |   28 -
 net/netfilter/ipset/ip_set_hash_gen.h                                |    8 
 net/netfilter/ipvs/ip_vs_conn.c                                      |    4 
 net/netfilter/ipvs/ip_vs_core.c                                      |   11 
 net/netfilter/ipvs/ip_vs_ctl.c                                       |    6 
 net/netfilter/ipvs/ip_vs_est.c                                       |   16 
 net/netfilter/ipvs/ip_vs_ftp.c                                       |    4 
 net/netfilter/nfnetlink.c                                            |    2 
 net/nfc/nci/ntf.c                                                    |  135 ++++--
 net/sunrpc/auth_gss/svcauth_gss.c                                    |    2 
 security/Kconfig                                                     |    1 
 sound/core/pcm_native.c                                              |   25 -
 sound/pci/lx6464es/lx_core.c                                         |    4 
 sound/soc/codecs/wcd934x.c                                           |   17 
 sound/soc/codecs/wcd937x.c                                           |    4 
 sound/soc/codecs/wcd937x.h                                           |    6 
 sound/soc/intel/boards/bytcht_es8316.c                               |   20 
 sound/soc/intel/boards/bytcr_rt5640.c                                |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                                |   26 -
 sound/soc/intel/boards/sof_sdw.c                                     |    2 
 sound/soc/sof/ipc3-topology.c                                        |   10 
 tools/include/nolibc/std.h                                           |    2 
 tools/lib/bpf/libbpf.c                                               |   46 +-
 tools/testing/nvdimm/test/ndtest.c                                   |   13 
 tools/testing/selftests/arm64/pauth/exec_target.c                    |    7 
 tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c              |    1 
 tools/testing/selftests/bpf/test_tcpnotify_user.c                    |   20 
 tools/testing/selftests/nolibc/nolibc-test.c                         |    4 
 tools/testing/selftests/vDSO/vdso_call.h                             |    7 
 tools/testing/selftests/vDSO/vdso_test_abi.c                         |    9 
 tools/testing/selftests/watchdog/watchdog-test.c                     |    6 
 264 files changed, 2038 insertions(+), 1119 deletions(-)

Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Aditya Kumar Singh (1):
      wifi: mac80211: fix Rx packet handling when pubsta information is not available

Akhilesh Patil (1):
      selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported

Alexander Lobakin (1):
      idpf: fix Rx descriptor ready check barrier in splitq

Alok Tiwari (3):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      PCI: j721e: Fix incorrect error message in probe()
      idpf: fix mismatched free function for dma_alloc_coherent

Andrea Righi (1):
      bpf: Mark kfuncs as __noclone

Andreas Gruenbacher (1):
      gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote

Andrei Lalaev (1):
      leds: leds-lp55xx: Use correct address for memory programming

Andy Yan (1):
      power: supply: cw2015: Fix a alignment coding style issue

AngeloGioacchino Del Regno (4):
      arm64: dts: mediatek: mt6331: Fix pmic, regulators, rtc, keys node names
      arm64: dts: mediatek: mt6795-xperia-m5: Fix mmc0 latch-ck value
      arm64: dts: mediatek: mt8395-kontron-i1200: Fix MT6360 regulator nodes
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Annette Kobou (1):
      arm64: dts: imx93-kontron: Fix GPIO for panel regulator

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Arnd Bergmann (2):
      hwrng: nomadik - add ARM_AMBA dependency
      media: st-delta: avoid excessive stack usage

Bagas Sanjaya (1):
      Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram

Bala-Vignesh-Reddy (1):
      selftests: arm64: Check fread return value in exec_target

Baochen Qiang (2):
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath10k: avoid unnecessary wait for service ready message

Bartosz Golaszewski (2):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      pinctrl: check the return value of pinmux_ops::get_function_name()

Bean Huo (1):
      mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()

Benjamin Berg (1):
      selftests/nolibc: fix EXPECT_NZ macro

Benjamin Tissoires (1):
      HID: hidraw: tighten ioctl command parsing

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Biju Das (1):
      arm64: dts: renesas: rzg2lc-smarc: Disable CAN-FD channel0

Brahmajit Das (1):
      drm/radeon/r600_cs: clean up of dead code in r600_cs

Brigham Campbell (1):
      drm/panel: novatek-nt35560: Fix invalid return value

Chao Yu (4):
      f2fs: fix condition in __allow_reserved_blocks()
      f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
      f2fs: fix to truncate first page in error path of f2fs_truncate()
      f2fs: fix to mitigate overhead of f2fs_zero_post_eof_page()

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8186-tentacruel: Fix touchscreen model

Chenghai Huang (3):
      crypto: hisilicon/zip - remove unnecessary validation for high-performance mode configurations
      crypto: hisilicon - re-enable address prefetch after device resuming
      crypto: hisilicon/qm - set NULL to qm->debug.qm_diff_regs

Chia-I Wu (1):
      drm/bridge: it6505: select REGMAP_I2C

Christophe Leroy (3):
      powerpc/8xx: Remove left-over instruction and comments in DataStoreTLBMiss handler
      powerpc/603: Really copy kernel PGD entries into all PGDIRs
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Colin Ian King (2):
      misc: genwqe: Fix incorrect cmd field being reported in error
      ACPI: NFIT: Fix incorrect ndr_desc being reportedin dev_err message

Cosmin Tanislav (1):
      mfd: rz-mtu3: Fix MTU5 NFCR register offset

Cristian Ciocaltea (1):
      usb: vhci-hcd: Prevent suspending virtually attached devices

D. Wythe (1):
      libbpf: Fix error when st-prefix_ops and ops from differ btf

Da Xue (1):
      pinctrl: meson-gxl: add missing i2c_d pinmux

Dan Carpenter (4):
      PM / devfreq: mtk-cci: Fix potential error pointer dereference in probe()
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      serial: max310x: Add error checking in probe()
      ocfs2: fix double free in user_cluster_connect()

Daniel Borkmann (1):
      bpf: Enforce expected_attach_type for tailcall compatibility

Daniel Wagner (1):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op

Deepak Sharma (1):
      net: nfc: nci: Add parameter validation for packet data

Dmitry Antipov (1):
      ACPICA: Fix largest possible resource descriptor index

Dmitry Baryshkov (2):
      thermal/drivers/qcom: Make LMH select QCOM_SCM
      thermal/drivers/qcom/lmh: Add missing IRQ includes

Dominique Martinet (1):
      net/9p: Fix buffer overflow in USB transport layer

Donet Tom (2):
      drivers/base/node: handle error properly in register_one_node()
      drivers/base/node: fix double free in register_one_node()

Enzo Matsumiya (1):
      smb: client: fix crypto buffers in non-linear memory

Eric Dumazet (3):
      nbd: restrict sockets to TCP and UDP
      inet: ping: check sock_net() in ping_get_port() and ping_lookup()
      tcp: fix __tcp_close() to only send RST when required

Erick Karanja (1):
      mtd: rawnand: atmel: Fix error handling path in atmel_nand_controller_add_nands

Fan Wu (1):
      KEYS: X.509: Fix Basic Constraints CA flag parsing

Fedor Pchelkin (1):
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Fenglin Wu (1):
      leds: flash: leds-qcom-flash: Update torch current clamp setting

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink: reset nlh pointer during batch replay

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Frieder Schrempf (1):
      arm64: dts: imx93-kontron: Fix USB port assignment

Geert Uytterhoeven (3):
      init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
      regmap: Remove superfluous check for !config in __regmap_init()
      ARM: dts: renesas: porter: Fix CAN pin group

Genjian Zhang (1):
      null_blk: Fix the description of the cache_size module argument

Greg Kroah-Hartman (1):
      Linux 6.12.53

Guangshuo Li (1):
      nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()

Gui-Dong Han (1):
      RDMA/rxe: Fix race in do_task() when draining

Guoqing Jiang (1):
      arm64: dts: mediatek: mt8195: Remove suspend-breaking reset from pcie0

Hans de Goede (2):
      iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()

Hengqi Chen (2):
      riscv, bpf: Sign extend struct ops return values properly
      bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

Håkon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

I Viswanath (2):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      ptp: Add a upper bound on max_vclocks

Ivan Abramov (1):
      dm vdo: return error on corrupted metadata in start_restoring_volume functions

Jacopo Mondi (1):
      media: zoran: Remove zoran_fh structure

Jakub Kicinski (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"

Jan Kara (1):
      ext4: fix checks for orphan inodes

Janne Grunau (2):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      fbdev: simplefb: Fix use after free in simplefb_detach_genpds()

Jarkko Sakkinen (1):
      tpm: Disable TPM2_TCG_HMAC by default

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Jens Axboe (1):
      io_uring/waitid: always prune wait queue entry in io_waitid_wait()

Jens Wiklander (1):
      tee: fix register_shm_helper()

Jeremy Linton (1):
      uprobes: uprobe_warn should use passed task

Jie Gan (1):
      coresight: tpda: fix the logic to setup the element size

Jihed Chaibi (3):
      ARM: dts: ti: omap: am335x-baltos: Fix ti,en-ck32k-xtal property in DTS to use correct boolean syntax
      ARM: dts: ti: omap: omap3-devkit8000-lcd: Fix ti,keep-vref-on property to use correct boolean syntax in DTS
      ARM: dts: omap: am335x-cm-t335: Remove unused mcasp num-serializer property

Johan Hovold (4):
      firmware: firmware: meson-sm: fix compile-test default
      soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
      soc: mediatek: mtk-svs: fix device leaks on mt8192 probe failure
      cpuidle: qcom-spm: fix device and OF node leaks at probe

Johannes Nixdorf (1):
      seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast

Jonas Gorski (1):
      spi: fix return code when spi device has too many chipselects

Jonas Karlman (1):
      phy: rockchip: naneng-combphy: Enable U3 OTG port for RK3568

Joy Zou (1):
      arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid

Junnan Wu (1):
      firmware: arm_scmi: Mark VirtIO ready before registering scmi_virtio_driver

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Komal Bajaj (1):
      usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls

Konrad Dybcio (1):
      arm64: dts: qcom: qcm2290: Disable USB SS bus instances in park mode

Kunihiko Hayashi (2):
      i2c: designware: Fix clock issue when PM is disabled
      i2c: designware: Add disabling clocks when probe fails

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Fix invalid unsigned return in rzg3s_oen_read()

Larshin Sergey (1):
      fs: udf: fix OOB read in lengthAllocDescs handling

Lei Lu (1):
      sunrpc: fix null pointer dereference on zero-length checksum

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Leo Yan (6):
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      coresight: tmc: Support atclk
      coresight: catu: Support atclk
      coresight: etm4x: Support atclk
      coresight: trbe: Return NULL pointer for allocation failures

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Liao Yuanhong (2):
      drm/amd/display: Remove redundant semicolons
      wifi: iwlwifi: Remove redundant header files

Lin Yujun (1):
      coresight: Fix incorrect handling for return value of devm_kzalloc

Ling Xu (4):
      misc: fastrpc: Save actual DMA size in fastrpc_map structure
      misc: fastrpc: Fix fastrpc_map_lookup operation
      misc: fastrpc: fix possible map leak in fastrpc_put_args
      misc: fastrpc: Skip reference for DMA handles

Lorenzo Bianconi (2):
      wifi: mt76: mt7996: Fix RX packets configuration for primary WED device
      wifi: mt76: mt7996: Convert mt7996_wed_rro_addr to LE

Lu Baolu (1):
      iommu/vt-d: Disallow dirty tracking if incoherent page walk

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO
      Bluetooth: ISO: Fix possible UAF on iso_conn_free
      Bluetooth: hci_sync: Fix using random address for BIG/PA advertisements

Ma Ke (1):
      ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()

Marek Vasut (4):
      PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
      PCI: rcar-gen4: Assure reset occurs before DBI access
      PCI: rcar-gen4: Fix inverted break condition in PHY initialization
      Input: atmel_mxt_ts - allow reset GPIO to sleep

Matt Bobrowski (1):
      bpf/selftests: Fix test_tcpnotify_user

Matvey Kovalev (1):
      ksmbd: fix error code overwriting in smb2_get_info_filesystem()

Miaoqian Lin (1):
      usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Michael S. Tsirkin (1):
      vhost: vringh: Fix copy_to_iter return value check

Michal Pecio (1):
      Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"

Moon Hee Lee (1):
      fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist

Moshe Shemesh (2):
      net/mlx5: Stop polling for command response if interface goes down
      net/mlx5: fw reset, add reset timeout work

Nagarjuna Kristam (1):
      PCI: tegra194: Fix duplicate PLL disable in pex_ep_event_pex_rst_assert()

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Namjae Jeon (1):
      ksmbd: add max ip connections parameter

Nicolas Ferre (1):
      ARM: at91: pm: fix MCKx restore routine

Nicolas Frattaroli (1):
      PM / devfreq: rockchip-dfi: double count on RK3588

Niklas Cassel (1):
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod

Nirmoy Das (1):
      PCI/ACPI: Fix pci_acpi_preserve_config() memory leak

Nishanth Menon (1):
      hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Oleksij Rempel (1):
      net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Or Har-Toov (1):
      RDMA/mlx5: Better estimate max_qp_wr to reflect WQE count

Parav Pandit (1):
      RDMA/core: Resolve MAC of next-hop device without ARP support

Patrisious Haddad (1):
      RDMA/mlx5: Fix vport loopback forcing for MPV device

Paul Chaignon (1):
      bpf: Explicitly check accesses to bpf_sock_addr

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Phillip Lougher (1):
      Squashfs: fix uninit-value in squashfs_get_parent

Qi Xi (1):
      once: fix race by moving DO_ONCE to separate section

Qianfeng Rong (9):
      regulator: scmi: Use int type to store negative error codes
      block: use int to store blk_stack_limits() return value
      pinctrl: renesas: Use int type to store negative error codes
      ALSA: lx_core: use int type to store negative error codes
      drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
      drm/msm/dpu: fix incorrect type for ret
      scsi: qla2xxx: edif: Fix incorrect sign of error code
      scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES()
      scsi: qla2xxx: Fix incorrect sign of error code in qla_nvme_xmt_ls_rsp()

Qiuxu Zhuo (1):
      EDAC/i10nm: Skip DIMM enumeration on a disabled memory controller

Qu Wenruo (1):
      btrfs: return any hit error from extent_writepage_io()

Rafael J. Wysocki (2):
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      smp: Fix up and expand the smp_call_function_many() kerneldoc

Randy Dunlap (1):
      lsm: CONFIG_LSM can depend on CONFIG_SECURITY

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Ranjani Sridharan (1):
      ASoC: SOF: ipc3-topology: Fix multi-core and static pipelines tear down

Richard Fitzgerald (1):
      ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Sean Christopherson (1):
      KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isn't valid

Sebastian Andrzej Siewior (1):
      ALSA: pcm: Disable bottom softirqs as part of spin_lock_irq() on PREEMPT_RT

Seppo Takalo (1):
      tty: n_gsm: Don't block input queue by waiting MSC

Shay Drory (1):
      net/mlx5: pagealloc: Fix reclaim race during command interface teardown

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Srinivas Kandagatla (2):
      ASoC: codecs: wcd937x: set the comp soundwire port correctly
      ASoC: codecs: wcd937x: make stub functions inline

Stanley Chu (2):
      i3c: master: svc: Use manual response for IBI events
      i3c: master: svc: Recycle unused IBI slot

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stefan Metzmacher (1):
      smb: server: fix IRD/ORD negotiation with the client

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid disabling handover IRQ twice

Sven Peter (1):
      usb: typec: tipd: Clear interrupts first

Takashi Iwai (3):
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping

Tao Chen (1):
      bpf: Remove migrate_disable in kprobe_multi_link_prog_run

Thomas Fourier (2):
      crypto: keembay - Add missing check after sg_nents_for_len()
      scsi: myrs: Fix dma_alloc_coherent() error check

Thomas Weißschuh (3):
      vdso: Add struct __kernel_old_timeval forward declaration to gettime.h
      selftests: vDSO: Fix -Wunitialized in powerpc VDSO_CALL() wrapper
      selftests: vDSO: vdso_test_abi: Correctly skip whole test with missing vDSO

Thorsten Blum (1):
      crypto: octeontx2 - Call strscpy() with correct size argument

Timur Kristóf (7):
      drm/amdgpu: Power up UVD 3 for FW validation (v2)
      drm/amd/pm: Disable ULV even if unsupported (v3)
      drm/amd/pm: Fix si_upload_smc_data (v3)
      drm/amd/pm: Adjust si_upload_smc_data register programming (v3)
      drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)
      drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
      drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks (v3)

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (4):
      pwm: tiehrpwm: Don't drop runtime PM reference in .free()
      pwm: tiehrpwm: Make code comment in .free() more useful
      pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Separate methods of fan setting coming from different subsystems

Vineeth Pillai (Google) (1):
      iommu/vt-d: debugfs: Fix legacy mode page table dump logic

Vitaly Grigoryev (1):
      fs: ntfs3: Fix integer overflow in run_unpack()

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xichao Zhao (1):
      usb: phy: twl6030: Fix incorrect type for ret

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yazhou Tang (1):
      bpf: Reject negative offsets for ALU ops

Yeounsu Moon (1):
      net: dlink: handle copy_thresh allocation failure

Youling Tang (1):
      LoongArch: Automatically disable kaslr if boot from kexec_file

Yuanfang Zhang (2):
      coresight: Only register perf symlink for sinks with alloc_buffer
      coresight-etm4x: Conditionally access register TRCEXTINSELR

Yunseong Kim (1):
      ksmbd: Fix race condition in RPC handle list access

Yureka Lilian (1):
      libbpf: Fix reuse of DEVMAP

Zhang Shurong (1):
      media: rj54n1cb0c: Fix memleak in rj54n1_probe()

Zhang Tengfei (1):
      ipvs: Use READ_ONCE/WRITE_ONCE for ipvs->enable

Zhen Ni (3):
      netfilter: ipset: Remove unused htable_bits in macro ahash_region
      Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      remoteproc: pru: Fix potential NULL pointer dereference in pru_rproc_set_ctable()

Zheng Qixing (2):
      dm: fix queue start/stop imbalance under suspend/load/resume races
      dm: fix NULL pointer dereference in __dm_suspend()

Zhi-Jun You (1):
      wifi: mt76: mt7915: fix mt7981 pre-calibration

Zhouyi Zhou (1):
      tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers

Zhushuai Yin (1):
      crypto: hisilicon/qm - check whether the input function and PF are on the same device

Zilin Guan (1):
      vfio/pds: replace bitmap_free with vfree

wangzijie (1):
      f2fs: fix zero-sized extent for precache extents

zhang jiao (1):
      vhost: vringh: Modify the return value check


