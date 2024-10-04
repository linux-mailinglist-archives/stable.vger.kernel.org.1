Return-Path: <stable+bounces-80757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEA99069C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88E01F20F09
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC721BAF0;
	Fri,  4 Oct 2024 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHwN29r0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A1621BAEB;
	Fri,  4 Oct 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053120; cv=none; b=dBbzfrtixB5jvZmYcuaFRDDfYMtLHz6EwpFqHZcnXc9k/73F4b+qWhIX+tDFICSgT9SiU8zYXUjISTWGifFIR0YHKh+SbO3F2bjZIh4F3drPVkhZJyYAtNgwwVNKq1qKZfJWTTWMVs5lFrj4mZkv0fvc4EHTMWerF9MbZDIihuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053120; c=relaxed/simple;
	bh=YiG1JTyr3s739E3DTm/4NQBcfnsuM8+GrWlzSEZCBlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K5VFSwDw/jaffyhUIaY0cGFfUlak0QrAjQ72z8YyHDNgWQ+Mu2vKi5n1/lZjDnsD2VI4XFX2ZbzFx6DJS0Gd8j+yRvGLVfrjyfQrUmeA454C1EuA79EWtEiMWkdV68zQGo5ybN9UIKVAc8Y4mFOPiGc7xT0lSaIJI+0Gwkp+nPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHwN29r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC2C4CECF;
	Fri,  4 Oct 2024 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728053118;
	bh=YiG1JTyr3s739E3DTm/4NQBcfnsuM8+GrWlzSEZCBlU=;
	h=From:To:Cc:Subject:Date:From;
	b=PHwN29r0pBThwGxFtJykGgqK7+vX4K6kKPbaJDZig67FBbIXTPNDKA7PaKdQW9U50
	 ZGp9WBkE3m69+hm/vaGM7LWDfARQS0C/B7ud6emW1iB6m6GEXV/+r++c4S5g4i93Tg
	 Le8m91Cz9W5YV7kbB5gIWZp+usIc7pO74oiGojF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.13
