Return-Path: <stable+bounces-114376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE4A2D54A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76A33A6372
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE1199E80;
	Sat,  8 Feb 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BklvKKLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBF28F3;
	Sat,  8 Feb 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007312; cv=none; b=mZSTh+RDr+42fNBjbtS3HYCFzTqSUefFKRbcYwM2q0iuCCEE63kqji786GZZ487afsdGu7lSuJSXmQkZJGNfIlaRj44NKx1vQYd9CeGe6qKAtfRWRxpYHxPo9WYBAN4BN0lE+GiXItNSflLQK5MNwndqZ/DJrhRijuuBXNr+IKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007312; c=relaxed/simple;
	bh=LrL6MIUb+o+iW4nIKMF9JeBLjIE8VP3xCync0bTZnxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AhRsv99wj77MbD8+/WaADf8tkYD3pFNJNNwBWIIbV0ShA2HE24hLYCQ5EBZOYG8O5SiQKDdzioepLCkpVKbe+9mPO+tyLWjrmopebAA/+yULkL+trYfrB6NiU6gZ+m7xUYSn0FDamBj9sbs1Mqw9YesYMUEX5idMJ52JJeQkBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BklvKKLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93040C4CED6;
	Sat,  8 Feb 2025 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739007312;
	bh=LrL6MIUb+o+iW4nIKMF9JeBLjIE8VP3xCync0bTZnxM=;
	h=From:To:Cc:Subject:Date:From;
	b=BklvKKLI+zYnBjbwPEFiDgr9GNqSUbGPbzXaIktyGxwFS63Ikk8zldHF4G5f4hYuX
	 Fc00CcD3C8kz9AvQshva7OpHgyFKObBNMkvXOgR2G9kyFUE7cBnz1YZH+BPpEHOU8X
	 yhX7FexI5VF9FjVexN/hKvDNJfVTUoHB1kL3ET9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.76
