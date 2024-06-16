Return-Path: <stable+bounces-52312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8176909D48
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9545FB210A9
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D2188CDF;
	Sun, 16 Jun 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmLFtlf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C476188CCE;
	Sun, 16 Jun 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539449; cv=none; b=YaaheGareoRLcjk2r0JXLx0hVzQnFA8CXfC22kaZ7xs2v3nClLQaTGSxNnmPe2kIinGEtKvwYIb1v37NTH5mEBkV6gzQrsd10P5MQoq2QizZwNjveWtWwt7BTR3ykXoQ3v6MD3wTWFdnLwJ+sZ5erQWqHKGNLRScNU58fKsfL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539449; c=relaxed/simple;
	bh=0JPTXMQ5ehMGv4Im+0CH4oxFXj4pBFkpsji9exnUxN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvQemOa0SMgruZAp7dkVxIlJ6CMeE8s/B29qgDjpU9ekA/Lmgd2S5pC1GbWiom+8ICxc7ayEW/U4Nw1Q0bJmLNVb4teCjwDJxKIhA51HNdX7xxXANvRW0Bz/uiAacKRfmSwlZ2XW1YeXtVV4bfeXNc30eeS8mb7OdR1S4R6zoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mmLFtlf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4185FC2BBFC;
	Sun, 16 Jun 2024 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539449;
	bh=0JPTXMQ5ehMGv4Im+0CH4oxFXj4pBFkpsji9exnUxN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmLFtlf2MYDY4oKlTySGboxHUMyp2WhZe3OgjRquIpae708SafBRzJG196smRDXWL
	 +wDmIuTQHEkhBwuLBabLsy1OoxbcFIuCcq81bay44L0FHETdenGqwlTBc6J6hFiUlS
	 jwHEQ1Hj2uypid17RWoHGLVqNIn1/humEBAIT5Ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.219
Date: Sun, 16 Jun 2024 14:03:59 +0200
Message-ID: <2024061659-blatancy-surfboard-4adf@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061659-overripe-ice-9bd3@gregkh>
References: <2024061659-overripe-ice-9bd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index 41a62fd2ae1f..c1fa379f5f3e 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 198aadafd3e7..8d650b4e2ce6 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -4,11 +4,11 @@ FPGA Bridge
 API to implement a new FPGA bridge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-* struct fpga_bridge — The FPGA Bridge structure
-* struct fpga_bridge_ops — Low level Bridge driver ops
-* devm_fpga_bridge_create() — Allocate and init a bridge struct
-* fpga_bridge_register() — Register a bridge
-* fpga_bridge_unregister() — Unregister a bridge
+* struct fpga_bridge - The FPGA Bridge structure
+* struct fpga_bridge_ops - Low level Bridge driver ops
+* devm_fpga_bridge_create() - Allocate and init a bridge struct
+* fpga_bridge_register() - Register a bridge
+* fpga_bridge_unregister() - Unregister a bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 917ee22db429..4d926b452cb3 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -101,12 +101,12 @@ in state.
 API for implementing a new FPGA Manager driver
 ----------------------------------------------
 
-* ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
-* struct fpga_manager —  the FPGA manager struct
-* struct fpga_manager_ops —  Low level FPGA manager driver ops
-* devm_fpga_mgr_create() —  Allocate and init a manager struct
-* fpga_mgr_register() —  Register an FPGA manager
-* fpga_mgr_unregister() —  Unregister an FPGA manager
+* ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
+* struct fpga_manager -  the FPGA manager struct
+* struct fpga_manager_ops -  Low level FPGA manager driver ops
+* devm_fpga_mgr_create() -  Allocate and init a manager struct
+* fpga_mgr_register() -  Register an FPGA manager
+* fpga_mgr_unregister() -  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index 002392dab04f..fb4da4240e96 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -84,10 +84,10 @@ will generate that list.  Here's some sample code of what to do next::
 API for programming an FPGA
 ---------------------------
 
-* fpga_region_program_fpga() —  Program an FPGA
-* fpga_image_info() —  Specifies what FPGA image to program
-* fpga_image_info_alloc() —  Allocate an FPGA image info struct
-* fpga_image_info_free() —  Free an FPGA image info struct
+* fpga_region_program_fpga() -  Program an FPGA
+* fpga_image_info() -  Specifies what FPGA image to program
+* fpga_image_info_alloc() -  Allocate an FPGA image info struct
+* fpga_image_info_free() -  Free an FPGA image info struct
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_program_fpga
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 363a8171ab0a..2d03b5fb7657 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -45,19 +45,25 @@ An example of usage can be seen in the probe function of [#f2]_.
 API to add a new FPGA region
 ----------------------------
 
-* struct fpga_region — The FPGA region struct
-* devm_fpga_region_create() — Allocate and init a region struct
-* fpga_region_register() —  Register an FPGA region
-* fpga_region_unregister() —  Unregister an FPGA region
+* struct fpga_region - The FPGA region struct
+* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
+* __fpga_region_register_full() -  Create and register an FPGA region using the
+  fpga_region_info structure to provide the full flexibility of options
+* __fpga_region_register() -  Create and register an FPGA region using standard
+  arguments
+* fpga_region_unregister() -  Unregister an FPGA region
+
+Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
+automatically set the module that registers the FPGA region as the owner.
 
 The FPGA region's probe function will need to get a reference to the FPGA
 Manager it will be using to do the programming.  This usually would happen
 during the region's probe function.
 
-* fpga_mgr_get() — Get a reference to an FPGA manager, raise ref count
-* of_fpga_mgr_get() —  Get a reference to an FPGA manager, raise ref count,
+* fpga_mgr_get() - Get a reference to an FPGA manager, raise ref count
+* of_fpga_mgr_get() -  Get a reference to an FPGA manager, raise ref count,
   given a device node.
-* fpga_mgr_put() — Put an FPGA manager
+* fpga_mgr_put() - Put an FPGA manager
 
 The FPGA region will need to specify which bridges to control while programming
 the FPGA.  The region driver can build a list of bridges during probe time
@@ -66,20 +72,23 @@ the list of bridges to program just before programming
 (:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
 following APIs to handle building or tearing down that list.
 
-* fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
+* fpga_bridge_get_to_list() - Get a ref of an FPGA bridge, add it to a
   list
-* of_fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
+* of_fpga_bridge_get_to_list() - Get a ref of an FPGA bridge, add it to a
   list, given a device node
-* fpga_bridges_put() — Given a list of bridges, put them
+* fpga_bridges_put() - Given a list of bridges, put them
 
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
 
+.. kernel-doc:: include/linux/fpga/fpga-region.h
+   :functions: fpga_region_info
+
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: devm_fpga_region_create
+   :functions: __fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :functions: __fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_unregister
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8c0fbdd8ce6f..de2bacc418fe 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -260,6 +260,14 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
 			 For other files, we can still enable compression via ioctl.
 			 Note that, there is one reserved special extension '*', it
 			 can be set to enable compression for all files.
+compress_chksum		 Support verifying chksum of raw data in compressed cluster.
+compress_mode=%s	 Control file compression mode. This supports "fs" and "user"
+			 modes. In "fs" mode (default), f2fs does automatic compression
+			 on the compression enabled files. In "user" mode, f2fs disables
+			 the automaic compression and gives the user discretion of
+			 choosing the target file and the timing. The user can do manual
+			 compression/decompression on the compression enabled files using
+			 ioctls.
 inlinecrypt		 When possible, encrypt/decrypt the contents of encrypted
 			 files using the blk-crypto framework rather than
 			 filesystem-layer encryption. This allows the use of
@@ -810,6 +818,34 @@ Compress metadata layout::
 	| data length | data chksum | reserved |      compressed data       |
 	+-------------+-------------+----------+----------------------------+
 
+Compression mode
+--------------------------
+
+f2fs supports "fs" and "user" compression modes with "compression_mode" mount option.
+With this option, f2fs provides a choice to select the way how to compress the
+compression enabled files (refer to "Compression implementation" section for how to
+enable compression on a regular inode).
+
+1) compress_mode=fs
+This is the default option. f2fs does automatic compression in the writeback of the
+compression enabled files.
+
+2) compress_mode=user
+This disables the automaic compression and gives the user discretion of choosing the
+target file and the timing. The user can do manual compression/decompression on the
+compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
+ioctls like the below.
+
+To decompress a file,
+
+fd = open(filename, O_WRONLY, 0);
+ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
+
+To compress a file,
+
+fd = open(filename, O_WRONLY, 0);
+ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
+
 NVMe Zoned Namespace devices
 ----------------------------
 
diff --git a/Makefile b/Makefile
index 3bc56bf43c82..3b36b77589f2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 218
+SUBLEVEL = 219
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 12bc1d3ed424..adc0a096ab4c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -58,7 +58,7 @@ cpu@3 {
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf1001000 0x0 0x1000>,  /* GICD */
-		      <0x0 0xf1002000 0x0 0x100>;   /* GICC */
+		      <0x0 0xf1002000 0x0 0x2000>;  /* GICC */
 		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 6e5f8465669e..a5ff8cfedf34 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -9,8 +9,8 @@ / {
 	compatible = "nvidia,norrin", "nvidia,tegra132", "nvidia,tegra124";
 
 	aliases {
-		rtc0 = "/i2c@7000d000/as3722@40";
-		rtc1 = "/rtc@7000e000";
+		rtc0 = &as3722;
+		rtc1 = &tegra_rtc;
 		serial0 = &uarta;
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index b14e9f3bfdbd..2533d72fb2e5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -573,7 +573,7 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x0 0x7000e000 0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a80c578484ba..b6d70d0073e7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -60,7 +60,7 @@ bluetooth {
 		vddrf-supply = <&vreg_l1_1p3>;
 		vddch0-supply = <&vdd_ch0_3p3>;
 
-		local-bd-address = [ 02 00 00 00 5a ad ];
+		local-bd-address = [ 00 00 00 00 00 00 ];
 
 		max-speed = <3200000>;
 	};
diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 03f52f84a4f3..bc2dcc8a0000 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -28,6 +28,7 @@
 	14470:	.long 14471f - 14470b;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
+		.align 2;				\
 		.popsection;				\
 	14471:
 #else
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index dfb5218137ca..3aad58626429 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -234,6 +234,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		case PSR_AA32_MODE_SVC:
 		case PSR_AA32_MODE_ABT:
 		case PSR_AA32_MODE_UND:
+		case PSR_AA32_MODE_SYS:
 			if (!vcpu_el1_is_32bit(vcpu))
 				return -EINVAL;
 			break;
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 546bab6bfc27..d0ca4df43528 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -432,7 +432,9 @@ resume:
 	movec	%a0,%dfc
 
 	/* restore status register */
-	movew	%a1@(TASK_THREAD+THREAD_SR),%sr
+	movew	%a1@(TASK_THREAD+THREAD_SR),%d0
+	oriw	#0x0700,%d0
+	movew	%d0,%sr
 
 	rts
 
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 90f4e9ca1276..d3b34dd7590d 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -452,30 +452,18 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II &&
-	    macintosh_config->ident != MAC_MODEL_SE30) {
-		/* need ROMBASE in booter */
-		/* indeed, plus need to MAP THE ROM !! */
-
-		if (mac_bi_data.rombase == 0)
-			mac_bi_data.rombase = 0x40800000;
-
-		/* works on some */
-		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
-
-		local_irq_disable();
-		rom_reset();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
-	           macintosh_config->adb_type == MAC_ADB_CUDA) {
+	if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	    macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
+	} else
 #endif
 #ifdef CONFIG_ADB_PMU
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+	if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
+	} else
 #endif
-	} else if (CPU_IS_030) {
-
+	if (CPU_IS_030) {
 		/* 030-specific reset routine.  The idea is general, but the
 		 * specific registers to reset are '030-specific.  Until I
 		 * have a non-030 machine, I can't test anything else.
@@ -523,6 +511,18 @@ void mac_reset(void)
 		    "jmp %/a0@\n\t" /* jump to the reset vector */
 		    ".chip 68k"
 		    : : "r" (offset), "a" (rombase) : "a0");
+	} else {
+		/* need ROMBASE in booter */
+		/* indeed, plus need to MAP THE ROM !! */
+
+		if (mac_bi_data.rombase == 0)
+			mac_bi_data.rombase = 0x40800000;
+
+		/* works on some */
+		rom_reset = (void *)(mac_bi_data.rombase + 0xa);
+
+		local_irq_disable();
+		rom_reset();
 	}
 
 	/* should never get here */
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index dd71637437f4..8b9d52b194cb 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -7,7 +7,6 @@ ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code and low level code
 CFLAGS_REMOVE_timer.o = -pg
 CFLAGS_REMOVE_intc.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
diff --git a/arch/microblaze/kernel/cpu/cpuinfo-static.c b/arch/microblaze/kernel/cpu/cpuinfo-static.c
index 85dbda4a08a8..03da36dc6d9c 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo-static.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo-static.c
@@ -18,7 +18,7 @@ static const char family_string[] = CONFIG_XILINX_MICROBLAZE0_FAMILY;
 static const char cpu_ver_string[] = CONFIG_XILINX_MICROBLAZE0_HW_VER;
 
 #define err_printk(x) \
-	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
+	pr_err("ERROR: Microblaze " x "-different for kernel and DTS\n");
 
 void __init set_cpuinfo_static(struct cpuinfo *ci, struct device_node *cpu)
 {
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index e8a6a751dfd8..07418f11a964 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -21,6 +21,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 00c8cda1c9c3..1a60188f74ad 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -494,7 +494,7 @@ struct hvcall_mpp_data {
 	unsigned long backing_mem;
 };
 
-int h_get_mpp(struct hvcall_mpp_data *);
+long h_get_mpp(struct hvcall_mpp_data *mpp_data);
 
 struct hvcall_mpp_x_data {
 	unsigned long coalesced_bytes;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 4a3425fb1939..aed67f1a1bc5 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1883,10 +1883,10 @@ void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf)
  * h_get_mpp
  * H_GET_MPP hcall returns info in 7 parms
  */
-int h_get_mpp(struct hvcall_mpp_data *mpp_data)
+long h_get_mpp(struct hvcall_mpp_data *mpp_data)
 {
-	int rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	long rc;
 
 	rc = plpar_hcall9(H_GET_MPP, retbuf);
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index a7d4e25ae82a..e0c5fc9ab242 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -112,8 +112,8 @@ struct hvcall_ppp_data {
  */
 static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
-	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	long rc;
 
 	rc = plpar_hcall9(H_GET_PPP, retbuf);
 
@@ -192,7 +192,7 @@ static void parse_ppp_data(struct seq_file *m)
 	struct hvcall_ppp_data ppp_data;
 	struct device_node *root;
 	const __be32 *perf_level;
-	int rc;
+	long rc;
 
 	rc = h_get_ppp(&ppp_data);
 	if (rc)
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index d276c5e96445..77aa7a13ab1d 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -573,10 +573,12 @@ static const struct fsl_msi_feature ipic_msi_feature = {
 	.msiir_offset = 0x38,
 };
 
+#ifdef CONFIG_EPAPR_PARAVIRT
 static const struct fsl_msi_feature vmpic_msi_feature = {
 	.fsl_pic_ip = FSL_PIC_IP_VMPIC,
 	.msiir_offset = 0,
 };
+#endif
 
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index c469e8848d65..939ceec83048 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -832,8 +832,8 @@ static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
 		scpdata_len += padding;
 	}
 
-	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
-	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN + scpdata_len;
 	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
 
 	return count;
@@ -1602,9 +1602,9 @@ static int __init dump_nvme_init(void)
 	}
 	dump_block_nvme->hdr.len = IPL_BP_NVME_LEN;
 	dump_block_nvme->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_nvme->fcp.len = IPL_BP0_NVME_LEN;
-	dump_block_nvme->fcp.pbt = IPL_PBT_NVME;
-	dump_block_nvme->fcp.opt = IPL_PB0_NVME_OPT_DUMP;
+	dump_block_nvme->nvme.len = IPL_BP0_NVME_LEN;
+	dump_block_nvme->nvme.pbt = IPL_PBT_NVME;
+	dump_block_nvme->nvme.opt = IPL_PB0_NVME_OPT_DUMP;
 	dump_capabilities |= DUMP_TYPE_NVME;
 	return 0;
 }
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 756100b01e84..849801373219 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -44,17 +44,12 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (OPCODE_RTE(opcode))
 		return -EFAULT;	/* Bad breakpoint */
 
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = opcode;
 
 	return 0;
 }
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	p->opcode = *p->addr;
-}
-
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..06fed5a21e8b 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -33,7 +33,8 @@
  */
 
 /*	
- * asmlinkage __wsum csum_partial(const void *buf, int len, __wsum sum);
+ * unsigned int csum_partial(const unsigned char *buf, int len,
+ *                           unsigned int sum);
  */
 
 .text
@@ -45,31 +46,11 @@ ENTRY(csum_partial)
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */
+	mov	r5, r1
 	mov	r4, r0
-	tst	#3, r0		! Check alignment.
-	bt/s	2f		! Jump if alignment is ok.
-	 mov	r4, r7		! Keep a copy to check for alignment
+	tst	#2, r0		! Check alignment.
+	bt	2f		! Jump if alignment is ok.
 	!
-	tst	#1, r0		! Check alignment.
-	bt	21f		! Jump if alignment is boundary of 2bytes.
-
-	! buf is odd
-	tst	r5, r5
-	add	#-1, r5
-	bt	9f
-	mov.b	@r4+, r0
-	extu.b	r0, r0
-	addc	r0, r6		! t=0 from previous tst
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-	mov	r4, r0
-	tst	#2, r0
-	bt	2f
-21:
-	! buf is 2 byte aligned (len could be 0)
 	add	#-2, r5		! Alignment uses up two bytes.
 	cmp/pz	r5		!
 	bt/s	1f		! Jump if we had at least two bytes.
@@ -77,17 +58,16 @@ ENTRY(csum_partial)
 	bra	6f
 	 add	#2, r5		! r5 was < 2.  Deal with it.
 1:
+	mov	r5, r1		! Save new len for later use.
 	mov.w	@r4+, r0
 	extu.w	r0, r0
 	addc	r0, r6
 	bf	2f
 	add	#1, r6
 2:
-	! buf is 4 byte aligned (len could be 0)
-	mov	r5, r1
 	mov	#-5, r0
-	shld	r0, r1
-	tst	r1, r1
+	shld	r0, r5
+	tst	r5, r5
 	bt/s	4f		! if it's =0, go to 4f
 	 clrt
 	.align	2
@@ -109,31 +89,30 @@ ENTRY(csum_partial)
 	addc	r0, r6
 	addc	r2, r6
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	3b
 	 cmp/eq	#1, r0
-	! here, we know r1==0
-	addc	r1, r6			! add carry to r6
+	! here, we know r5==0
+	addc	r5, r6			! add carry to r6
 4:
-	mov	r5, r0
+	mov	r1, r0
 	and	#0x1c, r0
 	tst	r0, r0
-	bt	6f
-	! 4 bytes or more remaining
-	mov	r0, r1
-	shlr2	r1
+	bt/s	6f
+	 mov	r0, r5
+	shlr2	r5
 	mov	#0, r2
 5:
 	addc	r2, r6
 	mov.l	@r4+, r2
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	5b
 	 cmp/eq	#1, r0
 	addc	r2, r6
-	addc	r1, r6		! r1==0 here, so it means add carry-bit
+	addc	r5, r6		! r5==0 here, so it means add carry-bit
 6:
-	! 3 bytes or less remaining
+	mov	r1, r5
 	mov	#3, r0
 	and	r0, r5
 	tst	r5, r5
@@ -159,16 +138,6 @@ ENTRY(csum_partial)
 	mov	#0, r0
 	addc	r0, r6
 9:
-	! Check if the buffer was misaligned, if so realign sum
-	mov	r7, r0
-	tst	#1, r0
-	bt	10f
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-10:
 	rts
 	 mov	r6, r0
 
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index e75783b6abc4..16ab904616a0 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -47,7 +47,6 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void cpu_play_dead(void);
 
@@ -77,7 +76,6 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
-#define smp_fill_in_cpu_possible_map() do { } while (0)
 #define smp_init_cpu_poke() do { } while (0)
 #define scheduler_poke() do { } while (0)
 
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..0614e179bccc 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -13,16 +13,6 @@ typedef unsigned int    tcflag_t;
 typedef unsigned long   tcflag_t;
 #endif
 
-#define NCC 8
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
 #define NCCS 17
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include/uapi/asm/termios.h
index ee86f4093d83..cceb32260881 100644
--- a/arch/sparc/include/uapi/asm/termios.h
+++ b/arch/sparc/include/uapi/asm/termios.h
@@ -40,5 +40,14 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
+#define NCC 8
+struct termio {
+	unsigned short c_iflag;		/* input mode flags */
+	unsigned short c_oflag;		/* output mode flags */
+	unsigned short c_cflag;		/* control mode flags */
+	unsigned short c_lflag;		/* local mode flags */
+	unsigned char c_line;		/* line discipline */
+	unsigned char c_cc[NCC];	/* control characters */
+};
 
 #endif /* _UAPI_SPARC_TERMIOS_H */
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index f883a50fa333..4eae633f7198 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -483,7 +483,9 @@ static void *record_one_cpu(struct device_node *dp, int cpuid, int arg)
 	ncpus_probed++;
 #ifdef CONFIG_SMP
 	set_cpu_present(cpuid, true);
-	set_cpu_possible(cpuid, true);
+
+	if (num_possible_cpus() < nr_cpu_ids)
+		set_cpu_possible(cpuid, true);
 #endif
 	return NULL;
 }
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index d87244197d5c..d921b4790af9 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -688,7 +688,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
-	smp_fill_in_cpu_possible_map();
 	/*
 	 * Once the OF device tree and MDESC have been setup and nr_cpus has
 	 * been parsed, we know the list of possible cpus.  Therefore we can
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index ae5faa1d989d..748909095d9b 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1210,20 +1210,6 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __init smp_fill_in_cpu_possible_map(void)
-{
-	int possible_cpus = num_possible_cpus();
-	int i;
-
-	if (possible_cpus > nr_cpu_ids)
-		possible_cpus = nr_cpu_ids;
-
-	for (i = 0; i < possible_cpus; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-}
-
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 14ad9f495fe6..37e96ba0f5fb 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -668,24 +668,26 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_port *port,
 		goto cleanup;
 	}
 
-	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
-				   .fd  	= fd,
+	*winch = ((struct winch) { .fd  	= fd,
 				   .tty_fd 	= tty_fd,
 				   .pid  	= pid,
 				   .port 	= port,
 				   .stack	= stack });
 
+	spin_lock(&winch_handler_lock);
+	list_add(&winch->list, &winch_handlers);
+	spin_unlock(&winch_handler_lock);
+
 	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			   IRQF_SHARED, "winch", winch) < 0) {
 		printk(KERN_ERR "register_winch_irq - failed to register "
 		       "IRQ\n");
+		spin_lock(&winch_handler_lock);
+		list_del(&winch->list);
+		spin_unlock(&winch_handler_lock);
 		goto out_free;
 	}
 
-	spin_lock(&winch_handler_lock);
-	list_add(&winch->list, &winch_handlers);
-	spin_unlock(&winch_handler_lock);
-
 	return;
 
  out_free:
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index b12c1b0d3e1d..de28ce711687 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1158,7 +1158,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1169,7 +1169,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index fc662f7cc2af..c10432ef2d41 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -142,7 +142,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b65..a7cb380c0b5c 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -15,8 +15,6 @@ typedef struct mm_context {
 	struct page *stub_pages[2];
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f41..92dbf727e384 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -15,4 +15,6 @@ struct mm_id {
 	int kill;
 };
 
+void __switch_mm(struct mm_id *mm_idp);
+
 #endif
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 27b5e2bc6a01..e6546aa448de 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -258,6 +258,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -281,7 +282,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index 6a0b15e7196a..54c0ee41209d 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -153,5 +153,6 @@ SYM_FUNC_START(nh_avx2)
 	vpaddq		T1, T0, T0
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
+	vzeroupper
 	RET
 SYM_FUNC_END(nh_avx2)
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 3439aaf4295d..81c8053152bb 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -711,6 +711,7 @@ done_hash:
 	popq	%r13
 	popq	%r12
 	popq	%rbx
+	vzeroupper
 	RET
 SYM_FUNC_END(sha256_transform_rorx)
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..f0b817eb6e8b 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -233,12 +224,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -261,23 +248,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6dc3c5f0be07..c682a14299e0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -528,7 +528,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bd557e9f5dd8..167c9df27ae7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -920,7 +920,8 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
 		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
 		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -957,6 +958,7 @@ void irq_complete_move(struct irq_cfg *cfg)
  */
 void irq_force_complete_move(struct irq_desc *desc)
 {
+	unsigned int cpu = smp_processor_id();
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
@@ -981,10 +983,11 @@ void irq_force_complete_move(struct irq_desc *desc)
 		goto unlock;
 
 	/*
-	 * If prev_vector is empty, no action required.
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
 	 */
 	vector = apicd->prev_vector;
-	if (!vector)
+	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
 		goto unlock;
 
 	/*
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 923660057f36..a6f357774697 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -192,11 +192,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned = false;
 
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
+	cur->adjusted = bootval;
 
 	/*
 	 * Check whether this CPU is the first in a package to come up. In
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..1c25c1072a84 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index cdb337cf92ba..98a5924d98b7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -649,33 +649,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	}
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			set_signal_archinfo(address, error_code);
-
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 #ifdef CONFIG_VMAP_STACK
 	/*
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index dc0b91c1db04..7c7bfdf0d0c0 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -37,7 +37,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 0043fd374a62..f9ec998b7e94 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -689,6 +689,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes sections; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
+			continue;
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
index f7ed43020672..0a970261b107 100644
--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -294,4 +294,5 @@ module_exit(ecrdsa_mod_fini);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vitaly Chikunov <vt@altlinux.org>");
 MODULE_DESCRIPTION("EC-RDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecrdsa");
 MODULE_ALIAS_CRYPTO("ecrdsa-generic");
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 7598778cf37f..60c059c74fb6 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -576,7 +576,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index f919811156b1..b6cf9c9bd639 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -5,6 +5,7 @@
 
 ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
 
 # use acpi.o to put all files here into acpi.o modparam namespace
 obj-y	+= acpi.o
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 42b1b06efda6..aa92ec4fe721 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -475,6 +475,18 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
+	{
+		/* TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
+	{
+		/* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcbaa4d6a0ff..6631a65f632b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -476,7 +476,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
@@ -5408,7 +5408,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
 
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 4405d255e3aa..220739b309ea 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -114,8 +114,6 @@ static int legacy_port[NR_HOST] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
 static struct legacy_probe probe_list[NR_HOST];
 static struct legacy_data legacy_data[NR_HOST];
 static struct ata_host *legacy_host[NR_HOST];
-static int nr_legacy_host;
-
 
 static int probe_all;		/* Set to check all ISA port ranges */
 static int ht6560a;		/* HT 6560A on primary 1, second 2, both 3 */
@@ -1239,9 +1237,11 @@ static __exit void legacy_exit(void)
 {
 	int i;
 
-	for (i = 0; i < nr_legacy_host; i++) {
+	for (i = 0; i < NR_HOST; i++) {
 		struct legacy_data *ld = &legacy_data[i];
-		ata_host_detach(legacy_host[i]);
+
+		if (legacy_host[i])
+			ata_host_detach(legacy_host[i]);
 		platform_device_unregister(ld->platform_dev);
 	}
 }
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 35b390a785dd..862a9420df52 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2032,10 +2032,13 @@ static void __exit null_exit(void)
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags)
 		blk_mq_free_tag_set(&tag_set);
+
+	mutex_destroy(&lock);
 }
 
 module_init(null_init);
 module_exit(null_exit);
 
 MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
+MODULE_DESCRIPTION("multi queue aware block test driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..a97edbf7455a 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,35 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
+	}
+
+	index = ida_alloc(&ida_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
 	}
 
-	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
-		ida_simple_remove(&ida_index, index);
-		goto err;
+		ida_free(&ida_index, index);
+		goto err_put_port;
 	}
 
 	pp->pdev = pdev;
 	pp->index = index;
 	dev_dbg(&pdev->dev, "registered pardevice\n");
-err:
+err_put_port:
+	parport_put_port(port);
+err_free_name:
 	kfree(name);
 	return rc;
 }
@@ -750,7 +757,7 @@ static int pp_release(struct inode *inode, struct file *file)
 
 	if (pp->pdev) {
 		parport_unregister_device(pp->pdev);
-		ida_simple_remove(&ida_index, pp->index);
+		ida_free(&ida_index, pp->index);
 		pp->pdev = NULL;
 		pr_debug(CHRDEV "%x: unregistered pardevice\n", minor);
 	}
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index a68764cfb793..5e2e60c1c228 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2587,6 +2587,8 @@ static struct clk_hw *mmcc_msm8998_hws[] = {
 
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
+	.cxcs = (unsigned int []){ 0x1028, 0x1034, 0x1038 },
+	.cxc_count = 3,
 	.pd = {
 		.name = "video_top",
 	},
@@ -2595,20 +2597,26 @@ static struct gdsc video_top_gdsc = {
 
 static struct gdsc video_subcore0_gdsc = {
 	.gdscr = 0x1040,
+	.cxcs = (unsigned int []){ 0x1048 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore0",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc video_subcore1_gdsc = {
 	.gdscr = 0x1044,
+	.cxcs = (unsigned int []){ 0x104c },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore1",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc mdss_gdsc = {
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5b4bca71f201..162de402b113 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1559,47 +1559,36 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return 0;
 }
 
-static int cpufreq_offline(unsigned int cpu)
+static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy;
 	int ret;
 
-	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
-
-	policy = cpufreq_cpu_get_raw(cpu);
-	if (!policy) {
-		pr_debug("%s: No cpu_data found\n", __func__);
-		return 0;
-	}
-
-	down_write(&policy->rwsem);
 	if (has_target())
 		cpufreq_stop_governor(policy);
 
 	cpumask_clear_cpu(cpu, policy->cpus);
 
-	if (policy_is_inactive(policy)) {
-		if (has_target())
-			strncpy(policy->last_governor, policy->governor->name,
-				CPUFREQ_NAME_LEN);
-		else
-			policy->last_policy = policy->policy;
-	} else if (cpu == policy->cpu) {
-		/* Nominate new CPU */
-		policy->cpu = cpumask_any(policy->cpus);
-	}
-
-	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
+		/* Nominate a new CPU if necessary. */
+		if (cpu == policy->cpu)
+			policy->cpu = cpumask_any(policy->cpus);
+
+		/* Start the governor again for the active policy. */
 		if (has_target()) {
 			ret = cpufreq_start_governor(policy);
 			if (ret)
 				pr_err("%s: Failed to start governor\n", __func__);
 		}
 
-		goto unlock;
+		return;
 	}
 
+	if (has_target())
+		strncpy(policy->last_governor, policy->governor->name,
+			CPUFREQ_NAME_LEN);
+	else
+		policy->last_policy = policy->policy;
+
 	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
@@ -1617,12 +1606,31 @@ static int cpufreq_offline(unsigned int cpu)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
+		return;
+	}
+
+	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+
+	policy->freq_table = NULL;
+}
+
+static int cpufreq_offline(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+
+	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy) {
+		pr_debug("%s: No cpu_data found\n", __func__);
+		return 0;
 	}
 
-unlock:
+	down_write(&policy->rwsem);
+
+	__cpufreq_offline(cpu, policy);
+
 	up_write(&policy->rwsem);
 	return 0;
 }
@@ -1640,19 +1648,26 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (!policy)
 		return;
 
+	down_write(&policy->rwsem);
+
 	if (cpu_online(cpu))