Date: Fri,  4 Oct 2024 16:45:05 +0200
Message-ID: <2024100405-crazed-sage-a609@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.13 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818                       |    2 
 Documentation/arch/arm64/silicon-errata.rst                                   |    2 
 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml    |    1 
 Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml                |   26 
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml                       |    1 
 Documentation/driver-api/ipmi.rst                                             |    2 
 Documentation/filesystems/mount_api.rst                                       |    9 
 Documentation/virt/kvm/locking.rst                                            |   33 
 Makefile                                                                      |    2 
 arch/arm/boot/dts/microchip/sam9x60.dtsi                                      |    4 
 arch/arm/boot/dts/microchip/sama7g5.dtsi                                      |    2 
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                                     |    2 
 arch/arm/boot/dts/nxp/imx/imx6ull-seeed-npi-dev-board.dtsi                    |   12 
 arch/arm/boot/dts/nxp/imx/imx7d-zii-rmu2.dts                                  |    2 
 arch/arm/mach-ep93xx/clock.c                                                  |    2 
 arch/arm/mach-versatile/platsmp-realview.c                                    |    1 
 arch/arm/vfp/vfpinstr.h                                                       |   48 
 arch/arm64/Kconfig                                                            |    2 
 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts                          |    2 
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi                              |    3 
 arch/arm64/boot/dts/mediatek/mt8186.dtsi                                      |   12 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                               |    1 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                      |   12 
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts                         |    1 
 arch/arm64/boot/dts/nvidia/tegra234-p3701-0008.dtsi                           |   33 
 arch/arm64/boot/dts/nvidia/tegra234-p3740-0002.dtsi                           |   33 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                                         |    2 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                        |   10 
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi                                   |    4 
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi                                    |    4 
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi                                    |    4 
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi                                    |    4 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts                          |    4 
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts                             |    2 
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso                                      |    8 
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts                            |    4 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                        |    4 
 arch/arm64/include/asm/cputype.h                                              |    2 
 arch/arm64/include/asm/esr.h                                                  |   88 
 arch/arm64/include/uapi/asm/sigcontext.h                                      |    6 
 arch/arm64/kernel/cpu_errata.c                                                |   10 
 arch/arm64/kernel/smp.c                                                       |  160 -
 arch/arm64/kvm/hyp/nvhe/ffa.c                                                 |   21 
 arch/arm64/net/bpf_jit_comp.c                                                 |   57 
 arch/loongarch/include/asm/kvm_vcpu.h                                         |    1 
 arch/loongarch/kvm/timer.c                                                    |    7 
 arch/loongarch/kvm/vcpu.c                                                     |    2 
 arch/m68k/kernel/process.c                                                    |    2 
 arch/powerpc/crypto/Kconfig                                                   |    1 
 arch/powerpc/include/asm/asm-compat.h                                         |    6 
 arch/powerpc/include/asm/atomic.h                                             |    5 
 arch/powerpc/include/asm/uaccess.h                                            |    7 
 arch/powerpc/kernel/head_8xx.S                                                |    6 
 arch/powerpc/kernel/vdso/gettimeofday.S                                       |    4 
 arch/powerpc/mm/nohash/8xx.c                                                  |    4 
 arch/riscv/include/asm/kvm_vcpu_pmu.h                                         |   21 
 arch/riscv/kernel/perf_callchain.c                                            |    2 
 arch/riscv/kvm/vcpu_pmu.c                                                     |   14 
 arch/riscv/kvm/vcpu_sbi.c                                                     |    4 
 arch/s390/include/asm/ftrace.h                                                |   17 
 arch/s390/kernel/stacktrace.c                                                 |   19 
 arch/x86/coco/tdx/tdx.c                                                       |  127 +
 arch/x86/events/intel/core.c                                                  |    8 
 arch/x86/events/intel/pt.c                                                    |   15 
 arch/x86/hyperv/ivm.c                                                         |   22 
 arch/x86/include/asm/acpi.h                                                   |    8 
 arch/x86/include/asm/hardirq.h                                                |    8 
 arch/x86/include/asm/idtentry.h                                               |    6 
 arch/x86/include/asm/kvm_host.h                                               |    3 
 arch/x86/include/asm/pgtable.h                                                |    5 
 arch/x86/include/asm/set_memory.h                                             |    3 
 arch/x86/include/asm/x86_init.h                                               |   14 
 arch/x86/kernel/acpi/boot.c                                                   |   11 
 arch/x86/kernel/cpu/sgx/main.c                                                |   27 
 arch/x86/kernel/crash.c                                                       |   12 
 arch/x86/kernel/head64.c                                                      |    3 
 arch/x86/kernel/jailhouse.c                                                   |    1 
 arch/x86/kernel/mmconf-fam10h_64.c                                            |    1 
 arch/x86/kernel/process_64.c                                                  |   29 
 arch/x86/kernel/reboot.c                                                      |   12 
 arch/x86/kernel/smpboot.c                                                     |    1 
 arch/x86/kernel/x86_init.c                                                    |    9 
 arch/x86/kvm/lapic.c                                                          |   97 
 arch/x86/kvm/svm/svm.c                                                        |    2 
 arch/x86/kvm/vmx/main.c                                                       |    2 
 arch/x86/kvm/vmx/x86_ops.h                                                    |    1 
 arch/x86/mm/mem_encrypt_amd.c                                                 |    8 
 arch/x86/mm/pat/set_memory.c                                                  |   54 
 arch/x86/mm/tlb.c                                                             |    7 
 arch/x86/net/bpf_jit_comp.c                                                   |  107 -
 arch/x86/pci/fixup.c                                                          |    4 
 arch/x86/xen/mmu_pv.c                                                         |    5 
 arch/x86/xen/p2m.c                                                            |   98 
 arch/x86/xen/setup.c                                                          |  203 +-
 arch/x86/xen/xen-ops.h                                                        |    6 
 block/bfq-iosched.c                                                           |   81 
 block/partitions/core.c                                                       |    8 
 crypto/asymmetric_keys/asymmetric_type.c                                      |    7 
 crypto/xor.c                                                                  |   31 
 drivers/acpi/acpica/exsystem.c                                                |   11 
 drivers/acpi/cppc_acpi.c                                                      |   43 
 drivers/acpi/device_sysfs.c                                                   |    5 
 drivers/acpi/pmic/tps68470_pmic.c                                             |    6 
 drivers/acpi/resource.c                                                       |   12 
 drivers/acpi/video_detect.c                                                   |   24 
 drivers/ata/libata-eh.c                                                       |    8 
 drivers/ata/libata-scsi.c                                                     |    5 
 drivers/base/core.c                                                           |   15 
 drivers/base/firmware_loader/main.c                                           |   30 
 drivers/base/module.c                                                         |   14 
 drivers/block/drbd/drbd_main.c                                                |    6 
 drivers/block/drbd/drbd_state.c                                               |    2 
 drivers/block/nbd.c                                                           |   15 
 drivers/block/ublk_drv.c                                                      |   62 
 drivers/bluetooth/btusb.c                                                     |    5 
 drivers/bus/arm-integrator-lm.c                                               |    1 
 drivers/bus/mhi/host/pci_generic.c                                            |   13 
 drivers/char/hw_random/bcm2835-rng.c                                          |    4 
 drivers/char/hw_random/cctrng.c                                               |    1 
 drivers/char/hw_random/mtk-rng.c                                              |    2 
 drivers/char/tpm/tpm-dev-common.c                                             |    2 
 drivers/char/tpm/tpm2-sessions.c                                              |    1 
 drivers/char/tpm/tpm2-space.c                                                 |    3 
 drivers/clk/at91/sama7g5.c                                                    |    5 
 drivers/clk/imx/clk-composite-7ulp.c                                          |    7 
 drivers/clk/imx/clk-composite-8m.c                                            |   53 
 drivers/clk/imx/clk-composite-93.c                                            |   15 
 drivers/clk/imx/clk-fracn-gppll.c                                             |    4 
 drivers/clk/imx/clk-imx6ul.c                                                  |    4 
 drivers/clk/imx/clk-imx8mp-audiomix.c                                         |   13 
 drivers/clk/imx/clk-imx8mp.c                                                  |    4 
 drivers/clk/imx/clk-imx8qxp.c                                                 |   10 
 drivers/clk/qcom/clk-alpha-pll.c                                              |   52 
 drivers/clk/qcom/clk-alpha-pll.h                                              |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                              |    9 
 drivers/clk/qcom/dispcc-sm8550.c                                              |   14 
 drivers/clk/qcom/gcc-ipq5332.c                                                |    1 
 drivers/clk/rockchip/clk-rk3228.c                                             |    2 
 drivers/clk/rockchip/clk-rk3588.c                                             |    2 
 drivers/clk/starfive/clk-starfive-jh7110-vout.c                               |    2 
 drivers/clk/ti/clk-dra7-atl.c                                                 |    1 
 drivers/clocksource/timer-qcom.c                                              |    7 
 drivers/cpufreq/ti-cpufreq.c                                                  |   10 
 drivers/cpuidle/cpuidle-riscv-sbi.c                                           |   21 
 drivers/crypto/caam/caamhash.c                                                |    1 
 drivers/crypto/ccp/sev-dev.c                                                  |   15 
 drivers/crypto/hisilicon/hpre/hpre_main.c                                     |   54 
 drivers/crypto/hisilicon/qm.c                                                 |  151 +
 drivers/crypto/hisilicon/sec2/sec_main.c                                      |   16 
 drivers/crypto/hisilicon/zip/zip_main.c                                       |   23 
 drivers/crypto/intel/iaa/iaa_crypto_main.c                                    |    4 
 drivers/crypto/intel/qat/qat_common/adf_gen4_hw_data.h                        |    2 
 drivers/crypto/intel/qat/qat_common/adf_init.c                                |    4 
 drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_msg.c                         |    9 
 drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.c                         |   14 
 drivers/crypto/intel/qat/qat_common/adf_pfvf_vf_msg.h                         |    1 
 drivers/crypto/intel/qat/qat_common/adf_vf_isr.c                              |    2 
 drivers/crypto/n2_core.c                                                      |    1 
 drivers/crypto/qcom-rng.c                                                     |    4 
 drivers/cxl/core/pci.c                                                        |    8 
 drivers/edac/igen6_edac.c                                                     |    2 
 drivers/edac/synopsys_edac.c                                                  |   35 
 drivers/firewire/core-cdev.c                                                  |    2 
 drivers/firmware/arm_scmi/optee.c                                             |    7 
 drivers/firmware/efi/libstub/tpm.c                                            |    2 
 drivers/firmware/qcom/qcom_scm.c                                              |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h                                   |    4 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                                |   29 
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c                                        |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                       |  165 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   16 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                   |    9 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c                  |    6 
 drivers/gpu/drm/amd/display/dc/dc_dsc.h                                       |    3 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c                                   |    5 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                     |   50 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                       |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c                       |   14 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                       |   13 
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c                |    1 
 drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c              |    3 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                       |    2 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                                      |   35 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                                       |    2 
 drivers/gpu/drm/mediatek/mtk_crtc.c                                           |   32 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                         |   12 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                                         |    2 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                                     |   30 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c                                   |   46 
 drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h                         |    2 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                       |    2 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                                      |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                           |   10 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                                     |   12 
 drivers/gpu/drm/radeon/evergreen_cs.c                                         |   62 
 drivers/gpu/drm/radeon/radeon_atombios.c                                      |   29 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                                   |    4 
 drivers/gpu/drm/stm/drv.c                                                     |    4 
 drivers/gpu/drm/stm/ltdc.c                                                    |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                                |    8 
 drivers/hid/wacom_wac.c                                                       |   13 
 drivers/hid/wacom_wac.h                                                       |    2 
 drivers/hwmon/max16065.c                                                      |   27 
 drivers/hwmon/ntc_thermistor.c                                                |    1 
 drivers/hwtracing/coresight/coresight-dummy.c                                 |    4 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                               |    2 
 drivers/hwtracing/coresight/coresight-tpdm.c                                  |    6 
 drivers/i2c/busses/i2c-aspeed.c                                               |   16 
 drivers/i2c/busses/i2c-isch.c                                                 |    3 
 drivers/iio/adc/ad7606.c                                                      |    8 
 drivers/iio/adc/ad7606_spi.c                                                  |    5 
 drivers/iio/chemical/bme680_core.c                                            |    7 
 drivers/iio/magnetometer/ak8975.c                                             |    1 
 drivers/infiniband/core/cache.c                                               |    4 
 drivers/infiniband/core/iwcm.c                                                |    2 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   25 
 drivers/infiniband/hw/hns/hns_roce_ah.c                                       |   14 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |   22 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   33 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                       |   16 
 drivers/infiniband/hw/irdma/verbs.c                                           |    2 
 drivers/infiniband/hw/mlx5/main.c                                             |    2 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                          |    2 
 drivers/infiniband/hw/mlx5/mr.c                                               |   99 -
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                        |    1 
 drivers/input/keyboard/adp5588-keys.c                                         |    2 
 drivers/input/serio/i8042-acpipnpio.h                                         |   37 
 drivers/input/touchscreen/ilitek_ts_i2c.c                                     |   18 
 drivers/interconnect/icc-clk.c                                                |    3 
 drivers/interconnect/qcom/sm8350.c                                            |    1 
 drivers/iommu/amd/io_pgtable.c                                                |   14 
 drivers/iommu/amd/io_pgtable_v2.c                                             |    4 
 drivers/iommu/amd/iommu.c                                                     |   57 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                    |   28 
 drivers/iommu/iommufd/hw_pagetable.c                                          |    3 
 drivers/iommu/iommufd/io_pagetable.c                                          |    8 
 drivers/iommu/iommufd/selftest.c                                              |    9 
 drivers/leds/leds-bd2606mvv.c                                                 |   23 
 drivers/leds/leds-gpio.c                                                      |    9 
 drivers/leds/leds-pca995x.c                                                   |   78 
 drivers/md/dm-rq.c                                                            |    4 
 drivers/md/dm.c                                                               |   11 
 drivers/md/md.c                                                               |    1 
 drivers/media/dvb-frontends/rtl2830.c                                         |    2 
 drivers/media/dvb-frontends/rtl2832.c                                         |    2 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_if.c        |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req_multi_if.c  |    9 
 drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c         |   10 
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c                         |    1 
 drivers/media/tuners/tuner-i2c.h                                              |    4 
 drivers/mtd/devices/powernv_flash.c                                           |    3 
 drivers/mtd/devices/slram.c                                                   |    2 
 drivers/mtd/nand/raw/mtk_nand.c                                               |   36 
 drivers/net/bareudp.c                                                         |   26 
 drivers/net/bonding/bond_main.c                                               |    6 
 drivers/net/can/m_can/m_can.c                                                 |   14 
 drivers/net/can/usb/esd_usb.c                                                 |    6 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    3 
 drivers/net/ethernet/intel/idpf/idpf.h                                        |    4 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                                |  125 -
 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h                               |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                    |   72 
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c                           |  195 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                   |  989 +++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h                                   |  457 +++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                               |   73 
 drivers/net/ethernet/realtek/r8169_phy_config.c                               |    2 
 drivers/net/ethernet/renesas/ravb_main.c                                      |   12 
 drivers/net/ethernet/seeq/ether3.c                                            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c                          |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                             |    2 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   37 
 drivers/net/usb/usbnet.c                                                      |   37 
 drivers/net/virtio_net.c                                                      |   10 
 drivers/net/wireless/ath/ath11k/core.h                                        |    1 
 drivers/net/wireless/ath/ath11k/mac.c                                         |   12 
 drivers/net/wireless/ath/ath11k/wmi.c                                         |    4 
 drivers/net/wireless/ath/ath12k/mac.c                                         |    5 
 drivers/net/wireless/ath/ath12k/wmi.c                                         |    1 
 drivers/net/wireless/ath/ath12k/wmi.h                                         |    3 
 drivers/net/wireless/ath/ath9k/debug.c                                        |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                                |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c                     |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                   |   30 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c                       |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c                    |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h                       |   40 
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c                                   |   11 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                               |    1 
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h                            |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                           |   14 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                                 |   36 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h                         |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                              |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                              |    4 
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                               |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                              |   65 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                              |    6 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                               |   13 
 drivers/net/wireless/microchip/wilc1000/hif.c                                 |    4 
 drivers/net/wireless/realtek/rtw88/coex.c                                     |   38 
 drivers/net/wireless/realtek/rtw88/fw.c                                       |   13 
 drivers/net/wireless/realtek/rtw88/main.c                                     |    7 
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c                                |    2 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                                 |   10 
 drivers/net/wireless/realtek/rtw88/rx.h                                       |    2 
 drivers/net/wireless/realtek/rtw89/mac.h                                      |    1 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                            |    2 
 drivers/ntb/ntb_transport.c                                                   |   23 
 drivers/ntb/test/ntb_perf.c                                                   |    2 
 drivers/nvdimm/namespace_devs.c                                               |   34 
 drivers/nvme/host/multipath.c                                                 |    2 
 drivers/pci/controller/dwc/pci-dra7xx.c                                       |   11 
 drivers/pci/controller/dwc/pci-imx6.c                                         |   15 
 drivers/pci/controller/dwc/pci-keystone.c                                     |    2 
 drivers/pci/controller/dwc/pcie-kirin.c                                       |    4 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                                     |   14 
 drivers/pci/controller/pcie-xilinx-nwl.c                                      |   39 
 drivers/pci/pci.c                                                             |   20 
 drivers/pci/pci.h                                                             |    6 
 drivers/pci/quirks.c                                                          |   31 
 drivers/perf/alibaba_uncore_drw_pmu.c                                         |    2 
 drivers/perf/arm-cmn.c                                                        |  109 -
 drivers/perf/dwc_pcie_pmu.c                                                   |   21 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                                        |   16 
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c                             |    1 
 drivers/pinctrl/mvebu/pinctrl-dove.c                                          |   42 
 drivers/pinctrl/pinctrl-single.c                                              |    3 
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c                                       |   95 
 drivers/platform/x86/ideapad-laptop.c                                         |   48 
 drivers/pmdomain/core.c                                                       |    2 
 drivers/power/supply/axp20x_battery.c                                         |   16 
 drivers/power/supply/max17042_battery.c                                       |    5 
 drivers/powercap/intel_rapl_common.c                                          |    2 
 drivers/pps/clients/pps_parport.c                                             |    8 
 drivers/regulator/of_regulator.c                                              |    2 
 drivers/remoteproc/imx_rproc.c                                                |    6 
 drivers/reset/reset-berlin.c                                                  |    3 
 drivers/reset/reset-k210.c                                                    |    3 
 drivers/s390/crypto/ap_bus.c                                                  |   17 
 drivers/scsi/NCR5380.c                                                        |   78 
 drivers/scsi/elx/libefc/efc_nport.c                                           |    2 
 drivers/scsi/lpfc/lpfc_hw4.h                                                  |    3 
 drivers/scsi/lpfc/lpfc_init.c                                                 |   21 
 drivers/scsi/lpfc/lpfc_scsi.c                                                 |    2 
 drivers/scsi/mac_scsi.c                                                       |  162 -
 drivers/scsi/sd.c                                                             |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   20 
 drivers/soc/fsl/qe/qmc.c                                                      |   24 
 drivers/soc/fsl/qe/tsa.c                                                      |    2 
 drivers/soc/qcom/smd-rpm.c                                                    |   35 
 drivers/soc/versatile/soc-integrator.c                                        |    1 
 drivers/soc/versatile/soc-realview.c                                          |   20 
 drivers/spi/atmel-quadspi.c                                                   |   15 
 drivers/spi/spi-airoha-snfi.c                                                 |   43 
 drivers/spi/spi-bcmbca-hsspi.c                                                |    8 
 drivers/spi/spi-fsl-lpspi.c                                                   |    1 
 drivers/spi/spi-nxp-fspi.c                                                    |   54 
 drivers/spi/spi-ppc4xx.c                                                      |    7 
 drivers/staging/media/starfive/camss/stf-camss.c                              |    2 
 drivers/thermal/gov_bang_bang.c                                               |   14 
 drivers/thermal/thermal_core.c                                                |   78 
 drivers/tty/serial/8250/8250_omap.c                                           |    2 
 drivers/tty/serial/qcom_geni_serial.c                                         |  101 -
 drivers/tty/serial/rp2.c                                                      |    2 
 drivers/tty/serial/serial_core.c                                              |   13 
 drivers/ufs/host/ufs-qcom.c                                                   |    2 
 drivers/usb/cdns3/cdnsp-ring.c                                                |    6 
 drivers/usb/cdns3/host.c                                                      |    4 
 drivers/usb/class/cdc-acm.c                                                   |    2 
 drivers/usb/dwc2/drd.c                                                        |    9 
 drivers/usb/gadget/udc/dummy_hcd.c                                            |   14 
 drivers/usb/host/xhci-mem.c                                                   |    5 
 drivers/usb/host/xhci-pci.c                                                   |   22 
 drivers/usb/host/xhci-ring.c                                                  |   14 
 drivers/usb/host/xhci.h                                                       |    3 
 drivers/usb/misc/appledisplay.c                                               |   15 
 drivers/usb/misc/cypress_cy7c63.c                                             |    4 
 drivers/usb/misc/yurex.c                                                      |   10 
 drivers/vdpa/mlx5/core/mr.c                                                   |    3 
 drivers/vhost/vdpa.c                                                          |   16 
 drivers/video/fbdev/hpfb.c                                                    |    1 
 drivers/video/fbdev/xen-fbfront.c                                             |    1 
 drivers/watchdog/imx_sc_wdt.c                                                 |   24 
 drivers/xen/swiotlb-xen.c                                                     |   10 
 fs/autofs/inode.c                                                             |    3 
 fs/btrfs/btrfs_inode.h                                                        |    1 
 fs/btrfs/ctree.h                                                              |    2 
 fs/btrfs/extent-tree.c                                                        |    4 
 fs/btrfs/file.c                                                               |   34 
 fs/btrfs/ioctl.c                                                              |    4 
 fs/btrfs/subpage.c                                                            |   10 
 fs/btrfs/tree-checker.c                                                       |    2 
 fs/cachefiles/xattr.c                                                         |   34 
 fs/debugfs/inode.c                                                            |   24 
 fs/erofs/inode.c                                                              |   20 
 fs/erofs/zdata.c                                                              |  136 -
 fs/eventpoll.c                                                                |    2 
 fs/exfat/nls.c                                                                |    5 
 fs/ext4/ialloc.c                                                              |   14 
 fs/ext4/inline.c                                                              |   35 
 fs/ext4/mballoc.c                                                             |   10 
 fs/ext4/super.c                                                               |   29 
 fs/f2fs/compress.c                                                            |   36 
 fs/f2fs/data.c                                                                |   10 
 fs/f2fs/dir.c                                                                 |    3 
 fs/f2fs/extent_cache.c                                                        |    4 
 fs/f2fs/f2fs.h                                                                |   37 
 fs/f2fs/file.c                                                                |  101 -
 fs/f2fs/inode.c                                                               |    5 
 fs/f2fs/namei.c                                                               |   68 
 fs/f2fs/segment.c                                                             |   15 
 fs/f2fs/super.c                                                               |   16 
 fs/f2fs/xattr.c                                                               |   14 
 fs/fcntl.c                                                                    |   14 
 fs/fs_parser.c                                                                |   34 
 fs/fuse/file.c                                                                |    2 
 fs/inode.c                                                                    |    4 
 fs/jfs/jfs_dmap.c                                                             |    4 
 fs/jfs/jfs_imap.c                                                             |    2 
 fs/namespace.c                                                                |   14 
 fs/netfs/main.c                                                               |    4 
 fs/nfs/nfs4state.c                                                            |    1 
 fs/nfsd/filecache.c                                                           |    3 
 fs/nfsd/nfs4idmap.c                                                           |   13 
 fs/nfsd/nfs4recover.c                                                         |    8 
 fs/nfsd/nfs4state.c                                                           |  164 -
 fs/nilfs2/btree.c                                                             |   12 
 fs/quota/dquot.c                                                              |    3 
 fs/smb/server/vfs.c                                                           |   19 
 include/acpi/acoutput.h                                                       |    5 
 include/acpi/cppc_acpi.h                                                      |    2 
 include/linux/bpf.h                                                           |    9 
 include/linux/bpf_lsm.h                                                       |    8 
 include/linux/compiler.h                                                      |    2 
 include/linux/f2fs_fs.h                                                       |    2 
 include/linux/fs_parser.h                                                     |    6 
 include/linux/lsm_hook_defs.h                                                 |    1 
 include/linux/lsm_hooks.h                                                     |    1 
 include/linux/sbitmap.h                                                       |    2 
 include/linux/soc/qcom/geni-se.h                                              |    9 
 include/linux/usb/usbnet.h                                                    |   15 
 include/net/bluetooth/hci_core.h                                              |    4 
 include/net/ip.h                                                              |    2 
 include/net/mac80211.h                                                        |    7 
 include/net/tcp.h                                                             |   21 
 include/sound/tas2781.h                                                       |    7 
 include/trace/events/f2fs.h                                                   |    3 
 io_uring/io-wq.c                                                              |   25 
 io_uring/io_uring.c                                                           |    4 
 io_uring/rw.c                                                                 |    8 
 io_uring/sqpoll.c                                                             |   12 
 kernel/bpf/bpf_lsm.c                                                          |   34 
 kernel/bpf/btf.c                                                              |   13 
 kernel/bpf/helpers.c                                                          |   12 
 kernel/bpf/syscall.c                                                          |    4 
 kernel/bpf/verifier.c                                                         |  134 -
 kernel/kthread.c                                                              |   10 
 kernel/locking/lockdep.c                                                      |   48 
 kernel/module/Makefile                                                        |    2 
 kernel/padata.c                                                               |    6 
 kernel/rcu/tree_nocb.h                                                        |    5 
 kernel/sched/deadline.c                                                       |   38 
 kernel/sched/fair.c                                                           |   34 
 kernel/trace/bpf_trace.c                                                      |   15 
 lib/debugobjects.c                                                            |    5 
 lib/sbitmap.c                                                                 |    4 
 lib/xz/xz_crc32.c                                                             |    2 
 lib/xz/xz_private.h                                                           |    4 
 mm/damon/vaddr.c                                                              |    2 
 mm/huge_memory.c                                                              |    2 
 mm/hugetlb.c                                                                  |  176 +
 mm/internal.h                                                                 |   11 
 mm/memory.c                                                                   |    8 
 mm/migrate.c                                                                  |    2 
 mm/mmap.c                                                                     |    4 
 mm/util.c                                                                     |    2 
 net/bluetooth/hci_conn.c                                                      |    6 
 net/bluetooth/hci_sync.c                                                      |    5 
 net/bluetooth/mgmt.c                                                          |   13 
 net/can/bcm.c                                                                 |    4 
 net/can/j1939/transport.c                                                     |    8 
 net/core/filter.c                                                             |   71 
 net/core/sock_map.c                                                           |    1 
 net/hsr/hsr_slave.c                                                           |   11 
 net/ipv4/icmp.c                                                               |  103 -
 net/ipv6/Kconfig                                                              |    1 
 net/ipv6/icmp.c                                                               |   28 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   14 
 net/ipv6/route.c                                                              |    2 
 net/ipv6/rpl_iptunnel.c                                                       |   12 
 net/mac80211/iface.c                                                          |   17 
 net/mac80211/mlme.c                                                           |   30 
 net/mac80211/offchannel.c                                                     |    1 
 net/mac80211/rate.c                                                           |    2 
 net/mac80211/scan.c                                                           |    2 
 net/mac80211/tx.c                                                             |    2 
 net/netfilter/nf_conntrack_netlink.c                                          |    7 
 net/netfilter/nf_tables_api.c                                                 |   18 
 net/netfilter/nft_compat.c                                                    |    6 
 net/netfilter/nft_dynset.c                                                    |    6 
 net/netfilter/nft_log.c                                                       |    2 
 net/netfilter/nft_meta.c                                                      |    2 
 net/netfilter/nft_numgen.c                                                    |    2 
 net/netfilter/nft_set_pipapo.c                                                |   13 
 net/netfilter/nft_tunnel.c                                                    |    5 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/tipc/bcast.c                                                              |    2 
 net/wireless/nl80211.c                                                        |    3 
 net/wireless/scan.c                                                           |    6 
 net/wireless/sme.c                                                            |    3 
 net/wireless/util.c                                                           |   10 
 net/xdp/xsk_buff_pool.c                                                       |   25 
 samples/bpf/Makefile                                                          |    6 
 security/apparmor/include/net.h                                               |    3 
 security/apparmor/lsm.c                                                       |   17 
 security/apparmor/net.c                                                       |    2 
 security/bpf/hooks.c                                                          |    1 
 security/integrity/ima/ima.h                                                  |    2 
 security/integrity/ima/ima_iint.c                                             |   20 
 security/integrity/ima/ima_main.c                                             |    2 
 security/landlock/fs.c                                                        |    9 
 security/security.c                                                           |   68 
 security/selinux/hooks.c                                                      |   80 
 security/selinux/include/objsec.h                                             |    5 
 security/selinux/netlabel.c                                                   |   23 
 security/smack/smack.h                                                        |    5 
 security/smack/smack_lsm.c                                                    |   70 
 security/smack/smack_netfilter.c                                              |    4 
 security/smack/smackfs.c                                                      |    2 
 sound/pci/hda/cs35l41_hda_spi.c                                               |    1 
 sound/pci/hda/tas2781_hda_i2c.c                                               |    2 
 sound/soc/codecs/rt5682.c                                                     |    4 
 sound/soc/codecs/rt5682s.c                                                    |    4 
 sound/soc/codecs/tas2781-comlib.c                                             |    3 
 sound/soc/codecs/tas2781-fmwlib.c                                             |    1 
 sound/soc/codecs/tas2781-i2c.c                                                |   58 
 sound/soc/loongson/loongson_card.c                                            |    4 
 tools/bpf/runqslower/Makefile                                                 |    3 
 tools/build/feature/test-all.c                                                |    4 
 tools/include/nolibc/string.h                                                 |    1 
 tools/lib/bpf/libbpf.c                                                        |   75 
 tools/objtool/arch/loongarch/decode.c                                         |   11 
 tools/objtool/check.c                                                         |   23 
 tools/objtool/include/objtool/elf.h                                           |    1 
 tools/perf/builtin-c2c.c                                                      |   14 
 tools/perf/builtin-inject.c                                                   |    1 
 tools/perf/builtin-mem.c                                                      |   20 
 tools/perf/builtin-report.c                                                   |    3 
 tools/perf/builtin-sched.c                                                    |    8 
 tools/perf/scripts/python/arm-cs-trace-disasm.py                              |    9 
 tools/perf/util/annotate-data.c                                               |    2 
 tools/perf/util/bpf_skel/lock_data.h                                          |    4 
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h                                    |    1 
 tools/perf/util/dwarf-aux.c                                                   |   16 
 tools/perf/util/mem-events.c                                                  |   20 
 tools/perf/util/mem-events.h                                                  |    4 
 tools/perf/util/session.c                                                     |    3 
 tools/perf/util/stat-display.c                                                |    3 
 tools/perf/util/time-utils.c                                                  |    4 
 tools/perf/util/tool.h                                                        |    1 
 tools/power/cpupower/lib/powercap.c                                           |    8 
 tools/testing/selftests/arm64/signal/Makefile                                 |    2 
 tools/testing/selftests/arm64/signal/sve_helpers.c                            |   56 
 tools/testing/selftests/arm64/signal/sve_helpers.h                            |   21 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c |   46 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c |   30 
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c                    |   36 
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c                 |   36 
 tools/testing/selftests/arm64/signal/testcases/sve_regs.c                     |   32 
 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c                   |   32 
 tools/testing/selftests/arm64/signal/testcases/za_regs.c                      |   36 
 tools/testing/selftests/bpf/Makefile                                          |   13 
 tools/testing/selftests/bpf/bench.c                                           |    1 
 tools/testing/selftests/bpf/bench.h                                           |    1 
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c                        |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c                  |    2 
 tools/testing/selftests/bpf/prog_tests/core_reloc.c                           |    1 
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c                        |    1 
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c                         |    1 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c                       |    2 
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c                            |    1 
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c                         |    1 
 tools/testing/selftests/bpf/prog_tests/lwt_reroute.c                          |    1 
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c                  |    2 
 tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c                    |    1 
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c                            |    1 
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c                          |   12 
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c                              |    1 
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c                         |    1 
 tools/testing/selftests/bpf/progs/bpf_misc.h                                  |   31 
 tools/testing/selftests/bpf/progs/cg_storage_multi.h                          |    2 
 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c             |    1 
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c                       |    8 
 tools/testing/selftests/bpf/test_cpp.cpp                                      |    4 
 tools/testing/selftests/bpf/test_loader.c                                     |  299 ++-
 tools/testing/selftests/bpf/test_lru_map.c                                    |    3 
 tools/testing/selftests/bpf/test_progs.c                                      |   18 
 tools/testing/selftests/bpf/test_progs.h                                      |    1 
 tools/testing/selftests/bpf/testing_helpers.c                                 |    6 
 tools/testing/selftests/bpf/unpriv_helpers.c                                  |    1 
 tools/testing/selftests/bpf/veristat.c                                        |    8 
 tools/testing/selftests/dt/test_unprobed_devices.sh                           |   15 
 tools/testing/selftests/ftrace/test.d/00basic/test_ownership.tc               |   12 
 tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc          |    9 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc              |    2 
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc            |    2 
 tools/testing/selftests/kselftest.h                                           |    2 
 tools/testing/selftests/net/netfilter/ipvs.sh                                 |    2 
 tools/testing/selftests/resctrl/cat_test.c                                    |    7 
 virt/kvm/kvm_main.c                                                           |   31 
 622 files changed, 7149 insertions(+), 4458 deletions(-)

