Return-Path: <stable+bounces-116560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D4A3806C
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66127A4F96
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCEB216E2B;
	Mon, 17 Feb 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tjc7g5X4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D6215F68;
	Mon, 17 Feb 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788800; cv=none; b=YbwrOhvs6djdtO09J2ZUFlQg3jOdfY2lskqr+HjZuCqauOSkc2G9Rvs0GKGTLxYoV2BvD159VgXftLRLNEtvUvXXNWG9flWAn4mPFM6RegoxhGQF5WHnC2+xXbSrAOZLRvmRsURj1240SAUl4TWDLuAwXMC+eciwlamUwr/fKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788800; c=relaxed/simple;
	bh=Dk3EmEEYJyqoNLIG/z8xH3byDeCF0UcPXpshc4GidxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FY0RasZrpGPOXdlGUxqPYEgyykXXTpkYZp1Jd8SIzZZ4t/EA2h1WIeXkbHSEbTd9O5PsoC2jOcE3/SFv48mOFm98yhUskZxLYQv3eCpcUobhFXXXw6CfMV5sLgfRO/EjZXSmlagPoRZuR+H2x+5Gu4vOyph9z3FhMlfV5qoFzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tjc7g5X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83798C4CEE4;
	Mon, 17 Feb 2025 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788799;
	bh=Dk3EmEEYJyqoNLIG/z8xH3byDeCF0UcPXpshc4GidxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Tjc7g5X44+rvTAA5S0F9fHaSJjqxq776AW3e5BhFbwfv1Za2idWQjYSbgh9+wgW4b
	 d39cvF/Q0r9i5v9kDSCZhv7IeBLiQGe5TqzUM6I0JfoqDAuHbKAcIpcdJ+823Ofccy
	 h6j/kYB3MiTPJwuCtafyNyEC7sA64IEca2hDHTn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.13.3
Date: Mon, 17 Feb 2025 11:39:54 +0100
Message-ID: <2025021754-stimuli-duly-4353@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.13.3 kernel.

All users of the 6.13 kernel series must upgrade.

