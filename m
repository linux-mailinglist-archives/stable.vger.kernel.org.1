Return-Path: <stable+bounces-118580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4EA3F5E8
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5857D860EC8
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438C20AF86;
	Fri, 21 Feb 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z0crTqnX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B120A5CC;
	Fri, 21 Feb 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144466; cv=none; b=V5hLcDAt0ZIgIkOIDIk5Uc5zDkwjDuFoQutjygqAarDDy1KZtVo7kL+IGSEU9vYjnL7Sn3mUOZarcq8WmwC5Eyjg1/atz2DdeBJYeLD0BReo8wHdPvoyhIXizERVdcswk9joai4AlikTTvIaIRQ1mej2SoD3FK6R/hElOPM4me8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144466; c=relaxed/simple;
	bh=3gvCho1t/8OUt1r3FgfzbjtlG9bLqKjmuANNMIiisHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oi/4VOUFlzFeW6rMPB3PECSjH+AgyvaKG64pPxos2/aueOa7PfNkK+bnR2SuAkYlHUbBPzju4S5v+8kCnnzS5cMJ48B9YE1JFQzWULi2oh6wgzixTvJdMC5NMI30+MRKRNm+l2BRomwpAy37M2hjFLNo7MspNt4I8JNBotqmM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z0crTqnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3FDC4CED6;
	Fri, 21 Feb 2025 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740144464;
	bh=3gvCho1t/8OUt1r3FgfzbjtlG9bLqKjmuANNMIiisHs=;
	h=From:To:Cc:Subject:Date:From;
	b=z0crTqnXhD/z7dpQQEjyHwTfUU5l1TtQqaY1gsMQXioezC/zi7YSHmDjKexPACDEB
	 v4FSgvqx9zGgUDN/Wy1a+JgvOx72KZftoed0UIx1D+b/JOYipFtg+CrJ6gIuuBG+CZ
	 ccwejUkKWLWlAnYhHF/JAeGtfTLut6ZN4RQ6KEHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.129
