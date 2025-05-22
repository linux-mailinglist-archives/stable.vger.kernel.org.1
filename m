Return-Path: <stable+bounces-146089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0BAC0C5D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4194D163CBB
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DE728BAAF;
	Thu, 22 May 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SjqTcHFA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345328C00C;
	Thu, 22 May 2025 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919523; cv=none; b=WqH59I7/hX6Yod9SQCukMXiAV3QULYzsjuLXqqKfR02KCEJFGgHZoXGZb7g9euSD9MhaYQ769176sULsRR9vQyUtsNpYLZnSfVvy9vXpE4mYMpCgpKyKeQsHDB/GnZ816eMaHboRnnplGX3PjT7PlLDkv45IRUTyqiJr6YMw75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919523; c=relaxed/simple;
	bh=Xx7bmj4q1TTc2QJeHUuR8rpibz/jyTHwsLFuDOUJP1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azaWGHdTb94acf5aMs4pohPSUcFswZyJRp9iRXZAAEKcdssm14blzFe0zt0nu/l6C3fAWegl7khU004WI0X3xetPUNzqNcMiphFJZzL+tDlLVAxYqOIhoI2KofTBMUNPL/HsCZP8r1q7joksLqCCJW/ROGv3U7hzt7yOtoLhY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SjqTcHFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F478C4CEED;
	Thu, 22 May 2025 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747919522;
	bh=Xx7bmj4q1TTc2QJeHUuR8rpibz/jyTHwsLFuDOUJP1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjqTcHFApigerGTtzhPA98tVP06f4ldu4ynqXYh2v26n154CkQhqozkDuPLzd/Ehu
	 AZljOEpgFiJBcpb4QvyM4eUXYb4lHq++vZJ3jmeOwoqvQckDpTJgDsuuiqsjs8J3Id
	 1fKRkHpTT2BssXcIJiN1XHZFI9HAyNFcrldQ8qf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.30
Date: Thu, 22 May 2025 15:11:47 +0200
Message-ID: <2025052246-wackiness-sneak-2b9c@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052246-dork-egotistic-7d01@gregkh>
References: <2025052246-dork-egotistic-7d01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b02d59a0349c..c5579a5412fc 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2017,7 +2017,8 @@ attribute-sets:
     attributes:
       -
         name: act
-        type: nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: police
@@ -2250,7 +2251,8 @@ attribute-sets:
     attributes:
       -
         name: act
-        type: nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: police
@@ -2745,7 +2747,7 @@ attribute-sets:
         type: u16
         byte-order: big-endian
       -
-        name: key-l2-tpv3-sid
+        name: key-l2tpv3-sid
         type: u32
         byte-order: big-endian
       -
@@ -3504,7 +3506,7 @@ attribute-sets:
         name: rate64
         type: u64
       -
-        name: prate4
+        name: prate64
         type: u64
       -
         name: burst
diff --git a/MAINTAINERS b/MAINTAINERS
index de04c7ba8571..d0f18fdba068 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17503,7 +17503,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24729,7 +24729,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24757,7 +24757,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
diff --git a/Makefile b/Makefile
index 7a06c48ffbaa..6e8afa78bbef 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 29
+SUBLEVEL = 30
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
index de35fa2d7a6d..8e3e3354ed67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-dreambox.dtsi
@@ -116,6 +116,10 @@ &arb {
 	status = "okay";
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &frddr_a {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
index b2ac2583a592..b59da91fdd04 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi
@@ -35,7 +35,6 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
-
 	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 	        compatible = "regulator-fixed";
 	        regulator-name = "VSD_3V3";
@@ -46,6 +45,16 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 	        startup-delay-us = <100>;
 	        off-on-delay-us = <12000>;
 	};
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		regulator-name = "VSD_VSEL";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		states = <3300000 0x0 1800000 0x1>;
+		vin-supply = <&ldo5>;
+	};
 };
 
 &A53_0 {
@@ -205,6 +214,7 @@ &usdhc2 {
         pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
         cd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
         vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
         bus-width = <4>;
         status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
index e3a9598b99fc..cacffc851584 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
@@ -222,6 +222,10 @@ rt5616: audio-codec@1b {
 		compatible = "realtek,rt5616";
 		reg = <0x1b>;
 		#sound-dai-cells = <0>;
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
+		clock-names = "mclk";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index bce72bac4503..3045cb3bd68c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -11,20 +11,15 @@ cluster0_opp_table: opp-table-cluster0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-1416000000 {
-			opp-hz = /bits/ 64 <1416000000>;
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <750000 750000 950000>;
 			clock-latency-ns = <40000>;
 			opp-suspend;
 		};
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <887500 887500 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-1704000000 {
-			opp-hz = /bits/ 64 <1704000000>;
-			opp-microvolt = <937500 937500 950000>;
+		opp-1296000000 {
+			opp-hz = /bits/ 64 <1296000000>;
+			opp-microvolt = <775000 775000 950000>;
 			clock-latency-ns = <40000>;
 		};
 	};
@@ -33,9 +28,14 @@ cluster1_opp_table: opp-table-cluster1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-1200000000{
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <750000 750000 950000>;
+			opp-microvolt = <762500 762500 950000>;
 			clock-latency-ns = <40000>;
 		};
 		opp-1608000000 {
@@ -43,25 +43,20 @@ opp-1608000000 {
 			opp-microvolt = <787500 787500 950000>;
 			clock-latency-ns = <40000>;
 		};
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <875000 875000 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-2016000000 {
-			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	cluster2_opp_table: opp-table-cluster2 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
+		opp-1200000000{
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <750000 750000 950000>;
+			clock-latency-ns = <40000>;
+		};
 		opp-1416000000 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <750000 750000 950000>;
+			opp-microvolt = <762500 762500 950000>;
 			clock-latency-ns = <40000>;
 		};
 		opp-1608000000 {
@@ -69,16 +64,6 @@ opp-1608000000 {
 			opp-microvolt = <787500 787500 950000>;
 			clock-latency-ns = <40000>;
 		};
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <875000 875000 950000>;
-			clock-latency-ns = <40000>;
-		};
-		opp-2016000000 {
-			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <950000 950000 950000>;
-			clock-latency-ns = <40000>;
-		};
 	};
 
 	gpu_opp_table: opp-table {
@@ -104,10 +89,6 @@ opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <750000 750000 850000>;
 		};
-		opp-850000000 {
-			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <787500 787500 850000>;
-		};
 	};
 };
 
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index a5b63c84f854..e5d21e836d99 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -55,7 +55,7 @@ static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long v
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last) - sizeof(unsigned long))
 
 /**
  * regs_get_register() - get register value from its offset
diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/include/asm/uprobes.h
index 99a0d198927f..025fc3f0a102 100644
--- a/arch/loongarch/include/asm/uprobes.h
+++ b/arch/loongarch/include/asm/uprobes.h
@@ -15,7 +15,6 @@ typedef u32 uprobe_opcode_t;
 #define UPROBE_XOLBP_INSN	__emit_break(BRK_UPROBE_XOLBP)
 
 struct arch_uprobe {
-	unsigned long	resume_era;
 	u32	insn[2];
 	u32	ixol[2];
 	bool	simulate;
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 4f0912141781..733a7665e434 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -16,6 +16,7 @@
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
 
+	.section .cpuidle.text, "ax"
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
 	/* start of idle interrupt region */
@@ -31,14 +32,16 @@ SYM_FUNC_START(__arch_cpu_idle)
 	 */
 	idle	0
 	/* end of idle interrupt region */
-1:	jr	ra
+idle_exit:
+	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
+	.previous
 
 SYM_CODE_START(handle_vint)
 	UNWIND_HINT_UNDEFINED
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, 1b
+	la_abs	t1, idle_exit
 	LONG_L	t0, sp, PT_ERA
 	/* 3 instructions idle interrupt region */
 	ori	t0, t0, 0b1100
diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
index ec5b28e570c9..4c476904227f 100644
--- a/arch/loongarch/kernel/kfpu.c
+++ b/arch/loongarch/kernel/kfpu.c
@@ -18,11 +18,28 @@ static unsigned int euen_mask = CSR_EUEN_FPEN;
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 static DEFINE_PER_CPU(unsigned int, euen_current);
 
+static inline void fpregs_lock(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		local_bh_disable();
+}
+
+static inline void fpregs_unlock(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		local_bh_enable();
+}
+
 void kernel_fpu_begin(void)
 {
 	unsigned int *euen_curr;
 
-	preempt_disable();
+	if (!irqs_disabled())
+		fpregs_lock();
 
 	WARN_ON(this_cpu_read(in_kernel_fpu));
 
@@ -73,7 +90,8 @@ void kernel_fpu_end(void)
 
 	this_cpu_write(in_kernel_fpu, false);
 
-	preempt_enable();
+	if (!irqs_disabled())
+		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 46d7d40c87e3..0535e5ddbfb9 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -111,7 +111,7 @@ static unsigned long __init get_loops_per_jiffy(void)
 	return lpj;
 }
 
-static long init_offset __nosavedata;
+static long init_offset;
 
 void save_counter(void)
 {
diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/uprobes.c
index 87abc7137b73..6022eb0f71db 100644
--- a/arch/loongarch/kernel/uprobes.c
+++ b/arch/loongarch/kernel/uprobes.c
@@ -42,7 +42,6 @@ int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	utask->autask.saved_trap_nr = current->thread.trap_nr;
 	current->thread.trap_nr = UPROBE_TRAP_NR;
 	instruction_pointer_set(regs, utask->xol_vaddr);
-	user_enable_single_step(current);
 
 	return 0;
 }
@@ -53,13 +52,7 @@ int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 	WARN_ON_ONCE(current->thread.trap_nr != UPROBE_TRAP_NR);
 	current->thread.trap_nr = utask->autask.saved_trap_nr;
-
-	if (auprobe->simulate)
-		instruction_pointer_set(regs, auprobe->resume_era);
-	else
-		instruction_pointer_set(regs, utask->vaddr + LOONGARCH_INSN_SIZE);
-
-	user_disable_single_step(current);
+	instruction_pointer_set(regs, utask->vaddr + LOONGARCH_INSN_SIZE);
 
 	return 0;
 }
@@ -70,7 +63,6 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 	current->thread.trap_nr = utask->autask.saved_trap_nr;
 	instruction_pointer_set(regs, utask->vaddr);
-	user_disable_single_step(current);
 }
 
 bool arch_uprobe_xol_was_trapped(struct task_struct *t)
@@ -90,7 +82,6 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 
 	insn.word = auprobe->insn[0];
 	arch_simulate_insn(insn, regs);
-	auprobe->resume_era = regs->csr_era;
 
 	return true;
 }
diff --git a/arch/loongarch/power/hibernate.c b/arch/loongarch/power/hibernate.c
index 1e0590542f98..e7b7346592cb 100644
--- a/arch/loongarch/power/hibernate.c
+++ b/arch/loongarch/power/hibernate.c
@@ -2,6 +2,7 @@
 #include <asm/fpu.h>
 #include <asm/loongson.h>
 #include <asm/sections.h>
+#include <asm/time.h>
 #include <asm/tlbflush.h>
 #include <linux/suspend.h>
 
@@ -14,6 +15,7 @@ struct pt_regs saved_regs;
 
 void save_processor_state(void)
 {
+	save_counter();
 	saved_crmd = csr_read32(LOONGARCH_CSR_CRMD);
 	saved_prmd = csr_read32(LOONGARCH_CSR_PRMD);
 	saved_euen = csr_read32(LOONGARCH_CSR_EUEN);
@@ -26,6 +28,7 @@ void save_processor_state(void)
 
 void restore_processor_state(void)
 {
+	sync_counter();
 	csr_write32(saved_crmd, LOONGARCH_CSR_CRMD);
 	csr_write32(saved_prmd, LOONGARCH_CSR_PRMD);
 	csr_write32(saved_euen, LOONGARCH_CSR_EUEN);
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index b724fb6d9689..b8063ba6d6d7 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -309,7 +309,7 @@ dmac: dma-controller@4330000 {
 					   1024 1024 1024 1024>;
 			snps,priority = <0 1 2 3 4 5 6 7>;
 			snps,dma-masters = <2>;
-			snps,data-width = <4>;
+			snps,data-width = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9242c0649adf..4607610ef062 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7616,9 +7616,30 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 }
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				int level)
+{
+	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_clear_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+				 int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage &= ~KVM_LPAGE_MIXED_FLAG;
+}
+
+static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level)
+{
+	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
+}
+
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range)
 {
+	struct kvm_memory_slot *slot = range->slot;
+	int level;
+
 	/*
 	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
 	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
@@ -7633,27 +7654,49 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
 		return false;
 
-	return kvm_unmap_gfn_range(kvm, range);
-}
+	if (WARN_ON_ONCE(range->end <= range->start))
+		return false;
 
-static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-				int level)
-{
-	return lpage_info_slot(gfn, slot, level)->disallow_lpage & KVM_LPAGE_MIXED_FLAG;
-}
+	/*
+	 * If the head and tail pages of the range currently allow a hugepage,
+	 * i.e. reside fully in the slot and don't have mixed attributes, then
+	 * add each corresponding hugepage range to the ongoing invalidation,
+	 * e.g. to prevent KVM from creating a hugepage in response to a fault
+	 * for a gfn whose attributes aren't changing.  Note, only the range
+	 * of gfns whose attributes are being modified needs to be explicitly
+	 * unmapped, as that will unmap any existing hugepages.
+	 */
+	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		gfn_t start = gfn_round_for_level(range->start, level);
+		gfn_t end = gfn_round_for_level(range->end - 1, level);
+		gfn_t nr_pages = KVM_PAGES_PER_HPAGE(level);
 
-static void hugepage_clear_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-				 int level)
-{
-	lpage_info_slot(gfn, slot, level)->disallow_lpage &= ~KVM_LPAGE_MIXED_FLAG;
-}
+		if ((start != range->start || start + nr_pages > range->end) &&
+		    start >= slot->base_gfn &&
+		    start + nr_pages <= slot->base_gfn + slot->npages &&
+		    !hugepage_test_mixed(slot, start, level))
+			kvm_mmu_invalidate_range_add(kvm, start, start + nr_pages);
 
-static void hugepage_set_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-			       int level)
-{
-	lpage_info_slot(gfn, slot, level)->disallow_lpage |= KVM_LPAGE_MIXED_FLAG;
+		if (end == start)
+			continue;
+
+		if ((end + nr_pages) > range->end &&
+		    (end + nr_pages) <= (slot->base_gfn + slot->npages) &&
+		    !hugepage_test_mixed(slot, end, level))
+			kvm_mmu_invalidate_range_add(kvm, end, end + nr_pages);
+	}
+
+	/* Unmap the old attribute page. */
+	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		range->attr_filter = KVM_FILTER_SHARED;
+	else
+		range->attr_filter = KVM_FILTER_PRIVATE;
+
+	return kvm_unmap_gfn_range(kvm, range);
 }
 
+
+
 static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 			       gfn_t gfn, int level, unsigned long attrs)
 {
diff --git a/block/bio.c b/block/bio.c
index 43d4ae26f475..20c74696bf23 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -611,7 +611,7 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 {
 	struct bio *bio;
 
-	if (nr_vecs > UIO_MAXIOV)
+	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
 	return kmalloc(struct_size(bio, bi_inline_vecs, nr_vecs), gfp_mask);
 }
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index eccedb0c8886..05a0d99ce95c 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -201,7 +201,7 @@ fw_log_fops_write(struct file *file, const char __user *user_buf, size_t size, l
 	if (!size)
 		return -EINVAL;
 
-	ivpu_fw_log_clear(vdev);
+	ivpu_fw_log_mark_read(vdev);
 	return size;
 }
 
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 8a9395a2abb5..d12188730ac7 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -218,7 +218,7 @@ static int ivpu_fw_parse(struct ivpu_device *vdev)
 	fw->cold_boot_entry_point = fw_hdr->entry_point;
 	fw->entry_point = fw->cold_boot_entry_point;
 
-	fw->trace_level = min_t(u32, ivpu_log_level, IVPU_FW_LOG_FATAL);
+	fw->trace_level = min_t(u32, ivpu_fw_log_level, IVPU_FW_LOG_FATAL);
 	fw->trace_destination_mask = VPU_TRACE_DESTINATION_VERBOSE_TRACING;
 	fw->trace_hw_component_mask = -1;
 
@@ -323,7 +323,7 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 		goto err_free_fw_mem;
 	}
 
-	if (ivpu_log_level <= IVPU_FW_LOG_INFO)
+	if (ivpu_fw_log_level <= IVPU_FW_LOG_INFO)
 		log_verb_size = IVPU_FW_VERBOSE_BUFFER_LARGE_SIZE;
 	else
 		log_verb_size = IVPU_FW_VERBOSE_BUFFER_SMALL_SIZE;
diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index ef0adb5e0fbe..337c906b0210 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #include <linux/ctype.h>
@@ -15,19 +15,19 @@
 #include "ivpu_fw_log.h"
 #include "ivpu_gem.h"
 
-#define IVPU_FW_LOG_LINE_LENGTH	  256
+#define IVPU_FW_LOG_LINE_LENGTH	256
 
-unsigned int ivpu_log_level = IVPU_FW_LOG_ERROR;
-module_param(ivpu_log_level, uint, 0444);
-MODULE_PARM_DESC(ivpu_log_level,
-		 "NPU firmware default trace level: debug=" __stringify(IVPU_FW_LOG_DEBUG)
+unsigned int ivpu_fw_log_level = IVPU_FW_LOG_ERROR;
+module_param_named(fw_log_level, ivpu_fw_log_level, uint, 0444);
+MODULE_PARM_DESC(fw_log_level,
+		 "NPU firmware default log level: debug=" __stringify(IVPU_FW_LOG_DEBUG)
 		 " info=" __stringify(IVPU_FW_LOG_INFO)
 		 " warn=" __stringify(IVPU_FW_LOG_WARN)
 		 " error=" __stringify(IVPU_FW_LOG_ERROR)
 		 " fatal=" __stringify(IVPU_FW_LOG_FATAL));
 
-static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
-		      struct vpu_tracing_buffer_header **log_header)
+static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
+			  struct vpu_tracing_buffer_header **out_log)
 {
 	struct vpu_tracing_buffer_header *log;
 
@@ -48,7 +48,7 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
 		return -EINVAL;
 	}
 
-	*log_header = log;
+	*out_log = log;
 	*offset += log->size;
 
 	ivpu_dbg(vdev, FW_BOOT,
@@ -59,7 +59,7 @@ static int fw_log_ptr(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *offset,
 	return 0;
 }
 
-static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
+static void fw_log_print_lines(char *buffer, u32 size, struct drm_printer *p)
 {
 	char line[IVPU_FW_LOG_LINE_LENGTH];
 	u32 index = 0;
@@ -87,56 +87,89 @@ static void buffer_print(char *buffer, u32 size, struct drm_printer *p)
 	}
 	line[index] = 0;
 	if (index != 0)
-		drm_printf(p, "%s\n", line);
+		drm_printf(p, "%s", line);
 }
 
-static void fw_log_print_buffer(struct ivpu_device *vdev, struct vpu_tracing_buffer_header *log,
-				const char *prefix, bool only_new_msgs, struct drm_printer *p)
+static void fw_log_print_buffer(struct vpu_tracing_buffer_header *log, const char *prefix,
+				bool only_new_msgs, struct drm_printer *p)
 {
-	char *log_buffer = (void *)log + log->header_size;
-	u32 log_size = log->size - log->header_size;
-	u32 log_start = log->read_index;
-	u32 log_end = log->write_index;
-
-	if (!(log->write_index || log->wrap_count) ||
-	    (log->write_index == log->read_index && only_new_msgs)) {
-		drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
-		return;
+	char *log_data = (void *)log + log->header_size;
+	u32 data_size = log->size - log->header_size;
+	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
+	u32 log_end = READ_ONCE(log->write_index);
+
+	if (log->wrap_count == log->read_wrap_count) {
+		if (log_end <= log_start) {
+			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
+			return;
+		}
+	} else if (log->wrap_count == log->read_wrap_count + 1) {
+		if (log_end > log_start)
+			log_start = log_end;
+	} else {
+		log_start = log_end;
 	}
 
 	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
-	if (log->write_index > log->read_index) {
-		buffer_print(log_buffer + log_start, log_end - log_start, p);
+	if (log_end > log_start) {
+		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
 	} else {
-		buffer_print(log_buffer + log_end, log_size - log_end, p);
-		buffer_print(log_buffer, log_end, p);
+		fw_log_print_lines(log_data + log_start, data_size - log_start, p);
+		fw_log_print_lines(log_data, log_end, p);
 	}
-	drm_printf(p, "\x1b[0m");
+	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
 	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
 }
 
-void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
+static void
+fw_log_print_all_in_bo(struct ivpu_device *vdev, const char *name,
+		       struct ivpu_bo *bo, bool only_new_msgs, struct drm_printer *p)
 {
-	struct vpu_tracing_buffer_header *log_header;
+	struct vpu_tracing_buffer_header *log;
 	u32 next = 0;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "NPU critical", only_new_msgs, p);
+	while (fw_log_from_bo(vdev, bo, &next, &log) == 0)
+		fw_log_print_buffer(log, name, only_new_msgs, p);
+}
+
+void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p)
+{
+	fw_log_print_all_in_bo(vdev, "NPU critical", vdev->fw->mem_log_crit, only_new_msgs, p);
+	fw_log_print_all_in_bo(vdev, "NPU verbose", vdev->fw->mem_log_verb, only_new_msgs, p);
+}
+
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev)
+{
+	struct vpu_tracing_buffer_header *log;
+	u32 next;
+
+	next = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
+		log->read_index = READ_ONCE(log->write_index);
+		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		fw_log_print_buffer(vdev, log_header, "NPU verbose", only_new_msgs, p);
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
+		log->read_index = READ_ONCE(log->write_index);
+		log->read_wrap_count = READ_ONCE(log->wrap_count);
+	}
 }
 
