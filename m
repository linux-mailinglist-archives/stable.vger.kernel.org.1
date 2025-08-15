Return-Path: <stable+bounces-169719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A63B2819E
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91E47A9822
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92F224247;
	Fri, 15 Aug 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uhFrpAcw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504311E230E;
	Fri, 15 Aug 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268080; cv=none; b=JNp3FbUbW0JHBQ+boKiF0JSFhOoXJJqeKK03KWzbs97/cygiOoe5cFwKSPoDpuqIItyN7hnIq+0fInLrNaZ0zt282FjnQyHaj3mU5U7YspVUn+cmbZyBvc7wN4gRSZnhJ7JAdkqB+009/BNkNIvIbFsPXdYuvZO/Q7/7xw2J+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268080; c=relaxed/simple;
	bh=MSnpb5l1n2x22ovMJyHPKsh6bBYh+J47FrFL72RcqV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EdnoFz7RKLCaq0CH2bBK/rai/dr+qJdQ/Oqsq2ZaPQVF6/gThe847HtJKnS8WTSGZxqcHDNB5obrG/EMn3oYADWvBYHOmuPwnS7+1xxfN9NrGgHpm3vRuLDt9oJHEOydjvnLgBuCif6nsMQnVWL9/rugcrdYB5z3UJ9l4AaJVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uhFrpAcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C9C4CEEB;
	Fri, 15 Aug 2025 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755268079;
	bh=MSnpb5l1n2x22ovMJyHPKsh6bBYh+J47FrFL72RcqV4=;
	h=From:To:Cc:Subject:Date:From;
	b=uhFrpAcwWZMcMkrqySEYEkVLWSmg0fIGtsgrdFHfgRAYn0m99bhIKA1cKxlfBXEWP
	 FoI74A1svNwu6J+XUiB78r7eNFPhpvA90wzFt62bQ+oxDv4kWaA518cd6TNoqoNyO7
	 8GZ2CnHf+jWgDFs9hanTUUalCEEGzaiAqD5hQ8mA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.148