Date: Fri, 21 Feb 2025 14:27:39 +0100
Message-ID: <2025022140-drowsily-dial-c8a6@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.129 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml |    2 
 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml      |   20 -
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml         |    2 
 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml |    6 
 Documentation/kbuild/kconfig.rst                                  |    9 
 Makefile                                                          |    4 
 arch/alpha/include/uapi/asm/ptrace.h                              |    2 
 arch/alpha/kernel/asm-offsets.c                                   |    2 
 arch/alpha/kernel/entry.S                                         |   24 -
 arch/alpha/kernel/traps.c                                         |    2 
 arch/alpha/mm/fault.c                                             |    4 
 arch/arm/boot/dts/dra7-l4.dtsi                                    |    2 
 arch/arm/boot/dts/mt7623.dtsi                                     |    2 
 arch/arm/mach-at91/pm.c                                           |   31 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                      |   29 -
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                       |   25 -
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts        |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts       |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi     |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |    2 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                  |    3 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                   |    2 
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                      |    9 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                          |    2 
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                          |   11 
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi                  |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                          |    6 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                             |   11 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                             |    9 
 arch/arm64/boot/dts/qcom/pm6150.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                             |   35 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts                           |   15 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi               |    1 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi             |    1 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi               |    7 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi        |   12 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi          |   12 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                      |    9 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                              |   34 --
 arch/arm64/boot/dts/qcom/sc7280.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                            |    6 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |   20 -
 arch/arm64/boot/dts/qcom/sm6125.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                 |    2 
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts         |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                              |   30 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi                              |    4 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                              |    4 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                     |    2 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                          |    1 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                         |    1 
 arch/arm64/kernel/cacheinfo.c                                     |   12 
 arch/arm64/kernel/vdso/vdso.lds.S                                 |    1 
 arch/arm64/kernel/vmlinux.lds.S                                   |    1 
 arch/arm64/mm/hugetlbpage.c                                       |   12 
 arch/hexagon/include/asm/cmpxchg.h                                |    2 
 arch/hexagon/kernel/traps.c                                       |    4 
 arch/m68k/include/asm/vga.h                                       |    8 
 arch/mips/kernel/ftrace.c                                         |    2 
 arch/mips/loongson64/boardinfo.c                                  |    2 
 arch/mips/math-emu/cp1emu.c                                       |    2 
 arch/powerpc/include/asm/hugetlb.h                                |    9 
 arch/powerpc/kvm/e500_mmu_host.c                                  |   21 -
 arch/powerpc/platforms/pseries/eeh_pseries.c                      |    6 
 arch/s390/Makefile                                                |    2 
 arch/s390/include/asm/futex.h                                     |    2 
 arch/s390/kvm/vsie.c                                              |   25 +
 arch/s390/purgatory/Makefile                                      |    2 
 arch/x86/boot/compressed/Makefile                                 |    1 
 arch/x86/events/intel/core.c                                      |    5 
 arch/x86/include/asm/kexec.h                                      |   18 -
 arch/x86/include/asm/mmu.h                                        |    2 
 arch/x86/include/asm/mmu_context.h                                |    1 
 arch/x86/include/asm/msr-index.h                                  |    3 
 arch/x86/include/asm/tlbflush.h                                   |    1 
 arch/x86/kernel/amd_nb.c                                          |    4 
 arch/x86/kernel/i8253.c                                           |   11 
 arch/x86/kernel/machine_kexec_64.c                                |   45 +-
 arch/x86/kernel/static_call.c                                     |    1 
 arch/x86/kvm/hyperv.c                                             |    6 
 arch/x86/kvm/mmu/mmu.c                                            |    2 
 arch/x86/kvm/svm/nested.c                                         |   10 
 arch/x86/mm/tlb.c                                                 |   35 +-
 arch/x86/xen/mmu_pv.c                                             |   79 +++-
 arch/x86/xen/xen-head.S                                           |    5 
 block/blk-cgroup.c                                                |    1 
 block/fops.c                                                      |    5 
 block/genhd.c                                                     |   22 +
 block/partitions/ldm.h                                            |    2 
 block/partitions/mac.c                                            |   18 -
 drivers/acpi/apei/ghes.c                                          |   10 
 drivers/acpi/fan_core.c                                           |   10 
 drivers/acpi/prmt.c                                               |    4 
 drivers/acpi/property.c                                           |   10 
 drivers/ata/libata-sff.c                                          |   18 -
 drivers/base/regmap/regmap-irq.c                                  |    2 
 drivers/block/nbd.c                                               |    1 
 drivers/char/ipmi/ipmb_dev_int.c                                  |    3 
 drivers/clk/analogbits/wrpll-cln28hpc.c                           |    2 
 drivers/clk/imx/clk-imx8mp.c                                      |    5 
 drivers/clk/qcom/clk-alpha-pll.c                                  |    2 
 drivers/clk/qcom/clk-rpmh.c                                       |    2 
 drivers/clk/qcom/dispcc-sm6350.c                                  |    7 
 drivers/clk/qcom/gcc-mdm9607.c                                    |    2 
 drivers/clk/qcom/gcc-sdm845.c                                     |   32 -
 drivers/clk/qcom/gcc-sm6350.c                                     |   22 -
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c                            |    6 
 drivers/clocksource/i8253.c                                       |   13 
 drivers/cpufreq/acpi-cpufreq.c                                    |   36 +-
 drivers/cpufreq/s3c64xx-cpufreq.c                                 |   11 
 drivers/crypto/hisilicon/sec2/sec.h                               |    3 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                        |  168 ++++------
 drivers/crypto/hisilicon/sec2/sec_crypto.h                        |   11 
 drivers/crypto/ixp4xx_crypto.c                                    |    3 
 drivers/crypto/qce/aead.c                                         |    2 
 drivers/crypto/qce/core.c                                         |   13 
 drivers/crypto/qce/sha.c                                          |    2 
 drivers/crypto/qce/skcipher.c                                     |    2 
 drivers/dma/ti/edma.c                                             |    3 
 drivers/firmware/Kconfig                                          |    2 
 drivers/firmware/efi/efi.c                                        |    6 
 drivers/firmware/efi/libstub/Makefile                             |    2 
 drivers/firmware/efi/libstub/randomalloc.c                        |    3 
 drivers/firmware/efi/libstub/relocate.c                           |    3 
 drivers/firmware/efi/sysfb_efi.c                                  |    2 
 drivers/gpio/gpio-bcm-kona.c                                      |   71 +++-
 drivers/gpio/gpio-mxc.c                                           |    3 
 drivers/gpio/gpio-pca953x.c                                       |   19 -
 drivers/gpio/gpio-stmpe.c                                         |   15 
 drivers/gpio/gpio-xilinx.c                                        |   56 +--
 drivers/gpio/gpiolib-acpi.c                                       |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c       |    6 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c      |    8 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c      |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                     |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c             |    3 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c             |    3 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c             |    5 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c           |    5 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c             |    5 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c           |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c               |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                         |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                |    1 
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c          |    4 
 drivers/gpu/drm/bridge/ite-it6505.c                               |   65 ++-
 drivers/gpu/drm/display/drm_dp_cec.c                              |   14 
 drivers/gpu/drm/drm_fb_helper.c                                   |   14 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                             |   16 
 drivers/gpu/drm/i915/display/skl_universal_plane.c                |    4 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                 |   20 -
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c                     |    4 
 drivers/gpu/drm/msm/dp/dp_audio.c                                 |    2 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                            |    9 
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h                       |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                      |  120 +++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                      |    1 
 drivers/gpu/drm/tidss/tidss_dispc.c                               |   22 -
 drivers/gpu/drm/v3d/v3d_perfmon.c                                 |    5 
 drivers/gpu/drm/virtio/virtgpu_drv.h                              |    7 
 drivers/gpu/drm/virtio/virtgpu_plane.c                            |   58 ++-
 drivers/hid/hid-core.c                                            |    2 
 drivers/hid/hid-multitouch.c                                      |    7 
 drivers/hid/hid-sensor-hub.c                                      |   21 -
 drivers/hid/hid-thrustmaster.c                                    |    8 
 drivers/hid/wacom_wac.c                                           |    5 
 drivers/i2c/i2c-core-acpi.c                                       |   22 +
 drivers/i3c/master.c                                              |    2 
 drivers/i3c/master/i3c-master-cdns.c                              |    1 
 drivers/iio/light/as73211.c                                       |   24 +
 drivers/infiniband/hw/cxgb4/device.c                              |    6 
 drivers/infiniband/hw/efa/efa_main.c                              |    9 
 drivers/infiniband/hw/mlx4/main.c                                 |    6 
 drivers/infiniband/hw/mlx5/odp.c                                  |   32 -
 drivers/infiniband/sw/rxe/rxe_pool.c                              |   11 
 drivers/infiniband/ulp/srp/ib_srp.c                               |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                       |   17 -
 drivers/irqchip/irq-apple-aic.c                                   |    3 
 drivers/leds/leds-lp8860.c                                        |    2 
 drivers/leds/leds-netxbig.c                                       |    1 
 drivers/mailbox/tegra-hsp.c                                       |    6 
 drivers/md/dm-crypt.c                                             |   27 -
 drivers/media/dvb-frontends/cxd2841er.c                           |    8 
 drivers/media/i2c/ccs/ccs-core.c                                  |    6 
 drivers/media/i2c/ccs/ccs-data.c                                  |   14 
 drivers/media/i2c/imx412.c                                        |   42 +-
 drivers/media/i2c/ov5640.c                                        |    1 
 drivers/media/i2c/ov9282.c                                        |    2 
 drivers/media/platform/marvell/mcam-core.c                        |    7 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                    |    7 
 drivers/media/platform/samsung/exynos4-is/mipi-csis.c             |   10 
 drivers/media/platform/samsung/s3c-camif/camif-core.c             |   13 
 drivers/media/rc/iguanair.c                                       |    4 
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                   |    8 
 drivers/media/usb/dvb-usb-v2/lmedm04.c                            |   12 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |    8 
 drivers/media/usb/uvc/uvc_driver.c                                |   70 +---
 drivers/media/usb/uvc/uvc_queue.c                                 |    3 
 drivers/media/usb/uvc/uvc_status.c                                |    1 
 drivers/media/v4l2-core/v4l2-mc.c                                 |    2 
 drivers/memory/tegra/tegra20-emc.c                                |    8 
 drivers/mfd/lpc_ich.c                                             |    3 
 drivers/mfd/syscon.c                                              |   81 +++-
 drivers/misc/cardreader/rtsx_usb.c                                |   15 
 drivers/misc/fastrpc.c                                            |    8 
 drivers/mmc/core/sdio.c                                           |    2 
 drivers/mmc/host/mtk-sd.c                                         |   31 +
 drivers/mmc/host/sdhci-msm.c                                      |   53 +++
 drivers/mtd/hyperbus/hbmc-am654.c                                 |   25 -
 drivers/mtd/nand/onenand/onenand_base.c                           |    1 
 drivers/net/can/c_can/c_can_platform.c                            |    5 
 drivers/net/can/ctucanfd/ctucanfd_base.c                          |   10 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                   |    4 
 drivers/net/ethernet/broadcom/bgmac.h                             |    3 
 drivers/net/ethernet/broadcom/tg3.c                               |   58 +++
 drivers/net/ethernet/davicom/dm9000.c                             |    3 
 drivers/net/ethernet/freescale/fec_main.c                         |   31 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                       |   15 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                       |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                       |   19 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c               |   24 -
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c                   |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c            |    4 
 drivers/net/ethernet/renesas/sh_eth.c                             |    4 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |    2 
 drivers/net/netdevsim/ipsec.c                                     |   12 
 drivers/net/netdevsim/netdevsim.h                                 |    1 
 drivers/net/netdevsim/udp_tunnels.c                               |   23 -
 drivers/net/phy/nxp-c45-tja11xx.c                                 |    2 
 drivers/net/team/team.c                                           |   11 
 drivers/net/tun.c                                                 |    2 
 drivers/net/usb/rtl8150.c                                         |   22 +
 drivers/net/vxlan/vxlan_core.c                                    |    7 
 drivers/net/vxlan/vxlan_vnifilter.c                               |    5 
 drivers/net/wireless/ath/ath11k/dp_rx.c                           |    1 
 drivers/net/wireless/ath/ath11k/hal_rx.c                          |    3 
 drivers/net/wireless/ath/wcn36xx/main.c                           |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c           |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c             |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c      |    3 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                      |   13 
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |    8 
 drivers/net/wireless/mediatek/mt76/usb.c                          |    4 
 drivers/net/wireless/realtek/rtlwifi/base.c                       |   29 -
 drivers/net/wireless/realtek/rtlwifi/base.h                       |    2 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   66 ---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c               |    7 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h               |    4 
 drivers/net/wireless/realtek/rtlwifi/usb.c                        |   12 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                       |   23 -
 drivers/net/wireless/ti/wlcore/main.c                             |   10 
 drivers/net/wwan/iosm/iosm_ipc_pcie.c                             |   56 +++
 drivers/nvme/host/core.c                                          |   16 
 drivers/nvme/host/ioctl.c                                         |    8 
 drivers/nvme/host/pci.c                                           |    4 
 drivers/nvmem/core.c                                              |    2 
 drivers/nvmem/qcom-spmi-sdam.c                                    |    1 
 drivers/of/base.c                                                 |    8 
 drivers/of/of_reserved_mem.c                                      |    7 
 drivers/opp/core.c                                                |  156 +++++++--
 drivers/opp/of.c                                                  |    4 
 drivers/parport/parport_pc.c                                      |    5 
 drivers/pci/controller/pcie-rcar-ep.c                             |    2 
 drivers/pci/endpoint/functions/pci-epf-test.c                     |   51 +--
 drivers/pci/endpoint/pci-epc-core.c                               |    2 
 drivers/pci/endpoint/pci-epf-core.c                               |    1 
 drivers/pci/quirks.c                                              |   12 
 drivers/pci/switch/switchtec.c                                    |   26 +
 drivers/pinctrl/pinctrl-cy8c95x0.c                                |    2 
 drivers/pinctrl/samsung/pinctrl-samsung.c                         |    2 
 drivers/pinctrl/stm32/pinctrl-stm32.c                             |  105 ++++--
 drivers/platform/x86/acer-wmi.c                                   |    4 
 drivers/platform/x86/intel/int3472/discrete.c                     |    3 
 drivers/platform/x86/intel/int3472/tps68470.c                     |    3 
 drivers/pps/clients/pps-gpio.c                                    |    4 
 drivers/pps/clients/pps-ktimer.c                                  |    4 
 drivers/pps/clients/pps-ldisc.c                                   |    6 
 drivers/pps/clients/pps_parport.c                                 |    4 
 drivers/pps/kapi.c                                                |   10 
 drivers/pps/kc.c                                                  |   10 
 drivers/pps/pps.c                                                 |  127 +++----
 drivers/ptp/ptp_chardev.c                                         |    4 
 drivers/ptp/ptp_clock.c                                           |    8 
 drivers/ptp/ptp_ocp.c                                             |    2 
 drivers/pwm/pwm-stm32-lp.c                                        |    8 
 drivers/pwm/pwm-stm32.c                                           |    7 
 drivers/regulator/core.c                                          |    2 
 drivers/regulator/of_regulator.c                                  |   14 
 drivers/remoteproc/remoteproc_core.c                              |   14 
 drivers/rtc/rtc-pcf85063.c                                        |   11 
 drivers/rtc/rtc-zynqmp.c                                          |    4 
 drivers/scsi/mpt3sas/mpt3sas_base.c                               |    3 
 drivers/scsi/qla2xxx/qla_def.h                                    |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                    |  124 ++++++-
 drivers/scsi/qla2xxx/qla_gbl.h                                    |    3 
 drivers/scsi/qla2xxx/qla_init.c                                   |   28 +
 drivers/scsi/storvsc_drv.c                                        |    1 
 drivers/soc/atmel/soc.c                                           |    2 
 drivers/soc/qcom/smem_state.c                                     |    3 
 drivers/soc/qcom/socinfo.c                                        |    2 
 drivers/spi/spi-zynq-qspi.c                                       |   13 
 drivers/staging/media/imx/imx-media-of.c                          |    8 
 drivers/staging/media/max96712/max96712.c                         |    4 
 drivers/tty/serial/8250/8250.h                                    |    2 
 drivers/tty/serial/8250/8250_dma.c                                |   16 
 drivers/tty/serial/8250/8250_pci.c                                |   10 
 drivers/tty/serial/8250/8250_port.c                               |   41 ++
 drivers/tty/serial/sh-sci.c                                       |   25 +
 drivers/tty/serial/xilinx_uartps.c                                |   10 
 drivers/ufs/core/ufs_bsg.c                                        |    2 
 drivers/usb/chipidea/ci_hdrc_imx.c                                |   31 +
 drivers/usb/class/cdc-acm.c                                       |   28 +
 drivers/usb/core/hub.c                                            |   14 
 drivers/usb/core/quirks.c                                         |    6 
 drivers/usb/dwc2/gadget.c                                         |    1 
 drivers/usb/dwc3/core.c                                           |   30 +
 drivers/usb/dwc3/dwc3-am62.c                                      |    1 
 drivers/usb/dwc3/gadget.c                                         |   34 ++
 drivers/usb/gadget/function/f_midi.c                              |    8 
 drivers/usb/gadget/function/f_tcm.c                               |   66 +--
 drivers/usb/gadget/udc/renesas_usb3.c                             |    2 
 drivers/usb/host/pci-quirks.c                                     |    9 
 drivers/usb/host/xhci-ring.c                                      |    3 
 drivers/usb/roles/class.c                                         |    5 
 drivers/usb/serial/option.c                                       |   49 +-
 drivers/usb/typec/tcpm/tcpci.c                                    |   13 
 drivers/usb/typec/tcpm/tcpm.c                                     |   10 
 drivers/vfio/iova_bitmap.c                                        |    2 
 drivers/vfio/pci/vfio_pci_rdwr.c                                  |    1 
 drivers/vfio/platform/vfio_platform_common.c                      |   10 
 drivers/video/fbdev/omap/lcd_dma.c                                |    4 
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c                     |    1 
 drivers/xen/swiotlb-xen.c                                         |   20 -
 fs/afs/dir.c                                                      |    7 
 fs/afs/xdr_fs.h                                                   |    2 
 fs/afs/yfsclient.c                                                |    5 
 fs/binfmt_flat.c                                                  |    2 
 fs/btrfs/file.c                                                   |    6 
 fs/btrfs/inode.c                                                  |    4 
 fs/btrfs/relocation.c                                             |   14 
 fs/btrfs/super.c                                                  |    2 
 fs/btrfs/transaction.c                                            |    4 
 fs/cachefiles/interface.c                                         |   14 
 fs/cachefiles/ondemand.c                                          |   30 +
 fs/exec.c                                                         |   29 +
 fs/f2fs/dir.c                                                     |   53 ++-
 fs/f2fs/f2fs.h                                                    |    6 
 fs/f2fs/file.c                                                    |   13 
 fs/f2fs/inline.c                                                  |    5 
 fs/file_table.c                                                   |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                            |   27 +
 fs/nfs/nfs42proc.c                                                |    2 
 fs/nfs/nfs42xdr.c                                                 |    2 
 fs/nfsd/nfs2acl.c                                                 |    2 
 fs/nfsd/nfs3acl.c                                                 |    2 
 fs/nfsd/nfs4callback.c                                            |    8 
 fs/nilfs2/inode.c                                                 |   10 
 fs/nilfs2/mdt.c                                                   |    6 
 fs/nilfs2/page.c                                                  |   55 +--
 fs/nilfs2/page.h                                                  |    4 
 fs/nilfs2/segment.c                                               |    4 
 fs/ocfs2/dir.c                                                    |   25 +
 fs/ocfs2/quota_global.c                                           |    5 
 fs/ocfs2/super.c                                                  |    2 
 fs/ocfs2/symlink.c                                                |    5 
 fs/orangefs/orangefs-debugfs.c                                    |    4 
 fs/proc/array.c                                                   |    2 
 fs/pstore/blk.c                                                   |    4 
 fs/select.c                                                       |    4 
 fs/smb/client/cifsglob.h                                          |   14 
 fs/smb/client/smb1ops.c                                           |    2 
 fs/smb/client/smb2ops.c                                           |   21 -
 fs/smb/client/smb2pdu.c                                           |    2 
 fs/smb/client/smb2proto.h                                         |    2 
 fs/smb/server/transport_ipc.c                                     |    9 
 fs/ubifs/debug.c                                                  |   22 -
 fs/xfs/xfs_inode.c                                                |    7 
 fs/xfs/xfs_qm_bhv.c                                               |   41 +-
 fs/xfs/xfs_super.c                                                |   11 
 include/linux/binfmts.h                                           |    4 
 include/linux/cgroup-defs.h                                       |    6 
 include/linux/efi.h                                               |    1 
 include/linux/i8253.h                                             |    1 
 include/linux/ieee80211.h                                         |   11 
 include/linux/iommu.h                                             |    2 
 include/linux/kallsyms.h                                          |    2 
 include/linux/kvm_host.h                                          |    9 
 include/linux/mfd/syscon.h                                        |   33 +
 include/linux/mlx5/driver.h                                       |    1 
 include/linux/netdevice.h                                         |    8 
 include/linux/pci_ids.h                                           |    4 
 include/linux/pm_opp.h                                            |   62 ++-
 include/linux/pps_kernel.h                                        |    3 
 include/linux/sched.h                                             |    4 
 include/linux/sched/task.h                                        |    1 
 include/linux/usb/tcpm.h                                          |    3 
 include/net/ax25.h                                                |   10 
 include/net/inetpeer.h                                            |   12 
 include/net/l3mdev.h                                              |    2 
 include/net/net_namespace.h                                       |   15 
 include/net/route.h                                               |    9 
 include/net/sch_generic.h                                         |    2 
 include/rv/da_monitor.h                                           |    4 
 include/uapi/linux/input-event-codes.h                            |    1 
 include/ufs/ufs.h                                                 |    4 
 io_uring/io_uring.c                                               |    5 
 io_uring/net.c                                                    |    5 
 io_uring/poll.c                                                   |    4 
 io_uring/rw.c                                                     |   10 
 kernel/cgroup/cgroup.c                                            |   20 -
 kernel/cgroup/rstat.c                                             |    1 
 kernel/debug/kdb/kdb_io.c                                         |    2 
 kernel/irq/internals.h                                            |    9 
 kernel/padata.c                                                   |   45 ++
 kernel/power/hibernate.c                                          |    7 
 kernel/printk/printk.c                                            |    2 
 kernel/sched/core.c                                               |    8 
 kernel/sched/cpufreq_schedutil.c                                  |    4 
 kernel/sched/fair.c                                               |   17 -
 kernel/sched/stats.h                                              |   22 -
 kernel/time/clocksource.c                                         |    9 
 kernel/trace/bpf_trace.c                                          |    2 
 lib/Kconfig.debug                                                 |    8 
 lib/maple_tree.c                                                  |   22 -
 mm/gup.c                                                          |   14 
 mm/kfence/core.c                                                  |    2 
 mm/kmemleak.c                                                     |    2 
 net/ax25/af_ax25.c                                                |   23 +
 net/ax25/ax25_dev.c                                               |    4 
 net/ax25/ax25_ip.c                                                |    3 
 net/ax25/ax25_out.c                                               |   22 +
 net/ax25/ax25_route.c                                             |    2 
 net/batman-adv/bat_v.c                                            |    2 
 net/batman-adv/bat_v_elp.c                                        |  122 +++++--
 net/batman-adv/bat_v_elp.h                                        |    2 
 net/batman-adv/types.h                                            |    3 
 net/bluetooth/l2cap_sock.c                                        |    7 
 net/bluetooth/mgmt.c                                              |   12 
 net/can/j1939/socket.c                                            |    4 
 net/can/j1939/transport.c                                         |    5 
 net/core/filter.c                                                 |    2 
 net/core/flow_dissector.c                                         |   21 -
 net/core/neighbour.c                                              |   11 
 net/core/sysctl_net_core.c                                        |    5 
 net/dsa/slave.c                                                   |    7 
 net/ethtool/netlink.c                                             |    2 
 net/hsr/hsr_forward.c                                             |    7 
 net/ipv4/arp.c                                                    |    4 
 net/ipv4/devinet.c                                                |    3 
 net/ipv4/icmp.c                                                   |   40 +-
 net/ipv4/inetpeer.c                                               |   31 -
 net/ipv4/ip_fragment.c                                            |   15 
 net/ipv4/ipmr_base.c                                              |    3 
 net/ipv4/route.c                                                  |   56 ++-
 net/ipv4/tcp_cubic.c                                              |    8 
 net/ipv4/udp.c                                                    |    4 
 net/ipv6/icmp.c                                                   |    6 
 net/ipv6/ip6_output.c                                             |    6 
 net/ipv6/mcast.c                                                  |   14 
 net/ipv6/ndisc.c                                                  |   32 +
 net/ipv6/route.c                                                  |    7 
 net/ipv6/udp.c                                                    |    4 
 net/mac80211/debugfs_netdev.c                                     |    2 
 net/mptcp/options.c                                               |   13 
 net/mptcp/pm_netlink.c                                            |    3 
 net/mptcp/protocol.c                                              |    5 
 net/mptcp/protocol.h                                              |   30 -
 net/ncsi/internal.h                                               |    2 
 net/ncsi/ncsi-cmd.c                                               |    3 
 net/ncsi/ncsi-manage.c                                            |   38 +-
 net/ncsi/ncsi-pkt.h                                               |   10 
 net/ncsi/ncsi-rsp.c                                               |   58 ++-
 net/netfilter/nf_tables_api.c                                     |    8 
 net/netfilter/nft_flow_offload.c                                  |   16 
 net/nfc/nci/hci.c                                                 |    2 
 net/openvswitch/datapath.c                                        |   12 
 net/rose/af_rose.c                                                |   40 +-
 net/rose/rose_timer.c                                             |   15 
 net/sched/sch_api.c                                               |    4 
 net/sched/sch_netem.c                                             |    2 
 net/sched/sch_sfq.c                                               |   56 +--
 net/smc/af_smc.c                                                  |    2 
 net/smc/smc_rx.c                                                  |   37 +-
 net/smc/smc_rx.h                                                  |    8 
 net/tipc/crypto.c                                                 |    4 
 net/wireless/scan.c                                               |   35 ++
 net/xfrm/xfrm_replay.c                                            |   10 
 samples/landlock/sandboxer.c                                      |    7 
 scripts/Makefile.extrawarn                                        |    5 
 scripts/Makefile.lib                                              |    4 
 scripts/genksyms/genksyms.c                                       |   11 
 scripts/genksyms/genksyms.h                                       |    2 
 scripts/genksyms/parse.y                                          |   18 -
 scripts/kconfig/conf.c                                            |    6 
 scripts/kconfig/confdata.c                                        |  102 +++---
 scripts/kconfig/lkc_proto.h                                       |    2 
 scripts/kconfig/symbol.c                                          |   10 
 security/landlock/fs.c                                            |   11 
 security/safesetid/securityfs.c                                   |    3 
 security/tomoyo/common.c                                          |    2 
 sound/pci/hda/hda_auto_parser.c                                   |    8 
 sound/pci/hda/hda_auto_parser.h                                   |    1 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/soc/amd/Kconfig                                             |    2 
 sound/soc/amd/yc/acp6x-mach.c                                     |   28 +
 sound/soc/intel/avs/apl.c                                         |    2 
 sound/soc/intel/boards/bytcr_rt5640.c                             |   17 -
 sound/soc/rockchip/rockchip_i2s_tdm.c                             |   31 +
 sound/soc/sh/rz-ssi.c                                             |    3 
 sound/soc/soc-pcm.c                                               |   31 +
 sound/soc/sunxi/sun4i-spdif.c                                     |    7 
 sound/usb/quirks.c                                                |    2 
 tools/bootconfig/main.c                                           |    4 
 tools/lib/bpf/linker.c                                            |   22 -
 tools/lib/bpf/usdt.c                                              |    2 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c           |   15 
 tools/testing/ktest/ktest.pl                                      |    7 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                     |    1 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh   |   16 
 tools/testing/selftests/gpio/gpio-sim.sh                          |   31 +
 tools/testing/selftests/kselftest_harness.h                       |   24 -
 tools/testing/selftests/landlock/fs_test.c                        |    3 
 tools/testing/selftests/net/ipsec.c                               |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                 |    2 
 tools/testing/selftests/net/pmtu.sh                               |  112 +++++-
 tools/testing/selftests/net/rtnetlink.sh                          |    4 
 tools/testing/selftests/net/udpgso.c                              |   26 +
 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c         |    2 
 tools/testing/selftests/timers/clocksource-switch.c               |    6 
 tools/tracing/rtla/src/osnoise.c                                  |    2 
 tools/tracing/rtla/src/timerlat_hist.c                            |   19 +
 tools/tracing/rtla/src/timerlat_top.c                             |   20 +
 tools/tracing/rtla/src/trace.c                                    |    8 
 tools/tracing/rtla/src/trace.h                                    |    1 
 543 files changed, 4579 insertions(+), 2310 deletions(-)

