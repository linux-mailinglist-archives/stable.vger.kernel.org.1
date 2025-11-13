Return-Path: <stable+bounces-194736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10731C5A0AD
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 295E334B4A7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F212D0C7B;
	Thu, 13 Nov 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sve4936S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B52C0271;
	Thu, 13 Nov 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067763; cv=none; b=J7qPButw182Gizkc7kXJR9U3t69V5m21+kivOV0/v5HwyaaaDxHUmQM7EUdu/4h/lGwHbYrXAeIQQMyrdOw2KYhoEVMNiXoarZoSCDcLXs4n+qWvmp2M1dz9o6YGZmIkvC6uQ9cRmWr+dqh/k0tDPq0+b7L2bZs9rAnmQNun08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067763; c=relaxed/simple;
	bh=BZWNxiOY9TxkEN6Y+tn+Pp9W6NONZCyxc6Uaq1kJHYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZuYwx95S3z750Lsu6ebqrISTcfb/2r3WsPdY/vrkZQId6pk9IYTjwubCvmlLOKUM2MKwSSOOzOp8EE49+no+guJj4Xxy0fY7PJUWsNHXjNOVBg/QuuI/wu0Fj4LnrMxioRq9GH9ZU8LOFVG2ELe/p/ThBoETbn3z15Gcn6urOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sve4936S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A34C4CEF7;
	Thu, 13 Nov 2025 21:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763067763;
	bh=BZWNxiOY9TxkEN6Y+tn+Pp9W6NONZCyxc6Uaq1kJHYs=;
	h=From:To:Cc:Subject:Date:From;
	b=sve4936Sx264GlbGNSq9EZFYdRvzQPj4W6T/7LSpLbusRUgEL4nB/YQZm9H/OIih5
	 tQbWtluhltlhzA8WceaJtq+/B+LAn+juFiJPK941j99VQziWzwsLvUojsW66dg/Mv4
	 hQKrsIivtWq40voO/se3UC+HXS/k9FEUcUZ6H30I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.58