Aaron Lu (1):
      x86/sgx: Fix deadlock in SGX NUMA node search

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Fix PHY for DP2

Abhinav Kumar (1):
      drm/msm/dp: enable widebus on all relevant chipsets

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling synchronization

Aleksa Sarai (1):
      autofs: fix missing fput for FSCONFIG_SET_FD

Aleksandr Mishin (2):
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
      drm/msm: Fix incorrect file name output in adreno_request_fw()

Alex Bee (1):
      drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher (3):
      drm/amdgpu: properly handle vbios fake edid sizing
      drm/radeon: properly handle vbios fake edid sizing
      drm/amdgpu/mes11: reduce timeout

Alexander Dahl (3):
      ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
      spi: atmel-quadspi: Avoid overwriting delay register settings
      spi: atmel-quadspi: Fix wrong register value written to MR

Alexander Lobakin (3):
      idpf: stop using macros for accessing queue descriptors
      idpf: split &idpf_queue into 4 strictly-typed queue structures
      idpf: merge singleq and splitq &net_device_ops

Alexander Shiyan (1):
      clk: rockchip: rk3588: Fix 32k clock name for pmu_24m_32k_100m_src_p

Alexandra Diupina (1):
      PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Alexei Starovoitov (1):
      selftests/bpf: Workaround strict bpf_lsm return value check.

