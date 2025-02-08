Return-Path: <stable+bounces-114379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AFCA2D54D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEDC3A6DCA
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A111AF0D7;
	Sat,  8 Feb 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdFUX3s5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16B28F3;
	Sat,  8 Feb 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739007334; cv=none; b=I0iL6bIX746B9eg/2EsEwZ4ZPKeTDL3/011OK2Bi6GNAeD0H++xo3zOsMKpE+F8BsTgQnPxA4qUGZpe+78eKq+fIUk+IXur6CcF1T5qEO84kcwPD/tbLqSYOWR7MaqLKnG1brFS47xpsf4oa8sAIHWHxaSlsQsqp6qpbIemoGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739007334; c=relaxed/simple;
	bh=16z97dPhDTSyjIEbWRzg8+wyzHUwHJWnX5tkYTdBspA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bod4skaJdi168LsC/ZHS/zmtWQm9Lz7nDXRMYkdUHV7BGfU2MEyr84fWIlPQCAHOwEbpECtyZcId0yC2g7ACw2UiFAFN3jkCwGbYptTsNqeRWNW6zEfQkjmSLEub5nVFVjl/ZHEYc9kc2HcEiD3cfbt+7gAixiDmuWBzJm0h02w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdFUX3s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44573C4CEE0;
	Sat,  8 Feb 2025 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739007334;
	bh=16z97dPhDTSyjIEbWRzg8+wyzHUwHJWnX5tkYTdBspA=;
	h=From:To:Cc:Subject:Date:From;
	b=qdFUX3s5K4no/Y+w70kA7D4S7inM6Rb3Fs5IyvwhRpa/zpN9l2ZZzej4Fxf6HciJj
	 L2LI6G1pixeqiIUyF49dDt8C2x1qNYz3Qme7/RqxITpKrj40cqHWr4eNusoWqm8/c2
	 0LOzSxL2MKSmlWgcw4op8gFpNps0krvZcSYS/xAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.13
