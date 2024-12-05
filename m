Return-Path: <stable+bounces-98814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7509E57E3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C191883A0A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9C218AD1;
	Thu,  5 Dec 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKiJOGKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C39218EBA;
	Thu,  5 Dec 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406823; cv=none; b=b9ydbmuO591WG6PYc69OQ5Klmqwc0Q/aaUUV7n3yPCvPfkwv34MUANEnXKznJhC44SRT8DYMpvIP7a29WvXlsCP/HVTQvl9IlbtbCjsWoN7IqbyMBB0/jZwkXNFcwxZWnhJXzIM18SWMw7gTvwVPLvXDAQBcZaxdFpFnX90Bnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406823; c=relaxed/simple;
	bh=lNTH0YjVE47MzQKJ45sIvbYr8gaSpYHjtCo4d4bynTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqTh/n2oNWaBKpaqZZAV8/8RJnA6jIJHYgQUTyYkYAneH+F406oxkWwYwaYBl8Tk1+TGmtx7BJf7cfjr8JsHWlDT04jbhjU5o52nN/Rd0tNmgyHagG0M1kikXc/lvbeJv+zZAswmwQUVV/Efku1S0n/r8GL6pB/vGZwJSc9ymvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKiJOGKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF52C4CEDD;
	Thu,  5 Dec 2024 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733406822;
	bh=lNTH0YjVE47MzQKJ45sIvbYr8gaSpYHjtCo4d4bynTU=;
	h=From:To:Cc:Subject:Date:From;
	b=MKiJOGKOitj2QLtJz8fjQJWYRVzj8D0SirtSJsJIpWDUvosnKpOivmAXMo/ZEdikF
	 TXQRCkxEoLVfXz427NDNCXxFCfItlD/DEcaQR+NNO4F1oSlYT+ojzBzKjkBkBXGGwi
	 1SnTO3uOOgPCUczCdH/AMWEp/wAqx1bMl6nBN0xg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.2
