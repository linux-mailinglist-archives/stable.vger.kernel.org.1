Return-Path: <stable+bounces-185779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF25BDDF8E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314293BDA21
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31F31BCAB;
	Wed, 15 Oct 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSX+hBLx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B731D39B;
	Wed, 15 Oct 2025 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523967; cv=none; b=DbsmAK1gr+FlPM3A+U5W1kUdXjJBxPRAH18qlyrYmF2akCsTLG1pm4lv7gEA863385FiNY3Eb8ykzKo0F976y3myoysp8XaPdBxXsPXlDh8Ln4VFxb10UjVc5i835UOLFQ1uz0U5oTnr5oZbpVxQLlm9I2Rwn88kWjDjAnIWUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523967; c=relaxed/simple;
	bh=bX8GmnpYne8dqv1sO7OkMSjOz/m6QBAsQrQ1Bh98vdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6UCBFqb0B79IlL8aMHUXUg321QbJhzqtuLIojXyevAQZXAtm0nTTL6GJMr+09SSMzwFqhHE/5tTR8/Y5NcIKsEyKq8bjKcvHWkfOiIfWcb+AeB4ntiqZvj80Ng9K3gIMdt7lf1k5XtnSyDd1T85Sw9XK8Is6a4zW51oQWYOeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSX+hBLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9C1C4CEF8;
	Wed, 15 Oct 2025 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760523966;
	bh=bX8GmnpYne8dqv1sO7OkMSjOz/m6QBAsQrQ1Bh98vdg=;
	h=From:To:Cc:Subject:Date:From;
	b=XSX+hBLxcAwIzQ2PPQ+PoWzXZeQ2rw070pYpdwSAgVJhZ62wOQfQXLVWe05mECnZm
	 H5fW3RbUOPFFZl33lt9vwjyu0qxjmXbwdAs7VSSHanVPrjTj9HVERbCNBV5iYPoHQi
	 mD63reNhtZvklXJfDN+PoiDvcNf7xWhz+XLBZArY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.17.3
Date: Wed, 15 Oct 2025 12:25:48 +0200
Message-ID: <2025101549-duffel-banner-7b5b@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.17.3 kernel.

All users of the 6.17 kernel series must upgrade.