Date: Sat,  8 Feb 2025 10:35:06 +0100
Message-ID: <2025020807-conform-embolism-40fd@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.76 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml |    2 
 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml      |   20 
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml         |    2 
 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml |    6 
 Makefile                                                          |    4 
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts        |   24 
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi              |    6 
 arch/arm/boot/dts/mediatek/mt7623.dtsi                            |    2 
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts           |    2 
 arch/arm/boot/dts/st/stm32mp151.dtsi                              |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi                 |   12 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi                  |   10 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi               |   10 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                   |    7 
 arch/arm/mach-at91/pm.c                                           |   31 
 arch/arm/mach-omap1/board-nokia770.c                              |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts             |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts              |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi                     |    2 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                      |   29 
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                       |   25 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts        |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts       |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi     |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi            |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                          |    3 
 arch/arm64/boot/dts/mediatek/mt8186.dtsi                          |    8 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                  |    3 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                   |    2 
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                      |    9 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                          |    5 
 arch/arm64/boot/dts/mediatek/mt8365.dtsi                          |    3 
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                          |   11 
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi                  |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                          |    2 
 arch/arm64/boot/dts/qcom/Makefile                                 |    3 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                             |   11 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                             |    9 
 arch/arm64/boot/dts/qcom/pm6150.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                             |    3 
 arch/arm64/boot/dts/qcom/qcs404.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts                          |    2 
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                          |    2 
 arch/arm64/boot/dts/qcom/qru1000-idp.dts                          |    2 
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts                         |  827 ----------
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi                        |  814 +++++++++
 arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi                 |   84 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi               |    9 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi             |    9 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi               |    7 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi        |    1 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi          |    9 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                      |    3 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                              |  387 ++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                            |    6 
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts   |  104 -
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso  |   70 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |   20 
 arch/arm64/boot/dts/qcom/sdx75.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/sm4450.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6125.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6375.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm7125.dtsi                              |   16 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                 |    2 
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts         |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                              |   30 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                              |    2 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                          |    1 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                         |    1 
 arch/hexagon/include/asm/cmpxchg.h                                |    2 
 arch/hexagon/kernel/traps.c                                       |    4 
 arch/loongarch/include/asm/hw_breakpoint.h                        |    4 
 arch/loongarch/include/asm/loongarch.h                            |   60 
 arch/loongarch/kernel/hw_breakpoint.c                             |   16 
 arch/loongarch/power/platform.c                                   |    2 
 arch/powerpc/include/asm/hugetlb.h                                |    9 
 arch/powerpc/kernel/smp.c                                         |    4 
 arch/powerpc/sysdev/xive/native.c                                 |    4 
 arch/powerpc/sysdev/xive/spapr.c                                  |    3 
 arch/riscv/kernel/vector.c                                        |    2 
 arch/s390/Makefile                                                |    2 
 arch/s390/kernel/perf_cpum_cf.c                                   |    2 
 arch/s390/kernel/perf_pai_crypto.c                                |    2 
 arch/s390/kernel/perf_pai_ext.c                                   |    2 
 arch/s390/kernel/topology.c                                       |    2 
 arch/s390/purgatory/Makefile                                      |    2 
 arch/x86/events/amd/ibs.c                                         |    2 
 arch/x86/kernel/smpboot.c                                         |   12 
 block/genhd.c                                                     |   22 
 block/partitions/ldm.h                                            |    2 
 drivers/acpi/acpica/achware.h                                     |    2 
 drivers/acpi/fan_core.c                                           |   10 
 drivers/base/class.c                                              |    9 
 drivers/block/nbd.c                                               |    1 
 drivers/bluetooth/btnxpuart.c                                     |    3 
 drivers/bus/ti-sysc.c                                             |    4 
 drivers/char/ipmi/ipmb_dev_int.c                                  |    3 
 drivers/char/ipmi/ssif_bmc.c                                      |    5 
 drivers/clk/analogbits/wrpll-cln28hpc.c                           |    2 
 drivers/clk/clk-conf.c                                            |    4 
 drivers/clk/clk-si5351.c                                          |   76 
 drivers/clk/clk.c                                                 |   14 
 drivers/clk/imx/clk-imx8mp.c                                      |    5 
 drivers/clk/qcom/common.c                                         |    4 
 drivers/clk/qcom/gcc-sdm845.c                                     |   32 
 drivers/clk/ralink/clk-mtmips.c                                   |    1 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                             |   13 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                             |    2 
 drivers/clk/sunxi/clk-simple-gates.c                              |    4 
 drivers/clk/sunxi/clk-sun8i-bus-gates.c                           |    4 
 drivers/clocksource/samsung_pwm_timer.c                           |    4 
 drivers/cpufreq/acpi-cpufreq.c                                    |   36 
 drivers/cpufreq/qcom-cpufreq-hw.c                                 |   34 
 drivers/crypto/caam/blob_gen.c                                    |    3 
 drivers/crypto/hisilicon/sec2/sec.h                               |    3 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                        |  168 --
 drivers/crypto/hisilicon/sec2/sec_crypto.h                        |   11 
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c                       |    3 
 drivers/dma/ti/edma.c                                             |    3 
 drivers/firmware/efi/sysfb_efi.c                                  |    2 
 drivers/gpio/gpio-brcmstb.c                                       |    5 
 drivers/gpio/gpio-mxc.c                                           |    3 
 drivers/gpio/gpio-pca953x.c                                       |  108 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                           |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                           |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c               |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c         |    5 
 drivers/gpu/drm/bridge/ite-it6505.c                               |    2 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                             |   16 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                             |    8 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h            |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h           |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h            |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h            |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h            |    2 
 drivers/gpu/drm/msm/dp/dp_audio.c                                 |    2 
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                   |    1 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                            |    1 
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c                   |    1 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                       |    1 
 drivers/gpu/drm/rockchip/inno_hdmi.c                              |    1 
 drivers/gpu/drm/rockchip/rk3066_hdmi.c                            |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h                       |   18 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h                       |   12 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                      |  121 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                      |   18 
 drivers/gpu/drm/rockchip/rockchip_lvds.c                          |    1 
 drivers/gpu/drm/rockchip/rockchip_rgb.c                           |    1 
 drivers/hid/hid-core.c                                            |    2 
 drivers/hid/hid-input.c                                           |   37 
 drivers/hid/hid-multitouch.c                                      |    2 
 drivers/hid/hid-thrustmaster.c                                    |    8 
 drivers/i3c/master/dw-i3c-master.c                                |   68 
 drivers/i3c/master/dw-i3c-master.h                                |    2 
 drivers/iio/adc/ti_am335x_adc.c                                   |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |    7 
 drivers/infiniband/hw/cxgb4/device.c                              |    6 
 drivers/infiniband/hw/mlx4/main.c                                 |    8 
 drivers/infiniband/hw/mlx5/odp.c                                  |   32 
 drivers/infiniband/sw/rxe/rxe.c                                   |    6 
 drivers/infiniband/sw/rxe/rxe.h                                   |    6 
 drivers/infiniband/sw/rxe/rxe_comp.c                              |    4 
 drivers/infiniband/sw/rxe/rxe_cq.c                                |    4 
 drivers/infiniband/sw/rxe/rxe_mr.c                                |   16 
 drivers/infiniband/sw/rxe/rxe_mw.c                                |    2 
 drivers/infiniband/sw/rxe/rxe_param.h                             |    2 
 drivers/infiniband/sw/rxe/rxe_pool.c                              |   11 
 drivers/infiniband/sw/rxe/rxe_qp.c                                |    8 
 drivers/infiniband/sw/rxe/rxe_resp.c                              |   12 
 drivers/infiniband/sw/rxe/rxe_task.c                              |    4 
 drivers/infiniband/sw/rxe/rxe_verbs.c                             |  221 +-
 drivers/infiniband/ulp/srp/ib_srp.c                               |    1 
 drivers/irqchip/irq-atmel-aic-common.c                            |    4 
 drivers/irqchip/irq-pic32-evic.c                                  |    4 
 drivers/leds/leds-cht-wcove.c                                     |    6 
 drivers/leds/leds-netxbig.c                                       |    1 
 drivers/media/i2c/imx290.c                                        |    3 
 drivers/media/i2c/imx412.c                                        |   42 
 drivers/media/i2c/ov9282.c                                        |    2 
 drivers/media/platform/marvell/mcam-core.c                        |    7 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                    |    7 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c              |    3 
 drivers/media/platform/samsung/exynos4-is/mipi-csis.c             |   10 
 drivers/media/platform/samsung/s3c-camif/camif-core.c             |   13 
 drivers/media/rc/iguanair.c                                       |    4 
 drivers/media/usb/dvb-usb-v2/af9035.c                             |   18 
 drivers/media/usb/dvb-usb-v2/lmedm04.c                            |   12 
 drivers/media/usb/uvc/uvc_queue.c                                 |    3 
 drivers/media/usb/uvc/uvc_status.c                                |    1 
 drivers/memory/tegra/tegra20-emc.c                                |    8 
 drivers/mfd/syscon.c                                              |   81 
 drivers/mfd/ti_am335x_tscadc.c                                    |    4 
 drivers/misc/cardreader/rtsx_usb.c                                |   15 
 drivers/mtd/hyperbus/hbmc-am654.c                                 |   25 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                          |    5 
 drivers/net/ethernet/broadcom/bgmac.h                             |    3 
 drivers/net/ethernet/davicom/dm9000.c                             |    3 
 drivers/net/ethernet/freescale/fec_main.c                         |   31 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                       |   15 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                       |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                       |   19 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c               |   10 
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c                   |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                 |    8 
 drivers/net/ethernet/renesas/sh_eth.c                             |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |   30 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |    2 
 drivers/net/netdevsim/netdevsim.h                                 |    1 
 drivers/net/netdevsim/udp_tunnels.c                               |   23 
 drivers/net/team/team.c                                           |    7 
 drivers/net/usb/rtl8150.c                                         |   22 
 drivers/net/vxlan/vxlan_vnifilter.c                               |    5 
 drivers/net/wireless/ath/ath11k/dp_rx.c                           |    1 
 drivers/net/wireless/ath/ath11k/hal_rx.c                          |    3 
 drivers/net/wireless/ath/ath12k/mac.c                             |    6 
 drivers/net/wireless/ath/wcn36xx/main.c                           |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h           |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |   10 
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |    1 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |   11 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |   32 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   15 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |    8 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                  |   15 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                  |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   |   47 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                  |    2 
 drivers/net/wireless/mediatek/mt76/usb.c                          |    4 
 drivers/net/wireless/realtek/rtlwifi/base.c                       |   13 
 drivers/net/wireless/realtek/rtlwifi/base.h                       |    1 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   61 
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c               |    7 
 drivers/net/wireless/realtek/rtlwifi/usb.c                        |   12 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                       |   12 
 drivers/net/wireless/ti/wlcore/main.c                             |   10 
 drivers/nvme/host/core.c                                          |   34 
 drivers/of/of_reserved_mem.c                                      |    3 
 drivers/opp/core.c                                                |   57 
 drivers/opp/of.c                                                  |    4 
 drivers/pci/controller/dwc/pci-imx6.c                             |  139 -
 drivers/pci/controller/pcie-rcar-ep.c                             |    2 
 drivers/pci/endpoint/functions/pci-epf-test.c                     |    6 
 drivers/pci/endpoint/pci-epc-core.c                               |    2 
 drivers/pinctrl/nxp/pinctrl-s32cc.c                               |    4 
 drivers/pinctrl/pinctrl-amd.c                                     |   27 
 drivers/pinctrl/pinctrl-amd.h                                     |    7 
 drivers/pinctrl/pinctrl-k210.c                                    |    4 
 drivers/pinctrl/stm32/pinctrl-stm32.c                             |   76 
 drivers/pps/clients/pps-gpio.c                                    |    4 
 drivers/pps/clients/pps-ktimer.c                                  |    4 
 drivers/pps/clients/pps-ldisc.c                                   |    6 
 drivers/pps/clients/pps_parport.c                                 |    4 
 drivers/pps/kapi.c                                                |   10 
 drivers/pps/kc.c                                                  |   10 
 drivers/pps/pps.c                                                 |  127 -
 drivers/ptp/ptp_chardev.c                                         |    4 
 drivers/ptp/ptp_ocp.c                                             |    2 
 drivers/pwm/pwm-samsung.c                                         |    4 
 drivers/pwm/pwm-stm32-lp.c                                        |    8 
 drivers/pwm/pwm-stm32.c                                           |    7 
 drivers/regulator/core.c                                          |    2 
 drivers/regulator/of_regulator.c                                  |   14 
 drivers/remoteproc/remoteproc_core.c                              |   14 
 drivers/rtc/rtc-loongson.c                                        |   13 
 drivers/rtc/rtc-pcf85063.c                                        |   11 
 drivers/scsi/mpt3sas/mpt3sas_base.c                               |    3 
 drivers/soc/atmel/soc.c                                           |    2 
 drivers/spi/spi-omap2-mcspi.c                                     |   11 
 drivers/spi/spi-zynq-qspi.c                                       |   13 
 drivers/staging/media/imx/imx-media-of.c                          |    8 
 drivers/staging/media/max96712/max96712.c                         |    4 
 drivers/tty/serial/8250/8250_port.c                               |   32 
 drivers/tty/serial/sc16is7xx.c                                    |   34 
 drivers/tty/sysrq.c                                               |    4 
 drivers/ufs/core/ufs_bsg.c                                        |    1 
 drivers/usb/dwc3/core.c                                           |   30 
 drivers/usb/dwc3/dwc3-am62.c                                      |    1 
 drivers/usb/gadget/function/f_tcm.c                               |   14 
 drivers/usb/host/xhci-ring.c                                      |    3 
 drivers/usb/misc/usb251xb.c                                       |    4 
 drivers/usb/typec/tcpm/tcpci.c                                    |   13 
 drivers/usb/typec/tcpm/tcpm.c                                     |   10 
 drivers/vfio/iova_bitmap.c                                        |    2 
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c                     |    1 
 drivers/watchdog/rti_wdt.c                                        |    1 
 fs/afs/dir.c                                                      |    7 
 fs/afs/internal.h                                                 |    9 
 fs/afs/rxrpc.c                                                    |   12 
 fs/afs/xdr_fs.h                                                   |    2 
 fs/afs/yfsclient.c                                                |    5 
 fs/btrfs/super.c                                                  |    2 
 fs/buffer.c                                                       |   24 
 fs/dlm/lowcomms.c                                                 |    3 
 fs/f2fs/dir.c                                                     |   53 
 fs/f2fs/f2fs.h                                                    |    6 
 fs/f2fs/inline.c                                                  |    5 
 fs/file_table.c                                                   |    2 
 fs/hostfs/hostfs_kern.c                                           |  157 +
 fs/nfs/nfs42proc.c                                                |    2 
 fs/nfs/nfs42xdr.c                                                 |    2 
 fs/nfsd/nfs4callback.c                                            |    1 
 fs/nilfs2/segment.c                                               |   11 
 fs/ocfs2/quota_global.c                                           |    5 
 fs/pstore/blk.c                                                   |    4 
 fs/select.c                                                       |    4 
 fs/smb/client/cifsacl.c                                           |   25 
 fs/smb/client/cifsproto.h                                         |    2 
 fs/smb/client/cifssmb.c                                           |    4 
 fs/smb/client/readdir.c                                           |    2 
 fs/smb/client/reparse.c                                           |   22 
 fs/smb/client/smb2ops.c                                           |    3 
 fs/ubifs/debug.c                                                  |   22 
 include/acpi/acpixf.h                                             |    1 
 include/dt-bindings/clock/sun50i-a64-ccu.h                        |    2 
 include/linux/buffer_head.h                                       |    4 
 include/linux/hid.h                                               |    1 
 include/linux/ieee80211.h                                         |   11 
 include/linux/kallsyms.h                                          |    2 
 include/linux/mfd/syscon.h                                        |   33 
 include/linux/mroute_base.h                                       |    6 
 include/linux/netdevice.h                                         |    2 
 include/linux/of.h                                                |   15 
 include/linux/perf_event.h                                        |    6 
 include/linux/platform_data/pca953x.h                             |   13 
 include/linux/platform_data/si5351.h                              |    2 
 include/linux/pps_kernel.h                                        |    3 
 include/linux/sched.h                                             |    1 
 include/linux/usb/tcpm.h                                          |    3 
 include/net/ax25.h                                                |   10 
 include/net/inetpeer.h                                            |   12 
 include/net/netfilter/nf_tables.h                                 |    8 
 include/net/xfrm.h                                                |   16 
 include/trace/events/afs.h                                        |    2 
 include/trace/events/rxrpc.h                                      |   25 
 io_uring/uring_cmd.c                                              |    2 
 kernel/bpf/bpf_local_storage.c                                    |    8 
 kernel/events/core.c                                              |   35 
 kernel/irq/internals.h                                            |    9 
 kernel/padata.c                                                   |   45 
 kernel/power/hibernate.c                                          |    7 
 kernel/sched/cpufreq_schedutil.c                                  |    4 
 kernel/sched/fair.c                                               |   19 
 kernel/sched/topology.c                                           |    8 
 kernel/trace/bpf_trace.c                                          |   13 
 net/ax25/af_ax25.c                                                |   12 
 net/ax25/ax25_dev.c                                               |    4 
 net/ax25/ax25_ip.c                                                |    3 
 net/ax25/ax25_out.c                                               |   22 
 net/ax25/ax25_route.c                                             |    2 
 net/core/dev.c                                                    |    4 
 net/core/filter.c                                                 |    2 
 net/core/sysctl_net_core.c                                        |    5 
 net/ethtool/netlink.c                                             |    2 
 net/hsr/hsr_forward.c                                             |    7 
 net/ipv4/icmp.c                                                   |    9 
 net/ipv4/inetpeer.c                                               |   31 
 net/ipv4/ip_fragment.c                                            |   15 
 net/ipv4/ipmr.c                                                   |   28 
 net/ipv4/ipmr_base.c                                              |    9 
 net/ipv4/route.c                                                  |   17 
 net/ipv4/tcp_cubic.c                                              |    8 
 net/ipv4/tcp_output.c                                             |    9 
 net/ipv6/icmp.c                                                   |    6 
 net/ipv6/ip6_output.c                                             |    6 
 net/ipv6/ip6mr.c                                                  |   28 
 net/ipv6/ndisc.c                                                  |    8 
 net/mac80211/debugfs_netdev.c                                     |    2 
 net/mac80211/driver-ops.h                                         |    3 
 net/mac80211/rx.c                                                 |    1 
 net/mptcp/options.c                                               |   13 
 net/mptcp/protocol.c                                              |    4 
 net/mptcp/protocol.h                                              |   30 
 net/netfilter/nf_tables_api.c                                     |   57 
 net/netfilter/nft_flow_offload.c                                  |   16 
 net/netfilter/nft_set_pipapo.c                                    |    7 
 net/netfilter/nft_set_rbtree.c                                    |  178 +-
 net/rose/af_rose.c                                                |   16 
 net/rose/rose_timer.c                                             |   15 
 net/rxrpc/conn_event.c                                            |   12 
 net/sched/sch_api.c                                               |    4 
 net/sched/sch_sfq.c                                               |   56 
 net/smc/af_smc.c                                                  |    2 
 net/smc/smc_rx.c                                                  |   37 
 net/smc/smc_rx.h                                                  |    8 
 net/sunrpc/svcsock.c                                              |   12 
 net/vmw_vsock/af_vsock.c                                          |    5 
 net/wireless/scan.c                                               |   35 
 net/xfrm/xfrm_replay.c                                            |   10 
 samples/landlock/sandboxer.c                                      |    7 
 scripts/Makefile.lib                                              |    4 
 scripts/genksyms/genksyms.c                                       |   11 
 scripts/genksyms/genksyms.h                                       |    2 
 scripts/genksyms/parse.y                                          |   18 
 scripts/kconfig/conf.c                                            |    6 
 scripts/kconfig/confdata.c                                        |  115 -
 scripts/kconfig/lkc_proto.h                                       |    2 
 scripts/kconfig/symbol.c                                          |   10 
 security/landlock/fs.c                                            |   11 
 sound/core/seq/Kconfig                                            |    5 
 sound/pci/hda/patch_realtek.c                                     |    1 
 sound/soc/codecs/arizona.c                                        |   12 
 sound/soc/intel/avs/apl.c                                         |   53 
 sound/soc/intel/avs/avs.h                                         |   40 
 sound/soc/intel/avs/core.c                                        |   51 
 sound/soc/intel/avs/ipc.c                                         |   36 
 sound/soc/intel/avs/loader.c                                      |    2 
 sound/soc/intel/avs/messages.h                                    |   10 
 sound/soc/intel/avs/registers.h                                   |    6 
 sound/soc/intel/avs/skl.c                                         |   30 
 sound/soc/rockchip/rockchip_i2s_tdm.c                             |   31 
 sound/soc/sh/rz-ssi.c                                             |    3 
 sound/soc/sunxi/sun4i-spdif.c                                     |    7 
 sound/usb/quirks.c                                                |    2 
 tools/bootconfig/main.c                                           |    4 
 tools/lib/bpf/linker.c                                            |   22 
 tools/lib/bpf/usdt.c                                              |    2 
 tools/perf/builtin-lock.c                                         |   66 
 tools/perf/builtin-report.c                                       |    2 
 tools/perf/builtin-top.c                                          |    2 
 tools/perf/builtin-trace.c                                        |    6 
 tools/perf/util/bpf-event.c                                       |   10 
 tools/perf/util/env.c                                             |   13 
 tools/perf/util/env.h                                             |    4 
 tools/perf/util/expr.c                                            |    5 
 tools/perf/util/header.c                                          |    8 
 tools/perf/util/machine.c                                         |    2 
 tools/perf/util/namespaces.c                                      |    7 
 tools/perf/util/namespaces.h                                      |    3 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c           |   15 
 tools/testing/ktest/ktest.pl                                      |    7 
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c           |    4 
 tools/testing/selftests/bpf/progs/test_fill_link_info.c           |   13 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                     |    1 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh   |   16 
 tools/testing/selftests/kselftest_harness.h                       |   24 
 tools/testing/selftests/landlock/fs_test.c                        |    3 
 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c         |    2 
 tools/testing/selftests/rseq/rseq.c                               |   32 
 tools/testing/selftests/rseq/rseq.h                               |    9 
 tools/testing/selftests/timers/clocksource-switch.c               |    6 
 455 files changed, 4558 insertions(+), 3437 deletions(-)