-void ivpu_fw_log_clear(struct ivpu_device *vdev)
+void ivpu_fw_log_reset(struct ivpu_device *vdev)
 {
-	struct vpu_tracing_buffer_header *log_header;
-	u32 next = 0;
+	struct vpu_tracing_buffer_header *log;
+	u32 next;
 
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_crit, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	next = 0;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_crit, &next, &log) == 0) {
+		log->read_index = 0;
+		log->read_wrap_count = 0;
+	}
 
 	next = 0;
-	while (fw_log_ptr(vdev, vdev->fw->mem_log_verb, &next, &log_header) == 0)
-		log_header->read_index = log_header->write_index;
+	while (fw_log_from_bo(vdev, vdev->fw->mem_log_verb, &next, &log) == 0) {
+		log->read_index = 0;
+		log->read_wrap_count = 0;
+	}
 }
diff --git a/drivers/accel/ivpu/ivpu_fw_log.h b/drivers/accel/ivpu/ivpu_fw_log.h
index 4b390a99699d..8bb528a73cb7 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.h
+++ b/drivers/accel/ivpu/ivpu_fw_log.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #ifndef __IVPU_FW_LOG_H__
@@ -17,14 +17,15 @@
 #define IVPU_FW_LOG_ERROR   4
 #define IVPU_FW_LOG_FATAL   5
 
-extern unsigned int ivpu_log_level;
-
 #define IVPU_FW_VERBOSE_BUFFER_SMALL_SIZE	SZ_1M
 #define IVPU_FW_VERBOSE_BUFFER_LARGE_SIZE	SZ_8M
 #define IVPU_FW_CRITICAL_BUFFER_SIZE		SZ_512K
 
+extern unsigned int ivpu_fw_log_level;
+
 void ivpu_fw_log_print(struct ivpu_device *vdev, bool only_new_msgs, struct drm_printer *p);
-void ivpu_fw_log_clear(struct ivpu_device *vdev);
+void ivpu_fw_log_mark_read(struct ivpu_device *vdev);
+void ivpu_fw_log_reset(struct ivpu_device *vdev);
 
 
 #endif /* __IVPU_FW_LOG_H__ */
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index d1fbad78f61b..2269569bdee7 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -38,6 +38,7 @@ static void ivpu_pm_prepare_cold_boot(struct ivpu_device *vdev)
 
 	ivpu_cmdq_reset_all_contexts(vdev);
 	ivpu_ipc_reset(vdev);
+	ivpu_fw_log_reset(vdev);
 	ivpu_fw_load(vdev);
 	fw->entry_point = fw->cold_boot_entry_point;
 }
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f73ce6e13065..54676e3d82dd 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -231,16 +231,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
-	while ((unsigned long)entry + proc_sz < table_end) {
+	/* ignore subtable types that are smaller than a processor node */
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
+
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent == node_entry)
 			return 0;
 		if (entry->length == 0)
 			return 0;
+
 		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
 				     entry->length);
-
 	}
 	return 1;
 }
@@ -273,15 +275,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 
 		if (entry->length == 0) {
 			pr_warn("Invalid zero length subtable\n");
 			break;
 		}
+		/* entry->length may not equal proc_sz, revalidate the processor structure length */
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    acpi_cpu_id == cpu_node->acpi_processor_id &&
+		    (unsigned long)entry + entry->length <= table_end &&
+		    entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
 		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
 			return (struct acpi_pptt_processor *)entry;
 		}
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 84a1ad61c4ad..56b875a6b1fb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -612,8 +612,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
 
-	release_firmware(nxpdev->fw);
-	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	if (nxpdev->fw && strlen(nxpdev->fw_name)) {
+		release_firmware(nxpdev->fw);
+		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	}
 
 	if (err == 0) {
 		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b0f13c8ea79c..ecea08915730 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -40,11 +40,6 @@
  *
  * These are the usage functions:
  *
- * tpm2_start_auth_session() which allocates the opaque auth structure
- *	and gets a session from the TPM.  This must be called before
- *	any of the following functions.  The session is protected by a
- *	session_key which is derived from a random salt value
- *	encrypted to the NULL seed.
  * tpm2_end_auth_session() kills the session and frees the resources.
  *	Under normal operation this function is done by
  *	tpm_buf_check_hmac_response(), so this is only to be used on
@@ -963,16 +958,13 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
 }
 
 /**
- * tpm2_start_auth_session() - create a HMAC authentication session with the TPM
- * @chip: the TPM chip structure to create the session with
+ * tpm2_start_auth_session() - Create an a HMAC authentication session
+ * @chip:	A TPM chip
  *
- * This function loads the NULL seed from its saved context and starts
- * an authentication session on the null seed, fills in the
- * @chip->auth structure to contain all the session details necessary
- * for performing the HMAC, encrypt and decrypt operations and
- * returns.  The NULL seed is flushed before this function returns.
+ * Loads the ephemeral key (null seed), and starts an HMAC authenticated
+ * session. The null seed is flushed before the return.
  *
- * Return: zero on success or actual error encountered.
+ * Returns zero on success, or a POSIX error code.
  */
 int tpm2_start_auth_session(struct tpm_chip *chip)
 {
@@ -1024,7 +1016,7 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	/* hash algorithm for session */
 	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "start auth session");
+	rc = tpm_ret_to_err(tpm_transmit_cmd(chip, &buf, 0, "StartAuthSession"));
 	tpm2_flush_context(chip, null_key);
 
 	if (rc == TPM2_RC_SUCCESS)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 970d02c337c7..6c3aa480396b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -54,7 +54,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 5f8d010516f0..b1ef4546346d 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -320,8 +320,9 @@ void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 	count++;
 
 	dma_resv_list_set(fobj, i, fence, usage);
-	/* pointer update must be visible before we extend the num_fences */
-	smp_store_mb(fobj->num_fences, count);
+	/* fence update must be visible before we extend the num_fences */
+	smp_wmb();
+	fobj->num_fences = count;
 }
 EXPORT_SYMBOL(dma_resv_add_fence);
 
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index d891dfca358e..91b2fbc0b864 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -841,9 +841,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_timeout(thread->done_wait,
-					   done->done,
-					   msecs_to_jiffies(params->timeout));
+			wait_event_freezable_timeout(thread->done_wait,
+					done->done,
+					msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 234c1c658ec7..18997f80bdc9 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -153,6 +153,25 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
 	pci_free_irq_vectors(pdev);
 }
 
+static void idxd_clean_wqs(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
+		conf_dev = wq_confdev(wq);
+		put_device(conf_dev);
+		kfree(wq);
+	}
+	bitmap_free(idxd->wq_enable_map);
+	kfree(idxd->wqs);
+}
+
 static int idxd_setup_wqs(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -167,8 +186,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
 	if (!idxd->wq_enable_map) {
-		kfree(idxd->wqs);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_bitmap;
 	}
 
 	for (i = 0; i < idxd->max_wqs; i++) {
@@ -187,10 +206,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		conf_dev->bus = &dsa_bus_type;
 		conf_dev->type = &idxd_wq_device_type;
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
-		if (rc < 0) {
-			put_device(conf_dev);
+		if (rc < 0)
 			goto err;
-		}
 
 		mutex_init(&wq->wq_lock);
 		init_waitqueue_head(&wq->err_queue);
@@ -201,7 +218,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
-			put_device(conf_dev);
 			rc = -ENOMEM;
 			goto err;
 		}
@@ -209,9 +225,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				put_device(conf_dev);
 				rc = -ENOMEM;
-				goto err;
+				goto err_opcap_bmap;
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
@@ -222,15 +237,46 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 
 	return 0;
 
- err:
+err_opcap_bmap:
+	kfree(wq->wqcfg);
+
+err:
+	put_device(conf_dev);
+	kfree(wq);
+
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
+		if (idxd->hw.wq_cap.op_config)
+			bitmap_free(wq->opcap_bmap);
+		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
+		kfree(wq);
+
 	}
+	bitmap_free(idxd->wq_enable_map);
+
+err_bitmap:
+	kfree(idxd->wqs);
+
 	return rc;
 }
 
+static void idxd_clean_engines(struct idxd_device *idxd)
+{
+	struct idxd_engine *engine;
+	struct device *conf_dev;
+	int i;
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		conf_dev = engine_confdev(engine);
+		put_device(conf_dev);
+		kfree(engine);
+	}
+	kfree(idxd->engines);
+}
+
 static int idxd_setup_engines(struct idxd_device *idxd)
 {
 	struct idxd_engine *engine;
@@ -261,6 +307,7 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "engine%d.%d", idxd->id, engine->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(engine);
 			goto err;
 		}
 
@@ -274,10 +321,26 @@ static int idxd_setup_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
+		kfree(engine);
 	}
+	kfree(idxd->engines);
+
 	return rc;
 }
 
+static void idxd_clean_groups(struct idxd_device *idxd)
+{
+	struct idxd_group *group;
+	int i;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = idxd->groups[i];
+		put_device(group_confdev(group));
+		kfree(group);
+	}
+	kfree(idxd->groups);
+}
+
 static int idxd_setup_groups(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
@@ -308,6 +371,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
 		if (rc < 0) {
 			put_device(conf_dev);
+			kfree(group);
 			goto err;
 		}
 
@@ -332,20 +396,18 @@ static int idxd_setup_groups(struct idxd_device *idxd)
 	while (--i >= 0) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
+		kfree(group);
 	}
+	kfree(idxd->groups);
+
 	return rc;
 }
 
 static void idxd_cleanup_internals(struct idxd_device *idxd)
 {
-	int i;
-
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_groups(idxd);
+	idxd_clean_engines(idxd);
+	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
 }
 
@@ -388,7 +450,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
 static int idxd_setup_internals(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
-	int rc, i;
+	int rc;
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
@@ -419,14 +481,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
  err_evl:
 	destroy_workqueue(idxd->wq);
  err_wkq_create:
-	for (i = 0; i < idxd->max_groups; i++)
-		put_device(group_confdev(idxd->groups[i]));
+	idxd_clean_groups(idxd);
  err_group:
-	for (i = 0; i < idxd->max_engines; i++)
-		put_device(engine_confdev(idxd->engines[i]));
+	idxd_clean_engines(idxd);
  err_engine:
-	for (i = 0; i < idxd->max_wqs; i++)
-		put_device(wq_confdev(idxd->wqs[i]));
+	idxd_clean_wqs(idxd);
  err_wqs:
 	return rc;
 }
@@ -526,6 +585,17 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
+static void idxd_free(struct idxd_device *idxd)
+{
+	if (!idxd)
+		return;
+
+	put_device(idxd_confdev(idxd));
+	bitmap_free(idxd->opcap_bmap);
+	ida_free(&idxd_ida, idxd->id);
+	kfree(idxd);
+}
+
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -543,28 +613,34 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 	idxd_dev_set_type(&idxd->idxd_dev, idxd->data->type);
 	idxd->id = ida_alloc(&idxd_ida, GFP_KERNEL);
 	if (idxd->id < 0)
-		return NULL;
+		goto err_ida;
 
 	idxd->opcap_bmap = bitmap_zalloc_node(IDXD_MAX_OPCAP_BITS, GFP_KERNEL, dev_to_node(dev));
-	if (!idxd->opcap_bmap) {
-		ida_free(&idxd_ida, idxd->id);
-		return NULL;
-	}
+	if (!idxd->opcap_bmap)
+		goto err_opcap;
 
 	device_initialize(conf_dev);
 	conf_dev->parent = dev;
 	conf_dev->bus = &dsa_bus_type;
 	conf_dev->type = idxd->data->dev_type;
 	rc = dev_set_name(conf_dev, "%s%d", idxd->data->name_prefix, idxd->id);
-	if (rc < 0) {
-		put_device(conf_dev);
-		return NULL;
-	}
+	if (rc < 0)
+		goto err_name;
 
 	spin_lock_init(&idxd->dev_lock);
 	spin_lock_init(&idxd->cmd_lock);
 
 	return idxd;
+
+err_name:
+	put_device(conf_dev);
+	bitmap_free(idxd->opcap_bmap);
+err_opcap:
+	ida_free(&idxd_ida, idxd->id);
+err_ida:
+	kfree(idxd);
+
+	return NULL;
 }
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
@@ -792,7 +868,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
@@ -829,7 +905,6 @@ static void idxd_shutdown(struct pci_dev *pdev)
 static void idxd_remove(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
-	struct idxd_irq_entry *irq_entry;
 
 	idxd_unregister_devices(idxd);
 	/*
@@ -842,20 +917,12 @@ static void idxd_remove(struct pci_dev *pdev)
 	get_device(idxd_confdev(idxd));
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
-	if (device_pasid_enabled(idxd))
-		idxd_disable_system_pasid(idxd);
 	idxd_device_remove_debugfs(idxd);
-
-	irq_entry = idxd_get_ie(idxd, 0);
-	free_irq(irq_entry->vector, irq_entry);
-	pci_free_irq_vectors(pdev);
+	idxd_cleanup(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
-	pci_disable_device(pdev);
-	destroy_workqueue(idxd->wq);
-	perfmon_pmu_remove(idxd);
 	put_device(idxd_confdev(idxd));
+	idxd_free(idxd);
+	pci_disable_device(pdev);
 }
 
 static struct pci_driver idxd_pci_driver = {
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b3f27b3f9209..7d89385c3c45 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1091,8 +1091,11 @@ static void udma_check_tx_completion(struct work_struct *work)
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
+	unsigned long flags;
 
 	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
 		if (uc->desc) {
 			/* Get previous residue and time stamp */
 			residue_diff = uc->tx_drain.residue;
@@ -1127,6 +1130,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 				break;
 			}
 
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1143,6 +1148,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 
 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
@@ -4246,7 +4253,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 				      struct of_dma *ofdma)
 {
 	struct udma_dev *ud = ofdma->of_dma_data;
-	dma_cap_mask_t mask = ud->ddev.cap_mask;
 	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
@@ -4278,7 +4284,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 		}
 	}
 