Date: Thu, 13 Nov 2025 16:02:34 -0500
Message-ID: <2025111334-liability-brush-8c0e@gregkh>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.58 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/netlink/specs/dpll.yaml                                          |    2 
 Makefile                                                                       |    2 
 arch/arc/include/asm/bitops.h                                                  |    2 
 arch/arm/boot/dts/nvidia/tegra20-asus-tf101.dts                                |    5 
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts                                   |    4 
 arch/arm/mach-at91/pm_suspend.S                                                |    8 
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts                              |    4 
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi                                         |    4 
 arch/loongarch/include/asm/inst.h                                              |    5 
 arch/loongarch/kernel/inst.c                                                   |   12 
 arch/mips/boot/dts/lantiq/danube.dtsi                                          |    6 
 arch/mips/boot/dts/lantiq/danube_easy50712.dts                                 |    4 
 arch/mips/lantiq/xway/sysctrl.c                                                |    2 
 arch/mips/sgi-ip22/ip22-platform.c                                             |   32 
 arch/openrisc/kernel/module.c                                                  |    4 
 arch/parisc/include/asm/video.h                                                |    2 
 arch/parisc/kernel/unwind.c                                                    |   13 
 arch/powerpc/kernel/eeh_driver.c                                               |    2 
 arch/riscv/kernel/stacktrace.c                                                 |   21 
 arch/riscv/mm/ptdump.c                                                         |    2 
 arch/riscv/net/bpf_jit_comp64.c                                                |    5 
 arch/s390/Kconfig                                                              |    1 
 arch/s390/include/asm/pci.h                                                    |    1 
 arch/s390/mm/dump_pagetables.c                                                 |   19 
 arch/s390/pci/pci_event.c                                                      |    7 
 arch/s390/pci/pci_irq.c                                                        |    9 
 arch/sparc/include/asm/elf_64.h                                                |    1 
 arch/sparc/include/asm/io_64.h                                                 |    6 
 arch/sparc/include/asm/video.h                                                 |    2 
 arch/sparc/kernel/module.c                                                     |    1 
 arch/um/drivers/ssl.c                                                          |    5 
 arch/x86/entry/vsyscall/vsyscall_64.c                                          |   17 
 arch/x86/events/intel/ds.c                                                     |    3 
 arch/x86/include/asm/runtime-const.h                                           |   17 
 arch/x86/include/asm/uaccess_64.h                                              |   22 
 arch/x86/include/asm/video.h                                                   |    2 
 arch/x86/kernel/cpu/amd.c                                                      |   35 
 arch/x86/kernel/cpu/common.c                                                   |    6 
 arch/x86/kernel/cpu/microcode/amd.c                                            |    2 
 arch/x86/kernel/fpu/core.c                                                     |    3 
 arch/x86/kernel/kvm.c                                                          |   20 
 arch/x86/lib/getuser.S                                                         |   12 
 arch/x86/net/bpf_jit_comp.c                                                    |   13 
 block/blk-cgroup.c                                                             |   23 
 drivers/accel/habanalabs/common/memory.c                                       |    2 
 drivers/accel/habanalabs/gaudi/gaudi.c                                         |   19 
 drivers/accel/habanalabs/gaudi2/gaudi2.c                                       |   15 
 drivers/accel/habanalabs/gaudi2/gaudi2_coresight.c                             |    2 
 drivers/acpi/acpi_video.c                                                      |    4 
 drivers/acpi/acpica/dsmethod.c                                                 |   10 
 drivers/acpi/button.c                                                          |    4 
 drivers/acpi/device_sysfs.c                                                    |    2 
 drivers/acpi/fan.h                                                             |    8 
 drivers/acpi/fan_attr.c                                                        |   39 
 drivers/acpi/fan_core.c                                                        |   61 -
 drivers/acpi/fan_hwmon.c                                                       |   19 
 drivers/acpi/prmt.c                                                            |   19 
 drivers/acpi/property.c                                                        |   24 
 drivers/acpi/resource.c                                                        |    7 
 drivers/acpi/scan.c                                                            |    4 
 drivers/acpi/spcr.c                                                            |   10 
 drivers/acpi/video_detect.c                                                    |    8 
 drivers/base/regmap/regmap-slimbus.c                                           |    6 
 drivers/bluetooth/btmtksdio.c                                                  |   12 
 drivers/bluetooth/btrtl.c                                                      |    4 
 drivers/bluetooth/btusb.c                                                      |   19 
 drivers/bluetooth/hci_bcsp.c                                                   |    3 
 drivers/bus/mhi/host/internal.h                                                |    2 
 drivers/bus/mhi/host/pm.c                                                      |    2 
 drivers/char/misc.c                                                            |   40 
 drivers/clk/at91/clk-master.c                                                  |    3 
 drivers/clk/at91/clk-sam9x60-pll.c                                             |   75 -
 drivers/clk/at91/sam9x7.c                                                      |    1 
 drivers/clk/clk-scmi.c                                                         |   11 
 drivers/clk/qcom/gcc-ipq6018.c                                                 |   60 -
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c                                           |   11 
 drivers/clk/ti/clk-33xx.c                                                      |    2 
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                     |    2 
 drivers/clocksource/timer-rtl-otto.c                                           |   26 
 drivers/clocksource/timer-vf-pit.c                                             |   22 
 drivers/cpufreq/cpufreq_ondemand.c                                             |   25 
 drivers/cpufreq/cpufreq_ondemand.h                                             |   23 
 drivers/cpufreq/longhaul.c                                                     |    3 
 drivers/cpufreq/tegra186-cpufreq.c                                             |   27 
 drivers/cpufreq/ti-cpufreq.c                                                   |    2 
 drivers/cpuidle/cpuidle.c                                                      |    8 
 drivers/cpuidle/governors/menu.c                                               |   73 -
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c                            |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c                              |    5 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c                              |    2 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c                              |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c                              |    1 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h                                   |    2 
 drivers/crypto/aspeed/aspeed-acry.c                                            |    2 
 drivers/crypto/caam/ctrl.c                                                     |    4 
 drivers/crypto/ccp/hsti.c                                                      |    2 
 drivers/crypto/ccp/sev-dev.c                                                   |   10 
 drivers/crypto/hisilicon/qm.c                                                  |   78 +
 drivers/crypto/intel/qat/qat_common/qat_uclo.c                                 |    2 
 drivers/dma/dw-edma/dw-edma-core.c                                             |   22 
 drivers/dma/mv_xor.c                                                           |    4 
 drivers/dma/sh/shdma-base.c                                                    |   25 
 drivers/dma/sh/shdmac.c                                                        |   17 
 drivers/extcon/extcon-adc-jack.c                                               |    2 
 drivers/firewire/ohci.c                                                        |   12 
 drivers/firmware/qcom/qcom_scm.c                                               |    2 
 drivers/firmware/qcom/qcom_tzmem.c                                             |    1 
 drivers/gpio/gpiolib-swnode.c                                                  |    2 
 drivers/gpio/gpiolib.c                                                         |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c                                        |   53 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                               |   15 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c                                 |   66 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                                         |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                                  |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                        |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c                                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                        |   75 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h                                        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c                                        |   34 
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c                                        |    1 
 drivers/gpu/drm/amd/amdgpu/atom.c                                              |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                          |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                                        |   11 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                                        |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c                                        |   10 
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c                                        |   13 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                       |   19 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                        |   10 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                                          |    9 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                           |   25 
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c                                    |   56 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h                                    |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                              |  100 ++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                              |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c                        |   86 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                         |   10 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c                      |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                    |   13 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h                    |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c                     |   16 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c                 |  142 +++
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h                 |    5 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                       |   25 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                              |   14 
 drivers/gpu/drm/amd/display/dc/dc_helper.c                                     |    5 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                                     |    3 
 drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c                       |    2 
 drivers/gpu/drm/amd/display/dc/dm_services.h                                   |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c                         |   20 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c                        |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c                      |    4 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |   28 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                      |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                        |   73 -
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                        |    5 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c                      |    2 
 drivers/gpu/drm/amd/display/dc/link/link_detection.c                           |    5 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                                |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c               |    9 
 drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c                       |    5 
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c               |    1 
 drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c                |    7 
 drivers/gpu/drm/amd/display/include/dal_asic_id.h                              |    5 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c                          |    2 
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c                       |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                                      |    6 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                              |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c                               |    3 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                                         |    2 
 drivers/gpu/drm/ast/ast_drv.h                                                  |    8 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                                 |   12 
 drivers/gpu/drm/bridge/display-connector.c                                     |    3 
 drivers/gpu/drm/drm_gem_atomic_helper.c                                        |    8 
 drivers/gpu/drm/drm_panel_backlight_quirks.c                                   |    2 
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c                                       |    2 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                                         |   10 
 drivers/gpu/drm/mediatek/mtk_plane.c                                           |   24 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                          |    5 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                          |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c                                      |   10 
 drivers/gpu/drm/msm/registers/gen_header.py                                    |    7 
 drivers/gpu/drm/nouveau/nouveau_sched.c                                        |   14 
 drivers/gpu/drm/nouveau/nvkm/core/enum.c                                       |    2 
 drivers/gpu/drm/panthor/panthor_gpu.c                                          |    7 
 drivers/gpu/drm/panthor/panthor_mmu.c                                          |    4 
 drivers/gpu/drm/radeon/radeon_drv.c                                            |   25 
 drivers/gpu/drm/radeon/radeon_kms.c                                            |    1 
 drivers/gpu/drm/scheduler/sched_entity.c                                       |   73 -
 drivers/gpu/drm/scheduler/sched_main.c                                         |    6 
 drivers/gpu/drm/tidss/tidss_crtc.c                                             |    7 
 drivers/gpu/drm/tidss/tidss_dispc.c                                            |   16 
 drivers/gpu/drm/xe/abi/guc_errors_abi.h                                        |    3 
 drivers/gpu/drm/xe/xe_bo.c                                                     |   28 
 drivers/gpu/drm/xe/xe_gt.c                                                     |   19 
 drivers/gpu/drm/xe/xe_guc.c                                                    |   32 
 drivers/gpu/drm/xe/xe_guc_ct.c                                                 |   10 
 drivers/gpu/drm/xe/xe_guc_log.h                                                |    2 
 drivers/hid/hid-asus.c                                                         |    6 
 drivers/hid/hid-ids.h                                                          |    2 
 drivers/hid/hid-universal-pidff.c                                              |   20 
 drivers/hid/i2c-hid/i2c-hid-acpi.c                                             |    8 
 drivers/hid/i2c-hid/i2c-hid-core.c                                             |   28 
 drivers/hid/i2c-hid/i2c-hid.h                                                  |    2 
 drivers/hid/usbhid/hid-pidff.c                                                 |   42 
 drivers/hid/usbhid/hid-pidff.h                                                 |    2 
 drivers/hwmon/asus-ec-sensors.c                                                |    2 
 drivers/hwmon/dell-smm-hwmon.c                                                 |   14 
 drivers/hwmon/k10temp.c                                                        |   10 
 drivers/hwmon/lenovo-ec-sensors.c                                              |   34 
 drivers/hwmon/sbtsi_temp.c                                                     |   46 -
 drivers/hwmon/sy7636a-hwmon.c                                                  |    1 
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c                             |    3 
 drivers/iio/adc/imx93_adc.c                                                    |   18 
 drivers/iio/adc/spear_adc.c                                                    |    9 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                        |   58 +
 drivers/infiniband/hw/hns/hns_roce_device.h                                    |    4 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                     |   11 
 drivers/infiniband/hw/hns/hns_roce_main.c                                      |    4 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                        |    2 
 drivers/infiniband/hw/irdma/Kconfig                                            |    7 
 drivers/infiniband/hw/irdma/pble.c                                             |    2 
 drivers/infiniband/hw/irdma/verbs.c                                            |    4 
 drivers/infiniband/hw/irdma/verbs.h                                            |    8 
 drivers/infiniband/ulp/ipoib/ipoib_main.c                                      |   21 
 drivers/iommu/amd/init.c                                                       |   28 
 drivers/iommu/apple-dart.c                                                     |    5 
 drivers/iommu/intel/debugfs.c                                                  |   10 
 drivers/iommu/intel/perf.c                                                     |   10 
 drivers/iommu/intel/perf.h                                                     |    5 
 drivers/iommu/iommufd/iova_bitmap.c                                            |    5 
 drivers/irqchip/irq-gic-v2m.c                                                  |   13 
 drivers/irqchip/irq-loongson-pch-lpc.c                                         |    9 
 drivers/irqchip/irq-sifive-plic.c                                              |    6 
 drivers/md/dm-target.c                                                         |    3 
 drivers/media/common/videobuf2/videobuf2-v4l2.c                                |    5 
 drivers/media/i2c/Kconfig                                                      |    2 
 drivers/media/i2c/adv7180.c                                                    |   48 -
 drivers/media/i2c/ir-kbd-i2c.c                                                 |    6 
 drivers/media/i2c/og01a1b.c                                                    |    6 
 drivers/media/i2c/ov08x40.c                                                    |    2 
 drivers/media/pci/intel/ipu6/ipu6-isys-subdev.c                                |    6 
 drivers/media/pci/ivtv/ivtv-alsa-pcm.c                                         |    2 
 drivers/media/pci/ivtv/ivtv-driver.h                                           |    3 
 drivers/media/pci/ivtv/ivtv-fileops.c                                          |   18 
 drivers/media/pci/ivtv/ivtv-irq.c                                              |    4 
 drivers/media/pci/mgb4/mgb4_vin.c                                              |    3 
 drivers/media/platform/amphion/vpu_v4l2.c                                      |    7 
 drivers/media/platform/verisilicon/hantro_drv.c                                |    2 
 drivers/media/platform/verisilicon/hantro_v4l2.c                               |    6 
 drivers/media/rc/imon.c                                                        |   61 -
 drivers/media/rc/redrat3.c                                                     |    2 
 drivers/media/tuners/xc4000.c                                                  |    8 
 drivers/media/tuners/xc5000.c                                                  |   12 
 drivers/media/usb/uvc/uvc_driver.c                                             |   15 
 drivers/memstick/core/memstick.c                                               |    8 
 drivers/mfd/da9063-i2c.c                                                       |   27 
 drivers/mfd/intel-lpss-pci.c                                                   |   13 
 drivers/mfd/kempld-core.c                                                      |   32 
 drivers/mfd/madera-core.c                                                      |    4 
 drivers/mfd/mfd-core.c                                                         |    1 
 drivers/mfd/stmpe-i2c.c                                                        |    1 
 drivers/mfd/stmpe.c                                                            |    3 
 drivers/mmc/host/renesas_sdhi_core.c                                           |    6 
 drivers/mmc/host/sdhci-msm.c                                                   |   15 
 drivers/net/dsa/b53/b53_common.c                                               |   27 
 drivers/net/dsa/b53/b53_regs.h                                                 |    3 
 drivers/net/dsa/dsa_loop.c                                                     |    9 
 drivers/net/dsa/microchip/ksz9477.c                                            |   98 +-
 drivers/net/dsa/microchip/ksz9477_reg.h                                        |    3 
 drivers/net/dsa/microchip/ksz_common.c                                         |   49 +
 drivers/net/dsa/microchip/ksz_common.h                                         |    2 
 drivers/net/dsa/ocelot/felix.c                                                 |    4 
 drivers/net/dsa/ocelot/felix.h                                                 |    3 
 drivers/net/dsa/ocelot/felix_vsc9959.c                                         |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                      |   75 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                                      |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c                              |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                                  |    4 
 drivers/net/ethernet/cadence/macb_main.c                                       |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                        |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c                        |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h                        |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_common.c                                |    5 
 drivers/net/ethernet/intel/fm10k/fm10k_common.h                                |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                                    |    2 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                                    |    2 
 drivers/net/ethernet/intel/ice/ice_main.c                                      |    2 
 drivers/net/ethernet/intel/ice/ice_trace.h                                     |   10 
 drivers/net/ethernet/intel/idpf/idpf.h                                         |    2 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                                     |  102 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                                    |  129 --
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c                           |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                                |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                             |   12 
 drivers/net/ethernet/microchip/lan865x/lan865x.c                               |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_ethtool.c                       |   18 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c                          |    2 
 drivers/net/ethernet/microchip/lan966x/lan966x_main.h                          |    4 
 drivers/net/ethernet/microchip/lan966x/lan966x_vcap_impl.c                     |    8 
 drivers/net/ethernet/microchip/sparx5/Kconfig                                  |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                               |   34 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c                            |    1 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c                               |    2 
 drivers/net/ethernet/realtek/Kconfig                                           |    2 
 drivers/net/ethernet/realtek/r8169_main.c                                      |    6 
 drivers/net/ethernet/renesas/sh_eth.c                                          |    4 
 drivers/net/ethernet/sfc/mae.c                                                 |    4 
 drivers/net/ethernet/smsc/smsc911x.c                                           |   14 
 drivers/net/ethernet/stmicro/stmmac/common.h                                   |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c                               |    9 
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h                               |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |   12 
 drivers/net/ethernet/ti/icssg/icssg_config.c                                   |    7 
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c                                |    7 
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                                     |    3 
 drivers/net/ethernet/wangxun/libwx/wx_type.h                                   |    4 
 drivers/net/hamradio/6pack.c                                                   |   57 -
 drivers/net/mdio/of_mdio.c                                                     |    1 
 drivers/net/phy/fixed_phy.c                                                    |    1 
 drivers/net/phy/marvell.c                                                      |   39 
 drivers/net/phy/phy.c                                                          |   13 
 drivers/net/usb/asix_devices.c                                                 |   12 
 drivers/net/usb/qmi_wwan.c                                                     |    6 
 drivers/net/usb/usbnet.c                                                       |    2 
 drivers/net/virtio_net.c                                                       |   36 
 drivers/net/wan/framer/pef2256/pef2256.c                                       |    7 
 drivers/net/wireless/ath/ath10k/mac.c                                          |   12 
 drivers/net/wireless/ath/ath10k/wmi.c                                          |   40 
 drivers/net/wireless/ath/ath11k/core.c                                         |   54 +
 drivers/net/wireless/ath/ath11k/core.h                                         |    3 
 drivers/net/wireless/ath/ath11k/mac.c                                          |   61 +
 drivers/net/wireless/ath/ath11k/wmi.c                                          |   11 
 drivers/net/wireless/ath/ath11k/wmi.h                                          |   10 
 drivers/net/wireless/ath/ath12k/dp.h                                           |    2 
 drivers/net/wireless/ath/ath12k/mac.c                                          |   34 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c                    |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c                         |   28 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h                         |    3 
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c                             |   14 
 drivers/net/wireless/mediatek/mt76/eeprom.c                                    |    9 
 drivers/net/wireless/mediatek/mt76/mt76.h                                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c                             |    3 
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c                             |    4 
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c                             |    6 
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c                             |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                             |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                               |    2 
 drivers/net/wireless/mediatek/mt76/mt7925/init.c                               |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c                             |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                               |    5 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                                |    4 
 drivers/net/wireless/realtek/rtw88/sdio.c                                      |    4 
 drivers/net/wireless/realtek/rtw89/core.c                                      |   59 +
 drivers/net/wireless/realtek/rtw89/core.h                                      |   10 
 drivers/net/wireless/realtek/rtw89/debug.h                                     |    1 
 drivers/net/wireless/realtek/rtw89/fw.c                                        |    4 
 drivers/net/wireless/realtek/rtw89/mac.c                                       |    7 
 drivers/net/wireless/realtek/rtw89/phy.c                                       |    7 
 drivers/net/wireless/realtek/rtw89/txrx.h                                      |    1 
 drivers/net/wireless/virtual/mac80211_hwsim.c                                  |    7 
 drivers/net/wwan/t7xx/t7xx_pci.c                                               |    1 
 drivers/ntb/hw/epf/ntb_hw_epf.c                                                |  103 +-
 drivers/nvme/host/core.c                                                       |    8 
 drivers/nvme/host/fc.c                                                         |   10 
 drivers/nvme/target/fc.c                                                       |   16 
 drivers/pci/controller/cadence/pcie-cadence-host.c                             |    2 
 drivers/pci/controller/cadence/pcie-cadence.c                                  |    4 
 drivers/pci/controller/cadence/pcie-cadence.h                                  |    6 
 drivers/pci/controller/dwc/pci-imx6.c                                          |    4 
 drivers/pci/controller/dwc/pcie-designware.c                                   |    4 
 drivers/pci/endpoint/functions/pci-epf-test.c                                  |    7 
 drivers/pci/p2pdma.c                                                           |    2 
 drivers/pci/pci-driver.c                                                       |    2 
 drivers/pci/pci.c                                                              |    5 
 drivers/pci/pcie/err.c                                                         |    3 
 drivers/pci/quirks.c                                                           |    3 
 drivers/phy/cadence/cdns-dphy.c                                                |    4 
 drivers/phy/renesas/r8a779f0-ether-serdes.c                                    |   28 
 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c                               |    5 
 drivers/pinctrl/pinctrl-keembay.c                                              |    7 
 drivers/pinctrl/pinctrl-single.c                                               |    4 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c            |    2 
 drivers/pmdomain/apple/pmgr-pwrstate.c                                         |    1 
 drivers/power/supply/qcom_battmgr.c                                            |    8 
 drivers/power/supply/sbs-charger.c                                             |   16 
 drivers/ptp/ptp_clock.c                                                        |   13 
 drivers/pwm/pwm-pca9685.c                                                      |   46 -
 drivers/remoteproc/qcom_q6v5.c                                                 |    5 
 drivers/remoteproc/wkup_m3_rproc.c                                             |    6 
 drivers/rpmsg/rpmsg_char.c                                                     |    3 
 drivers/rtc/rtc-pcf2127.c                                                      |   19 
 drivers/rtc/rtc-rx8025.c                                                       |    2 
 drivers/scsi/libfc/fc_encode.h                                                 |    2 
 drivers/scsi/lpfc/lpfc_debugfs.h                                               |    3 
 drivers/scsi/lpfc/lpfc_els.c                                                   |   21 
 drivers/scsi/lpfc/lpfc_init.c                                                  |    7 
 drivers/scsi/lpfc/lpfc_nportdisc.c                                             |   23 
 drivers/scsi/lpfc/lpfc_scsi.c                                                  |   14 
 drivers/scsi/lpfc/lpfc_sli.c                                                   |    3 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                                |   13 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                                |    2 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                                       |    3 
 drivers/scsi/pm8001/pm8001_ctl.c                                               |   24 
 drivers/scsi/pm8001/pm8001_init.c                                              |    1 
 drivers/scsi/pm8001/pm8001_sas.h                                               |    4 
 drivers/scsi/qla2xxx/qla_os.c                                                  |    5 
 drivers/soc/aspeed/aspeed-socinfo.c                                            |    4 
 drivers/soc/qcom/smem.c                                                        |    2 
 drivers/soc/tegra/fuse/fuse-tegra30.c                                          |  122 ++
 drivers/soc/ti/pruss.c                                                         |    2 
 drivers/spi/spi-loopback-test.c                                                |   12 
 drivers/spi/spi-rpc-if.c                                                       |    2 
 drivers/tee/tee_core.c                                                         |    2 
 drivers/thermal/gov_step_wise.c                                                |   15 
 drivers/thunderbolt/tb.c                                                       |    2 
 drivers/tty/serial/ip22zilog.c                                                 |  352 +++-----
 drivers/tty/serial/max3100.c                                                   |    2 
 drivers/tty/serial/max310x.c                                                   |    3 
 drivers/tty/vt/vt_ioctl.c                                                      |    4 
 drivers/ufs/core/ufshcd.c                                                      |   16 
 drivers/ufs/host/ufs-exynos.c                                                  |    8 
 drivers/ufs/host/ufs-mediatek.c                                                |  222 ++++-
 drivers/ufs/host/ufshcd-pci.c                                                  |   70 +
 drivers/usb/cdns3/cdnsp-gadget.c                                               |    8 
 drivers/usb/gadget/function/f_fs.c                                             |    8 
 drivers/usb/gadget/function/f_hid.c                                            |    4 
 drivers/usb/gadget/function/f_ncm.c                                            |    3 
 drivers/usb/host/xhci-pci.c                                                    |   43 
 drivers/usb/host/xhci-plat.c                                                   |    1 
 drivers/usb/mon/mon_bin.c                                                      |   14 
 drivers/vfio/pci/vfio_pci_intrs.c                                              |    7 
 drivers/vfio/vfio_main.c                                                       |    2 
 drivers/video/backlight/lp855x_bl.c                                            |    2 
 drivers/video/fbdev/aty/atyfb_base.c                                           |    8 
 drivers/video/fbdev/core/bitblit.c                                             |   33 
 drivers/video/fbdev/core/fbcon.c                                               |   19 
 drivers/video/fbdev/core/fbmem.c                                               |    1 
 drivers/video/fbdev/pvr2fb.c                                                   |    2 
 drivers/video/fbdev/valkyriefb.c                                               |    2 
 drivers/watchdog/s3c2410_wdt.c                                                 |   10 
 fs/9p/v9fs.c                                                                   |    9 
 fs/btrfs/extent_io.c                                                           |    8 
 fs/btrfs/file.c                                                                |   10 
 fs/btrfs/qgroup.c                                                              |    4 
 fs/ceph/dir.c                                                                  |    3 
 fs/ceph/file.c                                                                 |    6 
 fs/ceph/ioctl.c                                                                |   17 
 fs/ceph/locks.c                                                                |    5 
 fs/ceph/mds_client.c                                                           |    8 
 fs/ceph/mdsmap.c                                                               |   14 
 fs/ceph/super.c                                                                |   14 
 fs/ceph/super.h                                                                |   14 
 fs/exfat/balloc.c                                                              |   72 +
 fs/exfat/fatent.c                                                              |   11 
 fs/ext4/fast_commit.c                                                          |    2 
 fs/ext4/xattr.c                                                                |    2 
 fs/f2fs/extent_cache.c                                                         |    6 
 fs/f2fs/node.c                                                                 |   17 
 fs/f2fs/sysfs.c                                                                |    9 
 fs/fuse/inode.c                                                                |   11 
 fs/hpfs/namei.c                                                                |   18 
 fs/jfs/inode.c                                                                 |    8 
 fs/jfs/jfs_txnmgr.c                                                            |    9 
 fs/nfs/nfs4proc.c                                                              |    6 
 fs/nfs/nfs4state.c                                                             |    3 
 fs/nfsd/nfs4proc.c                                                             |    7 
 fs/ntfs3/inode.c                                                               |    1 
 fs/open.c                                                                      |   10 
 fs/orangefs/xattr.c                                                            |   12 
 fs/smb/client/cached_dir.c                                                     |   16 
 fs/smb/client/smb2ops.c                                                        |    3 
 fs/smb/client/smb2pdu.c                                                        |    7 
 fs/smb/client/transport.c                                                      |   10 
 fs/smb/server/transport_tcp.c                                                  |    7 
 include/drm/gpu_scheduler.h                                                    |   23 
 include/linux/blk_types.h                                                      |   11 
 include/linux/bpf_verifier.h                                                   |    7 
 include/linux/cgroup.h                                                         |    1 
 include/linux/f2fs_fs.h                                                        |    1 
 include/linux/fbcon.h                                                          |    2 
 include/linux/filter.h                                                         |    3 
 include/linux/pci.h                                                            |    2 
 include/linux/shdma-base.h                                                     |    2 
 include/linux/tnum.h                                                           |    3 
 include/net/bluetooth/hci.h                                                    |    1 
 include/net/bluetooth/hci_core.h                                               |   13 
 include/net/bluetooth/mgmt.h                                                   |    2 
 include/net/cls_cgroup.h                                                       |    2 
 include/net/nfc/nci_core.h                                                     |    2 
 include/net/xdp.h                                                              |    5 
 include/ufs/ufs_quirks.h                                                       |    3 
 include/ufs/ufshcd.h                                                           |    8 
 include/ufs/ufshci.h                                                           |    4 
 io_uring/notif.c                                                               |    5 
 kernel/bpf/core.c                                                              |    5 
 kernel/bpf/helpers.c                                                           |    2 
 kernel/bpf/ringbuf.c                                                           |    2 
 kernel/bpf/tnum.c                                                              |    8 
 kernel/bpf/verifier.c                                                          |  100 ++
 kernel/cgroup/cgroup.c                                                         |   24 
 kernel/events/uprobes.c                                                        |    7 
 kernel/futex/syscalls.c                                                        |  106 +-
 kernel/sched/ext.c                                                             |    8 
 kernel/trace/ftrace.c                                                          |    2 
 kernel/trace/ring_buffer.c                                                     |    4 
 kernel/trace/trace_events_hist.c                                               |    6 
 lib/crypto/Makefile                                                            |    2 
 lib/kunit/kunit-test.c                                                         |    2 
 net/8021q/vlan.c                                                               |    2 
 net/9p/trans_fd.c                                                              |    9 
 net/bluetooth/hci_event.c                                                      |   19 
 net/bluetooth/hci_sync.c                                                       |   21 
 net/bluetooth/iso.c                                                            |   11 
 net/bluetooth/mgmt.c                                                           |    6 
 net/bluetooth/rfcomm/tty.c                                                     |   26 
 net/bluetooth/sco.c                                                            |    7 
 net/bridge/br.c                                                                |    5 
 net/bridge/br_forward.c                                                        |    5 
 net/bridge/br_if.c                                                             |    1 
 net/bridge/br_input.c                                                          |    4 
 net/bridge/br_mst.c                                                            |   10 
 net/bridge/br_private.h                                                        |   13 
 net/core/filter.c                                                              |    1 
 net/core/page_pool.c                                                           |   12 
 net/core/sock.c                                                                |   15 
 net/dsa/tag_brcm.c                                                             |   70 -
 net/ethernet/eth.c                                                             |    5 
 net/ipv4/inet_diag.c                                                           |   14 
 net/ipv4/ip_input.c                                                            |   11 
 net/ipv4/netfilter/nf_reject_ipv4.c                                            |   25 
 net/ipv4/nexthop.c                                                             |    6 
 net/ipv4/route.c                                                               |    2 
 net/ipv4/tcp.c                                                                 |    4 
 net/ipv4/tcp_fastopen.c                                                        |    7 
 net/ipv4/udp_tunnel_nic.c                                                      |    2 
 net/ipv6/addrconf.c                                                            |    4 
 net/ipv6/ah6.c                                                                 |   50 -
 net/ipv6/netfilter/nf_reject_ipv6.c                                            |   30 
 net/ipv6/raw.c                                                                 |    2 
 net/ipv6/udp.c                                                                 |    2 
 net/mac80211/cfg.c                                                             |   20 
 net/mac80211/ieee80211_i.h                                                     |    2 
 net/mac80211/iface.c                                                           |    9 
 net/mac80211/key.c                                                             |   10 
 net/mac80211/mesh.c                                                            |    3 
 net/mac80211/mlme.c                                                            |    5 
 net/mptcp/protocol.c                                                           |   18 
 net/mptcp/protocol.h                                                           |    2 
 net/rds/rds.h                                                                  |    2 
 net/sctp/diag.c                                                                |   21 
 security/integrity/ima/ima_appraise.c                                          |   23 
 sound/drivers/serial-generic.c                                                 |   12 
 sound/pci/hda/patch_realtek.c                                                  |   17 
 sound/soc/codecs/cs-amp-lib-test.c                                             |    1 
 sound/soc/codecs/tlv320aic3x.c                                                 |   32 
 sound/soc/fsl/fsl_sai.c                                                        |   11 
 sound/soc/intel/avs/pcm.c                                                      |    3 
 sound/soc/mediatek/mt8173/mt8173-rt5650.c                                      |    2 
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c                             |    2 
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c                     |    2 
 sound/soc/mediatek/mt8186/mt8186-mt6366.c                                      |    2 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                      |    8 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                        |    2 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                                      |    4 
 sound/soc/meson/aiu-encoder-i2s.c                                              |    9 
 sound/soc/qcom/qdsp6/q6asm.c                                                   |    2 
 sound/soc/qcom/sc8280xp.c                                                      |    3 
 sound/soc/sof/ipc4-pcm.c                                                       |   56 +
 sound/soc/stm/stm32_sai_sub.c                                                  |    8 
 sound/usb/mixer.c                                                              |    7 
 sound/usb/mixer_s1810c.c                                                       |   28 
 sound/usb/validate.c                                                           |    9 
 tools/bpf/bpftool/btf_dumper.c                                                 |    2 
 tools/bpf/bpftool/prog.c                                                       |    2 
 tools/include/linux/bitmap.h                                                   |    1 
 tools/lib/bpf/bpf_tracing.h                                                    |    2 
 tools/lib/bpf/usdt.bpf.h                                                       |   44 -
 tools/lib/bpf/usdt.c                                                           |   62 +
 tools/lib/thermal/Makefile                                                     |    9 
 tools/net/ynl/lib/ynl-priv.h                                                   |    4 
 tools/power/cpupower/lib/cpuidle.c                                             |    5 
 tools/power/cpupower/lib/cpupower.c                                            |    2 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c                |   30 
 tools/testing/selftests/Makefile                                               |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c                            |    3 
 tools/testing/selftests/bpf/progs/verifier_arena_large.c                       |    1 
 tools/testing/selftests/bpf/test_lirc_mode2_user.c                             |    2 
 tools/testing/selftests/bpf/test_xsk.sh                                        |    2 
 tools/testing/selftests/drivers/net/hw/rss_ctx.py                              |   11 
 tools/testing/selftests/drivers/net/netdevsim/Makefile                         |    4 
 tools/testing/selftests/net/fcnal-test.sh                                      |  432 +++++-----
 tools/testing/selftests/net/forwarding/custom_multipath_hash.sh                |    2 
 tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh            |    2 
 tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh              |    6 
 tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh         |    2 
 tools/testing/selftests/net/forwarding/lib.sh                                  |    8 
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh             |    2 
 tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh            |    4 
 tools/testing/selftests/net/gro.c                                              |   12 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                                |    6 
 tools/testing/selftests/net/psock_tpacket.c                                    |    4 
 tools/testing/selftests/net/traceroute.sh                                      |   51 -
 tools/testing/selftests/thermal/intel/workload_hint/workload_hint_test.c       |    2 
 usr/include/headers_check.pl                                                   |    2 
 612 files changed, 5854 insertions(+), 2705 deletions(-)