Date: Thu,  5 Dec 2024 14:53:29 +0100
Message-ID: <2024120529-strained-unbraided-b958@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.2 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-fs-f2fs                                         |    7 
 Documentation/RCU/stallwarn.rst                                                 |    2 
 Documentation/admin-guide/blockdev/zram.rst                                     |    2 
 Documentation/admin-guide/media/building.rst                                    |    2 
 Documentation/admin-guide/media/saa7134.rst                                     |    2 
 Documentation/arch/x86/boot.rst                                                 |   17 
 Documentation/devicetree/bindings/cache/qcom,llcc.yaml                          |   36 
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml                     |   22 
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml                      |    2 
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml                   |    5 
 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml |   19 
 Documentation/devicetree/bindings/serial/rs485.yaml                             |   19 
 Documentation/devicetree/bindings/sound/mt6359.yaml                             |   10 
 Documentation/devicetree/bindings/vendor-prefixes.yaml                          |    2 
 Documentation/filesystems/mount_api.rst                                         |    3 
 Documentation/locking/seqlock.rst                                               |    2 
 MAINTAINERS                                                                     |  335 +--
 Makefile                                                                        |    2 
 arch/arc/kernel/devtree.c                                                       |    2 
 arch/arm/boot/dts/allwinner/sun9i-a80-cubieboard4.dts                           |    4 
 arch/arm/boot/dts/microchip/sam9x60.dtsi                                        |   12 
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts                                   |    2 
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi                                         |    1 
 arch/arm/kernel/devtree.c                                                       |    2 
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso               |   29 
 arch/arm64/boot/dts/mediatek/mt6358.dtsi                                        |    4 
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi                               |    8 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts                    |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts                     |    2 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts                      |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi                   |    3 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi                          |   30 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi                           |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi                           |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi                            |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                                  |    5 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                                        |    4 
 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi                        |   21 
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi                                |    8 
 arch/arm64/boot/dts/mediatek/mt8188.dtsi                                        |    5 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi                                 |    6 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                                        |    4 
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts                          |    2 
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi                                  |    2 
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts                                    |    2 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                           |    2 
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts                             |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                            |   14 
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts                         |    4 
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts                        |    4 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                                          |    8 
 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi                                    |    3 
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi                                    |    3 
 arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-io-expander.dtso             |    1 
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts                        |    2 
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts                             |    1 
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi                              |    2 
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts                           |    2 
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi                                       |   38 
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi                                 |    6 
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi                                 |    6 
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi                                      |   16 
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi                                |    6 
 arch/arm64/include/asm/insn.h                                                   |    1 
 arch/arm64/include/asm/kvm_host.h                                               |    2 
 arch/arm64/kernel/cpufeature.c                                                  |    1 
 arch/arm64/kernel/probes/decode-insn.c                                          |    7 
 arch/arm64/kernel/process.c                                                     |    2 
 arch/arm64/kernel/setup.c                                                       |    6 
 arch/arm64/kernel/vmlinux.lds.S                                                 |    6 
 arch/arm64/kvm/arch_timer.c                                                     |    3 
 arch/arm64/kvm/arm.c                                                            |   18 
 arch/arm64/kvm/mmio.c                                                           |   32 
 arch/arm64/kvm/pmu-emul.c                                                       |    1 
 arch/arm64/kvm/vgic/vgic-its.c                                                  |   32 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                              |    7 
 arch/arm64/kvm/vgic/vgic.h                                                      |   23 
 arch/arm64/net/bpf_jit_comp.c                                                   |   47 
 arch/csky/kernel/setup.c                                                        |    4 
 arch/loongarch/Makefile                                                         |    4 
 arch/loongarch/kernel/setup.c                                                   |    2 
 arch/loongarch/net/bpf_jit.c                                                    |    2 
 arch/loongarch/vdso/Makefile                                                    |    2 
 arch/m68k/coldfire/device.c                                                     |    8 
 arch/m68k/include/asm/mcfgpio.h                                                 |    2 
 arch/m68k/include/asm/mvme147hw.h                                               |    4 
 arch/m68k/kernel/early_printk.c                                                 |    5 
 arch/m68k/mvme147/config.c                                                      |   30 
 arch/m68k/mvme147/mvme147.h                                                     |    6 
 arch/microblaze/kernel/microblaze_ksyms.c                                       |   10 
 arch/microblaze/kernel/prom.c                                                   |    2 
 arch/mips/include/asm/switch_to.h                                               |    2 
 arch/mips/kernel/prom.c                                                         |    2 
 arch/mips/kernel/relocate.c                                                     |    2 
 arch/nios2/kernel/prom.c                                                        |    4 
 arch/openrisc/Kconfig                                                           |    3 
 arch/openrisc/include/asm/fixmap.h                                              |   21 
 arch/openrisc/kernel/prom.c                                                     |    2 
 arch/openrisc/mm/init.c                                                         |   37 
 arch/parisc/kernel/ftrace.c                                                     |    2 
 arch/powerpc/include/asm/dtl.h                                                  |    4 
 arch/powerpc/include/asm/fadump.h                                               |    9 
 arch/powerpc/include/asm/kvm_book3s_64.h                                        |    4 
 arch/powerpc/include/asm/sstep.h                                                |    5 
 arch/powerpc/include/asm/vdso.h                                                 |    1 
 arch/powerpc/kernel/dt_cpu_ftrs.c                                               |    2 
 arch/powerpc/kernel/fadump.c                                                    |   40 
 arch/powerpc/kernel/prom.c                                                      |    5 
 arch/powerpc/kernel/setup-common.c                                              |    6 
 arch/powerpc/kernel/setup_64.c                                                  |    1 
 arch/powerpc/kexec/file_load_64.c                                               |    9 
 arch/powerpc/kvm/book3s_hv.c                                                    |   14 
 arch/powerpc/kvm/book3s_hv_nested.c                                             |   14 
 arch/powerpc/kvm/trace_hv.h                                                     |    2 
 arch/powerpc/lib/sstep.c                                                        |   12 
 arch/powerpc/mm/fault.c                                                         |   10 
 arch/powerpc/platforms/pseries/dtl.c                                            |    8 
 arch/powerpc/platforms/pseries/lpar.c                                           |    8 
 arch/powerpc/platforms/pseries/plpks.c                                          |    2 
 arch/riscv/include/asm/cpufeature.h                                             |    2 
 arch/riscv/kernel/setup.c                                                       |    2 
 arch/riscv/kernel/traps_misaligned.c                                            |   14 
 arch/riscv/kernel/unaligned_access_speed.c                                      |    1 
 arch/riscv/kvm/aia_aplic.c                                                      |    3 
 arch/riscv/kvm/vcpu_sbi.c                                                       |   11 
 arch/s390/include/asm/facility.h                                                |   18 
 arch/s390/include/asm/pci.h                                                     |    4 
 arch/s390/include/asm/set_memory.h                                              |    1 
 arch/s390/kernel/perf_cpum_sf.c                                                 |    2 
 arch/s390/kernel/syscalls/Makefile                                              |    2 
 arch/s390/mm/pageattr.c                                                         |   15 
 arch/s390/pci/pci.c                                                             |   37 
 arch/s390/pci/pci_debug.c                                                       |   10 
 arch/sh/kernel/cpu/proc.c                                                       |    2 
 arch/sh/kernel/setup.c                                                          |    2 
 arch/um/drivers/net_kern.c                                                      |    2 
 arch/um/drivers/ubd_kern.c                                                      |    4 
 arch/um/drivers/vector_kern.c                                                   |    3 
 arch/um/kernel/dtb.c                                                            |    2 
 arch/um/kernel/physmem.c                                                        |    6 
 arch/um/kernel/process.c                                                        |    2 
 arch/um/kernel/sysrq.c                                                          |    2 
 arch/x86/coco/tdx/tdx.c                                                         |  111 +
 arch/x86/crypto/aegis128-aesni-asm.S                                            |   29 
 arch/x86/events/intel/pt.c                                                      |   11 
 arch/x86/events/intel/pt.h                                                      |    2 
 arch/x86/include/asm/atomic64_32.h                                              |    3 
 arch/x86/include/asm/cmpxchg_32.h                                               |    6 
 arch/x86/include/asm/kvm_host.h                                                 |    4 
 arch/x86/include/asm/shared/tdx.h                                               |   11 
 arch/x86/include/asm/tlb.h                                                      |    4 
 arch/x86/kernel/cpu/amd.c                                                       |    1 
 arch/x86/kernel/cpu/common.c                                                    |    4 
 arch/x86/kernel/cpu/microcode/amd.c                                             |   25 
 arch/x86/kernel/devicetree.c                                                    |    2 
 arch/x86/kernel/unwind_orc.c                                                    |    2 
 arch/x86/kvm/Kconfig                                                            |    5 
 arch/x86/kvm/mmu/mmu.c                                                          |   68 
 arch/x86/kvm/mmu/spte.c                                                         |   18 
 arch/x86/kvm/vmx/vmx.c                                                          |   54 
 arch/x86/mm/tlb.c                                                               |    3 
 arch/x86/platform/pvh/head.S                                                    |    9 
 arch/xtensa/kernel/setup.c                                                      |    2 
 block/bfq-cgroup.c                                                              |    1 
 block/bfq-iosched.c                                                             |   43 
 block/blk-core.c                                                                |   18 
 block/blk-merge.c                                                               |   45 
 block/blk-mq.c                                                                  |  148 +
 block/blk-mq.h                                                                  |   13 
 block/blk-settings.c                                                            |    7 
 block/blk-sysfs.c                                                               |    6 
 block/blk-zoned.c                                                               |   14 
 block/blk.h                                                                     |   30 
 block/elevator.c                                                                |   10 
 block/fops.c                                                                    |   25 
 block/genhd.c                                                                   |   24 
 crypto/pcrypt.c                                                                 |   12 
 drivers/accel/ivpu/ivpu_ipc.c                                                   |   35 
 drivers/accel/ivpu/ivpu_ipc.h                                                   |    7 
 drivers/accel/ivpu/ivpu_jsm_msg.c                                               |   19 
 drivers/acpi/arm64/gtdt.c                                                       |    2 
 drivers/acpi/cppc_acpi.c                                                        |    1 
 drivers/base/firmware_loader/main.c                                             |    5 
 drivers/base/regmap/regmap-irq.c                                                |    4 
 drivers/base/trace.h                                                            |    6 
 drivers/block/brd.c                                                             |   70 
 drivers/block/loop.c                                                            |    6 
 drivers/block/ublk_drv.c                                                        |   17 
 drivers/block/virtio_blk.c                                                      |   46 
 drivers/block/zram/Kconfig                                                      |    1 
 drivers/block/zram/zram_drv.c                                                   |   21 
 drivers/block/zram/zram_drv.h                                                   |    1 
 drivers/bluetooth/btbcm.c                                                       |    4 
 drivers/bluetooth/btintel.c                                                     |   62 
 drivers/bluetooth/btintel.h                                                     |    7 
 drivers/bluetooth/btintel_pcie.c                                                |  265 ++
 drivers/bluetooth/btintel_pcie.h                                                |   16 
 drivers/bluetooth/btmtk.c                                                       |    1 
 drivers/bluetooth/btusb.c                                                       |    1 
 drivers/bus/mhi/host/trace.h                                                    |   25 
 drivers/clk/.kunitconfig                                                        |    1 
 drivers/clk/Kconfig                                                             |    2 
 drivers/clk/clk-apple-nco.c                                                     |    3 
 drivers/clk/clk-axi-clkgen.c                                                    |   22 
 drivers/clk/clk-en7523.c                                                        |  264 ++
 drivers/clk/clk-loongson2.c                                                     |    6 
 drivers/clk/imx/clk-fracn-gppll.c                                               |   10 
 drivers/clk/imx/clk-imx8-acm.c                                                  |    4 
 drivers/clk/imx/clk-lpcg-scu.c                                                  |   37 
 drivers/clk/imx/clk-scu.c                                                       |    2 
 drivers/clk/mediatek/Kconfig                                                    |   15 
 drivers/clk/qcom/Kconfig                                                        |    4 
 drivers/clk/ralink/clk-mtmips.c                                                 |   26 
 drivers/clk/renesas/rzg2l-cpg.c                                                 |   11 
 drivers/clk/sophgo/clk-sg2042-pll.c                                             |    2 
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c                                            |    2 
 drivers/clocksource/Kconfig                                                     |    3 
 drivers/clocksource/timer-ti-dm-systimer.c                                      |    4 
 drivers/comedi/comedi_fops.c                                                    |   12 
 drivers/counter/stm32-timer-cnt.c                                               |   17 
 drivers/counter/ti-ecap-capture.c                                               |    7 
 drivers/cpufreq/amd-pstate.c                                                    |   26 
 drivers/cpufreq/cppc_cpufreq.c                                                  |   63 
 drivers/cpufreq/loongson2_cpufreq.c                                             |    4 
 drivers/cpufreq/loongson3_cpufreq.c                                             |    7 
 drivers/cpufreq/mediatek-cpufreq-hw.c                                           |    2 
 drivers/crypto/bcm/cipher.c                                                     |    5 
 drivers/crypto/caam/caampkc.c                                                   |   11 
 drivers/crypto/caam/qi.c                                                        |    2 
 drivers/crypto/cavium/cpt/cptpf_main.c                                          |    6 
 drivers/crypto/hisilicon/hpre/hpre_main.c                                       |   35 
 drivers/crypto/hisilicon/qm.c                                                   |   47 
 drivers/crypto/hisilicon/sec2/sec_main.c                                        |   35 
 drivers/crypto/hisilicon/zip/zip_main.c                                         |   35 
 drivers/crypto/inside-secure/safexcel_hash.c                                    |    2 
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c                          |    2 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c                            |    2 
 drivers/crypto/intel/qat/qat_common/adf_aer.c                                   |    5 
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.c                                 |   13 
 drivers/crypto/intel/qat/qat_common/adf_hw_arbiter.c                            |    4 
 drivers/crypto/mxs-dcp.c                                                        |   20 
 drivers/dax/pmem/Makefile                                                       |    7 
 drivers/dax/pmem/pmem.c                                                         |   10 
 drivers/dma-buf/Kconfig                                                         |    1 
 drivers/dma-buf/udmabuf.c                                                       |   44 
 drivers/edac/bluefield_edac.c                                                   |    2 
 drivers/edac/fsl_ddr_edac.c                                                     |   22 
 drivers/edac/i10nm_base.c                                                       |    1 
 drivers/edac/igen6_edac.c                                                       |    2 
 drivers/edac/skx_common.c                                                       |   57 
 drivers/edac/skx_common.h                                                       |    8 
 drivers/firmware/arm_scpi.c                                                     |    3 
 drivers/firmware/efi/libstub/efi-stub.c                                         |    2 
 drivers/firmware/efi/tpm.c                                                      |   17 
 drivers/firmware/google/gsmi.c                                                  |    6 
 drivers/gpio/gpio-exar.c                                                        |   10 
 drivers/gpio/gpio-zevio.c                                                       |    6 
 drivers/gpu/drm/Kconfig                                                         |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c                                         |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                                      |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                                         |   63 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                                           |    7 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                                           |    2 
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c                                        |   18 
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                                        |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                               |   32 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                               |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                          |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c                       |   13 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                     |   15 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                           |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                         |    6 
 drivers/gpu/drm/bridge/analogix/anx7625.c                                       |    2 
 drivers/gpu/drm/bridge/ite-it6505.c                                             |    2 
 drivers/gpu/drm/bridge/tc358767.c                                               |    7 
 drivers/gpu/drm/drm_file.c                                                      |    2 
 drivers/gpu/drm/drm_mm.c                                                        |    2 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                                           |   10 
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c                                           |   28 
 drivers/gpu/drm/fsl-dcu/Kconfig                                                 |    1 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c                                       |   15 
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h                                       |    3 
 drivers/gpu/drm/imagination/pvr_ccb.c                                           |    2 
 drivers/gpu/drm/imagination/pvr_vm.c                                            |    4 
 drivers/gpu/drm/imx/dcss/dcss-crtc.c                                            |    6 
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c                                          |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                                           |    4 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h                         |   12 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h                          |   14 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c                                   |    2 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                                           |    9 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c                                  |    1 
 drivers/gpu/drm/omapdrm/dss/base.c                                              |   25 
 drivers/gpu/drm/omapdrm/dss/omapdss.h                                           |    3 
 drivers/gpu/drm/omapdrm/omap_drv.c                                              |    4 
 drivers/gpu/drm/omapdrm/omap_gem.c                                              |   10 
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c                                 |    2 
 drivers/gpu/drm/panel/panel-novatek-nt35510.c                                   |   15 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                                     |    3 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                                         |    1 
 drivers/gpu/drm/panthor/panthor_devfreq.c                                       |   29 
 drivers/gpu/drm/panthor/panthor_device.h                                        |   28 
 drivers/gpu/drm/panthor/panthor_sched.c                                         |  333 +++
 drivers/gpu/drm/radeon/radeon_audio.c                                           |   12 
 drivers/gpu/drm/v3d/v3d_drv.h                                                   |    1 
 drivers/gpu/drm/v3d/v3d_irq.c                                                   |    2 
 drivers/gpu/drm/v3d/v3d_mmu.c                                                   |   31 
 drivers/gpu/drm/v3d/v3d_sched.c                                                 |   46 
 drivers/gpu/drm/vc4/tests/vc4_mock.c                                            |   12 
 drivers/gpu/drm/vc4/vc4_bo.c                                                    |   28 
 drivers/gpu/drm/vc4/vc4_crtc.c                                                  |   13 
 drivers/gpu/drm/vc4/vc4_drv.c                                                   |   22 
 drivers/gpu/drm/vc4/vc4_drv.h                                                   |    8 
 drivers/gpu/drm/vc4/vc4_gem.c                                                   |   24 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                                  |   22 
 drivers/gpu/drm/vc4/vc4_hvs.c                                                   |   64 
 drivers/gpu/drm/vc4/vc4_irq.c                                                   |   10 
 drivers/gpu/drm/vc4/vc4_kms.c                                                   |   14 
 drivers/gpu/drm/vc4/vc4_perfmon.c                                               |   20 
 drivers/gpu/drm/vc4/vc4_plane.c                                                 |   12 
 drivers/gpu/drm/vc4/vc4_render_cl.c                                             |    2 
 drivers/gpu/drm/vc4/vc4_v3d.c                                                   |   10 
 drivers/gpu/drm/vc4/vc4_validate.c                                              |    8 
 drivers/gpu/drm/vc4/vc4_validate_shaders.c                                      |    2 
 drivers/gpu/drm/vkms/vkms_output.c                                              |    5 
 drivers/gpu/drm/xe/display/xe_hdcp_gsc.c                                        |    2 
 drivers/gpu/drm/xe/xe_sync.c                                                    |    6 
 drivers/gpu/drm/xlnx/zynqmp_disp.c                                              |    3 
 drivers/gpu/drm/xlnx/zynqmp_kms.c                                               |    2 
 drivers/hid/hid-hyperv.c                                                        |   58 
 drivers/hid/wacom_wac.c                                                         |    4 
 drivers/hwmon/aquacomputer_d5next.c                                             |    2 
 drivers/hwmon/nct6775-core.c                                                    |    7 
 drivers/hwmon/pmbus/pmbus_core.c                                                |   12 
 drivers/hwmon/tps23861.c                                                        |    2 
 drivers/i2c/i2c-dev.c                                                           |   17 
 drivers/i3c/master.c                                                            |   13 
 drivers/iio/accel/adxl380.c                                                     |    2 
 drivers/iio/adc/ad4000.c                                                        |    6 
 drivers/iio/adc/pac1921.c                                                       |    4 
 drivers/iio/dac/adi-axi-dac.c                                                   |    2 
 drivers/iio/industrialio-backend.c                                              |    4 
 drivers/iio/industrialio-gts-helper.c                                           |    2 
 drivers/iio/light/al3010.c                                                      |   11 
 drivers/infiniband/core/roce_gid_mgmt.c                                         |   30 
 drivers/infiniband/core/uverbs.h                                                |    2 
 drivers/infiniband/core/uverbs_main.c                                           |   43 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                        |    7 
 drivers/infiniband/hw/bnxt_re/main.c                                            |   28 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                        |    2 
 drivers/infiniband/hw/hns/hns_roce_cq.c                                         |    4 
 drivers/infiniband/hw/hns/hns_roce_debugfs.c                                    |    3 
 drivers/infiniband/hw/hns/hns_roce_device.h                                     |   14 
 drivers/infiniband/hw/hns/hns_roce_hem.c                                        |   48 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                      |  257 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                                      |    8 
 drivers/infiniband/hw/hns/hns_roce_main.c                                       |    7 
 drivers/infiniband/hw/hns/hns_roce_mr.c                                         |   11 
 drivers/infiniband/hw/hns/hns_roce_qp.c                                         |   77 
 drivers/infiniband/hw/hns/hns_roce_srq.c                                        |    4 
 drivers/infiniband/hw/mlx5/main.c                                               |   69 
 drivers/infiniband/hw/mlx5/mlx5_ib.h                                            |    2 
 drivers/infiniband/sw/rxe/rxe_qp.c                                              |    1 
 drivers/infiniband/sw/rxe/rxe_req.c                                             |    6 
 drivers/input/misc/cs40l50-vibra.c                                              |    6 
 drivers/interconnect/qcom/icc-rpmh.c                                            |    3 
 drivers/iommu/amd/io_pgtable_v2.c                                               |    3 
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c                                  |    5 
 drivers/iommu/intel/iommu.c                                                     |   40 
 drivers/iommu/s390-iommu.c                                                      |   73 
 drivers/irqchip/irq-mvebu-sei.c                                                 |    2 
 drivers/irqchip/irq-riscv-aplic-main.c                                          |    3 
 drivers/irqchip/irq-riscv-aplic-msi.c                                           |    3 
 drivers/leds/flash/leds-ktd2692.c                                               |    1 
 drivers/leds/leds-max5970.c                                                     |    5 
 drivers/mailbox/arm_mhuv2.c                                                     |    8 
 drivers/mailbox/mtk-cmdq-mailbox.c                                              |    2 
 drivers/mailbox/omap-mailbox.c                                                  |    1 
 drivers/media/i2c/adv7604.c                                                     |    5 
 drivers/media/i2c/adv7842.c                                                     |   13 
 drivers/media/i2c/ds90ub960.c                                                   |    2 
 drivers/media/i2c/max96717.c                                                    |    6 
 drivers/media/i2c/vgxy61.c                                                      |    2 
 drivers/media/pci/intel/ipu6/Kconfig                                            |    6 
 drivers/media/pci/intel/ipu6/ipu6-bus.c                                         |    6 
 drivers/media/pci/intel/ipu6/ipu6-buttress.c                                    |   34 
 drivers/media/pci/intel/ipu6/ipu6-cpd.c                                         |   18 
 drivers/media/pci/intel/ipu6/ipu6-dma.c                                         |  202 +-
 drivers/media/pci/intel/ipu6/ipu6-dma.h                                         |   34 
 drivers/media/pci/intel/ipu6/ipu6-fw-com.c                                      |   14 
 drivers/media/pci/intel/ipu6/ipu6-mmu.c                                         |   28 
 drivers/media/pci/intel/ipu6/ipu6.c                                             |    3 
 drivers/media/radio/wl128x/fmdrv_common.c                                       |    3 
 drivers/media/test-drivers/vivid/vivid-vid-cap.c                                |   15 
 drivers/media/v4l2-core/v4l2-dv-timings.c                                       |  132 -
 drivers/message/fusion/mptsas.c                                                 |    4 
 drivers/mfd/da9052-spi.c                                                        |    2 
 drivers/mfd/intel_soc_pmic_bxtwc.c                                              |  132 -
 drivers/mfd/rt5033.c                                                            |    4 
 drivers/mfd/tps65010.c                                                          |    8 
 drivers/misc/apds990x.c                                                         |   12 
 drivers/misc/lkdtm/bugs.c                                                       |    2 
 drivers/mmc/host/mmc_spi.c                                                      |    9 
 drivers/mtd/hyperbus/rpc-if.c                                                   |    7 
 drivers/mtd/nand/raw/atmel/pmecc.c                                              |    8 
 drivers/mtd/nand/raw/atmel/pmecc.h                                              |    2 
 drivers/mtd/spi-nor/core.c                                                      |    2 
 drivers/mtd/spi-nor/spansion.c                                                  |    1 
 drivers/mtd/ubi/attach.c                                                        |   12 
 drivers/mtd/ubi/fastmap-wl.c                                                    |   19 
 drivers/mtd/ubi/vmt.c                                                           |    2 
 drivers/mtd/ubi/wl.c                                                            |   11 
 drivers/mtd/ubi/wl.h                                                            |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                       |   37 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                               |    9 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c                                   |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h                                   |    3 
 drivers/net/ethernet/broadcom/tg3.c                                             |    3 
 drivers/net/ethernet/google/gve/gve_adminq.c                                    |    4 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                                  |    2 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                                   |   21 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                                 |   70 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.h                                 |    5 
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h                         |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                                 |   87 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h                                 |   18 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                                 |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                             |   45 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                              |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                        |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c                         |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c                      |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c                       |   10 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c                         |   10 
 drivers/net/ethernet/marvell/pxa168_eth.c                                       |   14 
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c                               |   12 
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c                                     |    2 
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c                            |   17 
 drivers/net/ethernet/realtek/rtase/rtase.h                                      |    7 
 drivers/net/ethernet/realtek/rtase/rtase_main.c                                 |   43 
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c                             |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                                  |   24 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                                 |    1 
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c                                  |  168 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h                                  |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h                                 |    7 
 drivers/net/mdio/mdio-ipq4019.c                                                 |    5 
 drivers/net/netdevsim/ipsec.c                                                   |   11 
 drivers/net/usb/lan78xx.c                                                       |   40 
 drivers/net/wireless/ath/ath10k/mac.c                                           |    4 
 drivers/net/wireless/ath/ath11k/qmi.c                                           |    3 
 drivers/net/wireless/ath/ath12k/dp.c                                            |   19 
 drivers/net/wireless/ath/ath12k/mac.c                                           |    5 
 drivers/net/wireless/ath/ath12k/wow.c                                           |    2 
 drivers/net/wireless/ath/ath9k/htc_hst.c                                        |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c                           |    3 
 drivers/net/wireless/intel/iwlegacy/3945.c                                      |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                                  |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                               |    8 
 drivers/net/wireless/intersil/p54/p54spi.c                                      |    4 
 drivers/net/wireless/marvell/mwifiex/cmdevt.c                                   |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                                       |    2 
 drivers/net/wireless/marvell/mwifiex/main.c                                     |    4 
 drivers/net/wireless/marvell/mwifiex/util.c                                     |    2 
 drivers/net/wireless/microchip/wilc1000/netdev.c                                |    6 
 drivers/net/wireless/realtek/rtl8xxxu/core.c                                    |    6 
 drivers/net/wireless/realtek/rtlwifi/efuse.c                                    |   11 
 drivers/net/wireless/realtek/rtw89/cam.c                                        |  259 ++
 drivers/net/wireless/realtek/rtw89/cam.h                                        |   24 
 drivers/net/wireless/realtek/rtw89/chan.c                                       |  215 +-
 drivers/net/wireless/realtek/rtw89/chan.h                                       |    4 
 drivers/net/wireless/realtek/rtw89/coex.c                                       |  157 +
 drivers/net/wireless/realtek/rtw89/coex.h                                       |    6 
 drivers/net/wireless/realtek/rtw89/core.c                                       |  887 ++++++----
 drivers/net/wireless/realtek/rtw89/core.h                                       |  421 +++-
 drivers/net/wireless/realtek/rtw89/debug.c                                      |  127 +
 drivers/net/wireless/realtek/rtw89/fw.c                                         |  637 ++++---
 drivers/net/wireless/realtek/rtw89/fw.h                                         |  192 +-
 drivers/net/wireless/realtek/rtw89/mac.c                                        |  700 ++++---
 drivers/net/wireless/realtek/rtw89/mac.h                                        |   98 -
 drivers/net/wireless/realtek/rtw89/mac80211.c                                   |  653 +++++--
 drivers/net/wireless/realtek/rtw89/mac_be.c                                     |   69 
 drivers/net/wireless/realtek/rtw89/phy.c                                        |  399 ++--
 drivers/net/wireless/realtek/rtw89/phy.h                                        |    7 
 drivers/net/wireless/realtek/rtw89/ps.c                                         |  109 -
 drivers/net/wireless/realtek/rtw89/ps.h                                         |   14 
 drivers/net/wireless/realtek/rtw89/regd.c                                       |   79 
 drivers/net/wireless/realtek/rtw89/rtw8851b.c                                   |   13 
 drivers/net/wireless/realtek/rtw89/rtw8852a.c                                   |   12 
 drivers/net/wireless/realtek/rtw89/rtw8852b.c                                   |   13 
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c                                  |   13 
 drivers/net/wireless/realtek/rtw89/rtw8852c.c                                   |   12 
 drivers/net/wireless/realtek/rtw89/rtw8922a.c                                   |   10 
 drivers/net/wireless/realtek/rtw89/ser.c                                        |   37 
 drivers/net/wireless/realtek/rtw89/wow.c                                        |  217 +-
 drivers/net/wireless/realtek/rtw89/wow.h                                        |   10 
 drivers/net/wireless/silabs/wfx/main.c                                          |   17 
 drivers/net/wireless/st/cw1200/cw1200_spi.c                                     |    2 
 drivers/nvme/host/core.c                                                        |    5 
 drivers/nvme/host/multipath.c                                                   |   21 
 drivers/nvme/host/pci.c                                                         |   55 
 drivers/of/fdt.c                                                                |   14 
 drivers/of/kexec.c                                                              |    2 
 drivers/pci/controller/cadence/pci-j721e.c                                      |   26 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                                       |    6 
 drivers/pci/controller/dwc/pcie-qcom.c                                          |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                                      |    7 
 drivers/pci/endpoint/functions/pci-epf-mhi.c                                    |    6 
 drivers/pci/hotplug/cpqphp_pci.c                                                |   15 
 drivers/pci/pci.c                                                               |    5 
 drivers/pci/slot.c                                                              |    4 
 drivers/perf/arm-cmn.c                                                          |    4 
 drivers/perf/arm_smmuv3_pmu.c                                                   |   19 
 drivers/phy/phy-airoha-pcie-regs.h                                              |    6 
 drivers/phy/phy-airoha-pcie.c                                                   |    8 
 drivers/phy/realtek/phy-rtk-usb2.c                                              |    2 
 drivers/phy/realtek/phy-rtk-usb3.c                                              |    2 
 drivers/pinctrl/pinctrl-k210.c                                                  |    2 
 drivers/pinctrl/pinctrl-zynqmp.c                                                |    1 
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                                        |    2 
 drivers/pinctrl/renesas/Kconfig                                                 |    1 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                                         |    2 
 drivers/platform/chrome/cros_ec_typec.c                                         |    1 
 drivers/platform/x86/asus-wmi.c                                                 |   64 
 drivers/platform/x86/intel/bxtwc_tmu.c                                          |   22 
 drivers/platform/x86/intel/pmt/class.c                                          |    8 
 drivers/platform/x86/intel/pmt/class.h                                          |    2 
 drivers/platform/x86/intel/pmt/telemetry.c                                      |    2 
 drivers/platform/x86/panasonic-laptop.c                                         |   10 
 drivers/pmdomain/ti/ti_sci_pm_domains.c                                         |    4 
 drivers/power/reset/Kconfig                                                     |    1 
 drivers/power/sequencing/Kconfig                                                |    1 
 drivers/power/supply/bq27xxx_battery.c                                          |   37 
 drivers/power/supply/power_supply_core.c                                        |    2 
 drivers/power/supply/rt9471.c                                                   |   52 
 drivers/pwm/core.c                                                              |   10 
 drivers/pwm/pwm-imx27.c                                                         |   98 +
 drivers/regulator/qcom_smd-regulator.c                                          |    2 
 drivers/regulator/rk808-regulator.c                                             |   15 
 drivers/remoteproc/Kconfig                                                      |    6 
 drivers/remoteproc/qcom_q6v5_adsp.c                                             |   11 
 drivers/remoteproc/qcom_q6v5_mss.c                                              |    6 
 drivers/remoteproc/qcom_q6v5_pas.c                                              |   22 
 drivers/rpmsg/qcom_glink_native.c                                               |    3 
 drivers/rtc/interface.c                                                         |    7 
 drivers/rtc/rtc-ab-eoz9.c                                                       |    7 
 drivers/rtc/rtc-abx80x.c                                                        |    2 
 drivers/rtc/rtc-rzn1.c                                                          |    8 
 drivers/rtc/rtc-st-lpc.c                                                        |    5 
 drivers/s390/cio/cio.c                                                          |    6 
 drivers/s390/cio/device.c                                                       |   18 
 drivers/s390/virtio/virtio_ccw.c                                                |    4 
 drivers/scsi/bfa/bfad.c                                                         |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                                           |    8 
 drivers/scsi/qedf/qedf_main.c                                                   |    1 
 drivers/scsi/qedi/qedi_main.c                                                   |    1 
 drivers/scsi/sg.c                                                               |    9 
 drivers/sh/intc/core.c                                                          |    2 
 drivers/soc/fsl/qe/qmc.c                                                        |    4 
 drivers/soc/fsl/rcpm.c                                                          |    1 
 drivers/soc/qcom/qcom-geni-se.c                                                 |    3 
 drivers/soc/ti/smartreflex.c                                                    |    4 
 drivers/soc/xilinx/xlnx_event_manager.c                                         |    4 
 drivers/spi/atmel-quadspi.c                                                     |    2 
 drivers/spi/spi-fsl-lpspi.c                                                     |   12 
 drivers/spi/spi-tegra210-quad.c                                                 |    2 
 drivers/spi/spi-zynqmp-gqspi.c                                                  |    2 
 drivers/spi/spi.c                                                               |   13 
 drivers/staging/media/atomisp/pci/sh_css_params.c                               |    2 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c                   |    6 
 drivers/target/target_core_pscsi.c                                              |    2 
 drivers/thermal/testing/zone.c                                                  |   32 
 drivers/thermal/thermal_core.c                                                  |  123 -
 drivers/thermal/thermal_core.h                                                  |   12 
 drivers/tty/serial/8250/8250_fintek.c                                           |   14 
 drivers/tty/serial/8250/8250_omap.c                                             |    4 
 drivers/tty/serial/amba-pl011.c                                                 |    7 
 drivers/tty/tty_io.c                                                            |    2 
 drivers/usb/dwc3/core.h                                                         |    4 
 drivers/usb/dwc3/ep0.c                                                          |    2 
 drivers/usb/dwc3/gadget.c                                                       |   69 
 drivers/usb/gadget/composite.c                                                  |   18 
 drivers/usb/gadget/function/uvc_video.c                                         |    4 
 drivers/usb/host/ehci-spear.c                                                   |    7 
 drivers/usb/host/xhci-pci.c                                                     |   10 
 drivers/usb/host/xhci-ring.c                                                    |   73 
 drivers/usb/host/xhci.c                                                         |   40 
 drivers/usb/host/xhci.h                                                         |    3 
 drivers/usb/misc/chaoskey.c                                                     |   35 
 drivers/usb/misc/iowarrior.c                                                    |   50 
 drivers/usb/misc/usb-ljca.c                                                     |   20 
 drivers/usb/misc/yurex.c                                                        |    5 
 drivers/usb/musb/musb_gadget.c                                                  |   13 
 drivers/usb/typec/tcpm/wcove.c                                                  |    4 
 drivers/usb/typec/ucsi/ucsi_ccg.c                                               |    5 
 drivers/usb/typec/ucsi/ucsi_glink.c                                             |    2 
 drivers/vdpa/mlx5/core/mr.c                                                     |    4 
 drivers/vfio/pci/mlx5/cmd.c                                                     |    6 
 drivers/vfio/pci/mlx5/main.c                                                    |   35 
 drivers/vfio/pci/vfio_pci_config.c                                              |   16 
 drivers/video/fbdev/sh7760fb.c                                                  |    3 
 drivers/watchdog/Kconfig                                                        |    4 
 drivers/xen/xenbus/xenbus_probe.c                                               |    8 
 fs/binfmt_elf.c                                                                 |    2 
 fs/binfmt_elf_fdpic.c                                                           |    5 
 fs/binfmt_misc.c                                                                |    7 
 fs/cachefiles/interface.c                                                       |   14 
 fs/cachefiles/ondemand.c                                                        |   38 
 fs/dlm/ast.c                                                                    |    2 
 fs/dlm/recoverd.c                                                               |    2 
 fs/efs/super.c                                                                  |   43 
 fs/erofs/data.c                                                                 |   10 
 fs/erofs/internal.h                                                             |    1 
 fs/erofs/super.c                                                                |    6 
 fs/erofs/zmap.c                                                                 |   17 
 fs/exec.c                                                                       |   23 
 fs/exfat/file.c                                                                 |   10 
 fs/exfat/namei.c                                                                |   21 
 fs/ext4/balloc.c                                                                |    4 
 fs/ext4/ext4.h                                                                  |   12 
 fs/ext4/extents.c                                                               |    2 
 fs/ext4/fsmap.c                                                                 |   54 
 fs/ext4/ialloc.c                                                                |    5 
 fs/ext4/indirect.c                                                              |    2 
 fs/ext4/inode.c                                                                 |    4 
 fs/ext4/mballoc.c                                                               |   18 
 fs/ext4/mballoc.h                                                               |    1 
 fs/ext4/mmp.c                                                                   |    2 
 fs/ext4/move_extent.c                                                           |    2 
 fs/ext4/resize.c                                                                |    2 
 fs/ext4/super.c                                                                 |   42 
 fs/f2fs/checkpoint.c                                                            |    2 
 fs/f2fs/data.c                                                                  |   29 
 fs/f2fs/f2fs.h                                                                  |    3 
 fs/f2fs/file.c                                                                  |   17 
 fs/f2fs/gc.c                                                                    |    2 
 fs/f2fs/node.c                                                                  |   10 
 fs/f2fs/segment.c                                                               |    5 
 fs/f2fs/segment.h                                                               |   35 
 fs/f2fs/super.c                                                                 |   37 
 fs/fcntl.c                                                                      |    3 
 fs/fuse/file.c                                                                  |   62 
 fs/fuse/fuse_i.h                                                                |    6 
 fs/fuse/virtio_fs.c                                                             |    1 
 fs/gfs2/glock.c                                                                 |   19 
 fs/gfs2/glock.h                                                                 |    1 
 fs/gfs2/incore.h                                                                |    2 
 fs/gfs2/rgrp.c                                                                  |    2 
 fs/gfs2/super.c                                                                 |    2 
 fs/hfsplus/hfsplus_fs.h                                                         |    3 
 fs/hfsplus/wrapper.c                                                            |    2 
 fs/hostfs/hostfs_kern.c                                                         |    4 
 fs/isofs/inode.c                                                                |    8 
 fs/jffs2/erase.c                                                                |    7 
 fs/jfs/xattr.c                                                                  |    2 
 fs/netfs/fscache_volume.c                                                       |    3 
 fs/nfs/blocklayout/blocklayout.c                                                |   15 
 fs/nfs/blocklayout/dev.c                                                        |    6 
 fs/nfs/internal.h                                                               |    2 
 fs/nfs/localio.c                                                                |    6 
 fs/nfs/nfs4proc.c                                                               |    8 
 fs/nfs/write.c                                                                  |   49 
 fs/nfs_common/nfslocalio.c                                                      |    8 
 fs/nfsd/export.c                                                                |   31 
 fs/nfsd/export.h                                                                |    4 
 fs/nfsd/filecache.c                                                             |   14 
 fs/nfsd/filecache.h                                                             |    2 
 fs/nfsd/nfs4callback.c                                                          |   16 
 fs/nfsd/nfs4proc.c                                                              |    7 
 fs/nfsd/nfs4recover.c                                                           |    3 
 fs/nfsd/nfs4state.c                                                             |    5 
 fs/nfsd/nfs4xdr.c                                                               |    2 
 fs/nfsd/nfsfh.c                                                                 |   20 
 fs/nfsd/nfsfh.h                                                                 |    3 
 fs/notify/fsnotify.c                                                            |   23 
 fs/notify/mark.c                                                                |   12 
 fs/ntfs3/file.c                                                                 |    2 
 fs/ocfs2/aops.h                                                                 |    2 
 fs/ocfs2/file.c                                                                 |    4 
 fs/proc/kcore.c                                                                 |   10 
 fs/read_write.c                                                                 |   15 
 fs/smb/client/cached_dir.c                                                      |  229 +-
 fs/smb/client/cached_dir.h                                                      |    6 
 fs/smb/client/cifsacl.c                                                         |   50 
 fs/smb/client/cifsfs.c                                                          |   12 
 fs/smb/client/cifsglob.h                                                        |    4 
 fs/smb/client/cifsproto.h                                                       |    5 
 fs/smb/client/connect.c                                                         |   59 
 fs/smb/client/fs_context.c                                                      |   85 
 fs/smb/client/fs_context.h                                                      |    1 
 fs/smb/client/inode.c                                                           |    8 
 fs/smb/client/reparse.c                                                         |   95 -
 fs/smb/client/reparse.h                                                         |    6 
 fs/smb/client/smb1ops.c                                                         |    4 
 fs/smb/client/smb2file.c                                                        |   21 
 fs/smb/client/smb2inode.c                                                       |    6 
 fs/smb/client/smb2ops.c                                                         |    2 
 fs/smb/client/smb2pdu.c                                                         |    6 
 fs/smb/client/smb2proto.h                                                       |   11 
 fs/smb/client/smb2transport.c                                                   |   56 
 fs/smb/client/trace.h                                                           |    3 
 fs/smb/server/server.c                                                          |    4 
 fs/ubifs/super.c                                                                |    6 
 fs/ubifs/tnc_commit.c                                                           |    2 
 fs/unicode/utf8-core.c                                                          |    2 
 fs/xfs/xfs_bmap_util.c                                                          |    8 
 include/asm-generic/vmlinux.lds.h                                               |    4 
 include/kunit/skbuff.h                                                          |    2 
 include/linux/blk-mq.h                                                          |    2 
 include/linux/blkdev.h                                                          |   12 
 include/linux/bpf.h                                                             |    9 
 include/linux/cleanup.h                                                         |    4 
 include/linux/compiler_attributes.h                                             |   13 
 include/linux/compiler_types.h                                                  |   19 
 include/linux/f2fs_fs.h                                                         |    6 
 include/linux/fs.h                                                              |    2 
 include/linux/hisi_acc_qm.h                                                     |    8 
 include/linux/intel_vsec.h                                                      |    3 
 include/linux/jiffies.h                                                         |    2 
 include/linux/kfifo.h                                                           |    1 
 include/linux/kvm_host.h                                                        |    6 
 include/linux/lockdep.h                                                         |    2 
 include/linux/mmdebug.h                                                         |    6 
 include/linux/netpoll.h                                                         |    2 
 include/linux/nfslocalio.h                                                      |   18 
 include/linux/of_fdt.h                                                          |    5 
 include/linux/once.h                                                            |    4 
 include/linux/once_lite.h                                                       |    2 
 include/linux/rcupdate.h                                                        |    2 
 include/linux/rwlock_rt.h                                                       |   10 
 include/linux/sched/ext.h                                                       |    1 
 include/linux/seqlock.h                                                         |   98 -
 include/linux/spinlock_rt.h                                                     |   23 
 include/media/v4l2-dv-timings.h                                                 |   18 
 include/net/bluetooth/hci.h                                                     |    4 
 include/net/bluetooth/hci_core.h                                                |   63 
 include/net/net_debug.h                                                         |    2 
 include/rdma/ib_verbs.h                                                         |   11 
 include/uapi/linux/rtnetlink.h                                                  |    2 
 init/Kconfig                                                                    |    9 
 init/initramfs.c                                                                |   15 
 io_uring/memmap.c                                                               |   11 
 ipc/namespace.c                                                                 |    4 
 kernel/bpf/bpf_struct_ops.c                                                     |  114 +
 kernel/bpf/btf.c                                                                |    5 
 kernel/bpf/dispatcher.c                                                         |    3 
 kernel/bpf/trampoline.c                                                         |    9 
 kernel/bpf/verifier.c                                                           |  103 +
 kernel/cgroup/cgroup.c                                                          |   21 
 kernel/fork.c                                                                   |   26 
 kernel/rcu/rcuscale.c                                                           |    6 
 kernel/rcu/srcutiny.c                                                           |    2 
 kernel/rcu/tree.c                                                               |   14 
 kernel/rcu/tree_nocb.h                                                          |   13 
 kernel/sched/cpufreq_schedutil.c                                                |    3 
 kernel/sched/ext.c                                                              |    9 
 kernel/time/time.c                                                              |    4 
 kernel/time/timer.c                                                             |    3 
 kernel/trace/bpf_trace.c                                                        |    5 
 kernel/trace/trace_event_perf.c                                                 |    6 
 lib/overflow_kunit.c                                                            |    2 
 lib/string_helpers.c                                                            |    2 
 lib/strncpy_from_user.c                                                         |    5 
 mm/internal.h                                                                   |    2 
 net/9p/trans_usbg.c                                                             |    4 
 net/9p/trans_xen.c                                                              |    9 
 net/bluetooth/hci_conn.c                                                        |  219 +-
 net/bluetooth/hci_event.c                                                       |   39 
 net/bluetooth/hci_sysfs.c                                                       |   15 
 net/bluetooth/iso.c                                                             |  101 -
 net/bluetooth/mgmt.c                                                            |   38 
 net/bluetooth/rfcomm/sock.c                                                     |   10 
 net/core/filter.c                                                               |   88 
 net/core/netdev-genl.c                                                          |    2 
 net/core/skmsg.c                                                                |    4 
 net/hsr/hsr_device.c                                                            |    4 
 net/ipv4/inet_connection_sock.c                                                 |    2 
 net/ipv4/ipmr.c                                                                 |   42 
 net/ipv6/addrconf.c                                                             |   41 
 net/ipv6/ip6_fib.c                                                              |    8 
 net/ipv6/ip6mr.c                                                                |   38 
 net/ipv6/route.c                                                                |   51 
 net/iucv/af_iucv.c                                                              |   26 
 net/l2tp/l2tp_core.c                                                            |   22 
 net/llc/af_llc.c                                                                |    2 
 net/netfilter/ipset/ip_set_bitmap_ip.c                                          |    7 
 net/netfilter/nf_tables_api.c                                                   |   60 
 net/netlink/af_netlink.c                                                        |   21 
 net/rfkill/rfkill-gpio.c                                                        |    8 
 net/rxrpc/af_rxrpc.c                                                            |    7 
 net/sched/sch_fq.c                                                              |    6 
 net/sunrpc/cache.c                                                              |    4 
 net/sunrpc/svcsock.c                                                            |    4 
 net/sunrpc/xprtrdma/svc_rdma.c                                                  |   19 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                                         |    8 
 net/sunrpc/xprtsock.c                                                           |   17 
 net/wireless/core.c                                                             |   64 
 net/wireless/mlme.c                                                             |    6 
 net/wireless/nl80211.c                                                          |    1 
 net/xdp/xsk.c                                                                   |   11 
 rust/helpers/spinlock.c                                                         |    8 
 rust/kernel/block/mq/request.rs                                                 |   67 
 rust/kernel/lib.rs                                                              |    2 
 rust/kernel/rbtree.rs                                                           |    9 
 rust/macros/lib.rs                                                              |    2 
 samples/bpf/xdp_adjust_tail_kern.c                                              |    1 
 samples/kfifo/dma-example.c                                                     |    1 
 scripts/checkpatch.pl                                                           |   37 
 scripts/faddr2line                                                              |    2 
 scripts/kernel-doc                                                              |   47 
 scripts/mod/file2alias.c                                                        |    5 
 scripts/package/builddeb                                                        |   22 
 security/apparmor/capability.c                                                  |    2 
 security/apparmor/policy_unpack_test.c                                          |    6 
 sound/core/pcm_native.c                                                         |    6 
 sound/core/rawmidi.c                                                            |    4 
 sound/core/sound_kunit.c                                                        |   11 
 sound/core/ump.c                                                                |    5 
 sound/pci/hda/patch_realtek.c                                                   |  153 -
 sound/soc/amd/acp/acp-sdw-sof-mach.c                                            |   16 
 sound/soc/amd/yc/acp6x-mach.c                                                   |   25 
 sound/soc/codecs/da7213.c                                                       |    1 
 sound/soc/codecs/da7219.c                                                       |    9 
 sound/soc/codecs/rt722-sdca.c                                                   |    8 
 sound/soc/fsl/fsl-asoc-card.c                                                   |    8 
 sound/soc/fsl/fsl_micfil.c                                                      |    4 
 sound/soc/fsl/imx-audmix.c                                                      |    3 
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                                       |    9 
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c                         |    4 
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                                       |    9 
 sound/usb/6fire/chip.c                                                          |   10 
 sound/usb/caiaq/audio.c                                                         |   10 
 sound/usb/caiaq/audio.h                                                         |    1 
 sound/usb/caiaq/device.c                                                        |   19 
 sound/usb/caiaq/input.c                                                         |   12 
 sound/usb/caiaq/input.h                                                         |    1 
 sound/usb/clock.c                                                               |   24 
 sound/usb/quirks.c                                                              |   27 
 sound/usb/usx2y/us122l.c                                                        |    5 
 sound/usb/usx2y/usbusx2y.c                                                      |    2 
 tools/bpf/bpftool/jit_disasm.c                                                  |   40 
 tools/gpio/gpio-sloppy-logic-analyzer.sh                                        |    2 
 tools/include/nolibc/arch-s390.h                                                |    1 
 tools/lib/bpf/Makefile                                                          |    3 
 tools/lib/bpf/libbpf.c                                                          |   99 -
 tools/lib/bpf/linker.c                                                          |    2 
 tools/lib/thermal/commands.c                                                    |   52 
 tools/perf/Makefile.config                                                      |    2 
 tools/perf/builtin-ftrace.c                                                     |    2 
 tools/perf/builtin-list.c                                                       |    4 
 tools/perf/builtin-stat.c                                                       |   52 
 tools/perf/builtin-trace.c                                                      |   23 
 tools/perf/pmu-events/empty-pmu-events.c                                        |    2 
 tools/perf/pmu-events/jevents.py                                                |    2 
 tools/perf/tests/attr/test-stat-default                                         |   90 -
 tools/perf/tests/attr/test-stat-detailed-1                                      |  106 -
 tools/perf/tests/attr/test-stat-detailed-2                                      |  130 -
 tools/perf/tests/attr/test-stat-detailed-3                                      |  138 +
 tools/perf/util/bpf-filter.c                                                    |    2 
 tools/perf/util/cs-etm.c                                                        |   25 
 tools/perf/util/disasm.c                                                        |   15 
 tools/perf/util/evlist.c                                                        |   19 
 tools/perf/util/evlist.h                                                        |    1 
 tools/perf/util/machine.c                                                       |    2 
 tools/perf/util/mem-events.c                                                    |    8 
 tools/perf/util/pfm.c                                                           |    4 
 tools/perf/util/pmus.c                                                          |    2 
 tools/perf/util/probe-finder.c                                                  |   21 
 tools/perf/util/probe-finder.h                                                  |    4 
 tools/power/x86/turbostat/turbostat.c                                           |    5 
 tools/testing/selftests/arm64/abi/hwcap.c                                       |    6 
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c                        |    4 
 tools/testing/selftests/arm64/mte/mte_common_util.c                             |    4 
 tools/testing/selftests/bpf/Makefile                                            |    3 
 tools/testing/selftests/bpf/network_helpers.h                                   |    1 
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c                           |    6 
 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c                         |    4 
 tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c                        |    6 
 tools/testing/selftests/bpf/test_progs.c                                        |    9 
 tools/testing/selftests/bpf/test_sockmap.c                                      |  165 +
 tools/testing/selftests/bpf/uprobe_multi.c                                      |    4 
 tools/testing/selftests/mount_setattr/mount_setattr_test.c                      |    2 
 tools/testing/selftests/net/Makefile                                            |    1 
 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh                    |  262 ++
 tools/testing/selftests/net/netfilter/conntrack_dump_flush.c                    |    6 
 tools/testing/selftests/net/pmtu.sh                                             |    2 
 tools/testing/selftests/resctrl/fill_buf.c                                      |    2 
 tools/testing/selftests/resctrl/mbm_test.c                                      |   16 
 tools/testing/selftests/resctrl/resctrl_val.c                                   |    3 
 tools/testing/selftests/vDSO/parse_vdso.c                                       |    3 
 tools/testing/selftests/wireguard/netns.sh                                      |    1 
 tools/tracing/rtla/src/timerlat_hist.c                                          |    2 
 tools/tracing/rtla/src/timerlat_top.c                                           |    2 
 virt/kvm/kvm_main.c                                                             |  103 -
 896 files changed, 13140 insertions(+), 6525 deletions(-)