Date: Fri, 15 Aug 2025 16:27:54 +0200
Message-ID: <2025081555-net-pang-3f9c@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.148 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/f2fs.rst                              |    6 
 Makefile                                                        |    2 
 arch/arm/boot/dts/am335x-boneblack.dts                          |    2 
 arch/arm/boot/dts/imx6ul-kontron-bl-common.dtsi                 |    1 
 arch/arm/boot/dts/vfxxx.dtsi                                    |    2 
 arch/arm/crypto/aes-neonbs-glue.c                               |    2 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi            |    2 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi            |    2 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                            |   10 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |   10 
 arch/m68k/Kconfig.debug                                         |    2 
 arch/m68k/kernel/early_printk.c                                 |   42 -
 arch/m68k/kernel/head.S                                         |    8 
 arch/mips/mm/tlb-r4k.c                                          |   56 +
 arch/powerpc/configs/ppc6xx_defconfig                           |    1 
 arch/powerpc/kernel/eeh.c                                       |    1 
 arch/powerpc/kernel/eeh_driver.c                                |   48 +
 arch/powerpc/kernel/eeh_pe.c                                    |   11 
 arch/powerpc/kernel/pci-hotplug.c                               |    3 
 arch/sh/Makefile                                                |   10 
 arch/sh/boot/compressed/Makefile                                |    4 
 arch/sh/boot/romimage/Makefile                                  |    4 
 arch/um/drivers/rtc_user.c                                      |    2 
 arch/x86/boot/compressed/sev.c                                  |    7 
 arch/x86/boot/cpuflags.c                                        |   13 
 arch/x86/hyperv/irqdomain.c                                     |    4 
 arch/x86/include/asm/cpufeatures.h                              |    1 
 arch/x86/kernel/cpu/amd.c                                       |    2 
 arch/x86/kernel/cpu/scattered.c                                 |    1 
 arch/x86/kernel/sev-shared.c                                    |   18 
 arch/x86/kernel/sev.c                                           |   11 
 arch/x86/mm/extable.c                                           |    5 
 drivers/base/regmap/regmap.c                                    |    2 
 drivers/block/ublk_drv.c                                        |    4 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                 |   19 
 drivers/char/hw_random/mtk-rng.c                                |    4 
 drivers/clk/clk-axi-clkgen.c                                    |    2 
 drivers/clk/davinci/psc.c                                       |    5 
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c                            |    3 
 drivers/clk/xilinx/xlnx_vcu.c                                   |    4 
 drivers/comedi/drivers/comedi_test.c                            |    2 
 drivers/cpufreq/cpufreq.c                                       |   21 
 drivers/cpufreq/intel_pstate.c                                  |    4 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c             |    4 
 drivers/crypto/ccp/ccp-debugfs.c                                |    3 
 drivers/crypto/img-hash.c                                       |    2 
 drivers/crypto/inside-secure/safexcel_hash.c                    |    8 
 drivers/crypto/keembay/keembay-ocs-hcu-core.c                   |    8 
 drivers/crypto/marvell/cesa/cipher.c                            |    4 
 drivers/crypto/marvell/cesa/hash.c                              |    5 
 drivers/crypto/qat/qat_common/adf_transport_debug.c             |    4 
 drivers/devfreq/devfreq.c                                       |   10 
 drivers/dma/mv_xor.c                                            |   21 
 drivers/dma/nbpfaxi.c                                           |   13 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                            |   47 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c             |    2 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                           |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                         |    6 
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c                      |    9 
 drivers/i2c/busses/i2c-qup.c                                    |    4 
 drivers/i2c/busses/i2c-tegra.c                                  |   24 
 drivers/i2c/busses/i2c-virtio.c                                 |   15 
 drivers/iio/adc/ad7949.c                                        |    7 
 drivers/infiniband/core/cache.c                                 |    4 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                      |   15 
 drivers/infiniband/hw/mlx5/dm.c                                 |    2 
 drivers/input/keyboard/gpio_keys.c                              |    4 
 drivers/interconnect/qcom/sc7280.c                              |    1 
 drivers/interconnect/qcom/sc8180x.c                             |    6 
 drivers/interconnect/qcom/sc8280xp.c                            |    1 
 drivers/irqchip/Kconfig                                         |    1 
 drivers/media/v4l2-core/v4l2-ctrls-core.c                       |    8 
 drivers/mtd/ftl.c                                               |    2 
 drivers/mtd/nand/raw/atmel/nand-controller.c                    |    2 
 drivers/mtd/nand/raw/atmel/pmecc.c                              |    6 
 drivers/mtd/nand/raw/rockchip-nand-controller.c                 |   15 
 drivers/net/can/dev/dev.c                                       |   31 -
 drivers/net/can/dev/netlink.c                                   |   12 
 drivers/net/can/kvaser_pciefd.c                                 |    1 
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c                |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c                      |   17 
 drivers/net/ethernet/emulex/benet/be_cmds.c                     |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |   15 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c             |   15 
 drivers/net/ethernet/google/gve/gve_main.c                      |   67 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c         |   36 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c          |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c       |    6 
 drivers/net/ethernet/intel/e1000e/defines.h                     |    3 
 drivers/net/ethernet/intel/e1000e/ich8lan.c                     |    2 
 drivers/net/ethernet/intel/e1000e/nvm.c                         |    6 
 drivers/net/ethernet/intel/fm10k/fm10k.h                        |    3 
 drivers/net/ethernet/intel/i40e/i40e.h                          |    2 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                  |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |   18 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c              |    8 
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe.h                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |    3 
 drivers/net/phy/mscc/mscc_ptp.c                                 |    1 
 drivers/net/phy/mscc/mscc_ptp.h                                 |    1 
 drivers/net/ppp/pptp.c                                          |   18 
 drivers/net/usb/usbnet.c                                        |   11 
 drivers/net/vrf.c                                               |    2 
 drivers/net/wireless/ath/ath11k/hal.c                           |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c     |    8 
 drivers/net/wireless/intel/iwlwifi/dvm/main.c                   |   11 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                    |    4 
 drivers/net/wireless/marvell/mwl8k.c                            |    4 
 drivers/net/wireless/purelifi/plfxlc/mac.c                      |   11 
 drivers/net/wireless/purelifi/plfxlc/mac.h                      |    2 
 drivers/net/wireless/purelifi/plfxlc/usb.c                      |   29 
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c              |    3 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c           |    2 
 drivers/pci/controller/pcie-rockchip-host.c                     |    2 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                   |    4 
 drivers/pci/hotplug/pnv_php.c                                   |  233 +++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                           |   11 
 drivers/platform/x86/ideapad-laptop.c                           |    2 
 drivers/power/supply/cpcap-charger.c                            |    5 
 drivers/power/supply/max14577_charger.c                         |    4 
 drivers/powercap/dtpm_cpu.c                                     |    2 
 drivers/pps/pps.c                                               |   11 
 drivers/regulator/core.c                                        |    1 
 drivers/rtc/rtc-ds1307.c                                        |    2 
 drivers/rtc/rtc-hym8563.c                                       |    2 
 drivers/rtc/rtc-nct3018y.c                                      |    2 
 drivers/rtc/rtc-pcf85063.c                                      |    2 
 drivers/rtc/rtc-pcf8563.c                                       |    2 
 drivers/rtc/rtc-rv3028.c                                        |    2 
 drivers/scsi/elx/efct/efct_lio.c                                |    2 
 drivers/scsi/ibmvscsi_tgt/libsrp.c                              |    6 
 drivers/scsi/isci/request.c                                     |    2 
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                            |    3 
 drivers/scsi/mvsas/mv_sas.c                                     |    4 
 drivers/scsi/scsi_transport_iscsi.c                             |    2 
 drivers/scsi/sd.c                                               |    4 
 drivers/soc/qcom/qmi_encdec.c                                   |   46 +
 drivers/soc/tegra/cbb/tegra234-cbb.c                            |    2 
 drivers/soundwire/stream.c                                      |    2 
 drivers/staging/fbtft/fbtft-core.c                              |    1 
 drivers/staging/nvec/nvec_power.c                               |    2 
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c     |    4 
 drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h |    2 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   |   79 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c  |  172 ++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c   |   36 -
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c           |    4 
 drivers/ufs/core/ufshcd.c                                       |   10 
 drivers/usb/chipidea/ci.h                                       |   18 
 drivers/usb/chipidea/udc.c                                      |   10 
 drivers/usb/early/xhci-dbc.c                                    |    4 
 drivers/usb/gadget/composite.c                                  |    5 
 drivers/usb/host/xhci-plat.c                                    |    2 
 drivers/usb/misc/apple-mfi-fastcharge.c                         |   24 
 drivers/usb/phy/phy-mxs-usb.c                                   |    4 
 drivers/usb/serial/option.c                                     |    2 
 drivers/usb/typec/tcpm/tcpm.c                                   |   64 +-
 drivers/vfio/pci/vfio_pci_core.c                                |    2 
 drivers/vhost/scsi.c                                            |    4 
 drivers/video/fbdev/core/fbcon.c                                |    4 
 drivers/video/fbdev/imxfb.c                                     |    9 
 drivers/watchdog/ziirave_wdt.c                                  |    3 
 drivers/xen/gntdev-common.h                                     |    4 
 drivers/xen/gntdev.c                                            |   71 +-
 fs/erofs/decompressor.c                                         |   23 
 fs/erofs/dir.c                                                  |   17 
 fs/erofs/inode.c                                                |    3 
 fs/erofs/internal.h                                             |    2 
 fs/erofs/namei.c                                                |    9 
 fs/erofs/zdata.c                                                |   56 -
 fs/erofs/zmap.c                                                 |    3 
 fs/f2fs/data.c                                                  |    2 
 fs/f2fs/extent_cache.c                                          |    2 
 fs/f2fs/f2fs.h                                                  |    2 
 fs/f2fs/inode.c                                                 |   21 
 fs/f2fs/segment.h                                               |    5 
 fs/hfsplus/extents.c                                            |    3 
 fs/jfs/jfs_dmap.c                                               |    4 
 fs/jfs/jfs_imap.c                                               |   13 
 fs/nfs/dir.c                                                    |    4 
 fs/nfs/export.c                                                 |   11 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |   26 
 fs/nfs/flexfilelayout/flexfilelayoutdev.c                       |    6 
 fs/nfs/internal.h                                               |    9 
 fs/nfs/nfs4proc.c                                               |   10 
 fs/nilfs2/inode.c                                               |    9 
 fs/ntfs3/file.c                                                 |    5 
 fs/orangefs/orangefs-debugfs.c                                  |    6 
 fs/proc/generic.c                                               |    2 
 fs/proc/inode.c                                                 |    2 
 fs/proc/internal.h                                              |    5 
 fs/smb/client/smbdirect.c                                       |   14 
 fs/smb/server/connection.h                                      |    1 
 fs/smb/server/smb2pdu.c                                         |   22 
 fs/smb/server/smb_common.c                                      |    2 
 fs/smb/server/transport_rdma.c                                  |   97 +--
 fs/smb/server/transport_tcp.c                                   |   17 
 fs/smb/server/vfs.c                                             |    3 
 include/linux/fs_context.h                                      |    2 
 include/linux/moduleparam.h                                     |    5 
 include/linux/pps_kernel.h                                      |    1 
 include/linux/proc_fs.h                                         |    1 
 include/linux/skbuff.h                                          |   23 
 include/linux/usb/usbnet.h                                      |    1 
 include/linux/wait_bit.h                                        |   60 ++
 include/net/tc_act/tc_ctinfo.h                                  |    6 
 include/net/udp.h                                               |   24 
 kernel/bpf/preload/Kconfig                                      |    1 
 kernel/events/core.c                                            |   20 
 kernel/kcsan/kcsan_test.c                                       |    2 
 kernel/trace/preemptirq_delay_test.c                            |   13 
 kernel/ucount.c                                                 |    2 
 mm/hmm.c                                                        |    2 
 mm/kasan/report.c                                               |    4 
 mm/khugepaged.c                                                 |    4 
 mm/zsmalloc.c                                                   |    3 
 net/appletalk/aarp.c                                            |   24 
 net/caif/cfctrl.c                                               |  294 ++++------
 net/core/filter.c                                               |    3 
 net/core/netpoll.c                                              |    7 
 net/core/skmsg.c                                                |    7 
 net/ipv4/tcp_input.c                                            |    3 
 net/ipv6/ip6_fib.c                                              |   24 
 net/ipv6/ip6_offload.c                                          |    4 
 net/ipv6/ip6mr.c                                                |    3 
 net/ipv6/route.c                                                |   56 +
 net/mac80211/tdls.c                                             |    2 
 net/mac80211/tx.c                                               |   14 
 net/netfilter/nf_tables_api.c                                   |    4 
 net/netfilter/xt_nfacct.c                                       |    4 
 net/packet/af_packet.c                                          |   12 
 net/sched/act_ctinfo.c                                          |   19 
 net/sched/sch_netem.c                                           |   40 +
 net/sched/sch_qfq.c                                             |    7 
 net/tls/tls_sw.c                                                |   13 
 net/vmw_vsock/af_vsock.c                                        |    3 
 net/xfrm/xfrm_interface_core.c                                  |    7 
 samples/mei/mei-amt-version.c                                   |    2 
 scripts/kconfig/qconf.cc                                        |    2 
 security/apparmor/include/match.h                               |    3 
 security/apparmor/match.c                                       |    1 
 sound/pci/hda/hda_tegra.c                                       |   51 +
 sound/pci/hda/patch_ca0132.c                                    |    5 
 sound/pci/hda/patch_hdmi.c                                      |   20 
 sound/pci/hda/patch_realtek.c                                   |    1 
 sound/soc/amd/yc/acp6x-mach.c                                   |    7 
 sound/soc/intel/boards/Kconfig                                  |    2 
 sound/soc/soc-dai.c                                             |   16 
 sound/soc/soc-ops.c                                             |   26 
 sound/usb/mixer_scarlett2.c                                     |    7 
 sound/x86/intel_hdmi_audio.c                                    |    2 
 tools/bpf/bpftool/net.c                                         |   15 
 tools/perf/builtin-sched.c                                      |   39 +
 tools/perf/tests/bp_account.c                                   |    1 
 tools/perf/util/evsel.c                                         |   11 
 tools/perf/util/evsel.h                                         |    2 
 tools/testing/selftests/arm64/fp/sve-ptrace.c                   |    2 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |   28 
 tools/testing/selftests/net/mptcp/Makefile                      |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh     |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh         |    5 
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh     |    5 
 tools/testing/selftests/net/rtnetlink.sh                        |    6 
 tools/testing/selftests/perf_events/.gitignore                  |    1 
 tools/testing/selftests/perf_events/Makefile                    |    2 
 tools/testing/selftests/perf_events/mmap.c                      |  236 ++++++++
 tools/testing/selftests/syscall_user_dispatch/sud_test.c        |   50 -
 271 files changed, 2444 insertions(+), 1165 deletions(-)

