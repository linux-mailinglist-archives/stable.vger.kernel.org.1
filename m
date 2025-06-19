Return-Path: <stable+bounces-154811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D95AE07D4
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816763B2DC8
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089CE28B4EF;
	Thu, 19 Jun 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+7CkQ45"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3C28B4EA;
	Thu, 19 Jun 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341063; cv=none; b=kjIjswz5ydKSDyjmzLaKn+G4hu4Cz42rDKPB1Z9uRdcZo4FxXiCyxONYEVdFtcl5dHWAnbeLCvzzAbZgJLrzOB6qZ4ptJkk7ts7CePmuAioPqsZ7FeBF6TK3ZSN9K0BaWBtsAZoeHMbFXk+s06wIwWUlTfp+eUunn0KSf80GTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341063; c=relaxed/simple;
	bh=fb+WWNamxp165/LXkNvGWBqtfMBMsSPrqLrnfC7H6ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uitcZu3t1XioMsPBO59sQf3qQ4f8aO/a29M1VOgHo+QJmUzWRsZjzyg+a2tMnOqXD2uM7olZWYwXPfMiq0+EMJlEytGOk4dyc2jP/8vNQYzfBA2RS6PXLvld6kXa20LpMiRBCBupT47wM2Nzxa5W7nqT90jRFY51C0CV/fahj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+7CkQ45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6D0C4CEEA;
	Thu, 19 Jun 2025 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750341063;
	bh=fb+WWNamxp165/LXkNvGWBqtfMBMsSPrqLrnfC7H6ss=;
	h=From:To:Cc:Subject:Date:From;
	b=f+7CkQ45v7s404wFf6cjHCqA51D02c0CziwvZXxfpd4Z5+Bmqdq3sYW5TfQom5C30
	 M53yQTwqtnJC8Bfjd7NKaYJsgm0J2nKUiTp4KfLnUhGsXCkMc6xycdq2dMyL53yZOc
	 y45E96E2AW0xtEBelNsM+CmbK7e/zsFwvz3BbjW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.3