Aaron Kling (1):
      cpufreq: tegra186: Initialize all cores to max frequencies

Abdun Nihaal (2):
      sfc: fix potential memory leak in efx_mae_process_mport()
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()

Adrian Hunter (3):
      scsi: ufs: ufs-pci: Fix S0ix/S3 for Intel controllers
      scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL
      scsi: ufs: core: Add a quirk to suppress link_startup_again

Akhil P Oommen (1):
      drm/msm/a6xx: Fix GMU firmware parser

Al Viro (3):
      allow finish_no_open(file, ERR_PTR(-E...))
      sparc64: fix prototypes of reads[bwl]()
      nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing

Albin Babu Varghese (1):
      fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds

Aleksander Jan Bajkowski (5):
      mips: lantiq: danube: add missing properties to cpu node
      mips: lantiq: danube: add model to EASY50712 dts
      mips: lantiq: danube: add missing device_type in pci node
      mips: lantiq: xway: sysctrl: rename stp clock
      mips: lantiq: danube: rename stp node on EASY50712 reference board

Alex Deucher (5):
      drm/amd/display: add more cyan skillfish devices
      drm/amd: add more cyan skillfish PCI ids
      drm/amdgpu: don't enable SMU on cyan skillfish
      drm/amdgpu: add support for cyan skillfish gpu_info
      drm/amdgpu/smu: Handle S0ix for vangogh