-	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
+	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
 				     ofdma->of_node);
 	if (!chan) {
 		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d764a3af6346..ef3aee1cabcf 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1203,6 +1203,8 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 
 	guard(mutex)(&chip->i2c_lock);
 
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(chip);
@@ -1215,6 +1217,10 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 static void pca953x_save_context(struct pca953x_chip *chip)
 {
 	guard(mutex)(&chip->i2c_lock);
+
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b7aad43d9ad0..7edf8d67a0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -853,6 +853,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct debugfs_blob_wrapper     debugfs_discovery_blob;
@@ -1570,11 +1571,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b8d4e07d2043..bebfbc1497d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1533,22 +1533,4 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
-/**
- * amdgpu_choose_low_power_state
- *
- * @adev: amdgpu_device_pointer
- *
- * Choose the target low power state for the GPU
- */
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
-{
-	if (adev->in_runpm)
-		return;
-
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
-}
-
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index cfdf558b48b6..02138aa55793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -109,7 +109,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	int r;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24d007715a14..cb102ee71d04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -145,6 +145,8 @@ const char *amdgpu_asic_name[] = {
 };
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data);
 
 /**
  * DOC: pcie_replay_count
@@ -4519,6 +4521,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
+	r = register_pm_notifier(&adev->pm_nb);
+	if (r)
+		goto failed;
+
 	return 0;
 
 release_ras_con:
@@ -4583,6 +4590,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		drain_workqueue(adev->mman.bdev.wq);
 	adev->shutdown = true;
 
+	unregister_pm_notifier(&adev->pm_nb);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 */
@@ -4712,6 +4721,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
+ * @nb: notifier block
+ * @mode: suspend mode
+ * @data: data
+ *
+ * This function is called when the system is about to suspend or hibernate.
+ * It is used to set the appropriate flags so that eviction can be optimized
+ * in the pm prepare callback.
+ */
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data)
+{
+	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+		adev->in_s4 = true;
+		break;
+	case PM_POST_HIBERNATION:
+		adev->in_s4 = false;
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * amdgpu_device_prepare - prepare for device suspend
  *
@@ -4726,15 +4762,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
-	amdgpu_choose_low_power_state(adev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		goto unprepare;
+		return r;
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
@@ -4745,15 +4779,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
 		if (r)
-			goto unprepare;
+			return r;
 	}
 
 	return 0;
-
-unprepare:
-	adev->in_s0ix = adev->in_s3 = false;
-
-	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a9eb0927a766..1b479bd85135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2635,7 +2635,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	adev->in_s4 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	if (r)
 		return r;
@@ -2648,13 +2647,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
-
-	r = amdgpu_device_resume(drm_dev, true);
-	adev->in_s4 = false;
 
-	return r;
+	return amdgpu_device_resume(drm_dev, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -2667,9 +2661,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-
-	adev->in_s4 = false;
 
 	return amdgpu_device_resume(drm_dev, true);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4e9c23d65b02..87aaf5f1224f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -747,6 +747,18 @@ static int gmc_v11_0_sw_init(void *handle)
 	adev->gmc.vram_type = vram_type;
 	adev->gmc.vram_vendor = vram_vendor;
 
+	/* The mall_size is already calculated as mall_size_per_umc * num_umc.
+	 * However, for gfx1151, which features a 2-to-1 UMC mapping,
+	 * the result must be multiplied by 2 to determine the actual mall size.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(11, 5, 1):
+		adev->gmc.mall_size *= 2;
+		break;
+	default:
+		break;
+	}
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 66c50a09d2df..ff33760aa4fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12546,7 +12546,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length)
+	/*write req may receive a byte indicating partially written number as well*/
+	if (p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index dca8384af95d..fca0c31e14d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -62,6 +62,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	enum aux_return_code_type operation_result;
 	struct amdgpu_device *adev;
 	struct ddc_service *ddc;
+	uint8_t copy[16];
 
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
@@ -77,6 +78,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 	payload.defer_delay = 0;
 
+	if (payload.write) {
+		memcpy(copy, msg->buffer, msg->size);
+		payload.data = copy;
+	}
+
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
@@ -100,9 +106,9 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	 */
 	if (payload.write && result >= 0) {
 		if (result) {
-			/*one byte indicating partially written bytes. Force 0 to retry*/
-			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
-			result = 0;
+			/*one byte indicating partially written bytes*/
+			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
 			result = msg->size;
@@ -127,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 1236e0f9a256..712aff7e17f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -120,10 +120,11 @@ void dpp401_set_cursor_attributes(
 	enum dc_cursor_color_format color_format = cursor_attributes->color_format;
 	int cur_rom_en = 0;
 
-	// DCN4 should always do Cursor degamma for Cursor Color modes
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
 		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
-		cur_rom_en = 1;
+		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
+			cur_rom_en = 1;
+		}
 	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 51c2d742d199..7c8287c18e38 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -105,6 +105,40 @@ static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
 
 static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 					 struct drm_fb_helper_surface_size *sizes)
+{
+	return drm_fbdev_dma_driver_fbdev_probe(fb_helper, sizes);
+}
+
+static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
+					 struct drm_clip_rect *clip)
+{
+	struct drm_device *dev = helper->dev;
+	int ret;
+
+	/* Call damage handlers only if necessary */
+	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
+		return 0;
+
+	if (helper->fb->funcs->dirty) {
+		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
+		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
+	.fb_probe = drm_fbdev_dma_helper_fb_probe,
+	.fb_dirty = drm_fbdev_dma_helper_fb_dirty,
+};
+
+/*
+ * struct drm_fb_helper
+ */
+
+int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes)
 {
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
@@ -148,6 +182,7 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		goto err_drm_client_buffer_delete;
 	}
 
+	fb_helper->funcs = &drm_fbdev_dma_helper_funcs;
 	fb_helper->buffer = buffer;
 	fb_helper->fb = fb;
 
@@ -211,30 +246,7 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 	drm_client_framebuffer_delete(buffer);
 	return ret;
 }
-
-static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
-					 struct drm_clip_rect *clip)
-{
-	struct drm_device *dev = helper->dev;
-	int ret;
-
-	/* Call damage handlers only if necessary */
-	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
-		return 0;
-
-	if (helper->fb->funcs->dirty) {
-		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
-		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
-			return ret;
-	}
-
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
-	.fb_probe = drm_fbdev_dma_helper_fb_probe,
-	.fb_dirty = drm_fbdev_dma_helper_fb_dirty,
-};
+EXPORT_SYMBOL(drm_fbdev_dma_driver_fbdev_probe);
 
 /*
  * struct drm_client_funcs
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f6889f649bc1..ce17143d47a8 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -67,6 +67,7 @@ config DRM_OFDRM
 config DRM_PANEL_MIPI_DBI
 	tristate "DRM support for MIPI DBI compatible panels"
 	depends on DRM && SPI
+	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_MIPI_DBI
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index f753cdffe6f8..ac159e8127d5 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_client_setup.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -264,6 +265,7 @@ static const struct drm_driver panel_mipi_dbi_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &panel_mipi_dbi_fops,
 	DRM_GEM_DMA_DRIVER_OPS_VMAP,
+	DRM_FBDEV_DMA_DRIVER_OPS,
 	.debugfs_init		= mipi_dbi_debugfs_init,
 	.name			= "panel-mipi-dbi",
 	.desc			= "MIPI DBI compatible display panel",
@@ -388,7 +390,10 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, drm);
 
-	drm_fbdev_dma_setup(drm, 0);
+	if (bpp == 16)
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB565);
+	else
+		drm_client_setup_with_fourcc(drm, DRM_FORMAT_RGB888);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
index 10ec2920d31b..d4033278be9f 100644
--- a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
@@ -47,6 +47,10 @@
 #define   MI_LRI_FORCE_POSTED		REG_BIT(12)
 #define   MI_LRI_LEN(x)			(((x) & 0xff) + 1)
 
+#define MI_STORE_REGISTER_MEM		(__MI_INSTR(0x24) | XE_INSTR_NUM_DW(4))
+#define   MI_SRM_USE_GGTT		REG_BIT(22)
+#define   MI_SRM_ADD_CS_OFFSET		REG_BIT(19)
+
 #define MI_FLUSH_DW			__MI_INSTR(0x26)
 #define   MI_FLUSH_DW_STORE_INDEX	REG_BIT(21)
 #define   MI_INVALIDATE_TLB		REG_BIT(18)
diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 6fbea70d3d36..feb680d127e6 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -564,6 +564,28 @@ void xe_gsc_remove(struct xe_gsc *gsc)
 	xe_gsc_proxy_remove(gsc);
 }
 
+void xe_gsc_stop_prepare(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+	int ret;
+
+	if (!xe_uc_fw_is_loadable(&gsc->fw) || xe_uc_fw_is_in_error_state(&gsc->fw))
+		return;
+
+	xe_force_wake_assert_held(gt_to_fw(gt), XE_FW_GSC);
+
+	/*
+	 * If the GSC FW load or the proxy init are interrupted, the only way
+	 * to recover it is to do an FLR and reload the GSC from scratch.
+	 * Therefore, let's wait for the init to complete before stopping
+	 * operations. The proxy init is the last step, so we can just wait on
+	 * that
+	 */
+	ret = xe_gsc_wait_for_proxy_init_done(gsc);
+	if (ret)
+		xe_gt_err(gt, "failed to wait for GSC init completion before uc stop\n");
+}
+
 /*
  * wa_14015076503: if the GSC FW is loaded, we need to alert it before doing a
  * GSC engine reset by writing a notification bit in the GS1 register and then
diff --git a/drivers/gpu/drm/xe/xe_gsc.h b/drivers/gpu/drm/xe/xe_gsc.h
index e282b9ef6ec4..c31fe24c4b66 100644
--- a/drivers/gpu/drm/xe/xe_gsc.h
+++ b/drivers/gpu/drm/xe/xe_gsc.h
@@ -16,6 +16,7 @@ struct xe_hw_engine;
 int xe_gsc_init(struct xe_gsc *gsc);
 int xe_gsc_init_post_hwconfig(struct xe_gsc *gsc);
 void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc);
+void xe_gsc_stop_prepare(struct xe_gsc *gsc);
 void xe_gsc_load_start(struct xe_gsc *gsc);
 void xe_gsc_remove(struct xe_gsc *gsc);
 void xe_gsc_hwe_irq_handler(struct xe_hw_engine *hwe, u16 intr_vec);
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index 2d6ea8c01445..85801de4fab1 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -71,6 +71,17 @@ bool xe_gsc_proxy_init_done(struct xe_gsc *gsc)
 	       HECI1_FWSTS1_PROXY_STATE_NORMAL;
 }
 
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+
+	/* Proxy init can take up to 500ms, so wait double that for safety */
+	return xe_mmio_wait32(gt, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
+			      HECI1_FWSTS1_CURRENT_STATE,
+			      HECI1_FWSTS1_PROXY_STATE_NORMAL,
+			      USEC_PER_SEC, NULL, false);
+}
+
 static void __gsc_proxy_irq_rmw(struct xe_gsc *gsc, u32 clr, u32 set)
 {
 	struct xe_gt *gt = gsc_to_gt(gsc);
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.h b/drivers/gpu/drm/xe/xe_gsc_proxy.h
index c511ade6b863..e2498aa6de18 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.h
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.h
@@ -13,6 +13,7 @@ struct xe_gsc;
 int xe_gsc_proxy_init(struct xe_gsc *gsc);
 bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
 void xe_gsc_proxy_remove(struct xe_gsc *gsc);
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
 int xe_gsc_proxy_start(struct xe_gsc *gsc);
 
 int xe_gsc_proxy_request_handler(struct xe_gsc *gsc);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 17ba15132a98..3a7628fb5ad3 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -828,7 +828,7 @@ void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
-	xe_uc_stop_prepare(&gt->uc);
+	xe_uc_suspend_prepare(&gt->uc);
 
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 }
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index aec7db39c061..2d4e38b3bab1 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -694,7 +694,7 @@ static inline u32 __xe_lrc_start_seqno_offset(struct xe_lrc *lrc)
 
 static u32 __xe_lrc_ctx_job_timestamp_offset(struct xe_lrc *lrc)
 {
-	/* The start seqno is stored in the driver-defined portion of PPHWSP */
+	/* This is stored in the driver-defined portion of PPHWSP */
 	return xe_lrc_pphwsp_offset(lrc) + LRC_CTX_JOB_TIMESTAMP_OFFSET;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 9f327f27c072..fb31e09acb51 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -229,13 +229,10 @@ static u32 get_ppgtt_flag(struct xe_sched_job *job)
 
 static int emit_copy_timestamp(struct xe_lrc *lrc, u32 *dw, int i)
 {
-	dw[i++] = MI_COPY_MEM_MEM | MI_COPY_MEM_MEM_SRC_GGTT |
-		MI_COPY_MEM_MEM_DST_GGTT;
+	dw[i++] = MI_STORE_REGISTER_MEM | MI_SRM_USE_GGTT | MI_SRM_ADD_CS_OFFSET;
+	dw[i++] = RING_CTX_TIMESTAMP(0).addr;
 	dw[i++] = xe_lrc_ctx_job_timestamp_ggtt_addr(lrc);
 	dw[i++] = 0;
-	dw[i++] = xe_lrc_ctx_timestamp_ggtt_addr(lrc);
-	dw[i++] = 0;
-	dw[i++] = MI_NOOP;
 
 	return i;
 }
diff --git a/drivers/gpu/drm/xe/xe_uc.c b/drivers/gpu/drm/xe/xe_uc.c
index 0d073a9987c2..bb03c524613f 100644
--- a/drivers/gpu/drm/xe/xe_uc.c
+++ b/drivers/gpu/drm/xe/xe_uc.c
@@ -241,7 +241,7 @@ void xe_uc_gucrc_disable(struct xe_uc *uc)
 
 void xe_uc_stop_prepare(struct xe_uc *uc)
 {
-	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_gsc_stop_prepare(&uc->gsc);
 	xe_guc_stop_prepare(&uc->guc);
 }
 
@@ -275,6 +275,12 @@ static void uc_reset_wait(struct xe_uc *uc)
 		goto again;
 }
 
+void xe_uc_suspend_prepare(struct xe_uc *uc)
+{
+	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_guc_stop_prepare(&uc->guc);
+}
+
 int xe_uc_suspend(struct xe_uc *uc)
 {
 	/* GuC submission not enabled, nothing to do */
diff --git a/drivers/gpu/drm/xe/xe_uc.h b/drivers/gpu/drm/xe/xe_uc.h
index 506517c11333..ba2937ab94cf 100644
--- a/drivers/gpu/drm/xe/xe_uc.h
+++ b/drivers/gpu/drm/xe/xe_uc.h
@@ -18,6 +18,7 @@ int xe_uc_reset_prepare(struct xe_uc *uc);
 void xe_uc_stop_prepare(struct xe_uc *uc);
 void xe_uc_stop(struct xe_uc *uc);
 int xe_uc_start(struct xe_uc *uc);
+void xe_uc_suspend_prepare(struct xe_uc *uc);
 int xe_uc_suspend(struct xe_uc *uc);
 int xe_uc_sanitize_reset(struct xe_uc *uc);
 void xe_uc_remove(struct xe_uc *uc);
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 8420c227e21b..bd3cc5636648 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -38,6 +38,9 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 	struct hid_bpf_ops *e;
 	int ret;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return ERR_PTR(-ENODEV);
+
 	if (type >= HID_REPORT_TYPES)
 		return ERR_PTR(-EINVAL);
 
@@ -93,6 +96,9 @@ int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return -ENODEV;
+
 	if (rtype >= HID_REPORT_TYPES)
 		return -EINVAL;
 
@@ -130,6 +136,9 @@ int dispatch_hid_bpf_output_report(struct hid_device *hdev,
 	struct hid_bpf_ops *e;
 	int ret, idx;
 
+	if (unlikely(hdev->bpf.destroyed))
+		return -ENODEV;
+
 	idx = srcu_read_lock(&hdev->bpf.srcu);
 	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
 				 srcu_read_lock_held(&hdev->bpf.srcu)) {
diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index 3b81468a1df2..0bf70664c35e 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -174,6 +174,7 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	u8 ep_addr[2] = {b_ep, 0};
 
 	if (!usb_check_int_endpoints(usbif, ep_addr)) {
+		kfree(send_buf);
 		hid_err(hdev, "Unexpected non-int endpoint\n");
 		return;
 	}
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index d8008933c052..321c43fb06ae 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -142,11 +142,12 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			suffix = "System Control";
 			break;
 		}
-	}
-
-	if (suffix)
+	} else {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index fb8cd8469328..35f26fa1ffe7 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1077,68 +1077,10 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 EXPORT_SYMBOL(vmbus_sendpacket);
 
 /*
- * vmbus_sendpacket_pagebuffer - Send a range of single-page buffer
- * packets using a GPADL Direct packet type. This interface allows you
- * to control notifying the host. This will be useful for sending
- * batched data. Also the sender can control the send flags
- * explicitly.
- */
-int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-				struct hv_page_buffer pagebuffers[],
-				u32 pagecount, void *buffer, u32 bufferlen,
-				u64 requestid)
-{
-	int i;
-	struct vmbus_channel_packet_page_buffer desc;
-	u32 descsize;
-	u32 packetlen;
-	u32 packetlen_aligned;
-	struct kvec bufferlist[3];
-	u64 aligned_data = 0;
-
-	if (pagecount > MAX_PAGE_BUFFER_COUNT)
-		return -EINVAL;
-
-	/*
-	 * Adjust the size down since vmbus_channel_packet_page_buffer is the
-	 * largest size we support
-	 */
-	descsize = sizeof(struct vmbus_channel_packet_page_buffer) -
-			  ((MAX_PAGE_BUFFER_COUNT - pagecount) *
-			  sizeof(struct hv_page_buffer));
-	packetlen = descsize + bufferlen;
-	packetlen_aligned = ALIGN(packetlen, sizeof(u64));
-
-	/* Setup the descriptor */
-	desc.type = VM_PKT_DATA_USING_GPA_DIRECT;
-	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
-	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
-	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
-	desc.reserved = 0;
-	desc.rangecount = pagecount;
-
-	for (i = 0; i < pagecount; i++) {
-		desc.range[i].len = pagebuffers[i].len;
-		desc.range[i].offset = pagebuffers[i].offset;
-		desc.range[i].pfn	 = pagebuffers[i].pfn;
-	}
-
-	bufferlist[0].iov_base = &desc;
-	bufferlist[0].iov_len = descsize;
-	bufferlist[1].iov_base = buffer;
-	bufferlist[1].iov_len = bufferlen;
-	bufferlist[2].iov_base = &aligned_data;
-	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
-
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
-}
-EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
-
-/*
- * vmbus_sendpacket_multipagebuffer - Send a multi-page buffer packet
+ * vmbus_sendpacket_mpb_desc - Send one or more multi-page buffer packets
  * using a GPADL Direct packet type.
- * The buffer includes the vmbus descriptor.
+ * The desc argument must include space for the VMBus descriptor. The
+ * rangecount field must already be set.
  */
 int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 			      struct vmbus_packet_mpb_array *desc,
@@ -1160,7 +1102,6 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	desc->length8 = (u16)(packetlen_aligned >> 3);
 	desc->transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
 	desc->reserved = 0;
-	desc->rangecount = 1;
 
 	bufferlist[0].iov_base = desc;
 	bufferlist[0].iov_len = desc_size;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 52cb744b4d7f..e4136cbaa4d4 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -485,4 +485,10 @@ static inline int hv_debug_add_dev_dir(struct hv_device *dev)
 
 #endif /* CONFIG_HYPERV_TESTING */
 
+/* Create and remove sysfs entry for memory mapped ring buffers for a channel */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma));
+int hv_remove_ring_sysfs(struct vmbus_channel *channel);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2b6749c9712e..1f519e925f06 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1792,6 +1792,27 @@ static ssize_t subchannel_id_show(struct vmbus_channel *channel,
 }
 static VMBUS_CHAN_ATTR_RO(subchannel_id);
 
+static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
+				       struct bin_attribute *attr,
+				       struct vm_area_struct *vma)
+{
+	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
+
+	/*
+	 * hv_(create|remove)_ring_sysfs implementation ensures that mmap_ring_buffer
+	 * is not NULL.
+	 */
+	return channel->mmap_ring_buffer(channel, vma);
+}
+
+static struct bin_attribute chan_attr_ring_buffer = {
+	.attr = {
+		.name = "ring",
+		.mode = 0600,
+	},
+	.size = 2 * SZ_2M,
+	.mmap = hv_mmap_ring_buffer_wrapper,
+};
 static struct attribute *vmbus_chan_attrs[] = {
 	&chan_attr_out_mask.attr,
 	&chan_attr_in_mask.attr,
@@ -1811,6 +1832,11 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
+static struct bin_attribute *vmbus_chan_bin_attrs[] = {
+	&chan_attr_ring_buffer,
+	NULL
+};
+
 /*
  * Channel-level attribute_group callback function. Returns the permission for
  * each attribute, and returns 0 if an attribute is not visible.
@@ -1831,9 +1857,24 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
+static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
+					      struct bin_attribute *attr, int idx)
+{
+	const struct vmbus_channel *channel =
+		container_of(kobj, struct vmbus_channel, kobj);
+
+	/* Hide ring attribute if channel's ring_sysfs_visible is set to false */
+	if (attr ==  &chan_attr_ring_buffer && !channel->ring_sysfs_visible)
+		return 0;
+
+	return attr->attr.mode;
+}
+
 static const struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
-	.is_visible = vmbus_chan_attr_is_visible
+	.bin_attrs = vmbus_chan_bin_attrs,
+	.is_visible = vmbus_chan_attr_is_visible,
+	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
 };
 
 static const struct kobj_type vmbus_chan_ktype = {
@@ -1841,6 +1882,63 @@ static const struct kobj_type vmbus_chan_ktype = {
 	.release = vmbus_chan_release,
 };
 
+/**
+ * hv_create_ring_sysfs() - create "ring" sysfs entry corresponding to ring buffers for a channel.
+ * @channel: Pointer to vmbus_channel structure
+ * @hv_mmap_ring_buffer: function pointer for initializing the function to be called on mmap of
+ *                       channel's "ring" sysfs node, which is for the ring buffer of that channel.
+ *                       Function pointer is of below type:
+ *                       int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+ *                                                  struct vm_area_struct *vma))
+ *                       This has a pointer to the channel and a pointer to vm_area_struct,
+ *                       used for mmap, as arguments.
+ *
+ * Sysfs node for ring buffer of a channel is created along with other fields, however its
+ * visibility is disabled by default. Sysfs creation needs to be controlled when the use-case
+ * is running.
+ * For example, HV_NIC device is used either by uio_hv_generic or hv_netvsc at any given point of
+ * time, and "ring" sysfs is needed only when uio_hv_generic is bound to that device. To avoid
+ * exposing the ring buffer by default, this function is reponsible to enable visibility of
+ * ring for userspace to use.
+ * Note: Race conditions can happen with userspace and it is not encouraged to create new
+ * use-cases for this. This was added to maintain backward compatibility, while solving
+ * one of the race conditions in uio_hv_generic while creating sysfs.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int hv_create_ring_sysfs(struct vmbus_channel *channel,
+			 int (*hv_mmap_ring_buffer)(struct vmbus_channel *channel,
+						    struct vm_area_struct *vma))
+{
+	struct kobject *kobj = &channel->kobj;
+
+	channel->mmap_ring_buffer = hv_mmap_ring_buffer;
+	channel->ring_sysfs_visible = true;
+
+	return sysfs_update_group(kobj, &vmbus_chan_group);
+}
+EXPORT_SYMBOL_GPL(hv_create_ring_sysfs);
+
+/**
+ * hv_remove_ring_sysfs() - remove ring sysfs entry corresponding to ring buffers for a channel.
+ * @channel: Pointer to vmbus_channel structure
+ *
+ * Hide "ring" sysfs for a channel by changing its is_visible attribute and updating sysfs group.
+ *
+ * Returns 0 on success or error code on failure.
+ */
+int hv_remove_ring_sysfs(struct vmbus_channel *channel)
+{
+	struct kobject *kobj = &channel->kobj;
+	int ret;
+
+	channel->ring_sysfs_visible = false;
+	ret = sysfs_update_group(kobj, &vmbus_chan_group);
+	channel->mmap_ring_buffer = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_remove_ring_sysfs);
+
 /*
  * vmbus_add_channel_kobj - setup a sub-directory under device/channels
  */
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 7949b076fb87..d4c9b85135f5 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 157a0df97f97..a9248a85466e 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -169,7 +169,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index d0bd94912e0a..e05ce1f12065 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <linux/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 814ce0aad1cc..4085a36cd1db 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 176e54bb48c3..d5ca75b12883 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -692,8 +692,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -730,7 +731,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 9d5c30afa9d6..d62a018eaff3 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -34,16 +34,6 @@ struct iio_dev;
 struct mpr_data;
 struct mpr_ops;
 
-/**
- * struct mpr_chan
- * @pres: pressure value
- * @ts: timestamp
- */
-struct mpr_chan {
-	s32 pres;
-	s64 ts;
-};
-
 enum mpr_func_id {
 	MPR_FUNCTION_A,
 	MPR_FUNCTION_B,
@@ -69,6 +59,8 @@ enum mpr_func_id {
  *       reading in a loop until data is ready
  * @completion: handshake from irq to read
  * @chan: channel values for buffered mode
+ * @chan.pres: pressure value
+ * @chan.ts: timestamp
  * @buffer: raw conversion data
  */
 struct mpr_data {
@@ -87,7 +79,10 @@ struct mpr_data {
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;
-	struct mpr_chan		chan;
+	struct {
+		s32 pres;
+		aligned_s64 ts;
+	} chan;
 	u8	    buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 46102f179955..df2aa15a5bc9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1368,6 +1368,9 @@ static void ib_device_notify_register(struct ib_device *device)
 
 	down_read(&devices_rwsem);
 
+	/* Mark for userspace that device is ready */
+	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+
 	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
 	if (ret)
 		goto out;
@@ -1484,10 +1487,9 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 	dev_set_uevent_suppress(&device->dev, false);
-	/* Mark for userspace that device is ready */
-	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
 
 	ib_device_notify_register(device);
+
 	ib_device_put(device);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fec87c9030ab..fffd144d509e 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -56,11 +56,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
 			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
-	if (err) {
-		vfree(cq->queue->buf);
-		kfree(cq->queue);
+	if (err)
 		return err;
-	}
 
 	cq->is_user = uresp;
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index e072d2b50c98..0168ad495e6c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -326,6 +326,26 @@ static void b53_get_vlan_entry(struct b53_device *dev, u16 vid,
 	}
 }
 
+static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
+{
+	u64 eap_conf;
+
+	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
+		return;
+
+	b53_read64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), &eap_conf);
+
+	if (is63xx(dev)) {
+		eap_conf &= ~EAP_MODE_MASK_63XX;
+		eap_conf |= (u64)mode << EAP_MODE_SHIFT_63XX;
+	} else {
+		eap_conf &= ~EAP_MODE_MASK;
+		eap_conf |= (u64)mode << EAP_MODE_SHIFT;
+	}
+
+	b53_write64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), eap_conf);
+}
+
 static void b53_set_forwarding(struct b53_device *dev, int enable)
 {
 	u8 mgmt;
@@ -586,6 +606,13 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	b53_port_set_mcast_flood(dev, port, true);
 	b53_port_set_learning(dev, port, false);
 
+	/* Force all traffic to go to the CPU port to prevent the ASIC from
+	 * trying to forward to bridged ports on matching FDB entries, then
+	 * dropping frames because it isn't allowed to forward there.
+	 */
+	if (dsa_is_user_port(ds, port))
+		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_setup_port);
@@ -2043,6 +2070,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		pvlan |= BIT(i);
 	}
 