Abdun Nihaal (2):
      regmap: fix potential memory leak of regmap_bus
      staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()

Abinash Singh (1):
      f2fs: fix KMSAN uninit-value in extent_info usage

Adam Ford (2):
      arm64: dts: imx8mm-beacon: Fix HS400 USDHC clock speed
      arm64: dts: imx8mn-beacon: Fix HS400 USDHC clock speed

Adam Queler (1):
      ASoC: amd: yc: Add DMI entries to support HP 15-fb1xxx

Akhil R (1):
      i2c: tegra: Fix reset error handling with ACPI

Albin Törnqvist (1):
      arm: dts: ti: omap: Fixup pinheader typo

Alessandro Carminati (1):
      regulator: core: fix NULL dereference on unbind due to stale coupling data

Alex Williamson (1):
      vfio/pci: Separate SR-IOV VF dev_set

Alexander Wetzel (2):
      wifi: mac80211: Do not schedule stopped TXQs
      wifi: mac80211: Don't call fq_flow_idx() for management frames

Alexander Wilhelm (1):
      soc: qcom: QMI encoding/decoding for big endian

Alok Tiwari (1):
      staging: nvec: Fix incorrect null termination of battery manufacturer

Ammar Faizi (1):
      net: usbnet: Fix the wrong netif_carrier_on() call