The updated 6.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.17.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/vendor-prefixes.yaml               |   50 +
 Documentation/iio/ad3552r.rst                                        |    3 
 Documentation/trace/histogram-design.rst                             |    4 
 Makefile                                                             |    2 
 arch/alpha/kernel/process.c                                          |    2 
 arch/arc/kernel/process.c                                            |    2 
 arch/arm/boot/dts/renesas/r8a7791-porter.dts                         |    2 
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts                          |    2 
 arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi                         |    2 
 arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts                         |    2 
 arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi           |    2 
 arch/arm/kernel/process.c                                            |    2 
 arch/arm/mach-at91/pm_suspend.S                                      |    4 
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts              |   25 
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts              |   11 
 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts            |    8 
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi                          |    2 
 arch/arm64/boot/dts/apple/t6000-j314s.dts                            |    8 
 arch/arm64/boot/dts/apple/t6000-j316s.dts                            |    8 
 arch/arm64/boot/dts/apple/t6001-j314c.dts                            |    8 
 arch/arm64/boot/dts/apple/t6001-j316c.dts                            |    8 
 arch/arm64/boot/dts/apple/t6001-j375c.dts                            |    8 
 arch/arm64/boot/dts/apple/t6002-j375d.dts                            |    8 
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi                       |   10 
 arch/arm64/boot/dts/apple/t600x-j375.dtsi                            |   11 
 arch/arm64/boot/dts/apple/t8103-j457.dts                             |   12 
 arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts             |   32 -
 arch/arm64/boot/dts/freescale/imx95.dtsi                             |    4 
 arch/arm64/boot/dts/mediatek/mt6331.dtsi                             |   10 
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts               |    2 
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi                            |   12 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                       |   14 
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts                      |   14 
 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi              |    8 
 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts |    4 
 arch/arm64/boot/dts/mediatek/mt8188.dtsi                             |    2 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                             |    3 
 arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts        |   16 
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts                      |    2 
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                                |    1 
 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts                |    6 
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts                   |    6 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi                        |    5 
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts                     |  118 +++-
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi                      |   10 
 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts                     |    6 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                           |    2 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                       |    2 
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi                     |   12 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                              |   12 
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts                             |   14 
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi                          |    2 
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                              |    8 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                       |    8 
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi                      |   22 
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                              |   22 
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                               |   22 
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi                          |   16 
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi                       |   18 
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi                   |   10 
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts                       |   10 
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts                       |   22 
 arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi                      |   34 -
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi                           |   34 -
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                                |   48 -
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi                          |   18 
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts                   |   40 -
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                               |   40 -
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi                          |   38 -
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi                         |   34 -
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                              |   22 
 arch/arm64/boot/dts/ti/k3-j742s2-mcu-wakeup.dtsi                     |   17 
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi                                |    1 
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                             |    4 
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi              |   44 -
 arch/arm64/boot/dts/ti/k3-pinctrl.h                                  |    4 
 arch/arm64/kernel/process.c                                          |    2 
 arch/arm64/net/bpf_jit_comp.c                                        |    3 
 arch/csky/kernel/process.c                                           |    2 
 arch/hexagon/kernel/process.c                                        |    2 
 arch/loongarch/kernel/process.c                                      |    2 
 arch/loongarch/kernel/relocate.c                                     |    4 
 arch/loongarch/net/bpf_jit.c                                         |   80 ++
 arch/m68k/kernel/process.c                                           |    2 
 arch/microblaze/kernel/process.c                                     |    2 
 arch/mips/kernel/process.c                                           |    2 
 arch/nios2/kernel/process.c                                          |    2 
 arch/openrisc/kernel/process.c                                       |    2 
 arch/parisc/kernel/process.c                                         |    2 
 arch/powerpc/Kconfig                                                 |    4 
 arch/powerpc/Makefile                                                |    2 
 arch/powerpc/include/asm/book3s/32/pgalloc.h                         |   10 
 arch/powerpc/include/asm/nohash/pgalloc.h                            |    2 
 arch/powerpc/include/asm/topology.h                                  |    2 
 arch/powerpc/kernel/head_8xx.S                                       |    9 
 arch/powerpc/kernel/module_64.c                                      |    2 
 arch/powerpc/kernel/process.c                                        |    2 
 arch/powerpc/kernel/smp.c                                            |   27 
 arch/powerpc/kernel/trace/ftrace.c                                   |   10 
 arch/riscv/kernel/process.c                                          |    2 
 arch/riscv/kvm/vmid.c                                                |    3 
 arch/riscv/net/bpf_jit_comp64.c                                      |   42 +
 arch/s390/kernel/process.c                                           |    2 
 arch/s390/kernel/topology.c                                          |   20 
 arch/s390/net/bpf_jit_comp.c                                         |   42 +
 arch/sh/kernel/process_32.c                                          |    2 
 arch/sparc/kernel/process_32.c                                       |    2 
 arch/sparc/kernel/process_64.c                                       |    2 
 arch/sparc/lib/M7memcpy.S                                            |   20 
 arch/sparc/lib/Memcpy_utils.S                                        |    9 
 arch/sparc/lib/NG4memcpy.S                                           |    2 
 arch/sparc/lib/NGmemcpy.S                                            |   29 -
 arch/sparc/lib/U1memcpy.S                                            |   19 
 arch/sparc/lib/U3memcpy.S                                            |    2 
 arch/um/kernel/process.c                                             |    2 
 arch/x86/events/intel/bts.c                                          |    2 
 arch/x86/events/intel/core.c                                         |    3 
 arch/x86/include/asm/fpu/sched.h                                     |    2 
 arch/x86/include/asm/segment.h                                       |    8 
 arch/x86/include/asm/shstk.h                                         |    4 
 arch/x86/kernel/fpu/core.c                                           |    2 
 arch/x86/kernel/process.c                                            |    2 
 arch/x86/kernel/shstk.c                                              |    2 
 arch/x86/kernel/smpboot.c                                            |    8 
 arch/x86/kvm/svm/svm.c                                               |   12 
 arch/xtensa/kernel/process.c                                         |    2 
 block/bfq-iosched.c                                                  |   22 
 block/bio.c                                                          |    2 
 block/blk-cgroup.c                                                   |    6 
 block/blk-cgroup.h                                                   |   12 
 block/blk-core.c                                                     |   19 
 block/blk-iolatency.c                                                |   14 
 block/blk-merge.c                                                    |   64 +-
 block/blk-mq-sched.c                                                 |   14 
 block/blk-mq-sched.h                                                 |   13 
 block/blk-mq-sysfs.c                                                 |    6 
 block/blk-mq-tag.c                                                   |   23 
 block/blk-mq.c                                                       |   84 +--
 block/blk-mq.h                                                       |   18 
 block/blk-settings.c                                                 |   44 -
 block/blk-sysfs.c                                                    |   57 +-
 block/blk-throttle.c                                                 |   15 
 block/blk-throttle.h                                                 |   18 
 block/blk.h                                                          |   45 -
 block/elevator.c                                                     |    3 
 block/elevator.h                                                     |    2 
 block/kyber-iosched.c                                                |   19 
 block/mq-deadline.c                                                  |   16 
 crypto/842.c                                                         |    6 
 crypto/asymmetric_keys/x509_cert_parser.c                            |   16 
 crypto/lz4.c                                                         |    6 
 crypto/lz4hc.c                                                       |    6 
 crypto/lzo-rle.c                                                     |    6 
 crypto/lzo.c                                                         |    6 
 drivers/accel/amdxdna/aie2_ctx.c                                     |    6 
 drivers/acpi/acpica/aclocal.h                                        |    2 
 drivers/acpi/nfit/core.c                                             |    2 
 drivers/acpi/processor_idle.c                                        |    3 
 drivers/base/node.c                                                  |    4 
 drivers/base/power/main.c                                            |   14 
 drivers/base/regmap/regmap.c                                         |    2 
 drivers/block/nbd.c                                                  |    8 
 drivers/block/null_blk/main.c                                        |    2 
 drivers/bluetooth/btintel_pcie.c                                     |  220 ++-----
 drivers/bluetooth/btintel_pcie.h                                     |    2 
 drivers/bus/fsl-mc/fsl-mc-bus.c                                      |    3 
 drivers/cdx/Kconfig                                                  |    1 
 drivers/cdx/cdx.c                                                    |    4 
 drivers/cdx/controller/Kconfig                                       |    1 
 drivers/cdx/controller/cdx_controller.c                              |    3 
 drivers/char/hw_random/Kconfig                                       |    1 
 drivers/char/hw_random/ks-sa-rng.c                                   |    4 
 drivers/char/tpm/Kconfig                                             |    2 
 drivers/clocksource/timer-tegra186.c                                 |    4 
 drivers/cpufreq/scmi-cpufreq.c                                       |   10 
 drivers/cpuidle/cpuidle-qcom-spm.c                                   |    7 
 drivers/crypto/hisilicon/debugfs.c                                   |    1 
 drivers/crypto/hisilicon/hpre/hpre_main.c                            |   66 +-
 drivers/crypto/hisilicon/qm.c                                        |   45 +
 drivers/crypto/hisilicon/sec2/sec_main.c                             |  126 +++-
 drivers/crypto/hisilicon/zip/zip_main.c                              |   94 ++-
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c                  |    5 
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c                  |    2 
 drivers/crypto/nx/nx-common-powernv.c                                |    6 
 drivers/crypto/nx/nx-common-pseries.c                                |    6 
 drivers/devfreq/event/rockchip-dfi.c                                 |    7 
 drivers/devfreq/mtk-cci-devfreq.c                                    |    3 
 drivers/edac/i10nm_base.c                                            |   14 
 drivers/firmware/arm_scmi/transports/virtio.c                        |    3 
 drivers/firmware/efi/Kconfig                                         |    7 
 drivers/firmware/meson/Kconfig                                       |    2 
 drivers/fwctl/mlx5/main.c                                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                              |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                             |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                             |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                              |  170 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h                              |   11 
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                               |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                                |   29 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c                                |   27 
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c                                |    1 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c                                |    2 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c                              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                 |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c                      |    8 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c    |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c            |   32 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                      |    5 
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c        |   12 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c       |    5 
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h       |    3 
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c                         |    7 
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                           |   92 ++-
 drivers/gpu/drm/bridge/Kconfig                                       |    1 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                       |    4 
 drivers/gpu/drm/display/drm_bridge_connector.c                       |    4 
 drivers/gpu/drm/display/drm_dp_helper.c                              |    4 
 drivers/gpu/drm/drm_atomic_uapi.c                                    |   23 
 drivers/gpu/drm/drm_panel.c                                          |   73 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                  |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c                            |    4 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c                             |    6 
 drivers/gpu/drm/msm/msm_drv.c                                        |    1 
 drivers/gpu/drm/msm/msm_gem_vma.c                                    |   31 -
 drivers/gpu/drm/msm/msm_kms.c                                        |    5 
 drivers/gpu/drm/panel/panel-edp.c                                    |   20 
 drivers/gpu/drm/panel/panel-novatek-nt35560.c                        |    2 
 drivers/gpu/drm/radeon/r600_cs.c                                     |    4 
 drivers/gpu/drm/scheduler/tests/mock_scheduler.c                     |    2 
 drivers/gpu/drm/scheduler/tests/sched_tests.h                        |    7 
 drivers/gpu/drm/scheduler/tests/tests_basic.c                        |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c                                |    2 
 drivers/hid/hid-ids.h                                                |    2 
 drivers/hid/hid-quirks.c                                             |    2 
 drivers/hid/hid-steelseries.c                                        |  108 +--
 drivers/hid/hidraw.c                                                 |  224 ++++----
 drivers/hid/i2c-hid/i2c-hid-core.c                                   |   46 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                                |   11 
 drivers/hwmon/asus-ec-sensors.c                                      |    2 
 drivers/hwmon/mlxreg-fan.c                                           |   24 
 drivers/hwtracing/coresight/coresight-catu.c                         |   31 -
 drivers/hwtracing/coresight/coresight-catu.h                         |    1 
 drivers/hwtracing/coresight/coresight-core.c                         |    6 
 drivers/hwtracing/coresight/coresight-cpu-debug.c                    |    6 
 drivers/hwtracing/coresight/coresight-ctcu-core.c                    |   10 
 drivers/hwtracing/coresight/coresight-etb10.c                        |   10 
 drivers/hwtracing/coresight/coresight-etm3x-core.c                   |    9 
 drivers/hwtracing/coresight/coresight-etm4x-core.c                   |   41 -
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c                  |    1 
 drivers/hwtracing/coresight/coresight-etm4x.h                        |    6 
 drivers/hwtracing/coresight/coresight-funnel.c                       |   42 -
 drivers/hwtracing/coresight/coresight-replicator.c                   |   40 -
 drivers/hwtracing/coresight/coresight-stm.c                          |   13 
 drivers/hwtracing/coresight/coresight-syscfg.c                       |    2 
 drivers/hwtracing/coresight/coresight-tmc-core.c                     |   26 
 drivers/hwtracing/coresight/coresight-tmc.h                          |    2 
 drivers/hwtracing/coresight/coresight-tpda.c                         |    3 
 drivers/hwtracing/coresight/coresight-tpiu.c                         |   14 
 drivers/hwtracing/coresight/coresight-trbe.c                         |   12 
 drivers/hwtracing/coresight/ultrasoc-smb.h                           |    1 
 drivers/i2c/busses/i2c-designware-platdrv.c                          |    5 
 drivers/i2c/busses/i2c-k1.c                                          |   71 +-
 drivers/i2c/busses/i2c-mt65xx.c                                      |   17 
 drivers/i3c/internals.h                                              |   12 
 drivers/i3c/master/svc-i3c-master.c                                  |   31 -
 drivers/iio/inkern.c                                                 |   30 -
 drivers/infiniband/core/addr.c                                       |   10 
 drivers/infiniband/core/cm.c                                         |    4 
 drivers/infiniband/core/sa_query.c                                   |    6 
 drivers/infiniband/hw/mlx5/main.c                                    |   67 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                 |    5 
 drivers/infiniband/sw/rxe/rxe_task.c                                 |    8 
 drivers/infiniband/sw/siw/siw_verbs.c                                |   25 
 drivers/input/misc/uinput.c                                          |    1 
 drivers/input/touchscreen/atmel_mxt_ts.c                             |    2 
 drivers/iommu/intel/debugfs.c                                        |   17 
 drivers/iommu/intel/iommu.h                                          |    3 
 drivers/iommu/iommu-priv.h                                           |    2 
 drivers/iommu/iommu.c                                                |   26 
 drivers/iommu/iommufd/selftest.c                                     |    2 
 drivers/irqchip/irq-gic-v5-its.c                                     |   24 
 drivers/irqchip/irq-sg2042-msi.c                                     |   18 
 drivers/leds/flash/leds-qcom-flash.c                                 |   62 +-
 drivers/leds/leds-lp55xx-common.c                                    |    2 
 drivers/leds/leds-max77705.c                                         |    2 
 drivers/md/dm-core.h                                                 |    1 
 drivers/md/dm-vdo/indexer/volume-index.c                             |    4 
 drivers/md/dm.c                                                      |   13 
 drivers/media/i2c/rj54n1cb0c.c                                       |    9 
 drivers/media/i2c/vd55g1.c                                           |    2 
 drivers/media/pci/zoran/zoran.h                                      |    6 
 drivers/media/pci/zoran/zoran_driver.c                               |    3 
 drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c                |   20 
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                                |    2 
 drivers/mfd/max77705.c                                               |   38 -
 drivers/mfd/rz-mtu3.c                                                |    2 
 drivers/mfd/vexpress-sysreg.c                                        |    6 
 drivers/misc/fastrpc.c                                               |   89 ++-
 drivers/misc/genwqe/card_ddcb.c                                      |    2 
 drivers/misc/pci_endpoint_test.c                                     |    2 
 drivers/mmc/core/block.c                                             |    6 
 drivers/mmc/host/Kconfig                                             |    1 
 drivers/mtd/nand/raw/atmel/nand-controller.c                         |    4 
 drivers/net/bonding/bond_main.c                                      |    2 
 drivers/net/bonding/bond_netlink.c                                   |   16 
 drivers/net/ethernet/amazon/ena/ena_ethtool.c                        |    5 
 drivers/net/ethernet/cadence/macb.h                                  |    4 
 drivers/net/ethernet/cadence/macb_main.c                             |  134 ++--
 drivers/net/ethernet/dlink/dl2k.c                                    |    7 
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c                     |    2 
 drivers/net/ethernet/freescale/enetc/ntmp.c                          |   15 
 drivers/net/ethernet/intel/idpf/idpf_txrx.c                          |    8 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                      |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                 |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                 |    1 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                        |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h             |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                    |   17 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                   |   24 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c                  |    7 
 drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c                 |    2 
 drivers/net/phy/as21xxx.c                                            |    7 
 drivers/net/usb/asix_devices.c                                       |   29 +
 drivers/net/usb/rtl8150.c                                            |    2 
 drivers/net/wireless/ath/ath10k/wmi.c                                |   39 -
 drivers/net/wireless/ath/ath12k/ce.c                                 |    2 
 drivers/net/wireless/ath/ath12k/debug.h                              |    1 
 drivers/net/wireless/ath/ath12k/dp_mon.c                             |   56 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c                              |   45 +
 drivers/net/wireless/ath/ath12k/hal_rx.h                             |   12 
 drivers/net/wireless/ath/ath12k/mac.c                                |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c            |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c              |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c              |    8 
 drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h        |    1 
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h                   |    1 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                      |    7 
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                      |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                      |   29 -
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                     |   29 -
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                      |  137 +---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                     |  106 ++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                      |   38 -
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                      |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                   |   22 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                      |    2 
 drivers/net/wireless/realtek/rtw88/led.c                             |   13 
 drivers/net/wireless/realtek/rtw89/core.c                            |    1 
 drivers/net/wireless/realtek/rtw89/ser.c                             |    3 
 drivers/nvme/host/auth.c                                             |    5 
 drivers/nvme/host/tcp.c                                              |    3 
 drivers/nvme/target/fc.c                                             |   19 
 drivers/nvme/target/fcloop.c                                         |    8 
 drivers/pci/controller/cadence/pci-j721e.c                           |    2 
 drivers/pci/controller/dwc/pcie-designware.h                         |    1 
 drivers/pci/controller/dwc/pcie-qcom-common.c                        |   58 +-
 drivers/pci/controller/dwc/pcie-qcom-common.h                        |    2 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                            |    6 
 drivers/pci/controller/dwc/pcie-qcom.c                               |    8 
 drivers/pci/controller/dwc/pcie-rcar-gen4.c                          |   26 
 drivers/pci/controller/dwc/pcie-tegra194.c                           |    4 
 drivers/pci/controller/pci-tegra.c                                   |    2 
 drivers/pci/controller/pci-xgene-msi.c                               |    2 
 drivers/pci/controller/pcie-rcar-host.c                              |    2 
 drivers/pci/endpoint/functions/pci-epf-test.c                        |   31 -
 drivers/pci/endpoint/pci-ep-msi.c                                    |    2 
 drivers/pci/msi/irqdomain.c                                          |   57 ++
 drivers/pci/pci-acpi.c                                               |    6 
 drivers/pci/pcie/aer.c                                               |    3 
 drivers/pci/pwrctrl/slot.c                                           |   12 
 drivers/perf/arm_spe_pmu.c                                           |    3 
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c                   |   12 
 drivers/pinctrl/Kconfig                                              |    2 
 drivers/pinctrl/meson/pinctrl-meson-gxl.c                            |   10 
 drivers/pinctrl/pinctrl-eic7700.c                                    |    2 
 drivers/pinctrl/pinmux.c                                             |    2 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                              |    2 
 drivers/pinctrl/renesas/pinctrl.c                                    |    3 
 drivers/power/supply/cw2015_battery.c                                |    3 
 drivers/power/supply/max77705_charger.c                              |  200 +++----
 drivers/pps/kapi.c                                                   |    5 
 drivers/pps/pps.c                                                    |    5 
 drivers/ptp/ptp_private.h                                            |    1 
 drivers/ptp/ptp_sysfs.c                                              |    2 
 drivers/pwm/pwm-loongson.c                                           |    2 
 drivers/pwm/pwm-tiehrpwm.c                                           |  154 ++---
 drivers/regulator/scmi-regulator.c                                   |    3 
 drivers/remoteproc/pru_rproc.c                                       |    3 
 drivers/remoteproc/qcom_q6v5.c                                       |    3 
 drivers/remoteproc/qcom_q6v5_mss.c                                   |   11 
 drivers/remoteproc/qcom_q6v5_pas.c                                   |    6 
 drivers/rpmsg/qcom_smd.c                                             |    2 
 drivers/scsi/libsas/sas_expander.c                                   |    5 
 drivers/scsi/mpt3sas/mpt3sas_transport.c                             |    8 
 drivers/scsi/myrs.c                                                  |    8 
 drivers/scsi/pm8001/pm8001_hwi.c                                     |   11 
 drivers/scsi/pm8001/pm8001_sas.c                                     |   31 -
 drivers/scsi/pm8001/pm8001_sas.h                                     |    1 
 drivers/scsi/pm8001/pm80xx_hwi.c                                     |   10 
 drivers/scsi/qla2xxx/qla_edif.c                                      |    4 
 drivers/scsi/qla2xxx/qla_init.c                                      |    4 
 drivers/scsi/qla2xxx/qla_nvme.c                                      |    2 
 drivers/soc/mediatek/mtk-svs.c                                       |   23 
 drivers/soc/qcom/rpmh-rsc.c                                          |    7 
 drivers/spi/spi.c                                                    |    2 
 drivers/staging/media/ipu7/ipu7.c                                    |   28 -
 drivers/tee/tee_shm.c                                                |    8 
 drivers/thermal/qcom/Kconfig                                         |    3 
 drivers/thermal/qcom/lmh.c                                           |    2 
 drivers/thunderbolt/tunnel.c                                         |    5 
 drivers/tty/n_gsm.c                                                  |   25 
 drivers/tty/serial/max310x.c                                         |    2 
 drivers/ufs/core/ufs-sysfs.c                                         |    2 
 drivers/ufs/core/ufshcd.c                                            |    9 
 drivers/uio/uio_hv_generic.c                                         |    7 
 drivers/usb/cdns3/cdnsp-pci.c                                        |    5 
 drivers/usb/gadget/configfs.c                                        |    2 
 drivers/usb/host/max3421-hcd.c                                       |    2 
 drivers/usb/host/xhci-ring.c                                         |   11 
 drivers/usb/misc/Kconfig                                             |    1 
 drivers/usb/misc/qcom_eud.c                                          |   33 -
 drivers/usb/phy/phy-twl6030-usb.c                                    |    3 
 drivers/usb/typec/tipd/core.c                                        |   24 
 drivers/usb/usbip/vhci_hcd.c                                         |   22 
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c                       |    6 
 drivers/vfio/pci/pds/dirty.c                                         |    2 
 drivers/vhost/vringh.c                                               |   14 
 drivers/video/fbdev/simplefb.c                                       |   31 -
 drivers/watchdog/intel_oc_wdt.c                                      |    8 
 drivers/watchdog/mpc8xxx_wdt.c                                       |    2 
 fs/btrfs/extent_io.c                                                 |    9 
 fs/btrfs/inode.c                                                     |    2 
 fs/cramfs/inode.c                                                    |    2 
 fs/erofs/zdata.c                                                     |    4 
 fs/ext4/ext4.h                                                       |   10 
 fs/ext4/file.c                                                       |    2 
 fs/ext4/inode.c                                                      |    2 
 fs/ext4/mballoc.c                                                    |   10 
 fs/ext4/orphan.c                                                     |    6 
 fs/ext4/super.c                                                      |    4 
 fs/f2fs/compress.c                                                   |   25 
 fs/f2fs/data.c                                                       |   11 
 fs/f2fs/f2fs.h                                                       |    4 
 fs/f2fs/file.c                                                       |   49 +
 fs/f2fs/gc.c                                                         |   16 
 fs/f2fs/super.c                                                      |   10 
 fs/fuse/file.c                                                       |    1 
 fs/gfs2/file.c                                                       |   23 
 fs/gfs2/glock.c                                                      |  115 +---
 fs/gfs2/glock.h                                                      |    4 
 fs/gfs2/incore.h                                                     |    3 
 fs/gfs2/lock_dlm.c                                                   |   72 +-
 fs/gfs2/trace_gfs2.h                                                 |    1 
 fs/hfsplus/dir.c                                                     |    2 
 fs/hfsplus/hfsplus_fs.h                                              |    8 
 fs/hfsplus/unicode.c                                                 |   24 
 fs/hfsplus/xattr.c                                                   |    6 
 fs/nfs/localio.c                                                     |   65 +-
 fs/nfs/nfs4proc.c                                                    |    2 
 fs/nfsd/filecache.c                                                  |   34 +
 fs/nfsd/filecache.h                                                  |    4 
 fs/nfsd/localio.c                                                    |   11 
 fs/nfsd/trace.h                                                      |   27 
 fs/nfsd/vfs.h                                                        |    4 
 fs/notify/fanotify/fanotify_user.c                                   |    3 
 fs/ntfs3/index.c                                                     |   10 
 fs/ntfs3/run.c                                                       |   12 
 fs/ocfs2/stack_user.c                                                |    1 
 fs/smb/client/smb2ops.c                                              |   17 
 fs/smb/client/smbdirect.c                                            |  110 +++
 fs/smb/client/smbdirect.h                                            |    4 
 fs/smb/server/ksmbd_netlink.h                                        |    5 
 fs/smb/server/mgmt/user_session.c                                    |   26 
 fs/smb/server/server.h                                               |    1 
 fs/smb/server/smb2pdu.c                                              |    3 
 fs/smb/server/transport_ipc.c                                        |    3 
 fs/smb/server/transport_rdma.c                                       |   99 +++
 fs/smb/server/transport_tcp.c                                        |   27 
 fs/squashfs/inode.c                                                  |    7 
 fs/squashfs/squashfs_fs_i.h                                          |    2 
 fs/udf/inode.c                                                       |    3 
 include/acpi/actbl.h                                                 |    2 
 include/asm-generic/vmlinux.lds.h                                    |    1 
 include/crypto/internal/scompress.h                                  |   11 
 include/drm/drm_panel.h                                              |   14 
 include/linux/blk_types.h                                            |    7 
 include/linux/blkdev.h                                               |    2 
 include/linux/bpf.h                                                  |    1 
 include/linux/bpf_verifier.h                                         |   12 
 include/linux/btf.h                                                  |    2 
 include/linux/coresight.h                                            |   27 
 include/linux/dmaengine.h                                            |    2 
 include/linux/hid.h                                                  |    2 
 include/linux/irq.h                                                  |    2 
 include/linux/memcontrol.h                                           |    6 
 include/linux/mm.h                                                   |    2 
 include/linux/mmc/sdio_ids.h                                         |    2 
 include/linux/msi.h                                                  |    2 
 include/linux/nfslocalio.h                                           |    2 
 include/linux/once.h                                                 |    4 
 include/linux/phy.h                                                  |   23 
 include/linux/power/max77705_charger.h                               |  102 +--
 include/linux/sched/topology.h                                       |   28 -
 include/linux/topology.h                                             |    2 
 include/net/bonding.h                                                |    1 
 include/net/dst.h                                                    |   16 
 include/net/ip.h                                                     |   30 +
 include/net/ip6_route.h                                              |    2 
 include/net/route.h                                                  |    2 
 include/scsi/libsas.h                                                |    8 
 include/trace/events/filelock.h                                      |    3 
 include/trace/misc/fs.h                                              |   22 
 include/uapi/linux/hidraw.h                                          |    2 
 include/ufs/ufshcd.h                                                 |    3 
 include/vdso/gettime.h                                               |    1 
 init/Kconfig                                                         |    3 
 io_uring/waitid.c                                                    |    3 
 io_uring/zcrx.c                                                      |    4 
 kernel/bpf/core.c                                                    |    5 
 kernel/bpf/helpers.c                                                 |    3 
 kernel/bpf/verifier.c                                                |   28 -
 kernel/cgroup/cpuset.c                                               |    2 
 kernel/events/uprobes.c                                              |    2 
 kernel/irq/Kconfig                                                   |    2 
 kernel/irq/chip.c                                                    |   37 +
 kernel/irq/irq_test.c                                                |   18 
 kernel/pid.c                                                         |    2 
 kernel/rcu/srcutiny.c                                                |    4 
 kernel/sched/topology.c                                              |   28 -
 kernel/seccomp.c                                                     |   12 
 kernel/smp.c                                                         |   11 
 kernel/time/clockevents.c                                            |    2 
 kernel/time/tick-common.c                                            |   16 
 kernel/time/tick-internal.h                                          |    2 
 kernel/trace/bpf_trace.c                                             |    9 
 kernel/trace/trace.c                                                 |  278 ++++++++--
 kernel/trace/trace_events.c                                          |    3 
 kernel/trace/trace_fprobe.c                                          |   10 
 kernel/trace/trace_irqsoff.c                                         |   23 
 kernel/trace/trace_kprobe.c                                          |   11 
 kernel/trace/trace_probe.h                                           |    9 
 kernel/trace/trace_sched_wakeup.c                                    |   16 
 kernel/trace/trace_uprobe.c                                          |   12 
 lib/raid6/recov_rvv.c                                                |    2 
 lib/raid6/rvv.c                                                      |    3 
 lib/vdso/datastore.c                                                 |    6 
 mm/hugetlb.c                                                         |    2 
 mm/memcontrol.c                                                      |   13 
 mm/slub.c                                                            |    5 
 net/9p/trans_usbg.c                                                  |   16 
 net/bluetooth/hci_sync.c                                             |   10 
 net/bluetooth/iso.c                                                  |   11 
 net/bluetooth/mgmt.c                                                 |   10 
 net/core/dst.c                                                       |    2 
 net/core/filter.c                                                    |   16 
 net/core/sock.c                                                      |   16 
 net/ethtool/tsconfig.c                                               |   12 
 net/ipv4/icmp.c                                                      |    6 
 net/ipv4/ip_fragment.c                                               |    6 
 net/ipv4/ipmr.c                                                      |    6 
 net/ipv4/ping.c                                                      |   14 
 net/ipv4/route.c                                                     |    8 
 net/ipv4/tcp.c                                                       |    9 
 net/ipv4/tcp_input.c                                                 |   15 
 net/ipv4/tcp_metrics.c                                               |    6 
 net/ipv6/anycast.c                                                   |    2 
 net/ipv6/icmp.c                                                      |    9 
 net/ipv6/ip6_output.c                                                |   64 +-
 net/ipv6/mcast.c                                                     |   67 +-
 net/ipv6/ndisc.c                                                     |    2 
 net/ipv6/output_core.c                                               |    8 
 net/ipv6/proc.c                                                      |   47 +
 net/ipv6/route.c                                                     |    7 
 net/mac80211/cfg.c                                                   |   21 
 net/mac80211/main.c                                                  |    3 
 net/mac80211/rx.c                                                    |   28 -
 net/mac80211/sta_info.c                                              |   10 
 net/mptcp/ctrl.c                                                     |    9 
 net/mptcp/subflow.c                                                  |   11 
 net/netfilter/ipset/ip_set_hash_gen.h                                |    8 
 net/netfilter/ipvs/ip_vs_conn.c                                      |    4 
 net/netfilter/ipvs/ip_vs_core.c                                      |   11 
 net/netfilter/ipvs/ip_vs_ctl.c                                       |    6 
 net/netfilter/ipvs/ip_vs_est.c                                       |   16 
 net/netfilter/ipvs/ip_vs_ftp.c                                       |    4 
 net/netfilter/nf_conntrack_standalone.c                              |    3 
 net/netfilter/nfnetlink.c                                            |    2 
 net/nfc/nci/ntf.c                                                    |  135 +++-
 net/smc/smc_clc.c                                                    |   67 +-
 net/smc/smc_core.c                                                   |   27 
 net/smc/smc_pnet.c                                                   |   43 -
 net/sunrpc/auth_gss/svcauth_gss.c                                    |    2 
 net/tls/tls_device.c                                                 |   18 
 net/wireless/util.c                                                  |    2 
 rust/bindings/bindings_helper.h                                      |    1 
 rust/kernel/cpumask.rs                                               |    1 
 scripts/misc-check                                                   |    4 
 security/Kconfig                                                     |    1 
 sound/core/pcm_native.c                                              |   25 
 sound/hda/codecs/hdmi/hdmi.c                                         |    1 
 sound/hda/codecs/realtek/alc269.c                                    |    1 
 sound/pci/lx6464es/lx_core.c                                         |    4 
 sound/soc/codecs/wcd934x.c                                           |   17 
 sound/soc/codecs/wcd937x.c                                           |    4 
 sound/soc/codecs/wcd937x.h                                           |    6 
 sound/soc/intel/boards/bytcht_es8316.c                               |   20 
 sound/soc/intel/boards/bytcr_rt5640.c                                |    7 
 sound/soc/intel/boards/bytcr_rt5651.c                                |   26 
 sound/soc/intel/boards/sof_sdw.c                                     |    2 
 sound/soc/qcom/sc8280xp.c                                            |    4 
 sound/soc/sof/intel/hda-sdw-bpt.c                                    |    2 
 sound/soc/sof/ipc3-topology.c                                        |   10 
 sound/soc/sof/ipc4-pcm.c                                             |  101 ++-
 sound/soc/sof/ipc4-topology.c                                        |    1 
 sound/soc/sof/ipc4-topology.h                                        |    2 
 tools/include/nolibc/nolibc.h                                        |    1 
 tools/include/nolibc/std.h                                           |    2 
 tools/include/nolibc/sys.h                                           |   13 
 tools/include/nolibc/time.h                                          |    5 
 tools/lib/bpf/libbpf.c                                               |   46 -
 tools/lib/bpf/libbpf.h                                               |    2 
 tools/net/ynl/pyynl/lib/ynl.py                                       |    2 
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c             |    4 
 tools/testing/nvdimm/test/ndtest.c                                   |   13 
 tools/testing/selftests/arm64/abi/tpidr2.c                           |    8 
 tools/testing/selftests/arm64/gcs/basic-gcs.c                        |    2 
 tools/testing/selftests/arm64/pauth/exec_target.c                    |    7 
 tools/testing/selftests/bpf/Makefile                                 |    4 
 tools/testing/selftests/bpf/bench.c                                  |    2 
 tools/testing/selftests/bpf/prog_tests/btf_dump.c                    |    2 
 tools/testing/selftests/bpf/prog_tests/fd_array.c                    |    2 
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c           |  220 -------
 tools/testing/selftests/bpf/prog_tests/module_attach.c               |    2 
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c                  |    4 
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c         |    2 
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c     |    2 
 tools/testing/selftests/bpf/prog_tests/stacktrace_map.c              |    2 
 tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c       |    2 
 tools/testing/selftests/bpf/prog_tests/stacktrace_map_skip.c         |    2 
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c                     |    2 
 tools/testing/selftests/bpf/progs/bpf_dctcp.c                        |    2 
 tools/testing/selftests/bpf/progs/freplace_connect_v4_prog.c         |    2 
 tools/testing/selftests/bpf/progs/iters_state_safety.c               |    2 
 tools/testing/selftests/bpf/progs/rbtree_search.c                    |    2 
 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c           |    2 
 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c            |    2 
 tools/testing/selftests/bpf/progs/test_cls_redirect.c                |    2 
 tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c         |    2 
 tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c              |    1 
 tools/testing/selftests/bpf/progs/uretprobe_stack.c                  |    4 
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c              |    2 
 tools/testing/selftests/bpf/progs/verifier_var_off.c                 |    6 
 tools/testing/selftests/bpf/test_sockmap.c                           |    2 
 tools/testing/selftests/bpf/test_tcpnotify_user.c                    |   20 
 tools/testing/selftests/bpf/trace_helpers.c                          |  214 +++++++
 tools/testing/selftests/bpf/trace_helpers.h                          |    3 
 tools/testing/selftests/bpf/verifier/calls.c                         |    8 
 tools/testing/selftests/bpf/xdping.c                                 |    2 
 tools/testing/selftests/bpf/xsk.h                                    |    4 
 tools/testing/selftests/bpf/xskxceiver.c                             |   14 
 tools/testing/selftests/cgroup/lib/cgroup_util.c                     |   12 
 tools/testing/selftests/cgroup/lib/include/cgroup_util.h             |    1 
 tools/testing/selftests/cgroup/test_pids.c                           |    3 
 tools/testing/selftests/futex/functional/Makefile                    |    5 
 tools/testing/selftests/futex/functional/futex_numa_mpol.c           |   59 +-
 tools/testing/selftests/futex/functional/futex_priv_hash.c           |    1 
 tools/testing/selftests/futex/functional/run.sh                      |    1 
 tools/testing/selftests/futex/include/futextest.h                    |   11 
 tools/testing/selftests/iommu/iommufd_utils.h                        |    8 
 tools/testing/selftests/kselftest_harness/Makefile                   |    1 
 tools/testing/selftests/lib.mk                                       |    5 
 tools/testing/selftests/mm/madv_populate.c                           |   21 
 tools/testing/selftests/mm/soft-dirty.c                              |    5 
 tools/testing/selftests/mm/va_high_addr_switch.c                     |    4 
 tools/testing/selftests/mm/vm_util.c                                 |   17 
 tools/testing/selftests/mm/vm_util.h                                 |    1 
 tools/testing/selftests/nolibc/nolibc-test.c                         |    5 
 tools/testing/selftests/vDSO/vdso_call.h                             |    7 
 tools/testing/selftests/vDSO/vdso_test_abi.c                         |    9 
 tools/testing/selftests/watchdog/watchdog-test.c                     |    6 
 683 files changed, 6492 insertions(+), 3927 deletions(-)