+	/* Disable redirection of unknown SA to the CPU port */
+	b53_set_eap_mode(dev, port, EAP_MODE_BASIC);
+
 	/* Configure the local port VLAN control membership to include
 	 * remote ports and update the local port bitmask
 	 */
@@ -2078,6 +2108,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 			pvlan &= ~BIT(i);
 	}
 
+	/* Enable redirection of unknown SA to the CPU port */
+	b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
+
 	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index bfbcb66bef66..5f7a0e5c5709 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -50,6 +50,9 @@
 /* Jumbo Frame Registers */
 #define B53_JUMBO_PAGE			0x40
 
+/* EAP Registers */
+#define B53_EAP_PAGE			0x42
+
 /* EEE Control Registers Page */
 #define B53_EEE_PAGE			0x92
 
@@ -480,6 +483,17 @@
 #define   JMS_MIN_SIZE			1518
 #define   JMS_MAX_SIZE			9724
 
+/*************************************************************************
+ * EAP Page Registers
+ *************************************************************************/
+#define B53_PORT_EAP_CONF(i)		(0x20 + 8 * (i))
+#define  EAP_MODE_SHIFT			51
+#define  EAP_MODE_SHIFT_63XX		50
+#define  EAP_MODE_MASK			(0x3ull << EAP_MODE_SHIFT)
+#define  EAP_MODE_MASK_63XX		(0x3ull << EAP_MODE_SHIFT_63XX)
+#define  EAP_MODE_BASIC			0
+#define  EAP_MODE_SIMPLIFIED		3
+
 /*************************************************************************
  * EEE Configuration Page Registers
  *************************************************************************/
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index d0563ef59acf..fbac2a647b20 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2083,6 +2083,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -2092,11 +2093,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 		mac[port].egress    = false;
 		mac[port].dyn_learn = false;
 		break;
-	case BR_STATE_LISTENING:
-		mac[port].ingress   = true;
-		mac[port].egress    = false;
-		mac[port].dyn_learn = false;
-		break;
 	case BR_STATE_LEARNING:
 		mac[port].ingress   = true;
 		mac[port].egress    = false;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 60847cdb516e..ae100ed8ed6b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1016,22 +1016,15 @@ static void macb_update_stats(struct macb *bp)
 
 static int macb_halt_tx(struct macb *bp)
 {
-	unsigned long	halt_time, timeout;
-	u32		status;
+	u32 status;
 
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
 
-	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
-	do {
-		halt_time = jiffies;
-		status = macb_readl(bp, TSR);
-		if (!(status & MACB_BIT(TGO)))
-			return 0;
-
-		udelay(250);
-	} while (time_before(halt_time, timeout));
-
-	return -ETIMEDOUT;
+	/* Poll TSR until TGO is cleared or timeout. */
+	return read_poll_timeout_atomic(macb_readl, status,
+					!(status & MACB_BIT(TGO)),
+					250, MACB_HALT_TIMEOUT, false,
+					bp, TSR);
 }
 
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 44da335d66bd..6a6efe2b2bc5 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -67,6 +67,8 @@
 #define TSNEP_TX_TYPE_XDP_NDO_MAP_PAGE	(TSNEP_TX_TYPE_XDP_NDO | TSNEP_TX_TYPE_MAP_PAGE)
 #define TSNEP_TX_TYPE_XDP		(TSNEP_TX_TYPE_XDP_TX | TSNEP_TX_TYPE_XDP_NDO)
 #define TSNEP_TX_TYPE_XSK		BIT(12)
+#define TSNEP_TX_TYPE_TSTAMP		BIT(13)
+#define TSNEP_TX_TYPE_SKB_TSTAMP	(TSNEP_TX_TYPE_SKB | TSNEP_TX_TYPE_TSTAMP)
 
 #define TSNEP_XDP_TX		BIT(0)
 #define TSNEP_XDP_REDIRECT	BIT(1)