Abel Vesa (3):
      arm64: dts: qcom: x1e80100-slim7x: Drop orientation-switch from USB SS[0-1] QMP PHYs
      arm64: dts: qcom: x1e80100-vivobook-s15: Drop orientation-switch from USB SS[0-1] QMP PHYs
      dt-bindings: cache: qcom,llcc: Fix X1E80100 reg entries

Adrian Hunter (1):
      perf/x86/intel/pt: Fix buffer full but size is 0 case

Adrián Larumbe (4):
      drm/panfrost: Add missing OPP table refcnt decremental
      drm/panthor: introduce job cycle and timestamp accounting
      drm/panthor: record current and maximum device clock frequencies
      drm/panthor: Fix OPP refcnt leaks in devfreq initialisation

Ahmed Ehab (1):
      locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()

Ahsan Atta (1):
      crypto: qat - remove faulty arbiter config reset

Alan Maguire (1):
      selftests/bpf: Fix uprobe_multi compilation error

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Fix length of speed_input array

Aleksandr Mishin (1):
      acpi/arm64: Adjust error handling procedure in gtdt_parse_timer_block()

Aleksei Vetrov (1):
      wifi: nl80211: fix bounds checker error in nl80211_parse_sched_scan

Alex Zenla (2):
      9p/xen: fix init sequence
      9p/xen: fix release of IRQ