Abdun Nihaal (1):
      wifi: mt76: fix potential memory leak in mt76_wmac_probe()

Aditya Kumar Singh (2):
      wifi: mac80211: consider links for validating SCAN_FLAG_AP in scan request during MLO
      wifi: mac80211: fix Rx packet handling when pubsta information is not available

Ahmed Salem (1):
      ACPICA: Apply ACPI_NONSTRING

Akashdeep Kaur (1):
      arm64: dts: ti: k3-pinctrl: Fix the bug in existing macros

Akhil P Oommen (1):
      drm/msm: Fix bootup splat with separate_gpu_drm modparam

Akhilesh Patil (2):
      selftests: watchdog: skip ping loop if WDIOF_KEEPALIVEPING not supported
      fwctl/mlx5: Fix memory alloc/free in mlx5ctl_fw_rpc()

Alessandro Zanni (1):
      iommu/selftest: prevent use of uninitialized variable

Alexander Lobakin (1):
      idpf: fix Rx descriptor ready check barrier in splitq

Alexey Charkov (2):
      arm64: dts: rockchip: Add RTC on rk3576-evb1-v10
      arm64: dts: rockchip: Add WiFi on rk3576-evb1-v10

Alistair Popple (1):
      cramfs: fix incorrect physical page address calculation