Date: Thu, 19 Jun 2025 15:50:41 +0200
Message-ID: <2025061942-premiere-surreal-fa53@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.3 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml |   12 
 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml                |    4 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                     |    2 
 Documentation/gpu/xe/index.rst                                             |    1 
 Documentation/gpu/xe/xe_gt_freq.rst                                        |   14 
 Documentation/misc-devices/lis3lv02d.rst                                   |    6 
 Documentation/netlink/specs/rt_link.yaml                                   |   68 +
 Documentation/networking/xfrm_device.rst                                   |   10 
 Makefile                                                                   |    2 
 arch/arm/boot/dts/microchip/at91sam9263ek.dts                              |    2 
 arch/arm/boot/dts/microchip/tny_a9263.dts                                  |    2 
 arch/arm/boot/dts/microchip/usb_a9263.dts                                  |    4 
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi                                   |   82 +-
 arch/arm/mach-aspeed/Kconfig                                               |    1 
 arch/arm64/Kconfig                                                         |    6 
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi                             |    3 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts                        |    1 
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts                        |    1 
 arch/arm64/boot/dts/freescale/imx8mn-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi                       |    1 
 arch/arm64/boot/dts/mediatek/mt6357.dtsi                                   |   10 
 arch/arm64/boot/dts/mediatek/mt6359.dtsi                                   |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                             |   10 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                                   |    4 
 arch/arm64/boot/dts/mediatek/mt8188.dtsi                                   |    2 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                   |   50 -
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi                      |   12 
 arch/arm64/boot/dts/nvidia/tegra186.dtsi                                   |   12 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                                   |   12 
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi                             |    1 
 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi                           |   11 
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                                      |   16 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                      |   19 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                      |   16 
 arch/arm64/boot/dts/qcom/qcs615.dtsi                                       |   17 
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                                      |   12 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                                      |   11 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts                 |    3 
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts                        |    2 
 arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dts                        |    3 
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts                    |   16 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                       |    2 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                       |    6 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                       |  391 ++++++----
 arch/arm64/boot/dts/qcom/sm8650.dtsi                                       |   82 +-
 arch/arm64/boot/dts/qcom/sm8750.dtsi                                       |   26 
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                               |   44 +
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi                   |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                     |    2 
 arch/arm64/boot/dts/renesas/white-hawk-ard-audio-da7212.dtso               |    2 
 arch/arm64/boot/dts/renesas/white-hawk-single.dtsi                         |    8 
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts                        |    8 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                              |   12 
 arch/arm64/boot/dts/rockchip/rk3528.dtsi                                   |    3 
 arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts                            |    1 
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi                        |    5 
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi                              |   15 
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts                      |    1 
 arch/arm64/configs/defconfig                                               |    3 
 arch/arm64/include/asm/esr.h                                               |   14 
 arch/arm64/kernel/fpsimd.c                                                 |   21 
 arch/arm64/xen/hypercall.S                                                 |   21 
 arch/m68k/mac/config.c                                                     |    2 
 arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts                     |    1 
 arch/powerpc/kernel/Makefile                                               |    2 
 arch/powerpc/kexec/crash.c                                                 |    5 
 arch/powerpc/platforms/book3s/vas-api.c                                    |    9 
 arch/powerpc/platforms/powernv/memtrace.c                                  |    8 
 arch/powerpc/platforms/pseries/iommu.c                                     |    2 
 arch/riscv/kernel/traps_misaligned.c                                       |    4 
 arch/riscv/kvm/vcpu_sbi.c                                                  |    4 
 arch/s390/kernel/uv.c                                                      |   85 +-
 arch/s390/net/bpf_jit_comp.c                                               |   12 
 arch/um/os-Linux/sigio.c                                                   |    3 
 arch/x86/events/amd/uncore.c                                               |   36 
 arch/x86/hyperv/hv_init.c                                                  |   33 
 arch/x86/hyperv/hv_vtl.c                                                   |   44 -
 arch/x86/hyperv/ivm.c                                                      |   22 
 arch/x86/include/asm/mshyperv.h                                            |    6 
 arch/x86/include/asm/mwait.h                                               |    9 
 arch/x86/include/asm/sighandling.h                                         |   22 
 arch/x86/kernel/cpu/common.c                                               |   17 
 arch/x86/kernel/cpu/microcode/core.c                                       |    2 
 arch/x86/kernel/cpu/mtrr/generic.c                                         |    2 
 arch/x86/kernel/ioport.c                                                   |   13 
 arch/x86/kernel/irq.c                                                      |    2 
 arch/x86/kernel/process.c                                                  |   15 
 arch/x86/kernel/signal_32.c                                                |    4 
 arch/x86/kernel/signal_64.c                                                |    4 
 arch/x86/lib/x86-opcode-map.txt                                            |   50 -
 block/blk-integrity.c                                                      |    7 
 block/blk-throttle.c                                                       |   22 
 block/blk-zoned.c                                                          |    7 
 block/elevator.c                                                           |    3 
 crypto/api.c                                                               |   13 
 crypto/asymmetric_keys/public_key.c                                        |   13 
 crypto/ecdsa-p1363.c                                                       |    6 
 crypto/ecdsa-x962.c                                                        |    5 
 crypto/ecdsa.c                                                             |    2 
 crypto/ecrdsa.c                                                            |    2 
 crypto/krb5/rfc3961_simplified.c                                           |    1 
 crypto/lrw.c                                                               |    4 
 crypto/rsassa-pkcs1.c                                                      |    2 
 crypto/sig.c                                                               |    9 
 crypto/xts.c                                                               |    4 
 drivers/accel/amdxdna/aie2_message.c                                       |    6 
 drivers/accel/amdxdna/aie2_msg_priv.h                                      |   10 
 drivers/accel/amdxdna/aie2_psp.c                                           |    4 
 drivers/accel/ivpu/ivpu_job.c                                              |    8 
 drivers/acpi/acpica/exserial.c                                             |    6 
 drivers/acpi/apei/Kconfig                                                  |    1 
 drivers/acpi/apei/ghes.c                                                   |    2 
 drivers/acpi/cppc_acpi.c                                                   |    2 
 drivers/acpi/osi.c                                                         |    1 
 drivers/acpi/platform_profile.c                                            |    3 
 drivers/acpi/resource.c                                                    |    2 
 drivers/acpi/thermal.c                                                     |   10 
 drivers/base/power/main.c                                                  |    3 
 drivers/base/power/runtime.c                                               |   44 +
 drivers/block/brd.c                                                        |   11 
 drivers/block/loop.c                                                       |    8 
 drivers/bluetooth/btintel.c                                                |   10 
 drivers/bluetooth/btintel_pcie.c                                           |   31 
 drivers/bluetooth/btintel_pcie.h                                           |   10 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                            |   12 
 drivers/char/Kconfig                                                       |    2 
 drivers/clk/bcm/clk-raspberrypi.c                                          |    2 
 drivers/clk/qcom/camcc-sm6350.c                                            |   18 
 drivers/clk/qcom/dispcc-sm6350.c                                           |    3 
 drivers/clk/qcom/gcc-msm8939.c                                             |    4 
 drivers/clk/qcom/gcc-sm6350.c                                              |    6 
 drivers/clk/qcom/gpucc-sm6350.c                                            |    6 
 drivers/counter/interrupt-cnt.c                                            |    9 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c                        |    7 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                          |   17 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c                          |   34 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                               |    2 
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c                        |    2 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                 |    6 
 drivers/crypto/marvell/cesa/cipher.c                                       |    3 
 drivers/crypto/marvell/cesa/hash.c                                         |    2 
 drivers/crypto/xilinx/zynqmp-sha.c                                         |   18 
 drivers/dma/ti/k3-udma.c                                                   |    3 
 drivers/edac/bluefield_edac.c                                              |   20 
 drivers/edac/i10nm_base.c                                                  |   35 
 drivers/edac/skx_common.c                                                  |    1 
 drivers/edac/skx_common.h                                                  |   11 
 drivers/firmware/Kconfig                                                   |    1 
 drivers/firmware/arm_sdei.c                                                |   11 
 drivers/firmware/efi/libstub/efi-stub-helper.c                             |    1 
 drivers/firmware/psci/psci.c                                               |    4 
 drivers/firmware/samsung/exynos-acpm-pmic.c                                |   16 
 drivers/firmware/samsung/exynos-acpm.c                                     |   11 
 drivers/fpga/tests/fpga-mgr-test.c                                         |    1 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h                      |    6 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm                 |   13 
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c                         |    5 
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c                       |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c                        |    8 
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c                         |   58 -
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                                 |    6 
 drivers/gpu/drm/ci/gitlab-ci.yml                                           |   19 
 drivers/gpu/drm/display/drm_hdmi_audio_helper.c                            |    3 
 drivers/gpu/drm/drm_panic_qr.rs                                            |   71 +
 drivers/gpu/drm/i915/display/intel_dp.c                                    |    7 
 drivers/gpu/drm/i915/display/intel_dp.h                                    |    1 
 drivers/gpu/drm/i915/display/intel_dp_mst.c                                |    5 
 drivers/gpu/drm/i915/display/intel_psr_regs.h                              |    4 
 drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c                         |   16 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                          |   19 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                     |   31 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                                 |    2 
 drivers/gpu/drm/meson/meson_vclk.c                                         |   55 -
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                      |    1 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h                   |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h                   |    1 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h                   |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h                     |   16 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h                    |   16 
 drivers/gpu/drm/msm/dp/dp_display.c                                        |   27 
 drivers/gpu/drm/msm/dp/dp_link.h                                           |    4 
 drivers/gpu/drm/msm/dp/dp_panel.c                                          |   12 
 drivers/gpu/drm/panel/panel-samsung-sofef00.c                              |   34 
 drivers/gpu/drm/panel/panel-simple.c                                       |    5 
 drivers/gpu/drm/panthor/panthor_device.c                                   |    8 
 drivers/gpu/drm/panthor/panthor_mmu.c                                      |    1 
 drivers/gpu/drm/panthor/panthor_regs.h                                     |    4 
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c                              |   10 
 drivers/gpu/drm/tegra/rgb.c                                                |   14 
 drivers/gpu/drm/v3d/v3d_debugfs.c                                          |  126 +--
 drivers/gpu/drm/v3d/v3d_drv.c                                              |   22 
 drivers/gpu/drm/v3d/v3d_drv.h                                              |   11 
 drivers/gpu/drm/v3d/v3d_gem.c                                              |   10 
 drivers/gpu/drm/v3d/v3d_irq.c                                              |   64 +
 drivers/gpu/drm/v3d/v3d_perfmon.c                                          |    4 
 drivers/gpu/drm/v3d/v3d_sched.c                                            |    6 
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c                                |   36 
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c                             |  154 +++
 drivers/gpu/drm/vc4/vc4_hdmi.c                                             |   16 
 drivers/gpu/drm/vkms/vkms_crtc.c                                           |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                         |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                         |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                                    |   26 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                                   |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                                    |   34 
 drivers/gpu/drm/xe/Kconfig                                                 |    3 
 drivers/gpu/drm/xe/xe_bo.c                                                 |   48 -
 drivers/gpu/drm/xe/xe_gt_freq.c                                            |    5 
 drivers/gpu/drm/xe/xe_guc_debugfs.c                                        |  159 ++--
 drivers/gpu/drm/xe/xe_lrc.c                                                |   24 
 drivers/gpu/drm/xe/xe_pci.c                                                |    1 
 drivers/gpu/drm/xe/xe_pxp.c                                                |    8 
 drivers/gpu/drm/xe/xe_vm.c                                                 |   19 
 drivers/gpu/drm/xe/xe_vm.h                                                 |   69 +
 drivers/gpu/drm/xe/xe_vm_types.h                                           |    8 
 drivers/gpu/drm/xlnx/Kconfig                                               |    1 
 drivers/hid/Kconfig                                                        |    2 
 drivers/hid/hid-hyperv.c                                                   |    4 
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c                    |    7 
 drivers/hid/usbhid/hid-core.c                                              |   25 
 drivers/hwmon/asus-ec-sensors.c                                            |    4 
 drivers/hwtracing/coresight/coresight-catu.c                               |   27 
 drivers/hwtracing/coresight/coresight-catu.h                               |    1 
 drivers/hwtracing/coresight/coresight-config.h                             |    2 
 drivers/hwtracing/coresight/coresight-core.c                               |   21 
 drivers/hwtracing/coresight/coresight-cpu-debug.c                          |    3 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                         |    5 
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                        |    4 
 drivers/hwtracing/coresight/coresight-funnel.c                             |    3 
 drivers/hwtracing/coresight/coresight-replicator.c                         |    3 
 drivers/hwtracing/coresight/coresight-stm.c                                |    2 
 drivers/hwtracing/coresight/coresight-syscfg.c                             |   51 -
 drivers/hwtracing/coresight/coresight-tmc-core.c                           |    2 
 drivers/hwtracing/coresight/coresight-tmc-etf.c                            |   11 
 drivers/hwtracing/coresight/coresight-tpiu.c                               |    2 
 drivers/iio/adc/ad4851.c                                                   |   14 
 drivers/iio/adc/ad7124.c                                                   |    4 
 drivers/iio/adc/mcp3911.c                                                  |   39 
 drivers/iio/adc/pac1934.c                                                  |    2 
 drivers/iio/dac/adi-axi-dac.c                                              |    8 
 drivers/iio/filter/admv8818.c                                              |  224 ++++-
 drivers/infiniband/core/cm.c                                               |   19 
 drivers/infiniband/core/cma.c                                              |    3 
 drivers/infiniband/hw/bnxt_re/debugfs.c                                    |   20 
 drivers/infiniband/hw/hns/hns_roce_ah.c                                    |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                 |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                                 |    1 
 drivers/infiniband/hw/hns/hns_roce_main.c                                  |    1 
 drivers/infiniband/hw/hns/hns_roce_restrack.c                              |    1 
 drivers/infiniband/hw/mlx5/qpc.c                                           |   30 
 drivers/infiniband/sw/rxe/rxe_qp.c                                         |    7 
 drivers/iommu/Kconfig                                                      |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                                |    2 
 drivers/iommu/io-pgtable-arm.c                                             |   13 
 drivers/iommu/iommu.c                                                      |    4 
 drivers/iommu/ipmmu-vmsa.c                                                 |    3 
 drivers/mailbox/Kconfig                                                    |    4 
 drivers/mailbox/imx-mailbox.c                                              |   21 
 drivers/mailbox/mtk-cmdq-mailbox.c                                         |   51 -
 drivers/md/dm-core.h                                                       |    1 
 drivers/md/dm-flakey.c                                                     |   70 -
 drivers/md/dm-table.c                                                      |   67 +
 drivers/md/dm-zone.c                                                       |   86 +-
 drivers/md/dm.c                                                            |   36 
 drivers/md/dm.h                                                            |    6 
 drivers/md/raid1-10.c                                                      |   10 
 drivers/md/raid1.c                                                         |   19 
 drivers/md/raid10.c                                                        |   11 
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c                       |   14 
 drivers/media/platform/verisilicon/hantro_postproc.c                       |    4 
 drivers/mfd/exynos-lpass.c                                                 |   31 
 drivers/mfd/stmpe-spi.c                                                    |    2 
 drivers/misc/lis3lv02d/Kconfig                                             |    4 
 drivers/misc/mei/vsc-tp.c                                                  |    4 
 drivers/misc/vmw_vmci/vmci_host.c                                          |   11 
 drivers/mtd/nand/ecc-mxic.c                                                |    2 
 drivers/net/bonding/bond_main.c                                            |  144 +--
 drivers/net/dsa/b53/b53_common.c                                           |   92 +-
 drivers/net/dsa/b53/b53_priv.h                                             |    1 
 drivers/net/dsa/b53/b53_regs.h                                             |    7 
 drivers/net/dsa/bcm_sf2.c                                                  |    1 
 drivers/net/ethernet/airoha/airoha_eth.c                                   |   23 
 drivers/net/ethernet/airoha/airoha_eth.h                                   |   10 
 drivers/net/ethernet/airoha/airoha_ppe.c                                   |   32 
 drivers/net/ethernet/airoha/airoha_regs.h                                  |   10 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                            |   20 
 drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c           |   18 
 drivers/net/ethernet/google/gve/gve_main.c                                 |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                               |    3 
 drivers/net/ethernet/intel/e1000/e1000_main.c                              |    8 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                         |   11 
 drivers/net/ethernet/intel/iavf/iavf.h                                     |    1 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                             |   29 
 drivers/net/ethernet/intel/iavf/iavf_main.c                                |  300 ++-----
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                            |   17 
 drivers/net/ethernet/intel/ice/ice_main.c                                  |   47 -
 drivers/net/ethernet/intel/ice/ice_ptp.c                                   |    1 
 drivers/net/ethernet/intel/ice/ice_sched.c                                 |  181 +++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                 |   18 
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c                        |    9 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                |   45 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                |    8 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                            |    2 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                            |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                             |   41 -
 drivers/net/ethernet/intel/ixgbevf/ipsec.c                                 |   21 
 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c                     |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c                        |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c                   |   18 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c                           |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c                        |   22 
 drivers/net/ethernet/mediatek/mtk_star_emac.c                              |    4 
 drivers/net/ethernet/mellanox/mlx4/en_clock.c                              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c                   |   28 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h                   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                       |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                            |   12 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                          |   21 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                          |    5 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c                        |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c              |   14 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c                 |   55 +
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h                 |    9 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c             |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c              |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c             |   48 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h             |    6 
 drivers/net/ethernet/microchip/lan743x_main.c                              |   15 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                      |    7 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h                      |    6 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                       |   49 -
 drivers/net/ethernet/microchip/lan966x/lan966x_switchdev.c                 |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_vlan.c                      |   21 
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c                          |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c                           |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                          |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c                      |   11 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c                           |    2 
 drivers/net/ethernet/ti/icssg/icssg_stats.c                                |    8 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                          |    6 
 drivers/net/macsec.c                                                       |   40 -
 drivers/net/mctp/mctp-usb.c                                                |    2 
 drivers/net/netconsole.c                                                   |    3 
 drivers/net/netdevsim/ipsec.c                                              |   15 
 drivers/net/netdevsim/netdev.c                                             |    3 
 drivers/net/phy/mdio_bus.c                                                 |   12 
 drivers/net/phy/mediatek/Kconfig                                           |    3 
 drivers/net/phy/mscc/mscc_ptp.c                                            |   20 
 drivers/net/phy/phy_caps.c                                                 |   18 
 drivers/net/phy/phy_device.c                                               |    4 
 drivers/net/usb/aqc111.c                                                   |   10 
 drivers/net/vmxnet3/vmxnet3_drv.c                                          |   26 
 drivers/net/wireguard/device.c                                             |    1 
 drivers/net/wireless/ath/ath10k/snoc.c                                     |    4 
 drivers/net/wireless/ath/ath11k/core.c                                     |   37 
 drivers/net/wireless/ath/ath11k/core.h                                     |    4 
 drivers/net/wireless/ath/ath11k/debugfs.c                                  |  148 ---
 drivers/net/wireless/ath/ath11k/debugfs.h                                  |   10 
 drivers/net/wireless/ath/ath11k/mac.c                                      |   92 ++
 drivers/net/wireless/ath/ath11k/mac.h                                      |    4 
 drivers/net/wireless/ath/ath11k/wmi.c                                      |   47 +
 drivers/net/wireless/ath/ath12k/core.c                                     |   28 
 drivers/net/wireless/ath/ath12k/core.h                                     |   19 
 drivers/net/wireless/ath/ath12k/debugfs.c                                  |    4 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c                        |    3 
 drivers/net/wireless/ath/ath12k/dp.h                                       |    2 
 drivers/net/wireless/ath/ath12k/dp_mon.c                                   |  351 +++++++-
 drivers/net/wireless/ath/ath12k/dp_mon.h                                   |    4 
 drivers/net/wireless/ath/ath12k/dp_rx.c                                    |  234 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.h                                    |   29 
 drivers/net/wireless/ath/ath12k/dp_tx.c                                    |   23 
 drivers/net/wireless/ath/ath12k/hal.c                                      |  103 +-
 drivers/net/wireless/ath/ath12k/hal.h                                      |   64 -
 drivers/net/wireless/ath/ath12k/hal_desc.h                                 |    3 
 drivers/net/wireless/ath/ath12k/hal_rx.h                                   |   15 
 drivers/net/wireless/ath/ath12k/hw.c                                       |   35 
 drivers/net/wireless/ath/ath12k/hw.h                                       |   12 
 drivers/net/wireless/ath/ath12k/mac.c                                      |   86 +-
 drivers/net/wireless/ath/ath12k/mhi.c                                      |    7 
 drivers/net/wireless/ath/ath12k/pci.c                                      |   17 
 drivers/net/wireless/ath/ath12k/pci.h                                      |    4 
 drivers/net/wireless/ath/ath12k/reg.c                                      |    4 
 drivers/net/wireless/ath/ath12k/wmi.c                                      |   39 
 drivers/net/wireless/ath/ath12k/wmi.h                                      |   16 
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c                            |    3 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                             |    1 
 drivers/net/wireless/intel/iwlwifi/mld/mld.c                               |    3 
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                                |    2 
 drivers/net/wireless/marvell/mwifiex/11n.c                                 |    6 
 drivers/net/wireless/mediatek/mt76/channel.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mac80211.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                           |    6 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                           |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                            |   21 
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c                            |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                         |    1 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                           |   14 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                           |   23 
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                           |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                         |    4 
 drivers/net/wireless/realtek/rtw88/coex.c                                  |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                              |    3 
 drivers/net/wireless/realtek/rtw88/sdio.c                                  |   10 
 drivers/net/wireless/realtek/rtw89/fw.c                                    |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                                   |   36 
 drivers/net/wwan/mhi_wwan_mbim.c                                           |    9 
 drivers/net/wwan/t7xx/t7xx_netdev.c                                        |   11 
 drivers/nvme/host/constants.c                                              |    2 
 drivers/nvme/host/core.c                                                   |    1 
 drivers/nvme/host/ioctl.c                                                  |    2 
 drivers/nvme/host/pr.c                                                     |    2 
 drivers/nvme/target/core.c                                                 |    9 
 drivers/nvme/target/fcloop.c                                               |   31 
 drivers/nvme/target/io-cmd-bdev.c                                          |    9 
 drivers/nvmem/zynqmp_nvmem.c                                               |    1 
 drivers/of/unittest.c                                                      |   10 
 drivers/pci/controller/cadence/pcie-cadence-host.c                         |   11 
 drivers/pci/controller/dwc/pci-imx6.c                                      |   47 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                                |    1 
 drivers/pci/controller/pcie-apple.c                                        |    4 
 drivers/pci/controller/pcie-rockchip.h                                     |    7 
 drivers/pci/endpoint/pci-epf-core.c                                        |   22 
 drivers/pci/hotplug/pci_hotplug_core.c                                     |   69 +
 drivers/pci/hotplug/pciehp.h                                               |    1 
 drivers/pci/hotplug/pciehp_core.c                                          |   29 
 drivers/pci/hotplug/pciehp_hpc.c                                           |   78 +
 drivers/pci/pci-acpi.c                                                     |   23 
 drivers/pci/pci.c                                                          |    2 
 drivers/pci/pci.h                                                          |    3 
 drivers/pci/pcie/dpc.c                                                     |   68 -
 drivers/pci/pwrctrl/core.c                                                 |    2 
 drivers/perf/amlogic/meson_ddr_pmu_core.c                                  |    2 
 drivers/perf/arm-ni.c                                                      |   40 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                                    |    6 
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                      |   27 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                          |   13 
 drivers/pinctrl/mediatek/mtk-eint.c                                        |    4 
 drivers/pinctrl/mediatek/mtk-eint.h                                        |    2 
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c                           |    7 
 drivers/pinctrl/pinctrl-at91.c                                             |    6 
 drivers/pinctrl/qcom/pinctrl-qcm2290.c                                     |    9 
 drivers/pinctrl/qcom/pinctrl-qcs615.c                                      |    2 
 drivers/pinctrl/qcom/pinctrl-qcs8300.c                                     |    2 
 drivers/pinctrl/qcom/tlmm-test.c                                           |    1 
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c                             |   52 -
 drivers/pinctrl/samsung/pinctrl-exynos.c                                   |  260 +++---
 drivers/pinctrl/samsung/pinctrl-exynos.h                                   |    8 
 drivers/pinctrl/samsung/pinctrl-samsung.c                                  |   21 
 drivers/pinctrl/samsung/pinctrl-samsung.h                                  |    8 
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c                                   |    8 
 drivers/platform/chrome/cros_ec_typec.c                                    |    6 
 drivers/power/reset/at91-reset.c                                           |    5 
 drivers/power/supply/max77705_charger.c                                    |   20 
 drivers/ptp/ptp_private.h                                                  |   12 
 drivers/regulator/max20086-regulator.c                                     |    6 
 drivers/remoteproc/qcom_wcnss_iris.c                                       |    2 
 drivers/remoteproc/ti_k3_dsp_remoteproc.c                                  |    8 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                                   |  118 +--
 drivers/rpmsg/qcom_smd.c                                                   |    2 
 drivers/rtc/rtc-loongson.c                                                 |    8 
 drivers/rtc/rtc-sh.c                                                       |   12 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                      |   29 
 drivers/scsi/lpfc/lpfc_hbadisc.c                                           |   32 
 drivers/scsi/mpt3sas/mpt3sas_ctl.c                                         |    3 
 drivers/scsi/qedf/qedf_main.c                                              |    2 
 drivers/scsi/scsi_transport_iscsi.c                                        |   11 
 drivers/scsi/smartpqi/smartpqi_init.c                                      |    4 
 drivers/soc/aspeed/aspeed-lpc-snoop.c                                      |   17 
 drivers/soc/qcom/smp2p.c                                                   |    2 
 drivers/soundwire/generic_bandwidth_allocation.c                           |    7 
 drivers/spi/atmel-quadspi.c                                                |   17 
 drivers/spi/spi-bcm63xx-hsspi.c                                            |    2 
 drivers/spi/spi-bcm63xx.c                                                  |    2 
 drivers/spi/spi-omap2-mcspi.c                                              |   30 
 drivers/spi/spi-qpic-snand.c                                               |   44 -
 drivers/spi/spi-sh-msiof.c                                                 |   13 
 drivers/spi/spi-tegra210-quad.c                                            |   24 
 drivers/staging/gpib/ines/ines_gpib.c                                      |    2 
 drivers/staging/gpib/uapi/gpib_user.h                                      |    2 
 drivers/staging/media/rkvdec/rkvdec.c                                      |   10 
 drivers/thermal/mediatek/lvts_thermal.c                                    |   18 
 drivers/thunderbolt/usb4.c                                                 |    4 
 drivers/tty/serial/8250/8250_omap.c                                        |   25 
 drivers/tty/serial/milbeaut_usio.c                                         |    5 
 drivers/tty/vt/vt_ioctl.c                                                  |    2 
 drivers/ufs/core/ufs-mcq.c                                                 |    6 
 drivers/ufs/core/ufshcd.c                                                  |    7 
 drivers/ufs/host/ufs-qcom.c                                                |   92 +-
 drivers/usb/cdns3/cdnsp-gadget.c                                           |   21 
 drivers/usb/cdns3/cdnsp-gadget.h                                           |    4 
 drivers/usb/class/usbtmc.c                                                 |   17 
 drivers/usb/core/hub.c                                                     |   16 
 drivers/usb/core/usb-acpi.c                                                |    2 
 drivers/usb/gadget/function/f_hid.c                                        |   12 
 drivers/usb/gadget/udc/core.c                                              |    2 
 drivers/usb/misc/onboard_usb_dev.c                                         |  107 ++
 drivers/usb/renesas_usbhs/common.c                                         |   50 -
 drivers/usb/typec/bus.c                                                    |    2 
 drivers/usb/typec/tcpm/tcpci_maxim_core.c                                  |    3 
 drivers/usb/typec/tcpm/tcpm.c                                              |   91 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                             |   94 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h                             |   14 
 drivers/vfio/vfio_iommu_type1.c                                            |    2 
 drivers/video/backlight/qcom-wled.c                                        |    6 
 drivers/video/fbdev/core/fbcvt.c                                           |    2 
 drivers/virtio/virtio_pci_modern.c                                         |   13 
 drivers/watchdog/exar_wdt.c                                                |    2 
 drivers/watchdog/lenovo_se30_wdt.c                                         |    2 
 drivers/xen/balloon.c                                                      |   13 
 fs/9p/vfs_addr.c                                                           |    6 
 fs/afs/write.c                                                             |    9 
 fs/btrfs/extent-io-tree.c                                                  |    6 
 fs/btrfs/file.c                                                            |    2 
 fs/btrfs/inode.c                                                           |    7 
 fs/btrfs/scrub.c                                                           |   34 
 fs/btrfs/tree-log.c                                                        |   24 
 fs/cachefiles/io.c                                                         |   16 
 fs/ceph/addr.c                                                             |    6 
 fs/dax.c                                                                   |    2 
 fs/erofs/fscache.c                                                         |    6 
 fs/erofs/super.c                                                           |   49 +
 fs/f2fs/data.c                                                             |    6 
 fs/f2fs/f2fs.h                                                             |   46 -
 fs/f2fs/gc.c                                                               |    3 
 fs/f2fs/namei.c                                                            |   10 
 fs/f2fs/segment.c                                                          |   12 
 fs/f2fs/segment.h                                                          |   45 -
 fs/f2fs/super.c                                                            |   45 -
 fs/filesystems.c                                                           |   14 
 fs/gfs2/aops.c                                                             |   54 -
 fs/gfs2/aops.h                                                             |    3 
 fs/gfs2/bmap.c                                                             |    3 
 fs/gfs2/glock.c                                                            |    3 
 fs/gfs2/glops.c                                                            |    4 
 fs/gfs2/incore.h                                                           |    9 
 fs/gfs2/inode.c                                                            |   98 ++
 fs/gfs2/inode.h                                                            |    1 
 fs/gfs2/log.c                                                              |    7 
 fs/gfs2/meta_io.c                                                          |    2 
 fs/gfs2/meta_io.h                                                          |    4 
 fs/gfs2/ops_fstype.c                                                       |   35 
 fs/gfs2/super.c                                                            |   90 --
 fs/gfs2/sys.c                                                              |    1 
 fs/gfs2/trans.c                                                            |   21 
 fs/gfs2/trans.h                                                            |    2 
 fs/gfs2/xattr.c                                                            |   11 
 fs/gfs2/xattr.h                                                            |    2 
 fs/iomap/buffered-io.c                                                     |    2 
 fs/kernfs/dir.c                                                            |    5 
 fs/kernfs/file.c                                                           |    3 
 fs/mount.h                                                                 |    5 
 fs/namespace.c                                                             |  118 +--
 fs/netfs/buffered_read.c                                                   |   32 
 fs/netfs/buffered_write.c                                                  |    2 
 fs/netfs/direct_read.c                                                     |   13 
 fs/netfs/direct_write.c                                                    |   12 
 fs/netfs/fscache_io.c                                                      |   10 
 fs/netfs/internal.h                                                        |   42 -
 fs/netfs/main.c                                                            |    1 
 fs/netfs/misc.c                                                            |  219 +++++
 fs/netfs/objects.c                                                         |   48 -
 fs/netfs/read_collect.c                                                    |  185 ----
 fs/netfs/read_pgpriv2.c                                                    |    4 
 fs/netfs/read_retry.c                                                      |   26 
 fs/netfs/read_single.c                                                     |    6 
 fs/netfs/write_collect.c                                                   |   81 --
 fs/netfs/write_issue.c                                                     |   38 
 fs/netfs/write_retry.c                                                     |   19 
 fs/nfs/fscache.c                                                           |    1 
 fs/nfs/localio.c                                                           |   45 -
 fs/nfs/nfs4proc.c                                                          |   32 
 fs/nfs/super.c                                                             |   19 
 fs/nfs_common/nfslocalio.c                                                 |   99 +-
 fs/nfsd/filecache.c                                                        |   32 
 fs/nfsd/filecache.h                                                        |    3 
 fs/nfsd/localio.c                                                          |   70 +
 fs/nilfs2/btree.c                                                          |    4 
 fs/nilfs2/direct.c                                                         |    3 
 fs/ntfs3/index.c                                                           |    8 
 fs/ntfs3/inode.c                                                           |    5 
 fs/ocfs2/quota_local.c                                                     |    2 
 fs/pidfs.c                                                                 |    2 
 fs/pnode.c                                                                 |    4 
 fs/smb/client/cifsproto.h                                                  |    3 
 fs/smb/client/cifssmb.c                                                    |   24 
 fs/smb/client/file.c                                                       |   19 
 fs/smb/client/smb2pdu.c                                                    |    4 
 fs/squashfs/super.c                                                        |    5 
 fs/xfs/xfs_aops.c                                                          |   22 
 fs/xfs/xfs_discard.c                                                       |   17 
 include/crypto/sig.h                                                       |    2 
 include/hyperv/hvgdk_mini.h                                                |    2 
 include/kunit/clk.h                                                        |    1 
 include/linux/arm_sdei.h                                                   |    4 
 include/linux/bio.h                                                        |    2 
 include/linux/bpf_verifier.h                                               |   12 
 include/linux/bvec.h                                                       |    7 
 include/linux/coresight.h                                                  |    2 
 include/linux/exportfs.h                                                   |   10 
 include/linux/fscache.h                                                    |    2 
 include/linux/hid.h                                                        |    3 
 include/linux/ieee80211.h                                                  |   79 +-
 include/linux/iomap.h                                                      |    5 
 include/linux/mdio.h                                                       |    5 
 include/linux/mlx5/driver.h                                                |    1 
 include/linux/mm.h                                                         |   58 +
 include/linux/mount.h                                                      |   88 +-
 include/linux/netdevice.h                                                  |   10 
 include/linux/netfs.h                                                      |   15 
 include/linux/nfslocalio.h                                                 |   26 
 include/linux/nvme.h                                                       |    2 
 include/linux/overflow.h                                                   |   27 
 include/linux/pci-epf.h                                                    |    3 
 include/linux/pci.h                                                        |    8 
 include/linux/phy.h                                                        |    5 
 include/linux/pm_runtime.h                                                 |    4 
 include/linux/poison.h                                                     |    4 
 include/linux/virtio_vsock.h                                               |    1 
 include/net/bluetooth/hci.h                                                |    3 
 include/net/bluetooth/hci_core.h                                           |   50 -
 include/net/checksum.h                                                     |    2 
 include/net/netfilter/nft_fib.h                                            |    9 
 include/net/page_pool/types.h                                              |    6 
 include/net/sock.h                                                         |    7 
 include/net/xfrm.h                                                         |   11 
 include/sound/hdaudio.h                                                    |    4 
 include/sound/hdaudio_ext.h                                                |    6 
 include/trace/events/netfs.h                                               |    8 
 include/uapi/drm/xe_drm.h                                                  |    5 
 include/uapi/linux/bits.h                                                  |    4 
 include/uapi/linux/bpf.h                                                   |    4 
 io_uring/fdinfo.c                                                          |   12 
 io_uring/io_uring.c                                                        |   18 
 io_uring/register.c                                                        |    7 
 io_uring/sqpoll.c                                                          |   43 -
 io_uring/sqpoll.h                                                          |    8 
 kernel/bpf/core.c                                                          |   29 
 kernel/bpf/verifier.c                                                      |   18 
 kernel/events/core.c                                                       |   50 -
 kernel/power/energy_model.c                                                |    4 
 kernel/power/hibernate.c                                                   |    5 
 kernel/power/main.c                                                        |    3 
 kernel/power/power.h                                                       |    4 
 kernel/power/wakelock.c                                                    |    3 
 kernel/rcu/tree.c                                                          |   10 
 kernel/rcu/tree.h                                                          |    2 
 kernel/rcu/tree_stall.h                                                    |    4 
 kernel/sched/core.c                                                        |   12 
 kernel/sched/ext_idle.c                                                    |    8 
 kernel/sched/fair.c                                                        |   13 
 kernel/time/posix-cpu-timers.c                                             |    9 
 kernel/trace/bpf_trace.c                                                   |   10 
 kernel/trace/ring_buffer.c                                                 |   41 -
 kernel/trace/trace.h                                                       |    8 
 kernel/trace/trace_events_hist.c                                           |  122 ++-
 kernel/trace/trace_events_trigger.c                                        |   20 
 lib/Kconfig.ubsan                                                          |    2 
 lib/iov_iter.c                                                             |    2 
 lib/kunit/static_stub.c                                                    |    2 
 lib/tests/usercopy_kunit.c                                                 |    1 
 mm/filemap.c                                                               |   20 
 mm/page_alloc.c                                                            |    8 
 net/9p/client.c                                                            |    6 
 net/bluetooth/eir.c                                                        |   17 
 net/bluetooth/eir.h                                                        |    2 
 net/bluetooth/hci_conn.c                                                   |   46 -
 net/bluetooth/hci_core.c                                                   |   50 -
 net/bluetooth/hci_event.c                                                  |   40 -
 net/bluetooth/hci_sync.c                                                   |   88 +-
 net/bluetooth/iso.c                                                        |   13 
 net/bluetooth/l2cap_core.c                                                 |    3 
 net/bluetooth/mgmt.c                                                       |  146 +--
 net/bluetooth/mgmt_util.c                                                  |   34 
 net/bluetooth/mgmt_util.h                                                  |    4 
 net/bridge/netfilter/nf_conntrack_bridge.c                                 |   12 
 net/core/dev.c                                                             |    2 
 net/core/filter.c                                                          |    5 
 net/core/net_namespace.c                                                   |    4 
 net/core/netmem_priv.h                                                     |   33 
 net/core/page_pool.c                                                       |  108 ++
 net/core/rtnetlink.c                                                       |    2 
 net/core/skbuff.c                                                          |   16 
 net/core/skmsg.c                                                           |   53 -
 net/core/sock.c                                                            |    8 
 net/core/utils.c                                                           |    4 
 net/core/xdp.c                                                             |    4 
 net/dsa/tag_brcm.c                                                         |    2 
 net/ethtool/ioctl.c                                                        |    3 
 net/ipv4/netfilter/nft_fib_ipv4.c                                          |   11 
 net/ipv4/udp_offload.c                                                     |    5 
 net/ipv6/ila/ila_common.c                                                  |    6 
 net/ipv6/netfilter.c                                                       |   12 
 net/ipv6/netfilter/nft_fib_ipv6.c                                          |   17 
 net/ipv6/seg6_local.c                                                      |    6 
 net/mac80211/mlme.c                                                        |    7 
 net/mac80211/scan.c                                                        |   11 
 net/ncsi/internal.h                                                        |   21 
 net/ncsi/ncsi-pkt.h                                                        |   23 
 net/ncsi/ncsi-rsp.c                                                        |   21 
 net/netfilter/nf_nat_core.c                                                |   12 
 net/netfilter/nft_quota.c                                                  |   20 
 net/netfilter/nft_set_pipapo.c                                             |   58 +
 net/netfilter/nft_set_pipapo_avx2.c                                        |   21 
 net/netfilter/nft_tunnel.c                                                 |    8 
 net/netfilter/xt_TCPOPTSTRIP.c                                             |    4 
 net/netfilter/xt_mark.c                                                    |    2 
 net/netlabel/netlabel_kapi.c                                               |    5 
 net/openvswitch/flow.c                                                     |    2 
 net/packet/af_packet.c                                                     |   21 
 net/packet/internal.h                                                      |    1 
 net/sched/sch_ets.c                                                        |    2 
 net/sched/sch_prio.c                                                       |    2 
 net/sched/sch_red.c                                                        |    2 
 net/sched/sch_sfq.c                                                        |    5 
 net/sched/sch_tbf.c                                                        |    2 
 net/sunrpc/xprtrdma/svc_rdma_transport.c                                   |   14 
 net/tipc/crypto.c                                                          |    6 
 net/tls/tls_sw.c                                                           |   15 
 net/vmw_vsock/virtio_transport_common.c                                    |   26 
 net/wireless/scan.c                                                        |   18 
 net/xfrm/xfrm_device.c                                                     |    6 
 net/xfrm/xfrm_state.c                                                      |   16 
 rust/Makefile                                                              |   14 
 rust/kernel/alloc/kvec.rs                                                  |    3 
 rust/kernel/fs/file.rs                                                     |    1 
 rust/kernel/list/arc.rs                                                    |    2 
 rust/kernel/miscdevice.rs                                                  |    2 
 rust/kernel/pci.rs                                                         |   15 
 scripts/gcc-plugins/gcc-common.h                                           |   32 
 scripts/gcc-plugins/randomize_layout_plugin.c                              |   40 -
 scripts/generate_rust_analyzer.py                                          |   13 
 scripts/genksyms/genksyms.c                                                |   27 
 sound/core/seq_device.c                                                    |    2 
 sound/hda/ext/hdac_ext_controller.c                                        |   19 
 sound/hda/hda_bus_type.c                                                   |    6 
 sound/pci/hda/hda_bind.c                                                   |    4 
 sound/soc/apple/mca.c                                                      |   23 
 sound/soc/codecs/hda.c                                                     |    4 
 sound/soc/codecs/tas2764.c                                                 |    5 
 sound/soc/intel/avs/avs.h                                                  |    4 
 sound/soc/intel/avs/core.c                                                 |   51 -
 sound/soc/intel/avs/debugfs.c                                              |    6 
 sound/soc/intel/avs/ipc.c                                                  |    4 
 sound/soc/intel/avs/loader.c                                               |   11 
 sound/soc/intel/avs/path.c                                                 |    8 
 sound/soc/intel/avs/pcm.c                                                  |  129 ++-
 sound/soc/intel/avs/registers.h                                            |    2 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                                  |    4 
 sound/soc/sof/amd/pci-acp70.c                                              |    1 
 sound/soc/sof/ipc4-pcm.c                                                   |    3 
 sound/soc/ti/omap-hdmi.c                                                   |    7 
 sound/usb/implicit.c                                                       |    1 
 sound/usb/midi.c                                                           |    3 
 tools/arch/x86/kcpuid/kcpuid.c                                             |   47 -
 tools/arch/x86/lib/x86-opcode-map.txt                                      |   50 -
 tools/bpf/bpftool/cgroup.c                                                 |    2 
 tools/bpf/resolve_btfids/Makefile                                          |    2 
 tools/build/Makefile.feature                                               |    4 
 tools/include/uapi/linux/bpf.h                                             |    4 
 tools/lib/bpf/bpf_core_read.h                                              |    6 
 tools/lib/bpf/libbpf.c                                                     |   57 -
 tools/lib/bpf/libbpf_internal.h                                            |    9 
 tools/lib/bpf/linker.c                                                     |    6 
 tools/lib/bpf/nlattr.c                                                     |   15 
 tools/objtool/check.c                                                      |    3 
 tools/perf/MANIFEST                                                        |    6 
 tools/perf/Makefile.config                                                 |    6 
 tools/perf/Makefile.perf                                                   |    3 
 tools/perf/builtin-record.c                                                |    2 
 tools/perf/builtin-trace.c                                                 |   11 
 tools/perf/scripts/python/exported-sql-viewer.py                           |    5 
 tools/perf/tests/shell/lib/stat_output.sh                                  |    5 
 tools/perf/tests/shell/stat+json_output.sh                                 |    5 
 tools/perf/tests/switch-tracking.c                                         |    2 
 tools/perf/ui/browsers/hists.c                                             |    2 
 tools/perf/util/intel-pt.c                                                 |  205 +++++
 tools/perf/util/machine.c                                                  |    6 
 tools/perf/util/pmu.c                                                      |    3 
 tools/perf/util/symbol-minimal.c                                           |  160 +---
 tools/perf/util/thread.c                                                   |    8 
 tools/perf/util/thread.h                                                   |    2 
 tools/perf/util/tool_pmu.c                                                 |    8 
 tools/power/x86/turbostat/turbostat.c                                      |   41 -
 tools/testing/kunit/qemu_configs/sparc.py                                  |    2 
 tools/testing/selftests/Makefile                                           |    2 
 tools/testing/selftests/arm64/fp/fp-ptrace.c                               |   14 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                            |    6 
 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c                   |    2 
 tools/testing/selftests/bpf/progs/verifier_load_acquire.c                  |   40 -
 tools/testing/selftests/bpf/progs/verifier_store_release.c                 |   32 
 tools/testing/selftests/bpf/test_loader.c                                  |   14 
 tools/testing/selftests/coredump/stackdump_test.c                          |   10 
 tools/testing/selftests/cpufreq/cpufreq.sh                                 |    3 
 tools/testing/selftests/drivers/net/hw/tso.py                              |    4 
 tools/testing/selftests/seccomp/seccomp_bpf.c                              |   13 
 tools/tracing/rtla/src/timerlat_bpf.c                                      |    1 
 801 files changed, 9798 insertions(+), 5378 deletions(-)