@@ -387,8 +389,7 @@ static void tsnep_tx_activate(struct tsnep_tx *tx, int index, int length,
 	if (entry->skb) {
 		entry->properties = length & TSNEP_DESC_LENGTH_MASK;
 		entry->properties |= TSNEP_DESC_INTERRUPT_FLAG;
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS))
+		if ((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP)
 			entry->properties |= TSNEP_DESC_EXTENDED_WRITEBACK_FLAG;
 
 		/* toggle user flag to prevent false acknowledge
@@ -480,7 +481,8 @@ static int tsnep_tx_map_frag(skb_frag_t *frag, struct tsnep_tx_entry *entry,
 	return mapped;
 }
 
-static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
+static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count,
+			bool do_tstamp)
 {
 	struct device *dmadev = tx->adapter->dmadev;
 	struct tsnep_tx_entry *entry;
@@ -506,6 +508,9 @@ static int tsnep_tx_map(struct sk_buff *skb, struct tsnep_tx *tx, int count)
 				entry->type = TSNEP_TX_TYPE_SKB_INLINE;
 				mapped = 0;
 			}
+
+			if (do_tstamp)
+				entry->type |= TSNEP_TX_TYPE_TSTAMP;
 		} else {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
@@ -559,11 +564,12 @@ static int tsnep_tx_unmap(struct tsnep_tx *tx, int index, int count)
 static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 					 struct tsnep_tx *tx)
 {
-	int count = 1;
 	struct tsnep_tx_entry *entry;
+	bool do_tstamp = false;
+	int count = 1;
 	int length;
-	int i;
 	int retval;
+	int i;
 
 	if (skb_shinfo(skb)->nr_frags > 0)
 		count += skb_shinfo(skb)->nr_frags;
@@ -580,7 +586,13 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	entry = &tx->entry[tx->write];
 	entry->skb = skb;
 
-	retval = tsnep_tx_map(skb, tx, count);
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+	    tx->adapter->hwtstamp_config.tx_type == HWTSTAMP_TX_ON) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		do_tstamp = true;
+	}
+
+	retval = tsnep_tx_map(skb, tx, count, do_tstamp);
 	if (retval < 0) {
 		tsnep_tx_unmap(tx, tx->write, count);
 		dev_kfree_skb_any(entry->skb);
@@ -592,9 +604,6 @@ static netdev_tx_t tsnep_xmit_frame_ring(struct sk_buff *skb,
 	}
 	length = retval;
 
-	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-
 	for (i = 0; i < count; i++)
 		tsnep_tx_activate(tx, (tx->write + i) & TSNEP_RING_MASK, length,
 				  i == count - 1);
@@ -845,8 +854,7 @@ static bool tsnep_tx_poll(struct tsnep_tx *tx, int napi_budget)
 
 		length = tsnep_tx_unmap(tx, tx->read, count);
 
-		if ((entry->type & TSNEP_TX_TYPE_SKB) &&
-		    (skb_shinfo(entry->skb)->tx_flags & SKBTX_IN_PROGRESS) &&
+		if (((entry->type & TSNEP_TX_TYPE_SKB_TSTAMP) == TSNEP_TX_TYPE_SKB_TSTAMP) &&
 		    (__le32_to_cpu(entry->desc_wb->properties) &
 		     TSNEP_DESC_EXTENDED_WRITEBACK_FLAG)) {
 			struct skb_shared_hwtstamps hwtstamps;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 8216f843a7cd..e43c4608d3ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -707,6 +707,11 @@ int cgx_get_rx_stats(void *cgxd, int lmac_id, int idx, u64 *rx_stat)
 
 	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
+
+	/* pass lmac as 0 for CGX_CMR_RX_STAT9-12 */
+	if (idx >= CGX_RX_STAT_GLOBAL_INDEX)
+		lmac_id = 0;
+
 	*rx_stat =  cgx_read(cgx, lmac_id, CGXX_CMRX_RX_STAT0 + (idx * 8));
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6cc7a78968fc..74953f67a2bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -533,7 +533,8 @@ static int cn10k_mcs_write_tx_secy(struct otx2_nic *pfvf,
 	if (sw_tx_sc->encrypt)
 		sectag_tci |= (MCS_TCI_E | MCS_TCI_C);
 
-	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU, secy->netdev->mtu);
+	policy = FIELD_PREP(MCS_TX_SECY_PLCY_MTU,
+			    pfvf->netdev->mtu + OTX2_ETH_HLEN);
 	/* Write SecTag excluding AN bits(1..0) */
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_TCI, sectag_tci >> 2);
 	policy |= FIELD_PREP(MCS_TX_SECY_PLCY_ST_OFFSET, tag_offset);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index f27a3456ae64..5b45fd78d282 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -364,6 +364,7 @@ struct otx2_flow_config {
 	struct list_head	flow_list_tc;
 	u8			ucast_flt_cnt;
 	bool			ntuple;
+	u16			ntuple_cnt;
 };
 
 struct dev_hw_ops {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 53f14aa944bd..aaea19345750 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -41,6 +41,7 @@ static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
 	if (!pfvf->flow_cfg)
 		return 0;
 
+	pfvf->flow_cfg->ntuple_cnt = ctx->val.vu16;
 	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 58720a161ee2..2750326bfcf8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -252,7 +252,7 @@ int otx2_mcam_entry_init(struct otx2_nic *pfvf)
 	mutex_unlock(&pfvf->mbox.lock);
 
 	/* Allocate entries for Ntuple filters */
-	count = otx2_alloc_mcam_entries(pfvf, OTX2_DEFAULT_FLOWCOUNT);
+	count = otx2_alloc_mcam_entries(pfvf, flow_cfg->ntuple_cnt);
 	if (count <= 0) {
 		otx2_clear_ntuple_flow_info(pfvf, flow_cfg);
 		return 0;
@@ -312,6 +312,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
 
 	pf->flow_cfg->ucast_flt_cnt = OTX2_DEFAULT_UNICAST_FLOWS;
+	pf->flow_cfg->ntuple_cnt = OTX2_DEFAULT_FLOWCOUNT;
 
 	/* Allocate bare minimum number of MCAM entries needed for
 	 * unicast and ntuple filters.
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 0a13f7c4684e..272f178906d6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4685,7 +4685,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	}
 
 	if (mtk_is_netsys_v3_or_greater(mac->hw) &&
-	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW_BIT) &&
+	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW) &&
 	    id == MTK_GMAC1_ID) {
 		mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
 						       MAC_SYM_PAUSE |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 1c087fa1ca26..3e9ad3cb8121 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4344,6 +4344,10 @@ static netdev_features_t mlx5e_fix_uplink_rep_features(struct net_device *netdev
 	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
 		netdev_warn(netdev, "Disabling HW_VLAN CTAG FILTERING, not supported in switchdev mode\n");
 
+	features &= ~NETIF_F_HW_MACSEC;
+	if (netdev->features & NETIF_F_HW_MACSEC)
+		netdev_warn(netdev, "Disabling HW MACsec offload, not supported in switchdev mode\n");
+
 	return features;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7d6d859cef3f..511cd92e0e3e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3014,6 +3014,9 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.rif = rif,
 	};
 
+	if (!mlxsw_sp_dev_lower_is_port(mlxsw_sp_rif_dev(rif)))
+		return 0;
+
 	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
 	if (rms.err)
 		goto err_arp;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 99df00c30b8c..b5d744d2586f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -203,7 +203,7 @@ static struct pci_driver qede_pci_driver = {
 };
 
 static struct qed_eth_cb_ops qede_ll_ops = {
-	{
+	.common = {
 #ifdef CONFIG_RFS_ACCEL
 		.arfs_filter_op = qede_arfs_filter_op,
 #endif
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 28d24d59efb8..d57b976b9040 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1484,8 +1484,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e690b95b1bbb..a4963766fd99 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -158,7 +158,6 @@ struct hv_netvsc_packet {
 	u8 cp_partial; /* partial copy into send buffer */
 
 	u8 rmsg_size; /* RNDIS header and PPI size */
-	u8 rmsg_pgcnt; /* page count of RNDIS header and PPI */
 	u8 page_buf_cnt;
 
 	u16 q_idx;
@@ -893,6 +892,18 @@ struct nvsp_message {
 				 sizeof(struct nvsp_message))
 #define NETVSC_MIN_IN_MSG_SIZE sizeof(struct vmpacket_descriptor)
 
+/* Maximum # of contiguous data ranges that can make up a trasmitted packet.
+ * Typically it's the max SKB fragments plus 2 for the rndis packet and the
+ * linear portion of the SKB. But if MAX_SKB_FRAGS is large, the value may
+ * need to be limited to MAX_PAGE_BUFFER_COUNT, which is the max # of entries
+ * in a GPA direct packet sent to netvsp over VMBus.
+ */
+#if MAX_SKB_FRAGS + 2 < MAX_PAGE_BUFFER_COUNT
+#define MAX_DATA_RANGES (MAX_SKB_FRAGS + 2)
+#else
+#define MAX_DATA_RANGES MAX_PAGE_BUFFER_COUNT
+#endif
+
 /* Estimated requestor size:
  * out_ring_size/min_out_msg_size + in_ring_size/min_in_msg_size
  */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 2b6ec979a62f..807465dd4c8e 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -947,8 +947,7 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 		     + pend_size;
 	int i;
 	u32 padding = 0;
-	u32 page_count = packet->cp_partial ? packet->rmsg_pgcnt :
-		packet->page_buf_cnt;
+	u32 page_count = packet->cp_partial ? 1 : packet->page_buf_cnt;
 	u32 remain;
 
 	/* Add padding */
@@ -1049,6 +1048,42 @@ static int netvsc_dma_map(struct hv_device *hv_dev,
 	return 0;
 }
 
+/* Build an "array" of mpb entries describing the data to be transferred
+ * over VMBus. After the desc header fields, each "array" entry is variable
+ * size, and each entry starts after the end of the previous entry. The
+ * "offset" and "len" fields for each entry imply the size of the entry.
+ *
+ * The pfns are in HV_HYP_PAGE_SIZE, because all communication with Hyper-V
+ * uses that granularity, even if the system page size of the guest is larger.
+ * Each entry in the input "pb" array must describe a contiguous range of
+ * guest physical memory so that the pfns are sequential if the range crosses
+ * a page boundary. The offset field must be < HV_HYP_PAGE_SIZE.
+ */
+static inline void netvsc_build_mpb_array(struct hv_page_buffer *pb,
+				u32 page_buffer_count,
+				struct vmbus_packet_mpb_array *desc,
+				u32 *desc_size)
+{
+	struct hv_mpb_array *mpb_entry = &desc->range;
+	int i, j;
+
+	for (i = 0; i < page_buffer_count; i++) {
+		u32 offset = pb[i].offset;
+		u32 len = pb[i].len;
+
+		mpb_entry->offset = offset;
+		mpb_entry->len = len;
+
+		for (j = 0; j < HVPFN_UP(offset + len); j++)
+			mpb_entry->pfn_array[j] = pb[i].pfn + j;
+
+		mpb_entry = (struct hv_mpb_array *)&mpb_entry->pfn_array[j];
+	}
+
+	desc->rangecount = page_buffer_count;
+	*desc_size = (char *)mpb_entry - (char *)desc;
+}
+
 static inline int netvsc_send_pkt(
 	struct hv_device *device,
 	struct hv_netvsc_packet *packet,
@@ -1091,8 +1126,11 @@ static inline int netvsc_send_pkt(
 
 	packet->dma_range = NULL;
 	if (packet->page_buf_cnt) {
+		struct vmbus_channel_packet_page_buffer desc;
+		u32 desc_size;
+
 		if (packet->cp_partial)
-			pb += packet->rmsg_pgcnt;
+			pb++;
 
 		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
 		if (ret) {
@@ -1100,11 +1138,12 @@ static inline int netvsc_send_pkt(
 			goto exit;
 		}
 
-		ret = vmbus_sendpacket_pagebuffer(out_channel,
-						  pb, packet->page_buf_cnt,
-						  &nvmsg, sizeof(nvmsg),
-						  req_id);
-
+		netvsc_build_mpb_array(pb, packet->page_buf_cnt,
+				(struct vmbus_packet_mpb_array *)&desc,
+				 &desc_size);
+		ret = vmbus_sendpacket_mpb_desc(out_channel,
+				(struct vmbus_packet_mpb_array *)&desc,
+				desc_size, &nvmsg, sizeof(nvmsg), req_id);
 		if (ret)
 			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
 	} else {
@@ -1253,7 +1292,7 @@ int netvsc_send(struct net_device *ndev,
 		packet->send_buf_index = section_index;
 
 		if (packet->cp_partial) {
-			packet->page_buf_cnt -= packet->rmsg_pgcnt;
+			packet->page_buf_cnt--;
 			packet->total_data_buflen = msd_len + packet->rmsg_size;
 		} else {
 			packet->page_buf_cnt = 0;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 23180f7b67b6..8ec497023224 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -325,43 +325,10 @@ static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return txq;
 }
 
-static u32 fill_pg_buf(unsigned long hvpfn, u32 offset, u32 len,
-		       struct hv_page_buffer *pb)
-{
-	int j = 0;
-
-	hvpfn += offset >> HV_HYP_PAGE_SHIFT;
-	offset = offset & ~HV_HYP_PAGE_MASK;
-
-	while (len > 0) {
-		unsigned long bytes;
-
-		bytes = HV_HYP_PAGE_SIZE - offset;
-		if (bytes > len)
-			bytes = len;
-		pb[j].pfn = hvpfn;
-		pb[j].offset = offset;
-		pb[j].len = bytes;
-
-		offset += bytes;
-		len -= bytes;
-
-		if (offset == HV_HYP_PAGE_SIZE && len) {
-			hvpfn++;
-			offset = 0;
-			j++;
-		}
-	}
-
-	return j + 1;
-}
-
 static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 			   struct hv_netvsc_packet *packet,
 			   struct hv_page_buffer *pb)
 {
-	u32 slots_used = 0;
-	char *data = skb->data;
 	int frags = skb_shinfo(skb)->nr_frags;
 	int i;
 
@@ -370,28 +337,27 @@ static u32 init_page_array(void *hdr, u32 len, struct sk_buff *skb,
 	 * 2. skb linear data
 	 * 3. skb fragment data
 	 */
-	slots_used += fill_pg_buf(virt_to_hvpfn(hdr),
-				  offset_in_hvpage(hdr),
-				  len,
-				  &pb[slots_used]);
 
+	pb[0].offset = offset_in_hvpage(hdr);
+	pb[0].len = len;
+	pb[0].pfn = virt_to_hvpfn(hdr);
 	packet->rmsg_size = len;
-	packet->rmsg_pgcnt = slots_used;
 
-	slots_used += fill_pg_buf(virt_to_hvpfn(data),
-				  offset_in_hvpage(data),
-				  skb_headlen(skb),
-				  &pb[slots_used]);
+	pb[1].offset = offset_in_hvpage(skb->data);
+	pb[1].len = skb_headlen(skb);
+	pb[1].pfn = virt_to_hvpfn(skb->data);
 
 	for (i = 0; i < frags; i++) {
 		skb_frag_t *frag = skb_shinfo(skb)->frags + i;
+		struct hv_page_buffer *cur_pb = &pb[i + 2];
+		u64 pfn = page_to_hvpfn(skb_frag_page(frag));
+		u32 offset = skb_frag_off(frag);
 
-		slots_used += fill_pg_buf(page_to_hvpfn(skb_frag_page(frag)),
-					  skb_frag_off(frag),
-					  skb_frag_size(frag),
-					  &pb[slots_used]);
+		cur_pb->offset = offset_in_hvpage(offset);
+		cur_pb->len = skb_frag_size(frag);
+		cur_pb->pfn = pfn + (offset >> HV_HYP_PAGE_SHIFT);
 	}
-	return slots_used;
+	return frags + 2;
 }
 
 static int count_skb_frag_slots(struct sk_buff *skb)
@@ -482,7 +448,7 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 	struct net_device *vf_netdev;
 	u32 rndis_msg_size;
 	u32 hash;
-	struct hv_page_buffer pb[MAX_PAGE_BUFFER_COUNT];
+	struct hv_page_buffer pb[MAX_DATA_RANGES];
 
 	/* If VF is present and up then redirect packets to it.
 	 * Skip the VF if it is marked down or has no carrier.
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index ecc2128ca9b7..e457f809fe31 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -225,8 +225,7 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 				  struct rndis_request *req)
 {
 	struct hv_netvsc_packet *packet;
-	struct hv_page_buffer page_buf[2];
-	struct hv_page_buffer *pb = page_buf;
+	struct hv_page_buffer pb;
 	int ret;
 
 	/* Setup the packet to send it */
@@ -235,27 +234,14 @@ static int rndis_filter_send_request(struct rndis_device *dev,
 	packet->total_data_buflen = req->request_msg.msg_len;
 	packet->page_buf_cnt = 1;
 
-	pb[0].pfn = virt_to_phys(&req->request_msg) >>
-					HV_HYP_PAGE_SHIFT;
-	pb[0].len = req->request_msg.msg_len;
-	pb[0].offset = offset_in_hvpage(&req->request_msg);
-
-	/* Add one page_buf when request_msg crossing page boundary */
-	if (pb[0].offset + pb[0].len > HV_HYP_PAGE_SIZE) {
-		packet->page_buf_cnt++;
-		pb[0].len = HV_HYP_PAGE_SIZE -
-			pb[0].offset;
-		pb[1].pfn = virt_to_phys((void *)&req->request_msg
-			+ pb[0].len) >> HV_HYP_PAGE_SHIFT;
-		pb[1].offset = 0;
-		pb[1].len = req->request_msg.msg_len -
-			pb[0].len;
-	}
+	pb.pfn = virt_to_phys(&req->request_msg) >> HV_HYP_PAGE_SHIFT;
+	pb.len = req->request_msg.msg_len;
+	pb.offset = offset_in_hvpage(&req->request_msg);
 
 	trace_rndis_send(dev->ndev, 0, &req->request_msg);
 
 	rcu_read_lock_bh();
-	ret = netvsc_send(dev->ndev, packet, NULL, pb, NULL, false);
+	ret = netvsc_send(dev->ndev, packet, NULL, &pb, NULL, false);
 	rcu_read_unlock_bh();
 
 	return ret;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fbd1150c33cc..6d36cb204f9b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5547,7 +5547,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5576,7 +5576,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 5f46d6daeaa7..8940f8bb7bb5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -999,6 +999,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	int i;
 
 	mt76_worker_disable(&dev->tx_worker);
+	napi_disable(&dev->tx_napi);
 	netif_napi_del(&dev->tx_napi);
 
 	for (i = 0; i < ARRAY_SIZE(dev->phys); i++) {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 83ee433b6941..265b3608ae26 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -390,7 +390,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
  * as it only leads to a small amount of wasted memory for the lifetime of
  * the I/O.
  */
-static int nvme_pci_npages_prp(void)
+static __always_inline int nvme_pci_npages_prp(void)
 {
 	unsigned max_bytes = (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_SIZE;
 	unsigned nprps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
@@ -1202,7 +1202,9 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
 	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
+	spin_unlock(&nvmeq->cq_poll_lock);
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 58e123305152..513fd35dcaa9 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -107,7 +107,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -320,16 +319,15 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
-
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (enum rcar_gen3_phy_index i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI;
+	     i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -351,7 +349,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -389,7 +387,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -402,6 +400,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -462,16 +463,16 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
-
-	/* Initialize otg part */
-	if (channel->is_otg_channel) {
-		if (rcar_gen3_needs_init_otg(channel))
-			rcar_gen3_init_otg(channel);
-		rphy->otg_initialized = true;
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 	}
 
+	/* Initialize otg part (only if we initialize a PHY with IRQs). */
+	if (rphy->int_enable_bits)
+		rcar_gen3_init_otg(channel);
+
 	rphy->initialized = true;
 
 	return 0;
@@ -486,9 +487,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index fae6242aa730..23a23f2d64e5 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -237,6 +237,8 @@
 #define   DATA0_VAL_PD				BIT(1)
 #define   USE_XUSB_AO				BIT(4)
 
+#define TEGRA_UTMI_PAD_MAX 4
+
 #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
 	{								\
 		.name = _name,						\
@@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
 
 	/* UTMI bias and tracking */
 	struct clk *usb2_trk_clk;
-	unsigned int bias_pad_enable;
+	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
 
 	/* padctl context */
 	struct tegra186_xusb_padctl_context context;
@@ -603,12 +605,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	u32 value;
 	int err;
 
-	mutex_lock(&padctl->lock);
-
-	if (priv->bias_pad_enable++ > 0) {
-		mutex_unlock(&padctl->lock);
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
 		return;
-	}
 
 	err = clk_prepare_enable(priv->usb2_trk_clk);
 	if (err < 0)
@@ -658,8 +656,6 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	} else {
 		clk_disable_unprepare(priv->usb2_trk_clk);
 	}
-
-	mutex_unlock(&padctl->lock);
 }
 
 static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
@@ -667,17 +663,8 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	u32 value;
 
-	mutex_lock(&padctl->lock);
-
-	if (WARN_ON(priv->bias_pad_enable == 0)) {
-		mutex_unlock(&padctl->lock);
-		return;
-	}
-
-	if (--priv->bias_pad_enable > 0) {
-		mutex_unlock(&padctl->lock);
+	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
 		return;
-	}
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 	value |= USB2_PD_TRK;
@@ -690,13 +677,13 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 		clk_disable_unprepare(priv->usb2_trk_clk);
 	}
 
-	mutex_unlock(&padctl->lock);
 }
 
 static void tegra186_utmi_pad_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	struct tegra_xusb_usb2_port *port;
 	struct device *dev = padctl->dev;
 	unsigned int index = lane->index;
@@ -705,9 +692,16 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	if (!phy)
 		return;
 
+	mutex_lock(&padctl->lock);
+	if (test_bit(index, priv->utmi_pad_enabled)) {
+		mutex_unlock(&padctl->lock);
+		return;
+	}
+
 	port = tegra_xusb_find_usb2_port(padctl, index);
 	if (!port) {
 		dev_err(dev, "no port found for USB2 lane %u\n", index);
+		mutex_unlock(&padctl->lock);
 		return;
 	}
 
@@ -724,18 +718,28 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
 	value &= ~USB2_OTG_PD_DR;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
+
+	set_bit(index, priv->utmi_pad_enabled);
+	mutex_unlock(&padctl->lock);
 }
 
 static void tegra186_utmi_pad_power_down(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
 	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
 	unsigned int index = lane->index;
 	u32 value;
 
 	if (!phy)
 		return;
 
+	mutex_lock(&padctl->lock);
+	if (!test_bit(index, priv->utmi_pad_enabled)) {
+		mutex_unlock(&padctl->lock);
+		return;
+	}
+
 	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
 
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
@@ -748,7 +752,11 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
 
 	udelay(2);
 
+	clear_bit(index, priv->utmi_pad_enabled);
+
 	tegra186_utmi_bias_pad_power_off(padctl);
+
+	mutex_unlock(&padctl->lock);
 }
 
 static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 342f5ccf611d..c758145e912d 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -548,16 +548,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&port->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&port->dev);
+put_device:
+	put_device(&port->dev);
 	return err;
 }
 
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index b4f49720c87f..2e3f6fc67c56 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -217,6 +217,13 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "03.05"),
 		}
 	},
+	{
+		.ident = "MECHREVO Wujie 14X (GX4HRXL)",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE14-GX4HRXL"),
+		}
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index cb5abab2210a..b6bcc1d57f96 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -334,6 +334,11 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 	return 0;
 }
 
+static inline bool amd_pmf_pb_valid(struct amd_pmf_dev *dev)
+{
+	return memchr_inv(dev->policy_buf, 0xff, dev->policy_sz);
+}
+
 #ifdef CONFIG_AMD_PMF_DEBUG
 static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev)
 {
@@ -361,12 +366,22 @@ static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
 	dev->policy_buf = new_policy_buf;
 	dev->policy_sz = length;
 
+	if (!amd_pmf_pb_valid(dev)) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
 	amd_pmf_hex_dump_pb(dev);
 	ret = amd_pmf_start_policy_engine(dev);
 	if (ret < 0)
-		return ret;
+		goto cleanup;
 
 	return length;
+
+cleanup:
+	kfree(dev->policy_buf);
+	dev->policy_buf = NULL;
+	return ret;
 }
 
 static const struct file_operations pb_fops = {
@@ -528,6 +543,12 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 
 	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
 
+	if (!amd_pmf_pb_valid(dev)) {
+		dev_info(dev->dev, "No Smart PC policy present\n");
+		ret = -EINVAL;
+		goto err_free_policy;
+	}
+
 	amd_pmf_hex_dump_pb(dev);
 
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 1101e5b2488e..a1cff9ff35a9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4795,7 +4795,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_leds;
 
 	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_WLAN, &result);
-	if (result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
+	if ((result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT)) ==
+	    (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
 		asus->driver->wlan_ctrl_by_user = 1;
 
 	if (!(asus->driver->wlan_ctrl_by_user && ashs_present())) {
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index 59eb23d467ec..198d45f8e884 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -132,7 +132,7 @@ static int max20086_regulators_register(struct max20086 *chip)
 
 static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 {
-	struct of_regulator_match matches[MAX20086_MAX_REGULATORS] = { };
+	struct of_regulator_match *matches;
 	struct device_node *node;
 	unsigned int i;
 	int ret;
@@ -143,6 +143,11 @@ static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 		return -ENODEV;
 	}
 
+	matches = devm_kcalloc(chip->dev, chip->info->num_outputs,
+			       sizeof(*matches), GFP_KERNEL);
+	if (!matches)
+		return -ENOMEM;
+
 	for (i = 0; i < chip->info->num_outputs; ++i)
 		matches[i].name = max20086_output_names[i];
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 6ab27f4f4878..b8d42098f0b6 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -169,6 +169,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 					unsigned int nr_zones, size_t *buflen)
 {
 	struct request_queue *q = sdkp->disk->queue;
+	unsigned int max_segments;
 	size_t bufsize;
 	void *buf;
 
@@ -180,12 +181,15 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 	 * Furthermore, since the report zone command cannot be split, make
 	 * sure that the allocated buffer can always be mapped by limiting the
 	 * number of pages allocated to the HBA max segments limit.
+	 * Since max segments can be larger than the max inline bio vectors,
+	 * further limit the allocated buffer to BIO_MAX_INLINE_VECS.
 	 */
 	nr_zones = min(nr_zones, sdkp->zone_info.nr_zones);
 	bufsize = roundup((nr_zones + 1) * 64, SECTOR_SIZE);
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
-	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+	max_segments = min(BIO_MAX_INLINE_VECS, queue_max_segments(q));
+	bufsize = min_t(size_t, bufsize, max_segments << PAGE_SHIFT);
 
 	while (bufsize >= SECTOR_SIZE) {
 		buf = kvzalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index b8186feccdf5..48b0ca92b44f 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1819,6 +1819,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 				return SCSI_MLQUEUE_DEVICE_BUSY;
 		}
 
+		payload->rangecount = 1;
 		payload->range.len = length;
 		payload->range.offset = offset_in_hvpg;
 
diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 31a878d9458d..7740f94847a8 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -420,7 +420,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5c7eb020943b..11db703a0dde 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+	if ((setup->value && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->value && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->value && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 870409599411..c2759bbeed84 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -131,15 +131,12 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 	vmbus_device_unregister(channel->device_obj);
 }
 
-/* Sysfs API to allow mmap of the ring buffers
+/* Function used for mmap of ring buffer sysfs interface.
  * The ring buffer is allocated as contiguous memory by vmbus_open
  */
-static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
-			    struct bin_attribute *attr,
-			    struct vm_area_struct *vma)
+static int
+hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
 {
-	struct vmbus_channel *channel
-		= container_of(kobj, struct vmbus_channel, kobj);
 	void *ring_buffer = page_address(channel->ringbuffer_page);
 
 	if (channel->state != CHANNEL_OPENED_STATE)
@@ -149,15 +146,6 @@ static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
 			       channel->ringbuffer_pagecount << PAGE_SHIFT);
 }
 
-static const struct bin_attribute ring_buffer_bin_attr = {
-	.attr = {
-		.name = "ring",
-		.mode = 0600,
-	},
-	.size = 2 * SZ_2M,
-	.mmap = hv_uio_ring_mmap,
-};
-
 /* Callback from VMBUS subsystem when new channel created. */
 static void
 hv_uio_new_channel(struct vmbus_channel *new_sc)
@@ -178,8 +166,7 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 	/* Disable interrupts on sub channel */
 	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
-
-	ret = sysfs_create_bin_file(&new_sc->kobj, &ring_buffer_bin_attr);
+	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
 		dev_err(device, "sysfs create ring bin file failed; %d\n", ret);
 		vmbus_close(new_sc);
@@ -350,10 +337,18 @@ hv_uio_probe(struct hv_device *dev,
 		goto fail_close;
 	}
 
-	ret = sysfs_create_bin_file(&channel->kobj, &ring_buffer_bin_attr);
-	if (ret)
-		dev_notice(&dev->device,
-			   "sysfs create ring bin file failed; %d\n", ret);
+	/*
+	 * This internally calls sysfs_update_group, which returns a non-zero value if it executes
+	 * before sysfs_create_group. This is expected as the 'ring' will be created later in
+	 * vmbus_device_register() -> vmbus_add_channel_kobj(). Thus, no need to check the return
+	 * value and print warning.
+	 *
+	 * Creating/exposing sysfs in driver probe is not encouraged as it can lead to race
+	 * conditions with userspace. For backward compatibility, "ring" sysfs could not be removed
+	 * or decoupled from uio_hv_generic probe. Userspace programs can make use of inotify
+	 * APIs to make sure that ring is created.
+	 */
+	hv_create_ring_sysfs(channel, hv_uio_ring_mmap);
 
 	hv_set_drvdata(dev, pdata);
 
@@ -375,7 +370,7 @@ hv_uio_remove(struct hv_device *dev)
 	if (!pdata)
 		return;
 
-	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
+	hv_remove_ring_sysfs(dev->channel);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 8c9d0074db58..0c45936f51b3 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -475,7 +475,7 @@ static void reply_ump_stream_ep_info(struct f_midi2_ep *ep)
 /* reply a UMP EP device info */
 static void reply_ump_stream_ep_device(struct f_midi2_ep *ep)
 {
-	struct snd_ump_stream_msg_devince_info rep = {
+	struct snd_ump_stream_msg_device_info rep = {
 		.type = UMP_MSG_TYPE_STREAM,
 		.status = UMP_STREAM_MSG_STATUS_DEVICE_INFO,
 		.manufacture_id = ep->info.manufacturer,
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 241d7aa1fbc2..d35f3a18dd13 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -822,6 +822,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
 	union xhci_trb		*evt;
+	enum evtreturn		ret = EVT_DONE;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
 
@@ -906,6 +907,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
+			ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -924,7 +926,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 		lo_hi_writeq(deq, &dbc->regs->erdp);
 	}
 
-	return EVT_DONE;
+	return ret;
 }
 
 static void xhci_dbc_handle_events(struct work_struct *work)
@@ -933,6 +935,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	struct xhci_dbc		*dbc;
 	unsigned long		flags;
 	unsigned int		poll_interval;
+	unsigned long		busypoll_timelimit;
 
 	dbc = container_of(to_delayed_work(work), struct xhci_dbc, event_work);
 	poll_interval = dbc->poll_interval;
@@ -951,10 +954,20 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 			dbc->driver->disconnect(dbc);
 		break;
 	case EVT_DONE:
-		/* set fast poll rate if there are pending data transfers */
+		/*
+		 * Set fast poll rate if there are pending out transfers, or
+		 * a transfer was recently processed
+		 */
+		busypoll_timelimit = dbc->xfer_timestamp +
+			msecs_to_jiffies(DBC_XFER_INACTIVITY_TIMEOUT);
+
 		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
-		    !list_empty(&dbc->eps[BULK_IN].list_pending))
-			poll_interval = 1;
+		    time_is_after_jiffies(busypoll_timelimit))
+			poll_interval = 0;
+		break;
+	case EVT_XFER_DONE:
+		dbc->xfer_timestamp = jiffies;
+		poll_interval = 0;
 		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 9dc8f4d8077c..47ac72c2286d 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -96,6 +96,7 @@ struct dbc_ep {
 #define DBC_WRITE_BUF_SIZE		8192
 #define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
 #define DBC_POLL_INTERVAL_MAX		5000	/* milliseconds */
+#define DBC_XFER_INACTIVITY_TIMEOUT	10	/* milliseconds */
 /*
  * Private structure for DbC hardware state:
  */
@@ -142,6 +143,7 @@ struct xhci_dbc {
 	enum dbc_state			state;
 	struct delayed_work		event_work;
 	unsigned int			poll_interval;	/* ms */
+	unsigned long			xfer_timestamp;
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
@@ -187,6 +189,7 @@ struct dbc_request {
 enum evtreturn {
 	EVT_ERR	= -1,
 	EVT_DONE,
+	EVT_XFER_DONE,
 	EVT_GSER,
 	EVT_DISC,
 };
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 5d24a2321e15..8aae80b457d7 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -54,7 +54,8 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	u8 cur = 0;
 	int ret;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -100,7 +101,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	schedule_work(&dp->work);
 	ret = 0;
 err_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -112,7 +113,8 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	u64 command;
 	int ret = 0;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -144,7 +146,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	schedule_work(&dp->work);
 
 out_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -202,20 +204,21 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 	int cmd = PD_VDO_CMD(header);
 	int svdm_version;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
 
 		dev_warn(&p->dev,
 			 "firmware doesn't support alternate mode overriding\n");
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return -EOPNOTSUPP;
 	}
 
 	svdm_version = typec_altmode_get_svdm_version(alt);
 	if (svdm_version < 0) {
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return svdm_version;
 	}
 
@@ -259,7 +262,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 		break;
 	}
 
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return 0;
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 3f2bc13efa48..8eee3d8e588a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1903,6 +1903,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
 }
 EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
 
+/**
+ * ucsi_con_mutex_lock - Acquire the connector mutex
+ * @con: The connector interface to lock
+ *
+ * Returns true on success, false if the connector is disconnected
+ */
+bool ucsi_con_mutex_lock(struct ucsi_connector *con)
+{
+	bool mutex_locked = false;
+	bool connected = true;
+
+	while (connected && !mutex_locked) {
+		mutex_locked = mutex_trylock(&con->lock) != 0;
+		connected = con->status.flags & UCSI_CONSTAT_CONNECTED;
+		if (connected && !mutex_locked)
+			msleep(20);
+	}
+
+	connected = connected && con->partner;
+	if (!connected && mutex_locked)
+		mutex_unlock(&con->lock);
+
+	return connected;
+}
+
+/**
+ * ucsi_con_mutex_unlock - Release the connector mutex
+ * @con: The connector interface to unlock
+ */
+void ucsi_con_mutex_unlock(struct ucsi_connector *con)
+{
+	mutex_unlock(&con->lock);
+}
+
 /**
  * ucsi_create - Allocate UCSI instance
  * @dev: Device interface to the PPM (Platform Policy Manager)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index a333006d3496..5863a20b6c5d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -91,6 +91,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0112742e4504..1f8a322eb00b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2815,6 +2815,7 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2826,7 +2827,8 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2834,6 +2836,8 @@ int virtqueue_reset(struct virtqueue *_vq,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 0a216a078c31..47335a0f4a61 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -825,6 +825,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_brk;
+	bool brk_moved = false;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1092,15 +1093,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			/* Calculate any requested alignment. */
 			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 
-			/*
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with PT_INTERP)
-			 * and loaders (ET_DYN without PT_INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
+			/**
+			 * DOC: PIE handling
+			 *
+			 * There are effectively two types of ET_DYN ELF
+			 * binaries: programs (i.e. PIE: ET_DYN with
+			 * PT_INTERP) and loaders (i.e. static PIE: ET_DYN
+			 * without PT_INTERP, usually the ELF interpreter
+			 * itself). Loaders must be loaded away from programs
+			 * since the program may otherwise collide with the
+			 * loader (especially for ET_EXEC which does not have
+			 * a randomized position).
+			 *
+			 * For example, to handle invocations of
 			 * "./ld.so someprog" to test out a new version of
 			 * the loader, the subsequent program that the
 			 * loader loads must avoid the loader itself, so
@@ -1113,6 +1118,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
+			 *
+			 * See below for "brk" handling details, which is
+			 * also affected by program vs loader and ASLR.
 			 */
 			if (interpreter) {
 				/* On ET_DYN with PT_INTERP, we do the ASLR. */
@@ -1229,8 +1237,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data += load_bias;
 	end_data += load_bias;
 
-	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
-
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
@@ -1286,27 +1292,44 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
+	/**
+	 * DOC: "brk" handling
+	 *
+	 * For architectures with ELF randomization, when executing a
+	 * loader directly (i.e. static PIE: ET_DYN without PT_INTERP),
+	 * move the brk area out of the mmap region and into the unused
+	 * ELF_ET_DYN_BASE region. Since "brk" grows up it may collide
+	 * early with the stack growing down or other regions being put
+	 * into the mmap region by the kernel (e.g. vdso).
+	 *
+	 * In the CONFIG_COMPAT_BRK case, though, everything is turned
+	 * off because we're not allowed to move the brk at all.
+	 */
+	if (!IS_ENABLED(CONFIG_COMPAT_BRK) &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
+	    elf_ex->e_type == ET_DYN && !interpreter) {
+		elf_brk = ELF_ET_DYN_BASE;
+		/* This counts as moving the brk, so let brk(2) know. */
+		brk_moved = true;
+	}
+	mm->start_brk = mm->brk = ELF_PAGEALIGN(elf_brk);
+
+	if ((current->flags & PF_RANDOMIZE) && snapshot_randomize_va_space > 1) {
 		/*
-		 * For architectures with ELF randomization, when executing
-		 * a loader directly (i.e. no interpreter listed in ELF
-		 * headers), move the brk area out of the mmap region
-		 * (since it grows up, and may collide early with the stack
-		 * growing down), and into the unused ELF_ET_DYN_BASE region.
+		 * If we didn't move the brk to ELF_ET_DYN_BASE (above),
+		 * leave a gap between .bss and brk.
 		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
-		    elf_ex->e_type == ET_DYN && !interpreter) {
-			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
-		} else {
-			/* Otherwise leave a gap between .bss and brk. */
+		if (!brk_moved)
 			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
-		}
 
 		mm->brk = mm->start_brk = arch_randomize_brk(mm);
+		brk_moved = true;
+	}
+
 #ifdef compat_brk_randomized
+	if (brk_moved)
 		current->brk_randomized = 1;
 #endif
-	}
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e815d165cccc..e9cdc1759dad 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -94,8 +94,6 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				  struct btrfs_block_group *block_group)
 {
 	lockdep_assert_held(&discard_ctl->lock);
-	if (!btrfs_run_discard_work(discard_ctl))
-		return;
 
 	if (list_empty(&block_group->discard_list) ||
 	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
@@ -118,6 +116,9 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	if (!btrfs_is_block_group_data_only(block_group))
 		return;
 
+	if (!btrfs_run_discard_work(discard_ctl))
+		return;
+
 	spin_lock(&discard_ctl->lock);
 	__add_to_discard_list(discard_ctl, block_group);
 	spin_unlock(&discard_ctl->lock);
@@ -250,6 +251,18 @@ static struct btrfs_block_group *peek_discard_list(
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group)) {
 				__add_to_discard_list(discard_ctl, block_group);
+				/*
+				 * The block group must have been moved to other
+				 * discard list even if discard was disabled in
+				 * the meantime or a transaction abort happened,
+				 * otherwise we can end up in an infinite loop,
+				 * always jumping into the 'again' label and
+				 * keep getting this block group over and over
+				 * in case there are no other block groups in
+				 * the discard lists.
+				 */
+				ASSERT(block_group->discard_index !=
+				       BTRFS_DISCARD_INDEX_UNUSED);
 			} else {
 				list_del_init(&block_group->discard_list);
 				btrfs_put_block_group(block_group);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cbfb225858a5..bb822e425d7f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -285,6 +285,7 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
+#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
 struct btrfs_dev_replace {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bee8852e8155..9ce1270addb0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1187,6 +1187,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	struct extent_state *cached = NULL;
 	struct extent_map *em;
 	int ret = 0;
+	bool free_pages = false;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
@@ -1207,7 +1208,10 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 
 	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
+		ASSERT(!async_extent->folios);
+		ASSERT(async_extent->nr_folios == 0);
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1223,6 +1227,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		 * fall back to uncompressed.
 		 */
 		submit_uncompressed_range(inode, async_extent, locked_folio);
+		free_pages = true;
 		goto done;
 	}
 
@@ -1264,6 +1269,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 done:
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
+	if (free_pages)
+		free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	return;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 08ccf5d5e144..bcb8def4ade2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -570,6 +570,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_commit_interval:
 		ctx->commit_interval = result.uint_32;
+		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
+			btrfs_warn(NULL, "excessive commit interval %u, use with care",
+				   ctx->commit_interval);
+		}
 		if (ctx->commit_interval == 0)
 			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 		break;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e7bc99c69743..ca01f79c82e4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7040,10 +7040,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	struct nfs4_unlockdata *p;
 	struct nfs4_state *state = lsp->ls_state;
 	struct inode *inode = state->inode;
+	struct nfs_lock_context *l_ctx;
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return NULL;
+	l_ctx = nfs_get_lock_context(ctx);
+	if (!IS_ERR(l_ctx)) {
+		p->l_ctx = l_ctx;
+	} else {
+		kfree(p);
+		return NULL;
+	}
 	p->arg.fh = NFS_FH(inode);
 	p->arg.fl = &p->fl;
 	p->arg.seqid = seqid;
@@ -7051,7 +7059,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	p->lsp = lsp;
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
-	p->l_ctx = nfs_get_lock_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 5f582713bf05..683e09be25ad 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -745,6 +745,14 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 	return remaining;
 }
 