-		cpufreq_offline(cpu);
+		__cpufreq_offline(cpu, policy);
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus)) {
-		/* We did light-weight exit earlier, do full tear down now */
-		if (cpufreq_driver->offline)
-			cpufreq_driver->exit(policy);
-
-		cpufreq_policy_free(policy);
+	if (!cpumask_empty(policy->real_cpus)) {
+		up_write(&policy->rwsem);
+		return;
 	}
+
+	/* We did light-weight exit earlier, do full tear down now */
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	up_write(&policy->rwsem);
+
+	cpufreq_policy_free(policy);
 }
 
 /**
diff --git a/drivers/crypto/bcm/spu2.c b/drivers/crypto/bcm/spu2.c
index c860ffb0b4c3..670d439f204c 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -495,7 +495,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 9dba52fbee99..121f9d0cb608 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -39,44 +39,38 @@ static const struct sp_dev_vdata dev_vdata[] = {
 	},
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id sp_acpi_match[] = {
 	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id sp_of_match[] = {
 	{ .compatible = "amd,ccp-seattle-v1a",
 	  .data = (const void *)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sp_of_match);
-#endif
 
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
 	const struct of_device_id *match;
 
 	match = of_match_node(sp_of_match, pdev->dev.of_node);
 	if (match && match->data)
 		return (struct sp_dev_vdata *)match->data;
-#endif
+
 	return NULL;
 }
 
 static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_ACPI
 	const struct acpi_device_id *match;
 
 	match = acpi_match_device(sp_acpi_match, &pdev->dev);
 	if (match && match->driver_data)
 		return (struct sp_dev_vdata *)match->driver_data;
-#endif
+
 	return NULL;
 }
 
@@ -222,12 +216,8 @@ static int sp_platform_resume(struct platform_device *pdev)
 static struct platform_driver sp_platform_driver = {
 	.driver = {
 		.name = "ccp",
-#ifdef CONFIG_ACPI
 		.acpi_match_table = sp_acpi_match,
-#endif
-#ifdef CONFIG_OF
 		.of_match_table = sp_of_match,
-#endif
 	},
 	.probe = sp_platform_probe,
 	.remove = sp_platform_remove,
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index dc0feedf5270..bf6e2116148b 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -95,8 +95,7 @@ static void adf_device_reset_worker(struct work_struct *work)
 	if (adf_dev_init(accel_dev) || adf_dev_start(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-		    completion_done(&reset_data->compl))
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
@@ -104,16 +103,8 @@ static void adf_device_reset_worker(struct work_struct *work)
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 
-	/*
-	 * The dev is back alive. Notify the caller if in sync mode
-	 *
-	 * If device restart will take a more time than expected,
-	 * the schedule_reset() function can timeout and exit. This can be
-	 * detected by calling the completion_done() function. In this case
-	 * the reset_data structure needs to be freed here.
-	 */
-	if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-	    completion_done(&reset_data->compl))
+	/* The dev is back alive. Notify the caller if in sync mode */
+	if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 		kfree(reset_data);
 	else
 		complete(&reset_data->compl);
@@ -148,10 +139,10 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 		if (!timeout) {
 			dev_err(&GET_DEV(accel_dev),
 				"Reset device timeout expired\n");
+			cancel_work_sync(&reset_data->reset_work);
 			ret = -EFAULT;
-		} else {
-			kfree(reset_data);
 		}
+		kfree(reset_data);
 		return ret;
 	}
 	return 0;
diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index 101394f16930..237bce21d1e7 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -110,12 +110,12 @@ static void sync_print_obj(struct seq_file *s, struct sync_timeline *obj)
 
 	seq_printf(s, "%s: %d\n", obj->name, obj->value);
 
-	spin_lock_irq(&obj->lock);
+	spin_lock(&obj->lock); /* Caller already disabled IRQ. */
 	list_for_each(pos, &obj->pt_list) {
 		struct sync_pt *pt = container_of(pos, struct sync_pt, link);
 		sync_print_fence(s, &pt->base, false);
 	}
-	spin_unlock_irq(&obj->lock);
+	spin_unlock(&obj->lock);
 }
 
 static void sync_print_sync_file(struct seq_file *s,
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index db506e1f7ef4..0f065ba844c0 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -594,7 +594,9 @@ static int idma64_probe(struct idma64_chip *chip)
 
 	idma64->dma.dev = chip->sysdev;
 
-	dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	ret = dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&idma64->dma);
 	if (ret)
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index aac507bff135..09485803280e 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -121,7 +121,8 @@ config EXTCON_MAX77843
 
 config EXTCON_MAX8997
 	tristate "Maxim MAX8997 EXTCON Support"
-	depends on MFD_MAX8997 && IRQ_DOMAIN
+	depends on MFD_MAX8997
+	select IRQ_DOMAIN
 	help
 	  If you say yes here you get support for the MUIC device of
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 86d71b0212b1..0cfc60cc267d 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -164,9 +164,14 @@ static int dmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 45ff03da234a..c8a292df6fea 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -96,8 +97,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 	if (size & 3)
 		return -EINVAL;
 
-	buf = dma_alloc_coherent(fw->cl.dev, PAGE_ALIGN(size), &bus_addr,
-				 GFP_ATOMIC);
+	buf = dma_alloc_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size),
+				 &bus_addr, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
@@ -125,7 +126,7 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 		ret = -EINVAL;
 	}
 
-	dma_free_coherent(fw->cl.dev, PAGE_ALIGN(size), buf, bus_addr);
+	dma_free_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size), buf, bus_addr);
 
 	return ret;
 }
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..4aebde0a7f1c 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -30,6 +30,7 @@ static int fme_region_get_bridges(struct fpga_region *region)
 static int fme_region_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct fpga_region_info info = { 0 };
 	struct device *dev = &pdev->dev;
 	struct fpga_region *region;
 	struct fpga_manager *mgr;
@@ -39,20 +40,18 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	info.mgr = mgr;
+	info.compat_id = mgr->compat_id;
+	info.get_bridges = fme_region_get_bridges;
+	info.priv = pdata;
+	region = fpga_region_register_full(dev, &info);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index eb8a6e329af9..ae220365fc04 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1400,19 +1400,15 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
-	if (!cdev->region) {
-		ret = -ENOMEM;
-		goto free_cdev_exit;
-	}
-
 	cdev->parent = info->dev;
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->port_dev_list);
 
-	ret = fpga_region_register(cdev->region);
-	if (ret)
+	cdev->region = fpga_region_register(info->dev, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
+	}
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe..d73daea579ac 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -33,14 +33,14 @@ struct fpga_region *fpga_region_class_find(
 EXPORT_SYMBOL_GPL(fpga_region_class_find);
 
 /**
- * fpga_region_get - get an exclusive reference to a fpga region
+ * fpga_region_get - get an exclusive reference to an fpga region
  * @region: FPGA Region struct
  *
  * Caller should call fpga_region_put() when done with region.
  *
  * Return fpga_region struct if successful.
  * Return -EBUSY if someone already has a reference to the region.
- * Return -ENODEV if @np is not a FPGA Region.
+ * Return -ENODEV if @np is not an FPGA Region.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
@@ -52,7 +52,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
+	if (!try_module_get(region->ops_owner)) {
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -74,7 +74,7 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
+	module_put(region->ops_owner);
 	put_device(dev);
 	mutex_unlock(&region->mutex);
 }
@@ -180,48 +180,60 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_create - alloc and init a struct fpga_region
- * @dev: device parent
- * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
- *
- * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
- * recommended.
+ * __fpga_region_register_full - create and register an FPGA Region device
+ * @parent: device parent
+ * @info: parameters for FPGA Region
+ * @owner: module containing the get_bridges function
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*fpga_region_create(struct device *dev,
-		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
+	if (!info) {
+		dev_err(parent,
+			"Attempt to register without required info structure\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto err_free;
+	}
+
+	region->mgr = info->mgr;
+	region->compat_id = info->compat_id;
+	region->priv = info->priv;
+	region->get_bridges = info->get_bridges;
+	region->ops_owner = owner;
 
-	region->mgr = mgr;
-	region->get_bridges = get_bridges;
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
-	region->dev.parent = dev;
-	region->dev.of_node = dev->of_node;
+	region->dev.parent = parent;
+	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
 	if (ret)
 		goto err_remove;
 
+	ret = device_register(&region->dev);
+	if (ret) {
+		put_device(&region->dev);
+		return ERR_PTR(ret);
+	}
+
 	return region;
 
 err_remove:
@@ -229,84 +241,41 @@ struct fpga_region
 err_free:
 	kfree(region);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_region_create);
-
-/**
- * fpga_region_free - free a FPGA region created by fpga_region_create()
- * @region: FPGA region
- */
-void fpga_region_free(struct fpga_region *region)
-{
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
-}
-EXPORT_SYMBOL_GPL(fpga_region_free);
-
-static void devm_fpga_region_release(struct device *dev, void *res)
-{
-	struct fpga_region *region = *(struct fpga_region **)res;
-
-	fpga_region_free(region);
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(__fpga_region_register_full);
 
 /**
- * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @dev: device parent
+ * __fpga_region_register - create and register an FPGA Region device
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
+ * @owner: module containing the get_bridges function
  *
- * This function is intended for use in a FPGA region driver's probe function.
- * After the region driver creates the region struct with
- * devm_fpga_region_create(), it should register it with fpga_region_register().
- * The region driver's remove function should call fpga_region_unregister().
- * The region struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_region_register(), the struct will still get cleaned up.
+ * This simple version of the register function should be sufficient for most users.
+ * The fpga_region_register_full() function is available for users that need to
+ * pass additional, optional parameters.
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*devm_fpga_region_create(struct device *dev,
-			 struct fpga_manager *mgr,
-			 int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
 {
-	struct fpga_region **ptr, *region;
-
-	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct fpga_region_info info = { 0 };
 
-	region = fpga_region_create(dev, mgr, get_bridges);
-	if (!region) {
-		devres_free(ptr);
-	} else {
-		*ptr = region;
-		devres_add(dev, ptr);
-	}
+	info.mgr = mgr;
+	info.get_bridges = get_bridges;
 
-	return region;
+	return __fpga_region_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_region_create);
+EXPORT_SYMBOL_GPL(__fpga_region_register);
 
 /**
- * fpga_region_register - register a FPGA region
+ * fpga_region_unregister - unregister an FPGA region
  * @region: FPGA region
  *
- * Return: 0 or -errno
- */
-int fpga_region_register(struct fpga_region *region)
-{
-	return device_add(&region->dev);
-}
-EXPORT_SYMBOL_GPL(fpga_region_register);
-
-/**
- * fpga_region_unregister - unregister a FPGA region
- * @region: FPGA region
- *
- * This function is intended for use in a FPGA region driver's remove function.
+ * This function is intended for use in an FPGA region driver's remove function.
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
@@ -316,6 +285,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..466e083654ae 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -405,16 +405,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index dbcaef3f35da..c54834ed8751 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2073,6 +2073,9 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0)
+		return instance;
+
 	switch (entry->ring_id) {
 	case 0:
 		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d243e60c6eef..534f2dec6356 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -766,6 +766,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
+		/* If the process just called exec(3), it is possible that the
+		 * cleanup of the kfd_process (following the release of the mm
+		 * of the old process image) is still in the cleanup work queue.
+		 * Make sure to drain any job before trying to recreate any
+		 * resource for this process.
+		 */
+		flush_workqueue(kfd_process_wq);
+
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3578e3b3536e..29ef0ed44d5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2099,6 +2099,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 7a00fe525dfb..bd9bc51983fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -379,6 +379,11 @@ bool cm_helper_translate_curve_to_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS) {
+				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
+					     i, TRANSFER_FUNC_POINTS);
+				return false;
+			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 7d0e7b031e44..fa5e77ee3af8 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -70,7 +70,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index f56ff97c9899..ae99d04f0045 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1978,6 +1978,9 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode)
+		return;
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 660e05fa4a70..7f58ceda5b08 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -766,10 +766,8 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(lt9611->dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(lt9611->dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..2e299cfe4e48 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -453,10 +453,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
 		connector->display_info.bus_formats[0],
 		tc->bpc);
-	/*
-	 * Default hardware register settings of tc358775 configured
-	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
-	 */
 	if (connector->display_info.bus_formats[0] ==
 		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
@@ -467,14 +463,15 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B6, LVI_B7, LVI_B1, LVI_B2));
 		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
 		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R6));
-	} else { /*  MEDIA_BUS_FMT_RGB666_1X7X3_SPWG - JEIDA-18 */
-		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
-		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_L0, LVI_R5, LVI_G0));
-		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G1, LVI_G2, LVI_L0, LVI_L0));
-		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G3, LVI_G4, LVI_G5, LVI_B0));
-		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_L0, LVI_L0, LVI_B1, LVI_B2));
-		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
-		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_L0));
+	} else {
+		/* JEIDA-18 and JEIDA-24 */
+		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R2, LVI_R3, LVI_R4, LVI_R5));
+		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R6, LVI_R1, LVI_R7, LVI_G2));
+		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G3, LVI_G4, LVI_G0, LVI_G1));
+		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G5, LVI_G6, LVI_G7, LVI_B2));
+		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B0, LVI_B1, LVI_B3, LVI_B4));
+		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B5, LVI_B6, LVI_B7, LVI_L0));
+		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R0));
 	}
 
 	d2l_write(tc->i2c, VFUEN, VFUEN_EN);
@@ -605,10 +602,8 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 83918ac1f608..1e9842aac4dc 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -572,7 +572,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
 {
 	/* Note: Needs updating for non-default PPS or algorithm */
 	u8 tx[2] = { enable << 0, 0 };
@@ -597,8 +597,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps)
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps)
 {
 	struct mipi_dsi_msg msg = {
 		.channel = dsi->channel,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index b20ea58907c2..1dac9cd20d46 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -21,6 +21,9 @@ static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
 
 	size = round_up(size, PAGE_SIZE);
 
+	if (size == 0)
+		return ERR_PTR(-EINVAL);
+
 	mtk_gem_obj = kzalloc(sizeof(*mtk_gem_obj), GFP_KERNEL);
 	if (!mtk_gem_obj)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 0eb86943a358..37127ba40aa9 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
+				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 8493d68ad841..e1a97c10c0e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -448,9 +448,6 @@ static void dpu_encoder_phys_cmd_enable_helper(
 
 	_dpu_encoder_phys_cmd_pingpong_config(phys_enc);
 
-	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
-		return;
-
 	ctl = phys_enc->hw_ctl;
 	ctl->ops.get_bitmask_intf(ctl, &flush_mask, phys_enc->intf_idx);
 	ctl->ops.update_pending_flush(ctl, flush_mask);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 51470020ba61..7797aad592a1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2235,6 +2235,9 @@ static const struct panel_desc innolux_g121x1_l03 = {
 		.unprepare = 200,
 		.disable = 400,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 /*
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 6d01258349fa..0bd49538cb6d 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1253,6 +1253,8 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		index = 1;
 
 	addr = of_get_address(dev->of_node, index, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
 
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index c6d48a8648b7..4a16ede402ff 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -164,6 +164,11 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		dev_err(dev, "ISH: Failed to allocate IRQ vectors\n");
+		return ret;
+	}
+
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		irq_flag = IRQF_SHARED;
 
diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index 18546ebc8e9f..0365643029ae 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -238,7 +238,7 @@ static int shtc1_probe(struct i2c_client *client)
 
 	if (np) {
 		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
-		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
+		data->setup.high_precision = !of_property_read_bool(np, "sensirion,low-precision");
 	} else {
 		if (client->dev.platform_data)
 			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index e25438025b9f..7f13687267fd 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -289,6 +289,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7e24),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..ae9ea3a1fa2a 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -868,8 +868,11 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -ENOMEM;
 
 	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
-	if (stm->major < 0)
-		goto err_free;
+	if (stm->major < 0) {
+		err = stm->major;
+		vfree(stm);
+		return err;
+	}
 
 	device_initialize(&stm->dev);
 	stm->dev.devt = MKDEV(stm->major, 0);
@@ -913,10 +916,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 err_device:
 	unregister_chrdev(stm->major, stm_data->name);
 
-	/* matches device_initialize() above */
+	/* calls stm_device_release() */
 	put_device(&stm->dev);
-err_free:
-	vfree(stm);
 
 	return err;
 }
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1b6b9530f166..7fdc7a0147f0 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -730,7 +730,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
@@ -746,7 +746,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -768,11 +770,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
-		if (rc < 0)
+		rc = dps310_calculate_temp(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 5b2baf89d110..4bcaaa0524b1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -159,76 +159,96 @@ void hns_roce_bitmap_cleanup(struct hns_roce_bitmap *bitmap)
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf)
 {
-	struct device *dev = hr_dev->dev;
-	u32 size = buf->size;
-	int i;
+	struct hns_roce_buf_list *trunks;
+	u32 i;
 
-	if (size == 0)
+	if (!buf)
 		return;
 
-	buf->size = 0;
+	trunks = buf->trunk_list;
+	if (trunks) {
+		buf->trunk_list = NULL;
+		for (i = 0; i < buf->ntrunks; i++)
+			dma_free_coherent(hr_dev->dev, 1 << buf->trunk_shift,
+					  trunks[i].buf, trunks[i].map);
 
-	if (hns_roce_buf_is_direct(buf)) {
-		dma_free_coherent(dev, size, buf->direct.buf, buf->direct.map);
-	} else {
-		for (i = 0; i < buf->npages; ++i)
-			if (buf->page_list[i].buf)
-				dma_free_coherent(dev, 1 << buf->page_shift,
-						  buf->page_list[i].buf,
-						  buf->page_list[i].map);
-		kfree(buf->page_list);
-		buf->page_list = NULL;
+		kfree(trunks);
 	}
+
+	kfree(buf);
 }
 
-int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
-		       struct hns_roce_buf *buf, u32 page_shift)
+/*
+ * Allocate the dma buffer for storing ROCEE table entries
+ *
+ * @size: required size
+ * @page_shift: the unit size in a continuous dma address range
+ * @flags: HNS_ROCE_BUF_ flags to control the allocation flow.
+ */
+struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
+					u32 page_shift, u32 flags)
 {
-	struct hns_roce_buf_list *buf_list;
-	struct device *dev = hr_dev->dev;
-	u32 page_size;
-	int i;
+	u32 trunk_size, page_size, alloced_size;
+	struct hns_roce_buf_list *trunks;
+	struct hns_roce_buf *buf;
+	gfp_t gfp_flags;
+	u32 ntrunk, i;
 
 	/* The minimum shift of the page accessed by hw is HNS_HW_PAGE_SHIFT */
-	buf->page_shift = max_t(int, HNS_HW_PAGE_SHIFT, page_shift);
+	if (WARN_ON(page_shift < HNS_HW_PAGE_SHIFT))
+		return ERR_PTR(-EINVAL);
+
+	gfp_flags = (flags & HNS_ROCE_BUF_NOSLEEP) ? GFP_ATOMIC : GFP_KERNEL;
+	buf = kzalloc(sizeof(*buf), gfp_flags);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
 
+	buf->page_shift = page_shift;
 	page_size = 1 << buf->page_shift;
-	buf->npages = DIV_ROUND_UP(size, page_size);
-
-	/* required size is not bigger than one trunk size */
-	if (size <= max_direct) {
-		buf->page_list = NULL;
-		buf->direct.buf = dma_alloc_coherent(dev, size,
-						     &buf->direct.map,
-						     GFP_KERNEL);
-		if (!buf->direct.buf)
-			return -ENOMEM;
+
+	/* Calc the trunk size and num by required size and page_shift */
+	if (flags & HNS_ROCE_BUF_DIRECT) {
+		buf->trunk_shift = ilog2(ALIGN(size, PAGE_SIZE));
+		ntrunk = 1;
 	} else {
-		buf_list = kcalloc(buf->npages, sizeof(*buf_list), GFP_KERNEL);
-		if (!buf_list)
-			return -ENOMEM;
-
-		for (i = 0; i < buf->npages; i++) {
-			buf_list[i].buf = dma_alloc_coherent(dev, page_size,
-							     &buf_list[i].map,
-							     GFP_KERNEL);
-			if (!buf_list[i].buf)
-				break;
-		}
+		buf->trunk_shift = ilog2(ALIGN(page_size, PAGE_SIZE));
+		ntrunk = DIV_ROUND_UP(size, 1 << buf->trunk_shift);
+	}
 
-		if (i != buf->npages && i > 0) {
-			while (i-- > 0)
-				dma_free_coherent(dev, page_size,
-						  buf_list[i].buf,
-						  buf_list[i].map);
-			kfree(buf_list);
-			return -ENOMEM;
-		}
-		buf->page_list = buf_list;
+	trunks = kcalloc(ntrunk, sizeof(*trunks), gfp_flags);
+	if (!trunks) {
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
 	}
-	buf->size = size;
 
-	return 0;
+	trunk_size = 1 << buf->trunk_shift;
+	alloced_size = 0;
+	for (i = 0; i < ntrunk; i++) {
+		trunks[i].buf = dma_alloc_coherent(hr_dev->dev, trunk_size,
+						   &trunks[i].map, gfp_flags);
+		if (!trunks[i].buf)
+			break;
+
+		alloced_size += trunk_size;
+	}
+
+	buf->ntrunks = i;
+
+	/* In nofail mode, it's only failed when the alloced size is 0 */
+	if ((flags & HNS_ROCE_BUF_NOFAIL) ? i == 0 : i != ntrunk) {
+		for (i = 0; i < buf->ntrunks; i++)
+			dma_free_coherent(hr_dev->dev, trunk_size,
+					  trunks[i].buf, trunks[i].map);
+
+		kfree(trunks);
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	buf->npages = DIV_ROUND_UP(alloced_size, page_size);
+	buf->trunk_list = trunks;
+
+	return buf;
 }
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index c493d7644b57..339e3fd98b0b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -60,7 +60,7 @@ static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
@@ -78,7 +78,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -108,7 +108,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -159,7 +159,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -173,7 +173,7 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout)
+		      unsigned int timeout)
 {
 	int ret;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 8e63b827f28c..8025e7f657fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -141,7 +141,7 @@ enum {
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout);
+		      unsigned int timeout);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff8cfeb..e57e812b1546 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -38,19 +38,19 @@
 #define roce_raw_write(value, addr) \
 	__raw_writel((__force u32)cpu_to_le32(value), (addr))
 
-#define roce_get_field(origin, mask, shift) \
-	(((le32_to_cpu(origin)) & (mask)) >> (shift))
+#define roce_get_field(origin, mask, shift)                                    \
+	((le32_to_cpu(origin) & (mask)) >> (u32)(shift))
 
 #define roce_get_bit(origin, shift) \
 	roce_get_field((origin), (1ul << (shift)), (shift))
 
-#define roce_set_field(origin, mask, shift, val) \
-	do { \
-		(origin) &= ~cpu_to_le32(mask); \
-		(origin) |= cpu_to_le32(((u32)(val) << (shift)) & (mask)); \
+#define roce_set_field(origin, mask, shift, val)                               \
+	do {                                                                   \
+		(origin) &= ~cpu_to_le32(mask);                                \
+		(origin) |= cpu_to_le32(((u32)(val) << (u32)(shift)) & (mask));     \
 	} while (0)
 
-#define roce_set_bit(origin, shift, val) \
+#define roce_set_bit(origin, shift, val)                                       \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index bff6abdccfb0..5cb7376ce978 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -95,8 +95,8 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
 					struct hns_roce_db *db, int order)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	for (o = order; o <= 1; ++o) {
 		i = find_first_bit(pgdir->bits[o], HNS_ROCE_DB_PER_PAGE >> o);
@@ -154,8 +154,8 @@ int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 
 void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	mutex_lock(&hr_dev->pgdir_mutex);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 09b5e4935c2c..fe54e09eeccd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -115,11 +115,15 @@
 #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
 #define SRQ_DB_REG				0x230
 
+#define HNS_ROCE_QP_BANK_NUM 8
+
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
  */
 #define EQ_DEPTH_COEFF				2
 
+#define CQ_BANKID_MASK GENMASK(1, 0)
+
 enum {
 	SERV_TYPE_RC,
 	SERV_TYPE_UC,
@@ -263,9 +267,6 @@ enum {
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
-/* The minimum page count for hardware access page directly. */
-#define HNS_HW_DIRECT_PAGE_COUNT 2
-
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
@@ -316,7 +317,7 @@ struct hns_roce_hem_table {
 };
 
 struct hns_roce_buf_region {
-	int offset; /* page offset */
+	u32 offset; /* page offset */
 	u32 count; /* page count */
 	int hopnum; /* addressing hop num */
 };
@@ -336,10 +337,10 @@ struct hns_roce_buf_attr {
 		size_t	size;  /* region size */
 		int	hopnum; /* multi-hop addressing hop num */
 	} region[HNS_ROCE_MAX_BT_REGION];
-	int region_count; /* valid region count */
+	unsigned int region_count; /* valid region count */
 	unsigned int page_shift;  /* buffer page shift */
 	bool fixed_page; /* decide page shift is fixed-size or maximum size */
-	int user_access; /* umem access flag */
+	unsigned int user_access; /* umem access flag */
 	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
 
@@ -350,7 +351,7 @@ struct hns_roce_hem_cfg {
 	unsigned int	buf_pg_shift; /* buffer page shift */
 	unsigned int	buf_pg_count;  /* buffer page count */
 	struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
-	int		region_count;
+	unsigned int	region_count;
 };
 
 /* memory translate region */
@@ -398,7 +399,7 @@ struct hns_roce_wq {
 	u64		*wrid;     /* Work request ID */
 	spinlock_t	lock;
 	u32		wqe_cnt;  /* WQE num */
-	int		max_gs;
+	u32		max_gs;
 	int		offset;
 	int		wqe_shift;	/* WQE size */
 	u32		head;
@@ -417,11 +418,26 @@ struct hns_roce_buf_list {
 	dma_addr_t	map;
 };
 
+/*
+ * %HNS_ROCE_BUF_DIRECT indicates that the all memory must be in a continuous
+ * dma address range.
+ *
+ * %HNS_ROCE_BUF_NOSLEEP indicates that the caller cannot sleep.
+ *
+ * %HNS_ROCE_BUF_NOFAIL allocation only failed when allocated size is zero, even
+ * the allocated size is smaller than the required size.
+ */
+enum {
+	HNS_ROCE_BUF_DIRECT = BIT(0),
+	HNS_ROCE_BUF_NOSLEEP = BIT(1),
+	HNS_ROCE_BUF_NOFAIL = BIT(2),
+};
+
 struct hns_roce_buf {
-	struct hns_roce_buf_list	direct;
-	struct hns_roce_buf_list	*page_list;
+	struct hns_roce_buf_list	*trunk_list;
+	u32				ntrunks;
 	u32				npages;
-	u32				size;
+	unsigned int			trunk_shift;
 	unsigned int			page_shift;
 };
 
@@ -449,8 +465,8 @@ struct hns_roce_db {
 	} u;
 	dma_addr_t	dma;
 	void		*virt_addr;
-	int		index;
-	int		order;
+	unsigned long	index;
+	unsigned long	order;
 };
 
 struct hns_roce_cq {
@@ -498,8 +514,8 @@ struct hns_roce_srq {
 	u64		       *wrid;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
-	int			head;
-	int			tail;
+	u16			head;
+	u16			tail;
 	struct mutex		mutex;
 	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 };
@@ -508,13 +524,22 @@ struct hns_roce_uar_table {
 	struct hns_roce_bitmap bitmap;
 };
 
+struct hns_roce_bank {
+	struct ida ida;
+	u32 inuse; /* Number of IDs allocated */
+	u32 min; /* Lowest ID to allocate.  */
+	u32 max; /* Highest ID to allocate. */
+	u32 next; /* Next ID to allocate. */
+};
+
 struct hns_roce_qp_table {
-	struct hns_roce_bitmap		bitmap;
 	struct hns_roce_hem_table	qp_table;
 	struct hns_roce_hem_table	irrl_table;
 	struct hns_roce_hem_table	trrl_table;
 	struct hns_roce_hem_table	sccc_table;
 	struct mutex			scc_mutex;
+	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
+	struct mutex bank_mutex;
 };
 
 struct hns_roce_cq_table {
@@ -728,11 +753,11 @@ struct hns_roce_eq {
 	int				type_flag; /* Aeq:1 ceq:0 */
 	int				eqn;
 	u32				entries;
-	int				log_entries;
+	u32				log_entries;
 	int				eqe_size;
 	int				irq;
 	int				log_page_size;
-	int				cons_index;
+	u32				cons_index;
 	struct hns_roce_buf_list	*buf_list;
 	int				over_ignore;
 	int				coalesce;
@@ -740,7 +765,7 @@ struct hns_roce_eq {
 	int				hop_num;
 	struct hns_roce_mtr		mtr;
 	u16				eq_max_cnt;
-	int				eq_period;
+	u32				eq_period;
 	int				shift;
 	int				event_type;
 	int				sub_type;
@@ -763,8 +788,8 @@ struct hns_roce_caps {
 	u32		max_sq_inline;
 	u32		max_rq_sg;
 	u32		max_extend_sg;
-	int		num_qps;
-	int             reserved_qps;
+	u32		num_qps;
+	u32		reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
 	int		num_srqs;
@@ -776,7 +801,7 @@ struct hns_roce_caps {
 	u32		max_srq_desc_sz;
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
-	int		num_cqs;
+	u32		num_cqs;
 	u32		max_cqes;
 	u32		min_cqes;
 	u32		min_wqes;
@@ -785,7 +810,7 @@ struct hns_roce_caps {
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
-	int		num_mtpts;
+	u32		num_mtpts;
 	u32		num_mtt_segs;
 	u32		num_cqe_segs;
 	u32		num_srqwqe_segs;
@@ -896,7 +921,7 @@ struct hns_roce_hw {
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
 			 u64 out_param, u32 in_modifier, u8 op_modifier, u16 op,
 			 u16 token, int event);
-	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned long timeout);
+	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned int timeout);
 	int (*rst_prc_mbox)(struct hns_roce_dev *hr_dev);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, u8 port, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
@@ -1067,29 +1092,19 @@ static inline struct hns_roce_qp
 	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
 }
 
-static inline bool hns_roce_buf_is_direct(struct hns_roce_buf *buf)
+static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf,
+					unsigned int offset)
 {
-	if (buf->page_list)
-		return false;
-
-	return true;
+	return (char *)(buf->trunk_list[offset >> buf->trunk_shift].buf) +
+			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
-static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
+static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, u32 idx)
 {
-	if (hns_roce_buf_is_direct(buf))
-		return (char *)(buf->direct.buf) + (offset & (buf->size - 1));
-
-	return (char *)(buf->page_list[offset >> buf->page_shift].buf) +
-	       (offset & ((1 << buf->page_shift) - 1));
-}
+	unsigned int offset = idx << buf->page_shift;
 
-static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
-{
-	if (hns_roce_buf_is_direct(buf))
-		return buf->direct.map + ((dma_addr_t)idx << buf->page_shift);
-	else
-		return buf->page_list[idx].map;
+	return buf->trunk_list[offset >> buf->trunk_shift].map +
+			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
 #define hr_hw_page_align(x)		ALIGN(x, 1 << HNS_HW_PAGE_SHIFT)
@@ -1161,7 +1176,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt);
+		     dma_addr_t *pages, unsigned int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
@@ -1221,8 +1236,8 @@ int hns_roce_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
 int hns_roce_dealloc_mw(struct ib_mw *ibmw);
 
 void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
-int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
-		       struct hns_roce_buf *buf, u32 page_shift);
+struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
+					u32 page_shift, u32 flags);
 
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, int start, struct hns_roce_buf *buf);
@@ -1244,10 +1259,10 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
 void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n);
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n);
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq);
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state);
 void hns_roce_lock_cqs(struct hns_roce_cq *send_cq,
@@ -1277,7 +1292,7 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index b7617786b100..5b2162a2b8ce 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -60,16 +60,16 @@ enum {
 	 (sizeof(struct scatterlist) + sizeof(void *)))
 
 #define check_whether_bt_num_3(type, hop_num) \
-	(type < HEM_TYPE_MTT && hop_num == 2)
+	((type) < HEM_TYPE_MTT && (hop_num) == 2)
 
 #define check_whether_bt_num_2(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == 2))
+	(((type) < HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 2))
 
 #define check_whether_bt_num_1(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0) || \
-	(type >= HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
+	(((type) < HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0))
 
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 6f9b024d4ff7..ea8d7154d0e1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -288,7 +288,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 					ret = -EINVAL;
 					*bad_wr = wr;
 					dev_err(dev, "inline len(1-%d)=%d, illegal",
-						ctrl->msg_length,
+						le32_to_cpu(ctrl->msg_length),
 						hr_dev->caps.max_sq_inline);
 					goto out;
 				}
@@ -1715,7 +1715,7 @@ static int hns_roce_v1_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v1_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	u8 __iomem *hcr = hr_dev->reg_base + ROCEE_MB1_REG;
 	unsigned long end;
@@ -3674,10 +3674,10 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	return 0;
 }
 
-static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
+static void set_eq_cons_index_v1(struct hns_roce_eq *eq, u32 req_not)
 {
 	roce_raw_write((eq->cons_index & HNS_ROCE_V1_CONS_IDX_M) |
-		      (req_not << eq->log_entries), eq->doorbell);
+		       (req_not << eq->log_entries), eq->doorbell);
 }
 
 static void hns_roce_v1_wq_catas_err_handle(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 518b38e9158d..13aa8dd42f7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -650,7 +650,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
 	void *wqe = NULL;
-	int nreq;
+	u32 nreq;
 	int ret;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
@@ -828,7 +828,7 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
-static void *get_idx_buf(struct hns_roce_idx_que *idx_que, int n)
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, unsigned int n)
 {
 	return hns_roce_buf_offset(idx_que->mtr.kmem,
 				   n << idx_que->entry_shift);
@@ -869,12 +869,12 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
+	unsigned int ind;
 	__le32 *srq_idx;
 	int ret = 0;
 	int wqe_idx;
 	void *wqe;
 	int nreq;
-	int ind;
 	int i;
 
 	spin_lock_irqsave(&srq->lock, flags);
@@ -1128,7 +1128,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
 	} else {
@@ -1136,7 +1136,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
 	}
@@ -1907,8 +1907,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	}
 }
 
