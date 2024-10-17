Return-Path: <stable+bounces-86623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C159A23EF
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA478B24F75
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0FB1DE3AF;
	Thu, 17 Oct 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I9jb5OcB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC051DE3A0;
	Thu, 17 Oct 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172102; cv=none; b=TDa7pe4dKVBc0W1YcwXHN+1VcnAd7AYL1qiulF5Mij7QJCJwcMvR5pckhWWgxufZAoGhUFuskYYquSjGQy67PspjKqxtYKtESKbzRgXr9cjAb6mEmxmB38IVfO9+FFpAXWmS3B4bXyGqJjqNfCXV1/bQi1qEYEHaO/HCnc7d4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172102; c=relaxed/simple;
	bh=8K9uPLIS516YUhGMXwpnZbXYwDjmXCpDk9MoQTJyLn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWE6SISS6tuiQ48aQlBkVcKXyxGdfrVc9vZZUnKiTQHYZJEf2c1Cr6SQb4XvMoFt98TDZsqjsCcaWeKM/+6tuGl/0c5F6WXrLV79mIxtC64GHW3uimB0uLIQuPWR0cp7DzxIqjrzwI2ZunQBbU5fGKyJf+cC3VvhYPNuwKS1/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I9jb5OcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CDCC4CEC3;
	Thu, 17 Oct 2024 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729172101;
	bh=8K9uPLIS516YUhGMXwpnZbXYwDjmXCpDk9MoQTJyLn0=;
	h=From:To:Cc:Subject:Date:From;
	b=I9jb5OcB3wFbar8NVVshN4XTasJuVLgs8BEmnBEcQLMTjqK1gs9tREStDX2bNUAP/
	 RFDin2rX4bdoI/WhuMMo1piVfEtLgTeJwQ5CwaTjQtfJGSeVnAP9oRJoeH/p0rvRDR
	 CVqL+N5sSSGi/LvwFtini4CF1nARQusZ8TC1lfZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.113