+static void pnfs_reset_return_info(struct pnfs_layout_hdr *lo)
+{
+	struct pnfs_layout_segment *lseg;
+
+	list_for_each_entry(lseg, &lo->plh_return_segs, pls_list)
+		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
+}
+
 static void
 pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
 		struct list_head *free_me,
@@ -1292,6 +1300,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
 		pnfs_set_layout_stateid(lo, stateid, NULL, true);
+		pnfs_reset_return_info(lo);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 2ad067886ec3..bc1c1e9b288a 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -82,6 +82,9 @@ struct key_type cifs_spnego_key_type = {
 /* strlen of ";pid=0x" */
 #define PID_KEY_LEN		7
 
+/* strlen of ";upcall_target=" */
+#define UPCALL_TARGET_KEY_LEN	15
+
 /* get a key struct with a SPNEGO security blob, suitable for session setup */
 struct key *
 cifs_get_spnego_key(struct cifs_ses *sesInfo,
@@ -108,6 +111,11 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	if (sesInfo->user_name)
 		desc_len += USER_KEY_LEN + strlen(sesInfo->user_name);
 
+	if (sesInfo->upcall_target == UPTARGET_MOUNT)
+		desc_len += UPCALL_TARGET_KEY_LEN + 5; // strlen("mount")
+	else
+		desc_len += UPCALL_TARGET_KEY_LEN + 3; // strlen("app")
+
 	spnego_key = ERR_PTR(-ENOMEM);
 	description = kzalloc(desc_len, GFP_KERNEL);
 	if (description == NULL)
@@ -158,6 +166,14 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	dp = description + strlen(description);
 	sprintf(dp, ";pid=0x%x", current->pid);
 
+	if (sesInfo->upcall_target == UPTARGET_MOUNT) {
+		dp = description + strlen(description);
+		sprintf(dp, ";upcall_target=mount");
+	} else {
+		dp = description + strlen(description);
+		sprintf(dp, ";upcall_target=app");
+	}
+
 	cifs_dbg(FYI, "key description = %s\n", description);
 	saved_cred = override_creds(spnego_cred);
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0ceebde38f9f..9d96b833015c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -547,6 +547,30 @@ static int cifs_show_devname(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static void
+cifs_show_upcall_target(struct seq_file *s, struct cifs_sb_info *cifs_sb)
+{
+	if (cifs_sb->ctx->upcall_target == UPTARGET_UNSPECIFIED) {
+		seq_puts(s, ",upcall_target=app");
+		return;
+	}
+
+	seq_puts(s, ",upcall_target=");
+
+	switch (cifs_sb->ctx->upcall_target) {
+	case UPTARGET_APP:
+		seq_puts(s, "app");
+		break;
+	case UPTARGET_MOUNT:
+		seq_puts(s, "mount");
+		break;
+	default:
+		/* shouldn't ever happen */
+		seq_puts(s, "unknown");
+		break;
+	}
+}
+
 /*
  * cifs_show_options() is for displaying mount options in /proc/mounts.
  * Not all settable options are displayed but most of the important
@@ -563,6 +587,7 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 	seq_show_option(s, "vers", tcon->ses->server->vals->version_string);
 	cifs_show_security(s, tcon->ses);
 	cifs_show_cache_flavor(s, cifs_sb);
+	cifs_show_upcall_target(s, cifs_sb);
 
 	if (tcon->no_lease)
 		seq_puts(s, ",nolease");
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a8484af7a2fb..a38b40d68b14 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -154,6 +154,12 @@ enum securityEnum {
 	IAKerb,			/* Kerberos proxy */
 };
 
+enum upcall_target_enum {
+	UPTARGET_UNSPECIFIED, /* not specified, defaults to app */
+	UPTARGET_MOUNT, /* upcall to the mount namespace */
+	UPTARGET_APP, /* upcall to the application namespace which did the mount */
+};
+
 enum cifs_reparse_type {
 	CIFS_REPARSE_TYPE_NFS,
 	CIFS_REPARSE_TYPE_WSL,
@@ -1085,6 +1091,7 @@ struct cifs_ses {
 	struct session_key auth_key;
 	struct ntlmssp_auth *ntlmssp; /* ciphertext, flags, server challenge */
 	enum securityEnum sectype; /* what security flavor was specified? */
+	enum upcall_target_enum upcall_target; /* what upcall target was specified? */
 	bool sign;		/* is signing required? */
 	bool domainAuto:1;
 	bool expired_pwd;  /* track if access denied or expired pwd so can know if need to update */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d5549e06a533..112057c7ca11 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2381,6 +2381,26 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 
 	ses->sectype = ctx->sectype;
 	ses->sign = ctx->sign;
+
+	/*
+	 *Explicitly marking upcall_target mount option for easier handling
+	 * by cifs_spnego.c and eventually cifs.upcall.c
+	 */
+
+	switch (ctx->upcall_target) {
+	case UPTARGET_UNSPECIFIED: /* default to app */
+	case UPTARGET_APP:
+		ses->upcall_target = UPTARGET_APP;
+		break;
+	case UPTARGET_MOUNT:
+		ses->upcall_target = UPTARGET_MOUNT;
+		break;
+	default:
+		// should never happen
+		ses->upcall_target = UPTARGET_APP;
+		break;
+	}
+
 	ses->local_nls = load_nls(ctx->local_nls->charset);
 
 	/* add server as first channel */
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 1f1f4586673a..69cca4f17dba 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -67,6 +67,12 @@ static const match_table_t cifs_secflavor_tokens = {
 	{ Opt_sec_err, NULL }
 };
 
+static const match_table_t cifs_upcall_target = {
+	{ Opt_upcall_target_mount, "mount" },
+	{ Opt_upcall_target_application, "app" },
+	{ Opt_upcall_target_err, NULL }
+};
+
 const struct fs_parameter_spec smb3_fs_parameters[] = {
 	/* Mount options that take no arguments */
 	fsparam_flag_no("user_xattr", Opt_user_xattr),
@@ -179,6 +185,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
 	fsparam_string("sec", Opt_sec),
 	fsparam_string("cache", Opt_cache),
 	fsparam_string("reparse", Opt_reparse),
+	fsparam_string("upcall_target", Opt_upcalltarget),
 
 	/* Arguments that should be ignored */
 	fsparam_flag("guest", Opt_ignore),
@@ -249,6 +256,29 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 	return 0;
 }
 
+static int
+cifs_parse_upcall_target(struct fs_context *fc, char *value, struct smb3_fs_context *ctx)
+{
+	substring_t args[MAX_OPT_ARGS];
+
+	ctx->upcall_target = UPTARGET_UNSPECIFIED;
+
+	switch (match_token(value, cifs_upcall_target, args)) {
+	case Opt_upcall_target_mount:
+		ctx->upcall_target = UPTARGET_MOUNT;
+		break;
+	case Opt_upcall_target_application:
+		ctx->upcall_target = UPTARGET_APP;
+		break;
+
+	default:
+		cifs_errorf(fc, "bad upcall target: %s\n", value);
+		return 1;
+	}
+
+	return 0;
+}
+
 static const match_table_t cifs_cacheflavor_tokens = {
 	{ Opt_cache_loose, "loose" },
 	{ Opt_cache_strict, "strict" },
@@ -1526,6 +1556,10 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		if (cifs_parse_security_flavors(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
 		break;
+	case Opt_upcalltarget:
+		if (cifs_parse_upcall_target(fc, param->string, ctx) != 0)
+			goto cifs_parse_mount_err;
+		break;
 	case Opt_cache:
 		if (cifs_parse_cache_flavor(fc, param->string, ctx) != 0)
 			goto cifs_parse_mount_err;
@@ -1703,6 +1737,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 	}
 	/* case Opt_ignore: - is ignored as expected ... */
 
+	if (ctx->multiuser && ctx->upcall_target == UPTARGET_MOUNT) {
+		cifs_errorf(fc, "multiuser mount option not supported with upcalltarget set as 'mount'\n");
+		goto cifs_parse_mount_err;
+	}
+
 	return 0;
 
  cifs_parse_mount_err:
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index c8c8b4451b3b..ac6baa774ad3 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -61,6 +61,12 @@ enum cifs_sec_param {
 	Opt_sec_err
 };
 
+enum cifs_upcall_target_param {
+	Opt_upcall_target_mount,
+	Opt_upcall_target_application,
+	Opt_upcall_target_err
+};
+
 enum cifs_param {
 	/* Mount options that take no arguments */
 	Opt_user_xattr,
@@ -114,6 +120,8 @@ enum cifs_param {
 	Opt_multichannel,
 	Opt_compress,
 	Opt_witness,
+	Opt_is_upcall_target_mount,
+	Opt_is_upcall_target_application,
 
 	/* Mount options which take numeric value */
 	Opt_backupuid,
@@ -157,6 +165,7 @@ enum cifs_param {
 	Opt_sec,
 	Opt_cache,
 	Opt_reparse,
+	Opt_upcalltarget,
 
 	/* Mount options to be ignored */
 	Opt_ignore,
@@ -198,6 +207,7 @@ struct smb3_fs_context {
 	umode_t file_mode;
 	umode_t dir_mode;
 	enum securityEnum sectype; /* sectype requested via mnt opts */
+	enum upcall_target_enum upcall_target; /* where to upcall for mount */
 	bool sign; /* was signing requested via mnt opts? */
 	bool ignore_signature:1;
 	bool retry:1;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 83022a476e3b..176be478cd13 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2985,7 +2985,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 	/* Eventually save off posix specific response info and timestamps */
 
 err_free_rsp_buf:
-	free_rsp_buf(resp_buftype, rsp);
+	free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 	kfree(pc_buf);
 err_free_req:
 	cifs_small_buf_release(req);
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 4f33a4a48886..b4071c9cf8c9 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -115,7 +115,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 	}
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
-	if (ret == 0)
+	if (ret >= 0)
 		iinfo->i_lenExtents = inode->i_size;
 	brelse(epos.bh);
 }
diff --git a/fs/xattr.c b/fs/xattr.c
index 05ec7e7d9e87..4f5a45338a83 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1290,6 +1290,15 @@ static bool xattr_is_trusted(const char *name)
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
 }
 
+static bool xattr_is_maclabel(const char *name)
+{
+	const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
+
+	return !strncmp(name, XATTR_SECURITY_PREFIX,
+			XATTR_SECURITY_PREFIX_LEN) &&
+		security_ismaclabel(suffix);
+}
+
 /**
  * simple_xattr_list - list all xattr objects
  * @inode: inode from which to get the xattrs
@@ -1322,6 +1331,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	if (err)
 		return err;
 
+	err = security_inode_listsecurity(inode, buffer, remaining_size);
+	if (err < 0)
+		return err;
+
+	if (buffer) {
+		if (remaining_size < err)
+			return -ERANGE;
+		buffer += err;
+	}
+	remaining_size -= err;
+
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
 		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
@@ -1330,6 +1350,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
 
+		/* skip MAC labels; these are provided by LSM above */
+		if (xattr_is_maclabel(xattr->name))
+			continue;
+
 		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
 		if (err)
 			break;
diff --git a/include/drm/drm_fbdev_dma.h b/include/drm/drm_fbdev_dma.h
index 2da7ee784133..6ae4de46497c 100644
--- a/include/drm/drm_fbdev_dma.h
+++ b/include/drm/drm_fbdev_dma.h
@@ -4,12 +4,24 @@
 #define DRM_FBDEV_DMA_H
 
 struct drm_device;
+struct drm_fb_helper;
+struct drm_fb_helper_surface_size;
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
+int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
+				     struct drm_fb_helper_surface_size *sizes);
+
+#define DRM_FBDEV_DMA_DRIVER_OPS \
+	.fbdev_probe = drm_fbdev_dma_driver_fbdev_probe
+
 void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp);
 #else
 static inline void drm_fbdev_dma_setup(struct drm_device *dev, unsigned int preferred_bpp)
 { }
+
+#define DRM_FBDEV_DMA_DRIVER_OPS \
+	.fbdev_probe = NULL
+
 #endif
 
 #endif
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 66b7620a1b53..9e98fb87e7ef 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 
 #define BIO_MAX_VECS		256U
+#define BIO_MAX_INLINE_VECS	UIO_MAXIOV
 
 struct queue_limits;
 
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 02a226bcf0ed..44bf8af37901 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1067,6 +1067,12 @@ struct vmbus_channel {
 
 	/* The max size of a packet on this channel */
 	u32 max_pkt_size;
+
+	/* function to mmap ring buffer memory to the channel's sysfs ring attribute */
+	int (*mmap_ring_buffer)(struct vmbus_channel *channel, struct vm_area_struct *vma);
+
+	/* boolean to control visibility of sysfs for ring buffer */
+	bool ring_sysfs_visible;
 };
 
 #define lock_requestor(channel, flags)					\
@@ -1226,13 +1232,6 @@ extern int vmbus_sendpacket(struct vmbus_channel *channel,
 				  enum vmbus_packet_type type,
 				  u32 flags);
 
-extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-					    struct hv_page_buffer pagebuffers[],
-					    u32 pagecount,
-					    void *buffer,
-					    u32 bufferlen,
-					    u64 requestid);
-
 extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     struct vmbus_packet_mpb_array *mpb,
 				     u32 desc_size,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 15206450929d..2e836d44f738 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -260,11 +260,17 @@ union kvm_mmu_notifier_arg {
 	unsigned long attributes;
 };
 
+enum kvm_gfn_range_filter {
+	KVM_FILTER_SHARED		= BIT(0),
+	KVM_FILTER_PRIVATE		= BIT(1),
+};
+
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
 	gfn_t end;
 	union kvm_mmu_notifier_arg arg;
+	enum kvm_gfn_range_filter attr_filter;
 	bool may_block;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c00..a3d8305e88a5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -224,7 +224,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
@@ -257,6 +257,7 @@ enum tpm2_return_codes {
 	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
 	TPM2_RC_REFERENCE_H0	= 0x0910,
 	TPM2_RC_RETRY		= 0x0922,
+	TPM2_RC_SESSION_MEMORY	= 0x0903,
 };
 
 enum tpm2_command_codes {
@@ -437,6 +438,24 @@ static inline u32 tpm2_rc_value(u32 rc)
 	return (rc & BIT(7)) ? rc & 0xbf : rc;
 }
 
+/*
+ * Convert a return value from tpm_transmit_cmd() to POSIX error code.
+ */
+static inline ssize_t tpm_ret_to_err(ssize_t ret)
+{
+	if (ret < 0)
+		return ret;
+
+	switch (tpm2_rc_value(ret)) {
+	case TPM2_RC_SUCCESS:
+		return 0;
+	case TPM2_RC_SESSION_MEMORY:
+		return -ENOMEM;
+	default:
+		return -EFAULT;
+	}
+}
+
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 73c8922e69e0..d791d47eb00e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -103,7 +103,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq));
 
 struct virtio_admin_cmd {
 	__le16 opcode;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 24e48af7e8f7..a9d7e9ecee6b 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1031,6 +1031,21 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (skb) {
+		sch->q.qlen--;
+		return skb;
+	}
+	if (direct)
+		return __qdisc_dequeue_head(&sch->q);
+	else
+		return sch->dequeue(sch);
+}
+
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 {
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
diff --git a/include/sound/ump_msg.h b/include/sound/ump_msg.h
index 72f60ddfea75..9556b4755a1e 100644
--- a/include/sound/ump_msg.h
+++ b/include/sound/ump_msg.h
@@ -604,7 +604,7 @@ struct snd_ump_stream_msg_ep_info {
 } __packed;
 
 /* UMP Stream Message: Device Info Notification (128bit) */
-struct snd_ump_stream_msg_devince_info {
+struct snd_ump_stream_msg_device_info {
 #ifdef __BIG_ENDIAN_BITFIELD
 	/* 0 */
 	u32 type:4;
@@ -754,7 +754,7 @@ struct snd_ump_stream_msg_fb_name {
 union snd_ump_stream_msg {
 	struct snd_ump_stream_msg_ep_discovery ep_discovery;
 	struct snd_ump_stream_msg_ep_info ep_info;
-	struct snd_ump_stream_msg_devince_info device_info;
+	struct snd_ump_stream_msg_device_info device_info;
 	struct snd_ump_stream_msg_stream_cfg stream_cfg;
 	struct snd_ump_stream_msg_fb_discovery fb_discovery;
 	struct snd_ump_stream_msg_fb_info fb_info;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c709a05023cd..d1fb4bfbbd4c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1100,9 +1100,11 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 		if (top_cs) {
 			/*
-			 * Percpu kthreads in top_cpuset are ignored
+			 * PF_NO_SETAFFINITY tasks are ignored.
+			 * All per cpu kthreads should have PF_NO_SETAFFINITY
+			 * flag set, see kthread_set_per_cpu().
 			 */
-			if (kthread_is_per_cpu(task))
+			if (task->flags & PF_NO_SETAFFINITY)
 				continue;
 			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
 		} else {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7ed25654820f..ace5262642f9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6731,6 +6731,12 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
 		     __alignof__(struct bpf_iter_scx_dsq));
 
+	/*
+	 * next() and destroy() will be called regardless of the return value.
+	 * Always clear $kit->dsq.
+	 */
+	kit->dsq = NULL;
+
 	if (flags & ~__SCX_DSQ_ITER_USER_FLAGS)
 		return -EINVAL;
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e1ffbed8cc5e..baa5547e977a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1832,10 +1832,12 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 	head_page = cpu_buffer->head_page;
 
-	/* If both the head and commit are on the reader_page then we are done. */
-	if (head_page == cpu_buffer->reader_page &&
-	    head_page == cpu_buffer->commit_page)
+	/* If the commit_buffer is the reader page, update the commit page */
+	if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
+		cpu_buffer->commit_page = cpu_buffer->reader_page;
+		/* Nothing more to do, the only page is the reader page */
 		goto done;
+	}
 
 	/* Iterate until finding the commit page */
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..c9b0533407ed 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -16,7 +16,7 @@
 #include "trace_output.h"	/* for trace_event_sem */
 #include "trace_dynevent.h"
 
-static DEFINE_MUTEX(dyn_event_ops_mutex);
+DEFINE_MUTEX(dyn_event_ops_mutex);
 static LIST_HEAD(dyn_event_ops_list);
 
 bool trace_event_dyn_try_get_ref(struct trace_event_call *dyn_call)
@@ -125,6 +125,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	return ret;
 }
 
+/*
+ * Locked version of event creation. The event creation must be protected by
+ * dyn_event_ops_mutex because of protecting trace_probe_log.
+ */
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
+{
+	int ret;
+
+	mutex_lock(&dyn_event_ops_mutex);
+	ret = type->create(raw_command);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return ret;
+}
+
 static int create_dyn_event(const char *raw_command)
 {
 	struct dyn_event_operations *ops;
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 936477a111d3..beee3f8d7544 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -100,6 +100,7 @@ void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
 void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
 int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type);
 
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a5e3d6acf1e1..27e21488d574 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1581,7 +1581,7 @@ stacktrace_trigger(struct event_trigger_data *data,
 	struct trace_event_file *file = data->private_data;
 
 	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 	else
 		trace_dump_stack(STACK_SKIP);
 }
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index fbbc3c719d2f..fbb6cf8dc047 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -574,11 +574,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx();
-
-	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
+	__trace_stack(tr, tracing_gen_ctx_dec(), FTRACE_STACK_SKIP);
 }
 
 static void
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 935a886af40c..6b9c3f3f870f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1090,7 +1090,7 @@ static int create_or_delete_trace_kprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_kprobe_ops);
 
-	ret = trace_kprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_kprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 578919962e5d..ae20ad7f7461 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -154,9 +154,12 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
 }
 
 static struct trace_probe_log trace_probe_log;
+extern struct mutex dyn_event_ops_mutex;
 
 void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.subsystem = subsystem;
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
@@ -165,11 +168,15 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 
 void trace_probe_log_clear(void)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
 }
 
 void trace_probe_log_set_index(int index)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.index = index;
 }
 