Aaro Koskinen (1):
      ARM: omap1: Fix up the Retu IRQ on Nokia 770

Ahmad Fatoum (1):
      gpio: mxc: remove dead code after switch to DT-only

Akhil R (1):
      arm64: tegra: Fix DMA ID for SPI2

Al Viro (1):
      hostfs: fix string handling in __dentry_name()

Alan Stern (1):
      HID: core: Fix assumption that Resolution Multipliers must be in Logical Collections

Alexander Aring (1):
      dlm: fix srcu_read_lock() return type to int

Alexander Stein (1):
      regulator: core: Add missing newline character

Alexandre Cassen (1):
      xfrm: delete intermediate secpath entry in packet offload mode

Alvin Šipraga (1):
      clk: si5351: allow PLLs to be adjusted without reset

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Do not use shared clk_ops for QUPs

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andrew Halaney (2):
      arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy0 irq
      arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq

Andrii Nakryiko (1):
      libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing

Andy Shevchenko (2):
      gpio: pca953x: Drop unused fields in struct pca953x_platform_data
      gpio: pca953x: Fully convert to device managed resources

Andy Strohman (1):
      wifi: mac80211: fix tid removal during mesh forwarding

Andy Yan (7):
      drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
      drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
      drm/rockchip: vop2: Set YUV/RGB overlay mode
      drm/rockchip: vop2: set bg dly and prescan dly at vop2_post_config
      drm/rockchip: vop2: Fix the windows switch between different layers
      drm/rockchip: vop2: Check linear format for Cluster windows on rk3566/8
      drm/rockchip: move output interface related definition to rockchip_drm_drv.h