Date: Thu, 17 Oct 2024 15:34:32 +0200
Message-ID: <2024101732-confident-astronomy-b04b@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.113 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 .gitignore                                                                    |    1 
 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818                       |    2 
 Documentation/accounting/delay-accounting.rst                                 |   14 
 Documentation/admin-guide/kernel-parameters.txt                               |   10 
 Documentation/arm64/silicon-errata.rst                                        |    4 
 Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml    |    1 
 Documentation/driver-api/ipmi.rst                                             |    2 
 Documentation/translations/zh_CN/accounting/delay-accounting.rst              |   17 
 Makefile                                                                      |    2 
 arch/arm/boot/dts/imx7d-zii-rmu2.dts                                          |    2 
 arch/arm/boot/dts/sam9x60.dtsi                                                |    4 
 arch/arm/boot/dts/sama7g5.dtsi                                                |    2 
 arch/arm/crypto/aes-ce-glue.c                                                 |    2 
 arch/arm/crypto/aes-neonbs-glue.c                                             |    2 
 arch/arm/mach-ep93xx/clock.c                                                  |    2 
 arch/arm/mach-versatile/platsmp-realview.c                                    |    1 
 arch/arm64/Kconfig                                                            |    2 
 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts                          |    2 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                               |    1 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                          |   20 
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi                                   |    4 
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi                                    |    4 
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi                                    |    4 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts                          |    4 
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                                        |    4 
 arch/arm64/include/asm/cputype.h                                              |    4 
 arch/arm64/kernel/cpu_errata.c                                                |    2 
 arch/loongarch/configs/loongson3_defconfig                                    |    1 
 arch/loongarch/pci/acpi.c                                                     |    1 
 arch/m68k/kernel/process.c                                                    |    2 
 arch/parisc/kernel/entry.S                                                    |    6 
 arch/parisc/kernel/syscall.S                                                  |   14 
 arch/powerpc/Kconfig                                                          |   23 
 arch/powerpc/Makefile                                                         |    4 
 arch/powerpc/include/asm/asm-compat.h                                         |    6 
 arch/powerpc/include/asm/atomic.h                                             |   25 
 arch/powerpc/include/asm/io.h                                                 |   37 
 arch/powerpc/include/asm/uaccess.h                                            |   33 
 arch/powerpc/include/asm/vdso_datapage.h                                      |   15 
 arch/powerpc/kernel/asm-offsets.c                                             |    2 
 arch/powerpc/kernel/head_8xx.S                                                |    6 
 arch/powerpc/kernel/trace/ftrace.c                                            |    2 
 arch/powerpc/kernel/vdso/cacheflush.S                                         |    2 
 arch/powerpc/kernel/vdso/datapage.S                                           |    4 
 arch/powerpc/mm/nohash/8xx.c                                                  |    4 
 arch/powerpc/platforms/Kconfig.cputype                                        |   24 
 arch/powerpc/platforms/pseries/dlpar.c                                        |   17 
 arch/powerpc/platforms/pseries/hotplug-cpu.c                                  |    2 
 arch/powerpc/platforms/pseries/hotplug-memory.c                               |   16 
 arch/powerpc/platforms/pseries/pmem.c                                         |    2 
 arch/riscv/Kconfig                                                            |    5 
 arch/riscv/include/asm/sparsemem.h                                            |    2 
 arch/riscv/kernel/elf_kexec.c                                                 |    6 
 arch/riscv/kernel/perf_callchain.c                                            |    2 
 arch/riscv/kvm/vcpu_sbi.c                                                     |    4 
 arch/s390/include/asm/facility.h                                              |    6 
 arch/s390/kernel/perf_cpum_sf.c                                               |   12 
 arch/s390/mm/cmm.c                                                            |   18 
 arch/x86/coco/tdx/tdx.c                                                       |    6 
 arch/x86/events/core.c                                                        |   63 
 arch/x86/events/intel/pt.c                                                    |   15 
 arch/x86/include/asm/hardirq.h                                                |    8 
 arch/x86/include/asm/idtentry.h                                               |   73 
 arch/x86/include/asm/syscall.h                                                |    7 
 arch/x86/kernel/apic/io_apic.c                                                |   46 
 arch/x86/kernel/cpu/sgx/main.c                                                |   27 
 arch/x86/kernel/machine_kexec_64.c                                            |   27 
 arch/x86/kvm/lapic.c                                                          |   35 
 arch/x86/net/bpf_jit_comp.c                                                   |   54 
 arch/x86/xen/setup.c                                                          |    2 
 block/bfq-iosched.c                                                           |   44 
 block/blk-integrity.c                                                         |  175 
 block/blk-iocost.c                                                            |    8 
 block/blk.h                                                                   |   10 
 block/genhd.c                                                                 |   12 
 block/partitions/core.c                                                       |    8 
 crypto/asymmetric_keys/asymmetric_type.c                                      |    7 
 crypto/simd.c                                                                 |   76 
 crypto/xor.c                                                                  |   31 
 drivers/acpi/acpi_pad.c                                                       |    6 
 drivers/acpi/acpica/dbconvert.c                                               |    2 
 drivers/acpi/acpica/exprep.c                                                  |    3 
 drivers/acpi/acpica/exsystem.c                                                |   11 
 drivers/acpi/acpica/psargs.c                                                  |   47 
 drivers/acpi/battery.c                                                        |   28 
 drivers/acpi/cppc_acpi.c                                                      |   43 
 drivers/acpi/device_sysfs.c                                                   |    5 
 drivers/acpi/ec.c                                                             |   55 
 drivers/acpi/pmic/tps68470_pmic.c                                             |    6 
 drivers/acpi/resource.c                                                       |   20 
 drivers/acpi/video_detect.c                                                   |    8 
 drivers/ata/libata-eh.c                                                       |   18 
 drivers/ata/pata_serverworks.c                                                |   16 
 drivers/ata/sata_sil.c                                                        |   12 
 drivers/base/bus.c                                                            |    6 
 drivers/base/firmware_loader/main.c                                           |   30 
 drivers/base/power/domain.c                                                   |    2 
 drivers/block/aoe/aoecmd.c                                                    |   13 
 drivers/block/drbd/drbd_main.c                                                |    6 
 drivers/block/drbd/drbd_state.c                                               |    2 
 drivers/block/loop.c                                                          |   15 
 drivers/block/nbd.c                                                           |   13 
 drivers/bluetooth/btmrvl_sdio.c                                               |    3 
 drivers/bluetooth/btusb.c                                                     |    7 
 drivers/bus/arm-integrator-lm.c                                               |    1 
 drivers/bus/mhi/host/pci_generic.c                                            |   13 
 drivers/char/hw_random/bcm2835-rng.c                                          |    4 
 drivers/char/hw_random/cctrng.c                                               |    1 
 drivers/char/hw_random/mtk-rng.c                                              |    2 
 drivers/char/tpm/tpm-dev-common.c                                             |    2 
 drivers/char/tpm/tpm2-space.c                                                 |    3 
 drivers/char/virtio_console.c                                                 |   18 
 drivers/clk/bcm/clk-bcm53573-ilp.c                                            |    2 
 drivers/clk/imx/clk-composite-7ulp.c                                          |    7 
 drivers/clk/imx/clk-composite-8m.c                                            |   63 
 drivers/clk/imx/clk-fracn-gppll.c                                             |   72 
 drivers/clk/imx/clk-imx7d.c                                                   |    4 
 drivers/clk/imx/clk-imx8mp.c                                                  |    4 
 drivers/clk/imx/clk-imx8qxp.c                                                 |   10 
 drivers/clk/imx/clk.h                                                         |    7 
 drivers/clk/qcom/clk-alpha-pll.c                                              |   54 
 drivers/clk/qcom/clk-alpha-pll.h                                              |    2 
 drivers/clk/qcom/clk-rpmh.c                                                   |    2 
 drivers/clk/qcom/dispcc-sm8250.c                                              |   12 
 drivers/clk/qcom/gcc-sc8180x.c                                                |   88 
 drivers/clk/qcom/gcc-sm8250.c                                                 |    6 
 drivers/clk/qcom/gcc-sm8450.c                                                 |    4 
 drivers/clk/rockchip/clk-rk3228.c                                             |    2 
 drivers/clk/rockchip/clk.c                                                    |    3 
 drivers/clk/samsung/clk-exynos7885.c                                          |   14 
 drivers/clk/ti/clk-dra7-atl.c                                                 |    1 
 drivers/clocksource/timer-qcom.c                                              |    7 
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c                     |    5 
 drivers/cpufreq/intel_pstate.c                                                |   20 
 drivers/cpufreq/ti-cpufreq.c                                                  |   10 
 drivers/crypto/ccp/sev-dev.c                                                  |    2 
 drivers/crypto/hisilicon/hpre/hpre_main.c                                     |   57 
 drivers/crypto/hisilicon/qm.c                                                 |  180 
 drivers/crypto/hisilicon/sec2/sec_main.c                                      |   16 
 drivers/crypto/hisilicon/sgl.c                                                |    1 
 drivers/crypto/hisilicon/zip/zip_main.c                                       |   23 
 drivers/cxl/core/pci.c                                                        |   60 
 drivers/dax/device.c                                                          |    2 
 drivers/edac/igen6_edac.c                                                     |    2 
 drivers/edac/synopsys_edac.c                                                  |   85 
 drivers/firmware/arm_scmi/optee.c                                             |    7 
 drivers/firmware/efi/libstub/tpm.c                                            |    2 
 drivers/firmware/tegra/bpmp.c                                                 |    6 
 drivers/gpio/gpio-aspeed.c                                                    |    4 
 drivers/gpio/gpio-davinci.c                                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                        |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                       |   18 
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h                                   |    4 
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c                                |   26 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                         |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                        |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                             |   22 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                   |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                       |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                      |    8 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                             |    6 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c                        |    2 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c                        |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c                            |    6 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c           |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c             |    2 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                       |    2 
 drivers/gpu/drm/amd/include/atombios.h                                        |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c                      |    2 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                                      |   35 
 drivers/gpu/drm/drm_atomic_uapi.c                                             |    2 
 drivers/gpu/drm/drm_crtc.c                                                    |    1 
 drivers/gpu/drm/drm_print.c                                                   |   13 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                                       |    2 
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c                                       |    2 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                                       |   32 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                         |   12 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h                                         |    2 
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c                                     |   30 
 drivers/gpu/drm/msm/adreno/adreno_gpu.c                                       |    2 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c                                      |    2 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                                        |    2 
 drivers/gpu/drm/omapdrm/omap_drv.c                                            |    5 
 drivers/gpu/drm/radeon/atombios.h                                             |    2 
 drivers/gpu/drm/radeon/evergreen_cs.c                                         |   62 
 drivers/gpu/drm/radeon/r100.c                                                 |   70 
 drivers/gpu/drm/radeon/radeon_atombios.c                                      |   26 
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c                                   |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                                   |   20 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h                                   |    7 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h                                  |    5 
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c                                   |   20 
 drivers/gpu/drm/scheduler/sched_entity.c                                      |    2 
 drivers/gpu/drm/stm/drv.c                                                     |    7 
 drivers/gpu/drm/stm/ltdc.c                                                    |   78 
 drivers/gpu/drm/v3d/v3d_perfmon.c                                             |    9 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                                |    8 
 drivers/gpu/drm/vc4/vc4_perfmon.c                                             |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                            |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                           |    3 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                                      |   14 
 drivers/hid/hid-ids.h                                                         |    4 
 drivers/hid/hid-multitouch.c                                                  |   14 
 drivers/hid/hid-plantronics.c                                                 |   23 
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c                                   |    2 
 drivers/hid/wacom_wac.c                                                       |   13 
 drivers/hid/wacom_wac.h                                                       |    2 
 drivers/hwmon/Kconfig                                                         |    3 
 drivers/hwmon/max16065.c                                                      |   27 
 drivers/hwmon/ntc_thermistor.c                                                |    1 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                               |    2 
 drivers/i2c/busses/i2c-aspeed.c                                               |   16 
 drivers/i2c/busses/i2c-i801.c                                                 |    9 
 drivers/i2c/busses/i2c-isch.c                                                 |    3 
 drivers/i2c/busses/i2c-qcom-geni.c                                            |    4 
 drivers/i2c/busses/i2c-stm32f7.c                                              |    6 
 drivers/i2c/busses/i2c-xiic.c                                                 |   89 
 drivers/i2c/i2c-core-base.c                                                   |   58 
 drivers/iio/adc/ad7606.c                                                      |    8 
 drivers/iio/adc/ad7606_spi.c                                                  |    5 
 drivers/iio/chemical/bme680_core.c                                            |    7 
 drivers/iio/magnetometer/ak8975.c                                             |  117 
 drivers/infiniband/core/cache.c                                               |    4 
 drivers/infiniband/core/iwcm.c                                                |    2 
 drivers/infiniband/core/mad.c                                                 |   14 
 drivers/infiniband/hw/cxgb4/cm.c                                              |    5 
 drivers/infiniband/hw/erdma/erdma_verbs.c                                     |   25 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                      |   22 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                    |   29 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                       |   16 
 drivers/infiniband/hw/irdma/verbs.c                                           |    2 
 drivers/infiniband/hw/mlx5/odp.c                                              |   25 
 drivers/infiniband/ulp/rtrs/rtrs-clt.c                                        |    9 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                                        |   14 
 drivers/input/keyboard/adp5588-keys.c                                         |    2 
 drivers/input/keyboard/adp5589-keys.c                                         |   22 
 drivers/input/rmi4/rmi_driver.c                                               |    6 
 drivers/input/serio/i8042-acpipnpio.h                                         |   37 
 drivers/input/touchscreen/ilitek_ts_i2c.c                                     |   18 
 drivers/iommu/amd/io_pgtable_v2.c                                             |    2 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                                    |    7 
 drivers/iommu/intel/Kconfig                                                   |   11 
 drivers/iommu/intel/Makefile                                                  |    1 
 drivers/iommu/intel/dmar.c                                                    |   23 
 drivers/iommu/intel/iommu.c                                                   |    6 
 drivers/iommu/intel/iommu.h                                                   |   43 
 drivers/iommu/intel/perfmon.c                                                 |  172 
 drivers/iommu/intel/perfmon.h                                                 |   40 
 drivers/mailbox/bcm2835-mailbox.c                                             |    3 
 drivers/mailbox/rockchip-mailbox.c                                            |    2 
 drivers/md/dm-rq.c                                                            |    4 
 drivers/md/dm.c                                                               |   11 
 drivers/media/common/videobuf2/videobuf2-core.c                               |    8 
 drivers/media/dvb-frontends/rtl2830.c                                         |    2 
 drivers/media/dvb-frontends/rtl2832.c                                         |    2 
 drivers/media/i2c/ar0521.c                                                    |    5 
 drivers/media/i2c/imx335.c                                                    |   43 
 drivers/media/platform/qcom/camss/camss.c                                     |    5 
 drivers/media/platform/qcom/venus/core.c                                      |    1 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c                            |    5 
 drivers/media/tuners/tuner-i2c.h                                              |    4 
 drivers/media/usb/usbtv/usbtv-video.c                                         |    7 
 drivers/mtd/devices/powernv_flash.c                                           |    3 
 drivers/mtd/devices/slram.c                                                   |    2 
 drivers/mtd/nand/raw/mtk_nand.c                                               |   36 
 drivers/net/bareudp.c                                                         |   26 
 drivers/net/bonding/bond_main.c                                               |    6 
 drivers/net/can/m_can/m_can.c                                                 |   18 
 drivers/net/dsa/b53/b53_common.c                                              |   17 
 drivers/net/dsa/lan9303-core.c                                                |   29 
 drivers/net/ethernet/adi/adin1110.c                                           |    4 
 drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c                           |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                             |    2 
 drivers/net/ethernet/cortina/gemini.c                                         |   32 
 drivers/net/ethernet/freescale/enetc/enetc.c                                  |    3 
 drivers/net/ethernet/hisilicon/hip04_eth.c                                    |    1 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c                             |    1 
 drivers/net/ethernet/hisilicon/hns_mdio.c                                     |    1 
 drivers/net/ethernet/ibm/emac/mal.c                                           |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c                                   |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                            |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                                     |    3 
 drivers/net/ethernet/intel/ice/ice_sched.c                                    |    6 
 drivers/net/ethernet/intel/ice/ice_switch.c                                   |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                                     |    4 
 drivers/net/ethernet/lantiq_etop.c                                            |    4 
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h                                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c                              |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c                         |   10 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                                |    2 
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c                       |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c                         |    6 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                           |    5 
 drivers/net/ethernet/realtek/r8169_main.c                                     |   31 
 drivers/net/ethernet/realtek/r8169_phy_config.c                               |    2 
 drivers/net/ethernet/seeq/ether3.c                                            |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c                          |    3 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c                             |   18 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                               |    1 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                             |   37 
 drivers/net/ieee802154/Kconfig                                                |    1 
 drivers/net/ieee802154/mcr20a.c                                               |    5 
 drivers/net/phy/bcm84881.c                                                    |    4 
 drivers/net/phy/dp83869.c                                                     |    1 
 drivers/net/ppp/ppp_async.c                                                   |    2 
 drivers/net/ppp/ppp_generic.c                                                 |    4 
 drivers/net/slip/slhc.c                                                       |   57 
 drivers/net/usb/usbnet.c                                                      |   37 
 drivers/net/vxlan/vxlan_core.c                                                |    6 
 drivers/net/vxlan/vxlan_private.h                                             |    2 
 drivers/net/vxlan/vxlan_vnifilter.c                                           |   19 
 drivers/net/wireless/ath/ath11k/dp_rx.c                                       |    2 
 drivers/net/wireless/ath/ath9k/debug.c                                        |    6 
 drivers/net/wireless/ath/ath9k/hif_usb.c                                      |    6 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                                |    2 
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h                              |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h                            |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c                                 |   42 
 drivers/net/wireless/marvell/mwifiex/fw.h                                     |    2 
 drivers/net/wireless/marvell/mwifiex/scan.c                                   |    3 
 drivers/net/wireless/mediatek/mt76/mac80211.c                                 |    8 
 drivers/net/wireless/mediatek/mt76/mt76.h                                     |    1 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                              |    3 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                               |   10 
 drivers/net/wireless/microchip/wilc1000/hif.c                                 |    4 
 drivers/net/wireless/realtek/rtw88/Kconfig                                    |    1 
 drivers/net/wireless/realtek/rtw88/coex.c                                     |   38 
 drivers/net/wireless/realtek/rtw88/main.c                                     |    7 
 drivers/net/wireless/realtek/rtw88/rtw8822c.c                                 |   10 
 drivers/net/wireless/realtek/rtw89/phy.c                                      |    4 
 drivers/net/wwan/qcom_bam_dmux.c                                              |   11 
 drivers/net/xen-netback/hash.c                                                |    5 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                            |    2 
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c                                        |    1 
 drivers/ntb/ntb_transport.c                                                   |   23 
 drivers/ntb/test/ntb_perf.c                                                   |    2 
 drivers/nvdimm/namespace_devs.c                                               |   34 
 drivers/nvdimm/nd_virtio.c                                                    |    9 
 drivers/nvme/host/multipath.c                                                 |    2 
 drivers/nvme/host/nvme.h                                                      |    5 
 drivers/nvme/host/pci.c                                                       |   18 
 drivers/of/irq.c                                                              |   38 
 drivers/pci/controller/dwc/pci-imx6.c                                         |    7 
 drivers/pci/controller/dwc/pci-keystone.c                                     |    2 
 drivers/pci/controller/dwc/pcie-kirin.c                                       |    4 
 drivers/pci/controller/pcie-xilinx-nwl.c                                      |   39 
 drivers/pci/pci-driver.c                                                      |   15 
 drivers/pci/pci.c                                                             |   26 
 drivers/pci/pci.h                                                             |    9 
 drivers/pci/pcie/dpc.c                                                        |    3 
 drivers/pci/quirks.c                                                          |    8 
 drivers/perf/alibaba_uncore_drw_pmu.c                                         |    2 
 drivers/perf/arm-cmn.c                                                        |  232 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                                        |   14 
 drivers/pinctrl/mvebu/pinctrl-dove.c                                          |   45 
 drivers/pinctrl/pinctrl-single.c                                              |    3 
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c                   |    4 
 drivers/platform/x86/touchscreen_dmi.c                                        |   26 
 drivers/power/reset/brcmstb-reboot.c                                          |    3 
 drivers/power/supply/axp20x_battery.c                                         |   16 
 drivers/power/supply/max17042_battery.c                                       |    5 
 drivers/power/supply/power_supply_hwmon.c                                     |    3 
 drivers/pps/clients/pps_parport.c                                             |   14 
 drivers/regulator/of_regulator.c                                              |    2 
 drivers/remoteproc/imx_rproc.c                                                |   19 
 drivers/remoteproc/ti_k3_r5_remoteproc.c                                      |   86 
 drivers/reset/reset-berlin.c                                                  |    3 
 drivers/reset/reset-k210.c                                                    |    3 
 drivers/rtc/rtc-at91sam9.c                                                    |    1 
 drivers/scsi/NCR5380.c                                                        |   82 
 drivers/scsi/aacraid/aacraid.h                                                |    2 
 drivers/scsi/elx/libefc/efc_nport.c                                           |    2 
 drivers/scsi/lpfc/lpfc_ct.c                                                   |   12 
 drivers/scsi/lpfc/lpfc_disc.h                                                 |    7 
 drivers/scsi/lpfc/lpfc_els.c                                                  |   34 
 drivers/scsi/lpfc/lpfc_nportdisc.c                                            |   22 
 drivers/scsi/lpfc/lpfc_vport.c                                                |   43 
 drivers/scsi/mac_scsi.c                                                       |  162 
 drivers/scsi/pm8001/pm8001_init.c                                             |    6 
 drivers/scsi/sd.c                                                             |    2 
 drivers/scsi/smartpqi/smartpqi_init.c                                         |   22 
 drivers/scsi/wd33c93.c                                                        |    2 
 drivers/soc/versatile/soc-integrator.c                                        |    1 
 drivers/soc/versatile/soc-realview.c                                          |   20 
 drivers/spi/atmel-quadspi.c                                                   |    1 
 drivers/spi/spi-bcm63xx.c                                                     |    9 
 drivers/spi/spi-fsl-lpspi.c                                                   |    1 
 drivers/spi/spi-imx.c                                                         |    2 
 drivers/spi/spi-ppc4xx.c                                                      |    7 
 drivers/spi/spi-s3c64xx.c                                                     |    4 
 drivers/staging/vme_user/vme_fake.c                                           |    6 
 drivers/staging/vme_user/vme_tsi148.c                                         |    6 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c          |   23 
 drivers/tty/serial/rp2.c                                                      |    2 
 drivers/usb/cdns3/cdnsp-ring.c                                                |    6 
 drivers/usb/cdns3/host.c                                                      |    4 
 drivers/usb/chipidea/udc.c                                                    |    8 
 drivers/usb/class/cdc-acm.c                                                   |    2 
 drivers/usb/dwc2/drd.c                                                        |    9 
 drivers/usb/dwc2/platform.c                                                   |   26 
 drivers/usb/dwc3/core.c                                                       |   22 
 drivers/usb/dwc3/core.h                                                       |    4 
 drivers/usb/dwc3/gadget.c                                                     |   11 
 drivers/usb/gadget/udc/core.c                                                 |    1 
 drivers/usb/host/xhci-debugfs.c                                               |    2 
 drivers/usb/host/xhci-mem.c                                                   |  331 
 drivers/usb/host/xhci-pci.c                                                   |   20 
 drivers/usb/host/xhci-ring.c                                                  |   82 
 drivers/usb/host/xhci.c                                                       |   54 
 drivers/usb/host/xhci.h                                                       |   32 
 drivers/usb/misc/appledisplay.c                                               |   15 
 drivers/usb/misc/cypress_cy7c63.c                                             |    4 
 drivers/usb/misc/yurex.c                                                      |    5 
 drivers/usb/storage/unusual_devs.h                                            |   11 
 drivers/vfio/pci/vfio_pci_intrs.c                                             |    4 
 drivers/vhost/scsi.c                                                          |   27 
 drivers/vhost/vdpa.c                                                          |   18 
 drivers/video/fbdev/core/fbcon.c                                              |    2 
 drivers/video/fbdev/hpfb.c                                                    |    1 
 drivers/video/fbdev/pxafb.c                                                   |    1 
 drivers/video/fbdev/sis/sis_main.c                                            |    2 
 drivers/virtio/virtio_vdpa.c                                                  |    1 
 drivers/watchdog/imx_sc_wdt.c                                                 |   24 
 drivers/xen/swiotlb-xen.c                                                     |   10 
 fs/btrfs/disk-io.c                                                            |   11 
 fs/btrfs/relocation.c                                                         |    2 
 fs/btrfs/send.c                                                               |   23 
 fs/btrfs/zoned.c                                                              |    2 
 fs/cachefiles/namei.c                                                         |    7 
 fs/ceph/addr.c                                                                |    6 
 fs/crypto/fname.c                                                             |    8 
 fs/dax.c                                                                      |   62 
 fs/ecryptfs/crypto.c                                                          |   10 
 fs/erofs/data.c                                                               |   50 
 fs/erofs/decompressor.c                                                       |    6 
 fs/erofs/decompressor_lzma.c                                                  |    4 
 fs/erofs/dir.c                                                                |   22 
 fs/erofs/erofs_fs.h                                                           |    5 
 fs/erofs/fscache.c                                                            |    7 
 fs/erofs/inode.c                                                              |   37 
 fs/erofs/internal.h                                                           |   34 
 fs/erofs/namei.c                                                              |   30 
 fs/erofs/super.c                                                              |   72 
 fs/erofs/xattr.c                                                              |   40 
 fs/erofs/xattr.h                                                              |   10 
 fs/erofs/zdata.c                                                              |   16 
 fs/erofs/zmap.c                                                               |  263 
 fs/exec.c                                                                     |    3 
 fs/exfat/balloc.c                                                             |   10 
 fs/ext4/dir.c                                                                 |   14 
 fs/ext4/extents.c                                                             |   55 
 fs/ext4/fast_commit.c                                                         |   49 
 fs/ext4/file.c                                                                |    8 
 fs/ext4/ialloc.c                                                              |   14 
 fs/ext4/inline.c                                                              |   35 
 fs/ext4/inode.c                                                               |   11 
 fs/ext4/mballoc.c                                                             |   10 
 fs/ext4/migrate.c                                                             |    2 
 fs/ext4/move_extent.c                                                         |    1 
 fs/ext4/namei.c                                                               |   14 
 fs/ext4/super.c                                                               |    9 
 fs/ext4/xattr.c                                                               |    7 
 fs/f2fs/dir.c                                                                 |    3 
 fs/f2fs/extent_cache.c                                                        |    4 
 fs/f2fs/f2fs.h                                                                |   24 
 fs/f2fs/file.c                                                                |   98 
 fs/f2fs/namei.c                                                               |   69 
 fs/f2fs/super.c                                                               |    4 
 fs/f2fs/xattr.c                                                               |   18 
 fs/fcntl.c                                                                    |   14 
 fs/file.c                                                                     |   95 
 fs/inode.c                                                                    |    4 
 fs/iomap/buffered-io.c                                                        |   16 
 fs/jbd2/checkpoint.c                                                          |   21 
 fs/jbd2/journal.c                                                             |    4 
 fs/jfs/jfs_discard.c                                                          |   11 
 fs/jfs/jfs_dmap.c                                                             |   11 
 fs/jfs/jfs_imap.c                                                             |    2 
 fs/jfs/xattr.c                                                                |    2 
 fs/namei.c                                                                    |    6 
 fs/namespace.c                                                                |   21 
 fs/nfs/callback_xdr.c                                                         |    2 
 fs/nfs/client.c                                                               |    1 
 fs/nfs/nfs42proc.c                                                            |    2 
 fs/nfs/nfs4state.c                                                            |    3 
 fs/nfsd/filecache.c                                                           |    7 
 fs/nfsd/nfs4idmap.c                                                           |   13 
 fs/nfsd/nfs4recover.c                                                         |    8 
 fs/nfsd/nfs4state.c                                                           |    5 
 fs/nfsd/nfs4xdr.c                                                             |   10 
 fs/nfsd/vfs.c                                                                 |    1 
 fs/nilfs2/btree.c                                                             |   12 
 fs/ntfs3/file.c                                                               |    4 
 fs/ntfs3/frecord.c                                                            |   21 
 fs/ntfs3/fslog.c                                                              |   19 
 fs/ocfs2/aops.c                                                               |    5 
 fs/ocfs2/buffer_head_io.c                                                     |    4 
 fs/ocfs2/journal.c                                                            |    7 
 fs/ocfs2/localalloc.c                                                         |   19 
 fs/ocfs2/quota_local.c                                                        |    8 
 fs/ocfs2/refcounttree.c                                                       |   26 
 fs/ocfs2/xattr.c                                                              |   11 
 fs/proc/base.c                                                                |   61 
 fs/smb/client/cifsfs.c                                                        |   13 
 fs/smb/client/cifsglob.h                                                      |    2 
 fs/smb/client/smb1ops.c                                                       |    2 
 fs/smb/client/smb2ops.c                                                       |   19 
 fs/smb/server/vfs.c                                                           |   19 
 fs/unicode/mkutf8data.c                                                       |   70 
 fs/unicode/utf8data.c_shipped                                                 | 6703 ++++------
 fs/xfs/xfs_reflink.c                                                          |    8 
 include/acpi/acoutput.h                                                       |    5 
 include/acpi/cppc_acpi.h                                                      |    2 
 include/crypto/internal/simd.h                                                |   12 
 include/drm/drm_print.h                                                       |   54 
 include/dt-bindings/clock/exynos7885.h                                        |    4 
 include/dt-bindings/clock/qcom,gcc-sc8180x.h                                  |    3 
 include/linux/blkdev.h                                                        |    3 
 include/linux/dax.h                                                           |    2 
 include/linux/f2fs_fs.h                                                       |    2 
 include/linux/fdtable.h                                                       |    8 
 include/linux/fs.h                                                            |   11 
 include/linux/i2c.h                                                           |    7 
 include/linux/nfs_fs_sb.h                                                     |    1 
 include/linux/pci_ids.h                                                       |    2 
 include/linux/sbitmap.h                                                       |    2 
 include/linux/uprobes.h                                                       |    2 
 include/linux/usb/usbnet.h                                                    |   15 
 include/linux/vdpa.h                                                          |    6 
 include/linux/xarray.h                                                        |    6 
 include/net/bluetooth/hci_core.h                                              |    4 
 include/net/ip.h                                                              |    2 
 include/net/mac80211.h                                                        |    7 
 include/net/mctp.h                                                            |    2 
 include/net/rtnetlink.h                                                       |   17 
 include/net/sch_generic.h                                                     |    1 
 include/net/sock.h                                                            |    2 
 include/net/tcp.h                                                             |   21 
 include/trace/events/erofs.h                                                  |    4 
 include/trace/events/f2fs.h                                                   |    3 
 include/uapi/linux/cec.h                                                      |    6 
 include/uapi/linux/netfilter/nf_tables.h                                      |    2 
 include/uapi/linux/snmp.h                                                     |    3 
 io_uring/io-wq.c                                                              |   33 
 io_uring/io_uring.c                                                           |   15 
 io_uring/net.c                                                                |    4 
 io_uring/sqpoll.c                                                             |   12 
 kernel/bpf/arraymap.c                                                         |    3 
 kernel/bpf/btf.c                                                              |    8 
 kernel/bpf/hashtab.c                                                          |    3 
 kernel/bpf/helpers.c                                                          |    6 
 kernel/bpf/syscall.c                                                          |    1 
 kernel/bpf/verifier.c                                                         |   16 
 kernel/events/core.c                                                          |    6 
 kernel/events/uprobes.c                                                       |    4 
 kernel/fork.c                                                                 |   30 
 kernel/jump_label.c                                                           |   52 
 kernel/kthread.c                                                              |   12 
 kernel/locking/lockdep.c                                                      |   48 
 kernel/module/Makefile                                                        |    2 
 kernel/padata.c                                                               |    6 
 kernel/rcu/rcuscale.c                                                         |    4 
 kernel/rcu/tree_nocb.h                                                        |    5 
 kernel/resource.c                                                             |   58 
 kernel/sched/psi.c                                                            |   26 
 kernel/static_call_inline.c                                                   |   13 
 kernel/trace/trace.c                                                          |   18 
 kernel/trace/trace_hwlat.c                                                    |    2 
 kernel/trace/trace_osnoise.c                                                  |    2 
 kernel/trace/trace_output.c                                                   |    6 
 lib/bootconfig.c                                                              |    3 
 lib/buildid.c                                                                 |   90 
 lib/debugobjects.c                                                            |    5 
 lib/sbitmap.c                                                                 |    4 
 lib/test_xarray.c                                                             |   93 
 lib/xarray.c                                                                  |   49 
 lib/xz/xz_crc32.c                                                             |    2 
 lib/xz/xz_private.h                                                           |    4 
 mm/Kconfig                                                                    |   25 
 mm/damon/vaddr.c                                                              |    2 
 mm/filemap.c                                                                  |   50 
 mm/secretmem.c                                                                |    4 
 mm/slab_common.c                                                              |    7 
 mm/util.c                                                                     |    2 
 net/bluetooth/hci_conn.c                                                      |    6 
 net/bluetooth/hci_core.c                                                      |   27 
 net/bluetooth/hci_event.c                                                     |   13 
 net/bluetooth/hci_sock.c                                                      |   21 
 net/bluetooth/hci_sync.c                                                      |    5 
 net/bluetooth/mgmt.c                                                          |   13 
 net/bluetooth/rfcomm/sock.c                                                   |    2 
 net/bridge/br_netfilter_hooks.c                                               |    5 
 net/can/bcm.c                                                                 |    4 
 net/can/j1939/transport.c                                                     |    8 
 net/core/dev.c                                                                |   12 
 net/core/filter.c                                                             |   44 
 net/core/rtnetlink.c                                                          |   29 
 net/core/sock_map.c                                                           |    1 
 net/ipv4/devinet.c                                                            |    6 
 net/ipv4/fib_frontend.c                                                       |    2 
 net/ipv4/icmp.c                                                               |  106 
 net/ipv4/ip_gre.c                                                             |    6 
 net/ipv4/netfilter/nf_dup_ipv4.c                                              |    7 
 net/ipv4/netfilter/nf_reject_ipv4.c                                           |   10 
 net/ipv4/netfilter/nft_fib_ipv4.c                                             |    4 
 net/ipv4/proc.c                                                               |    8 
 net/ipv4/tcp_input.c                                                          |   31 
 net/ipv4/tcp_ipv4.c                                                           |    3 
 net/ipv4/udp_offload.c                                                        |   22 
 net/ipv6/Kconfig                                                              |    1 
 net/ipv6/icmp.c                                                               |   32 
 net/ipv6/netfilter/nf_dup_ipv6.c                                              |    7 
 net/ipv6/netfilter/nf_reject_ipv6.c                                           |   19 
 net/ipv6/netfilter/nft_fib_ipv6.c                                             |    5 
 net/ipv6/proc.c                                                               |    1 
 net/ipv6/route.c                                                              |    2 
 net/ipv6/rpl_iptunnel.c                                                       |   12 
 net/mac80211/chan.c                                                           |    4 
 net/mac80211/iface.c                                                          |   17 
 net/mac80211/mlme.c                                                           |    2 
 net/mac80211/offchannel.c                                                     |    1 
 net/mac80211/rate.c                                                           |    2 
 net/mac80211/scan.c                                                           |   21 
 net/mac80211/tx.c                                                             |    2 
 net/mac80211/util.c                                                           |    4 
 net/mctp/af_mctp.c                                                            |    6 
 net/mctp/device.c                                                             |   30 
 net/mctp/neigh.c                                                              |   31 
 net/mctp/route.c                                                              |   33 
 net/mptcp/mib.c                                                               |    2 
 net/mptcp/mib.h                                                               |    2 
 net/mptcp/pm_netlink.c                                                        |    3 
 net/mptcp/protocol.c                                                          |   24 
 net/mptcp/subflow.c                                                           |    6 
 net/netfilter/nf_conntrack_netlink.c                                          |    7 
 net/netfilter/nf_tables_api.c                                                 |   14 
 net/netfilter/xt_CHECKSUM.c                                                   |   33 
 net/netfilter/xt_CLASSIFY.c                                                   |   16 
 net/netfilter/xt_CONNSECMARK.c                                                |   36 
 net/netfilter/xt_CT.c                                                         |  106 
 net/netfilter/xt_IDLETIMER.c                                                  |   59 
 net/netfilter/xt_LED.c                                                        |   39 
 net/netfilter/xt_NFLOG.c                                                      |   36 
 net/netfilter/xt_RATEEST.c                                                    |   39 
 net/netfilter/xt_SECMARK.c                                                    |   27 
 net/netfilter/xt_TRACE.c                                                      |   35 
 net/netfilter/xt_addrtype.c                                                   |   15 
 net/netfilter/xt_cluster.c                                                    |   33 
 net/netfilter/xt_connbytes.c                                                  |    4 
 net/netfilter/xt_connlimit.c                                                  |   39 
 net/netfilter/xt_connmark.c                                                   |   28 
 net/netfilter/xt_mark.c                                                       |   42 
 net/netlink/af_netlink.c                                                      |    3 
 net/qrtr/af_qrtr.c                                                            |    2 
 net/sched/sch_api.c                                                           |    7 
 net/sched/sch_taprio.c                                                        |    4 
 net/sctp/socket.c                                                             |   20 
 net/socket.c                                                                  |    7 
 net/tipc/bcast.c                                                              |    2 
 net/tipc/bearer.c                                                             |    8 
 net/wireless/nl80211.c                                                        |   18 
 net/wireless/scan.c                                                           |    6 
 net/wireless/sme.c                                                            |    3 
 rust/macros/module.rs                                                         |    6 
 scripts/kconfig/qconf.cc                                                      |    2 
 security/Kconfig                                                              |   32 
 security/bpf/hooks.c                                                          |    1 
 security/selinux/hooks.c                                                      |    4 
 security/smack/smack_lsm.c                                                    |    4 
 security/smack/smackfs.c                                                      |    2 
 security/tomoyo/domain.c                                                      |    9 
 sound/core/init.c                                                             |   14 
 sound/core/oss/mixer_oss.c                                                    |    4 
 sound/pci/asihpi/hpimsgx.c                                                    |    2 
 sound/pci/hda/cs35l41_hda_spi.c                                               |    1 
 sound/pci/hda/hda_controller.h                                                |    2 
 sound/pci/hda/hda_generic.c                                                   |    4 
 sound/pci/hda/hda_intel.c                                                     |   12 
 sound/pci/hda/patch_conexant.c                                                |   24 
 sound/pci/hda/patch_realtek.c                                                 |   10 
 sound/pci/rme9652/hdsp.c                                                      |    6 
 sound/pci/rme9652/hdspm.c                                                     |    6 
 sound/soc/atmel/mchp-pdmc.c                                                   |    3 
 sound/soc/codecs/rt5682.c                                                     |    4 
 sound/soc/codecs/rt5682s.c                                                    |    4 
 sound/soc/codecs/wsa883x.c                                                    |   16 
 sound/soc/fsl/imx-card.c                                                      |    1 
 sound/usb/card.c                                                              |    6 
 sound/usb/line6/podhd.c                                                       |    2 
 sound/usb/mixer.c                                                             |   35 
 sound/usb/mixer.h                                                             |    1 
 sound/usb/quirks-table.h                                                      | 2287 ---
 sound/usb/quirks.c                                                            |    4 
 tools/accounting/getdelays.c                                                  |   24 
 tools/arch/x86/kcpuid/kcpuid.c                                                |   12 
 tools/iio/iio_generic_buffer.c                                                |    4 
 tools/lib/subcmd/parse-options.c                                              |    8 
 tools/perf/builtin-inject.c                                                   |    1 
 tools/perf/builtin-kmem.c                                                     |    2 
 tools/perf/builtin-kvm.c                                                      |    3 
 tools/perf/builtin-kwork.c                                                    |    3 
 tools/perf/builtin-lock.c                                                     |   24 
 tools/perf/builtin-mem.c                                                      |    4 
 tools/perf/builtin-sched.c                                                    |  160 
 tools/perf/util/hist.c                                                        |    7 
 tools/perf/util/session.c                                                     |    3 
 tools/perf/util/stat-display.c                                                |    3 
 tools/perf/util/time-utils.c                                                  |    4 
 tools/perf/util/tool.h                                                        |    1 
 tools/testing/ktest/ktest.pl                                                  |    2 
 tools/testing/selftests/arm64/signal/Makefile                                 |    8 
 tools/testing/selftests/arm64/signal/sve_helpers.c                            |   56 
 tools/testing/selftests/arm64/signal/sve_helpers.h                            |   21 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c |   46 
 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sve_change_vl.c |   30 
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c                    |   36 
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c                 |  146 
 tools/testing/selftests/arm64/signal/testcases/sve_regs.c                     |   32 
 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c                   |   32 
 tools/testing/selftests/arm64/signal/testcases/za_regs.c                      |   36 
 tools/testing/selftests/bpf/DENYLIST.s390x                                    |    2 
 tools/testing/selftests/bpf/bench.c                                           |    1 
 tools/testing/selftests/bpf/bench.h                                           |    1 
 tools/testing/selftests/bpf/map_tests/sk_storage_map.c                        |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c                  |    2 
 tools/testing/selftests/bpf/prog_tests/core_reloc.c                           |    1 
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c                       |    1 
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c                            |    1 
 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c             |   87 
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c                  |  154 
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c                  |   19 
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c              |   17 
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c                              |    1 
 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c                         |    1 
 tools/testing/selftests/bpf/progs/cg_storage_multi.h                          |    2 
 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c             |   37 
 tools/testing/selftests/bpf/progs/test_ns_current_pid_tgid.c                  |   17 
 tools/testing/selftests/bpf/test_cpp.cpp                                      |    4 
 tools/testing/selftests/bpf/test_lru_map.c                                    |    3 
 tools/testing/selftests/bpf/test_progs.c                                      |  110 
 tools/testing/selftests/bpf/test_progs.h                                      |    2 
 tools/testing/selftests/bpf/testing_helpers.c                                 |   63 
 tools/testing/selftests/bpf/testing_helpers.h                                 |    9 
 tools/testing/selftests/breakpoints/step_after_suspend_test.c                 |    5 
 tools/testing/selftests/net/forwarding/no_forwarding.sh                       |    2 
 tools/testing/selftests/netfilter/nft_audit.sh                                |   57 
 tools/testing/selftests/nolibc/nolibc-test.c                                  |    4 
 tools/testing/selftests/vDSO/parse_vdso.c                                     |   17 
 tools/testing/selftests/vDSO/vdso_config.h                                    |   10 
 tools/testing/selftests/vDSO/vdso_test_correctness.c                          |    6 
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh                         |    2 
 tools/testing/selftests/vm/write_to_hugetlbfs.c                               |   21 
 755 files changed, 11811 insertions(+), 9584 deletions(-)