-static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
-		       int *buf_page_size, int *bt_page_size, u32 hem_type)
+static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
+		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type)
 {
 	u64 obj_per_chunk;
 	u64 bt_chunk_size = PAGE_SIZE;
@@ -2382,10 +2382,10 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 	u32 buf_chk_sz;
 	dma_addr_t t;
 	int func_num = 1;
-	int pg_num_a;
-	int pg_num_b;
-	int pg_num;
-	int size;
+	u32 pg_num_a;
+	u32 pg_num_b;
+	u32 pg_num;
+	u32 size;
 	int i;
 
 	switch (type) {
@@ -2549,7 +2549,7 @@ static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_mbox_status *mb_st =
 				       (struct hns_roce_mbox_status *)desc.data;
-	enum hns_roce_cmd_return_status status;
+	int status;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST, true);
 
@@ -2620,7 +2620,7 @@ static int hns_roce_v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long end;
@@ -2970,7 +2970,7 @@ static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
 }
 
-static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
+static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 {
 	struct hns_roce_v2_cqe *cqe = get_cqe_v2(hr_cq, n & hr_cq->ib_cq.cqe);
 
@@ -3278,8 +3278,9 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		   wc->status == IB_WC_WR_FLUSH_ERR))
 		return;
 
-	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
-	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
+	ibdev_err_ratelimited(&hr_dev->ib_dev, "error cqe status 0x%x:\n",
+			      cqe_status);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 4, cqe,
 		       cq->cqe_size, false);
 
 	/*
@@ -3314,7 +3315,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
-	int qpn;
+	u32 qpn;
 	int ret;
 
 	/* Find cqe according to consumer index */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 90cbd15f6441..f62162771db5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -53,7 +53,7 @@
  *		GID[0][0], GID[1][0],.....GID[N - 1][0],
  *		And so on
  */
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
 {
 	return gid_index * hr_dev->caps.num_ports + port;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index d5b3b10e0a80..c038ed7d9496 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -484,18 +484,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
-	int ret = 0;
+	int ret, sg_num = 0;
 
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
 	if (!mr->page_list)
-		return ret;
+		return sg_num;
 
-	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
-	if (ret < 1) {
+	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
-			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
+			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
 		goto err_page_list;
 	}
 
@@ -506,17 +506,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
 	if (ret) {
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
-		ret = 0;
+		sg_num = 0;
 	} else {
-		mr->pbl_mtr.hem_cfg.buf_pg_shift = ilog2(ibmr->page_size);
-		ret = mr->npages;
+		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
 	}
 
 err_page_list:
 	kvfree(mr->page_list);
 	mr->page_list = NULL;
 
-	return ret;
+	return sg_num;
 }
 
 static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
@@ -694,15 +693,6 @@ static inline size_t mtr_bufs_size(struct hns_roce_buf_attr *attr)
 	return size;
 }
 
-static inline size_t mtr_kmem_direct_size(bool is_direct, size_t alloc_size,
-					  unsigned int page_shift)
-{
-	if (is_direct)
-		return ALIGN(alloc_size, 1 << page_shift);
-	else
-		return HNS_HW_DIRECT_PAGE_COUNT << page_shift;
-}
-
 /*
  * check the given pages in continuous address space
  * Returns 0 on success, or the error page num.
@@ -731,7 +721,6 @@ static void mtr_free_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr)
 	/* release kernel buffers */
 	if (mtr->kmem) {
 		hns_roce_buf_free(hr_dev, mtr->kmem);
-		kfree(mtr->kmem);
 		mtr->kmem = NULL;
 	}
 }
@@ -743,13 +732,12 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	unsigned int best_pg_shift;
 	int all_pg_count = 0;
-	size_t direct_size;
 	size_t total_size;
 	int ret;
 
 	total_size = mtr_bufs_size(buf_attr);
 	if (total_size < 1) {
-		ibdev_err(ibdev, "Failed to check mtr size\n");
+		ibdev_err(ibdev, "failed to check mtr size\n.");
 		return -EINVAL;
 	}
 
@@ -761,7 +749,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->umem = ib_umem_get(ibdev, user_addr, total_size,
 					buf_attr->user_access);
 		if (IS_ERR_OR_NULL(mtr->umem)) {
-			ibdev_err(ibdev, "Failed to get umem, ret %ld\n",
+			ibdev_err(ibdev, "failed to get umem, ret = %ld.\n",
 				  PTR_ERR(mtr->umem));
 			return -ENOMEM;
 		}
@@ -779,19 +767,16 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		ret = 0;
 	} else {
 		mtr->umem = NULL;
-		mtr->kmem = kzalloc(sizeof(*mtr->kmem), GFP_KERNEL);
-		if (!mtr->kmem) {
-			ibdev_err(ibdev, "Failed to alloc kmem\n");
-			return -ENOMEM;
-		}
-		direct_size = mtr_kmem_direct_size(is_direct, total_size,
-						   buf_attr->page_shift);
-		ret = hns_roce_buf_alloc(hr_dev, total_size, direct_size,
-					 mtr->kmem, buf_attr->page_shift);
-		if (ret) {
-			ibdev_err(ibdev, "Failed to alloc kmem, ret %d\n", ret);
-			goto err_alloc_mem;
+		mtr->kmem =
+			hns_roce_buf_alloc(hr_dev, total_size,
+					   buf_attr->page_shift,
+					   is_direct ? HNS_ROCE_BUF_DIRECT : 0);
+		if (IS_ERR(mtr->kmem)) {
+			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
+				  PTR_ERR(mtr->kmem));
+			return PTR_ERR(mtr->kmem);
 		}
+
 		best_pg_shift = buf_attr->page_shift;
 		all_pg_count = mtr->kmem->npages;
 	}
@@ -799,7 +784,8 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	/* must bigger than minimum hardware page shift */
 	if (best_pg_shift < HNS_HW_PAGE_SHIFT || all_pg_count < 1) {
 		ret = -EINVAL;
-		ibdev_err(ibdev, "Failed to check mtr page shift %d count %d\n",
+		ibdev_err(ibdev,
+			  "failed to check mtr, page shift = %u count = %d.\n",
 			  best_pg_shift, all_pg_count);
 		goto err_alloc_mem;
 	}
@@ -840,12 +826,12 @@ static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt)
+		     dma_addr_t *pages, unsigned int page_cnt)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
+	unsigned int i;
 	int err;
-	int i;
 
 	/*
 	 * Only use the first page address as root ba when hopnum is 0, this
@@ -882,13 +868,12 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
 	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	int mtt_count, left;
 	int start_index;
-	int mtt_count;
 	int total = 0;
 	__le64 *mtts;
-	int npage;
+	u32 npage;
 	u64 addr;
-	int left;
 
 	if (!mtt_buf || mtt_max < 1)
 		goto done;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index d1c07f1f8fe9..1a6de9a9e57c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -154,9 +154,66 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
-static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+static u8 get_affinity_cq_bank(u8 qp_bank)
 {
+	return (qp_bank >> 1) & CQ_BANKID_MASK;
+}
+
+static u8 get_least_load_bankid_for_qp(struct ib_qp_init_attr *init_attr,
+					struct hns_roce_bank *bank)
+{
+#define INVALID_LOAD_QPNUM 0xFFFFFFFF
+	struct ib_cq *scq = init_attr->send_cq;
+	u32 least_load = INVALID_LOAD_QPNUM;
+	unsigned long cqn = 0;
+	u8 bankid = 0;
+	u32 bankcnt;
+	u8 i;
+
+	if (scq)
+		cqn = to_hr_cq(scq)->cqn;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
+			continue;
+
+		bankcnt = bank[i].inuse;
+		if (bankcnt < least_load) {
+			least_load = bankcnt;
+			bankid = i;
+		}
+	}
+
+	return bankid;
+}
+
+static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
+				 unsigned long *qpn)
+{
+	int id;
+
+	id = ida_alloc_range(&bank->ida, bank->next, bank->max, GFP_KERNEL);
+	if (id < 0) {
+		id = ida_alloc_range(&bank->ida, bank->min, bank->max,
+				     GFP_KERNEL);
+		if (id < 0)
+			return id;
+	}
+
+	/* the QPN should keep increasing until the max value is reached. */
+	bank->next = (id + 1) > bank->max ? bank->min : id + 1;
+
+	/* the lower 3 bits is bankid */
+	*qpn = (id << 3) | bankid;
+
+	return 0;
+}
+static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		     struct ib_qp_init_attr *init_attr)
+{
+	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned long num = 0;
+	u8 bankid;
 	int ret;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI) {
@@ -169,13 +226,21 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 
 		hr_qp->doorbell_qpn = 1;
 	} else {
-		ret = hns_roce_bitmap_alloc_range(&hr_dev->qp_table.bitmap,
-						  1, 1, &num);
+		mutex_lock(&qp_table->bank_mutex);
+		bankid = get_least_load_bankid_for_qp(init_attr, qp_table->bank);
+
+		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
+					    &num);
 		if (ret) {
-			ibdev_err(&hr_dev->ib_dev, "Failed to alloc bitmap\n");
-			return -ENOMEM;
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to alloc QPN, ret = %d\n", ret);
+			mutex_unlock(&qp_table->bank_mutex);
+			return ret;
 		}
 
+		qp_table->bank[bankid].inuse++;
+		mutex_unlock(&qp_table->bank_mutex);
+
 		hr_qp->doorbell_qpn = (u32)num;
 	}
 
@@ -340,9 +405,15 @@ static void free_qpc(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	hns_roce_table_put(hr_dev, &qp_table->irrl_table, hr_qp->qpn);
 }
 
+static inline u8 get_qp_bankid(unsigned long qpn)
+{
+	/* The lower 3 bits of QPN are used to hash to different banks */
+	return (u8)(qpn & GENMASK(2, 0));
+}
+
 static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
+	u8 bankid;
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
 		return;
@@ -350,7 +421,13 @@ static void free_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	if (hr_qp->qpn < hr_dev->caps.reserved_qps)
 		return;
 
-	hns_roce_bitmap_free_range(&qp_table->bitmap, hr_qp->qpn, 1, BITMAP_RR);
+	bankid = get_qp_bankid(hr_qp->qpn);
+
+	ida_free(&hr_dev->qp_table.bank[bankid].ida, hr_qp->qpn >> 3);
+
+	mutex_lock(&hr_dev->qp_table.bank_mutex);
+	hr_dev->qp_table.bank[bankid].inuse--;
+	mutex_unlock(&hr_dev->qp_table.bank_mutex);
 }
 
 static int set_rq_size(struct hns_roce_dev *hr_dev, struct ib_qp_cap *cap,
@@ -944,7 +1021,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_db;
 	}
 
-	ret = alloc_qpn(hr_dev, hr_qp);
+	ret = alloc_qpn(hr_dev, hr_qp, init_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
 		goto err_buf;
@@ -1257,22 +1334,22 @@ static inline void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
 }
 
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->rq.offset + (n << hr_qp->rq.wqe_shift));
 }
 
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sq.offset + (n << hr_qp->sq.wqe_shift));
 }
 
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sge.offset + (n << hr_qp->sge.sge_shift));
 }
 
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq)
 {
 	struct hns_roce_cq *hr_cq;
@@ -1293,22 +1370,25 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
-	int reserved_from_top = 0;
-	int reserved_from_bot;
-	int ret;
+	unsigned int reserved_from_bot;
+	unsigned int i;
 
 	mutex_init(&qp_table->scc_mutex);
+	mutex_init(&qp_table->bank_mutex);
 	xa_init(&hr_dev->qp_table_xa);
 
 	reserved_from_bot = hr_dev->caps.reserved_qps;
 
-	ret = hns_roce_bitmap_init(&qp_table->bitmap, hr_dev->caps.num_qps,
-				   hr_dev->caps.num_qps - 1, reserved_from_bot,
-				   reserved_from_top);
-	if (ret) {
-		dev_err(hr_dev->dev, "qp bitmap init failed!error=%d\n",
-			ret);
-		return ret;
+	for (i = 0; i < reserved_from_bot; i++) {
+		hr_dev->qp_table.bank[get_qp_bankid(i)].inuse++;
+		hr_dev->qp_table.bank[get_qp_bankid(i)].min++;
+	}
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		ida_init(&hr_dev->qp_table.bank[i].ida);
+		hr_dev->qp_table.bank[i].max = hr_dev->caps.num_qps /
+					       HNS_ROCE_QP_BANK_NUM - 1;
+		hr_dev->qp_table.bank[i].next = hr_dev->qp_table.bank[i].min;
 	}
 
 	return 0;
@@ -1316,5 +1396,8 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 {
-	hns_roce_bitmap_cleanup(&hr_dev->qp_table.bitmap);
+	int i;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
+		ida_destroy(&hr_dev->qp_table.bank[i].ida);
 }
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4c50a87ed7cc..15a7cda44676 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -185,8 +185,12 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
 	ppriv = ipoib_priv(pdev);
 
-	snprintf(intf_name, sizeof(intf_name), "%s.%04x",
-		 ppriv->dev->name, pkey);
+	/* If you increase IFNAMSIZ, update snprintf below
+	 * to allow longer names.
+	 */
+	BUILD_BUG_ON(IFNAMSIZ != 16);
+	snprintf(intf_name, sizeof(intf_name), "%.10s.%04x", ppriv->dev->name,
+		 pkey);
 
 	ndev = ipoib_intf_alloc(ppriv->ca, ppriv->port, intf_name);
 	if (IS_ERR(ndev)) {
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 08b9b5cdb943..e5cb20e7f57b 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -42,8 +42,8 @@ struct ims_pcu_backlight {
 #define IMS_PCU_PART_NUMBER_LEN		15
 #define IMS_PCU_SERIAL_NUMBER_LEN	8
 #define IMS_PCU_DOM_LEN			8
-#define IMS_PCU_FW_VERSION_LEN		(9 + 1)
-#define IMS_PCU_BL_VERSION_LEN		(9 + 1)
+#define IMS_PCU_FW_VERSION_LEN		16
+#define IMS_PCU_BL_VERSION_LEN		16
 #define IMS_PCU_BL_RESET_REASON_LEN	(2 + 1)
 
 #define IMS_PCU_PCU_B_DEVICE_ID		5
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 53ad25eaf1a2..8bfe5c7b1244 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,7 +14,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV		(100)
+#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
 
 #define MAX_FF_SPEED		0xff
 
@@ -118,10 +119,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		vib->active = true;
 		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
 						VIB_MIN_LEVEL_mV;
-		vib->level /= 100;
+		vib->level /= VIB_PER_STEP_mV;
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / 100;
+		vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
 	}
 
 	pm8xxx_vib_set(vib, vib->active);
diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index d51bfe912db5..676b0bda3d72 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -190,7 +190,7 @@ static int ioc3kbd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ioc3kbd_remove(struct platform_device *pdev)
+static void ioc3kbd_remove(struct platform_device *pdev)
 {
 	struct ioc3kbd_data *d = platform_get_drvdata(pdev);
 
@@ -198,13 +198,18 @@ static int ioc3kbd_remove(struct platform_device *pdev)
 
 	serio_unregister_port(d->kbd);
 	serio_unregister_port(d->aux);
-
-	return 0;
 }
 
+static const struct platform_device_id ioc3kbd_id_table[] = {
+	{ "ioc3-kbd", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
+
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
-	.remove         = ioc3kbd_remove,
+	.remove_new     = ioc3kbd_remove,
+	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
 	},
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 1819bb1d2723..aedbc4befcdf 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 32562b7e681b..254a58fbb844 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -132,7 +132,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
 
 err_hwirq:
 	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 
 	return err;
 }
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 060e03f2264b..6adb34d1e381 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -142,24 +142,19 @@ static int macii_probe(void)
 /* Initialize the driver */
 static int macii_init(void)
 {
-	unsigned long flags;
 	int err;
 
-	local_irq_save(flags);
-
 	err = macii_init_via();
 	if (err)
-		goto out;
+		return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
 	if (err)
-		goto out;
+		return err;
 
 	macii_state = idle;
-out:
-	local_irq_restore(flags);
-	return err;
+	return 0;
 }
 
 /* initialize the hardware */
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b28302836b2e..91bc764a854c 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1355,7 +1355,7 @@ __acquires(bitmap->lock)
 	sector_t chunk = offset >> bitmap->chunkshift;
 	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
 	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
-	sector_t csize;
+	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
 	if (page >= bitmap->pages) {
@@ -1364,6 +1364,7 @@ __acquires(bitmap->lock)
 		 * End-of-device while looking for a whole page or
 		 * user set a huge number to sysfs bitmap_set_bits.
 		 */
+		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
@@ -1372,8 +1373,7 @@ __acquires(bitmap->lock)
 	    bitmap->bp[page].map == NULL)
 		csize = ((sector_t)1) << (bitmap->chunkshift +
 					  PAGE_COUNTER_SHIFT);
-	else
-		csize = ((sector_t)1) << bitmap->chunkshift;
+
 	*blocks = csize - (offset & (csize - 1));
 
 	if (err < 0)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 9f114b9d8dc6..66167c4c7bc9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6484,6 +6483,9 @@ static void raid5d(struct md_thread *thread)
 		int batch_size, released;
 		unsigned int offset;
 
+		if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+			break;
+
 		released = release_stripe_list(conf, conf->temp_inactive_list);
 		if (released)
 			clear_bit(R5_DID_ALLOC, &conf->cache_state);
@@ -6520,18 +6522,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 2f7ab5df1c58..73cc2b0fe185 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -39,15 +39,6 @@ static void cec_fill_msg_report_features(struct cec_adapter *adap,
  */
 #define CEC_XFER_TIMEOUT_MS (5 * 400 + 100)
 
-#define call_op(adap, op, arg...) \
-	(adap->ops->op ? adap->ops->op(adap, ## arg) : 0)
-
-#define call_void_op(adap, op, arg...)			\
-	do {						\
-		if (adap->ops->op)			\
-			adap->ops->op(adap, ## arg);	\
-	} while (0)
-
 static int cec_log_addr2idx(const struct cec_adapter *adap, u8 log_addr)
 {
 	int i;
@@ -161,10 +152,10 @@ static void cec_queue_event(struct cec_adapter *adap,
 	u64 ts = ktime_get_ns();
 	struct cec_fh *fh;
 
-	mutex_lock(&adap->devnode.lock);
+	mutex_lock(&adap->devnode.lock_fhs);
 	list_for_each_entry(fh, &adap->devnode.fhs, list)
 		cec_queue_event_fh(fh, ev, ts);
-	mutex_unlock(&adap->devnode.lock);
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 
 /* Notify userspace that the CEC pin changed state at the given time. */
@@ -178,11 +169,12 @@ void cec_queue_pin_cec_event(struct cec_adapter *adap, bool is_high,
 	};
 	struct cec_fh *fh;
 
-	mutex_lock(&adap->devnode.lock);
-	list_for_each_entry(fh, &adap->devnode.fhs, list)
+	mutex_lock(&adap->devnode.lock_fhs);
+	list_for_each_entry(fh, &adap->devnode.fhs, list) {
 		if (fh->mode_follower == CEC_MODE_MONITOR_PIN)
 			cec_queue_event_fh(fh, &ev, ktime_to_ns(ts));
-	mutex_unlock(&adap->devnode.lock);
+	}
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 EXPORT_SYMBOL_GPL(cec_queue_pin_cec_event);
 
@@ -195,10 +187,10 @@ void cec_queue_pin_hpd_event(struct cec_adapter *adap, bool is_high, ktime_t ts)
 	};
 	struct cec_fh *fh;
 
-	mutex_lock(&adap->devnode.lock);
+	mutex_lock(&adap->devnode.lock_fhs);
 	list_for_each_entry(fh, &adap->devnode.fhs, list)
 		cec_queue_event_fh(fh, &ev, ktime_to_ns(ts));
-	mutex_unlock(&adap->devnode.lock);
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 EXPORT_SYMBOL_GPL(cec_queue_pin_hpd_event);
 
@@ -211,10 +203,10 @@ void cec_queue_pin_5v_event(struct cec_adapter *adap, bool is_high, ktime_t ts)
 	};
 	struct cec_fh *fh;
 
-	mutex_lock(&adap->devnode.lock);
+	mutex_lock(&adap->devnode.lock_fhs);
 	list_for_each_entry(fh, &adap->devnode.fhs, list)
 		cec_queue_event_fh(fh, &ev, ktime_to_ns(ts));
-	mutex_unlock(&adap->devnode.lock);
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 EXPORT_SYMBOL_GPL(cec_queue_pin_5v_event);
 
@@ -286,12 +278,12 @@ static void cec_queue_msg_monitor(struct cec_adapter *adap,
 	u32 monitor_mode = valid_la ? CEC_MODE_MONITOR :
 				      CEC_MODE_MONITOR_ALL;
 
-	mutex_lock(&adap->devnode.lock);
+	mutex_lock(&adap->devnode.lock_fhs);
 	list_for_each_entry(fh, &adap->devnode.fhs, list) {
 		if (fh->mode_follower >= monitor_mode)
 			cec_queue_msg_fh(fh, msg);
 	}
-	mutex_unlock(&adap->devnode.lock);
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 
 /*
@@ -302,12 +294,12 @@ static void cec_queue_msg_followers(struct cec_adapter *adap,
 {
 	struct cec_fh *fh;
 
-	mutex_lock(&adap->devnode.lock);
+	mutex_lock(&adap->devnode.lock_fhs);
 	list_for_each_entry(fh, &adap->devnode.fhs, list) {
 		if (fh->mode_follower == CEC_MODE_FOLLOWER)
 			cec_queue_msg_fh(fh, msg);
 	}
-	mutex_unlock(&adap->devnode.lock);
+	mutex_unlock(&adap->devnode.lock_fhs);
 }
 
 /* Notify userspace of an adapter state change. */
@@ -365,38 +357,48 @@ static void cec_data_completed(struct cec_data *data)
 /*
  * A pending CEC transmit needs to be cancelled, either because the CEC
  * adapter is disabled or the transmit takes an impossibly long time to
- * finish.
+ * finish, or the reply timed out.
  *
  * This function is called with adap->lock held.
  */
-static void cec_data_cancel(struct cec_data *data, u8 tx_status)
+static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
 {
+	struct cec_adapter *adap = data->adap;
+
 	/*
 	 * It's either the current transmit, or it is a pending
 	 * transmit. Take the appropriate action to clear it.
 	 */
-	if (data->adap->transmitting == data) {
-		data->adap->transmitting = NULL;
+	if (adap->transmitting == data) {
+		adap->transmitting = NULL;
 	} else {
 		list_del_init(&data->list);
 		if (!(data->msg.tx_status & CEC_TX_STATUS_OK))
-			if (!WARN_ON(!data->adap->transmit_queue_sz))
-				data->adap->transmit_queue_sz--;
+			if (!WARN_ON(!adap->transmit_queue_sz))
+				adap->transmit_queue_sz--;
 	}
 
 	if (data->msg.tx_status & CEC_TX_STATUS_OK) {
 		data->msg.rx_ts = ktime_get_ns();
-		data->msg.rx_status = CEC_RX_STATUS_ABORTED;
+		data->msg.rx_status = rx_status;
+		if (!data->blocking)
+			data->msg.tx_status = 0;
 	} else {
 		data->msg.tx_ts = ktime_get_ns();
 		data->msg.tx_status |= tx_status |
 				       CEC_TX_STATUS_MAX_RETRIES;
 		data->msg.tx_error_cnt++;
 		data->attempts = 0;
+		if (!data->blocking)
+			data->msg.rx_status = 0;
 	}
 
 	/* Queue transmitted message for monitoring purposes */
-	cec_queue_msg_monitor(data->adap, &data->msg, 1);
+	cec_queue_msg_monitor(adap, &data->msg, 1);
+
+	if (!data->blocking && data->msg.sequence)
+		/* Allow drivers to react to a canceled transmit */
+		call_void_op(adap, adap_nb_transmit_canceled, &data->msg);
 
 	cec_data_completed(data);
 }
@@ -417,15 +419,15 @@ static void cec_flush(struct cec_adapter *adap)
 	while (!list_empty(&adap->transmit_queue)) {
 		data = list_first_entry(&adap->transmit_queue,
 					struct cec_data, list);
-		cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 	}
 	if (adap->transmitting)
-		cec_data_cancel(adap->transmitting, CEC_TX_STATUS_ABORTED);
+		adap->transmit_in_progress_aborted = true;
 
 	/* Cancel the pending timeout work. */
 	list_for_each_entry_safe(data, n, &adap->wait_queue, list) {
 		if (cancel_delayed_work(&data->work))
-			cec_data_cancel(data, CEC_TX_STATUS_OK);
+			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
 		/*
 		 * If cancel_delayed_work returned false, then
 		 * the cec_wait_timeout function is running,
@@ -500,6 +502,15 @@ int cec_thread_func(void *_adap)
 			goto unlock;
 		}
 
+		if (adap->transmit_in_progress &&
+		    adap->transmit_in_progress_aborted) {
+			if (adap->transmitting)
+				cec_data_cancel(adap->transmitting,
+						CEC_TX_STATUS_ABORTED, 0);
+			adap->transmit_in_progress = false;
+			adap->transmit_in_progress_aborted = false;
+			goto unlock;
+		}
 		if (adap->transmit_in_progress && timeout) {
 			/*
 			 * If we timeout, then log that. Normally this does
@@ -515,7 +526,7 @@ int cec_thread_func(void *_adap)
 					adap->transmitting->msg.msg);
 				/* Just give up on this. */
 				cec_data_cancel(adap->transmitting,
-						CEC_TX_STATUS_TIMEOUT);
+						CEC_TX_STATUS_TIMEOUT, 0);
 			} else {
 				pr_warn("cec-%s: transmit timed out\n", adap->name);
 			}
@@ -571,10 +582,11 @@ int cec_thread_func(void *_adap)
 		if (data->attempts == 0)
 			data->attempts = attempts;
 
+		adap->transmit_in_progress_aborted = false;
 		/* Tell the adapter to transmit, cancel on error */
-		if (adap->ops->adap_transmit(adap, data->attempts,
-					     signal_free_time, &data->msg))
-			cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		if (call_op(adap, adap_transmit, data->attempts,
+			    signal_free_time, &data->msg))
+			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 		else
 			adap->transmit_in_progress = true;
 
@@ -598,6 +610,8 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 	struct cec_msg *msg;
 	unsigned int attempts_made = arb_lost_cnt + nack_cnt +
 				     low_drive_cnt + error_cnt;
+	bool done = status & (CEC_TX_STATUS_MAX_RETRIES | CEC_TX_STATUS_OK);
+	bool aborted = adap->transmit_in_progress_aborted;
 
 	dprintk(2, "%s: status 0x%02x\n", __func__, status);
 	if (attempts_made < 1)
@@ -618,6 +632,7 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 		goto wake_thread;
 	}
 	adap->transmit_in_progress = false;
+	adap->transmit_in_progress_aborted = false;
 
 	msg = &data->msg;
 
@@ -638,8 +653,7 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 	 * the hardware didn't signal that it retried itself (by setting
 	 * CEC_TX_STATUS_MAX_RETRIES), then we will retry ourselves.
 	 */
-	if (data->attempts > attempts_made &&
-	    !(status & (CEC_TX_STATUS_MAX_RETRIES | CEC_TX_STATUS_OK))) {
+	if (!aborted && data->attempts > attempts_made && !done) {
 		/* Retry this message */
 		data->attempts -= attempts_made;
 		if (msg->timeout)
@@ -654,6 +668,8 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 		goto wake_thread;
 	}
 
+	if (aborted && !done)
+		status |= CEC_TX_STATUS_ABORTED;
 	data->attempts = 0;
 
 	/* Always set CEC_TX_STATUS_MAX_RETRIES on error */
@@ -732,9 +748,7 @@ static void cec_wait_timeout(struct work_struct *work)
 
 	/* Mark the message as timed out */
 	list_del_init(&data->list);
-	data->msg.rx_ts = ktime_get_ns();
-	data->msg.rx_status = CEC_RX_STATUS_TIMEOUT;
-	cec_data_completed(data);
+	cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_TIMEOUT);
 unlock:
 	mutex_unlock(&adap->lock);
 }
@@ -750,6 +764,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int err;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -912,14 +927,20 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 * Release the lock and wait, retake the lock afterwards.
 	 */
 	mutex_unlock(&adap->lock);
-	wait_for_completion_killable(&data->c);
-	if (!data->completed)
-		cancel_delayed_work_sync(&data->work);
+	err = wait_for_completion_killable(&data->c);
+	cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);
 
+	if (err)
+		adap->transmit_in_progress_aborted = true;
+
 	/* Cancel the transmit if it was interrupted */
-	if (!data->completed)
-		cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+	if (!data->completed) {
+		if (data->msg.tx_status & CEC_TX_STATUS_OK)
+			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
+		else
+			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
+	}
 
 	/* The transmit completed (possibly with an error) */
 	*msg = data->msg;
@@ -1294,7 +1315,7 @@ static int cec_config_log_addr(struct cec_adapter *adap,
 	 * Message not acknowledged, so this logical
 	 * address is free to use.
 	 */
-	err = adap->ops->adap_log_addr(adap, log_addr);
+	err = call_op(adap, adap_log_addr, log_addr);
 	if (err)
 		return err;
 
@@ -1311,9 +1332,8 @@ static int cec_config_log_addr(struct cec_adapter *adap,
  */
 static void cec_adap_unconfigure(struct cec_adapter *adap)
 {
-	if (!adap->needs_hpd ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID)
-		WARN_ON(adap->ops->adap_log_addr(adap, CEC_LOG_ADDR_INVALID));
+	if (!adap->needs_hpd || adap->phys_addr != CEC_PHYS_ADDR_INVALID)
+		WARN_ON(call_op(adap, adap_log_addr, CEC_LOG_ADDR_INVALID));
 	adap->log_addrs.log_addr_mask = 0;
 	adap->is_configured = false;
 	cec_flush(adap);
@@ -1521,9 +1541,12 @@ static int cec_config_thread_func(void *arg)
  */
 static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 {
-	if (WARN_ON(adap->is_configuring || adap->is_configured))
+	if (WARN_ON(adap->is_claiming_log_addrs ||
+		    adap->is_configuring || adap->is_configured))
 		return;
 
+	adap->is_claiming_log_addrs = true;
+
 	init_completion(&adap->config_completion);
 
 	/* Ready to kick off the thread */
@@ -1532,11 +1555,67 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 					   "ceccfg-%s", adap->name);
 	if (IS_ERR(adap->kthread_config)) {
 		adap->kthread_config = NULL;
+		adap->is_configuring = false;
 	} else if (block) {
 		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
 		mutex_lock(&adap->lock);
 	}
+	adap->is_claiming_log_addrs = false;
+}
+
+/*
+ * Helper function to enable/disable the CEC adapter.
+ *
+ * This function is called with adap->lock held.
+ */
+static int cec_adap_enable(struct cec_adapter *adap)
+{
+	bool enable;
+	int ret = 0;
+
+	enable = adap->monitor_all_cnt || adap->monitor_pin_cnt ||
+		 adap->log_addrs.num_log_addrs;
+	if (adap->needs_hpd)
+		enable = enable && adap->phys_addr != CEC_PHYS_ADDR_INVALID;
+
+	if (enable == adap->is_enabled)
+		return 0;
+
+	/* serialize adap_enable */
+	mutex_lock(&adap->devnode.lock);
+	if (enable) {
+		adap->last_initiator = 0xff;
+		adap->transmit_in_progress = false;
+		ret = adap->ops->adap_enable(adap, true);
+		if (!ret) {
+			/*
+			 * Enable monitor-all/pin modes if needed. We warn, but
+			 * continue if this fails as this is not a critical error.
+			 */
+			if (adap->monitor_all_cnt)
+				WARN_ON(call_op(adap, adap_monitor_all_enable, true));
+			if (adap->monitor_pin_cnt)
+				WARN_ON(call_op(adap, adap_monitor_pin_enable, true));
+		}
+	} else {
+		/* Disable monitor-all/pin modes if needed (needs_hpd == 1) */
+		if (adap->monitor_all_cnt)
+			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+		if (adap->monitor_pin_cnt)
+			WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+		WARN_ON(adap->ops->adap_enable(adap, false));
+		adap->last_initiator = 0xff;
+		adap->transmit_in_progress = false;
+		adap->transmit_in_progress_aborted = false;
+		if (adap->transmitting)
+			cec_data_cancel(adap->transmitting, CEC_TX_STATUS_ABORTED, 0);
+	}
+	if (!ret)
+		adap->is_enabled = enable;
+	wake_up_interruptible(&adap->kthread_waitq);
+	mutex_unlock(&adap->devnode.lock);
+	return ret;
 }
 
 /* Set a new physical address and send an event notifying userspace of this.
@@ -1545,52 +1624,30 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
  */
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block)
 {
+	bool becomes_invalid = phys_addr == CEC_PHYS_ADDR_INVALID;
+	bool is_invalid = adap->phys_addr == CEC_PHYS_ADDR_INVALID;
+
 	if (phys_addr == adap->phys_addr)
 		return;
-	if (phys_addr != CEC_PHYS_ADDR_INVALID && adap->devnode.unregistered)
+	if (!becomes_invalid && adap->devnode.unregistered)
 		return;
 
 	dprintk(1, "new physical address %x.%x.%x.%x\n",
 		cec_phys_addr_exp(phys_addr));
-	if (phys_addr == CEC_PHYS_ADDR_INVALID ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID) {
+	if (becomes_invalid || !is_invalid) {
 		adap->phys_addr = CEC_PHYS_ADDR_INVALID;
 		cec_post_state_event(adap);
 		cec_adap_unconfigure(adap);
-		/* Disabling monitor all mode should always succeed */
-		if (adap->monitor_all_cnt)
-			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
-		mutex_lock(&adap->devnode.lock);
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
-			WARN_ON(adap->ops->adap_enable(adap, false));
-			adap->transmit_in_progress = false;
-			wake_up_interruptible(&adap->kthread_waitq);
-		}
-		mutex_unlock(&adap->devnode.lock);
-		if (phys_addr == CEC_PHYS_ADDR_INVALID)
+		if (becomes_invalid) {
+			cec_adap_enable(adap);
 			return;
+		}
 	}
 
-	mutex_lock(&adap->devnode.lock);
-	adap->last_initiator = 0xff;
-	adap->transmit_in_progress = false;
-
-	if ((adap->needs_hpd || list_empty(&adap->devnode.fhs)) &&
-	    adap->ops->adap_enable(adap, true)) {
-		mutex_unlock(&adap->devnode.lock);
-		return;
-	}
-
-	if (adap->monitor_all_cnt &&
-	    call_op(adap, adap_monitor_all_enable, true)) {
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs))
-			WARN_ON(adap->ops->adap_enable(adap, false));
-		mutex_unlock(&adap->devnode.lock);
-		return;
-	}
-	mutex_unlock(&adap->devnode.lock);
-
 	adap->phys_addr = phys_addr;
+	if (is_invalid)
+		cec_adap_enable(adap);
+
 	cec_post_state_event(adap);
 	if (adap->log_addrs.num_log_addrs)
 		cec_claim_log_addrs(adap, block);
@@ -1647,12 +1704,15 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block)
 {
 	u16 type_mask = 0;
+	int err;
 	int i;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
 
 	if (!log_addrs || log_addrs->num_log_addrs == 0) {
+		if (!adap->is_configuring && !adap->is_configured)
+			return 0;
 		cec_adap_unconfigure(adap);
 		adap->log_addrs.num_log_addrs = 0;
 		for (i = 0; i < CEC_MAX_LOG_ADDRS; i++)
@@ -1660,6 +1720,7 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		adap->log_addrs.osd_name[0] = '\0';
 		adap->log_addrs.vendor_id = CEC_VENDOR_ID_NONE;
 		adap->log_addrs.cec_version = CEC_OP_CEC_VERSION_2_0;
+		cec_adap_enable(adap);
 		return 0;
 	}
 
@@ -1795,9 +1856,10 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 
 	log_addrs->log_addr_mask = adap->log_addrs.log_addr_mask;
 	adap->log_addrs = *log_addrs;
-	if (adap->phys_addr != CEC_PHYS_ADDR_INVALID)
+	err = cec_adap_enable(adap);
+	if (!err && adap->phys_addr != CEC_PHYS_ADDR_INVALID)
 		cec_claim_log_addrs(adap, block);
-	return 0;
+	return err;
 }
 
 int cec_s_log_addrs(struct cec_adapter *adap,
@@ -1899,11 +1961,10 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
 	    msg->msg[1] != CEC_MSG_CDC_MESSAGE)
 		return 0;
 
-	if (adap->ops->received) {
-		/* Allow drivers to process the message first */
-		if (adap->ops->received(adap, msg) != -ENOMSG)
-			return 0;
-	}
+	/* Allow drivers to process the message first */
+	if (adap->ops->received && !adap->devnode.unregistered &&
+	    adap->ops->received(adap, msg) != -ENOMSG)
+		return 0;
 
 	/*
 	 * REPORT_PHYSICAL_ADDR, CEC_MSG_USER_CONTROL_PRESSED and
@@ -2096,20 +2157,25 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
  */
 int cec_monitor_all_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
+
+	if (adap->monitor_all_cnt++)
+		return 0;
 
-	if (adap->monitor_all_cnt == 0)
-		ret = call_op(adap, adap_monitor_all_enable, 1);
-	if (ret == 0)
-		adap->monitor_all_cnt++;
+	ret = cec_adap_enable(adap);
+	if (ret)
+		adap->monitor_all_cnt--;
 	return ret;
 }
 
 void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_all_cnt--;
-	if (adap->monitor_all_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_all_enable, 0));
+	if (WARN_ON(!adap->monitor_all_cnt))
+		return;
+	if (--adap->monitor_all_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+	cec_adap_enable(adap);
 }
 
 /*
@@ -2119,20 +2185,25 @@ void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
  */
 int cec_monitor_pin_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