Alok Tiwari (3):
      PCI: tegra: Fix devm_kcalloc() argument order for port->phys allocation
      PCI: j721e: Fix incorrect error message in probe()
      idpf: fix mismatched free function for dma_alloc_coherent

Amery Hung (1):
      selftests/bpf: Copy test_kmods when installing selftest

Anderson Nascimento (1):
      fanotify: Validate the return value of mnt_ns_from_dentry() before dereferencing

Andrea Righi (1):
      bpf: Mark kfuncs as __noclone

Andreas Gruenbacher (7):
      gfs2: Fix GLF_INVALIDATE_IN_PROGRESS flag clearing in do_xmote
      gfs2: Further sanitize lock_dlm.c
      gfs2: Fix LM_FLAG_TRY* logic in add_to_queue
      gfs2: Remove duplicate check in do_xmote
      gfs2: Get rid of GLF_INVALIDATE_IN_PROGRESS
      gfs2: do_xmote cleanup
      gfs2: Add proper lockspace locking

Andrei Lalaev (1):
      leds: leds-lp55xx: Use correct address for memory programming

André Almeida (2):
      selftest/futex: Make the error check more precise for futex_numa_mpol
      tools/nolibc: add stdbool.h to nolibc includes

Andy Yan (1):
      power: supply: cw2015: Fix a alignment coding style issue