Andy Shevchenko (1):
      mm/hmm: move pmd_to_hmm_pfn_flags() to the respective #ifdeffery

Andy Yan (1):
      drm/rockchip: cleanup fb when drm_gem_fb_afbc_init failed

Annette Kobou (1):
      ARM: dts: imx6ul-kontron-bl-common: Fix RTS polarity for RS485 interface

Arnd Bergmann (7):
      ethernet: intel: fix building with large NR_CPUS
      ASoC: Intel: fix SND_SOC_SOF dependencies
      ASoC: ops: dynamically allocate struct snd_ctl_elem_value
      caif: reduce stack size, again
      crypto: arm/aes-neonbs - work around gcc-15 warning
      kernel: trace: preemptirq_delay_test: use offstack cpu mask
      irqchip: Build IMX_MU_MSI only on ARM

Balamanikandan Gunasundar (1):
      mtd: rawnand: atmel: set pmecc data setup time

Bard Liao (1):
      soundwire: stream: restore params when prepare ports fail

Ben Hutchings (1):
      sh: Do not use hyphen in exported variable name

Benjamin Coddington (1):
      NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY

Brahmajit Das (1):
      samples: mei: Fix building on musl libc

Brian Masney (6):
      rtc: ds1307: fix incorrect maximum clock rate handling
      rtc: hym8563: fix incorrect maximum clock rate handling
      rtc: nct3018y: fix incorrect maximum clock rate handling
      rtc: pcf85063: fix incorrect maximum clock rate handling
      rtc: pcf8563: fix incorrect maximum clock rate handling
      rtc: rv3028: fix incorrect maximum clock rate handling

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Caleb Sander Mateos (1):
      ublk: use vmalloc for ublk_device's __queues