+
+	if (adap->monitor_pin_cnt++)
+		return 0;
 
-	if (adap->monitor_pin_cnt == 0)
-		ret = call_op(adap, adap_monitor_pin_enable, 1);
-	if (ret == 0)
-		adap->monitor_pin_cnt++;
+	ret = cec_adap_enable(adap);
+	if (ret)
+		adap->monitor_pin_cnt--;
 	return ret;
 }
 
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_pin_cnt--;
-	if (adap->monitor_pin_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_pin_enable, 0));
+	if (WARN_ON(!adap->monitor_pin_cnt))
+		return;
+	if (--adap->monitor_pin_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+	cec_adap_enable(adap);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -2146,6 +2217,7 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	struct cec_data *data;
 
 	mutex_lock(&adap->lock);
+	seq_printf(file, "enabled: %d\n", adap->is_enabled);
 	seq_printf(file, "configured: %d\n", adap->is_configured);
 	seq_printf(file, "configuring: %d\n", adap->is_configuring);
 	seq_printf(file, "phys_addr: %x.%x.%x.%x\n",
@@ -2160,6 +2232,9 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	if (adap->monitor_all_cnt)
 		seq_printf(file, "file handles in Monitor All mode: %u\n",
 			   adap->monitor_all_cnt);
+	if (adap->monitor_pin_cnt)
+		seq_printf(file, "file handles in Monitor Pin mode: %u\n",
+			   adap->monitor_pin_cnt);
 	if (adap->tx_timeouts) {
 		seq_printf(file, "transmit timeouts: %u\n",
 			   adap->tx_timeouts);
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index f922a2196b2b..8bdf58abdf96 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
 			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
 			   CEC_LOG_ADDRS_FL_CDC_ONLY;
 	mutex_lock(&adap->lock);
-	if (!adap->is_configuring &&
+	if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
 	    (!log_addrs.num_log_addrs || !adap->is_configured) &&
 	    !cec_is_busy(adap, fh)) {
 		err = __cec_s_log_addrs(adap, &log_addrs, block);
@@ -586,17 +586,6 @@ static int cec_open(struct inode *inode, struct file *filp)
 		return err;
 	}
 
-	mutex_lock(&devnode->lock);
-	if (list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd &&
-	    adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		err = adap->ops->adap_enable(adap, true);
-		if (err) {
-			mutex_unlock(&devnode->lock);
-			kfree(fh);
-			return err;
-		}
-	}
 	filp->private_data = fh;
 
 	/* Queue up initial state events */
@@ -606,7 +595,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
 	cec_queue_event_fh(fh, &ev, 0);
 #ifdef CONFIG_CEC_PIN
-	if (adap->pin && adap->pin->ops->read_hpd) {
+	if (adap->pin && adap->pin->ops->read_hpd &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_hpd(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_HPD_HIGH :
@@ -614,7 +604,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 			cec_queue_event_fh(fh, &ev, 0);
 		}
 	}
-	if (adap->pin && adap->pin->ops->read_5v) {
+	if (adap->pin && adap->pin->ops->read_5v &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_5v(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_5V_HIGH :
@@ -624,7 +615,10 @@ static int cec_open(struct inode *inode, struct file *filp)
 	}
 #endif
 
+	mutex_lock(&devnode->lock);
+	mutex_lock(&devnode->lock_fhs);
 	list_add(&fh->list, &devnode->fhs);
+	mutex_unlock(&devnode->lock_fhs);
 	mutex_unlock(&devnode->lock);
 
 	return 0;
@@ -654,11 +648,9 @@ static int cec_release(struct inode *inode, struct file *filp)
 	mutex_unlock(&adap->lock);
 
 	mutex_lock(&devnode->lock);
+	mutex_lock(&devnode->lock_fhs);
 	list_del(&fh->list);
-	if (cec_is_registered(adap) && list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd && adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		WARN_ON(adap->ops->adap_enable(adap, false));
-	}
+	mutex_unlock(&devnode->lock_fhs);
 	mutex_unlock(&devnode->lock);
 
 	/* Unhook pending transmits from this filehandle. */
@@ -672,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
 		list_del(&data->xfer_list);
 	}
 	mutex_unlock(&adap->lock);
+
+	mutex_lock(&fh->lock);
 	while (!list_empty(&fh->msgs)) {
 		struct cec_msg_entry *entry =
 			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
@@ -689,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
 			kfree(entry);
 		}
 	}
+	mutex_unlock(&fh->lock);
 	kfree(fh);
 
 	cec_put_device(devnode);
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index ece236291f35..0a3345e1a0f3 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -167,8 +167,10 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 		return;
 	}
 
+	mutex_lock(&devnode->lock_fhs);
 	list_for_each_entry(fh, &devnode->fhs, list)
 		wake_up_interruptible(&fh->wait);
+	mutex_unlock(&devnode->lock_fhs);
 
 	devnode->registered = false;
 	devnode->unregistered = true;
@@ -202,7 +204,7 @@ static ssize_t cec_error_inj_write(struct file *file,
 		line = strsep(&p, "\n");
 		if (!*line || *line == '#')
 			continue;
-		if (!adap->ops->error_inj_parse_line(adap, line)) {
+		if (!call_op(adap, error_inj_parse_line, line)) {
 			kfree(buf);
 			return -EINVAL;
 		}
@@ -215,7 +217,7 @@ static int cec_error_inj_show(struct seq_file *sf, void *unused)
 {
 	struct cec_adapter *adap = sf->private;
 
-	return adap->ops->error_inj_show(adap, sf);
+	return call_op(adap, error_inj_show, sf);
 }
 
 static int cec_error_inj_open(struct inode *inode, struct file *file)
@@ -272,6 +274,7 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
 
 	/* adap->devnode initialization */
 	INIT_LIST_HEAD(&adap->devnode.fhs);
+	mutex_init(&adap->devnode.lock_fhs);
 	mutex_init(&adap->devnode.lock);
 
 	adap->kthread = kthread_run(cec_thread_func, adap, "cec-%s", name);
diff --git a/drivers/media/cec/core/cec-pin-priv.h b/drivers/media/cec/core/cec-pin-priv.h
index f423db8855d9..5577c62e4131 100644
--- a/drivers/media/cec/core/cec-pin-priv.h
+++ b/drivers/media/cec/core/cec-pin-priv.h
@@ -12,6 +12,17 @@
 #include <linux/atomic.h>
 #include <media/cec-pin.h>
 
+#define call_pin_op(pin, op, arg...)					\
+	((pin && pin->ops->op && !pin->adap->devnode.unregistered) ?	\
+	 pin->ops->op(pin->adap, ## arg) : 0)
+
+#define call_void_pin_op(pin, op, arg...)				\
+	do {								\
+		if (pin && pin->ops->op &&				\
+		    !pin->adap->devnode.unregistered)			\
+			pin->ops->op(pin->adap, ## arg);		\
+	} while (0)
+
 enum cec_pin_state {
 	/* CEC is off */
 	CEC_ST_OFF,
diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
index f8452a1f9fc6..447fdada20e9 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -135,7 +135,7 @@ static void cec_pin_update(struct cec_pin *pin, bool v, bool force)
 
 static bool cec_pin_read(struct cec_pin *pin)
 {
-	bool v = pin->ops->read(pin->adap);
+	bool v = call_pin_op(pin, read);
 
 	cec_pin_update(pin, v, false);
 	return v;
@@ -143,13 +143,13 @@ static bool cec_pin_read(struct cec_pin *pin)
 
 static void cec_pin_low(struct cec_pin *pin)
 {
-	pin->ops->low(pin->adap);
+	call_void_pin_op(pin, low);
 	cec_pin_update(pin, false, false);
 }
 
 static bool cec_pin_high(struct cec_pin *pin)
 {
-	pin->ops->high(pin->adap);
+	call_void_pin_op(pin, high);
 	return cec_pin_read(pin);
 }
 
@@ -1086,7 +1086,7 @@ static int cec_pin_thread_func(void *_adap)
 				    CEC_PIN_IRQ_UNCHANGED)) {
 		case CEC_PIN_IRQ_DISABLE:
 			if (irq_enabled) {
-				pin->ops->disable_irq(adap);
+				call_void_pin_op(pin, disable_irq);
 				irq_enabled = false;
 			}
 			cec_pin_high(pin);
@@ -1097,7 +1097,7 @@ static int cec_pin_thread_func(void *_adap)
 		case CEC_PIN_IRQ_ENABLE:
 			if (irq_enabled)
 				break;
-			pin->enable_irq_failed = !pin->ops->enable_irq(adap);
+			pin->enable_irq_failed = !call_pin_op(pin, enable_irq);
 			if (pin->enable_irq_failed) {
 				cec_pin_to_idle(pin);
 				hrtimer_start(&pin->timer, ns_to_ktime(0),
@@ -1112,8 +1112,8 @@ static int cec_pin_thread_func(void *_adap)
 		if (kthread_should_stop())
 			break;
 	}
-	if (pin->ops->disable_irq && irq_enabled)
-		pin->ops->disable_irq(adap);
+	if (irq_enabled)
+		call_void_pin_op(pin, disable_irq);
 	hrtimer_cancel(&pin->timer);
 	cec_pin_read(pin);
 	cec_pin_to_idle(pin);
@@ -1208,7 +1208,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	seq_printf(file, "state: %s\n", states[pin->state].name);
 	seq_printf(file, "tx_bit: %d\n", pin->tx_bit);
 	seq_printf(file, "rx_bit: %d\n", pin->rx_bit);
-	seq_printf(file, "cec pin: %d\n", pin->ops->read(adap));
+	seq_printf(file, "cec pin: %d\n", call_pin_op(pin, read));
 	seq_printf(file, "cec pin events dropped: %u\n",
 		   pin->work_pin_events_dropped_cnt);
 	seq_printf(file, "irq failed: %d\n", pin->enable_irq_failed);
@@ -1261,8 +1261,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	pin->rx_data_bit_too_long_cnt = 0;
 	pin->rx_low_drive_cnt = 0;
 	pin->tx_low_drive_cnt = 0;
-	if (pin->ops->status)
-		pin->ops->status(adap, file);
+	call_void_pin_op(pin, status, file);
 }
 
 static int cec_pin_adap_monitor_all_enable(struct cec_adapter *adap,
@@ -1278,7 +1277,7 @@ static void cec_pin_adap_free(struct cec_adapter *adap)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->free)
+	if (pin && pin->ops->free)
 		pin->ops->free(adap);
 	adap->pin = NULL;
 	kfree(pin);
@@ -1288,7 +1287,7 @@ static int cec_pin_received(struct cec_adapter *adap, struct cec_msg *msg)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->received)
+	if (pin->ops->received && !adap->devnode.unregistered)
 		return pin->ops->received(adap, msg);
 	return -ENOMSG;
 }
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index 9bbd05053d42..b78df931aa74 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -17,6 +17,16 @@
 			pr_info("cec-%s: " fmt, adap->name, ## arg);	\
 	} while (0)
 
+#define call_op(adap, op, arg...)					\
+	((adap->ops->op && !adap->devnode.unregistered) ?		\
+	 adap->ops->op(adap, ## arg) : 0)
+
+#define call_void_op(adap, op, arg...)					\
+	do {								\
+		if (adap->ops->op && !adap->devnode.unregistered)	\
+			adap->ops->op(adap, ## arg);			\
+	} while (0)
+
 /* devnode to cec_adapter */
 #define to_cec_adapter(node) container_of(node, struct cec_adapter, devnode)
 
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 47fb22180d5b..d638cc88aa77 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -2213,6 +2213,11 @@ static int lgdt3306a_probe(struct i2c_client *client,
 	struct dvb_frontend *fe;
 	int ret;
 
+	if (!client->dev.platform_data) {
+		dev_err(&client->dev, "platform data is mandatory\n");
+		return -EINVAL;
+	}
+
 	config = kmemdup(client->dev.platform_data,
 			 sizeof(struct lgdt3306a_config), GFP_KERNEL);
 	if (config == NULL) {
diff --git a/drivers/media/dvb-frontends/mxl5xx.c b/drivers/media/dvb-frontends/mxl5xx.c
index 0b00a23436ed..aaf9a173596a 100644
--- a/drivers/media/dvb-frontends/mxl5xx.c
+++ b/drivers/media/dvb-frontends/mxl5xx.c
@@ -1390,57 +1390,57 @@ static int config_ts(struct mxl *state, enum MXL_HYDRA_DEMOD_ID_E demod_id,
 	u32 nco_count_min = 0;
 	u32 clk_type = 0;
 
-	struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 8, 1}, {0x90700010, 9, 1},
 		{0x90700010, 10, 1}, {0x90700010, 11, 1},
 		{0x90700010, 12, 1}, {0x90700010, 13, 1},
 		{0x90700010, 14, 1}, {0x90700010, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 16, 1}, {0x90700010, 17, 1},
 		{0x90700010, 18, 1}, {0x90700010, 19, 1},
 		{0x90700010, 20, 1}, {0x90700010, 21, 1},
 		{0x90700010, 22, 1}, {0x90700010, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 0, 1}, {0x90700014, 1, 1},
 		{0x90700014, 2, 1}, {0x90700014, 3, 1},
 		{0x90700014, 4, 1}, {0x90700014, 5, 1},
 		{0x90700014, 6, 1}, {0x90700014, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700018, 0, 3}, {0x90700018, 4, 3},
 		{0x90700018, 8, 3}, {0x90700018, 12, 3},
 		{0x90700018, 16, 3}, {0x90700018, 20, 3},
 		{0x90700018, 24, 3}, {0x90700018, 28, 3} };
-	struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 16, 1}, {0x9070000C, 17, 1},
 		{0x9070000C, 18, 1}, {0x9070000C, 19, 1},
 		{0x9070000C, 20, 1}, {0x9070000C, 21, 1},
 		{0x9070000C, 22, 1}, {0x9070000C, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 0, 1}, {0x90700010, 1, 1},
 		{0x90700010, 2, 1}, {0x90700010, 3, 1},
 		{0x90700010, 4, 1}, {0x90700010, 5, 1},
 		{0x90700010, 6, 1}, {0x90700010, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 0, 1}, {0x9070000C, 1, 1},
 		{0x9070000C, 2, 1}, {0x9070000C, 3, 1},
 		{0x9070000C, 4, 1}, {0x9070000C, 5, 1},
 		{0x9070000C, 6, 1}, {0x9070000C, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 24, 1}, {0x9070000C, 25, 1},
 		{0x9070000C, 26, 1}, {0x9070000C, 27, 1},
 		{0x9070000C, 28, 1}, {0x9070000C, 29, 1},
 		{0x9070000C, 30, 1}, {0x9070000C, 31, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 8, 1}, {0x90700014, 9, 1},
 		{0x90700014, 10, 1}, {0x90700014, 11, 1},
 		{0x90700014, 12, 1}, {0x90700014, 13, 1},
 		{0x90700014, 14, 1}, {0x90700014, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
 		{0x907001D4, 0, 1}, {0x907001D4, 1, 1},
 		{0x907001D4, 2, 1}, {0x907001D4, 3, 1},
 		{0x907001D4, 4, 1}, {0x907001D4, 5, 1},
 		{0x907001D4, 6, 1}, {0x907001D4, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700044, 16, 80}, {0x90700044, 16, 81},
 		{0x90700044, 16, 82}, {0x90700044, 16, 83},
 		{0x90700044, 16, 84}, {0x90700044, 16, 85},
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index f11382afe23b..f249199dc616 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -246,15 +246,14 @@ int __must_check media_devnode_register(struct media_device *mdev,
 	kobject_set_name(&devnode->cdev.kobj, "media%d", devnode->minor);
 
 	/* Part 3: Add the media and char device */
+	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 	ret = cdev_device_add(&devnode->cdev, &devnode->dev);
 	if (ret < 0) {
+		clear_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 		pr_err("%s: cdev_device_add failed\n", __func__);
 		goto cdev_add_error;
 	}
 
-	/* Part 4: Activate this minor. The char device can now be used. */
-	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
-
 	return 0;
 
 cdev_add_error:
diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index e1a8c611d01b..97cac9770802 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -1488,7 +1488,9 @@ static int init_channel(struct ngene_channel *chan)
 	}
 
 	if (dev->ci.en && (io & NGENE_IO_TSOUT)) {
-		dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		ret = dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		if (ret != 0)
+			goto err;
 		set_transfer(chan, 1);
 		chan->dev->channel[2].DataFormatFlags = DF_SWAP32;
 		set_transfer(&chan->dev->channel[2], 1);
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335..e3e6aa87fe08 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif
diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 2299d5cca8ff..6ded5a6181aa 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -502,17 +502,21 @@ static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 
 static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 {
-	/* use the alternate setting with the larges buffer */
-	int ret = usb_set_interface(fc_usb->udev, 0, 1);
+	struct usb_host_interface *alt;
+	int ret;
 
+	/* use the alternate setting with the largest buffer */
+	ret = usb_set_interface(fc_usb->udev, 0, 1);
 	if (ret) {
 		err("set interface failed.");
 		return ret;
 	}
 
-	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
+	alt = fc_usb->uintf->cur_altsetting;
+
+	if (alt->desc.bNumEndpoints < 2)
 		return -ENODEV;
-	if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[0].desc))
+	if (!usb_endpoint_is_isoc_in(&alt->endpoint[0].desc))
 		return -ENODEV;
 
 	switch (fc_usb->udev->speed) {
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 4cf540d1b250..2a5a90311e0c 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -99,7 +99,7 @@ void stk1160_buffer_done(struct stk1160 *dev)
 static inline
 void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 {
-	int linesdone, lineoff, lencopy;
+	int linesdone, lineoff, lencopy, offset;
 	int bytesperline = dev->width * 2;
 	struct stk1160_buffer *buf = dev->isoc_ctl.buf;
 	u8 *dst = buf->mem;
@@ -139,8 +139,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	 * Check if we have enough space left in the buffer.
 	 * In that case, we force loop exit after copy.
 	 */
-	if (lencopy > buf->bytesused - buf->length) {
-		lencopy = buf->bytesused - buf->length;
+	offset = dst - (u8 *)buf->mem;
+	if (offset > buf->length) {
+		dev_warn_ratelimited(dev->dev, "out of bounds offset\n");
+		return;
+	}
+	if (lencopy > buf->length - offset) {
+		lencopy = buf->length - offset;
 		remain = lencopy;
 	}
 
@@ -182,8 +187,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 		 * Check if we have enough space left in the buffer.
 		 * In that case, we force loop exit after copy.
 		 */
-		if (lencopy > buf->bytesused - buf->length) {
-			lencopy = buf->bytesused - buf->length;
+		offset = dst - (u8 *)buf->mem;
+		if (offset > buf->length) {
+			dev_warn_ratelimited(dev->dev, "offset out of bounds\n");
+			return;
+		}
+		if (lencopy > buf->length - offset) {
+			lencopy = buf->length - offset;
 			remain = lencopy;
 		}
 
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index a593ea0598b5..4c31aa0a941e 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1030,8 +1030,10 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
+	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
+		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
 		goto cleanup;
 	}
@@ -1051,6 +1053,7 @@ int __video_register_device(struct video_device *vdev,
 
 	/* Part 6: Activate this minor. The char device can now be used. */
 	set_bit(V4L2_FL_REGISTERED, &vdev->flags);
+	mutex_unlock(&videodev_lock);
 
 	return 0;
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b949a4468bf5..7ba1343ca5c1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -114,13 +114,12 @@ void mmc_retune_enable(struct mmc_host *host)
 
 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command.
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 681653d097ef..04c510b751b2 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -202,6 +202,26 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd);
 
+/**
+ * mmc_gpiod_set_cd_config - set config for card-detection GPIO
+ * @host: mmc host
+ * @config: Generic pinconf config (from pinconf_to_config_packed())
+ *
+ * This can be used by mmc host drivers to fixup a card-detection GPIO's config
+ * (e.g. set PIN_CONFIG_BIAS_PULL_UP) after acquiring the GPIO descriptor
+ * through mmc_gpiod_request_cd().
+ *
+ * Returns:
+ * 0 on success, or a negative errno value on error.
+ */
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	return gpiod_set_config(ctx->cd_gpio, config);
+}
+EXPORT_SYMBOL(mmc_gpiod_set_cd_config);
+
 bool mmc_can_gpio_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 2a28101777c6..ba1272db851f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -81,6 +81,7 @@ struct sdhci_acpi_host {
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
 	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
+	DMI_QUIRK_SD_CD_ACTIVE_HIGH				= BIT(2),
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -761,7 +762,20 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+/* Please keep this list sorted alphabetically */
 static const struct dmi_system_id sdhci_acpi_quirks[] = {
+	{
+		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{
 		/*
 		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
@@ -778,15 +792,23 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 	},
 	{
 		/*
-		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
-		 * reports the card being write-protected even though microSD
-		 * cards do not have a write-protect switch at all.
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13" Android version) this
+		 * has broken WP reporting and an inverted CD signal.
+		 * Note this has more or less the same BIOS as the Lenovo Yoga
+		 * Tablet 2 830F/L or 1050F/L (8" and 10" Android), but unlike
+		 * the 830 / 1050 models which share the same mainboard this
+		 * model has a different mainboard and the inverted CD and
+		 * broken WP are unique to this board.
 		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Full match so as to NOT match the 830/1050 BIOS */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21.X64.0005.R00.1504101516"),
 		},
-		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+		.driver_data = (void *)(DMI_QUIRK_SD_NO_WRITE_PROTECT |
+					DMI_QUIRK_SD_CD_ACTIVE_HIGH),
 	},
 	{
 		/*
@@ -799,6 +821,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
 	},
+	{
+		/*
+		 * The Toshiba WT10-A's microSD slot always reports the card being
+		 * write-protected.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA WT10-A"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
 
@@ -913,6 +946,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
 		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
 
+		if (quirks & DMI_QUIRK_SD_CD_ACTIVE_HIGH)
+			host->mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0);
 		if (err) {
 			if (err == -EPROBE_DEFER)
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index eb52e0c5a020..9d74ee989cb7 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -140,19 +140,26 @@ static const struct timing_data td[] = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	bool legacy_otapdly;
 	int otap_del_sel[ARRAY_SIZE(td)];
 	int itap_del_sel[ARRAY_SIZE(td)];
+	u32 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
 	int strb_sel;
 	u32 flags;
 	u32 quirks;
+	bool dll_enable;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
+struct window {
+	u8 start;
+	u8 end;
+	u8 length;
+};
+
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
@@ -232,11 +239,13 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 }
 
 static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
-				      u32 itapdly)
+				      u32 itapdly, u32 enable)
 {
 	/* Set ITAPCHGWIN before writing to ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
 			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   enable << ITAPDLYENA_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
 			   itapdly << ITAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
@@ -253,8 +262,8 @@ static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 
-	sdhci_am654_write_itapdly(sdhci_am654,
-				  sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -263,7 +272,6 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
-	u32 otap_del_ena;
 	u32 mask, val;
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
@@ -271,15 +279,10 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_set_clock(host, clock);
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
-
-	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
 	/* Write to STRBSEL for HS400 speed mode */
@@ -294,10 +297,21 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
+	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
-	else
+		sdhci_am654->dll_enable = true;
+
+		if (timing == MMC_TIMING_MMC_HS400) {
+			sdhci_am654->itap_del_ena[timing] = 0x1;
+			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
+		}
+
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+					  sdhci_am654->itap_del_ena[timing]);
+	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
+		sdhci_am654->dll_enable = false;
+	}
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
@@ -310,19 +324,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
+	/* Setup Input TAP delay */
+	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+	itap_del_sel = sdhci_am654->itap_del_sel[timing];
+
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) |
+	       (itap_del_sel << ITAPDLYSEL_SHIFT);
+
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
 
@@ -415,40 +439,105 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
+
+static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+			  *fail_window, u8 num_fails, bool circular_buffer)
+{
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	u8 first_fail_start = 0, last_fail_end = 0;
+	struct device *dev = mmc_dev(host->mmc);
+	struct window pass_window = {0, 0, 0};
+	int prev_fail_end = -1;
+	u8 i;
+
+	if (!num_fails)
+		return ITAPDLY_LAST_INDEX >> 1;
+
+	if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_err(dev, "No passing ITAPDLY, return 0\n");
+		return 0;
+	}
+
+	first_fail_start = fail_window->start;
+	last_fail_end = fail_window[num_fails - 1].end;
+
+	for (i = 0; i < num_fails; i++) {
+		start_fail = fail_window[i].start;
+		end_fail = fail_window[i].end;
+		pass_length = start_fail - (prev_fail_end + 1);
+
+		if (pass_length > pass_window.length) {
+			pass_window.start = prev_fail_end + 1;
+			pass_window.length = pass_length;
+		}
+		prev_fail_end = end_fail;
+	}
+
+	if (!circular_buffer)
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
+	else
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
+
+	if (pass_length > pass_window.length) {
+		pass_window.start = last_fail_end + 1;
+		pass_window.length = pass_length;
+	}
+
+	if (!circular_buffer)
+		itap = pass_window.start + (pass_window.length >> 1);
+	else
+		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
+}
+
 static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 					       u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
-	u32 itap;
+	unsigned char timing = host->mmc->ios.timing;
+	struct window fail_window[ITAPDLY_LENGTH];
+	u8 curr_pass, itap;
+	u8 fail_index = 0;
+	u8 prev_pass = 1;
+
+	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
+	sdhci_am654->itap_del_ena[timing] = 0x1;
+
+	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
+		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 
-	for (itap = 0; itap < ITAP_MAX; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap);
+		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
-		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
-		if (cur_val && !prev_val)
-			pass_window = itap;
+		if (!curr_pass && prev_pass)
+			fail_window[fail_index].start = itap;
+
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
 
-		if (!cur_val)
-			fail_len++;
+		if (curr_pass && !prev_pass)
+			fail_index++;
 
-		prev_val = cur_val;
+		prev_pass = curr_pass;
 	}
-	/*
-	 * Having determined the length of the failing window and start of
-	 * the passing window calculate the length of the passing window and
-	 * set the final value halfway through it considering the range as a
-	 * circular buffer
-	 */
-	pass_len = ITAP_MAX - fail_len;
-	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
-	sdhci_am654_write_itapdly(sdhci_am654, itap);
+
+	if (fail_window[fail_index].length != 0)
+		fail_index++;
+
+	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					  sdhci_am654->dll_enable);
+
+	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+
+	/* Save ITAPDLY */
+	sdhci_am654->itap_del_sel[timing] = itap;
 
 	return 0;
 }
@@ -579,32 +668,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 	int i;
 	int ret;
 
-	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
-				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
-	if (ret) {
-		/*
-		 * ti,otap-del-sel-legacy is mandatory, look for old binding
-		 * if not found.
-		 */
-		ret = device_property_read_u32(dev, "ti,otap-del-sel",
-					       &sdhci_am654->otap_del_sel[0]);
-		if (ret) {
-			dev_err(dev, "Couldn't find otap-del-sel\n");
-
-			return ret;
-		}
-
-		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
-		sdhci_am654->legacy_otapdly = true;
-
-		return 0;
-	}
-
 	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
 		if (ret) {
+			if (i == MMC_TIMING_LEGACY) {
+				dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
+				return ret;
+			}
 			dev_dbg(dev, "Couldn't find %s\n",
 				td[i].otap_binding);
 			/*
@@ -617,9 +689,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 				host->mmc->caps2 &= ~td[i].capability;
 		}
 
-		if (td[i].itap_binding)
-			device_property_read_u32(dev, td[i].itap_binding,
-						 &sdhci_am654->itap_del_sel[i]);
+		if (td[i].itap_binding) {
+			ret = device_property_read_u32(dev, td[i].itap_binding,
+						       &sdhci_am654->itap_del_sel[i]);
+			if (!ret)
+				sdhci_am654->itap_del_ena[i] = 0x1;
+		}
 	}
 
 	return 0;
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index a9f50c9af109..856b3d6eceb7 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -402,7 +402,7 @@ static int hynix_nand_rr_init(struct nand_chip *chip)
 	if (ret)
 		pr_warn("failed to initialize read-retry infrastructure");
 
-	return 0;
+	return ret;
 }
 
 static void hynix_nand_extract_oobsize(struct nand_chip *chip,
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 548d8095c0a7..b695f3f23328 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
 	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
 
 	if (port[IFLA_PORT_PROFILE]) {
+		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_NAME;
 		memcpy(pp->name, nla_data(port[IFLA_PORT_PROFILE]),
 			PORT_PROFILE_MAX);
 	}
 
 	if (port[IFLA_PORT_INSTANCE_UUID]) {
+		if (nla_len(port[IFLA_PORT_INSTANCE_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_INSTANCE;
 		memcpy(pp->instance_uuid,
 			nla_data(port[IFLA_PORT_INSTANCE_UUID]), PORT_UUID_MAX);
 	}
 
 	if (port[IFLA_PORT_HOST_UUID]) {
+		if (nla_len(port[IFLA_PORT_HOST_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_HOST;
 		memcpy(pp->host_uuid,
 			nla_data(port[IFLA_PORT_HOST_UUID]), PORT_UUID_MAX);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index c78587ddb32f..fa46854fd697 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1109,10 +1109,13 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
+	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
+
 	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
 
 	if (en)
@@ -1121,6 +1124,8 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	val = en ? val | mask : val & ~mask;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
+
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
@@ -1427,15 +1432,19 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	union gmac_rxdesc_3 word3;
 	struct page *page = NULL;
 	unsigned int page_offs;
+	unsigned long flags;
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
 	int frag_nr = 0;
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
 	/* Reset interrupt as all packages until here are taken into account */
 	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
 	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
+
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
 
@@ -1738,10 +1747,9 @@ static irqreturn_t gmac_irq(int irq, void *data)
 		gmac_update_hw_stats(netdev);
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
+		spin_lock(&geth->irq_lock);
 		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
-
-		spin_lock(&geth->irq_lock);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;
 		u64_stats_update_end(&port->ir_stats_syncp);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fe29769cb158..adb76db66031 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3443,6 +3443,14 @@ static int fec_enet_init(struct net_device *ndev)
 	return ret;
 }
 
+static void fec_enet_deinit(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	netif_napi_del(&fep->napi);
+	fec_enet_free_queue(ndev);
+}
+
 #ifdef CONFIG_OF
 static int fec_reset_phy(struct platform_device *pdev)
 {
@@ -3813,6 +3821,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -3874,6 +3883,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index c5ae67300590..780fbb3e1ed0 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -103,14 +103,13 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	u64 ns;
 	val = 0;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
-
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->pps_enable == enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		return 0;
+	}
+
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
 		 */
@@ -441,6 +440,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
+		fep->pps_channel = DEFAULT_PPS_CHANNEL;
+		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
 		ret = fec_ptp_enable_pps(fep, on);
 
 		return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 0ba43c93abb2..42dc76f85c62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1523,6 +1523,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5673a4113253..f1834853872d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3695,7 +3695,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_dropped = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 41bc31e3f935..03ede9425889 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1234,7 +1234,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1243,11 +1242,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 	for_each_hwfn(cdev, i) {
 		hwfn = &cdev->hwfns[i];
 
-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
+		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
+					 0, 0, cdev->pdev->bus->number,
+					 PCI_SLOT(cdev->pdev->devfn),
+					 hwfn->abs_pf_id);
 
-		hwfn->slowpath_wq = alloc_workqueue(name, 0, 0);
 		if (!hwfn->slowpath_wq) {
 			DP_NOTICE(hwfn, "Cannot create slowpath workqueue\n");
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 387539a8094b..95e9204ce827 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -175,8 +175,8 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		_swapw(readw((a) + (r)))
-#define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
+#define SMC_inw(a, r)		ioread16be((a) + (r))
+#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 58f142ee78a3..4d6a9f02c738 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -949,17 +949,6 @@ static irqreturn_t gem_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void gem_poll_controller(struct net_device *dev)
-{
-	struct gem *gp = netdev_priv(dev);
-
-	disable_irq(gp->pdev->irq);
-	gem_interrupt(gp->pdev->irq, dev);
-	enable_irq(gp->pdev->irq);
-}
-#endif
-
 static void gem_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gem *gp = netdev_priv(dev);
@@ -2836,9 +2825,6 @@ static const struct net_device_ops gem_netdev_ops = {
 	.ndo_change_mtu		= gem_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = gem_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller    = gem_poll_controller,
-#endif
 };
 
 static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index bfea28bd4502..d04b1450875b 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -440,7 +440,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-	err = ip_local_out(net, skb->sk, skb);
+	err = ip_local_out(net, NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
@@ -495,7 +495,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-	err = ip6_local_out(dev_net(dev), skb->sk, skb);
+	err = ip6_local_out(dev_net(dev), NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 4ea02116be18..895d4f5166f9 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1141,17 +1141,15 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			continue;
 		}
 
-		/* Clone SKB */
-		new_skb = skb_clone(skb, GFP_ATOMIC);
+		new_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 
 		if (!new_skb)
 			goto err;
 
-		new_skb->len = pkt_len;
+		skb_put(new_skb, pkt_len);
+		memcpy(new_skb->data, skb->data, pkt_len);
 		skb_pull(new_skb, AQ_RX_HW_PAD);
-		skb_set_tail_pointer(new_skb, new_skb->len);
 
-		new_skb->truesize = SKB_TRUESIZE(new_skb->len);
 		if (aqc111_data->rx_checksum)
 			aqc111_rx_checksum(new_skb, pkt_desc);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index be2761d0bcd9..4dd1a9fb4c8a 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1301,6 +1301,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 569be01700aa..30e5f6910e6f 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -845,7 +845,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev, int in_pm)
 static int smsc95xx_reset(struct usbnet *dev)
 {
 	struct smsc95xx_priv *pdata = dev->driver_priv;
-	u32 read_buf, write_buf, burst_cap;
+	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
 	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
@@ -987,10 +987,13 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	netif_dbg(dev, ifup, dev->net, "ID_REV = 0x%08x\n", read_buf);
 
+	ret = smsc95xx_read_reg(dev, LED_GPIO_CFG, &read_buf);
+	if (ret < 0)
+		return ret;
 	/* Configure GPIO pins as LED outputs */
-	write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
-		LED_GPIO_CFG_FDX_LED;
-	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
+	read_buf |= LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
+		    LED_GPIO_CFG_FDX_LED;
+	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, read_buf);
 	if (ret < 0)
 		return ret;
 
@@ -1801,9 +1804,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
 static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
 {
-	skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
+	u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
+
+	skb->csum = (__force __wsum)get_unaligned(csum_ptr);
 	skb->ip_summed = CHECKSUM_COMPLETE;
-	skb_trim(skb, skb->len - 2);
+	skb_trim(skb, skb->len - 2); /* remove csum */
 }
 
 static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
@@ -1861,25 +1866,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				if (dev->net->features & NETIF_F_RXCSUM)
 					smsc95xx_rx_csum_offload(skb);
 				skb_trim(skb, skb->len - 4); /* remove fcs */
-				skb->truesize = size + sizeof(struct sk_buff);
 
 				return 1;
 			}
 
-			ax_skb = skb_clone(skb, GFP_ATOMIC);
+			ax_skb = netdev_alloc_skb_ip_align(dev->net, size);
 			if (unlikely(!ax_skb)) {
 				netdev_warn(dev->net, "Error allocating skb\n");
 				return 0;
 			}
 
-			ax_skb->len = size;
-			ax_skb->data = packet;
-			skb_set_tail_pointer(ax_skb, size);
+			skb_put(ax_skb, size);
+			memcpy(ax_skb->data, packet, size);
 
 			if (dev->net->features & NETIF_F_RXCSUM)
 				smsc95xx_rx_csum_offload(ax_skb);
 			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
 
 			usbnet_skb_return(dev, ax_skb);
 		}
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 811c8751308c..3fac642bec77 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -418,19 +418,15 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			skb_pull(skb, 3);
 			skb->len = len;
 			skb_set_tail_pointer(skb, len);
-			skb->truesize = len + sizeof(struct sk_buff);
 			return 2;
 		}
 
-		/* skb_clone is used for address align */
-		sr_skb = skb_clone(skb, GFP_ATOMIC);
+		sr_skb = netdev_alloc_skb_ip_align(dev->net, len);
 		if (!sr_skb)
 			return 0;
 
-		sr_skb->len = len;
-		sr_skb->data = skb->data + 3;
-		skb_set_tail_pointer(sr_skb, len);
-		sr_skb->truesize = len + sizeof(struct sk_buff);
+		skb_put(sr_skb, len);
+		memcpy(sr_skb->data, skb->data + 3, len);
 		usbnet_skb_return(dev, sr_skb);
 
 		skb_pull(skb, len + SR_RX_OVERHEAD);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b173497a3e0c..3096769e718e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1778,10 +1778,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
-	/* Ignore packets from invalid src-address */
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-		return false;
-
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index efe38b2c1df7..71c2bf8817dc 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1590,6 +1590,20 @@ static int ar5523_probe(struct usb_interface *intf,
 	struct ar5523 *ar;
 	int error = -ENOMEM;
 
+	static const u8 bulk_ep_addr[] = {
+		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
+		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
+		AR5523_CMD_RX_PIPE | USB_DIR_IN,
+		AR5523_DATA_RX_PIPE | USB_DIR_IN,
+		0};
+
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&dev->dev,
+			"Could not find all expected endpoints\n");
+		error = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Load firmware if the device requires it.  This will return
 	 * -ENXIO on success and we'll get called back afer the usb
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 57ac80997319..d03a36c45f9f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -625,6 +625,9 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.max_spatial_stream = 4,
 		.fw = {
 			.dir = WCN3990_HW_1_0_FW_DIR,
+			.board = WCN3990_HW_1_0_BOARD_DATA_FILE,
+			.board_size = WCN3990_BOARD_DATA_SZ,
+			.board_ext_size = WCN3990_BOARD_EXT_DATA_SZ,
 		},
 		.sw_decrypt_mcast_mgmt = true,
 		.hw_ops = &wcn3990_ops,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 367539f2c370..f7912c72cba3 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -438,7 +438,7 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 	}
 out:
 	mutex_unlock(&ar->conf_mutex);
-	return count;
+	return ret ?: count;
 }
 
 static const struct file_operations fops_peer_debug_trigger = {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index d3ef83ad577d..c4df0e4e161b 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -132,6 +132,7 @@ enum qca9377_chip_id_rev {
 /* WCN3990 1.0 definitions */
 #define WCN3990_HW_1_0_DEV_VERSION	ATH10K_HW_WCN3990
 #define WCN3990_HW_1_0_FW_DIR		ATH10K_FW_DIR "/WCN3990/hw1.0"
+#define WCN3990_HW_1_0_BOARD_DATA_FILE "board.bin"
 
 #define ATH10K_FW_FILE_BASE		"firmware"
 #define ATH10K_FW_API_MAX		6
diff --git a/drivers/net/wireless/ath/ath10k/targaddrs.h b/drivers/net/wireless/ath/ath10k/targaddrs.h
index ec556bb88d65..ba37e6c7ced0 100644
--- a/drivers/net/wireless/ath/ath10k/targaddrs.h
+++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
@@ -491,4 +491,7 @@ struct host_interest {
 #define QCA4019_BOARD_DATA_SZ	  12064
 #define QCA4019_BOARD_EXT_DATA_SZ 0
 
+#define WCN3990_BOARD_DATA_SZ	  26328
+#define WCN3990_BOARD_EXT_DATA_SZ 0
+
 #endif /* __TARGADDRS_H__ */
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 85fe855ece09..9cfd35dc87ba 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1762,12 +1762,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
-	unsigned long time_left;
+	unsigned long time_left, i;
 
 	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
+	if (!time_left) {
+		/* Sometimes the PCI HIF doesn't receive interrupt
+		 * for the service ready message even if the buffer
+		 * was completed. PCIe sniffer shows that it's
+		 * because the corresponding CE ring doesn't fires
+		 * it. Workaround here by polling CE rings once.
+		 */
+		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
+
+		for (i = 0; i < CE_COUNT; i++)
+			ath10k_hif_send_complete_check(ar, i, 1);
+
+		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
+							WMI_SERVICE_READY_TIMEOUT_HZ);
+		if (!time_left) {
+			ath10k_warn(ar, "polling timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		ath10k_warn(ar, "service ready completion received, continuing normally\n");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index e4eb666c6eea..a5265997b576 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -1069,6 +1069,38 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 			ar->usb_ep_cmd_is_bulk = true;
 	}
 
+	/* Verify that all expected endpoints are present */
+	if (ar->usb_ep_cmd_is_bulk) {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	} else {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	}
+
+	if (err) {
+		carl9170_free(ar);
+		return err;
+	}
+
 	usb_set_intfdata(intf, ar);
 	SET_IEEE80211_DEV(ar->hw, &intf->dev);
 
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index dc91ac8cbd48..dd72e9f8b407 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2714,7 +2714,7 @@ __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
 		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_MULTICAST);
 		cmd->numaddr = cpu_to_le16(mc_count);
 		netdev_hw_addr_list_for_each(ha, mc_list) {
-			memcpy(cmd->addr[i], ha->addr, ETH_ALEN);
+			memcpy(cmd->addr[i++], ha->addr, ETH_ALEN);
 		}
 	}
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9efc15e69ae8..5b27c22e7e58 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -28,6 +28,7 @@
 #include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
+#include <linux/bitfield.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
@@ -1389,13 +1390,13 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	u8 cck[RTL8723A_MAX_RF_PATHS], ofdm[RTL8723A_MAX_RF_PATHS];
 	u8 ofdmbase[RTL8723A_MAX_RF_PATHS], mcsbase[RTL8723A_MAX_RF_PATHS];
 	u32 val32, ofdm_a, ofdm_b, mcs_a, mcs_b;
-	u8 val8;
+	u8 val8, base;
 	int group, i;
 
 	group = rtl8xxxu_gen1_channel_to_group(channel);
 
-	cck[0] = priv->cck_tx_power_index_A[group] - 1;
-	cck[1] = priv->cck_tx_power_index_B[group] - 1;
+	cck[0] = priv->cck_tx_power_index_A[group];
+	cck[1] = priv->cck_tx_power_index_B[group];
 
 	if (priv->hi_pa) {
 		if (cck[0] > 0x20)
@@ -1406,10 +1407,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
 	ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
-	if (ofdm[0])
-		ofdm[0] -= 1;
-	if (ofdm[1])
-		ofdm[1] -= 1;
 
 	ofdmbase[0] = ofdm[0] +	priv->ofdm_tx_power_index_diff[group].a;
 	ofdmbase[1] = ofdm[1] +	priv->ofdm_tx_power_index_diff[group].b;
@@ -1498,20 +1495,19 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
 			 mcs_a + power_base->reg_0e1c);
+	val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
-		else
-			val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XC_TX_IQ_IMBALANCE + i, val8);
 	}
+
 	rtl8xxxu_write32(priv, REG_TX_AGC_B_MCS15_MCS12,
 			 mcs_b + power_base->reg_0868);
+	val8 = u32_get_bits(mcs_b + power_base->reg_0868, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[1] > 8) ? (mcsbase[1] - 8) : 0;
-		else
-			val8 = (mcsbase[1] > 6) ? (mcsbase[1] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XD_TX_IQ_IMBALANCE + i, val8);
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 8944712274b5..93cba14f4401 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -35,7 +35,7 @@ static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
 
 static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 				       struct rtl_stats *pstats,
-				       struct rx_desc_92d *pdesc,
+				       __le32 *pdesc,
 				       struct rx_fwinfo_92d *p_drvinfo,
 				       bool packet_match_bssid,
 				       bool packet_toself,
@@ -49,8 +49,10 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 	u8 i, max_spatial_stream;
 	u32 rssi, total_rssi = 0;
 	bool is_cck_rate;
+	u8 rxmcs;
 
-	is_cck_rate = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
+	rxmcs = get_rx_desc_rxmcs(pdesc);
+	is_cck_rate = rxmcs <= DESC_RATE11M;
 	pstats->packet_matchbssid = packet_match_bssid;
 	pstats->packet_toself = packet_toself;
 	pstats->packet_beacon = packet_beacon;
@@ -158,8 +160,8 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 		pstats->rx_pwdb_all = pwdb_all;
 		pstats->rxpower = rx_pwr_all;
 		pstats->recvsignalpower = rx_pwr_all;
-		if (pdesc->rxht && pdesc->rxmcs >= DESC_RATEMCS8 &&
-		    pdesc->rxmcs <= DESC_RATEMCS15)
+		if (get_rx_desc_rxht(pdesc) && rxmcs >= DESC_RATEMCS8 &&
+		    rxmcs <= DESC_RATEMCS15)
 			max_spatial_stream = 2;
 		else
 			max_spatial_stream = 1;
@@ -365,7 +367,7 @@ static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
 static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					       struct sk_buff *skb,
 					       struct rtl_stats *pstats,
-					       struct rx_desc_92d *pdesc,
+					       __le32 *pdesc,
 					       struct rx_fwinfo_92d *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -414,7 +416,8 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	stats->icv = (u16)get_rx_desc_icv(pdesc);
 	stats->crc = (u16)get_rx_desc_crc32(pdesc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(pdesc) &&
+			   get_rx_desc_enc_type(pdesc) != RX_DESC_ENC_NONE;
 	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
 	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
 	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
@@ -427,8 +430,6 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	rx_status->band = hw->conf.chandef.chan->band;
 	if (get_rx_desc_crc32(pdesc))
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!get_rx_desc_swdec(pdesc))
-		rx_status->flag |= RX_FLAG_DECRYPTED;
 	if (get_rx_desc_bw(pdesc))
 		rx_status->bw = RATE_INFO_BW_40;
 	if (get_rx_desc_rxht(pdesc))
@@ -442,9 +443,7 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
 						     stats->rx_bufshift);
-		_rtl92de_translate_rx_signal_stuff(hw,
-						   skb, stats,
-						   (struct rx_desc_92d *)pdesc,
+		_rtl92de_translate_rx_signal_stuff(hw, skb, stats, pdesc,
 						   p_drvinfo);
 	}
 	/*rx_status->qual = stats->signal; */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index d01578875cd5..eb3f768140b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -14,6 +14,15 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH				4
 
+enum rtl92d_rx_desc_enc {
+	RX_DESC_ENC_NONE	= 0,
+	RX_DESC_ENC_WEP40	= 1,
+	RX_DESC_ENC_TKIP_WO_MIC	= 2,
+	RX_DESC_ENC_TKIP_MIC	= 3,
+	RX_DESC_ENC_AES		= 4,
+	RX_DESC_ENC_WEP104	= 5,
+};
+
 /* macros to read/write various fields in RX or TX descriptors */
 
 static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
@@ -246,6 +255,11 @@ static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
 	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
+static inline u32 get_rx_desc_enc_type(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(22, 20));
+}
+
 static inline u32 get_rx_desc_shift(__le32 *__pdesc)
 {
 	return le32_get_bits(*__pdesc, GENMASK(25, 24));
@@ -380,10 +394,17 @@ struct rx_fwinfo_92d {
 	u8 csi_target[2];
 	u8 sigevm;
 	u8 max_ex_pwr;
+#ifdef __LITTLE_ENDIAN
 	u8 ex_intf_flag:1;
 	u8 sgi_en:1;
 	u8 rxsc:2;
 	u8 reserve:4;
+#else
+	u8 reserve:4;
+	u8 rxsc:2;
+	u8 sgi_en:1;
+	u8 ex_intf_flag:1;
+#endif
 } __packed;
 
 struct tx_desc_92d {
@@ -488,64 +509,6 @@ struct tx_desc_92d {
 	u32 reserve_pass_pcie_mm_limit[4];
 } __packed;
 
-struct rx_desc_92d {
-	u32 length:14;
-	u32 crc32:1;
-	u32 icverror:1;
-	u32 drv_infosize:4;
-	u32 security:3;
-	u32 qos:1;
-	u32 shift:2;
-	u32 phystatus:1;
-	u32 swdec:1;
-	u32 lastseg:1;
-	u32 firstseg:1;
-	u32 eor:1;
-	u32 own:1;
-
-	u32 macid:5;
-	u32 tid:4;
-	u32 hwrsvd:5;
-	u32 paggr:1;
-	u32 faggr:1;
-	u32 a1_fit:4;
-	u32 a2_fit:4;
-	u32 pam:1;
-	u32 pwr:1;
-	u32 moredata:1;
-	u32 morefrag:1;
-	u32 type:2;
-	u32 mc:1;
-	u32 bc:1;
-
-	u32 seq:12;
-	u32 frag:4;
-	u32 nextpktlen:14;
-	u32 nextind:1;
-	u32 rsvd:1;
-
-	u32 rxmcs:6;
-	u32 rxht:1;
-	u32 amsdu:1;
-	u32 splcp:1;
-	u32 bandwidth:1;
-	u32 htc:1;
-	u32 tcpchk_rpt:1;
-	u32 ipcchk_rpt:1;
-	u32 tcpchk_valid:1;
-	u32 hwpcerr:1;
-	u32 hwpcind:1;
-	u32 iv0:16;
-
-	u32 iv1;
-
-	u32 tsfl;
-
-	u32 bufferaddress;
-	u32 bufferaddress64;
-
-} __packed;
-
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_hdr *hdr, u8 *pdesc,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 379d6818a063..9f59f93b70e2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -168,7 +168,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9aed5cc71096..f2d11fc04752 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -532,10 +532,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (strtobool(page, &enable))
 		return -EINVAL;
 
+	/*
+	 * take a global nvmet_config_sem because the disable routine has a
+	 * window where it releases the subsys-lock, giving a chance to
+	 * a parallel enable to concurrently execute causing the disable to
+	 * have a misaccounting of the ns percpu_ref.
+	 */
+	down_write(&nvmet_config_sem);
 	if (enable)
 		ret = nvmet_ns_enable(ns);
 	else
 		nvmet_ns_disable(ns);
+	up_write(&nvmet_config_sem);
 
 	return ret ? ret : count;
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 87734e4c3c20..35210007602c 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -32,10 +32,10 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	int status = 0;
 
 	/*
-	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * Per PCI Firmware r3.3, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
+	 * optional. Return success if it's not implemented.
 	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
 		return 0;
 
@@ -46,12 +46,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	argv4.package.count = 1;
 	argv4.package.elements = &req;
 
-	/*
-	 * Per Downstream Port Containment Related Enhancements ECN to PCI
-	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
-	 * optional.  Return success if it's not implemented.
-	 */
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 				EDR_PORT_DPC_ENABLE_DSM, &argv4);
 	if (!obj)
 		return 0;
@@ -85,8 +80,9 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 	u16 port;
 
 	/*
-	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * If EDR_PORT_LOCATE_DSM is not implemented under the target of
+	 * EDR, the target is the port that experienced the containment
+	 * event (PCI Firmware r3.3, sec 4.6.13).
 	 */
 	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
 			    1ULL << EDR_PORT_LOCATE_DSM))
@@ -103,6 +99,16 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 		return NULL;
 	}
 