Alex Hung (1):
      drm/amd/display: Fix black screen with HDMI outputs

Alex Mastro (1):
      vfio: return -ENOTTY for unsupported device feature

Alexander Stein (2):
      mfd: stmpe: Remove IRQ domain upon removal
      mfd: stmpe-i2c: Add missing MODULE_LICENSE

Alexey Klimov (2):
      regmap: slimbus: fix bus_context pointer in regmap init calls
      ASoC: qcom: sc8280xp: explicitly set S16LE format in sc8280xp_be_hw_params_fixup()

Alice Chao (2):
      scsi: ufs: host: mediatek: Assign power mode userdata before FASTAUTO mode change
      scsi: ufs: host: mediatek: Fix invalid access in vccqx handling

Alistair Francis (1):
      nvme: Use non zero KATO for persistent discovery connections

Alok Tiwari (2):
      udp_tunnel: use netdev_warn() instead of netdev_WARN()
      scsi: libfc: Fix potential buffer overflow in fc_ct_ms_fill()

Amber Lin (1):
      drm/amdkfd: Tie UNMAP_LATENCY to queue_preemption

Amery Hung (1):
      bpf: Clear pfmemalloc flag when freeing all fragments

Amirreza Zarrabi (1):
      tee: allow a driver to allocate a tee_device without a pool

Andreas Kemnade (1):
      hwmon: sy7636a: add alias

Andrew Davis (2):
      rpmsg: char: Export alias for RPMSG ID rpmsg-raw from table
      remoteproc: wkup_m3: Use devm_pm_runtime_enable() helper

Andrii Nakryiko (1):
      libbpf: Fix powerpc's stack register definition in bpf_tracing.h

Antheas Kapenekakis (2):
      drm: panel-backlight-quirks: Make EDID match optional
      HID: asus: add Z13 folio to generic group for multitouch to work

Anthony Iliopoulos (1):
      NFSv4.1: fix mount hang after CREATE_SESSION failure

Antonino Maniscalco (1):
      drm/msm: make sure to not queue up recovery more than once

Anubhav Singh (2):
      selftests/net: fix out-of-order delivery of FIN in gro:tcp test
      selftests/net: use destination options instead of hop-by-hop

Ariel D'Alessandro (1):
      drm/mediatek: Disable AFBC support on Mediatek DRM driver

Arkadiusz Bokowy (1):
      Bluetooth: btusb: Check for unexpected bytes when defragmenting HCI frames

Armin Wolf (3):
      ACPI: fan: Use ACPI handle when retrieving _FST
      ACPI: fan: Use platform device for devres-related actions
      hwmon: (dell-smm) Remove Dell Precision 490 custom config data