Alexey Gladkov (Intel) (1):
      x86/tdx: Fix "in-kernel MMIO" check

Amit Shah (1):
      crypto: ccp - do not request interrupt on cmd completion when irqs disabled

Anastasia Belova (1):
      arm64: esr: Define ESR_ELx_EC_* constants as UL

Andre Przywara (1):
      kselftest/arm64: signal: fix/refactor SVE vector length enumeration

Andrew Davis (3):
      arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
      arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations
      hwmon: (max16065) Remove use of i2c_match_id()

Andrew Jones (1):
      RISC-V: KVM: Fix sbiret init before forwarding to userspace

Andrey Konovalov (1):
      usb: gadget: dummy_hcd: execute hrtimer callback in softirq context

Andrii Nakryiko (1):
      libbpf: Fix bpf_object__open_skeleton()'s mishandling of options

Andy Shevchenko (3):
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      platform/x86: ideapad-laptop: Make the scope_guard() clear of its scope
      i2c: isch: Add missed 'else'

AngeloGioacchino Del Regno (1):
      arm64: dts: mediatek: mt8186: Fix supported-hw mask for GPU OPPs

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Antoniu Miclaus (1):
      ABI: testing: fix admv8818 attr description

Anup Patel (1):
      RISC-V: KVM: Don't zero-out PMU snapshot area before freeing data