AngeloGioacchino Del Regno (5):
      arm64: dts: mediatek: mt6331: Fix pmic, regulators, rtc, keys node names
      arm64: dts: mediatek: mt6795-xperia-m5: Fix mmc0 latch-ck value
      arm64: dts: mediatek: mt7986a: Fix PCI-Express T-PHY node address
      arm64: dts: mediatek: mt8395-kontron-i1200: Fix MT6360 regulator nodes
      arm64: dts: mediatek: mt8516-pumpkin: Fix machine compatible

Annette Kobou (1):
      arm64: dts: imx93-kontron: Fix GPIO for panel regulator

Anthony Iliopoulos (1):
      NFSv4.1: fix backchannel max_resp_sz verification check

Aradhya Bhatia (1):
      drm/bridge: cdns-dsi: Fix the _atomic_check()

Arnd Bergmann (5):
      clocksource/drivers/tegra186: Avoid 64-bit division
      i3c: fix big-endian FIFO transfers
      drm/amdgpu: fix link error for !PM_SLEEP
      hwrng: nomadik - add ARM_AMBA dependency
      media: st-delta: avoid excessive stack usage

Bagas Sanjaya (1):
      Documentation: trace: historgram-design: Separate sched_waking histogram section heading and the following diagram

Bala-Vignesh-Reddy (2):
      selftests: arm64: Check fread return value in exec_target
      selftests: arm64: Fix -Waddress warning in tpidr2 test

Baochen Qiang (4):
      wifi: ath12k: initialize eirp_power before use
      wifi: ath12k: fix overflow warning on num_pwr_levels
      wifi: ath12k: fix wrong logging ID used for CE
      wifi: ath10k: avoid unnecessary wait for service ready message

Baokun Li (1):
      ext4: fix potential null deref in ext4_mb_init()

Baptiste Lepers (1):
      rust: cpumask: Mark CpumaskVar as transparent

Bard Liao (1):
      ASoC: Intel: hda-sdw-bpt: set persistent_buffer false

Barnabás Czémán (1):
      rpmsg: qcom_smd: Fix fallback to qcom,ipc parse

Bartosz Golaszewski (2):
      mfd: vexpress-sysreg: Check the return value of devm_gpiochip_add_data()
      pinctrl: check the return value of pinmux_ops::get_function_name()

Bean Huo (1):
      mmc: core: Fix variable shadowing in mmc_route_rpmb_frames()

Beleswar Padhi (4):
      arm64: dts: ti: k3-j742s2-mcu-wakeup: Override firmware-name for MCU R5F cores
      arm64: dts: ti: k3: Rename rproc reserved-mem nodes to 'memory@addr'
      Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations"
      Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations"

Benjamin Berg (1):
      selftests/nolibc: fix EXPECT_NZ macro

Benjamin Mugnier (1):
      media: i2c: vd55g1: Fix duster register address

Benjamin Tissoires (1):
      HID: hidraw: tighten ioctl command parsing

Bernard Metzler (1):
      RDMA/siw: Always report immediate post SQ errors

Bibo Mao (1):
      tick: Do not set device to detached state in tick_shutdown()

Biju Das (2):
      arm64: dts: renesas: rzg2lc-smarc: Disable CAN-FD channel0
      arm64: dts: renesas: r9a09g047e57-smarc: Fix gpio key's pin control node

Bingbu Cao (3):
      media: staging/ipu7: convert to use pci_alloc_irq_vectors() API
      media: staging/ipu7: Don't set name for IPU7 PCI device
      media: staging/ipu7: cleanup the MMU correctly in IPU7 driver release

Bitterblue Smith (2):
      wifi: rtw88: Lock rtwdev->mutex before setting the LED
      wifi: rtw88: Use led->brightness_set_blocking for PCI too

Bo Sun (2):
      octeontx2-vf: fix bitmap leak
      octeontx2-pf: fix bitmap leak

Brahmajit Das (2):
      drm/radeon/r600_cs: clean up of dead code in r600_cs
      bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer

Breno Leitao (1):
      PCI/AER: Avoid NULL pointer dereference in aer_ratelimit()

Brian Norris (4):
      genirq/test: Select IRQ_DOMAIN
      genirq/test: Depend on SPARSE_IRQ
      genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
      genirq/test: Ensure CPU 1 is online for hotplug test

Brigham Campbell (1):
      drm/panel: novatek-nt35560: Fix invalid return value

Chao Yu (11):
      f2fs: fix condition in __allow_reserved_blocks()
      f2fs: fix to avoid overflow while left shift operation
      f2fs: fix to zero data after EOF for compressed file correctly
      f2fs: fix to clear unusable_cap for checkpoint=enable
      f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()
      f2fs: fix to allow removing qf_name
      f2fs: fix to update map->m_next_extent correctly in f2fs_map_blocks()
      f2fs: fix to truncate first page in error path of f2fs_truncate()
      f2fs: fix to avoid migrating empty section
      f2fs: fix to mitigate overhead of f2fs_zero_post_eof_page()
      f2fs: fix UAF issue in f2fs_merge_page_bio()

Chen Ridong (1):
      cpuset: fix failure to enable isolated partition when containing isolcpus

Chen-Yu Tsai (8):
      arm64: dts: allwinner: a527: cubie-a5e: Add ethernet PHY reset setting
      arm64: dts: allwinner: t527: avaota-a1: Add ethernet PHY reset setting
      arm64: dts: mediatek: mt8188: Change efuse fallback compatible to mt8186
      arm64: dts: mediatek: mt8186-tentacruel: Fix touchscreen model
      arm64: dts: allwinner: a527: cubie-a5e: Add LEDs
      arm64: dts: allwinner: a527: cubie-a5e: Drop external 32.768 KHz crystal
      arm64: dts: allwinner: t527: avaota-a1: hook up external 32k crystal
      arm64: dts: allwinner: t527: orangepi-4a: hook up external 32k crystal

Chenghai Huang (3):
      crypto: hisilicon/zip - remove unnecessary validation for high-performance mode configurations
      crypto: hisilicon - re-enable address prefetch after device resuming
      crypto: hisilicon/qm - set NULL to qm->debug.qm_diff_regs

Chia-I Wu (1):
      drm/bridge: it6505: select REGMAP_I2C

Christian Göttsche (1):
      pid: use ns_capable_noaudit() when determining net sysctl permissions

Christian Marangi (2):
      net: phy: introduce phy_id_compare_vendor() PHY ID helper
      net: phy: as21xxx: better handle PHY HW reset on soft-reboot

Christophe Leroy (3):
      powerpc/8xx: Remove left-over instruction and comments in DataStoreTLBMiss handler
      powerpc/603: Really copy kernel PGD entries into all PGDIRs
      watchdog: mpc8xxx_wdt: Reload the watchdog timer when enabling the watchdog

Chunyan Zhang (1):
      raid6: riscv: Clean up unused header file inclusion

Chunyu Hu (1):
      selftests/mm: fix va_high_addr_switch.sh failure on x86_64

Claudiu Beznea (1):
      PCI: rcar-host: Pass proper IRQ domain to generic_handle_domain_irq()

Claudiu Manoil (1):
      net: enetc: Fix probing error message typo for the ENETCv4 PF driver

Colin Ian King (4):
      gfs2: Remove space before newline
      drm/vmwgfx: fix missing assignment to ts
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