The updated 6.13.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.13.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arch/arm64/elf_hwcaps.rst                          |   39 
 Documentation/driver-api/media/tx-rx.rst                         |    2 
 Documentation/gpu/drm-kms-helpers.rst                            |    3 
 Makefile                                                         |    2 
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi                           |    2 
 arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi                       |   10 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                   |    5 
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts                  |    4 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                         |    2 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                         |    6 
 arch/arm64/boot/dts/qcom/sdx75.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6115.dtsi                             |    8 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                             |    6 
 arch/arm64/boot/dts/qcom/sm6375.dtsi                             |   10 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                             |  492 +++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi                             |  216 ++--
 arch/arm64/boot/dts/qcom/sm8550.dtsi                             |  271 ++---
 arch/arm64/boot/dts/qcom/sm8650.dtsi                             |  305 +++---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts       |    4 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts          |    4 
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                        |    6 
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts            |    4 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts         |    6 
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi         |    4 
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                        |    6 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                           |  280 ++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                    |    2 
 arch/arm64/include/asm/assembler.h                               |    5 
 arch/arm64/include/asm/pgtable-hwdef.h                           |    6 
 arch/arm64/include/asm/pgtable-prot.h                            |    7 
 arch/arm64/include/asm/sparsemem.h                               |    5 
 arch/arm64/kernel/cpufeature.c                                   |   55 -
 arch/arm64/kernel/cpuinfo.c                                      |   10 
 arch/arm64/kernel/pi/idreg-override.c                            |    9 
 arch/arm64/kernel/pi/map_kernel.c                                |    6 
 arch/arm64/kvm/arch_timer.c                                      |    4 
 arch/arm64/kvm/arm.c                                             |    8 
 arch/arm64/mm/hugetlbpage.c                                      |   12 
 arch/arm64/mm/init.c                                             |    7 
 arch/loongarch/include/uapi/asm/ptrace.h                         |   10 
 arch/loongarch/kernel/ptrace.c                                   |    6 
 arch/m68k/include/asm/vga.h                                      |    8 
 arch/mips/Kconfig                                                |    1 
 arch/mips/kernel/ftrace.c                                        |    2 
 arch/mips/loongson64/boardinfo.c                                 |    2 
 arch/mips/math-emu/cp1emu.c                                      |    2 
 arch/mips/pci/pci-legacy.c                                       |    8 
 arch/parisc/Kconfig                                              |    4 
 arch/powerpc/platforms/pseries/eeh_pseries.c                     |    6 
 arch/s390/include/asm/asm-extable.h                              |    4 
 arch/s390/include/asm/fpu-insn.h                                 |   17 
 arch/s390/include/asm/futex.h                                    |    2 
 arch/s390/include/asm/processor.h                                |    3 
 arch/s390/kernel/vmlinux.lds.S                                   |    1 
 arch/s390/kvm/vsie.c                                             |   25 
 arch/s390/mm/extable.c                                           |    9 
 arch/s390/pci/pci_bus.c                                          |    1 
 arch/x86/boot/compressed/Makefile                                |    1 
 arch/x86/include/asm/kexec.h                                     |   18 
 arch/x86/include/asm/kvm_host.h                                  |    2 
 arch/x86/kernel/acpi/boot.c                                      |   50 -
 arch/x86/kernel/amd_nb.c                                         |    4 
 arch/x86/kernel/machine_kexec_64.c                               |   45 
 arch/x86/kernel/process.c                                        |    2 
 arch/x86/kernel/reboot.c                                         |    2 
 arch/x86/kvm/lapic.c                                             |   11 
 arch/x86/kvm/lapic.h                                             |    1 
 arch/x86/kvm/mmu/mmu.c                                           |   45 
 arch/x86/kvm/svm/sev.c                                           |    2 
 arch/x86/kvm/vmx/nested.c                                        |    5 
 arch/x86/kvm/vmx/vmx.c                                           |   21 
 arch/x86/kvm/vmx/vmx.h                                           |    1 
 arch/x86/kvm/x86.c                                               |    7 
 arch/x86/mm/fault.c                                              |    2 
 arch/x86/pci/fixup.c                                             |   30 
 arch/x86/platform/efi/quirks.c                                   |    5 
 arch/x86/xen/xen-head.S                                          |    5 
 block/blk-cgroup.c                                               |    1 
 block/blk-sysfs.c                                                |    3 
 block/fops.c                                                     |    5 
 drivers/accel/ivpu/ivpu_drv.c                                    |    8 
 drivers/accel/ivpu/ivpu_pm.c                                     |   86 -
 drivers/acpi/apei/ghes.c                                         |   10 
 drivers/acpi/prmt.c                                              |    4 
 drivers/acpi/property.c                                          |   10 
 drivers/ata/libata-sff.c                                         |   18 
 drivers/bluetooth/btusb.c                                        |    6 
 drivers/char/misc.c                                              |   39 
 drivers/char/tpm/eventlog/acpi.c                                 |   15 
 drivers/clk/clk-loongson2.c                                      |    5 
 drivers/clk/mediatek/clk-mt2701-aud.c                            |   10 
 drivers/clk/mediatek/clk-mt2701-bdp.c                            |    1 
 drivers/clk/mediatek/clk-mt2701-img.c                            |    1 
 drivers/clk/mediatek/clk-mt2701-mm.c                             |    1 
 drivers/clk/mediatek/clk-mt2701-vdec.c                           |    1 
 drivers/clk/mmp/pwr-island.c                                     |    2 
 drivers/clk/qcom/Kconfig                                         |    1 
 drivers/clk/qcom/clk-alpha-pll.c                                 |    2 
 drivers/clk/qcom/clk-rpmh.c                                      |    2 
 drivers/clk/qcom/dispcc-sm6350.c                                 |    7 
 drivers/clk/qcom/gcc-mdm9607.c                                   |    2 
 drivers/clk/qcom/gcc-sm6350.c                                    |   22 
 drivers/clk/qcom/gcc-sm8550.c                                    |    8 
 drivers/clk/qcom/gcc-sm8650.c                                    |    8 
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c                           |    6 
 drivers/cpufreq/Kconfig                                          |    2 
 drivers/cpufreq/cpufreq-dt-platdev.c                             |    2 
 drivers/cpufreq/s3c64xx-cpufreq.c                                |   11 
 drivers/crypto/qce/aead.c                                        |    2 
 drivers/crypto/qce/core.c                                        |   13 
 drivers/crypto/qce/sha.c                                         |    2 
 drivers/crypto/qce/skcipher.c                                    |    2 
 drivers/firmware/Kconfig                                         |    2 
 drivers/firmware/efi/libstub/Makefile                            |    2 
 drivers/firmware/qcom/qcom_scm.c                                 |   10 
 drivers/gpio/Kconfig                                             |    1 
 drivers/gpio/gpio-pca953x.c                                      |   19 
 drivers/gpio/gpio-sim.c                                          |   13 
 drivers/gpu/drm/Kconfig                                          |    4 
 drivers/gpu/drm/Makefile                                         |    1 
 drivers/gpu/drm/amd/amdgpu/Kconfig                               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h                          |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c                           |   11 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                         |    8 
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c                           |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                          |   25 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c            |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c                       |   25 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                            |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c           |    7 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   20 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c      |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c          |   22 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h          |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                         |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c            |    3 
 drivers/gpu/drm/amd/display/dc/dml2/Makefile                     |    4 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c          |   35 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h  |    6 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c               |   35 
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c             |    7 
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c        |    6 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c       |    3 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c       |    3 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c       |    3 
 drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c       |    3 
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c           |    8 
 drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c           |    2 
 drivers/gpu/drm/amd/display/dc/hubp/dcn32/dcn32_hubp.c           |    2 
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c         |   10 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c          |    3 
 drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c               |    1 
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c         |    4 
 drivers/gpu/drm/ast/ast_dp.c                                     |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                        |    2 
 drivers/gpu/drm/bridge/ite-it6505.c                              |   83 -
 drivers/gpu/drm/bridge/ite-it66121.c                             |    2 
 drivers/gpu/drm/display/drm_dp_cec.c                             |   14 
 drivers/gpu/drm/drm_client_modeset.c                             |    9 
 drivers/gpu/drm/drm_connector.c                                  |    1 
 drivers/gpu/drm/drm_edid.c                                       |    6 
 drivers/gpu/drm/drm_fb_helper.c                                  |   14 
 drivers/gpu/drm/drm_panel_backlight_quirks.c                     |   94 +
 drivers/gpu/drm/exynos/exynos_hdmi.c                             |    2 
 drivers/gpu/drm/i915/display/intel_dp.c                          |   10 
 drivers/gpu/drm/i915/display/intel_hdcp.c                        |   13 
 drivers/gpu/drm/i915/display/skl_universal_plane.c               |    4 
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                        |    6 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                |   20 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                         |   13 
 drivers/gpu/drm/msm/dp/dp_audio.c                                |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c                   |   16 
 drivers/gpu/drm/radeon/radeon_audio.c                            |    2 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                           |    9 
 drivers/gpu/drm/sti/sti_hdmi.c                                   |    2 
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c               |   33 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                   |    4 
 drivers/gpu/drm/virtio/virtgpu_drv.h                             |    7 
 drivers/gpu/drm/virtio/virtgpu_plane.c                           |   58 -
 drivers/gpu/drm/xe/regs/xe_oa_regs.h                             |    6 
 drivers/gpu/drm/xe/xe_devcoredump.c                              |   40 
 drivers/gpu/drm/xe/xe_devcoredump.h                              |    2 
 drivers/gpu/drm/xe/xe_gt.c                                       |    4 
 drivers/gpu/drm/xe/xe_gt_sriov_pf.c                              |   14 
 drivers/gpu/drm/xe/xe_gt_sriov_pf.h                              |    6 
 drivers/gpu/drm/xe/xe_guc_ct.c                                   |    3 
 drivers/gpu/drm/xe/xe_guc_log.c                                  |    4 
 drivers/gpu/drm/xe/xe_oa.c                                       |   12 
 drivers/hid/hid-asus.c                                           |   26 
 drivers/hid/hid-multitouch.c                                     |    5 
 drivers/hid/hid-sensor-hub.c                                     |   21 
 drivers/hid/wacom_wac.c                                          |    5 
 drivers/i2c/i2c-core-acpi.c                                      |   22 
 drivers/i3c/master.c                                             |    2 
 drivers/iio/chemical/bme680_core.c                               |    4 
 drivers/iio/dac/ad3552r-common.c                                 |    5 
 drivers/iio/dac/ad3552r-hs.c                                     |    6 
 drivers/iio/dac/ad3552r.h                                        |    8 
 drivers/iio/light/as73211.c                                      |   24 
 drivers/infiniband/hw/mlx5/mr.c                                  |   17 
 drivers/infiniband/hw/mlx5/odp.c                                 |    2 
 drivers/input/misc/nxp-bbnsm-pwrkey.c                            |    8 
 drivers/input/mouse/synaptics.c                                  |   56 -
 drivers/input/mouse/synaptics.h                                  |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c                      |   17 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                   |    8 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                       |    1 
 drivers/iommu/intel/iommu.c                                      |    7 
 drivers/iommu/iommufd/fault.c                                    |   44 
 drivers/iommu/iommufd/iommufd_private.h                          |   29 
 drivers/irqchip/Kconfig                                          |    1 
 drivers/irqchip/irq-apple-aic.c                                  |    3 
 drivers/irqchip/irq-mvebu-icu.c                                  |    3 
 drivers/leds/leds-lp8860.c                                       |    2 
 drivers/mailbox/tegra-hsp.c                                      |    6 
 drivers/mailbox/zynqmp-ipi-mailbox.c                             |    2 
 drivers/md/Kconfig                                               |   13 
 drivers/md/Makefile                                              |    2 
 drivers/md/dm-crypt.c                                            |   27 
 drivers/md/md-autodetect.c                                       |    8 
 drivers/md/md-linear.c                                           |  352 +++++++
 drivers/md/md.c                                                  |    2 
 drivers/media/i2c/ccs/ccs-core.c                                 |    6 
 drivers/media/i2c/ccs/ccs-data.c                                 |   14 
 drivers/media/i2c/ds90ub913.c                                    |    1 
 drivers/media/i2c/ds90ub953.c                                    |    1 
 drivers/media/i2c/ds90ub960.c                                    |  123 +-
 drivers/media/i2c/imx296.c                                       |    2 
 drivers/media/i2c/ov5640.c                                       |    1 
 drivers/media/pci/intel/ipu6/ipu6-isys.c                         |    1 
 drivers/media/platform/marvell/mmp-driver.c                      |   21 
 drivers/media/platform/nuvoton/npcm-video.c                      |    4 
 drivers/media/platform/qcom/venus/core.c                         |    8 
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c    |    2 
 drivers/media/usb/uvc/uvc_ctrl.c                                 |   83 +
 drivers/media/usb/uvc/uvc_driver.c                               |   98 -
 drivers/media/usb/uvc/uvc_v4l2.c                                 |    2 
 drivers/media/usb/uvc/uvc_video.c                                |   21 
 drivers/media/usb/uvc/uvcvideo.h                                 |   10 
 drivers/media/v4l2-core/v4l2-mc.c                                |    2 
 drivers/mfd/axp20x.c                                             |    2 
 drivers/mfd/lpc_ich.c                                            |    3 
 drivers/misc/fastrpc.c                                           |    8 
 drivers/mmc/core/sdio.c                                          |    2 
 drivers/mmc/host/sdhci-esdhc-imx.c                               |    1 
 drivers/mmc/host/sdhci-msm.c                                     |   53 +
 drivers/mtd/nand/onenand/onenand_base.c                          |    1 
 drivers/mtd/ubi/build.c                                          |    2 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                  |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c               |   16 
 drivers/net/ethernet/broadcom/tg3.c                              |   58 +
 drivers/net/ethernet/intel/ice/devlink/devlink.c                 |    3 
 drivers/net/ethernet/intel/ice/ice_txrx.c                        |  150 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.h                        |    1 
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h                    |   43 
 drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c           |   41 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c              |   19 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.h              |    6 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c                |   11 
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h                |    4 
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c                |    7 
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h                |    4 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c     |   29 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c        |   17 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h        |    6 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c          |    9 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h          |    2 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c          |    7 
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c              |   24 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c       |   17 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c   |   24 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                         |   67 -
 drivers/net/phy/nxp-c45-tja11xx.c                                |    2 
 drivers/net/tun.c                                                |    2 
 drivers/net/usb/ipheth.c                                         |   69 -
 drivers/net/vmxnet3/vmxnet3_xdp.c                                |   14 
 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c              |    5 
 drivers/net/wireless/ath/ath12k/mac.c                            |   57 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c          |    5 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c            |    8 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c     |    3 
 drivers/net/wireless/intel/iwlwifi/Makefile                      |    2 
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c                      |  167 +++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                     |   13 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                  |   10 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                    |   16 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c               |   21 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                 |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c                  |    3 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h              |    4 
 drivers/net/wireless/realtek/rtw88/main.h                        |    4 
 drivers/net/wireless/realtek/rtw88/rtw8703b.c                    |    8 
 drivers/net/wireless/realtek/rtw88/rtw8723x.h                    |    8 
 drivers/net/wireless/realtek/rtw88/rtw8821c.h                    |    9 
 drivers/net/wireless/realtek/rtw88/rtw8822b.h                    |    9 
 drivers/net/wireless/realtek/rtw88/rtw8822c.h                    |    9 
 drivers/net/wireless/realtek/rtw88/sdio.c                        |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                         |   16 
 drivers/net/wireless/realtek/rtw89/pci.h                         |    9 
 drivers/net/wireless/realtek/rtw89/pci_be.c                      |    1 
 drivers/net/wireless/realtek/rtw89/phy.c                         |   11 
 drivers/net/wireless/realtek/rtw89/phy.h                         |    2 
 drivers/net/wwan/iosm/iosm_ipc_pcie.c                            |   56 +
 drivers/nvme/host/core.c                                         |    8 
 drivers/nvme/host/fc.c                                           |    9 
 drivers/nvme/host/pci.c                                          |    4 
 drivers/nvme/host/sysfs.c                                        |    2 
 drivers/nvme/target/admin-cmd.c                                  |    1 
 drivers/nvmem/core.c                                             |    2 
 drivers/nvmem/imx-ocotp-ele.c                                    |   38 
 drivers/nvmem/qcom-spmi-sdam.c                                   |    1 
 drivers/of/address.c                                             |   12 
 drivers/of/base.c                                                |    8 
 drivers/of/of_reserved_mem.c                                     |    9 
 drivers/pci/controller/dwc/pcie-designware-ep.c                  |   46 
 drivers/pci/endpoint/pci-epf-core.c                              |    1 
 drivers/pci/tph.c                                                |    2 
 drivers/perf/fsl_imx9_ddr_perf.c                                 |   33 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                          |    2 
 drivers/pinctrl/samsung/pinctrl-samsung.c                        |    2 
 drivers/platform/x86/acer-wmi.c                                  |   45 
 drivers/platform/x86/intel/int3472/discrete.c                    |    3 
 drivers/platform/x86/intel/int3472/tps68470.c                    |    3 
 drivers/platform/x86/serdev_helpers.h                            |    4 
 drivers/ptp/ptp_clock.c                                          |    8 
 drivers/pwm/pwm-microchip-core.c                                 |    2 
 drivers/remoteproc/omap_remoteproc.c                             |   17 
 drivers/rtc/rtc-zynqmp.c                                         |    4 
 drivers/scsi/qla2xxx/qla_def.h                                   |    2 
 drivers/scsi/qla2xxx/qla_dfs.c                                   |  124 ++
 drivers/scsi/qla2xxx/qla_gbl.h                                   |    3 
 drivers/scsi/qla2xxx/qla_init.c                                  |   28 
 drivers/scsi/scsi_lib.c                                          |    9 
 drivers/scsi/st.c                                                |    6 
 drivers/scsi/st.h                                                |    1 
 drivers/scsi/storvsc_drv.c                                       |    1 
 drivers/soc/mediatek/mtk-devapc.c                                |   19 
 drivers/soc/qcom/llcc-qcom.c                                     |    1 
 drivers/soc/qcom/smem_state.c                                    |    3 
 drivers/soc/qcom/socinfo.c                                       |    2 
 drivers/soc/samsung/exynos-pmu.c                                 |    2 
 drivers/spi/atmel-quadspi.c                                      |  118 +-
 drivers/tty/serial/sh-sci.c                                      |   25 
 drivers/tty/serial/xilinx_uartps.c                               |    8 
 drivers/tty/vt/selection.c                                       |   14 
 drivers/tty/vt/vt.c                                              |    2 
 drivers/ufs/core/ufshcd.c                                        |   31 
 drivers/ufs/host/ufs-qcom.c                                      |   18 
 drivers/ufs/host/ufshcd-pci.c                                    |    2 
 drivers/ufs/host/ufshcd-pltfrm.c                                 |   28 
 drivers/usb/gadget/function/f_tcm.c                              |   54 -
 drivers/vfio/platform/vfio_platform_common.c                     |   10 
 fs/binfmt_flat.c                                                 |    2 
 fs/btrfs/ctree.c                                                 |    2 
 fs/btrfs/file.c                                                  |    2 
 fs/btrfs/ordered-data.c                                          |   12 
 fs/btrfs/qgroup.c                                                |    5 
 fs/btrfs/raid-stripe-tree.c                                      |   26 
 fs/btrfs/relocation.c                                            |   14 
 fs/btrfs/transaction.c                                           |    4 
 fs/ceph/mds_client.c                                             |   16 
 fs/exec.c                                                        |   29 
 fs/namespace.c                                                   |   50 -
 fs/netfs/read_collect.c                                          |   21 
 fs/netfs/read_pgpriv2.c                                          |    5 
 fs/nfs/Kconfig                                                   |    3 
 fs/nfs/flexfilelayout/flexfilelayout.c                           |   27 
 fs/nfsd/nfs4xdr.c                                                |   20 
 fs/nilfs2/inode.c                                                |    6 
 fs/ocfs2/super.c                                                 |    2 
 fs/ocfs2/symlink.c                                               |    5 
 fs/pidfs.c                                                       |   34 
 fs/proc/array.c                                                  |    2 
 fs/smb/client/cifsglob.h                                         |   14 
 fs/smb/client/dir.c                                              |    6 
 fs/smb/client/smb1ops.c                                          |    2 
 fs/smb/client/smb2inode.c                                        |  108 +-
 fs/smb/client/smb2ops.c                                          |   41 
 fs/smb/client/smb2pdu.c                                          |    2 
 fs/smb/client/smb2proto.h                                        |    2 
 fs/smb/server/transport_ipc.c                                    |    9 
 fs/xfs/xfs_exchrange.c                                           |   71 -
 fs/xfs/xfs_inode.c                                               |    7 
 fs/xfs/xfs_iomap.c                                               |    6 
 include/drm/drm_connector.h                                      |    5 
 include/drm/drm_utils.h                                          |    4 
 include/linux/binfmts.h                                          |    4 
 include/linux/call_once.h                                        |   45 
 include/linux/hrtimer_defs.h                                     |    1 
 include/linux/jiffies.h                                          |    2 
 include/linux/kvm_host.h                                         |    9 
 include/linux/mlx5/driver.h                                      |    1 
 include/linux/platform_data/x86/asus-wmi.h                       |    5 
 include/net/sch_generic.h                                        |    2 
 include/rv/da_monitor.h                                          |    4 
 include/trace/events/rxrpc.h                                     |    1 
 include/uapi/drm/amdgpu_drm.h                                    |    9 
 include/uapi/linux/input-event-codes.h                           |    1 
 include/uapi/linux/iommufd.h                                     |    4 
 include/uapi/linux/raid/md_p.h                                   |    2 
 include/uapi/linux/raid/md_u.h                                   |    2 
 include/ufs/ufs.h                                                |    4 
 include/ufs/ufshcd.h                                             |    1 
 io_uring/net.c                                                   |    5 
 io_uring/poll.c                                                  |    4 
 kernel/bpf/verifier.c                                            |    2 
 kernel/locking/test-ww_mutex.c                                   |    9 
 kernel/printk/printk.c                                           |    2 
 kernel/sched/core.c                                              |    6 
 kernel/sched/fair.c                                              |   19 
 kernel/seccomp.c                                                 |   12 
 kernel/time/hrtimer.c                                            |  103 +-
 kernel/time/timer_migration.c                                    |   10 
 kernel/trace/ring_buffer.c                                       |   13 
 kernel/trace/trace_functions_graph.c                             |    2 
 kernel/trace/trace_osnoise.c                                     |   17 
 lib/Kconfig.debug                                                |    8 
 lib/atomic64.c                                                   |   78 -
 lib/maple_tree.c                                                 |   23 
 mm/compaction.c                                                  |    3 
 mm/gup.c                                                         |   14 
 mm/hugetlb.c                                                     |   24 
 mm/kfence/core.c                                                 |    2 
 mm/kmemleak.c                                                    |    2 
 mm/vmscan.c                                                      |    7 
 net/bluetooth/l2cap_sock.c                                       |    7 
 net/bluetooth/mgmt.c                                             |   12 
 net/ethtool/ioctl.c                                              |    2 
 net/ethtool/rss.c                                                |    3 
 net/ipv4/udp.c                                                   |    4 
 net/ipv6/udp.c                                                   |    4 
 net/ncsi/ncsi-manage.c                                           |   13 
 net/nfc/nci/hci.c                                                |    2 
 net/rose/af_rose.c                                               |   24 
 net/rxrpc/ar-internal.h                                          |    2 
 net/rxrpc/call_object.c                                          |    6 
 net/rxrpc/conn_event.c                                           |   21 
 net/rxrpc/conn_object.c                                          |    1 
 net/rxrpc/input.c                                                |    2 
 net/rxrpc/sendmsg.c                                              |    2 
 net/sched/sch_fifo.c                                             |    3 
 net/sched/sch_netem.c                                            |    2 
 net/tipc/crypto.c                                                |    4 
 rust/kernel/init.rs                                              |    2 
 scripts/Makefile.extrawarn                                       |    5 
 scripts/gdb/linux/cpus.py                                        |    2 
 scripts/generate_rust_target.rs                                  |   18 
 security/keys/trusted-keys/trusted_dcp.c                         |   22 
 security/safesetid/securityfs.c                                  |    3 
 security/tomoyo/common.c                                         |    2 
 sound/pci/hda/hda_auto_parser.c                                  |    8 
 sound/pci/hda/hda_auto_parser.h                                  |    1 
 sound/pci/hda/patch_realtek.c                                    |   20 
 sound/soc/amd/Kconfig                                            |    2 
 sound/soc/amd/yc/acp6x-mach.c                                    |   28 
 sound/soc/intel/boards/sof_sdw.c                                 |    5 
 sound/soc/renesas/rz-ssi.c                                       |   10 
 sound/soc/soc-pcm.c                                              |   32 
 sound/soc/sof/intel/hda-dai.c                                    |   12 
 sound/soc/sof/intel/hda.c                                        |    5 
 tools/perf/bench/epoll-wait.c                                    |    7 
 tools/testing/selftests/bpf/progs/exceptions_fail.c              |    4 
 tools/testing/selftests/bpf/progs/preempt_lock.c                 |   14 
 tools/testing/selftests/bpf/progs/verifier_spin_lock.c           |    2 
 tools/testing/selftests/drivers/net/hw/rss_ctx.py                |    2 
 tools/testing/selftests/net/ipsec.c                              |    3 
 tools/testing/selftests/net/mptcp/mptcp_connect.c                |    2 
 tools/testing/selftests/net/udpgso.c                             |   26 
 tools/tracing/rtla/src/osnoise.c                                 |    2 
 tools/tracing/rtla/src/timerlat_hist.c                           |   26 
 tools/tracing/rtla/src/timerlat_top.c                            |   27 
 tools/tracing/rtla/src/trace.c                                   |    8 
 tools/tracing/rtla/src/trace.h                                   |    1 
 478 files changed, 5311 insertions(+), 2635 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Fix usb_2 controller interrupts