Alexander Aring (2):
      dlm: fix swapped args sb_flags vs sb_status
      dlm: fix dlm_recover_members refcount on error

Alexis Lothoré (eBPF Foundation) (1):
      selftests/bpf: add missing header include for htons

Alper Nebi Yasak (2):
      arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Amir Goldstein (1):
      fsnotify: fix sending inotify event with unexpected filename

Andre Przywara (5):
      kselftest/arm64: hwcap: fix f8dp2 cpuinfo name
      kselftest/arm64: mte: fix printf type warnings about __u64
      kselftest/arm64: mte: fix printf type warnings about longs
      ARM: dts: cubieboard4: Fix DCDC5 regulator constraints
      clk: sunxi-ng: d1: Fix PLL_AUDIO0 preset

Andreas Gruenbacher (3):
      gfs2: Rename GLF_VERIFY_EVICT to GLF_VERIFY_DELETE
      gfs2: Allow immediate GLF_VERIFY_DELETE work
      gfs2: Fix unlinked inode cleanup

Andreas Kemnade (1):
      ARM: dts: omap36xx: declare 1GHz OPP as turbo again

Andrei Simion (1):
      ARM: dts: microchip: sam9x60: Add missing property atmel,usart-mode

Andrej Shadura (1):
      Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()

Andrii Nakryiko (4):
      libbpf: fix sym_is_subprog() logic for weak global subprogs
      libbpf: never interpret subprogs in .text as entry programs
      selftests/bpf: fix test_spin_lock_fail.c's global vars usage
      libbpf: move global data mmap()'ing into bpf_object__load()