Date: Sat,  8 Feb 2025 10:35:15 +0100
Message-ID: <2025020816-legible-uranium-3071@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.13 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/core-api/symbol-namespaces.rst                           |    4 
 Documentation/devicetree/bindings/clock/imx93-clock.yaml               |    1 
 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml      |    2 
 Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml           |   20 
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml              |    2 
 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml      |    6 
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst                     |    9 
 Documentation/translations/it_IT/core-api/symbol-namespaces.rst        |    4 
 Documentation/translations/zh_CN/core-api/symbol-namespaces.rst        |    4 
 Makefile                                                               |    4 
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts             |   24 
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi                   |    6 
 arch/arm/boot/dts/mediatek/mt7623.dtsi                                 |    2 
 arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts                |    1 
 arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts                |    1 
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                              |    1 
 arch/arm/boot/dts/st/stm32mp13xx-dhcor-som.dtsi                        |    4 
 arch/arm/boot/dts/st/stm32mp151.dtsi                                   |    2 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-drc02.dtsi                      |   12 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-pdk2.dtsi                       |   10 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-picoitx.dtsi                    |   10 
 arch/arm/boot/dts/st/stm32mp15xx-dhcom-som.dtsi                        |    7 
 arch/arm/mach-at91/pm.c                                                |   31 
 arch/arm/mach-omap1/board-nokia770.c                                   |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts                  |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts                   |    2 
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi                          |    2 
 arch/arm64/boot/dts/freescale/imx93.dtsi                               |    2 
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts                     |    4 
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                              |    3 
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                           |   29 
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts                            |   25 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts             |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts            |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi          |   15 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi                 |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                               |    3 
 arch/arm64/boot/dts/mediatek/mt8186.dtsi                               |    8 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi                       |    3 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                        |    2 
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts                           |    9 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                               |    5 
 arch/arm64/boot/dts/mediatek/mt8365.dtsi                               |    3 
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts                 |    2 
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts                  |    2 
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                               |   11 
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi                       |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/Makefile                                      |    3 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                  |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                                  |    2 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                                  |   11 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                     |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                  |    9 
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts                       |    2 
 arch/arm64/boot/dts/qcom/qcs404.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts                               |    2 
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                               |    2 
 arch/arm64/boot/dts/qcom/qru1000-idp.dts                               |    2 
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi                             |    2 
 arch/arm64/boot/dts/qcom/sc7180-firmware-tfa.dtsi                      |   84 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi                    |    8 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi                  |    8 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi                    |    4 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi             |    1 
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi               |    8 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                   |  362 +++++-----
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                                 |   46 -
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts        |  104 --
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso       |   70 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                   |   20 
 arch/arm64/boot/dts/qcom/sdx75.dtsi                                    |    2 
 arch/arm64/boot/dts/qcom/sm4450.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sm6125.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sm6375.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sm7125.dtsi                                   |   16 
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts                      |    2 
 arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dts              |    4 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                   |   30 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                   |    2 
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts                        |    2 
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts            |    2 
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                                |    2 
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                   |    6 
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi               |    4 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                 |    2 
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi                       |    5 
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi                           |    7 
 arch/arm64/boot/dts/rockchip/rk3308-rock-s0.dts                        |   25 
 arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts                 |    2 
 arch/arm64/boot/dts/ti/Makefile                                        |    4 
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                               |    1 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                              |    1 
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts                |   47 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso               |   45 -
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts                |   47 +
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso               |   44 -
 arch/arm64/configs/defconfig                                           |    1 
 arch/hexagon/include/asm/cmpxchg.h                                     |    2 
 arch/hexagon/kernel/traps.c                                            |    4 
 arch/loongarch/include/asm/hw_breakpoint.h                             |    4 
 arch/loongarch/include/asm/loongarch.h                                 |   60 +
 arch/loongarch/kernel/hw_breakpoint.c                                  |   16 
 arch/loongarch/power/platform.c                                        |    2 
 arch/powerpc/include/asm/hugetlb.h                                     |    9 
 arch/powerpc/kernel/iommu.c                                            |    2 
 arch/powerpc/platforms/pseries/iommu.c                                 |   12 
 arch/riscv/kernel/vector.c                                             |    2 
 arch/s390/Kconfig                                                      |    1 
 arch/s390/Makefile                                                     |    2 
 arch/s390/include/asm/sclp.h                                           |    1 
 arch/s390/kernel/perf_cpum_cf.c                                        |    2 
 arch/s390/kernel/perf_pai_crypto.c                                     |    2 
 arch/s390/kernel/perf_pai_ext.c                                        |    2 
 arch/s390/kernel/setup.c                                               |    5 
 arch/s390/purgatory/Makefile                                           |    2 
 arch/x86/events/amd/ibs.c                                              |    2 
 arch/x86/include/asm/kvm_host.h                                        |    2 
 arch/x86/kernel/smpboot.c                                              |   10 
 arch/x86/kvm/lapic.c                                                   |   11 
 arch/x86/kvm/vmx/vmx.c                                                 |    2 
 arch/x86/kvm/vmx/x86_ops.h                                             |    2 
 block/bio-integrity.c                                                  |   15 
 block/blk-core.c                                                       |   21 
 block/blk-mq.c                                                         |   34 
 block/blk-mq.h                                                         |    6 
 block/blk-sysfs.c                                                      |    9 
 block/genhd.c                                                          |   22 
 block/partitions/ldm.h                                                 |    2 
 crypto/algapi.c                                                        |    4 
 drivers/acpi/acpica/achware.h                                          |    2 
 drivers/acpi/fan_core.c                                                |   10 
 drivers/base/class.c                                                   |    9 
 drivers/block/nbd.c                                                    |    1 
 drivers/block/ps3disk.c                                                |    4 
 drivers/bluetooth/btbcm.c                                              |    3 
 drivers/bluetooth/btnxpuart.c                                          |    3 
 drivers/bluetooth/btrtl.c                                              |    4 
 drivers/bluetooth/btusb.c                                              |    7 
 drivers/cdx/Makefile                                                   |    2 
 drivers/char/ipmi/ipmb_dev_int.c                                       |    3 
 drivers/char/ipmi/ssif_bmc.c                                           |    5 
 drivers/clk/analogbits/wrpll-cln28hpc.c                                |    2 
 drivers/clk/clk.c                                                      |    4 
 drivers/clk/imx/clk-imx8mp.c                                           |    5 
 drivers/clk/imx/clk-imx93.c                                            |   89 +-
 drivers/clk/qcom/camcc-x1e80100.c                                      |    7 
 drivers/clk/qcom/gcc-sdm845.c                                          |   32 
 drivers/clk/qcom/gcc-x1e80100.c                                        |    2 
 drivers/clk/ralink/clk-mtmips.c                                        |    1 
 drivers/clk/renesas/renesas-cpg-mssr.c                                 |    2 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c                                  |   13 
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h                                  |    2 
 drivers/clk/thead/clk-th1520-ap.c                                      |   13 
 drivers/cpufreq/acpi-cpufreq.c                                         |   36 
 drivers/cpufreq/qcom-cpufreq-hw.c                                      |   34 
 drivers/crypto/caam/blob_gen.c                                         |    3 
 drivers/crypto/hisilicon/sec2/sec.h                                    |    3 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                             |  161 ++--
 drivers/crypto/hisilicon/sec2/sec_crypto.h                             |   11 
 drivers/crypto/intel/iaa/Makefile                                      |    2 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                             |    2 
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c                            |    3 
 drivers/crypto/intel/qat/qat_common/Makefile                           |    2 
 drivers/crypto/tegra/tegra-se-aes.c                                    |    7 
 drivers/crypto/tegra/tegra-se-hash.c                                   |    7 
 drivers/dma/idxd/Makefile                                              |    2 
 drivers/dma/ti/edma.c                                                  |    3 
 drivers/firewire/device-attribute-test.c                               |    2 
 drivers/firmware/efi/sysfb_efi.c                                       |    2 
 drivers/firmware/qcom/qcom_scm.c                                       |   42 -
 drivers/gpio/gpio-idio-16.c                                            |    2 
 drivers/gpio/gpio-mxc.c                                                |    3 
 drivers/gpio/gpio-pca953x.c                                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                                |    6 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                      |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c            |   34 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c                   |    3 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c                 |   10 
 drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.h                 |    2 
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c                 |    1 
 drivers/gpu/drm/amd/display/dc/hubp/dcn201/dcn201_hubp.c               |    1 
 drivers/gpu/drm/amd/display/dc/hubp/dcn21/dcn21_hubp.c                 |    3 
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c                 |    3 
 drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c                 |    1 
 drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c                 |    1 
 drivers/gpu/drm/amd/display/dc/hubp/dcn35/dcn35_hubp.c                 |    1 
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c               |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                |    2 
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h                           |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                    |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_powertune.c              |    5 
 drivers/gpu/drm/bridge/ite-it6505.c                                    |    2 
 drivers/gpu/drm/display/drm_hdmi_state_helper.c                        |    8 
 drivers/gpu/drm/etnaviv/etnaviv_gem.c                                  |   16 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                  |    8 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h                |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h                 |   54 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h                 |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h                |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h                 |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h                 |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h                 |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h               |    2 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c                      |    2 
 drivers/gpu/drm/msm/dp/dp_audio.c                                      |    2 
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c                               |    2 
 drivers/gpu/drm/msm/msm_kms.c                                          |    1 
 drivers/gpu/drm/panthor/panthor_device.c                               |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                           |  115 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                           |   10 
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c                           |   26 
 drivers/gpu/drm/v3d/v3d_debugfs.c                                      |    4 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                      |   15 
 drivers/gpu/drm/v3d/v3d_regs.h                                         |   29 
 drivers/hid/hid-core.c                                                 |    2 
 drivers/hid/hid-input.c                                                |   37 -
 drivers/hid/hid-multitouch.c                                           |    2 
 drivers/hid/hid-thrustmaster.c                                         |    8 
 drivers/hwmon/Kconfig                                                  |    4 
 drivers/hwmon/nct6775-core.c                                           |    6 
 drivers/i2c/busses/i2c-designware-common.c                             |    5 
 drivers/i2c/busses/i2c-designware-master.c                             |    5 
 drivers/i2c/busses/i2c-designware-slave.c                              |    5 
 drivers/i3c/master/dw-i3c-master.c                                     |    1 
 drivers/infiniband/hw/Makefile                                         |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                               |    7 
 drivers/infiniband/hw/cxgb4/device.c                                   |    6 
 drivers/infiniband/hw/cxgb4/qp.c                                       |    8 
 drivers/infiniband/hw/hns/Kconfig                                      |   20 
 drivers/infiniband/hw/hns/Makefile                                     |    9 
 drivers/infiniband/hw/mlx4/main.c                                      |    8 
 drivers/infiniband/hw/mlx5/odp.c                                       |   62 +
 drivers/infiniband/sw/rxe/rxe_param.h                                  |    2 
 drivers/infiniband/sw/rxe/rxe_pool.c                                   |   11 
 drivers/infiniband/sw/rxe/rxe_verbs.c                                  |    5 
 drivers/infiniband/ulp/rtrs/rtrs.c                                     |    3 
 drivers/infiniband/ulp/srp/ib_srp.c                                    |    1 
 drivers/iommu/amd/amd_iommu.h                                          |    1 
 drivers/iommu/amd/iommu.c                                              |    9 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                            |   17 
 drivers/iommu/iommufd/iova_bitmap.c                                    |    2 
 drivers/iommu/iommufd/main.c                                           |    2 
 drivers/leds/leds-cht-wcove.c                                          |    6 
 drivers/leds/leds-netxbig.c                                            |    1 
 drivers/md/md-bitmap.c                                                 |   79 +-
 drivers/md/md-bitmap.h                                                 |    7 
 drivers/md/md.c                                                        |   34 
 drivers/md/md.h                                                        |    5 
 drivers/md/raid1.c                                                     |   34 
 drivers/md/raid1.h                                                     |    1 
 drivers/md/raid10.c                                                    |   26 
 drivers/md/raid10.h                                                    |    1 
 drivers/md/raid5-cache.c                                               |    4 
 drivers/md/raid5.c                                                     |  111 +--
 drivers/md/raid5.h                                                     |    4 
 drivers/media/i2c/imx290.c                                             |    3 
 drivers/media/i2c/imx412.c                                             |   42 -
 drivers/media/i2c/ov9282.c                                             |    2 
 drivers/media/platform/marvell/mcam-core.c                             |    7 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                         |    7 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c                   |    3 
 drivers/media/platform/samsung/exynos4-is/mipi-csis.c                  |   10 
 drivers/media/platform/samsung/s3c-camif/camif-core.c                  |   13 
 drivers/media/rc/iguanair.c                                            |    4 
 drivers/media/usb/dvb-usb-v2/af9035.c                                  |   18 
 drivers/media/usb/dvb-usb-v2/lmedm04.c                                 |   12 
 drivers/media/usb/uvc/uvc_queue.c                                      |    3 
 drivers/media/usb/uvc/uvc_status.c                                     |    1 
 drivers/memory/tegra/tegra20-emc.c                                     |    8 
 drivers/mfd/syscon.c                                                   |   19 
 drivers/misc/cardreader/rtsx_usb.c                                     |   15 
 drivers/mtd/hyperbus/hbmc-am654.c                                      |   19 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                               |    5 
 drivers/net/ethernet/broadcom/bgmac.h                                  |    3 
 drivers/net/ethernet/davicom/dm9000.c                                  |    3 
 drivers/net/ethernet/freescale/fec_main.c                              |   31 
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                            |   15 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                            |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                        |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c              |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                            |   19 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                        |   18 
 drivers/net/ethernet/intel/ice/ice_ethtool.c                           |  109 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.h                           |   38 -
 drivers/net/ethernet/intel/ice/ice_parser.h                            |    6 
 drivers/net/ethernet/intel/ice/ice_parser_rt.c                         |   12 
 drivers/net/ethernet/intel/idpf/idpf_controlq.c                        |    6 
 drivers/net/ethernet/intel/idpf/idpf_main.c                            |   15 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                        |   14 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c                    |   10 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c              |    8 
 drivers/net/ethernet/mediatek/airoha_eth.c                             |   37 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c |    2 
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c                        |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c                      |    8 
 drivers/net/ethernet/renesas/ravb_main.c                               |   22 
 drivers/net/ethernet/renesas/sh_eth.c                                  |    4 
 drivers/net/ethernet/sfc/ef100_ethtool.c                               |    1 
 drivers/net/ethernet/sfc/ethtool.c                                     |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |   30 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                               |    2 
 drivers/net/netdevsim/netdevsim.h                                      |    1 
 drivers/net/netdevsim/udp_tunnels.c                                    |   23 
 drivers/net/phy/marvell-88q2xxx.c                                      |   33 
 drivers/net/tap.c                                                      |    6 
 drivers/net/team/team_core.c                                           |    7 
 drivers/net/tun.c                                                      |    6 
 drivers/net/usb/rtl8150.c                                              |   22 
 drivers/net/vxlan/vxlan_vnifilter.c                                    |    5 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                |    1 
 drivers/net/wireless/ath/ath11k/hal_rx.c                               |    3 
 drivers/net/wireless/ath/ath12k/mac.c                                  |    6 
 drivers/net/wireless/ath/wcn36xx/main.c                                |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h                |    2 
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                           |   44 -
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c                          |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                            |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c                          |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                        |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                   |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                        |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                       |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                     |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                        |    1 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                       |    9 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                        |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/main.c                       |  109 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                        |  142 ++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                        |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                     |    2 
 drivers/net/wireless/mediatek/mt76/mt792x.h                            |    7 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                       |    3 
 drivers/net/wireless/mediatek/mt76/mt792x_mac.c                        |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                       |   20 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                        |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                       |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                        |   47 -
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                       |    2 
 drivers/net/wireless/mediatek/mt76/usb.c                               |    4 
 drivers/net/wireless/realtek/rtlwifi/base.c                            |   13 
 drivers/net/wireless/realtek/rtlwifi/base.h                            |    1 
 drivers/net/wireless/realtek/rtlwifi/pci.c                             |   61 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c                    |    7 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c                   |    4 
 drivers/net/wireless/realtek/rtlwifi/usb.c                             |   12 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                            |   12 
 drivers/net/wireless/realtek/rtw89/chan.c                              |  212 +++++
 drivers/net/wireless/realtek/rtw89/chan.h                              |   28 
 drivers/net/wireless/realtek/rtw89/core.c                              |  122 +--
 drivers/net/wireless/realtek/rtw89/core.h                              |   27 
 drivers/net/wireless/realtek/rtw89/fw.c                                |   40 -
 drivers/net/wireless/realtek/rtw89/mac.c                               |    3 
 drivers/net/wireless/realtek/rtw89/mac80211.c                          |   10 
 drivers/net/wireless/ti/wlcore/main.c                                  |   10 
 drivers/nvme/host/core.c                                               |   34 
 drivers/nvme/host/tcp.c                                                |   70 +
 drivers/of/fdt.c                                                       |   13 
 drivers/of/of_private.h                                                |    3 
 drivers/of/of_reserved_mem.c                                           |  176 +++-
 drivers/of/property.c                                                  |    2 
 drivers/opp/core.c                                                     |   57 +
 drivers/opp/of.c                                                       |    4 
 drivers/pci/controller/dwc/pci-imx6.c                                  |   30 
 drivers/pci/controller/dwc/pcie-designware-host.c                      |    1 
 drivers/pci/controller/dwc/pcie-qcom.c                                 |    2 
 drivers/pci/controller/pcie-rcar-ep.c                                  |    2 
 drivers/pci/controller/plda/pcie-microchip-host.c                      |  222 ++++--
 drivers/pci/controller/plda/pcie-plda-host.c                           |   17 
 drivers/pci/controller/plda/pcie-plda.h                                |    6 
 drivers/pci/endpoint/functions/pci-epf-test.c                          |    6 
 drivers/pci/endpoint/pci-epc-core.c                                    |    2 
 drivers/pinctrl/nomadik/pinctrl-nomadik.c                              |   35 
 drivers/pinctrl/pinctrl-amd.c                                          |   27 
 drivers/pinctrl/pinctrl-amd.h                                          |    7 
 drivers/pinctrl/samsung/pinctrl-exynos.c                               |    3 
 drivers/pinctrl/stm32/pinctrl-stm32.c                                  |   76 +-
 drivers/platform/mellanox/mlxbf-pmc.c                                  |    6 
 drivers/platform/x86/x86-android-tablets/lenovo.c                      |    4 
 drivers/pps/clients/pps-gpio.c                                         |    4 
 drivers/pps/clients/pps-ktimer.c                                       |    4 
 drivers/pps/clients/pps-ldisc.c                                        |    6 
 drivers/pps/clients/pps_parport.c                                      |    4 
 drivers/pps/kapi.c                                                     |   10 
 drivers/pps/kc.c                                                       |   10 
 drivers/pps/pps.c                                                      |  127 +--
 drivers/ptp/ptp_chardev.c                                              |    4 
 drivers/ptp/ptp_ocp.c                                                  |    2 
 drivers/pwm/core.c                                                     |    2 
 drivers/pwm/pwm-dwc-core.c                                             |    2 
 drivers/pwm/pwm-lpss.c                                                 |    2 
 drivers/pwm/pwm-stm32-lp.c                                             |    8 
 drivers/pwm/pwm-stm32.c                                                |    7 
 drivers/regulator/core.c                                               |    2 
 drivers/regulator/of_regulator.c                                       |   14 
 drivers/remoteproc/mtk_scp.c                                           |   12 
 drivers/remoteproc/remoteproc_core.c                                   |   14 
 drivers/rtc/rtc-loongson.c                                             |   13 
 drivers/rtc/rtc-pcf85063.c                                             |   11 
 drivers/rtc/rtc-tps6594.c                                              |    2 
 drivers/s390/char/sclp.c                                               |   12 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                       |    8 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                    |    3 
 drivers/soc/atmel/soc.c                                                |    2 
 drivers/spi/spi-omap2-mcspi.c                                          |   11 
 drivers/spi/spi-zynq-qspi.c                                            |   13 
 drivers/staging/media/imx/imx-media-of.c                               |    8 
 drivers/staging/media/max96712/max96712.c                              |    4 
 drivers/tty/mips_ejtag_fdc.c                                           |    4 
 drivers/tty/serial/8250/8250_port.c                                    |   32 
 drivers/tty/serial/sc16is7xx.c                                         |    2 
 drivers/ufs/core/ufs_bsg.c                                             |    1 
 drivers/usb/dwc3/core.c                                                |   35 
 drivers/usb/dwc3/dwc3-am62.c                                           |    1 
 drivers/usb/gadget/function/f_tcm.c                                    |   14 
 drivers/usb/host/xhci-ring.c                                           |    3 
 drivers/usb/storage/Makefile                                           |    2 
 drivers/usb/typec/tcpm/tcpci.c                                         |   13 
 drivers/usb/typec/tcpm/tcpm.c                                          |   10 
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c                          |    1 
 drivers/watchdog/rti_wdt.c                                             |    1 
 fs/afs/dir.c                                                           |    7 
 fs/afs/internal.h                                                      |    9 
 fs/afs/rxrpc.c                                                         |   12 
 fs/afs/xdr_fs.h                                                        |    2 
 fs/afs/yfsclient.c                                                     |    5 
 fs/btrfs/inode.c                                                       |   95 ++
 fs/btrfs/qgroup.c                                                      |   21 
 fs/btrfs/subpage.c                                                     |    6 
 fs/btrfs/subpage.h                                                     |   13 
 fs/btrfs/super.c                                                       |    2 
 fs/dlm/lock.c                                                          |   46 -
 fs/dlm/lowcomms.c                                                      |    3 
 fs/erofs/internal.h                                                    |   17 
 fs/erofs/zdata.c                                                       |  190 +++--
 fs/erofs/zutil.c                                                       |  155 ----
 fs/f2fs/dir.c                                                          |   53 +
 fs/f2fs/f2fs.h                                                         |    6 
 fs/f2fs/inline.c                                                       |    5 
 fs/file_table.c                                                        |    2 
 fs/hostfs/hostfs_kern.c                                                |   27 
 fs/nfs/localio.c                                                       |    4 
 fs/nfs/nfs42proc.c                                                     |    2 
 fs/nfs/nfs42xdr.c                                                      |    2 
 fs/nfs_common/common.c                                                 |   89 ++
 fs/nilfs2/dir.c                                                        |   13 
 fs/nilfs2/namei.c                                                      |   29 
 fs/nilfs2/nilfs.h                                                      |    4 
 fs/nilfs2/page.c                                                       |   31 
 fs/nilfs2/segment.c                                                    |    4 
 fs/ocfs2/quota_global.c                                                |    5 
 fs/pstore/blk.c                                                        |    4 
 fs/select.c                                                            |    4 
 fs/smb/client/cifsacl.c                                                |   25 
 fs/smb/client/cifsproto.h                                              |    2 
 fs/smb/client/cifssmb.c                                                |    4 
 fs/smb/client/readdir.c                                                |    2 
 fs/smb/client/reparse.c                                                |   22 
 fs/smb/client/smb2ops.c                                                |    3 
 fs/ubifs/debug.c                                                       |   22 
 fs/xfs/xfs_buf.c                                                       |    3 
 fs/xfs/xfs_notify_failure.c                                            |  121 ++-
 include/acpi/acpixf.h                                                  |    1 
 include/dt-bindings/clock/imx93-clock.h                                |    7 
 include/dt-bindings/clock/sun50i-a64-ccu.h                             |    2 
 include/linux/btf.h                                                    |    5 
 include/linux/coredump.h                                               |    4 
 include/linux/ethtool.h                                                |    4 
 include/linux/export.h                                                 |    2 
 include/linux/hid.h                                                    |    1 
 include/linux/ieee80211.h                                              |   11 
 include/linux/kallsyms.h                                               |    2 
 include/linux/mroute_base.h                                            |    6 
 include/linux/netdevice.h                                              |    2 
 include/linux/nfs_common.h                                             |    3 
 include/linux/perf_event.h                                             |    6 
 include/linux/pps_kernel.h                                             |    3 
 include/linux/ptr_ring.h                                               |   21 
 include/linux/sched.h                                                  |    1 
 include/linux/skb_array.h                                              |   17 
 include/linux/usb/tcpm.h                                               |    3 
 include/net/ax25.h                                                     |   10 
 include/net/inetpeer.h                                                 |   12 
 include/net/netfilter/nf_tables.h                                      |    6 
 include/net/netns/xfrm.h                                               |    1 
 include/net/pkt_cls.h                                                  |   13 
 include/net/sch_generic.h                                              |    5 
 include/net/xfrm.h                                                     |   30 
 include/sound/hdaudio_ext.h                                            |   45 -
 include/trace/events/afs.h                                             |    2 
 include/trace/events/rxrpc.h                                           |   25 
 include/uapi/linux/xfrm.h                                              |    2 
 io_uring/uring_cmd.c                                                   |    2 
 kernel/bpf/arena.c                                                     |    8 
 kernel/bpf/bpf_local_storage.c                                         |    8 
 kernel/bpf/bpf_struct_ops.c                                            |   21 
 kernel/bpf/btf.c                                                       |    5 
 kernel/bpf/helpers.c                                                   |   18 
 kernel/dma/coherent.c                                                  |   14 
 kernel/events/core.c                                                   |   35 
 kernel/irq/internals.h                                                 |    9 
 kernel/module/main.c                                                   |    7 
 kernel/padata.c                                                        |   45 -
 kernel/power/hibernate.c                                               |    7 
 kernel/printk/internal.h                                               |    6 
 kernel/printk/printk.c                                                 |    5 
 kernel/printk/printk_safe.c                                            |    7 
 kernel/sched/core.c                                                    |   83 +-
 kernel/sched/cpufreq_schedutil.c                                       |    4 
 kernel/sched/fair.c                                                    |   21 
 kernel/sched/features.h                                                |    9 
 kernel/sched/sched.h                                                   |   56 -
 kernel/sched/stats.h                                                   |   33 
 kernel/sched/syscalls.c                                                |    2 
 kernel/trace/bpf_trace.c                                               |   13 
 lib/rhashtable.c                                                       |   12 
 mm/memcontrol.c                                                        |    7 
 mm/oom_kill.c                                                          |    8 
 net/ax25/af_ax25.c                                                     |   12 
 net/ax25/ax25_dev.c                                                    |    4 
 net/ax25/ax25_ip.c                                                     |    3 
 net/ax25/ax25_out.c                                                    |   22 
 net/ax25/ax25_route.c                                                  |    2 
 net/core/dev.c                                                         |   21 
 net/core/filter.c                                                      |    2 
 net/core/sysctl_net_core.c                                             |    5 
 net/ethtool/ioctl.c                                                    |    8 
 net/ethtool/netlink.c                                                  |    2 
 net/hsr/hsr_forward.c                                                  |    7 
 net/ipv4/esp4_offload.c                                                |    6 
 net/ipv4/icmp.c                                                        |    9 
 net/ipv4/inetpeer.c                                                    |   31 
 net/ipv4/ip_fragment.c                                                 |   15 
 net/ipv4/ipmr.c                                                        |   28 
 net/ipv4/ipmr_base.c                                                   |    9 
 net/ipv4/route.c                                                       |   17 
 net/ipv4/tcp_cubic.c                                                   |    8 
 net/ipv4/tcp_output.c                                                  |    9 
 net/ipv4/udp.c                                                         |   56 +
 net/ipv6/esp6_offload.c                                                |    6 
 net/ipv6/icmp.c                                                        |    6 
 net/ipv6/ip6_output.c                                                  |    6 
 net/ipv6/ip6mr.c                                                       |   28 
 net/ipv6/ndisc.c                                                       |    8 
 net/ipv6/udp.c                                                         |   50 +
 net/key/af_key.c                                                       |    7 
 net/mac80211/debugfs_netdev.c                                          |    2 
 net/mac80211/driver-ops.h                                              |    3 
 net/mac80211/rx.c                                                      |    1 
 net/mptcp/ctrl.c                                                       |    4 
 net/mptcp/options.c                                                    |   13 
 net/mptcp/pm_netlink.c                                                 |    3 
 net/mptcp/protocol.c                                                   |    4 
 net/mptcp/protocol.h                                                   |   30 
 net/ncsi/ncsi-rsp.c                                                    |   18 
 net/netfilter/nf_tables_api.c                                          |   57 +
 net/netfilter/nft_flow_offload.c                                       |   16 
 net/netfilter/nft_set_rbtree.c                                         |   43 +
 net/rose/af_rose.c                                                     |   16 
 net/rose/rose_timer.c                                                  |   15 
 net/rxrpc/conn_event.c                                                 |   12 
 net/rxrpc/peer_event.c                                                 |   16 
 net/rxrpc/peer_object.c                                                |   12 
 net/sched/cls_api.c                                                    |   57 -
 net/sched/cls_bpf.c                                                    |    2 
 net/sched/cls_flower.c                                                 |    2 
 net/sched/cls_matchall.c                                               |    2 
 net/sched/cls_u32.c                                                    |    4 
 net/sched/sch_api.c                                                    |    4 
 net/sched/sch_generic.c                                                |    4 
 net/sched/sch_sfq.c                                                    |   43 -
 net/smc/af_smc.c                                                       |    2 
 net/smc/smc_rx.c                                                       |   37 -
 net/smc/smc_rx.h                                                       |    8 
 net/sunrpc/svcsock.c                                                   |   12 
 net/vmw_vsock/af_vsock.c                                               |    5 
 net/wireless/scan.c                                                    |    7 
 net/wireless/tests/scan.c                                              |    2 
 net/xfrm/xfrm_compat.c                                                 |    6 
 net/xfrm/xfrm_input.c                                                  |    2 
 net/xfrm/xfrm_policy.c                                                 |   12 
 net/xfrm/xfrm_replay.c                                                 |   10 
 net/xfrm/xfrm_state.c                                                  |  256 ++++++-
 net/xfrm/xfrm_user.c                                                   |   59 +
 samples/landlock/sandboxer.c                                           |    7 
 scripts/Makefile.lib                                                   |    4 
 scripts/genksyms/genksyms.c                                            |   11 
 scripts/genksyms/genksyms.h                                            |    2 
 scripts/genksyms/parse.y                                               |   18 
 scripts/kconfig/confdata.c                                             |    6 
 scripts/kconfig/symbol.c                                               |    1 
 security/landlock/fs.c                                                 |   11 
 sound/core/seq/Kconfig                                                 |    4 
 sound/pci/hda/patch_realtek.c                                          |    1 
 sound/soc/amd/acp/acp-i2s.c                                            |    1 
 sound/soc/codecs/Makefile                                              |    6 
 sound/soc/codecs/da7213.c                                              |    2 
 sound/soc/intel/avs/apl.c                                              |    3 
 sound/soc/intel/avs/cnl.c                                              |    1 
 sound/soc/intel/avs/core.c                                             |   14 
 sound/soc/intel/avs/loader.c                                           |    2 
 sound/soc/intel/avs/registers.h                                        |   45 +
 sound/soc/intel/avs/skl.c                                              |    1 
 sound/soc/intel/avs/topology.c                                         |    4 
 sound/soc/intel/boards/sof_sdw.c                                       |   47 -
 sound/soc/mediatek/mt8365/Makefile                                     |    2 
 sound/soc/rockchip/rockchip_i2s_tdm.c                                  |   31 
 sound/soc/sh/rz-ssi.c                                                  |    3 
 sound/soc/sunxi/sun4i-spdif.c                                          |    7 
 sound/usb/quirks.c                                                     |    2 
 tools/bootconfig/main.c                                                |    4 
 tools/include/uapi/linux/if_xdp.h                                      |    4 
 tools/lib/bpf/btf.c                                                    |    1 
 tools/lib/bpf/btf_relocate.c                                           |    2 
 tools/lib/bpf/linker.c                                                 |   22 
 tools/lib/bpf/usdt.c                                                   |    2 
 tools/net/ynl/lib/ynl.c                                                |    2 
 tools/perf/MANIFEST                                                    |    1 
 tools/perf/builtin-inject.c                                            |    8 
 tools/perf/builtin-lock.c                                              |   66 +
 tools/perf/builtin-report.c                                            |    2 
 tools/perf/builtin-top.c                                               |    2 
 tools/perf/builtin-trace.c                                             |    6 
 tools/perf/tests/shell/trace_btf_enum.sh                               |    8 
 tools/perf/util/bpf-event.c                                            |   10 
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c                  |   11 
 tools/perf/util/env.c                                                  |   13 
 tools/perf/util/env.h                                                  |    4 
 tools/perf/util/expr.c                                                 |    5 
 tools/perf/util/header.c                                               |    8 
 tools/perf/util/machine.c                                              |    2 
 tools/perf/util/maps.c                                                 |    7 
 tools/perf/util/namespaces.c                                           |    7 
 tools/perf/util/namespaces.h                                           |    3 
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c                |   15 
 tools/power/x86/turbostat/turbostat.8                                  |   25 
 tools/power/x86/turbostat/turbostat.c                                  |  163 ++++
 tools/testing/ktest/ktest.pl                                           |    7 
 tools/testing/selftests/bpf/Makefile                                   |    4 
 tools/testing/selftests/bpf/prog_tests/btf_distill.c                   |    4 
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c                |    4 
 tools/testing/selftests/bpf/prog_tests/tailcalls.c                     |  120 ++-
 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c                         |    5 
 tools/testing/selftests/bpf/progs/test_fill_link_info.c                |   13 
 tools/testing/selftests/bpf/test_tc_tunnel.sh                          |    1 
 tools/testing/selftests/bpf/xdp_hw_metadata.c                          |    2 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh        |   16 
 tools/testing/selftests/ftrace/test.d/00basic/mount_options.tc         |    8 
 tools/testing/selftests/kselftest/ktap_helpers.sh                      |    2 
 tools/testing/selftests/kselftest_harness.h                            |   24 
 tools/testing/selftests/landlock/Makefile                              |    4 
 tools/testing/selftests/landlock/fs_test.c                             |    3 
 tools/testing/selftests/net/lib/Makefile                               |    2 
 tools/testing/selftests/net/mptcp/Makefile                             |    2 
 tools/testing/selftests/net/openvswitch/Makefile                       |    2 
 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c              |    2 
 tools/testing/selftests/rseq/rseq.c                                    |   32 
 tools/testing/selftests/rseq/rseq.h                                    |    9 
 tools/testing/selftests/timers/clocksource-switch.c                    |    6 
 677 files changed, 6485 insertions(+), 3583 deletions(-)