Arnd Bergmann (1):
      mfd: madera: Work around false-positive -Wininitialized warning

Ashish Kalra (2):
      iommu/amd: Skip enabling command/event buffers for kdump
      crypto: ccp: Skip SEV and SNP INIT for kdump boot

Aurabindo Pillai (1):
      drm/amd/display: fix condition for setting timing_adjust_pending

Ausef Yousof (1):
      drm/amd/display: fix dml ms order of operations

Avadhut Naik (1):
      hwmon: (k10temp) Add thermal support for AMD Family 1Ah-based models

Balamanikandan Gunasundar (1):
      clk: at91: sam9x7: Add peripheral clock id for pmecc

Baochen Qiang (1):
      Revert "wifi: ath10k: avoid unnecessary wait for service ready message"

Bart Van Assche (1):
      scsi: ufs: core: Disable timestamp functionality if not supported

Bartosz Golaszewski (3):
      pinctrl: keembay: release allocated memory in detach path
      gpio: swnode: don't use the swnode's name as the key for GPIO lookup
      gpiolib: fix invalid pointer access in debugfs

Bastien Curutchet (2):
      mfd: core: Increment of_node's refcount before linking it to the platform device
      net: dsa: microchip: Set SPI as bus interface during reset for KSZ8463

Ben Copeland (1):
      hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex

Benjamin Lin (1):
      wifi: mt76: mt7996: Temporarily disable EPCS

Bharat Uppal (1):
      scsi: ufs: exynos: fsd: Gate ref_clk and put UFS device in reset on suspend

Biju Das (2):
      mmc: host: renesas_sdhi: Fix the actual clock
      spi: rpc-if: Add resume support for RZ/G3E

Brahmajit Das (1):
      net: intel: fm10k: Fix parameter idx set but not used

Bruno Thomsen (1):
      rtc: pcf2127: fix watchdog interrupt mask on pcf2131

Bui Quang Minh (2):
      virtio-net: drop the multi-buffer XDP packet in zerocopy
      virtio-net: fix received length check in big packets

Carolina Jubran (1):
      net/mlx5e: Don't query FEC statistics when FEC is disabled

Ce Sun (2):
      drm/amdgpu: Avoid rma causes GPU duplicate reset
      drm/amdgpu: Correct the counts of nr_banks and nr_errors

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Cezary Rojewski (2):
      ASoC: Intel: avs: Unprepare a stream when XRUN occurs
      ASoC: Intel: avs: Disable periods-elapsed work when closing PCM

Chandrakanth Patil (2):
      scsi: mpi3mr: Fix I/O failures during controller reset
      scsi: mpi3mr: Fix controller init failure on fault during queue creation

Chang S. Bae (1):
      x86/fpu: Ensure XFD state on signal delivery

Chao Yu (1):
      f2fs: fix to detect potential corrupted nid in free_nid_list

Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Chelsy Ratnawat (1):
      media: fix uninitialized symbol warnings

Chen Pei (1):
      ACPI: SPCR: Support Precise Baud Rate field

Chen Wang (1):
      PCI: cadence: Check for the existence of cdns_pcie::ops before using it

Chen Yufeng (1):
      usb: cdns3: gadget: Use-after-free during failed initialization and exit of cdnsp gadget

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun6i-rtc: Add A523 specifics

Chengchang Tang (1):
      RDMA/hns: Fix recv CQ and QP cache affinity

Chenghao Duan (1):
      riscv: bpf: Fix uninitialized symbol 'retval_off'

Chi Zhang (1):
      pinctrl: single: fix bias pull up/down handling in pin_config_set

Chi Zhiling (1):
      exfat: limit log print for IO error

Chia-I Wu (1):
      drm/panthor: check bo offset alignment in vm bind

Chih-Kang Chang (1):
      wifi: rtw89: obtain RX path from ppdu status IE00

Chris Lu (2):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset
      Bluetooth: btusb: Add new VID/PID 13d3/3633 for MT7922

Christian Bruel (1):
      irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

Christian König (1):
      drm/amdgpu: reject gang submissions under SRIOV

Christoph Hellwig (1):
      dm error: mark as DM_TARGET_PASSES_INTEGRITY

Christoph Paasch (1):
      net: When removing nexthops, don't call synchronize_net if it is not necessary

Christopher Ruehl (1):
      power: supply: qcom_battmgr: add OOI chemistry

Chuande Chen (1):
      hwmon: (sbtsi_temp) AMD CPU extended temperature range support

Chuck Lever (1):
      NFSD: Fix crash in nfsd4_read_release()

ChunHao Lin (1):
      r8169: set EEE speed down ratio to 1

Chunyan Zhang (1):
      riscv: stacktrace: Disable KASAN checks for non-current tasks

Clay King (2):
      drm/amd/display: ensure committing streams is seamless
      drm/amd/display: incorrect conditions for failing dto calculations

Coiby Xu (1):
      ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr

Colin Foster (1):
      smsc911x: add second read of EEPROM mac when possible corruption seen

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP Quark2

Damien Le Moal (2):
      block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
      block: make REQ_OP_ZONE_OPEN a write operation

Daniel Lezcano (1):
      clocksource/drivers/vf-pit: Replace raw_readl/writel to readl/writel

Daniel Palmer (4):
      fbdev: atyfb: Check if pll_ops->init_pll failed
      drm/radeon: Do not kfree() devres managed rdev
      drm/radeon: Remove calls to drm_put_dev()
      eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP

Daniel Wagner (2):
      nvmet-fc: avoid scheduling association deletion twice
      nvme-fc: use lock accessing port_state and rport state

Danny Wang (1):
      drm/amd/display: Reset apply_eamless_boot_optimization when dpms_off

Dapeng Mi (1):
      perf/x86/intel: Fix KASAN global-out-of-bounds warning

David Ahern (2):
      selftests: Disable dad for ipv6 in fcnal-test.sh
      selftests: Replace sleep with slowwait

David Francis (1):
      drm/amdgpu: Allow kfd CRIU with no buffer objects

David Ober (1):
      hwmon: (lenovo-ec-sensors) Update P8 supprt

David Rosca (1):
      drm/sched: avoid killing parent entity on child SIGKILL

David Yang (1):
      selftests: forwarding: Reorder (ar)ping arguments to obey POSIX getopt

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Devendra K Verma (1):
      dmaengine: dw-edma: Set status for callback_result

Dmitry Baryshkov (1):
      drm/bridge: display-connector: don't set OP_DETECT for DisplayPorts

Dragos Tatulea (2):
      page_pool: Clamp pool size to max 16K pages
      net/mlx5e: SHAMPO, Fix skb size check for 64K pages

Emil Dahl Juhl (1):
      tools: lib: thermal: don't preserve owner in install

Eric Dumazet (5):
      idpf: do not linearize big TSO packets
      inet_diag: annotate data-races in inet_diag_bc_sk()
      tcp: use dst_dev_rcu() in tcp_fastopen_active_disable_ofo_check()
      net: call cond_resched() less often in __release_sock()
      ipv6: np->rxpmtu race annotation

Eric Huang (1):
      drm/amdkfd: fix vram allocation failure for a special case

Fabien Proriol (1):
      power: supply: sbs-charger: Support multiple devices

Fangzhi Zuo (1):
      drm/amd/display: Fix pbn_div Calculation Error

Farhan Ali (1):
      s390/pci: Restore IRQ unconditionally for the zPCI device

Felix Fietkau (1):
      wifi: mt76: mt7996: fix memory leak on mt7996_mcu_sta_key_tlv error

Fenglin Wu (1):
      power: supply: qcom_battmgr: handle charging state change notifications

Fiona Ebner (1):
      smb: client: transport: avoid reconnects triggered by pending task work

Florian Fuchs (1):
      fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS

Florian Schmaus (1):
      kunit: test_dev_action: Correctly cast 'priv' pointer to long*

Florian Westphal (1):
      netfilter: nf_reject: don't reply to icmp error messages

Forest Crossman (1):
      usb: mon: Increase BUFF_MAX to 64 MiB to support multi-MB URBs

Francisco Gutierrez (1):
      scsi: pm80xx: Fix race condition caused by static variables

Gal Pressman (1):
      net/mlx5e: Fix return value in case of module EEPROM read error

Gaurav Jain (1):
      crypto: caam - double the entropy delay interval for retry

Geert Uytterhoeven (1):
      kbuild: uapi: Strip comments before size type check

Geoffrey McRae (1):
      drm/amdkfd: return -ENOTTY for unsupported IOCTLs

Gerd Bayer (1):
      s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Greg Kroah-Hartman (1):
      Linux 6.12.58

Gregory Price (1):
      x86/CPU/AMD: Add RDSEED fix for Zen5

Guangshuo Li (1):
      drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()

Haibo Chen (1):
      iio: adc: imx93_adc: load calibrated values even calibration failed

Hangbin Liu (1):
      net: vlan: sync VLAN features with lower device

Hans de Goede (2):
      ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in acpi_ds_call_control_method()

Hao Yao (1):
      media: ov08x40: Fix the horizontal flip control

Haotian Zhang (2):
      crypto: aspeed - fix double free caused by devm
      net: wan: framer: pef2256: Switch to devm_mfd_add_devices()

Harikrishna Shenoy (1):
      phy: cadence: cdns-dphy: Enable lower resolutions in dphy

Hector Martin (1):
      iommu/apple-dart: Clear stream error indicator bits for T8110 DARTs

Heijligen, Thomas (1):
      mfd: kempld: Switch back to earlier ->init() behavior

Heiko Carstens (1):
      s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP

Heiner Kallweit (1):
      net: phy: fixed_phy: let fixed_phy_unregister free the phy_device

Helge Deller (1):
      parisc: Avoid crash due to unaligned access in unwinder

Heng Zhou (1):
      drm/amdgpu: fix nullptr err of vm_handle_moved

Henrique Carvalho (2):
      smb: client: fix potential cfid UAF in smb2_query_info_compound
      smb: client: fix potential UAF in smb2_close_cached_fid()

Hongguang Gao (2):
      bnxt_en: Refactor bnxt_free_ctx_mem()
      bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()