Antoine Tenart (1):
      net: avoid race between device unregistration and ethnl ops

Arnaldo Carvalho de Melo (3):
      perf top: Don't complain about lack of vmlinux when not resolving some kernel samples
      perf namespaces: Introduce nsinfo__set_in_pidns()
      perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool

Arnaud Pouliquen (2):
      ARM: dts: stm32: Fix IPCC EXTI declaration on stm32mp151
      remoteproc: core: Fix ida_free call while not allocated

Ba Jing (1):
      ktest.pl: Remove unused declarations in run_bisect_test function

Balaji Pothunoori (1):
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Bartosz Golaszewski (1):
      arm64: dts: qcom: move common parts for sa8775p-ride variants into a .dtsi

Benjamin Lin (1):
      wifi: mt76: mt7996: fix incorrect indexing of MIB FW event

Billy Tsai (1):
      i3c: dw: Add hot-join support.

Bo Gan (1):
      clk: analogbits: Fix incorrect calculation of vco rate delta

Bokun Zhang (1):
      drm/amdgpu/vcn: reset fw_shared under SRIOV

Bryan Brattlof (2):
      arm64: dts: ti: k3-am62: Remove duplicate GICR reg
      arm64: dts: ti: k3-am62a: Remove duplicate GICR reg

Bryan O'Donoghue (1):
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Convert mezzanine riser to dtso