Aaradhana Sahu (1):
      wifi: ath12k: Resolve multicast packet drop by populating key_cipher in ath12k_install_key()

Aaron Kling (2):
      arm64: tegra: Drop remaining serial clock-names and reset-names
      arm64: tegra: Add uartd serial alias for Jetson TX1 module

Abel Vesa (2):
      arm64: dts: qcom: x1e001de-devkit: Describe USB retimers resets pin configs
      arm64: dts: qcom: x1e001de-devkit: Fix pin config for USB0 retimer vregs

Adam Ford (5):
      arm64: dts: imx8mm-beacon: Fix RTC capacitive load
      arm64: dts: imx8mn-beacon: Fix RTC capacitive load
      arm64: dts: imx8mp-beacon: Fix RTC capacitive load
      arm64: dts: imx8mm-beacon: Set SAI5 MCLK direction to output for HDMI audio
      arm64: dts: imx8mn-beacon: Set SAI5 MCLK direction to output for HDMI audio

Aditya Kumar Singh (2):
      wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
      wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling

Adrian Hunter (2):
      perf intel-pt: Fix PEBS-via-PT data_src
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Ahmed S. Darwish (2):
      tools/x86/kcpuid: Fix error handling
      x86/cpu: Sanitize CPUID(0x80000000) output