@@ -178,6 +185,8 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	if (!trace_probe_log.argv)
 		return;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b085a8a164ea..9916677acf24 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -739,7 +739,7 @@ static int create_or_delete_trace_uprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_uprobe_ops);
 
-	ret = trace_uprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_uprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d29da0c6a7f2..ebe1ec661492 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7041,9 +7041,6 @@ bool has_managed_dma(void)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 
-/* Counts number of zones with unaccepted pages. */
-static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
-
 static bool lazy_accept = true;
 
 static int __init accept_memory_parse(char *p)
@@ -7070,11 +7067,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 static void __accept_page(struct zone *zone, unsigned long *flags,
 			  struct page *page)
 {
-	bool last;
-
 	list_del(&page->lru);
-	last = list_empty(&zone->unaccepted_pages);
-
 	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	__ClearPageUnaccepted(page);
@@ -7083,9 +7076,6 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
 	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
-
-	if (last)
-		static_branch_dec(&zones_with_unaccepted_pages);
 }
 
 void accept_page(struct page *page)
@@ -7122,19 +7112,11 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept, wmark;
 	bool ret = false;
 
-	if (!has_unaccepted_memory())
-		return false;
-
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
@@ -7168,22 +7150,17 @@ static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
 	unsigned long flags;
-	bool first = false;
 
 	if (!lazy_accept)
 		return false;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	__SetPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	if (first)
-		static_branch_inc(&zones_with_unaccepted_pages);
-
 	return true;
 }
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 748b52ce8567..e06e3d270961 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1059,8 +1059,13 @@ static int move_present_pte(struct mm_struct *mm,
 	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
 	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
-	/* Follow mremap() behavior and treat the entry dirty after the move */
-	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
+	/* Set soft dirty bit so userspace can notice the pte was moved */
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
+#endif
+	if (pte_dirty(orig_src_pte))
+		orig_dst_pte = pte_mkdirty(orig_dst_pte);
+	orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
 
 	set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 out:
@@ -1094,6 +1099,9 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
+#ifdef CONFIG_MEM_SOFT_DIRTY
+	orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
+#endif
 	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
 	double_pt_unlock(dst_ptl, src_ptl);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c019f69c5939..d4700f940e8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7612,11 +7612,16 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_cp_add_device *cp = cmd->param;
 
 	if (!err) {
+		struct hci_conn_params *params;
+
+		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
+						le_addr_type(cp->addr.type));
+
 		device_added(cmd->sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 			     cp->action);
 		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
 				     cp->addr.type, hdev->conn_flags,
-				     PTR_UINT(cmd->user_data));
+				     params ? params->flags : 0);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,
@@ -7719,8 +7724,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cmd->user_data = UINT_PTR(current_flags);
-
 	err = hci_cmd_sync_queue(hdev, add_device_sync, cmd,
 				 add_device_complete);
 	if (err < 0) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index ee1211a213d7..caedc939eea1 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1344,10 +1344,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_MONITOR);
 
 
-	local->int_scan_req = kzalloc(sizeof(*local->int_scan_req) +
-				      sizeof(void *) * channels, GFP_KERNEL);
+	local->int_scan_req = kzalloc(struct_size(local->int_scan_req,
+						  channels, channels),
+				      GFP_KERNEL);
 	if (!local->int_scan_req)
 		return -ENOMEM;
+	local->int_scan_req->n_channels = channels;
 
 	eth_broadcast_addr(local->int_scan_req->bssid);
 
diff --git a/net/mctp/device.c b/net/mctp/device.c
index 85cc5f31f1e7..8d1386601bbe 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -20,8 +20,7 @@
 #include <net/sock.h>
 
 struct mctp_dump_cb {
-	int h;
-	int idx;
+	unsigned long ifindex;
 	size_t a_idx;
 };
 
@@ -115,43 +114,36 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct mctp_dump_cb *mcb = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct hlist_head *head;
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex;
-	int idx = 0, rc;
-
-	hdr = nlmsg_data(cb->nlh);
-	// filter by ifindex if requested
-	ifindex = hdr->ifa_index;
+	int ifindex = 0, rc;
+
+	/* Filter by ifindex if a header is provided */
+	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
+		hdr = nlmsg_data(cb->nlh);
+		ifindex = hdr->ifa_index;
+	} else {
+		if (cb->strict_check) {
+			NL_SET_ERR_MSG(cb->extack, "mctp: Invalid header for addr dump request");
+			return -EINVAL;
+		}
+	}
 
 	rcu_read_lock();
-	for (; mcb->h < NETDEV_HASHENTRIES; mcb->h++, mcb->idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[mcb->h];
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx >= mcb->idx &&
-			    (ifindex == 0 || ifindex == dev->ifindex)) {
-				mdev = __mctp_dev_get(dev);
-				if (mdev) {
-					rc = mctp_dump_dev_addrinfo(mdev,
-								    skb, cb);
-					mctp_dev_put(mdev);
-					// Error indicates full buffer, this
-					// callback will get retried.
-					if (rc < 0)
-						goto out;
-				}
-			}
-			idx++;
-			// reset for next iteration
-			mcb->a_idx = 0;
-		}
+	for_each_netdev_dump(net, dev, mcb->ifindex) {
+		if (ifindex && ifindex != dev->ifindex)
+			continue;
+		mdev = __mctp_dev_get(dev);
+		if (!mdev)
+			continue;
+		rc = mctp_dump_dev_addrinfo(mdev, skb, cb);
+		mctp_dev_put(mdev);
+		if (rc < 0)
+			break;
+		mcb->a_idx = 0;
 	}
-out:
 	rcu_read_unlock();
-	mcb->idx = idx;
 
 	return skb->len;
 }
@@ -525,9 +517,12 @@ static struct notifier_block mctp_dev_nb = {
 };
 
 static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
-	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
-	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
-	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_NEWADDR,
+	 .doit = mctp_rtm_newaddr},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_DELADDR,
+	 .doit = mctp_rtm_deladdr},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_GETADDR,
+	 .dumpit = mctp_dump_addrinfo},
 };
 
 int __init mctp_device_init(void)
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 4c460160914f..d9c8e5a5f9ce 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -313,8 +313,10 @@ static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev)
 
 	key = flow->key;
 
-	if (WARN_ON(key->dev && key->dev != dev))
+	if (key->dev) {
+		WARN_ON(key->dev != dev);
 		return;
+	}
 
 	mctp_dev_set_key(dev, key);
 }
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index e1f6e7618deb..afd9805cb68e 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -143,7 +143,7 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index afefe124d903..1af9768cd8ff 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1113,7 +1113,7 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		sch_tree_lock(sch);
 	}
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		if (!skb)
 			break;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 778f6e5966be..551b7cbdae90 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -440,7 +440,7 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
-		struct sk_buff *skb = fq_codel_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		q->cstats.drop_len += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index c38f33ff80bd..6ed08b705f8a 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -364,7 +364,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_pie_qdisc_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		len_dropped += qdisc_pkt_len(skb);
 		num_dropped += 1;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 44d9efe1a96a..5aa434b46707 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -564,7 +564,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	qlen = sch->q.qlen;
 	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = hhf_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		rtnl_kfree_skbs(skb, skb);
 	}
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b3dcb845b327..db61cbc21b13 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -192,7 +192,7 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 77e33e1e340e..65b0da6fdf6a 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -396,7 +396,6 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
-	shinfo->frag_list = NULL;
 
 	/* If we don't know the length go max plus page for cipher overhead */
 	need_spc = strp->stm.full_len ?: TLS_MAX_PAYLOAD_SIZE + PAGE_SIZE;
@@ -412,6 +411,8 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 				   page, 0, 0);
 	}
 
+	shinfo->frag_list = NULL;
+
 	strp->copy_mode = 1;
 	strp->stm.offset = 0;
 
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index d0ee9001c7b3..aaa8fa92e24d 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -112,7 +112,7 @@ static int __init sample_trace_array_init(void)
 	/*
 	 * If context specific per-cpu buffers havent already been allocated.
 	 */
-	trace_printk_init_buffers();
+	trace_array_init_printk(tr);
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
 	if (IS_ERR(simple_tsk)) {
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index dc081cf46d21..686197407c3c 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -36,6 +36,18 @@ KBUILD_CFLAGS += -Wno-gnu
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111219
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow-non-kprintf)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation-non-kprintf)
+
+# Clang may emit a warning when a const variable, such as the dummy variables
+# in typecheck(), or const member of an aggregate type are not initialized,
+# which can result in unexpected behavior. However, in many audited cases of
+# the "field" variant of the warning, this is intentional because the field is
+# never used within a particular call path, the field is within a union with
+# other non-const members, or the containing object is not const so the field
+# can be modified via memcpy() / memset(). While the variable warning also gets
+# disabled with this same switch, there should not be too much coverage lost
+# because -Wuninitialized will still flag when an uninitialized const variable
+# is used.
+KBUILD_CFLAGS += $(call cc-disable-warning, default-const-init-unsafe)
 else
 
 # gcc inanely warns about local variables called 'main'
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index b30faf731da7..b74de9c0969f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -732,15 +732,21 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
  */
 static int __deliver_to_subscribers(struct snd_seq_client *client,
 				    struct snd_seq_event *event,
-				    struct snd_seq_client_port *src_port,
-				    int atomic, int hop)
+				    int port, int atomic, int hop)
 {
+	struct snd_seq_client_port *src_port;
 	struct snd_seq_subscribers *subs;
 	int err, result = 0, num_ev = 0;
 	union __snd_seq_event event_saved;
 	size_t saved_size;
 	struct snd_seq_port_subs_info *grp;
 
+	if (port < 0)
+		return 0;
+	src_port = snd_seq_port_use_ptr(client, port);
+	if (!src_port)
+		return 0;
+
 	/* save original event record */
 	saved_size = snd_seq_event_packet_size(event);
 	memcpy(&event_saved, event, saved_size);
@@ -775,6 +781,7 @@ static int __deliver_to_subscribers(struct snd_seq_client *client,
 		read_unlock(&grp->list_lock);
 	else
 		up_read(&grp->list_mutex);
+	snd_seq_port_unlock(src_port);
 	memcpy(event, &event_saved, saved_size);
 	return (result < 0) ? result : num_ev;
 }
@@ -783,25 +790,32 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 				  struct snd_seq_event *event,
 				  int atomic, int hop)
 {
-	struct snd_seq_client_port *src_port;
-	int ret = 0, ret2;
-
-	src_port = snd_seq_port_use_ptr(client, event->source.port);
-	if (src_port) {
-		ret = __deliver_to_subscribers(client, event, src_port, atomic, hop);
-		snd_seq_port_unlock(src_port);
-	}
-
-	if (client->ump_endpoint_port < 0 ||
-	    event->source.port == client->ump_endpoint_port)
-		return ret;
+	int ret;
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+	int ret2;
+#endif
 
-	src_port = snd_seq_port_use_ptr(client, client->ump_endpoint_port);
-	if (!src_port)
+	ret = __deliver_to_subscribers(client, event,
+				       event->source.port, atomic, hop);
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+	if (!snd_seq_client_is_ump(client) || client->ump_endpoint_port < 0)
 		return ret;
-	ret2 = __deliver_to_subscribers(client, event, src_port, atomic, hop);
-	snd_seq_port_unlock(src_port);
-	return ret2 < 0 ? ret2 : ret;
+	/* If it's an event from EP port (and with a UMP group),
+	 * deliver to subscribers of the corresponding UMP group port, too.
+	 * Or, if it's from non-EP port, deliver to subscribers of EP port, too.
+	 */
+	if (event->source.port == client->ump_endpoint_port)
+		ret2 = __deliver_to_subscribers(client, event,
+						snd_seq_ump_group_port(event),
+						atomic, hop);
+	else
+		ret2 = __deliver_to_subscribers(client, event,
+						client->ump_endpoint_port,
+						atomic, hop);
+	if (ret2 < 0)
+		return ret2;
+#endif
+	return ret;
 }
 
 /* deliver an event to the destination port(s).
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index ff7e558b4d51..db2f169cae11 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -1285,3 +1285,21 @@ int snd_seq_deliver_to_ump(struct snd_seq_client *source,
 	else
 		return cvt_to_ump_midi1(dest, dest_port, event, atomic, hop);
 }
+
+/* return the UMP group-port number of the event;
+ * return -1 if groupless or non-UMP event
+ */
+int snd_seq_ump_group_port(const struct snd_seq_event *event)
+{
+	const struct snd_seq_ump_event *ump_ev =
+		(const struct snd_seq_ump_event *)event;
+	unsigned char type;
+
+	if (!snd_seq_ev_is_ump(event))
+		return -1;
+	type = ump_message_type(ump_ev->ump[0]);
+	if (ump_is_groupless_msg(type))
+		return -1;
+	/* group-port number starts from 1 */
+	return ump_message_group(ump_ev->ump[0]) + 1;
+}
diff --git a/sound/core/seq/seq_ump_convert.h b/sound/core/seq/seq_ump_convert.h
index 6c146d803280..4abf0a7637d7 100644
--- a/sound/core/seq/seq_ump_convert.h
+++ b/sound/core/seq/seq_ump_convert.h
@@ -18,5 +18,6 @@ int snd_seq_deliver_to_ump(struct snd_seq_client *source,
 			   struct snd_seq_client_port *dest_port,
 			   struct snd_seq_event *event,
 			   int atomic, int hop);
+int snd_seq_ump_group_port(const struct snd_seq_event *event);
 
 #endif /* __SEQ_UMP_CONVERT_H */
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index c6c018b40c69..4e0693f0ab0f 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1561,7 +1561,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int err, apu1, apu2;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
@@ -1605,7 +1605,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_es1968_capture;
 	runtime->hw.buffer_bytes_max = runtime->hw.period_bytes_max =
 		calc_available_memory_size(chip) - 1024; /* keep MIXBUF size */
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (err < 0)
+		return err;
 
 	spin_lock_irq(&chip->substream_lock);
 	list_add(&es->list, &chip->substream_list);
diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index b75fbb3236a7..f5fa09d740b4 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -14,7 +14,7 @@ if SND_SUPERH
 
 config SND_AICA
 	tristate "Dreamcast Yamaha AICA sound"