Horatiu Vultur (1):
      lan966x: Fix sleeping in atomic context

Hoyoung Seo (1):
      scsi: ufs: core: Include UTP error in INT_FATAL_ERRORS

Ian Rogers (1):
      tools bitmap: Add missing asm-generic/bitsperlong.h include

Ido Schimmel (3):
      bridge: Redirect to backup port when port is administratively down
      selftests: traceroute: Use require_command()
      selftests: traceroute: Return correct value on failure

Ilan Peer (2):
      wifi: mac80211: Fix HE capabilities element check
      wifi: mac80211: Track NAN interface start/stop

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Ilpo Järvinen (1):
      mfd: intel-lpss: Add Intel Wildcat Lake LPSS PCI IDs

Inochi Amaoto (1):
      irqchip/sifive-plic: Respect mask state when setting affinity

Iulia Tanasescu (1):
      Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave

Ivan Lipski (2):
      drm/amd/display: Fix incorrect return of vblank enable on unconfigured crtc
      drm/amd/display: Support HW cursor 180 rot for any number of pipe splits

Ivan Pravdin (1):
      Bluetooth: bcsp: receive data only if registered

Jacky Bai (1):
      clk: scmi: Add duty cycle ops only when duty cycle is supported

Jacob Moroni (3):
      RDMA/irdma: Fix SD index calculation
      RDMA/irdma: Remove unused struct irdma_cq fields
      RDMA/irdma: Set irdma_cq cq_num field during CQ create

Jaegeuk Kim (1):
      f2fs: fix wrong layout information on 16KB page

Jakub Kicinski (4):
      selftests: drv-net: rss_ctx: fix the queue count check
      selftests: drv-net: rss_ctx: make the test pass with few queues
      selftests: net: replace sleeps in fcnal-test with waits
      page_pool: always add GFP_NOWARN for ATOMIC allocations

Janne Grunau (1):
      pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"

Jarkko Nikula (1):
      i3c: mipi-i3c-hci-pci: Add support for Intel Wildcat Lake-U I3C

Jason Gunthorpe (1):
      iommufd: Don't overflow during division for dirty tracking

Jayesh Choudhary (1):
      drm/tidss: Set crtc modesetting parameters with adjusted mode

Jens Kehne (1):
      mfd: da9063: Split chip variant reading in two bus transactions

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jerome Brunet (1):
      NTB: epf: Allow arbitrary BAR mapping

Jiawei Zhao (1):
      libbpf: Fix USDT SIB argument handling causing unrecognized register error

Jiawen Wu (2):
      net: wangxun: limit tx_max_coalesced_frames_irq
      net: libwx: fix device bus LAN ID

Jiayi Li (1):
      memstick: Add timeout to prevent indefinite waiting

Jijie Shao (1):
      net: hns3: return error code when function fails

Jiri Olsa (1):
      uprobe: Do not emulate/sstep original instruction when ip is changed

Johan Hovold (2):
      Bluetooth: rfcomm: fix modem control handling
      drm/mediatek: Fix device use-after-free on unbind

Johannes Berg (1):
      wifi: mac80211: fix key tailroom accounting leak

John Harrison (2):
      drm/xe/guc: Add more GuC load error status codes
      drm/xe/guc: Return an error code if the GuC load fails

John Keeping (1):
      ALSA: serial-generic: remove shared static buffer

John Smith (2):
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Fiji
      drm/amd/pm/powerplay/smumgr: Fix PCIeBootLinkLevel value on Iceland

Jonas Gorski (5):
      net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
      net: dsa: b53: fix resetting speed and pause on forced link
      net: dsa: b53: fix bcm63xx RGMII port link adjustment
      net: dsa: b53: fix enabling ip multicast
      net: dsa: b53: stop reading ARL entries if search is done

Jonas Schwöbel (1):
      ARM: tegra: p880: set correct touchscreen clipping

Josephine Pfeiffer (1):
      riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro

Joshua Grisham (1):
      ACPI: fan: Add fan speed reporting for fans with only _FST

Joshua Rogers (1):
      smb: client: validate change notify buffer before copy

Josua Mayer (1):
      rtc: pcf2127: clear minute/second interrupt

Julian Sun (1):
      ext4: increase IO priority of fastcommit

Junjie Cao (1):
      fbdev: bitblit: bound-check glyph index in bit_putcs*

Junxian Huang (1):
      RDMA/hns: Fix wrong WQE data when QP wraps around

Juraj Šarinay (1):
      net: nfc: nci: Increase NCI_DATA_TIMEOUT to 3000 ms

Justin Tee (6):
      scsi: lpfc: Clean up allocated queues when queue setup mbox commands fail
      scsi: lpfc: Decrement ndlp kref after FDISC retries exhausted
      scsi: lpfc: Check return status of lpfc_reset_flush_io_context during TGT_RESET
      scsi: lpfc: Remove ndlp kref decrement clause for F_Port_Ctrl in lpfc_cleanup
      scsi: lpfc: Define size of debugfs entry for xri rebalancing
      scsi: lpfc: Ensure PLOGI_ACC is sent prior to PRLI in Point to Point topology

Kailang Yang (1):
      ALSA: hda/realtek: Audio disappears on HP 15-fc000 after warm boot again

Kalesh AP (1):
      bnxt_en: Fix a possible memory leak in bnxt_ptp_init

Karthi Kandasamy (1):
      drm/amd/display: Add AVI infoframe copy in copy_stream_update_to_stream

Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Karunika Choo (1):
      drm/panthor: Serialize GPU cache flush operations

Kaushlendra Kumar (5):
      ACPI: button: Call input_free_device() on failing input device registration
      ACPI: sysfs: Use ACPI_FREE() for freeing an ACPI object
      tools/cpupower: fix error return value in cpupower_write_sysfs()
      tools/cpupower: Fix incorrect size in cpuidle_state_disable()
      tools/power x86_energy_perf_policy: Fix incorrect fopen mode usage

Kees Cook (1):
      arc: Fix __fls() const-foldability via __builtin_clzl()

Kent Russell (1):
      drm/amdkfd: Handle lack of READ permissions in SVM mapping

Kirill A. Shutemov (2):
      x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
      x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro

Koakuma (1):
      sparc/module: Add R_SPARC_UA64 relocation handling

Konstantin Sinyuk (1):
      accel/habanalabs/gaudi2: read preboot status after recovering from dirty state

Kotresh HR (1):
      ceph: fix multifs mds auth caps issue

Krishna Kurapati (1):
      usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

Krzysztof Kozlowski (4):
      extcon: adc-jack: Fix wakeup source leaks on device unbind
      drm/msm/dsi/phy: Toggle back buffer resync after preparing PLL
      drm/msm/dsi/phy_7nm: Fix missing initial VCO rate
      extcon: adc-jack: Cleanup wakeup source only if it was enabled

Kuan-Chung Chen (2):
      wifi: rtw89: wow: remove notify during WoWLAN net-detect
      wifi: rtw89: fix BSSID comparison for non-transmitted BSSID

Kumar Kartikeya Dwivedi (1):
      bpf: Do not limit bpf_cgroup_from_id to current's namespace

Kuniyuki Iwashima (1):
      net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.

Laurent Pinchart (2):
      media: pci: ivtv: Don't create fake v4l2_fh
      media: amphion: Delete v4l2_fh synchronously in .release()

Len Brown (2):
      tools/power x86_energy_perf_policy: Enhance HWP enable
      tools/power x86_energy_perf_policy: Prefer driver HWP limits

Li RongQing (1):
      x86/kvm: Prefer native qspinlock for dedicated vCPUs irrespective of PV_UNHALT

Lijo Lazar (2):
      drm/amd/pm: Use cached metrics data on aldebaran
      drm/amd/pm: Use cached metrics data on arcturus

Linus Torvalds (2):
      x86: use cmov for user address masking
      x86: uaccess: don't use runtime-const rewriting in modules

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Lo-an Chen (1):
      drm/amd/display: Init dispclk from bootup clock for DCN314

Loic Poulain (2):
      wifi: ath10k: Fix memory leak on unsupported WMI command
      wifi: ath10k: Fix connection after GTK rekeying

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Fix BIS connection dst_type handling
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_core: Fix tracking of periodic advertisement
      Bluetooth: SCO: Fix UAF on sco_conn_free

Lukas Wunner (2):
      PCI/ERR: Update device error_state already after reset
      thunderbolt: Use is_pciehp instead of is_hotplug_bridge

Maarten Lankhorst (1):
      drm/xe: Fix oops in xe_gem_fault when running core_hotunplug test.

Maarten Zanders (1):
      ASoC: fsl_sai: Fix sync error in consumer mode

Mangesh Gadre (1):
      drm/amdgpu: Avoid vcn v5.0.1 poison irq call trace on sriov guest

Marcos Del Sol Vives (1):
      PCI: Disable MSI on RDC PCI to PCIe bridges

Marek Szyprowski (1):
      media: videobuf2: forbid remove_bufs when legacy fileio is active

Marek Vasut (1):
      PCI: endpoint: pci-epf-test: Limit PCIe BAR size for fixed BARs

Mario Limonciello (4):
      drm/amd: Check that VPE has reached DPM0 in idle handler
      drm/amd/display: Set up pixel encoding for YCBCR422
      PCI/PM: Skip resuming to D0 if device is disconnected
      drm/amd/display: Add fallback path for YCBCR422

Mario Limonciello (AMD) (5):
      ACPI: video: force native for Lenovo 82K8
      Fix access to video_is_primary_device() when compiled without CONFIG_VIDEO
      drm/amd: Avoid evicting resources at S5
      HID: i2c-hid: Resolve touchpad issues on Dell systems during S4
      x86/microcode/AMD: Add more known models to entry sign checking

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Marko Mäkelä (1):
      clk: qcom: gcc-ipq6018: rework nss_port5 clock to multiple conf

Markus Stockhausen (2):
      clocksource/drivers/timer-rtl-otto: Work around dying timers
      clocksource/drivers/timer-rtl-otto: Do not interfere with interrupts

Martin Tůma (1):
      media: pci: mgb4: Fix timings comparison in VIDIOC_S_DV_TIMINGS

Martin Willi (1):
      wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgroup

Matthew Brost (1):
      drm/xe: Do not wake device during a GT reset

Matthias Schiffer (1):
      clk: ti: am33xx: keep WKUP_DEBUGSS_CLKCTRL enabled

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: join: allow more time to send ADD_ADDR

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix fdb hash size configuration

Mehdi Djait (1):
      media: i2c: Kconfig: Ensure a dependency on HAVE_CLK for VIDEO_CAMERA_SENSOR

Melissa Wen (2):
      drm/amd/display: change dc stream color settings only in atomic commit
      drm/amd/display: update color on atomic commit time

Meng Li (1):
      drm/amd/amdgpu: Release xcp drm memory after unplug

Miaoqian Lin (3):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints
      fbdev: valkyriefb: Fix reference count leak in valkyriefb_init
      s390/mm: Fix memory leak in add_marker() when kvrealloc() fails

Michael Dege (1):
      phy: renesas: r8a779f0-ether-serdes: add new step added to latest datasheet

Michael Riesch (1):
      phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf register 0

Michael Strauss (2):
      drm/amd/display: Move setup_stream_attribute
      drm/amd/display: Increase AUX Intra-Hop Done Max Wait Duration

Michal Pecio (1):
      usb: xhci-pci: Fix USB2-only root hub registration

Michal Wajdeczko (1):
      drm/xe/guc: Set upper limit of H2G retries over CTB

Mike Marshall (1):
      orangefs: fix xattr related buffer overflow...

Miklos Szeredi (1):
      fuse: zero initialize inode private data

Ming Wang (1):
      irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC IRQ controller

Miri Korenblit (1):
      wifi: mac80211: don't mark keys for inactive links as uploaded

Miroslav Lichvar (1):
      ptp: Limit time setting of PTP clocks

Mohammad Heib (2):
      net: ionic: add dma_wmb() before ringing TX doorbell
      net: ionic: map SKB after pseudo-header checksum prep

Moti Haimovski (1):
      accel/habanalabs: support mapping cb with vmalloc-backed coherent memory

Mukesh Ojha (1):
      firmware: qcom: scm: preserve assign_mem() error return value

Mykyta Yatsenko (1):
      selftests/bpf: Fix flaky bpf_cookie selftest

Nai-Chen Cheng (1):
      selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency

Namjae Jeon (2):
      exfat: validate cluster allocation bits of the allocation bitmap
      ksmbd: use sock_create_kern interface to create kernel socket

Nathan Chancellor (1):
      lib/crypto: curve25519-hacl64: Fix older clang KASAN workaround for GCC

Nicolas Ferre (2):
      ARM: at91: pm: save and restore ACR during PLL disable/enable
      clk: at91: clk-sam9x60-pll: force write to PLL_UPDT register

Nidhish A N (1):
      wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list

Nikita Travkin (1):
      firmware: qcom: tzmem: disable sc7180 platform

Niklas Cassel (1):
      PCI: dwc: Verify the single eDMA IRQ in dw_pcie_edma_irq_verify()

Niklas Neronin (1):
      usb: xhci-pci: add support for hosts with zero USB3 ports

Niklas Schnelle (2):
      powerpc/eeh: Use result of error_detected() in uevent
      s390/pci: Use pci_uevent_ers() in PCI recovery

Niklas Söderlund (4):
      media: adv7180: Add missing lock in suspend callback
      media: adv7180: Do not write format to device in set_fmt
      media: adv7180: Only validate format in querystd
      net: sh_eth: Disable WoL if system can not suspend

Nikolay Aleksandrov (2):
      net: bridge: fix use-after-free due to MST port state bypass
      net: bridge: fix MST static key usage

Nithyanantham Paramasivam (1):
      wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Oleg Nesterov (1):
      9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN

Oleksij Rempel (2):
      net: stmmac: Correctly handle Rx checksum offload errors
      net: phy: clear link parameters on admin link down

Olga Kornievskaia (1):
      NFSv4: handle ERR_GRACE on delegation recalls

Olivier Moysan (1):
      ASoC: stm32: sai: manage context in set_sysclk callback

Ondrej Mosnacek (1):
      bpf: Do not audit capability check in do_jit()

Oscar Maes (1):
      net: ipv4: allow directed broadcast routes to use dst hint

Ovidiu Panait (1):
      crypto: sun8i-ce - remove channel timeout field

Owen Gu (1):
      usb: gadget: f_fs: Fix epfile null pointer access after ep enable.

Paolo Abeni (2):
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: restore window probe

Paresh Bhagat (1):
      cpufreq: ti: Add support for AM62D2

Parthiban Veerasooran (1):
      microchip: lan865x: add ndo_eth_ioctl handler to enable PHY ioctl support

Paul Chaignon (1):
      bpf: Use tnums for JEQ/JNE is_branch_taken logic

Paul Hsieh (1):
      drm/amd/display: update dpp/disp clock from smu clock table

Paul Kocialkowski (1):
      media: verisilicon: Explicitly disable selection api ioctls for decoders

Pavan Chebbi (1):
      bnxt_en: Add Hyper-V VF ID

Pavel Begunkov (1):
      io_uring/zctx: check chained notif contexts

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-pcm: Add fixup for channels

Peter Wang (8):
      scsi: ufs: host: mediatek: Fix auto-hibern8 timer configuration
      scsi: ufs: host: mediatek: Fix PWM mode switch issue
      scsi: ufs: host: mediatek: Change reset sequence for improved stability
      scsi: ufs: host: mediatek: Enhance recovery on resume failure
      scsi: ufs: host: mediatek: Fix unbalanced IRQ enable issue
      scsi: ufs: host: mediatek: Enhance recovery on hibernation exit failure
      scsi: ufs: host: mediatek: Correct system PM flow
      scsi: ufs: host: mediatek: Disable auto-hibern8 during power mode changes

Petr Machata (1):
      net: bridge: Install FDB for bridge MAC on VLAN 0

Petr Oros (2):
      tools: ynl: fix string attribute length to include null terminator
      dpll: spec: add missing module-name and clock-id to pin-get reply

Philip Yang (1):
      drm/amdkfd: Fix mmap write lock not release

Philipp Stanner (2):
      drm/nouveau: Fix race in nouveau_sched_fini()
      drm/sched: Fix race in drm_sched_entity_select_rq()

Pierre-Eric Pelloux-Prayer (1):
      drm/sched: Fix deadlock in drm_sched_entity_kill_jobs_cb

Ping-Ke Shih (2):
      wifi: rtw89: print just once for unknown C2H events
      wifi: rtw88: sdio: use indirect IO for device registers before power-on

Pranav Tyagi (1):
      futex: Don't leak robust_list pointer on exec race

Primoz Fiser (1):
      ASoC: tlv320aic3x: Fix class-D initialization for tlv320aic3007

Punit Agrawal (1):
      ACPI: SPCR: Check for table version when using precise baudrate

Qendrim Maxhuni (1):
      net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup

Qianfeng Rong (3):
      crypto: qat - use kcalloc() in qat_uclo_map_objs_from_mof()
      scsi: pm8001: Use int instead of u32 to store error codes
      media: redrat3: use int type to store negative error codes

Qingfang Deng (1):
      6pack: drop redundant locking and refcounting

Qu Wenruo (1):
      btrfs: ensure no dirty metadata is written back for an fs with errors

Quan Zhou (1):
      wifi: mt76: mt7921: Add 160MHz beamformee capability for mt7922 device

Quanmin Yan (1):
      fbcon: Set fb_display[i]->mode to NULL when the mode is released

Quanyang Wang (1):
      arm64: zynqmp: Disable coresight by default

Radhey Shyam Pandey (1):
      arm64: zynqmp: Revert usb node drive strength and slew rate for zcu106

Rafael J. Wysocki (4):
      cpuidle: governors: menu: Rearrange main loop in menu_select()
      cpuidle: governors: menu: Select polling state in some more cases
      thermal: gov_step_wise: Allow cooling level to be reduced earlier
      cpuidle: Fail cpuidle device registration if there is one already

Rameshkumar Sundaram (1):
      wifi: ath11k: avoid bit operation on key flags

Ramya Gnanasekar (1):
      wifi: mac80211: Fix 6 GHz Band capabilities element advertisement in lower bands

Randall P. Embry (2):
      9p: fix /sys/fs/9p/caches overwriting itself
      9p: sysfs_init: don't hardcode error to ENOMEM

Ranjan Kumar (1):
      scsi: mpt3sas: Add support for 22.5 Gbps SAS link rate

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: hci_event: validate skb length for unknown CC opcode

Relja Vojvodic (1):
      drm/amd/display: Increase minimum clock for TMDS 420 with pipe splitting

Ricardo B. Marlière (2):
      selftests/bpf: Fix bpf_prog_detach2 usage in test_lirc_mode2
      selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh

Ricardo Ribalda (1):
      media: uvcvideo: Use heuristic to find stream entity

Richard Fitzgerald (1):
      ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h

Richard Zhu (1):
      PCI: imx6: Enable the Vaux supply if available

Rob Clark (1):
      drm/msm/registers: Generate _HI/LO builders for reg64

Robert Marko (1):
      net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X

Rodrigo Gobbi (1):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register

Rohan G Thomas (2):
      net: phy: marvell: Fix 88e1510 downshift counter errata
      net: stmmac: est: Drop frames causing HLBS error

Rong Zhang (2):
      hwmon: (k10temp) Add device ID for Strix Halo
      drm/amd/display: Fix NULL deref in debugfs odm_combine_segments

Rosen Penev (2):
      dmaengine: mv_xor: match alloc_wc and free_wc
      wifi: mt76: mt76_eeprom_override to int

Roy Vegard Ovesen (2):
      ALSA: usb-audio: fix control pipe direction
      ALSA: usb-audio: add mono main switch to Presonus S1824c

Ryan Chen (1):
      soc: aspeed: socinfo: Add AST27xx silicon IDs

Ryan Wanner (1):
      clk: at91: clk-master: Add check for divide by 3

Sakari Ailus (2):
      media: ipu6: isys: Set embedded data type correctly for metadata formats
      ACPI: property: Return present device nodes only on fwnode interface

Saket Dumbre (1):
      ACPICA: Update dsmethod.c to get rid of unused variable warning