+	/*
+	 * Bit 31 represents the success/failure of the operation. If bit
+	 * 31 is set, the operation failed.
+	 */
+	if (obj->integer.value & BIT(31)) {
+		ACPI_FREE(obj);
+		pci_err(pdev, "Locate Port _DSM failed\n");
+		return NULL;
+	}
+
 	/*
 	 * Firmware returns DPC port BDF details in following format:
 	 *	15:8 = bus
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index 85c0b9000963..fc08f6f61655 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -234,14 +234,11 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.suspend_reg = BD71828_REG_BUCK1_SUSP_VOLT,
 			.suspend_mask = BD71828_MASK_BUCK1267_VOLT,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
-			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
 			/*
 			 * LPSR voltage is same as SUSPEND voltage. Allow
-			 * setting it so that regulator can be set enabled at
-			 * LPSR state
+			 * only enabling/disabling regulator for LPSR state
 			 */
-			.lpsr_reg = BD71828_REG_BUCK1_SUSP_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK1267_VOLT,
+			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
 		},
 		.reg_inits = buck1_inits,
 		.reg_init_amnt = ARRAY_SIZE(buck1_inits),
@@ -312,13 +309,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK3_VOLT,
-			.idle_reg = BD71828_REG_BUCK3_VOLT,
-			.suspend_reg = BD71828_REG_BUCK3_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK3_VOLT,
 			.run_mask = BD71828_MASK_BUCK3_VOLT,
-			.idle_mask = BD71828_MASK_BUCK3_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK3_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK3_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -353,13 +344,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK4_VOLT,
-			.idle_reg = BD71828_REG_BUCK4_VOLT,
-			.suspend_reg = BD71828_REG_BUCK4_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK4_VOLT,
 			.run_mask = BD71828_MASK_BUCK4_VOLT,
-			.idle_mask = BD71828_MASK_BUCK4_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK4_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK4_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -394,13 +379,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK5_VOLT,
-			.idle_reg = BD71828_REG_BUCK5_VOLT,
-			.suspend_reg = BD71828_REG_BUCK5_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK5_VOLT,
 			.run_mask = BD71828_MASK_BUCK5_VOLT,
-			.idle_mask = BD71828_MASK_BUCK5_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK5_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK5_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -509,13 +488,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO1_VOLT,
-			.idle_reg = BD71828_REG_LDO1_VOLT,
-			.suspend_reg = BD71828_REG_LDO1_VOLT,
-			.lpsr_reg = BD71828_REG_LDO1_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -549,13 +522,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO2_VOLT,
-			.idle_reg = BD71828_REG_LDO2_VOLT,
-			.suspend_reg = BD71828_REG_LDO2_VOLT,
-			.lpsr_reg = BD71828_REG_LDO2_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -589,13 +556,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO3_VOLT,
-			.idle_reg = BD71828_REG_LDO3_VOLT,
-			.suspend_reg = BD71828_REG_LDO3_VOLT,
-			.lpsr_reg = BD71828_REG_LDO3_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -630,13 +591,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO4_VOLT,
-			.idle_reg = BD71828_REG_LDO4_VOLT,
-			.suspend_reg = BD71828_REG_LDO4_VOLT,
-			.lpsr_reg = BD71828_REG_LDO4_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -671,13 +626,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO5_VOLT,
-			.idle_reg = BD71828_REG_LDO5_VOLT,
-			.suspend_reg = BD71828_REG_LDO5_VOLT,
-			.lpsr_reg = BD71828_REG_LDO5_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -736,9 +685,6 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.suspend_reg = BD71828_REG_LDO7_VOLT,
 			.lpsr_reg = BD71828_REG_LDO7_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 6d5ae25d08d1..e2a28788d8a2 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -86,6 +86,7 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_ipq4019_of_match);
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 4803139bce14..4716798b1368 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -50,7 +50,7 @@ DECLARE_EVENT_CLASS(s390_class_schib,
 		__entry->devno = schib->pmcw.dev;
 		__entry->schib = *schib;
 		__entry->pmcw_ena = schib->pmcw.ena;
-		__entry->pmcw_st = schib->pmcw.ena;
+		__entry->pmcw_st = schib->pmcw.st;
 		__entry->pmcw_dnv = schib->pmcw.dnv;
 		__entry->pmcw_dev = schib->pmcw.dev;
 		__entry->pmcw_lpm = schib->pmcw.lpm;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index c00a288a4eca..13e56a23e41e 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -859,7 +859,7 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
  */
 static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 {
-	int a, i, z;
+	unsigned long a, i, z;
 	char *np, sign;
 
 	/* bits needs to be a multiple of 8 */
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index fd1b378a263a..d3c7d4423c51 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -250,7 +250,7 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -317,7 +317,7 @@ bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a44a098dbb9c..4e7ec83c07cf 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5834,7 +5834,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 8444a4287ac1..8681e0cdfa5e 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -256,8 +256,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id, void *rsp)
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..96174353e389 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3d56f971cdc4..8d54f6099802 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4644,7 +4644,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 	} else {
@@ -4652,14 +4652,14 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES) {
-			strlcpy(ha->model_number,
+			strscpy(ha->model_number,
 				qla2x00_model_name[index * 2],
 				sizeof(ha->model_number));
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 		} else {
-			strlcpy(ha->model_number, def,
+			strscpy(ha->model_number, def,
 				sizeof(ha->model_number));
 		}
 	}
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 7178646ee0f0..cc8994a7c994 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -691,7 +691,7 @@ qlafx00_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 	struct qla_hw_data *ha = vha->hw;
 
 	if (pci_is_pcie(ha->pdev))
-		strlcpy(str, "PCIe iSA", str_len);
+		strscpy(str, "PCIe iSA", str_len);
 	return str;
 }
 
@@ -1849,21 +1849,21 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 			phost_info = &preg_hsi->hsi;
 			memset(preg_hsi, 0, sizeof(struct register_host_info));
 			phost_info->os_type = OS_TYPE_LINUX;