-	depends on SH_DREAMCAST
+	depends on SH_DREAMCAST && SH_DMA_API
 	select SND_PCM
 	select G2_DMA
 	help
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09210fb4ac60..c7387081577c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2240,6 +2240,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
@@ -2248,6 +2250,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
diff --git a/tools/net/ynl/ethtool.py b/tools/net/ynl/ethtool.py
index 63c471f075ab..7e8342f91481 100755
--- a/tools/net/ynl/ethtool.py
+++ b/tools/net/ynl/ethtool.py
@@ -337,16 +337,24 @@ def main():
         print('Capabilities:')
         [print(f'\t{v}') for v in bits_to_dict(tsinfo['timestamping'])]
 
-        print(f'PTP Hardware Clock: {tsinfo["phc-index"]}')
+        print(f'PTP Hardware Clock: {tsinfo.get("phc-index", "none")}')
 
-        print('Hardware Transmit Timestamp Modes:')
-        [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
+        if 'tx-types' in tsinfo:
+            print('Hardware Transmit Timestamp Modes:')
+            [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
+        else:
+            print('Hardware Transmit Timestamp Modes: none')
+
+        if 'rx-filters' in tsinfo:
+            print('Hardware Receive Filter Modes:')
+            [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+        else:
+            print('Hardware Receive Filter Modes: none')
 
-        print('Hardware Receive Filter Modes:')
-        [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+        if 'stats' in tsinfo and tsinfo['stats']:
+            print('Statistics:')
+            [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
 
-        print('Statistics:')
-        [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
         return
 
     print(f'Settings for {args.device}:')
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 64d6805381c5..8617e6d7698d 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,7 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
+static char *client_ip;
 static char *port = "5201";
 static size_t do_validation;
 static int start_queue = 8;
@@ -71,24 +71,107 @@ static char *ifname = "eth1";
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 
-void print_bytes(void *ptr, size_t size)
+struct memory_buffer {
+	int fd;
+	size_t size;
+
+	int devfd;
+	int memfd;
+	char *buf_mem;
+};
+
+struct memory_provider {
+	struct memory_buffer *(*alloc)(size_t size);
+	void (*free)(struct memory_buffer *ctx);
+	void (*memcpy_from_device)(void *dst, struct memory_buffer *src,
+				   size_t off, int n);
+};
+
+static struct memory_buffer *udmabuf_alloc(size_t size)
 {
-	unsigned char *p = ptr;
-	int i;
+	struct udmabuf_create create;
+	struct memory_buffer *ctx;
+	int ret;
 
-	for (i = 0; i < size; i++)
-		printf("%02hhX ", p[i]);
-	printf("\n");
+	ctx = malloc(sizeof(*ctx));
+	if (!ctx)
+		error(1, ENOMEM, "malloc failed");
+
+	ctx->size = size;
+
+	ctx->devfd = open("/dev/udmabuf", O_RDWR);
+	if (ctx->devfd < 0)
+		error(1, errno,
+		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		      TEST_PREFIX);
+
+	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	if (ctx->memfd < 0)
+		error(1, errno, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+
+	ret = fcntl(ctx->memfd, F_ADD_SEALS, F_SEAL_SHRINK);
+	if (ret < 0)
+		error(1, errno, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+
+	ret = ftruncate(ctx->memfd, size);
+	if (ret == -1)
+		error(1, errno, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+
+	memset(&create, 0, sizeof(create));
+
+	create.memfd = ctx->memfd;
+	create.offset = 0;
+	create.size = size;
+	ctx->fd = ioctl(ctx->devfd, UDMABUF_CREATE, &create);
+	if (ctx->fd < 0)
+		error(1, errno, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+
+	ctx->buf_mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			    ctx->fd, 0);
+	if (ctx->buf_mem == MAP_FAILED)
+		error(1, errno, "%s: [FAIL, map udmabuf]\n", TEST_PREFIX);
+
+	return ctx;
+}
+
+static void udmabuf_free(struct memory_buffer *ctx)
+{
+	munmap(ctx->buf_mem, ctx->size);
+	close(ctx->fd);
+	close(ctx->memfd);
+	close(ctx->devfd);
+	free(ctx);
 }
 
-void print_nonzero_bytes(void *ptr, size_t size)
+static void udmabuf_memcpy_from_device(void *dst, struct memory_buffer *src,
+				       size_t off, int n)
+{
+	struct dma_buf_sync sync = {};
+
+	sync.flags = DMA_BUF_SYNC_START;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
+
+	memcpy(dst, src->buf_mem + off, n);
+
+	sync.flags = DMA_BUF_SYNC_END;
+	ioctl(src->fd, DMA_BUF_IOCTL_SYNC, &sync);
+}
+
+static struct memory_provider udmabuf_memory_provider = {
+	.alloc = udmabuf_alloc,
+	.free = udmabuf_free,
+	.memcpy_from_device = udmabuf_memcpy_from_device,
+};
+
+static struct memory_provider *provider = &udmabuf_memory_provider;
+
+static void print_nonzero_bytes(void *ptr, size_t size)
 {
 	unsigned char *p = ptr;
 	unsigned int i;
 
 	for (i = 0; i < size; i++)
 		putchar(p[i]);
-	printf("\n");
 }
 
 void validate_buffer(void *line, size_t size)
@@ -120,7 +203,7 @@ void validate_buffer(void *line, size_t size)
 		char command[256];                                      \
 		memset(command, 0, sizeof(command));                    \
 		snprintf(command, sizeof(command), cmd, ##__VA_ARGS__); \
-		printf("Running: %s\n", command);                       \
+		fprintf(stderr, "Running: %s\n", command);                       \
 		system(command);                                        \
 	})
 
@@ -128,22 +211,22 @@ static int reset_flow_steering(void)
 {
 	int ret = 0;
 
-	ret = run_command("sudo ethtool -K %s ntuple off", ifname);
+	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
 	if (ret)
 		return ret;
 
-	return run_command("sudo ethtool -K %s ntuple on", ifname);
+	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
 }
 
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s", ifname,
+	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
 			   on ? "on" : "off");
 }
 
 static int configure_rss(void)
 {
-	return run_command("sudo ethtool -X %s equal %d", ifname, start_queue);
+	return run_command("sudo ethtool -X %s equal %d >&2", ifname, start_queue);
 }
 
 static int configure_channels(unsigned int rx, unsigned int tx)
@@ -151,10 +234,29 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
-static int configure_flow_steering(void)
+static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	const char *type = "tcp6";
+	const char *server_addr;
+	char buf[40];
+
+	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
+	server_addr = buf;
+
+	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
+		type = "tcp4";
+		server_addr = strrchr(server_addr, ':') + 1;
+	}
+
+	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+			   ifname,
+			   type,
+			   client_ip ? "src-ip" : "",
+			   client_ip ?: "",
+			   server_addr,
+			   client_ip ? "src-port" : "",
+			   client_ip ? port : "",
+			   port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
@@ -187,7 +289,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 		goto err_close;
 	}
 
-	printf("got dmabuf id=%d\n", rsp->id);
+	fprintf(stderr, "got dmabuf id=%d\n", rsp->id);
 	dmabuf_id = rsp->id;
 
 	netdev_bind_rx_req_free(req);
@@ -202,66 +304,82 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
-static void create_udmabuf(int *devfd, int *memfd, int *buf, size_t dmabuf_size)
+static void enable_reuseaddr(int fd)
 {
-	struct udmabuf_create create;
+	int opt = 1;
 	int ret;
 
-	*devfd = open("/dev/udmabuf", O_RDWR);
-	if (*devfd < 0) {
-		error(70, 0,
-		      "%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
-		      TEST_PREFIX);
-	}
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret)
+		error(1, errno, "%s: [FAIL, SO_REUSEPORT]\n", TEST_PREFIX);
 
-	*memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
-	if (*memfd < 0)
-		error(70, 0, "%s: [skip,no-memfd]\n", TEST_PREFIX);
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (ret)
+		error(1, errno, "%s: [FAIL, SO_REUSEADDR]\n", TEST_PREFIX);
+}
 
-	/* Required for udmabuf */
-	ret = fcntl(*memfd, F_ADD_SEALS, F_SEAL_SHRINK);
-	if (ret < 0)
-		error(73, 0, "%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
+static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
+{
+	int ret;
 
-	ret = ftruncate(*memfd, dmabuf_size);
-	if (ret == -1)
-		error(74, 0, "%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
+	sin6->sin6_family = AF_INET6;
+	sin6->sin6_port = htons(port);
+
+	ret = inet_pton(sin6->sin6_family, str, &sin6->sin6_addr);
+	if (ret != 1) {
+		/* fallback to plain IPv4 */
+		ret = inet_pton(AF_INET, str, &sin6->sin6_addr.s6_addr32[3]);
+		if (ret != 1)
+			return -1;
+
+		/* add ::ffff prefix */
+		sin6->sin6_addr.s6_addr32[0] = 0;
+		sin6->sin6_addr.s6_addr32[1] = 0;
+		sin6->sin6_addr.s6_addr16[4] = 0;
+		sin6->sin6_addr.s6_addr16[5] = 0xffff;
+	}
 
-	memset(&create, 0, sizeof(create));
+	return 0;
+}
 
-	create.memfd = *memfd;
-	create.offset = 0;
-	create.size = dmabuf_size;
-	*buf = ioctl(*devfd, UDMABUF_CREATE, &create);
-	if (*buf < 0)
-		error(75, 0, "%s: [FAIL, create udmabuf]\n", TEST_PREFIX);
+static struct netdev_queue_id *create_queues(void)
+{
+	struct netdev_queue_id *queues;
+	size_t i = 0;
+
+	queues = calloc(num_queues, sizeof(*queues));
+	for (i = 0; i < num_queues; i++) {
+		queues[i]._present.type = 1;
+		queues[i]._present.id = 1;
+		queues[i].type = NETDEV_QUEUE_TYPE_RX;
+		queues[i].id = start_queue + i;
+	}
+
+	return queues;
 }
 
-int do_server(void)
+int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
-	struct sockaddr_in client_addr;
-	struct sockaddr_in server_sin;
+	struct sockaddr_in6 client_addr;
+	struct sockaddr_in6 server_sin;
 	size_t page_aligned_frags = 0;
-	int devfd, memfd, buf, ret;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
 	bool is_devmem = false;
-	char *buf_mem = NULL;
+	char *tmp_mem = NULL;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
 	char iobuf[819200];
 	char buffer[256];
 	int socket_fd;
 	int client_fd;
-	size_t i = 0;
-	int opt = 1;
-
-	dmabuf_size = getpagesize() * NUM_PAGES;
+	int ret;
 
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
 
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
@@ -271,92 +389,65 @@ int do_server(void)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
 
-	queues = malloc(sizeof(*queues) * num_queues);
-
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
-	buf_mem = mmap(NULL, dmabuf_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-		       buf, 0);
-	if (buf_mem == MAP_FAILED)
-		error(1, 0, "mmap()");
-
-	server_sin.sin_family = AF_INET;
-	server_sin.sin_port = htons(atoi(port));
+	tmp_mem = malloc(mem->size);
+	if (!tmp_mem)
+		error(1, ENOMEM, "malloc failed");
 
-	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (socket < 0)
-		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (socket_fd < 0)
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
-	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
-	if (socket < 0)
-		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	enable_reuseaddr(socket_fd);
 
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
-			 sizeof(opt));
-	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
-
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
-			 sizeof(opt));
-	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
-
-	printf("binding to address %s:%d\n", server_ip,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "binding to address %s:%d\n", server_ip,
+		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
 
 	ret = listen(socket_fd, 1);
 	if (ret)
-		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
 
 	client_addr_len = sizeof(client_addr);
 
-	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer,
 		  sizeof(buffer));
-	printf("Waiting or connection on %s:%d\n", buffer,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
+		ntohs(server_sin.sin6_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
-	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+	inet_ntop(AF_INET6, &client_addr.sin6_addr, buffer,
 		  sizeof(buffer));
-	printf("Got connection from %s:%d\n", buffer,
-	       ntohs(client_addr.sin_port));
+	fprintf(stderr, "Got connection from %s:%d\n", buffer,
+		ntohs(client_addr.sin6_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
 				     .iov_len = sizeof(iobuf) };
 		struct dmabuf_cmsg *dmabuf_cmsg = NULL;
-		struct dma_buf_sync sync = { 0 };
 		struct cmsghdr *cm = NULL;
 		struct msghdr msg = { 0 };
 		struct dmabuf_token token;
 		ssize_t ret;
 
 		is_devmem = false;
-		printf("\n\n");
 
 		msg.msg_iov = &iov;
 		msg.msg_iovlen = 1;
 		msg.msg_control = ctrl_data;
 		msg.msg_controllen = sizeof(ctrl_data);
 		ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
-		printf("recvmsg ret=%ld\n", ret);
+		fprintf(stderr, "recvmsg ret=%ld\n", ret);
 		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
 			continue;
 		if (ret < 0) {
@@ -364,16 +455,15 @@ int do_server(void)
 			continue;
 		}
 		if (ret == 0) {
-			printf("client exited\n");
+			fprintf(stderr, "client exited\n");
 			goto cleanup;
 		}
 
-		i++;
 		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
 			if (cm->cmsg_level != SOL_SOCKET ||
 			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
 			     cm->cmsg_type != SCM_DEVMEM_LINEAR)) {
-				fprintf(stdout, "skipping non-devmem cmsg\n");
+				fprintf(stderr, "skipping non-devmem cmsg\n");
 				continue;
 			}
 
@@ -384,7 +474,7 @@ int do_server(void)
 				/* TODO: process data copied from skb's linear
 				 * buffer.
 				 */
-				fprintf(stdout,
+				fprintf(stderr,
 					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
 					dmabuf_cmsg->frag_size);
 
@@ -395,12 +485,13 @@ int do_server(void)
 			token.token_count = 1;
 
 			total_received += dmabuf_cmsg->frag_size;
-			printf("received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
-			       dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
-			       dmabuf_cmsg->frag_offset % getpagesize(),
-			       dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
-			       dmabuf_cmsg->frag_token, total_received,
-			       dmabuf_cmsg->dmabuf_id);
+			fprintf(stderr,
+				"received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
+				dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
+				dmabuf_cmsg->frag_offset % getpagesize(),
+				dmabuf_cmsg->frag_offset,
+				dmabuf_cmsg->frag_size, dmabuf_cmsg->frag_token,
+				total_received, dmabuf_cmsg->dmabuf_id);
 
 			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
 				error(1, 0,
@@ -411,22 +502,16 @@ int do_server(void)
 			else
 				page_aligned_frags++;
 
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+			provider->memcpy_from_device(tmp_mem, mem,
+						     dmabuf_cmsg->frag_offset,
+						     dmabuf_cmsg->frag_size);
 
 			if (do_validation)
-				validate_buffer(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
+				validate_buffer(tmp_mem,
+						dmabuf_cmsg->frag_size);
 			else
-				print_nonzero_bytes(
-					((unsigned char *)buf_mem) +
-						dmabuf_cmsg->frag_offset,
-					dmabuf_cmsg->frag_size);
-
-			sync.flags = DMA_BUF_SYNC_READ | DMA_BUF_SYNC_END;
-			ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);
+				print_nonzero_bytes(tmp_mem,
+						    dmabuf_cmsg->frag_size);
 
 			ret = setsockopt(client_fd, SOL_SOCKET,
 					 SO_DEVMEM_DONTNEED, &token,
@@ -438,25 +523,22 @@ int do_server(void)
 		if (!is_devmem)
 			error(1, 0, "flow steering error\n");
 
-		printf("total_received=%lu\n", total_received);
+		fprintf(stderr, "total_received=%lu\n", total_received);
 	}
 
-	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
 cleanup:
 
-	munmap(buf_mem, dmabuf_size);
+	free(tmp_mem);
 	close(client_fd);
 	close(socket_fd);
-	close(buf);
-	close(memfd);
-	close(devfd);
 	ynl_sock_destroy(ys);
 
 	return 0;
@@ -464,52 +546,33 @@ int do_server(void)
 
 void run_devmem_tests(void)
 {
-	struct netdev_queue_id *queues;
-	int devfd, memfd, buf;
+	struct memory_buffer *mem;
 	struct ynl_sock *ys;
-	size_t dmabuf_size;
-	size_t i = 0;
 
-	dmabuf_size = getpagesize() * NUM_PAGES;
-
-	create_udmabuf(&devfd, &memfd, &buf, dmabuf_size);
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
 
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "rss error\n");
 
-	queues = calloc(num_queues, sizeof(*queues));
-
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd,
+			   calloc(num_queues, sizeof(struct netdev_queue_id)),
+			   num_queues, &ys))
 		error(1, 0, "Binding empty queues array should have failed\n");
 
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
 	if (configure_headersplit(0))
 		error(1, 0, "Failed to configure header split\n");
 
-	if (!bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (!bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Configure dmabuf with header split off should have failed\n");
 
 	if (configure_headersplit(1))
 		error(1, 0, "Failed to configure header split\n");
 
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
-
-	if (bind_rx_queue(ifindex, buf, queues, num_queues, &ys))
+	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys))
 		error(1, 0, "Failed to bind\n");
 
 	/* Deactivating a bound queue should not be legal */
@@ -518,11 +581,15 @@ void run_devmem_tests(void)
 
 	/* Closing the netlink socket does an implicit unbind */
 	ynl_sock_destroy(ys);
+
+	provider->free(mem);
 }
 
 int main(int argc, char *argv[])
 {
+	struct memory_buffer *mem;
 	int is_server = 0, opt;
+	int ret;
 
 	while ((opt = getopt(argc, argv, "ls:c:p:v:q:t:f:")) != -1) {
 		switch (opt) {
@@ -551,7 +618,7 @@ int main(int argc, char *argv[])
 			ifname = optarg;
 			break;
 		case '?':
-			printf("unknown option: %c\n", optopt);
+			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;
 		}
 	}
@@ -559,12 +626,13 @@ int main(int argc, char *argv[])
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-		printf("extra arguments: %s\n", argv[optind]);
+		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
 	run_devmem_tests();
 
-	if (is_server)
-		return do_server();
+	mem = provider->alloc(getpagesize() * NUM_PAGES);
+	ret = is_server ? do_server(mem) : 1;
+	provider->free(mem);
 
-	return 0;
+	return ret;
 }
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 0b7f5bf546da..0c22ff7a8de2 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1283,21 +1283,25 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
 	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 	control_expectln("RECEIVED");
 
-	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-		} else {
+	/* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
+	 * the "RECEIVED" message means that the other side has received the
+	 * data, there can be a delay in our kernel before updating the "unsent
+	 * bytes" counter. Repeat SIOCOUTQ until it returns 0.
+	 */
+	timeout_begin(TIMEOUT);
+	do {
+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+		if (ret < 0) {
+			if (errno == EOPNOTSUPP) {
+				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+				break;
+			}
 			perror("ioctl");
 			exit(EXIT_FAILURE);
 		}
-	} else if (ret == 0 && sock_bytes_unsent != 0) {
-		fprintf(stderr,
-			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
-			sock_bytes_unsent);
-		exit(EXIT_FAILURE);
-	}
-
+		timeout_check("SIOCOUTQ");
+	} while (sock_bytes_unsent != 0);
+	timeout_end();
 	close(fd);
 }
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8f079a61a56d..bb062d3d2457 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -118,6 +118,8 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
 			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
 			.slot = slot,
 			.may_block = true,
+			/* guest memfd is relevant to only private mappings. */
+			.attr_filter = KVM_FILTER_PRIVATE,
 		};
 
 		if (!found_memslot) {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 279e03029ce1..b99de3b5ffbc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -632,6 +632,11 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_range(struct kvm *kvm,
 			 */
 			gfn_range.arg = range->arg;
 			gfn_range.may_block = range->may_block;
+			/*
+			 * HVA-based notifications aren't relevant to private
+			 * mappings as they don't have a userspace mapping.
+			 */
+			gfn_range.attr_filter = KVM_FILTER_SHARED;
 
 			/*
 			 * {gfn(page) | page intersects with [hva_start, hva_end)} =
@@ -2454,6 +2459,14 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 	gfn_range.arg = range->arg;
 	gfn_range.may_block = range->may_block;
 
+	/*
+	 * If/when KVM supports more attributes beyond private .vs shared, this
+	 * _could_ set KVM_FILTER_{SHARED,PRIVATE} appropriately if the entire target
+	 * range already has the desired private vs. shared state (it's unclear
+	 * if that is a net win).  For now, KVM reaches this point if and only
+	 * if the private flag is being toggled, i.e. all mappings are in play.
+	 */
+
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 
@@ -2510,6 +2523,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
+		.arg.attributes = attributes,
 		.handler = kvm_pre_set_memory_attributes,
 		.on_lock = kvm_mmu_invalidate_begin,
 		.flush_on_ret = true,