Aaro Koskinen (1):
      fbdev: omap: use threaded IRQ for LCD DMA

Ahmad Fatoum (1):
      gpio: mxc: remove dead code after switch to DT-only

Alan Stern (2):
      HID: core: Fix assumption that Resolution Multipliers must be in Logical Collections
      USB: hub: Ignore non-compliant devices with too many configs or interfaces

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Alexander Stein (1):
      regulator: core: Add missing newline character

Alexander Sverdlin (1):
      leds: lp8860: Write full EEPROM, not only half of it

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Do not use shared clk_ops for QUPs

Anandu Krishnan E (1):
      misc: fastrpc: Deregister device nodes properly in error scenarios

Anastasia Belova (1):
      clk: qcom: clk-rpmh: prevent integer overflow in recalc_rate

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andrew Cooper (1):
      x86/static-call: Remove early_boot_irqs_disabled check to fix Xen PVH dom0

Andrii Nakryiko (1):
      libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing

Andy Shevchenko (2):
      ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()
      pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware

Andy Strohman (1):
      batman-adv: fix panic during interface removal

Andy Yan (6):
      drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
      drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
      drm/rockchip: vop2: Set YUV/RGB overlay mode
      drm/rockchip: vop2: set bg dly and prescan dly at vop2_post_config
      drm/rockchip: vop2: Fix the windows switch between different layers
      drm/rockchip: vop2: Check linear format for Cluster windows on rk3566/8

Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Anshuman Khandual (1):
      arm64/mm: Ensure adequate HUGE_MAX_HSTATE