Chao Yu (6):
      f2fs: doc: fix wrong quota mount option description
      f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
      f2fs: fix to avoid panic in f2fs_evict_inode
      f2fs: fix to avoid out-of-boundary access in devs.path
      f2fs: fix to update upper_p in __get_secs_required() correctly
      f2fs: fix to calculate dirty data during has_not_enough_free_secs()

Charalampos Mitrodimas (1):
      usb: misc: apple-mfi-fastcharge: Make power supply names unique

Charles Han (2):
      power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
      power: supply: max14577: Handle NULL pdata when CONFIG_OF is not set

Chenyuan Yang (1):
      fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

Chiara Meiohas (1):
      net/mlx5: Fix memory leak in cmd_exec()

Christoph Paasch (1):
      net/mlx5: Correctly set gso_segs when LRO is used

Dan Carpenter (2):
      watchdog: ziirave_wdt: check record length in ziirave_firm_verify()
      fs/orangefs: Allow 2 more characters in do_c_string()

Daniel Dadap (1):
      ALSA: hda: Add missing NVIDIA HDA codec IDs

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Dave Hansen (1):
      x86/fpu: Delay instruction pointer fixup until after warning

David Lechner (1):
      iio: adc: ad7949: use spi_is_bpw_supported()

Dawid Rezler (1):
      ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx

Denis OSTERLAND-HEIM (1):
      pps: fix poll support

Dennis Chen (1):
      i40e: report VF tx_dropped with tx_errors instead of tx_discards

Dmitry Antipov (1):
      jfs: reject on-disk inodes of an unsupported type

Dmitry Baryshkov (2):
      interconnect: qcom: sc8280xp: specify num_links for qnm_a1noc_cfg
      interconnect: qcom: sc8180x: specify num_nodes

Dmitry Vyukov (1):
      selftests: Fix errno checking in syscall_user_dispatch test

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Remove extra semicolon in ti_sn_bridge_probe()