Ahmed Zaki (1):
      iavf: fix reset_task for early reset event

Al Viro (8):
      fs/fhandle.c: fix a race in call of has_locked_children()
      path_overmount(): avoid false negatives
      finish_automount(): don't leak MNT_LOCKED from parent to child
      fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
      clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns
      do_change_type(): refuse to operate on unmounted/not ours mounts
      Don't propagate mounts into detached trees
      do_move_mount(): split the checks in subtree-of-our-ns and entire-anon cases

Aleksandrs Vinarskis (3):
      drm/msm/dp: Fix support of LTTPR initialization
      drm/msm/dp: Account for LTTPRs capabilities
      drm/msm/dp: Prepare for link training per-segment for LTTPRs

Alexander Shiyan (1):
      power: reset: at91-reset: Optimize at91_reset()

Alexander Sverdlin (1):
      counter: interrupt-cnt: Protect enable/disable OPs with mutex

Alexandre Ghiti (1):
      ACPI: platform_profile: Avoid initializing on non-ACPI platforms

Alexei Safin (1):
      hwmon: (asus-ec-sensors) check sensor index in read_string()

Alexey Gladkov (1):
      mfd: stmpe-spi: Correct the name used in MODULE_DEVICE_TABLE

Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Alexey Minnekhanov (3):
      arm64: dts: qcom: sdm660-xiaomi-lavender: Add missing SD card detect GPIO
      arm64: dts: qcom: sdm660-lavender: Add missing USB phy supply
      arm64: dts: qcom: sda660-ifc6560: Fix dt-validate warning

Alexis Lothoré (2):
      net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

Alistair Popple (1):
      fs/dax: Fix "don't skip locked entries when scanning entries"

Alok Tiwari (3):
      gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
      gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO
      scsi: iscsi: Fix incorrect error path labels for flashnode operations

Amadeusz Sławiński (1):
      ASoC: Intel: avs: Fix paths in MODULE_FIRMWARE hints

Amir Goldstein (1):
      exportfs: require ->fh_to_parent() to encode connectable file handles

Amir Tzin (1):
      net/mlx5: Fix ECVF vports unload on shutdown flow

Amit Sunil Dhamne (1):
      usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()

Anand Moon (1):
      perf/amlogic: Replace smp_processor_id() with raw_smp_processor_id() in meson_ddr_pmu_create()

Andre Przywara (2):
      arm64: dts: allwinner: a100: set maximum MMC frequency
      dt-bindings: vendor-prefixes: Add Liontron name

Andrea Righi (1):
      sched_ext: idle: Skip cross-node search with !CONFIG_NUMA

Andreas Gruenbacher (7):
      gfs2: replace sd_aspace with sd_inode
      gfs2: gfs2_create_inode error handling fix
      gfs2: Move gfs2_dinode_dealloc
      gfs2: Move GIF_ALLOC_FAILED check out of gfs2_ea_dealloc
      gfs2: deallocate inodes in gfs2_create_inode
      gfs2: Move gfs2_trans_add_databufs
      gfs2: Don't start unnecessary transactions during log flush

Andrew Cooper (1):
      x86/idle: Remove MFENCEs for X86_BUG_CLFLUSH_MONITOR in mwait_idle_with_hints() and prefer_mwait_c1_over_halt()

Andrew Price (1):
      gfs2: Don't clear sb->s_fs_info in gfs2_sys_fs_add

Andrey Vatoropin (1):
      fs/ntfs3: handle hdr_first_de() return value

André Draszik (2):
      firmware: exynos-acpm: fix reading longer results
      firmware: exynos-acpm: silence EPROBE_DEFER error on boot

Andy Shevchenko (1):
      pinctrl: at91: Fix possible out-of-boundary access

Angelo Dureghello (1):
      iio: dac: adi-axi-dac: fix bus read

AngeloGioacchino Del Regno (5):
      thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure
      drm/mediatek: mtk_drm_drv: Fix kobject put for mtk_mutex device ptr
      drm/mediatek: Fix kobject put for component sub-drivers
      drm/mediatek: mtk_drm_drv: Unbind secondary mmsys components on err
      arm64: dts: mediatek: mt8195: Reparent vdec1/2 and venc1 power domains

Annie Li (1):
      x86/microcode/AMD: Do not return error when microcode update is not necessary

Anton Nadezhdin (1):
      ice/ptp: fix crosstimestamp reporting

Anton Protopopov (3):
      libbpf: Use proper errno value in linker
      bpf: Fix uninitialized values in BPF_{CORE,PROBE}_READ
      libbpf: Use proper errno value in nlattr

Antoniu Miclaus (1):
      iio: adc: ad4851: fix ad4858 chan pointer handling

Anubhav Shelat (2):
      perf trace: Always print return value for syscalls returning a pid
      perf trace: Set errpid to false for rseq and set_robust_list

Aradhya Bhatia (1):
      drm/xe/guc: Make creation of SLPC debugfs files conditional

Armin Wolf (2):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
      ACPI: thermal: Execute _SCP before reading trip points