Aaro Koskinen (1):
      ARM: omap1: Fix up the Retu IRQ on Nokia 770

Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Do not turn off usb_2 controller GDSC

Ahmad Fatoum (1):
      gpio: mxc: remove dead code after switch to DT-only

Akhil R (1):
      arm64: tegra: Fix DMA ID for SPI2

Al Viro (1):
      hostfs: fix string handling in __dentry_name()

Alan Stern (1):
      HID: core: Fix assumption that Resolution Multipliers must be in Logical Collections

Alejandro Jimenez (1):
      iommu/amd: Remove unused amd_iommu_domain_update()

Alex Deucher (1):
      Revert "drm/amdgpu/gfx9: put queue resets behind a debug option"

Alexander Aring (2):
      dlm: fix removal of rsb struct that is master and dir record
      dlm: fix srcu_read_lock() return type to int

Alexander Stein (2):
      ARM: dts: imx7-tqma7: add missing vs-supply for LM75A (rev. 01xxx)
      regulator: core: Add missing newline character

Alexandre Cassen (1):
      xfrm: delete intermediate secpath entry in packet offload mode

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix init-config parsing

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Do not use shared clk_ops for QUPs

Andreas Kemnade (1):
      wifi: wlcore: fix unbalanced pm_runtime calls

Andrii Nakryiko (1):
      libbpf: don't adjust USDT semaphore address if .stapsdt.base addr is missing