André Almeida (1):
      unicode: Fix utf8_load() error path

Andy Shevchenko (11):
      regmap: irq: Set lockdep class for hierarchical IRQ domains
      drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for USB Type-C device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for TMU device
      mfd: intel_soc_pmic_bxtwc: Use IRQ domain for PMIC devices
      mfd: intel_soc_pmic_bxtwc: Fix IRQ domain names duplication
      cpufreq: loongson3: Check for error code from devm_mutex_init() call
      gpio: zevio: Add missed label initialisation
      iio: adc: ad4000: Check for error code from devm_mutex_init() call
      iio: adc: pac1921: Check for error code from devm_mutex_init() call
      x86/Documentation: Update algo in init_size description of boot protocol

Angelo Dureghello (2):
      iio: dac: adi-axi-dac: fix wrong register bitfield
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed

Antonio Quartulli (1):
      m68k: coldfire/device.c: only build FEC when HW macros are defined

Antoniu Miclaus (1):
      iio: accel: adxl380: fix raw sample read

Anurag Dutta (3):
      arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
      arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
      arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances

Ard Biesheuvel (1):
      x86/pvh: Call C code via the kernel virtual mapping

Armin Wolf (1):
      platform/x86: asus-wmi: Fix inconsistent use of thermal policies

Arnaldo Carvalho de Melo (1):
      perf ftrace latency: Fix unit on histogram first entry when using --use-nsec

Arnd Bergmann (5):
      wifi: ath12k: fix one more memcpy size error
      mailbox, remoteproc: k3-m4+: fix compile testing
      power: reset: ep93xx: add AUXILIARY_BUS dependency
      KVM: x86: add back X86_LOCAL_APIC dependency
      serial: amba-pl011: fix build regression

Artem Sadovnikov (1):
      jfs: xattr: check invalid xattr size more strictly

Aurabindo Pillai (1):
      drm/amd/display: fix a memleak issue when driver is removed

Avihai Horon (1):
      vfio/pci: Properly hide first-in-list PCIe extended capability

Balaji Pothunoori (1):
      wifi: ath11k: Fix CE offset address calculation for WCN6750 in SSR

Baochen Qiang (2):
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss1
      wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2

Baolin Liu (1):
      scsi: target: Fix incorrect function name in pscsi_create_type_disk()

Barnabás Czémán (1):
      power: supply: bq27xxx: Fix registers of bq27426

Bart Van Assche (3):
      scsi: sg: Enable runtime power management
      power: supply: core: Remove might_sleep() from power_supply_put()
      blk-mq: Make blk_mq_quiesce_tagset() hold the tag list mutex less long

Bartosz Golaszewski (4):
      mmc: mmc_spi: drop buggy snprintf()
      power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
      pinctrl: zynqmp: drop excess struct member description
      lib: string_helpers: silence snprintf() output truncation warning

Baruch Siach (1):
      doc: rcu: update printed dynticks counter bits

Benjamin Coddington (3):
      SUNRPC: timeout and cancel TLS handshake with -ETIMEDOUT
      nfs/blocklayout: Don't attempt unregister for invalid block device
      nfs/blocklayout: Limit repeat device registration on failure

Benjamin Peterson (3):
      perf trace: avoid garbage when not printing a trace event's arguments
      perf trace: Do not lose last events in a race
      perf trace: Avoid garbage when not printing a syscall's arguments

Benoît Sevens (1):
      ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices

Biju Das (3):
      pinctrl: renesas: rzg2l: Fix missing return in rzg2l_pinctrl_register()
      mtd: hyperbus: rpc-if: Add missing MODULE_DEVICE_TABLE
      clk: renesas: rzg2l: Fix FOUTPOSTDIV clk

Bill O'Donnell (1):
      efs: fix the efs new mount api implementation

Bin Liu (1):
      serial: 8250: omap: Move pm_runtime_get_sync

Bingbu Cao (2):
      media: ipu6: not override the dma_ops of device in driver
      media: ipu6: remove architecture DMA ops dependency in Kconfig

Björn Töpel (3):
      libbpf: Add missing per-arch include path
      selftests: bpf: Add missing per-arch include path
      riscv: kvm: Fix out-of-bounds array access

Borislav Petkov (AMD) (2):
      x86/mm: Carve out INVLPG inline asm for use by others
      x86/microcode/AMD: Flush patch buffer mapping after application

Breno Leitao (3):
      spi: tegra210-quad: Avoid shift-out-of-bounds
      netpoll: Use rcu_access_pointer() in netpoll_poll_lock
      nvme/multipath: Fix RCU list traversal to use SRCU primitive

Cabiddu, Giovanni (1):
      crypto: qat - remove check after debugfs_create_dir()

Carl Vanderlip (1):
      bus: mhi: host: Switch trace_mhi_gen_tre fields to native endian

Carlos Llamas (1):
      Revert "scripts/faddr2line: Check only two symbols when calculating symbol size"

Chao Yu (6):
      f2fs: fix to account dirty data in __get_secs_required()
      f2fs: fix to avoid potential deadlock in f2fs_record_stop_reason()
      f2fs: fix to map blocks correctly for direct write
      f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode
      f2fs: fix to do cast in F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
      f2fs: fix to do sanity check on node blkaddr in truncate_node()

Charles Han (4):
      clk: clk-apple-nco: Add NULL check in applnco_probe
      phy: realtek: usb: fix NULL deref in rtk_usb2phy_probe
      phy: realtek: usb: fix NULL deref in rtk_usb3phy_probe
      ASoC: imx-audmix: Add NULL check in imx_audmix_probe

Chen Ridong (4):
      crypto: caam - add error check to caam_rsa_set_priv_key_form
      crypto: bcm - add error check in the ahash_hmac_init function
      Revert "cgroup: Fix memory leak caused by missing cgroup_bpf_offline"
      cgroup/bpf: only cgroup v2 can be attached by bpf programs

Chen Yufan (1):
      drm/imagination: Convert to use time_before macro

Chen-Yu Tsai (5):
      scripts/kernel-doc: Do not track section counter across processed files
      arm64: dts: mediatek: mt8173-elm-hana: Add vdd-supply to second source trackpad
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Fix DP bridge supply names
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: Add supplies for fixed regulators
      arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec nodes

Cheng Ming Lin (1):
      mtd: spi-nor: core: replace dummy buswidth from addr to data

Chengchang Tang (2):
      RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
      RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

ChiYuan Huang (2):
      power: supply: rt9471: Fix wrong WDT function regfield declaration
      power: supply: rt9471: Use IC status regfield to report real charger status

Chiara Meiohas (3):
      RDMA/mlx5: Call dev_put() after the blocking notifier
      RDMA/core: Implement RoCE GID port rescan and export delete function
      RDMA/mlx5: Ensure active slave attachment to the bond IB device

Chris Lu (1):
      Bluetooth: btmtk: adjust the position to init iso data anchor

Chris Morgan (1):
      arm64: dts: rockchip: correct analog audio name on Indiedroid Nova

Christian Brauner (2):
      fcntl: make F_DUPFD_QUERY associative
      Revert "fs: don't block i_writecount during exec"

Christian Loehle (1):
      sched/cpufreq: Ensure sd is rebuilt for EAS check

Christoph Hellwig (7):
      nvme-pci: fix freeing of the HMB descriptor table
      block: take chunk_sectors into account in bio_split_write_zeroes
      block: fix bio_split_rw_at to take zone_write_granularity into account
      nvme-pci: reverse request order in nvme_queue_rqs
      virtio_blk: reverse request order in virtio_queue_rqs
      kfifo: don't include dma-mapping.h in kfifo.h
      block: return unsigned int from bdev_io_min

Christophe JAILLET (4):
      crypto: caam - Fix the pointer passed to caam_qi_shutdown()
      crypto: cavium - Fix an error handling path in cpt_ucode_load_fw()
      media: i2c: vgxy61: Fix an error handling path in vgxy61_detect()
      iio: light: al3010: Fix an error handling path in al3010_probe()

Christophe Leroy (1):
      powerpc/vdso: Flag VDSO64 entry points as functions

Chuck Lever (5):
      svcrdma: Address an integer overflow
      NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
      NFSD: Fix nfsd4_shutdown_copy()
      NFSD: Prevent a potential integer overflow

Chun-Tse Shao (1):
      perf/arm-smmuv3: Fix lockdep assert in ->event_init()

Clark Wang (1):
      pwm: imx27: Workaround of the pwm output bug when decrease the duty cycle

Claudiu Beznea (2):
      ASoC: da7213: Populate max_register to regmap_config
      serial: sh-sci: Clean sci_ports[0] after at earlycon exit

Colin Ian King (1):
      media: i2c: ds90ub960: Fix missing return check on ub960_rxport_read call

Csókás, Bence (1):
      spi: atmel-quadspi: Fix register name in verbose logging function

Damien Le Moal (1):
      block: Prevent potential deadlock in blk_revalidate_disk_zones()

Dan Carpenter (10):
      crypto: qat/qat_420xx - fix off by one in uof_get_name()
      crypto: qat/qat_4xxx - fix off by one in uof_get_name()
      soc: qcom: geni-se: fix array underflow in geni_se_clk_tbl_get()
      media: i2c: max96717: clean up on error in max96717_subdev_init()
      wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()
      kunit: skb: use "gfp" variable instead of hardcoding GFP_KERNEL
      mailbox: arm_mhuv2: clean up loop in get_irq_chan_comb()
      usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
      cifs: unlock on error in smb3_reconfigure()
      sh: intc: Fix use-after-free bug in register_intc_controller()

Daniel Lezcano (2):
      tools/lib/thermal: Make more generic the command encoding function
      thermal/lib: Fix memory leak on error in thermal_genl_auto()

Daniel Palmer (2):
      m68k: mvme147: Fix SCSI controller IRQ numbers
      m68k: mvme147: Reinstate early console

Daolong Zhu (4):
      arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
      arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns

Darrick J. Wong (2):
      MAINTAINERS: appoint myself the XFS maintainer for 6.12 LTS
      xfs: fix simplify extent lookup in xfs_can_free_eofblocks

Dave Stevenson (7):
      drm/vc4: hvs: Don't write gamma luts on 2711
      drm/vc4: hvs: Fix dlist debug not resetting the next entry pointer
      drm/vc4: hvs: Remove incorrect limit from hvs_dlist debugfs function
      drm/vc4: hvs: Correct logic on stopping an HVS channel
      drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_lut_load
      drm/vc4: Match drm_dev_enter and exit calls in vc4_hvs_atomic_flush
      drm/vc4: Correct generation check in vc4_hvs_lut_load

David Disseldorp (1):
      initramfs: avoid filename buffer overrun

David Laight (1):
      x86: fix off-by-one in access_ok()

David Lechner (1):
      iio: adc: ad4000: fix reading unsigned data

David Thompson (1):
      EDAC/bluefield: Fix potential integer overflow

Dinesh Kumar (1):
      ALSA: hda/realtek: Fix Internal Speaker and Mic boost of Infinix Y4 Max

Dipendra Khadka (6):
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_common.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in cn10k.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
      octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for EliteBook X G1i

Dmitry Antipov (2):
      Bluetooth: fix use-after-free in device_for_each_child()
      ocfs2: fix uninitialized value in ocfs2_file_read_iter()

Dmitry Baryshkov (7):
      arm64: dts: qcom: qcs6390-rb3gen2: use modem.mbn for modem DSP
      arm64: dts: qcom: sda660-ifc6560: fix l10a voltage ranges
      drm/msm/dpu: on SDM845 move DSPP_3 to LM_5 block
      drm/msm/dpu: drop LM_3 / LM_4 on SDM845
      drm/msm/dpu: drop LM_3 / LM_4 on MSM8998
      remoteproc: qcom: pas: add minidump_id to SM8350 resources
      usb: typec: ucsi: glink: fix off-by-one in connector_status

Dom Cobley (2):
      drm/vc4: hdmi: Avoid hang with debug registers when suspended
      drm/vc4: hdmi: Increase audio MAI fifo dreq threshold

Dong Aisheng (1):
      clk: imx: clk-scu: fix clk enable state save and restore

Dragan Simic (1):
      regulator: rk808: Restrict DVS GPIOs to the RK808 variant only

Eder Zulian (1):
      rust: helpers: Avoid raw_spin_lock initialization for PREEMPT_RT

Eduard Zingerman (1):
      selftests/bpf: Fix backtrace printing for selftests crashes

Edward Adam Davis (1):
      USB: chaoskey: Fix possible deadlock chaoskey_list_lock

Emmanuel Grumbach (2):
      wifi: iwlwifi: allow fast resume on ax200
      wifi: iwlwifi: mvm: tell iwlmei when we finished suspending

Eric Biggers (1):
      crypto: x86/aegis128 - access 32-bit arguments as 32-bit

Eric Dumazet (1):
      net: hsr: fix hsr_init_sk() vs network/transport headers.

Everest K.C (2):
      crypto: cavium - Fix the if condition to exit loop after timeout
      ASoC: rt722-sdca: Remove logically deadcode in rt722-sdca.c

Fangzhi Zuo (3):
      drm/amd/display: Skip Invalid Streams from DSC Policy
      drm/amd/display: Fix incorrect DSC recompute trigger
      drm/amd/display: Reduce HPD Detection Interval for IPS

Fei Shao (3):
      arm64: dts: mediatek: mt8188: Fix USB3 PHY port default status
      arm64: dts: mediatek: mt8195-cherry: Use correct audio codec DAI
      dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only

Felix Maurer (1):
      xsk: Free skb when TX metadata options are invalid

Feng Fang (1):
      RDMA/hns: Fix different dgids mapping to the same dip_idx

Filip Brozovic (1):
      serial: 8250_fintek: Add support for F81216E

Florian Westphal (3):
      netfilter: nf_tables: avoid false-positive lockdep splat on rule deletion
      netfilter: nf_tables: must hold rcu read lock while iterating expression type list
      netfilter: nf_tables: must hold rcu read lock while iterating object type list