Arnaldo Carvalho de Melo (5):
      tools build: Don't set libunwind as available if test-all.c build succeeds
      tools build: Don't show libunwind build status as it is opt-in
      perf build: Warn when libdebuginfod devel files are not available
      tools build: Don't show libbfd build status as it is opt-in
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()

Arnd Bergmann (6):
      drm: xlnx: zynqmp_dpsub: fix Kconfig dependencies for ASoC
      iommu: ipmmu-vmsa: avoid Wformat-security warning
      iommu/io-pgtable-arm: dynamically allocate selftest device struct
      drm/xe/vsec: fix CONFIG_INTEL_VSEC dependency
      usb: misc: onboard_usb_dev: fix build warning for CONFIG_USB_ONBOARD_DEV_USB5744=n
      thermal/drivers/mediatek/lvts: Remove unused lvts_debugfs_exit

Badal Nilawar (1):
      drm/xe/d3cold: Set power state to D3Cold during s2idle/s3

Baochen Qiang (5):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started
      wifi: ath11k: move some firmware stats related functions outside of debugfs
      wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Bard Liao (1):
      soundwire: only compute port params in specific stream states

Barnabás Czémán (1):
      soc: qcom: smp2p: Fix fallback to qcom,ipc parse

Beleswar Padhi (1):
      remoteproc: k3-r5: Refactor sequential core power up/down operations

Bence Csókás (2):
      PM: runtime: Add new devm functions
      spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

Benjamin Marzinski (7):
      dm: don't change md if dm_table_set_restrictions() fails
      dm: free table mempools if not used in __bind
      dm: handle failures in dm_table_set_restrictions
      dm: fix dm_blk_report_zones
      dm: limit swapping tables for devices with zone write plugs
      dm-flakey: error all IOs when num_features is absent
      dm-flakey: make corrupting read bios work

Benno Lossin (1):
      rust: list: fix path of `assert_pinned!`

Benson Leung (1):
      platform/chrome: cros_ec_typec: Set Pin Assignment E in DP PORT VDO

Biju Das (2):
      drm: rcar-du: Fix memory leak in rcar_du_vsps_init()
      drm/tegra: rgb: Fix the unbound reference count

Bjorn Helgaas (2):
      PCI/DPC: Initialize aer_err_info before using it
      PCI/DPC: Log Error Source ID only when valid

Boris Brezillon (4):
      drm/panthor: Fix GPU_COHERENCY_ACE[_LITE] definitions
      drm/panthor: Call panthor_gpu_coherency_init() after PM resume()
      drm/panthor: Update panthor_mmu::irq::mask when needed
      drm/panthor: Fix the panthor_gpu_coherency_init() error path

Brian Norris (1):
      PCI/pwrctrl: Cancel outstanding rescan work when unregistering

Brian Pellegrino (1):
      iio: filter: admv8818: Support frequencies >= 2^32

Brian Vazquez (1):
      idpf: fix a race in txq wakeup

Bui Quang Minh (1):
      selftests: net: build net/lib dependency in all target

Caleb Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Caleb Sander Mateos (1):
      block: flip iter directions in blk_rq_integrity_map_user()

Can Guo (1):
      scsi: ufs: qcom: Map devfreq OPP freq to UniPro Core Clock freq

Carlos Fernandez (1):
      macsec: MACsec SCI assignment for ES = 0

Carlos Llamas (1):
      libbpf: Fix implicit memfd_create() for bionic

Casey Connolly (1):
      drm/panel: samsung-sofef00: Drop s6e3fc2x01 support

Cezary Rojewski (11):
      ASoC: codecs: hda: Fix RPM usage count underflow
      ASoC: Intel: avs: Fix deadlock when the failing IPC is SET_D0IX
      ALSA: hda: Allow to fetch hlink by ID
      ASoC: Intel: avs: PCM operations for LNL-based platforms
      ASoC: Intel: avs: Fix PPLCxFMT calculation
      ASoC: Intel: avs: Fix possible null-ptr-deref when initing hw
      ASoC: Intel: avs: Ignore Vendor-space manipulation for ACE
      ASoC: Intel: avs: Read HW capabilities when possible
      ASoC: Intel: avs: Relocate DSP status registers
      ASoC: Intel: avs: Verify kcalloc() status when setting constraints
      ASoC: Intel: avs: Verify content returned by parse_int_array()

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
      Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition

Chao Yu (6):
      f2fs: zone: fix to avoid inconsistence in between SIT and SSA
      f2fs: fix to do sanity check on sbi->total_valid_block_count
      f2fs: clean up w/ fscrypt_is_bounce_page()
      f2fs: fix to detect gcing page in f2fs_is_cp_guaranteed()
      f2fs: zone: fix to calculate first_zoned_segno correctly
      f2fs: fix to skip f2fs_balance_fs() if checkpoint is disabled

Charalampos Mitrodimas (1):
      net: tipc: fix refcount warning in tipc_aead_encrypt

Charles Han (3):
      drm/amd/pp: Fix potential NULL pointer dereference in atomctrl_initialize_mc_reg_table
      pinctrl: qcom: tlmm-test: Fix potential null dereference in tlmm kunit test
      wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init

Chen-Yu Tsai (2):
      arm64: dts: mediatek: mt8188: Fix IOMMU device for rdma0
      pinctrl: sunxi: dt: Consider pin base when calculating bank number from pin

Chenyuan Yang (2):
      phy: qcom-qmp-usb: Fix an NULL vs IS_ERR() bug
      usb: acpi: Prevent null pointer dereference in usb_acpi_add_usb4_devlink()

Chin-Yen Lee (1):
      wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

Christian Brauner (1):
      gfs2: pass through holder from the VFS for freeze/thaw

Christian Marangi (1):
      net: phy: mediatek: permit to compile test GE SOC PHY driver

Christian Schrefl (1):
      rust: miscdevice: fix typo in MiscDevice::ioctl documentation

Christoph Hellwig (1):
      block: don't use submit_bio_noacct_nocheck in blk_zone_wplug_bio_work

Christophe JAILLET (5):
      drm/bridge: lt9611uxc: Fix an error handling path in lt9611uxc_probe()
      net: airoha: Fix an error handling path in airoha_alloc_gdm_port()
      mfd: exynos-lpass: Fix an error handling path in exynos_lpass_probe()
      mfd: exynos-lpass: Avoid calling exynos_lpass_disable() twice in exynos_lpass_remove()
      mfd: exynos-lpass: Fix another error handling path in exynos_lpass_probe()

Chuck Lever (1):
      svcrdma: Reduce the number of rdma_rw contexts per-QP

Chukun Pan (2):
      arm64: dts: rockchip: Add missing uart3 interrupt for RK3528
      arm64: dts: rockchip: Move SHMEM memory to reserved memory on rk3588

Corentin Labbe (1):
      crypto: sun8i-ss - do not use sg_dma_len before calling DMA functions

Cosmin Ratiu (5):
      net/mlx5: Avoid using xso.real_dev unnecessarily
      xfrm: Use xdo.dev instead of xdo.real_dev
      xfrm: Add explicit dev to .xdo_dev_state_{add,delete,free}
      bonding: Mark active offloaded xfrm_states
      bonding: Fix multiple long standing offload races

Cristian Ciocaltea (2):
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Do no set rk_hdptx_phy->rate in case of errors

Damon Ding (3):
      drm/bridge: analogix_dp: Remove the unnecessary calls to clk_disable_unprepare() during probing
      drm/bridge: analogix_dp: Remove CONFIG_PM related check in analogix_dp_bind()/analogix_dp_unbind()
      drm/bridge: analogix_dp: Add support to get panel from the DP AUX bus

Dan Carpenter (8):
      power: supply: max77705: Fix workqueue error handling in probe
      wifi: ath12k: Fix buffer overflow in debugfs
      of: unittest: Unlock on error in unittest_data_add()
      wifi: mt76: mt7925: Fix logical vs bitwise typo
      remoteproc: qcom_wcnss_iris: Add missing put_device() on error in probe
      rpmsg: qcom_smd: Fix uninitialized return variable in __qcom_smd_send()
      net/mlx4_en: Prevent potential integer overflow calculating Hz
      regulator: max20086: Fix refcount leak in max20086_parse_regulators_dt()

Daniel Wagner (1):
      nvmet-fcloop: access fcpreq only when holding reqlock

Daniele Ceraolo Spurio (2):
      drm/xe/pxp: Use the correct define in the set_property_funcs array
      drm/xe/pxp: Clarify PXP queue creation behavior if PXP is not ready

Daniele Palmas (1):
      net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing

Daniil Tatianin (1):
      ACPICA: exserial: don't forget to handle FFixedHW opregions for reading

Danilo Krummrich (1):
      rust: alloc: add missing invariant in Vec::set_len()

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Dave Chinner (1):
      xfs: don't assume perags are initialised when trimming AGs

Dave Penkler (3):
      staging: gpib: Fix PCMCIA config identifier
      staging: gpib: Fix secondary address restriction
      usb: usbtmc: Fix read_stb function and get_stb ioctl

David Gow (1):
      kunit: qemu_configs: Disable faulting tests on 32-bit SPARC

David Heimann (1):
      ALSA: usb-audio: Add implicit feedback quirk for RODE AI-1

David Hildenbrand (3):
      s390/uv: Don't return 0 from make_hva_secure() if the operation was not successful
      s390/uv: Always return 0 from s390_wiggle_split_folio() if successful
      s390/uv: Improve splitting of large folios that cannot be split while dirty

David Howells (5):
      crypto/krb5: Fix change to use SG miter to use offset
      netfs: Fix oops in write-retry from mis-resetting the subreq iterator
      netfs: Fix the request's work item to not require a ref
      netfs: Fix wait/wake to be consistent about the waitqueue used
      netfs: Fix undifferentiation of DIO reads from unbuffered reads

David Thompson (1):
      EDAC/bluefield: Don't use bluefield_edac_readl() result on error

Detlev Casanova (1):
      media: verisilicon: Free post processor buffers on error

Di Shen (1):
      bpf: Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic"

Dibin Moolakadan Subrahmanian (1):
      drm/i915/display: Fix u32 overflow in SNPS PHY HDMI PLL setup

Dmitry Antipov (4):
      wifi: rtw88: do not ignore hardware read error during DPK
      Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
      Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands
      ring-buffer: Fix buffer locking in ring_buffer_subbuf_order_set()

Dmitry Baryshkov (9):
      drm/msm/dpu: enable SmartDMA on SM8150
      drm/msm/dpu: enable SmartDMA on SC8180X
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8937
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8917
      drm/msm/dpu: remove DSC feature bit for PINGPONG on MSM8953
      ARM: dts: qcom: apq8064: add missing clocks to the timer node
      ARM: dts: qcom: apq8064 merge hw splinlock into corresponding syscon device
      ARM: dts: qcom: apq8064: move replicator out of soc node
      arm64: dts: qcom: qcm2290: fix (some) of QUP interconnects

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Dzmitry Sankouski (4):
      arm64: dts: qcom: sdm845-starqltechn: remove wifi
      arm64: dts: qcom: sdm845-starqltechn: fix usb regulator mistake
      arm64: dts: qcom: sdm845-starqltechn: refactor node order
      arm64: dts: qcom: sdm845-starqltechn: remove excess reserved gpios

Eddie James (1):
      powerpc/crash: Fix non-smp kexec preparation

Emil Tantilov (1):
      idpf: avoid mailbox timeout delays during reset

Eric Dumazet (8):
      net: annotate data-races around cleanup_net_task
      net: prevent a NULL deref in rtnl_create_link()
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      net_sched: ets: fix a race in ets_qdisc_change()
      calipso: unlock rcu before returning -EAFNOSUPPORT

Faicker Mo (1):
      net: openvswitch: Fix the dead loop of MPLS parse

Feng Jiang (1):
      wifi: mt76: scan: Fix 'mlink' dereferenced before IS_ERR_OR_NULL check

Feng Yang (1):
      libbpf: Fix event name too long error

Fernando Fernandez Mancera (1):
      netfilter: nft_tunnel: fix geneve_opt dump

Filipe Manana (5):
      btrfs: fix invalid data space release when truncating block in NOCOW mode
      btrfs: fix wrong start offset for delalloc space release during mmap write
      btrfs: exit after state insertion failure at btrfs_convert_extent_bit()
      btrfs: fix fsync of files with no hard links not persisting deletion
      btrfs: exit after state split error at set_extent_bit()

Finn Thain (1):
      m68k: mac: Fix macintosh_config for Mac II

Florian Westphal (5):
      netfilter: xtables: support arpt_mark and ipv6 optstrip for iptables-nft only builds
      netfilter: nf_tables: nft_fib_ipv6: fix VRF ipv4/ipv6 result discrepancy
      netfilter: nf_tables: nft_fib: consistent l3mdev handling
      netfilter: nf_set_pipapo_avx2: fix initial map fill
      netfilter: nf_nat: also check reverse tuple to obtain clashing entry

Francesco Dolcini (1):
      Revert "wifi: mwifiex: Fix HT40 bandwidth issue."

Félix Piédallu (2):
      spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
      spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted

Gabor Juhos (2):
      spi: spi-qpic-snand: use kmalloc() for OOB buffer allocation
      spi: spi-qpic-snand: validate user/chip specific ECC properties

Gabriel Dalimonte (1):
      drm/vc4: fix infinite EPROBE_DEFER loop

Gal Pressman (1):
      net: ethtool: Don't check if RSS context exists in case of context 0

Gary Guo (1):
      rust: compile libcore with edition 2024 for 1.87+