Andy Strohman (1):
      wifi: mac80211: fix tid removal during mesh forwarding

Andy Yan (7):
      drm/rockchip: vop2: Fix cluster windows alpha ctrl regsiters offset
      drm/rockchip: vop2: Fix the mixer alpha setup for layer 0
      drm/rockchip: vop2: Fix the windows switch between different layers
      drm/rockchip: vop2: Set AXI id for rk3588
      drm/rockchip: vop2: Setup delay cycle for Esmart2/3
      drm/rockchip: vop2: Check linear format for Cluster windows on rk3566/8
      drm/rockchip: vop2: Add check for 32 bpp format for rk3588

Antoine Tenart (1):
      net: avoid race between device unregistration and ethnl ops

Anumula Murali Mohan Reddy (1):
      RDMA/cxgb4: Notify rdma stack for IB_EVENT_QP_LAST_WQE_REACHED event

Aric Cyr (1):
      drm/amd/display: Add hubp cache reset when powergating

Arnaldo Carvalho de Melo (4):
      perf top: Don't complain about lack of vmlinux when not resolving some kernel samples
      perf namespaces: Introduce nsinfo__set_in_pidns()
      perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool
      perf MANIFEST: Add arch/*/include/uapi/asm/bpf_perf_event.h to the perf tarball

Arnaud Pouliquen (2):
      ARM: dts: stm32: Fix IPCC EXTI declaration on stm32mp151
      remoteproc: core: Fix ida_free call while not allocated

Ba Jing (1):
      ktest.pl: Remove unused declarations in run_bisect_test function

Balaji Pothunoori (1):
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Bard Liao (1):
      ASoC: Intel: sof_sdw: correct mach_params->dmic_num

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Benjamin Lin (2):
      wifi: mt76: mt7996: fix incorrect indexing of MIB FW event
      wifi: mt76: mt7996: fix definition of tx descriptor

Bo Gan (1):
      clk: analogbits: Fix incorrect calculation of vco rate delta

Bokun Zhang (1):
      drm/amdgpu/vcn: reset fw_shared under SRIOV

Boris Brezillon (1):
      drm/panthor: Preserve the result returned by panthor_fw_resume()

Breno Leitao (1):
      rhashtable: Fix potential deadlock by moving schedule_work outside lock

Bryan Brattlof (2):
      arm64: dts: ti: k3-am62: Remove duplicate GICR reg
      arm64: dts: ti: k3-am62a: Remove duplicate GICR reg

Bryan O'Donoghue (2):
      clk: qcom: camcc-x1e80100: Set titan_top_gdsc as the parent GDSC of subordinate GDSCs
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Convert mezzanine riser to dtso

Calvin Owens (1):
      pps: Fix a use-after-free

Cezary Rojewski (4):
      ASoC: Intel: avs: Do not readq() u32 registers
      ASoC: Intel: avs: Fix the minimum firmware version numbers
      ASoC: Intel: avs: Fix theoretical infinite loop
      ALSA: hda: Fix compilation of snd_hdac_adsp_xxx() helpers

Charles Han (4):
      ipmi: ipmb: Add check devm_kasprintf() returned value
      wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links
      Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
      firewire: test: Fix potential null dereference in firewire kunit test

Chen Ni (1):
      media: lmedm04: Handle errors for lme2510_int_read

Chen Ridong (5):
      crypto: tegra - do not transfer req when tegra init fails
      padata: fix UAF in padata_reorder
      padata: add pd get/put refcnt helper
      padata: avoid UAF for reorder_work
      memcg: fix soft lockup in the OOM process

Chen-Yu Tsai (12):
      regulator: dt-bindings: mt6315: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
      arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible property
      arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible property
      arm64: dts: mediatek: mt8195-demo: Drop regulator-compatible property
      arm64: dts: medaitek: mt8395-nio-12l: Drop regulator-compatible property
      arm64: dts: mediatek: mt8395-genio-1200-evk: Drop regulator-compatible property
      arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC sub-node names
      arm64: dts: mediatek: mt8173-evb: Fix MT6397 PMIC sub-node names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop pp3300_panel voltage settings
      remoteproc: mtk_scp: Only populate devices for SCP cores

Chengming Zhou (1):
      psi: Fix race when task wakes up before psi_sched_switch() adjusts flags

Chenyuan Yang (1):
      net: davicom: fix UAF in dm9000_drv_remove

Chih-Kang Chang (1):
      wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed

Christian Marangi (1):
      net: airoha: Fix wrong GDM4 register definition

Christoph Hellwig (4):
      block: copy back bounce buffer to user-space correctly in case of split
      block: check BLK_FEAT_POLL under q_usage_count
      block: don't update BLK_FEAT_POLL in __blk_mq_update_nr_hw_queues
      xfs: check for dead buffers in xfs_buf_find_insert

Christophe JAILLET (3):
      drm/amd/pm: Fix an error handling path in vega10_enable_se_edc_force_stall_config()
      wifi: mt76: mt7915: Fix an error handling path in mt7915_add_interface()
      pinctrl: samsung: Fix irq handling if an error occurs in exynos_irq_demux_eint16_31()

Christophe Leroy (4):
      select: Fix unbalanced user_access_end()
      perf maps: Fix display of kernel symbols
      perf machine: Don't ignore _etext when not a text symbol
      module: Don't fail module loading when setting ro_after_init section RO failed

Chuck Lever (1):
      Revert "SUNRPC: Reduce thread wake-up rate when receiving large RPC messages"

Chun-Tse Shao (1):
      perf lock: Fix parse_lock_type which only retrieve one lock flag

Claudiu Beznea (3):
      ASoC: renesas: rz-ssi: Use only the proper amount of dividers
      arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
      ASoC: da7213: Initialize the mutex

Colin Ian King (1):
      wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop

Conor Dooley (1):
      PCI: microchip: Add support for using either Root Port 1 or 2

Cristian Birsan (2):
      ARM: dts: microchip: sama5d29_curiosity: Add no-1-8-v property to sdmmc0 node
      ARM: dts: microchip: sama5d27_wlsom1_ek: Add no-1-8-v property to sdmmc0 node

Daire McNamara (1):
      PCI: microchip: Set inbound address translation for coherent or non-coherent mode

Dan Carpenter (4):
      wifi: mt76: mt7925: fix off by one in mt7925_load_clc()
      rdma/cxgb4: Prevent potential integer overflow on 32bit
      rtc: tps6594: Fix integer overflow on 32bit systems
      media: imx-jpeg: Fix potential error pointer dereference in detach_pm()

Daniel Baluta (1):
      ASoC: amd: acp: Fix possible deadlock

Daniel Gabay (1):
      wifi: iwlwifi: mvm: don't count mgmt frames as MPDU

Daniel Lee (1):
      f2fs: Introduce linear search for dentries

Daniel Xu (1):
      bpf: tcp: Mark bpf_load_hdr_opt() arg2 as read-write

Darrick J. Wong (1):
      xfs: don't shut down the filesystem for media failures beyond end of log

Dave Stevenson (2):
      media: i2c: imx290: Register 0x3011 varies between imx327 and imx290
      media: i2c: ov9282: Correct the exposure offset

David Howells (6):
      afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
      afs: Fix directory format encoding struct
      afs: Fix cleanup of immediately failed async calls
      afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
      rxrpc: Fix handling of received connection abort
      rxrpc, afs: Fix peer hash locking vs RCU callback

Derek Foreman (1):
      drm/connector: Allow clearing HDMI infoframes

Desnes Nunes (1):
      media: dvb-usb-v2: af9035: fix ISO C90 compilation error on af9035_i2c_master_xfer

Detlev Casanova (1):
      ASoC: rockchip: i2s_tdm: Re-add the set_sysclk callback

Dheeraj Reddy Jonnalagadda (1):
      net: fec: implement TSO descriptor cleanup

Dimitri Fedrau (1):
      net: phy: marvell-88q2xxx: Fix temperature measurement with reset-gpios

Dmitry Antipov (1):
      wifi: cfg80211: adjust allocation of colocated AP data

Dmitry Baryshkov (28):
      drm/msm/dp: set safe_to_exit_level before printing it
      drm/msm/dpu: provide DSPP and correct LM config for SDM670
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8150
      drm/msm/dpu: link DSPP_2/_3 blocks on SC8180X
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8250
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8350
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8550
      drm/msm/dpu: link DSPP_2/_3 blocks on SM8650
      drm/msm/dpu: link DSPP_2/_3 blocks on X1E80100
      drm/msm: don't clean up priv->kms prematurely
      drm/msm/mdp4: correct LCDC regulator name
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
      arm64: dts: qcom: sm8550: correct sleep clock frequency
      arm64: dts: qcom: sm8650: correct sleep clock frequency
      arm64: dts: qcom: x1e80100: correct sleep clock frequency

Dmitry V. Levin (1):
      selftests: harness: fix printing of mismatch values in __EXPECT()

Dmytro Maluka (1):
      of/fdt: Restore possibility to use both ACPI and FDT from bootloader

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()

Drew Fustini (3):
      clk: thead: Fix clk gate registration to pass flags
      clk: thead: Add CLK_IGNORE_UNUSED to fix TH1520 boot
      clk: thead: Fix cpu2vp_clk for TH1520 AP_SUBSYS clocks

Edward Cree (1):
      net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in

Emil Tantilov (2):
      idpf: add read memory barrier when checking descriptor done bit
      idpf: fix transaction timeouts on reset

Eric Dumazet (11):
      net_sched: sch_sfq: handle bigger packets
      inetpeer: remove create argument of inet_getpeer_v[46]()
      inetpeer: remove create argument of inet_getpeer()
      inetpeer: update inetpeer timestamp in inet_getpeer()
      inetpeer: do not get a refcount in inet_getpeer()
      ptr_ring: do not block hard interrupts in ptr_ring_resize_multiple()
      ax25: rcu protect dev->ax25_ptr
      inet: ipmr: fix data-races
      ipmr: do not call mr_mfc_uses_dev() for unres entries
      net: rose: fix timer races against user threads
      net: hsr: fix fill_frame_info() regression vs VLAN packets

Eric-SY Chang (1):
      wifi: mt76: mt7925: fix wrong band_idx setting when enable sniffer mode

Eugen Hristev (1):
      pstore/blk: trivial typo fixes

Everest K.C (1):
      xfrm: Add error handling when nla_put_u32() returns an error

Felix Fietkau (4):
      wifi: mt76: mt7996: fix rx filter setting for bfee functionality
      wifi: mt76: only enable tx worker after setting the channel
      wifi: mt76: mt7915: firmware restart on devices with a second pcie link
      wifi: mt76: mt7915: fix omac index assignment after hardware reset

Florian Westphal (2):
      netfilter: nft_flow_offload: update tcp state flags under lock
      xfrm: state: fix out-of-bounds read during lookup

Frank Li (1):
      PCI: imx6: Configure PHY based on Root Complex or Endpoint mode

Frank Wunderlich (1):
      arm64: dts: mediatek: mt7988: Add missing clock-div property for i2c

Gal Pressman (2):
      ethtool: Fix set RXNFC command with symmetric RSS hash
      ethtool: Fix access to uninitialized fields in set RXNFC command

Gao Xiang (4):
      erofs: get rid of erofs_{find,insert}_workgroup
      erofs: move erofs_workgroup operations into zdata.c
      erofs: sunset `struct erofs_workgroup`
      erofs: fix potential return value overflow of z_erofs_shrink_scan()

Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU incorrectly marks MMIO range in DDW

Gaurav Jain (1):
      crypto: caam - use JobR's space to access page 0 regs

Gautham R. Shenoy (1):
      cpufreq: ACPI: Fix max-frequency computation

Geert Uytterhoeven (4):
      ps3disk: Do not use dev->bounce_size before it is set
      dt-bindings: leds: class-multicolor: Fix path to color definitions
      selftests: timers: clocksource-switch: Adapt progress to kselftest framework
      dma-mapping: save base/size instead of pointer to shared DMA pool

George Lander (1):
      ASoC: sun4i-spdif: Add clock multiplier settings

Greg Kroah-Hartman (1):
      Linux 6.12.13

Guangguan Wang (1):
      net/smc: fix data error when recvmsg with MSG_PEEK flag

Guixin Liu (2):
      scsi: ufs: bsg: Delete bsg_dev when setting up bsg fails
      scsi: mpi3mr: Fix possible crash when setting up bsg fails

He Rongguang (1):
      cpupower: fix TSC MHz calculation

Heiko Carstens (1):
      s390/sclp: Initialize sclp subsystem via arch_cpu_finalize_init()

Heiko Stuebner (1):
      drm/rockchip: vop2: fix rk3588 dp+dsi maxclk verification

Herbert Xu (2):
      crypto: api - Fix boot-up self-test race
      rhashtable: Fix rhashtable_try_insert test

Hermes Wu (1):
      drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE

Hou Tao (1):
      bpf: Cancel the running bpf_timer through kworker for PREEMPT_RT

Howard Chu (2):
      perf trace: Fix BPF loading failure (-E2BIG)
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

Ian Rogers (1):
      perf inject: Fix use without initialization of local variables

Ilan Peer (1):
      wifi: mac80211: Fix common size calculation for ML element

Ivan Stepchenko (1):
      drm/amdgpu: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table

Jakub Kicinski (3):
      net: netdevsim: try to close UDP port harness races
      tools: ynl: c: correct reverse decode of empty attrs
      ethtool: ntuple: fix rss + ring_cookie check

Jamal Hadi Salim (1):
      net: sched: Disallow replacing of child qdisc from one parent to another

Jan Stancek (2):
      selftests: mptcp: extend CFLAGS to keep options from environment
      selftests: net/{lib,openvswitch}: extend CFLAGS to keep options from environment

Jason Gunthorpe (1):
      iommu/arm-smmuv3: Update comments about ATS and bypass

Jason-JH.Lin (1):
      dts: arm64: mediatek: mt8195: Remove MT8183 compatible for OVL

Javier Carrasco (2):
      clk: renesas: cpg-mssr: Fix 'soc' node handling in cpg_mssr_reserved_init()
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

Jiayuan Chen (1):
      selftests/bpf: Avoid generating untracked files when running bpf selftests

Jinliang Zheng (1):
      fs: fix proc_handler for sysctl_nr_open

Jiri Kosina (1):
      HID: multitouch: fix support for Goodix PID 0x01e9

Jiri Slaby (SUSE) (1):
      tty: mips_ejtag_fdc: fix one more u8 warning

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

Joel Stanley (2):
      hwmon: Fix help text for aspeed-g6-pwm-tach
      arm64: dts: qcom: x1e80100-romulus: Update firmware nodes

Johannes Berg (3):
      wifi: iwlwifi: fw: read STEP table from correct UEFI var
      wifi: mac80211: prohibit deactivating all links
      wifi: mac80211: don't flush non-uploaded STAs

Johannes Weiner (1):
      sched: psi: pass enqueue/dequeue flags to psi callbacks directly

John Ogness (2):
      printk: Defer legacy printing when holding printk_cpu_sync
      serial: 8250: Adjust the timeout for FIFO mode

John Stultz (1):
      sched: Split out __schedule() deactivate task logic into a helper

Jon Maloy (1):
      tcp: correct handling of extreme memory squeeze

Jonas Karlman (1):
      arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards

Jonathan Kim (1):
      drm/amdgpu: fix gpu recovery disable with per queue reset

Jos Wang (1):
      usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout to PD_T_SENDER_RESPONSE

Josua Mayer (2):
      arm64: dts: marvell: cn9131-cf-solidwan: fix cp1 comphy links
      arm64: dts: ti: k3-am642-hummingboard-t: Convert overlay to board dts

Junxian Huang (1):
      RDMA/hns: Clean up the legacy CONFIG_INFINIBAND_HNS

K Prateek Nayak (1):
      x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone distorted sound on Acer Aspire A115-31 laptop

Kalesh AP (1):
      RDMA/bnxt_re: Fix to drop reference to the mmap entry in case of error

Kanchana P Sridhar (1):
      crypto: iaa - Fix IAA disabling that occurs when sync_mode is set to 'async'

Karol Przybylski (1):
      HID: hid-thrustmaster: Fix warning in thrustmaster_probe by adding endpoint check

Kees Cook (2):
      coredump: Do not lock during 'comm' reporting
      wifi: cfg80211: Move cfg80211_scan_req_add_chan() n_channels increment earlier

Keisuke Nishimura (2):
      nvme: Add error check for xa_store in nvme_get_effects_log
      nvme: Add error path for xa_store in nvme_init_effects

King Dix (1):
      PCI: rcar-ep: Fix incorrect variable used when calling devm_request_mem_region()

Konrad Dybcio (3):
      arm64: dts: qcom: msm8996: Fix up USB3 interrupts
      arm64: dts: qcom: msm8994: Describe USB interrupts
      arm64: dts: qcom: sc8280xp: Fix up remoteproc register space sizes

Kory Maincent (2):
      net: ravb: Fix missing rtnl lock in suspend/resume path
      net: sh_eth: Fix missing rtnl lock in suspend/resume path

Krishna chaitanya chundru (1):
      PCI: qcom: Update ICC and OPP values after Link Up event

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sm8650: Fix CDSP context banks unit addresses
      arm64: dts: qcom: sc7180: change labels to lower-case
      firmware: qcom: scm: Cleanup global '__scm' on probe failures

Kunihiko Hayashi (2):
      net: stmmac: Limit the number of MTL queues to hardware capability
      net: stmmac: Limit FIFO size by hardware capability

Kuniyuki Iwashima (1):
      dev: Acquire netdev_rename_lock before restoring dev->name in dev_change_name().

Kyle Tso (2):
      usb: dwc3: core: Defer the probe until USB power supply ready
      usb: typec: tcpci: Prevent Sink disconnection before vPpsShutdown in SPR PPS

Laurent Pinchart (1):
      media: uvcvideo: Fix double free in error path

Laurentiu Palcu (2):
      media: nxp: imx8-isi: fix v4l2-compliance test errors
      staging: media: max96712: fix kernel oops when removing module

Len Brown (1):
      tools/power turbostat: Fix forked child affinity regression

Leon Hwang (1):
      selftests/bpf: Add test to verify tailcall and freplace restrictions

Leon Romanovsky (1):
      RDMA/mlx4: Avoid false error about access to uninitialized gids array

Leon Yen (1):
      wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO

Levi Yun (1):
      perf expr: Initialize is_test value in expr__ctx_new()

Li Zhijian (1):
      RDMA/rtrs: Add missing deinit() call

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for iBasso DC07 Pro

Lin Yujun (1):
      hexagon: Fix unbalanced spinlock in die()

Liu Jian (1):
      net: let net.core.dev_weight always be non-zero

Lorenzo Bianconi (1):
      net: airoha: Fix error path in airoha_probe()

Luca Ceresoli (1):
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

Manoj Vishwanathan (1):
      idpf: Acquire the lock before accessing the xn->salt

Marcel Hamer (1):
      wifi: brcmfmac: add missing header include for brcmf_dbg

Marco Leogrande (2):
      tools/testing/selftests/bpf/test_tc_tunnel.sh: Fix wait for server bind
      idpf: convert workqueues to unbound

Marek Vasut (5):
      clk: imx8mp: Fix clkout1/2 support
      ARM: dts: stm32: Increase CPU core voltage on STM32MP13xx DHCOR SoM
      ARM: dts: stm32: Deduplicate serial aliases and chosen node for STM32MP15xx DHCOM SoM
      ARM: dts: stm32: Swap USART3 and UART8 alias on STM32MP15xx DHCOM SoM
      arm64: dts: qcom: msm8996-xiaomi-gemini: Fix LP5562 LED1 reg property

Mark Brown (1):
      spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors

Martin KaFai Lau (2):
      bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT
      bpf: Reject struct_ops registration that uses module ptr and the module btf_id is missing

Masahiro Yamada (5):
      module: Convert default symbol namespace to string literal
      genksyms: fix memory leak when the same symbol is added from source
      genksyms: fix memory leak when the same symbol is read from *.symref file
      kconfig: fix file name in warnings when loading KCONFIG_DEFCONFIG_LIST
      kconfig: fix memory leak in sym_warn_unmet_dep()

Masami Hiramatsu (Google) (1):
      selftests/ftrace: Fix to use remount when testing mount GID option

Mateusz Polchlopek (3):
      ice: rework of dump serdes equalizer values feature
      ice: extend dump serdes equalizer values feature
      ice: remove invalid parameter of equalizer

Mathieu Desnoyers (1):
      selftests/rseq: Fix handling of glibc without rseq support

Matthieu Baerts (NGI0) (2):
      mptcp: pm: only set fullmesh for subflow endp
      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted

Matti Vaittinen (1):
      dt-bindings: mfd: bd71815: Fix rsense and typos

Max Chou (1):
      Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()

Maíra Canal (1):
      drm/v3d: Fix performance counter source settings on V3D 7.x

Michael Ellerman (1):
      selftests/powerpc: Fix argument order to timer_sub()

Michael Guralnik (1):
      RDMA/mlx5: Fix indirect mkey ODP page count

Michael Lo (1):
      wifi: mt76: mt7921: fix using incorrect group cipher after disconnection.

Michael Riesch (1):
      arm64: dts: rockchip: fix num-channels property of wolfvision pf5 mic

Michal Luczaj (1):
      vsock: Allow retrying on connect() failure

Michal Pecio (1):
      usb: xhci: Fix NULL pointer dereference on certain command aborts

Michal Swiatkowski (1):
      iavf: allow changing VLAN state without calling PF

Mickaël Salaün (4):
      selftests: ktap_helpers: Fix uninitialized variable
      landlock: Handle weird files
      selftests/landlock: Fix build with non-default pthread linking
      selftests/landlock: Fix error message

Mike Snitzer (1):
      nfs: fix incorrect error handling in LOCALIO

Min-Hua Chen (1):
      drm/rockchip: vop2: include rockchip_drm_drv.h

Ming Wang (1):
      rtc: loongson: clear TOY_MATCH0_REG in loongson_rtc_isr()

Ming Yen Hsieh (15):
      wifi: mt76: mt7925: fix get wrong chip cap from incorrect pointer
      wifi: mt76: mt7925: fix the invalid ip address for arp offload
      wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
      wifi: mt76: mt7925: Fix incorrect WCID assignment for MLO
      wifi: mt76: mt7925: fix wrong parameter for related cmd of chan info
      wifi: mt76: mt7925: Enhance mt7925_mac_link_bss_add to support MLO
      wifi: mt76: Enhance mt7925_mac_link_sta_add to support MLO
      wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
      wifi: mt76: mt7925: Update mt792x_rx_get_wcid for per-link STA
      wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
      wifi: mt76: mt7925: Update secondary link PS flow
      wifi: mt76: mt7925: Init secondary link PM state
      wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
      wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
      wifi: mt76: mt7925: Properly handle responses for commands with events

Mingwei Zheng (5):
      spi: zynq-qspi: Add check for clk_enable()
      pwm: stm32-lp: Add check for clk_enable()
      pwm: stm32: Add check for clk_enable()
      pinctrl: nomadik: Add check for clk_enable()
      pinctrl: stm32: Add check for clk_enable()

Miri Korenblit (1):
      wifi: iwlwifi: mvm: avoid NULL pointer dereference

Mohamed Khalfella (1):
      PCI: endpoint: pci-epf-test: Set dma_chan_rx pointer to NULL on error

Namhyung Kim (1):
      perf test: Skip syscall enum test if no landlock syscall

Nathan Chancellor (1):
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming

Neil Armstrong (9):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized
      dt-bindings: mmc: controller: clarify the address-cells description
      arm64: dts: qcom: qcm6490-shift-otter: remove invalid orientation-switch
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

Oreoluwa Babatunde (1):
      of: reserved_mem: Restructure how the reserved memory regions are processed

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

Patrisious Haddad (1):
      RDMA/mlx5: Fix implicit ODP use after free

Patryk Wlazlyn (2):
      tools/power turbostat: Allow using cpu device in perf counters on hybrid platforms
      tools/power turbostat: Fix PMT mmaped file size rounding

Paul Fertser (1):
      net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling

Paul Menzel (1):
      scsi: mpt3sas: Set ioc->manu_pg11.EEDPTagMode directly to 1

Paulo Alcantara (1):
      smb: client: fix oops due to unset link speed

Pei Xiao (4):
      platform/mellanox: mlxbf-pmc: incorrect type in assignment
      platform/x86: x86-android-tablets: make platform data be static
      bpf: Use refcount_t instead of atomic_t for mmap_count
      i3c: dw: Fix use-after-free in dw_i3c_master driver due to race condition

Peng Fan (1):
      clk: imx: Apply some clks only for i.MX93

Pengfei Li (4):
      dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
      dt-bindings: clock: Add i.MX91 clock support
      clk: imx93: Move IMX93_CLK_END macro to clk driver
      clk: imx: add i.MX91 clk

Perry Yuan (1):
      x86/cpu: Enable SD_ASYM_PACKING for PKG domain on AMD

Peter Chiu (4):
      wifi: mt76: mt7915: fix register mapping
      wifi: mt76: mt7996: fix register mapping
      wifi: mt76: mt7996: add max mpdu len capability
      wifi: mt76: mt7996: fix ldpc setting

Peter Zijlstra (2):
      sched/fair: Untangle NEXT_BUDDY and pick_next_task()
      sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat

Ping-Ke Shih (1):
      wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion

Przemek Kitszel (1):
      ice: fix ice_parser_rt::bst_key array size

Pu Lehui (3):
      selftests/bpf: Fix btf leak on new btf alloc failure in btf_distill test
      libbpf: Fix return zero when elf_begin failed
      libbpf: Fix incorrect traversal end type ID when marking BTF_IS_EMBEDDED

Puranjay Mohan (1):
      bpf: Send signals asynchronously if !preemptible

Qasim Ijaz (1):
      iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()

Qu Wenruo (4):
      btrfs: improve the warning and error message for btrfs_remove_qgroup()
      btrfs: subpage: fix the bitmap dump of the locked flags
      btrfs: output the reason for open_ctree() failure
      btrfs: do proper folio cleanup when run_delalloc_nocow() failed

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

Ray Chi (1):
      usb: dwc3: Skip resume if pm_runtime_set_active() fails

Rex Nie (1):
      drm/msm/hdmi: simplify code in pll_get_integloop_gain

Ricardo B. Marliere (1):
      ktest.pl: Check kernelrelease return in get_version

Ricardo Ribalda (1):
      media: uvcvideo: Propagate buf->error to userspace

Richard Zhu (4):
      PCI: imx6: Skip controller_id generation logic for i.MX7D
      PCI: imx6: Deassert apps_reset in imx_pcie_deassert_core_reset()
      PCI: imx6: Add missing reference clock disable logic
      PCI: dwc: Always stop link in the dw_pcie_suspend_noirq

Ricky CX Wu (3):
      ARM: dts: aspeed: yosemite4: correct the compatible string of adm1272
      ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan boards
      ARM: dts: aspeed: yosemite4: correct the compatible string for max31790

Rob Herring (Arm) (1):
      mfd: syscon: Fix race in device_node_get_regmap()

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()

Ross Burton (1):
      arm64: defconfig: remove obsolete CONFIG_SM_DISPCC_8650

Ryusuke Konishi (3):
      nilfs2: do not force clear folio if buffer is referenced
      nilfs2: protect access to buffers with no active references
      nilfs2: handle errors that nilfs_prepare_chunk() may return

Sagi Grimberg (1):
      nvme-tcp: Fix I/O queue cpu spreading for multiple controllers

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix fill_link_info selftest on powerpc

Sathishkumar Muruganandam (1):
      wifi: ath12k: fix tx power, max reg power update to firmware

Sean Christopherson (1):
      KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()

Sean Rhodes (1):
      drivers/card_reader/rtsx_usb: Restore interrupt based detection

Sean Wang (1):
      wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO

Sebastian Andrzej Siewior (1):
      module: Extend the preempt disabled section in dereference_symbol_descriptor().

Sebastian Sewior (1):
      xfrm: Don't disable preemption while looking up cache state.

Sergio Paracuellos (1):
      clk: ralink: mtmips: remove duplicated 'xtal' clock for Ralink SoC RT3883

Shayne Chen (1):
      wifi: mt76: mt7996: fix invalid interface combinations

Shengjiu Wang (3):
      dt-bindings: clock: imx93: Add SPDIF IPG clk
      clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
      arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock

Shigeru Yoshida (1):
      vxlan: Fix uninit-value in vxlan_vnifilter_dump()

Shinas Rasheed (2):
      octeon_ep: remove firmware stats fetch in ndo_get_stats64
      octeon_ep_vf: remove firmware stats fetch in ndo_get_stats64

Shivaprasad G Bhat (1):
      powerpc/pseries/iommu: Don't unset window if it was never set

Simon Trimmer (2):
      ASoC: Intel: sof_sdw: Fix DMI match for Lenovo 83LC
      ASoC: Intel: sof_sdw: Fix DMI match for Lenovo 83JX, 83MC and 83NM

Song Yoong Siang (1):
      selftests/bpf: Actuate tx_metadata_len in xdp_hw_metadata

Sourabh Jain (1):
      powerpc/book3s64/hugetlb: Fix disabling hugetlb when fadump is active

Stefano Brivio (1):
      udp: Deal with race between UDP socket address change and rehash

Steffen Klassert (4):
      xfrm: Add support for per cpu xfrm state handling.
      xfrm: Cache used outbound xfrm states at the policy.
      xfrm: Add an inbound percpu state cache.
      xfrm: Fix acquire state insertion.

Su Yue (1):
      ocfs2: mark dquot as inactive if failed to start trans while releasing dquot

Sui Jingfeng (2):
      drm/etnaviv: Fix page property being used for non writecombine buffers
      drm/msm: Check return value of of_dma_configure()

Sultan Alsawaf (unemployed) (1):
      cpufreq: schedutil: Fix superfluous updates caused by need_freq_update

Suraj Sonawane (1):
      iommu: iommufd: fix WARNING in iommufd_device_unbind

Takashi Iwai (4):
      ASoC: cs40l50: Use *-y for Makefile
      ASoC: mediatek: mt8365: Use *-y for Makefile
      ASoC: wcd937x: Use *-y for Makefile
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

Tianchen Ding (1):
      sched: Fix race between yield_to() and try_to_wake_up()

Tiezhu Yang (1):
      LoongArch: Change 8 to 14 for LOONGARCH_MAX_{BRP,WRP}

Toke Høiland-Jørgensen (1):
      net: xdp: Disallow attaching device-bound programs in generic mode

Uwe Kleine-König (2):
      hwmon: (nct6775): Actually make use of the HWMON_NCT6775 symbol namespace
      i2c: designware: Actually make use of the I2C_DW_COMMON and I2C_DW symbol namespaces

Val Packett (5):
      arm64: dts: mediatek: mt8516: fix GICv2 range
      arm64: dts: mediatek: mt8516: fix wdt irq type
      arm64: dts: mediatek: mt8516: add i2c clock-div property
      arm64: dts: mediatek: mt8516: reserve 192 KiB for TF-A
      arm64: dts: mediatek: add per-SoC compatibles for keypad nodes

Vasily Gorbik (2):
      s390/mm: Allow large pages for KASAN shadow mapping
      Revert "s390/mm: Allow large pages for KASAN shadow mapping"

Vasily Khoruzhick (4):
      dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
      clk: sunxi-ng: a64: drop redundant CLK_PLL_VIDEO0_2X and CLK_PLL_MIPI
      clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as TCON0 parent
      arm64: dts: allwinner: a64: explicitly assign clock parent for TCON0

Vishal Chourasia (1):
      tools: Sync if_xdp.h uapi tooling header

Vladimir Zapolskiy (3):
      arm64: dts: qcom: sc8280xp: Fix interrupt type of camss interrupts
      arm64: dts: qcom: sdm845: Fix interrupt types of camss interrupts
      arm64: dts: qcom: sm8250: Fix interrupt types of camss interrupts

WangYuli (1):
      wifi: mt76: mt76u_vendor_request: Do not print error messages when -EPROTO

Wayne Lin (1):
      drm/amd/display: Reduce accessing remote DPCD overhead

Wenkai Lin (2):
      crypto: hisilicon/sec2 - fix for aead icv error
      crypto: hisilicon/sec2 - fix for aead invalid authsize

Wentao Liang (1):
      PM: hibernate: Add error handling for syscore_suspend()

Willem de Bruijn (1):
      hexagon: fix using plain integer as NULL pointer warning in cmpxchg

Xin Long (1):
      net: sched: refine software bypass handling in tc_run

Yabin Cui (1):
      perf/core: Save raw sample data conditionally based on sample type

Yang Erkun (1):
      block: retry call probe after request_module in blk_request_module

Yevgeny Kliteynik (1):
      net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset

Yu Kuai (7):
      nbd: don't allow reconnect after disconnect
      md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
      md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
      md: add a new callback pers->bitmap_sector()
      md/raid5: implement pers->bitmap_sector()
      md/md-bitmap: move bitmap_{start, end}write to md upper layer
      md/md-bitmap: Synchronize bitmap_get_stats() with bitmap lifetime

Zhongqiu Han (3):
      perf header: Fix one memory leakage in process_bpf_btf()
      perf header: Fix one memory leakage in process_bpf_prog_info()
      perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()

Zhu Yanjun (1):
      RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"

Zichen Xie (2):
      wifi: cfg80211: tests: Fix potential NULL dereference in test_cfg80211_parse_colocated_ap()
      samples/landlock: Fix possible NULL dereference in parse_path()

Zijun Hu (5):
      of: property: Avoiding using uninitialized variable @imaplen in parse_interrupt_map()
      of: reserved-memory: Do not make kmemleak ignore freed address
      PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
      driver core: class: Fix wild pointer dereferences in API class_dev_iter_next()
      of: reserved-memory: Warn for missing static reserved memory regions

Zong-Zhe Yang (6):
      wifi: rtw89: handle entity active flag per PHY
      wifi: rtw89: chan: manage active interfaces
      wifi: rtw89: tweak setting of channel and TX power for MLO
      wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
      wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
      wifi: rtw89: mcc: consider time limits not divisible by 1024

allan.wang (1):
      wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment

david regan (1):
      mtd: rawnand: brcmnand: fix status read of brcmnand_waitfunc

pangliyuan (1):
      ubifs: skip dumping tnc tree when zroot is null

xueqin Luo (2):
      wifi: mt76: mt7996: fix overflows seen when writing limit attributes
      wifi: mt76: mt7915: fix overflows seen when writing limit attributes

zhenwei pi (1):
      RDMA/rxe: Fix mismatched max_msg_sz