Antoine Tenart (1):
      net: avoid race between device unregistration and ethnl ops

Antonio Borneo (1):
      pinctrl: stm32: fix array read out of bound

Ard Biesheuvel (1):
      efi: Avoid cold plugged memory for placing the kernel

Armin Wolf (1):
      platform/x86: acer-wmi: Ignore AC events

Arnaud Pouliquen (1):
      remoteproc: core: Fix ida_free call while not allocated

Arnd Bergmann (1):
      media: cxd2841er: fix 64-bit division on gcc-9

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

Aubrey Li (1):
      ACPI: PRM: Remove unnecessary strict handler address checks

Ba Jing (1):
      ktest.pl: Remove unused declarations in run_bisect_test function

Balaji Pothunoori (1):
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Bao D. Nguyen (1):
      scsi: ufs: core: Fix the HIGH/LOW_TEMP Bit Definitions

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Bartosz Golaszewski (3):
      crypto: qce - fix goto jump in error path
      crypto: qce - unregister previously registered algos in error path
      gpio: xilinx: remove excess kernel doc

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix media status report

Bo Gan (1):
      clk: analogbits: Fix incorrect calculation of vco rate delta

Borislav Petkov (1):
      APEI: GHES: Have GHES honor the panic= setting

Brad Griffis (1):
      arm64: tegra: Fix Tegra234 PCIe interrupt-map

Bryan Brattlof (2):
      arm64: dts: ti: k3-am62: Remove duplicate GICR reg
      arm64: dts: ti: k3-am62a: Remove duplicate GICR reg