Eric Dumazet (7):
      net_sched: act_ctinfo: use atomic64_t for three counters
      ipv6: prevent infinite loop in rt6_nlmsg_size()
      ipv6: fix possible infinite loop in fib6_info_uses_dev()
      ipv6: annotate data-races around rt->fib6_nsiblings
      pptp: ensure minimal skb length in pptp_xmit()
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fabrice Gasnier (1):
      Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

Fedor Pchelkin (2):
      drm/amd/pm/powerplay/hwmgr/smu_helper: fix order of mask and value
      netfilter: nf_tables: adjust lockdep assertions handling

Finn Thain (1):
      m68k: Don't unregister boot console needlessly

Florian Westphal (1):
      netfilter: xt_nfacct: don't assume acct name is null-terminated

Gao Xiang (5):
      erofs: get rid of debug_one_dentry()
      erofs: sunset erofs_dbg()
      erofs: drop z_erofs_page_mark_eio()
      erofs: simplify z_erofs_transform_plain()
      erofs: address D-cache aliasing

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Add retry on -EPROTO from scarlett2_usb_tx()

Giovanni Cabiddu (1):
      crypto: qat - fix seq_file position update in adf_ring_next()

Gokul Sivakumar (1):
      wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE

Greg Kroah-Hartman (2):
      Revert "vmci: Prevent the dispatching of uninitialized payloads"
      Linux 6.1.148

Hans Zhang (1):
      PCI: rockchip-host: Fix "Unexpected Completion" log message

Haoxiang Li (1):
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Harry Yoo (1):
      mm/zsmalloc: do not pass __GFP_MOVABLE if CONFIG_COMPACTION=n

Henry Martin (1):
      clk: davinci: Add NULL check in davinci_lpsc_clk_register()

Herbert Xu (1):
      crypto: marvell/cesa - Fix engine load inaccuracy

Horatiu Vultur (1):
      phy: mscc: Fix parsing of unicast frames

Ian Abbott (1):
      comedi: comedi_test: Fix possible deletion of uninitialized timers

Ivan Stepchenko (1):
      mtd: fix possible integer overflow in erase_xfer()

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
      e1000e: ignore uninitialized checksum word on tgp

Jakub Kicinski (1):
      netpoll: prevent hanging NAPI when netcons gets enabled

James Cowgill (1):
      media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check

Jamie Bainbridge (1):
      i40e: When removing VF MAC filters, only check PF-set MAC

Jan Prusakowski (1):
      f2fs: vm_unmap_ram() may be called from an invalid context

Jerome Brunet (1):
      PCI: endpoint: pci-epf-vntb: Return -ENOENT if pci_epc_get_next_free_bar() fails

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jiasheng Jiang (1):
      iwlwifi: Add missing check for alloc_ordered_workqueue

Jiaxun Yang (1):
      MIPS: mm: tlb-r4k: Uniquify TLB entries on init

Jiayuan Chen (2):
      bpf, sockmap: Fix psock incorrectly pointing to sk
      bpf, ktls: Fix data corruption when using bpf_msg_pop_data() in ktls

Jimmy Assarsson (2):
      can: kvaser_pciefd: Store device channel index
      can: kvaser_usb: Assign netdev.dev_port based on device channel index

Johan Korsnes (1):
      arch: powerpc: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

John Ernberg (1):
      net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

Juergen Gross (1):
      xen/gntdev: remove struct gntdev_copy_batch from stack

Junxian Huang (1):
      RDMA/hns: Fix -Wframe-larger-than issue

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Konrad Dybcio (2):
      arm64: dts: qcom: sdm845: Expand IMEM region
      arm64: dts: qcom: sc7180: Expand IMEM region

Konstantin Komarov (1):
      Revert "fs/ntfs3: Replace inode_trylock with inode_lock"

Krzysztof Kozlowski (1):
      ARM: dts: vfxxx: Correctly use two tuples for timer address

Kuninori Morimoto (1):
      ASoC: soc-dai: tidyup return value of snd_soc_xlate_tdm_slot_mask()

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Li Lingfeng (1):
      scsi: Revert "scsi: iscsi: Fix HW conn removal use after free"

Lifeng Zheng (3):
      PM / devfreq: Check governor before using governor->name
      cpufreq: Initialize cpufreq-based frequency-invariance later
      cpufreq: Init policy->rwsem before it may be possibly used

Liu Shixin (1):
      mm: khugepaged: fix call hpage_collapse_scan_file() for anonymous vma

Lizhi Xu (1):
      vmci: Prevent the dispatching of uninitialized payloads