Dan Carpenter (11):
      PM / devfreq: mtk-cci: Fix potential error pointer dereference in probe()
      irqchip/gic-v5: Fix loop in gicv5_its_create_itt_two_level() cleanup path
      irqchip/gic-v5: Fix error handling in gicv5_its_irq_domain_alloc()
      selftests/futex: Fix futex_wait() for 32bit ARM
      PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check in pci_epf_write_msi_msg()
      PCI: xgene-msi: Return negative -EINVAL in xgene_msi_handler_setup()
      usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      misc: pci_endpoint_test: Fix array underflow in pci_endpoint_test_ioctl()
      serial: max310x: Add error checking in probe()
      HID: i2c-hid: Fix test in i2c_hid_core_register_panel_follower()
      ocfs2: fix double free in user_cluster_connect()

Dan Moulding (1):
      crypto: comp - Use same definition of context alloc and free ops

Daniel Borkmann (1):
      bpf: Enforce expected_attach_type for tailcall compatibility

Daniel Wagner (2):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fcloop: call done callback even when remote port is gone

Dapeng Mi (2):
      perf/x86/intel: Use early_initcall() to hook bts_init()
      perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error

David Gow (1):
      genirq/test: Fix depth tests on architectures with NOREQUEST by default.

Deepak Sharma (1):
      net: nfc: nci: Add parameter validation for packet data

Dmitry Antipov (1):
      ACPICA: Fix largest possible resource descriptor index

Dmitry Baryshkov (7):
      thermal/drivers/qcom: Make LMH select QCOM_SCM
      thermal/drivers/qcom/lmh: Add missing IRQ includes
      drm/display: bridge-connector: correct CEC bridge pointers in drm_bridge_connector_init
      drm/msm/mdp4: stop supporting no-IOMMU configuration
      drm/msm: stop supporting no-IOMMU configuration
      remoteproc: qcom_q6v5_mss: support loading MBN file on msm8974
      ASoC: qcom: sc8280xp: use sa8775p/ subdir for QCS9100 / QCS9075

Dominique Martinet (1):
      net/9p: Fix buffer overflow in USB transport layer

Donet Tom (2):
      drivers/base/node: handle error properly in register_one_node()
      drivers/base/node: fix double free in register_one_node()

Duoming Zhou (1):
      thunderbolt: Fix use-after-free in tb_dp_dprx_work

Dzmitry Sankouski (5):
      mfd: max77705: max77705_charger: move active discharge setting to mfd parent
      power: supply: max77705_charger: refactoring: rename charger to chg
      power: supply: max77705_charger: use regfields for config registers
      power: supply: max77705_charger: rework interrupts
      mfd: max77705: Setup the core driver as an interrupt controller

Eduard Zingerman (1):
      bpf: dont report verifier bug for missing bpf_scc_visit on speculative path

Edward Srouji (1):
      RDMA/mlx5: Fix page size bitmap calculation for KSM mode

Enzo Matsumiya (1):
      smb: client: fix crypto buffers in non-linear memory

Eric Dumazet (14):
      nbd: restrict sockets to TCP and UDP
      net: dst: introduce dst->dev_rcu
      ipv6: start using dst_dev_rcu()
      ipv6: use RCU in ip6_xmit()
      ipv6: use RCU in ip6_output()
      net: use dst_dev_rcu() in sk_setup_caps()
      tcp_metrics: use dst_dev_net_rcu()
      ipv4: start using dst_dev_rcu()
      inet: ping: check sock_net() in ping_get_port() and ping_lookup()
      tcp: fix __tcp_close() to only send RST when required
      ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
      ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
      netfilter: nf_conntrack: do not skip entries in /proc/net/nf_conntrack
      tcp: use skb->len instead of skb->truesize in tcp_can_ingest()

Erick Karanja (1):
      mtd: rawnand: atmel: Fix error handling path in atmel_nand_controller_add_nands

Eugene Shalygin (1):
      hwmon: (asus-ec-sensors) Narrow lock for X870E-CREATOR WIFI

Fan Wu (1):
      KEYS: X.509: Fix Basic Constraints CA flag parsing

Fangyu Yu (1):
      RISC-V: KVM: Write hgatp register with valid mode bits

Fedor Pchelkin (2):
      wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Felix Fietkau (1):
      wifi: mt76: mt7996: remove redundant per-phy mac80211 calls during restart

Fenglin Wu (1):
      leds: flash: leds-qcom-flash: Update torch current clamp setting

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink: reset nlh pointer during batch replay

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Frieder Schrempf (1):
      arm64: dts: imx93-kontron: Fix USB port assignment

Gao Xiang (1):
      erofs: avoid reading more for fragment maps

Geert Uytterhoeven (5):
      init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
      regmap: Remove superfluous check for !config in __regmap_init()
      ARM: dts: renesas: porter: Fix CAN pin group
      PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure
      efi: Explain OVMF acronym in OVMF_DEBUG_LOG help text

Genjian Zhang (1):
      null_blk: Fix the description of the cache_size module argument

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Greg Kroah-Hartman (1):
      Linux 6.17.3

Guangshuo Li (1):
      nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()

Guenter Roeck (2):
      clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
      watchdog: intel_oc_wdt: Do not try to write into const memory

Gui-Dong Han (1):
      RDMA/rxe: Fix race in do_task() when draining

Guixin Liu (1):
      iommufd: Register iommufd mock devices with fwspec

Guoqing Jiang (1):
      arm64: dts: mediatek: mt8195: Remove suspend-breaking reset from pcie0

Han Guangjiang (1):
      blk-throttle: fix access race during throttle policy activation

Hangbin Liu (1):
      bonding: fix xfrm offload feature setup on active-backup mode

Hans de Goede (3):
      iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag

Hari Chandrakanthan (1):
      wifi: ath12k: Fix peer lookup in ath12k_dp_mon_rx_deliver_msdu()

Hector Martin (2):
      arm64: dts: apple: t600x: Add missing WiFi properties
      arm64: dts: apple: t600x: Add bluetooth device nodes

Hengqi Chen (10):
      riscv, bpf: Sign extend struct ops return values properly
      bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()
      LoongArch: BPF: Sign-extend struct ops return values properly
      LoongArch: BPF: No support of struct argument in trampoline programs
      LoongArch: BPF: Don't align trampoline size
      LoongArch: BPF: Make trampoline size stable
      LoongArch: BPF: Make error handling robust in arch_prepare_bpf_trampoline()
      LoongArch: BPF: Remove duplicated bpf_flush_icache()
      LoongArch: BPF: No text_poke() for kernel text
      LoongArch: BPF: Remove duplicated flags check

Huacai Chen (1):
      LoongArch: BPF: Fix uninitialized symbol 'retval_off'

Huisong Li (1):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed

Håkon Bugge (1):
      RDMA/cm: Rate limit destroy CM ID timeout error message

I Viswanath (2):
      net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      ptp: Add a upper bound on max_vclocks

Ilya Leoshkevich (3):
      s390/bpf: Do not write tail call counter into helper and kfunc frames
      s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
      s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG

Inochi Amaoto (4):
      genirq: Add irq_chip_(startup/shutdown)_parent()
      PCI/MSI: Add startup/shutdown for per device domains
      irqchip/sg2042-msi: Fix broken affinity setting
      PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()

Ivan Abramov (1):
      dm vdo: return error on corrupted metadata in start_restoring_volume functions

Jacopo Mondi (1):
      media: zoran: Remove zoran_fh structure

Jakub Acs (1):
      mm/ksm: fix flag-dropping behavior in ksm_madvise

Jakub Kicinski (1):
      Revert "net/mlx5e: Update and set Xon/Xoff upon MTU set"

James Clark (2):
      coresight: trbe: Add ISB after TRBLIMITR write
      coresight: Fix missing include for FIELD_GET

Jan Kara (1):
      ext4: fix checks for orphan inodes

Janne Grunau (3):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      arm64: dts: apple: Add ethernet0 alias for J375 template
      fbdev: simplefb: Fix use after free in simplefb_detach_genpds()

Jarkko Sakkinen (1):
      tpm: Disable TPM2_TCG_HMAC by default

Jeff Layton (1):
      filelock: add FL_RECLAIM to show_fl_flags() macro

Jens Axboe (1):
      io_uring/waitid: always prune wait queue entry in io_waitid_wait()

Jens Wiklander (1):
      tee: fix register_shm_helper()

Jeongjun Park (1):
      HID: steelseries: refactor probe() and remove()

Jeremy Linton (1):
      uprobes: uprobe_warn should use passed task

Jie Gan (1):
      coresight: tpda: fix the logic to setup the element size

Jihed Chaibi (4):
      ARM: dts: stm32: stm32mp151c-plyaqm: Use correct dai-format property
      ARM: dts: ti: omap: am335x-baltos: Fix ti,en-ck32k-xtal property in DTS to use correct boolean syntax
      ARM: dts: ti: omap: omap3-devkit8000-lcd: Fix ti,keep-vref-on property to use correct boolean syntax in DTS
      ARM: dts: omap: am335x-cm-t335: Remove unused mcasp num-serializer property

Jiri Kosina (1):
      HID: steelseries: Fix STEELSERIES_SRWS1 handling in steelseries_remove()

Jiri Olsa (1):
      selftests/bpf: Fix realloc size in bpf_get_addrs

Joanne Koong (1):
      fuse: remove unneeded offset assignment when filling write pages

Joe Lawrence (2):
      powerpc/ftrace: ensure ftrace record ops are always set for NOPs
      powerpc64/modules: correctly iterate over stubs in setup_ftrace_ool_stubs

Johan Hovold (4):
      firmware: firmware: meson-sm: fix compile-test default
      soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
      soc: mediatek: mtk-svs: fix device leaks on mt8192 probe failure
      cpuidle: qcom-spm: fix device and OF node leaks at probe

Johannes Nixdorf (1):
      seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer replies too fast

John Garry (2):
      block: update validation of atomic writes boundary for stacked devices
      block: fix stacking of atomic writes when atomics are not supported

Jonas Gorski (1):
      spi: fix return code when spi device has too many chipselects

Jonas Karlman (1):
      phy: rockchip: naneng-combphy: Enable U3 OTG port for RK3568

Jorge Marques (1):
      docs: iio: ad3552r: Fix malformed code-block directive

Joy Zou (1):
      arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid

Jun Nie (1):
      drm/msm: Do not validate SSPP when it is not ready

Junnan Wu (1):
      firmware: arm_scmi: Mark VirtIO ready before registering scmi_virtio_driver