Ard Biesheuvel (1):
      efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Arend van Spriel (1):
      wifi: brcmfmac: introducing fwil query functions

Arnaldo Carvalho de Melo (1):
      perf build: Fix up broken capstone feature detection fast path

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Atish Patra (2):
      RISC-V: KVM: Allow legacy PMU access from guest
      RISC-V: KVM: Fix to allow hpmcounter31 from the guest

Avraham Stern (1):
      wifi: iwlwifi: mvm: increase the time between ranging measurements

Baochen Qiang (1):
      wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

Baokun Li (1):
      netfs: Delete subtree of 'fs/netfs' when netfs module exits

Biju Das (1):
      media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TABLE

Bitterblue Smith (3):
      wifi: rtw88: Fix USB/SDIO devices not transmitting beacons
      wifi: rtw88: 8822c: Fix reported RX band width
      wifi: rtw88: 8703b: Fix reported RX band width

Bjørn Mork (1):
      wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Brian Masney (1):
      crypto: qcom-rng - fix support for ACPI-based systems

Calvin Owens (1):
      ARM: 9410/1: vfp: Use asm volatile in fmrx/fmxr macros

Casey Schaufler (1):
      lsm: infrastructure management of the sock security

Chao Yu (9):
      f2fs: atomic: fix to avoid racing w/ GC
      f2fs: reduce expensive checkpoint trigger frequency
      f2fs: fix to avoid racing in between read and OPU dio write
      f2fs: fix to wait page writeback before setting gcing flag
      f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
      f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
      f2fs: get rid of online repaire on corrupted directory
      f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
      f2fs: fix to check atomic_file in f2fs ioctl interfaces

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Ni (1):
      iommu/amd: Convert comma to semicolon

Chen Yu (2):
      kthread: fix task state in kthread worker if being frozen
      sched/pelt: Use rq_clock_task() for hw_pressure

Chen-Yu Tsai (5):
      regulator: Return actual error in of_regulator_bulk_get_all()
      arm64: dts: mediatek: mt8195: Correct clock order for dp_intf*
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled
      arm64: dts: mediatek: mt8395-nio-12l: Mark USB 3.0 on xhci1 as disabled
      arm64: dts: mediatek: mt8186-corsola: Disable DPI display interface

Cheng Xu (1):
      RDMA/erdma: Return QP state in erdma_query_qp

Chengchang Tang (2):
      RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
      RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Chris Morgan (1):
      power: supply: axp20x_battery: Remove design from min and max voltage

Christophe JAILLET (3):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pinctrl: ti: ti-iodelay: Fix some error handling paths

Christophe Leroy (3):
      powerpc/8xx: Fix initial memory mapping
      powerpc/8xx: Fix kernel vs user address comparison
      powerpc/vdso: Inconditionally use CFUNC macro

Claudiu Beznea (3):
      ARM: dts: microchip: sama7g5: Fix RTT clock
      drm/stm: ltdc: check memory returned by devm_kzalloc()
      clk: at91: sama7g5: Allocate only the needed amount of memory for PLLs

Clément Léger (1):
      ACPI: CPPC: Fix MASK_VAL() usage

Connor Abbott (3):
      drm/msm: Use a7xx family directly in gpu_state
      drm/msm: Dump correct dbgahb clusters on a750
      drm/msm: Fix CP_BV_DRAW_STATE_ADDR name

Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Explicitly include pm_runtime.h

Cristian Marussi (1):
      firmware: arm_scmi: Fix double free in OPTEE transport

Cupertino Miranda (1):
      selftests/bpf: Support checks against a regular expression

D Scott Phillips (1):
      arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a

Daeho Jeong (1):
      f2fs: prevent atomic file from being dirtied before commit

Daehwan Jung (1):
      xhci: Add a quirk for writing ERST in high-low order

Damien Le Moal (1):
      ata: libata-scsi: Fix ata_msense_control() CDL page reporting

Dan Carpenter (5):
      crypto: iaa - Fix potential use after free bug
      powercap: intel_rapl: Fix off by one in get_rpi()
      scsi: elx: libefc: Fix potential use after free in efc_nport_vport_del()
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()

Daniel Borkmann (4):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
      bpf: Fix helper writes to read-only maps
      bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
      bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error

Daniel Yang (1):
      exfat: resolve memory leak from exfat_create_upcase_table()

Danny Tsen (1):
      crypto: powerpc/p10-aes-gcm - Disable CRYPTO_AES_GCM_P10

Dave Jiang (1):
      ntb: Force physically contiguous allocation of rx ring buffers

Dave Martin (1):
      arm64: signal: Fix some under-bracketed UAPI macros

David Gow (1):
      mm: only enforce minimum stack gap size if it's sensible

David Howells (1):
      cachefiles: Fix non-taking of sb_writers around set/removexattr

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

David Vernet (1):
      libbpf: Don't take direct pointers into BTF data from st_ops

David Virag (1):
      arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB

Dmitry Antipov (4):
      wifi: rtw88: always wait for both firmware loading attempts
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()

Dmitry Baryshkov (9):
      iommu/arm-smmu-qcom: apply num_context_bank fixes for SDM630 / SDM660
      drm/msm/dsi: correct programming sequence for SM8350 / SM8450
      clk: qcom: dispcc-sm8550: fix several supposed typos
      clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src
      clk: qcom: dispcc-sm8650: Update the GDSC flags
      clk: qcom: dispcc-sm8550: use rcg2_shared_ops for ESC RCGs
      clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL
      interconnect: qcom: sm8250: Enable sync_state
      Revert "soc: qcom: smd-rpm: Match rpmsg channel instead of compatible"

Dmitry Kandybka (1):
      wifi: rtw88: remove CPT execution branch never used

Dmitry Vyukov (2):
      x86/entry: Remove unwanted instrumentation in common_interrupt()
      module: Fix KCOV-ignored file name

Douglas Anderson (4):
      arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first
      soc: qcom: geni-se: add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
      serial: qcom-geni: fix arg types for qcom_geni_serial_poll_bit()
      serial: qcom-geni: introduce qcom_geni_serial_poll_bitfield()

Dragan Simic (2):
      arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
      arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Dragos Tatulea (1):
      vdpa/mlx5: Fix invalid mr resource destroy

Eduard Zingerman (7):
      selftests/bpf: no need to track next_match_pos in struct test_loader
      selftests/bpf: extract test_loader->expect_msgs as a data structure
      selftests/bpf: allow checking xlated programs in verifier_* tests
      selftests/bpf: __arch_* macro to limit test cases to specific archs
      selftests/bpf: fix to avoid __msg tag de-duplication by clang
      bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
      selftests/bpf: correctly move 'log' upon successful match

Eliav Bar-ilan (1):
      iommu/amd: Fix argument order in amd_iommu_dev_flush_pasid_all()

Emanuele Ghidoli (2):
      Input: ilitek_ts_i2c - avoid wrong input subsystem sync
      Input: ilitek_ts_i2c - add report id message validation

Emmanuel Grumbach (2):
      wifi: mac80211: fix the comeback long retry times
      wifi: iwlwifi: mvm: allow ESR when we the ROC expires

Eric Dumazet (4):
      sock_map: Add a cond_resched() in sock_hash_free()
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      icmp: change the order of rate limits

Eric Sandeen (2):
      fs_parse: add uid & gid option option parsing helpers
      debugfs: Convert to new uid/gid option parsing helpers

Esther Shimanovich (1):
      ACPI: video: force native for Apple MacbookPro9,2

Fabio Porcedda (1):
      bus: mhi: host: pci_generic: Fix the name for the Telit FE990A

Fangzhi Zuo (2):
      drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Fei Shao (1):
      drm/mediatek: Use spin_lock_irqsave() for CRTC event lock

Felix Fietkau (2):
      wifi: mt76: mt7603: fix mixed declarations and code
      wifi: mt76: mt7996: fix uninitialized TLV data

Felix Moessbauer (4):
      io_uring/io-wq: do not allow pinning outside of cpuset
      io_uring/io-wq: inherit cpuset of cgroup in io worker
      io_uring/sqpoll: do not allow pinning outside of cpuset
      io_uring/sqpoll: do not put cpumask on stack

Filipe Manana (1):
      btrfs: fix race setting file private on concurrent lseek using same fd