Francesco Zardi (1):
      rust: block: fix formatting of `kernel::block::mq::request` module

Frank Li (2):
      arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix coexistence of output-low and output-high in GPIO
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin

Gao Xiang (2):
      erofs: fix file-backed mounts over FUSE
      erofs: handle NONHEAD !delta[1] lclusters gracefully

Gaosheng Cui (2):
      drivers: soc: xilinx: add the missing kfree in xlnx_add_cb_for_suspend()
      firmware_loader: Fix possible resource leak in fw_log_firmware_info()

Gautam Menghani (3):
      KVM: PPC: Book3S HV: Stop using vc->dpdes for nested KVM guests
      KVM: PPC: Book3S HV: Avoid returning to nested hypervisor on pending doorbells
      powerpc/pseries: Fix KVM guest detection for disabling hardlockup detector

Gautham R. Shenoy (1):
      amd-pstate: Set min_perf to nominal_perf for active mode performance gov

Geert Uytterhoeven (2):
      ASoC: fsl-asoc-card: Add missing handling of {hp,mic}-dt-gpios
      zram: ZRAM_DEF_COMP should depend on ZRAM

Gerd Bayer (1):
      s390/facilities: Fix warning about shadow of global variable

Greg Kroah-Hartman (2):
      Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
      Linux 6.12.2

Gregory Price (1):
      tpm: fix signed/unsigned bug when checking event logs

Guenter Roeck (1):
      net: microchip: vcap: Add typegroup table terminators in kunit tests

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Gustavo A. R. Silva (2):
      clk: clk-loongson2: Fix memory corruption bug in struct loongson2_clk_provider
      clk: clk-loongson2: Fix potential buffer overflow in flexible-array member access

Halil Pasic (1):
      s390/virtio_ccw: Fix dma_parm pointer not set up

Hangbin Liu (3):
      netdevsim: copy addresses for both in and out paths
      wireguard: selftests: load nf_conntrack if not present
      net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged

Hans Verkuil (1):
      media: v4l2-core: v4l2-dv-timings: check cvt/gtf result

Hao Ge (2):
      isofs: avoid memory leak in iocharset
      perf bpf-filter: Return -ENOMEM directly when pfi allocation fails

Hari Bathini (1):
      powerpc/fadump: allocate memory for additional parameters early

Hariprasad Kelam (5):
      octeontx2-af: RPM: Fix mismatch in lmac type
      octeontx2-af: RPM: Fix low network performance
      octeontx2-af: RPM: fix stale RSFEC counters
      octeontx2-af: RPM: fix stale FCFEC counters
      octeontx2-af: Quiesce traffic before NIX block reset

Harshit Mogalapalli (1):
      dax: delete a stale directory pmem

Heiko Carstens (1):
      s390/pageattr: Implement missing kernel_page_present()

Heiko Stuebner (1):
      arm64: dts: rockchip: Remove 'enable-active-low' from two boards

Henrique Carvalho (1):
      smb: client: disable directory caching when dir_cache_timeout is zero

Herve Codina (1):
      soc: fsl: cpm1: qmc: Set the ret error code on platform_get_irq() failure

Hongzhen Luo (1):
      erofs: fix blksize < PAGE_SIZE for file-backed mounts

Hou Tao (1):
      virtiofs: use pages instead of pointer for kernel direct IO

Howard Chu (1):
      perf trace: Fix tracing itself, creating feedback loops

Hsin-Te Yuan (2):
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4

Huacai Chen (2):
      LoongArch: Explicitly specify code model in Makefile
      sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Huan Yang (2):
      udmabuf: change folios array from kmalloc to kvmalloc
      udmabuf: fix vmap_udmabuf error page set

Hubert Wiśniewski (1):
      usb: musb: Fix hardware lockup on first Rx endpoint request

Ian Rogers (3):
      perf stat: Fix affinity memory leaks on error path
      perf disasm: Fix capstone memory leak
      perf probe: Fix libdw memory leak

Igor Prusov (1):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc

Igor Pylypiv (1):
      i2c: dev: Fix memory leak when underlying adapter does not support I2C

Ilpo Järvinen (1):
      PCI: cpqphp: Fix PCIBIOS_* return value confusion

Ilya Zverev (1):
      ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00

Iulia Tanasescu (3):
      Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
      Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending
      Bluetooth: ISO: Send BIG Create Sync via hci_sync

Jacob Keller (1):
      ice: consistently use q_idx in ice_vc_cfg_qs_msg()

Jaegeuk Kim (1):
      Revert "f2fs: remove unreachable lazytime mount option parsing"

Jakub Kicinski (3):
      eth: fbnic: don't disable the PCI device twice
      netlink: fix false positive warning in extack during dumps
      net_sched: sch_fq: don't follow the fast path if Tx is behind now

James Chapman (1):
      net/l2tp: fix warning in l2tp_exit_net found by syzbot

James Clark (1):
      perf cs-etm: Don't flush when packet_queue fills up

Jan Hendrik Farr (1):
      Compiler Attributes: disable __counted_by for clang < 19.1.3

Jan Kara (1):
      ext4: avoid remount errors with 'abort' mount option

Jann Horn (2):
      fsnotify: Fix ordering of iput() and watched_objects decrement
      comedi: Flush partial mappings in error case

Jared McArthur (1):
      arm64: dts: ti: k3-j7200: Fix register map for main domain pmx

Jason Gerecke (1):
      HID: wacom: Interpret tilt data from Intuos Pro BT as signed values

Javier Carrasco (9):
      clocksource/drivers/timer-ti-dm: Fix child node refcount handling
      Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()
      leds: max5970: Fix unreleased fwnode_handle in probe function
      wifi: brcmfmac: release 'root' node in all execution paths
      platform/chrome: cros_ec_typec: fix missing fwnode reference decrement
      mtd: ubi: fix unreleased fwnode_handle in find_volume_fwnode()
      soc: fsl: rcpm: fix missing of_node_put() in copy_ippdexpcr1_setting()
      staging: vchiq_arm: Fix missing refcount decrement in error path for fw_node
      counter: stm32-timer-cnt: fix device_node handling in probe_encoder()

Jean-Michel Hautbois (1):
      m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x

Jean-Philippe Romain (1):
      perf list: Fix topic and pmu_name argument order

Jeff Layton (1):
      nfsd: drop inode parameter from nfsd4_change_attribute()

Jeongjun Park (4):
      wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      usb: using mutex lock and supporting O_NONBLOCK flag in iowarrior_read()
      ext4: supress data-race warnings in ext4_free_inodes_{count,set}()
      netfilter: ipset: add missing range check in bitmap_ip_uadt

Jerome Brunet (1):
      hwmon: (pmbus/core) clear faults after setting smbalert mask

Jesse Taube (2):
      RISC-V: Scalar unaligned access emulated on hotplug CPUs
      RISC-V: Check scalar unaligned access on all CPUs

Jiasheng Jiang (2):
      counter: stm32-timer-cnt: Add check for clk_enable()
      counter: ti-ecap-capture: Add check for clk_enable()

Jiawen Wu (2):
      net: txgbe: remove GPIO interrupt controller
      net: txgbe: fix null pointer to pcs

Jiayuan Chen (1):
      bpf: fix recursive lock when verdict program return SK_PASS

Jie Zhan (1):
      cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged

Jing Zhang (1):
      KVM: arm64: vgic-its: Add a data length check in vgic_its_save_*

Jinjie Ruan (17):
      spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
      soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/dcss: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/imx/ipuv3: Use IRQF_NO_AUTOEN flag in request_irq()
      drm/msm/adreno: Use IRQF_NO_AUTOEN flag in request_irq()
      mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
      cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()
      cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
      misc: apds990x: Fix missing pm_runtime_disable()
      apparmor: test: Fix memory leak for aa_unpack_strdup()
      cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()
      rtc: st-lpc: Use IRQF_NO_AUTOEN flag in request_irq()

Jiri Olsa (2):
      bpf: Allow return values 0 and 1 for kprobe session
      bpf: Force uprobe bpf program to always return 0

Joe Damato (1):
      netdev-genl: Hold rcu_read_lock in napi_get

Joe Hattori (2):
      remoteproc: qcom: pas: Remove subdevs on the error path of adsp_probe()
      remoteproc: qcom: adsp: Remove subdevs on the error path of adsp_probe()

Johan Hovold (1):
      pinctrl: qcom: spmi: fix debugfs drive strength

John Garry (3):
      block/fs: Pass an iocb to generic_atomic_write_valid()
      fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
      block: Don't allow an atomic write be truncated in blkdev_write_iter()

Jonas Gorski (1):
      mips: asm: fix warning when disabling MIPS_FP_SUPPORT

Jonathan Gray (1):
      drm: use ATOMIC64_INIT() for atomic64_t

Jonathan Marek (3):
      efi/libstub: fix efi_parse_options() ignoring the default command line
      clk: qcom: videocc-sm8550: depend on either gcc-sm8550 or gcc-sm8650
      rpmsg: glink: use only lower 16-bits of param2 for CMD_OPEN name length

Jose Ignacio Tornos Martinez (2):
      wifi: ath12k: fix warning when unbinding
      wifi: ath12k: fix crash when unbinding

Josh Poimboeuf (1):
      parisc/ftrace: Fix function graph tracing disablement

José Expósito (1):
      drm/vkms: Drop unnecessary call to drm_crtc_cleanup()

Junxian Huang (3):
      RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
      RDMA/hns: Fix out-of-order issue of requester when setting FENCE
      RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

Justin Lai (3):
      rtase: Refactor the rtase_check_mac_version_valid() function
      rtase: Correct the speed for RTL907XD-V1
      rtase: Corrects error handling of the rtase_check_mac_version_valid()

Kailang Yang (4):
      ALSA: hda/realtek: Update ALC256 depop procedure
      ALSA: hda/realtek: Update ALC225 depop procedure
      ALSA: hda/realtek: Enable speaker pins for Medion E15443 platform
      ALSA: hda/realtek: Set PCBeep to default value for ALC274

Kajol Jain (1):
      KVM: PPC: Book3S HV: Fix kmv -> kvm typo

Kalesh AP (1):
      RDMA/bnxt_re: Correct the sequence of device suspend

Kalle Valo (1):
      Revert "wifi: iwlegacy: do not skip frames with bad FCS"

Kan Liang (1):
      perf jevents: Don't stop at the first matched pmu when searching a events table

Karol Wachowski (1):
      accel/ivpu: Prevent recovery invocation during probe and resume

Karthikeyan Periyasamy (1):
      wifi: cfg80211: check radio iface combination for multi radio per wiphy

Kartik Rajput (1):
      serial: amba-pl011: Fix RX stall when DMA is used

Kashyap Desai (1):
      RDMA/bnxt_re: Check cqe flags to know imm_data vs inv_irkey

Keita Morisaki (1):
      devres: Fix page faults when tracing devres from unloaded modules

Kiran K (2):
      Bluetooth: btintel_pcie: Add handshake between driver and firmware
      Bluetooth: btintel: Do no pass vendor events to stack

Kirill A. Shutemov (3):
      x86/tdx: Introduce wrappers to read and write TD metadata
      x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
      x86/tdx: Dynamically disable SEPT violations from causing #VEs

Konrad Dybcio (2):
      arm64: dts: qcom: x1e80100: Update C4/C5 residency/exit numbers
      arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

Konstantin Komarov (1):
      fs/ntfs3: Equivalent transition from page to folio

Kristina Martsenko (1):
      arm64: probes: Disable kprobes/uprobes on MOPS instructions

Krzysztof Kozlowski (1):
      dt-bindings: pinctrl: samsung: Fix interrupt constraint for variants with fallbacks

Kuangyi Chiang (4):
      xhci: Fix control transfer error on Etron xHCI host
      xhci: Combine two if statements for Etron xHCI host
      xhci: Don't perform Soft Retry for Etron xHCI host
      xhci: Don't issue Reset Device command to Etron xHCI host

Kumar Kartikeya Dwivedi (2):
      bpf: Tighten tail call checks for lingering locks, RCU, preempt_disable
      bpf: Mark raw_tp arguments with PTR_MAYBE_NULL

Kuniyuki Iwashima (1):
      tcp: Fix use-after-free of nreq in reqsk_timer_handler().

Kunkun Jiang (2):
      KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE
      KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device

Lad Prabhakar (2):
      arm64: dts: renesas: hihope: Drop #sound-dai-cells
      pinctrl: renesas: Select PINCTRL_RZG2L for RZ/V2H(P) SoC

Leo Yan (1):
      perf probe: Correct demangled symbols in C++ program

Leon Hwang (1):
      bpf, bpftool: Fix incorrect disasm pc

Levi Yun (2):
      trace/trace_event_perf: remove duplicate samples on the first tracepoint event
      perf stat: Close cork_fd when create_perf_stat_counter() failed

Li Huafei (6):
      crypto: inside-secure - Fix the return value of safexcel_xcbcmac_cra_init()
      media: atomisp: Add check for rgby_data memory allocation failure
      drm/nouveau/gr/gf100: Fix missing unlock in gf100_gr_chan_new()
      drm/amdgpu: Fix the memory allocation issue in amdgpu_discovery_get_nps_info()
      perf disasm: Use disasm_line__free() to properly free disasm_line
      perf disasm: Fix not cleaning up disasm_line in symbol__disassemble_raw()

Li Lingfeng (1):
      nfs: ignore SB_RDONLY when mounting nfs

Li Wang (1):
      loop: fix type of block size

Lifeng Zheng (1):
      ACPI: CPPC: Fix _CPC register setting issue

Lijo Lazar (2):
      drm/amdgpu: Fix JPEG v4.0.3 register write
      drm/amdgpu: Fix map/unmap queue logic

Lingbo Kong (1):
      wifi: cfg80211: Remove the Medium Synchronization Delay validity check

Linus Walleij (2):
      drm/panel: nt35510: Make new commands optional
      wifi: cw1200: Fix potential NULL dereference

Liu Jian (3):
      RDMA/rxe: Set queue pair cur_qp_state when being queried
      sunrpc: clear XPRT_SOCK_UPD_TIMEOUT when reset transport
      sunrpc: fix one UAF issue caused by sunrpc kernel tcp socket

Liu Shixin (1):
      zram: fix NULL pointer in comp_algorithm_show()

Long Li (2):
      ext4: fix race in buffer_head read fault injection
      f2fs: fix race in concurrent f2fs_stop_gc_thread