Gaurav Batra (1):
      powerpc/pseries/iommu: Fix kmemleak in TCE table userspace view

Gautam R A (2):
      RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
      RDMA/bnxt_re: Fix missing error handling for tx_queue

Gautham R. Shenoy (1):
      tools/power turbostat: Fix AMD package-energy reporting

Geert Uytterhoeven (4):
      spi: sh-msiof: Fix maximum DMA transfer size
      arm64: dts: renesas: white-hawk-single: Improve Ethernet TSN description
      HID: HID_APPLETB_KBD should depend on X86
      HID: HID_APPLETB_BL should depend on X86

Greg Kroah-Hartman (5):
      ALSA: core: fix up bus match const issues.
      net: phy: fix up const issues in to_mdio_device() and to_phy_device()
      USB: gadget: udc: fix const issue in gadget_match_driver()
      USB: typec: fix const issue in typec_match()
      Linux 6.15.3

Gustavo A. R. Silva (1):
      overflow: Fix direct struct member initialization in _DEFINE_FLEX()

Gustavo Luiz Duarte (1):
      netconsole: fix appending sysdata when sysdata_fields == SYSDATA_RELEASE

Hangbin Liu (1):
      bonding: assign random address if device address is same as bond

Hans Zhang (2):
      efi/libstub: Describe missing 'out' parameter in efi_load_initrd
      PCI: cadence: Fix runtime atomic count underflow

Hans de Goede (1):
      mei: vsc: Cast tx_buf to (__be32 *) when passed to cpu_to_be32_array()

Hao Chang (1):
      pinctrl: mediatek: Fix the invalid conditions

Haren Myneni (1):
      powerpc/vas: Return -EINVAL if the offset is non-zero in mmap()

Hari Kalavakunta (1):
      net: ncsi: Fix GCPS 64-bit member variables

Hariprasad Kelam (2):
      octeontx2-pf: QOS: Perform cache sync on send queue teardown
      octeontx2-pf: QOS: Refactor TC_HTB_LEAF_DEL_LAST callback

Harry Wentland (1):
      drm/amd/display: Don't check for NULL divisor in fixpt code

Hector Martin (2):
      ASoC: tas2764: Enable main IRQs
      PCI: apple: Use gpiod_set_value_cansleep in probe flow

Heiko Stuebner (1):
      drm/bridge: analogix_dp: Fix clk-disable removal

Henry Martin (8):
      clk: bcm: rpi: Add NULL check in raspberrypi_clk_register()
      wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
      wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()
      soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      watchdog: lenovo_se30_wdt: Fix possible devm_ioremap() NULL pointer dereference in lenovo_se30_wdt_probe()
      backlight: pm8941: Add NULL check in wled_configure()
      dmaengine: ti: Add NULL check in udma_probe()
      serial: Fix potential null-ptr-deref in mlb_usio_probe()

Herbert Xu (7):
      crypto: iaa - Do not clobber req->base.data
      crypto: zynqmp-sha - Add locking
      crypto: marvell/cesa - Handle zero-length skcipher requests
      crypto: marvell/cesa - Avoid empty transfer descriptor
      crypto: lrw - Only add ecb if it is not already there
      crypto: xts - Only add ecb if it is not already there
      crypto: api - Redo lookup on EEXIST

Hongbo Li (1):
      erofs: fix file handle encoding for 64-bit NIDs

Hongbo Yao (2):
      perf: arm-ni: Unregister PMUs on probe failure
      perf: arm-ni: Fix missing platform_set_drvdata()

Horatiu Vultur (4):
      net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
      net: phy: mscc: Fix memory leak when using one step timestamping
      net: phy: mscc: Stop clearing the the UDPv4 checksum for L2 frames
      net: lan966x: Make sure to insert the vlan tags also in host mode

Howard Hsu (1):
      wifi: mt76: mt7996: fix beamformee SS field

Huajian Yang (1):
      netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it

Huang Yiwei (1):
      firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES

Ian Forbes (2):
      drm/vmwgfx: Add seqno waiter for sync_files
      drm/vmwgfx: Fix dumb buffer leak

Ian Rogers (5):
      perf tool_pmu: Fix aggregation on duration_time
      perf symbol-minimal: Fix double free in filename__read_build_id
      perf pmu: Avoid segv for missing name/alias_name in wildcarding
      perf symbol: Fix use-after-free in filename__read_build_id
      perf callchain: Always populate the addr_location map when adding IP

Ido Schimmel (1):
      seg6: Fix validation of nexthop addresses

Ilan Peer (1):
      wifi: iwlfiwi: mvm: Fix the rate reporting

Ilya Leoshkevich (1):
      s390/bpf: Store backchain even for leaf progs

Imre Deak (1):
      drm/i915/dp_mst: Use the correct connector while computing the link BPP limit on MST

Ioana Ciornei (1):
      bus: fsl-mc: fix double-free on mc_dev

Israel Rukshin (1):
      virtio-pci: Fix result size returned for the admin command completion

Jack Morgenstein (1):
      RDMA/cma: Fix hang when cma_netevent_callback fails to queue_work

Jacob Moroni (1):
      IB/cm: use rwlock for MAD agent lock

Jaegeuk Kim (1):
      f2fs: clean up unnecessary indentation

Jakub Kicinski (5):
      netlink: specs: rt-link: add missing byte-order properties
      netlink: specs: rt-link: decode ip6gre
      selftests: drv-net: tso: fix the GRE device name
      selftests: drv-net: tso: make bkg() wait for socat to quit
      net: drv: netdevsim: don't napi_complete() from netpoll

Jakub Raczynski (2):
      net/mdiobus: Fix potential out-of-bounds read/write access
      net/mdiobus: Fix potential out-of-bounds clause 45 read/write access

James Clark (1):
      perf tools: Fix arm64 source package build

Jason Gunthorpe (1):
      iommu: Protect against overflow in iommu_pgsize()

Jason-JH Lin (1):
      mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting

Jens Axboe (3):
      iomap: don't lose folio dropbehind state for overwrites
      mm/filemap: gate dropbehind invalidate on folio !dirty && !writeback
      mm/filemap: use filemap_end_dropbehind() for read invalidation

Jensen Huang (1):
      PCI: rockchip: Fix order of rockchip_pci_core_rsts

Jeongjun Park (1):
      ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()

Jeremy Kerr (1):
      net: mctp: start tx queue on netdev open

Jerome Brunet (2):
      PCI: rcar-gen4: set ep BAR4 fixed size
      PCI: endpoint: Retain fixed-size BAR size as well as aligned size

Jesus Narvaez (2):
      drm/i915/guc: Check if expecting reply before decrementing outstanding_submission_g2h
      drm/i915/guc: Handle race condition where wakeref count drops below 0

Jianbo Liu (1):
      net/mlx5e: Fix leak of Geneve TLV option object

Jiaqing Zhao (1):
      x86/mtrr: Check if fixed-range MTRRs exist in mtrr_save_fixed_ranges()

Jiayuan Chen (5):
      bpf: fix ktls panic with sockmap
      bpf, sockmap: fix duplicated data transmission
      bpf, sockmap: Fix panic when calling skb_linearize
      ktls, sockmap: Fix missing uncharge operation
      bpf, sockmap: Avoid using sk_socket after free when sending

Jinjian Song (1):
      net: wwan: t7xx: Fix napi rx poll issue

Jiri Slaby (SUSE) (2):
      powerpc: do not build ppc_save_regs.o always
      tty: serial: 8250_omap: fix TX with DMA for am33xx

Jocelyn Falempe (1):
      drm/panic: Use a decimal fifo to avoid u64 by u64 divide

Joe Damato (1):
      e1000: Move cancel_work_sync to avoid deadlock

Joel Stanley (1):
      ARM: aspeed: Don't select SRAM

John Stultz (1):
      sched/core: Tweak wait_task_inactive() to force dequeue sched_delayed tasks

Jonas Gorski (7):
      net: dsa: b53: do not enable EEE on bcm63xx
      net: dsa: b53: do not enable RGMII delay on bcm63xx
      net: dsa: b53: implement setting ageing time
      net: dsa: b53: do not configure bcm63xx's IMP port interface
      net: dsa: b53: allow RGMII for bcm63xx RGMII ports
      net: dsa: b53: do not touch DLL_IQQD on bcm53115
      net: dsa: b53: fix untagged traffic sent via cpu tagged with VID 0

Jonas Karlman (1):
      media: rkvdec: Fix frame size enumeration

Jonathan Stroud (1):
      usb: misc: onboard_usb_dev: Fix usb5744 initialization sequence

Jonathan Wiepert (1):
      Use thread-safe function pointer in libbpf_print

Jose Maria Casanova Crespo (2):
      drm/v3d: fix client obtained from axi_ids on V3D 4.1
      drm/v3d: client ranges from axi_ids are different with V3D 7.1

Jouni Högander (1):
      drm/i915/psr: Fix using wrong mask in REG_FIELD_PREP

Julien Massot (3):
      ASoC: mediatek: mt8195: Set ETDM1/2 IN/OUT to COMP_DUMMY()
      arm64: dts: mt6359: Add missing 'compatible' property to regulators node
      arm64: dts: mt6359: Rename RTC node to match binding expectations

Junhao He (1):
      coresight: Fixes device's owner field for registered using coresight_init_driver()

Junxian Huang (1):
      RDMA/hns: Include hnae3.h in hns_roce_hw_v2.h

Justin Tee (1):
      scsi: lpfc: Avoid potential ndlp use-after-free in dev_loss_tmo_callbk

Jyothi Kumar Seerapu (1):
      arm64: dts: qcom: sm8750: Correct clocks property for uart14 node

KONDO KAZUMA(近藤　和真) (1):
      fs: allow clone_private_mount() for a path on real rootfs

KaFai Wan (1):
      bpf: Avoid __bpf_prog_ret0_warn when jit fails

Kalesh AP (1):
      RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc

Karol Wachowski (1):
      accel/ivpu: Reorder Doorbell Unregister and Command Queue Destruction

Karthikeyan Periyasamy (2):
      wifi: ath12k: fix NULL access in assign channel context handler
      wifi: ath12k: Replace band define G with GHZ where appropriate

Kathiravan Thirumoorthy (2):
      Revert "phy: qcom-qusb2: add QUSB2 support for IPQ5424"
      phy: qcom-qusb2: reuse the IPQ6018 settings for IPQ5424

Kees Cook (9):
      ASoC: SOF: ipc4-pcm: Adjust pipeline_list->pipelines allocation type
      watchdog: exar: Shorten identity name to fit correctly
      drm/vkms: Adjust vkms_state->active_planes allocation type
      scsi: qedf: Use designated initializer for struct qed_fcoe_cb_ops
      Bluetooth: btintel: Check dsbr size from EFI variable
      ubsan: integer-overflow: depend on BROKEN to keep this out of CI
      randstruct: gcc-plugin: Remove bogus void member
      randstruct: gcc-plugin: Fix attribute addition
      overflow: Introduce __DEFINE_FLEX for having no initializer

Keisuke Nishimura (1):
      drm/vmwgfx: Add error path for xa_store in vmw_bo_add_detached_resource

Keith Busch (2):
      nvme: fix command limits status code
      io_uring: consistently use rcu semantics with sqpoll thread

Kiran K (1):
      Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers

Konrad Dybcio (4):
      drm/msm/a6xx: Disable rgb565_predicator on Adreno 7c3
      arm64: dts: qcom: x1e80100-romulus: Keep L12B and L15B always on
      arm64: dts: qcom: msm8998: Remove mdss_hdmi_phy phandle argument
      arm64: dts: qcom: qcs615: Fix up UFS clocks

Kornel Dulęba (1):
      arm64: Support ARM64_VA_BITS=52 when setting ARCH_MMAP_RND_BITS_MAX

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sa8775p: Partially revert "arm64: dts: qcom: sa8775p: add QCrypto nodes"
      arm64: dts: qcom: qcs8300: Partially revert "arm64: dts: qcom: qcs8300: add QCrypto nodes"
      arm64: dts: qcom: msm8998: Use the header with DSI phy clock IDs

Kuniyuki Iwashima (1):
      calipso: Don't call calipso functions for AF_INET sk.

Lachlan Hodges (1):
      wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements

Lad Prabhakar (1):
      usb: renesas_usbhs: Reorder clock handling and power management in probe

Leo Yan (2):
      perf tests switch-tracking: Fix timestamp comparison
      coresight: etm4x: Fix timestamp bit field handling

Li Lingfeng (2):
      nfs: clear SB_RDONLY before getting superblock
      nfs: ignore SB_RDONLY when remounting nfs

Li RongQing (1):
      vfio/type1: Fix error unwind in migration dirty bitmap allocation

Lijuan Gao (2):
      pinctrl: qcom: correct the ngpios entry for QCS615
      pinctrl: qcom: correct the ngpios entry for QCS8300

Liu Dalin (1):
      rtc: loongson: Add missing alarm notifications for ACPI RTC events

Lizhi Hou (2):
      accel/amdxdna: Fix incorrect size of ERT_START_NPU commands
      accel/amdxdna: Fix incorrect PSP firmware size

Lizhi Xu (1):
      fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr

Longfang Liu (5):
      hisi_acc_vfio_pci: fix XQE dma address error
      hisi_acc_vfio_pci: add eq and aeq interruption restore
      hisi_acc_vfio_pci: bugfix cache write-back issue
      hisi_acc_vfio_pci: bugfix the problem of uninstalling driver
      hisi_acc_vfio_pci: bugfix live migration function without VF device driver