Calvin Owens (1):
      pps: Fix a use-after-free

Cezary Rojewski (4):
      ASoC: Intel: avs: Prefix SKL/APL-specific members
      ASoC: Intel: avs: Abstract IPC handling
      ASoC: Intel: avs: Do not readq() u32 registers
      ASoC: Intel: avs: Fix theoretical infinite loop

Charles Han (1):
      ipmi: ipmb: Add check devm_kasprintf() returned value

Chen Ni (1):
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

Chenyuan Yang (1):
      net: davicom: fix UAF in dm9000_drv_remove

Christophe JAILLET (1):
      drm/amd/pm: Fix an error handling path in vega10_enable_se_edc_force_stall_config()

Christophe Leroy (2):
      select: Fix unbalanced user_access_end()
      perf machine: Don't ignore _etext when not a text symbol

Chuck Lever (2):
      NFSD: Reset cb_seq_status after NFS4ERR_DELAY
      Revert "SUNRPC: Reduce thread wake-up rate when receiving large RPC messages"

Chun-Tse Shao (1):
      perf lock: Fix parse_lock_type which only retrieve one lock flag

Claudiu Beznea (1):
      ASoC: renesas: rz-ssi: Use only the proper amount of dividers

Cristian Birsan (1):
      ARM: dts: microchip: sama5d27_wlsom1_ek: Add no-1-8-v property to sdmmc0 node

Dan Carpenter (2):
      rdma/cxgb4: Prevent potential integer overflow on 32bit
      media: imx-jpeg: Fix potential error pointer dereference in detach_pm()

Daniel Lee (1):
      f2fs: Introduce linear search for dentries

Daniel Xu (1):
      bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write

Dave Stevenson (2):
      media: i2c: imx290: Register 0x3011 varies between imx327 and imx290
      media: i2c: ov9282: Correct the exposure offset

David Howells (5):
      afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
      afs: Fix directory format encoding struct
      afs: Fix cleanup of immediately failed async calls
      afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
      rxrpc: Fix handling of received connection abort

David Wronek (1):
      arm64: dts: qcom: Add SM7125 device tree

Desnes Nunes (1):
      media: dvb-usb-v2: af9035: fix ISO C90 compilation error on af9035_i2c_master_xfer

Detlev Casanova (1):
      ASoC: rockchip: i2s_tdm: Re-add the set_sysclk callback

Dheeraj Reddy Jonnalagadda (1):
      net: fec: implement TSO descriptor cleanup

Dmitry Antipov (1):
      wifi: cfg80211: adjust allocation of colocated AP data

Dmitry Baryshkov (20):
      drm/msm/dp: set safe_to_exit_level before printing it
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8150
      drm/msm/dpu: link DSPP_2/_3 blocks on SC8180X
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8250
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8350
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8550
      arm64: dts: qcom: msm8916: correct sleep clock frequency
      arm64: dts: qcom: msm8939: correct sleep clock frequency
      arm64: dts: qcom: msm8994: correct sleep clock frequency
      arm64: dts: qcom: qcs404: correct sleep clock frequency
      arm64: dts: qcom: q[dr]u1000: correct sleep clock frequency
      arm64: dts: qcom: qrb4210-rb2: correct sleep clock frequency
      arm64: dts: qcom: sc7280: correct sleep clock frequency
      arm64: dts: qcom: sdx75: correct sleep clock frequency
      arm64: dts: qcom: sm4450: correct sleep clock frequency
      arm64: dts: qcom: sm6125: correct sleep clock frequency
      arm64: dts: qcom: sm6375: correct sleep clock frequency
      arm64: dts: qcom: sm8250: correct sleep clock frequency
      arm64: dts: qcom: sm8350: correct sleep clock frequency
      arm64: dts: qcom: sm8450: correct sleep clock frequency

Dmitry V. Levin (1):
      selftests: harness: fix printing of mismatch values in __EXPECT()

Eric Dumazet (11):
      net_sched: sch_sfq: annotate data-races around q->perturb_period
      net_sched: sch_sfq: handle bigger packets
      inetpeer: remove create argument of inet_getpeer_v[46]()
      inetpeer: remove create argument of inet_getpeer()
      inetpeer: update inetpeer timestamp in inet_getpeer()
      inetpeer: do not get a refcount in inet_getpeer()
      ax25: rcu protect dev->ax25_ptr
      inet: ipmr: fix data-races
      ipmr: do not call mr_mfc_uses_dev() for unres entries
      net: rose: fix timer races against user threads
      net: hsr: fix fill_frame_info() regression vs VLAN packets

Eugen Hristev (1):
      pstore/blk: trivial typo fixes

Felix Fietkau (5):
      wifi: mt76: mt7996: fix rx filter setting for bfee functionality
      wifi: mt76: mt7915: firmware restart on devices with a second pcie link
      wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
      wifi: mt76: mt7915: improve hardware restart reliability
      wifi: mt76: mt7915: fix omac index assignment after hardware reset

Florian Westphal (4):
      netfilter: nf_tables: de-constify set commit ops function argument
      netfilter: nft_set_rbtree: rename gc deactivate+erase function
      netfilter: nft_set_rbtree: prefer sync gc to async worker
      netfilter: nft_flow_offload: update tcp state flags under lock