Aakash Menon (1):
      net: sparx5: Fix invalid timestamps

Aaron Lu (1):
      x86/sgx: Fix deadlock in SGX NUMA node search

Abhishek Tamboli (1):
      ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200

Aditya Gupta (1):
      libsubcmd: Don't free the usage string

Adrian Hunter (1):
      perf/x86/intel/pt: Fix sampling synchronization

Adrian Ratiu (1):
      proc: add config & param to block forcing mem writes

Ahmed S. Darwish (1):
      tools/x86/kcpuid: Protect against faulty "max subleaf" values

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Ajit Pandey (1):
      clk: qcom: clk-alpha-pll: Fix CAL_L_VAL override for LUCID EVO PLL

Al Viro (1):
      close_range(): fix the logics in descriptor table trimming

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Aleksandr Loktionov (1):
      i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Aleksandr Mishin (3):
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()
      drm/msm: Fix incorrect file name output in adreno_request_fw()
      ice: Adjust over allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Alex Bee (1):
      drm/rockchip: vop: Allow 4096px width scaling

Alex Deucher (2):
      drm/amdgpu: properly handle vbios fake edid sizing
      drm/radeon: properly handle vbios fake edid sizing

Alex Hung (4):
      drm/amd/display: Check null pointers before using dc->clk_mgr
      drm/amd/display: Check stream before comparing them
      drm/amd/display: Initialize get_bytes_per_element's default to 1
      drm/amd/display: Check null pointer before dereferencing se