Finn Thain (5):
      m68k: Fix kernel_clone_args.flags in m68k_clone()
      scsi: NCR5380: Check for phase match during PDMA fixup
      scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages
      scsi: mac_scsi: Refactor polling loop
      scsi: mac_scsi: Disallow bus errors during PDMA send

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Frank Li (2):
      dt-bindings: PCI: layerscape-pci: Replace fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
      PCI: imx6: Fix missing call to phy_power_off() in error handling

Frederic Weisbecker (1):
      rcu/nocb: Fix RT throttling hrtimer armed from offline CPU

Furong Xu (1):
      net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled

Gao Xiang (3):
      erofs: fix incorrect symlink detection in fast symlink
      erofs: tidy up `struct z_erofs_bvec`
      erofs: handle overlapped pclusters out of crafted images properly

Gaosheng Cui (2):
      hwrng: bcm2835 - Add missing clk_disable_unprepare in bcm2835_rng_init
      hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Geert Uytterhoeven (1):
      pmdomain: core: Harden inter-column space in debug summary

Gilbert Wu (1):
      scsi: smartpqi: revert propagate-the-multipath-failure-to-SML-quickly

Golan Ben Ami (1):
      wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL

Greg Kroah-Hartman (1):
      Linux 6.10.13

Guenter Roeck (2):
      hwmon: (max16065) Fix overflows seen when writing limits
      hwmon: (max16065) Fix alarm attributes

Guillaume Nault (2):
      bareudp: Pull inner IP header in bareudp_udp_encap_recv().
      bareudp: Pull inner IP header on xmit.

Guillaume Stols (2):
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

Guoqing Jiang (2):
      nfsd: call cache_put if xdr_reserve_space returns NULL
      hwrng: mtk - Use devm_pm_runtime_enable

Haibo Chen (3):
      spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
      dt-bindings: spi: nxp-fspi: add imx8ulp support
      spi: fspi: add support for imx8ulp

Hannes Reinecke (1):
      nvme-multipath: system fails to create generic nvme device

Hao Ge (1):
      selftests/bpf: Fix incorrect parameters in NULL pointer checking

Harald Freudenberger (1):
      s390/ap: Fix deadlock caused by recursive lock of the AP bus scan mutex

Heiner Kallweit (1):
      r8169: disable ALDPS per default for RTL8125

Helge Deller (1):
      crypto: xor - fix template benchmarking

Herbert Xu (2):
      crypto: n2 - Set err to EINVAL if snprintf fails for hmac
      crypto: caam - Pad SG length when allocating hash edesc

Herve Codina (2):
      soc: fsl: cpm1: qmc: Update TRNSYNC only in transparent mode
      soc: fsl: cpm1: tsa: Fix tsa_write8()

Hobin Woo (1):
      ksmbd: make __dir_empty() compatible with POSIX

Hou Wenlong (1):
      KVM: x86: Drop unused check_apicv_inhibit_reasons() callback definition

Howard Hsu (3):
      wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
      wifi: mt76: mt7996: fix EHT beamforming capability check
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Huacai Chen (1):
      Revert "LoongArch: KVM: Invalidate guest steal time address on vCPU reset"

Huang Shijie (1):
      sched/deadline: Fix schedstats vs deadline servers

Ian Rogers (2):
      perf inject: Fix leader sampling inserting additional samples
      perf time-utils: Fix 32-bit nsec parsing

Ilan Peer (1):
      wifi: mac80211: Check for missing VHT elements only for 5 GHz

Ilpo Järvinen (1):
      PCI: Wait for Link before restoring Downstream Buses

Jack Wang (1):
      RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer

Jacky Bai (1):
      clk: imx: composite-93: keep root clock on when mcore enabled

Jake Hamby (1):
      can: m_can: enable NAPI before enabling interrupts

James Clark (1):
      perf scripts python cs-etm: Restore first sample log in verbose mode

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jason Andryuk (1):
      fbdev: xen-fbfront: Assign fb_info->device

Jason Gerecke (2):
      HID: wacom: Support sequence numbers smaller than 16-bit
      HID: wacom: Do not warn about dropped packets for first packet

Jason Gunthorpe (7):
      iommu/amd: Allocate the page table root using GFP_KERNEL
      iommu/amd: Move allocation of the top table into v1_alloc_pgtable
      iommu/amd: Set the pgsize_bitmap correctly
      iommu/amd: Do not set the D bit on AMD v2 table entries
      iommufd/selftest: Fix buffer read overrrun in the dirty test
      iommufd: Check the domain owner of the parent before creating a nesting domain
      iommufd: Protect against overflow of ALIGN() during iova allocation

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Jason-JH.Lin (1):
      drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()

Javier Carrasco (3):
      leds: bd2606mvv: Fix device child node usage in bd2606mvv_probe()
      leds: pca995x: Use device_for_each_child_node() to access device child nodes
      leds: pca995x: Fix device child node usage in pca995x_probe()

Jeff Layton (3):
      nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
      nfsd: fix refcount leak when file is unhashed after being found
      nfsd: fix initial getattr on write delegation

Jens Axboe (3):
      io_uring/rw: treat -EOPNOTSUPP for IOCB_NOWAIT like -EAGAIN
      io_uring: check for presence of task_work rather than TIF_NOTIFY_SIGNAL
      io_uring/sqpoll: retain test for whether the CPU is valid

Jeongjun Park (2):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      mm: migrate: annotate data-race in migrate_folio_unmap()

Jiangshan Yi (1):
      samples/bpf: Fix compilation errors with cf-protection option

Jiawei Ye (2):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jie Gan (2):
      Coresight: Set correct cs_mode for TPDM to fix disable issue
      Coresight: Set correct cs_mode for dummy source to fix disable issue

Jing Zhang (1):
      drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Jinjie Ruan (8):
      net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
      mtd: rawnand: mtk: Use for_each_child_of_node_scoped()
      riscv: Fix fp alignment bug in perf_callchain_user()
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      spi: atmel-quadspi: Undo runtime PM changes at driver exit time
      spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
      driver core: Fix a potential null-ptr-deref in module_add_driver()

Jiri Slaby (SUSE) (1):
      serial: don't use uninitialized value in uart_poll_init()

Jiwon Kim (1):
      bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Johan Hovold (3):
      serial: qcom-geni: fix fifo polling timeout
      serial: qcom-geni: fix false console tx restart
      serial: qcom-geni: fix console corruption

Johannes Berg (1):
      wifi: iwlwifi: config: label 'gl' devices as discrete

John B. Wyatt IV (1):
      pm:cpupower: Add missing powercap_set_enabled() stub function

Jon Hunter (1):
      arm64: tegra: Correct location of power-sensors for IGX Orin

Jonas Blixt (1):
      watchdog: imx_sc_wdt: Don't disable WDT in suspend

Jonas Karlman (3):
      arm64: dts: rockchip: Correct vendor prefix for Hardkernel ODROID-M1
      drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Juergen Gross (9):
      xen: use correct end address of kernel for conflict checking
      xen: introduce generic helper checking for memory map conflicts
      xen: move max_pfn in xen_memory_setup() out of function scope
      xen: add capability to remap non-RAM pages to different PFNs
      xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
      xen/swiotlb: add alignment check for dma buffers
      xen/swiotlb: fix allocated size
      xen: move checks for e820 conflicts further up
      xen: allow mapping ACPI data using a different physical address

Julian Sun (1):
      vfs: fix race between evice_inodes() and find_inode()&iput()

Junlin Li (2):
      drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junxian Huang (5):
      RDMA/hns: Don't modify rq next block addr in HIP09 QPC
      RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
      RDMA/hns: Optimize hem allocation performance
      RDMA/hns: Fix restricted __le16 degrades to integer issue
      RDMA/hns: Fix ah error counter in sw stat not increasing

Justin Iurman (1):
      net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Justin Tee (1):
      scsi: lpfc: Restrict support for 32 byte CDBs to specific HBAs

Kaixin Wang (1):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition

Kamlesh Gurudasani (1):
      padata: Honor the caller's alignment in case of chunk_size 0

Kan Liang (4):
      perf report: Fix --total-cycles --stdio output error
      perf mem: Check mem_events for all eligible PMUs
      perf mem: Fix missed p-core mem events on ADL and RPL
      perf/x86/intel: Allow to setup LBR for counting event for BPF

Kang Yang (1):
      wifi: ath11k: use work queue to process beacon tx event

Kees Cook (2):
      leds: gpio: Set num_leds after allocation
      interconnect: icc-clk: Add missed num_nodes initialization

Kemeng Shi (4):
      ext4: avoid buffer_head leak in ext4_mark_inode_used()
      ext4: avoid potential buffer_head leak in __ext4_new_inode()
      ext4: avoid negative min_clusters in find_group_orlov()
      quota: avoid missing put_quota_format when DQUOT_SUSPENDED is passed

Kexy Biscuit (1):
      tpm: export tpm2_sessions_init() to fix ibmvtpm building

Kirill A. Shutemov (4):
      x86/mm: Make x86_platform.guest.enc_status_change_*() return an error
      x86/tdx: Account shared memory
      x86/mm: Add callbacks to prepare encrypted memory for kexec
      x86/tdx: Convert shared memory back to private on kexec

Konrad Dybcio (1):
      iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages

Krishna chaitanya chundru (2):
      perf/dwc_pcie: Fix registration issue in multi PCIe controller instances
      perf/dwc_pcie: Always register for PCIe bus notifier