Lorenzo Bianconi (3):
      bpf: Allow XDP dev-bound programs to perform XDP_REDIRECT into maps
      net: airoha: Add the capability to allocate hfwd descriptors in SRAM
      net: airoha: Initialize PPE UPDMEM source-mac table

Louis-Alexis Eyraud (1):
      arm64: dts: mediatek: mt8390-genio-common: Set ssusb2 default dual role mode to host

Luca Weiss (6):
      clk: qcom: camcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: dispcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gcc-sm6350: Add *_wait_val values for GDSCs
      clk: qcom: gpucc-sm6350: Add *_wait_val values for GDSCs
      arm64: dts: qcom: sm8350: Reenable crypto & cryptobam
      arm64: dts: qcom: sm8650: Fix domain-idle-state for CPU2

Lucas De Marchi (1):
      drm/xe/lrc: Use a temporary buffer for WA BB

Luis Gerhorst (1):
      selftests/bpf: Fix caps for __xlated/jited_unpriv

Luiz Augusto von Dentz (8):
      Bluetooth: ISO: Fix not using SID from adv report
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
      Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
      Bluetooth: MGMT: Protect mgmt_pending list with its own lock
      Bluetooth: Fix NULL pointer deference on eir_get_service_data
      Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
      Bluetooth: eir: Fix possible crashes on eir_create_adv_data
      Bluetooth: MGMT: Fix sparse errors

Lukas Wunner (4):
      crypto: ecdsa - Fix enc/dec size reported by KEYCTL_PKEY_QUERY
      crypto: ecdsa - Fix NIST P521 key size reported by KEYCTL_PKEY_QUERY
      PCI: pciehp: Ignore Presence Detect Changed caused by DPC
      PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset

Madhavan Srinivasan (1):
      powerpc/kernel: Fix ppc_save_regs inclusion in build

Maharaja Kennadyrajan (2):
      wifi: ath12k: Prevent sending WMI commands to firmware during firmware crash
      wifi: ath12k: fix node corruption in ar->arvifs list

Manikanta Mylavarapu (1):
      arm64: dts: qcom: ipq9574: fix the msi interrupt numbers of pcie3

Mao Jinlong (1):
      coresight: tmc: fix failure to disable/enable ETF after reading

Marcus Folkesson (1):
      iio: adc: mcp3911: fix device dependent mappings for conversion result registers

Mario Limonciello (1):
      thunderbolt: Fix a logic error in wake on connect

Marius Cristea (1):
      iio: adc: PAC1934: fix typo in documentation link

Mark Brown (2):
      arm64/fpsimd: Discard stale CPU state when handling SME traps
      arm64/fpsimd: Don't corrupt FPMR when streaming mode changes

Mark Kettenis (1):
      arm64: dts: qcom: x1e80100: Mark usb_2 as dma-coherent

Mark Rutland (6):
      arm64/fpsimd: Avoid RES0 bits in the SME trap handler
      arm64/fpsimd: Avoid clobbering kernel FPSIMD state with SMSTOP
      arm64/fpsimd: Reset FPMR upon exec()
      arm64/fpsimd: Fix merging of FPSIMD state during signal return
      arm64/fpsimd: Avoid warning when sve_to_fpsimd() is unused
      kselftest/arm64: fp-ptrace: Fix expected FPMR value when PSTATE.SM is changed

Martin Blumenstingl (3):
      drm/meson: fix debug log statement when setting the HDMI clocks
      drm/meson: use vclk_freq instead of pixel_freq in debug print
      drm/meson: fix more rounding issues with 59.94Hz modes

Martin Povišer (2):
      ASoC: tas2764: Reinit cache on part reset
      ASoC: apple: mca: Constrain channels according to TDM mask

Masami Hiramatsu (Google) (1):
      x86/insn: Fix opcode map (!REX2) superscript tags

Mathias Nyman (1):
      usb: Flush altsetting 0 endpoints before reinitializating them after reset.

Matthew Auld (1):
      drm/xe/vm: move xe_svm_init() earlier

Matthew Wilcox (Oracle) (3):
      bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP
      block: Fix bvec_set_folio() for very large folios
      9p: Add a migrate_folio method

Maulik Shah (1):
      arm64: dts: qcom: sm8750: Fix cluster hierarchy for idle states

Maxime Chevallier (1):
      net: phy: phy_caps: Don't skip better duplex macth on non-exact match

Maxime Ripard (3):
      drm/vc4: tests: Use return instead of assert
      drm/vc4: tests: Stop allocating the state in test init
      drm/vc4: tests: Retry pv-muxing tests when EDEADLK

Maíra Canal (1):
      drm/v3d: Associate a V3D tech revision to all supported devices

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.

Miaoqian Lin (2):
      firmware: psci: Fix refcount leak in psci_dt_init
      tracing: Fix error handling in event_trigger_parse()

Miaoqing Pan (1):
      wifi: ath12k: fix uaf in ath12k_core_init()

Michael Lo (1):
      wifi: mt76: mt7925: ensure all MCU commands wait for response

Michael Petlan (1):
      perf tests: Fix 'perf report' tests installation

Michael Walle (1):
      drm/panel-simple: fix the warnings for the Evervision VGG644804

Michal Koutný (1):
      kernfs: Relax constraint in draining guard

Michal Kubiak (3):
      ice: fix Tx scheduler error handling in XDP callback
      ice: create new Tx scheduler nodes for new queues only
      ice: fix rebuilding the Tx scheduler tree for large queue counts

Michal Luczaj (1):
      net: Fix TOCTOU issue in sk_is_readable()

Michal Wajdeczko (2):
      drm/xe/guc: Refactor GuC debugfs initialization
      drm/xe/guc: Don't expose GuC privileged debugfs files if VF

Miguel Ojeda (3):
      drm/panic: clean Clippy warning
      rust: pci: fix docs related to missing Markdown code spans
      objtool/rust: relax slice condition to cover more `noreturn` Rust functions

Mike Yuan (1):
      pidfs: never refuse ppid == 0 in PIDFD_GET_INFO

Mikhail Arkhipov (1):
      mtd: nand: ecc-mxic: Fix use of uninitialized variable ret

Ming Lei (2):
      loop: add file_start_write() and file_end_write()
      block: use q->elevator with ->elevator_lock held in elv_iosched_show()

Ming Yen Hsieh (2):
      wifi: mt76: mt7925: prevent multiple scan commands
      wifi: mt76: mt7925: refine the sniffer commnad

Mingcong Bai (1):
      ACPI: resource: fix a typo for MECHREVO in irq1_edge_low_force_override[]

Mirco Barone (1):
      wireguard: device: enable threaded NAPI

Miri Korenblit (2):
      wifi: iwlwifi: re-add IWL_AMSDU_8K case
      wifi: iwlwifi: mld: avoid panic on init failure

Moshe Shemesh (1):
      net/mlx5: Ensure fw pages are always allocated on same NUMA

Murad Masimov (1):
      ocfs2: fix possible memory leak in ocfs2_finish_quota_recovery

Nam Cao (3):
      selftests: coredump: Properly initialize pointer
      selftests: coredump: Fix test failure for slow machines
      selftests: coredump: Raise timeout to 2 minutes

Namhyung Kim (2):
      perf trace: Fix leaks of 'struct thread' in fprintf_sys_enter()
      perf trace: Fix leaks of 'struct thread' in set_filter_loop_pids()

Neil Armstrong (4):
      arm64: dts: qcom: sm8650: setup gpu thermal with higher temperatures
      arm64: dts: qcom: sm8550: use ICC tag for all interconnect phandles
      arm64: dts: qcom: sm8550: add missing cpu-cfg interconnect path in the mdss node
      arm64: dts: qcom: sm8650: add missing cpu-cfg interconnect path in the mdss node

NeilBrown (7):
      nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()
      nfs_localio: use cmpxchg() to install new nfs_file_localio
      nfs_localio: always hold nfsd net ref with nfsd_file ref
      nfs_localio: simplify interface to nfsd for getting nfsd_file
      nfs_localio: duplicate nfs_close_local_fh()
      nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()
      nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer

Neill Kapron (1):
      selftests/seccomp: fix syscall_restart test for arm compat

Nicolas Dufresne (2):
      media: synopsys: hdmirx: Renamed frame_idx to sequence
      media: synopsys: hdmirx: Count dropped frames

Nicolas Frattaroli (1):
      drm/connector: only call HDMI audio helper plugged cb if non-null

Nicolas Pitre (1):
      vt: remove VT_RESIZE and VT_RESIZEX from vt_compat_ioctl()

Nikita Zhandarovich (1):
      net: usb: aqc111: fix error handling of usbnet read calls

Nitesh Shetty (1):
      iov_iter: use iov_offset for length calculation in iov_iter_aligned_bvec

Nitin Rawat (1):
      scsi: ufs: qcom: Prevent calling phy_exit() before phy_init()

Nylon Chen (1):
      riscv: misaligned: fix sleeping function called during misaligned access handling

Nícolas F. R. A. Prado (3):
      kselftest: cpufreq: Get rid of double suspend in rtcwake case
      arm64: dts: mediatek: mt6357: Drop regulator-fixed compatibles
      regulator: dt-bindings: mt6357: Drop fixed compatible requirement

Oleg Nesterov (1):
      posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Ovidiu Panait (4):
      crypto: sun8i-ce-hash - fix error handling in sun8i_ce_hash_run()
      crypto: sun8i-ce-cipher - fix error handling in sun8i_ce_cipher_prepare()
      crypto: sun8i-ce - undo runtime PM changes during driver removal
      crypto: sun8i-ce - move fallback ahash_request to the end of the struct

P Praneesh (12):
      wifi: ath12k: Fix memory leak during vdev_id mismatch
      wifi: ath12k: Fix memory corruption during MLO multicast tx
      wifi: ath12k: Fix invalid memory access while forming 802.11 header
      wifi: ath12k: Handle error cases during extended skb allocation
      wifi: ath12k: Add MSDU length validation for TKIP MIC error
      wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
      wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
      wifi: ath12k: change the status update in the monitor Rx
      wifi: ath12k: add rx_info to capture required field from rx descriptor
      wifi: ath12k: replace the usage of rx desc with rx_info
      wifi: ath12k: Fix invalid RSSI values in station dump
      wifi: ath12k: refactor ath12k_hw_regs structure

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: prevent overflow in lookup table allocation

Pali Rohár (1):
      cifs: Fix validation of SMB1 query reparse point response

Patrisious Haddad (2):
      RDMA/mlx5: Fix error flow upon firmware failure for RQ destruction
      net/mlx5: Fix return value when searching for existing flow group

Paul Chaignon (3):
      net: Fix checksum update for ILA adj-transport
      bpf: Clarify the meaning of BPF_F_PSEUDO_HDR
      bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

Pauli Virtanen (2):
      Bluetooth: separate CIS_LINK and BIS_LINK link types
      Bluetooth: hci_core: fix list_for_each_entry_rcu usage

Paulo Alcantara (2):
      netfs: Fix setting of transferred bytes with short DIO reads
      smb: client: fix perf regression with deferred closes

Pavel Begunkov (2):
      nvme: fix implicit bool to flags conversion
      io_uring: fix spurious drain flushing

Pawel Laszczak (2):
      usb: cdnsp: Fix issue with detecting command completion event
      usb: cdnsp: Fix issue with detecting USB 3.2 speed

Peilin Ye (1):
      selftests/bpf: Avoid passing out-of-range values to __retval()

Pekka Ristola (1):
      rust: file: mark `LocalFile` as `repr(transparent)`

Peng Fan (1):
      mailbox: imx: Fix TXDB_V2 sending

Penglei Jiang (1):
      io_uring: fix use-after-free of sq->thread in __io_uring_show_fdinfo()

Pengyu Luo (1):
      arm64: dts: qcom: sm8650: add the missing l2 cache node

Peter Chiu (2):
      wifi: mt76: mt7996: set EHT max ampdu length capability
      wifi: mt76: mt7996: fix invalid NSS setting when TX path differs from NSS

Peter Griffin (3):
      pinctrl: samsung: refactor drvdata suspend & resume callbacks
      pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      pinctrl: samsung: add gs101 specific eint suspend/resume callbacks

Peter Korsgaard (1):
      nvmem: zynqmp_nvmem: unbreak driver after cleanup

Peter Robinson (2):
      arm64: dts: rockchip: Add vcc-supply to SPI flash on rk3566-rock3c
      arm64: dts: rockchip: Update eMMC for NanoPi R5 series

Peter Zijlstra (2):
      sched: Fix trace_sched_switch(.prev_state)
      perf: Ensure bpf_perf_link path is properly serialized

Petr Pavlu (1):
      genksyms: Fix enum consts from a reference affecting new values

Phillip Lougher (1):
      Squashfs: check return result of sb_min_blocksize

Pin-yen Lin (1):
      arm64: dts: mt8183: Add port node to mt8183.dtsi

Ping-Ke Shih (2):
      wifi: rtw89: pci: configure manual DAC mode via PCI config API only
      wifi: rtw89: pci: enlarge retry times of RX tag to 1000

Prasanth Babu Mantena (1):
      arm64: dts: ti: k3-j721e-common-proc-board: Enable OSPI1 on J721E

Przemek Kitszel (6):
      iavf: iavf_suspend(): take RTNL before netdev_lock()
      iavf: centralize watchdog requeueing itself
      iavf: simplify watchdog_task in terms of adminq task scheduling
      iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
      iavf: sprinkle netdev_assert_locked() annotations
      iavf: get rid of the crit lock