Kai Vehmanen (2):
      ASoC: SOF: ipc4-pcm: fix delay calculation when DSP resamples
      ASoC: SOF: ipc4-pcm: fix start offset calculation for chain DMA

Kang Chen (1):
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Kang Yang (3):
      wifi: ath12k: fix signal in radiotap for WCN7850
      wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
      wifi: ath12k: fix the fetching of combined rssi

Kienan Stewart (1):
      kbuild: Add missing $(objtree) prefix to powerpc crtsavres.o artifact

Kiran K (1):
      Bluetooth: btintel_pcie: Refactor Device Coredump

Kohei Enju (2):
      nfp: fix RSS hash key size when RSS is not supported
      net: ena: return 0 in ena_get_rxfh_key_size() when RSS hash key is not configurable

Komal Bajaj (1):
      usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through secure calls

Konrad Dybcio (1):
      arm64: dts: qcom: qcm2290: Disable USB SS bus instances in park mode

Krishna Chaitanya Chundru (1):
      PCI: qcom: Restrict port parsing only to PCIe bridge child nodes

Kuan-Wei Chiu (1):
      mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal

Kunihiko Hayashi (2):
      i2c: designware: Fix clock issue when PM is disabled
      i2c: designware: Add disabling clocks when probe fails

Kuniyuki Iwashima (8):
      mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
      smc: Fix use-after-free in __pnet_find_base_ndev().
      smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
      smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().
      tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
      mptcp: Call dst_release() in mptcp_active_enable().
      mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Fix invalid unsigned return in rzg3s_oen_read()

Lance Yang (1):
      selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled

Langyan Ye (2):
      drm/panel-edp: Add disable to 100ms for MNB601LS1-4
      drm/panel-edp: Add 50ms disable delay for four panels

Larshin Sergey (1):
      fs: udf: fix OOB read in lengthAllocDescs handling

Lei Lu (1):
      sunrpc: fix null pointer dereference on zero-length checksum

Leilk.Liu (1):
      i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD

Len Bao (1):
      leds: max77705: Function return instead of variable assignment

Leo Yan (9):
      coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      coresight: tmc: Support atclk
      coresight: catu: Support atclk
      coresight: etm4x: Support atclk
      coresight: Appropriately disable programming clocks
      coresight: Appropriately disable trace bus clocks
      coresight: Avoid enable programming clock duplicately
      coresight: trbe: Return NULL pointer for allocation failures

Li Nan (1):
      blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx

Liao Yuanhong (2):
      drm/amd/display: Remove redundant semicolons
      wifi: iwlwifi: Remove redundant header files

Lijo Lazar (2):
      drm/amdgpu: Check vcn state before profile switch
      drm/amdgpu/vcn: Fix double-free of vcn dump buffer

Lin Yujun (1):
      coresight: Fix incorrect handling for return value of devm_kzalloc

Ling Xu (4):
      misc: fastrpc: Save actual DMA size in fastrpc_map structure
      misc: fastrpc: Fix fastrpc_map_lookup operation
      misc: fastrpc: fix possible map leak in fastrpc_put_args
      misc: fastrpc: Skip reference for DMA handles

Linus Torvalds (1):
      Fix CC_HAS_ASM_GOTO_OUTPUT on non-x86 architectures

Lorenzo Bianconi (8):
      wifi: mac80211: Make CONNECTION_MONITOR optional for MLO sta
      wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid configuration
      wifi: mt76: mt7996: Fix mt7996_mcu_bss_mld_tlv routine
      wifi: mt76: mt7996: Use proper link_id in link_sta_rc_update callback
      wifi: mt76: mt7996: Check phy before init msta_link in mt7996_mac_sta_add_links()
      wifi: mt76: mt7996: Fix tx-queues initialization for second phy on mt7996
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

Marek Szyprowski (1):
      scsi: ufs: core: Fix PM QoS mutex initialization

Marek Vasut (6):
      arm64: dts: renesas: sparrow-hawk: Invert microSD voltage selector on EVTB1
      arm64: dts: renesas: sparrow-hawk: Set VDDQ18_25_AVB voltage on EVTB1
      PCI: rcar-gen4: Add missing 1ms delay after PWR reset assertion
      PCI: rcar-gen4: Assure reset occurs before DBI access
      PCI: rcar-gen4: Fix inverted break condition in PHY initialization
      Input: atmel_mxt_ts - allow reset GPIO to sleep

Martin George (2):
      nvme-auth: update bi_directional flag
      nvme-tcp: send only permitted commands for secure concat

Matt Bobrowski (1):
      bpf/selftests: Fix test_tcpnotify_user

Matthieu Baerts (NGI0) (1):
      tools: ynl: fix undefined variable name

Matvey Kovalev (1):
      ksmbd: fix error code overwriting in smb2_get_info_filesystem()

Menglong Dong (1):
      selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c

Miaoqian Lin (2):
      hisi_acc_vfio_pci: Fix reference leak in hisi_acc_vfio_debug_init
      usb: cdns3: cdnsp-pci: remove redundant pci_disable_device() call

Michael Karcher (5):
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      sparc: fix accurate exception reporting in copy_to_user for Niagara 4
      sparc: fix accurate exception reporting in copy_{from,to}_user for M7

Michael S. Tsirkin (1):
      vhost: vringh: Fix copy_to_iter return value check

Michal Koutný (1):
      selftests: cgroup: Make test_pids backwards compatible

Michal Pecio (1):
      Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"

Mike Snitzer (2):
      NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support
      nfs/localio: avoid issuing misaligned IO using O_DIRECT

Mikko Rapeli (1):
      mmc: select REGMAP_MMIO with MMC_LOONGSON2

Moon Hee Lee (1):
      fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist

Moshe Shemesh (2):
      net/mlx5: Stop polling for command response if interface goes down
      net/mlx5: fw reset, add reset timeout work

Mykyta Yatsenko (1):
      libbpf: Export bpf_object__prepare symbol

Nagarjuna Kristam (1):
      PCI: tegra194: Fix duplicate PLL disable in pex_ep_event_pex_rst_assert()

Naman Jain (1):
      uio_hv_generic: Let userspace take care of interrupt mask

Namjae Jeon (1):
      ksmbd: add max ip connections parameter

Nathan Lynch (1):
      dmaengine: Fix dma_async_tx_descriptor->tx_submit documentation

Nicolas Ferre (1):
      ARM: at91: pm: fix MCKx restore routine

Nicolas Frattaroli (1):
      PM / devfreq: rockchip-dfi: double count on RK3588

Niklas Cassel (7):
      scsi: pm80xx: Restore support for expanders
      scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      scsi: libsas: Add dev_parent_is_expander() helper
      scsi: pm80xx: Use dev_parent_is_expander() helper
      scsi: pm80xx: Add helper function to get the local phy id
      scsi: pm80xx: Fix pm8001_abort_task() for chip_8006 when using an expander
      PCI: endpoint: pci-epf-test: Fix doorbell test support

Nipun Gupta (1):
      cdx: don't select CONFIG_GENERIC_MSI_IRQ

Nirmoy Das (1):
      PCI/ACPI: Fix pci_acpi_preserve_config() memory leak

Nishanth Menon (1):
      hwrng: ks-sa - fix division by zero in ks_sa_rng_init

Nithyanantham Paramasivam (2):
      wifi: ath12k: Refactor RX TID deletion handling into helper function
      wifi: ath12k: Fix flush cache failure during RX queue update

Oleksij Rempel (1):
      net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Or Har-Toov (1):
      RDMA/mlx5: Better estimate max_qp_wr to reflect WQE count

Parav Pandit (1):
      RDMA/core: Resolve MAC of next-hop device without ARP support

Patrisious Haddad (1):
      RDMA/mlx5: Fix vport loopback forcing for MPV device

Paul Chaignon (2):
      bpf: Tidy verifier bug message
      bpf: Explicitly check accesses to bpf_sock_addr

Pauli Virtanen (2):
      Bluetooth: ISO: free rx_skb if not consumed
      Bluetooth: ISO: don't leak skb in ISO_CONT RX

Pavel Begunkov (1):
      io_uring/zcrx: fix overshooting recv limit

Peter Zijlstra (1):
      sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()

Phillip Lougher (1):
      Squashfs: fix uninit-value in squashfs_get_parent

Pin-yen Lin (2):
      drm/panel: Allow powering on panel follower after panel is enabled
      HID: i2c-hid: Make elan touch controllers power on after panel is enabled

Qi Xi (1):
      once: fix race by moving DO_ONCE to separate section

Qianfeng Rong (10):
      regulator: scmi: Use int type to store negative error codes
      block: use int to store blk_stack_limits() return value
      pinctrl: renesas: Use int type to store negative error codes
      ALSA: lx_core: use int type to store negative error codes
      accel/amdxdna: Use int instead of u32 to store error codes
      drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
      drm/msm/dpu: fix incorrect type for ret
      scsi: qla2xxx: edif: Fix incorrect sign of error code
      scsi: qla2xxx: Fix incorrect sign of error code in START_SP_W_RETRIES()
      scsi: qla2xxx: Fix incorrect sign of error code in qla_nvme_xmt_ls_rsp()

Qiuxu Zhuo (1):
      EDAC/i10nm: Skip DIMM enumeration on a disabled memory controller

Qu Wenruo (2):
      btrfs: return any hit error from extent_writepage_io()
      btrfs: fix symbolic link reading when bs > ps

Rafael J. Wysocki (2):
      PM: sleep: core: Clear power.must_resume in noirq suspend error path
      smp: Fix up and expand the smp_call_function_many() kerneldoc

Randy Dunlap (1):
      lsm: CONFIG_LSM can depend on CONFIG_SECURITY

Ranjan Kumar (1):
      scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()

Ranjani Sridharan (1):
      ASoC: SOF: ipc3-topology: Fix multi-core and static pipelines tear down

Ricardo B. Marlière (1):
      selftests/bpf: Fix count write in testapp_xdp_metadata_copy()

Richard Fitzgerald (2):
      ASoC: SOF: ipc4-pcm: Fix incorrect comparison with number of tdm_slots
      ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback

Rob Clark (2):
      drm/msm: Fix obj leak in VM_BIND error path
      drm/msm: Fix missing VM_BIND offset/range validation