Krzysztof Kozlowski (13):
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      reset: k210: fix OF node leak in probe() error path
      iio: magnetometer: ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
      soc: versatile: integrator: fix OF node leak in probe() error path
      bus: integrator-lm: fix OF node leak in probe()
      cpuidle: riscv-sbi: Use scoped device node handling to fix missing of_node_put
      ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl
      ARM: dts: imx6ull-seeed-npi: fix fsl,pins property in tscgrp pinctrl
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove

Kuniyuki Iwashima (1):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().

Lad Prabhakar (4):
      arm64: dts: renesas: r9a08g045: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g043u: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes

Lang Yu (1):
      drm/amdgpu: fix invalid fence handling in amdgpu_vm_tlb_flush

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (1):
      Remove *.orig pattern from .gitignore

Leo Ma (1):
      drm/amd/display: Add HDMI DSC native YCbCr422 support

Leon Hwang (2):
      bpf, x64: Fix tailcall hierarchy
      bpf, arm64: Fix tailcall hierarchy

Li Chen (1):
      ACPI: resource: Do IRQ override on MECHREV GM7XG0M

Li Lingfeng (2):
      nfsd: return -EINVAL when namelen is 0
      nfs: fix memory leak in error path of nfs4_do_reclaim

Li Zhijian (1):
      nvdimm: Fix devs leaks in scan_labels()

Liam R. Howlett (1):
      mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock

Linus Torvalds (1):
      minmax: avoid overly complex min()/max() macro arguments in xen

Linus Walleij (2):
      ASoC: tas2781-i2c: Drop weird GPIO code
      ASoC: tas2781-i2c: Get the right GPIO line

Liu Ying (1):
      drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()

Lorenzo Bianconi (3):
      spi: airoha: fix dirmap_{read,write} operations
      spi: airoha: fix airoha_snand_{write,read}_data data_len estimation
      spi: airoha: remove read cache in airoha_snand_dirmap_read()

Luca Stefani (1):
      btrfs: always update fstrim_range on failure in FITRIM ioctl

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
      Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
      Bluetooth: btusb: Fix not handling ZPL/short-transfer

MD Danish Anwar (1):
      arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas

Ma Ke (8):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
      ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
      pps: add an error check in parport_attach
      wifi: mt76: mt7921: Check devm_kasprintf() returned value
      wifi: mt76: mt7915: check devm_kasprintf() returned value
      wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
      wifi: mt76: mt7615: check devm_kasprintf() returned value

Maciej Fijalkowski (1):
      xsk: fix batch alloc API on non-coherent systems

Maciej W. Rozycki (4):
      PCI: Revert to the original speed after PCIe failed link retraining
      PCI: Clear the LBMS bit after a link retrain
      PCI: Correct error reporting with PCIe failed link retraining
      PCI: Use an error code with PCIe failed link retraining

Manish Pandey (1):
      scsi: ufs: qcom: Update MODE_MAX cfg_bw value

Manivannan Sadhasivam (1):
      PCI: qcom-ep: Enable controller resources like PHY only after refclk is available

Marc Aurèle La France (1):
      debugfs show actual source in /proc/mounts

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

Mario Limonciello (1):
      drm/amd/display: Validate backlight caps are sane

Mark Bloch (1):
      RDMA/mlx5: Obtain upper net device only when needed

Mark Brown (1):
      kselftest/arm64: Actually test SME vector length changes via sigreturn

Markus Schneider-Pargmann (1):
      serial: 8250: omap: Cleanup on error in request_irq

Martin Karsten (1):
      eventpoll: Annotate data-race of busy_poll_usecs

Martin Tsai (1):
      drm/amd/display: Clean up dsc blocks in accelerated mode

Martin Wilck (1):
      scsi: sd: Fix off-by-one error in sd_read_block_characteristics()

Masami Hiramatsu (Google) (2):
      selftests/ftrace: Add required dependency for kprobe tests
      selftests/ftrace: Fix eventfs ownership testcase to find mount point

Mathias Nyman (1):
      xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.

Max Hawking (1):
      ntb_perf: Fix printk format

Md Haris Iqbal (1):
      RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds

Miaohe Lin (1):
      mm/huge_memory: ensure huge_zero_folio won't have large_rmappable flag set

Michael Ellerman (1):
      powerpc/atomic: Use YZ constraints for DS-form instructions

Michael Guralnik (4):
      RDMA/mlx5: Fix counter update on MR cache mkey creation
      RDMA/mlx5: Limit usage of over-sized mkeys from the MR cache
      RDMA/mlx5: Drop redundant work canceling from clean_keys()
      RDMA/mlx5: Fix MR cache temp entries cleanup

Michal Kubiak (1):
      idpf: fix netdev Tx queue stop/wake

Michal Witwicki (3):
      crypto: qat - disable IOV in adf_dev_stop()
      crypto: qat - fix recovery flow for VFs
      crypto: qat - ensure correct order in VF restarting handler

Mickaël Salaün (1):
      fs: Fix file_set_fowner LSM hook inconsistencies

Mikhail Lobanov (2):
      RDMA/cxgb4: Added NULL check for lookup_atid
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Mikulas Patocka (3):
      Revert "dm: requeue IO if mapping table not yet available"
      dm-verity: restart or panic on an I/O error
      Revert: "dm-verity: restart or panic on an I/O error"

Ming Lei (3):
      ublk: move zone report data out of request pdu
      nbd: fix race between timeout and normal completion
      lib/sbitmap: define swap_lock as raw_spinlock_t

Ming Yen Hsieh (2):
      wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
      wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc

Miquel Raynal (2):
      mtd: rawnand: mtk: Factorize out the logic cleaning mtk chips
      mtd: rawnand: mtk: Fix init error path

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Mukesh Ojha (1):
      firmware: qcom: scm: Disable SDI and write no dump to dump mode

Namhyung Kim (5):
      perf mem: Free the allocated sort string, fixing a leak
      perf lock contention: Change stack_id type to s32
      perf dwarf-aux: Check allowed location expressions when collecting variables
      perf annotate-data: Fix off-by-one in location range check
      perf dwarf-aux: Handle bitfield members from pointer access

Namjae Jeon (2):
      ksmbd: allow write with FILE_APPEND_DATA
      ksmbd: handle caseless file creation

NeilBrown (1):
      nfsd: untangle code in nfsd4_deleg_getattr_conflict()

Nicholas Kazlauskas (1):
      drm/amd/display: Block dynamic IPS2 on DCN35 for incompatible FW versions

Nick Morrow (1):
      wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

Nikita Zhandarovich (4):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: fix several potential integer overflows in file offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Niklas Cassel (1):
      ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Nuno Sa (1):
      Input: adp5588-keys - fix check on return code

Nícolas F. R. A. Prado (1):
      kselftest: dt: Ignore nodes that have ancestors disabled

Ojaswin Mujoo (1):
      ext4: check stripe size compatibility on remount as well

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Oleg Nesterov (1):
      bpf: Fix use-after-free in bpf_uprobe_multi_link_attach()

Oliver Neukum (5):
      usbnet: fix cyclical race on disconnect with work queue
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: misc: yurex: fix race between read and write

Orlando Chamberlain (1):
      ACPI: video: force native for some T2 macbooks

P Praneesh (2):
      wifi: ath12k: fix BSS chan info request WMI command
      wifi: ath12k: match WMI BSS chan info structure with firmware definition

Pablo Neira Ayuso (7):
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout
      netfilter: nf_tables: remove annotation to access set timeout while holding lock
      netfilter: nft_dynset: annotate data-races around set timeout
      netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path
      netfilter: nf_tables: missing objects with no memcg accounting

Paolo Bonzini (1):
      Documentation: KVM: fix warning in "make htmldocs"

Patrisious Haddad (1):
      IB/core: Fix ib_cache_setup_one error flow cleanup

Paul Barker (1):
      net: ravb: Fix R-Car RX frame size limit

Paul Moore (1):
      lsm: add the inode_free_security_rcu() LSM implementation hook

Pavan Kumar Paluri (1):
      crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Pawel Laszczak (2):
      usb: cdnsp: Fix incorrect usb_request status
      usb: xhci: fix loss of data on Cadence xHC

Peng Fan (6):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      remoteproc: imx_rproc: Correct ddr alias for i.MX8M
      remoteproc: imx_rproc: Initialize workqueue earlier
      pinctrl: ti: iodelay: Use scope based of_node_put() cleanups

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Peter Chiu (4):
      wifi: mt76: mt7996: use hweight16 to get correct tx antenna
      wifi: mt76: mt7996: fix traffic delay when switching back to working channel
      wifi: mt76: mt7996: fix wmm set of station interface to 3
      wifi: mt76: connac: fix checksum offload fields of connac3 RXD

Phil Sutter (2):
      netfilter: nf_tables: Keep deleted flowtable hooks until after RCU
      selftests: netfilter: Avoid hanging ipvs.sh

Pieterjan Camerlynck (1):
      leds: leds-pca995x: Add support for NXP PCA9956B

Ping-Ke Shih (2):
      wifi: rtw89: remove unused C2H event ID RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
      wifi: mac80211: don't use rate mask for offchannel TX either

Qingqing Zhou (1):
      arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs as DMA coherent

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Qiuxu Zhuo (1):
      EDAC/igen6: Fix conversion of system address to physical memory address

Qu Wenruo (2):
      btrfs: subpage: fix the bitmap dump which can cause bitmap corruption
      btrfs: tree-checker: fix the wrong output of data backref objectid