-			strlcpy(phost_info->sysname, p_sysid->sysname,
+			strscpy(phost_info->sysname, p_sysid->sysname,
 				sizeof(phost_info->sysname));
-			strlcpy(phost_info->nodename, p_sysid->nodename,
+			strscpy(phost_info->nodename, p_sysid->nodename,
 				sizeof(phost_info->nodename));
 			if (!strcmp(phost_info->nodename, "(none)"))
 				ha->mr.host_info_resend = true;
-			strlcpy(phost_info->release, p_sysid->release,
+			strscpy(phost_info->release, p_sysid->release,
 				sizeof(phost_info->release));
-			strlcpy(phost_info->version, p_sysid->version,
+			strscpy(phost_info->version, p_sysid->version,
 				sizeof(phost_info->version));
-			strlcpy(phost_info->machine, p_sysid->machine,
+			strscpy(phost_info->machine, p_sysid->machine,
 				sizeof(phost_info->machine));
-			strlcpy(phost_info->domainname, p_sysid->domainname,
+			strscpy(phost_info->domainname, p_sysid->domainname,
 				sizeof(phost_info->domainname));
-			strlcpy(phost_info->hostdriver, QLA2XXX_VERSION,
+			strscpy(phost_info->hostdriver, QLA2XXX_VERSION,
 				sizeof(phost_info->hostdriver));
 			preg_hsi->utc = (uint64_t)ktime_get_real_seconds();
 			ql_dbg(ql_dbg_init, vha, 0x0149,
@@ -1909,9 +1909,9 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	if (fx_type == FXDISC_GET_CONFIG_INFO) {
 		struct config_info_data *pinfo =
 		    (struct config_info_data *) fdisc->u.fxiocb.rsp_addr;
-		strlcpy(vha->hw->model_number, pinfo->model_num,
+		strscpy(vha->hw->model_number, pinfo->model_num,
 			ARRAY_SIZE(vha->hw->model_number));
-		strlcpy(vha->hw->model_desc, pinfo->model_description,
+		strscpy(vha->hw->model_desc, pinfo->model_description,
 			ARRAY_SIZE(vha->hw->model_desc));
 		memcpy(&vha->hw->mr.symbolic_name, pinfo->symbolic_name,
 		    sizeof(vha->hw->mr.symbolic_name));
diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index da065a259f6e..408ba52671de 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -135,7 +135,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 	 * Make sure the register was updated,
 	 * UniPro layer will not work with an incorrect value.
 	 */
-	mb();
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
 
 	return 0;
 }
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 08331ecbe91f..2c3972d9ba52 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -242,8 +242,9 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
-	/* make sure above configuration is applied before we return */
-	mb();
+
+	if (host->hw_ver.major >= 0x05)
+		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 }
 
 /*
@@ -352,7 +353,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
@@ -449,7 +450,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 * make sure above write gets applied before we return from
 		 * this function.
 		 */
-		mb();
+		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
 	}
 
 	if (ufs_qcom_cap_qunipro(host))
@@ -515,9 +516,9 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		mb();
 	}
 
-	if (update_link_startup_timer) {
+	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
 		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
-			      REG_UFS_PA_LINK_STARTUP_TIMER);
+			      REG_UFS_CFG0);
 		/*
 		 * make sure that this configuration is applied before
 		 * we return
@@ -578,6 +579,17 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 	return err;
 }
 
+static void ufs_qcom_device_reset_ctrl(struct ufs_hba *hba, bool asserted)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	/* reset gpio is optional */
+	if (!host->device_reset)
+		return;
+
+	gpiod_set_value_cansleep(host->device_reset, asserted);
+}
+
 static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -592,6 +604,9 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ufs_qcom_disable_lane_clks(host);
 		phy_power_off(phy);
 
+		/* reset the connected UFS device during power down */
+		ufs_qcom_device_reset_ctrl(hba, true);
+
 	} else if (!ufs_qcom_is_link_active(hba)) {
 		ufs_qcom_disable_lane_clks(host);
 	}
@@ -1441,10 +1456,10 @@ static int ufs_qcom_device_reset(struct ufs_hba *hba)
 	 * The UFS device shall detect reset pulses of 1us, sleep for 10us to
 	 * be on the safe side.
 	 */
-	gpiod_set_value_cansleep(host->device_reset, 1);
+	ufs_qcom_device_reset_ctrl(hba, true);
 	usleep_range(10, 15);
 
-	gpiod_set_value_cansleep(host->device_reset, 0);
+	ufs_qcom_device_reset_ctrl(hba, false);
 	usleep_range(10, 15);
 
 	return 0;
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index 3f4922743b3e..742f752d01d6 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -46,8 +46,10 @@ enum {
 	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
 	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
 	REG_UFS_PA_ERR_CODE                 = 0xCC,
-	REG_UFS_RETRY_TIMER_REG             = 0xD0,
-	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
+	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
+	REG_UFS_PARAM0                      = 0xD0,
+	/* On older UFS revisions, this register is called "REG_UFS_PA_LINK_STARTUP_TIMER" */
+	REG_UFS_CFG0                        = 0xD8,
 	REG_UFS_CFG1                        = 0xDC,
 	REG_UFS_CFG2                        = 0xE0,
 	REG_UFS_HW_VERSION                  = 0xE4,
@@ -85,6 +87,9 @@ enum {
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
+/* bit definitions for REG_UFS_CFG0 register */
+#define QUNIPRO_G4_SEL		BIT(5)
+
 /* bit definitions for REG_UFS_CFG1 register */
 #define QUNIPRO_SEL		0x1
 #define UTP_DBG_RAMS_EN		0x20000
@@ -156,10 +161,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
@@ -168,10 +173,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure de-assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 /* Host controller hardware version: major.minor.step */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a432aebd14be..0b0230b46f28 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3819,7 +3819,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		 * Make sure UIC command completion interrupt is disabled before
 		 * issuing UIC command.
 		 */
-		wmb();
+		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 		reenable_intr = true;
 	}
 	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
@@ -9193,7 +9193,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 * Make sure that UFS interrupts are disabled and any pending interrupt
 	 * status is cleared before registering UFS interrupt handler.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
 	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 505651b0d715..c0b2f9397ea8 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -13,7 +13,8 @@
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
-#define CMDQ_JUMP_RELATIVE	1
+#define CMDQ_JUMP_RELATIVE	0
+#define CMDQ_JUMP_ABSOLUTE	1
 
 struct cmdq_instruction {
 	union {
@@ -414,7 +415,7 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
-	inst.offset = CMDQ_JUMP_RELATIVE;
+	inst.offset = CMDQ_JUMP_ABSOLUTE;
 	inst.value = addr >>
 		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
 	return cmdq_pkt_append_command(pkt, inst);
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 18e7d158fcca..d3e9cd3faadf 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1698,7 +1698,7 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 9ec37cf10c01..f97b822cca19 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -931,7 +931,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
-		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
+		dev_vdbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
 			 sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 857a1399850c..e84494eed1c1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -970,6 +970,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
 			continue;
@@ -993,6 +994,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_msg_mapped = true;
 
diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..c7383c6c6094 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -468,6 +468,7 @@ static const struct of_device_id arche_apb_ctrl_of_match[] = {
 	{ .compatible = "usbffff,2", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arche_apb_ctrl_of_match);
 
 static struct platform_driver arche_apb_ctrl_device_driver = {
 	.probe		= arche_apb_ctrl_probe,
diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index eebf0deb39f5..02a700f720e6 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -622,14 +622,7 @@ static const struct of_device_id arche_platform_of_match[] = {
 	{ .compatible = "google,arche-platform", },
 	{ },
 };
-
-static const struct of_device_id arche_combined_id[] = {
-	/* Use PID/VID of SVC device */
-	{ .compatible = "google,arche-platform", },
-	{ .compatible = "usbffff,2", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, arche_combined_id);
+MODULE_DEVICE_TABLE(of, arche_platform_of_match);
 
 static struct platform_driver arche_platform_device_driver = {
 	.probe		= arche_platform_probe,
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index e59bb27236b9..7352d7deb8ba 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -147,6 +147,9 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
 		channel = get_channel_from_mode(channel->light,
 						GB_CHANNEL_MODE_TORCH);
 
+	if (!channel)
+		return -EINVAL;
+
 	/* For not flash we need to convert brightness to intensity */
 	intensity = channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);
@@ -550,7 +553,10 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 	}
 
 	channel_flash = get_channel_from_mode(light, GB_CHANNEL_MODE_FLASH);
-	WARN_ON(!channel_flash);
+	if (!channel_flash) {
+		dev_err(dev, "failed to get flash channel from mode\n");
+		return -EINVAL;
+	}
 
 	fled = &channel_flash->fled;
 
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index 54a18921fbd1..cb0354520360 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5477,6 +5477,7 @@ static int load_video_binaries(struct ia_css_pipe *pipe)
 		mycs->yuv_scaler_binary = kzalloc(cas_scaler_descr.num_stage *
 						  sizeof(struct ia_css_binary), GFP_KERNEL);
 		if (!mycs->yuv_scaler_binary) {
+			mycs->num_yuv_scaler = 0;
 			err = -ENOMEM;
 			return err;
 		}
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c20f69a4c5e9..0a367fa23c27 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2082,8 +2082,12 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 		break;
 	case GSM_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len)
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			gsm->state = GSM_FCS;
+		}
 		break;
 	case GSM_FCS:		/* FCS follows the packet */
 		gsm->received_fcs = c;
@@ -2176,7 +2180,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		gsm->state = GSM_DATA;
 		break;
 	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
 			gsm->state = GSM_OVERRUN;
 			gsm->bad_size++;
 		} else
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 371569a0fd00..17b6f4a872d6 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -45,6 +45,9 @@
 #include <linux/freezer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/serial_max3100.h>
 
@@ -191,7 +194,7 @@ static void max3100_timeout(struct timer_list *t)
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
-	u16 etx, erx;
+	__be16 etx, erx;
 	int status;
 	struct spi_transfer tran = {
 		.tx_buf = &etx,
@@ -213,7 +216,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 	return 0;
 }
 
-static int max3100_handlerx(struct max3100_port *s, u16 rx)
+static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 {
 	unsigned int ch, flg, status = 0;
 	int ret = 0, cts;
@@ -253,6 +256,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	return ret;
 }
 
+static int max3100_handlerx(struct max3100_port *s, u16 rx)
+{
+	unsigned long flags;
+	int ret;
+
+	uart_port_lock_irqsave(&s->port, &flags);
+	ret = max3100_handlerx_unlocked(s, rx);
+	uart_port_unlock_irqrestore(&s->port, flags);
+	return ret;
+}
+
 static void max3100_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
@@ -743,13 +757,14 @@ static int max3100_probe(struct spi_device *spi)
 	mutex_lock(&max3100s_lock);
 
 	if (!uart_driver_registered) {
-		uart_driver_registered = 1;
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
 			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
 			return retval;
 		}
+
+		uart_driver_registered = 1;
 	}
 
 	for (i = 0; i < MAX_MAX3100; i++)
@@ -835,6 +850,7 @@ static int max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 	return 0;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 29f05db0d49b..d751f8ce5cf6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -25,7 +26,6 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/units.h>
-#include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a7c28543c6f7..71cf9a7329f9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1257,9 +1257,14 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 static void sci_dma_rx_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx_saved;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	s->chan_rx_saved = NULL;
 	sci_dma_rx_chan_invalidate(s);
+	uart_port_unlock_irqrestore(port, flags);
+
 	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 6c8b8f5b7e0f..a387ff2c8b73 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -611,6 +611,8 @@ void g_audio_cleanup(struct g_audio *g_audio)
 		return;
 
 	uac = g_audio->uac;
+	g_audio->uac = NULL;
+
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index dd5958463097..9ad3e5157869 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2013,8 +2013,8 @@ config FB_COBALT
 	depends on FB && MIPS_COBALT
 
 config FB_SH7760
-	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 94ebd8af50cf..224d7c8146a9 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2271,7 +2271,10 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (info->var.xres_virtual > 0x1000)
 		info->var.xres_virtual = 0x1000;
 #endif
-	savagefb_check_var(&info->var, info);
+	err = savagefb_check_var(&info->var, info);
+	if (err)
+		goto failed;
+
 	savagefb_set_fix(info);
 
 	/*
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c1043420dbd3..21d13d16f973 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1580,7 +1580,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	 */
 	info->fix = sh_mobile_lcdc_overlay_fix;
 	snprintf(info->fix.id, sizeof(info->fix.id),
-		 "SH Mobile LCDC Overlay %u", ovl->index);
+		 "SHMobile ovl %u", ovl->index);
 	info->fix.smem_start = ovl->dma_handle;
 	info->fix.smem_len = ovl->fb_size;
 	info->fix.line_length = ovl->pitch;
diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index a8fb41f1a258..09329072004f 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -172,7 +172,7 @@ static const unsigned char SiS_HiTVGroup3_2[] = {
 };
 
 /* 301C / 302ELV extended Part2 TV registers (4 tap scaler) */
-
+#ifdef CONFIG_FB_SIS_315
 static const unsigned char SiS_Part2CLVX_1[] = {
     0x00,0x00,
     0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
@@ -245,7 +245,6 @@ static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
     0xFF,0xFF,
 };
 
-#ifdef CONFIG_FB_SIS_315
 /* 661 et al LCD data structure (2.03.00) */
 static const unsigned char SiS_LCDStruct661[] = {
     /* 1024x768 */
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1e890ef17687..a6f375417fd5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -339,8 +339,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
-		if (err)
+		if (err) {
+			vp_del_vq(vqs[i]);
 			goto error_find;
+		}
 	}
 	return 0;
 
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index daa00f3c5a6a..7f2ca611a3f8 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -52,6 +52,8 @@
 
 #define DWDST			BIT(1)
 
+#define MAX_HW_ERROR		250
+
 static int heartbeat = DEFAULT_HEARTBEAT;
 
 /*
@@ -90,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 	 * to be 50% or less than that; we obviouly want to configure the open
 	 * window as large as possible so we select the 50% option.
 	 */
-	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
+	wdd->min_hw_heartbeat_ms = 520 * wdd->timeout + MAX_HW_ERROR;
 
 	/* Generate NMI when wdt expires */
 	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
@@ -124,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
 	 * be petted during the open window; not too early or not too late.
 	 * The HW configuration options only allow for the open window size
 	 * to be 50% or less than that.
+	 * To avoid any glitches, we accommodate 2% + max hardware error
+	 * safety margin.
 	 */
 	switch (wsize) {
 	case RTIWWDSIZE_50P:
-		/* 50% open window => 50% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
+		/* 50% open window => 52% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 520 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_25P:
-		/* 25% open window => 75% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
+		/* 25% open window => 77% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 770 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_12P5:
-		/* 12.5% open window => 87.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
+		/* 12.5% open window => 89.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 895 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_6P25:
-		/* 6.5% open window => 93.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
+		/* 6.5% open window => 95.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 955 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_3P125:
-		/* 3.125% open window => 96.9% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
+		/* 3.125% open window => 98.9% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 989 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	default:
@@ -222,14 +226,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * If watchdog is running at 32k clock, it is not accurate.
-	 * Adjust frequency down in this case so that we don't pet
-	 * the watchdog too often.
-	 */
-	if (wdt->freq < 32768)
-		wdt->freq = wdt->freq * 9 / 10;
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index bbb2c210d139..fa8a6543142d 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -146,6 +146,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		put_page(page);
 		if (ret < 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
+		    ctx->type == AFSVL_BACKVOL)
+			return -ENODEV;
 	}
 
 	return 0;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index f6a17d259db7..afe51b4be1e7 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -300,9 +300,11 @@ write_tag_66_packet(char *signature, u8 cipher_code,
 	 *         | Key Identifier Size      | 1 or 2 bytes |
 	 *         | Key Identifier           | arbitrary    |
 	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | Cipher Code              | 1 byte       |
 	 *         | File Encryption Key      | arbitrary    |
+	 *         | Checksum                 | 2 bytes      |
 	 */
-	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	data_len = (8 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
 	*packet = kmalloc(data_len, GFP_KERNEL);
 	message = *packet;
 	if (!message) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c1d632725c2c..87378d08a414 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5083,8 +5083,73 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	return ret;
 }
 
-static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
-				struct ext4_allocation_request *ar, int *errp);
+/*
+ * Simple allocator for Ext4 fast commit replay path. It searches for blocks
+ * linearly starting at the goal block and also excludes the blocks which
+ * are going to be in use after fast commit replay.
+ */
+static ext4_fsblk_t
+ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
+{
+	struct buffer_head *bitmap_bh;
+	struct super_block *sb = ar->inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group, nr;
+	ext4_grpblk_t blkoff;
+	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
+	ext4_grpblk_t i = 0;
+	ext4_fsblk_t goal, block;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+
+	goal = ar->goal;
+	if (goal < le32_to_cpu(es->s_first_data_block) ||
+			goal >= ext4_blocks_count(es))
+		goal = le32_to_cpu(es->s_first_data_block);
+
+	ar->len = 0;
+	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
+	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
+		bitmap_bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bitmap_bh)) {
+			*errp = PTR_ERR(bitmap_bh);
+			pr_warn("Failed to read block bitmap\n");
+			return 0;
+		}
+
+		while (1) {
+			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
+						blkoff);
+			if (i >= max)
+				break;
+			if (ext4_fc_replay_check_excluded(sb,
+				ext4_group_first_block_no(sb, group) +
+				EXT4_C2B(sbi, i))) {
+				blkoff = i + 1;
+			} else
+				break;
+		}
+		brelse(bitmap_bh);
+		if (i < max)
+			break;
+
+		if (++group >= ext4_get_groups_count(sb))
+			group = 0;
+
+		blkoff = 0;
+	}
+
+	if (i >= max) {
+		*errp = -ENOSPC;
+		return 0;
+	}
+
+	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
+	ext4_mb_mark_bb(sb, block, 1, 1);
+	ar->len = 1;
+
+	*errp = 0;
+	return block;
+}
 
 /*
  * Main entry point into mballoc to allocate blocks
@@ -5109,7 +5174,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
-		return ext4_mb_new_blocks_simple(handle, ar, errp);
+		return ext4_mb_new_blocks_simple(ar, errp);
 
 	/* Allow to use superuser reservation for quota file */
 	if (ext4_is_quota_file(ar->inode))
@@ -5339,69 +5404,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	return 0;
 }
 
-/*
- * Simple allocator for Ext4 fast commit replay path. It searches for blocks
- * linearly starting at the goal block and also excludes the blocks which
- * are going to be in use after fast commit replay.
- */
-static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
-				struct ext4_allocation_request *ar, int *errp)
-{
-	struct buffer_head *bitmap_bh;
-	struct super_block *sb = ar->inode->i_sb;
-	ext4_group_t group;
-	ext4_grpblk_t blkoff;
-	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
-	ext4_grpblk_t i = 0;
-	ext4_fsblk_t goal, block;
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
-
-	goal = ar->goal;
-	if (goal < le32_to_cpu(es->s_first_data_block) ||
-			goal >= ext4_blocks_count(es))
-		goal = le32_to_cpu(es->s_first_data_block);
-
-	ar->len = 0;
-	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
-	for (; group < ext4_get_groups_count(sb); group++) {
-		bitmap_bh = ext4_read_block_bitmap(sb, group);
-		if (IS_ERR(bitmap_bh)) {
-			*errp = PTR_ERR(bitmap_bh);
-			pr_warn("Failed to read block bitmap\n");
-			return 0;
-		}
-
-		ext4_get_group_no_and_offset(sb,
-			max(ext4_group_first_block_no(sb, group), goal),
-			NULL, &blkoff);
-		while (1) {
-			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
-						blkoff);
-			if (i >= max)
-				break;
-			if (ext4_fc_replay_check_excluded(sb,
-				ext4_group_first_block_no(sb, group) + i)) {
-				blkoff = i + 1;
-			} else
-				break;
-		}
-		brelse(bitmap_bh);
-		if (i < max)
-			break;
-	}
-
-	if (group >= ext4_get_groups_count(sb) || i >= max) {
-		*errp = -ENOSPC;
-		return 0;
-	}
-
-	block = ext4_group_first_block_no(sb, group) + i;
-	ext4_mb_mark_bb(sb, block, 1, 1);
-	ar->len = 1;
-
-	return block;
-}
-
 static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 					unsigned long count)
 {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a50eb4c61ecc..af0801593abb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2748,7 +2748,7 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode = ext4_new_inode_start_handle(dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
 			  4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5bf858fc271f..2dcb7d2bb85e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3065,8 +3065,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
 
 		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
 		if (IS_ERR(bh)) {
-			if (PTR_ERR(bh) == -ENOMEM)
+			if (PTR_ERR(bh) == -ENOMEM) {
+				mb_cache_entry_put(ea_block_cache, ce);
 				return NULL;
+			}
 			bh = NULL;
 			EXT4_ERROR_INODE(inode, "block %lu read error",
 					 (unsigned long)ce->e_value);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8ca549cc975e..f4ab9b313e4f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -776,7 +776,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	 */
 	head = &im->ino_list;
 
-	/* loop for each orphan inode entry and write them in Jornal block */
+	/* loop for each orphan inode entry and write them in journal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
 			page = f2fs_grab_meta_page(sbi, start_blk++);
@@ -1109,7 +1109,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-		 * wribacking dentry pages in the freeing inode.
+		 * writebacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_merged_write(sbi, DATA);
 		cond_resched();
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a94e102d1586..8dccb59d072b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -589,6 +589,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 				f2fs_cops[fi->i_compress_algorithm];
 	unsigned int max_len, new_nr_cpages;
 	struct page **new_cpages;
+	u32 chksum = 0;
 	int i, ret;
 
 	trace_f2fs_compress_pages_start(cc->inode, cc->cluster_idx,
@@ -642,6 +643,11 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 
 	cc->cbuf->clen = cpu_to_le32(cc->clen);
 
+	if (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)
+		chksum = f2fs_crc32(F2FS_I_SB(cc->inode),
+					cc->cbuf->cdata, cc->clen);
+	cc->cbuf->chksum = cpu_to_le32(chksum);
+
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
@@ -777,6 +783,22 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 
 	ret = cops->decompress_pages(dic);
 
+	if (!ret && (fi->i_compress_flag & 1 << COMPRESS_CHKSUM)) {
+		u32 provided = le32_to_cpu(dic->cbuf->chksum);
+		u32 calculated = f2fs_crc32(sbi, dic->cbuf->cdata, dic->clen);
+
+		if (provided != calculated) {
+			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
+				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
+				printk_ratelimited(
+					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
+					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
+					provided, calculated);
+			}
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
+	}
+
 out_vunmap_cbuf:
 	vm_unmap_ram(dic->cbuf, dic->nr_cpages);
 out_vunmap_rbuf:
@@ -843,14 +865,17 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
 	return true;
 }
 
-static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
+static int __f2fs_cluster_blocks(struct inode *inode,
+				unsigned int cluster_idx, bool compr)
 {
 	struct dnode_of_data dn;
+	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	unsigned int start_idx = cluster_idx <<
+				F2FS_I(inode)->i_log_cluster_size;
 	int ret;
 
-	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
-	ret = f2fs_get_dnode_of_data(&dn, start_idx_of_cluster(cc),
-							LOOKUP_NODE);
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	ret = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
 	if (ret) {
 		if (ret == -ENOENT)
 			ret = 0;
@@ -861,7 +886,7 @@ static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 		int i;
 
 		ret = 1;
-		for (i = 1; i < cc->cluster_size; i++) {
+		for (i = 1; i < cluster_size; i++) {
 			block_t blkaddr;
 
 			blkaddr = data_blkaddr(dn.inode,
@@ -874,6 +899,10 @@ static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 					ret++;
 			}
 		}
+
+		f2fs_bug_on(F2FS_I_SB(inode),
+			!compr && ret != cluster_size &&
+			!is_inode_flag_set(inode, FI_COMPRESS_RELEASED));
 	}
 fail:
 	f2fs_put_dnode(&dn);
@@ -883,30 +912,20 @@ static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 /* return # of compressed blocks in compressed cluster */
 static int f2fs_compressed_blocks(struct compress_ctx *cc)
 {
-	return __f2fs_cluster_blocks(cc, true);
+	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
 }
 
 /* return # of valid blocks in compressed cluster */
-static int f2fs_cluster_blocks(struct compress_ctx *cc)
-{
-	return __f2fs_cluster_blocks(cc, false);
-}
-
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
-	struct compress_ctx cc = {
-		.inode = inode,
-		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
-		.cluster_size = F2FS_I(inode)->i_cluster_size,
-		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
-	};
-
-	return f2fs_cluster_blocks(&cc);
+	return __f2fs_cluster_blocks(inode,
+		index >> F2FS_I(inode)->i_log_cluster_size,
+		false);
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
 {
-	if (!f2fs_compressed_file(cc->inode))
+	if (!f2fs_need_compress_data(cc->inode))
 		return false;
 	if (f2fs_is_atomic_file(cc->inode))
 		return false;
@@ -944,21 +963,16 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct address_space *mapping = cc->inode->i_mapping;
 	struct page *page;
-	struct dnode_of_data dn;
 	sector_t last_block_in_bio;
 	unsigned fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	int i, ret;
-	bool prealloc;
 
 retry:
-	ret = f2fs_cluster_blocks(cc);
+	ret = f2fs_is_compressed_cluster(cc->inode, start_idx);
 	if (ret <= 0)
 		return ret;
 
-	/* compressed case */
-	prealloc = (ret < cc->cluster_size);
-
 	ret = f2fs_init_compress_ctx(cc);
 	if (ret)
 		return ret;
@@ -1016,25 +1030,6 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		}
 	}
 
-	if (prealloc) {
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
-
-		set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
-
-		for (i = cc->cluster_size - 1; i > 0; i--) {
-			ret = f2fs_get_block(&dn, start_idx + i);
-			if (ret) {
-				i = cc->cluster_size;
-				break;
-			}
-
-			if (dn.data_blkaddr != NEW_ADDR)
-				break;
-		}
-
-		f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
-	}
-
 	if (likely(!ret)) {
 		*fsdata = cc->rpages;
 		*pagep = cc->rpages[offset_in_cluster(cc, index)];
@@ -1165,6 +1160,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
+	/* we should bypass data pages to proceed the kworker jobs */
+	if (unlikely(f2fs_cp_error(sbi))) {
+		mapping_set_error(cc->rpages[0]->mapping, -EIO);
+		goto out_free;
+	}
+
 	if (IS_NOQUOTA(inode)) {
 		/*
 		 * We need to wait for node_write to avoid block allocation during
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e0533cffbb07..1b764f70b70e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2431,7 +2431,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
-			/* there are remained comressed pages, submit them */
+			/* there are remained compressed pages, submit them */
 			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
@@ -2807,7 +2807,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	trace_f2fs_writepage(page, DATA);
 
-	/* we should bypass data pages to proceed the kworkder jobs */
+	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
 		/*
@@ -2933,7 +2933,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
 	/*
-	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
+	 * pageout() in MM translates EAGAIN, so calls handle_write_error()
 	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
 	 * file_write_and_wait_range() will see EIO error, which is critical
 	 * to return value of fsync() followed by atomic_write failure to user.
@@ -2967,7 +2967,7 @@ static int f2fs_write_data_page(struct page *page,
 }
 
 /*
- * This function was copied from write_cche_pages from mm/page-writeback.c.
+ * This function was copied from write_cache_pages from mm/page-writeback.c.
  * The major change is making write step of cold data page separately from
  * warm/hot data page.
  */
@@ -3222,7 +3222,7 @@ static inline bool __should_serialize_io(struct inode *inode,
 	if (IS_NOQUOTA(inode))
 		return false;
 
-	if (f2fs_compressed_file(inode))
+	if (f2fs_need_compress_data(inode))
 		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ad0b83a41226..01f93fae5629 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -112,7 +112,7 @@ struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * @prev_ex: extent before ofs
  * @next_ex: extent after ofs
  * @insert_p: insert point for new extent at ofs
- * in order to simpfy the insertion after.
+ * in order to simplify the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
 struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
@@ -572,7 +572,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	if (!en)
 		en = next_en;
 
-	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
+	/* 2. invalidate all extent nodes in range [fofs, fofs + len - 1] */
 	while (en && en->ei.fofs < end) {
 		unsigned int org_end;
 		int parts = 0;	/* # of parts current extent split into */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 83ebc860508b..4380df9b2d70 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -147,8 +147,10 @@ struct f2fs_mount_info {
 
 	/* For compression */
 	unsigned char compress_algorithm;	/* algorithm type */
-	unsigned compress_log_size;		/* cluster log size */
+	unsigned char compress_log_size;	/* cluster log size */
+	bool compress_chksum;			/* compressed data chksum */
 	unsigned char compress_ext_cnt;		/* extension count */
+	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
 
@@ -678,7 +680,10 @@ enum {
 	FI_ATOMIC_REVOKE_REQUEST, /* request to drop atomic data */
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
+	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
+	FI_ENABLE_COMPRESS,	/* enable compression in "user" compression mode */
+	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -736,6 +741,7 @@ struct f2fs_inode_info {
 	atomic_t i_compr_blocks;		/* # of compressed blocks */
 	unsigned char i_compress_algorithm;	/* algorithm type */
 	unsigned char i_log_cluster_size;	/* log of cluster size */
+	unsigned short i_compress_flag;		/* compress flag */
 	unsigned int i_cluster_size;		/* cluster size */
 };
 
@@ -1252,6 +1258,18 @@ enum fsync_mode {
 	FSYNC_MODE_NOBARRIER,	/* fsync behaves nobarrier based on posix */
 };
 
+enum {
+	COMPR_MODE_FS,		/*
+				 * automatically compress compression
+				 * enabled files
+				 */
+	COMPR_MODE_USER,	/*
+				 * automatical compression is disabled.
+				 * user can control the file compression
+				 * using ioctls
+				 */
+};
+
 /*
  * this value is set in page as a private data which indicate that
  * the page is atomically written, and it is in inmem_pages list.
@@ -1281,9 +1299,15 @@ enum compress_algorithm_type {
 	COMPRESS_MAX,
 };
 
-#define COMPRESS_DATA_RESERVED_SIZE		5
+enum compress_flag {
+	COMPRESS_CHKSUM,
+	COMPRESS_MAX_FLAG,
+};
+
+#define COMPRESS_DATA_RESERVED_SIZE		4
 struct compress_data {
 	__le32 clen;			/* compressed data size */
+	__le32 chksum;			/* compressed data chksum */
 	__le32 reserved[COMPRESS_DATA_RESERVED_SIZE];	/* reserved */
 	u8 cdata[];			/* compressed data */
 };
@@ -2627,6 +2651,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
+	case FI_COMPRESS_RELEASED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
@@ -2748,6 +2773,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
 		set_bit(FI_EXTRA_ATTR, fi->flags);
 	if (ri->i_inline & F2FS_PIN_FILE)
 		set_bit(FI_PIN_FILE, fi->flags);
+	if (ri->i_inline & F2FS_COMPRESS_RELEASED)
+		set_bit(FI_COMPRESS_RELEASED, fi->flags);
 }
 
 static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
@@ -2768,6 +2795,8 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
 		ri->i_inline |= F2FS_EXTRA_ATTR;
 	if (is_inode_flag_set(inode, FI_PIN_FILE))
 		ri->i_inline |= F2FS_PIN_FILE;
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		ri->i_inline |= F2FS_COMPRESS_RELEASED;
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode)
@@ -2786,6 +2815,22 @@ static inline int f2fs_compressed_file(struct inode *inode)
 		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
 }
 
+static inline bool f2fs_need_compress_data(struct inode *inode)
+{
+	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
+
+	if (!f2fs_compressed_file(inode))
+		return false;
+
+	if (compress_mode == COMPR_MODE_FS)
+		return true;
+	else if (compress_mode == COMPR_MODE_USER &&
+			is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+		return true;
+
+	return false;
+}
+
 static inline unsigned int addrs_per_inode(struct inode *inode)
 {
 	unsigned int addrs = CUR_ADDRS_PER_INODE(inode) -
@@ -3925,6 +3970,9 @@ static inline void set_compress_context(struct inode *inode)
 			F2FS_OPTION(sbi).compress_algorithm;
 	F2FS_I(inode)->i_log_cluster_size =
 			F2FS_OPTION(sbi).compress_log_size;
+	F2FS_I(inode)->i_compress_flag =
+			F2FS_OPTION(sbi).compress_chksum ?
+				1 << COMPRESS_CHKSUM : 0;
 	F2FS_I(inode)->i_cluster_size =
 			1 << F2FS_I(inode)->i_log_cluster_size;
 	F2FS_I(inode)->i_flags |= F2FS_COMPR_FL;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 40e805014f71..50514962771a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -63,6 +63,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		return VM_FAULT_SIGBUS;
+
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto err;
@@ -81,10 +84,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 			err = ret;
 			goto err;
 		} else if (ret) {
-			if (ret < F2FS_I(inode)->i_cluster_size) {
-				err = -EAGAIN;
-				goto err;
-			}
 			need_alloc = false;
 		}
 	}
@@ -298,6 +297,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
+	} else {
+		/*
+		 * for OPU case, during fsync(), node can be persisted before
+		 * data when lower device doesn't support write barrier, result
+		 * in data corruption after SPO.
+		 * So for strict fsync mode, force to use atomic write semantics
+		 * to keep write order in between data/node and last node to
+		 * avoid potential data corruption.
+		 */
+		if (F2FS_OPTION(sbi).fsync_mode ==
+				FSYNC_MODE_STRICT && !atomic)
+			atomic = true;
 	}
 go_write:
 	/*
@@ -880,9 +891,14 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	if ((attr->ia_valid & ATTR_SIZE) &&
-		!f2fs_is_compress_backend_ready(inode))
-		return -EOPNOTSUPP;
+	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (!f2fs_is_compress_backend_ready(inode))
+			return -EOPNOTSUPP;
+		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
+			!IS_ALIGNED(attr->ia_size,
+			F2FS_BLK_TO_BYTES(F2FS_I(inode)->i_cluster_size)))
+			return -EINVAL;
+	}
 
 	err = setattr_prepare(dentry, attr);
 	if (err)
@@ -1253,6 +1269,8 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
+
 			f2fs_copy_page(psrc, pdst);
 			set_page_dirty(pdst);
 			f2fs_put_page(pdst, 1);
@@ -1732,11 +1750,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	if (f2fs_compressed_file(inode) &&
-		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
-		return -EOPNOTSUPP;
-
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 			FALLOC_FL_INSERT_RANGE))
@@ -1744,6 +1757,17 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	/*
+	 * Pinned file should not support partial truncation since the block
+	 * can be used by applications.
+	 */
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	ret = file_modified(file);
 	if (ret)
 		goto out;
@@ -1779,7 +1803,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
 	/*
-	 * f2fs_relase_file is called at every close calls. So we should
+	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
 	 */
 	if (!(filp->f_mode & FMODE_WRITE) ||
@@ -2816,7 +2840,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
@@ -3532,9 +3557,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3553,7 +3575,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (IS_IMMUTABLE(inode)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3562,8 +3585,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		goto out;
 
-	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
-	f2fs_set_inode_flags(inode);
+	set_inode_flag(inode, FI_COMPRESS_RELEASED);
 	inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
@@ -3579,9 +3601,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3599,6 +3624,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3712,9 +3739,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3729,7 +3753,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!IS_IMMUTABLE(inode)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
@@ -3743,9 +3768,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3763,6 +3791,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3774,8 +3804,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	up_write(&F2FS_I(inode)->i_mmap_sem);
 
 	if (ret >= 0) {
-		F2FS_I(inode)->i_flags &= ~F2FS_IMMUTABLE_FL;
-		f2fs_set_inode_flags(inode);
+		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
 		inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
@@ -4132,6 +4161,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto unlock;
 	}
 
+	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	ret = generic_write_checks(iocb, from);
 	if (ret > 0) {
 		bool preallocated = false;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 87752550f78c..724760353bcd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -326,6 +326,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 
@@ -455,6 +461,7 @@ static int do_read_inode(struct inode *inode)
 					le64_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
+			fi->i_compress_flag = le16_to_cpu(ri->i_compress_flag);
 			fi->i_cluster_size = 1 << fi->i_log_cluster_size;
 			set_inode_flag(inode, FI_COMPRESSED_FILE);
 		}
@@ -633,6 +640,8 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 					&F2FS_I(inode)->i_compr_blocks));
 			ri->i_compress_algorithm =
 				F2FS_I(inode)->i_compress_algorithm;
+			ri->i_compress_flag =
+				cpu_to_le16(F2FS_I(inode)->i_compress_flag);
 			ri->i_log_cluster_size =
 				F2FS_I(inode)->i_log_cluster_size;
 		}
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 99e4ec48d2a4..56d23bc25435 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -937,7 +937,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	/*
 	 * If new_inode is null, the below renaming flow will
-	 * add a link in old_dir which can conver inline_dir.
+	 * add a link in old_dir which can convert inline_dir.
 	 * After then, if we failed to get the entry due to other
 	 * reasons like ENOMEM, we had to remove the new entry.
 	 * Instead of adding such the error handling routine, let's
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 02cb1c806c3e..348ad1d6199f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1242,6 +1242,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		goto fail;
 	}
@@ -1267,7 +1268,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a27a93429271..134a78179e6f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3296,7 +3296,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			else
 				return CURSEG_COLD_DATA;
 		}
-		if (file_is_cold(inode) || f2fs_compressed_file(inode))
+		if (file_is_cold(inode) || f2fs_need_compress_data(inode))
 			return CURSEG_COLD_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
@@ -3688,7 +3688,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 
 		/* submit cached LFS IO */
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		/* sbumit cached IPU IO */
+		/* submit cached IPU IO */
 		f2fs_submit_merged_ipu_write(sbi, NULL, page);
 		if (ordered) {
 			wait_on_page_writeback(page);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a74d60f61db..1281b59da6a2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -146,6 +146,8 @@ enum {
 	Opt_compress_algorithm,
 	Opt_compress_log_size,
 	Opt_compress_extension,
+	Opt_compress_chksum,
+	Opt_compress_mode,
 	Opt_atgc,
 	Opt_err,
 };
@@ -214,6 +216,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_compress_algorithm, "compress_algorithm=%s"},
 	{Opt_compress_log_size, "compress_log_size=%u"},
 	{Opt_compress_extension, "compress_extension=%s"},
+	{Opt_compress_chksum, "compress_chksum"},
+	{Opt_compress_mode, "compress_mode=%s"},
 	{Opt_atgc, "atgc"},
 	{Opt_err, NULL},
 };
@@ -974,10 +978,29 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
+		case Opt_compress_chksum:
+			F2FS_OPTION(sbi).compress_chksum = true;
+			break;
+		case Opt_compress_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "fs")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
+			} else if (!strcmp(name, "user")) {
+				F2FS_OPTION(sbi).compress_mode = COMPR_MODE_USER;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 #else
 		case Opt_compress_algorithm:
 		case Opt_compress_log_size:
 		case Opt_compress_extension:
+		case Opt_compress_chksum:
+		case Opt_compress_mode:
 			f2fs_info(sbi, "compression options not supported");
 			break;
 #endif
@@ -1562,6 +1585,14 @@ static inline void f2fs_show_compress_options(struct seq_file *seq,
 		seq_printf(seq, ",compress_extension=%s",
 			F2FS_OPTION(sbi).extensions[i]);
 	}
+
+	if (F2FS_OPTION(sbi).compress_chksum)
+		seq_puts(seq, ",compress_chksum");
+
+	if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_FS)
+		seq_printf(seq, ",compress_mode=%s", "fs");
+	else if (F2FS_OPTION(sbi).compress_mode == COMPR_MODE_USER)
+		seq_printf(seq, ",compress_mode=%s", "user");
 }
 
 static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