Alex Williamson (1):
      PCI: Mark Creative Labs EMU20k2 INTx masking as broken

Alexander Dahl (1):
      ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks

Alexander Shiyan (1):
      media: i2c: ar0521: Use cansleep version of gpiod_set_value()

Alexandra Diupina (1):
      PCI: kirin: Fix buffer overflow in kirin_pcie_parse_port()

Alexei Starovoitov (1):
      selftests/bpf: Workaround strict bpf_lsm return value check.

Alexey Dobriyan (1):
      build-id: require program headers to be right after ELF header

Alexey Gladkov (Intel) (1):
      x86/tdx: Fix "in-kernel MMIO" check

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Andi Shyti (1):
      i2c: xiic: Use devm_clk_get_enabled()

Andre Przywara (1):
      kselftest/arm64: signal: fix/refactor SVE vector length enumeration

Andrei Simion (1):
      ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized

Andrew Davis (3):
      arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
      hwmon: (max16065) Remove use of i2c_match_id()
      power: reset: brcmstb: Do not go into infinite loop if reset fails

Andrew Jones (2):
      RISC-V: KVM: Fix sbiret init before forwarding to userspace
      of/irq: Support #msi-cells=<0> in of_msi_get_domain

Andrey Shumilin (1):
      fbdev: sisfb: Fix strbuf array overflow