Lorenzo Stoakes (1):
      selftests/perf_events: Add a mmap() correctness test

Lucas De Marchi (1):
      usb: early: xhci-dbc: Fix early_ioremap leak

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling

Maciej W. Rozycki (1):
      powerpc/eeh: Rely on dev->link_active_reporting

Manivannan Sadhasivam (1):
      PCI: endpoint: pci-epf-vntb: Fix the incorrect usage of __iomem attribute

Maor Gottlieb (1):
      RDMA/core: Rate limit GID cache warning messages

Marc Kleine-Budde (3):
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): move debug message and stats after successful restart
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

Marco Elver (2):
      kasan: use vmalloc_dump_obj() for vmalloc error reports
      kcsan: test: Initialize dummy variable

Mark Brown (1):
      kselftest/arm64: Fix check for setting new VLs in sve-ptrace

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Masahiro Yamada (1):
      kconfig: qconf: fix ConfigList::updateListAllforAll()

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Mengbiao Xiong (1):
      crypto: ccp - Fix crash when rebind ccp device for ccp.ko

Michael Grzeschik (2):
      usb: typec: tcpm: allow to use sink in accessory mode
      usb: typec: tcpm: allow switching to mode accessory to mux properly

Michael Zhivich (1):
      x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Mohan Kumar D (1):
      ALSA: hda/tegra: Add Tegra264 support

Moon Hee Lee (1):
      wifi: mac80211: reject TDLS operations when station is not associated

Murad Masimov (1):
      wifi: plfxlc: Fix error handling in usb driver probe

Namhyung Kim (2):
      perf sched: Fix memory leaks for evsel->priv in timehist
      perf sched: Fix memory leaks in 'perf sched latency'

Namjae Jeon (4):
      ksmbd: fix null pointer dereference error in generate_encryptionkey
      ksmbd: fix Preauh_HashValue race condition
      ksmbd: fix corrupted mtime and ctime in smb2_open
      ksmbd: limit repeated connections from clients with the same IP

NeilBrown (1):
      sched: Add test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()

Nuno Das Neves (1):
      x86/hyperv: Fix usage of cpu_online_mask to get valid cpu

Nuno Sá (1):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq

Olga Kornievskaia (1):
      NFSv4.2: another fix for listxattr

Ovidiu Panait (2):
      crypto: sun8i-ce - fix nents passed to dma_unmap_sg()
      hwrng: mtk - handle devm_pm_runtime_enable errors

Paul Chaignon (1):
      bpf: Check flow_dissector ctx accesses are aligned

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix de clock definition

Petr Machata (1):
      net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain

Petr Pavlu (1):
      module: Restore the moduleparam prefix length check

Philip Yang (1):
      drm/amdkfd: Don't call mmput from MMU notifier callback

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

RD Babiera (1):
      usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Always use HWP_DESIRED_PERF in passive mode

Remi Pommarel (2):
      wifi: mac80211: Check 802.11 encaps offloading in ieee80211_tx_h_select_key()
      Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Rohit Visavalia (1):
      clk: xilinx: vcu: unregister pll_post only if registered correctly

Rong Zhang (1):
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots

RubenKelevra (1):
      fs_context: fix parameter name in infofc() macro

Ryan Lee (1):
      apparmor: ensure WB_HISTORY_SIZE value is a power of 2

Ryusuke Konishi (1):
      nilfs2: reject invalid file types when reading inodes

Salomon Dushimirimana (1):
      scsi: sd: Make sd shutdown issue START STOP UNIT appropriately

Sergey Senozhatsky (1):
      wifi: ath11k: clear initialized flag for deinit-ed srng lists

Seunghui Lee (1):
      scsi: ufs: core: Use link recovery when h8 exit fails during runtime resume

Seungjin Bae (1):
      usb: host: xhci-plat: fix incorrect type for of_match variable in xhci_plat_probe()

Shixiong Ou (1):
      fbcon: Fix outdated registered_fb reference in comment

Sivan Zohar-Kotzer (1):
      powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W709

Stanislav Fomichev (1):
      vrf: Drop existing dst reference in vrf_ip6_input_dst

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

Stefan Metzmacher (5):
      smb: server: remove separate empty_recvmsg_queue
      smb: server: make sure we call ib_dma_unmap_single() only if we called ib_dma_map_single already
      smb: server: let recv_done() consistently call put_recvmsg/smb_direct_disconnect_rdma_connection
      smb: server: let recv_done() avoid touching data_transfer after cleanup/move
      smb: client: let recv_done() cleanup before notifying the callers.