Bryan O'Donoghue (1):
      arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl

Calvin Owens (1):
      pps: Fix a use-after-free

Carlos Llamas (1):
      lockdep: Fix upper limit for LOCKDEP_*_BITS configs

Catalin Marinas (1):
      mm: kmemleak: fix upper boundary check for physical address objects

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix theoretical infinite loop

Chao Yu (1):
      f2fs: fix to wait dio completion

Charles Han (2):
      ipmi: ipmb: Add check devm_kasprintf() returned value
      HID: multitouch: Add NULL check in mt_input_configured

Chen Ni (2):
      pinctrl: stm32: Add check for devm_kcalloc
      media: lmedm04: Handle errors for lme2510_int_read

Chen Ridong (3):
      padata: fix UAF in padata_reorder
      padata: add pd get/put refcnt helper
      padata: avoid UAF for reorder_work

Chen-Yu Tsai (9):
      regulator: dt-bindings: mt6315: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
      arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible property
      arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible property
      arm64: dts: mediatek: mt8195-demo: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC sub-node names
      arm64: dts: mediatek: mt8173-evb: Fix MT6397 PMIC sub-node names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop pp3300_panel voltage settings

Chenghai Huang (1):
      crypto: hisilicon/sec2 - optimize the error return process

Chengming Zhou (1):
      sched/psi: Use task->psi_flags to clear in CPU migration

Chenyuan Yang (1):
      net: davicom: fix UAF in dm9000_drv_remove

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Christian Gmeiner (1):
      drm/v3d: Stop active perfmon if it is being destroyed

Christophe Leroy (1):
      select: Fix unbalanced user_access_end()

Chuck Lever (1):
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY

Claudiu Beznea (3):
      ASoC: renesas: rz-ssi: Use only the proper amount of dividers
      serial: sh-sci: Drop __initdata macro for port_cfg
      serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use

Cody Eksal (1):
      clk: sunxi-ng: a100: enable MMC clock reparenting

Cong Wang (1):
      netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()

Cosmin Tanislav (1):
      media: mc: fix endpoint iteration

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Damien Le Moal (1):
      PCI: epf-test: Simplify DMA support checks

Dan Carpenter (6):
      rdma/cxgb4: Prevent potential integer overflow on 32bit
      media: imx-jpeg: Fix potential error pointer dereference in detach_pm()
      tipc: re-order conditions in tipc_crypto_key_rcv()
      binfmt_flat: Fix integer overflow bug on 32 bit systems
      ksmbd: fix integer overflows on 32 bit systems
      NFC: nci: Add bounds checking in nci_hci_create_pipe()

Daniel Lee (1):
      f2fs: Introduce linear search for dentries

Daniel Wagner (1):
      nvme: handle connectivity loss in nvme_set_queue_count

Daniel Xu (1):
      bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write

Daniele Ceraolo Spurio (1):
      drm/i915/guc: Debug print LRC state entries only if the context is pinned

Darrick J. Wong (2):
      xfs: report realtime block quota limits on realtime directories
      xfs: don't over-report free space or inodes in statvfs

Dave Stevenson (1):
      media: i2c: ov9282: Correct the exposure offset

David Hildenbrand (1):
      KVM: s390: vsie: fix some corner-cases when grabbing vsie pages

David Howells (3):
      afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
      afs: Fix directory format encoding struct
      afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call

David Woodhouse (2):
      x86/kexec: Allocate PGD for x86_64 transition page tables separately
      x86/i8253: Disable PIT timer 0 when not in use

Detlev Casanova (1):
      ASoC: rockchip: i2s_tdm: Re-add the set_sysclk callback

Devarsh Thakkar (1):
      drm/tidss: Clear the interrupt status for interrupts being disabled

Dheeraj Reddy Jonnalagadda (1):
      net: fec: implement TSO descriptor cleanup

Dmitry Antipov (4):
      wifi: rtlwifi: remove unused timer and related code
      wifi: rtlwifi: remove unused dualmac control leftovers
      wifi: cfg80211: adjust allocation of colocated AP data
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

Dmitry Baryshkov (8):
      drm/msm/dp: set safe_to_exit_level before printing it
      arm64: dts: qcom: msm8916: correct sleep clock frequency
      arm64: dts: qcom: msm8994: correct sleep clock frequency
      arm64: dts: qcom: sc7280: correct sleep clock frequency
      arm64: dts: qcom: sm6125: correct sleep clock frequency
      arm64: dts: qcom: sm8250: correct sleep clock frequency
      arm64: dts: qcom: sm8350: correct sleep clock frequency
      arm64: dts: qcom: sm8450: correct sleep clock frequency

Dmitry V. Levin (1):
      selftests: harness: fix printing of mismatch values in __EXPECT()

Dongwon Kim (1):
      drm/virtio: New fence for every plane update

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo C6400

Edward Adam Davis (1):
      media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Ekansh Gupta (2):
      misc: fastrpc: Fix registered buffer page address
      misc: fastrpc: Fix copy buffer page size

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Eric Biggers (1):
      crypto: qce - fix priority to be less than ARMv8 CE

Eric Dumazet (30):
      net_sched: sch_sfq: annotate data-races around q->perturb_period
      net_sched: sch_sfq: handle bigger packets
      inetpeer: remove create argument of inet_getpeer_v[46]()
      inetpeer: remove create argument of inet_getpeer()
      inetpeer: update inetpeer timestamp in inet_getpeer()
      inetpeer: do not get a refcount in inet_getpeer()
      ax25: rcu protect dev->ax25_ptr
      ipmr: do not call mr_mfc_uses_dev() for unres entries
      net: rose: fix timer races against user threads
      net: hsr: fix fill_frame_info() regression vs VLAN packets
      net: rose: lock the socket in rose_bind()
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      vrf: use RCU protection in l3mdev_l3_out()
      vxlan: check vxlan_vnigroup_init() return value
      team: better TEAM_OPTION_TYPE_STRING validation
      ipv4: add RCU protection to ip4_dst_hoplimit()
      net: add dev_net_rcu() helper
      ipv4: use RCU protection in ipv4_default_advmss()
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv4: use RCU protection in __ip_rt_update_pmtu()
      ipv4: icmp: convert to dev_net_rcu()
      flow_dissector: use RCU protection to fetch dev_net()
      ipv6: use RCU protection in ip6_default_advmss()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      ndisc: extend RCU protection in ndisc_send_skb()
      ipv6: mcast: add RCU protection to mld_newpack()

Eugen Hristev (1):
      pstore/blk: trivial typo fixes

Even Xu (1):
      HID: Wacom: Add PCI Wacom device support

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Fangzhi Zuo (1):
      drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor

Fedor Pchelkin (3):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection
      can: ctucanfd: handle skb allocation failure

Filipe Manana (3):
      btrfs: fix use-after-free when attempting to join an aborted transaction
      btrfs: avoid monopolizing a core when activating a swap file
      btrfs: fix hole expansion when writing at an offset beyond EOF

Florian Westphal (1):
      netfilter: nft_flow_offload: update tcp state flags under lock

Frank Li (1):
      i3c: master: Fix missing 'ret' assignment in set_speed()

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: fix alpha mode configuration

Gabriele Monaco (1):
      rv: Reset per-task monitors also for idle tasks

Gautham R. Shenoy (1):
      cpufreq: ACPI: Fix max-frequency computation

Geert Uytterhoeven (2):
      dt-bindings: leds: class-multicolor: Fix path to color definitions
      selftests: timers: clocksource-switch: Adapt progress to kselftest framework

Georg Gottleuber (2):
      nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
      nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

George Lander (1):
      ASoC: sun4i-spdif: Add clock multiplier settings

Greg Kroah-Hartman (1):
      Linux 6.1.129

Guangguan Wang (1):
      net/smc: fix data error when recvmsg with MSG_PEEK flag

Guixin Liu (2):
      scsi: ufs: bsg: Delete bsg_dev when setting up bsg fails
      scsi: ufs: bsg: Set bsg_queue to NULL after removal

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Hangbin Liu (2):
      netdevsim: print human readable IP address
      selftests: rtnetlink: update netdevsim ipsec output format

Hans Verkuil (1):
      gpu: drm_dp_cec: fix broken CEC adapter properties check

Hans de Goede (3):
      mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
      platform/x86: int3472: Check for adev == NULL
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet 5V

Hao-ran Zheng (1):
      btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()

Haoxiang Li (1):
      drm/komeda: Add check for komeda_get_layer_fourcc_list()

He Rongguang (1):
      cpupower: fix TSC MHz calculation

Heiko Carstens (1):
      s390/futex: Fix FUTEX_OP_ANDN implementation