Sam van Kampen (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook Pro N6506CU

Sammy Hsu (1):
      net: wwan: t7xx: add support for HP DRMR-H01

Sangwook Shin (1):
      watchdog: s3c2410_wdt: Fix max_timeout being calculated larger

Sarthak Garg (1):
      mmc: sdhci-msm: Enable tuning for SDR50 mode for SD card

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

Sathishkumar S (3):
      drm/amdgpu: Check vcn sram load return value
      drm/amdgpu/jpeg: Hold pg_lock before jpeg poweroff
      drm/amdgpu: Fix unintended error log in VCN5_0_0

Seyediman Seyedarab (2):
      drm/nouveau: replace snprintf() with scnprintf() in nvkm_snprintbf()
      iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()

Shang song (Lenovo) (1):
      ACPI: PRM: Skip handlers with NULL handler_address or NULL VA

Shardul Bankar (1):
      btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation

Shaurya Rane (1):
      jfs: fix uninitialized waitqueue in transaction manager

Shengjiu Wang (1):
      ASoC: fsl_sai: fix bit order for DSD format

Shruti Parab (1):
      bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type

Shubhrajyoti Datta (1):
      clk: clocking-wizard: Fix output clock register offset for Versal platforms

Sohil Mehta (1):
      cpufreq: ondemand: Update the efficient idle check for Intel extended Families

Sridevi Arvindekar (1):
      drm/amd/display: Fix for test crash due to power gating

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6asm: do not sleep while atomic

Srinivas Pandruvada (2):
      thermal: intel: selftests: workload_hint: Mask unsupported types
      platform/x86/intel-uncore-freq: Fix warning in partitioned system

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix function header names in amdgpu_connectors.c

Stanislav Fomichev (1):
      net: devmem: expose tcp_recvmsg_locked errors

Stefan Wahren (1):
      ethernet: Extend device_get_mac_address() to use NVMEM

Stefan Wiehler (3):
      sctp: Hold RCU read lock while iterating over address list
      sctp: Prevent TOCTOU out-of-bounds write
      sctp: Hold sock lock while iterating over address list

Stephan Gerhold (1):
      remoteproc: qcom: q6v5: Avoid handling handover twice

Steven Rostedt (1):
      ring-buffer: Do not warn in ring_buffer_map_get_reader() when reader catches up

Sungho Kim (1):
      PCI/P2PDMA: Fix incorrect pointer usage in devm_kfree() call

Sunil V L (1):
      ACPI: scan: Update honor list for RPMI System MSI

Svyatoslav Ryhel (4):
      soc/tegra: fuse: Add Tegra114 nvmem cells and fuse lookups
      ARM: tegra: transformer-20: add missing magnetometer interrupt
      ARM: tegra: transformer-20: fix audio-codec interrupt
      video: backlight: lp855x_bl: Set correct EPROM start for LP8556

Takashi Iwai (1):
      ALSA: usb-audio: Add validation of UAC2/UAC3 effect units

Takashi Sakamoto (1):
      firewire: ohci: move self_id_complete tracepoint after validating register

Tao Zhou (1):
      drm/amdgpu: add range check for RAS bad page address

Tatyana Nikolova (1):
      RDMA/irdma: Update Kconfig

Tejun Heo (1):
      sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU

Terry Cheong (1):
      ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks

Tetsuo Handa (3):
      media: imon: make send_packet() more robust
      ntfs3: pretend $Extend records as regular files
      jfs: Verify inode mode when loading from disk

Thadeu Lima de Souza Cascardo (1):
      char: misc: restrict the dynamic range to exclude reserved minors

Thomas Andreatta (1):
      dmaengine: sh: setup_xref error handling

Thomas Bogendoerfer (1):
      tty: serial: ip22zilog: Use platform device for probing

Thomas Weißschuh (4):
      spi: loopback-test: Don't use %pK through printk
      soc: ti: pruss: don't use %pK through printk
      bpf: Don't use %pK through printk
      ice: Don't use %pK through printk or tracepoints

Thomas Zimmermann (2):
      drm/sysfb: Do not dereference NULL pointer in plane reset
      drm/ast: Clear preserved bits from register output value

Théo Lebrun (1):
      net: macb: avoid dealing with endianness in macb_set_hwaddr()

Tiezhu Yang (2):
      net: stmmac: Check stmmac_hw_setup() in stmmac_resume()
      LoongArch: Handle new atomic instructions for probes

Timothy Pearson (1):
      vfio/pci: Fix INTx handling on legacy non-PCI 2.3 devices

Timur Kristóf (3):
      drm/amdgpu: Respect max pixel clock for HDMI and DVI-D (v2)
      drm/amd/display: Fix DVI-D/HDMI adapters
      drm/amd/display: Disable VRR on DCE 6

Tiwei Bie (1):
      um: Fix help message for ssl-non-raw

Tom Stellard (1):
      bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21

Tomasz Pakuła (2):
      HID: pidff: Use direction fix only for conditional effects
      HID: pidff: PERMISSIVE_CONTROL quirk autodetection

Tomer Tayar (1):
      accel/habanalabs: return ENOMEM if less than requested pages were pinned

Tomeu Vizoso (1):
      drm/etnaviv: fix flush sequence logic

Tomi Valkeinen (3):
      drm/tidss: Use the crtc_* timings when programming the HW
      drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
      drm/bridge: cdns-dsi: Don't fail on MIPI_DSI_MODE_VIDEO_BURST

Tristram Ha (1):
      net: dsa: microchip: Fix reserved multicast address table programming

TungYu Lu (1):
      drm/amd/display: Wait until OTG enable state is cleared

Tvrtko Ursulin (3):
      drm/sched: Optimise drm_sched_entity_push_job
      drm/sched: Re-group and rename the entity run-queue lock
      drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl

Ujwal Kundur (1):
      rds: Fix endianness annotation for RDS_MPATH_HASH

Uwe Kleine-König (1):
      pwm: pca9685: Use bulk write to atomicially update registers

Valerio Setti (1):
      ASoC: meson: aiu-encoder-i2s: fix bit clock polarity

Vered Yavniely (1):
      accel/habanalabs/gaudi2: fix BMON disable configuration

Viacheslav Dubeyko (3):
      ceph: add checking of wait_for_completion_killable() return value
      ceph: fix potential race condition in ceph_ioctl_lazyio()
      ceph: refactor wake_up_bit() pattern of calling

Vivek Pernamitta (1):
      bus: mhi: core: Improve mhi_sync_power_up handling for SYS_ERR state

Vlad Dumitrescu (1):
      IB/ipoib: Ignore L3 master device

Vladimir Oltean (1):
      net: dsa: felix: support phy-mode = "10g-qxgmii"

Vladimir Riabchun (1):
      ftrace: Fix softlockup in ftrace_module_enable

Vladimir Zapolskiy (1):
      media: i2c: og01a1b: Specify monochrome media bus format instead of Bayer

Wake Liu (2):
      selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
      selftests/net: Ensure assert() triggers in psock_tpacket.c

Wang Liang (1):
      selftests: netdevsim: Fix ethtool-coalesce.sh fail by installing ethtool-common.sh

Wayne Lin (1):
      drm/amd/display: Enable mst when it's detected but yet to be initialized

Weili Qian (2):
      crypto: hisilicon/qm - invalidate queues in use
      crypto: hisilicon/qm - clear all VF configurations in the hardware

William Wu (1):
      usb: gadget: f_hid: Fix zero length packet transfer

Wonkon Kim (1):
      scsi: ufs: core: Initialize value of an attribute returned by uic cmd

Xi Ruoyao (1):
      drm/amd/display/dml2: Guard dml21_map_dc_state_into_dml_display_cfg with DC_FP_START

Xiang Liu (1):
      drm/amdgpu: Skip poison aca bank from UE channel

Xichao Zhao (1):
      tty: serial: Modify the use of dev_err_probe()

Xion Wang (1):
      char: Use list_del_init() in misc_deregister() to reinitialize list pointer

Yafang Shao (1):
      net/cls_cgroup: Fix task_get_classid() during qdisc run

Yang Wang (1):
      drm/amd/pm: fix smu table id bound check issue in smu_cmn_update_table()

Yifan Zhang (1):
      amd/amdkfd: resolve a race in amdgpu_amdkfd_device_fini_sw

Yikang Yue (1):
      fs/hpfs: Fix error code for new_inode() failure in mkdir/create/mknod/symlink

Yonghong Song (3):
      bpf: Find eligible subprogs for private stack support
      bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
      selftests/bpf: Fix selftest verifier_arena_large failure

Yu Kuai (1):
      blk-cgroup: fix possible deadlock while configuring policy

Yu Zhang(Yuriy) (1):
      wifi: ath11k: add support for MU EDCA

Yue Haibing (1):
      ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled

Yuhao Jiang (1):
      ACPI: video: Fix use-after-free in acpi_video_switch_brightness()

Yunseong Kim (1):
      crypto: ccp - Fix incorrect payload size calculation in psp_poulate_hsti()

Yuta Hayama (1):
      rtc: rx8025: fix incorrect register reference

Zhanjun Dong (1):
      drm/xe/guc: Increase GuC crash dump buffer size

Zijun Hu (2):
      char: misc: Make misc_register() reentry for miscdevice who wants dynamic minor
      char: misc: Does not request module for miscdevice with dynamic minor

Zilin Guan (1):
      tracing: Fix memory leaks in create_field_var()

Zizhi Wo (1):
      tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()

Zong-Zhe Yang (1):
      wifi: rtw89: renew a completion for each H2C command waiting C2H event

austinchang (1):
      btrfs: mark dirty extent range for out of bound prealloc extents

chenmiao (1):
      openrisc: Add R_OR1K_32_PCREL relocation type module support

chuguangqing (1):
      fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock

raub camaioni (1):
      usb: gadget: f_ncm: Fix MAC assignment NCM ethernet

wangzijie (1):
      f2fs: fix infinite loop in __insert_extent_tree()

wenglianfa (1):
      RDMA/hns: Fix the modification of max_send_sge

Álvaro Fernández Rojas (1):
      net: dsa: tag_brcm: legacy: reorganize functions