Andrii Nakryiko (2):
      perf,x86: avoid missing caller address in stack traces captured in uprobe
      lib/buildid: harden build ID parsing logic

André Apitzsch (1):
      iio: magnetometer: ak8975: Fix 'Unexpected device' error

Andy Roulin (1):
      netfilter: br_netfilter: fix panic with metadata_dst skb

Andy Shevchenko (3):
      fs/namespace: fnic: Switch to use %ptTd
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      i2c: isch: Add missed 'else'

Ankit Agrawal (1):
      clocksource/drivers/qcom: Add missing iounmap() on errors in msm_dt_timer_init()

Anshuman Khandual (1):
      arm64: Add Cortex-715 CPU part definition

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Antoniu Miclaus (1):
      ABI: testing: fix admv8818 attr description

Ard Biesheuvel (1):
      efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption

Armin Wolf (4):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook

Arnaldo Carvalho de Melo (1):
      perf lock: Don't pass an ERR_PTR() directly to perf_session__delete()

Artem Sadovnikov (1):
      ext4: fix i_data_sem unlock order in ext4_ind_migrate()

Artur Weber (1):
      power: supply: max17042_battery: Fix SOC threshold calc w/ no current sense

Avraham Stern (1):
      wifi: iwlwifi: mvm: increase the time between ranging measurements

Baokun Li (9):
      ext4: avoid use-after-free in ext4_ext_show_leaf()
      ext4: fix slab-use-after-free in ext4_split_extent_at()
      ext4: propagate errors from ext4_find_extent() in ext4_insert_range()
      ext4: drop ppath from ext4_ext_replay_update_ex() to avoid double-free
      ext4: aovid use-after-free in ext4_ext_insert_extent()
      ext4: fix double brelse() the buffer of the extents path
      ext4: update orig_path in ext4_find_extent()
      jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      cachefiles: fix dentry leak in cachefiles_open_file()

Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Basavaraj Natikar (1):
      HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Beleswar Padhi (1):
      remoteproc: k3-r5: Acquire mailbox handle during probe routine

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Benjamin Gaignard (1):
      media: usbtv: Remove useless locks in usbtv_video_free()

Benjamin Poirier (1):
      selftests: net: Remove executable bits from library scripts

Biju Das (2):
      i2c: Add i2c_get_match_data()
      iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Bitterblue Smith (1):
      wifi: rtw88: 8822c: Fix reported RX band width

Boqun Feng (1):
      rust: macros: provide correct provenance when constructing THIS_MODULE

Breno Leitao (1):
      net: ibm/emac: allocate dummy net_device dynamically

Bryan O'Donoghue (1):
      media: qcom: camss: Fix ordering of pm_runtime_enable

Chao Yu (9):
      f2fs: fix to update i_ctime in __f2fs_setxattr()
      f2fs: remove unneeded check condition in __f2fs_setxattr()
      f2fs: reduce expensive checkpoint trigger frequency
      f2fs: fix to avoid racing in between read and OPU dio write
      f2fs: fix to wait page writeback before setting gcing flag
      f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
      f2fs: clean up w/ dotdot_name
      f2fs: get rid of online repaire on corrupted directory
      f2fs: fix to check atomic_file in f2fs ioctl interfaces

Charles Han (1):
      mtd: powernv: Add check devm_kasprintf() returned value

Chen Yu (1):
      kthread: fix task state in kthread worker if being frozen

Chen-Yu Tsai (2):
      regulator: Return actual error in of_regulator_bulk_get_all()
      arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled

Cheng Xu (1):
      RDMA/erdma: Return QP state in erdma_query_qp

Chengchang Tang (2):
      RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
      RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS

Chris Morgan (1):
      power: supply: axp20x_battery: Remove design from min and max voltage

Christian Heusel (1):
      block: print symbolic error name instead of error code

Christoph Hellwig (3):
      f2fs: factor the read/write tracing logic into a helper
      loop: don't set QUEUE_FLAG_NOMERGES
      iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release

Christophe JAILLET (6):
      fbdev: hpfb: Fix an error handling path in hpfb_dio_probe()
      drm/stm: Fix an error handling path in stm_drm_platform_probe()
      pps: remove usage of the deprecated ida_simple_xx() API
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      net: phy: bcm84881: Fix some error handling paths
      net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()

Christophe Leroy (6):
      powerpc/8xx: Fix initial memory mapping
      powerpc/8xx: Fix kernel vs user address comparison
      selftests: vDSO: fix vDSO name for powerpc
      selftests: vDSO: fix vdso_config for powerpc
      selftests: vDSO: fix vDSO symbols lookup for powerpc64
      powerpc/vdso: Fix VDSO data access when running in a non-root time namespace

Chuck Lever (3):
      fs: Create a generic is_dot_dotdot() utility
      NFSD: Fix NFSv4's PUTPUBFH operation
      NFSD: Mark filecache "down" if init fails

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Ckath (1):
      platform/x86: touchscreen_dmi: add nanote-next quirk

Claudiu Beznea (2):
      ARM: dts: microchip: sama7g5: Fix RTT clock
      drm/stm: ltdc: check memory returned by devm_kzalloc()

Clément Léger (1):
      ACPI: CPPC: Fix MASK_VAL() usage

Colin Ian King (1):
      r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"

Cristian Marussi (1):
      firmware: arm_scmi: Fix double free in OPTEE transport

Daehwan Jung (1):
      xhci: Add a quirk for writing ERST in high-low order

Damien Le Moal (2):
      ata: pata_serverworks: Do not use the term blacklist
      ata: sata_sil: Rename sil_blacklist to sil_quirks

Dan Carpenter (4):
      scsi: elx: libefc: Fix potential use after free in efc_nport_vport_del()
      PCI: keystone: Fix if-statement expression in ks_pcie_quirk()
      ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()
      SUNRPC: Fix integer overflow in decode_rc_list()

Daniel Borkmann (3):
      bpf: Fix bpf_strtol and bpf_strtoul helpers for 32bit
      bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types
      bpf: Zero former ARG_PTR_TO_{LONG,INT} args in case of error

Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Daniel Palmer (1):
      scsi: wd33c93: Don't use stale scsi_pointer value

Daniel Wagner (1):
      scsi: pm8001: Do not overwrite PCI queue mapping

Danilo Krummrich (1):
      mm: krealloc: consider spare memory for __GFP_ZERO

Darrick J. Wong (1):
      iomap: constrain the file range passed to iomap_file_unshare

Dave Ertman (1):
      ice: fix VLAN replay after reset

Dave Jiang (2):
      ntb: Force physically contiguous allocation of rx ring buffers
      cxl/pci: Break out range register decoding from cxl_hdm_decode_init()

David Gow (1):
      mm: only enforce minimum stack gap size if it's sensible

David Hildenbrand (1):
      selftests/mm: fix charge_reserved_hugetlb.sh test

David Lechner (1):
      clk: ti: dra7-atl: Fix leak of of_nodes

David Virag (3):
      arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM amount to 4GB
      dt-bindings: clock: exynos7885: Fix duplicated binding
      clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix

Dmitry Antipov (5):
      wifi: rtw88: always wait for both firmware loading attempts
      wifi: cfg80211: fix UBSAN noise in cfg80211_wext_siwscan()
      wifi: cfg80211: fix two more possible UBSAN-detected off-by-one errors
      wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()
      net: sched: consistently use rcu_replace_pointer() in taprio_change()

Dmitry Baryshkov (2):
      clk: qcom: dispcc-sm8250: use special function for Lucid 5LPE PLL
      clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks

Dmitry Kandybka (2):
      wifi: rtw88: remove CPT execution branch never used
      wifi: ath9k: fix possible integer overflow in ath9k_get_et_stats()

Dmitry Vyukov (2):
      x86/entry: Remove unwanted instrumentation in common_interrupt()
      module: Fix KCOV-ignored file name

Dragan Simic (2):
      arm64: dts: rockchip: Raise Pinebook Pro's panel backlight PWM frequency
      arm64: dts: rockchip: Correct the Pinebook Pro battery design capacity

Eduard Zingerman (1):
      bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos

Edward Adam Davis (3):
      jfs: Fix uaf in dbFreeBits
      jfs: check if leafidx greater than num leaves per dmap tree
      ext4: no need to continue when the number of entries is 1

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Emanuele Ghidoli (3):
      Input: ilitek_ts_i2c - avoid wrong input subsystem sync
      Input: ilitek_ts_i2c - add report id message validation
      gpio: davinci: fix lazy disable

Eric Dumazet (11):
      sock_map: Add a cond_resched() in sock_hash_free()
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()
      netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      icmp: change the order of rate limits
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      ppp: do not assume bh is held in ppp_channel_bridge_input()
      net/sched: accept TCA_STAB only for root qdisc
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Fabio Porcedda (1):
      bus: mhi: host: pci_generic: Fix the name for the Telit FE990A

Fangzhi Zuo (2):
      drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Fei Shao (1):
      drm/mediatek: Use spin_lock_irqsave() for CRTC event lock

Felix Fietkau (2):
      wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
      wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker

Felix Moessbauer (4):
      io_uring/sqpoll: do not allow pinning outside of cpuset
      io_uring/io-wq: do not allow pinning outside of cpuset
      io_uring/io-wq: inherit cpuset of cgroup in io worker
      io_uring/sqpoll: do not put cpumask on stack

Filipe Manana (3):
      btrfs: send: fix invalid clone operation for file that got its size decreased
      btrfs: wait for fixup workers before stopping cleaner kthread during umount
      btrfs: zoned: fix missing RCU locking in error message when loading zone info

Finn Thain (6):
      m68k: Fix kernel_clone_args.flags in m68k_clone()
      scsi: NCR5380: Check for phase match during PDMA fixup
      scsi: mac_scsi: Revise printk(KERN_DEBUG ...) messages
      scsi: mac_scsi: Refactor polling loop
      scsi: mac_scsi: Disallow bus errors during PDMA send
      scsi: NCR5380: Initialize buffer for MSG IN and STATUS transfers

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Florian Westphal (2):
      netfilter: xtables: avoid NFPROTO_UNSPEC where needed
      netfilter: fib: check correct rtable in vrf setups

Frank Li (1):
      PCI: imx6: Fix missing call to phy_power_off() in error handling

Frederic Weisbecker (2):
      rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
      kthread: unpark only parked kthread

Furong Xu (1):
      net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Gao Xiang (3):
      erofs: get rid of erofs_inode_datablocks()
      erofs: get rid of z_erofs_do_map_blocks() forward declaration
      erofs: fix incorrect symlink detection in fast symlink

Gaosheng Cui (2):
      hwrng: bcm2835 - Add missing clk_disable_unprepare in bcm2835_rng_init
      hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume

Gautham Ananthakrishna (1):
      ocfs2: reserve space for inline xattr before attaching reflink tree

Geert Uytterhoeven (3):
      pmdomain: core: Harden inter-column space in debug summary
      drm/radeon/r100: Handle unknown family in r100_cp_init_microcode()
      of/irq: Refer to actual buffer size in of_irq_parse_one()

Gerald Schaefer (1):
      s390/mm: Add cond_resched() to cmm_alloc/free_pages()

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Gilbert Wu (1):
      scsi: smartpqi: revert propagate-the-multipath-failure-to-SML-quickly

Greg Kroah-Hartman (1):
      Linux 6.1.113

Guenter Roeck (3):
      hwmon: (max16065) Fix overflows seen when writing limits
      hwmon: (max16065) Fix alarm attributes
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Guillaume Nault (2):
      bareudp: Pull inner IP header in bareudp_udp_encap_recv().
      bareudp: Pull inner IP header on xmit.

Guillaume Stols (2):
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation

Guoqing Jiang (2):
      nfsd: call cache_put if xdr_reserve_space returns NULL
      hwrng: mtk - Use devm_pm_runtime_enable