@@ -1711,6 +1742,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
 	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
+	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index dd052101e226..b0f01a8e3776 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -691,11 +691,13 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
+		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+
 		/* lock_dlm */
 		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
-		    test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags)) {
+		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
 			finish_xmote(gl, target);
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 3ece99e6490c..d11152dedb80 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -348,7 +348,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 			fs_err(sdp, "telling LM to unmount\n");
 			lm->lm_unmount(sdp);
 		}
-		set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index acb4492f5970..5a31220f96f5 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1111,6 +1111,9 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 
 	request = PAD(sizeof(struct jffs2_raw_xattr) + strlen(xname) + 1 + size);
+	if (request > c->sector_size - c->cleanmarker_size)
+		return -ERANGE;
+
 	rc = jffs2_reserve_space(c, request, &length,
 				 ALLOC_NORMAL, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9a72abfb46ab..566f1b11f62f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -660,9 +660,9 @@ unsigned long nfs_block_bits(unsigned long bsize, unsigned char *nrbitsp)
 	if ((bsize & (bsize - 1)) || nrbitsp) {
 		unsigned char	nrbits;
 
-		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits)); nrbits--)
+		for (nrbits = 31; nrbits && !(bsize & (1UL << nrbits)); nrbits--)
 			;
-		bsize = 1 << nrbits;
+		bsize = 1UL << nrbits;
 		if (nrbitsp)
 			*nrbitsp = nrbits;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8e546e6a5619..1ff3f9efbe51 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5320,7 +5320,7 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	struct rpc_message *msg = &task->tk_msg;
 
 	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
-	    server->caps & NFS_CAP_READ_PLUS && task->tk_status == -ENOTSUPP) {
+	    task->tk_status == -ENOTSUPP) {
 		server->caps &= ~NFS_CAP_READ_PLUS;
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 		rpc_restart_call_prepare(task);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 01235fac5971..668c1b28a940 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -59,7 +59,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_nmembs == 0)
 		return 0;
 
-	if (argv->v_size > PAGE_SIZE)
+	if ((size_t)argv->v_size > PAGE_SIZE)
 		return -EINVAL;
 
 	/*
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index be0ca35b8aa4..2eeae67ad298 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2164,8 +2164,10 @@ static void nilfs_segctor_start_timer(struct nilfs_sc_info *sci)
 {
 	spin_lock(&sci->sc_state_lock);
 	if (!(sci->sc_state & NILFS_SEGCTOR_COMMIT)) {
-		sci->sc_timer.expires = jiffies + sci->sc_interval;
-		add_timer(&sci->sc_timer);
+		if (sci->sc_task) {
+			sci->sc_timer.expires = jiffies + sci->sc_interval;
+			add_timer(&sci->sc_timer);
+		}
 		sci->sc_state |= NILFS_SEGCTOR_COMMIT;
 	}
 	spin_unlock(&sci->sc_state_lock);
@@ -2212,19 +2214,36 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	struct nilfs_segctor_wait_request wait_req;
 	int err = 0;
 
-	spin_lock(&sci->sc_state_lock);
 	init_wait(&wait_req.wq);
 	wait_req.err = 0;
 	atomic_set(&wait_req.done, 0);
+	init_waitqueue_entry(&wait_req.wq, current);
+
+	/*
+	 * To prevent a race issue where completion notifications from the
+	 * log writer thread are missed, increment the request sequence count
+	 * "sc_seq_request" and insert a wait queue entry using the current
+	 * sequence number into the "sc_wait_request" queue at the same time
+	 * within the lock section of "sc_state_lock".
+	 */
+	spin_lock(&sci->sc_state_lock);
 	wait_req.seq = ++sci->sc_seq_request;
+	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
 	spin_unlock(&sci->sc_state_lock);
 
-	init_waitqueue_entry(&wait_req.wq, current);
-	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
-	set_current_state(TASK_INTERRUPTIBLE);
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/*
+		 * Synchronize only while the log writer thread is alive.
+		 * Leave flushing out after the log writer thread exits to
+		 * the cleanup work in nilfs_segctor_destroy().
+		 */
+		if (!sci->sc_task)
+			break;
+
 		if (atomic_read(&wait_req.done)) {
 			err = wait_req.err;
 			break;
@@ -2240,7 +2259,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	return err;
 }
 
-static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
+static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
 {
 	struct nilfs_segctor_wait_request *wrq, *n;
 	unsigned long flags;
@@ -2248,7 +2267,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
 	spin_lock_irqsave(&sci->sc_wait_request.lock, flags);
 	list_for_each_entry_safe(wrq, n, &sci->sc_wait_request.head, wq.entry) {
 		if (!atomic_read(&wrq->done) &&
-		    nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq)) {
+		    (force || nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq))) {
 			wrq->err = err;
 			atomic_set(&wrq->done, 1);
 		}
@@ -2368,10 +2387,21 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
  */
 static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 {
+	bool thread_is_alive;
+
 	spin_lock(&sci->sc_state_lock);
 	sci->sc_seq_accepted = sci->sc_seq_request;
+	thread_is_alive = (bool)sci->sc_task;
 	spin_unlock(&sci->sc_state_lock);
-	del_timer_sync(&sci->sc_timer);
+
+	/*
+	 * This function does not race with the log writer thread's
+	 * termination.  Therefore, deleting sc_timer, which should not be
+	 * done after the log writer thread exits, can be done safely outside
+	 * the area protected by sc_state_lock.
+	 */
+	if (thread_is_alive)
+		del_timer_sync(&sci->sc_timer);
 }
 
 /**
@@ -2388,7 +2418,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 	if (mode == SC_LSEG_SR) {
 		sci->sc_state &= ~NILFS_SEGCTOR_COMMIT;
 		sci->sc_seq_done = sci->sc_seq_accepted;
-		nilfs_segctor_wakeup(sci, err);
+		nilfs_segctor_wakeup(sci, err, false);
 		sci->sc_flush_request = 0;
 	} else {
 		if (mode == SC_FLUSH_FILE)
@@ -2397,7 +2427,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 			sci->sc_flush_request &= ~FLUSH_DAT_BIT;
 
 		/* re-enable timer if checkpoint creation was not done */
-		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) && sci->sc_task &&
 		    time_before(jiffies, sci->sc_timer.expires))
 			add_timer(&sci->sc_timer);
 	}
@@ -2587,6 +2617,7 @@ static int nilfs_segctor_thread(void *arg)
 	int timeout = 0;
 
 	sci->sc_timer_task = current;
+	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	/* start sync. */
 	sci->sc_task = current;
@@ -2653,6 +2684,7 @@ static int nilfs_segctor_thread(void *arg)
  end_thread:
 	/* end sync. */
 	sci->sc_task = NULL;
+	del_timer_sync(&sci->sc_timer);
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
 	spin_unlock(&sci->sc_state_lock);
 	return 0;
@@ -2716,7 +2748,6 @@ static struct nilfs_sc_info *nilfs_segctor_new(struct super_block *sb,
 	INIT_LIST_HEAD(&sci->sc_gc_inodes);
 	INIT_LIST_HEAD(&sci->sc_iput_queue);
 	INIT_WORK(&sci->sc_iput_work, nilfs_iput_work_func);
-	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	sci->sc_interval = HZ * NILFS_SC_DEFAULT_TIMEOUT;
 	sci->sc_mjcp_freq = HZ * NILFS_SC_DEFAULT_SR_FREQ;
@@ -2770,6 +2801,13 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 		|| sci->sc_seq_request != sci->sc_seq_done);
 	spin_unlock(&sci->sc_state_lock);
 
+	/*
+	 * Forcibly wake up tasks waiting in nilfs_segctor_sync(), which can
+	 * be called from delayed iput() via nilfs_evict_inode() and can race
+	 * with the above log writer thread termination.
+	 */
+	nilfs_segctor_wakeup(sci, 0, true);
+
 	if (flush_work(&sci->sc_iput_work))
 		flag = true;
 
@@ -2795,7 +2833,6 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
-	del_timer_sync(&sci->sc_timer);
 	kfree(sci);
 }
 
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 40c8c2e32fa3..1e22344be5e5 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -362,10 +362,10 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openpromfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -373,7 +373,6 @@ static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
 	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
@@ -417,6 +416,7 @@ static int openpromfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations openpromfs_context_ops = {
 	.get_tree	= openpromfs_get_tree,
+	.reconfigure	= openpromfs_reconfigure,
 };
 
 static int openpromfs_init_fs_context(struct fs_context *fc)
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 3c0d1495c062..0dbed65c0ca5 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -231,9 +231,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 					    u16 value);
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps);
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps);
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a5dbb57a687f..9a6082c57219 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -229,6 +229,7 @@ struct f2fs_extent {
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
 #define F2FS_PIN_FILE		0x40	/* file should not be gced */
+#define F2FS_COMPRESS_RELEASED	0x80	/* file released compressed blocks */
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
@@ -273,7 +274,7 @@ struct f2fs_inode {
 			__le64 i_compr_blocks;	/* # of compressed blocks */
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
-			__le16 i_padding;		/* padding */
+			__le16 i_compress_flag;		/* compress flag */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		} __packed;
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275db..1c446c2ce2f9 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -7,6 +7,27 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
 
+struct fpga_region;
+
+/**
+ * struct fpga_region_info - collection of parameters an FPGA Region
+ * @mgr: fpga region manager
+ * @compat_id: FPGA region id for compatibility check.
+ * @priv: fpga region private data
+ * @get_bridges: optional function to get bridges to a list
+ *
+ * fpga_region_info contains parameters for the register_full function.
+ * These are separated into an info structure because they some are optional
+ * others could be added to in the future. The info structure facilitates
+ * maintaining a stable API.
+ */
+struct fpga_region_info {
+	struct fpga_manager *mgr;
+	struct fpga_compat_id *compat_id;
+	void *priv;
+	int (*get_bridges)(struct fpga_region *region);
+};
+
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
@@ -15,6 +36,7 @@
  * @mgr: FPGA manager
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
+ * @ops_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -25,6 +47,7 @@ struct fpga_region {
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
+	struct module *ops_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
@@ -37,15 +60,17 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
-void fpga_region_unregister(struct fpga_region *region);
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
+struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
+struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner);
+void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 4ae2f2908f99..d4a1567c94d0 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -20,6 +20,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int debounce);
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, unsigned int debounce);
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 6388eb9734a5..f25a1c484390 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -431,6 +431,8 @@ extern int param_get_int(char *buffer, const struct kernel_param *kp);
 extern const struct kernel_param_ops param_ops_uint;
 extern int param_set_uint(const char *val, const struct kernel_param *kp);
 extern int param_get_uint(char *buffer, const struct kernel_param *kp);
+int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
+		unsigned int min, unsigned int max);
 #define param_check_uint(name, p) __param_check(name, p, unsigned int)
 
 extern const struct kernel_param_ops param_ops_long;
diff --git a/include/media/cec.h b/include/media/cec.h
index cd35ae6b7560..38eb9334d854 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -26,13 +26,17 @@
  * @dev:	cec device
  * @cdev:	cec character device
  * @minor:	device node minor number
+ * @lock:	lock to serialize open/release and registration
  * @registered:	the device was correctly registered
  * @unregistered: the device was unregistered
- * @fhs_lock:	lock to control access to the filehandle list
+ * @lock_fhs:	lock to control access to @fhs
  * @fhs:	the list of open filehandles (cec_fh)
  *
  * This structure represents a cec-related device node.
  *
+ * To add or remove filehandles from @fhs the @lock must be taken first,
+ * followed by @lock_fhs. It is safe to access @fhs if either lock is held.
+ *
  * The @parent is a physical device. It must be set by core or device drivers
  * before registering the node.
  */
@@ -43,10 +47,13 @@ struct cec_devnode {
 
 	/* device info */
 	int minor;
+	/* serialize open/release and registration */
+	struct mutex lock;
 	bool registered;
 	bool unregistered;
+	/* protect access to fhs */
+	struct mutex lock_fhs;
 	struct list_head fhs;
-	struct mutex lock;
 };
 
 struct cec_adapter;
@@ -113,14 +120,16 @@ struct cec_adap_ops {
 	int (*adap_log_addr)(struct cec_adapter *adap, u8 logical_addr);
 	int (*adap_transmit)(struct cec_adapter *adap, u8 attempts,
 			     u32 signal_free_time, struct cec_msg *msg);
+	void (*adap_nb_transmit_canceled)(struct cec_adapter *adap,
+					  const struct cec_msg *msg);
 	void (*adap_status)(struct cec_adapter *adap, struct seq_file *file);
 	void (*adap_free)(struct cec_adapter *adap);
 
-	/* Error injection callbacks */
+	/* Error injection callbacks, called without adap->lock held */
 	int (*error_inj_show)(struct cec_adapter *adap, struct seq_file *sf);
 	bool (*error_inj_parse_line)(struct cec_adapter *adap, char *line);
 
-	/* High-level CEC message callback */
+	/* High-level CEC message callback, called without adap->lock held */
 	int (*received)(struct cec_adapter *adap, struct cec_msg *msg);
 };
 