Frank Li (1):
      PCI: imx6: Simplify clock handling by using clk_bulk*() function

Gaurav Jain (1):
      crypto: caam - use JobR's space to access page 0 regs

Gautham R. Shenoy (1):
      cpufreq: ACPI: Fix max-frequency computation

Geert Uytterhoeven (2):
      dt-bindings: leds: class-multicolor: Fix path to color definitions
      selftests: timers: clocksource-switch: Adapt progress to kselftest framework

George Lander (1):
      ASoC: sun4i-spdif: Add clock multiplier settings

Greg Kroah-Hartman (1):
      Linux 6.6.76

Guangguan Wang (1):
      net/smc: fix data error when recvmsg with MSG_PEEK flag

Guixin Liu (1):
      scsi: ufs: bsg: Delete bsg_dev when setting up bsg fails

He Rongguang (1):
      cpupower: fix TSC MHz calculation

Hermes Wu (1):
      drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE

Hongbo Li (2):
      hostfs: convert hostfs to use the new mount API
      hostfs: fix the host directory parse when mounting.

Howard Chu (1):
      perf trace: Fix runtime error of index out of bounds

Howard Hsu (2):
      wifi: mt76: mt7996: fix the capability of reception of EHT MU PPDU
      wifi: mt76: mt7996: fix HE Phy capability

Hsin-Te Yuan (2):
      arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
      arm64: dts: mediatek: mt8183: willow: Support second source touchscreen

Hsin-Yi Wang (1):
      arm64: dts: mt8183: set DMIC one-wire mode on Damu

Huacai Chen (1):
      LoongArch: Fix warnings during S3 suspend

Hugo Villeneuve (1):
      serial: sc16is7xx: use device_property APIs when configuring irda mode

Ilan Peer (2):
      wifi: mac80211: Fix common size calculation for ML element
      wifi: cfg80211: Handle specific BSSID in 6GHz scanning

Ivan Stepchenko (1):
      drm/amdgpu: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table

Jakub Kicinski (1):
      net: netdevsim: try to close UDP port harness races

Jamal Hadi Salim (1):
      net: sched: Disallow replacing of child qdisc from one parent to another

Jason-JH.Lin (1):
      dts: arm64: mediatek: mt8195: Remove MT8183 compatible for OVL

Javier Carrasco (1):
      soc: atmel: fix device_node release in atmel_soc_device_init()

Jens Axboe (2):
      nvme: fix bogus kzalloc() return check in nvme_init_effects_log()
      io_uring/uring_cmd: use cached cmd_op in io_uring_cmd_sock()

Jiachen Zhang (1):
      perf report: Fix misleading help message about --demangle

Jian Shen (1):
      net: hns3: fix oops when unload drivers paralleling

Jianbo Liu (1):
      xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO

Jiang Liu (1):
      drm/amdgpu: tear down ttm range manager for doorbell in amdgpu_ttm_fini()

Jiasheng Jiang (3):
      media: marvell: Add check for clk_enable()
      media: mipi-csis: Add check for clk_enable()
      media: camif-core: Add check for clk_enable()

Jinliang Zheng (1):
      fs: fix proc_handler for sysctl_nr_open

Jiri Kosina (1):
      HID: multitouch: fix support for Goodix PID 0x01e9

Joe Hattori (14):
      clk: fix an OF node reference leak in of_clk_get_parent_name()
      ACPI: fan: cleanup resources in the error path of .probe()
      leds: netxbig: Fix an OF node reference leak in netxbig_leds_get_of_pdata()
      regulator: of: Implement the unwind path of of_regulator_match()
      OPP: OF: Fix an OF node leak in _opp_add_static_v2()
      leds: cht-wcove: Use devm_led_classdev_register() to avoid memory leak
      crypto: ixp4xx - fix OF node reference leaks in init_ixp_crypto()
      memory: tegra20-emc: fix an OF node reference bug in tegra_emc_find_node_by_ram_code()
      fbdev: omapfb: Fix an OF node leak in dss_of_port_get_parent_device()
      mtd: hyperbus: hbmc-am654: fix an OF node reference leak
      watchdog: rti_wdt: Fix an OF node leak in rti_wdt_probe()
      staging: media: imx: fix OF node leak in imx_media_add_of_subdevs()
      dmaengine: ti: edma: fix OF node reference leaks in edma_driver
      usb: dwc3-am62: Fix an OF node leak in phy_syscon_pll_refclk()

Johannes Berg (2):
      wifi: mac80211: prohibit deactivating all links
      wifi: mac80211: don't flush non-uploaded STAs

John Ogness (1):
      serial: 8250: Adjust the timeout for FIFO mode

Jon Maloy (1):
      tcp: correct handling of extreme memory squeeze

Jos Wang (1):
      usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout to PD_T_SENDER_RESPONSE

K Prateek Nayak (1):
      x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone distorted sound on Acer Aspire A115-31 laptop

Kalesh AP (1):
      RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error

Karol Przybylski (1):
      HID: hid-thrustmaster: Fix warning in thrustmaster_probe by adding endpoint check

Keisuke Nishimura (2):
      nvme: Add error check for xa_store in nvme_get_effects_log
      nvme: Add error path for xa_store in nvme_init_effects

King Dix (1):
      PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

Konrad Dybcio (4):
      arm64: dts: qcom: msm8996: Fix up USB3 interrupts
      arm64: dts: qcom: msm8994: Describe USB interrupts
      arm64: dts: qcom: sc7180-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8280xp: Fix up remoteproc register space sizes

Kory Maincent (1):
      net: sh_eth: Fix missing rtnl lock in suspend/resume path

Krzysztof Kozlowski (2):
      mfd: syscon: Use scoped variables with memory allocators to simplify error paths
      arm64: dts: qcom: sc7180: change labels to lower-case

Kunihiko Hayashi (2):
      net: stmmac: Limit the number of MTL queues to hardware capability
      net: stmmac: Limit FIFO size by hardware capability

Kyle Tso (2):
      usb: dwc3: core: Defer the probe until USB power supply ready
      usb: typec: tcpci: Prevent Sink disconnection before vPpsShutdown in SPR PPS

Laurent Pinchart (1):
      media: uvcvideo: Fix double free in error path

Laurentiu Palcu (2):
      media: nxp: imx8-isi: fix v4l2-compliance test errors
      staging: media: max96712: fix kernel oops when removing module

Leon Romanovsky (1):
      RDMA/mlx4: Avoid false error about access to uninitialized gids array