Abhinav Kumar (1):
      drm/msm/dpu: filter out too wide modes if no 3dmux is present

Alain Volmat (1):
      media: stm32: dcmipp: correct dma_set_mask_and_coherent mask value

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alexander Sverdlin (1):
      leds: lp8860: Write full EEPROM, not only half of it

Alice Ryhl (1):
      x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0

Anandu Krishnan E (1):
      misc: fastrpc: Deregister device nodes properly in error scenarios

Anastasia Belova (1):
      clk: qcom: clk-rpmh: prevent integer overflow in recalc_rate

Andre Przywara (1):
      Revert "mfd: axp20x: Allow multiple regulators"

Andreas Kemnade (2):
      cpufreq: fix using cpufreq-dt as module
      ARM: dts: ti/omap: gta04: fix pm issues caused by spi module

Andrew Halaney (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922

André Draszik (1):
      scsi: ufs: core: Fix use-after free in init error and remove paths

Andy Shevchenko (1):
      ACPI: property: Fix return value for nval == 0 in acpi_data_prop_read()

Angelo Dureghello (2):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag

Ankit Nautiyal (1):
      drm/i915/dp: fix the Adaptive sync Operation mode for SDP

Anshuman Khandual (1):
      arm64/mm: Ensure adequate HUGE_MAX_HSTATE

Antoine Viallon (1):
      ceph: fix memory leak in ceph_mds_auth_match()

Ard Biesheuvel (3):
      arm64/kvm: Configure HYP TCR.PS/DS based on host stage1
      arm64/mm: Override PARange for !LPA2 and use it consistently
      arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled

Aric Cyr (1):
      drm/amd/display: Optimize cursor position updates

Armin Wolf (3):
      platform/x86: acer-wmi: Add support for Acer PH14-51
      platform/x86: acer-wmi: Add support for Acer Predator PH16-72
      platform/x86: acer-wmi: Ignore AC events

Ashutosh Dixit (1):
      drm/xe/oa: Preserve oa_ctrl unused bits

Aubrey Li (1):
      ACPI: PRM: Remove unnecessary strict handler address checks

Ausef Yousof (2):
      drm/amd/display: Populate chroma prefetch parameters, DET buffer fix
      drm/amd/display: Overwriting dualDPP UBF values before usage

Bao D. Nguyen (1):
      scsi: ufs: core: Fix the HIGH/LOW_TEMP Bit Definitions

Bard Liao (1):
      ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params

Bart Van Assche (1):
      md: Fix linear_set_limits()

Bartosz Golaszewski (3):
      gpio: sim: lock hog configfs items if present
      crypto: qce - fix goto jump in error path
      crypto: qce - unregister previously registered algos in error path

Bence Csókás (1):
      spi: atmel-qspi: Memory barriers after memory-mapped I/O

Binbin Zhou (1):
      clk: clk-loongson2: Fix the number count of clk provider

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8821ae: Fix media status report

Borislav Petkov (1):
      APEI: GHES: Have GHES honor the panic= setting

Brad Griffis (1):
      arm64: tegra: Fix Tegra234 PCIe interrupt-map

Brian Geffon (1):
      drm/i915: Fix page cleanup on DMA remap failure

Carlos Llamas (1):
      lockdep: Fix upper limit for LOCKDEP_*_BITS configs

Catalin Marinas (1):
      mm: kmemleak: fix upper boundary check for physical address objects

Chao Gao (1):
      KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is active w/o VID

Chen-Yu Tsai (2):
      arm64: dts: mediatek: mt8183: Disable DPI display output by default
      arm64: dts: mediatek: mt8183: Disable DSI display output by default

Chih-Kang Chang (1):
      wifi: rtw89: add crystal_cap check to avoid setting as overflow value

Christian Brauner (2):
      pidfs: check for valid ioctl commands
      pidfs: improve ioctl handling

Christoph Hellwig (1):
      xfs: don't call remap_verify_area with sb write protection held

Chuck Lever (1):
      NFSD: Encode COMPOUND operation status on page boundaries

Ciprian Marian Costea (1):
      mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G

Claudiu Beznea (3):
      ASoC: renesas: rz-ssi: Terminate all the DMA transactions
      serial: sh-sci: Drop __initdata macro for port_cfg
      serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use

Cody Eksal (1):
      clk: sunxi-ng: a100: enable MMC clock reparenting

Cong Wang (1):
      netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()

Conor Dooley (1):
      pwm: microchip-core: fix incorrect comparison with max period

Cosmin Tanislav (1):
      media: mc: fix endpoint iteration

Csókás, Bence (1):
      spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families

Dan Carpenter (7):
      tipc: re-order conditions in tipc_crypto_key_rcv()
      binfmt_flat: Fix integer overflow bug on 32 bit systems
      ksmbd: fix integer overflows on 32 bit systems
      ASoC: renesas: rz-ssi: Add a check for negative sample_space
      iio: chemical: bme680: Fix uninitialized variable in __bme680_read_raw()
      NFC: nci: Add bounds checking in nci_hci_create_pipe()
      md/md-linear: Fix a NULL vs IS_ERR() bug in linear_add()

Daniel Golle (5):
      clk: mediatek: mt2701-vdec: fix conversion to mtk_clk_simple_probe
      clk: mediatek: mt2701-aud: fix conversion to mtk_clk_simple_probe
      clk: mediatek: mt2701-bdp: add missing dummy clk
      clk: mediatek: mt2701-img: add missing dummy clk
      clk: mediatek: mt2701-mm: add missing dummy clk

Daniel Wagner (2):
      nvme: handle connectivity loss in nvme_set_queue_count
      nvme-fc: use ctrl state getter

Daniele Ceraolo Spurio (1):
      drm/i915/guc: Debug print LRC state entries only if the context is pinned

Dave Young (1):
      x86/efi: skip memattr table on kexec boot

David Gstir (1):
      KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=y

David Hildenbrand (1):
      KVM: s390: vsie: fix some corner-cases when grabbing vsie pages

David Howells (2):
      rxrpc: Fix the rxrpc_connection attend queue handling
      rxrpc: Fix call state set to not include the SERVER_SECURING state

David Woodhouse (1):
      x86/kexec: Allocate PGD for x86_64 transition page tables separately

Denis Arefev (1):
      ubi: Add a check for ubi_num

Dmitry Antipov (1):
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

Dmitry Baryshkov (13):
      drm/tests: hdmi: handle empty modes in find_preferred_mode()
      drm/tests: hdmi: return meaningful value from set_connector_edid()
      drm/connector: add mutex to protect ELD from concurrent access
      drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
      drm/bridge: ite-it66121: use eld_mutex to protect access to connector->eld
      drm/amd/display: use eld_mutex to protect access to connector->eld
      drm/exynos: hdmi: use eld_mutex to protect access to connector->eld
      drm/msm/dp: use eld_mutex to protect access to connector->eld
      drm/radeon: use eld_mutex to protect access to connector->eld
      drm/sti: hdmi: use eld_mutex to protect access to connector->eld
      drm/vc4: hdmi: use eld_mutex to protect access to connector->eld
      arm64: dts: qcom: sm8550: correct MDSS interconnects
      arm64: dts: qcom: sm8650: correct MDSS interconnects

Dmitry Torokhov (1):
      Input: synaptics - fix crash when enabling pass-through port

Dongwon Kim (1):
      drm/virtio: New fence for every plane update

Dragan Simic (1):
      nfs: Make NFS_FSCACHE select NETFS_SUPPORT instead of depending on it

Dustin L. Howett (1):
      drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels

Easwar Hariharan (1):
      jiffies: Cast to unsigned long in secs_to_jiffies() conversion

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Positivo C6400

Ekansh Gupta (2):
      misc: fastrpc: Fix registered buffer page address
      misc: fastrpc: Fix copy buffer page size

En-Wei Wu (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925

Eric Biggers (2):
      scsi: ufs: qcom: Fix crypto key eviction
      crypto: qce - fix priority to be less than ARMv8 CE

Eric Dumazet (1):
      net: rose: lock the socket in rose_bind()

Even Xu (1):
      HID: Wacom: Add PCI Wacom device support

Eyal Birger (1):
      seccomp: passthrough uretprobe systemcall without filtering

Fangzhi Zuo (1):
      drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor

Fedor Pchelkin (2):
      Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection

Filipe Manana (3):
      btrfs: fix lockdep splat while merging a relocation root
      btrfs: fix assertion failure when splitting ordered extent after transaction abort
      btrfs: fix use-after-free when attempting to join an aborted transaction

Fiona Klute (1):
      wifi: rtw88: sdio: Fix disconnection after beacon loss

Florian Fainelli (1):
      net: bcmgenet: Correct overlaying of PHY and MAC Wake-on-LAN

Foster Snowhill (7):
      usbnet: ipheth: fix possible overflow in DPE length check
      usbnet: ipheth: use static NDP16 location in URB
      usbnet: ipheth: check that DPE points past NCM header
      usbnet: ipheth: refactor NCM datagram loop
      usbnet: ipheth: break up NCM header size computation
      usbnet: ipheth: fix DPE OoB read
      usbnet: ipheth: document scope of NCM implementation

Frank Li (1):
      i3c: master: Fix missing 'ret' assignment in set_speed()

Frederic Weisbecker (2):
      hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
      timers/migration: Fix off-by-one root mis-connection

Gabe Teeger (1):
      drm/amd/display: Limit Scaling Ratio on DCN3.01

Gabor Juhos (1):
      clk: qcom: clk-alpha-pll: fix alpha mode configuration

Gabriele Monaco (1):
      rv: Reset per-task monitors also for idle tasks

Geert Uytterhoeven (2):
      irqchip/lan966x-oic: Make CONFIG_LAN966X_OIC depend on CONFIG_MCHP_LAN966X_PCI
      gpio: GPIO_GRGPIO should depend on OF

Georg Gottleuber (2):
      nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
      nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

Greg Kroah-Hartman (1):
      Linux 6.13.3

Günther Noack (1):
      tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN

Hans Verkuil (1):
      gpu: drm_dp_cec: fix broken CEC adapter properties check

Hans de Goede (3):
      mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
      platform/x86: int3472: Check for adev == NULL
      platform/x86: serdev_helpers: Check for serial_ctrl_uid == NULL

Hao-ran Zheng (1):
      btrfs: fix data race when accessing the inode's disk_i_size at btrfs_drop_extents()

Haoxiang Li (1):
      drm/komeda: Add check for komeda_get_layer_fourcc_list()

Heiko Carstens (2):
      s390/futex: Fix FUTEX_OP_ANDN implementation
      s390/fpu: Add fpc exception handler / remove fixup section again

Heiko Stuebner (1):
      HID: hid-sensor-hub: don't use stale platform-data on remove

Helge Deller (1):
      parisc: Temporarily disable jump label support

Heming Zhao (1):
      ocfs2: fix incorrect CPU endianness conversion causing mount failure

Hermes Wu (5):
      drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
      drm/bridge: it6505: fix HDCP Bstatus check
      drm/bridge: it6505: fix HDCP encryption when R0 ready
      drm/bridge: it6505: fix HDCP CTS compare V matching
      drm/bridge: it6505: fix HDCP CTS KSV list wait timer

Hou Tao (2):
      dm-crypt: don't update io->sector after kcryptd_crypt_write_io_submit()
      dm-crypt: track tag_offset in convert_context

Hridesh MG (1):
      platform/x86: acer-wmi: add support for Acer Nitro AN515-58

Ido Schimmel (1):
      net: sched: Fix truncation of offloaded action statistics

Igor Pylypiv (1):
      scsi: core: Do not retry I/Os during depopulation

Illia Ostapyshyn (1):
      Input: allocate keycode for phone linking

Ivan Stepchenko (1):
      mtd: onenand: Fix uninitialized retlen in do_otp_read()

Jacek Lawrynowicz (4):
      accel/ivpu: Fix Qemu crash when running in passthrough
      accel/ivpu: Fix error handling in ivpu_boot()
      accel/ivpu: Clear runtime_error after pm_runtime_resume_and_get() fails
      accel/ivpu: Fix error handling in recovery/reset

Jacob Moroni (1):
      net: atlantic: fix warning during hot unplug

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma

Jakub Kicinski (3):
      ethtool: rss: fix hiding unsupported fields in dumps
      ethtool: ntuple: fix rss + ring_cookie check
      selftests: drv-net: rss_ctx: add missing cleanup in queue reconfigure

Jan Kiszka (1):
      scripts/gdb: fix aarch64 userspace detection in get_current_task

Jani Nikula (1):
      drm/i915/dp: Iterate DSC BPP from high to low on all platforms

Jarkko Sakkinen (1):
      tpm: Change to kvalloc() in eventlog/acpi.c

Javier Carrasco (2):
      iio: light: as73211: fix channel handling in only-color triggered buffer
      pinctrl: samsung: fix fwnode refcount cleanup if platform_get_irq_optional() fails

Jay Cornwall (1):
      drm/amdkfd: Block per-queue reset when halt_if_hws_hang=1

Jeff Layton (1):
      fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()

Jennifer Berringer (1):
      nvmem: core: improve range check for nvmem_cell_write()

Jens Axboe (2):
      block: don't revert iter for -EIOCBQUEUED
      io_uring/net: don't retry connect operation on EPOLLERR

Jeongjun Park (1):
      ring-buffer: Make reading page consistent with the code logic

Jiasheng Jiang (1):
      ice: Add check for devm_kzalloc()

Jiaxun Yang (1):
      MIPS: pci-legacy: Override pci_address_to_pio

Johannes Thumshirn (1):
      btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents

Josef Bacik (1):
      btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling

Juergen Gross (2):
      x86/xen: fix xen_hypercall_hvm() to not clobber %rbx
      x86/xen: add FRAME_END to xen_hypercall_hvm()

K Prateek Nayak (1):
      sched/fair: Fix inaccurate h_nr_runnable accounting with delayed dequeue

Kai Mäkisara (1):
      scsi: st: Don't set pos_unknown just after device recognition

Kalle Valo (1):
      wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'

Karol Przybylski (1):
      wifi: ath12k: Fix for out-of bound access error

Kees Bakker (1):
      iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Kees Cook (1):
      exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case

Keith Busch (2):
      nvme: make nvme_tls_attrs_group static
      kvm: defer huge page recovery vhost task to later

Kenneth Feng (1):
      drm/amd/amdgpu: change the config of cgcg on gfx12

Kexy Biscuit (1):
      MIPS: Loongson64: remove ROM Size unit in boardinfo

Konrad Dybcio (2):
      clk: qcom: Make GCC_8150 depend on QCOM_GDSC
      soc: qcom: llcc: Enable LLCC_WRCACHE at boot on X1

Krzysztof Kozlowski (29):
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
      firmware: qcom: scm: Fix missing read barrier in qcom_scm_get_tzmem_pool()
      arm64: dts: qcom: sdx75: Fix MPSS memory length
      arm64: dts: qcom: x1e80100: Fix ADSP memory base and length
      arm64: dts: qcom: x1e80100: Fix CDSP memory length
      arm64: dts: qcom: sm6115: Fix MPSS memory length
      arm64: dts: qcom: sm6115: Fix CDSP memory length
      arm64: dts: qcom: sm6115: Fix ADSP memory base and length
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      arm64: dts: qcom: sm6375: Fix ADSP memory length
      arm64: dts: qcom: sm6375: Fix CDSP memory base and length
      arm64: dts: qcom: sm6375: Fix MPSS memory base and length
      arm64: dts: qcom: sm8350: Fix ADSP memory base and length
      arm64: dts: qcom: sm8350: Fix CDSP memory base and length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix ADSP memory base and length
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      arm64: dts: qcom: sm8550: Fix ADSP memory base and length
      arm64: dts: qcom: sm8550: Fix CDSP memory length
      arm64: dts: qcom: sm8550: Fix MPSS memory length
      arm64: dts: qcom: sm8650: Fix ADSP memory base and length
      arm64: dts: qcom: sm8650: Fix CDSP memory length
      arm64: dts: qcom: sm8650: Fix MPSS memory length
      soc: samsung: exynos-pmu: Fix uninitialized ret in tensor_set_bits_atomic()
      soc: mediatek: mtk-devapc: Fix leaking IO map on error paths
      soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove
      soc: qcom: smem_state: fix missing of_node_put in error path

Kuan-Wei Chiu (3):
      printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      perf bench: Fix undefined behavior in cmpworker()
      ALSA: hda: Fix headset detection failure due to unstable sort

Kumar Kartikeya Dwivedi (1):
      bpf: Improve verifier log for resource leak on exit

Kuninori Morimoto (1):
      ASoC: soc-pcm: don't use soc_pcm_ret() on .prepare callback

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Fix PFC_MASK for RZ/V2H and RZ/G3E

Lenny Szubowicz (1):
      tg3: Disable tg3 PCIe AER on system reboot

Leo Stone (1):
      safesetid: check size of policy writes

Li Zhijian (1):
      mm/vmscan: accumulate nr_demoted for accurate demotion statistics

Lijo Lazar (1):
      drm/amd/pm: Mark MM activity as unsupported

Liu Shixin (1):
      mm/compaction: fix UBSAN shift-out-of-bounds warning

Liu Ye (1):
      selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()

Lo-an Chen (1):
      drm/amd/display: Fix seamless boot sequence

Long Li (1):
      scsi: storvsc: Set correct data length for sending SCSI command without payload

Lubomir Rintel (2):
      clk: mmp2: call pm_genpd_init() only after genpd.name is set
      media: mmp: Bring back registration of the device

Luca Weiss (4):
      clk: qcom: gcc-sm6350: Add missing parent_map for two clocks
      clk: qcom: dispcc-sm6350: Add missing parent_map for a clock
      arm64: dts: qcom: sm6350: Fix uart1 interconnect path
      nvmem: qcom-spmi-sdam: Set size in struct nvmem_config

Lucas De Marchi (2):
      drm/xe/devcoredump: Move exec queue snapshot to Contexts section
      drm/xe: Fix and re-enable xe_print_blob_ascii85()

Luke D. Jones (1):
      HID: hid-asus: Disable OOBE mode on the ProArt P16

Maarten Lankhorst (2):
      drm/modeset: Handle tiled displays in pan_display_atomic.
      drm/client: Handle tiled displays better

Maciej Fijalkowski (3):
      ice: put Rx buffers after being done with current frame
      ice: gather page_count()'s of each frag right before XDP prog call
      ice: stop storing XDP verdict within ice_rx_buf

Maciej S. Szmigiero (1):
      net: wwan: iosm: Fix hibernation by re-binding the driver around it

Manivannan Sadhasivam (2):
      clk: qcom: gcc-sm8550: Do not turn off PCIe GDSCs during gdsc_disable()
      clk: qcom: gcc-sm8650: Do not turn off PCIe GDSCs during gdsc_disable()

Marc Zyngier (2):
      arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented
      KVM: arm64: timer: Always evaluate the need for a soft timer

Marcel Hamer (1):
      wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

Marco Elver (1):
      kfence: skip __GFP_THISNODE allocations on NUMA systems

Marek Olšák (1):
      drm/amdgpu: add a BO metadata flag to disable write compression for Vulkan

Mario Limonciello (1):
      ASoC: acp: Support microphone from Lenovo Go S

Mark Brown (1):
      arm64/sme: Move storage of reg_smidr to __cpuinfo_store_cpu()

Mark Dietzer (1):
      Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x

Mark Tomlinson (1):
      gpio: pca953x: Improve interrupt support

Mateusz Jończyk (1):
      mips/math-emu: fix emulation of the prefx instruction

Matthew Wilcox (Oracle) (1):
      ocfs2: handle a symlink read error correctly

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: connect: -f: no reconnect

Max Kellermann (2):
      fs/netfs/read_pgpriv2: skip folio queues without `marks3`
      fs/netfs/read_collect: fix crash due to uninitialized `prev` variable

Mazin Al Haddad (1):
      Bluetooth: MGMT: Fix slab-use-after-free Read in mgmt_remove_adv_monitor_sync

Meetakshi Setiya (1):
      smb: client: change lease epoch type from unsigned int to __u16

Mehdi Djait (1):
      media: ccs: Fix cleanup order in ccs_probe()

Michal Simek (1):
      rtc: zynqmp: Fix optional clock name property

Michal Wajdeczko (1):
      drm/xe/pf: Fix migration initialization

Miguel Ojeda (1):
      rust: init: use explicit ABI to clean warning in future compilers

Mike Snitzer (1):
      pnfs/flexfiles: retry getting layout segment for reads

Miklos Szeredi (2):
      statmount: let unset strings be empty
      fs: fix adding security options to statmount.mnt_opt

Milos Reljin (1):
      net: phy: c45-tjaxx: add delay between MDIO write and read in soft_reset

Ming Lei (1):
      block: mark GFP_NOIO around sysfs ->store()

Miri Korenblit (1):
      wifi: iwlwifi: avoid memory leak

Nam Cao (1):
      fs/proc: do_task_stat: Fix ESP not readable during coredump

Narayana Murty N (1):
      powerpc/pseries/eeh: Fix get PE state translation

Nathan Chancellor (4):
      drm/amd/display: Increase sanitizer frame larger than limit when compile testing with clang
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15
      kbuild: Move -Wenum-enum-conversion to W=2
      x86/boot: Use '-std=gnu11' to fix build with GCC 15

Naushir Patuck (1):
      media: imx296: Add standby delay during probe

Nick Chan (1):
      irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured so

Nick Morrow (1):
      wifi: mt76: mt7921u: Add VID/PID for TP-Link TXE50UH

Nicolin Chen (4):
      iommufd: Fix struct iommu_hwpt_pgfault init and padding
      iommu/tegra241-cmdqv: Read SMMU IDR1.CMDQS instead of hardcoding
      iommufd/fault: Destroy response and mutex in iommufd_fault_destroy()
      iommufd/fault: Use a separate spinlock to protect fault->deliver list

Nikita Zhandarovich (1):
      nilfs2: fix possible int overflows in nilfs_fiemap()

Niklas Cassel (3):
      PCI: dwc: ep: Write BAR_MASK before iATU registers in pci_epc_set_bar()
      PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
      ata: libata-sff: Ensure that we cannot write outside the allocated buffer

Niklas Schnelle (1):
      s390/pci: Fix SR-IOV for PFs initially in standby

Pali Rohár (1):
      cifs: Remove intermediate object of failed create SFU call

Paul Fertser (1):
      net/ncsi: wait for the last response to Deselect Package before configuring channel

Pavel Begunkov (1):
      io_uring: fix multishots with selected buffers

Pekka Pessi (1):
      mailbox: tegra-hsp: Clear mailbox before using message

Peng Fan (1):
      Input: bbnsm_pwrkey - add remove hook

Peter Xu (1):
      mm/hugetlb: fix avoid_reserve to allow taking folio from subpool

Peter Zijlstra (2):
      x86: Convert unreachable() to BUG()
      x86/mm: Convert unreachable() to BUG()

Philip Yang (2):
      drm/amdgpu: Don't enable sdma 4.4.5 CTXEMPTY interrupt
      drm/amdkfd: Queue interrupt work to different CPU

Ping-Ke Shih (2):
      wifi: rtw88: add __packed attribute to efuse layout struct
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

Prasad Pandit (1):
      firmware: iscsi_ibft: fix ISCSI_IBFT Kconfig entry

Prike Liang (1):
      drm/amdkfd: only flush the validate MES contex

Qu Wenruo (1):
      btrfs: do not output error message if a qgroup has been already cleaned up

Quang Le (1):
      pfifo_tail_enqueue: Drop new packet when sch->limit == 0

Quinn Tran (1):
      scsi: qla2xxx: Move FCE Trace buffer allocation to user control

Randolph Ha (1):
      i2c: Force ELAN06FA touchpad I2C bus freq to 100KHz

Ricardo Ribalda (6):
      media: uvcvideo: Fix crash during unbind if gpio unit is in use
      media: uvcvideo: Fix event flags in uvc_ctrl_send_events
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove redundant NULL assignment
      media: uvcvideo: Remove dangling pointers

Richard Acayan (1):
      iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible

Ritesh Harjani (IBM) (1):
      mm/hugetlb: fix hugepage allocation for interleaved memory nodes

Robin Murphy (3):
      iommu/arm-smmu-v3: Clean up more on probe failure
      PCI/TPH: Restore TPH Requester Enable correctly
      remoteproc: omap: Handle ARM dma_iommu_mapping

Rodrigo Siqueira (1):
      Revert "drm/amd/display: Fix green screen issue after suspend"

Roger Quadros (1):
      net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path

Romain Naour (1):
      ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus

Ruben Devos (1):
      smb: client: fix order of arguments of tracepoints

Sagi Grimberg (1):
      nvmet: fix a memory leak in controller identify

Sakari Ailus (3):
      media: ccs: Clean up parsed CCS static data on parse failure
      media: Documentation: tx-rx: Fix formatting
      media: ccs: Fix CCS static data parsing for large block sizes

Sam Bobrowicz (1):
      media: ov5640: fix get_light_freq on auto

Sankararaman Jayaraman (1):
      vmxnet3: Fix tx queue race condition with XDP

Sascha Hauer (4):
      nvmem: imx-ocotp-ele: simplify read beyond device check
      nvmem: imx-ocotp-ele: fix MAC address byte order
      nvmem: imx-ocotp-ele: fix reading from non zero offset
      nvmem: imx-ocotp-ele: set word length to 1

Satya Priya Kakitapalli (1):
      clk: qcom: gcc-mdm9607: Fix cmd_rcgr offset for blsp1_uart6 rcg

Sean Anderson (1):
      tty: xilinx_uartps: split sysrq handling

Sean Christopherson (2):
      KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
      KVM: x86/mmu: Ensure NX huge page recovery thread is alive before waking

Sebastian Wiese-Wagner (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14s-fq1xxx

Sergey Senozhatsky (1):
      media: venus: destroy hfi session after m2m_ctx release

Shawn Lin (1):
      mmc: core: Respect quirk_max_rate for non-UHS SDIO card

Shayne Chen (1):
      wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz on MT7916

Shinas Rasheed (2):
      octeon_ep: update tx/rx stats locally for persistence
      octeon_ep_vf: update tx/rx stats locally for persistence

Simon Trimmer (1):
      ASoC: Intel: sof_sdw: Correct quirk for Lenovo Yoga Slim 7

Somashekhar(Som) (1):
      wifi: iwlwifi: pcie: Add support for new device ids

Stanislaw Gruszka (1):
      media: intel/ipu6: remove cpu latency qos request on error

Stas Sergeev (1):
      tun: fix group permission check

Stefan Dösinger (1):
      wifi: brcmfmac: Check the return value of of_property_read_string_index()

Stefan Eichenberger (1):
      irqchip/irq-mvebu-icu: Fix access to msi_data from irq_domain::host_data

Stephan Gerhold (8):
      arm64: dts: qcom: x1e80100-asus-vivobook-s15: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e80100-dell-xps13-9345: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e80100-qcp: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e80100-crd: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Fix USB QMP PHY supplies
      arm64: dts: qcom: x1e80100-microsoft-romulus: Fix USB QMP PHY supplies
      soc: qcom: socinfo: Avoid out of bounds read of serial number

Steven Rostedt (4):
      ring-buffer: Do not allow events in NMI with generic atomic64 cmpxchg()
      atomic64: Use arch_spin_locks instead of raw_spin_locks
      fgraph: Fix set_graph_notrace with setting TRACE_GRAPH_NOTRACE_BIT
      tracing/osnoise: Fix resetting of tracepoints

Suleiman Souhlal (1):
      sched: Don't try to catch up excess steal time.

Sumit Gupta (2):
      arm64: tegra: Fix typo in Tegra234 dce-fabric compatible
      arm64: tegra: Disable Tegra234 sce-fabric node

Suraj Kandpal (1):
      drm/i915/hdcp: Fix Repeater authentication during topology change

Sven Schnelle (1):
      s390/stackleak: Use exrl instead of ex in __stackleak_poison()

Takashi Iwai (2):
      ALSA: hda/realtek: Fix quirk matching for Legion Pro 7
      ALSA: hda/realtek: Workaround for resume on Dell Venue 11 Pro 7130

Tetsuo Handa (1):
      tomoyo: don't emit warning in tomoyo_write_control()

Thadeu Lima de Souza Cascardo (1):
      Revert "media: uvcvideo: Require entities to have a non-zero unique ID"

Thinh Nguyen (4):
      usb: gadget: f_tcm: Translate error to sense
      usb: gadget: f_tcm: Decrement command ref count on cleanup
      usb: gadget: f_tcm: ep_autoconfig with fullspeed endpoint
      usb: gadget: f_tcm: Don't prepare BOT write request twice

Thomas Weißschuh (5):
      drm: Add panel backlight quirks
      drm/amd/display: Add support for minimum backlight quirk
      drm: panel-backlight-quirks: Add Framework 13 matte panel
      of: address: Fix empty resource handling in __of_address_resource_bounds()
      ptp: Ensure info->enable callback is always set

Thomas Zimmermann (3):
      m68k: vga: Fix I/O defines
      drm/rockchip: cdn-dp: Use drm_connector_helper_hpd_irq_event()
      drm/ast: astdp: Fix timeout for enabling video signal

Thorsten Blum (1):
      locking/ww_mutex/test: Use swap() macro

Tiezhu Yang (1):
      LoongArch: Extend the maximum number of watchpoints

Tom Chung (1):
      Revert "drm/amd/display: Use HW lock mgr for PSR1"

Tomas Glozar (6):
      rtla/osnoise: Distinguish missing workload option
      rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
      rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
      rtla: Add trace_instance_stop
      rtla/timerlat_hist: Stop timerlat tracer on signal
      rtla/timerlat_top: Stop timerlat tracer on signal

Tomi Valkeinen (5):
      media: i2c: ds90ub960: Fix UB9702 refclk register access
      media: i2c: ds90ub9x3: Fix extra fwnode_handle_put()
      media: i2c: ds90ub960: Fix use of non-existing registers on UB9702
      media: i2c: ds90ub960: Fix UB9702 VC map
      media: i2c: ds90ub960: Fix logging SP & EQ status only for UB9702

Uros Bizjak (1):
      mailbox: zynqmp: Remove invalid __percpu annotation in zynqmp_ipi_probe()

Vadim Fedorenko (1):
      net/mlx5: use do_aux_work for PHC overflow checks

Vasily Khoruzhick (1):
      wifi: rtw88: 8703b: Fix RX/TX issues

Ville Syrjälä (1):
      drm/i915: Drop 64bpp YUV formats from ICL+ SDR planes

Vimal Agrawal (1):
      misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors

Viresh Kumar (1):
      cpufreq: s3c64xx: Fix compilation warning

WangYuli (1):
      MIPS: ftrace: Declare ftrace_get_parent_ra_addr() as static

Wei Yang (1):
      maple_tree: simplify split calculation

Wentao Liang (2):
      xfs: Propagate errors from xfs_reflink_cancel_cow_range in xfs_dax_write_iomap_end
      xfs: Add error handling for xfs_reflink_cancel_cow_range

Werner Sembach (1):
      PCI: Avoid putting some root ports into D3 on TUXEDO Sirius Gen1

Willem de Bruijn (1):
      tun: revert fix group permission check

Xi Ruoyao (1):
      Revert "MIPS: csrc-r4k: Select HAVE_UNSTABLE_SCHED_CLOCK if SMP && 64BIT"

Xu Yang (1):
      perf: imx9_perf: Introduce AXI filter version to refactor the driver and better extension

Yan Zhai (1):
      udp: gso: do not drop small packets when PMTU reduces

Yazen Ghannam (1):
      x86/amd_nb: Restrict init function to AMD-based systems

Yevgeny Kliteynik (2):
      net/mlx5: HWS, change error flow on matcher disconnect
      net/mlx5: HWS, num_of_rules counter on matcher should be atomic

Yishai Hadas (1):
      RDMA/mlx5: Fix a race for an ODP MR which leads to CQE with error

Youwan Wang (1):
      HID: multitouch: Add quirk for Hantick 5288 touchpad

Yu Kuai (1):
      md: reintroduce md-linear

Yu-Chun Lin (1):
      ASoC: amd: Add ACPI dependency to fix build error

Yuanjie Yang (1):
      mmc: sdhci-msm: Correctly set the load for the regulator

Zhang Rui (1):
      x86/acpi: Fix LAPIC/x2APIC parsing order

Zhaoyang Huang (1):
      mm: gup: fix infinite loop within __get_longterm_locked

Zhen Lei (1):
      media: nuvoton: Fix an error check in npcm_video_ece_init()

Zhi Wang (2):
      nvkm/gsp: correctly advance the read pointer of GSP message queue
      nvkm: correctly calculate the available space of the GSP cmdq buffer

Zijun Hu (6):
      blk-cgroup: Fix class @block_class's subsystem refcount leakage
      of: Correct child specifier used as input of the 2nd nexus node
      of: Fix of_find_node_opts_by_path() handling of alias+path+options
      of: reserved-memory: Fix using wrong number of cells to get property 'alignment'
      of: reserved-memory: Warn for missing static reserved memory regions
      PCI: endpoint: Finish virtual EP removal in pci_epf_remove_vepf()