Heiko Stuebner (1):
      HID: hid-sensor-hub: don't use stale platform-data on remove

Heming Zhao (1):
      ocfs2: fix incorrect CPU endianness conversion causing mount failure

Hermes Wu (5):
      drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
      drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
      drm/bridge: it6505: fix HDCP Bstatus check
      drm/bridge: it6505: fix HDCP encryption when R0 ready
      drm/bridge: it6505: fix HDCP CTS compare V matching

Hersen Wu (1):
      drm/amd/display: Add NULL pointer check for kzalloc

Hou Tao (2):
      dm-crypt: don't update io->sector after kcryptd_crypt_write_io_submit()
      dm-crypt: track tag_offset in convert_context

Hsin-Te Yuan (2):
      arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
      arm64: dts: mediatek: mt8183: willow: Support second source touchscreen

Hsin-Yi Wang (1):
      arm64: dts: mt8183: set DMIC one-wire mode on Damu

Huacai Chen (1):
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Ido Schimmel (1):
      net: sched: Fix truncation of offloaded action statistics

Ilan Peer (2):
      wifi: mac80211: Fix common size calculation for ML element
      wifi: cfg80211: Handle specific BSSID in 6GHz scanning

Illia Ostapyshyn (1):
      Input: allocate keycode for phone linking

Ivan Kokshaysky (3):
      alpha: make stack 16-byte aligned (most cases)
      alpha: align stack for page fault and user unaligned trap handlers
      alpha: replace hardcoded stack offsets with autogenerated ones

Ivan Stepchenko (2):
      drm/amdgpu: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table
      mtd: onenand: Fix uninitialized retlen in do_otp_read()

Jacob Moroni (1):
      net: atlantic: fix warning during hot unplug

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma

Jakub Kicinski (1):
      net: netdevsim: try to close UDP port harness races

Jamal Hadi Salim (1):
      net: sched: Disallow replacing of child qdisc from one parent to another

Jann Horn (3):
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments
      partitions: mac: fix handling of bogus partition table

Jason-JH.Lin (1):
      dts: arm64: mediatek: mt8195: Remove MT8183 compatible for OVL

Javier Carrasco (3):
      soc: atmel: fix device_node release in atmel_soc_device_init()
      iio: light: as73211: fix channel handling in only-color triggered buffer
      pinctrl: samsung: fix fwnode refcount cleanup if platform_get_irq_optional() fails

Jennifer Berringer (1):
      nvmem: core: improve range check for nvmem_cell_write()

Jens Axboe (2):
      block: don't revert iter for -EIOCBQUEUED
      io_uring/net: don't retry connect operation on EPOLLERR

Jian Shen (1):
      net: hns3: fix oops when unload drivers paralleling

Jianbo Liu (1):
      xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO

Jiang Liu (1):
      drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Jiaqing Zhao (3):
      can: ems_pci: move ASIX AX99100 ids to pci_ids.h
      serial: 8250_pci: add support for ASIX AX99100
      parport_pc: add support for ASIX AX99100

Jiasheng Jiang (4):
      media: marvell: Add check for clk_enable()
      media: mipi-csis: Add check for clk_enable()
      media: camif-core: Add check for clk_enable()
      regmap-irq: Add missing kfree()

Jinliang Zheng (1):
      fs: fix proc_handler for sysctl_nr_open

Jiri Kosina (1):
      HID: multitouch: fix support for Goodix PID 0x01e9

Jiri Pirko (1):
      net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()

Joe Hattori (12):
      ACPI: fan: cleanup resources in the error path of .probe()
      leds: netxbig: Fix an OF node reference leak in netxbig_leds_get_of_pdata()
      regulator: of: Implement the unwind path of of_regulator_match()
      OPP: OF: Fix an OF node leak in _opp_add_static_v2()
      crypto: ixp4xx - fix OF node reference leaks in init_ixp_crypto()
      memory: tegra20-emc: fix an OF node reference bug in tegra_emc_find_node_by_ram_code()
      fbdev: omapfb: Fix an OF node leak in dss_of_port_get_parent_device()
      mtd: hyperbus: hbmc-am654: fix an OF node reference leak
      staging: media: imx: fix OF node leak in imx_media_add_of_subdevs()
      dmaengine: ti: edma: fix OF node reference leaks in edma_driver
      usb: dwc3-am62: Fix an OF node leak in phy_syscon_pll_refclk()
      usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

Johannes Berg (1):
      wifi: mac80211: prohibit deactivating all links

John Keeping (2):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      serial: 8250: Fix fifo underflow on flush

John Ogness (2):
      serial: 8250: Adjust the timeout for FIFO mode
      kdb: Do not assume write() callback available

Jos Wang (1):
      usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout to PD_T_SENDER_RESPONSE

Josef Bacik (1):
      btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling

Juergen Gross (4):
      x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
      x86/xen: add FRAME_END to xen_hypercall_hvm()
      xen/swiotlb: relax alignment requirements
      x86/xen: allow larger contiguous memory regions in PV guests

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone distorted sound on Acer Aspire A115-31 laptop

Kaixin Wang (1):
      i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition

Karol Przybylski (1):
      HID: hid-thrustmaster: Fix warning in thrustmaster_probe by adding endpoint check

Kees Cook (1):
      exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case

Keisuke Nishimura (1):
      nvme: Add error check for xa_store in nvme_get_effects_log

Kexy Biscuit (1):
      MIPS: Loongson64: remove ROM Size unit in boardinfo

King Dix (1):
      PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

Koichiro Den (2):
      Revert "btrfs: avoid monopolizing a core when activating a swap file"
      selftests: gpio: gpio-sim: Fix missing chip disablements

Konrad Dybcio (4):
      arm64: dts: qcom: msm8996: Fix up USB3 interrupts
      arm64: dts: qcom: msm8994: Describe USB interrupts
      arm64: dts: qcom: sc7180-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8280xp: Fix up remoteproc register space sizes

Kory Maincent (1):
      net: sh_eth: Fix missing rtnl lock in suspend/resume path

Krzysztof Karas (1):
      drm/i915/selftests: avoid using uninitialized context

Krzysztof Kozlowski (10):
      mfd: syscon: Use scoped variables with memory allocators to simplify error paths
      arm64: dts: qcom: sc7180-idp: use just "port" in panel
      arm64: dts: qcom: sc7180-trogdor-quackingstick: use just "port" in panel
      arm64: dts: qcom: sc7180-trogdor-wormdingler: use just "port" in panel
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      soc: qcom: smem_state: fix missing of_node_put in error path
      can: c_can: fix unbalanced runtime PM disable in error path

Kuan-Wei Chiu (2):
      printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      ALSA: hda: Fix headset detection failure due to unstable sort

Kuninori Morimoto (1):
      ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback

Kyle Tso (2):
      usb: dwc3: core: Defer the probe until USB power supply ready
      usb: typec: tcpci: Prevent Sink disconnection before vPpsShutdown in SPR PPS

Laurent Pinchart (1):
      media: uvcvideo: Fix double free in error path

Laurentiu Palcu (1):
      staging: media: max96712: fix kernel oops when removing module

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Lenny Szubowicz (1):
      tg3: Disable tg3 PCIe AER on system reboot

Leo Stone (1):
      safesetid: check size of policy writes

Leon Romanovsky (1):
      RDMA/mlx4: Avoid false error about access to uninitialized gids array

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

Li Zetao (1):
      neighbour: delete redundant judgment statements

Liam R. Howlett (1):
      maple_tree: fix static analyser cppcheck issue

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for iBasso DC07 Pro

Lijo Lazar (1):
      drm/amd/pm: Mark MM activity as unsupported

Lin Yujun (1):
      hexagon: Fix unbalanced spinlock in die()

Linus Walleij (1):
      gpio: xilinx: Convert to immutable irq_chip

Liu Jian (1):
      net: let net.core.dev_weight always be non-zero

Liu Ye (1):
      selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()

Long Li (1):
      scsi: storvsc: Set correct data length for sending SCSI command without payload

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Luca Weiss (6):
      arm64: dts: qcom: sm7225-fairphone-fp4: Drop extra qcom,msm-id value
      arm64: dts: qcom: pm6150l: add temp sensor and thermal zone config
      media: i2c: imx412: Add missing newline to prints
      clk: qcom: gcc-sm6350: Add missing parent_map for two clocks
      clk: qcom: dispcc-sm6350: Add missing parent_map for a clock
      nvmem: qcom-spmi-sdam: Set size in struct nvmem_config

Luo Yifan (1):
      tools/bootconfig: Fix the wrong format specifier

Ma Ke (2):
      pinctrl: stm32: check devm_kasprintf() returned value
      RDMA/srp: Fix error handling in srp_add_port