Gustavo A. R. Silva (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()

Hannes Reinecke (1):
      nvme-multipath: system fails to create generic nvme device

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hans Verkuil (1):
      media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags

Hans de Goede (5):
      ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18
      power: supply: hwmon: Fix missing temp1_max_alarm attribute
      ACPI: resource: Add Asus Vivobook X1704VAP to irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to irq1_level_low_skip_override[]
      i2c: i801: Use a different adapter-name for IDF adapters

Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Haren Myneni (1):
      powerpc/pseries: Use correct data types from pseries_hp_errorlog struct

Harshit Mogalapalli (1):
      usb: yurex: Fix inconsistent locking bug in yurex_read()

He Lugang (1):
      HID: multitouch: Add support for lenovo Y9000P Touchpad

Heiko Carstens (2):
      selftests: vDSO: fix vdso_config for s390
      s390/facility: Disable compile time optimization for decompressor code

Heiner Kallweit (3):
      r8169: disable ALDPS per default for RTL8125
      i2c: core: Lock address during client device instantiation
      r8169: add tally counter fields added with RTL8125

Helge Deller (4):
      crypto: xor - fix template benchmarking
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Fix 64-bit userspace syscall path
      parisc: Fix stack start for ADDR_NO_RANDOMIZE personality

Heming Zhao (1):
      ocfs2: fix the la space leak when unmounting an ocfs2 volume

Herbert Xu (1):
      crypto: simd - Do not call crypto_alloc_tfm during registration

Hilda Wu (1):
      Bluetooth: btusb: Add Realtek RTL8852C support ID 0x0489:0xe122

Hobin Woo (1):
      ksmbd: make __dir_empty() compatible with POSIX

Howard Hsu (1):
      wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Huang Ying (1):
      resource: fix region_intersects() vs add_memory_driver_managed()

Hui Wang (1):
      ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m

Ian Rogers (4):
      perf inject: Fix leader sampling inserting additional samples
      perf time-utils: Fix 32-bit nsec parsing
      perf lock: Dynamically allocate lockhash_table
      perf sched: Avoid large stack allocations

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ido Schimmel (1):
      ipv4: Mask upper DSCP bits and ECN bits in NETLINK_FIB_LOOKUP family

Ignat Korchagin (1):
      net: explicitly clear the sk pointer, when pf->create fails

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix a race in scan abort flow

Ilpo Järvinen (1):
      PCI: Wait for Link before restoring Downstream Buses

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Issam Hamdi (1):
      wifi: cfg80211: Set correct chandef when starting CAC

Jack Wang (2):
      RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
      Revert "iommu/vt-d: Retrieve IOMMU perfmon capability information"

Jake Hamby (1):
      can: m_can: enable NAPI before enabling interrupts

Jakub Kicinski (1):
      Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"

Jamie Bainbridge (1):
      icmp: Add counters for rate limits

Jan Kara (1):
      ext4: don't set SB_RDONLY after filesystem errors

Jan Kiszka (1):
      remoteproc: k3-r5: Fix error handling when power-up failed

Jan Lalinsky (1):
      ALSA: usb-audio: Add native DSD support for Luxman D-08u

Jani Nikula (1):
      drm/i915/gem: fix bitwise and logical AND mixup

Jann Horn (2):
      firmware_loader: Block path traversal
      f2fs: Require FMODE_WRITE for atomic write ioctls

Jaroslav Kysela (1):
      ALSA: core: add isascii() check to card ID generator

Jason Gerecke (2):
      HID: wacom: Support sequence numbers smaller than 16-bit
      HID: wacom: Do not warn about dropped packets for first packet

Jason Gunthorpe (1):
      iommu/amd: Do not set the D bit on AMD v2 table entries

Jason Wang (1):
      vhost_vdpa: assign irq bypass producer token correctly

Jason Xing (1):
      tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process

Jason-JH.Lin (1):
      drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()

Javier Carrasco (2):
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C

Jean-Loïc Charroud (2):
      ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table
      ALSA: hda/realtek: cs35l41: Fix device ID / model name

Jeff Layton (2):
      nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
      nfsd: fix refcount leak when file is unhashed after being found

Jens Axboe (3):
      io_uring/sqpoll: retain test for whether the CPU is valid
      io_uring/net: harden multishot termination case for recv
      io_uring: check if we need to reschedule during overflow flush

Jens Remus (1):
      selftests: vDSO: fix ELF hash table entry size for s390x

Jeongjun Park (2):
      jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Jesse Zhang (1):
      drm/amdkfd: Fix resource leak in criu restore queue

Jiawei Ye (2):
      wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
      smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso

Jing Zhang (1):
      drivers/perf: Fix ali_drw_pmu driver interrupt status clearing

Jingbo Xu (2):
      erofs: avoid hardcoded blocksize for subpage block support
      erofs: set block size to the on-disk block size

Jinjie Ruan (16):
      net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
      mtd: rawnand: mtk: Use for_each_child_of_node_scoped()
      riscv: Fix fp alignment bug in perf_callchain_user()
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      spi: atmel-quadspi: Undo runtime PM changes at driver exit time
      spi: spi-fsl-lpspi: Undo runtime PM changes at driver exit time
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      nfp: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: bcm63xx: Fix module autoloading
      i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: bcm63xx: Fix missing pm_runtime_disable()

Jiri Olsa (2):
      selftests/bpf: Replace extract_build_id with read_build_id
      selftests/bpf: Move test_progs helpers to testing_helpers object

Jisheng Zhang (1):
      riscv: define ILLEGAL_POINTER_VALUE for 64bit

Jiwon Kim (1):
      bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()

Johannes Berg (1):
      wifi: mac80211: fix RCU list iterations

Johannes Weiner (1):
      sched: psi: fix bogus pressure spikes from aggregation race

John Keeping (1):
      usb: gadget: core: force synchronous registration

Jonas Blixt (1):
      watchdog: imx_sc_wdt: Don't disable WDT in suspend

Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

Jonas Karlman (2):
      drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
      clk: rockchip: Set parent rate for DCLK_VOP clock on RK3228

Jonathan McDowell (1):
      tpm: Clean up TPM space after command failure

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joseph Qi (2):
      ocfs2: fix uninit-value in ocfs2_get_block()
      ocfs2: cancel dqi_sync_work before freeing oinfo

Josh Hunt (1):
      tcp: check skb is non-NULL in tcp_rto_delta_us()

Joshua Pius (1):
      ALSA: usb-audio: Add logitech Audio profile quirk

Juergen Gross (3):
      xen: use correct end address of kernel for conflict checking
      xen/swiotlb: add alignment check for dma buffers
      xen/swiotlb: fix allocated size

Julian Sun (2):
      vfs: fix race between evice_inodes() and find_inode()&iput()
      ocfs2: fix null-ptr-deref when journal load failed.

Junlin Li (2):
      drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error

Junxian Huang (3):
      RDMA/hns: Don't modify rq next block addr in HIP09 QPC
      RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
      RDMA/hns: Optimize hem allocation performance

Justin Iurman (1):
      net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input

Justin Tee (3):
      scsi: lpfc: Update PRLO handling in direct attached topology
      scsi: lpfc: Add ELS_RSP cmd to the list of WQEs to flush in lpfc_els_flush_cmd()
      scsi: lpfc: Ensure DA_ID handling completion before deleting an NPIV instance

Kacper Ludwinski (1):
      selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test

Kairui Song (3):
      mm/filemap: return early if failed to allocate memory for split
      lib/xarray: introduce a new helper xas_get_order
      mm/filemap: optimize filemap folio adding

Kaixin Wang (3):
      net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
      fbdev: pxafb: Fix possible use after free in pxafb_task()
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Kamlesh Gurudasani (1):
      padata: Honor the caller's alignment in case of chunk_size 0

Karthikeyan Periyasamy (1):
      wifi: ath11k: fix array out-of-bound access in SoC stats

Katya Orlova (1):
      drm/stm: Avoid use-after-free issues with crtc and plane

Kees Cook (2):
      x86/syscall: Avoid memcpy() for ia32 syscall_get_arguments()
      scsi: aacraid: Rearrange order of struct aac_srb_unit

Keith Busch (1):
      nvme-pci: qdepth 1 quirk

Kemeng Shi (4):
      ext4: avoid buffer_head leak in ext4_mark_inode_used()
      ext4: avoid potential buffer_head leak in __ext4_new_inode()
      ext4: avoid negative min_clusters in find_group_orlov()
      jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit

Kenton Groombridge (1):
      wifi: mac80211: Avoid address calculations via out of bounds array indexing

KhaiWenTan (1):
      net: stmmac: Fix zero-division error when disabling tc cbs

Kieran Bingham (1):
      media: i2c: imx335: Enable regulator supplies

Konstantin Komarov (3):
      fs/ntfs3: Do not call file_modified if collapse range failed
      fs/ntfs3: Fix sparse warning in ni_fiemap
      fs/ntfs3: Refactor enum_rstbl to suppress static checker

Konstantin Ovsepian (1):
      blk_iocost: fix more out of bound shifts

Krzysztof Kozlowski (18):
      ARM: dts: imx7d-zii-rmu2: fix Ethernet PHY pinctrl property
      ARM: versatile: fix OF node leak in CPUs prepare
      reset: berlin: fix OF node leak in probe() error path
      reset: k210: fix OF node leak in probe() error path
      iio: magnetometer: ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
      soc: versatile: integrator: fix OF node leak in probe() error path
      bus: integrator-lm: fix OF node leak in probe()
      soc: versatile: realview: fix memory leak during device remove
      soc: versatile: realview: fix soc_dev leak during device remove
      net: hisilicon: hip04: fix OF node leak in probe()
      net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
      net: hisilicon: hns_mdio: fix OF node leak in probe()
      ASoC: codecs: wsa883x: Handle reading version failure
      firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
      rtc: at91sam9: fix OF node leak in probe() error path
      clk: samsung: exynos7885: do not define number of clocks in bindings
      clk: bcm: bcm53573: fix OF node leak in init

Kun(llfl) (1):
      device-dax: correct pgoff align in dax_set_mapping()

Kuniyuki Iwashima (5):
      can: bcm: Clear bo->bcm_proc_read after remove_proc_entry().
      ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
      rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
      vxlan: Handle error of rtnl_register_module().
      mctp: Handle error of rtnl_register_module().

Lad Prabhakar (3):
      arm64: dts: renesas: r9a07g043u: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g054: Correct GICD and GICR sizes
      arm64: dts: renesas: r9a07g044: Correct GICD and GICR sizes

Lasse Collin (1):
      xz: cleanup CRC32 edits from 2018

Laurent Pinchart (2):
      Remove *.orig pattern from .gitignore
      media: sun4i_csi: Implement link validate for sun4i_csi subdev

Lee Jones (1):
      usb: yurex: Replace snprintf() with the safer scnprintf() variant

Li Lingfeng (3):
      nfsd: return -EINVAL when namelen is 0
      nfs: fix memory leak in error path of nfs4_do_reclaim
      nfsd: map the EBADMSG to nfserr_io to avoid warning

Li Zhijian (1):
      nvdimm: Fix devs leaks in scan_labels()

Liam R. Howlett (1):
      mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Liao Chen (1):
      mailbox: rockchip: fix a typo in module autoloading

Linus Walleij (2):
      net: ethernet: cortina: Drop TSO support
      net: ethernet: cortina: Restore TSO support

Liu Ying (1):
      drm/bridge: lontium-lt8912b: Validate mode in drm_bridge_funcs::mode_valid()

Lizhi Xu (2):
      ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate

Lorenzo Bianconi (1):
      wifi: mt76: do not run mt76_unregister_device() on unregistered hw

Lu Baolu (1):
      iommu/vt-d: Always reserve a domain ID for identity setup

Luis Henriques (SUSE) (7):
      ext4: fix incorrect tid assumption in ext4_fc_mark_ineligible()
      ext4: fix incorrect tid assumption in __jbd2_log_wait_for_space()
      ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
      ext4: fix incorrect tid assumption in jbd2_journal_shrink_checkpoint_list()
      ext4: fix fast commit inode enqueueing during a full journal commit
      ext4: use handle to mark fc as ineligible in __track_dentry_update()
      ext4: mark fc as ineligible using an handle in ext4_xattr_set()

Luiz Augusto von Dentz (7):
      Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
      Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
      Bluetooth: btusb: Fix not handling ZPL/short-transfer
      Bluetooth: hci_sock: Fix not validating setsockopt user input
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
      Bluetooth: Fix usage of __hci_cmd_sync_status
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

Lukas Wunner (1):
      xhci: Preserve RsvdP bits in ERSTBA register correctly

Luo Gengkun (1):
      perf/core: Fix small negative period being ignored

Ma Ke (6):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
      ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
      wifi: mt76: mt7615: check devm_kasprintf() returned value
      pps: add an error check in parport_attach
      drm: omapdrm: Add missing check for alloc_ordered_workqueue

Mahesh Rajashekhara (1):
      scsi: smartpqi: correct stream detection

Manivannan Sadhasivam (3):
      clk: qcom: gcc-sm8450: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8250: Do not turn off PCIe GDSCs during gdsc_disable()
      dt-bindings: clock: qcom: Add missing UFS QREF clocks

Marc Ferland (1):
      i2c: xiic: improve error message when transfer fails to start

Marc Gonzalez (1):
      iommu/arm-smmu-qcom: hide last LPASS SMMU context bank from linux

Marc Kleine-Budde (1):
      can: m_can: m_can_close(): stop clocks after device has been shut down

Marcin Szycik (1):
      ice: Fix netif_is_ice() in Safe Mode

Marek Vasut (1):
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/resume

Mario Limonciello (2):
      drm/amd/display: Validate backlight caps are sane
      drm/amd/display: Allow backlight to go below `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`

Mark Brown (4):
      kselftest/arm64: Don't pass headers to the compiler as source
      kselftest/arm64: Verify simultaneous SSVE and ZA context generation
      kselftest/arm64: Fix enumeration of systems without 128 bit SME for SSVE+ZA
      kselftest/arm64: Actually test SME vector length changes via sigreturn

Mark Rutland (2):
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more

Markus Elfring (1):
      clk: imx: composite-8m: Less function calls in __imx8m_clk_hw_composite() after error detection

Markus Schneider-Pargmann (1):
      can: m_can: Remove repeated check for is_peripheral

Martin Wilck (1):
      scsi: sd: Fix off-by-one error in sd_read_block_characteristics()

Masahiro Yamada (1):
      kconfig: qconf: fix buffer overflow in debug links

Masami Hiramatsu (Google) (1):
      bootconfig: Fix the kerneldoc of _xbc_exit()

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathias Nyman (4):
      xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.
      xhci: fix event ring segment table related masks and variables in header
      xhci: remove xhci_test_trb_in_td_math early development check
      xhci: Refactor interrupter code for initial multi interrupter support.

Matt Fleming (1):
      perf hist: Update hist symbol when updating maps

Matthew Brost (1):
      drm/printer: Allow NULL data in devcoredump printer

Matthieu Baerts (NGI0) (2):
      mptcp: fallback when MPTCP opts are dropped after 1st data
      mptcp: pm: do not remove closing subflows

Max Hawking (1):
      ntb_perf: Fix printk format

Maíra Canal (2):
      drm/v3d: Stop the active perfmon before being destroyed
      drm/vc4: Stop the active perfmon before being destroyed

Md Haris Iqbal (2):
      RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
      RDMA/rtrs-srv: Avoid null pointer deref during path establishment

Michael Ellerman (1):
      powerpc/atomic: Use YZ constraints for DS-form instructions

Michael Guralnik (1):
      RDMA/mlx5: Enforce umem boundaries for explicit ODP page faults

Michael S. Tsirkin (1):
      virtio_console: fix misc probe bugs

Mickaël Salaün (1):
      fs: Fix file_set_fowner LSM hook inconsistencies

Mika Westerberg (3):
      PCI/PM: Increase wait time after resume
      PCI/PM: Drop pci_bridge_wait_for_secondary_bus() timeout parameter
      PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume

Mike Tipton (1):
      clk: qcom: clk-rpmh: Fix overflow in BCM vote

Mikhail Lobanov (2):
      RDMA/cxgb4: Added NULL check for lookup_atid
      drbd: Add NULL check for net_conf to prevent dereference in state validation

Mikulas Patocka (1):
      Revert "dm: requeue IO if mapping table not yet available"

Ming Lei (2):
      nbd: fix race between timeout and normal completion
      lib/sbitmap: define swap_lock as raw_spinlock_t

Minjie Du (1):
      wifi: ath9k: fix parameter check in ath9k_init_debug()

Miquel Raynal (2):
      mtd: rawnand: mtk: Factorize out the logic cleaning mtk chips
      mtd: rawnand: mtk: Fix init error path

Mirsad Todorovac (1):
      mtd: slram: insert break after errors in parsing the map

Mohamed Khalfella (2):
      net/mlx5: Added cond_resched() to crdump collection
      igb: Do not bring the device up after non-fatal error

Namhyung Kim (2):
      perf mem: Free the allocated sort string, fixing a leak
      perf report: Fix segfault when 'sym' sort key is not used

Namjae Jeon (2):
      ksmbd: allow write with FILE_APPEND_DATA
      ksmbd: handle caseless file creation

Nathan Chancellor (1):
      powerpc: Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with ld.lld 15+

Neal Cardwell (2):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe

NeilBrown (1):
      nfsd: fix delegation_blocked() to block correctly for at least 30 seconds

Nicholas Piggin (2):
      powerpc/64: Option to build big-endian with ELFv2 ABI
      powerpc/64: Add support to build with prefixed instructions

Nikita Zhandarovich (4):
      drm/radeon/evergreen_cs: fix int overflow errors in cs track offsets
      f2fs: fix several potential integer overflows in file offsets
      f2fs: prevent possible int overflow in dir_block_index()
      f2fs: avoid potential int overflow in sanity_check_area_boundary()

Niklas Cassel (1):
      ata: libata: avoid superfluous disk spin down + spin up during hibernation

Nishanth Menon (1):
      cpufreq: ti-cpufreq: Introduce quirks to handle syscon fails appropriately

Nuno Sa (3):
      Input: adp5588-keys - fix check on return code
      Input: adp5589-keys - fix NULL pointer dereference
      Input: adp5589-keys - fix adp5589_gpio_get_value()

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Olaf Hering (1):
      mount: handle OOM on mnt_warn_timestamp_expiry

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Oliver Neukum (6):
      usbnet: fix cyclical race on disconnect with work queue
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: misc: yurex: fix race between read and write
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() variant"

Pablo Neira Ayuso (4):
      netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
      netfilter: nf_tables: reject element expiration with no timeout
      netfilter: nf_tables: reject expiration higher than timeout
      netfilter: nf_tables: remove annotation to access set timeout while holding lock

Palmer Dabbelt (1):
      RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t

Paolo Abeni (1):
      mptcp: handle consistently DSS corruption

Patrick Donnelly (1):
      ceph: fix cap ref leak via netfs init_request

Patrick Roy (1):
      secretmem: disable memfd_secret() if arch cannot set direct map

Patrisious Haddad (1):
      IB/core: Fix ib_cache_setup_one error flow cleanup

Paul E. McKenney (1):
      rcuscale: Provide clear error when async specified without primitives

Paulo Miguel Almeida (2):
      drm/amdgpu: Replace one-element array with flexible-array member
      drm/radeon: Replace one-element array with flexible-array member

Pavan Kumar Paluri (1):
      crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure

Pawel Laszczak (2):
      usb: cdnsp: Fix incorrect usb_request status
      usb: xhci: fix loss of data on Cadence xHC

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()

Peng Fan (8):
      clk: imx: composite-8m: Enable gate clk with mcore_booted
      clk: imx: fracn-gppll: support integer pll
      clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
      clk: imx: imx8qxp: Parent should be initialized earlier than the clock
      remoteproc: imx_rproc: Correct ddr alias for i.MX8M
      remoteproc: imx_rproc: Initialize workqueue earlier
      remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table
      clk: imx: Remove CLK_SET_PARENT_GATE for DRAM mux for i.MX7D

Peng Liu (2):
      drm/amdgpu: add raven1 gfxoff quirk
      drm/amdgpu: enable gfxoff quirk on HP 705G4

Pengfei Li (1):
      clk: imx: fracn-gppll: fix fractional part of PLL getting lost

Peter Zijlstra (1):
      jump_label: Fix static_key_slow_dec() yet again

Phil Sutter (3):
      netfilter: nf_tables: Keep deleted flowtable hooks until after RCU
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      selftests: netfilter: Fix nft_audit.sh for newer nft binaries

Philip Chen (1):
      virtio_pmem: Check device status before requesting flush

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit

Ping-Ke Shih (2):
      wifi: mac80211: don't use rate mask for offchannel TX either
      wifi: rtw89: correct base HT rate mask for firmware

Qianqiang Liu (1):
      fbcon: Fix a NULL pointer dereference issue in fbcon_putcs

Qiu-ji Chen (1):
      drbd: Fix atomicity violation in drbd_uuid_set_bm()

Qiuxu Zhuo (1):
      EDAC/igen6: Fix conversion of system address to physical memory address

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new trasacntion

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Remington Brasga (1):
      jfs: UBSAN: shift-out-of-bounds in dbFindBits

Riyan Dhiman (2):
      block: fix potential invalid pointer dereference in blk_add_partition
      staging: vme_user: added bound check to geoid

Rob Clark (1):
      drm/crtc: fix uninitialized variable use even harder

Robert Hancock (2):
      i2c: xiic: Try re-initialization on bus busy timeout
      i2c: xiic: Wait for TX empty to avoid missed TX NAKs

Roberto Sassu (1):
      selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()

Robin Chen (1):
      drm/amd/display: Round calculated vtotal

Robin Murphy (5):
      perf/arm-cmn: Rework DTC counters (again)
      perf/arm-cmn: Improve debugfs pretty-printing for large configs
      perf/arm-cmn: Refactor node ID handling. Again.
      perf/arm-cmn: Ensure dtm_idx is big enough
      perf/arm-cmn: Fail DTC counter allocation correctly

Roman Smirnov (2):
      Revert "media: tuners: fix error return code of hybrid_tuner_request_state()"
      KEYS: prevent NULL pointer dereference in find_asymmetric_key()

Rosen Penev (2):
      net: ibm: emac: mal: fix wrong goto
      net: ibm: emac: mal: add dcr_unmap to _remove

Ruffalo Lavoisier (1):
      comedi: ni_routing: tools: Check when the file could not be opened

Ryusuke Konishi (3):
      nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      nilfs2: determine empty node blocks as corrupted
      nilfs2: fix potential oob read in nilfs_btree_check_delete()

Sanjay K Kumar (1):
      iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count

Saravanan Vajravel (1):
      RDMA/mad: Improve handling of timed out WRs of mad agent

Sascha Hauer (1):
      drm/rockchip: vop: limit maximum resolution to hardware capabilities

Sasha Levin (1):
      Revert "net: ibm/emac: allocate dummy net_device dynamically"

Satya Priya Kakitapalli (4):
      clk: qcom: gcc-sm8150: De-register gcc_cpuss_ahb_clk_src
      clk: qcom: gcc-sc8180x: Fix the sdcc2 and sdcc4 clocks freq table
      dt-bindings: clock: qcom: Add GPLL9 support on gcc-sc8180x
      clk: qcom: gcc-sc8180x: Add GPLL9 support

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx hook

Sean Anderson (5):
      PCI: xilinx-nwl: Fix register misspelling
      PCI: xilinx-nwl: Clean up clock on probe failure/removal
      net: xilinx: axienet: Schedule NAPI in two steps
      net: xilinx: axienet: Fix packet counting
      PCI: xilinx-nwl: Fix off-by-one in INTx IRQ handler

Sean Christopherson (2):
      KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits
      KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()

Sebastian Reichel (1):
      clk: rockchip: fix error for unknown clocks

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is halted

Serge Semin (1):
      EDAC/synopsys: Fix ECC status and IRQ control race condition

Shawn Shao (1):
      usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Shay Drory (1):
      net/mlx5: Always drain health in shutdown callback

Shenwei Wang (1):
      net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit check

Sherry Yang (1):
      drm/msm: fix %s null argument error

Shiyang Ruan (3):
      fsdax,xfs: port unshare to fsdax
      fsdax: dax_unshare_iter() should return a valid length
      fsdax: unshare: zero destination if srcmap is HOLE or UNWRITTEN

Shubhrajyoti Datta (1):
      EDAC/synopsys: Fix error injection on Zynq UltraScale+

Simon Horman (6):
      netfilter: ctnetlink: compile ctnetlink_label_size with CONFIG_NF_CONNTRACK_EVENTS
      tipc: guard against string buffer overrun
      net: mvpp2: Increase size of queue_name buffer
      bnxt_en: Extend maximum length of version string by 1 byte
      net: atlantic: Avoid warning about potential string truncation
      netfilter: nf_reject: Fix build warning when CONFIG_BRIDGE_NETFILTER=n

Song Liu (1):
      bpf: lsm: Set bpf_lsm_blob_sizes.lbs_task to 0

Srinivas Pandruvada (1):
      thermal: int340x: processor_thermal: Set feature mask before proc_thermal_add

Srinivasan Shanmugam (7):
      drm/amd/display: Add null check for set_output_gamma in dcn30_set_output_transfer_func
      drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
      drm/amd/display: Handle null 'stream_status' in 'planes_changed_for_existing_stream'
      drm/amd/display: Add null check for 'afb' in amdgpu_dm_plane_handle_cursor_update (v2)
      drm/amd/display: Fix index out of bounds in DCN30 degamma hardware format translation
      drm/amd/display: Fix index out of bounds in degamma hardware format translation
      drm/amd/display: Fix index out of bounds in DCN30 color transformation

Stefan Wahren (2):
      drm/vc4: hdmi: Handle error case of pm_runtime_resume_and_get
      mailbox: bcm2835: Fix timeout during suspend mode

Steven Rostedt (Google) (2):
      tracing: Remove precision vsnprintf() check from print event
      tracing: Have saved_cmdlines arrays all in one allocation

Su Hui (1):
      net: tipc: avoid possible garbage value

Subramanian Ananthanarayanan (1):
      PCI: Add ACS quirk for Qualcomm SA8775P

Sumit Semwal (1):
      Revert "arm64: dts: qcom: sm8250: switch UFS QMP PHY to new style of bindings"

SurajSonawane2415 (1):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in ish_fw_xfer_direct_dma

Suzuki K Poulose (1):
      coresight: tmc: sg: Do not leak sg_table

Takashi Iwai (8):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin
      ALSA: usb-audio: Add input value sanity checks for standard types
      ALSA: usb-audio: Define macros for quirk table entries
      ALSA: usb-audio: Replace complex quirk lines with macros
      ALSA: asihpi: Fix potential OOB array access
      ALSA: hdsp: Break infinite MIDI input flush loop
      Revert "ALSA: hda: Conditionally use snooping for AMD HDMI"

Tao Chen (1):
      bpf: Check percpu map value size first

Tao Liu (1):
      x86/kexec: Add EFI config table identity mapping for kexec kernel

Tetsuo Handa (1):
      tomoyo: fallback to realpath if symlink's pathname does not exist

Thadeu Lima de Souza Cascardo (3):
      ext4: return error on ext4_find_inline_entry
      ext4: avoid OOB when system.data xattr changes underneath the filesystem
      ext4: ext4_search_dir should return a proper error

Thomas Gleixner (4):
      static_call: Handle module init failure correctly in static_call_del_module()
      static_call: Replace pointless WARN_ON() in static_call_module_notify()
      jump_label: Simplify and clarify static_key_fast_inc_cpus_locked()
      x86/ioapic: Handle allocation failures gracefully

Thomas Richter (1):
      s390/cpum_sf: Remove WARN_ON_ONCE statements

Thomas Weißschuh (6):
      net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
      ACPI: sysfs: validate return type of _STR method
      selftests/nolibc: avoid passing NULL to printf("%s")
      blk-integrity: use sysfs_emit
      blk-integrity: convert to struct device_attribute
      blk-integrity: register sysfs attributes on struct device

Thomas Zimmermann (1):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS

Tim Huang (2):
      drm/amdgpu: fix unchecked return value warning for amdgpu_gfx
      drm/amd/pm: ensure the fw_info is not null before using it

Toke Høiland-Jørgensen (2):
      wifi: ath9k: Remove error checks when creating debugfs entries
      wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit

Tom Chung (1):
      drm/amd/display: Fix system hang while resume with TBT monitor

Tomas Marek (1):
      usb: dwc2: drd: fix clock gating on USB role switch

Tommy Huang (1):
      i2c: aspeed: Update the stop sw state when the bus recovery occurs

Tony Ambardar (15):
      selftests/bpf: Use pid_t consistently in test_progs.c
      selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
      selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl libc
      selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
      selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
      selftests/bpf: Fix missing BUILD_BUG_ON() declaration
      selftests/bpf: Fix include of <sys/fcntl.h>
      selftests/bpf: Fix compiling kfree_skb.c with musl-libc
      selftests/bpf: Fix compiling flow_dissector.c with musl-libc
      selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
      selftests/bpf: Fix compiling core_reloc.c with musl-libc
      selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
      selftests/bpf: Fix error compiling test_lru_map.c
      selftests/bpf: Fix C++ compile error from missing _Bool type
      selftests/bpf: Fix compile if backtrace support missing in libc

Tvrtko Ursulin (1):
      drm/sched: Add locking to drm_sched_entity_modify_sched

Udit Kumar (1):
      remoteproc: k3-r5: Delay notification of wakeup event

Umang Jain (1):
      media: imx335: Fix reset-gpio handling

Uwe Kleine-König (1):
      cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock

Val Packett (2):
      drm/rockchip: vop: clear DMA stop bit on RK3066
      drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

VanGiang Nguyen (1):
      padata: use integer wrap around to prevent deadlock on seq_nr overflow

Vasileios Amoiridis (1):
      iio: chemical: bme680: Fix read/write ops to device by adding mutexes

Vasily Khoruzhick (2):
      ACPICA: Implement ACPI_WARNING_ONCE and ACPI_ERROR_ONCE
      ACPICA: executer/exsystem: Don't nag user about every Stall() violating the spec

Vishnu Sankar (1):
      HID: multitouch: Add support for Thinkpad X12 Gen 2 Kbd Portfolio

Vitaliy Shevtsov (1):
      RDMA/irdma: fix error message in irdma_modify_qp_roce()

Vladimir Lypak (4):
      drm/msm/a5xx: disable preemption in submits by default
      drm/msm/a5xx: properly clear preemption records on resume
      drm/msm/a5xx: fix races in preemption evaluation stage
      drm/msm/a5xx: workaround early ring-buffer emptiness check

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Wang Jianzheng (1):
      pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function

Wang Yong (1):
      delayacct: improve the average delay precision of getdelay tool to microsecond

WangYuli (2):
      drm/amd/amdgpu: Properly tune the size of struct
      PCI: Add function 0 DMA alias quirk for Glenfly Arise chip

Wei Li (2):
      tracing/hwlat: Fix a race during cpuhp processing
      tracing/timerlat: Fix a race during cpuhp processing

Weili Qian (5):
      crypto: hisilicon/hpre - enable sva error interrupt event
      crypto: hisilicon/hpre - mask cluster timeout error
      crypto: hisilicon/qm - fix coding style issues
      crypto: hisilicon/qm - reset device before enabling it
      crypto: hisilicon/qm - inject error before stopping queue

Wentao Guan (1):
      LoongArch: Fix memleak in pci_acpi_scan_root()

Werner Sembach (4):
      Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table
      Input: i8042 - add TUXEDO Stellaris 15 Slim Gen6 AMD to i8042 quirk table
      Input: i8042 - add another board name for TUXEDO Stellaris Gen5 AMD line
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Willem de Bruijn (1):
      gso: fix udp gso fraglist segmentation after pull from frag_list

Wojciech Gładysz (1):
      ext4: nested locking for xattr inode

Wolfram Sang (2):
      ipmi: docs: don't advertise deprecated sysfs entries
      i2c: create debugfs entry per adapter

Xie Yongji (1):
      vdpa: Add eventfd for the vdpa callback

Xin Li (1):
      x86/idtentry: Incorporate definitions/declarations of the FRED entries

Xin Long (2):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
      sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start

Xiubo Li (1):
      ceph: remove the incorrect Fw reference check when dirtying pages

Xu Yang (1):
      usb: chipidea: udc: enable suspend interrupt after usb reset

Yanfei Xu (1):
      cxl/pci: Fix to record only non-zero ranges

Yang Jihong (6):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time
      perf sched: Move start_work_mutex and work_done_wait_mutex initialization to perf_sched__replay()
      perf sched: Fix memory leak in perf_sched__map()
      perf sched: Move curr_thread initialization to perf_sched__map()
      perf sched: Move curr_pid and cpu_last_switched initialization to perf_sched__{lat|map|replay}()

Yang Yingliang (1):
      pinctrl: single: fix missing error code in pcs_probe()

Yangtao Li (1):
      pinctrl: mvebu: Use devm_platform_get_and_ioremap_resource()

Yanjun Zhang (1):
      NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

Yannick Fertre (1):
      drm/stm: ltdc: reset plane transparency after plane disable

Yanteng Si (2):
      net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
      docs/zh_CN: Update the translation of delay-accounting to 6.1-rc8

Ye Bin (1):
      vfio/pci: fix potential memory leak in vfio_intx_enable()

Ye Li (1):
      clk: imx: composite-7ulp: Check the PCC present bit

Yicong Yang (2):
      drivers/perf: hisi_pcie: Record hardware counts correctly
      perf stat: Display iostat headers correctly

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succeed

Ying Sun (1):
      riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown

Yonatan Maman (1):
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Yonghong Song (5):
      selftests/bpf: Add selftest deny_namespace to s390x deny list
      selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
      selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
      selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
      bpf, x64: Fix a jit convergence issue

Yosry Ahmed (1):
      mm: z3fold: deprecate CONFIG_Z3FOLD

Youssef Samir (1):
      net: qrtr: Update packets cloning when broadcasting

Yu Kuai (4):
      block, bfq: fix possible UAF for bfqq->bic with merge chain
      block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      block, bfq: don't break merge chain in bfq_split_bfqq()
      block, bfq: fix uaf for accessing waker_bfqq after splitting

Yuesong Li (1):
      drivers:drm:exynos_drm_gsc:Fix wrong assignment in gsc_bind()

Yuezhang Mo (1):
      exfat: fix memory leak in exfat_load_bitmap()

Yunke Cao (1):
      media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()

Yuntao Liu (2):
      ALSA: hda: cs35l41: fix module autoloading
      hwmon: (ntc_thermistor) fix module autoloading

Zach Wade (1):
      platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Zack Rusin (1):
      drm/vmwgfx: Prevent unmapping active read buffers

Zhang Changzhong (1):
      can: j1939: use correct function name in comment

Zhang Rui (1):
      thermal: intel: int340x: processor: Fix warning during module unload

Zhao Mengmeng (1):
      jfs: Fix uninit-value access of new_ea in ea_buffer

Zhen Lei (1):
      debugobjects: Fix conditions in fill_pool()

Zheng Wang (1):
      media: venus: fix use after free bug in venus_remove due to race condition

Zhiguo Niu (1):
      lockdep: fix deadlock issue between lockdep and rcu

Zhihao Cheng (1):
      ext4: dax: fix overflowing extents beyond inode size when partially writing

Zhipeng Wang (1):
      clk: imx: imx8mp: fix clock tree update of TF-A managed clocks

Zhu Jun (1):
      tools/iio: Add memory allocation failure check for trigger_name

Zhu Yanjun (1):
      RDMA/iwcm: Fix WARNING:at_kernel/workqueue.c:#check_flush_dependency

Zijun Hu (1):
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute

Zong-Zhe Yang (1):
      wifi: rtw88: select WANT_DEV_COREDUMP

wangrong (1):
      smb: client: use actual path when queryfs

wenglianfa (2):
      RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()

yangerkun (1):
      ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard

yao.ly (1):
      ext4: correct encrypted dentry name hash when not casefolded