@@ -156,6 +165,11 @@ struct cec_adap_ops {
  * @wait_queue:		queue of transmits waiting for a reply
  * @transmitting:	CEC messages currently being transmitted
  * @transmit_in_progress: true if a transmit is in progress
+ * @transmit_in_progress_aborted: true if a transmit is in progress is to be
+ *			aborted. This happens if the logical address is
+ *			invalidated while the transmit is ongoing. In that
+ *			case the transmit will finish, but will not retransmit
+ *			and be marked as ABORTED.
  * @kthread_config:	kthread used to configure a CEC adapter
  * @config_completion:	used to signal completion of the config kthread
  * @kthread:		main CEC processing thread
@@ -168,6 +182,7 @@ struct cec_adap_ops {
  * @needs_hpd:		if true, then the HDMI HotPlug Detect pin must be high
  *	in order to transmit or receive CEC messages. This is usually a HW
  *	limitation.
+ * @is_enabled:		the CEC adapter is enabled
  * @is_configuring:	the CEC adapter is configuring (i.e. claiming LAs)
  * @is_configured:	the CEC adapter is configured (i.e. has claimed LAs)
  * @cec_pin_is_high:	if true then the CEC pin is high. Only used with the
@@ -210,6 +225,7 @@ struct cec_adapter {
 	struct list_head wait_queue;
 	struct cec_data *transmitting;
 	bool transmit_in_progress;
+	bool transmit_in_progress_aborted;
 
 	struct task_struct *kthread_config;
 	struct completion config_completion;
@@ -224,6 +240,8 @@ struct cec_adapter {
 
 	u16 phys_addr;
 	bool needs_hpd;
+	bool is_enabled;
+	bool is_claiming_log_addrs;
 	bool is_configuring;
 	bool is_configured;
 	bool cec_pin_is_high;
diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
index f08ba181263d..1cc89d2e693a 100644
--- a/include/media/v4l2-h264.h
+++ b/include/media/v4l2-h264.h
@@ -66,11 +66,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
 			    u8 *b0_reflist, u8 *b1_reflist);
 
 /**
- * v4l2_h264_build_b_ref_lists() - Build the P reference list
+ * v4l2_h264_build_p_ref_list() - Build the P reference list
  *
  * @builder: reference list builder context
- * @p_reflist: 16-bytes array used to store the P reference list. Each entry
- *	       is an index in the DPB
+ * @reflist: 16-bytes array used to store the P reference list. Each entry
+ *	     is an index in the DPB
  *
  * This functions builds the P reference lists. This procedure is describe in
  * section '8.2.4 Decoding process for reference picture lists construction'
diff --git a/include/media/v4l2-jpeg.h b/include/media/v4l2-jpeg.h
index ddba2a56c321..3a3344a97678 100644
--- a/include/media/v4l2-jpeg.h
+++ b/include/media/v4l2-jpeg.h
@@ -91,7 +91,9 @@ struct v4l2_jpeg_scan_header {
  * struct v4l2_jpeg_header - parsed JPEG header
  * @sof: pointer to frame header and size
  * @sos: pointer to scan header and size
+ * @num_dht: number of entries in @dht
  * @dht: pointers to huffman tables and sizes
+ * @num_dqt: number of entries in @dqt
  * @dqt: pointers to quantization tables and sizes
  * @frame: parsed frame header
  * @scan: pointer to parsed scan header, optional
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 632086b2f644..3ae2fda29507 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -24,7 +24,7 @@ struct dst_ops {
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
 					  struct net_device *dev, int how);
-	struct dst_entry *	(*negative_advice)(struct dst_entry *);
+	void			(*negative_advice)(struct sock *sk, struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
 					       struct sk_buff *skb, u32 mtu,
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 56f1286583d3..f89320b6fee3 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,6 +48,22 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+typedef u32 (inet6_ehashfn_t)(const struct net *net,
+			       const struct in6_addr *laddr, const u16 lport,
+			       const struct in6_addr *faddr, const __be16 fport);
+
+inet6_ehashfn_t inet6_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn);
+
 struct sock *inet6_lookup_listener(struct net *net,
 				   struct inet_hashinfo *hashinfo,
 				   struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index c9e387d174c6..7778422cfac5 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -313,6 +313,20 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+typedef u32 (inet_ehashfn_t)(const struct net *net,
+			      const __be32 laddr, const __u16 lport,
+			      const __be32 faddr, const __be16 fport);
+
+inet_ehashfn_t inet_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
@@ -382,10 +396,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
-u32 inet6_ehashfn(const struct net *net,
-		  const struct in6_addr *laddr, const u16 lport,
-		  const struct in6_addr *faddr, const __be16 fport);
-
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2da11d8c0f45..ab8d84775ca8 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1174,6 +1174,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
  *	@type: stateful object numeric type
  *	@owner: module owner
  *	@maxattr: maximum netlink attribute
+ *	@family: address family for AF-specific object types
  *	@policy: netlink attribute policy
  */
 struct nft_object_type {
@@ -1183,6 +1184,7 @@ struct nft_object_type {
 	struct list_head		list;
 	u32				type;
 	unsigned int                    maxattr;
+	u8				family;
 	struct module			*owner;
 	const struct nla_policy		*policy;
 };
diff --git a/include/net/sock.h b/include/net/sock.h
index 8bcc96bf291c..0be681984987 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2012,17 +2012,10 @@ sk_dst_get(struct sock *sk)
 
 static inline void __dst_negative_advice(struct sock *sk)
 {
-	struct dst_entry *ndst, *dst = __sk_dst_get(sk);
+	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->ops->negative_advice) {
-		ndst = dst->ops->negative_advice(dst);
-
-		if (ndst != dst) {
-			rcu_assign_pointer(sk->sk_dst_cache, ndst);
-			sk_tx_queue_clear(sk);
-			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-		}
-	}
+	if (dst && dst->ops->negative_advice)
+		dst->ops->negative_advice(sk, dst);
 }
 
 static inline void dst_negative_advice(struct sock *sk)
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index b16a844d16ef..9a43c44dcbbb 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -171,4 +171,10 @@ struct snd_soc_acpi_codecs {
 	u8 codecs[SND_SOC_ACPI_MAX_CODECS][ACPI_ID_LEN];
 };
 
+static inline bool snd_soc_acpi_sof_parent(struct device *dev)
+{
+	return dev->parent && dev->parent->driver && dev->parent->driver->name &&
+		!strcmp(dev->parent->driver->name, "sof-audio-acpi");
+}
+
 #endif
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 40c300fe704d..f62d5b702426 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -11,6 +11,8 @@
 #define DAPM_DIRECT "(direct)"
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
+TRACE_DEFINE_ENUM(SND_SOC_DAPM_DIR_OUT);
+
 struct snd_soc_jack;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index 7d1a06c52469..dc8879d179fd 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -396,6 +396,7 @@ struct cec_drm_connector_info {
  * associated with the CEC adapter.
  * @type: connector type (if any)
  * @drm: drm connector info
+ * @raw: array to pad the union
  */
 struct cec_connector_info {
 	__u32 type;
@@ -453,7 +454,7 @@ struct cec_event_lost_msgs {
  * struct cec_event - CEC event structure
  * @ts: the timestamp of when the event was sent.
  * @event: the event.
- * array.
+ * @flags: event flags.
  * @state_change: the event payload for CEC_EVENT_STATE_CHANGE.
  * @lost_msgs: the event payload for CEC_EVENT_LOST_MSGS.
  * @raw: array to pad the union.
diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index a38454d9e0f5..658106f5b5dc 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -44,6 +44,7 @@ enum v4l2_subdev_format_whence {
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @pad: pad number, as reported by the media API
  * @format: media bus format (format code and frame size)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_format {
 	__u32 which;
@@ -57,6 +58,7 @@ struct v4l2_subdev_format {
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @pad: pad number, as reported by the media API
  * @rect: pad crop rectangle boundaries
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_crop {
 	__u32 which;
@@ -78,6 +80,7 @@ struct v4l2_subdev_crop {
  * @code: format code (MEDIA_BUS_FMT_ definitions)
  * @which: format type (from enum v4l2_subdev_format_whence)
  * @flags: flags set by the driver, (V4L2_SUBDEV_MBUS_CODE_*)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_mbus_code_enum {
 	__u32 pad;
@@ -90,10 +93,15 @@ struct v4l2_subdev_mbus_code_enum {
 
 /**
  * struct v4l2_subdev_frame_size_enum - Media bus format enumeration
- * @pad: pad number, as reported by the media API
  * @index: format index during enumeration
+ * @pad: pad number, as reported by the media API
  * @code: format code (MEDIA_BUS_FMT_ definitions)
+ * @min_width: minimum frame width, in pixels
+ * @max_width: maximum frame width, in pixels
+ * @min_height: minimum frame height, in pixels
+ * @max_height: maximum frame height, in pixels
  * @which: format type (from enum v4l2_subdev_format_whence)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_size_enum {
 	__u32 index;
@@ -111,6 +119,7 @@ struct v4l2_subdev_frame_size_enum {
  * struct v4l2_subdev_frame_interval - Pad-level frame rate
  * @pad: pad number, as reported by the media API
  * @interval: frame interval in seconds
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_interval {
 	__u32 pad;
@@ -127,6 +136,7 @@ struct v4l2_subdev_frame_interval {
  * @height: frame height in pixels
  * @interval: frame interval in seconds
  * @which: format type (from enum v4l2_subdev_format_whence)
+ * @reserved: drivers and applications must zero this array
  */
 struct v4l2_subdev_frame_interval_enum {
 	__u32 index;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 55b8c4b82479..1bbd81f031fe 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -976,8 +976,10 @@ struct v4l2_requestbuffers {
  *			pointing to this plane
  * @fd:			when memory is V4L2_MEMORY_DMABUF, a userspace file
  *			descriptor associated with this plane
+ * @m:			union of @mem_offset, @userptr and @fd
  * @data_offset:	offset in the plane to the start of data; usually 0,
  *			unless there is a header in front of the data
+ * @reserved:		drivers and applications must zero this array
  *
  * Multi-planar buffers consist of one or more planes, e.g. an YCbCr buffer
  * with two planes can have one plane for Y, and another for interleaved CbCr
@@ -1019,10 +1021,14 @@ struct v4l2_plane {
  *		a userspace file descriptor associated with this buffer
  * @planes:	for multiplanar buffers; userspace pointer to the array of plane
  *		info structs for this buffer
+ * @m:		union of @offset, @userptr, @planes and @fd
  * @length:	size in bytes of the buffer (NOT its payload) for single-plane
  *		buffers (when type != *_MPLANE); number of elements in the
  *		planes array for multi-plane buffers
+ * @reserved2:	drivers and applications must zero this field
  * @request_fd: fd of the request that this buffer should use
+ * @reserved:	for backwards compatibility with applications that do not know
+ *		about @request_fd
  *
  * Contains data exchanged by application and driver using one of the Streaming
  * I/O methods.
@@ -1060,7 +1066,7 @@ struct v4l2_buffer {
 #ifndef __KERNEL__
 /**
  * v4l2_timeval_to_ns - Convert timeval to nanoseconds
- * @ts:		pointer to the timeval variable to be converted
+ * @tv:		pointer to the timeval variable to be converted
  *
  * Returns the scalar nanosecond representation of the timeval
  * parameter.
@@ -1121,6 +1127,7 @@ static inline __u64 v4l2_timeval_to_ns(const struct timeval *tv)
  * @flags:	flags for newly created file, currently only O_CLOEXEC is
  *		supported, refer to manual of open syscall for more details
  * @fd:		file descriptor associated with DMABUF (set by driver)
+ * @reserved:	drivers and applications must zero this array
  *
  * Contains data used for exporting a video buffer as DMABUF file descriptor.
  * The buffer is identified by a 'cookie' returned by VIDIOC_QUERYBUF
@@ -2215,6 +2222,7 @@ struct v4l2_mpeg_vbi_fmt_ivtv {
  *			this plane will be used
  * @bytesperline:	distance in bytes between the leftmost pixels in two
  *			adjacent lines
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_plane_pix_format {
 	__u32		sizeimage;
@@ -2233,8 +2241,10 @@ struct v4l2_plane_pix_format {
  * @num_planes:		number of planes for this format
  * @flags:		format flags (V4L2_PIX_FMT_FLAG_*)
  * @ycbcr_enc:		enum v4l2_ycbcr_encoding, Y'CbCr encoding
+ * @hsv_enc:		enum v4l2_hsv_encoding, HSV encoding
  * @quantization:	enum v4l2_quantization, colorspace quantization
  * @xfer_func:		enum v4l2_xfer_func, colorspace transfer function
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_pix_format_mplane {
 	__u32				width;
@@ -2259,6 +2269,7 @@ struct v4l2_pix_format_mplane {
  * struct v4l2_sdr_format - SDR format definition
  * @pixelformat:	little endian four character code (fourcc)
  * @buffersize:		maximum size in bytes required for data
+ * @reserved:		drivers and applications must zero this array
  */
 struct v4l2_sdr_format {
 	__u32				pixelformat;
@@ -2285,6 +2296,8 @@ struct v4l2_meta_format {
  * @vbi:	raw VBI capture or output parameters
  * @sliced:	sliced VBI capture or output parameters
  * @raw_data:	placeholder for future extensions and custom formats
+ * @fmt:	union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
+ *		and @raw_data
  */
 struct v4l2_format {
 	__u32	 type;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93f9ecedc59f..47bc8fe2b945 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6474,6 +6474,8 @@ static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	switch (req->opcode) {
 	case IORING_OP_NOP:
+		if (READ_ONCE(sqe->rw_flags))
+			return -EINVAL;
 		return 0;
 	case IORING_OP_READV:
 	case IORING_OP_READ_FIXED:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25f8a8716e88..ad115ccc2fe0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4890,7 +4890,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -4901,6 +4902,11 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 		if (eatype == BPF_TRACE_ITER)
 			return true;
 		break;
+	case BPF_PROG_TYPE_SOCK_OPS:
+		/* map_update allowed only via dedicated helpers with event type checks */
+		if (func_id == BPF_FUNC_map_delete_elem)
+			return true;
+		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -4988,7 +4994,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -4998,7 +5003,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 195f9cccab20..9f2a93c829a9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1901,7 +1901,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b718..a3b4b55d2e2e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -172,6 +172,33 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+/**
+ * kdb_position_cursor() - Place cursor in the correct horizontal position
+ * @prompt: Nil-terminated string containing the prompt string
+ * @buffer: Nil-terminated string containing the entire command line
+ * @cp: Cursor position, pointer the character in buffer where the cursor
+ *      should be positioned.
+ *
+ * The cursor is positioned by sending a carriage-return and then printing
+ * the content of the line until we reach the correct cursor position.
+ *
+ * There is some additional fine detail here.
+ *
+ * Firstly, even though kdb_printf() will correctly format zero-width fields
+ * we want the second call to kdb_printf() to be conditional. That keeps things
+ * a little cleaner when LOGGING=1.
+ *
+ * Secondly, we can't combine everything into one call to kdb_printf() since
+ * that renders into a fixed length buffer and the combined print could result
+ * in unwanted truncation.
+ */
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -200,7 +227,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 						 * and null byte */
 	char *lastchar;
 	char *p_tmp;
-	char tmp;
 	static char tmpbuffer[CMD_BUFLEN];
 	int len = strlen(buffer);
 	int len_tmp;
@@ -237,12 +263,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 13: /* enter */
@@ -259,19 +281,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -287,11 +304,10 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
+	case 16: /* Up */
+		kdb_printf("\r%*c\r",
+			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
+			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;
@@ -301,15 +317,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;
@@ -353,15 +360,25 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;
@@ -372,13 +389,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b13b359..40c6512bc163 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
+	/*
+	 * Complete an eventually pending irq move cleanup. If this
+	 * interrupt was moved in hard irq context, then the vectors need
+	 * to be cleaned up. It can't wait until this interrupt actually
+	 * happens and this CPU was involved.
+	 */
+	irq_force_complete_move(desc);
+
 	/*
 	 * No move required, if:
 	 * - Interrupt is per cpu
@@ -87,14 +95,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
-	/*
-	 * Complete an eventually pending irq move cleanup. If this
-	 * interrupt was moved in hard irq context, then the vectors need
-	 * to be cleaned up. It can't wait until this interrupt actually
-	 * happens and this CPU was involved.
-	 */
-	irq_force_complete_move(desc);
-
 	/*
 	 * If there is a setaffinity pending, then try to reuse the pending
 	 * mask, so the last change of the affinity does not get lost. If
diff --git a/kernel/params.c b/kernel/params.c
index 164d79330849..eb00abef7076 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -243,6 +243,24 @@ STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",		kstrtoul);
 STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",		kstrtoull);
 STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", 	kstrtouint);
 
+int param_set_uint_minmax(const char *val, const struct kernel_param *kp,
+		unsigned int min, unsigned int max)
+{
+	unsigned int num;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+	ret = kstrtouint(val, 0, &num);
+	if (ret)
+		return ret;
+	if (num < min || num > max)
+		return -EINVAL;
+	*((unsigned int *)kp->arg) = num;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(param_set_uint_minmax);
+
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
 	if (strlen(val) > 1024) {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ff2c6d3ba6c7..6eb0996ef859 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1217,7 +1217,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2df8e13a29e5..9a2c8727b033 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1498,6 +1498,11 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
+ *
+ * Callers of this function need to guarantee that the list of pages doesn't get
+ * modified during the check. In particular, if it's possible that the function
+ * is invoked with concurrent readers which can swap in a new reader page then
+ * the caller should take cpu_buffer->reader_lock.
  */
 static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -2222,8 +2227,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
+			unsigned long flags;
+
 			cpu_buffer = buffer->buffers[cpu];
+			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
diff --git a/net/9p/client.c b/net/9p/client.c
index cd85a4b6448b..0fa324e8b245 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,6 +235,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->id = 0;
+	fc->tag = P9_NOTAG;
 	return 0;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 0e2c433bebcd..5e91496fd3a3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10217,8 +10217,9 @@ static void netdev_wait_allrefs(struct net_device *dev)
 			rebroadcast_time = jiffies;
 		}
 
+		rcu_barrier();
+
 		if (!wait) {
-			rcu_barrier();
 			wait = WAIT_REFS_MIN_MSECS;
 		} else {
 			msleep(wait);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ad050f8476b8..56deddeac1b0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -28,9 +28,9 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 
-static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
-			const __u16 lport, const __be32 faddr,
-			const __be16 fport)
+u32 inet_ehashfn(const struct net *net, const __be32 laddr,
+		 const __u16 lport, const __be32 faddr,
+		 const __be16 fport)
 {
 	static u32 inet_ehash_secret __read_mostly;
 
@@ -39,6 +39,7 @@ static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      inet_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet_ehashfn);
 
 /* This function handles inet_sock, but also timewait and request sockets
  * for IPv4/IPv6.
@@ -252,20 +253,25 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    __be32 saddr, __be16 sport,
-					    __be32 daddr, unsigned short hnum)
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_2(ehashfn, udp_ehashfn, inet_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
 
 /*
  * Here are some nice properties to exploit here. The BSD API
@@ -290,8 +296,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 		sk = (struct sock *)icsk;
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet_lookup_reuseport(net, sk, skb, doff,
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -320,7 +326,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/netfilter/nf_tproxy_ipv4.c b/net/ipv4/netfilter/nf_tproxy_ipv4.c
index 61cb2341f50f..7c1a0cd9f435 100644
--- a/net/ipv4/netfilter/nf_tproxy_ipv4.c
+++ b/net/ipv4/netfilter/nf_tproxy_ipv4.c
@@ -58,6 +58,8 @@ __be32 nf_tproxy_laddr4(struct sk_buff *skb, __be32 user_laddr, __be32 daddr)
 
 	laddr = 0;
 	indev = __in_dev_get_rcu(skb->dev);
+	if (!indev)
+		return daddr;
 
 	in_dev_for_each_ifa_rcu(ifa, indev) {
 		if (ifa->ifa_flags & IFA_F_SECONDARY)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cc409cc0789c..b3b49d8b386d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -137,7 +137,8 @@ static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 static struct dst_entry *ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 static unsigned int	 ipv4_mtu(const struct dst_entry *dst);
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
+static void		ipv4_negative_advice(struct sock *sk,
+					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 					   struct sk_buff *skb, u32 mtu,
@@ -866,22 +867,15 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	__ip_do_redirect(rt, skb, &fl4, true);
 }
 
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
+static void ipv4_negative_advice(struct sock *sk,
+				 struct dst_entry *dst)
 {
 	struct rtable *rt = (struct rtable *)dst;
-	struct dst_entry *ret = dst;
 
-	if (rt) {
-		if (dst->obsolete > 0) {
-			ip_rt_put(rt);
-			ret = NULL;
-		} else if ((rt->rt_flags & RTCF_REDIRECTED) ||
-			   rt->dst.expires) {
-			ip_rt_put(rt);
-			ret = NULL;
-		}
-	}
-	return ret;
+	if ((dst->obsolete > 0) ||
+	    (rt->rt_flags & RTCF_REDIRECTED) ||
+	    rt->dst.expires)
+		sk_dst_reset(sk);
 }
 
 /*
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 79f705450c16..be2c97e907ae 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -55,7 +55,18 @@ struct dctcp {
 };
 
 static unsigned int dctcp_shift_g __read_mostly = 4; /* g = 1/2^4 */
-module_param(dctcp_shift_g, uint, 0644);
+
+static int dctcp_shift_g_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0, 10);
+}
+
+static const struct kernel_param_ops dctcp_shift_g_ops = {
+	.set = dctcp_shift_g_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(dctcp_shift_g, &dctcp_shift_g_ops, &dctcp_shift_g, 0644);
 MODULE_PARM_DESC(dctcp_shift_g, "parameter g for updating dctcp_alpha");
 
 static unsigned int dctcp_alpha_on_init __read_mostly = DCTCP_MAX_ALPHA;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 85d8688933f3..0e7179a19e22 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1787,7 +1787,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -1796,6 +1796,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -1891,7 +1892,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	__skb_push(skb, hdrlen);
 
 no_coalesce:
-	limit = (u32)READ_ONCE(sk->sk_rcvbuf) + (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
 
 	/* Only socket owner can try to collapse/prune rx queues
 	 * to reduce memory overhead, so add a little headroom here.
@@ -1899,6 +1906,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 16ff3962b24d..da9015efb45e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -398,9 +398,9 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
-		       const __u16 lport, const __be32 faddr,
-		       const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport)
 {
 	static u32 udp_ehash_secret __read_mostly;
 
@@ -410,22 +410,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned short hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -436,15 +420,28 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (need_rescore)
+				continue;
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+						       saddr, sport, daddr, hnum, udp_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -458,9 +455,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(result, net, saddr, sport,
-						daddr, hnum, dif, sdif);
-
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
@@ -483,7 +485,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b4a5e01e1201..21b4fc835487 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -41,6 +41,7 @@ u32 inet6_ehashfn(const struct net *net,
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -113,22 +114,27 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    const struct in6_addr *saddr,
-					    __be16 sport,
-					    const struct in6_addr *daddr,
-					    unsigned short hnum)
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_INET(ehashfn, udp6_ehashfn, inet6_ehashfn,
+					   net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
 
 /* called with rcu_read_lock() */
 static struct sock *inet6_lhash2_lookup(struct net *net,
@@ -146,8 +152,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 		sk = (struct sock *)icsk;
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet6_lookup_reuseport(net, sk, skb, doff,
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -178,7 +184,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 28e44782c94d..699367517155 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -363,7 +363,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 * the source of the fragment, with the Pointer field set to zero.
 	 */
 	nexthdr = hdr->nexthdr;
-	if (ipv6frag_thdr_truncated(skb, skb_transport_offset(skb), &nexthdr)) {
+	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
 		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 				IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2d53c362f309..88f96241ca97 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -85,7 +85,8 @@ enum rt6_nud_state {
 static struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
 static unsigned int	 ip6_mtu(const struct dst_entry *dst);
-static struct dst_entry *ip6_negative_advice(struct dst_entry *);
+static void		ip6_negative_advice(struct sock *sk,
+					    struct dst_entry *dst);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
@@ -2635,24 +2636,24 @@ static struct dst_entry *ip6_dst_check(struct dst_entry *dst, u32 cookie)
 	return dst_ret;
 }
 
-static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
+static void ip6_negative_advice(struct sock *sk,
+				struct dst_entry *dst)
 {
 	struct rt6_info *rt = (struct rt6_info *) dst;
 
-	if (rt) {
-		if (rt->rt6i_flags & RTF_CACHE) {
-			rcu_read_lock();
-			if (rt6_check_expired(rt)) {
-				rt6_remove_exception_rt(rt);
-				dst = NULL;
-			}
-			rcu_read_unlock();
-		} else {
-			dst_release(dst);
-			dst = NULL;
+	if (rt->rt6i_flags & RTF_CACHE) {
+		rcu_read_lock();
+		if (rt6_check_expired(rt)) {
+			/* counteract the dst_release() in sk_dst_reset() */
+			dst_hold(dst);
+			sk_dst_reset(sk);
+
+			rt6_remove_exception_rt(rt);
 		}
+		rcu_read_unlock();
+		return;
 	}
-	return dst;
+	sk_dst_reset(sk);
 }
 
 static void ip6_link_failure(struct sk_buff *skb)
@@ -4345,7 +4346,7 @@ static void rtmsg_to_fib6_config(struct net *net,
 		.fc_table = l3mdev_fib_table_by_index(net, rtmsg->rtmsg_ifindex) ?
 			 : RT6_TABLE_MAIN,
 		.fc_ifindex = rtmsg->rtmsg_ifindex,
-		.fc_metric = rtmsg->rtmsg_metric ? : IP6_RT_PRIO_USER,
+		.fc_metric = rtmsg->rtmsg_metric,
 		.fc_expires = rtmsg->rtmsg_info,
 		.fc_dst_len = rtmsg->rtmsg_dst_len,
 		.fc_src_len = rtmsg->rtmsg_src_len,
@@ -4375,6 +4376,9 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 	rtnl_lock();
 	switch (cmd) {
 	case SIOCADDRT:
+		/* Only do the default setting of fc_metric in route adding */
+		if (cfg.fc_metric == 0)
+			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
 		break;
 	case SIOCDELRT:
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index a8439fded12d..77221f27262a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -490,6 +490,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
 #endif
 out_unregister_pernet:
@@ -503,8 +505,9 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 552bce1fdfb9..2e2b94ae6355 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -355,6 +355,7 @@ static int seg6_hmac_init_algo(void)
 	struct crypto_shash *tfm;
 	struct shash_desc *shash;
 	int i, alg_count, cpu;
+	int ret = -ENOMEM;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 
@@ -365,12 +366,14 @@ static int seg6_hmac_init_algo(void)
 		algo = &hmac_algos[i];
 		algo->tfms = alloc_percpu(struct crypto_shash *);
 		if (!algo->tfms)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			tfm = crypto_alloc_shash(algo->name, 0, 0);
-			if (IS_ERR(tfm))
-				return PTR_ERR(tfm);
+			if (IS_ERR(tfm)) {
+				ret = PTR_ERR(tfm);
+				goto error_out;
+			}
 			p_tfm = per_cpu_ptr(algo->tfms, cpu);
 			*p_tfm = tfm;
 		}
@@ -382,18 +385,22 @@ static int seg6_hmac_init_algo(void)
 
 		algo->shashs = alloc_percpu(struct shash_desc *);
 		if (!algo->shashs)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			shash = kzalloc_node(shsize, GFP_KERNEL,
 					     cpu_to_node(cpu));
 			if (!shash)
-				return -ENOMEM;
+				goto error_out;
 			*per_cpu_ptr(algo->shashs, cpu) = shash;
 		}
 	}
 
 	return 0;
+
+error_out:
+	seg6_hmac_exit();
+	return ret;
 }
 
 int __init seg6_hmac_init(void)
@@ -413,22 +420,29 @@ int __net_init seg6_hmac_net_init(struct net *net)
 void seg6_hmac_exit(void)
 {
 	struct seg6_hmac_algo *algo = NULL;
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
 	int i, alg_count, cpu;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
 		algo = &hmac_algos[i];
-		for_each_possible_cpu(cpu) {
-			struct crypto_shash *tfm;
-			struct shash_desc *shash;
 
-			shash = *per_cpu_ptr(algo->shashs, cpu);
-			kfree(shash);
-			tfm = *per_cpu_ptr(algo->tfms, cpu);
-			crypto_free_shash(tfm);
+		if (algo->shashs) {
+			for_each_possible_cpu(cpu) {
+				shash = *per_cpu_ptr(algo->shashs, cpu);
+				kfree(shash);
+			}
+			free_percpu(algo->shashs);
+		}
+
+		if (algo->tfms) {
+			for_each_possible_cpu(cpu) {
+				tfm = *per_cpu_ptr(algo->tfms, cpu);
+				crypto_free_shash(tfm);
+			}
+			free_percpu(algo->tfms);
 		}
-		free_percpu(algo->tfms);
-		free_percpu(algo->shashs);
 	}
 }
 EXPORT_SYMBOL(seg6_hmac_exit);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 8c9672e7a7dd..203a6d64d7e9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -67,11 +67,12 @@ int udpv6_init_sock(struct sock *sk)
 	return 0;
 }
 
-static u32 udp6_ehashfn(const struct net *net,
-			const struct in6_addr *laddr,
-			const u16 lport,
-			const struct in6_addr *faddr,
-			const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp6_ehashfn(const struct net *net,
+		 const struct in6_addr *laddr,
+		 const u16 lport,
+		 const struct in6_addr *faddr,
+		 const __be16 fport)
 {
 	static u32 udp6_ehash_secret __read_mostly;
 	static u32 udp_ipv6_hash_secret __read_mostly;
@@ -155,24 +156,6 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     const struct in6_addr *saddr,
-				     __be16 sport,
-				     const struct in6_addr *daddr,
-				     unsigned int hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -182,15 +165,28 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (need_rescore)
+				continue;
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+							saddr, sport, daddr, hnum, udp6_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -204,8 +200,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(sk, net, saddr, sport,
-						daddr, hnum, dif, sdif);
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
@@ -230,7 +232,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					  saddr, sport, daddr, hnum, udp6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 858d09b54eaa..f3cb5c920276 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6234,11 +6234,15 @@ static int nft_object_dump(struct sk_buff *skb, unsigned int attr,
 	return -1;
 }
 
-static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
+static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	list_for_each_entry(type, &nf_tables_objects, list) {
+	list_for_each_entry_rcu(type, &nf_tables_objects, list) {
+		if (type->family != NFPROTO_UNSPEC &&
+		    type->family != family)
+			continue;
+
 		if (objtype == type->type)
 			return type;
 	}
@@ -6246,13 +6250,17 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype)
 }
 
 static const struct nft_object_type *
-nft_obj_type_get(struct net *net, u32 objtype)
+nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	type = __nft_obj_type_get(objtype);
-	if (type != NULL && try_module_get(type->owner))
+	rcu_read_lock();
+	type = __nft_obj_type_get(objtype, family);
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
@@ -6343,7 +6351,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		type = __nft_obj_type_get(objtype);
+		type = __nft_obj_type_get(objtype, family);
 		nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
 		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
@@ -6354,7 +6362,7 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
 	if (!nft_use_inc(&table->use))
 		return -EMFILE;
 
-	type = nft_obj_type_get(net, objtype);
+	type = nft_obj_type_get(net, objtype, family);
 	if (IS_ERR(type)) {
 		err = PTR_ERR(type);
 		goto err_type;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 9d87606c76ff..dc6af1919dea 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -167,7 +167,9 @@ instance_destroy_rcu(struct rcu_head *head)
 	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
 						   rcu);
 
+	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
+	rcu_read_unlock();
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 56f6c05362ae..fa64b1b8ae91 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -44,36 +44,27 @@ nft_payload_copy_vlan(u32 *d, const struct sk_buff *skb, u8 offset, u8 len)
 	int mac_off = skb_mac_header(skb) - skb->data;
 	u8 *vlanh, *dst_u8 = (u8 *) d;
 	struct vlan_ethhdr veth;
-	u8 vlan_hlen = 0;
-
-	if ((skb->protocol == htons(ETH_P_8021AD) ||
-	     skb->protocol == htons(ETH_P_8021Q)) &&
-	    offset >= VLAN_ETH_HLEN && offset < VLAN_ETH_HLEN + VLAN_HLEN)
-		vlan_hlen += VLAN_HLEN;
 
 	vlanh = (u8 *) &veth;
-	if (offset < VLAN_ETH_HLEN + vlan_hlen) {
+	if (offset < VLAN_ETH_HLEN) {
 		u8 ethlen = len;
 
-		if (vlan_hlen &&
-		    skb_copy_bits(skb, mac_off, &veth, VLAN_ETH_HLEN) < 0)
-			return false;
-		else if (!nft_payload_rebuild_vlan_hdr(skb, mac_off, &veth))
+		if (!nft_payload_rebuild_vlan_hdr(skb, mac_off, &veth))
 			return false;
 
-		if (offset + len > VLAN_ETH_HLEN + vlan_hlen)
-			ethlen -= offset + len - VLAN_ETH_HLEN - vlan_hlen;
+		if (offset + len > VLAN_ETH_HLEN)
+			ethlen -= offset + len - VLAN_ETH_HLEN;
 
-		memcpy(dst_u8, vlanh + offset - vlan_hlen, ethlen);
+		memcpy(dst_u8, vlanh + offset, ethlen);
 
 		len -= ethlen;
 		if (len == 0)
 			return true;
 
 		dst_u8 += ethlen;
-		offset = ETH_HLEN + vlan_hlen;
+		offset = ETH_HLEN;
 	} else {
-		offset -= VLAN_HLEN + vlan_hlen;
+		offset -= VLAN_HLEN;
 	}
 
 	return skb_copy_bits(skb, offset + mac_off, dst_u8, len) == 0;
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 2ee50996da8c..c8822fa8196d 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -684,6 +684,7 @@ static const struct nft_object_ops nft_tunnel_obj_ops = {
 
 static struct nft_object_type nft_tunnel_obj_type __read_mostly = {
 	.type		= NFT_OBJECT_TUNNEL,
+	.family		= NFPROTO_NETDEV,
 	.ops		= &nft_tunnel_obj_ops,
 	.maxattr	= NFTA_TUNNEL_KEY_MAX,
 	.policy		= nft_tunnel_key_policy,
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 895702337c92..9269b5e69b9a 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -284,22 +284,14 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	return 0;
 }
 
-static inline void __nr_remove_node(struct nr_node *nr_node)
+static void nr_remove_node_locked(struct nr_node *nr_node)
 {
+	lockdep_assert_held(&nr_node_list_lock);
+
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-#define nr_remove_node_locked(__node) \
-	__nr_remove_node(__node)
-
-static void nr_remove_node(struct nr_node *nr_node)
-{
-	spin_lock_bh(&nr_node_list_lock);
-	__nr_remove_node(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
-}
-
 static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
 {
 	hlist_del_init(&nr_neigh->neigh_node);
@@ -338,6 +330,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
@@ -351,7 +344,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_node->count--;
 
 			if (nr_node->count == 0) {
-				nr_remove_node(nr_node);
+				nr_remove_node_locked(nr_node);
 			} else {
 				switch (i) {
 				case 0:
@@ -365,12 +358,14 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				nr_node_put(nr_node);
 			}
 			nr_node_unlock(nr_node);
+			spin_unlock_bh(&nr_node_list_lock);
 
 			return 0;
 		}
 	}
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index d8002065baae..3182b4228cfa 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1452,6 +1452,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb)
+{
+	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
+	BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+
+	if (skb->len < hdr_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < hdr_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1502,9 +1515,9 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			break;
+			continue;
 		}
 
 		/* Process frame */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 80fee9d118ee..4095456f413d 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -923,6 +923,12 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		/* Need to set the pkt_type to involve the routing layer.  The
+		 * packet movement through the OVS datapath doesn't generally
+		 * use routing, but this is needed for tunnel cases.
+		 */
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index c9ba61413c98..9bad601c7fe8 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -412,7 +412,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 	 */
 	key->tp.src = htons(icmp->icmp6_type);
 	key->tp.dst = htons(icmp->icmp6_code);
-	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
 
 	if (icmp->icmp6_code == 0 &&
 	    (icmp->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
@@ -421,6 +420,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 		struct nd_msg *nd;
 		int offset;
 
+		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
+
 		/* In order to process neighbor discovery options, we need the
 		 * entire packet.
 		 */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index db5d16c5d5b1..8e52f0949305 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2487,8 +2487,7 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
-		if (!packet_read_pending(&po->tx_ring))
-			complete(&po->skb_completion);
+		complete(&po->skb_completion);
 	}
 
 	sock_wfree(skb);
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 71c2295d4a57..29c0886eb9ef 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1279,13 +1279,19 @@ static int __init qrtr_proto_init(void)
 		return rc;
 
 	rc = sock_register(&qrtr_family);
-	if (rc) {
-		proto_unregister(&qrtr_proto);
-		return rc;
-	}
+	if (rc)
+		goto err_proto;
 
-	qrtr_ns_init();
+	rc = qrtr_ns_init();
+	if (rc)
+		goto err_sock;
 
+	return 0;
+
+err_sock:
+	sock_unregister(qrtr_family.family);
+err_proto:
+	proto_unregister(&qrtr_proto);
 	return rc;
 }
 postcore_initcall(qrtr_proto_init);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index c92dd960bfef..1da34d54092b 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -771,7 +771,7 @@ static void qrtr_ns_data_ready(struct sock *sk)
 	queue_work(qrtr_ns.workqueue, &qrtr_ns.work);
 }
 
-void qrtr_ns_init(void)
+int qrtr_ns_init(void)
 {
 	struct sockaddr_qrtr sq;
 	int ret;
@@ -782,7 +782,7 @@ void qrtr_ns_init(void)
 	ret = sock_create_kern(&init_net, AF_QIPCRTR, SOCK_DGRAM,
 			       PF_QIPCRTR, &qrtr_ns.sock);
 	if (ret < 0)
-		return;
+		return ret;
 
 	ret = kernel_getsockname(qrtr_ns.sock, (struct sockaddr *)&sq);
 	if (ret < 0) {
@@ -815,12 +815,31 @@ void qrtr_ns_init(void)
 	if (ret < 0)
 		goto err_wq;
 
-	return;
+	/* As the qrtr ns socket owner and creator is the same module, we have
+	 * to decrease the qrtr module reference count to guarantee that it
+	 * remains zero after the ns socket is created, otherwise, executing
+	 * "rmmod" command is unable to make the qrtr module deleted after the
+	 *  qrtr module is inserted successfully.
+	 *
+	 * However, the reference count is increased twice in
+	 * sock_create_kern(): one is to increase the reference count of owner
+	 * of qrtr socket's proto_ops struct; another is to increment the
+	 * reference count of owner of qrtr proto struct. Therefore, we must
+	 * decrement the module reference count twice to ensure that it keeps
+	 * zero after server's listening socket is created. Of course, we
+	 * must bump the module reference count twice as well before the socket
+	 * is closed.
+	 */
+	module_put(qrtr_ns.sock->ops->owner);
+	module_put(qrtr_ns.sock->sk->sk_prot_creator->owner);
+
+	return 0;
 
 err_wq:
 	destroy_workqueue(qrtr_ns.workqueue);
 err_sock:
 	sock_release(qrtr_ns.sock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(qrtr_ns_init);
 
@@ -828,6 +847,15 @@ void qrtr_ns_remove(void)
 {
 	cancel_work_sync(&qrtr_ns.work);
 	destroy_workqueue(qrtr_ns.workqueue);
+
+	/* sock_release() expects the two references that were put during
+	 * qrtr_ns_init(). This function is only called during module remove,
+	 * so try_stop_module() has already set the refcnt to 0. Use
+	 * __module_get() instead of try_module_get() to successfully take two
+	 * references.
+	 */
+	__module_get(qrtr_ns.sock->ops->owner);
+	__module_get(qrtr_ns.sock->sk->sk_prot_creator->owner);
 	sock_release(qrtr_ns.sock);
 }
 EXPORT_SYMBOL_GPL(qrtr_ns_remove);
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index dc2b67f17927..3f2d28696062 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -29,7 +29,7 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep);
 
 int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len);
 
-void qrtr_ns_init(void);
+int qrtr_ns_init(void);
 
 void qrtr_ns_remove(void);
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 406ff7f8b156..784c8b24f164 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1126,17 +1126,11 @@ gss_read_verf(struct rpc_gss_wire_cred *gc,
 
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 {
-	u32 inlen;
 	int i;
 
 	i = 0;
-	inlen = in_token->page_len;
-	while (inlen) {
-		if (in_token->pages[i])
-			put_page(in_token->pages[i]);
-		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
-	}
-
+	while (in_token->pages[i])
+		put_page(in_token->pages[i++]);
 	kfree(in_token->pages);
 	in_token->pages = NULL;
 }
@@ -1162,7 +1156,7 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	pages = DIV_ROUND_UP(inlen, PAGE_SIZE);
-	in_token->pages = kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
+	in_token->pages = kcalloc(pages + 1, sizeof(struct page *), GFP_KERNEL);
 	if (!in_token->pages) {
 		kfree(in_handle->data);
 		return SVC_DENIED;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a5ce9b937c42..196a3b11d150 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -970,6 +970,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
 		.stats		= old->cl_stats,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 495ebe7fad6d..cfe8b911ca01 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1248,8 +1248,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argsize);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index d015576f3081..9e9df38b29f7 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -268,7 +268,11 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
-		fallthrough;
+		switch (xchg(&ep->re_connect_status, -ENODEV)) {
+		case 0: goto wake_connect_worker;
+		case 1: goto disconnected;
+		}
+		return 0;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		goto disconnected;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index ae5b5380f0f0..0666f981618a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3166,24 +3166,6 @@ void cleanup_socket_xprt(void)
 	xprt_unregister_transport(&xs_bc_tcp_transport);
 }
 
-static int param_set_uint_minmax(const char *val,
-		const struct kernel_param *kp,
-		unsigned int min, unsigned int max)
-{
-	unsigned int num;
-	int ret;
-
-	if (!val)
-		return -EINVAL;
-	ret = kstrtouint(val, 0, &num);
-	if (ret)
-		return ret;
-	if (num < min || num > max)
-		return -EINVAL;
-	*((unsigned int *)kp->arg) = num;
-	return 0;
-}
-
 static int param_set_portnr(const char *val, const struct kernel_param *kp)
 {
 	return param_set_uint_minmax(val, kp,
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 2bbacd9b97e5..ebf856cf821d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -633,9 +633,17 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 		return NULL;
 
 	mutex_init(&ctx->tx_lock);
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
 	ctx->sk = sk;
+	/* Release semantic of rcu_assign_pointer() ensures that
+	 * ctx->sk_proto is visible before changing sk->sk_prot in
+	 * update_sk_prot(), and prevents reading uninitialized value in
+	 * tls_{getsockopt, setsockopt}. Note that we do not need a
+	 * read barrier in tls_{getsockopt,setsockopt} as there is an
+	 * address dependency between sk->sk_proto->{getsockopt,setsockopt}
+	 * and ctx->sk_proto.
+	 */
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	return ctx;
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 224b1fdc8227..3ab726a668e8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1918,7 +1918,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index edc824c103e8..06e81d1efc92 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1660,7 +1660,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1677,7 +1677,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 664d55957feb..fadb309b25b4 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3807,15 +3807,10 @@ static void xfrm_link_failure(struct sk_buff *skb)
 	/* Impossible. Such dst must be popped before reaches point of failure. */
 }
 
-static struct dst_entry *xfrm_negative_advice(struct dst_entry *dst)
+static void xfrm_negative_advice(struct sock *sk, struct dst_entry *dst)
 {
-	if (dst) {
-		if (dst->obsolete) {
-			dst_release(dst);
-			dst = NULL;
-		}
-	}
-	return dst;
+	if (dst->obsolete)
+		sk_dst_reset(sk);
 }
 
 static void xfrm_init_pmtu(struct xfrm_dst **bundle, int nr)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a2056fa80de2..ff4c5d314b4d 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -13,18 +13,21 @@
 
 struct symbol symbol_yes = {
 	.name = "y",
+	.type = S_TRISTATE,
 	.curr = { "y", yes },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_mod = {
 	.name = "m",
+	.type = S_TRISTATE,
 	.curr = { "m", mod },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_no = {
 	.name = "n",
+	.type = S_TRISTATE,
 	.curr = { "n", no },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
@@ -776,8 +779,7 @@ const char *sym_get_string_value(struct symbol *sym)
 		case no:
 			return "n";
 		case mod:
-			sym_calc_value(modules_sym);
-			return (modules_sym->curr.tri == no) ? "n" : "m";
+			return "m";
 		case yes:
 			return "y";
 		}
diff --git a/sound/core/init.c b/sound/core/init.c
index 9f5270c90a10..b6dd43005c27 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -206,8 +206,8 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	card->number = idx;
 #ifdef MODULE
 	WARN_ON(!module);
-	card->module = module;
 #endif
+	card->module = module;
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 764d2b19344e..708c9a46eefe 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -553,6 +553,16 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 		goto unlock;
 	}
 
+	/* check the actual time for the start tick;
+	 * bail out as error if it's way too low (< 100us)
+	 */
+	if (start) {
+		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
+			result = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	if (start)
 		timeri->ticks = timeri->cticks = ticks;
 	else if (!timeri->cticks)
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index b6030709b6b6..2fb26dd84bc7 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -629,8 +629,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -705,6 +707,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 5db63ef33f1a..ac403827a229 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -414,6 +414,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_hp_det;
+	struct gpio_desc *gpiod_cbj_sleeve;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
@@ -3169,6 +3170,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, 0);
 
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 1);
+
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
@@ -3185,6 +3189,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
+			if (rt5645->gpiod_cbj_sleeve)
+				gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 		}
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
@@ -3210,6 +3216,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 	}
 
 	return rt5645->jack_type;
@@ -3882,6 +3891,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	rt5645->gpiod_cbj_sleeve = devm_gpiod_get_optional(&i2c->dev, "cbj-sleeve",
+							   GPIOD_OUT_LOW);
+
+	if (IS_ERR(rt5645->gpiod_cbj_sleeve)) {
+		ret = PTR_ERR(rt5645->gpiod_cbj_sleeve);
+		dev_info(&i2c->dev, "failed to initialize gpiod, ret=%d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
 		rt5645->supplies[i].supply = rt5645_supply_names[i];
 
@@ -4125,6 +4144,9 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 
 	return 0;
@@ -4142,6 +4164,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		0);
 	msleep(20);
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
+
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 }
 
 static struct i2c_driver rt5645_i2c_driver = {
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 361a90ae594c..c0f09c3bcb6e 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -110,6 +110,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index bd00c35116cd..f045876c12f1 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -2,7 +2,8 @@
 /*
  * tas2552.c - ALSA SoC Texas Instruments TAS2552 Mono Audio Amplifier
  *
- * Copyright (C) 2014 Texas Instruments Incorporated -  https://www.ti.com
+ * Copyright (C) 2014 - 2024 Texas Instruments Incorporated -
+ *	https://www.ti.com
  *
  * Author: Dan Murphy <dmurphy@ti.com>
  */
@@ -119,12 +120,14 @@ static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
 			 &tas2552_input_mux_control),
 
 	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASI OUT", "DAC Capture", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUT_DRV("ClassD", TAS2552_CFG_2, 7, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PLL", TAS2552_CFG_2, 3, 0, NULL, 0),
 	SND_SOC_DAPM_POST("Post Event", tas2552_post_event),
 
-	SND_SOC_DAPM_OUTPUT("OUT")
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC")
 };
 
 static const struct snd_soc_dapm_route tas2552_audio_map[] = {
@@ -134,6 +137,7 @@ static const struct snd_soc_dapm_route tas2552_audio_map[] = {
 	{"ClassD", NULL, "Input selection"},
 	{"OUT", NULL, "ClassD"},
 	{"ClassD", NULL, "PLL"},
+	{"ASI OUT", NULL, "DMIC"}
 };
 
 #ifdef CONFIG_PM
@@ -538,6 +542,13 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = TAS2552_FORMATS,
 		},
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = TAS2552_FORMATS,
+		},
 		.ops = &tas2552_speaker_dai_ops,
 	},
 };
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 0c0a717823c4..1a24c44db6dd 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -750,6 +750,7 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 0f3157dfa838..13c41338003f 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -575,6 +575,7 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 
 };
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 62cca511522e..c1b789ac6d50 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -603,6 +603,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	card = &glk_audio_card_rt5682_m98357a;
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		card->disable_route_checks = true;
 
 	/* override plaform name, if required */
 	mach = pdev->dev.platform_data;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 36f1f49e0b76..4ecef661f883 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -571,6 +571,7 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
 	.dapm_routes = kabylake_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 884741aa4833..80c343fe7f65 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -1016,6 +1016,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1034,6 +1035,7 @@ static struct snd_soc_card kbl_audio_card_max98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1051,6 +1053,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1068,6 +1071,7 @@ static struct snd_soc_card kbl_audio_card_max98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 3a9f91b58e11..2bffd2b6b361 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -519,6 +519,7 @@ static struct snd_soc_card kabylake_audio_card_rt5660 = {
 	.dapm_routes = kabylake_rt5660_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 9a4b3d0973f6..be76c71eca67 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -948,6 +948,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -964,6 +965,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 	.dapm_routes = kabylake_5663_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index f95546c184aa..291f56f79cd3 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -779,6 +779,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index bc50eda297ab..c2ff59e9a8cf 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -229,6 +229,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		hda_soc_card.disable_route_checks = true;
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 55802900069a..d976636f5a49 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -643,6 +643,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.dapm_routes = skylake_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 5a0c64a83146..4ff3e5fb9b7d 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -524,6 +524,7 @@ static struct snd_soc_card skylake_rt286 = {
 	.dapm_routes = skylake_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..1c25c1072a84 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index f32c059fbfb4..8b2a2576fed6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -637,7 +637,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 39ebf6192016..e799d35cba43 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
+	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		char *buf = NULL;
-
 		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
 
 		for (int i = 0; subcommands[i]; i++) {
@@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-
+	if (buf) {
+		usagestr[0] = NULL;
+		free(buf);
+	}
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 427ca00a3217..85d57633c8b6 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2014,9 +2014,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index 8af25ae96049..24d8910c7ab5 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += -I../../../../../usr/include/ -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -88,7 +88,10 @@ int main(int argc, char **argv)
 		int pid2 = getpid();
 		int ret;
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		ksft_print_header();
+		ksft_set_plan(3);
+
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
@@ -152,7 +155,6 @@ int main(int argc, char **argv)
 			ksft_inc_pass_cnt();
 		}
 
-		ksft_print_cnts();
 
 		if (ret)
 			ksft_exit_fail();
@@ -162,5 +164,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	return 0;
 }