Levi Yun (1):
      perf expr: Initialize is_test value in expr__ctx_new()

Li Zhijian (1):
      RDMA/rxe: Improve newline in printing messages

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for iBasso DC07 Pro

Lin Yujun (1):
      hexagon: Fix unbalanced spinlock in die()

Liu Jian (1):
      net: let net.core.dev_weight always be non-zero

Luca Ceresoli (2):
      of: remove internal arguments from of_property_for_each_u32()
      gpio: pca953x: log an error when failing to get the reset GPIO

Luca Weiss (2):
      arm64: dts: qcom: sm7225-fairphone-fp4: Drop extra qcom,msm-id value
      media: i2c: imx412: Add missing newline to prints

Luo Yifan (1):
      tools/bootconfig: Fix the wrong format specifier

Ma Ke (1):
      RDMA/srp: Fix error handling in srp_add_port

Maciej S. Szmigiero (1):
      pinctrl: amd: Take suspend type into consideration which pins are non-wake

Mahdi Arghavani (1):
      tcp_cubic: fix incorrect HyStart round start detection

Maher Sanalla (1):
      net/mlxfw: Drop hard coded max FW flash image size

Mamta Shukla (1):
      arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead of "ahb"

Manivannan Sadhasivam (3):
      cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if LMh IRQ is not available
      cpufreq: qcom: Implement clk_ops::determine_rate() for qcom_cpufreq* clocks
      PCI: endpoint: pci-epf-test: Fix check for DMA MEMCPY test

Marcel Hamer (1):
      wifi: brcmfmac: add missing header include for brcmf_dbg

Marco Leogrande (1):
      tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind

Marek Vasut (4):
      clk: imx8mp: Fix clkout1/2 support
      ARM: dts: stm32: Deduplicate serial aliases and chosen node for STM32MP15xx DHCOM SoM
      ARM: dts: stm32: Swap USART3 and UART8 alias on STM32MP15xx DHCOM SoM
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix LP5562 LED1 reg property

Mark Brown (1):
      spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors

Martin KaFai Lau (1):
      bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT

Masahiro Yamada (8):
      ALSA: seq: remove redundant 'tristate' for SND_SEQ_UMP_CLIENT
      genksyms: fix memory leak when the same symbol is added from source
      genksyms: fix memory leak when the same symbol is read from *.symref file
      kconfig: fix file name in warnings when loading KCONFIG_DEFCONFIG_LIST
      kconfig: require a space after '#' for valid input
      kconfig: remove unused code for S_DEF_AUTO in conf_read_simple()
      kconfig: deduplicate code in conf_read_simple()
      kconfig: fix memory leak in sym_warn_unmet_dep()

Mathieu Desnoyers (1):
      selftests/rseq: Fix handling of glibc without rseq support

Matthew Wilcox (Oracle) (2):
      buffer: make folio_create_empty_buffers() return a buffer_head
      nilfs2: convert nilfs_lookup_dirty_data_buffers to use folio_create_empty_buffers

Matti Vaittinen (1):
      dt-bindings: mfd: bd71815: Fix rsense and typos

Michael Ellerman (1):
      selftests/powerpc: Fix argument order to timer_sub()

Michael Guralnik (1):
      RDMA/mlx5: Fix indirect mkey ODP page count

Michael Lo (1):
      wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.

Michal Luczaj (1):
      vsock: Allow retrying on connect() failure

Michal Pecio (1):
      usb: xhci: Fix NULL pointer dereference on certain command aborts

Michal Swiatkowski (1):
      iavf: allow changing VLAN state without calling PF

Mickaël Salaün (2):
      landlock: Handle weird files
      selftests/landlock: Fix error message

Mihai Sain (1):
      ARM: dts: microchip: sama5d27_wlsom1_ek: Remove mmc-ddr-3_3v property from sdmmc0 node

Min-Hua Chen (1):
      drm/rockchip: vop2: include rockchip_drm_drv.h

Ming Wang (1):
      rtc: loongson: clear TOY_MATCH0_REG in loongson_rtc_isr()

Mingwei Zheng (4):
      spi: zynq-qspi: Add check for clk_enable()
      pwm: stm32-lp: Add check for clk_enable()
      pwm: stm32: Add check for clk_enable()
      pinctrl: stm32: Add check for clk_enable()

Mohamed Khalfella (1):
      PCI: endpoint: pci-epf-test: Set dma_chan_rx pointer to NULL on error

Nathan Chancellor (2):
      hostfs: Add const qualifier to host_root in hostfs_fill_super()
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming

Neil Armstrong (8):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized
      dt-bindings: mmc: controller: clarify the address-cells description
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: remove disabled ov7251 camera
      arm64: dts: qcom: sc7180-trogdor-quackingstick: add missing avee-supply
      arm64: dts: qcom: sc7180-trogdor-pompom: rename 5v-choke thermal zone
      arm64: dts: qcom: sc7180: fix psci power domain node names
      arm64: dts: qcom: sm8150-microsoft-surface-duo: fix typos in da7280 properties

Nicolas Cavallari (1):
      wifi: mt76: mt7915: Fix mesh scan on MT7916 DBDC

Nicolas Ferre (1):
      ARM: at91: pm: change BU Power Switch to automatic mode

Nikita Zhandarovich (2):
      net/rose: prevent integer overflows in rose_setsockopt()
      net: usb: rtl8150: enable basic endpoint checking

Nícolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8186: Move wakeup to MTU3 to get working suspend
      arm64: dts: mediatek: mt8195: Remove suspend-breaking reset from pcie1

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

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix set size with rbtree backend
      netfilter: nf_tables: reject mismatching sum of field_len with set key length

Pali Rohár (3):
      cifs: Use cifs_autodisable_serverino() for disabling CIFS_MOUNT_SERVER_INUM in readdir.c
      cifs: Validate EAs for WSL reparse points
      cifs: Fix getting and setting SACLs over SMB1

Palmer Dabbelt (1):
      RISC-V: Mark riscv_v_init() as __init

Paolo Abeni (2):
      mptcp: consolidate suboption status
      mptcp: handle fastopen disconnect correctly

Parth Pancholi (1):
      kbuild: switch from lz4c to lz4 for compression

Paul Menzel (1):
      scsi: mpt3sas: Set ioc->manu_pg11.EEDPTagMode directly to 1

Paulo Alcantara (1):
      smb: client: fix oops due to unset link speed

Pei Xiao (1):
      i3c: dw: Fix use-after-free in dw_i3c_master driver due to race condition

Perry Yuan (1):
      x86/cpu: Enable SD_ASYM_PACKING for PKG domain on AMD