Rob Herring (Arm) (2):
      dt-bindings: vendor-prefixes: Add undocumented vendor prefixes
      arm64: dts: mediatek: mt8183: Fix out of range pull values

Ryder Lee (1):
      wifi: cfg80211: fix width unit in cfg80211_radio_chandef_valid()

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Sarika Sharma (1):
      wifi: mac80211: fix reporting of all valid links in sta_set_sinfo()

Sasha Levin (1):
      tracing: Fix lock imbalance in s_start() memory allocation failure path

Sathishkumar S (2):
      drm/amdgpu/vcn: Add regdump helper functions
      drm/amdgpu/vcn: Hold pg_lock before vcn power off

Sean Christopherson (1):
      KVM: SVM: Skip fastpath emulation on VM-Exit if next RIP isn't valid

Sebastian Andrzej Siewior (3):
      selftests/futex: Remove the -g parameter from futex_priv_hash
      selftest/futex: Compile also with libnuma < 2.0.16
      ALSA: pcm: Disable bottom softirqs as part of spin_lock_irq() on PREEMPT_RT

Sebastian Reichel (1):
      arm64: dts: rockchip: Fix network on rk3576 evb1 board

Seppo Takalo (1):
      tty: n_gsm: Don't block input queue by waiting MSC

Shay Drory (1):
      net/mlx5: pagealloc: Fix reclaim race during command interface teardown

Shin'ichiro Kawasaki (1):
      PCI: endpoint: pci-epf-test: Add NULL check for DMA channels before release

Shubham Sharma (1):
      selftests/bpf: Fix typos and grammar in test sources

Simon Schuster (1):
      arch: copy_thread: pass clone_flags as u64

Slavin Liu (1):
      ipvs: Defer ip_vs_ftp unregister during netns cleanup

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Srinivas Kandagatla (2):
      ASoC: codecs: wcd937x: set the comp soundwire port correctly
      ASoC: codecs: wcd937x: make stub functions inline

Srinivasan Shanmugam (2):
      drm/amd/display: Reduce Stack Usage by moving 'audio_output' into 'stream_res' v4
      drm/amd/display: Add NULL pointer checks in dc_stream cursor attribute functions

Sriram R (1):
      wifi: ath12k: Add fallback for invalid channel number in PHY metadata

Stanley Chu (2):
      i3c: master: svc: Use manual response for IBI events
      i3c: master: svc: Recycle unused IBI slot

Stefan Kerkmann (1):
      wifi: mwifiex: send world regulatory domain to driver

Stefan Metzmacher (2):
      smb: client: fix sending the iwrap custom IRD/ORD negotiation messages
      smb: server: fix IRD/ORD negotiation with the client

Stephan Gerhold (2):
      remoteproc: qcom: q6v5: Avoid disabling handover IRQ twice
      remoteproc: qcom: pas: Shutdown lite ADSP DTB on X1E

Steven 'Steve' Kendall (1):
      ALSA: hda/hdmi: Add pin fix for HP ProDesk model

Steven Rostedt (5):
      tracing: Fix wakeup tracers on failure of acquiring calltime
      tracing: Fix irqoff tracers on failure of acquiring calltime
      tracing: Have trace_marker use per-cpu data to read user space
      tracing: Fix tracing_mark_raw_write() to use buf and not ubuf
      tracing: Stop fortify-string from warning in tracing_mark_raw_write()

Sven Peter (1):
      usb: typec: tipd: Clear interrupts first

Takashi Iwai (4):
      ASoC: Intel: bytcht_es8316: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping
      ALSA: hda/realtek: Add quirk for HP Spectre 14t-ea100

Tao Chen (2):
      bpf: Remove migrate_disable in kprobe_multi_link_prog_run
      bpf: Remove preempt_disable in bpf_try_get_buffers

Thomas Fourier (2):
      crypto: keembay - Add missing check after sg_nents_for_len()
      scsi: myrs: Fix dma_alloc_coherent() error check

Thomas Weißschuh (8):
      kselftest/arm64/gcs: Correctly check return value when disabling GCS
      tools/nolibc: fix error return value of clock_nanosleep()
      tools/nolibc: avoid error in dup2() if old fd equals new fd
      vdso/datastore: Gate time data behind CONFIG_GENERIC_GETTIMEOFDAY
      vdso: Add struct __kernel_old_timeval forward declaration to gettime.h
      selftests: vDSO: Fix -Wunitialized in powerpc VDSO_CALL() wrapper
      selftests: vDSO: vdso_test_abi: Correctly skip whole test with missing vDSO
      selftests: always install UAPI headers to the correct directory

Thorsten Blum (1):
      crypto: octeontx2 - Call strscpy() with correct size argument

Théo Lebrun (3):
      net: macb: remove illusion about TBQPH/RBQPH being per-queue
      net: macb: move ring size computation to functions
      net: macb: single dma_alloc_coherent() for DMA descriptors

Timur Kristóf (8):
      drm/amdgpu: Power up UVD 3 for FW validation (v2)
      drm/amd/pm: Disable ULV even if unsupported (v3)
      drm/amd/pm: Fix si_upload_smc_data (v3)
      drm/amd/pm: Adjust si_upload_smc_data register programming (v3)
      drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)
      drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
      drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks (v3)
      drm/amdgpu: Fix allocating extra dwords for rings (v2)

Troy Mitchell (5):
      i2c: spacemit: ensure bus release check runs when wait_bus_idle() fails
      i2c: spacemit: remove stop function to avoid bus error
      i2c: spacemit: disable SDA glitch fix to avoid restart delay
      i2c: spacemit: check SDA instead of SCL after bus reset
      i2c: spacemit: ensure SDA is released after bus reset

Tvrtko Ursulin (1):
      drm/sched: Fix a race in DRM_GPU_SCHED_STAT_NO_HANG test

Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

Uwe Kleine-König (4):
      pwm: tiehrpwm: Don't drop runtime PM reference in .free()
      pwm: tiehrpwm: Make code comment in .free() more useful
      pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
      pwm: tiehrpwm: Fix corner case in clock divisor calculation

Vadim Fedorenko (1):
      net: ethtool: tsconfig: set command must provide a reply

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Separate methods of fan setting coming from different subsystems

Val Packett (1):
      drm/dp: drm_edp_backlight_set_level: do not always send 3-byte commands

Vineeth Pillai (Google) (1):
      iommu/vt-d: debugfs: Fix legacy mode page table dump logic

Vitaly Grigoryev (1):
      fs: ntfs3: Fix integer overflow in run_unpack()

Vlad Dumitrescu (1):
      IB/sa: Fix sa_local_svc_timeout_ms read race

Vlastimil Babka (1):
      scripts/misc-check: update export checks for EXPORT_SYMBOL_FOR_MODULES()

Waiman Long (1):
      selftests/futex: Fix some futex_numa_mpol subtests

Wang Liang (1):
      pps: fix warning in pps_register_cdev when register device fail

Wei Fang (1):
      net: enetc: initialize SW PIR and CIR based HW PIR and CIR values

Weili Qian (2):
      crypto: hisilicon - check the sva module status while enabling or disabling address prefetch
      crypto: hisilicon/qm - request reserved interrupt for virtual function

William Wu (1):
      usb: gadget: configfs: Correctly set use_os_string at bind

Xaver Hugl (1):
      drm: re-allow no-op changes on non-primary planes in async flips

Xi Ruoyao (1):
      pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT

Xiang Liu (2):
      drm/amdgpu: Fix jpeg v4.0.3 poison irq call trace on sriov guest
      drm/amdgpu: Fix vcn v4.0.3 poison irq call trace on sriov guest

Xianwei Zhao (1):
      dts: arm: amlogic: fix pwm node for c3

Xichao Zhao (1):
      usb: phy: twl6030: Fix incorrect type for ret

Yang Shi (1):
      mm: hugetlb: avoid soft lockup when mprotect to large memory area

Yazhou Tang (1):
      bpf: Reject negative offsets for ALU ops

Yeoreum Yun (1):
      coresight: fix indentation error in cscfg_remove_owned_csdev_configs()

Yeounsu Moon (1):
      net: dlink: handle copy_thresh allocation failure

Yi Lai (1):
      selftests/kselftest_harness: Add harness-selftest.expected to TEST_FILES

Youling Tang (1):
      LoongArch: Automatically disable kaslr if boot from kexec_file

Yu Kuai (14):
      blk-mq: fix elevator depth_updated method
      block: cleanup bio_issue
      block: initialize bio issue time in blk_mq_submit_bio()
      block: factor out a helper bio_submit_split_bioset()
      block: skip unnecessary checks for split bio
      block: fix ordering of recursive split IO
      blk-mq: remove useless checkings in blk_mq_update_nr_requests()
      blk-mq: check invalid nr_requests in queue_requests_store()
      blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock
      blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
      blk-mq: split bitmap grow and resize case in blk_mq_update_nr_requests()
      blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_tags()
      blk-mq: fix potential deadlock while nr_requests grown
      blk-throttle: fix throtl_data leak during disk release

Yuan Chen (1):
      tracing: Fix race condition in kprobe initialization causing NULL pointer dereference

Yuanfang Zhang (2):
      coresight: Only register perf symlink for sinks with alloc_buffer
      coresight-etm4x: Conditionally access register TRCEXTINSELR

Yue Haibing (1):
      ipv6: mcast: Add ip6_mc_find_idev() helper

Yulin Lu (1):
      pinctrl: eswin: Fix regulator error check and Kconfig dependency

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

Zhongqiu Han (1):
      scsi: ufs: core: Fix data race in CPU latency PM QoS request handling

Zhouyi Zhou (1):
      tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers

Zhushuai Yin (1):
      crypto: hisilicon/qm - check whether the input function and PF are on the same device

Zilin Guan (1):
      vfio/pds: replace bitmap_free with vfree

Ziyue Zhang (1):
      PCI: qcom: Add equalization settings for 8.0 GT/s and 32.0 GT/s

Zqiang (1):
      srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()

wangzijie (1):
      f2fs: fix zero-sized extent for precache extents

zhang jiao (1):
      vhost: vringh: Modify the return value check