Maarten Lankhorst (1):
      drm/modeset: Handle tiled displays in pan_display_atomic.

Maciej S. Szmigiero (1):
      net: wwan: iosm: Fix hibernation by re-binding the driver around it

Mahdi Arghavani (1):
      tcp_cubic: fix incorrect HyStart round start detection

Maher Sanalla (1):
      net/mlxfw: Drop hard coded max FW flash image size

Maksym Planeta (1):
      Grab mm lock before grabbing pt lock

Manivannan Sadhasivam (3):
      OPP: Introduce dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs
      OPP: Introduce dev_pm_opp_get_freq_indexed() API
      PCI: endpoint: pci-epf-test: Fix check for DMA MEMCPY test

Marcel Hamer (1):
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Marco Elver (1):
      kfence: skip __GFP_THISNODE allocations on NUMA systems

Marco Leogrande (1):
      tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind

Marek Vasut (3):
      clk: imx8mp: Fix clkout1/2 support
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix LP5562 LED1 reg property
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mario Limonciello (2):
      ASoC: acp: Support microphone from Lenovo Go S
      gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Mark Tomlinson (1):
      gpio: pca953x: Improve interrupt support

Masahiro Yamada (7):
      genksyms: fix memory leak when the same symbol is added from source
      genksyms: fix memory leak when the same symbol is read from *.symref file
      kconfig: fix file name in warnings when loading KCONFIG_DEFCONFIG_LIST
      kconfig: require a space after '#' for valid input
      kconfig: remove unused code for S_DEF_AUTO in conf_read_simple()
      kconfig: deduplicate code in conf_read_simple()
      kconfig: fix memory leak in sym_warn_unmet_dep()

Mateusz Jończyk (1):
      mips/math-emu: fix emulation of the prefx instruction

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Matthew Wilcox (Oracle) (1):
      ocfs2: handle a symlink read error correctly

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: -f: no reconnect
      mptcp: pm: only set fullmesh for subflow endp

Matti Vaittinen (1):
      dt-bindings: mfd: bd71815: Fix rsense and typos

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Meetakshi Setiya (1):
      smb: client: change lease epoch type from unsigned int to __u16

Mehdi Djait (1):
      media: ccs: Fix cleanup order in ccs_probe()

Michael Ellerman (1):
      selftests/powerpc: Fix argument order to timer_sub()

Michael Guralnik (1):
      RDMA/mlx5: Fix indirect mkey ODP page count

Michael Lo (1):
      wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.

Michael Margolin (1):
      RDMA/efa: Reset device on probe failure

Michal Pecio (1):
      usb: xhci: Fix NULL pointer dereference on certain command aborts

Michal Simek (1):
      rtc: zynqmp: Fix optional clock name property

Michal Swiatkowski (1):
      iavf: allow changing VLAN state without calling PF

Mickaël Salaün (2):
      landlock: Handle weird files
      selftests/landlock: Fix error message

Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

Mike Snitzer (1):
      pnfs/flexfiles: retry getting layout segment for reads

Milos Reljin (1):
      net: phy: c45-tjaxx: add delay between MDIO write and read in soft_reset

Mingwei Zheng (4):
      spi: zynq-qspi: Add check for clk_enable()
      pwm: stm32-lp: Add check for clk_enable()
      pwm: stm32: Add check for clk_enable()
      pinctrl: stm32: Add check for clk_enable()

Miri Korenblit (1):
      wifi: iwlwifi: avoid memory leak

Mohamed Khalfella (1):
      PCI: endpoint: pci-epf-test: Set dma_chan_rx pointer to NULL on error

Muhammad Adeel (1):
      cgroup: Remove steal time from usage_usec

Murad Masimov (1):
      ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Nam Cao (1):
      fs/proc: do_task_stat: Fix ESP not readable during coredump

Narayana Murty N (1):
      powerpc/pseries/eeh: Fix get PE state translation

Nathan Chancellor (5):
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15
      kbuild: Move -Wenum-enum-conversion to W=2
      x86/boot: Use '-std=gnu11' to fix build with GCC 15
      arm64: Handle .ARM.attributes section in linker scripts

Neil Armstrong (6):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized
      dt-bindings: mmc: controller: clarify the address-cells description
      arm64: dts: qcom: sc7180-trogdor-quackingstick: add missing avee-supply
      arm64: dts: qcom: sc7180-trogdor-pompom: rename 5v-choke thermal zone
      arm64: dts: qcom: sm8150-microsoft-surface-duo: fix typos in da7280 properties

Nick Chan (1):
      irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured so

Nicolas Ferre (1):
      ARM: at91: pm: change BU Power Switch to automatic mode

Nikita Travkin (2):
      arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
      arm64: dts: qcom: sc7180: Drop redundant disable in mdp

Nikita Zhandarovich (3):
      net/rose: prevent integer overflows in rose_setsockopt()
      net: usb: rtl8150: enable basic endpoint checking
      nilfs2: fix possible int overflows in nilfs_fiemap()

Niklas Cassel (1):
      ata: libata-sff: Ensure that we cannot write outside the allocated buffer

Octavian Purdila (2):
      net_sched: sch_sfq: don't allow 1 packet limit
      team: prevent adding a device which is already a team device lower

Oleksij Rempel (1):
      rtc: pcf85063: fix potential OOB write in PCF85063 NVMEM read

Olga Kornievskaia (2):
      NFSv4.2: fix COPY_NOTIFY xdr buf size calculation
      NFSv4.2: mark OFFLOAD_CANCEL MOVEABLE

Oliver Neukum (1):
      media: rc: iguanair: handle timeouts

Pablo Neira Ayuso (1):
      netfilter: nf_tables: reject mismatching sum of field_len with set key length

Paolo Abeni (3):
      mptcp: consolidate suboption status
      mptcp: handle fastopen disconnect correctly
      mptcp: prevent excessive coalescing on receive

Paolo Bonzini (1):
      KVM: e500: always restore irqs

Parth Pancholi (1):
      kbuild: switch from lz4c to lz4 for compression

Paul Fertser (3):
      net/ncsi: fix locking in Get MAC Address handling
      net/ncsi: wait for the last response to Deselect Package before configuring channel
      net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling

Paul Menzel (1):
      scsi: mpt3sas: Set ioc->manu_pg11.EEDPTagMode directly to 1

Paulo Alcantara (1):
      smb: client: fix oops due to unset link speed

Pavel Begunkov (3):
      io_uring: fix multishots with selected buffers
      io_uring: fix io_req_prep_async with provided buffers
      io_uring/rw: commit provided buffer state on async

Pekka Pessi (1):
      mailbox: tegra-hsp: Clear mailbox before using message

Peter Chiu (1):
      wifi: mt76: mt7915: fix register mapping

Peter Delevoryas (1):
      net/ncsi: Add NC-SI 1.2 Get MC MAC Address command

Peter Griffin (2):
      mfd: syscon: Remove extern from function prototypes
      mfd: syscon: Add of_syscon_register_regmap() API

Peter Zijlstra (1):
      sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat

Petr Tesarik (1):
      xen: remove a confusing comment on auto-translated guest I/O

Prasad Pandit (1):
      firmware: iscsi_ibft: fix ISCSI_IBFT Kconfig entry

Puranjay Mohan (2):
      bpf: Send signals asynchronously if !preemptible
      nvme: fix metadata handling in nvme-passthrough

Qasim Ijaz (1):
      iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()

Qu Wenruo (1):
      btrfs: output the reason for open_ctree() failure

Quentin Monnet (1):
      libbpf: Fix segfault due to libelf functions not setting errno

Quinn Tran (1):
      scsi: qla2xxx: Move FCE Trace buffer allocation to user control

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Rafał Miłecki (2):
      ARM: dts: mediatek: mt7623: fix IR nodename
      bgmac: reduce max frame size to support just MTU 1500

Rakesh Babu Saladi (1):
      PCI: switchtec: Add Microchip PCI100X device IDs

Ramesh Thomas (1):
      vfio/pci: Enable iowrite64 and ioread64 for vfio pci

Randolph Ha (1):
      i2c: Force ELAN06FA touchpad I2C bus freq to 100KHz

Randy Dunlap (2):
      partitions: ldm: remove the initial kernel-doc notation
      efi: sysfb_efi: fix W=1 warnings when EFI is not set

Ricardo B. Marliere (1):
      ktest.pl: Check kernelrelease return in get_version

Ricardo Ribalda (3):
      media: uvcvideo: Propagate buf->error to userspace
      media: uvcvideo: Fix event flags in uvc_ctrl_send_events
      media: uvcvideo: Remove redundant NULL assignment