Peter Chiu (4):
      wifi: mt76: mt7915: fix register mapping
      wifi: mt76: mt7996: fix register mapping
      wifi: mt76: mt7996: add max mpdu len capability
      wifi: mt76: mt7996: fix ldpc setting

Peter Griffin (2):
      mfd: syscon: Remove extern from function prototypes
      mfd: syscon: Add of_syscon_register_regmap() API

Peter Zijlstra (2):
      sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat
      sched/topology: Rename 'DIE' domain to 'PKG'

Puranjay Mohan (1):
      bpf: Send signals asynchronously if !preemptible

Qasim Ijaz (1):
      iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()

Qu Wenruo (1):
      btrfs: output the reason for open_ctree() failure

Quan Nguyen (1):
      ipmi: ssif_bmc: Fix new request loss when bmc ready for a response

Quentin Monnet (1):
      libbpf: Fix segfault due to libelf functions not setting errno

Rafał Miłecki (2):
      ARM: dts: mediatek: mt7623: fix IR nodename
      bgmac: reduce max frame size to support just MTU 1500

Randy Dunlap (2):
      partitions: ldm: remove the initial kernel-doc notation
      efi: sysfb_efi: fix W=1 warnings when EFI is not set

Ricardo B. Marliere (1):
      ktest.pl: Check kernelrelease return in get_version

Ricardo Ribalda (1):
      media: uvcvideo: Propagate buf->error to userspace

Richard Zhu (1):
      PCI: imx6: Skip controller_id generation logic for i.MX7D

Ricky CX Wu (3):
      ARM: dts: aspeed: yosemite4: correct the compatible string of adm1272
      ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan boards
      ARM: dts: aspeed: yosemite4: correct the compatible string for max31790

Rob Herring (Arm) (1):
      mfd: syscon: Fix race in device_node_get_regmap()

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()

Ryusuke Konishi (1):
      nilfs2: protect access to buffers with no active references

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix fill_link_info selftest on powerpc

Sathishkumar Muruganandam (1):
      wifi: ath12k: fix tx power, max reg power update to firmware

Sean Rhodes (1):
      drivers/card_reader/rtsx_usb: Restore interrupt based detection

Sebastian Andrzej Siewior (1):
      module: Extend the preempt disabled section in dereference_symbol_descriptor().

Sergey Senozhatsky (1):
      kconfig: WERROR unmet symbol dependency

Sergio Paracuellos (1):
      clk: ralink: mtmips: remove duplicated 'xtal' clock for Ralink SoC RT3883

Shazad Hussain (1):
      arm64: dts: qcom: sa8775p-ride: enable pmm8654au_0_pon_resin

Shigeru Yoshida (1):
      vxlan: Fix uninit-value in vxlan_vnifilter_dump()

Shinas Rasheed (1):
      octeon_ep: remove firmware stats fetch in ndo_get_stats64

Sourabh Jain (1):
      powerpc/book3s64/hugetlb: Fix disabling hugetlb when fadump is active

Su Yue (1):
      ocfs2: mark dquot as inactive if failed to start trans while releasing dquot

Sui Jingfeng (2):
      drm/etnaviv: Fix page property being used for non writecombine buffers
      drm/msm: Check return value of of_dma_configure()

Sultan Alsawaf (unemployed) (1):
      cpufreq: schedutil: Fix superfluous updates caused by need_freq_update

Takashi Iwai (1):
      ALSA: seq: Make dependency on UMP clearer

Taniya Das (1):
      arm64: dts: qcom: sa8775p: Update sleep_clk frequency

Terry Tritton (1):
      HID: fix generic desktop D-Pad controls

Thadeu Lima de Souza Cascardo (9):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory

Thinh Nguyen (2):
      usb: gadget: f_tcm: Fix Get/SetInterface return value
      usb: gadget: f_tcm: Don't free command immediately

Thomas Gleixner (1):
      genirq: Make handle_enforce_irqctx() unconditionally available

Thomas Weißschuh (2):
      padata: fix sysfs store callback check
      ptp: Properly handle compat ioctls

Tiezhu Yang (1):
      LoongArch: Change 8 to 14 for LOONGARCH_MAX_{BRP,WRP}

Toke Høiland-Jørgensen (1):
      net: xdp: Disallow attaching device-bound programs in generic mode

Uwe Kleine-König (1):
      mtd: hyperbus: hbmc-am654: Convert to platform remove callback returning void

Val Packett (5):
      arm64: dts: mediatek: mt8516: fix GICv2 range
      arm64: dts: mediatek: mt8516: fix wdt irq type
      arm64: dts: mediatek: mt8516: add i2c clock-div property
      arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A
      arm64: dts: mediatek: add per-SoC compatibles for keypad nodes

Vasily Khoruzhick (4):
      dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
      clk: sunxi-ng: a64: drop redundant CLK_PLL_VIDEO0_2X and CLK_PLL_MIPI
      clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent
      arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0

Vladimir Zapolskiy (2):
      arm64: dts: qcom: sdm845: Fix interrupt types of camss interrupts
      arm64: dts: qcom: sm8250: Fix interrupt types of camss interrupts

WangYuli (1):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Wenkai Lin (2):
      crypto: hisilicon/sec2 - fix for aead icv error
      crypto: hisilicon/sec2 - fix for aead invalid authsize

Wentao Liang (1):
      PM: hibernate: Add error handling for syscore_suspend()

Willem de Bruijn (1):
      hexagon: fix using plain integer as NULL pointer warning in cmpxchg

Yabin Cui (1):
      perf/core: Save raw sample data conditionally based on sample type

Yang Erkun (1):
      block: retry call probe after request_module in blk_request_module

Yu Kuai (1):
      nbd: don't allow reconnect after disconnect

Zhongqiu Han (3):
      perf header: Fix one memory leakage in process_bpf_btf()
      perf header: Fix one memory leakage in process_bpf_prog_info()
      perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()

Zhu Yanjun (1):
      RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"

Zichen Xie (1):
      samples/landlock: Fix possible NULL dereference in parse_path()

Zijun Hu (3):
      of: reserved-memory: Do not make kmemleak ignore freed address
      PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
      driver core: class: Fix wild pointer dereferences in API class_dev_iter_next()

david regan (1):
      mtd: rawnand: brcmnand: fix status read of brcmnand_waitfunc

pangliyuan (1):
      ubifs: skip dumping tnc tree when zroot is null

xueqin Luo (1):
      wifi: mt76: mt7915: fix overflows seen when writing limit attributes

zhenwei pi (1):
      RDMA/rxe: Fix mismatched max_msg_sz