LongPing Wei (1):
      f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block

Lorenzo Bianconi (8):
      clk: en7523: remove REG_PCIE*_{MEM,MEM_MASK} configuration
      clk: en7523: move clock_register in hw_init callback
      clk: en7523: introduce chip_scu regmap
      clk: en7523: fix estimation of fixed rate for EN7581
      phy: airoha: Fix REG_CSR_2L_PLL_CMN_RESERVE0 config in airoha_pcie_phy_init_clk_out()
      phy: airoha: Fix REG_PCIE_PMA_TX_RESET config in airoha_pcie_phy_init_csr_2l()
      phy: airoha: Fix REG_CSR_2L_JCPLL_SDM_HREN config in airoha_pcie_phy_init_ssc_jcpll()
      phy: airoha: Fix REG_CSR_2L_RX{0,1}_REV0 definitions

Luca Weiss (1):
      arm64: dts: qcom: sm6350: Fix GPU frequencies missing on some speedbins

Lucas Stach (1):
      drm/etnaviv: hold GPU lock across perfmon sampling

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Use kref to track lifetime of iso_conn
      Bluetooth: MGMT: Fix slab-use-after-free Read in set_powered_sync
      Bluetooth: MGMT: Fix possible deadlocks

Lukas Bulwahn (1):
      clk: mediatek: drop two dead config options

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Lukasz Luba (1):
      drm/msm/gpu: Check the status of registration to PM QoS

Luo Qiu (1):
      firmware: arm_scpi: Check the DVFS OPP count returned by the firmware

Ma Wupeng (1):
      ipc: fix memleak if msg_init_ns failed in create_ipc_ns

Macpaul Lin (5):
      arm64: dts: mediatek: mt8395-genio-1200-evk: Fix dtbs_check error for phy
      arm64: dts: mt8195: Fix dtbs_check error for mutex node
      arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
      arm64: dts: mediatek: mt6358: fix dtbs_check error
      ASoC: dt-bindings: mt6359: Update generic node name and dmic-mode

Manivannan Sadhasivam (3):
      PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported
      PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
      PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()

Marc Zyngier (2):
      arm64: Expose ID_AA64ISAR1_EL1.XS to sanitised feature consumers
      KVM: arm64: vgic-v3: Sanitise guest writes to GICR_INVLPIR

Marco Elver (2):
      kcsan, seqlock: Support seqcount_latch_t
      kcsan, seqlock: Fix incorrect assumption in read_seqbegin()

Marcus Folkesson (1):
      mfd: da9052-spi: Change read-mask to write-mask

Marek Vasut (1):
      wifi: wilc1000: Set MAC after operation mode

Mario Limonciello (1):
      cpufreq/amd-pstate: Don't update CPPC request in amd_pstate_cpu_boost_update()

Mark Brown (2):
      kselftest/arm64: Fix encoding for SVE B16B16 test
      clocksource/drivers:sp804: Make user selectable

Martin Kaistra (1):
      wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled

Masahiro Yamada (5):
      arm64: fix .data.rel.ro size assertion when CONFIG_LTO_CLANG
      s390/syscalls: Avoid creation of arch/arch/ directory
      Rename .data.unlikely to .data..unlikely
      Rename .data.once to .data..once to fix resetting WARN*_ONCE
      modpost: remove incorrect code in do_eisa_entry()

Matt Coster (1):
      drm/imagination: Use pvr_vm_context_get()

Matt Fleming (1):
      kbuild: deb-pkg: Don't fail if modules.order is missing

Matthew Rosato (1):
      iommu/s390: Implement blocking domain

Matthias Schiffer (1):
      drm: fsl-dcu: enable PIXCLK on LS1021A

Maurice Lambert (1):
      netlink: typographical error in nlmsg_type constants definition

Mauro Carvalho Chehab (2):
      MAINTAINERS: update location of media main tree
      docs: media: update location of the media patches

Maxime Chevallier (2):
      net: stmmac: dwmac-socfpga: Set RX watchdog interrupt as broken
      rtc: ab-eoz9: don't fail temperature reads on undervoltage notification

Maxime Ripard (1):
      drm/vc4: Introduce generation number enum

Maíra Canal (2):
      drm/v3d: Address race-condition in MMU flush
      drm/v3d: Flush the MMU before we supply more memory to the binner

Meetakshi Setiya (1):
      cifs: support mounting with alternate password to allow password rotation

Michael Chan (2):
      bnxt_en: Refactor bnxt_ptp_init()
      bnxt_en: Unregister PTP during PCI shutdown and suspend

Michael Ellerman (2):
      powerpc/pseries: Fix dtl_access_lock to be a rw_semaphore
      selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels

Michael Grzeschik (1):
      usb: gadget: uvc: wake pump everytime we update the free list

Michael J. Ruhl (1):
      platform/x86/intel/pmt: allow user offset for PMT callbacks

Michael Petlan (1):
      perf trace: Keep exited threads for summary

Michal Luczaj (2):
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input

Michal Pecio (3):
      usb: xhci: Limit Stop Endpoint retries
      usb: xhci: Fix TD invalidation under pending Set TR Dequeue
      usb: xhci: Avoid queuing redundant Stop Endpoint commands

Michal Schmidt (1):
      rcu/srcutiny: don't return before reenabling preemption

Michal Simek (2):
      microblaze: Export xmb_manager functions
      dt-bindings: serial: rs485: Fix rs485-rts-delay property

Michal Suchanek (1):
      powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static

Michal Vrastil (1):
      Revert "usb: gadget: composite: fix OS descriptors w_value logic"

Miguel Ojeda (4):
      time: Partially revert cleanup on msecs_to_jiffies() documentation
      time: Fix references to _msecs_to_jiffies() handling of values
      drm/panic: Select ZLIB_DEFLATE for DRM_PANIC_SCREEN_QR_CODE
      rust: rbtree: fix `SAFETY` comments that should be `# Safety` sections

Mike Snitzer (1):
      nfs_common: must not hold RCU while calling nfsd_file_put_local

Mikulas Patocka (1):
      blk-settings: round down io_opt to physical_block_size

Min-Hua Chen (1):
      regulator: qcom-smd: make smd_vreg_rpm static

Ming Lei (6):
      ublk: fix ublk_ch_mmap() for 64K page size
      ublk: fix error code for unsupported command
      blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
      block: model freeze & enter queue as lock for supporting lockdep
      block: always verify unfreeze lock on the owner task
      block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()

Mingwei Zheng (1):
      net: rfkill: gpio: Add check for clk_enable()

Miquel Raynal (1):
      mtd: rawnand: atmel: Fix possible memory leak

Mirsad Todorovac (2):
      fs/proc/kcore.c: fix coccinelle reported ERROR instances
      net/9p/usbg: fix handling of the failed kzalloc() memory allocation

Muchun Song (3):
      block: fix missing dispatching request when queue is started or unquiesced
      block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding
      block: fix ordering between checking BLK_MQ_S_STOPPED request adding

Murad Masimov (1):
      hwmon: (tps23861) Fix reporting of negative temperatures

Namhyung Kim (1):
      perf/arm-cmn: Ensure port and device id bits are set properly

Namjae Jeon (1):
      exfat: fix uninit-value in __exfat_get_dentry_set

Nathan Morrisson (1):
      arm64: dts: ti: k3-am62x-phyboard-lyra: Drop unnecessary McASP AFIFOs

NeilBrown (1):
      nfs/localio: must clear res.replen in nfs_local_read_done

Nicolas Bouchinet (1):
      tty: ldsic: fix tty_ldisc_autoload sysctl's proc_handler

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Staticize cmdqv_debugfs_dir
      iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift

Niklas Schnelle (2):
      watchdog: Add HAS_IOPORT dependency for SBC8360 and SBC7240
      s390/pci: Fix potential double remove of hotplug slot

Nilay Shroff (1):
      nvme-fabrics: fix kernel crash while shutting down controller

Nirmoy Das (1):
      drm/xe/ufence: Wake up waiters after setting ufence->signalled

Nobuhiro Iwamatsu (1):
      rtc: abx80x: Fix WDT bit position of the status register

Nuno Sa (2):
      dt-bindings: clock: axi-clkgen: include AXI clk
      clk: clk-axi-clkgen: make sure to enable the AXI bus clock

Nícolas F. R. A. Prado (1):
      ASoC: mediatek: Check num_codecs is not zero to avoid panic during probe

Oleksij Rempel (3):
      net: usb: lan78xx: Fix double free issue with interrupt buffer allocation
      net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
      net: usb: lan78xx: Fix refcounting and autosuspend on invalid WoL configuration

Oliver Neukum (2):
      usb: yurex: make waiting on yurex_write interruptible
      USB: chaoskey: fail open after removal

Oliver Upton (1):
      KVM: arm64: Don't retire aborted MMIO instruction

Omid Ehtemam-Haghighi (1):
      ipv6: Fix soft lockups in fib6_select_path under high next hop churn

Orange Kao (1):
      EDAC/igen6: Avoid segmentation fault on module unload

Pablo Sun (1):
      arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power domain

Pali Rohár (2):
      cifs: Fix parsing native symlinks relative to the export
      cifs: Fix parsing reparse point with native symlink in SMB1 non-UNICODE session

Paolo Abeni (4):
      ipv6: release nexthop on device removal
      selftests: net: really check for bg process completion
      ip6mr: fix tables suspicious RCU usage
      ipmr: fix tables suspicious RCU usage

Paolo Bonzini (2):
      rust: macros: fix documentation of the paste! macro
      KVM: x86: switch hugepage recovery thread to vhost_task

Patrisious Haddad (1):
      RDMA/mlx5: Move events notifier registration to be after device registration

Patryk Wlazlyn (1):
      tools/power turbostat: Fix child's argument forwarding

Paul Aurich (5):
      smb: cached directories can be more than root file handle
      smb: Don't leak cfid when reconnect races with open_cached_dir
      smb: prevent use-after-free due to open_cached_dir error paths
      smb: During unmount, ensure all cached dir instances drop their dentry
      smb: Initialize cfid->tcon before performing network ops

Paulo Alcantara (3):
      smb: client: fix NULL ptr deref in crypto_aead_setkey()
      smb: client: fix use-after-free of signing key
      smb: client: handle max length for SMB symlinks

Pavan Chebbi (1):
      tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets

Pavel Begunkov (2):
      io_uring: fix corner case forgetting to vunmap
      io_uring: check for overflows in io_pin_pages

Pei Xiao (2):
      hwmon: (nct6775-core) Fix overflows seen when writing limit attributes
      wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()

Peng Fan (3):
      clk: imx: lpcg-scu: SW workaround for errata (e10858)
      clk: imx: fracn-gppll: correct PLL initialization flow
      clk: imx: fracn-gppll: fix pll power up

Peter Große (1):
      i40e: Fix handling changed priv flags

Pin-yen Lin (3):
      arm64: dts: mt8183: Add port node to dpi node
      drm/bridge: anx7625: Drop EDID cache on bridge power off
      drm/bridge: it6505: Drop EDID cache on bridge power off

Po-Hao Huang (1):
      wifi: rtw89: Fix TX fail with A2DP after scanning

Priyanka Singh (1):
      EDAC/fsl_ddr: Fix bad bit shift operations

Qi Han (1):
      f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks

Qingfang Deng (1):
      jffs2: fix use of uninitialized variable

Qiu-ji Chen (3):
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
      media: wl128x: Fix atomicity violation in fmc_send_cmd()

Qiuxu Zhuo (2):
      EDAC/skx_common: Differentiate memory error sources
      EDAC/{skx_common,i10nm}: Fix incorrect far-memory error source indicator

Rafael J. Wysocki (7):
      thermal: core: Initialize thermal zones before registering them
      thermal: core: Rearrange PM notification code
      thermal: core: Represent suspend-related thermal zone flags as bits
      thermal: core: Mark thermal zones as initializing to start with
      thermal: core: Fix race between zone registration and system suspend
      thermal: testing: Use DEFINE_FREE() and __free() to simplify code
      thermal: testing: Initialize some variables annoteded with _free()

Raghavendra Rao Ananta (2):
      KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
      KVM: arm64: Get rid of userspace_irqchip_in_use

Ralph Boehme (1):
      fs/smb/client: implement chmod() for SMB3 POSIX Extensions

Rameshkumar Sundaram (1):
      wifi: ath12k: fix use-after-free in ath12k_dp_cc_cleanup()

Ramya Gnanasekar (1):
      wifi: ath12k: Skip Rx TID cleanup for self peer

Randy Dunlap (2):
      kernel-doc: allow object-like macros in ReST output
      fs_parser: update mount_api doc to match function signature

Raviteja Laggyshetty (1):
      interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency

Raymond Hackley (1):
      leds: ktd2692: Set missing timing properties

Reinette Chatre (3):
      selftests/resctrl: Print accurate buffer size as part of MBM results
      selftests/resctrl: Fix memory overflow due to unhandled wraparound
      selftests/resctrl: Protect against array overrun during iMC config parsing

Ritesh Harjani (IBM) (3):
      powerpc/fadump: Refactor and prepare fadump_cma_init for late init
      powerpc/fadump: Move fadump_cma_init to setup_arch() after initmem_init()
      powerpc/mm/fault: Fix kfence page fault reporting

Roman Li (1):
      drm/amd/display: Increase idle worker HPD detection time

Rosen Penev (1):
      net: mdio-ipq4019: add missing error check

Russell King (Oracle) (1):
      irqchip/irq-mvebu-sei: Move misplaced select() callback to SEI CP domain

Ryan Walklin (1):
      drm: panel: nv3052c: correct spi_device_id for RG35XX panel

Sabyrzhan Tasbolatov (1):
      kasan: move checks to do_strncpy_from_user

Sai Kumar Cholleti (1):
      gpio: exar: set value when external pull-up or pull-down is present

Sakari Ailus (1):
      media: ipu6: Fix DMA and physical address debugging messages for 32-bit

Samuel Holland (1):
      irqchip/riscv-aplic: Prevent crash when MSI domain is missing

Saravanan Vajravel (1):
      bnxt_en: Reserve rings after PCIe AER recovery if NIC interface is down

Sascha Hauer (1):
      wifi: mwifiex: add missing locking for cfg80211 calls

Sean Anderson (1):
      drm: zynqmp_kms: Unplug DRM device before removal