Qasim Ijaz (4):
      wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
      wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
      wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()
      fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()

Qing Wang (1):
      perf/core: Fix broken throttling when max_samples_per_tick=1

Qinxin Xia (1):
      iommu/arm-smmu-v3: Fix incorrect return in arm_smmu_attach_dev

Qiuxu Zhuo (2):
      EDAC/skx_common: Fix general protection fault
      EDAC/{skx_common,i10nm}: Fix the loss of saved RRL for HBM pseudo channel 0

Qu Wenruo (2):
      btrfs: scrub: update device stats when an error is detected
      btrfs: scrub: fix a wrong error type when metadata bytenr mismatches

Quentin Schulz (3):
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou
      net: stmmac: platform: guarantee uniqueness of bus_id

RD Babiera (1):
      usb: typec: tcpm: move tcpm_queue_vdm_unlocked to asynchronous work

Radim Krčmář (1):
      RISC-V: KVM: lock the correct mp_state during reset

Rafael J. Wysocki (2):
      PM: sleep: Print PM debug messages during hibernation
      PM: sleep: Fix power.is_suspended cleanup for direct-complete devices

Raj Kumar Bhagat (1):
      wifi: ath12k: fix cleanup path after mhi init

Rajat Soni (1):
      wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Ramasamy Kaliappan (1):
      wifi: ath12k: Fix the QoS control field offset to build QoS header

Rameshkumar Sundaram (1):
      wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers

Ramya Gnanasekar (1):
      wifi: ath12k: Fix WMI tag for EHT rate in peer assoc

Richard Fitzgerald (1):
      clk: test: Forward-declare struct of_phandle_args in kunit/clk.h

Richard Zhu (1):
      PCI: imx6: Save and restore the LUT setting during suspend/resume for i.MX95 SoC

Ritesh Harjani (IBM) (1):
      powerpc/powernv/memtrace: Fix out of bounds issue in memtrace mmap

Rob Herring (Arm) (1):
      dt-bindings: soc: fsl,qman-fqd: Fix reserved-memory.yaml reference

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Robin Murphy (1):
      bus: fsl_mc: Fix driver_managed_dma check

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Rodrigo Vivi (2):
      drm/xe: Make xe_gt_freq part of the Documentation
      drm/xe: Add missing documentation of rpa_freq

Roger Pau Monne (1):
      xen/x86: fix initial memory balloon target

Rolf Eike Beer (1):
      iommu: remove duplicate selection of DMAR_TABLE

Roman Kisel (1):
      x86/hyperv: Fix APIC ID and VP index confusion in hv_snp_boot_ap()

Ronak Doshi (1):
      vmxnet3: correctly report gso type for UDP tunnels

Roxana Nicolescu (2):
      misc: lis3lv02d: Fix correct sysfs directory path for lis3lv02d
      char: tlclk: Fix correct sysfs directory path for tlclk

Ryusuke Konishi (1):
      nilfs2: do not propagate ENOENT error from nilfs_btree_propagate()

Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf_nf selftest failure

Sam Winchenbach (3):
      iio: filter: admv8818: fix band 4, state 15
      iio: filter: admv8818: fix integer overflow
      iio: filter: admv8818: fix range calculation

Sandipan Das (2):
      perf/x86/amd/uncore: Remove unused 'struct amd_uncore_ctx::node' member
      perf/x86/amd/uncore: Prevent UMC counters from saturating

Sanjeev Yadav (1):
      scsi: core: ufs: Fix a hang in the error handler

Sarika Sharma (1):
      wifi: ath12k: fix invalid access to memory

Sean Christopherson (1):
      x86/irq: Ensure initial PIR loads are performed exactly once

Sergey Shtylyov (1):
      fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()

Shahar Shitrit (1):
      net/mlx5e: Fix number of lanes to UNKNOWN when using data_rate_oper

Shayne Chen (2):
      wifi: mt76: mt7996: fix RX buffer size of MCU event
      wifi: mt76: fix available_antennas setting

Sheng Yong (1):
      erofs: avoid using multiple devices with different type

Shiming Cheng (1):
      net: fix udp gso skb_segment after pull from frag_list

Shivasharan S (1):
      scsi: mpt3sas: Fix _ctl_get_mpt_mctp_passthru_adapter() to return IOC pointer

Siddharth Vadapalli (2):
      remoteproc: k3-r5: Drop check performed in k3_r5_rproc_{mbox_callback/kick}
      remoteproc: k3-dsp: Drop check performed in k3_dsp_rproc_{mbox_callback/kick}

Srinivasan Shanmugam (1):
      drm/amdgpu: Refine Cleaner Shader MEC firmware version for GFX10.1.x GPUs

Stanislav Fomichev (1):
      af_packet: move notifier's packet_dev_mc out of rcu critical section

Stefan Wahren (1):
      drm/vc4: hdmi: Call HDMI hotplug helper on disconnect

Stefano Garzarella (1):
      vsock/virtio: fix `rx_bytes` accounting for stream sockets

Stefano Stabellini (1):
      xen/arm: call uaccess_ttbr0_enable for dm_op hypercall

Stephan Gerhold (1):
      arm64: dts: qcom: sc8280xp-x13s: Drop duplicate DMIC supplies

Stephen Brennan (1):
      fs: convert mount flags to enum

Steven Rostedt (4):
      tracing: Move histogram trigger variables from stack to per CPU structure
      tracing: Rename event_trigger_alloc() to trigger_data_alloc()
      ring-buffer: Do not trigger WARN_ON() due to a commit_overrun
      ring-buffer: Move cpus_read_lock() outside of buffer->mutex

Stone Zhang (1):
      wifi: ath11k: fix node corruption in ar->arvifs list

Su Hui (1):
      soc: aspeed: lpc: Fix impossible judgment condition

Subbaraya Sundeep (1):
      octeontx2-af: Send Link events one by one

Suleiman Souhlal (1):
      tools/resolve_btfids: Fix build when cross compiling kernel with clang.

Suraj Gupta (1):
      net: xilinx: axienet: Fix Tx skb circular buffer occupancy check in dmaengine xmit

T.J. Mercier (1):
      selftests/bpf: Fix kmem_cache iterator draining

Takashi Iwai (1):
      ALSA: usb-audio: Kill timer properly at removal

Tao Chen (4):
      bpf: Check link_create.flags parameter for multi_kprobe
      bpf: Check link_create.flags parameter for multi_uprobe
      libbpf: Remove sample_period init in perf_buffer
      bpf: Fix WARN() in get_bpf_raw_tp_regs

Tengteng Yang (1):
      Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated

Terry Junge (1):
      HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()

Terry Tritton (1):
      selftests/seccomp: fix negative_ENOSYS tracer tests on arm32

Thangaraj Samynathan (2):
      net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
      net: lan743x: Fix PHY reset handling during initialization and WOL

Thomas Gleixner (1):
      x86/iopl: Cure TIF_IO_BITMAP inconsistencies

Thomas Hellström (1):
      drm/xe: Rework eviction rejection of bound external bos

Thomas Richter (1):
      perf tests metric-only perf stat: Fix tests 84 and 86 s390

Thomas Weißschuh (3):
      kunit: qemu_configs: sparc: Explicitly enable CONFIG_SPARC32=y
      kunit/usercopy: Disable u64 test on 32-bit SPARC
      uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again

Thorsten Blum (1):
      ASoC: Intel: avs: Fix kcalloc() sizes

Thuan Nguyen (1):
      arm64: dts: renesas: white-hawk-ard-audio: Fix TPU0 groups

Tingguo Cheng (1):
      arm64: dts: qcom: qcs615: remove disallowed property in spmi bus node

Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool
      wifi: ath9k_htc: Abort software beacon handling if disabled

Tomas Glozar (1):
      rtla: Define _GNU_SOURCE in timerlat_bpf.c

Tzung-Bi Shih (1):
      kunit: Fix wrong parameter to kunit_deactivate_static_stub()

Uwe Kleine-König (1):
      iio: adc: ad7124: Fix 3dB filter frequency reading

Varadarajan Narayanan (1):
      arm64: dts: qcom: ipq9574: Fix USB vdd info

Vignesh Raman (2):
      drm/ci: fix merge request rules
      arm64: defconfig: mediatek: enable PHY drivers

Vijendar Mukunda (1):
      ASoC: SOF: amd: add missing acp descriptor field

Viktor Malik (1):
      libbpf: Fix buffer overflow in bpf_object__init_prog

Vincent Knecht (1):
      clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz

Vishwaroop A (3):
      spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
      spi: tegra210-quad: remove redundant error handling code
      spi: tegra210-quad: modify chip select (CS) deactivation

Vitaly Prosyak (1):
      drm/amdgpu/gfx10: Refine Cleaner Shader for GFX10.1.10

Vlad Dogaru (2):
      net/mlx5: HWS, Fix matcher action template attach
      net/mlx5: HWS, make sure the uplink is the last destination

Vlad Dumitrescu (1):
      IB/cm: Drop lockdep assert and WARN when freeing old msg

WangYuli (1):
      MIPS: Loongson64: Add missing '#interrupt-cells' for loongson64c_ls7a

Wei Fang (1):
      net: phy: clear phydev->devlink when the link is deleted

Wentao Guan (1):
      HID: intel-thc-hid: intel-quicki2c: pass correct arguments to acpi_evaluate_object

Wentao Liang (1):
      nilfs2: add pointer check for nilfs_direct_propagate()

Wilfred Mallawa (1):
      PCI: Print the actual delay time in pci_bridge_wait_for_secondary_bus()

Wojciech Slenska (1):
      pinctrl: qcom: pinctrl-qcm2290: Add missing pins

Wolfram Sang (3):
      ARM: dts: at91: usb_a9263: fix GPIO for Dataflash chip select
      ARM: dts: at91: at91sam9263: fix NAND chip selects
      rtc: sh: assign correct interrupts with DT

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xilin Wu (1):
      arm64: dts: qcom: sm8250: Fix CPU7 opp table

Xin Li (Intel) (1):
      x86/fred/signal: Prevent immediate repeat of single step trap on return from SIGTRAP handler

Xuewen Yan (1):
      sched/fair: Fixup wake_up_sync() vs DELAYED_DEQUEUE

Yabin Cui (2):
      coresight: catu: Introduce refcount and spinlock for enabling/disabling
      coresight: core: Disable helpers for devices that fail to enable

Yanqing Wang (1):
      driver: net: ethernet: mtk_star_emac: fix suspend/resume issue

Yaxiong Tian (1):
      PM: EM: Fix potential division-by-zero error in em_compute_costs()

Yeoreum Yun (3):
      coresight/etm4: fix missing disable active config
      coresight: holding cscfg_csdev_lock while removing cscfg from csdev
      coresight: prevent deactivate active config while enabling the config

Yevgeny Kliteynik (1):
      net/mlx5: HWS, fix missing ip_version handling in definer

Yi Zhang (1):
      scsi: smartpqi: Fix smp_processor_id() call trace for preemptible kernels

YiFei Zhu (1):
      bpftool: Fix regression of "bpftool cgroup tree" EINVAL on older kernels

Yihang Li (1):
      scsi: hisi_sas: Call I_T_nexus after soft reset for SATA disk

Yingying Tang (1):
      wifi: ath12k: Reorder and relocate the release of resources in ath12k_core_deinit()

Yonghong Song (1):
      bpf: Do not include stack ptr register in precision backtracking bookkeeping

Yongliang Gao (1):
      rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture

Yongting Lin (1):
      um: Fix tgkill compile error on old host OSes

Yu Kuai (3):
      brd: fix aligned_sector from brd_do_discard()
      brd: fix discard end sector
      md/raid1,raid10: don't handle IO error for REQ_RAHEAD and REQ_NOWAIT

Yue Haibing (1):
      mailbox: mchp-ipc-sbi: Fix COMPILE_TEST build error

Yunhui Cui (1):
      ACPI: CPPC: Fix NULL pointer dereference when nosmp is used

Yuuki NAGAO (1):
      ASoC: ti: omap-hdmi: Re-add dai_link->platform to fix card init

Zhe Qiao (1):
      PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()

Zhen XIN (2):
      wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
      wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

Zhiguo Niu (2):
      f2fs: use d_inode(dentry) cleanup dentry->d_inode
      f2fs: fix to correct check conditions in f2fs_cross_rename

Zhongqiu Duan (1):
      netfilter: nft_quota: match correctly when the quota just depleted

Zhu Yanjun (1):
      RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug

Zijun Hu (2):
      PM: wakeup: Delete space in the end of string shown by pm_show_wakelocks()
      fs/filesystems: Fix potential unsigned integer underflow in fs_name()

Ziqi Chen (1):
      scsi: ufs: qcom: Check gear against max gear in vop freq_to_gear()

Zizhi Wo (1):
      blk-throttle: Fix wrong tg->[bytes/io]_disp update in __tg_update_carryover()

ping.gao (1):
      scsi: ufs: mcq: Delete ufshcd_release_scsi_cmd() in ufshcd_mcq_abort()

yohan.joung (1):
      f2fs: prevent the current section from being selected as a victim during GC

Álvaro Fernández Rojas (3):
      spi: bcm63xx-spi: fix shared reset
      spi: bcm63xx-hsspi: fix shared reset
      net: dsa: tag_brcm: legacy: fix pskb_may_pull length