Rafael J. Wysocki (3):
      thermal: core: Fold two functions into their respective callers
      thermal: core: Fix rounding of delay jiffies
      thermal: gov_bang_bang: Adjust states of all uninitialized instances

Rex Lu (1):
      wifi: mt76: mt7996: fix handling mbss enable/disable

Richard Zhu (2):
      PCI: imx6: Fix establish link failure in EP mode for i.MX8MM and i.MX8MP
      PCI: imx6: Fix i.MX8MP PCIe EP's occasional failure to trigger MSI

Riyan Dhiman (1):
      block: fix potential invalid pointer dereference in blk_add_partition

Rob Herring (Arm) (1):
      ASoC: tas2781: Use of_property_read_reg()

Robin Chen (1):
      drm/amd/display: Round calculated vtotal

Robin Murphy (3):
      perf/arm-cmn: Refactor node ID handling. Again.
      perf/arm-cmn: Fix CCLA register offset
      perf/arm-cmn: Ensure dtm_idx is big enough

Roman Smirnov (2):
      Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"
      KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Ryusuke Konishi (3):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()

Saleemkhan Jamadar (1):
      drm/amdgpu/vcn: enable AV1 on both instances

Samasth Norway Ananda (1):
      x86/PCI: Check pcie_find_root_port() return for NULL

Sean Anderson (5):
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Clean up clock on probe failure/removal
      net: xilinx: axienet: Schedule NAPI in two steps
      net: xilinx: axienet: Fix packet counting
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Sean Christopherson (5):
      KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits
      KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
      KVM: Use dedicated mutex to protect kvm_usage_count to avoid deadlock
      KVM: x86: Make x2APIC ID 100% readonly
      KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)

Sebastian Andrzej Siewior (1):
      net: hsr: Use the seqnr lock for frames received via interlink port.

Sebastien Laveze (1):
      clk: imx: imx6ul: fix default parent for enet*_ref_sel

Shengjiu Wang (1):
      clk: imx: clk-audiomix: Correct parent clock for earc_phy and audpll

Sherry Yang (1):
      drm/msm: fix %s null argument error

Shin'ichiro Kawasaki (1):
      f2fs: check discard support for conventional zones

Shu Han (1):
      mm: call the security_mmap_file() LSM hook in remap_file_pages()

Shuah Khan (1):
      selftests:resctrl: Fix build failure on archs without __cpuid_count()

Shubhrajyoti Datta (1):
      EDAC/synopsys: Fix error injection on Zynq UltraScale+

Siddharth Vadapalli (2):
      PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ
      PCI: dra7xx: Fix error handling when IRQ request fails in probe

Simon Horman (1):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS

Snehal Koukuntla (1):
      KVM: arm64: Add memory length checks and remove inline in do_ffa_mem_xfer

Song Liu (1):
      bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Srinivasan Shanmugam (1):
      drm/amd/display: Add null check for set_output_gamma in dcn30_set_output_transfer_func

Stefan Mätje (1):
      can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD

Stefan Wahren (1):
      drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get

Steven Rostedt (Google) (1):
      selftests/ftrace: Fix test to handle both old and new kernels

Su Hui (1):
      net: tipc: avoid possible garbage value

Sung Joon Kim (1):
      drm/amd/display: Disable SYMCLK32_LE root clock gating

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Svyatoslav Pankratov (1):
      crypto: qat - fix "Full Going True" macro definition

Takashi Sakamoto (1):
      firewire: core: correct range of block for case of switch statement

Thadeu Lima de Souza Cascardo (2):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem

Thomas Weißschuh (3):
      net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
      ACPI: sysfs: validate return type of _STR method
      tools/nolibc: include arch.h from string.h

Tianchen Ding (1):
      sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy

Tiezhu Yang (2):
      objtool: Handle frame pointer related instructions
      compiler.h: specify correct attribute for .rodata..c_jump_table

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Remove error checks when creating debugfs entries

Tomas Marek (1):
      usb: dwc2: drd: fix clock gating on USB role switch

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (26):
      selftests/bpf: Fix error linking uprobe_multi on mips
      selftests/bpf: Fix wrong binary in Makefile log output
      tools/runqslower: Fix LDFLAGS and add LDLIBS support
      selftests/bpf: Use pid_t consistently in test_progs.c
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
      selftests/bpf: Drop unneeded error.h includes
      selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
      selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
      selftests/bpf: Fix missing BUILD_BUG_ON() declaration
      selftests/bpf: Fix include of <sys/fcntl.h>
      selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
      selftests/bpf: Fix compiling kfree_skb.c with musl-libc
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix compiling core_reloc.c with musl-libc
      selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
      selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
      selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
      selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
      selftests/bpf: Fix arg parsing in veristat, test_progs
      selftests/bpf: Fix error compiling test_lru_map.c
      selftests/bpf: Fix C++ compile error from missing _Bool type
      selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
      selftests/bpf: Fix compile if backtrace support missing in libc
      selftests/bpf: Fix error compiling tc_redirect.c with musl libc

Uros Bizjak (1):
      x86/boot/64: Strip percpu address space when setting up GDT descriptors

Uwe Kleine-König (1):
      media: staging: media: starfive: camss: Drop obsolete return value documentation

VanGiang Nguyen (1):
      padata: use integer wrap around to prevent deadlock on seq_nr overflow

Varadarajan Narayanan (1):
      clk: qcom: ipq5332: Register gcc_qdss_tsctr_clk_src

Vasant Hegde (1):
      iommu/amd: Handle error path in amd_iommu_probe_device()

Vasileios Amoiridis (1):
      iio: chemical: bme680: Fix read/write ops to device by adding mutexes

Vasily Gorbik (1):
      s390/ftrace: Avoid calling unwinder in ftrace_return_address()

Vasily Khoruzhick (2):
      ACPICA: Implement ACPI_WARNING_ONCE and ACPI_ERROR_ONCE
      ACPICA: executer/exsystem: Don't nag user about every Stall() violating the spec

Vishal Moola (Oracle) (2):
      mm/hugetlb.c: fix UAF of vma in hugetlb fault pathway
      mm: change vmf_anon_prepare() to __vmf_anon_prepare()

Vitaliy Shevtsov (1):
      RDMA/irdma: fix error message in irdma_modify_qp_roce()

Vladimir Lypak (4):
      drm/msm/a5xx: disable preemption in submits by default
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage
      drm/msm/a5xx: workaround early ring-buffer emptiness check

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

WangYuli (2):
      drm/amd/amdgpu: Properly tune the size of struct
      usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium xHCI host

Weili Qian (3):
      crypto: hisilicon/hpre - mask cluster timeout error
      crypto: hisilicon/qm - reset device before enabling it
      crypto: hisilicon/qm - inject error before stopping queue

Wenbo Li (1):
      virtio_net: Fix mismatched buf address when unmapping for small packets

Werner Sembach (4):
      Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table
      Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table
      Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Wolfram Sang (1):
      ipmi: docs: don't advertise deprecated sysfs entries

Wouter Verhelst (1):
      nbd: correct the maximum value for discard sectors

Xu Kuohai (2):
      bpf, lsm: Add check for BPF LSM return value
      bpf: Fix compare error in function retval_range_within

Yanfei Xu (1):
      cxl/pci: Fix to record only non-zero ranges

Yang Jihong (2):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Yanteng Si (1):
      net: stmmac: dwmac-loongson: Init ref and PTP clocks rate

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Yeongjin Gil (2):
      f2fs: Create COW inode from parent dentry for atomic write
      f2fs: compress: don't redirty sparse cluster during {,de}compress

Yicong Yang (3):
      drivers/perf: hisi_pcie: Record hardware counts correctly
      drivers/perf: hisi_pcie: Fix TLP headers bandwidth counting
      perf stat: Display iostat headers correctly

Yihan Zhu (1):
      drm/amd/display: Enable DML2 override_det_buffer_size_kbytes

Yonghong Song (1):
      bpf: Fail verification for sign-extension of packet data/data_end/data_meta

Yosry Ahmed (1):
      x86/mm: Use IPIs to synchronize LAM enablement

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Kuai (6):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()
      block, bfq: fix uaf for accessing waker_bfqq after splitting
      block, bfq: fix procress reference leakage for bfqq in merge chain
      md: Don't flush sync_work in md_write_start()

Yu Zhao (1):
      mm/hugetlb_vmemmap: batch HVO work when demoting

Yuesong Li (1):
      drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Yujie Liu (1):
      sched/numa: Fix the vma scan starving issue

Yunfei Dong (3):
      media: mediatek: vcodec: Fix H264 multi stateless decoder smatch warning
      media: mediatek: vcodec: Fix VP8 stateless decoder smatch warning
      media: mediatek: vcodec: Fix H264 stateless decoder smatch warning

Yuntao Liu (3):
      ALSA: hda: cs35l41: fix module autoloading
      hwmon: (ntc_thermistor) fix module autoloading
      clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

Zhen Lei (1):
      debugobjects: Fix conditions in fill_pool()

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

Zhikai Zhai (1):
      drm/amd/display: Skip to enable dsc if it has been off

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zijun Hu (1):
      driver core: Fix error handling in driver API device_rename()

hhorace (1):
      wifi: cfg80211: fix bug of mapping AF3x to incorrect User Priority

tangbin (1):
      ASoC: loongson: fix error release

wenglianfa (2):
      RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

yangyun (1):
      fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set