Rik van Riel (1):
      x86/mm/tlb: Only trim the mm_cpumask once a second

Rob Herring (Arm) (1):
      mfd: syscon: Fix race in device_node_get_regmap()

Robin Murphy (1):
      iommu/arm-smmu-v3: Clean up more on probe failure

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()

Romain Naour (1):
      ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus

Ryusuke Konishi (3):
      nilfs2: do not output warnings when clearing dirty buffers
      nilfs2: do not force clear folio if buffer is referenced
      nilfs2: protect access to buffers with no active references

Sakari Ailus (2):
      media: ccs: Clean up parsed CCS static data on parse failure
      media: ccs: Fix CCS static data parsing for large block sizes

Sam Bobrowicz (1):
      media: ov5640: fix get_light_freq on auto

Satya Priya Kakitapalli (1):
      clk: qcom: gcc-mdm9607: Fix cmd_rcgr offset for blsp1_uart6 rcg

Sean Anderson (2):
      gpio: xilinx: Convert gpio_lock to raw spinlock
      tty: xilinx_uartps: split sysrq handling

Sean Christopherson (7):
      KVM: PPC: e500: Mark "struct page" dirty in kvmppc_e500_shadow_map()
      KVM: PPC: e500: Mark "struct page" pfn accessed before dropping mmu_lock
      KVM: PPC: e500: Use __kvm_faultin_pfn() to handle page faults
      KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC isn't in-kernel
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Sean Rhodes (1):
      drivers/card_reader/rtsx_usb: Restore interrupt based detection

Sebastian Andrzej Siewior (1):
      module: Extend the preempt disabled section in dereference_symbol_descriptor().

Sebastian Wiese-Wagner (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14s-fq1xxx

Selvarasu Ganesan (1):
      usb: dwc3: Fix timeout issue during controller enter/exit from halt state

Sergey Senozhatsky (2):
      kconfig: add warn-unknown-symbols sanity check
      kconfig: WERROR unmet symbol dependency

Shakeel Butt (1):
      cgroup: fix race between fork and cgroup.kill

Shawn Lin (1):
      mmc: core: Respect quirk_max_rate for non-UHS SDIO card

Shigeru Yoshida (1):
      vxlan: Fix uninit-value in vxlan_vnifilter_dump()

Sourabh Jain (1):
      powerpc/book3s64/hugetlb: Fix disabling hugetlb when fadump is active

Stas Sergeev (1):
      tun: fix group permission check

Stefan Dösinger (1):
      wifi: brcmfmac: Check the return value of of_property_read_string_index()

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Stephan Gerhold (1):
      soc: qcom: socinfo: Avoid out of bounds read of serial number

Su Yue (2):
      ocfs2: mark dquot as inactive if failed to start trans while releasing dquot
      ocfs2: check dir i_size in ocfs2_find_entry

Sui Jingfeng (1):
      drm/etnaviv: Fix page property being used for non writecombine buffers

Suleiman Souhlal (1):
      sched: Don't try to catch up excess steal time.

Sultan Alsawaf (unemployed) (1):
      cpufreq: schedutil: Fix superfluous updates caused by need_freq_update

Sumit Gupta (2):
      arm64: tegra: Disable Tegra234 sce-fabric node
      arm64: tegra: Fix typo in Tegra234 dce-fabric compatible

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

Takashi Iwai (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P

Tetsuo Handa (1):
      tomoyo: don't emit warning in tomoyo_write_control()

Thadeu Lima de Souza Cascardo (10):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory
      Revert "media: uvcvideo: Require entities to have a non-zero unique ID"

Thinh Nguyen (6):
      usb: gadget: f_tcm: Fix Get/SetInterface return value
      usb: gadget: f_tcm: Don't free command immediately
      usb: gadget: f_tcm: Translate error to sense
      usb: gadget: f_tcm: Decrement command ref count on cleanup
      usb: gadget: f_tcm: ep_autoconfig with fullspeed endpoint
      usb: gadget: f_tcm: Don't prepare BOT write request twice

Thomas Gleixner (1):
      genirq: Make handle_enforce_irqctx() unconditionally available

Thomas Weißschuh (3):
      padata: fix sysfs store callback check
      ptp: Properly handle compat ioctls
      ptp: Ensure info->enable callback is always set

Thomas Zimmermann (2):
      m68k: vga: Fix I/O defines
      drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()

Tim Huang (1):
      drm/amd/display: fix double free issue during amdgpu module unload

Tom Chung (1):
      Revert "drm/amd/display: Use HW lock mgr for PSR1"

Tomas Glozar (6):
      rtla/osnoise: Distinguish missing workload option
      rtla: Add trace_instance_stop
      rtla/timerlat_hist: Stop timerlat tracer on signal
      rtla/timerlat_top: Stop timerlat tracer on signal
      rtla/timerlat_hist: Abort event processing on second signal
      rtla/timerlat_top: Abort event processing on second signal

Tomi Valkeinen (1):
      drm/tidss: Fix issue in irq handling causing irq-flood issue

Tulio Fernandes (1):
      HID: hid-thrustmaster: fix stack-out-of-bounds read in usb_check_int_endpoints()

Uwe Kleine-König (2):
      mtd: hyperbus: hbmc-am654: Convert to platform remove callback returning void
      usb: chipidea/ci_hdrc_imx: Convert to platform remove callback returning void

Vadim Fedorenko (1):
      net/mlx5: use do_aux_work for PHC overflow checks

Val Packett (4):
      arm64: dts: mediatek: mt8516: fix GICv2 range
      arm64: dts: mediatek: mt8516: fix wdt irq type
      arm64: dts: mediatek: mt8516: add i2c clock-div property
      arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A

Valentin Caron (1):
      pinctrl: stm32: set default gpio line names using pin names

Ville Syrjälä (1):
      drm/i915: Drop 64bpp YUV formats from ICL+ SDR planes

Viresh Kumar (4):
      OPP: Rearrange entries in pm_opp.h
      OPP: Add dev_pm_opp_find_freq_exact_indexed()
      OPP: Reuse dev_pm_opp_get_freq_indexed()
      cpufreq: s3c64xx: Fix compilation warning

Vladimir Oltean (1):
      net: dsa: fix netdev_priv() dereference before check on non-DSA netdevice events

Vladimir Vdovin (1):
      net: ipv4: Cache pmtu for all packet paths if multipath enabled

Vladimir Zapolskiy (2):
      arm64: dts: qcom: sdm845: Fix interrupt types of camss interrupts
      arm64: dts: qcom: sm8250: Fix interrupt types of camss interrupts

Waiman Long (2):
      clocksource: Use pr_info() for "Checking clocksource synchronization" message
      clocksource: Use migrate_disable() to avoid calling get_random_u32() in atomic context

WangYuli (2):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
      MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static

Wei Yang (1):
      maple_tree: simplify split calculation

Wenkai Lin (2):
      crypto: hisilicon/sec2 - fix for aead icv error
      crypto: hisilicon/sec2 - fix for aead invalid authsize

Wentao Liang (4):
      PM: hibernate: Add error handling for syscore_suspend()
      xfs: Add error handling for xfs_reflink_cancel_cow_range
      gpio: stmpe: Check return value of stmpe_reg_read in stmpe_gpio_irq_sync_unlock
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Willem de Bruijn (2):
      hexagon: fix using plain integer as NULL pointer warning in cmpxchg
      tun: revert fix group permission check

Yan Zhai (1):
      udp: gso: do not drop small packets when PMTU reduces

Yang Erkun (1):
      block: retry call probe after request_module in blk_request_module

Yazen Ghannam (1):
      x86/amd_nb: Restrict init function to AMD-based systems

Yu Kuai (1):
      nbd: don't allow reconnect after disconnect

Yu-Chun Lin (1):
      ASoC: amd: Add ACPI dependency to fix build error

Yuanjie Yang (1):
      mmc: sdhci-msm: Correctly set the load for the regulator

Zhaoyang Huang (1):
      mm: gup: fix infinite loop within __get_longterm_locked

Zhu Yanjun (1):
      RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"

Zichen Xie (1):
      samples/landlock: Fix possible NULL dereference in parse_path()

Zijun Hu (7):
      of: reserved-memory: Do not make kmemleak ignore freed address
      PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      of: Correct child specifier used as input of the 2nd nexus node
      of: Fix of_find_node_opts_by_path() handling of alias+path+options
      of: reserved-memory: Fix using wrong number of cells to get property 'alignment'
      PCI: endpoint: Finish virtual EP removal in pci_epf_remove_vepf()

Zizhi Wo (1):
      cachefiles: Fix NULL pointer dereference in object->file

pangliyuan (1):
      ubifs: skip dumping tnc tree when zroot is null