Stefan Wahren (1):
      staging: vchiq_arm: Make vchiq_shutdown never fail

Stephane Grosjean (1):
      can: peak_usb: fix USB FD devices potential malfunction

Steven Rostedt (1):
      selftests/tracing: Fix false failure of subsystem event test

Sumit Gupta (1):
      soc/tegra: cbb: Clear ERR_FORCE register with ERR_STATUS

Takashi Iwai (1):
      ALSA: hda/ca0132: Fix missing error handling in ca0132_alt_select_out()

Tao Xue (1):
      usb: gadget : fix use-after-free in composite_dev_cleanup()

Thomas Fourier (12):
      mwl8k: Add missing check after DMA map
      crypto: inside-secure - Fix `dma_unmap_sg()` nents value
      scsi: ibmvscsi_tgt: Fix dma_unmap_sg() nents value
      scsi: elx: efct: Fix dma_unmap_sg() nents value
      scsi: mvsas: Fix dma_unmap_sg() nents value
      scsi: isci: Fix dma_unmap_sg() nents value
      crypto: keembay - Fix dma_unmap_sg() nents value
      crypto: img-hash - Fix dma_unmap_sg() nents value
      dmaengine: mv_xor: Fix missing check after DMA map and missing unmap
      dmaengine: nbpfaxi: Add missing check after DMA map
      mtd: rawnand: atmel: Fix dma_mapping_error() address
      mtd: rawnand: rockchip: Add missing check after DMA map

Thomas Gleixner (3):
      perf/core: Don't leak AUX buffer refcount on allocation failure
      perf/core: Exit early on perf_mmap() fail
      perf/core: Prevent VMA split of buffer mappings

Thomas Weißschuh (1):
      bpf/preload: Don't select USERMODE_DRIVER

Thorsten Blum (2):
      smb: server: Fix extension string in ksmbd_extract_shortname()
      ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()

Tigran Mkrtchyan (1):
      pNFS/flexfiles: don't attempt pnfs on fatal DS errors

Timothy Pearson (5):
      PCI: pnv_php: Clean up allocated IRQs on unplug
      PCI: pnv_php: Work around switches with broken presence detection
      powerpc/eeh: Export eeh_unfreeze_pe()
      powerpc/eeh: Make EEH driver device hotplug safe
      PCI: pnv_php: Fix surprise plug detection and recovery

Tiwei Bie (1):
      um: rtc: Avoid shadowing err in uml_rtc_start()

Tom Lendacky (1):
      x86/sev: Evict cache lines during SNP memory validation

Tomas Henzl (1):
      scsi: mpt3sas: Fix a fw_event memory leak

Trond Myklebust (2):
      NFS: Fix wakeup of __nfs_lookup_revalidate() in unblock_revalidate()
      NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()

Umang Jain (3):
      staging: vc04_services: Drop VCHIQ_SUCCESS usage
      staging: vc04_services: Drop VCHIQ_ERROR usage
      staging: vc04_services: Drop VCHIQ_RETRY usage

Uros Bizjak (1):
      ucount: fix atomic_long_inc_below() argument type

Ville Syrjälä (1):
      drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x

Viresh Kumar (1):
      i2c: virtio: Avoid hang by using interruptible completion wait

Wang Liang (1):
      net: drop UFO packets in udp_rcv_segment()

William Liu (1):
      net/sched: Restrict conditions for adding duplicating netems to qdisc tree

Xiang Mei (1):
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class

Xilin Wu (1):
      interconnect: qcom: sc7280: Add missing num_links to xm_pcie3_1 node

Xiu Jianfeng (1):
      wifi: iwlwifi: Fix memory leak in iwl_mvm_init()

Xiumei Mu (1):
      selftests: rtnetlink.sh: remove esp4_offload after test

Xu Yang (2):
      usb: chipidea: add USB PHY event
      usb: phy: mxs: disconnect line when USB charger is attached

Yajun Deng (1):
      i40e: Add rx_missed_errors for buffer exhaustion

Yang Xiwen (1):
      i2c: qup: jump out of the loop in case of timeout

Yangtao Li (1):
      hfsplus: remove mutex_lock check in hfsplus_free_extents

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

Yuan Chen (2):
      bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
      pinctrl: sunxi: Fix memory leak on krealloc failure

Zheng Yu (1):
      jfs: fix metapage reference count leak in dbAllocCtl

wangzijie (1):
      proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al

xin.guo (1):
      tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range