Sean Christopherson (3):
      KVM: x86/mmu: Skip the "try unsync" path iff the old SPTE was a leaf SPTE
      KVM: x86: Break CONFIG_KVM_X86's direct dependency on KVM_INTEL || KVM_AMD
      Revert "KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata handling out of setup_vmcs_config()"

Sebastian Andrzej Siewior (2):
      locking/rt: Add sparse annotation PREEMPT_RT's sleeping locks.
      x86/CPU/AMD: Terminate the erratum_1386_microcode array

Selvarasu Ganesan (1):
      usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic

Sergey Senozhatsky (1):
      zram: permit only one post-processing operation at a time

Sergio Paracuellos (2):
      clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
      clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs

Shengjiu Wang (1):
      ASoC: fsl_micfil: fix regmap_write_bits usage

Shravya KN (2):
      bnxt_en: Set backplane link modes correctly for ethtool
      bnxt_en: Fix receive ring space parameters when XDP is active

Shyam Prasad N (1):
      cifs: during remount, make sure passwords are in sync

Si-Wei Liu (1):
      vdpa/mlx5: Fix suboptimal range on iotlb iteration

Sibi Sankar (2):
      arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
      remoteproc: qcom_q6v5_mss: Re-order writes to the IMEM region

Siddharth Vadapalli (1):
      PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds

Sidraya Jayagond (1):
      s390/iucv: MSG_PEEK causes memory leak in iucv_sock_destruct()

Somnath Kotur (1):
      bnxt_en: Fix queue start to update vnic RSS table

Sourabh Jain (1):
      fadump: reserve param area if below boot_mem_top

Srikar Dronamraju (1):
      gpio: sloppy-logic-analyzer remove reference to rcu_momentary_dyntick_idle()

Srinivasan Shanmugam (2):
      drm/amdgpu/gfx9: Add Cleaner Shader Deinitialization in gfx_v9_0 Module
      drm/amdkfd: Use dynamic allocation for CU occupancy array in 'kfd_get_cu_occupancy()'

Stafford Horne (1):
      openrisc: Implement fixmap to fix earlycon

Stanislaw Gruszka (4):
      spi: Fix acpi deferred irq probe
      media: intel/ipu6: do not handle interrupts when device is disabled
      usb: misc: ljca: set small runtime autosuspend delay
      usb: misc: ljca: move usb_autopm_put_interface() after wait for response

Steffen Dirkwinkel (1):
      drm: xlnx: zynqmp_disp: layer may be null while releasing

Stephen Boyd (1):
      clk: Allow kunit tests to run without OF_OVERLAY enabled

Steve French (1):
      smb3: request handle caching when caching directories

Steven 'Steve' Kendall (1):
      drm/radeon: Fix spurious unplug event on radeon HDMI

Steven Price (1):
      drm/panfrost: Remove unused id_mask from struct panfrost_model

Suraj Kandpal (1):
      drm/xe/hdcp: Fix gsc structure check in fw check status

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Use nor->addr_nbytes in octal DTR mode in RD_ANY_REG_OP

Takashi Iwai (9):
      ALSA: usx2y: Use snd_card_free_when_closed() at disconnection
      ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      ALSA: 6fire: Release resources at card release
      ALSA: usb-audio: Fix out of bounds reads when finding clock sources
      ALSA: rawmidi: Fix kvfree() call in spinlock
      ALSA: ump: Fix evaluation of MIDI 1.0 FB info
      ALSA: pcm: Add sanity NULL check for the default mmap fault handler
      ALSA: hda/realtek: Apply quirk for Medion E15433

Tamir Duberstein (1):
      checkpatch: always parse orig_commit in fixes tag

Tao Chen (1):
      libbpf: Fix expected_attach_type set handling in program load callback

Tejun Heo (1):
      sched_ext: scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context

Thadeu Lima de Souza Cascardo (1):
      hfsplus: don't query the device logical block size multiple times

Theodore Ts'o (1):
      ext4: fix FS_IOC_GETFSMAP handling

Thinh Nguyen (3):
      usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
      usb: dwc3: gadget: Fix checking for number of TRBs left
      usb: dwc3: gadget: Fix looping of queued SG entries

Thomas Falcon (1):
      perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}

Thomas Gleixner (2):
      timers: Add missing READ_ONCE() in __run_timer_base()
      sched/ext: Remove sched_fork() hack

Thomas Richter (1):
      s390/cpum_sf: Fix and protect memory allocation of SDBs with mutex

Thomas Weißschuh (1):
      tools/nolibc: s390: include std.h

Tiezhu Yang (2):
      LoongArch: Fix build failure with GCC 15 (-std=gnu23)
      LoongArch: BPF: Sign-extend return values

Tiwei Bie (7):
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Fix potential integer overflow during physmem setup
      um: Fix the return value of elf_core_copy_task_fpregs
      um: ubd: Initialize ubd's disk pointer in ubd_add
      um: Always dump trace for specified task in show_stack

Todd Kjos (1):
      PCI: Fix reset_method_store() memory leak

Tomas Glozar (1):
      rtla/timerlat: Do not set params->user_workload with -U

Tomas Paukrt (1):
      crypto: mxs-dcp - Fix AES-CBC with hardware-bound keys

Tomasz Maciej Nowak (1):
      arm64: tegra: p2180: Add mandatory compatible for WiFi node

Tomi Valkeinen (3):
      drm/omap: Fix possible NULL dereference
      drm/omap: Fix locking in omap_gem_new_dmabuf()
      drm/bridge: tc358767: Fix link properties discovery

Tony Ambardar (1):
      libbpf: Fix output .symtab byte-order during linking

Trond Myklebust (2):
      NFSv4.0: Fix a use-after-free problem in the asynchronous open()
      Revert "nfs: don't reuse partially completed requests in nfs_lock_and_join_requests"

Tvrtko Ursulin (1):
      drm/v3d: Appease lockdep while updating GPU stats

Uladzislau Rezki (Sony) (2):
      rcu/kvfree: Fix data-race in __mod_timer / kvfree_call_rcu
      rcuscale: Do a proper cleanup if kfree_scale_init() fails

Uros Bizjak (3):
      cleanup: Remove address space of returned pointer
      locking/atomic/x86: Use ALT_OUTPUT_SP() for __alternative_atomic64()
      locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()

Usama Arif (1):
      of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify

Uwe Kleine-König (1):
      pwm: Assume a disabled PWM to emit a constant inactive output

Vasant Hegde (1):
      iommu/amd/pgtbl_v2: Take protection domain lock before invalidating TLB

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry

Veronika Molnarova (2):
      perf test attr: Add back missing topdown events
      perf dso: Fix symtab_type for kmod compression

Vijendar Mukunda (2):
      ASoC: amd: acp: fix for inconsistent indenting
      ASoC: amd: acp: fix for cpu dai index logic

Viktor Malik (1):
      selftests/bpf: skip the timer_lockup test for single-CPU nodes

Vineeth Vijayan (1):
      s390/cio: Do not unregister the subchannel based on DNV

Vitalii Mordan (2):
      marvell: pxa168_eth: fix call balance of pep->clk handling routines
      usb: ehci-spear: fix call balance of sehci clk handling routines

Vitaly Kuznetsov (1):
      HID: hyperv: streamline driver probe to avoid devres issues

Wang Hai (1):
      crypto: qat - Fix missing destroy_workqueue in adf_init_aer()

Waqar Hameed (1):
      ubifs: authentication: Fix use-after-free in ubifs_tnc_end_commit

Weili Qian (1):
      crypto: hisilicon/qm - disable same error report before resetting

Will Deacon (1):
      arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled

Wolfram Sang (2):
      ARM: dts: renesas: genmai: Fix partition size for QSPI NOR Flash
      rtc: rzn1: fix BCD to rtc_time conversion errors

Xiaolei Wang (1):
      drm/etnaviv: Request pages from DMA32 zone on addressing_limited

Xiuhong Wang (1):
      f2fs: fix fiemap failure issue when page size is 16KB

Xu Kuohai (3):
      bpf, arm64: Remove garbage frame for struct_ops trampoline
      bpf: Use function pointers count as struct_ops links count
      bpf: Add kernel symbol for struct_ops trampoline

Yang Erkun (3):
      brd: defer automatic disk creation until module initialization succeeds
      nfsd: release svc_expkey/svc_export with rcu_work
      SUNRPC: make sure cache entry active before cache_show

Yang Wang (1):
      drm/amdgpu: fix ACA bank count boundary check error

Yang Yingliang (3):
      clk: imx: imx8-acm: Fix return value check in clk_imx_acm_attach_pm_domains()
      mailbox: mtk-cmdq: fix wrong use of sizeof in cmdq_get_clocks()
      iio: backend: fix wrong pointer passed to IS_ERR()

Yao Zi (1):
      platform/x86: panasonic-laptop: Return errno correctly in show callback

Ye Bin (3):
      scsi: bfa: Fix use-after-free in bfad_im_module_exit()
      f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
      svcrdma: fix miss destroy percpu_counter in svc_rdma_proc_init()

Yi Yang (1):
      crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY

Yicong Yang (1):
      perf build: Add missing cflags when building with custom libtraceevent

Yihang Li (1):
      scsi: hisi_sas: Enable all PHYs that are not disabled by user during controller reset

Yishai Hadas (2):
      vfio/mlx5: Fix an unwind issue in mlx5vf_add_migration_pages()
      vfio/mlx5: Fix unwind flows in mlx5vf_pci_save/resume_device_data()

Yong-Xuan Wang (1):
      RISC-V: KVM: Fix APLIC in_clrip and clripnum write emulation

Yongliang Gao (1):
      rtc: check if __rtc_read_time was successful in rtc_timer_do_work()

Yongpeng Yang (1):
      f2fs: check curseg->inited before write_sum_page in change_curseg

Yu Kuai (2):
      block: fix uaf for flush rq while iterating tags
      block, bfq: fix bfqq uaf in bfq_limit_depth()

Yuan Can (5):
      firmware: google: Unregister driver_info on failure
      wifi: wfx: Fix error handling in wfx_core_init()
      drm/amdkfd: Fix wrong usage of INIT_WORK()
      cpufreq: loongson2: Unregister platform_driver on failure
      Input: cs40l50 - fix wrong usage of INIT_WORK()

Yuan Chen (1):
      bpf: Fix the xdp_adjust_tail sample prog issue

Yuezhang Mo (2):
      exfat: fix file being changed by unaligned direct write
      exfat: fix out-of-bounds access of directory entries

Yunseong Kim (1):
      ksmbd: fix use-after-free in SMB request handling

Yutaro Ohno (1):
      rust: kernel: fix THIS_MODULE header path in ThisModule doc comment

Yuyu Li (1):
      RDMA/hns: Modify debugfs name

Zach Wade (1):
      Revert "block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()"

Zeng Heng (2):
      scsi: fusion: Remove unused variable 'rc'
      f2fs: Fix not used variable 'index'

Zhang Changzhong (1):
      mfd: rt5033: Fix missing regmap_del_irq_chip()

Zhang Rui (1):
      tools/power turbostat: Fix trailing '\n' parsing

Zhang Xianwei (1):
      brd: decrease the number of allocated pages which discarded

Zhang Zekun (2):
      pmdomain: ti-sci: Add missing of_node_put() for args.np
      powerpc/kexec: Fix return of uninitialized variable

ZhangPeng (1):
      hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio()

Zhen Lei (3):
      scsi: qedf: Fix a possible memory leak in qedf_alloc_and_init_sb()
      scsi: qedi: Fix a possible memory leak in qedi_alloc_and_init_sb()
      fbdev: sh7760fb: Fix a possible memory leak in sh7760fb_alloc_mem()

Zheng Yejian (1):
      x86/unwind/orc: Fix unwind for newly forked tasks

Zhenzhong Duan (2):
      iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
      iommu/vt-d: Fix checks and print in pgtable_walk()

Zhiguo Niu (1):
      f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID

Zhihao Cheng (4):
      ubi: wl: Put source PEB into correct list if trying locking LEB failed
      ubi: fastmap: wl: Schedule fm_work if wear-leveling pool is empty
      ubifs: Correct the total block count by deducting journal reservation
      ubi: fastmap: Fix duplicate slab cache names while attaching

Zhongqiu Han (1):
      PCI: endpoint: epf-mhi: Avoid NULL dereference if DT lacks 'mmio'

Zhu Yanjun (1):
      RDMA/rxe: Fix the qp flush warnings in req

Zichen Xie (3):
      drm/msm/dpu: cast crtc_clk calculation to u64 in _dpu_core_perf_calc_clk()
      clk: sophgo: avoid integer overflow in sg2042_pll_recalc_rate()
      ALSA: core: Fix possible NULL dereference caused by kunit_kzalloc()

Zicheng Qu (3):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in dcn20_program_pipe
      drm/amd/display: Fix null check for pipe_ctx->plane_state in hwss_setup_dpp
      iio: gts: Fix uninitialized symbol 'ret'

Zijian Zhang (9):
      selftests/bpf: Fix msg_verify_data in test_sockmap
      selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
      selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
      selftests/bpf: Fix SENDPAGE data logic in test_sockmap
      selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
      selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
      bpf, sockmap: Several fixes to bpf_msg_push_data
      bpf, sockmap: Several fixes to bpf_msg_pop_data
      bpf, sockmap: Fix sk_msg_reset_curr

Ziwei Xiao (1):
      gve: Flow steering trigger reset only for timeout error

Zizhi Wo (4):
      cachefiles: Fix incorrect length return value in cachefiles_ondemand_fd_write_iter()
      cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
      cachefiles: Fix NULL pointer dereference in object->file
      netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

Zong-Zhe Yang (7):
      wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
      wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
      wifi: rtw89: read bss_conf corresponding to the link
      wifi: rtw89: read link_sta corresponding to the link
      wifi: rtw89: refactor VIF related func ahead for MLO
      wifi: rtw89: refactor STA related func ahead for MLO
      wifi: rtw89: tweak driver architecture for impending MLO support

Zqiang (1):
      rcu/nocb: Fix missed RCU barrier on deoffloading

chao liu (1):
      apparmor: fix 'Do simple duplicate message elimination'

guanjing (1):
      selftests: netfilter: Fix missing return values in conntrack_dump_flush

wenglianfa (3):
      RDMA/hns: Fix an AEQE overflow error caused by untimely update of eq_db_ci
      RDMA/hns: Fix flush cqe error when racing with destroy qp
      RDMA/hns: Fix cpu stuck caused by printings during reset

zhang jiao (1):
      pinctrl: k210: Undef K210_PC_DEFAULT


