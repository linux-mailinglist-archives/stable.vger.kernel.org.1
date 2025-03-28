Return-Path: <stable+bounces-126975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBFA75200
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FF13B2EE5
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D81F09B0;
	Fri, 28 Mar 2025 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfVKVqUw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5691F0985;
	Fri, 28 Mar 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196865; cv=none; b=eOzVW/7HflkrVVAKlq8pms7v703Ot9nJOYHPnzUnxSe/m696YFem6XgVl7Fr9CdHvbXP+5+r8DIX/6feju3shJTHn0Cx2bqhFbBaQtqnglphvPPVpjuB3Gl1L9DEkeRTVI0/TCXb+N9ZJ3TOggGTqhZZdgBFbulOkwCA7aZTuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196865; c=relaxed/simple;
	bh=OAZg7RiqyhIH51ziNwMXji8VwjDkh0eli5wHdPQfN98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okhAwBemYUJB3PfR48ZvfRwxrgJdllXUjt5c38FkcOkM7bTZRvErjHpeB56tLIWue3SeprA7yg93hvYAHZfIz9gT364HbSeGasacL8L1vhZcMrJ+joq5MZ8Tjyvdxj+kvuvAwYQ9aunjjByMka29jGkDpRfyhDARCwanFn4fqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfVKVqUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55C9C4CEE4;
	Fri, 28 Mar 2025 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743196864;
	bh=OAZg7RiqyhIH51ziNwMXji8VwjDkh0eli5wHdPQfN98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfVKVqUwp8TVkvCKZaebQeCkze1e7PnWH2Tmp5byo9IGSdOctN8K0Jc9loyXYAB7e
	 KtGHE4KSt2sZDJysWOAC8wf0V+IBFZCVqqH7DGD4zlW74XhafRw05B9BX+sO4laN6r
	 X2AYTWVdj4n+fPEXOgA06/HTNBQSkVZVMKwAuKxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.132
Date: Fri, 28 Mar 2025 22:19:32 +0100
Message-ID: <2025032832-pointed-cavalry-6fc5@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025032832-prissy-exact-e585@gregkh>
References: <2025032832-prissy-exact-e585@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index f8786be15183..7fe8ef9718d8 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
diff --git a/Makefile b/Makefile
index 58d17d339578..5b9f26ae157d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 131
+SUBLEVEL = 132
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -1851,11 +1851,6 @@ rustfmt:
 rustfmtcheck: rustfmt_flags = --check
 rustfmtcheck: rustfmt
 
-# IDE support targets
-PHONY += rust-analyzer
-rust-analyzer:
-	$(Q)$(MAKE) $(build)=rust $@
-
 # Misc
 # ---------------------------------------------------------------------------
 
@@ -1908,6 +1903,7 @@ help:
 	@echo  '  modules         - default target, build the module(s)'
 	@echo  '  modules_install - install the module'
 	@echo  '  clean           - remove generated files in module directory only'
+	@echo  '  rust-analyzer	  - generate rust-project.json rust-analyzer support file'
 	@echo  ''
 
 endif # KBUILD_EXTMOD
@@ -2044,6 +2040,11 @@ quiet_cmd_tags = GEN     $@
 tags TAGS cscope gtags: FORCE
 	$(call cmd,tags)
 
+# IDE support targets
+PHONY += rust-analyzer
+rust-analyzer:
+	$(Q)$(MAKE) $(build)=rust $@
+
 # Script to generate missing namespace dependencies
 # ---------------------------------------------------------------------------
 
diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index 8049997fa372..2039a8c8d547 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -74,7 +74,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
-#define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
+#define elf_check_arch(x) (((x)->e_machine == EM_ALPHA) && !((x)->e_flags & EF_ALPHA_32BIT))
 
 /*
  * These are used to set parameters in the core dumps.
@@ -145,10 +145,6 @@ extern int dump_elf_task_fp(elf_fpreg_t *dest, struct task_struct *task);
 	: amask (AMASK_CIX) ? "ev6" : "ev67");	\
 })
 
-#define SET_PERSONALITY(EX)					\
-	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
-	   ? PER_LINUX_32BIT : PER_LINUX)
-
 extern int alpha_l1i_cacheshape;
 extern int alpha_l1d_cacheshape;
 extern int alpha_l2_cacheshape;
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 9e45f6735d5d..6fe4e9deeb5e 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -322,7 +322,7 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 
 extern void paging_init(void);
 
-/* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
+/* We have our own get_unmapped_area */
 #define HAVE_ARCH_UNMAPPED_AREA
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/include/asm/processor.h b/arch/alpha/include/asm/processor.h
index 714abe494e5f..916a2dd782c1 100644
--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -8,23 +8,19 @@
 #ifndef __ASM_ALPHA_PROCESSOR_H
 #define __ASM_ALPHA_PROCESSOR_H
 
-#include <linux/personality.h>	/* for ADDR_LIMIT_32BIT */
-
 /*
  * We have a 42-bit user address space: 4TB user VM...
  */
 #define TASK_SIZE (0x40000000000UL)
 
-#define STACK_TOP \
-  (current->personality & ADDR_LIMIT_32BIT ? 0x80000000 : 0x00120000000UL)
+#define STACK_TOP (0x00120000000UL)
 
 #define STACK_TOP_MAX	0x00120000000UL
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE \
-  ((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)
+#define TASK_UNMAPPED_BASE (TASK_SIZE / 2)
 
 /* This is dead.  Everything has been moved to thread_info.  */
 struct thread_struct { };
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index c54469b369cb..03b70b6c9250 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1213,8 +1213,7 @@ SYSCALL_DEFINE1(old_adjtimex, struct timex32 __user *, txc_p)
 	return ret;
 }
 
-/* Get an address range which is currently unmapped.  Similar to the
-   generic version except that we know how to honor ADDR_LIMIT_32BIT.  */
+/* Get an address range which is currently unmapped. */
 
 static unsigned long
 arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
@@ -1236,13 +1235,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
 		       unsigned long flags)
 {
-	unsigned long limit;
-
-	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
-	if (current->personality & ADDR_LIMIT_32BIT)
-		limit = 0x80000000;
-	else
-		limit = TASK_SIZE;
+	unsigned long limit = TASK_SIZE;
 
 	if (len > limit)
 		return -ENOMEM;
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 941c4d16791b..27b467219a40 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -134,7 +134,7 @@ uart2: serial@7e201400 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -145,7 +145,7 @@ uart3: serial@7e201600 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -156,7 +156,7 @@ uart4: serial@7e201800 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -167,7 +167,7 @@ uart5: serial@7e201a00 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -451,8 +451,6 @@ IRQ_TYPE_LEVEL_LOW)>,
 					  IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 					  IRQ_TYPE_LEVEL_LOW)>;
-		/* This only applies to the ARMv7 stub */
-		arm,cpu-registers-not-fw-configured;
 	};
 
 	cpus: cpus {
@@ -1154,6 +1152,7 @@ &txp {
 };
 
 &uart0 {
+	arm,primecell-periphid = <0x00341011>;
 	interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 };
 
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 7ec7ada287e0..16bf3bed38fe 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_OMAP1
 	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select FORCE_PCI if PCCARD
+	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 9466ae61f56a..b45c68d88275 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -136,6 +136,7 @@ ENDPROC(shmobile_smp_sleep)
 	.long	shmobile_smp_arg - 1b
 
 	.bss
+	.align	2
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
 	.space	NR_CPUS * 4
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index 7c3f5c54f040..d84ae7571d23 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -16,10 +16,10 @@ sound_card: sound-card {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
index 7bd680a926ce..c63144f2456e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2021-2022 TQ-Systems GmbH
- * Author: Alexander Stein <alexander.stein@tq-group.com>
+ * Copyright 2021-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
  */
 
 #include "imx8mp.dtsi"
@@ -23,15 +24,6 @@ reg_vcc3v3: regulator-vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
-
-	/* e-MMC IO, needed for HS modes */
-	reg_vcc1v8: regulator-vcc1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
 };
 
 &A53_0 {
@@ -194,7 +186,7 @@ &usdhc3 {
 	no-sd;
 	no-sdio;
 	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc1v8>;
+	vqmmc-supply = <&buck5_reg>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fe5b52610010..6a6b36c36ce2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -117,7 +117,7 @@ &u2phy0_host {
 };
 
 &u2phy1_host {
-	status = "disabled";
+	phy-supply = <&vdd_5v>;
 };
 
 &uart0 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6a4f118fb25f..f095b99bb214 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1209,8 +1209,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pmd_t *pmdp;
 
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
+	/* [start, end] should be within one section */
+	WARN_ON_ONCE(end - start > PAGES_PER_SECTION * sizeof(struct page));
 
-	if (!ARM64_KERNEL_USES_PMD_MAPS)
+	if (!ARM64_KERNEL_USES_PMD_MAPS ||
+	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))
 		return vmemmap_populate_basepages(start, end, node, altmap);
 
 	do {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 117f86283183..b9dde3769412 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3852,6 +3852,85 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static u64 intel_pmu_freq_start_period(struct perf_event *event)
+{
+	int type = event->attr.type;
+	u64 config, factor;
+	s64 start;
+
+	/*
+	 * The 127 is the lowest possible recommended SAV (sample after value)
+	 * for a 4000 freq (default freq), according to the event list JSON file.
+	 * Also, assume the workload is idle 50% time.
+	 */
+	factor = 64 * 4000;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		goto end;
+
+	/*
+	 * The estimation of the start period in the freq mode is
+	 * based on the below assumption.
+	 *
+	 * For a cycles or an instructions event, 1GHZ of the
+	 * underlying platform, 1 IPC. The workload is idle 50% time.
+	 * The start period = 1,000,000,000 * 1 / freq / 2.
+	 *		    = 500,000,000 / freq
+	 *
+	 * Usually, the branch-related events occur less than the
+	 * instructions event. According to the Intel event list JSON
+	 * file, the SAV (sample after value) of a branch-related event
+	 * is usually 1/4 of an instruction event.
+	 * The start period of branch-related events = 125,000,000 / freq.
+	 *
+	 * The cache-related events occurs even less. The SAV is usually
+	 * 1/20 of an instruction event.
+	 * The start period of cache-related events = 25,000,000 / freq.
+	 */
+	config = event->attr.config & PERF_HW_EVENT_MASK;
+	if (type == PERF_TYPE_HARDWARE) {
+		switch (config) {
+		case PERF_COUNT_HW_CPU_CYCLES:
+		case PERF_COUNT_HW_INSTRUCTIONS:
+		case PERF_COUNT_HW_BUS_CYCLES:
+		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
+		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
+		case PERF_COUNT_HW_REF_CPU_CYCLES:
+			factor = 500000000;
+			break;
+		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+		case PERF_COUNT_HW_BRANCH_MISSES:
+			factor = 125000000;
+			break;
+		case PERF_COUNT_HW_CACHE_REFERENCES:
+		case PERF_COUNT_HW_CACHE_MISSES:
+			factor = 25000000;
+			break;
+		default:
+			goto end;
+		}
+	}
+
+	if (type == PERF_TYPE_HW_CACHE)
+		factor = 25000000;
+end:
+	/*
+	 * Usually, a prime or a number with less factors (close to prime)
+	 * is chosen as an SAV, which makes it less likely that the sampling
+	 * period synchronizes with some periodic event in the workload.
+	 * Minus 1 to make it at least avoiding values near power of twos
+	 * for the default freq.
+	 */
+	start = DIV_ROUND_UP_ULL(factor, event->attr.sample_freq) - 1;
+
+	if (start > x86_pmu.max_period)
+		start = x86_pmu.max_period;
+
+	if (x86_pmu.limit_period)
+		x86_pmu.limit_period(event, &start);
+
+	return start;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3863,6 +3942,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (event->attr.freq && event->attr.sample_freq) {
+		event->hw.sample_period = intel_pmu_freq_start_period(event);
+		event->hw.last_period = event->hw.sample_period;
+		local64_set(&event->hw.period_left, event->hw.sample_period);
+	}
+
 	if (event->attr.precise_ip) {
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9a3092ec9b27..b8d6e616fc50 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -867,7 +867,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 		return ret;
 	}
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6090fe513d40..100fed2afbe7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
-#include <linux/i8253.h>
 #include <linux/random.h>
 #include <linux/swiotlb.h>
 #include <asm/processor.h>
@@ -461,16 +460,6 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
-	/*
-	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
-	 * counter register during PIT shutdown restarts the PIT. So it
-	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
-	 * to false tells pit_shutdown() not to zero the counter so that
-	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
-	 * and setting this value has no effect.
-	 */
-	i8253_clear_counter_on_shutdown = false;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 766ffe3ba313..439fdb3f5fdf 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -23,8 +23,10 @@
 #include <asm/traps.h>
 #include <asm/thermal.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 5d202b775beb..c202e2527d05 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -739,8 +739,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
 		 * old cgroup.
 		 */
 		bfq_put_cooperator(sync_bfqq);
-		bfq_release_process_ref(bfqd, sync_bfqq);
 		bic_set_bfqq(bic, NULL, true, act_idx);
+		bfq_release_process_ref(bfqd, sync_bfqq);
 	}
 }
 
diff --git a/block/bio.c b/block/bio.c
index 3318e0022fdf..a7323d567c79 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -73,7 +73,7 @@ struct bio_slab {
 	struct kmem_cache *slab;
 	unsigned int slab_ref;
 	unsigned int slab_size;
-	char name[8];
+	char name[12];
 };
 static DEFINE_MUTEX(bio_slab_lock);
 static DEFINE_XARRAY(bio_slabs);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 34cb7894e54e..d4fb1436f9f5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -553,6 +553,12 @@ static const struct dmi_system_id maingear_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 0ff28938943f..d636a6b80830 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -206,6 +206,7 @@ static const struct clk_ops samsung_pll3000_clk_ops = {
  */
 /* Maximum lock time can be 270 * PDIV cycles */
 #define PLL35XX_LOCK_FACTOR	(270)
+#define PLL142XX_LOCK_FACTOR	(150)
 
 #define PLL35XX_MDIV_MASK       (0x3FF)
 #define PLL35XX_PDIV_MASK       (0x3F)
@@ -272,7 +273,11 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	}
 
 	/* Set PLL lock time. */
-	writel_relaxed(rate->pdiv * PLL35XX_LOCK_FACTOR,
+	if (pll->type == pll_142xx)
+		writel_relaxed(rate->pdiv * PLL142XX_LOCK_FACTOR,
+			pll->lock_reg);
+	else
+		writel_relaxed(rate->pdiv * PLL35XX_LOCK_FACTOR,
 			pll->lock_reg);
 
 	/* Change PLL PMS values */
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index cb215e6f2e83..39f7c2d736d1 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,13 +20,6 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-/*
- * Handle PIT quirk in pit_shutdown() where zeroing the counter register
- * restarts the PIT, negating the shutdown. On platforms with the quirk,
- * platform specific code can set this to false.
- */
-bool i8253_clear_counter_on_shutdown __ro_after_init = true;
-
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -112,12 +105,33 @@ void clockevent_i8253_disable(void)
 {
 	raw_spin_lock(&i8253_lock);
 
+	/*
+	 * Writing the MODE register should stop the counter, according to
+	 * the datasheet. This appears to work on real hardware (well, on
+	 * modern Intel and AMD boxes; I didn't dig the Pegasos out of the
+	 * shed).
+	 *
+	 * However, some virtual implementations differ, and the MODE change
+	 * doesn't have any effect until either the counter is written (KVM
+	 * in-kernel PIT) or the next interrupt (QEMU). And in those cases,
+	 * it may not stop the *count*, only the interrupts. Although in
+	 * the virt case, that probably doesn't matter, as the value of the
+	 * counter will only be calculated on demand if the guest reads it;
+	 * it's the interrupts which cause steal time.
+	 *
+	 * Hyper-V apparently has a bug where even in mode 0, the IRQ keeps
+	 * firing repeatedly if the counter is running. But it *does* do the
+	 * right thing when the MODE register is written.
+	 *
+	 * So: write the MODE and then load the counter, which ensures that
+	 * the IRQ is stopped on those buggy virt implementations. And then
+	 * write the MODE again, which is the right way to stop it.
+	 */
 	outb_p(0x30, PIT_MODE);
+	outb_p(0, PIT_CH0);
+	outb_p(0, PIT_CH0);
 
-	if (i8253_clear_counter_on_shutdown) {
-		outb_p(0, PIT_CH0);
-		outb_p(0, PIT_CH0);
-	}
+	outb_p(0x30, PIT_MODE);
 
 	raw_spin_unlock(&i8253_lock);
 }
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 5d88a5a46b09..fc076055a215 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -75,6 +75,10 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	/* Avoid address 0x0, as it can be mistaken for NULL */
+	if (alloc_min == 0)
+		alloc_min = align;
+
 	size = round_up(size, EFI_ALLOC_ALIGN);
 
 	/* count the suitable slots in each memory map entry */
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79caccd01..fa25c082109a 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -279,6 +279,7 @@ static int imx_scu_probe(struct platform_device *pdev)
 		return ret;
 
 	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
+	of_node_put(args.np);
 
 	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
 	for (i = 0; i < num_channel; i++) {
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea..371f24569b3b 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -310,7 +310,10 @@ static ssize_t ibft_attr_show_nic(void *data, int type, char *buf)
 		str += sprintf_ipaddr(str, nic->ip_addr);
 		break;
 	case ISCSI_BOOT_ETH_SUBNET_MASK:
-		val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
+		if (nic->subnet_mask_prefix > 32)
+			val = cpu_to_be32(~0);
+		else
+			val = cpu_to_be32(~((1 << (32-nic->subnet_mask_prefix))-1));
 		str += sprintf(str, "%pI4", &val);
 		break;
 	case ISCSI_BOOT_ETH_PREFIX_LEN:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index b86c0b8252a5..031b6d974f26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -132,13 +132,25 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
+	int r;
+
 	if (bo->kfd_bo)
-		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm,
 						    addr, amdgpu_bo_size(bo),
 						    &amdgpu_mn_hsa_ops);
-	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
-					    amdgpu_bo_size(bo),
-					    &amdgpu_mn_gfx_ops);
+	else
+		r = mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
+							amdgpu_bo_size(bo),
+							&amdgpu_mn_gfx_ops);
+	if (r)
+		/*
+		 * Make sure amdgpu_hmm_unregister() doesn't call
+		 * mmu_interval_notifier_remove() when the notifier isn't properly
+		 * initialized.
+		 */
+		bo->notifier.mm = NULL;
+
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 877989278290..0d4d6acae994 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -87,7 +87,7 @@ static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c373a2a3248e..9c16fff40f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -125,7 +125,7 @@ static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dc0f70df24f..9b3f5f76d52d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -230,6 +230,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
 static void handle_hpd_rx_irq(void *param);
 
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
+					 u32 user_brightness);
+
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
@@ -2885,6 +2889,12 @@ static int dm_resume(void *handle)
 
 		mutex_unlock(&dm->dc_lock);
 
+		/* set the backlight after a reset */
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
+
 		return 0;
 	}
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 6202e31c7e3a..3f211c0308a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -404,6 +404,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	for (i = 0; i < hdcp_work->max_link; i++) {
 		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
+		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
 	}
 
 	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 87a6d6a4ddf4..f036e9988a0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2328,10 +2328,13 @@ static int get_norm_pix_clk(const struct dc_crtc_timing *timing)
 			break;
 		case COLOR_DEPTH_121212:
 			normalized_pix_clk = (pix_clk * 36) / 24;
-		break;
+			break;
+		case COLOR_DEPTH_141414:
+			normalized_pix_clk = (pix_clk * 42) / 24;
+			break;
 		case COLOR_DEPTH_161616:
 			normalized_pix_clk = (pix_clk * 48) / 24;
-		break;
+			break;
 		default:
 			ASSERT(0);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 3f32e9c3fbaf..13995b6fb865 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -67,5 +67,17 @@ bool should_use_dmub_lock(struct dc_link *link)
 {
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
+
+	/* only use HW lock for PSR1 on single eDP */
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
+
+		get_edp_links(link->dc, edp_links, &edp_num);
+
+		if (edp_num == 1)
+			return true;
+	}
+
 	return false;
 }
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index d8cbb4eadc5b..6f41c752844b 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3959,6 +3959,22 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 	return 0;
 }
 
+static bool primary_mstb_probing_is_done(struct drm_dp_mst_topology_mgr *mgr)
+{
+	bool probing_done = false;
+
+	mutex_lock(&mgr->lock);
+
+	if (mgr->mst_primary && drm_dp_mst_topology_try_get_mstb(mgr->mst_primary)) {
+		probing_done = mgr->mst_primary->link_address_sent;
+		drm_dp_mst_topology_put_mstb(mgr->mst_primary);
+	}
+
+	mutex_unlock(&mgr->lock);
+
+	return probing_done;
+}
+
 static inline bool
 drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 			  struct drm_dp_pending_up_req *up_req)
@@ -3989,8 +4005,12 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
 	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
-		dowork = drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
-		hotplug = true;
+		if (!primary_mstb_probing_is_done(mgr)) {
+			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.\n");
+		} else {
+			dowork = drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
+			hotplug = true;
+		}
 	}
 
 	drm_dp_mst_topology_put_mstb(mstb);
@@ -4069,10 +4089,11 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	drm_dp_send_up_ack_reply(mgr, mst_primary, up_req->msg.req_type,
 				 false);
 
+	drm_dp_mst_topology_put_mstb(mst_primary);
+
 	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
 		const struct drm_dp_connection_status_notify *conn_stat =
 			&up_req->msg.u.conn_stat;
-		bool handle_csn;
 
 		drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
 			    conn_stat->port_number,
@@ -4081,16 +4102,6 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 			    conn_stat->message_capability_status,
 			    conn_stat->input_port,
 			    conn_stat->peer_device_type);
-
-		mutex_lock(&mgr->probe_lock);
-		handle_csn = mst_primary->link_address_sent;
-		mutex_unlock(&mgr->probe_lock);
-
-		if (!handle_csn) {
-			drm_dbg_kms(mgr->dev, "Got CSN before finish topology probing. Skip it.");
-			kfree(up_req);
-			goto out_put_primary;
-		}
 	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
 		const struct drm_dp_resource_status_notify *res_stat =
 			&up_req->msg.u.resource_stat;
@@ -4105,9 +4116,6 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 	list_add_tail(&up_req->next, &mgr->up_req_list);
 	mutex_unlock(&mgr->up_req_lock);
 	queue_work(system_long_wq, &mgr->up_req_work);
-
-out_put_primary:
-	drm_dp_mst_topology_put_mstb(mst_primary);
 out_clear_reply:
 	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
 	return 0;
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index b620a0da2d02..55b78b027e09 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -932,6 +932,10 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 
 	if (mode != DRM_MODE_DPMS_ON)
 		mode = DRM_MODE_DPMS_OFF;
+
+	if (connector->dpms == mode)
+		goto out;
+
 	connector->dpms = mode;
 
 	crtc = connector->state->crtc;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3d18d840ef3b..e5c1572f720b 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1100,6 +1100,10 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
  * 	callback. For atomic drivers the remapping to the "ACTIVE" property is
  * 	implemented in the DRM core.
  *
+ * 	On atomic drivers any DPMS setproperty ioctl where the value does not
+ * 	change is completely skipped, otherwise a full atomic commit will occur.
+ * 	On legacy drivers the exact behavior is driver specific.
+ *
  * 	Note that this property cannot be set through the MODE_ATOMIC ioctl,
  * 	userspace must use "ACTIVE" on the CRTC instead.
  *
diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index 7e76790c6a81..cba97d7db131 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -279,6 +279,11 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 					    0, PCI_DEVFN(2, 0));
 	int ret = -1;
 
+	if (pci_gfx_root == NULL) {
+		WARN_ON(1);
+		return;
+	}
+
 	/* Get the address of the platform config vbt */
 	pci_read_config_dword(pci_gfx_root, 0xFC, &addr);
 	pci_dev_put(pci_gfx_root);
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 68050409dd26..499c7c8916df 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -157,6 +157,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	return 0;
 
 err_free_mmio:
+	iounmap(hv->vram);
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 err_vmbus_close:
 	vmbus_close(hdev->channel);
@@ -175,6 +176,7 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
+	iounmap(hv->vram);
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 
 	return 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 21e584038581..336a6ee792c6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -119,7 +119,14 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 	int ret;
 
 	args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	args->size = args->pitch * args->height;
+
+	/*
+	 * Multiply 2 variables of different types,
+	 * for example: args->size = args->spacing * args->height;
+	 * may cause coverity issue with unintentional overflow.
+	 */
+	args->size = args->pitch;
+	args->size *= args->height;
 
 	mtk_gem = mtk_drm_gem_create(dev, args->size, false);
 	if (IS_ERR(mtk_gem))
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 30d361671aa9..fb062e52eb12 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -120,6 +120,7 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	struct mtk_drm_gem_obj *mtk_gem;
 	unsigned int pitch, format;
 	dma_addr_t addr;
+	int offset;
 
 	gem = fb->obj[0];
 	mtk_gem = to_mtk_gem_obj(gem);
@@ -127,8 +128,16 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
 	pitch = fb->pitches[0];
 	format = fb->format->format;
 
-	addr += (new_state->src.x1 >> 16) * fb->format->cpp[0];
-	addr += (new_state->src.y1 >> 16) * pitch;
+	/*
+	 * Using dma_addr_t variable to calculate with multiplier of different types,
+	 * for example: addr += (new_state->src.x1 >> 16) * fb->format->cpp[0];
+	 * may cause coverity issue with unintentional overflow.
+	 */
+	offset = (new_state->src.x1 >> 16) * fb->format->cpp[0];
+	addr += offset;
+	offset = (new_state->src.y1 >> 16) * pitch;
+	addr += offset;
+
 
 	mtk_plane_state->pending.enable = true;
 	mtk_plane_state->pending.pitch = pitch;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index bdf5262ebd35..5a30d115525a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -755,7 +755,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index ca4a36464340..cb01dc36b4b5 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -557,7 +557,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 {
 	int session_idx = -1;
 	bool destroyed = false, created = false, allocated = false;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	int i, r = 0;
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 06238e6d7f5c..5b729013fd26 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -179,11 +179,15 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
+	v3d->tfu_job = job;
+
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
 		return NULL;
 
-	v3d->tfu_job = job;
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
@@ -217,6 +221,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	v3d->csd_job = job;
 
 	v3d_invalidate_caches(v3d);
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 37b2ce9b50fe..746b2abfc8fd 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -339,6 +339,12 @@ static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
 	return false;
 }
 
+static bool apple_is_omoton_kb066(struct hid_device *hdev)
+{
+	return hdev->product == USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI &&
+		strcmp(hdev->name, "Bluetooth Keyboard") == 0;
+}
+
 static inline void apple_setup_key_translation(struct input_dev *input,
 		const struct apple_key_translation *table)
 {
@@ -425,6 +431,7 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2015)
 			table = magic_keyboard_2015_fn_keys;
 		else if (hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021 ||
+			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021 ||
 			 hid->product == USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table = apple2021_fn_keys;
@@ -675,7 +682,7 @@ static int apple_input_configured(struct hid_device *hdev,
 {
 	struct apple_sc *asc = hid_get_drvdata(hdev);
 
-	if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
+	if (((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) || apple_is_omoton_kb066(hdev)) {
 		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
 		asc->quirks &= ~APPLE_HAS_FN;
 	}
@@ -1030,6 +1037,10 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024),
+		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
 		.driver_data = APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK | APPLE_RDESC_BATTERY },
 	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d8c5e24e7d44..4187d890bcc1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -184,6 +184,7 @@
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
 #define USB_DEVICE_ID_APPLE_IRCONTROL5	0x8243
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2024   0x0320
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021   0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021   0x029f
 #define USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT 0x8102
@@ -1072,6 +1073,7 @@
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001		0x3001
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
+#define USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473		0x5473
 
 #define I2C_VENDOR_ID_RAYDIUM		0x2386
 #define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index debc49272a5c..875c44e5cf6c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -882,6 +882,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
 };
 
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index dd5fc60874ba..42141a78bdb4 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -517,6 +517,10 @@ static int ish_fw_reset_handler(struct ishtp_device *dev)
 	/* ISH FW is dead */
 	if (!ish_is_input_ready(dev))
 		return	-EPIPE;
+
+	/* Send clock sync at once after reset */
+	ishtp_dev->prev_sync = 0;
+
 	/*
 	 * Set HOST2ISH.ILUP. Apparently we need this BEFORE sending
 	 * RESET_NOTIFY_ACK - FW will be checking for it
@@ -576,15 +580,14 @@ static void fw_reset_work_fn(struct work_struct *unused)
  */
 static void _ish_sync_fw_clock(struct ishtp_device *dev)
 {
-	static unsigned long	prev_sync;
-	uint64_t	usec;
+	struct ipc_time_update_msg time = {};
 
-	if (prev_sync && time_before(jiffies, prev_sync + 20 * HZ))
+	if (dev->prev_sync && time_before(jiffies, dev->prev_sync + 20 * HZ))
 		return;
 
-	prev_sync = jiffies;
-	usec = ktime_to_us(ktime_get_boottime());
-	ipc_send_mng_msg(dev, MNG_SYNC_FW_CLOCK, &usec, sizeof(uint64_t));
+	dev->prev_sync = jiffies;
+	/* The fields of time would be updated while sending message */
+	ipc_send_mng_msg(dev, MNG_SYNC_FW_CLOCK, &time, sizeof(time));
 }
 
 /**
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index 32142c7d9a04..9b2ee3fe04b8 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -212,6 +212,8 @@ struct ishtp_device {
 	unsigned int	ipc_tx_cnt;
 	unsigned long long	ipc_tx_bytes_cnt;
 
+	/* Time of the last clock sync */
+	unsigned long prev_sync;
 	const struct ishtp_hw_ops *ops;
 	size_t	mtu;
 	uint32_t	ishtp_msg_hdr;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index a2191bc5c153..dfbfdbf9cbd7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2409,12 +2409,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	mutex_lock(&hyperv_mmio_lock);
+
+	/*
+	 * If all bytes of the MMIO range to be released are within the
+	 * special case fb_mmio shadow region, skip releasing the shadow
+	 * region since no corresponding __request_region() was done
+	 * in vmbus_allocate_mmio().
+	 */
+	if (fb_mmio && start >= fb_mmio->start &&
+	    (start + size - 1 <= fb_mmio->end))
+		goto skip_shadow_release;
+
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
 		__release_region(iter, start, size);
 	}
+
+skip_shadow_release:
 	release_mem_region(start, size);
 	mutex_unlock(&hyperv_mmio_lock);
 
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index ee83c4581bce..cd2c8afebe79 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -490,6 +490,8 @@ MODULE_DEVICE_TABLE(pci, ali1535_ids);
 
 static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (ali1535_setup(dev)) {
 		dev_warn(&dev->dev,
 			"ALI1535 not detected, module not inserted.\n");
@@ -501,7 +503,15 @@ static int ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
 		"SMBus ALI1535 adapter at %04x", ali1535_offset);
-	return i2c_add_adapter(&ali1535_adapter);
+	ret = i2c_add_adapter(&ali1535_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+	return ret;
 }
 
 static void ali1535_remove(struct pci_dev *dev)
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index cc58feacd082..28a57cb6efb9 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -473,6 +473,8 @@ MODULE_DEVICE_TABLE (pci, ali15x3_ids);
 
 static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (ali15x3_setup(dev)) {
 		dev_err(&dev->dev,
 			"ALI15X3 not detected, module not inserted.\n");
@@ -484,7 +486,15 @@ static int ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	snprintf(ali15x3_adapter.name, sizeof(ali15x3_adapter.name),
 		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
-	return i2c_add_adapter(&ali15x3_adapter);
+	ret = i2c_add_adapter(&ali15x3_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+	return ret;
 }
 
 static void ali15x3_remove(struct pci_dev *dev)
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7ec252199706..256fa766b1d3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1049,23 +1049,6 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	return 0;
 }
 
-static irqreturn_t
-omap_i2c_isr(int irq, void *dev_id)
-{
-	struct omap_i2c_dev *omap = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
-	u16 mask;
-	u16 stat;
-
-	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
-
-	if (stat & mask)
-		ret = IRQ_WAKE_THREAD;
-
-	return ret;
-}
-
 static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 {
 	u16 bits;
@@ -1096,8 +1079,13 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
-			err |= OMAP_I2C_STAT_NACK;
+			omap->cmd_err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);
+
+			if (!(stat & ~OMAP_I2C_STAT_NACK)) {
+				err = -EAGAIN;
+				break;
+			}
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
@@ -1475,7 +1463,7 @@ omap_i2c_probe(struct platform_device *pdev)
 				IRQF_NO_SUSPEND, pdev->name, omap);
 	else
 		r = devm_request_threaded_irq(&pdev->dev, omap->irq,
-				omap_i2c_isr, omap_i2c_isr_thread,
+				NULL, omap_i2c_isr_thread,
 				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				pdev->name, omap);
 
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 87d56250d78a..c42ecadac4f2 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -509,6 +509,8 @@ MODULE_DEVICE_TABLE(pci, sis630_ids);
 
 static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev,
 			"SIS630 compatible bus not detected, "
@@ -522,7 +524,15 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
 		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
-	return i2c_add_adapter(&sis630_adapter);
+	ret = i2c_add_adapter(&sis630_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION);
+	return ret;
 }
 
 static void sis630_remove(struct pci_dev *dev)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 23f9a48828dc..15a62d0d243c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1186,8 +1186,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 9c28f4625c92..9d4f744b001a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -220,9 +220,10 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn);
 void bnxt_qplib_mark_qp_error(void *qp_handle);
+
 static inline u32 map_qp_id_to_tbl_indx(u32 qid, struct bnxt_qplib_rcfw *rcfw)
 {
 	/* Last index of the qp_tbl is for QP1 ie. qp_tbl_size - 1*/
-	return (qid == 1) ? rcfw->qp_tbl_size - 1 : qid % rcfw->qp_tbl_size - 2;
+	return (qid == 1) ? rcfw->qp_tbl_size - 1 : (qid % (rcfw->qp_tbl_size - 2));
 }
 #endif /* __BNXT_QPLIB_RCFW_H__ */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f1de497fc977..173ab794fa78 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1416,6 +1416,11 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+/* This is the bottom bt pages number of a 100G MR on 4K OS, assuming
+ * the bt page size is not expanded by cal_best_bt_pg_sz()
+ */
+#define RESCHED_LOOP_CNT_THRESHOLD_ON_4K 12800
+
 /* construct the base address table and link them by address hop config */
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
@@ -1424,6 +1429,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
+	int loop;
 	int unit;
 	int ret;
 	int i;
@@ -1441,7 +1447,10 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			continue;
 
 		end = r->offset + r->count;
-		for (ofs = r->offset; ofs < end; ofs += unit) {
+		for (ofs = r->offset, loop = 1; ofs < end; ofs += unit, loop++) {
+			if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+				cond_resched();
+
 			ret = hem_list_alloc_mid_bt(hr_dev, r, unit, ofs,
 						    hem_list->mid_bt[i],
 						    &hem_list->btm_bt);
@@ -1498,9 +1507,14 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
+	int loop = 1;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
+		if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+			cond_resched();
+		loop++;
+
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index afe7523eca90..5106b3ce89f0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -182,7 +182,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				  IB_DEVICE_RC_RNR_NAK_GEN;
 	props->max_send_sge = hr_dev->caps.max_sq_sg;
 	props->max_recv_sge = hr_dev->caps.max_rq_sg;
-	props->max_sge_rd = 1;
+	props->max_sge_rd = hr_dev->caps.max_sq_sg;
 	props->max_cq = hr_dev->caps.num_cqs;
 	props->max_cqe = hr_dev->caps.max_cqes;
 	props->max_mr = hr_dev->caps.num_mtpts;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 19136cb16960..0f0351abe9b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -924,12 +924,14 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ib_create_qp *ucmd,
 			    struct hns_roce_ib_create_qp_resp *resp)
 {
+	bool has_sdb = user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd);
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
 		struct hns_roce_ucontext, ibucontext);
+	bool has_rdb = user_qp_has_rdb(hr_dev, init_attr, udata, resp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+	if (has_sdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr, &hr_qp->sdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -940,7 +942,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 	}
 
-	if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+	if (has_rdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->db_addr, &hr_qp->rdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -954,7 +956,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_sdb:
-	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
+	if (has_sdb)
 		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 err_out:
 	return ret;
@@ -1211,7 +1213,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
 			ibdev_err(ibdev, "copy qp resp failed!\n");
-			goto err_store;
+			goto err_flow_ctrl;
 		}
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 34d1f07ea4c3..8813db7eec39 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1080,16 +1080,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
 			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
 			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/* Mivvy M310 */
@@ -1159,9 +1157,7 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
-	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
-	 * none of them have an external PS/2 port so this can safely be set for
-	 * all of them.
+	 * after suspend fixable with the forcenorestore quirk.
 	 * Clevo barebones come with board_vendor and/or system_vendor set to
 	 * either the very generic string "Notebook" and/or a different value
 	 * for each individual reseller. The only somewhat universal way to
@@ -1171,29 +1167,25 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
@@ -1205,29 +1197,19 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
-		/*
-		 * Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS makes
-		 * the keyboard very laggy for ~5 seconds after boot and
-		 * sometimes also after resume.
-		 * However both are required for the keyboard to not fail
-		 * completely sometimes after boot or resume.
-		 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NHxxRZQ"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	/*
 	 * At least one modern Clevo barebone has the touchpad connected both
@@ -1243,17 +1225,15 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX |
+					SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX |
+					SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
@@ -1265,8 +1245,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "P640RE"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
@@ -1277,16 +1262,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65xH"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
@@ -1297,8 +1280,7 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65_P67H"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
@@ -1309,8 +1291,7 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RP"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
@@ -1321,8 +1302,7 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RS"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
@@ -1333,22 +1313,43 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "P67xRP"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PB51RF"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PB71RD"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PC70DR"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX_GN20"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
 	{
@@ -1361,15 +1362,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
 		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+		.driver_data = (void *)(SERIO_QUIRK_FORCENORESTORE)
 	},
 	{
 		/*
diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..31eca8394a26 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -258,6 +258,7 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 {
 	struct mlxreg_core_platform_data *led_pdata;
 	struct mlxreg_led_priv_data *priv;
+	int err;
 
 	led_pdata = dev_get_platdata(&pdev->dev);
 	if (!led_pdata) {
@@ -269,28 +270,21 @@ static int mlxreg_led_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	mutex_init(&priv->access_lock);
+	err = devm_mutex_init(&pdev->dev, &priv->access_lock);
+	if (err)
+		return err;
+
 	priv->pdev = pdev;
 	priv->pdata = led_pdata;
 
 	return mlxreg_led_config(priv);
 }
 
-static int mlxreg_led_remove(struct platform_device *pdev)
-{
-	struct mlxreg_led_priv_data *priv = dev_get_drvdata(&pdev->dev);
-
-	mutex_destroy(&priv->access_lock);
-
-	return 0;
-}
-
 static struct platform_driver mlxreg_led_driver = {
 	.driver = {
 	    .name = "leds-mlxreg",
 	},
 	.probe = mlxreg_led_probe,
-	.remove = mlxreg_led_remove,
 };
 
 module_platform_driver(mlxreg_led_driver);
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index e1fe2603e92e..22d8f178b04d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -336,14 +336,18 @@ static int vdec_vp8_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 	src_buf_info = container_of(bs, struct mtk_video_dec_buf, bs_buffer);
 
 	fb = inst->ctx->dev->vdec_pdata->get_cap_buffer(inst->ctx);
-	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	if (!fb) {
+		mtk_vcodec_err(inst, "fb buffer is NULL");
+		return -ENOMEM;
+	}
 
-	y_fb_dma = fb ? (u64)fb->base_y.dma_addr : 0;
+	dst_buf_info = container_of(fb, struct mtk_video_dec_buf, frame_buffer);
+	y_fb_dma = fb->base_y.dma_addr;
 	if (inst->ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1)
 		c_fb_dma = y_fb_dma +
 			inst->ctx->picinfo.buf_w * inst->ctx->picinfo.buf_h;
 	else
-		c_fb_dma = fb ? (u64)fb->base_c.dma_addr : 0;
+		c_fb_dma = fb->base_c.dma_addr;
 
 	inst->vsi->dec.bs_dma = (u64)bs->dma_addr;
 	inst->vsi->dec.bs_sz = bs->size;
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index dd18440a90c5..914c0e84b5cc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2506,8 +2506,10 @@ static int atmci_probe(struct platform_device *pdev)
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
 	ret = atmci_configure_dma(host);
-	if (ret == -EPROBE_DEFER)
+	if (ret == -EPROBE_DEFER) {
+		clk_disable_unprepare(host->mck);
 		goto err_dma_probe_defer;
+	}
 	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 5b650d5dd0ae..5a7ee8a390b0 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -396,8 +396,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -422,6 +429,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index c8536dc7d860..21ca95cdef42 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1238,10 +1238,28 @@ static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *sla
 	       slave->dev->flags & IFF_MULTICAST;
 }
 
+/**
+ * slave_set_ns_maddrs - add/del all NS mac addresses for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @add: add or remove all the NS mac addresses
+ *
+ * This function tries to add or delete all the NS mac addresses on the slave
+ *
+ * Note, the IPv6 NS target address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * arp_validate changes
+ *   * enslaving, releasing new slaves
+ */
 static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
 {
 	struct in6_addr *targets = bond->params.ns_targets;
 	char slot_maddr[MAX_ADDR_LEN];
+	struct in6_addr mcaddr;
 	int i;
 
 	if (!slave_can_set_ns_maddr(bond, slave))
@@ -1251,7 +1269,8 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
 		if (ipv6_addr_any(&targets[i]))
 			break;
 
-		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
+		addrconf_addr_solict_mult(&targets[i], &mcaddr);
+		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
 			if (add)
 				dev_mc_add(slave->dev, slot_maddr);
 			else
@@ -1274,23 +1293,43 @@ void bond_slave_ns_maddrs_del(struct bonding *bond, struct slave *slave)
 	slave_set_ns_maddrs(bond, slave, false);
 }
 
+/**
+ * slave_set_ns_maddr - set new NS mac address for slave
+ * @bond: bond device
+ * @slave: slave device
+ * @target: the new IPv6 target
+ * @slot: the old IPv6 target in the slot
+ *
+ * This function tries to replace the old mac address to new one on the slave.
+ *
+ * Note, the target/slot IPv6 address is the unicast address in Neighbor
+ * Solicitation (NS) message. The dest address of NS message should be
+ * solicited-node multicast address of the target. The dest mac of NS message
+ * is converted from the solicited-node multicast address.
+ *
+ * This function is called when
+ *   * An IPv6 NS target is added or removed.
+ */
 static void slave_set_ns_maddr(struct bonding *bond, struct slave *slave,
 			       struct in6_addr *target, struct in6_addr *slot)
 {
-	char target_maddr[MAX_ADDR_LEN], slot_maddr[MAX_ADDR_LEN];
+	char mac_addr[MAX_ADDR_LEN];
+	struct in6_addr mcast_addr;
 
 	if (!bond->params.arp_validate || !slave_can_set_ns_maddr(bond, slave))
 		return;
 
-	/* remove the previous maddr from slave */
+	/* remove the previous mac addr from slave */
+	addrconf_addr_solict_mult(slot, &mcast_addr);
 	if (!ipv6_addr_any(slot) &&
-	    !ndisc_mc_map(slot, slot_maddr, slave->dev, 0))
-		dev_mc_del(slave->dev, slot_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_del(slave->dev, mac_addr);
 
-	/* add new maddr on slave if target is set */
+	/* add new mac addr on slave if target is set */
+	addrconf_addr_solict_mult(target, &mcast_addr);
 	if (!ipv6_addr_any(target) &&
-	    !ndisc_mc_map(target, target_maddr, slave->dev, 0))
-		dev_mc_add(slave->dev, target_maddr);
+	    !ndisc_mc_map(&mcast_addr, mac_addr, slave->dev, 0))
+		dev_mc_add(slave->dev, mac_addr);
 }
 
 static void _bond_options_ns_ip6_target_set(struct bonding *bond, int slot,
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 9bdadd716f4e..c25ecf608335 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2230,14 +2230,19 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 
 			flexcan_chip_interrupts_disable(dev);
 
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
+
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
 				return err;
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2248,7 +2253,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2262,12 +2266,20 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
-			err = flexcan_chip_start(dev);
+			err = flexcan_transceiver_enable(priv);
 			if (err)
 				return err;
 
+			err = flexcan_chip_start(dev);
+			if (err) {
+				flexcan_transceiver_disable(priv);
+				return err;
+			}
+
 			flexcan_chip_interrupts_enable(dev);
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e68291697c33..a1f68b74229e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -772,22 +772,14 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 }
 
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
-					   u32 ch)
+					   u32 ch, u32 rule_entry)
 {
-	u32 cfg;
-	int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if (ch == 0) {
-		start = 0; /* Channel 0 always starts from 0th rule */
-	} else {
-		/* Get number of Channel 0 rules and adjust */
-		cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
-		start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
-	}
-
 	/* Enable write access to entry */
-	page = RCANFD_GAFL_PAGENUM(start);
+	page = RCANFD_GAFL_PAGENUM(rule_entry);
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
 			   (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
 			    RCANFD_GAFLECTR_AFLDAE));
@@ -803,13 +795,13 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 		offset = RCANFD_C_GAFL_OFFSET;
 
 	/* Accept all IDs */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, rule_entry_index), 0);
 	/* IDE or RTR is not considered for matching */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, rule_entry_index), 0);
 	/* Any data length accepted */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, rule_entry_index), 0);
 	/* Place the msg in corresponding Rx FIFO entry */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, start),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, rule_entry_index),
 			   RCANFD_GAFLP1_GAFLFDP(ridx));
 
 	/* Disable write access to page */
@@ -1825,6 +1817,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
+	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	enum rcanfd_chip_id chip_id;
 	int max_channels;
@@ -2003,7 +1996,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_configure_tx(gpriv, ch);
 
 		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch);
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
 	}
 
 	/* Configure common interrupts */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d94b46316a11..af0565c3a364 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2107,13 +2107,11 @@ mv88e6xxx_port_vlan_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
-					const unsigned char *addr, u16 vid,
-					u8 state)
+static int mv88e6xxx_port_db_get(struct mv88e6xxx_chip *chip,
+				 const unsigned char *addr, u16 vid,
+				 u16 *fid, struct mv88e6xxx_atu_entry *entry)
 {
-	struct mv88e6xxx_atu_entry entry;
 	struct mv88e6xxx_vtu_entry vlan;
-	u16 fid;
 	int err;
 
 	/* Ports have two private address databases: one for when the port is
@@ -2124,7 +2122,7 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 	 * VLAN ID into the port's database used for VLAN-unaware bridging.
 	 */
 	if (vid == 0) {
-		fid = MV88E6XXX_FID_BRIDGED;
+		*fid = MV88E6XXX_FID_BRIDGED;
 	} else {
 		err = mv88e6xxx_vtu_get(chip, vid, &vlan);
 		if (err)
@@ -2134,14 +2132,39 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		if (!vlan.valid)
 			return -EOPNOTSUPP;
 
-		fid = vlan.fid;
+		*fid = vlan.fid;
 	}
 
-	entry.state = 0;
-	ether_addr_copy(entry.mac, addr);
-	eth_addr_dec(entry.mac);
+	entry->state = 0;
+	ether_addr_copy(entry->mac, addr);
+	eth_addr_dec(entry->mac);
+
+	return mv88e6xxx_g1_atu_getnext(chip, *fid, entry);
+}
+
+static bool mv88e6xxx_port_db_find(struct mv88e6xxx_chip *chip,
+				   const unsigned char *addr, u16 vid)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
 
-	err = mv88e6xxx_g1_atu_getnext(chip, fid, &entry);
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
+	if (err)
+		return false;
+
+	return entry.state && ether_addr_equal(entry.mac, addr);
+}
+
+static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
+					const unsigned char *addr, u16 vid,
+					u8 state)
+{
+	struct mv88e6xxx_atu_entry entry;
+	u16 fid;
+	int err;
+
+	err = mv88e6xxx_port_db_get(chip, addr, vid, &fid, &entry);
 	if (err)
 		return err;
 
@@ -2739,6 +2762,13 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+	if (err)
+		goto out;
+
+	if (!mv88e6xxx_port_db_find(chip, addr, vid))
+		err = -ENOSPC;
+
+out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -6502,6 +6532,13 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
 					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+	if (err)
+		goto out;
+
+	if (!mv88e6xxx_port_db_find(chip, mdb->addr, mdb->vid))
+		err = -ENOSPC;
+
+out:
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7d9677d0f730..393a983f6d69 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1994,7 +1994,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
+						 rxr->page_pool, &xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index aa56db138d6b..d9a7b85343a4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -462,20 +462,13 @@ int bnxt_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 struct sk_buff *
 bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
-		   struct page_pool *pool, struct xdp_buff *xdp,
-		   struct rx_cmp_ext *rxcmp1)
+		   struct page_pool *pool, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 
 	if (!skb)
 		return NULL;
-	skb_checksum_none_assert(skb);
-	if (RX_CMP_L4_CS_OK(rxcmp1)) {
-		if (bp->dev->features & NETIF_F_RXCSUM) {
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb->csum_level = RX_CMP_ENCAP(rxcmp1);
-		}
-	}
+
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
 				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index ea430d6961df..ae8159c5f56c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -33,6 +33,5 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 			      struct xdp_buff *xdp);
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   u8 num_frags, struct page_pool *pool,
-				   struct xdp_buff *xdp,
-				   struct rx_cmp_ext *rxcmp1);
+				   struct xdp_buff *xdp);
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index fba178e07600..79074f041e39 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -510,7 +510,7 @@ void ice_init_arfs(struct ice_vsi *vsi)
 	struct hlist_head *arfs_fltr_list;
 	unsigned int i;
 
-	if (!vsi || vsi->type != ICE_VSI_PF)
+	if (!vsi || vsi->type != ICE_VSI_PF || ice_is_arfs_active(vsi))
 		return;
 
 	arfs_fltr_list = kcalloc(ICE_MAX_ARFS_LIST, sizeof(*arfs_fltr_list),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index ce85b48d327d..6748c92941b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -48,15 +48,10 @@ mlx5_esw_bridge_lag_rep_get(struct net_device *dev, struct mlx5_eswitch *esw)
 	struct list_head *iter;
 
 	netdev_for_each_lower_dev(dev, lower, iter) {
-		struct mlx5_core_dev *mdev;
-		struct mlx5e_priv *priv;
-
 		if (!mlx5e_eswitch_rep(lower))
 			continue;
 
-		priv = netdev_priv(lower);
-		mdev = priv->mdev;
-		if (mlx5_lag_is_shared_fdb(mdev) && mlx5_esw_bridge_dev_same_esw(lower, esw))
+		if (mlx5_esw_bridge_dev_same_esw(lower, esw))
 			return lower;
 	}
 
@@ -121,7 +116,7 @@ static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *
 	priv = netdev_priv(rep);
 	mdev = priv->mdev;
 	if (netif_is_lag_master(dev))
-		return mlx5_lag_is_shared_fdb(mdev) && mlx5_lag_is_master(mdev);
+		return mlx5_lag_is_master(mdev);
 	return true;
 }
 
@@ -436,6 +431,9 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 	if (!rep)
 		return NOTIFY_DONE;
 
+	if (netif_is_lag_master(dev) && !mlx5_lag_is_shared_fdb(esw->dev))
+		return NOTIFY_DONE;
+
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = container_of(info,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8ee6a81b42b4..f520949b2024 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4791,11 +4791,9 @@ static int mlx5e_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 mode, setting;
-	int err;
 
-	err = mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting);
-	if (err)
-		return err;
+	if (mlx5_eswitch_get_vepa(mdev->priv.eswitch, &setting))
+		return -EOPNOTSUPP;
 	mode = setting ? BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB;
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       mode,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
index df58cba37930..64c1071bece8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
@@ -196,6 +196,11 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
 		ns = mlx5_get_flow_namespace(chains->dev, chains->ns);
 	}
 
+	if (!ns) {
+		mlx5_core_warn(chains->dev, "Failed to get flow namespace\n");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	ft_attr.autogroup.num_reserved_entries = 2;
 	ft_attr.autogroup.max_num_groups = chains->group_num;
 	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index f9dd50152b1e..28d24d59efb8 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -454,8 +454,10 @@ static int qlcnic_sriov_set_guest_vlan_mode(struct qlcnic_adapter *adapter,
 
 	num_vlans = sriov->num_allowed_vlans;
 	sriov->allowed_vlans = kcalloc(num_vlans, sizeof(u16), GFP_KERNEL);
-	if (!sriov->allowed_vlans)
+	if (!sriov->allowed_vlans) {
+		qlcnic_sriov_free_vlans(adapter);
 		return -ENOMEM;
+	}
 
 	vlans = (u16 *)&cmd->rsp.arg[3];
 	for (i = 0; i < num_vlans; i++)
@@ -2167,8 +2169,10 @@ int qlcnic_sriov_alloc_vlans(struct qlcnic_adapter *adapter)
 		vf = &sriov->vf_info[i];
 		vf->sriov_vlans = kcalloc(sriov->num_allowed_vlans,
 					  sizeof(*vf->sriov_vlans), GFP_KERNEL);
-		if (!vf->sriov_vlans)
+		if (!vf->sriov_vlans) {
+			qlcnic_sriov_free_vlans(adapter);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 7635a8b3c35c..17619d011689 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -543,6 +543,7 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_i2c_hdr *hdr;
 	struct mctp_hdr *mhdr;
 	u8 lldst, llsrc;
+	int rc;
 
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
@@ -553,6 +554,10 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	lldst = *((u8 *)daddr);
 	llsrc = *((u8 *)saddr);
 
+	rc = skb_cow_head(skb, sizeof(struct mctp_i2c_hdr));
+	if (rc)
+		return rc;
+
 	skb_push(skb, sizeof(struct mctp_i2c_hdr));
 	skb_reset_mac_header(skb);
 	hdr = (void *)skb_mac_header(skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 53302c29c229..f8af851474e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1286,7 +1286,9 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 		mvm->net_detect = true;
 	} else {
-		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
+		struct iwl_wowlan_config_cmd wowlan_config_cmd = {
+			.offloading_tid = 0,
+		};
 
 		wowlan_config_cmd.sta_id = mvmvif->ap_sta_id;
 
@@ -1298,6 +1300,11 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 			goto out_noreset;
 		}
 
+		ret = iwl_mvm_sta_ensure_queue(
+			mvm, ap_sta->txq[wowlan_config_cmd.offloading_tid]);
+		if (ret)
+			goto out_noreset;
+
 		ret = iwl_mvm_get_wowlan_config(mvm, wowlan, &wowlan_config_cmd,
 						vif, mvmvif, ap_sta);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 6b52afcf0272..46bf158eb4b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1419,6 +1419,34 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm,
+			     struct ieee80211_txq *txq)
+{
+	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
+	int ret = -EINVAL;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (likely(test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) ||
+	    !txq->sta) {
+		return 0;
+	}
+
+	if (!iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, txq->tid)) {
+		set_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		ret = 0;
+	}
+
+	local_bh_disable();
+	spin_lock(&mvm->add_stream_lock);
+	if (!list_empty(&mvmtxq->list))
+		list_del_init(&mvmtxq->list);
+	spin_unlock(&mvm->add_stream_lock);
+	local_bh_enable();
+
+	return ret;
+}
+
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 {
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index f1a4fc3e4038..5f7e9311e7e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -544,6 +544,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvmvif,
 				       bool disable);
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index ef70bb7c88ad..43c20deab318 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -209,7 +209,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
 	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
 	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
 	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
-		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
+		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
 				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
 	}
 	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba76cd3b5f85..6a636fe6506b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -501,8 +501,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3dbf926fd99f..2b0f15de7711 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3525,8 +3525,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f939b6dc295e..afcb9668dad9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3577,6 +3577,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 29489c2c52fb..da9d510d3d4f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -694,6 +694,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
+static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_term_pdu *pdu)
+{
+	u16 fes;
+	const char *msg;
+	u32 plen = le32_to_cpu(pdu->hdr.plen);
+
+	static const char * const msg_table[] = {
+		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
+		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
+		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
+		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
+		[NVME_TCP_FES_DATA_LIMIT_EXCEEDED] = "Data Transfer Limit Exceeded",
+		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
+	};
+
+	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
+	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Received a malformed C2HTermReq PDU (plen = %u)\n",
+			plen);
+		return;
+	}
+
+	fes = le16_to_cpu(pdu->fes);
+	if (fes && fes < ARRAY_SIZE(msg_table))
+		msg = msg_table[fes];
+	else
+		msg = "Unknown";
+
+	dev_err(queue->ctrl->ctrl.device,
+		"Received C2HTermReq (FES = %s)\n", msg);
+}
+
 static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		unsigned int *offset, size_t *len)
 {
@@ -715,6 +749,15 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
+		/*
+		 * C2HTermReq never includes Header or Data digests.
+		 * Skip the checks.
+		 */
+		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
+		return -EINVAL;
+	}
+
 	if (queue->hdr_digest) {
 		ret = nvme_tcp_verify_hdgst(queue, queue->pdu, hdr->hlen);
 		if (unlikely(ret))
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index a6d55ebb8238..298c46834a53 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -997,6 +997,27 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	nvmet_req_complete(&cmd->req, status);
 }
 
+static bool nvmet_rdma_recv_not_live(struct nvmet_rdma_queue *queue,
+		struct nvmet_rdma_rsp *rsp)
+{
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&queue->state_lock, flags);
+	/*
+	 * recheck queue state is not live to prevent a race condition
+	 * with RDMA_CM_EVENT_ESTABLISHED handler.
+	 */
+	if (queue->state == NVMET_RDMA_Q_LIVE)
+		ret = false;
+	else if (queue->state == NVMET_RDMA_Q_CONNECTING)
+		list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+	else
+		nvmet_rdma_put_rsp(rsp);
+	spin_unlock_irqrestore(&queue->state_lock, flags);
+	return ret;
+}
+
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct nvmet_rdma_cmd *cmd =
@@ -1038,17 +1059,9 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	rsp->req.port = queue->port;
 	rsp->n_rdma = 0;
 
-	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&queue->state_lock, flags);
-		if (queue->state == NVMET_RDMA_Q_CONNECTING)
-			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
-		else
-			nvmet_rdma_put_rsp(rsp);
-		spin_unlock_irqrestore(&queue->state_lock, flags);
+	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE) &&
+	    nvmet_rdma_recv_not_live(queue, rsp))
 		return;
-	}
 
 	nvmet_rdma_handle_command(queue, rsp);
 }
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index fd52a83387ef..bba5496335ee 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -971,7 +971,7 @@ static const struct regmap_config bcm281xx_pinctrl_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = BCM281XX_PIN_VC_CAM3_SDA,
+	.max_register = BCM281XX_PIN_VC_CAM3_SDA * 4,
 };
 
 static int bcm281xx_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a57e236be050..26ca9c453a59 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8161,6 +8161,7 @@ static struct ibm_struct volume_driver_data = {
 
 #define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
 #define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
+#define FAN_CLOCK_TPM		(22500*60)	/* Ticks per minute for a 22.5 kHz clock */
 
 enum {					/* Fan control constants */
 	fan_status_offset = 0x2f,	/* EC register 0x2f */
@@ -8214,6 +8215,7 @@ static int fan_watchdog_maxinterval;
 
 static bool fan_with_ns_addr;
 static bool ecfw_with_fan_dec_rpm;
+static bool fan_speed_in_tpr;
 
 static struct mutex fan_mutex;
 
@@ -8396,8 +8398,11 @@ static int fan_get_speed(unsigned int *speed)
 			     !acpi_ec_read(fan_rpm_offset + 1, &hi)))
 			return -EIO;
 
-		if (likely(speed))
+		if (likely(speed)) {
 			*speed = (hi << 8) | lo;
+			if (fan_speed_in_tpr && *speed != 0)
+				*speed = FAN_CLOCK_TPM / *speed;
+		}
 		break;
 	case TPACPI_FAN_RD_TPEC_NS:
 		if (!acpi_ec_read(fan_rpm_status_ns, &lo))
@@ -8430,8 +8435,11 @@ static int fan2_get_speed(unsigned int *speed)
 		if (rc)
 			return -EIO;
 
-		if (likely(speed))
+		if (likely(speed)) {
 			*speed = (hi << 8) | lo;
+			if (fan_speed_in_tpr && *speed != 0)
+				*speed = FAN_CLOCK_TPM / *speed;
+		}
 		break;
 
 	case TPACPI_FAN_RD_TPEC_NS:
@@ -8959,6 +8967,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
+#define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8981,6 +8990,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
+	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -9044,6 +9054,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 
 			if (quirks & TPACPI_FAN_Q1)
 				fan_quirk1_setup();
+			if (quirks & TPACPI_FAN_TPR)
+				fan_speed_in_tpr = true;
 			/* Try and probe the 2nd fan */
 			tp_features.second_fan = 1; /* needed for get_speed to work */
 			res = fan2_get_speed(&speed);
@@ -10473,6 +10485,10 @@ static struct ibm_struct proxsensor_driver_data = {
 #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
 #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance */
 
+#define DYTC_MODE_PSCV9_LOWPOWER 1  /* Low power mode */
+#define DYTC_MODE_PSCV9_BALANCE  3  /* Default mode aka balanced */
+#define DYTC_MODE_PSCV9_PERFORM  4  /* High power mode aka performance */
+
 #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the error result */
 #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
 
@@ -10493,6 +10509,10 @@ static int dytc_capabilities;
 static bool dytc_mmc_get_available;
 static int profile_force;
 
+static int platform_psc_profile_lowpower = DYTC_MODE_PSC_LOWPOWER;
+static int platform_psc_profile_balanced = DYTC_MODE_PSC_BALANCE;
+static int platform_psc_profile_performance = DYTC_MODE_PSC_PERFORM;
+
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
 {
@@ -10514,19 +10534,15 @@ static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		}
 		return 0;
 	case DYTC_FUNCTION_PSC:
-		switch (dytcmode) {
-		case DYTC_MODE_PSC_LOWPOWER:
+		if (dytcmode == platform_psc_profile_lowpower)
 			*profile = PLATFORM_PROFILE_LOW_POWER;
-			break;
-		case DYTC_MODE_PSC_BALANCE:
+		else if (dytcmode == platform_psc_profile_balanced)
 			*profile =  PLATFORM_PROFILE_BALANCED;
-			break;
-		case DYTC_MODE_PSC_PERFORM:
+		else if (dytcmode == platform_psc_profile_performance)
 			*profile =  PLATFORM_PROFILE_PERFORMANCE;
-			break;
-		default: /* Unknown mode */
+		else
 			return -EINVAL;
-		}
+
 		return 0;
 	case DYTC_FUNCTION_AMT:
 		/* For now return balanced. It's the closest we have to 'auto' */
@@ -10547,19 +10563,19 @@ static int convert_profile_to_dytc(enum platform_profile_option profile, int *pe
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_LOWPOWER;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_LOWPOWER;
+			*perfmode = platform_psc_profile_lowpower;
 		break;
 	case PLATFORM_PROFILE_BALANCED:
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_BALANCE;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_BALANCE;
+			*perfmode = platform_psc_profile_balanced;
 		break;
 	case PLATFORM_PROFILE_PERFORMANCE:
 		if (dytc_capabilities & BIT(DYTC_FC_MMC))
 			*perfmode = DYTC_MODE_MMC_PERFORM;
 		else if (dytc_capabilities & BIT(DYTC_FC_PSC))
-			*perfmode = DYTC_MODE_PSC_PERFORM;
+			*perfmode = platform_psc_profile_performance;
 		break;
 	default: /* Unknown profile */
 		return -EOPNOTSUPP;
@@ -10748,6 +10764,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	if (output & BIT(DYTC_QUERY_ENABLE_BIT))
 		dytc_version = (output >> DYTC_QUERY_REV_BIT) & 0xF;
 
+	dbg_printk(TPACPI_DBG_INIT, "DYTC version %d\n", dytc_version);
 	/* Check DYTC is enabled and supports mode setting */
 	if (dytc_version < 5)
 		return -ENODEV;
@@ -10786,6 +10803,11 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
 		pr_debug("PSC is supported\n");
+		if (dytc_version >= 9) { /* update profiles for DYTC 9 and up */
+			platform_psc_profile_lowpower = DYTC_MODE_PSCV9_LOWPOWER;
+			platform_psc_profile_balanced = DYTC_MODE_PSCV9_BALANCE;
+			platform_psc_profile_performance = DYTC_MODE_PSCV9_PERFORM;
+		}
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
 		return -ENODEV;
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index ff736b006198..fd475e463d1f 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -626,8 +626,7 @@ struct powercap_control_type *powercap_register_control_type(
 	dev_set_name(&control_type->dev, "%s", name);
 	result = device_register(&control_type->dev);
 	if (result) {
-		if (control_type->allocated)
-			kfree(control_type);
+		put_device(&control_type->dev);
 		return ERR_PTR(result);
 	}
 	idr_init(&control_type->idr);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index fc52551aa265..29c9171e923a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2091,6 +2091,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			if (!r) {
+				ret = -EPROBE_DEFER;
+				goto out;
+			}
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -2108,6 +2112,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		if (!r) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		get_device(&r->dev);
 	}
 
@@ -2216,8 +2224,10 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			if (!rdev)
+				return ERR_PTR(-EPROBE_DEFER);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			get_device(&rdev->dev);
 			break;
 
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 5440f285f349..7e00c061538d 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -661,7 +661,8 @@ static int info_update(void)
 	if (time_after(jiffies, chp_info_expires)) {
 		/* Data is too old, update. */
 		rc = sclp_chp_read_info(&chp_info);
-		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+		if (!rc)
+			chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL;
 	}
 	mutex_unlock(&info_lock);
 
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 1e7f4d138e06..0bb80d135f56 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -2866,7 +2866,7 @@ qla1280_64bit_start_scsi(struct scsi_qla_host *ha, struct srb * sp)
 			dprintk(3, "S/G Segment phys_addr=%x %x, len=0x%x\n",
 				cpu_to_le32(upper_32_bits(dma_handle)),
 				cpu_to_le32(lower_32_bits(dma_handle)),
-				cpu_to_le32(sg_dma_len(sg_next(s))));
+				cpu_to_le32(sg_dma_len(s)));
 			remseg--;
 		}
 		dprintk(5, "qla1280_64bit_start_scsi: Scatter/gather "
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 852d509b19b2..69288303e600 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -245,7 +245,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	}
 	ret = sbitmap_init_node(&sdev->budget_map,
 				scsi_device_max_queue_depth(sdev),
-				new_shift, GFP_KERNEL,
+				new_shift, GFP_NOIO,
 				sdev->request_queue->node, false, true);
 	if (!ret)
 		sbitmap_resize(&sdev->budget_map, depth);
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index a160854a1917..006cad061a32 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -30,11 +30,9 @@
 
 struct imx8_soc_data {
 	char *name;
-	int (*soc_revision)(u32 *socrev);
+	int (*soc_revision)(u32 *socrev, u64 *socuid);
 };
 
-static u64 soc_uid;
-
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
 {
@@ -51,24 +49,22 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static int imx8mq_soc_revision(u32 *socrev)
+static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
 	struct clk *clk;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -89,44 +85,39 @@ static int imx8mq_soc_revision(u32 *socrev)
 			rev = REV_B1;
 	}
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
 	*socrev = rev;
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
-	of_node_put(np);
 
 	return 0;
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
 	return ret;
 }
 
-static int imx8mm_soc_uid(void)
+static int imx8mm_soc_uid(u64 *socuid)
 {
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	void __iomem *ocotp_base;
-	struct device_node *np;
 	struct clk *clk;
 	int ret = 0;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -136,47 +127,36 @@ static int imx8mm_soc_uid(void)
 
 	clk_prepare_enable(clk);
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
-
 	return ret;
 }
 
-static int imx8mm_soc_revision(u32 *socrev)
+static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	void __iomem *anatop_base;
-	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
 		return -EINVAL;
 
 	anatop_base = of_iomap(np, 0);
-	if (!anatop_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!anatop_base)
+		return -EINVAL;
 
 	*socrev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
 
 	iounmap(anatop_base);
-	of_node_put(np);
 
-	return imx8mm_soc_uid();
-
-err_iomap:
-	of_node_put(np);
-	return ret;
+	return imx8mm_soc_uid(socuid);
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -207,21 +187,34 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };
 
-#define imx8_revision(soc_rev) \
-	soc_rev ? \
-	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+#define imx8_revision(dev, soc_rev) \
+	(soc_rev) ? \
+	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
 	"unknown"
 
+static void imx8m_unregister_soc(void *data)
+{
+	soc_device_unregister(data);
+}
+
+static void imx8m_unregister_cpufreq(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
+	struct platform_device *cpufreq_dev;
+	const struct imx8_soc_data *data;
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
+	struct soc_device *soc_dev;
 	u32 soc_rev = 0;
-	const struct imx8_soc_data *data;
+	u64 soc_uid = 0;
 	int ret;
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -229,58 +222,52 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 
 	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
 	if (ret)
-		goto free_soc;
+		return ret;
 
 	id = of_match_node(imx8_soc_match, of_root);
-	if (!id) {
-		ret = -ENODEV;
-		goto free_soc;
-	}
+	if (!id)
+		return -ENODEV;
 
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision) {
-			ret = data->soc_revision(&soc_rev);
+			ret = data->soc_revision(&soc_rev, &soc_uid);
 			if (ret)
-				goto free_soc;
+				return ret;
 		}
 	}
 
-	soc_dev_attr->revision = imx8_revision(soc_rev);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto free_soc;
-	}
+	soc_dev_attr->revision = imx8_revision(dev, soc_rev);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
-	if (!soc_dev_attr->serial_number) {
-		ret = -ENOMEM;
-		goto free_rev;
-	}
+	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto free_serial_number;
-	}
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	ret = devm_add_action(dev, imx8m_unregister_soc, soc_dev);
+	if (ret)
+		return ret;
 
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		if (IS_ERR(cpufreq_dev))
+			return dev_err_probe(dev, PTR_ERR(cpufreq_dev),
+					     "Failed to register imx-cpufreq-dev device\n");
+		ret = devm_add_action(dev, imx8m_unregister_cpufreq, cpufreq_dev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_rev:
-	if (strcmp(soc_dev_attr->revision, "unknown"))
-		kfree(soc_dev_attr->revision);
-free_soc:
-	kfree(soc_dev_attr);
-	return ret;
 }
 
 static struct platform_driver imx8m_soc_driver = {
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index c7cd4daa10b0..f83491a7510e 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -74,7 +74,6 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 {
 	struct pdr_handle *pdr = container_of(qmi, struct pdr_handle,
 					      locator_hdl);
-	struct pdr_service *pds;
 
 	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
@@ -86,12 +85,7 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 	mutex_unlock(&pdr->lock);
 
 	/* Service pending lookup requests */
-	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (pds->need_locator_lookup)
-			schedule_work(&pdr->locator_work);
-	}
-	mutex_unlock(&pdr->list_lock);
+	schedule_work(&pdr->locator_work);
 
 	return 0;
 }
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 9f8b438fcf8f..bac0f52a361b 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -57,8 +57,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @cooling_ops: cpufreq callbacks to thermal cooling device ops
  * @idle_time: idle time stats
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 248cbc9c48fd..f1498b511a81 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1079,6 +1079,20 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
+	/* Altera USB Blaster 3 */
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6022_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6025_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6029_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602C_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 5ee60ba2a73c..52be47d684ea 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1612,3 +1612,16 @@
  */
 #define GMC_VID				0x1cd7
 #define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
+
+/*
+ *  Altera USB Blaster 3 (http://www.altera.com).
+ */
+#define ALTERA_VID			0x09fb
+#define ALTERA_UB3_6022_PID		0x6022
+#define ALTERA_UB3_6025_PID		0x6025
+#define ALTERA_UB3_6026_PID		0x6026
+#define ALTERA_UB3_6029_PID		0x6029
+#define ALTERA_UB3_602A_PID		0x602a
+#define ALTERA_UB3_602C_PID		0x602c
+#define ALTERA_UB3_602D_PID		0x602d
+#define ALTERA_UB3_602E_PID		0x602e
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 7ca07ba1a139..715738d70cbf 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1368,13 +1368,13 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990 (rmnet) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1080, 0xff),	/* Telit FE990A (rmnet) */
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990 (MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1081, 0xff),	/* Telit FE990A (MBIM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990 (RNDIS) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1082, 0xff),	/* Telit FE990A (RNDIS) */
 	  .driver_info = NCTRL(2) | RSVD(3) },
-	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990 (ECM) */
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1083, 0xff),	/* Telit FE990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
@@ -1388,28 +1388,44 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x30),	/* Telit FE990B (rmnet) */
+	  .driver_info = NCTRL(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x30),	/* Telit FE990B (MBIM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b1, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x30),	/* Telit FE990B (RNDIS) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b2, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x30),	/* Telit FE990B (ECM) */
+	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x60) },	/* Telit FN990B (rmnet) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d0, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x30),	/* Telit FN990B (rmnet) */
 	  .driver_info = NCTRL(5) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x60) },	/* Telit FN990B (MBIM) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d1, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x60) },	/* Telit FN990B (RNDIS) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d2, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x30),	/* Telit FN990B (RNDIS) */
 	  .driver_info = NCTRL(6) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x60) },	/* Telit FN990B (ECM) */
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x40) },
-	{ USB_DEVICE_INTERFACE_PROTOCOL(TELIT_VENDOR_ID, 0x10d3, 0x30),
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d2, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x30),	/* Telit FN990B (ECM) */
 	  .driver_info = NCTRL(6) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index d3d643cf7506..41c496ff55cc 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1106,7 +1106,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0893c1012de6..fe52c8cbf136 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -112,7 +112,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 }
 
 #ifdef CONFIG_X86
-int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
+int __init xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 {
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index aa2be4c1ea8f..de31cb8eb720 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1445,7 +1445,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 		goto out_err;
 
 	if (fc->cache_symlinks)
-		return page_get_link(dentry, inode, callback);
+		return page_get_link_raw(dentry, inode, callback);
 
 	err = -ECHILD;
 	if (!dentry)
diff --git a/fs/namei.c b/fs/namei.c
index 166d71c82d7a..6ce07cde1c27 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5156,10 +5156,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
 EXPORT_SYMBOL(vfs_get_link);
 
 /* get the link contents into pagecache */
-const char *page_get_link(struct dentry *dentry, struct inode *inode,
-			  struct delayed_call *callback)
+static char *__page_get_link(struct dentry *dentry, struct inode *inode,
+			     struct delayed_call *callback)
 {
-	char *kaddr;
 	struct page *page;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -5178,8 +5177,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 	}
 	set_delayed_call(callback, page_put_link, page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
-	kaddr = page_address(page);
-	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
+	return page_address(page);
+}
+
+const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
+			      struct delayed_call *callback)
+{
+	return __page_get_link(dentry, inode, callback);
+}
+EXPORT_SYMBOL_GPL(page_get_link_raw);
+
+const char *page_get_link(struct dentry *dentry, struct inode *inode,
+					struct delayed_call *callback)
+{
+	char *kaddr = __page_get_link(dentry, inode, callback);
+
+	if (!IS_ERR(kaddr))
+		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
 	return kaddr;
 }
 
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0388e6b42100..feda45c7ca8e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -176,7 +176,7 @@ static int run_deallocate_ex(struct ntfs_sb_info *sbi, struct runs_tree *run,
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn)
+			   CLST *new_lcn, CLST *new_len)
 {
 	int err;
 	CLST flen, vcn0 = vcn, pre = pre_alloc ? *pre_alloc : 0;
@@ -196,20 +196,36 @@ int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 		if (err)
 			goto out;
 
-		if (new_lcn && vcn == vcn0)
-			*new_lcn = lcn;
+		if (vcn == vcn0) {
+			/* Return the first fragment. */
+			if (new_lcn)
+				*new_lcn = lcn;
+			if (new_len)
+				*new_len = flen;
+		}
 
 		/* Add new fragment into run storage. */
-		if (!run_add_entry(run, vcn, lcn, flen, opt == ALLOCATE_MFT)) {
+		if (!run_add_entry(run, vcn, lcn, flen, opt & ALLOCATE_MFT)) {
 			/* Undo last 'ntfs_look_for_free_space' */
 			mark_as_free_ex(sbi, lcn, len, false);
 			err = -ENOMEM;
 			goto out;
 		}
 
+		if (opt & ALLOCATE_ZERO) {
+			u8 shift = sbi->cluster_bits - SECTOR_SHIFT;
+
+			err = blkdev_issue_zeroout(sbi->sb->s_bdev,
+						   (sector_t)lcn << shift,
+						   (sector_t)flen << shift,
+						   GFP_NOFS, 0);
+			if (err)
+				goto out;
+		}
+
 		vcn += flen;
 
-		if (flen >= len || opt == ALLOCATE_MFT ||
+		if (flen >= len || (opt & ALLOCATE_MFT) ||
 		    (fr && run->count - cnt >= fr)) {
 			*alen = vcn - vcn0;
 			return 0;
@@ -287,7 +303,8 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 		const char *data = resident_data(attr);
 
 		err = attr_allocate_clusters(sbi, run, 0, 0, len, NULL,
-					     ALLOCATE_DEF, &alen, 0, NULL);
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out1;
 
@@ -582,13 +599,13 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			/* ~3 bytes per fragment. */
 			err = attr_allocate_clusters(
 				sbi, run, vcn, lcn, to_allocate, &pre_alloc,
-				is_mft ? ALLOCATE_MFT : 0, &alen,
+				is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
 				is_mft ? 0
 				       : (sbi->record_size -
 					  le32_to_cpu(rec->used) + 8) /
 							 3 +
 						 1,
-				NULL);
+				NULL, NULL);
 			if (err)
 				goto out;
 		}
@@ -886,8 +903,19 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	return err;
 }
 
+/*
+ * attr_data_get_block - Returns 'lcn' and 'len' for given 'vcn'.
+ *
+ * @new == NULL means just to get current mapping for 'vcn'
+ * @new != NULL means allocate real cluster if 'vcn' maps to hole
+ * @zero - zeroout new allocated clusters
+ *
+ *  NOTE:
+ *  - @new != NULL is called only for sparsed or compressed attributes.
+ *  - new allocated clusters are zeroed via blkdev_issue_zeroout.
+ */
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new)
+			CLST *len, bool *new, bool zero)
 {
 	int err = 0;
 	struct runs_tree *run = &ni->file.run;
@@ -896,29 +924,27 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end;
+	CLST hint, svcn, to_alloc, evcn1, next_svcn, asize, end, vcn0, alen;
+	unsigned int fr;
 	u64 total_size;
-	u32 clst_per_frame;
-	bool ok;
 
 	if (new)
 		*new = false;
 
+	/* Try to find in cache. */
 	down_read(&ni->file.run_lock);
-	ok = run_lookup_entry(run, vcn, lcn, len, NULL);
+	if (!run_lookup_entry(run, vcn, lcn, len, NULL))
+		*len = 0;
 	up_read(&ni->file.run_lock);
 
-	if (ok && (*lcn != SPARSE_LCN || !new)) {
-		/* Normal way. */
-		return 0;
+	if (*len) {
+		if (*lcn != SPARSE_LCN || !new)
+			return 0; /* Fast normal way without allocation. */
+		else if (clen > *len)
+			clen = *len;
 	}
 
-	if (!clen)
-		clen = 1;
-
-	if (ok && clen > *len)
-		clen = *len;
-
+	/* No cluster in cache or we need to allocate cluster in hole. */
 	sbi = ni->mi.sbi;
 	cluster_bits = sbi->cluster_bits;
 
@@ -944,12 +970,6 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		goto out;
 	}
 
-	clst_per_frame = 1u << attr_b->nres.c_unit;
-	to_alloc = (clen + clst_per_frame - 1) & ~(clst_per_frame - 1);
-
-	if (vcn + to_alloc > asize)
-		to_alloc = asize - vcn;
-
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
 
@@ -968,36 +988,68 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
 	}
 
+	/* Load in cache actual information. */
 	err = attr_load_runs(attr, ni, run, NULL);
 	if (err)
 		goto out;
 
-	if (!ok) {
-		ok = run_lookup_entry(run, vcn, lcn, len, NULL);
-		if (ok && (*lcn != SPARSE_LCN || !new)) {
-			/* Normal way. */
-			err = 0;
-			goto ok;
-		}
+	if (!*len) {
+		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
+			if (*lcn != SPARSE_LCN || !new)
+				goto ok; /* Slow normal way without allocation. */
 
-		if (!ok && !new) {
-			*len = 0;
-			err = 0;
+			if (clen > *len)
+				clen = *len;
+		} else if (!new) {
+			/* Here we may return -ENOENT.
+			 * In any case caller gets zero length. */
 			goto ok;
 		}
-
-		if (ok && clen > *len) {
-			clen = *len;
-			to_alloc = (clen + clst_per_frame - 1) &
-				   ~(clst_per_frame - 1);
-		}
 	}
 
 	if (!is_attr_ext(attr_b)) {
+		/* The code below only for sparsed or compressed attributes. */
 		err = -EINVAL;
 		goto out;
 	}
 
+	vcn0 = vcn;
+	to_alloc = clen;
+	fr = (sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1;
+	/* Allocate frame aligned clusters.
+	 * ntfs.sys usually uses 16 clusters per frame for sparsed or compressed.
+	 * ntfs3 uses 1 cluster per frame for new created sparsed files. */
+	if (attr_b->nres.c_unit) {
+		CLST clst_per_frame = 1u << attr_b->nres.c_unit;
+		CLST cmask = ~(clst_per_frame - 1);
+
+		/* Get frame aligned vcn and to_alloc. */
+		vcn = vcn0 & cmask;
+		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
+		if (fr < clst_per_frame)
+			fr = clst_per_frame;
+		zero = true;
+
+		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
+		if (vcn < svcn || evcn1 <= vcn) {
+			/* Load attribute for truncated vcn. */
+			attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0,
+					    &vcn, &mi);
+			if (!attr) {
+				err = -EINVAL;
+				goto out;
+			}
+			svcn = le64_to_cpu(attr->nres.svcn);
+			evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+			err = attr_load_runs(attr, ni, run, NULL);
+			if (err)
+				goto out;
+		}
+	}
+
+	if (vcn + to_alloc > asize)
+		to_alloc = asize - vcn;
+
 	/* Get the last LCN to allocate from. */
 	hint = 0;
 
@@ -1011,18 +1063,33 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 		hint = -1;
 	}
 
-	err = attr_allocate_clusters(
-		sbi, run, vcn, hint + 1, to_alloc, NULL, 0, len,
-		(sbi->record_size - le32_to_cpu(mi->mrec->used) + 8) / 3 + 1,
-		lcn);
+	/* Allocate and zeroout new clusters. */
+	err = attr_allocate_clusters(sbi, run, vcn, hint + 1, to_alloc, NULL,
+				     zero ? ALLOCATE_ZERO : ALLOCATE_DEF, &alen,
+				     fr, lcn, len);
 	if (err)
 		goto out;
 	*new = true;
 
-	end = vcn + *len;
-
+	end = vcn + alen;
 	total_size = le64_to_cpu(attr_b->nres.total_size) +
-		     ((u64)*len << cluster_bits);
+		     ((u64)alen << cluster_bits);
+
+	if (vcn != vcn0) {
+		if (!run_lookup_entry(run, vcn0, lcn, len, NULL)) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (*lcn == SPARSE_LCN) {
+			/* Internal error. Should not happened. */
+			WARN_ON(1);
+			err = -EINVAL;
+			goto out;
+		}
+		/* Check case when vcn0 + len overlaps new allocated clusters. */
+		if (vcn0 + *len > end)
+			*len = end - vcn0;
+	}
 
 repack:
 	err = mi_pack_runs(mi, attr, run, max(end, evcn1) - svcn);
@@ -1547,7 +1614,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, next_svcn, lcn, len;
+	CLST svcn, evcn1, next_svcn, len;
 	CLST vcn, end, clst_data;
 	u64 total_size, valid_size, data_size;
 
@@ -1623,8 +1690,9 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 		}
 
 		err = attr_allocate_clusters(sbi, run, vcn + clst_data,
-					     hint + 1, len - clst_data, NULL, 0,
-					     &alen, 0, &lcn);
+					     hint + 1, len - clst_data, NULL,
+					     ALLOCATE_DEF, &alen, 0, NULL,
+					     NULL);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 70b38465aee3..72e25842f5dc 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -122,8 +122,8 @@ static int ntfs_extend_initialized_size(struct file *file,
 			bits = sbi->cluster_bits;
 			vcn = pos >> bits;
 
-			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen,
-						  NULL);
+			err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL,
+						  false);
 			if (err)
 				goto out;
 
@@ -196,18 +196,18 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	struct address_space *mapping = inode->i_mapping;
 	u32 blocksize = 1 << inode->i_blkbits;
 	pgoff_t idx = vbo >> PAGE_SHIFT;
-	u32 z_start = vbo & (PAGE_SIZE - 1);
+	u32 from = vbo & (PAGE_SIZE - 1);
 	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	loff_t page_off;
 	struct buffer_head *head, *bh;
-	u32 bh_next, bh_off, z_end;
+	u32 bh_next, bh_off, to;
 	sector_t iblock;
 	struct page *page;
 
-	for (; idx < idx_end; idx += 1, z_start = 0) {
+	for (; idx < idx_end; idx += 1, from = 0) {
 		page_off = (loff_t)idx << PAGE_SHIFT;
-		z_end = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
-							: PAGE_SIZE;
+		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
+						     : PAGE_SIZE;
 		iblock = page_off >> inode->i_blkbits;
 
 		page = find_or_create_page(mapping, idx,
@@ -224,7 +224,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		do {
 			bh_next = bh_off + blocksize;
 
-			if (bh_next <= z_start || bh_off >= z_end)
+			if (bh_next <= from || bh_off >= to)
 				continue;
 
 			if (!buffer_mapped(bh)) {
@@ -258,7 +258,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		} while (bh_off = bh_next, iblock += 1,
 			 head != (bh = bh->b_this_page));
 
-		zero_user_segment(page, z_start, z_end);
+		zero_user_segment(page, from, to);
 
 		unlock_page(page);
 		put_page(page);
@@ -269,81 +269,6 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 	return err;
 }
 
-/*
- * ntfs_sparse_cluster - Helper function to zero a new allocated clusters.
- *
- * NOTE: 512 <= cluster size <= 2M
- */
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
-	u64 vbo = (u64)vcn << sbi->cluster_bits;
-	u64 bytes = (u64)len << sbi->cluster_bits;
-	u32 blocksize = 1 << inode->i_blkbits;
-	pgoff_t idx0 = page0 ? page0->index : -1;
-	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
-	loff_t end = ntfs_up_cluster(sbi, vbo + bytes);
-	pgoff_t idx = vbo_clst >> PAGE_SHIFT;
-	u32 from = vbo_clst & (PAGE_SIZE - 1);
-	pgoff_t idx_end = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	loff_t page_off;
-	u32 to;
-	bool partial;
-	struct page *page;
-
-	for (; idx < idx_end; idx += 1, from = 0) {
-		page = idx == idx0 ? page0 : grab_cache_page(mapping, idx);
-
-		if (!page)
-			continue;
-
-		page_off = (loff_t)idx << PAGE_SHIFT;
-		to = (page_off + PAGE_SIZE) > end ? (end - page_off)
-						  : PAGE_SIZE;
-		partial = false;
-
-		if ((from || PAGE_SIZE != to) &&
-		    likely(!page_has_buffers(page))) {
-			create_empty_buffers(page, blocksize, 0);
-		}
-
-		if (page_has_buffers(page)) {
-			struct buffer_head *head, *bh;
-			u32 bh_off = 0;
-
-			bh = head = page_buffers(page);
-			do {
-				u32 bh_next = bh_off + blocksize;
-
-				if (from <= bh_off && bh_next <= to) {
-					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
-				} else if (!buffer_uptodate(bh)) {
-					partial = true;
-				}
-				bh_off = bh_next;
-			} while (head != (bh = bh->b_this_page));
-		}
-
-		zero_user_segment(page, from, to);
-
-		if (!partial) {
-			if (!PageUptodate(page))
-				SetPageUptodate(page);
-			set_page_dirty(page);
-		}
-
-		if (idx != idx0) {
-			unlock_page(page);
-			put_page(page);
-		}
-		cond_resched();
-	}
-	mark_inode_dirty(inode);
-}
-
 /*
  * ntfs_file_mmap - file_operations::mmap
  */
@@ -385,13 +310,9 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 			for (; vcn < end; vcn += len) {
 				err = attr_data_get_block(ni, vcn, 1, &lcn,
-							  &len, &new);
+							  &len, &new, true);
 				if (err)
 					goto out;
-
-				if (!new)
-					continue;
-				ntfs_sparse_cluster(inode, NULL, vcn, 1);
 			}
 		}
 
@@ -532,7 +453,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	loff_t end = vbo + len;
-	loff_t vbo_down = round_down(vbo, PAGE_SIZE);
+	loff_t vbo_down = round_down(vbo, max_t(unsigned long,
+						sbi->cluster_size, PAGE_SIZE));
 	bool is_supported_holes = is_sparsed(ni) || is_compressed(ni);
 	loff_t i_size, new_size;
 	bool map_locked;
@@ -585,11 +507,8 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		u32 frame_size;
 		loff_t mask, vbo_a, end_a, tmp;
 
-		err = filemap_write_and_wait_range(mapping, vbo, end - 1);
-		if (err)
-			goto out;
-
-		err = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
+		err = filemap_write_and_wait_range(mapping, vbo_down,
+						   LLONG_MAX);
 		if (err)
 			goto out;
 
@@ -692,39 +611,35 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			goto out;
 
 		if (is_supported_holes) {
-			CLST vcn_v = ni->i_valid >> sbi->cluster_bits;
 			CLST vcn = vbo >> sbi->cluster_bits;
 			CLST cend = bytes_to_cluster(sbi, end);
+			CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
 			CLST lcn, clen;
 			bool new;
 
+			if (cend_v > cend)
+				cend_v = cend;
+
 			/*
-			 * Allocate but do not zero new clusters. (see below comments)
-			 * This breaks security: One can read unused on-disk areas.
+			 * Allocate and zero new clusters.
 			 * Zeroing these clusters may be too long.
-			 * Maybe we should check here for root rights?
+			 */
+			for (; vcn < cend_v; vcn += clen) {
+				err = attr_data_get_block(ni, vcn, cend_v - vcn,
+							  &lcn, &clen, &new,
+							  true);
+				if (err)
+					goto out;
+			}
+			/*
+			 * Allocate but not zero new clusters.
 			 */
 			for (; vcn < cend; vcn += clen) {
 				err = attr_data_get_block(ni, vcn, cend - vcn,
-							  &lcn, &clen, &new);
+							  &lcn, &clen, &new,
+							  false);
 				if (err)
 					goto out;
-				if (!new || vcn >= vcn_v)
-					continue;
-
-				/*
-				 * Unwritten area.
-				 * NTFS is not able to store several unwritten areas.
-				 * Activate 'ntfs_sparse_cluster' to zero new allocated clusters.
-				 *
-				 * Dangerous in case:
-				 * 1G of sparsed clusters + 1 cluster of data =>
-				 * valid_size == 1G + 1 cluster
-				 * fallocate(1G) will zero 1G and this can be very long
-				 * xfstest 016/086 will fail without 'ntfs_sparse_cluster'.
-				 */
-				ntfs_sparse_cluster(inode, NULL, vcn,
-						    min(vcn_v - vcn, clen));
 			}
 		}
 
@@ -945,8 +860,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 		frame_vbo = valid & ~(frame_size - 1);
 		off = valid & (frame_size - 1);
 
-		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 0, &lcn,
-					  &clen, NULL);
+		err = attr_data_get_block(ni, frame << NTFS_LZNT_CUNIT, 1, &lcn,
+					  &clen, NULL, false);
 		if (err)
 			goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d41ddc06f207..fb572688f919 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2297,7 +2297,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 
 		for (vcn = vbo >> sbi->cluster_bits; vcn < end; vcn += clen) {
 			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
-						  &clen, &new);
+						  &clen, &new, false);
 			if (err)
 				goto out;
 		}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2589f6d1215f..2dfe74a3de75 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1442,8 +1442,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	run_init(&run);
 
-	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
-				     NULL);
+	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, ALLOCATE_DEF,
+				     &alen, 0, NULL, NULL);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 057aa3cec902..5baf6a2b3d48 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -592,7 +592,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	off = vbo & sbi->cluster_mask;
 	new = false;
 
-	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL);
+	err = attr_data_get_block(ni, vcn, 1, &lcn, &len, create ? &new : NULL,
+				  create && sbi->cluster_size > PAGE_SIZE);
 	if (err)
 		goto out;
 
@@ -610,11 +611,8 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 		WARN_ON(1);
 	}
 
-	if (new) {
+	if (new)
 		set_buffer_new(bh);
-		if ((len << cluster_bits) > block_size)
-			ntfs_sparse_cluster(inode, page, vcn, len);
-	}
 
 	lbo = ((u64)lcn << cluster_bits) + off;
 
@@ -1533,8 +1531,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 				cpu_to_le64(ntfs_up_cluster(sbi, nsize));
 
 			err = attr_allocate_clusters(sbi, &ni->file.run, 0, 0,
-						     clst, NULL, 0, &alen, 0,
-						     NULL);
+						     clst, NULL, ALLOCATE_DEF,
+						     &alen, 0, NULL, NULL);
 			if (err)
 				goto out5;
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 26dbe1b46fdd..f2f32e304b3d 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -42,9 +42,11 @@ enum utf16_endian;
 #define MINUS_ONE_T			((size_t)(-1))
 /* Biggest MFT / smallest cluster */
 #define MAXIMUM_BYTES_PER_MFT		4096
+#define MAXIMUM_SHIFT_BYTES_PER_MFT	12
 #define NTFS_BLOCKS_PER_MFT_RECORD	(MAXIMUM_BYTES_PER_MFT / 512)
 
 #define MAXIMUM_BYTES_PER_INDEX		4096
+#define MAXIMUM_SHIFT_BYTES_PER_INDEX	12
 #define NTFS_BLOCKS_PER_INODE		(MAXIMUM_BYTES_PER_INDEX / 512)
 
 /* NTFS specific error code when fixup failed. */
@@ -126,6 +128,7 @@ struct ntfs_buffers {
 enum ALLOCATE_OPT {
 	ALLOCATE_DEF = 0, // Allocate all clusters.
 	ALLOCATE_MFT = 1, // Allocate for MFT.
+	ALLOCATE_ZERO = 2, // Zeroout new allocated clusters
 };
 
 enum bitmap_mutex_classes {
@@ -416,7 +419,7 @@ enum REPARSE_SIGN {
 int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
 			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
 			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
-			   CLST *new_lcn);
+			   CLST *new_lcn, CLST *new_len);
 int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 			  struct ATTR_LIST_ENTRY *le, struct mft_inode *mi,
 			  u64 new_size, struct runs_tree *run,
@@ -426,7 +429,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
 		  struct ATTRIB **ret);
 int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
-			CLST *len, bool *new);
+			CLST *len, bool *new, bool zero);
 int attr_data_read_resident(struct ntfs_inode *ni, struct page *page);
 int attr_data_write_resident(struct ntfs_inode *ni, struct page *page);
 int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
@@ -491,8 +494,6 @@ extern const struct file_operations ntfs_dir_operations;
 /* Globals from file.c */
 int ntfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
-void ntfs_sparse_cluster(struct inode *inode, struct page *page0, CLST vcn,
-			 CLST len);
 int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		  struct iattr *attr);
 int ntfs_file_open(struct inode *inode, struct file *file);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index eee54214f4a3..674a16c0c66b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -680,7 +680,7 @@ static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
  * ntfs_init_from_boot - Init internal info from on-disk boot sector.
  */
 static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
-			       u64 dev_size)
+		  u64 dev_size)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	int err;
@@ -705,12 +705,12 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* 0x55AA is not mandaroty. Thanks Maxim Suhanov*/
 	/*if (0x55 != boot->boot_magic[0] || 0xAA != boot->boot_magic[1])
-	 *	goto out;
+	 *  goto out;
 	 */
 
 	boot_sector_size = (u32)boot->bytes_per_sector[1] << 8;
 	if (boot->bytes_per_sector[0] || boot_sector_size < SECTOR_SIZE ||
-	    !is_power_of_2(boot_sector_size)) {
+		!is_power_of_2(boot_sector_size)) {
 		goto out;
 	}
 
@@ -733,15 +733,49 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	/* Check MFT record size. */
 	if ((boot->record_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->record_size))) ||
-	    (boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+		 SECTOR_SIZE > (2U << (-boot->record_size))) ||
+		(boot->record_size >= 0 && !is_power_of_2(boot->record_size))) {
+		goto out;
+	}
+
+	/* Calculate cluster size */
+	sbi->cluster_size = boot_sector_size * sct_per_clst;
+	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
+
+	if (boot->record_size >= 0) {
+		record_size = (u32)boot->record_size << sbi->cluster_bits;
+	} else if (-boot->record_size <= MAXIMUM_SHIFT_BYTES_PER_MFT) {
+		record_size = 1u << (-boot->record_size);
+	} else {
+		ntfs_err(sb, "%s: invalid record size %d.", "NTFS",
+			 boot->record_size);
+		goto out;
+	}
+
+	sbi->record_size = record_size;
+	sbi->record_bits = blksize_bits(record_size);
+	sbi->attr_size_tr = (5 * record_size >> 4); // ~320 bytes
+
+	if (record_size > MAXIMUM_BYTES_PER_MFT) {
+		ntfs_err(sb, "Unsupported bytes per MFT record %u.",
+			 record_size);
+		goto out;
+	}
+
+	if (boot->index_size >= 0) {
+		sbi->index_size = (u32)boot->index_size << sbi->cluster_bits;
+	} else if (-boot->index_size <= MAXIMUM_SHIFT_BYTES_PER_INDEX) {
+		sbi->index_size = 1u << (-boot->index_size);
+	} else {
+		ntfs_err(sb, "%s: invalid index size %d.", "NTFS",
+			 boot->index_size);
 		goto out;
 	}
 
 	/* Check index record size. */
 	if ((boot->index_size < 0 &&
-	     SECTOR_SIZE > (2U << (-boot->index_size))) ||
-	    (boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
+		 SECTOR_SIZE > (2U << (-boot->index_size))) ||
+		(boot->index_size >= 0 && !is_power_of_2(boot->index_size))) {
 		goto out;
 	}
 
@@ -762,9 +796,6 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		dev_size += sector_size - 1;
 	}
 
-	sbi->cluster_size = boot_sector_size * sct_per_clst;
-	sbi->cluster_bits = blksize_bits(sbi->cluster_size);
-
 	sbi->mft.lbo = mlcn << sbi->cluster_bits;
 	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
 
@@ -785,9 +816,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sbi->cluster_mask = sbi->cluster_size - 1;
 	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
 	sbi->record_size = record_size = boot->record_size < 0
-						 ? 1 << (-boot->record_size)
-						 : (u32)boot->record_size
-							   << sbi->cluster_bits;
+		? 1 << (-boot->record_size)
+		: (u32)boot->record_size
+		  << sbi->cluster_bits;
 
 	if (record_size > MAXIMUM_BYTES_PER_MFT || record_size < SECTOR_SIZE)
 		goto out;
@@ -801,8 +832,8 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		ALIGN(sizeof(enum ATTR_TYPE), 8);
 
 	sbi->index_size = boot->index_size < 0
-				  ? 1u << (-boot->index_size)
-				  : (u32)boot->index_size << sbi->cluster_bits;
+		? 1u << (-boot->index_size)
+		: (u32)boot->index_size << sbi->cluster_bits;
 
 	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
 
@@ -871,13 +902,6 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 	sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
 #endif
 
-	/*
-	 * Compute the MFT zone at two steps.
-	 * It would be nice if we are able to allocate 1/8 of
-	 * total clusters for MFT but not more then 512 MB.
-	 */
-	sbi->zone_max = min_t(CLST, 0x20000000 >> sbi->cluster_bits, clusters >> 3);
-
 	err = 0;
 
 out:
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ecc45389ea79..82e4a8805bae 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2633,10 +2633,11 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 	}
 
 	task_lock(p);
-	if (slack_ns == 0)
-		p->timer_slack_ns = p->default_timer_slack_ns;
-	else
-		p->timer_slack_ns = slack_ns;
+	if (task_is_realtime(p))
+		slack_ns = 0;
+	else if (slack_ns == 0)
+		slack_ns = p->default_timer_slack_ns;
+	p->timer_slack_ns = slack_ns;
 	task_unlock(p);
 
 out:
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 587b91d9d998..b721bb88b4a6 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -558,10 +558,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static inline void pde_set_flags(struct proc_dir_entry *pde)
+static void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (pde->proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (pde->proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
@@ -625,6 +631,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -655,6 +662,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..025490480be1 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -679,13 +679,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_read_iter(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl) {
-			if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_compat_ioctl(de)) {
+			if (pde_has_proc_read_iter(de))
 				inode->i_fop = &proc_iter_file_ops_compat;
 			else
 				inode->i_fop = &proc_reg_file_ops_compat;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 6b921826d85b..d115d22c01d4 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -84,6 +84,20 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_iter;
+}
+
+static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
+{
+#ifdef CONFIG_COMPAT
+	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
+#else
+	return false;
+#endif
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/fs/select.c b/fs/select.c
index 3f730b8581f6..e66b6189845e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -77,19 +77,16 @@ u64 select_estimate_accuracy(struct timespec64 *tv)
 {
 	u64 ret;
 	struct timespec64 now;
+	u64 slack = current->timer_slack_ns;
 
-	/*
-	 * Realtime tasks get a slack of 0 for obvious reasons.
-	 */
-
-	if (rt_task(current))
+	if (slack == 0)
 		return 0;
 
 	ktime_get_ts64(&now);
 	now = timespec64_sub(*tv, now);
 	ret = __estimate_accuracy(&now);
-	if (ret < current->timer_slack_ns)
-		return current->timer_slack_ns;
+	if (ret < slack)
+		return slack;
 	return ret;
 }
 
diff --git a/fs/smb/client/asn1.c b/fs/smb/client/asn1.c
index b5724ef9f182..214a44509e7b 100644
--- a/fs/smb/client/asn1.c
+++ b/fs/smb/client/asn1.c
@@ -52,6 +52,8 @@ int cifs_neg_token_init_mech_type(void *context, size_t hdrlen,
 		server->sec_kerberos = true;
 	else if (oid == OID_ntlmssp)
 		server->sec_ntlmssp = true;
+	else if (oid == OID_IAKerb)
+		server->sec_iakerb = true;
 	else {
 		char buf[50];
 
diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 1e6819daaaa7..8b58f494235f 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -130,11 +130,13 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 
 	dp = description + strlen(description);
 
-	/* for now, only sec=krb5 and sec=mskrb5 are valid */
+	/* for now, only sec=krb5 and sec=mskrb5 and iakerb are valid */
 	if (server->sec_kerberos)
 		sprintf(dp, ";sec=krb5");
 	else if (server->sec_mskerberos)
 		sprintf(dp, ";sec=mskrb5");
+	else if (server->sec_iakerb)
+		sprintf(dp, ";sec=iakerb");
 	else {
 		cifs_dbg(VFS, "unknown or missing server auth type, use krb5\n");
 		sprintf(dp, ";sec=krb5");
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 71e519bf65e2..17fce0afb297 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -148,6 +148,7 @@ enum securityEnum {
 	NTLMv2,			/* Legacy NTLM auth with NTLMv2 hash */
 	RawNTLMSSP,		/* NTLMSSP without SPNEGO, NTLMv2 hash */
 	Kerberos,		/* Kerberos via SPNEGO */
+	IAKerb,			/* Kerberos proxy */
 };
 
 struct session_key {
@@ -685,6 +686,7 @@ struct TCP_Server_Info {
 	bool	sec_kerberosu2u;	/* supports U2U Kerberos */
 	bool	sec_kerberos;		/* supports plain Kerberos */
 	bool	sec_mskerberos;		/* supports legacy MS Kerberos */
+	bool	sec_iakerb;		/* supports pass-through auth for Kerberos (krb5 proxy) */
 	bool	large_buf;		/* is current buffer large? */
 	/* use SMBD connection instead of socket */
 	bool	rdma;
@@ -2049,6 +2051,8 @@ static inline char *get_security_type_str(enum securityEnum sectype)
 		return "Kerberos";
 	case NTLMv2:
 		return "NTLMv2";
+	case IAKerb:
+		return "IAKerb";
 	default:
 		return "Unknown";
 	}
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index db30c4b8a221..01ce81f77e89 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1881,9 +1881,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 /* this function must be called with ses_lock and chan_lock held */
 static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 {
-	if (ctx->sectype != Unspecified &&
-	    ctx->sectype != ses->sectype)
-		return 0;
+	struct TCP_Server_Info *server = ses->server;
+	enum securityEnum ctx_sec, ses_sec;
 
 	/*
 	 * If an existing session is limited to less channels than
@@ -1892,11 +1891,20 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	if (ses->chan_max < ctx->max_channels)
 		return 0;
 
-	switch (ses->sectype) {
+	ctx_sec = server->ops->select_sectype(server, ctx->sectype);
+	ses_sec = server->ops->select_sectype(server, ses->sectype);
+
+	if (ctx_sec != ses_sec)
+		return 0;
+
+	switch (ctx_sec) {
+	case IAKerb:
 	case Kerberos:
 		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
 			return 0;
 		break;
+	case NTLMv2:
+	case RawNTLMSSP:
 	default:
 		/* NULL username means anonymous session */
 		if (ses->user_name == NULL) {
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index ca39d01077cd..de2366d05767 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1078,21 +1078,21 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->got_wsize = true;
 		break;
 	case Opt_acregmax:
-		ctx->acregmax = HZ * result.uint_32;
-		if (ctx->acregmax > CIFS_MAX_ACTIMEO) {
+		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
 			cifs_errorf(fc, "acregmax too large\n");
 			goto cifs_parse_mount_err;
 		}
+		ctx->acregmax = HZ * result.uint_32;
 		break;
 	case Opt_acdirmax:
-		ctx->acdirmax = HZ * result.uint_32;
-		if (ctx->acdirmax > CIFS_MAX_ACTIMEO) {
+		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
 			cifs_errorf(fc, "acdirmax too large\n");
 			goto cifs_parse_mount_err;
 		}
+		ctx->acdirmax = HZ * result.uint_32;
 		break;
 	case Opt_actimeo:
-		if (HZ * result.uint_32 > CIFS_MAX_ACTIMEO) {
+		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
 			cifs_errorf(fc, "timeout too large\n");
 			goto cifs_parse_mount_err;
 		}
@@ -1104,11 +1104,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->acdirmax = ctx->acregmax = HZ * result.uint_32;
 		break;
 	case Opt_closetimeo:
-		ctx->closetimeo = HZ * result.uint_32;
-		if (ctx->closetimeo > SMB3_MAX_DCLOSETIMEO) {
+		if (result.uint_32 > SMB3_MAX_DCLOSETIMEO / HZ) {
 			cifs_errorf(fc, "closetimeo too large\n");
 			goto cifs_parse_mount_err;
 		}
+		ctx->closetimeo = HZ * result.uint_32;
 		break;
 	case Opt_echo_interval:
 		ctx->echo_interval = result.uint_32;
diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index ae9905e2b9d4..7402070b7a06 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -246,7 +246,9 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each_entry(server_it, &cifs_tcp_ses_list, tcp_ses_list) {
 			list_for_each_entry(ses_it, &server_it->smb_ses_list, smb_ses_list) {
-				if (ses_it->Suid == out.session_id) {
+				spin_lock(&ses_it->ses_lock);
+				if (ses_it->ses_status != SES_EXITING &&
+				    ses_it->Suid == out.session_id) {
 					ses = ses_it;
 					/*
 					 * since we are using the session outside the crit
@@ -254,9 +256,11 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 					 * so increment its refcount
 					 */
 					ses->ses_count++;
+					spin_unlock(&ses_it->ses_lock);
 					found = true;
 					goto search_end;
 				}
+				spin_unlock(&ses_it->ses_lock);
 			}
 		}
 search_end:
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index b8e14bcd2c68..c8f7ae0a2006 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -1209,12 +1209,13 @@ cifs_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested)
 		switch (requested) {
 		case Kerberos:
 		case RawNTLMSSP:
+		case IAKerb:
 			return requested;
 		case Unspecified:
 			if (server->sec_ntlmssp &&
 			    (global_secflags & CIFSSEC_MAY_NTLMSSP))
 				return RawNTLMSSP;
-			if ((server->sec_kerberos || server->sec_mskerberos) &&
+			if ((server->sec_kerberos || server->sec_mskerberos || server->sec_iakerb) &&
 			    (global_secflags & CIFSSEC_MAY_KRB5))
 				return Kerberos;
 			fallthrough;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 217d381eb9fe..96faa22b9cb6 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1270,7 +1270,7 @@ smb2_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested)
 		if (server->sec_ntlmssp &&
 			(global_secflags & CIFSSEC_MAY_NTLMSSP))
 			return RawNTLMSSP;
-		if ((server->sec_kerberos || server->sec_mskerberos) &&
+		if ((server->sec_kerberos || server->sec_mskerberos || server->sec_iakerb) &&
 			(global_secflags & CIFSSEC_MAY_KRB5))
 			return Kerberos;
 		fallthrough;
@@ -1999,7 +1999,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 
 tcon_error_exit:
 	if (rsp && rsp->hdr.Status == STATUS_BAD_NETWORK_NAME)
-		cifs_tcon_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
+		cifs_dbg(VFS | ONCE, "BAD_NETWORK_NAME: %s\n", tree);
 	goto tcon_exit;
 }
 
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 6fd3560028d3..3adab8e10a21 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -398,7 +398,9 @@ static void parse_dacl(struct user_namespace *user_ns,
 	if (num_aces <= 0)
 		return;
 
-	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
+	if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
+			(offsetof(struct smb_ace, sid) +
+			 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
 		return;
 
 	ret = init_acl_state(&acl_state, num_aces);
@@ -432,6 +434,7 @@ static void parse_dacl(struct user_namespace *user_ns,
 			offsetof(struct smb_sid, sub_auth);
 
 		if (end_of_acl - acl_base < acl_size ||
+		    ppace[i]->sid.num_subauth == 0 ||
 		    ppace[i]->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
 		    (end_of_acl - acl_base <
 		     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth) ||
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 74952e58cca0..48f33d4994dc 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index bf47efe08a58..9743fa5b5388 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -259,6 +259,30 @@ xfs_agino_range(
 	return __xfs_agino_range(mp, xfs_ag_block_count(mp, agno), first, last);
 }
 
+/*
+ * Free perag within the specified AG range, it is only used to free unused
+ * perags under the error handling path.
+ */
+void
+xfs_free_unused_perag_range(
+	struct xfs_mount	*mp,
+	xfs_agnumber_t		agstart,
+	xfs_agnumber_t		agend)
+{
+	struct xfs_perag	*pag;
+	xfs_agnumber_t		index;
+
+	for (index = agstart; index < agend; index++) {
+		spin_lock(&mp->m_perag_lock);
+		pag = radix_tree_delete(&mp->m_perag_tree, index);
+		spin_unlock(&mp->m_perag_lock);
+		if (!pag)
+			break;
+		xfs_buf_hash_destroy(pag);
+		kmem_free(pag);
+	}
+}
+
 int
 xfs_initialize_perag(
 	struct xfs_mount	*mp,
@@ -345,18 +369,14 @@ xfs_initialize_perag(
 	return 0;
 
 out_remove_pag:
+	spin_lock(&mp->m_perag_lock);
 	radix_tree_delete(&mp->m_perag_tree, index);
+	spin_unlock(&mp->m_perag_lock);
 out_free_pag:
 	kmem_free(pag);
 out_unwind_new_pags:
 	/* unwind any prior newly initialized pags */
-	for (index = first_initialised; index < agcount; index++) {
-		pag = radix_tree_delete(&mp->m_perag_tree, index);
-		if (!pag)
-			break;
-		xfs_buf_hash_destroy(pag);
-		kmem_free(pag);
-	}
+	xfs_free_unused_perag_range(mp, first_initialised, agcount);
 	return error;
 }
 
@@ -906,7 +926,10 @@ xfs_ag_shrink_space(
 		if (err2 != -ENOSPC)
 			goto resv_err;
 
-		__xfs_free_extent_later(*tpp, args.fsbno, delta, NULL, true);
+		err2 = __xfs_free_extent_later(*tpp, args.fsbno, delta, NULL,
+				XFS_AG_RESV_NONE, true);
+		if (err2)
+			goto resv_err;
 
 		/*
 		 * Roll the transaction before trying to re-init the per-ag
@@ -981,10 +1004,8 @@ xfs_ag_extend_space(
 	if (error)
 		return error;
 
-	error = xfs_free_extent(tp, XFS_AGB_TO_FSB(pag->pag_mount, pag->pag_agno,
-					be32_to_cpu(agf->agf_length) - len),
-				len, &XFS_RMAP_OINFO_SKIP_UPDATE,
-				XFS_AG_RESV_NONE);
+	error = xfs_free_extent(tp, pag, be32_to_cpu(agf->agf_length) - len,
+			len, &XFS_RMAP_OINFO_SKIP_UPDATE, XFS_AG_RESV_NONE);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ag.h b/fs/xfs/libxfs/xfs_ag.h
index 191b22b9a35b..eb84af1c8628 100644
--- a/fs/xfs/libxfs/xfs_ag.h
+++ b/fs/xfs/libxfs/xfs_ag.h
@@ -106,6 +106,9 @@ struct xfs_perag {
 #endif /* __KERNEL__ */
 };
 
+
+void xfs_free_unused_perag_range(struct xfs_mount *mp, xfs_agnumber_t agstart,
+			xfs_agnumber_t agend);
 int xfs_initialize_perag(struct xfs_mount *mp, xfs_agnumber_t agcount,
 			xfs_rfsblock_t dcount, xfs_agnumber_t *maxagi);
 int xfs_initialize_perag_data(struct xfs_mount *mp, xfs_agnumber_t agno);
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 74d039bdc9f7..c08265f19136 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2485,45 +2485,53 @@ xfs_agfl_reset(
  * the real allocation can proceed. Deferring the free disconnects freeing up
  * the AGFL slot from freeing the block.
  */
-STATIC void
+static int
 xfs_defer_agfl_block(
 	struct xfs_trans		*tp,
 	xfs_agnumber_t			agno,
-	xfs_fsblock_t			agbno,
+	xfs_agblock_t			agbno,
 	struct xfs_owner_info		*oinfo)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
-	struct xfs_extent_free_item	*new;		/* new element */
+	struct xfs_extent_free_item	*xefi;
+	xfs_fsblock_t			fsbno = XFS_AGB_TO_FSB(mp, agno, agbno);
 
 	ASSERT(xfs_extfree_item_cache != NULL);
 	ASSERT(oinfo != NULL);
 
-	new = kmem_cache_zalloc(xfs_extfree_item_cache,
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbno(mp, fsbno)))
+		return -EFSCORRUPTED;
+
+	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
-	new->xefi_startblock = XFS_AGB_TO_FSB(mp, agno, agbno);
-	new->xefi_blockcount = 1;
-	new->xefi_owner = oinfo->oi_owner;
+	xefi->xefi_startblock = fsbno;
+	xefi->xefi_blockcount = 1;
+	xefi->xefi_owner = oinfo->oi_owner;
+	xefi->xefi_agresv = XFS_AG_RESV_AGFL;
 
 	trace_xfs_agfl_free_defer(mp, agno, 0, agbno, 1);
 
-	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &new->xefi_list);
+	xfs_extent_free_get_group(mp, xefi);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_AGFL_FREE, &xefi->xefi_list);
+	return 0;
 }
 
 /*
  * Add the extent to the list of extents to be free at transaction end.
  * The list is maintained sorted (by block number).
  */
-void
+int
 __xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
 	const struct xfs_owner_info	*oinfo,
+	enum xfs_ag_resv_type		type,
 	bool				skip_discard)
 {
-	struct xfs_extent_free_item	*new;		/* new element */
-#ifdef DEBUG
+	struct xfs_extent_free_item	*xefi;
 	struct xfs_mount		*mp = tp->t_mountp;
+#ifdef DEBUG
 	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 
@@ -2539,28 +2547,36 @@ __xfs_free_extent_later(
 	ASSERT(agbno + len <= mp->m_sb.sb_agblocks);
 #endif
 	ASSERT(xfs_extfree_item_cache != NULL);
+	ASSERT(type != XFS_AG_RESV_AGFL);
+
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
+		return -EFSCORRUPTED;
 
-	new = kmem_cache_zalloc(xfs_extfree_item_cache,
+	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
 			       GFP_KERNEL | __GFP_NOFAIL);
-	new->xefi_startblock = bno;
-	new->xefi_blockcount = (xfs_extlen_t)len;
+	xefi->xefi_startblock = bno;
+	xefi->xefi_blockcount = (xfs_extlen_t)len;
+	xefi->xefi_agresv = type;
 	if (skip_discard)
-		new->xefi_flags |= XFS_EFI_SKIP_DISCARD;
+		xefi->xefi_flags |= XFS_EFI_SKIP_DISCARD;
 	if (oinfo) {
 		ASSERT(oinfo->oi_offset == 0);
 
 		if (oinfo->oi_flags & XFS_OWNER_INFO_ATTR_FORK)
-			new->xefi_flags |= XFS_EFI_ATTR_FORK;
+			xefi->xefi_flags |= XFS_EFI_ATTR_FORK;
 		if (oinfo->oi_flags & XFS_OWNER_INFO_BMBT_BLOCK)
-			new->xefi_flags |= XFS_EFI_BMBT_BLOCK;
-		new->xefi_owner = oinfo->oi_owner;
+			xefi->xefi_flags |= XFS_EFI_BMBT_BLOCK;
+		xefi->xefi_owner = oinfo->oi_owner;
 	} else {
-		new->xefi_owner = XFS_RMAP_OWN_NULL;
+		xefi->xefi_owner = XFS_RMAP_OWN_NULL;
 	}
-	trace_xfs_bmap_free_defer(tp->t_mountp,
+	trace_xfs_bmap_free_defer(mp,
 			XFS_FSB_TO_AGNO(tp->t_mountp, bno), 0,
 			XFS_FSB_TO_AGBNO(tp->t_mountp, bno), len);
-	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &new->xefi_list);
+
+	xfs_extent_free_get_group(mp, xefi);
+	xfs_defer_add(tp, XFS_DEFER_OPS_TYPE_FREE, &xefi->xefi_list);
+	return 0;
 }
 
 #ifdef DEBUG
@@ -2720,7 +2736,9 @@ xfs_alloc_fix_freelist(
 			goto out_agbp_relse;
 
 		/* defer agfl frees */
-		xfs_defer_agfl_block(tp, args->agno, bno, &targs.oinfo);
+		error = xfs_defer_agfl_block(tp, args->agno, bno, &targs.oinfo);
+		if (error)
+			goto out_agbp_relse;
 	}
 
 	targs.tp = tp;
@@ -3447,7 +3465,8 @@ xfs_free_extent_fix_freelist(
 int
 __xfs_free_extent(
 	struct xfs_trans		*tp,
-	xfs_fsblock_t			bno,
+	struct xfs_perag		*pag,
+	xfs_agblock_t			agbno,
 	xfs_extlen_t			len,
 	const struct xfs_owner_info	*oinfo,
 	enum xfs_ag_resv_type		type,
@@ -3455,12 +3474,9 @@ __xfs_free_extent(
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_buf			*agbp;
-	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp, bno);
-	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp, bno);
 	struct xfs_agf			*agf;
 	int				error;
 	unsigned int			busy_flags = 0;
-	struct xfs_perag		*pag;
 
 	ASSERT(len != 0);
 	ASSERT(type != XFS_AG_RESV_AGFL);
@@ -3469,10 +3485,9 @@ __xfs_free_extent(
 			XFS_ERRTAG_FREE_EXTENT))
 		return -EIO;
 
-	pag = xfs_perag_get(mp, agno);
 	error = xfs_free_extent_fix_freelist(tp, pag, &agbp);
 	if (error)
-		goto err;
+		return error;
 	agf = agbp->b_addr;
 
 	if (XFS_IS_CORRUPT(mp, agbno >= mp->m_sb.sb_agblocks)) {
@@ -3486,20 +3501,18 @@ __xfs_free_extent(
 		goto err_release;
 	}
 
-	error = xfs_free_ag_extent(tp, agbp, agno, agbno, len, oinfo, type);
+	error = xfs_free_ag_extent(tp, agbp, pag->pag_agno, agbno, len, oinfo,
+			type);
 	if (error)
 		goto err_release;
 
 	if (skip_discard)
 		busy_flags |= XFS_EXTENT_BUSY_SKIP_DISCARD;
 	xfs_extent_busy_insert(tp, pag, agbno, len, busy_flags);
-	xfs_perag_put(pag);
 	return 0;
 
 err_release:
 	xfs_trans_brelse(tp, agbp);
-err:
-	xfs_perag_put(pag);
 	return error;
 }
 
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index 2c3f762dfb58..2dd93d62150f 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -130,7 +130,8 @@ xfs_alloc_vextent(
 int				/* error */
 __xfs_free_extent(
 	struct xfs_trans	*tp,	/* transaction pointer */
-	xfs_fsblock_t		bno,	/* starting block number of extent */
+	struct xfs_perag	*pag,
+	xfs_agblock_t		agbno,
 	xfs_extlen_t		len,	/* length of extent */
 	const struct xfs_owner_info	*oinfo,	/* extent owner */
 	enum xfs_ag_resv_type	type,	/* block reservation type */
@@ -139,12 +140,13 @@ __xfs_free_extent(
 static inline int
 xfs_free_extent(
 	struct xfs_trans	*tp,
-	xfs_fsblock_t		bno,
+	struct xfs_perag	*pag,
+	xfs_agblock_t		agbno,
 	xfs_extlen_t		len,
 	const struct xfs_owner_info	*oinfo,
 	enum xfs_ag_resv_type	type)
 {
-	return __xfs_free_extent(tp, bno, len, oinfo, type, false);
+	return __xfs_free_extent(tp, pag, agbno, len, oinfo, type, false);
 }
 
 int				/* error */
@@ -211,9 +213,9 @@ xfs_buf_to_agfl_bno(
 	return bp->b_addr;
 }
 
-void __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
+int __xfs_free_extent_later(struct xfs_trans *tp, xfs_fsblock_t bno,
 		xfs_filblks_t len, const struct xfs_owner_info *oinfo,
-		bool skip_discard);
+		enum xfs_ag_resv_type type, bool skip_discard);
 
 /*
  * List of extents to be free "later".
@@ -224,21 +226,27 @@ struct xfs_extent_free_item {
 	uint64_t		xefi_owner;
 	xfs_fsblock_t		xefi_startblock;/* starting fs block number */
 	xfs_extlen_t		xefi_blockcount;/* number of blocks in extent */
+	struct xfs_perag	*xefi_pag;
 	unsigned int		xefi_flags;
+	enum xfs_ag_resv_type	xefi_agresv;
 };
 
+void xfs_extent_free_get_group(struct xfs_mount *mp,
+		struct xfs_extent_free_item *xefi);
+
 #define XFS_EFI_SKIP_DISCARD	(1U << 0) /* don't issue discard */
 #define XFS_EFI_ATTR_FORK	(1U << 1) /* freeing attr fork block */
 #define XFS_EFI_BMBT_BLOCK	(1U << 2) /* freeing bmap btree block */
 
-static inline void
+static inline int
 xfs_free_extent_later(
 	struct xfs_trans		*tp,
 	xfs_fsblock_t			bno,
 	xfs_filblks_t			len,
-	const struct xfs_owner_info	*oinfo)
+	const struct xfs_owner_info	*oinfo,
+	enum xfs_ag_resv_type		type)
 {
-	__xfs_free_extent_later(tp, bno, len, oinfo, false);
+	return __xfs_free_extent_later(tp, bno, len, oinfo, type, false);
 }
 
 
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index e28d93d232de..32d350e97e0f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -421,10 +421,10 @@ xfs_attr_complete_op(
 	bool			do_replace = args->op_flags & XFS_DA_OP_REPLACE;
 
 	args->op_flags &= ~XFS_DA_OP_REPLACE;
-	if (do_replace) {
-		args->attr_filter &= ~XFS_ATTR_INCOMPLETE;
+	args->attr_filter &= ~XFS_ATTR_INCOMPLETE;
+	if (do_replace)
 		return replace_state;
-	}
+
 	return XFS_DAS_DONE;
 }
 
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 27d3121e6da9..2a3b78032cb0 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -21,7 +21,7 @@
 #include "xfs_bmap.h"
 #include "xfs_bmap_util.h"
 #include "xfs_bmap_btree.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_quota.h"
@@ -572,8 +572,13 @@ xfs_bmap_btree_to_extents(
 	cblock = XFS_BUF_TO_BLOCK(cbp);
 	if ((error = xfs_btree_check_block(cur, cblock, 0, cbp)))
 		return error;
+
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, whichfork);
-	xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo);
+	error = xfs_free_extent_later(cur->bc_tp, cbno, 1, &oinfo,
+			XFS_AG_RESV_NONE);
+	if (error)
+		return error;
+
 	ip->i_nblocks--;
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, -1L);
 	xfs_trans_binval(tp, cbp);
@@ -4994,7 +4999,6 @@ xfs_bmap_del_extent_real(
 	xfs_fileoff_t		del_endoff;	/* first offset past del */
 	int			do_fx;	/* free extent at end of routine */
 	int			error;	/* error return value */
-	int			flags = 0;/* inode logging flags */
 	struct xfs_bmbt_irec	got;	/* current extent entry */
 	xfs_fileoff_t		got_endoff;	/* first offset past got */
 	int			i;	/* temp state */
@@ -5007,6 +5011,8 @@ xfs_bmap_del_extent_real(
 	uint32_t		state = xfs_bmap_fork_to_state(whichfork);
 	struct xfs_bmbt_irec	old;
 
+	*logflagsp = 0;
+
 	mp = ip->i_mount;
 	XFS_STATS_INC(mp, xs_del_exlist);
 
@@ -5019,7 +5025,6 @@ xfs_bmap_del_extent_real(
 	ASSERT(got_endoff >= del_endoff);
 	ASSERT(!isnullstartblock(got.br_startblock));
 	qfield = 0;
-	error = 0;
 
 	/*
 	 * If it's the case where the directory code is running with no block
@@ -5035,13 +5040,13 @@ xfs_bmap_del_extent_real(
 	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
 		return -ENOSPC;
 
-	flags = XFS_ILOG_CORE;
+	*logflagsp = XFS_ILOG_CORE;
 	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
 		if (!(bflags & XFS_BMAPI_REMAP)) {
 			error = xfs_rtfree_blocks(tp, del->br_startblock,
 					del->br_blockcount);
 			if (error)
-				goto done;
+				return error;
 		}
 
 		do_fx = 0;
@@ -5056,11 +5061,9 @@ xfs_bmap_del_extent_real(
 	if (cur) {
 		error = xfs_bmbt_lookup_eq(cur, &got, &i);
 		if (error)
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 	}
 
 	if (got.br_startoff == del->br_startoff)
@@ -5077,17 +5080,15 @@ xfs_bmap_del_extent_real(
 		xfs_iext_prev(ifp, icur);
 		ifp->if_nextents--;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		if ((error = xfs_btree_delete(cur, &i)))
-			goto done;
-		if (XFS_IS_CORRUPT(mp, i != 1)) {
-			error = -EFSCORRUPTED;
-			goto done;
-		}
+			return error;
+		if (XFS_IS_CORRUPT(mp, i != 1))
+			return -EFSCORRUPTED;
 		break;
 	case BMAP_LEFT_FILLING:
 		/*
@@ -5098,12 +5099,12 @@ xfs_bmap_del_extent_real(
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case BMAP_RIGHT_FILLING:
 		/*
@@ -5112,12 +5113,12 @@ xfs_bmap_del_extent_real(
 		got.br_blockcount -= del->br_blockcount;
 		xfs_iext_update_extent(ip, state, icur, &got);
 		if (!cur) {
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 			break;
 		}
 		error = xfs_bmbt_update(cur, &got);
 		if (error)
-			goto done;
+			return error;
 		break;
 	case 0:
 		/*
@@ -5134,18 +5135,18 @@ xfs_bmap_del_extent_real(
 		new.br_state = got.br_state;
 		new.br_startblock = del_endblock;
 
-		flags |= XFS_ILOG_CORE;
+		*logflagsp |= XFS_ILOG_CORE;
 		if (cur) {
 			error = xfs_bmbt_update(cur, &got);
 			if (error)
-				goto done;
+				return error;
 			error = xfs_btree_increment(cur, 0, &i);
 			if (error)
-				goto done;
+				return error;
 			cur->bc_rec.b = new;
 			error = xfs_btree_insert(cur, &i);
 			if (error && error != -ENOSPC)
-				goto done;
+				return error;
 			/*
 			 * If get no-space back from btree insert, it tried a
 			 * split, and we have a zero block reservation.  Fix up
@@ -5158,33 +5159,28 @@ xfs_bmap_del_extent_real(
 				 */
 				error = xfs_bmbt_lookup_eq(cur, &got, &i);
 				if (error)
-					goto done;
-				if (XFS_IS_CORRUPT(mp, i != 1)) {
-					error = -EFSCORRUPTED;
-					goto done;
-				}
+					return error;
+				if (XFS_IS_CORRUPT(mp, i != 1))
+					return -EFSCORRUPTED;
 				/*
 				 * Update the btree record back
 				 * to the original value.
 				 */
 				error = xfs_bmbt_update(cur, &old);
 				if (error)
-					goto done;
+					return error;
 				/*
 				 * Reset the extent record back
 				 * to the original value.
 				 */
 				xfs_iext_update_extent(ip, state, icur, &old);
-				flags = 0;
-				error = -ENOSPC;
-				goto done;
-			}
-			if (XFS_IS_CORRUPT(mp, i != 1)) {
-				error = -EFSCORRUPTED;
-				goto done;
+				*logflagsp = 0;
+				return -ENOSPC;
 			}
+			if (XFS_IS_CORRUPT(mp, i != 1))
+				return -EFSCORRUPTED;
 		} else
-			flags |= xfs_ilog_fext(whichfork);
+			*logflagsp |= xfs_ilog_fext(whichfork);
 
 		ifp->if_nextents++;
 		xfs_iext_next(ifp, icur);
@@ -5202,10 +5198,13 @@ xfs_bmap_del_extent_real(
 		if (xfs_is_reflink_inode(ip) && whichfork == XFS_DATA_FORK) {
 			xfs_refcount_decrease_extent(tp, del);
 		} else {
-			__xfs_free_extent_later(tp, del->br_startblock,
+			error = __xfs_free_extent_later(tp, del->br_startblock,
 					del->br_blockcount, NULL,
-					(bflags & XFS_BMAPI_NODISCARD) ||
-					del->br_state == XFS_EXT_UNWRITTEN);
+					XFS_AG_RESV_NONE,
+					((bflags & XFS_BMAPI_NODISCARD) ||
+					del->br_state == XFS_EXT_UNWRITTEN));
+			if (error)
+				return error;
 		}
 	}
 
@@ -5220,9 +5219,7 @@ xfs_bmap_del_extent_real(
 	if (qfield && !(bflags & XFS_BMAPI_REMAP))
 		xfs_trans_mod_dquot_byino(tp, ip, qfield, (long)-nblks);
 
-done:
-	*logflagsp = flags;
-	return error;
+	return 0;
 }
 
 /*
@@ -6119,39 +6116,37 @@ xfs_bmap_unmap_extent(
 int
 xfs_bmap_finish_one(
 	struct xfs_trans		*tp,
-	struct xfs_inode		*ip,
-	enum xfs_bmap_intent_type	type,
-	int				whichfork,
-	xfs_fileoff_t			startoff,
-	xfs_fsblock_t			startblock,
-	xfs_filblks_t			*blockcount,
-	xfs_exntst_t			state)
+	struct xfs_bmap_intent		*bi)
 {
+	struct xfs_bmbt_irec		*bmap = &bi->bi_bmap;
 	int				error = 0;
 
 	ASSERT(tp->t_firstblock == NULLFSBLOCK);
 
 	trace_xfs_bmap_deferred(tp->t_mountp,
-			XFS_FSB_TO_AGNO(tp->t_mountp, startblock), type,
-			XFS_FSB_TO_AGBNO(tp->t_mountp, startblock),
-			ip->i_ino, whichfork, startoff, *blockcount, state);
+			XFS_FSB_TO_AGNO(tp->t_mountp, bmap->br_startblock),
+			bi->bi_type,
+			XFS_FSB_TO_AGBNO(tp->t_mountp, bmap->br_startblock),
+			bi->bi_owner->i_ino, bi->bi_whichfork,
+			bmap->br_startoff, bmap->br_blockcount,
+			bmap->br_state);
 
-	if (WARN_ON_ONCE(whichfork != XFS_DATA_FORK))
+	if (WARN_ON_ONCE(bi->bi_whichfork != XFS_DATA_FORK))
 		return -EFSCORRUPTED;
 
 	if (XFS_TEST_ERROR(false, tp->t_mountp,
 			XFS_ERRTAG_BMAP_FINISH_ONE))
 		return -EIO;
 
-	switch (type) {
+	switch (bi->bi_type) {
 	case XFS_BMAP_MAP:
-		error = xfs_bmapi_remap(tp, ip, startoff, *blockcount,
-				startblock, 0);
-		*blockcount = 0;
+		error = xfs_bmapi_remap(tp, bi->bi_owner, bmap->br_startoff,
+				bmap->br_blockcount, bmap->br_startblock, 0);
+		bmap->br_blockcount = 0;
 		break;
 	case XFS_BMAP_UNMAP:
-		error = __xfs_bunmapi(tp, ip, startoff, blockcount,
-				XFS_BMAPI_REMAP, 1);
+		error = __xfs_bunmapi(tp, bi->bi_owner, bmap->br_startoff,
+				&bmap->br_blockcount, XFS_BMAPI_REMAP, 1);
 		break;
 	default:
 		ASSERT(0);
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 08c16e4edc0f..524912f276f8 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -236,10 +236,7 @@ struct xfs_bmap_intent {
 	struct xfs_bmbt_irec			bi_bmap;
 };
 
-int	xfs_bmap_finish_one(struct xfs_trans *tp, struct xfs_inode *ip,
-		enum xfs_bmap_intent_type type, int whichfork,
-		xfs_fileoff_t startoff, xfs_fsblock_t startblock,
-		xfs_filblks_t *blockcount, xfs_exntst_t state);
+int	xfs_bmap_finish_one(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 void	xfs_bmap_map_extent(struct xfs_trans *tp, struct xfs_inode *ip,
 		struct xfs_bmbt_irec *imap);
 void	xfs_bmap_unmap_extent(struct xfs_trans *tp, struct xfs_inode *ip,
diff --git a/fs/xfs/libxfs/xfs_bmap_btree.c b/fs/xfs/libxfs/xfs_bmap_btree.c
index 18de4fbfef4e..57f401f2492d 100644
--- a/fs/xfs/libxfs/xfs_bmap_btree.c
+++ b/fs/xfs/libxfs/xfs_bmap_btree.c
@@ -285,11 +285,15 @@ xfs_bmbt_free_block(
 	struct xfs_trans	*tp = cur->bc_tp;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 	struct xfs_owner_info	oinfo;
+	int			error;
 
 	xfs_rmap_ino_bmbt_owner(&oinfo, ip->i_ino, cur->bc_ino.whichfork);
-	xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo);
-	ip->i_nblocks--;
+	error = xfs_free_extent_later(cur->bc_tp, fsbno, 1, &oinfo,
+			XFS_AG_RESV_NONE);
+	if (error)
+		return error;
 
+	ip->i_nblocks--;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	xfs_trans_mod_dquot_byino(tp, ip, XFS_TRANS_DQ_BCOUNT, -1L);
 	return 0;
diff --git a/fs/xfs/libxfs/xfs_btree_staging.c b/fs/xfs/libxfs/xfs_btree_staging.c
index dd75e208b543..29e3f8ccb185 100644
--- a/fs/xfs/libxfs/xfs_btree_staging.c
+++ b/fs/xfs/libxfs/xfs_btree_staging.c
@@ -342,9 +342,7 @@ xfs_btree_bload_drop_buf(
 	if (*bpp == NULL)
 		return;
 
-	if (!xfs_buf_delwri_queue(*bpp, buffers_list))
-		ASSERT(0);
-
+	xfs_buf_delwri_queue_here(*bpp, buffers_list);
 	xfs_buf_relse(*bpp);
 	*bpp = NULL;
 }
diff --git a/fs/xfs/libxfs/xfs_btree_staging.h b/fs/xfs/libxfs/xfs_btree_staging.h
index f0d2976050ae..5f638f711246 100644
--- a/fs/xfs/libxfs/xfs_btree_staging.h
+++ b/fs/xfs/libxfs/xfs_btree_staging.h
@@ -37,12 +37,6 @@ struct xbtree_ifakeroot {
 
 	/* Number of bytes available for this fork in the inode. */
 	unsigned int		if_fork_size;
-
-	/* Fork format. */
-	unsigned int		if_format;
-
-	/* Number of records. */
-	unsigned int		if_extents;
 };
 
 /* Cursor interactions with fake roots for inode-rooted btrees. */
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..282c7cf032f4 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2316,10 +2316,17 @@ xfs_da3_swap_lastblock(
 		return error;
 	/*
 	 * Copy the last block into the dead buffer and log it.
+	 * On CRC-enabled file systems, also update the stamped in blkno.
 	 */
 	memcpy(dead_buf->b_addr, last_buf->b_addr, args->geo->blksize);
+	if (xfs_has_crc(mp)) {
+		struct xfs_da3_blkinfo *da3 = dead_buf->b_addr;
+
+		da3->blkno = cpu_to_be64(xfs_buf_daddr(dead_buf));
+	}
 	xfs_trans_log_buf(tp, dead_buf, 0, args->geo->blksize - 1);
 	dead_info = dead_buf->b_addr;
+
 	/*
 	 * Get values from the moved block.
 	 */
diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 371dc07233e0..20acb8573d7a 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -98,7 +98,7 @@ typedef struct xfs_sb {
 	uint32_t	sb_blocksize;	/* logical block size, bytes */
 	xfs_rfsblock_t	sb_dblocks;	/* number of data blocks */
 	xfs_rfsblock_t	sb_rblocks;	/* number of realtime blocks */
-	xfs_rtblock_t	sb_rextents;	/* number of realtime extents */
+	xfs_rtbxlen_t	sb_rextents;	/* number of realtime extents */
 	uuid_t		sb_uuid;	/* user-visible file system unique id */
 	xfs_fsblock_t	sb_logstart;	/* starting block of log if internal */
 	xfs_ino_t	sb_rootino;	/* root inode number */
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 120dbec16f5c..d1472cbd48ff 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -1827,7 +1827,7 @@ xfs_dialloc(
  * might be sparse and only free the regions that are allocated as part of the
  * chunk.
  */
-STATIC void
+static int
 xfs_difree_inode_chunk(
 	struct xfs_trans		*tp,
 	xfs_agnumber_t			agno,
@@ -1844,10 +1844,10 @@ xfs_difree_inode_chunk(
 
 	if (!xfs_inobt_issparse(rec->ir_holemask)) {
 		/* not sparse, calculate extent info directly */
-		xfs_free_extent_later(tp, XFS_AGB_TO_FSB(mp, agno, sagbno),
-				  M_IGEO(mp)->ialloc_blks,
-				  &XFS_RMAP_OINFO_INODES);
-		return;
+		return xfs_free_extent_later(tp,
+				XFS_AGB_TO_FSB(mp, agno, sagbno),
+				M_IGEO(mp)->ialloc_blks, &XFS_RMAP_OINFO_INODES,
+				XFS_AG_RESV_NONE);
 	}
 
 	/* holemask is only 16-bits (fits in an unsigned long) */
@@ -1864,6 +1864,8 @@ xfs_difree_inode_chunk(
 						XFS_INOBT_HOLEMASK_BITS);
 	nextbit = startidx + 1;
 	while (startidx < XFS_INOBT_HOLEMASK_BITS) {
+		int error;
+
 		nextbit = find_next_zero_bit(holemask, XFS_INOBT_HOLEMASK_BITS,
 					     nextbit);
 		/*
@@ -1889,8 +1891,11 @@ xfs_difree_inode_chunk(
 
 		ASSERT(agbno % mp->m_sb.sb_spino_align == 0);
 		ASSERT(contigblk % mp->m_sb.sb_spino_align == 0);
-		xfs_free_extent_later(tp, XFS_AGB_TO_FSB(mp, agno, agbno),
-				  contigblk, &XFS_RMAP_OINFO_INODES);
+		error = xfs_free_extent_later(tp,
+				XFS_AGB_TO_FSB(mp, agno, agbno), contigblk,
+				&XFS_RMAP_OINFO_INODES, XFS_AG_RESV_NONE);
+		if (error)
+			return error;
 
 		/* reset range to current bit and carry on... */
 		startidx = endidx = nextbit;
@@ -1898,6 +1903,7 @@ xfs_difree_inode_chunk(
 next:
 		nextbit++;
 	}
+	return 0;
 }
 
 STATIC int
@@ -1998,7 +2004,9 @@ xfs_difree_inobt(
 			goto error0;
 		}
 
-		xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		error = xfs_difree_inode_chunk(tp, pag->pag_agno, &rec);
+		if (error)
+			goto error0;
 	} else {
 		xic->deleted = false;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc_btree.c b/fs/xfs/libxfs/xfs_ialloc_btree.c
index 8c83e265770c..7125447cde1a 100644
--- a/fs/xfs/libxfs/xfs_ialloc_btree.c
+++ b/fs/xfs/libxfs/xfs_ialloc_btree.c
@@ -156,9 +156,11 @@ __xfs_inobt_free_block(
 	struct xfs_buf		*bp,
 	enum xfs_ag_resv_type	resv)
 {
+	xfs_fsblock_t		fsbno;
+
 	xfs_inobt_mod_blockcount(cur, -1);
-	return xfs_free_extent(cur->bc_tp,
-			XFS_DADDR_TO_FSB(cur->bc_mp, xfs_buf_daddr(bp)), 1,
+	fsbno = XFS_DADDR_TO_FSB(cur->bc_mp, xfs_buf_daddr(bp));
+	return xfs_free_extent_later(cur->bc_tp, fsbno, 1,
 			&XFS_RMAP_OINFO_INOBT, resv);
 }
 
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 2420865f3007..a5100a11faf9 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -131,4 +131,26 @@ void xlog_check_buf_cancel_table(struct xlog *log);
 #define xlog_check_buf_cancel_table(log) do { } while (0)
 #endif
 
+/*
+ * Transform a regular reservation into one suitable for recovery of a log
+ * intent item.
+ *
+ * Intent recovery only runs a single step of the transaction chain and defers
+ * the rest to a separate transaction.  Therefore, we reduce logcount to 1 here
+ * to avoid livelocks if the log grant space is nearly exhausted due to the
+ * recovered intent pinning the tail.  Keep the same logflags to avoid tripping
+ * asserts elsewhere.  Struct copies abound below.
+ */
+static inline struct xfs_trans_res
+xlog_recover_resv(const struct xfs_trans_res *r)
+{
+	struct xfs_trans_res ret = {
+		.tr_logres	= r->tr_logres,
+		.tr_logcount	= 1,
+		.tr_logflags	= r->tr_logflags,
+	};
+
+	return ret;
+}
+
 #endif	/* __XFS_LOG_RECOVER_H__ */
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 6f7ed9288fe4..4ec7a81dd3ef 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1129,8 +1129,11 @@ xfs_refcount_adjust_extents(
 				fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 						cur->bc_ag.pag->pag_agno,
 						tmp.rc_startblock);
-				xfs_free_extent_later(cur->bc_tp, fsbno,
-						  tmp.rc_blockcount, NULL);
+				error = xfs_free_extent_later(cur->bc_tp, fsbno,
+						  tmp.rc_blockcount, NULL,
+						  XFS_AG_RESV_NONE);
+				if (error)
+					goto out_error;
 			}
 
 			(*agbno) += tmp.rc_blockcount;
@@ -1188,8 +1191,11 @@ xfs_refcount_adjust_extents(
 			fsbno = XFS_AGB_TO_FSB(cur->bc_mp,
 					cur->bc_ag.pag->pag_agno,
 					ext.rc_startblock);
-			xfs_free_extent_later(cur->bc_tp, fsbno,
-					ext.rc_blockcount, NULL);
+			error = xfs_free_extent_later(cur->bc_tp, fsbno,
+					ext.rc_blockcount, NULL,
+					XFS_AG_RESV_NONE);
+			if (error)
+				goto out_error;
 		}
 
 skip:
@@ -1213,37 +1219,33 @@ xfs_refcount_adjust_extents(
 STATIC int
 xfs_refcount_adjust(
 	struct xfs_btree_cur	*cur,
-	xfs_agblock_t		agbno,
-	xfs_extlen_t		aglen,
-	xfs_agblock_t		*new_agbno,
-	xfs_extlen_t		*new_aglen,
+	xfs_agblock_t		*agbno,
+	xfs_extlen_t		*aglen,
 	enum xfs_refc_adjust_op	adj)
 {
 	bool			shape_changed;
 	int			shape_changes = 0;
 	int			error;
 
-	*new_agbno = agbno;
-	*new_aglen = aglen;
 	if (adj == XFS_REFCOUNT_ADJUST_INCREASE)
-		trace_xfs_refcount_increase(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-				agbno, aglen);
+		trace_xfs_refcount_increase(cur->bc_mp,
+				cur->bc_ag.pag->pag_agno, *agbno, *aglen);
 	else
-		trace_xfs_refcount_decrease(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-				agbno, aglen);
+		trace_xfs_refcount_decrease(cur->bc_mp,
+				cur->bc_ag.pag->pag_agno, *agbno, *aglen);
 
 	/*
 	 * Ensure that no rcextents cross the boundary of the adjustment range.
 	 */
 	error = xfs_refcount_split_extent(cur, XFS_REFC_DOMAIN_SHARED,
-			agbno, &shape_changed);
+			*agbno, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
 		shape_changes++;
 
 	error = xfs_refcount_split_extent(cur, XFS_REFC_DOMAIN_SHARED,
-			agbno + aglen, &shape_changed);
+			*agbno + *aglen, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
@@ -1253,7 +1255,7 @@ xfs_refcount_adjust(
 	 * Try to merge with the left or right extents of the range.
 	 */
 	error = xfs_refcount_merge_extents(cur, XFS_REFC_DOMAIN_SHARED,
-			new_agbno, new_aglen, adj, &shape_changed);
+			agbno, aglen, adj, &shape_changed);
 	if (error)
 		goto out_error;
 	if (shape_changed)
@@ -1262,7 +1264,7 @@ xfs_refcount_adjust(
 		cur->bc_ag.refc.shape_changes++;
 
 	/* Now that we've taken care of the ends, adjust the middle extents */
-	error = xfs_refcount_adjust_extents(cur, new_agbno, new_aglen, adj);
+	error = xfs_refcount_adjust_extents(cur, agbno, aglen, adj);
 	if (error)
 		goto out_error;
 
@@ -1298,21 +1300,20 @@ xfs_refcount_finish_one_cleanup(
 static inline int
 xfs_refcount_continue_op(
 	struct xfs_btree_cur		*cur,
-	xfs_fsblock_t			startblock,
-	xfs_agblock_t			new_agbno,
-	xfs_extlen_t			new_len,
-	xfs_fsblock_t			*new_fsbno)
+	struct xfs_refcount_intent	*ri,
+	xfs_agblock_t			new_agbno)
 {
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_perag		*pag = cur->bc_ag.pag;
 
-	if (XFS_IS_CORRUPT(mp, !xfs_verify_agbext(pag, new_agbno, new_len)))
+	if (XFS_IS_CORRUPT(mp, !xfs_verify_agbext(pag, new_agbno,
+					ri->ri_blockcount)))
 		return -EFSCORRUPTED;
 
-	*new_fsbno = XFS_AGB_TO_FSB(mp, pag->pag_agno, new_agbno);
+	ri->ri_startblock = XFS_AGB_TO_FSB(mp, pag->pag_agno, new_agbno);
 
-	ASSERT(xfs_verify_fsbext(mp, *new_fsbno, new_len));
-	ASSERT(pag->pag_agno == XFS_FSB_TO_AGNO(mp, *new_fsbno));
+	ASSERT(xfs_verify_fsbext(mp, ri->ri_startblock, ri->ri_blockcount));
+	ASSERT(pag->pag_agno == XFS_FSB_TO_AGNO(mp, ri->ri_startblock));
 
 	return 0;
 }
@@ -1327,11 +1328,7 @@ xfs_refcount_continue_op(
 int
 xfs_refcount_finish_one(
 	struct xfs_trans		*tp,
-	enum xfs_refcount_intent_type	type,
-	xfs_fsblock_t			startblock,
-	xfs_extlen_t			blockcount,
-	xfs_fsblock_t			*new_fsb,
-	xfs_extlen_t			*new_len,
+	struct xfs_refcount_intent	*ri,
 	struct xfs_btree_cur		**pcur)
 {
 	struct xfs_mount		*mp = tp->t_mountp;
@@ -1339,17 +1336,16 @@ xfs_refcount_finish_one(
 	struct xfs_buf			*agbp = NULL;
 	int				error = 0;
 	xfs_agblock_t			bno;
-	xfs_agblock_t			new_agbno;
 	unsigned long			nr_ops = 0;
 	int				shape_changes = 0;
 	struct xfs_perag		*pag;
 
-	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, startblock));
-	bno = XFS_FSB_TO_AGBNO(mp, startblock);
+	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ri->ri_startblock));
+	bno = XFS_FSB_TO_AGBNO(mp, ri->ri_startblock);
 
-	trace_xfs_refcount_deferred(mp, XFS_FSB_TO_AGNO(mp, startblock),
-			type, XFS_FSB_TO_AGBNO(mp, startblock),
-			blockcount);
+	trace_xfs_refcount_deferred(mp, XFS_FSB_TO_AGNO(mp, ri->ri_startblock),
+			ri->ri_type, XFS_FSB_TO_AGBNO(mp, ri->ri_startblock),
+			ri->ri_blockcount);
 
 	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_REFCOUNT_FINISH_ONE)) {
 		error = -EIO;
@@ -1380,42 +1376,42 @@ xfs_refcount_finish_one(
 	}
 	*pcur = rcur;
 
-	switch (type) {
+	switch (ri->ri_type) {
 	case XFS_REFCOUNT_INCREASE:
-		error = xfs_refcount_adjust(rcur, bno, blockcount, &new_agbno,
-				new_len, XFS_REFCOUNT_ADJUST_INCREASE);
+		error = xfs_refcount_adjust(rcur, &bno, &ri->ri_blockcount,
+				XFS_REFCOUNT_ADJUST_INCREASE);
 		if (error)
 			goto out_drop;
-		if (*new_len > 0)
-			error = xfs_refcount_continue_op(rcur, startblock,
-					new_agbno, *new_len, new_fsb);
+		if (ri->ri_blockcount > 0)
+			error = xfs_refcount_continue_op(rcur, ri, bno);
 		break;
 	case XFS_REFCOUNT_DECREASE:
-		error = xfs_refcount_adjust(rcur, bno, blockcount, &new_agbno,
-				new_len, XFS_REFCOUNT_ADJUST_DECREASE);
+		error = xfs_refcount_adjust(rcur, &bno, &ri->ri_blockcount,
+				XFS_REFCOUNT_ADJUST_DECREASE);
 		if (error)
 			goto out_drop;
-		if (*new_len > 0)
-			error = xfs_refcount_continue_op(rcur, startblock,
-					new_agbno, *new_len, new_fsb);
+		if (ri->ri_blockcount > 0)
+			error = xfs_refcount_continue_op(rcur, ri, bno);
 		break;
 	case XFS_REFCOUNT_ALLOC_COW:
-		*new_fsb = startblock + blockcount;
-		*new_len = 0;
-		error = __xfs_refcount_cow_alloc(rcur, bno, blockcount);
+		error = __xfs_refcount_cow_alloc(rcur, bno, ri->ri_blockcount);
+		if (error)
+			goto out_drop;
+		ri->ri_blockcount = 0;
 		break;
 	case XFS_REFCOUNT_FREE_COW:
-		*new_fsb = startblock + blockcount;
-		*new_len = 0;
-		error = __xfs_refcount_cow_free(rcur, bno, blockcount);
+		error = __xfs_refcount_cow_free(rcur, bno, ri->ri_blockcount);
+		if (error)
+			goto out_drop;
+		ri->ri_blockcount = 0;
 		break;
 	default:
 		ASSERT(0);
 		error = -EFSCORRUPTED;
 	}
-	if (!error && *new_len > 0)
-		trace_xfs_refcount_finish_one_leftover(mp, pag->pag_agno, type,
-				bno, blockcount, new_agbno, *new_len);
+	if (!error && ri->ri_blockcount > 0)
+		trace_xfs_refcount_finish_one_leftover(mp, pag->pag_agno,
+				ri->ri_type, bno, ri->ri_blockcount);
 out_drop:
 	xfs_perag_put(pag);
 	return error;
@@ -1968,7 +1964,11 @@ xfs_refcount_recover_cow_leftovers(
 				rr->rr_rrec.rc_blockcount);
 
 		/* Free the block. */
-		xfs_free_extent_later(tp, fsb, rr->rr_rrec.rc_blockcount, NULL);
+		error = xfs_free_extent_later(tp, fsb,
+				rr->rr_rrec.rc_blockcount, NULL,
+				XFS_AG_RESV_NONE);
+		if (error)
+			goto out_trans;
 
 		error = xfs_trans_commit(tp);
 		if (error)
diff --git a/fs/xfs/libxfs/xfs_refcount.h b/fs/xfs/libxfs/xfs_refcount.h
index 452f30556f5a..c633477ce3ce 100644
--- a/fs/xfs/libxfs/xfs_refcount.h
+++ b/fs/xfs/libxfs/xfs_refcount.h
@@ -75,9 +75,7 @@ void xfs_refcount_decrease_extent(struct xfs_trans *tp,
 extern void xfs_refcount_finish_one_cleanup(struct xfs_trans *tp,
 		struct xfs_btree_cur *rcur, int error);
 extern int xfs_refcount_finish_one(struct xfs_trans *tp,
-		enum xfs_refcount_intent_type type, xfs_fsblock_t startblock,
-		xfs_extlen_t blockcount, xfs_fsblock_t *new_fsb,
-		xfs_extlen_t *new_len, struct xfs_btree_cur **pcur);
+		struct xfs_refcount_intent *ri, struct xfs_btree_cur **pcur);
 
 extern int xfs_refcount_find_shared(struct xfs_btree_cur *cur,
 		xfs_agblock_t agbno, xfs_extlen_t aglen, xfs_agblock_t *fbno,
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index e1f789866683..fbd53b6951a9 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
@@ -106,18 +106,13 @@ xfs_refcountbt_free_block(
 	struct xfs_buf		*agbp = cur->bc_ag.agbp;
 	struct xfs_agf		*agf = agbp->b_addr;
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
-	int			error;
 
 	trace_xfs_refcountbt_free_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
 			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1);
 	be32_add_cpu(&agf->agf_refcount_blocks, -1);
 	xfs_alloc_log_agf(cur->bc_tp, agbp, XFS_AGF_REFCOUNT_BLOCKS);
-	error = xfs_free_extent(cur->bc_tp, fsbno, 1, &XFS_RMAP_OINFO_REFC,
-			XFS_AG_RESV_METADATA);
-	if (error)
-		return error;
-
-	return error;
+	return xfs_free_extent_later(cur->bc_tp, fsbno, 1,
+			&XFS_RMAP_OINFO_REFC, XFS_AG_RESV_METADATA);
 }
 
 STATIC int
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index 655108a4cd05..760172a65aff 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -16,6 +16,7 @@
 #include "xfs_trans.h"
 #include "xfs_rtalloc.h"
 #include "xfs_error.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Realtime allocator bitmap functions shared with userspace.
@@ -1129,3 +1130,4 @@ xfs_rtalloc_extent_is_free(
 	*is_free = matches;
 	return 0;
 }
+
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.h b/fs/xfs/libxfs/xfs_rtbitmap.h
new file mode 100644
index 000000000000..b89712983347
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_rtbitmap.h
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2000-2003,2005 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __XFS_RTBITMAP_H__
+#define	__XFS_RTBITMAP_H__
+
+/*
+ * XXX: Most of the realtime allocation functions deal in units of realtime
+ * extents, not realtime blocks.  This looks funny when paired with the type
+ * name and screams for a larger cleanup.
+ */
+struct xfs_rtalloc_rec {
+	xfs_rtblock_t		ar_startext;
+	xfs_rtbxlen_t		ar_extcount;
+};
+
+typedef int (*xfs_rtalloc_query_range_fn)(
+	struct xfs_mount		*mp,
+	struct xfs_trans		*tp,
+	const struct xfs_rtalloc_rec	*rec,
+	void				*priv);
+
+#ifdef CONFIG_XFS_RT
+int xfs_rtbuf_get(struct xfs_mount *mp, struct xfs_trans *tp,
+		  xfs_rtblock_t block, int issum, struct xfs_buf **bpp);
+int xfs_rtcheck_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		      xfs_rtblock_t start, xfs_extlen_t len, int val,
+		      xfs_rtblock_t *new, int *stat);
+int xfs_rtfind_back(struct xfs_mount *mp, struct xfs_trans *tp,
+		    xfs_rtblock_t start, xfs_rtblock_t limit,
+		    xfs_rtblock_t *rtblock);
+int xfs_rtfind_forw(struct xfs_mount *mp, struct xfs_trans *tp,
+		    xfs_rtblock_t start, xfs_rtblock_t limit,
+		    xfs_rtblock_t *rtblock);
+int xfs_rtmodify_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		       xfs_rtblock_t start, xfs_extlen_t len, int val);
+int xfs_rtmodify_summary_int(struct xfs_mount *mp, struct xfs_trans *tp,
+			     int log, xfs_rtblock_t bbno, int delta,
+			     struct xfs_buf **rbpp, xfs_fsblock_t *rsb,
+			     xfs_suminfo_t *sum);
+int xfs_rtmodify_summary(struct xfs_mount *mp, struct xfs_trans *tp, int log,
+			 xfs_rtblock_t bbno, int delta, struct xfs_buf **rbpp,
+			 xfs_fsblock_t *rsb);
+int xfs_rtfree_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		     xfs_rtblock_t start, xfs_extlen_t len,
+		     struct xfs_buf **rbpp, xfs_fsblock_t *rsb);
+int xfs_rtalloc_query_range(struct xfs_mount *mp, struct xfs_trans *tp,
+		const struct xfs_rtalloc_rec *low_rec,
+		const struct xfs_rtalloc_rec *high_rec,
+		xfs_rtalloc_query_range_fn fn, void *priv);
+int xfs_rtalloc_query_all(struct xfs_mount *mp, struct xfs_trans *tp,
+			  xfs_rtalloc_query_range_fn fn,
+			  void *priv);
+bool xfs_verify_rtbno(struct xfs_mount *mp, xfs_rtblock_t rtbno);
+int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
+			       xfs_rtblock_t start, xfs_extlen_t len,
+			       bool *is_free);
+/*
+ * Free an extent in the realtime subvolume.  Length is expressed in
+ * realtime extents, as is the block number.
+ */
+int					/* error */
+xfs_rtfree_extent(
+	struct xfs_trans	*tp,	/* transaction pointer */
+	xfs_rtblock_t		bno,	/* starting block number to free */
+	xfs_extlen_t		len);	/* length of extent freed */
+
+/* Same as above, but in units of rt blocks. */
+int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
+		xfs_filblks_t rtlen);
+
+#else /* CONFIG_XFS_RT */
+# define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
+# define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
+# define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
+# define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
+# define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
+# define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
+#endif /* CONFIG_XFS_RT */
+
+#endif /* __XFS_RTBITMAP_H__ */
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d214233ef532..90ed55cd3d10 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -25,6 +25,7 @@
 #include "xfs_da_format.h"
 #include "xfs_health.h"
 #include "xfs_ag.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Physical superblock buffer manipulations. Shared with libxfs in userspace.
@@ -501,8 +502,9 @@ xfs_validate_sb_common(
 		rbmblocks = howmany_64(sbp->sb_rextents,
 				       NBBY * sbp->sb_blocksize);
 
-		if (sbp->sb_rextents != rexts ||
-		    sbp->sb_rextslog != xfs_highbit32(sbp->sb_rextents) ||
+		if (!xfs_validate_rtextents(rexts) ||
+		    sbp->sb_rextents != rexts ||
+		    sbp->sb_rextslog != xfs_compute_rextslog(rexts) ||
 		    sbp->sb_rbmblocks != rbmblocks) {
 			xfs_notice(mp,
 				"realtime geometry sanity check failed");
@@ -1365,3 +1367,17 @@ xfs_validate_stripe_geometry(
 	}
 	return true;
 }
+
+/*
+ * Compute the maximum level number of the realtime summary file, as defined by
+ * mkfs.  The historic use of highbit32 on a 64-bit quantity prohibited correct
+ * use of rt volumes with more than 2^32 extents.
+ */
+uint8_t
+xfs_compute_rextslog(
+	xfs_rtbxlen_t		rtextents)
+{
+	if (!rtextents)
+		return 0;
+	return xfs_highbit64(rtextents);
+}
diff --git a/fs/xfs/libxfs/xfs_sb.h b/fs/xfs/libxfs/xfs_sb.h
index 19134b23c10b..2e8e8d63d4eb 100644
--- a/fs/xfs/libxfs/xfs_sb.h
+++ b/fs/xfs/libxfs/xfs_sb.h
@@ -38,4 +38,6 @@ extern int	xfs_sb_get_secondary(struct xfs_mount *mp,
 extern bool	xfs_validate_stripe_geometry(struct xfs_mount *mp,
 		__s64 sunit, __s64 swidth, int sectorsize, bool silent);
 
+uint8_t xfs_compute_rextslog(xfs_rtbxlen_t rtextents);
+
 #endif	/* __XFS_SB_H__ */
diff --git a/fs/xfs/libxfs/xfs_types.h b/fs/xfs/libxfs/xfs_types.h
index 5ebdda7e1078..42fed04f038d 100644
--- a/fs/xfs/libxfs/xfs_types.h
+++ b/fs/xfs/libxfs/xfs_types.h
@@ -31,6 +31,7 @@ typedef uint64_t	xfs_rfsblock_t;	/* blockno in filesystem (raw) */
 typedef uint64_t	xfs_rtblock_t;	/* extent (block) in realtime area */
 typedef uint64_t	xfs_fileoff_t;	/* block number in a file */
 typedef uint64_t	xfs_filblks_t;	/* number of blocks in a file */
+typedef uint64_t	xfs_rtbxlen_t;	/* rtbitmap extent length in rtextents */
 
 typedef int64_t		xfs_srtblock_t;	/* signed version of xfs_rtblock_t */
 
@@ -227,4 +228,16 @@ bool xfs_verify_fileoff(struct xfs_mount *mp, xfs_fileoff_t off);
 bool xfs_verify_fileext(struct xfs_mount *mp, xfs_fileoff_t off,
 		xfs_fileoff_t len);
 
+/* Do we support an rt volume having this number of rtextents? */
+static inline bool
+xfs_validate_rtextents(
+	xfs_rtbxlen_t		rtextents)
+{
+	/* No runt rt volumes */
+	if (rtextents == 0)
+		return false;
+
+	return true;
+}
+
 #endif	/* __XFS_TYPES_H__ */
diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index c18bd039fce9..e0ed0ebfdaea 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -582,7 +582,8 @@ xrep_reap_block(
 	else if (resv == XFS_AG_RESV_AGFL)
 		error = xrep_put_freelist(sc, agbno);
 	else
-		error = xfs_free_extent(sc->tp, fsbno, 1, oinfo, resv);
+		error = xfs_free_extent(sc->tp, sc->sa.pag, agbno, 1, oinfo,
+				resv);
 	if (agf_bp != sc->sa.agf_bp)
 		xfs_trans_brelse(sc->tp, agf_bp);
 	if (error)
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index 0a3bde64c675..fad7c353ada6 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -11,9 +11,10 @@
 #include "xfs_mount.h"
 #include "xfs_log_format.h"
 #include "xfs_trans.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_inode.h"
 #include "xfs_bmap.h"
+#include "xfs_sb.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
 
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 2788a6f2edcd..11e88a76a33c 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -329,6 +329,13 @@ xfs_xattri_finish_update(
 		goto out;
 	}
 
+	/* If an attr removal is trivially complete, we're done. */
+	if (attr->xattri_op_flags == XFS_ATTRI_OP_FLAGS_REMOVE &&
+	    !xfs_inode_hasattr(args->dp)) {
+		error = 0;
+		goto out;
+	}
+
 	error = xfs_attr_set_iter(attr);
 	if (!error && attr->xattri_dela_state != XFS_DAS_DONE)
 		error = -EAGAIN;
@@ -547,7 +554,7 @@ xfs_attri_item_recover(
 	struct xfs_inode		*ip;
 	struct xfs_da_args		*args;
 	struct xfs_trans		*tp;
-	struct xfs_trans_res		tres;
+	struct xfs_trans_res		resv;
 	struct xfs_attri_log_format	*attrp;
 	struct xfs_attri_log_nameval	*nv = attrip->attri_nameval;
 	int				error;
@@ -608,8 +615,6 @@ xfs_attri_item_recover(
 			attr->xattri_dela_state = xfs_attr_init_add_state(args);
 		break;
 	case XFS_ATTRI_OP_FLAGS_REMOVE:
-		if (!xfs_inode_hasattr(args->dp))
-			goto out;
 		attr->xattri_dela_state = xfs_attr_init_remove_state(args);
 		break;
 	default:
@@ -618,8 +623,9 @@ xfs_attri_item_recover(
 		goto out;
 	}
 
-	xfs_init_attr_trans(args, &tres, &total);
-	error = xfs_trans_alloc(mp, &tres, total, 0, XFS_TRANS_RESERVE, &tp);
+	xfs_init_attr_trans(args, &resv, &total);
+	resv = xlog_recover_resv(&resv);
+	error = xfs_trans_alloc(mp, &resv, total, 0, XFS_TRANS_RESERVE, &tp);
 	if (error)
 		goto out;
 
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 41323da523d1..1058603db3ac 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -246,18 +246,11 @@ static int
 xfs_trans_log_finish_bmap_update(
 	struct xfs_trans		*tp,
 	struct xfs_bud_log_item		*budp,
-	enum xfs_bmap_intent_type	type,
-	struct xfs_inode		*ip,
-	int				whichfork,
-	xfs_fileoff_t			startoff,
-	xfs_fsblock_t			startblock,
-	xfs_filblks_t			*blockcount,
-	xfs_exntst_t			state)
+	struct xfs_bmap_intent		*bi)
 {
 	int				error;
 
-	error = xfs_bmap_finish_one(tp, ip, type, whichfork, startoff,
-			startblock, blockcount, state);
+	error = xfs_bmap_finish_one(tp, bi);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
@@ -378,25 +371,17 @@ xfs_bmap_update_finish_item(
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_bmap_intent		*bmap;
-	xfs_filblks_t			count;
+	struct xfs_bmap_intent		*bi;
 	int				error;
 
-	bmap = container_of(item, struct xfs_bmap_intent, bi_list);
-	count = bmap->bi_bmap.br_blockcount;
-	error = xfs_trans_log_finish_bmap_update(tp, BUD_ITEM(done),
-			bmap->bi_type,
-			bmap->bi_owner, bmap->bi_whichfork,
-			bmap->bi_bmap.br_startoff,
-			bmap->bi_bmap.br_startblock,
-			&count,
-			bmap->bi_bmap.br_state);
-	if (!error && count > 0) {
-		ASSERT(bmap->bi_type == XFS_BMAP_UNMAP);
-		bmap->bi_bmap.br_blockcount = count;
+	bi = container_of(item, struct xfs_bmap_intent, bi_list);
+
+	error = xfs_trans_log_finish_bmap_update(tp, BUD_ITEM(done), bi);
+	if (!error && bi->bi_bmap.br_blockcount > 0) {
+		ASSERT(bi->bi_type == XFS_BMAP_UNMAP);
 		return -EAGAIN;
 	}
-	kmem_cache_free(xfs_bmap_intent_cache, bmap);
+	kmem_cache_free(xfs_bmap_intent_cache, bi);
 	return error;
 }
 
@@ -471,17 +456,14 @@ xfs_bui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
-	struct xfs_bmbt_irec		irec;
+	struct xfs_bmap_intent		fake = { };
+	struct xfs_trans_res		resv;
 	struct xfs_bui_log_item		*buip = BUI_ITEM(lip);
 	struct xfs_trans		*tp;
 	struct xfs_inode		*ip = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	struct xfs_map_extent		*bmap;
+	struct xfs_map_extent		*map;
 	struct xfs_bud_log_item		*budp;
-	xfs_filblks_t			count;
-	xfs_exntst_t			state;
-	unsigned int			bui_type;
-	int				whichfork;
 	int				iext_delta;
 	int				error = 0;
 
@@ -491,19 +473,18 @@ xfs_bui_item_recover(
 		return -EFSCORRUPTED;
 	}
 
-	bmap = &buip->bui_format.bui_extents[0];
-	state = (bmap->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
-			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
-	whichfork = (bmap->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
+	map = &buip->bui_format.bui_extents[0];
+	fake.bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
-	bui_type = bmap->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
+	fake.bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
 
-	error = xlog_recover_iget(mp, bmap->me_owner, &ip);
+	error = xlog_recover_iget(mp, map->me_owner, &ip);
 	if (error)
 		return error;
 
 	/* Allocate transaction and do the work. */
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv,
 			XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK), 0, 0, &tp);
 	if (error)
 		goto err_rele;
@@ -512,34 +493,34 @@ xfs_bui_item_recover(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
-	if (bui_type == XFS_BMAP_MAP)
+	if (fake.bi_type == XFS_BMAP_MAP)
 		iext_delta = XFS_IEXT_ADD_NOSPLIT_CNT;
 	else
 		iext_delta = XFS_IEXT_PUNCH_HOLE_CNT;
 
-	error = xfs_iext_count_may_overflow(ip, whichfork, iext_delta);
+	error = xfs_iext_count_may_overflow(ip, fake.bi_whichfork, iext_delta);
 	if (error == -EFBIG)
 		error = xfs_iext_count_upgrade(tp, ip, iext_delta);
 	if (error)
 		goto err_cancel;
 
-	count = bmap->me_len;
-	error = xfs_trans_log_finish_bmap_update(tp, budp, bui_type, ip,
-			whichfork, bmap->me_startoff, bmap->me_startblock,
-			&count, state);
+	fake.bi_owner = ip;
+	fake.bi_bmap.br_startblock = map->me_startblock;
+	fake.bi_bmap.br_startoff = map->me_startoff;
+	fake.bi_bmap.br_blockcount = map->me_len;
+	fake.bi_bmap.br_state = (map->me_flags & XFS_BMAP_EXTENT_UNWRITTEN) ?
+			XFS_EXT_UNWRITTEN : XFS_EXT_NORM;
+
+	error = xfs_trans_log_finish_bmap_update(tp, budp, &fake);
 	if (error == -EFSCORRUPTED)
-		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, bmap,
-				sizeof(*bmap));
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, map,
+				sizeof(*map));
 	if (error)
 		goto err_cancel;
 
-	if (count > 0) {
-		ASSERT(bui_type == XFS_BMAP_UNMAP);
-		irec.br_startblock = bmap->me_startblock;
-		irec.br_blockcount = count;
-		irec.br_startoff = bmap->me_startoff;
-		irec.br_state = state;
-		xfs_bmap_unmap_extent(tp, ip, &irec);
+	if (fake.bi_bmap.br_blockcount > 0) {
+		ASSERT(fake.bi_type == XFS_BMAP_UNMAP);
+		xfs_bmap_unmap_extent(tp, ip, &fake.bi_bmap);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 54c774af6e1c..257945cdf63b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2040,6 +2040,14 @@ xfs_alloc_buftarg(
 	return NULL;
 }
 
+static inline void
+xfs_buf_list_del(
+	struct xfs_buf		*bp)
+{
+	list_del_init(&bp->b_list);
+	wake_up_var(&bp->b_list);
+}
+
 /*
  * Cancel a delayed write list.
  *
@@ -2057,7 +2065,7 @@ xfs_buf_delwri_cancel(
 
 		xfs_buf_lock(bp);
 		bp->b_flags &= ~_XBF_DELWRI_Q;
-		list_del_init(&bp->b_list);
+		xfs_buf_list_del(bp);
 		xfs_buf_relse(bp);
 	}
 }
@@ -2110,6 +2118,34 @@ xfs_buf_delwri_queue(
 	return true;
 }
 
+/*
+ * Queue a buffer to this delwri list as part of a data integrity operation.
+ * If the buffer is on any other delwri list, we'll wait for that to clear
+ * so that the caller can submit the buffer for IO and wait for the result.
+ * Callers must ensure the buffer is not already on the list.
+ */
+void
+xfs_buf_delwri_queue_here(
+	struct xfs_buf		*bp,
+	struct list_head	*buffer_list)
+{
+	/*
+	 * We need this buffer to end up on the /caller's/ delwri list, not any
+	 * old list.  This can happen if the buffer is marked stale (which
+	 * clears DELWRI_Q) after the AIL queues the buffer to its list but
+	 * before the AIL has a chance to submit the list.
+	 */
+	while (!list_empty(&bp->b_list)) {
+		xfs_buf_unlock(bp);
+		wait_var_event(&bp->b_list, list_empty(&bp->b_list));
+		xfs_buf_lock(bp);
+	}
+
+	ASSERT(!(bp->b_flags & _XBF_DELWRI_Q));
+
+	xfs_buf_delwri_queue(bp, buffer_list);
+}
+
 /*
  * Compare function is more complex than it needs to be because
  * the return value is only 32 bits and we are doing comparisons
@@ -2172,7 +2208,7 @@ xfs_buf_delwri_submit_buffers(
 		 * reference and remove it from the list here.
 		 */
 		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			list_del_init(&bp->b_list);
+			xfs_buf_list_del(bp);
 			xfs_buf_relse(bp);
 			continue;
 		}
@@ -2192,7 +2228,7 @@ xfs_buf_delwri_submit_buffers(
 			list_move_tail(&bp->b_list, wait_list);
 		} else {
 			bp->b_flags |= XBF_ASYNC;
-			list_del_init(&bp->b_list);
+			xfs_buf_list_del(bp);
 		}
 		__xfs_buf_submit(bp, false);
 	}
@@ -2246,7 +2282,7 @@ xfs_buf_delwri_submit(
 	while (!list_empty(&wait_list)) {
 		bp = list_first_entry(&wait_list, struct xfs_buf, b_list);
 
-		list_del_init(&bp->b_list);
+		xfs_buf_list_del(bp);
 
 		/*
 		 * Wait on the locked buffer, check for errors and unlock and
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 549c60942208..6cf0332ba62c 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -305,6 +305,7 @@ extern void xfs_buf_stale(struct xfs_buf *bp);
 /* Delayed Write Buffer Routines */
 extern void xfs_buf_delwri_cancel(struct list_head *);
 extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
+void xfs_buf_delwri_queue_here(struct xfs_buf *bp, struct list_head *bl);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
 extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index d5130d1fcfae..be9f279a5c75 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -345,23 +345,29 @@ static int
 xfs_trans_free_extent(
 	struct xfs_trans		*tp,
 	struct xfs_efd_log_item		*efdp,
-	xfs_fsblock_t			start_block,
-	xfs_extlen_t			ext_len,
-	const struct xfs_owner_info	*oinfo,
-	bool				skip_discard)
+	struct xfs_extent_free_item	*xefi)
 {
+	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_extent		*extp;
 	uint				next_extent;
-	xfs_agnumber_t			agno = XFS_FSB_TO_AGNO(mp, start_block);
 	xfs_agblock_t			agbno = XFS_FSB_TO_AGBNO(mp,
-								start_block);
+							xefi->xefi_startblock);
 	int				error;
 
-	trace_xfs_bmap_free_deferred(tp->t_mountp, agno, 0, agbno, ext_len);
+	oinfo.oi_owner = xefi->xefi_owner;
+	if (xefi->xefi_flags & XFS_EFI_ATTR_FORK)
+		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
+	if (xefi->xefi_flags & XFS_EFI_BMBT_BLOCK)
+		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
+
+	trace_xfs_bmap_free_deferred(tp->t_mountp, xefi->xefi_pag->pag_agno, 0,
+			agbno, xefi->xefi_blockcount);
+
+	error = __xfs_free_extent(tp, xefi->xefi_pag, agbno,
+			xefi->xefi_blockcount, &oinfo, xefi->xefi_agresv,
+			xefi->xefi_flags & XFS_EFI_SKIP_DISCARD);
 
-	error = __xfs_free_extent(tp, start_block, ext_len,
-				  oinfo, XFS_AG_RESV_NONE, skip_discard);
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
 	 * transaction is aborted, which:
@@ -375,8 +381,8 @@ xfs_trans_free_extent(
 	next_extent = efdp->efd_next_extent;
 	ASSERT(next_extent < efdp->efd_format.efd_nextents);
 	extp = &(efdp->efd_format.efd_extents[next_extent]);
-	extp->ext_start = start_block;
-	extp->ext_len = ext_len;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 	efdp->efd_next_extent++;
 
 	return error;
@@ -389,14 +395,13 @@ xfs_extent_free_diff_items(
 	const struct list_head		*a,
 	const struct list_head		*b)
 {
-	struct xfs_mount		*mp = priv;
 	struct xfs_extent_free_item	*ra;
 	struct xfs_extent_free_item	*rb;
 
 	ra = container_of(a, struct xfs_extent_free_item, xefi_list);
 	rb = container_of(b, struct xfs_extent_free_item, xefi_list);
-	return  XFS_FSB_TO_AGNO(mp, ra->xefi_startblock) -
-		XFS_FSB_TO_AGNO(mp, rb->xefi_startblock);
+
+	return ra->xefi_pag->pag_agno - rb->xefi_pag->pag_agno;
 }
 
 /* Log a free extent to the intent item. */
@@ -404,7 +409,7 @@ STATIC void
 xfs_extent_free_log_item(
 	struct xfs_trans		*tp,
 	struct xfs_efi_log_item		*efip,
-	struct xfs_extent_free_item	*free)
+	struct xfs_extent_free_item	*xefi)
 {
 	uint				next_extent;
 	struct xfs_extent		*extp;
@@ -420,8 +425,8 @@ xfs_extent_free_log_item(
 	next_extent = atomic_inc_return(&efip->efi_next_extent) - 1;
 	ASSERT(next_extent < efip->efi_format.efi_nextents);
 	extp = &efip->efi_format.efi_extents[next_extent];
-	extp->ext_start = free->xefi_startblock;
-	extp->ext_len = free->xefi_blockcount;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 }
 
 static struct xfs_log_item *
@@ -433,15 +438,15 @@ xfs_extent_free_create_intent(
 {
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_efi_log_item		*efip = xfs_efi_init(mp, count);
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 
 	ASSERT(count > 0);
 
 	xfs_trans_add_item(tp, &efip->efi_item);
 	if (sort)
 		list_sort(mp, items, xfs_extent_free_diff_items);
-	list_for_each_entry(free, items, xefi_list)
-		xfs_extent_free_log_item(tp, efip, free);
+	list_for_each_entry(xefi, items, xefi_list)
+		xfs_extent_free_log_item(tp, efip, xefi);
 	return &efip->efi_item;
 }
 
@@ -455,6 +460,26 @@ xfs_extent_free_create_done(
 	return &xfs_trans_get_efd(tp, EFI_ITEM(intent), count)->efd_item;
 }
 
+/* Take a passive ref to the AG containing the space we're freeing. */
+void
+xfs_extent_free_get_group(
+	struct xfs_mount		*mp,
+	struct xfs_extent_free_item	*xefi)
+{
+	xfs_agnumber_t			agno;
+
+	agno = XFS_FSB_TO_AGNO(mp, xefi->xefi_startblock);
+	xefi->xefi_pag = xfs_perag_get(mp, agno);
+}
+
+/* Release a passive AG ref after some freeing work. */
+static inline void
+xfs_extent_free_put_group(
+	struct xfs_extent_free_item	*xefi)
+{
+	xfs_perag_put(xefi->xefi_pag);
+}
+
 /* Process a free extent. */
 STATIC int
 xfs_extent_free_finish_item(
@@ -463,21 +488,15 @@ xfs_extent_free_finish_item(
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_owner_info		oinfo = { };
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 	int				error;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	oinfo.oi_owner = free->xefi_owner;
-	if (free->xefi_flags & XFS_EFI_ATTR_FORK)
-		oinfo.oi_flags |= XFS_OWNER_INFO_ATTR_FORK;
-	if (free->xefi_flags & XFS_EFI_BMBT_BLOCK)
-		oinfo.oi_flags |= XFS_OWNER_INFO_BMBT_BLOCK;
-	error = xfs_trans_free_extent(tp, EFD_ITEM(done),
-			free->xefi_startblock,
-			free->xefi_blockcount,
-			&oinfo, free->xefi_flags & XFS_EFI_SKIP_DISCARD);
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+
+	error = xfs_trans_free_extent(tp, EFD_ITEM(done), xefi);
+
+	xfs_extent_free_put_group(xefi);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 	return error;
 }
 
@@ -494,10 +513,12 @@ STATIC void
 xfs_extent_free_cancel_item(
 	struct list_head		*item)
 {
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+
+	xfs_extent_free_put_group(xefi);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 }
 
 const struct xfs_defer_op_type xfs_extent_free_defer_type = {
@@ -523,28 +544,25 @@ xfs_agfl_free_finish_item(
 	struct xfs_owner_info		oinfo = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	struct xfs_efd_log_item		*efdp = EFD_ITEM(done);
-	struct xfs_extent_free_item	*free;
+	struct xfs_extent_free_item	*xefi;
 	struct xfs_extent		*extp;
 	struct xfs_buf			*agbp;
 	int				error;
-	xfs_agnumber_t			agno;
 	xfs_agblock_t			agbno;
 	uint				next_extent;
-	struct xfs_perag		*pag;
 
-	free = container_of(item, struct xfs_extent_free_item, xefi_list);
-	ASSERT(free->xefi_blockcount == 1);
-	agno = XFS_FSB_TO_AGNO(mp, free->xefi_startblock);
-	agbno = XFS_FSB_TO_AGBNO(mp, free->xefi_startblock);
-	oinfo.oi_owner = free->xefi_owner;
+	xefi = container_of(item, struct xfs_extent_free_item, xefi_list);
+	ASSERT(xefi->xefi_blockcount == 1);
+	agbno = XFS_FSB_TO_AGBNO(mp, xefi->xefi_startblock);
+	oinfo.oi_owner = xefi->xefi_owner;
 
-	trace_xfs_agfl_free_deferred(mp, agno, 0, agbno, free->xefi_blockcount);
+	trace_xfs_agfl_free_deferred(mp, xefi->xefi_pag->pag_agno, 0, agbno,
+			xefi->xefi_blockcount);
 
-	pag = xfs_perag_get(mp, agno);
-	error = xfs_alloc_read_agf(pag, tp, 0, &agbp);
+	error = xfs_alloc_read_agf(xefi->xefi_pag, tp, 0, &agbp);
 	if (!error)
-		error = xfs_free_agfl_block(tp, agno, agbno, agbp, &oinfo);
-	xfs_perag_put(pag);
+		error = xfs_free_agfl_block(tp, xefi->xefi_pag->pag_agno,
+				agbno, agbp, &oinfo);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
@@ -559,11 +577,12 @@ xfs_agfl_free_finish_item(
 	next_extent = efdp->efd_next_extent;
 	ASSERT(next_extent < efdp->efd_format.efd_nextents);
 	extp = &(efdp->efd_format.efd_extents[next_extent]);
-	extp->ext_start = free->xefi_startblock;
-	extp->ext_len = free->xefi_blockcount;
+	extp->ext_start = xefi->xefi_startblock;
+	extp->ext_len = xefi->xefi_blockcount;
 	efdp->efd_next_extent++;
 
-	kmem_cache_free(xfs_extfree_item_cache, free);
+	xfs_extent_free_put_group(xefi);
+	kmem_cache_free(xfs_extfree_item_cache, xefi);
 	return error;
 }
 
@@ -595,11 +614,11 @@ xfs_efi_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
+	struct xfs_trans_res		resv;
 	struct xfs_efi_log_item		*efip = EFI_ITEM(lip);
 	struct xfs_mount		*mp = lip->li_log->l_mp;
 	struct xfs_efd_log_item		*efdp;
 	struct xfs_trans		*tp;
-	struct xfs_extent		*extp;
 	int				i;
 	int				error = 0;
 
@@ -618,16 +637,27 @@ xfs_efi_item_recover(
 		}
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, 0, 0, 0, &tp);
 	if (error)
 		return error;
 	efdp = xfs_trans_get_efd(tp, efip, efip->efi_format.efi_nextents);
 
 	for (i = 0; i < efip->efi_format.efi_nextents; i++) {
+		struct xfs_extent_free_item	fake = {
+			.xefi_owner		= XFS_RMAP_OWN_UNKNOWN,
+			.xefi_agresv		= XFS_AG_RESV_NONE,
+		};
+		struct xfs_extent		*extp;
+
 		extp = &efip->efi_format.efi_extents[i];
-		error = xfs_trans_free_extent(tp, efdp, extp->ext_start,
-					      extp->ext_len,
-					      &XFS_RMAP_OINFO_ANY_OWNER, false);
+
+		fake.xefi_startblock = extp->ext_start;
+		fake.xefi_blockcount = extp->ext_len;
+
+		xfs_extent_free_get_group(mp, &fake);
+		error = xfs_trans_free_extent(tp, efdp, &fake);
+		xfs_extent_free_put_group(&fake);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					extp, sizeof(*extp));
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 062e5dc5db9f..a5b9754c62d1 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -23,7 +23,7 @@
 #include "xfs_refcount.h"
 #include "xfs_refcount_btree.h"
 #include "xfs_alloc_btree.h"
-#include "xfs_rtalloc.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_ag.h"
 
 /* Convert an xfs_fsmap to an fsmap. */
diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 77b14f788214..96e9d64fbe62 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -153,7 +153,7 @@ xfs_growfs_data_private(
 			(delta > 0 ? XFS_GROWFS_SPACE_RES(mp) : -delta), 0,
 			XFS_TRANS_RESERVE, &tp);
 	if (error)
-		return error;
+		goto out_free_unused_perag;
 
 	last_pag = xfs_perag_get(mp, oagcount - 1);
 	if (delta > 0) {
@@ -227,6 +227,9 @@ xfs_growfs_data_private(
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
+out_free_unused_perag:
+	if (nagcount > oagcount)
+		xfs_free_unused_perag_range(mp, oagcount, nagcount);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 91c847a84e10..2ec23c9af760 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -556,6 +556,9 @@ xfs_inode_to_log_dinode(
 		memset(to->di_pad2, 0, sizeof(to->di_pad2));
 		uuid_copy(&to->di_uuid, &ip->i_mount->m_sb.sb_meta_uuid);
 		to->di_v3_pad = 0;
+
+		/* dummy value for initialisation */
+		to->di_crc = 0;
 	} else {
 		to->di_version = 2;
 		to->di_flushiter = ip->i_flushiter;
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 858e3e9eb4a8..dfd7b824e32b 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -252,17 +252,12 @@ static int
 xfs_trans_log_finish_refcount_update(
 	struct xfs_trans		*tp,
 	struct xfs_cud_log_item		*cudp,
-	enum xfs_refcount_intent_type	type,
-	xfs_fsblock_t			startblock,
-	xfs_extlen_t			blockcount,
-	xfs_fsblock_t			*new_fsb,
-	xfs_extlen_t			*new_len,
+	struct xfs_refcount_intent	*ri,
 	struct xfs_btree_cur		**pcur)
 {
 	int				error;
 
-	error = xfs_refcount_finish_one(tp, type, startblock,
-			blockcount, new_fsb, new_len, pcur);
+	error = xfs_refcount_finish_one(tp, ri, pcur);
 
 	/*
 	 * Mark the transaction dirty, even on error. This ensures the
@@ -378,25 +373,20 @@ xfs_refcount_update_finish_item(
 	struct list_head		*item,
 	struct xfs_btree_cur		**state)
 {
-	struct xfs_refcount_intent	*refc;
-	xfs_fsblock_t			new_fsb;
-	xfs_extlen_t			new_aglen;
+	struct xfs_refcount_intent	*ri;
 	int				error;
 
-	refc = container_of(item, struct xfs_refcount_intent, ri_list);
-	error = xfs_trans_log_finish_refcount_update(tp, CUD_ITEM(done),
-			refc->ri_type, refc->ri_startblock, refc->ri_blockcount,
-			&new_fsb, &new_aglen, state);
+	ri = container_of(item, struct xfs_refcount_intent, ri_list);
+	error = xfs_trans_log_finish_refcount_update(tp, CUD_ITEM(done), ri,
+			state);
 
 	/* Did we run out of reservation?  Requeue what we didn't finish. */
-	if (!error && new_aglen > 0) {
-		ASSERT(refc->ri_type == XFS_REFCOUNT_INCREASE ||
-		       refc->ri_type == XFS_REFCOUNT_DECREASE);
-		refc->ri_startblock = new_fsb;
-		refc->ri_blockcount = new_aglen;
+	if (!error && ri->ri_blockcount > 0) {
+		ASSERT(ri->ri_type == XFS_REFCOUNT_INCREASE ||
+		       ri->ri_type == XFS_REFCOUNT_DECREASE);
 		return -EAGAIN;
 	}
-	kmem_cache_free(xfs_refcount_intent_cache, refc);
+	kmem_cache_free(xfs_refcount_intent_cache, ri);
 	return error;
 }
 
@@ -463,18 +453,14 @@ xfs_cui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
-	struct xfs_bmbt_irec		irec;
+	struct xfs_trans_res		resv;
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(lip);
-	struct xfs_phys_extent		*refc;
 	struct xfs_cud_log_item		*cudp;
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_log->l_mp;
-	xfs_fsblock_t			new_fsb;
-	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
 	bool				requeue_only = false;
-	enum xfs_refcount_intent_type	type;
 	int				i;
 	int				error = 0;
 
@@ -505,14 +491,18 @@ xfs_cui_item_recover(
 	 * doesn't fit.  We need to reserve enough blocks to handle a
 	 * full btree split on either end of the refcount range.
 	 */
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
-			mp->m_refc_maxlevels * 2, 0, XFS_TRANS_RESERVE, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, mp->m_refc_maxlevels * 2, 0,
+			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 
 	cudp = xfs_trans_get_cud(tp, cuip);
 
 	for (i = 0; i < cuip->cui_format.cui_nextents; i++) {
+		struct xfs_refcount_intent	fake = { };
+		struct xfs_phys_extent		*refc;
+
 		refc = &cuip->cui_format.cui_extents[i];
 		refc_type = refc->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
 		switch (refc_type) {
@@ -520,7 +510,7 @@ xfs_cui_item_recover(
 		case XFS_REFCOUNT_DECREASE:
 		case XFS_REFCOUNT_ALLOC_COW:
 		case XFS_REFCOUNT_FREE_COW:
-			type = refc_type;
+			fake.ri_type = refc_type;
 			break;
 		default:
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
@@ -529,13 +519,12 @@ xfs_cui_item_recover(
 			error = -EFSCORRUPTED;
 			goto abort_error;
 		}
-		if (requeue_only) {
-			new_fsb = refc->pe_startblock;
-			new_len = refc->pe_len;
-		} else
+
+		fake.ri_startblock = refc->pe_startblock;
+		fake.ri_blockcount = refc->pe_len;
+		if (!requeue_only)
 			error = xfs_trans_log_finish_refcount_update(tp, cudp,
-				type, refc->pe_startblock, refc->pe_len,
-				&new_fsb, &new_len, &rcur);
+					&fake, &rcur);
 		if (error == -EFSCORRUPTED)
 			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 					&cuip->cui_format,
@@ -544,10 +533,13 @@ xfs_cui_item_recover(
 			goto abort_error;
 
 		/* Requeue what we didn't finish. */
-		if (new_len > 0) {
-			irec.br_startblock = new_fsb;
-			irec.br_blockcount = new_len;
-			switch (type) {
+		if (fake.ri_blockcount > 0) {
+			struct xfs_bmbt_irec	irec = {
+				.br_startblock	= fake.ri_startblock,
+				.br_blockcount	= fake.ri_blockcount,
+			};
+
+			switch (fake.ri_type) {
 			case XFS_REFCOUNT_INCREASE:
 				xfs_refcount_increase_extent(tp, &irec);
 				break;
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cbdc23217a42..1bac6a8af970 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -618,8 +618,11 @@ xfs_reflink_cancel_cow_blocks(
 			xfs_refcount_free_cow_extent(*tpp, del.br_startblock,
 					del.br_blockcount);
 
-			xfs_free_extent_later(*tpp, del.br_startblock,
-					  del.br_blockcount, NULL);
+			error = xfs_free_extent_later(*tpp, del.br_startblock,
+					del.br_blockcount, NULL,
+					XFS_AG_RESV_NONE);
+			if (error)
+				break;
 
 			/* Roll the transaction */
 			error = xfs_defer_finish(tpp);
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 534504ede1a3..2043cea261c0 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -492,6 +492,7 @@ xfs_rui_item_recover(
 	struct xfs_log_item		*lip,
 	struct list_head		*capture_list)
 {
+	struct xfs_trans_res		resv;
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(lip);
 	struct xfs_map_extent		*rmap;
 	struct xfs_rud_log_item		*rudp;
@@ -519,8 +520,9 @@ xfs_rui_item_recover(
 		}
 	}
 
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate,
-			mp->m_rmap_maxlevels, 0, XFS_TRANS_RESERVE, &tp);
+	resv = xlog_recover_resv(&M_RES(mp)->tr_itruncate);
+	error = xfs_trans_alloc(mp, &resv, mp->m_rmap_maxlevels, 0,
+			XFS_TRANS_RESERVE, &tp);
 	if (error)
 		return error;
 	rudp = xfs_trans_get_rud(tp, ruip);
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 0bfbbc1dd0da..7c5134899634 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -19,6 +19,7 @@
 #include "xfs_icache.h"
 #include "xfs_rtalloc.h"
 #include "xfs_sb.h"
+#include "xfs_rtbitmap.h"
 
 /*
  * Read and return the summary information for a given extent size,
@@ -317,7 +318,7 @@ xfs_rtallocate_extent_block(
 	/*
 	 * Searched the whole thing & didn't find a maxlen free extent.
 	 */
-	if (minlen < maxlen && besti != -1) {
+	if (minlen <= maxlen && besti != -1) {
 		xfs_extlen_t	p;	/* amount to trim length by */
 
 		/*
@@ -997,8 +998,10 @@ xfs_growfs_rt(
 	 */
 	nrextents = nrblocks;
 	do_div(nrextents, in->extsize);
+	if (!xfs_validate_rtextents(nrextents))
+		return -EINVAL;
 	nrbmblocks = howmany_64(nrextents, NBBY * sbp->sb_blocksize);
-	nrextslog = xfs_highbit32(nrextents);
+	nrextslog = xfs_compute_rextslog(nrextents);
 	nrsumlevels = nrextslog + 1;
 	nrsumsize = (uint)sizeof(xfs_suminfo_t) * nrsumlevels * nrbmblocks;
 	nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
@@ -1060,13 +1063,16 @@ xfs_growfs_rt(
 		nsbp->sb_rextents = nsbp->sb_rblocks;
 		do_div(nsbp->sb_rextents, nsbp->sb_rextsize);
 		ASSERT(nsbp->sb_rextents != 0);
-		nsbp->sb_rextslog = xfs_highbit32(nsbp->sb_rextents);
+		nsbp->sb_rextslog = xfs_compute_rextslog(nsbp->sb_rextents);
 		nrsumlevels = nmp->m_rsumlevels = nsbp->sb_rextslog + 1;
 		nrsumsize =
 			(uint)sizeof(xfs_suminfo_t) * nrsumlevels *
 			nsbp->sb_rbmblocks;
 		nrsumblocks = XFS_B_TO_FSB(mp, nrsumsize);
 		nmp->m_rsumsize = nrsumsize = XFS_FSB_TO_B(mp, nrsumblocks);
+		/* recompute growfsrt reservation from new rsumsize */
+		xfs_trans_resv_calc(nmp, &nmp->m_resv);
+
 		/*
 		 * Start a transaction, get the log reservation.
 		 */
@@ -1150,6 +1156,8 @@ xfs_growfs_rt(
 		 */
 		mp->m_rsumlevels = nrsumlevels;
 		mp->m_rsumsize = nrsumsize;
+		/* recompute growfsrt reservation from new rsumsize */
+		xfs_trans_resv_calc(mp, &mp->m_resv);
 
 		error = xfs_trans_commit(tp);
 		if (error)
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 65c284e9d33e..11859c259a1c 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -11,22 +11,6 @@
 struct xfs_mount;
 struct xfs_trans;
 
-/*
- * XXX: Most of the realtime allocation functions deal in units of realtime
- * extents, not realtime blocks.  This looks funny when paired with the type
- * name and screams for a larger cleanup.
- */
-struct xfs_rtalloc_rec {
-	xfs_rtblock_t		ar_startext;
-	xfs_rtblock_t		ar_extcount;
-};
-
-typedef int (*xfs_rtalloc_query_range_fn)(
-	struct xfs_mount		*mp,
-	struct xfs_trans		*tp,
-	const struct xfs_rtalloc_rec	*rec,
-	void				*priv);
-
 #ifdef CONFIG_XFS_RT
 /*
  * Function prototypes for exported functions.
@@ -48,19 +32,6 @@ xfs_rtallocate_extent(
 	xfs_extlen_t		prod,	/* extent product factor */
 	xfs_rtblock_t		*rtblock); /* out: start block allocated */
 
-/*
- * Free an extent in the realtime subvolume.  Length is expressed in
- * realtime extents, as is the block number.
- */
-int					/* error */
-xfs_rtfree_extent(
-	struct xfs_trans	*tp,	/* transaction pointer */
-	xfs_rtblock_t		bno,	/* starting block number to free */
-	xfs_extlen_t		len);	/* length of extent freed */
-
-/* Same as above, but in units of rt blocks. */
-int xfs_rtfree_blocks(struct xfs_trans *tp, xfs_fsblock_t rtbno,
-		xfs_filblks_t rtlen);
 
 /*
  * Initialize realtime fields in the mount structure.
@@ -102,55 +73,11 @@ xfs_growfs_rt(
 	struct xfs_mount	*mp,	/* file system mount structure */
 	xfs_growfs_rt_t		*in);	/* user supplied growfs struct */
 
-/*
- * From xfs_rtbitmap.c
- */
-int xfs_rtbuf_get(struct xfs_mount *mp, struct xfs_trans *tp,
-		  xfs_rtblock_t block, int issum, struct xfs_buf **bpp);
-int xfs_rtcheck_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		      xfs_rtblock_t start, xfs_extlen_t len, int val,
-		      xfs_rtblock_t *new, int *stat);
-int xfs_rtfind_back(struct xfs_mount *mp, struct xfs_trans *tp,
-		    xfs_rtblock_t start, xfs_rtblock_t limit,
-		    xfs_rtblock_t *rtblock);
-int xfs_rtfind_forw(struct xfs_mount *mp, struct xfs_trans *tp,
-		    xfs_rtblock_t start, xfs_rtblock_t limit,
-		    xfs_rtblock_t *rtblock);
-int xfs_rtmodify_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		       xfs_rtblock_t start, xfs_extlen_t len, int val);
-int xfs_rtmodify_summary_int(struct xfs_mount *mp, struct xfs_trans *tp,
-			     int log, xfs_rtblock_t bbno, int delta,
-			     struct xfs_buf **rbpp, xfs_fsblock_t *rsb,
-			     xfs_suminfo_t *sum);
-int xfs_rtmodify_summary(struct xfs_mount *mp, struct xfs_trans *tp, int log,
-			 xfs_rtblock_t bbno, int delta, struct xfs_buf **rbpp,
-			 xfs_fsblock_t *rsb);
-int xfs_rtfree_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		     xfs_rtblock_t start, xfs_extlen_t len,
-		     struct xfs_buf **rbpp, xfs_fsblock_t *rsb);
-int xfs_rtalloc_query_range(struct xfs_mount *mp, struct xfs_trans *tp,
-		const struct xfs_rtalloc_rec *low_rec,
-		const struct xfs_rtalloc_rec *high_rec,
-		xfs_rtalloc_query_range_fn fn, void *priv);
-int xfs_rtalloc_query_all(struct xfs_mount *mp, struct xfs_trans *tp,
-			  xfs_rtalloc_query_range_fn fn,
-			  void *priv);
-bool xfs_verify_rtbno(struct xfs_mount *mp, xfs_rtblock_t rtbno);
-int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
-			       xfs_rtblock_t start, xfs_extlen_t len,
-			       bool *is_free);
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
 #else
 # define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)	(-ENOSYS)
-# define xfs_rtfree_extent(t,b,l)			(-ENOSYS)
-# define xfs_rtfree_blocks(t,rb,rl)			(-ENOSYS)
 # define xfs_rtpick_extent(m,t,l,rb)			(-ENOSYS)
 # define xfs_growfs_rt(mp,in)				(-ENOSYS)
-# define xfs_rtalloc_query_range(m,t,l,h,f,p)		(-ENOSYS)
-# define xfs_rtalloc_query_all(m,t,f,p)			(-ENOSYS)
-# define xfs_rtbuf_get(m,t,b,i,p)			(-ENOSYS)
-# define xfs_verify_rtbno(m, r)				(false)
-# define xfs_rtalloc_extent_is_free(m,t,s,l,i)		(-ENOSYS)
 # define xfs_rtalloc_reinit_frextents(m)		(0)
 static inline int		/* error */
 xfs_rtmount_init(
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 0cd62031e53f..20e2ec8b73aa 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3208,17 +3208,14 @@ DEFINE_REFCOUNT_DEFERRED_EVENT(xfs_refcount_deferred);
 
 TRACE_EVENT(xfs_refcount_finish_one_leftover,
 	TP_PROTO(struct xfs_mount *mp, xfs_agnumber_t agno,
-		 int type, xfs_agblock_t agbno, xfs_extlen_t len,
-		 xfs_agblock_t new_agbno, xfs_extlen_t new_len),
-	TP_ARGS(mp, agno, type, agbno, len, new_agbno, new_len),
+		 int type, xfs_agblock_t agbno, xfs_extlen_t len),
+	TP_ARGS(mp, agno, type, agbno, len),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_agnumber_t, agno)
 		__field(int, type)
 		__field(xfs_agblock_t, agbno)
 		__field(xfs_extlen_t, len)
-		__field(xfs_agblock_t, new_agbno)
-		__field(xfs_extlen_t, new_len)
 	),
 	TP_fast_assign(
 		__entry->dev = mp->m_super->s_dev;
@@ -3226,17 +3223,13 @@ TRACE_EVENT(xfs_refcount_finish_one_leftover,
 		__entry->type = type;
 		__entry->agbno = agbno;
 		__entry->len = len;
-		__entry->new_agbno = new_agbno;
-		__entry->new_len = new_len;
 	),
-	TP_printk("dev %d:%d type %d agno 0x%x agbno 0x%x fsbcount 0x%x new_agbno 0x%x new_fsbcount 0x%x",
+	TP_printk("dev %d:%d type %d agno 0x%x agbno 0x%x fsbcount 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->type,
 		  __entry->agno,
 		  __entry->agbno,
-		  __entry->len,
-		  __entry->new_agbno,
-		  __entry->new_len)
+		  __entry->len)
 );
 
 /* simple inode-based error/%ip tracepoint class */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0d32634c5cf0..08fba309ddc7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3385,6 +3385,8 @@ extern const struct file_operations generic_ro_fops;
 
 extern int readlink_copy(char __user *, int, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
+extern const char *page_get_link_raw(struct dentry *, struct inode *,
+				     struct delayed_call *);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
 extern void page_put_link(void *);
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index bf169cfef7f1..56c280eb2d4f 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,7 +21,6 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
-extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 extern void clockevent_i8253_disable(void);
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 37aeea266ebb..2bd01109e0ec 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -352,6 +352,11 @@ struct io_ring_ctx {
 	unsigned			sq_thread_idle;
 	/* protected by ->completion_lock */
 	unsigned			evfd_last_cq_tail;
+
+	unsigned short			n_ring_pages;
+	unsigned short			n_sqe_pages;
+	struct page			**ring_pages;
+	struct page			**sqe_pages;
 };
 
 enum {
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 57ebe1267f7f..0278ce3ad1fb 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,8 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 #define NVME_TCP_MIN_MAXH2CDATA 4096
+#define NVME_TCP_MIN_C2HTERM_PLEN	24
+#define NVME_TCP_MAX_C2HTERM_PLEN	152
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0260f5ea98fe..39532c19aa28 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,10 +20,13 @@ enum {
 	 * If in doubt, ignore this flag.
 	 */
 #ifdef MODULE
-	PROC_ENTRY_PERMANENT = 0U,
+	PROC_ENTRY_PERMANENT		= 0U,
 #else
-	PROC_ENTRY_PERMANENT = 1U << 0,
+	PROC_ENTRY_PERMANENT		= 1U << 0,
 #endif
+
+	PROC_ENTRY_proc_read_iter	= 1U << 1,
+	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
 };
 
 struct proc_ops {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b37e95554271..d26b57e87f7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -815,6 +815,7 @@ struct hci_conn_params {
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
+extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
@@ -1768,47 +1769,24 @@ struct hci_cb {
 
 	char *name;
 
-	bool (*match)		(struct hci_conn *conn);
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
-				 __u8 encrypt);
+								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
-static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head *list)
-{
-	struct hci_cb *cb, *cpy;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
-		if (cb->match && cb->match(conn)) {
-			cpy = kmalloc(sizeof(*cpy), GFP_ATOMIC);
-			if (!cpy)
-				break;
-
-			*cpy = *cb;
-			INIT_LIST_HEAD(&cpy->list);
-			list_add_rcu(&cpy->list, list);
-		}
-	}
-	rcu_read_unlock();
-}
-
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
+	struct hci_cb *cb;
 
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->connect_cfm)
 			cb->connect_cfm(conn, status);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -1816,43 +1794,22 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 
 static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
+	struct hci_cb *cb;
 
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->disconn_cfm)
 			cb->disconn_cfm(conn, reason);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
 }
 
-static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
-				    __u8 encrypt)
-{
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
-
-	list_for_each_entry_safe(cb, tmp, &list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-		kfree(cb);
-	}
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
-}
-
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 {
+	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
@@ -1860,11 +1817,20 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 
-	hci_security_cfm(conn, status, encrypt);
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
+	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (conn->state == BT_CONFIG) {
@@ -1891,38 +1857,40 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->sec_level = conn->pending_sec_level;
 	}
 
-	hci_security_cfm(conn, status, encrypt);
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->security_cfm)
+			cb->security_cfm(conn, status, encrypt);
+	}
+	mutex_unlock(&hci_cb_list_lock);
+
+	if (conn->security_cfm_cb)
+		conn->security_cfm_cb(conn, status);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
+	struct hci_cb *cb;
 
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 								__u8 role)
 {
-	struct list_head list;
-	struct hci_cb *cb, *tmp;
-
-	INIT_LIST_HEAD(&list);
-	hci_cb_lookup(conn, &list);
+	struct hci_cb *cb;
 
-	list_for_each_entry_safe(cb, tmp, &list, list) {
+	mutex_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
-		kfree(cb);
 	}
+	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 108617cea9c6..d63ac6d9fbdc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1141,7 +1141,10 @@ void snd_soc_close_delayed_work(struct snd_soc_pcm_runtime *rtd);
 
 /* mixer control */
 struct soc_mixer_control {
-	int min, max, platform_max;
+	/* Minimum and maximum specified as written to the hardware */
+	int min, max;
+	/* Limited maximum value specified as presented through the control */
+	int platform_max;
 	int reg, rreg;
 	unsigned int shift, rshift;
 	unsigned int sign_bit;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 9eff86acdfec..8f8e39cd183e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -379,6 +379,7 @@ enum {
 #define IORING_OFF_SQ_RING		0ULL
 #define IORING_OFF_CQ_RING		0x8000000ULL
 #define IORING_OFF_SQES			0x10000000ULL
+#define IORING_OFF_MMAP_MASK		0xf8000000ULL
 
 /*
  * Filled with the offset for mmap(2)
diff --git a/init/Kconfig b/init/Kconfig
index 2825c8cfde3b..b6786ddc88a8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1925,7 +1925,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !SHADOW_CALL_STACK
-	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	help
 	  Enables Rust support in the kernel.
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 33597284e1cb..ceac15a6bf3b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -71,6 +71,7 @@
 #include <linux/io_uring.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/vmalloc.h>
 #include <asm/shmparam.h>
 
 #define CREATE_TRACE_POINTS
@@ -2513,23 +2514,118 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	return READ_ONCE(rings->cq.head) == READ_ONCE(rings->cq.tail) ? ret : 0;
 }
 
-static void io_mem_free(void *ptr)
+static void io_pages_unmap(void *ptr, struct page ***pages,
+			   unsigned short *npages)
 {
-	struct page *page;
+	bool do_vunmap = false;
 
 	if (!ptr)
 		return;
 
-	page = virt_to_head_page(ptr);
-	if (put_page_testzero(page))
-		free_compound_page(page);
+	if (*npages) {
+		struct page **to_free = *pages;
+		int i;
+
+		/*
+		 * Only did vmap for the non-compound multiple page case.
+		 * For the compound page, we just need to put the head.
+		 */
+		if (PageCompound(to_free[0]))
+			*npages = 1;
+		else if (*npages > 1)
+			do_vunmap = true;
+		for (i = 0; i < *npages; i++)
+			put_page(to_free[i]);
+	}
+	if (do_vunmap)
+		vunmap(ptr);
+	kvfree(*pages);
+	*pages = NULL;
+	*npages = 0;
+}
+
+static void io_rings_free(struct io_ring_ctx *ctx)
+{
+	io_pages_unmap(ctx->rings, &ctx->ring_pages, &ctx->n_ring_pages);
+	io_pages_unmap(ctx->sq_sqes, &ctx->sqe_pages, &ctx->n_sqe_pages);
+	ctx->rings = NULL;
+	ctx->sq_sqes = NULL;
+}
+
+static void *io_mem_alloc_compound(struct page **pages, int nr_pages,
+				   size_t size, gfp_t gfp)
+{
+	struct page *page;
+	int i, order;
+
+	order = get_order(size);
+	if (order > 10)
+		return ERR_PTR(-ENOMEM);
+	else if (order)
+		gfp |= __GFP_COMP;
+
+	page = alloc_pages(gfp, order);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = page + i;
+
+	return page_address(page);
 }
 
-static void *io_mem_alloc(size_t size)
+static void *io_mem_alloc_single(struct page **pages, int nr_pages, size_t size,
+				 gfp_t gfp)
 {
-	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP;
+	void *ret;
+	int i;
 
-	return (void *) __get_free_pages(gfp, get_order(size));
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = alloc_page(gfp);
+		if (!pages[i])
+			goto err;
+	}
+
+	ret = vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (ret)
+		return ret;
+err:
+	while (i--)
+		put_page(pages[i]);
+	return ERR_PTR(-ENOMEM);
+}
+
+static void *io_pages_map(struct page ***out_pages, unsigned short *npages,
+			  size_t size)
+{
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
+	struct page **pages;
+	int nr_pages;
+	void *ret;
+
+	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages = kvmalloc_array(nr_pages, sizeof(struct page *), gfp);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	ret = io_mem_alloc_compound(pages, nr_pages, size, gfp);
+	if (!IS_ERR(ret))
+		goto done;
+	if (nr_pages == 1)
+		goto fail;
+
+	ret = io_mem_alloc_single(pages, nr_pages, size, gfp);
+	if (!IS_ERR(ret)) {
+done:
+		*out_pages = pages;
+		*npages = nr_pages;
+		return ret;
+	}
+fail:
+	kvfree(pages);
+	*out_pages = NULL;
+	*npages = 0;
+	return ret;
 }
 
 static unsigned long rings_size(struct io_ring_ctx *ctx, unsigned int sq_entries,
@@ -2680,8 +2776,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		mmdrop(ctx->mm_account);
 		ctx->mm_account = NULL;
 	}
-	io_mem_free(ctx->rings);
-	io_mem_free(ctx->sq_sqes);
+	io_rings_free(ctx);
 
 	percpu_ref_exit(&ctx->refs);
 	free_uid(ctx->user);
@@ -3114,11 +3209,9 @@ static void *io_uring_validate_mmap_request(struct file *file,
 	switch (offset) {
 	case IORING_OFF_SQ_RING:
 	case IORING_OFF_CQ_RING:
-		ptr = ctx->rings;
-		break;
+		return ctx->rings;
 	case IORING_OFF_SQES:
-		ptr = ctx->sq_sqes;
-		break;
+		return ctx->sq_sqes;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -3130,11 +3223,23 @@ static void *io_uring_validate_mmap_request(struct file *file,
 	return ptr;
 }
 
+int io_uring_mmap_pages(struct io_ring_ctx *ctx, struct vm_area_struct *vma,
+			struct page **pages, int npages)
+{
+	unsigned long nr_pages = npages;
+
+	vma->vm_flags |= VM_DONTEXPAND;
+	return vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
+}
+
 #ifdef CONFIG_MMU
 
 static __cold int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct io_ring_ctx *ctx = file->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
+	long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned int npages;
 	unsigned long pfn;
 	void *ptr;
 
@@ -3142,6 +3247,16 @@ static __cold int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 
+	switch (offset & IORING_OFF_MMAP_MASK) {
+	case IORING_OFF_SQ_RING:
+	case IORING_OFF_CQ_RING:
+		npages = min(ctx->n_ring_pages, (sz + PAGE_SIZE - 1) >> PAGE_SHIFT);
+		return io_uring_mmap_pages(ctx, vma, ctx->ring_pages, npages);
+	case IORING_OFF_SQES:
+		return io_uring_mmap_pages(ctx, vma, ctx->sqe_pages,
+						ctx->n_sqe_pages);
+	}
+
 	pfn = virt_to_phys(ptr) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
@@ -3422,6 +3537,7 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 {
 	struct io_rings *rings;
 	size_t size, sq_array_offset;
+	void *ptr;
 
 	/* make sure these are sane, as we already accounted them */
 	ctx->sq_entries = p->sq_entries;
@@ -3431,9 +3547,9 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	if (size == SIZE_MAX)
 		return -EOVERFLOW;
 
-	rings = io_mem_alloc(size);
-	if (!rings)
-		return -ENOMEM;
+	rings = io_pages_map(&ctx->ring_pages, &ctx->n_ring_pages, size);
+	if (IS_ERR(rings))
+		return PTR_ERR(rings);
 
 	ctx->rings = rings;
 	ctx->sq_array = (u32 *)((char *)rings + sq_array_offset);
@@ -3447,18 +3563,17 @@ static __cold int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	else
 		size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
 	if (size == SIZE_MAX) {
-		io_mem_free(ctx->rings);
-		ctx->rings = NULL;
+		io_rings_free(ctx);
 		return -EOVERFLOW;
 	}
 
-	ctx->sq_sqes = io_mem_alloc(size);
-	if (!ctx->sq_sqes) {
-		io_mem_free(ctx->rings);
-		ctx->rings = NULL;
-		return -ENOMEM;
+	ptr = io_pages_map(&ctx->sqe_pages, &ctx->n_sqe_pages, size);
+	if (IS_ERR(ptr)) {
+		io_rings_free(ctx);
+		return PTR_ERR(ptr);
 	}
 
+	ctx->sq_sqes = ptr;
 	return 0;
 }
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index a1f679b8199e..886921d2d58d 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -41,6 +41,8 @@ bool io_fill_cqe_aux(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
 
 struct page **io_pin_pages(unsigned long ubuf, unsigned long len, int *npages);
+int io_uring_mmap_pages(struct io_ring_ctx *ctx, struct vm_area_struct *vma,
+			struct page **pages, int npages);
 
 struct file *io_file_get_normal(struct io_kiocb *req, int fd);
 struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a483fd9f5de..9b01fdceb622 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -997,9 +997,10 @@ void wake_up_q(struct wake_q_head *head)
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-		/* Task can safely be re-inserted now: */
 		node = node->next;
-		task->wake_q.next = NULL;
+		/* pairs with cmpxchg_relaxed() in __wake_q_add() */
+		WRITE_ONCE(task->wake_q.next, NULL);
+		/* Task can safely be re-inserted now. */
 
 		/*
 		 * wake_up_process() executes a full barrier, which pairs with
@@ -7380,6 +7381,14 @@ static void __setscheduler_params(struct task_struct *p,
 	else if (fair_policy(policy))
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
 
+	/* rt-policy tasks do not have a timerslack */
+	if (task_is_realtime(p)) {
+		p->timer_slack_ns = 0;
+	} else if (p->timer_slack_ns == 0) {
+		/* when switching back to non-rt policy, restore timerslack */
+		p->timer_slack_ns = p->default_timer_slack_ns;
+	}
+
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
 	 * !rt_policy. Always setting this ensures that things like
diff --git a/kernel/sys.c b/kernel/sys.c
index d06eda1387b6..06a9a87a8d3e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2477,6 +2477,8 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
+		if (task_is_realtime(current))
+			break;
 		if (arg2 <= 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8db65e2db14c..e60863ab74b5 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -145,11 +145,6 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return base == &migration_base;
-}
-
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -274,11 +269,6 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 
 #else /* CONFIG_SMP */
 
-static inline bool is_migration_base(struct hrtimer_clock_base *base)
-{
-	return false;
-}
-
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1378,6 +1368,18 @@ static void hrtimer_sync_wait_running(struct hrtimer_cpu_base *cpu_base,
 	}
 }
 
+#ifdef CONFIG_SMP
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+#else
+static __always_inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+#endif
+
 /*
  * This function is called on PREEMPT_RT kernels when the fast path
  * deletion of a timer failed because the timer callback function was
@@ -2090,14 +2092,9 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
 	int ret = 0;
-	u64 slack;
-
-	slack = current->timer_slack_ns;
-	if (dl_task(current) || rt_task(current))
-		slack = 0;
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
-	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
+	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);
 	ret = do_nanosleep(&t, mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
@@ -2278,7 +2275,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2305,13 +2302,6 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
-	/*
-	 * Override any slack passed by the user if under
-	 * rt contraints.
-	 */
-	if (rt_task(current))
-		delta = 0;
-
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2331,7 +2321,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
+ * @delta:	slack in expires timeout (ktime_t)
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
diff --git a/lib/buildid.c b/lib/buildid.c
index cc5da016b235..391382bd0541 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma_is_secretmem(vma))
+		return -EFAULT;
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
diff --git a/mm/migrate.c b/mm/migrate.c
index 209078154a46..e37b18376714 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -420,19 +420,17 @@ int folio_migrate_mapping(struct address_space *mapping,
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			int i;
+    if (folio_test_swapcache(folio)) {
+        int i;
 
-			folio_set_swapcache(newfolio);
-			for (i = 0; i < nr; i++)
-				set_page_private(folio_page(newfolio, i),
-					page_private(folio_page(folio, i)));
-		}
+        folio_set_swapcache(newfolio);
+        for (i = 0; i < nr; i++)
+            set_page_private(folio_page(newfolio, i),
+                page_private(folio_page(folio, i)));
 		entries = nr;
 	} else {
-		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
 	}
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 859ba6bdeb9c..6f4025d1b52b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -357,6 +357,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
+int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
+			struct page **pages, unsigned long *num)
+{
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vm_insert_pages);
+
 int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 			unsigned long num)
 {
diff --git a/net/atm/lec.c b/net/atm/lec.c
index 6257bf12e5a0..ac3cfc1ae510 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -181,6 +181,7 @@ static void
 lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	unsigned int len = skb->len;
 
 	ATM_SKB(skb)->vcc = vcc;
 	atm_account_tx(vcc, skb);
@@ -191,7 +192,7 @@ lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	}
 
 	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_bytes += len;
 }
 
 static void lec_tx_timeout(struct net_device *dev, unsigned int txqueue)
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7f6a7c96ac92..02e084b44053 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -325,8 +325,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 9f4815f4c8e8..deef817b28f0 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -840,8 +840,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 4eb1b3ced0d2..db119071a0ea 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -825,11 +825,16 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
 					 unsigned long hdr_len,
 					 unsigned long len, int nb)
 {
+	struct sk_buff *skb;
+
 	/* Note that we must allocate using GFP_ATOMIC here as
 	 * this function is called originally from netdev hard xmit
 	 * function in atomic context.
 	 */
-	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	skb = bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+	return skb;
 }
 
 static void chan_suspend_cb(struct l2cap_chan *chan)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 496dac042b9c..3cd7c212375f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,6 +58,7 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
+DEFINE_MUTEX(hci_cb_list_lock);
 
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
@@ -2977,7 +2978,9 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	list_add_tail_rcu(&cb->list, &hci_cb_list);
+	mutex_lock(&hci_cb_list_lock);
+	list_add_tail(&cb->list, &hci_cb_list);
+	mutex_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
@@ -2987,8 +2990,9 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	list_del_rcu(&cb->list);
-	synchronize_rcu();
+	mutex_lock(&hci_cb_list_lock);
+	list_del(&cb->list);
+	mutex_unlock(&hci_cb_list_lock);
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6fe5e15981f..6cfd61628cd7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3477,23 +3477,30 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		hci_update_scan(hdev);
 	}
 
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		switch (params->auto_connect) {
-		case HCI_AUTO_CONN_LINK_LOSS:
-			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+	/* Re-enable passive scanning if disconnected device is marked
+	 * as auto-connectable.
+	 */
+	if (conn->type == LE_LINK) {
+		params = hci_conn_params_lookup(hdev, &conn->dst,
+						conn->dst_type);
+		if (params) {
+			switch (params->auto_connect) {
+			case HCI_AUTO_CONN_LINK_LOSS:
+				if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+					break;
+				fallthrough;
+
+			case HCI_AUTO_CONN_DIRECT:
+			case HCI_AUTO_CONN_ALWAYS:
+				hci_pend_le_list_del_init(params);
+				hci_pend_le_list_add(params,
+						     &hdev->pend_le_conns);
+				hci_update_passive_scan(hdev);
 				break;
-			fallthrough;
 
-		case HCI_AUTO_CONN_DIRECT:
-		case HCI_AUTO_CONN_ALWAYS:
-			hci_pend_le_list_del_init(params);
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-			hci_update_passive_scan(hdev);
-			break;
-
-		default:
-			break;
+			default:
+				break;
+			}
 		}
 	}
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f62df9097f5e..437cbeaa9619 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1579,11 +1579,6 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-static bool iso_match(struct hci_conn *hcon)
-{
-	return hcon->type == ISO_LINK || hcon->type == LE_LINK;
-}
-
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	if (hcon->type != ISO_LINK) {
@@ -1753,7 +1748,6 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb iso_cb = {
 	.name		= "ISO",
-	.match		= iso_match,
 	.connect_cfm	= iso_connect_cfm,
 	.disconn_cfm	= iso_disconn_cfm,
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 36d6122f2e12..21a79ef7092d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8278,11 +8278,6 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
-static bool l2cap_match(struct hci_conn *hcon)
-{
-	return hcon->type == ACL_LINK || hcon->type == LE_LINK;
-}
-
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
@@ -8290,6 +8285,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	struct l2cap_chan *pchan;
 	u8 dst_type;
 
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (status) {
@@ -8354,6 +8352,9 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
+	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
@@ -8641,7 +8642,6 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
-	.match		= l2cap_match,
 	.connect_cfm	= l2cap_connect_cfm,
 	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 1686fa60e278..4f54c7df3a94 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2130,11 +2130,6 @@ static int rfcomm_run(void *unused)
 	return 0;
 }
 
-static bool rfcomm_match(struct hci_conn *hcon)
-{
-	return hcon->type == ACL_LINK;
-}
-
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
 	struct rfcomm_session *s;
@@ -2181,7 +2176,6 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 static struct hci_cb rfcomm_cb = {
 	.name		= "RFCOMM",
-	.match		= rfcomm_match,
 	.security_cfm	= rfcomm_security_cfm
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 127479bf475b..fe8728041ad0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1367,13 +1367,11 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-static bool sco_match(struct hci_conn *hcon)
-{
-	return hcon->type == SCO_LINK || hcon->type == ESCO_LINK;
-}
-
 static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
 
 	if (!status) {
@@ -1388,6 +1386,9 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
+	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
+		return;
+
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
@@ -1413,7 +1414,6 @@ void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 static struct hci_cb sco_cb = {
 	.name		= "SCO",
-	.match		= sco_match,
 	.connect_cfm	= sco_connect_cfm,
 	.disconn_cfm	= sco_disconn_cfm,
 };
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a..4417a18b3e95 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -23,6 +23,8 @@
 #include <net/ip6_fib.h>
 #include <net/rtnh.h>
 
+#include "dev.h"
+
 DEFINE_STATIC_KEY_FALSE(nf_hooks_lwtunnel_enabled);
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_enabled);
 
@@ -325,13 +327,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_cmp_encap);
 
 int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -341,8 +353,11 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->output))
+	if (likely(ops && ops->output)) {
+		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -359,13 +374,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_output);
 
 int lwtunnel_xmit(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 
 	lwtstate = dst->lwtstate;
 
@@ -376,8 +401,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->xmit))
+	if (likely(ops && ops->xmit)) {
+		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -394,13 +422,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_xmit);
 
 int lwtunnel_input(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
 
-	if (!dst)
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
 		goto drop;
+	}
+
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
+		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -410,8 +448,11 @@ int lwtunnel_input(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->input))
+	if (likely(ops && ops->input)) {
+		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 2e2c009b5a2d..bcc3950638b9 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2283,6 +2283,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 681eeb2b7399..657abbb7d0d7 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -326,6 +326,7 @@ static int netpoll_owner_active(struct net_device *dev)
 static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	netdev_tx_t status = NETDEV_TX_BUSY;
+	netdev_tx_t ret = NET_XMIT_DROP;
 	struct net_device *dev;
 	unsigned long tries;
 	/* It is up to the caller to keep npinfo alive. */
@@ -334,11 +335,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	lockdep_assert_irqs_disabled();
 
 	dev = np->dev;
+	rcu_read_lock();
 	npinfo = rcu_dereference_bh(dev->npinfo);
 
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
-		return NET_XMIT_DROP;
+		goto out;
 	}
 
 	/* don't get messages out of order, and no recursion */
@@ -377,7 +379,10 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
-	return NETDEV_TX_OK;
+	ret = NETDEV_TX_OK;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7d591a0cf0c7..b64d53590f25 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4745,6 +4745,12 @@ int tcp_abort(struct sock *sk, int err)
 	/* Don't race with userspace socket closes such as tcp_close. */
 	lock_sock(sk);
 
+	/* Avoid closing the same socket twice. */
+	if (sk->sk_state == TCP_CLOSE) {
+		release_sock(sk);
+		return -ENOENT;
+	}
+
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
 		inet_csk_listen_stop(sk);
@@ -4754,19 +4760,12 @@ int tcp_abort(struct sock *sk, int err)
 	local_bh_disable();
 	bh_lock_sock(sk);
 
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		WRITE_ONCE(sk->sk_err, err);
-		/* This barrier is coupled with smp_rmb() in tcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		if (tcp_need_reset(sk->sk_state))
-			tcp_send_active_reset(sk, GFP_ATOMIC);
-		tcp_done(sk);
-	}
+	if (tcp_need_reset(sk->sk_state))
+		tcp_send_active_reset(sk, GFP_ATOMIC);
+	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-	tcp_write_queue_purge(sk);
 	release_sock(sk);
 	return 0;
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 17918f411386..5cf6e824c0df 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3637,7 +3637,8 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		in6_dev_put(idev);
 
 	if (err) {
-		lwtstate_put(fib6_nh->fib_nh_lws);
+		fib_nh_common_release(&fib6_nh->nh_common);
+		fib6_nh->nh_common.nhc_pcpu_rth_output = NULL;
 		fib6_nh->fib_nh_lws = NULL;
 		dev_put(dev);
 	}
@@ -3797,10 +3798,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (nh) {
 		if (rt->fib6_src.plen) {
 			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+			err = -EINVAL;
 			goto out_free;
 		}
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			err = -ENOENT;
 			goto out_free;
 		}
 		rt->nh = nh;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f04fa61a6323..929074f08713 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -649,6 +649,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
+	struct mptcp_addr_info addr;
 	bool echo;
 	int len;
 
@@ -657,7 +658,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
 		    &echo, &drop_other_suboptions))
 		return false;
 
@@ -670,7 +671,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	else if (opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
 	if (remaining < len)
 		return false;
 
@@ -687,6 +688,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		opts->ahmac = 0;
 		*size -= opt_size;
 	}
+	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 77e727d81cc2..25c1cda5c1bc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -981,6 +981,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 18e37b32a5d6..6cc50f05c46c 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2854,12 +2854,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_SERVICES:
 	{
 		struct ip_vs_get_services *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_services *)arg;
 		size = struct_size(get, entrytable, get->num_services);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %zu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -2895,12 +2895,12 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 	case IP_VS_SO_GET_DESTS:
 	{
 		struct ip_vs_get_dests *get;
-		int size;
+		size_t size;
 
 		get = (struct ip_vs_get_dests *)arg;
 		size = struct_size(get, entrytable, get->num_dests);
 		if (*len != size) {
-			pr_err("length: %u != %u\n", *len, size);
+			pr_err("length: %u != %zu\n", *len, size);
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 5885810da412..6156c0751056 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -132,7 +132,7 @@ static int __nf_conncount_add(struct net *net,
 	struct nf_conn *found_ct;
 	unsigned int collect = 0;
 
-	if (time_is_after_eq_jiffies((unsigned long)list->last_gc))
+	if ((u32)jiffies == list->last_gc)
 		goto add_new_node;
 
 	/* check the saved connections */
@@ -234,7 +234,7 @@ bool nf_conncount_gc_list(struct net *net,
 	bool ret = false;
 
 	/* don't bother if we just did GC */
-	if (time_is_after_eq_jiffies((unsigned long)READ_ONCE(list->last_gc)))
+	if ((u32)jiffies == READ_ONCE(list->last_gc))
 		return false;
 
 	/* don't bother if other cpu is already doing GC */
@@ -377,6 +377,8 @@ insert_tree(struct net *net,
 
 	conn->tuple = *tuple;
 	conn->zone = *zone;
+	conn->cpu = raw_smp_processor_id();
+	conn->jiffies32 = (u32)jiffies;
 	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
 	nf_conncount_list_init(&rbconn->list);
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 781d3a26f5df..8d19bd001277 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/seqlock.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
@@ -17,6 +17,11 @@
 #include <net/netfilter/nf_tables_offload.h>
 
 struct nft_counter {
+	u64_stats_t	bytes;
+	u64_stats_t	packets;
+};
+
+struct nft_counter_tot {
 	s64		bytes;
 	s64		packets;
 };
@@ -25,25 +30,24 @@ struct nft_counter_percpu_priv {
 	struct nft_counter __percpu *counter;
 };
 
-static DEFINE_PER_CPU(seqcount_t, nft_counter_seq);
+static DEFINE_PER_CPU(struct u64_stats_sync, nft_counter_sync);
 
 static inline void nft_counter_do_eval(struct nft_counter_percpu_priv *priv,
 				       struct nft_regs *regs,
 				       const struct nft_pktinfo *pkt)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
-
-	write_seqcount_begin(myseq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	this_cpu->bytes += pkt->skb->len;
-	this_cpu->packets++;
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->bytes, pkt->skb->len);
+	u64_stats_inc(&this_cpu->packets);
+	u64_stats_update_end(nft_sync);
 
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
@@ -66,17 +70,16 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
+	this_cpu = raw_cpu_ptr(cpu_stats);
 	if (tb[NFTA_COUNTER_PACKETS]) {
-	        this_cpu->packets =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS]));
+		u64_stats_set(&this_cpu->packets,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_PACKETS])));
 	}
 	if (tb[NFTA_COUNTER_BYTES]) {
-		this_cpu->bytes =
-			be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES]));
+		u64_stats_set(&this_cpu->bytes,
+			      be64_to_cpu(nla_get_be64(tb[NFTA_COUNTER_BYTES])));
 	}
-	preempt_enable();
+
 	priv->counter = cpu_stats;
 	return 0;
 }
@@ -104,40 +107,41 @@ static void nft_counter_obj_destroy(const struct nft_ctx *ctx,
 }
 
 static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
+
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, -total->packets);
+	u64_stats_add(&this_cpu->bytes, -total->bytes);
+	u64_stats_update_end(nft_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets -= total->packets;
-	this_cpu->bytes -= total->bytes;
-	write_seqcount_end(myseq);
 	local_bh_enable();
 }
 
 static void nft_counter_fetch(struct nft_counter_percpu_priv *priv,
-			      struct nft_counter *total)
+			      struct nft_counter_tot *total)
 {
 	struct nft_counter *this_cpu;
-	const seqcount_t *myseq;
 	u64 bytes, packets;
 	unsigned int seq;
 	int cpu;
 
 	memset(total, 0, sizeof(*total));
 	for_each_possible_cpu(cpu) {
-		myseq = per_cpu_ptr(&nft_counter_seq, cpu);
+		struct u64_stats_sync *nft_sync = per_cpu_ptr(&nft_counter_sync, cpu);
+
 		this_cpu = per_cpu_ptr(priv->counter, cpu);
 		do {
-			seq	= read_seqcount_begin(myseq);
-			bytes	= this_cpu->bytes;
-			packets	= this_cpu->packets;
-		} while (read_seqcount_retry(myseq, seq));
+			seq	= u64_stats_fetch_begin(nft_sync);
+			bytes	= u64_stats_read(&this_cpu->bytes);
+			packets	= u64_stats_read(&this_cpu->packets);
+		} while (u64_stats_fetch_retry(nft_sync, seq));
 
 		total->bytes	+= bytes;
 		total->packets	+= packets;
@@ -148,7 +152,7 @@ static int nft_counter_do_dump(struct sk_buff *skb,
 			       struct nft_counter_percpu_priv *priv,
 			       bool reset)
 {
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -236,7 +240,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
-	struct nft_counter total;
+	struct nft_counter_tot total;
 
 	nft_counter_fetch(priv, &total);
 
@@ -244,11 +248,9 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, g
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
-	preempt_disable();
-	this_cpu = this_cpu_ptr(cpu_stats);
-	this_cpu->packets = total.packets;
-	this_cpu->bytes = total.bytes;
-	preempt_enable();
+	this_cpu = raw_cpu_ptr(cpu_stats);
+	u64_stats_set(&this_cpu->packets, total.packets);
+	u64_stats_set(&this_cpu->bytes, total.bytes);
 
 	priv_clone->counter = cpu_stats;
 	return 0;
@@ -266,17 +268,17 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 				      const struct flow_stats *stats)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
+	struct u64_stats_sync *nft_sync;
 	struct nft_counter *this_cpu;
-	seqcount_t *myseq;
 
 	local_bh_disable();
 	this_cpu = this_cpu_ptr(priv->counter);
-	myseq = this_cpu_ptr(&nft_counter_seq);
+	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
-	write_seqcount_begin(myseq);
-	this_cpu->packets += stats->pkts;
-	this_cpu->bytes += stats->bytes;
-	write_seqcount_end(myseq);
+	u64_stats_update_begin(nft_sync);
+	u64_stats_add(&this_cpu->packets, stats->pkts);
+	u64_stats_add(&this_cpu->bytes, stats->bytes);
+	u64_stats_update_end(nft_sync);
 	local_bh_enable();
 }
 
@@ -285,7 +287,7 @@ void nft_counter_init_seqcount(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
+		u64_stats_init(per_cpu_ptr(&nft_counter_sync, cpu));
 }
 
 struct nft_expr_type nft_counter_type;
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 6157f8b4a3ce..3641043ca8cc 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -240,6 +240,7 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 	enum ip_conntrack_info ctinfo;
 	u16 value = nft_reg_load16(&regs->data[priv->sreg]);
 	struct nf_conn *ct;
+	int oldcnt;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) /* already tracked */
@@ -260,10 +261,11 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 
 	ct = this_cpu_read(nft_ct_pcpu_template);
 
-	if (likely(refcount_read(&ct->ct_general.use) == 1)) {
-		refcount_inc(&ct->ct_general.use);
+	__refcount_inc(&ct->ct_general.use, &oldcnt);
+	if (likely(oldcnt == 1)) {
 		nf_ct_zone_add(ct, &zone);
 	} else {
+		refcount_dec(&ct->ct_general.use);
 		/* previous skb got queued to userspace, allocate temporary
 		 * one until percpu template can be reused.
 		 */
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index de588f7b69c4..60d18bd60d82 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -86,7 +86,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	unsigned char optbuf[sizeof(struct ip_options) + 40];
 	struct ip_options *opt = (struct ip_options *)optbuf;
 	struct iphdr *iph, _iph;
-	unsigned int start;
 	bool found = false;
 	__be32 info;
 	int optlen;
@@ -94,7 +93,6 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	iph = skb_header_pointer(skb, 0, sizeof(_iph), &_iph);
 	if (!iph)
 		return -EBADMSG;
-	start = sizeof(struct iphdr);
 
 	optlen = iph->ihl * 4 - (int)sizeof(struct iphdr);
 	if (optlen <= 0)
@@ -104,7 +102,7 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 	/* Copy the options since __ip_options_compile() modifies
 	 * the options.
 	 */
-	if (skb_copy_bits(skb, start, opt->__data, optlen))
+	if (skb_copy_bits(skb, sizeof(struct iphdr), opt->__data, optlen))
 		return -EBADMSG;
 	opt->optlen = optlen;
 
@@ -119,18 +117,18 @@ static int ipv4_find_option(struct net *net, struct sk_buff *skb,
 		found = target == IPOPT_SSRR ? opt->is_strictroute :
 					       !opt->is_strictroute;
 		if (found)
-			*offset = opt->srr + start;
+			*offset = opt->srr;
 		break;
 	case IPOPT_RR:
 		if (!opt->rr)
 			break;
-		*offset = opt->rr + start;
+		*offset = opt->rr;
 		found = true;
 		break;
 	case IPOPT_RA:
 		if (!opt->router_alert)
 			break;
-		*offset = opt->router_alert + start;
+		*offset = opt->router_alert;
 		found = true;
 		break;
 	default:
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index e3c85ceb1f0a..5ebbec656895 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2302,14 +2302,10 @@ int ovs_nla_put_mask(const struct sw_flow *flow, struct sk_buff *skb)
 				OVS_FLOW_ATTR_MASK, true, skb);
 }
 
-#define MAX_ACTIONS_BUFSIZE	(32 * 1024)
-
 static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 {
 	struct sw_flow_actions *sfa;
 
-	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
-
 	sfa = kmalloc(kmalloc_size_roundup(sizeof(*sfa) + size), GFP_KERNEL);
 	if (!sfa)
 		return ERR_PTR(-ENOMEM);
@@ -2465,15 +2461,6 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
-	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((next_offset + req_size) > MAX_ACTIONS_BUFSIZE) {
-			OVS_NLERR(log, "Flow action size exceeds max %u",
-				  MAX_ACTIONS_BUFSIZE);
-			return ERR_PTR(-EMSGSIZE);
-		}
-		new_acts_size = MAX_ACTIONS_BUFSIZE;
-	}
-
 	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
 		return (void *)acts;
@@ -3492,7 +3479,7 @@ int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 	int err;
 	u32 mpls_label_count = 0;
 
-	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
+	*sfa = nla_alloc_flow_actions(nla_len(attr));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cb379849c51a..c395e7a98232 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2200,6 +2200,12 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EOPNOTSUPP;
 	}
 
+	/* Prevent creation of traffic classes with classid TC_H_ROOT */
+	if (clid == TC_H_ROOT) {
+		NL_SET_ERR_MSG(extack, "Cannot create traffic class with classid TC_H_ROOT");
+		return -EINVAL;
+	}
+
 	new_cl = cl;
 	err = -EOPNOTSUPP;
 	if (cops->change)
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 872d127c9db4..fa7a1b69c0f3 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -913,7 +913,8 @@ static void gred_destroy(struct Qdisc *sch)
 	for (i = 0; i < table->DPs; i++)
 		gred_destroy_vq(table->tab[i]);
 
-	gred_offload(sch, TC_GRED_DESTROY);
+	if (table->opt)
+		gred_offload(sch, TC_GRED_DESTROY);
 	kfree(table->opt);
 }
 
diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index ee6514af830f..0527728aee98 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -735,7 +735,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 *     value SHOULD be the smallest TSN not acknowledged by the
 	 *     receiver of the request plus 2^31.
 	 */
-	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1 << 31);
+	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1U << 31);
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 2e14d4c37e2d..9aec24490e8f 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -381,7 +381,7 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
-static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
+static RAW_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
 /**
  *	register_switchdev_notifier - Register notifier
@@ -427,17 +427,27 @@ EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
 int register_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
+
+	rtnl_lock();
+	err = raw_notifier_chain_register(chain, nb);
+	rtnl_unlock();
 
-	return blocking_notifier_chain_register(chain, nb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(register_switchdev_blocking_notifier);
 
 int unregister_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
 
-	return blocking_notifier_chain_unregister(chain, nb);
+	rtnl_lock();
+	err = raw_notifier_chain_unregister(chain, nb);
+	rtnl_unlock();
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_switchdev_blocking_notifier);
 
@@ -445,10 +455,11 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	ASSERT_RTNL();
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	return raw_notifier_call_chain(&switchdev_blocking_notif_chain,
+				       val, info);
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2bed30621fa6..74904f88edfa 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1146,6 +1146,13 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 {
 	struct cfg80211_internal_bss *scan, *tmp;
 	struct cfg80211_beacon_registration *reg, *treg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	WARN_ON(!list_empty(&rdev->wiphy_work_list));
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+	cancel_work_sync(&rdev->wiphy_work);
+
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 3321ca7eb76c..21d5fdba47c4 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -102,7 +102,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
-			xp_init_xskb_addr(xskb, pool, i * pool->chunk_size);
+			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
 	}
 
 	return pool;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 07a7ee43b8ae..c59c548d8fc1 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -738,7 +738,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol)
+			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
diff --git a/rust/Makefile b/rust/Makefile
index 28ba3b9ee18d..ec737bad7fbb 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -344,8 +344,11 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
 
 rust-analyzer:
-	$(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(objtree) \
-		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
+	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
+		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
+		$(abs_srctree) $(abs_objtree) \
+		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
+		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
 
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Dunreachable_pub
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 75bb611bd751..1093c540e324 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -6,10 +6,19 @@
 import argparse
 import json
 import logging
+import os
 import pathlib
 import sys
 
-def generate_crates(srctree, objtree, sysroot_src):
+def args_crates_cfgs(cfgs):
+    crates_cfgs = {}
+    for cfg in cfgs:
+        crate, vals = cfg.split("=", 1)
+        crates_cfgs[crate] = vals.replace("--cfg", "").split()
+
+    return crates_cfgs
+
+def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Generate the configuration list.
     cfg = []
     with open(objtree / "include" / "generated" / "rustc_cfg") as fd:
@@ -23,6 +32,7 @@ def generate_crates(srctree, objtree, sysroot_src):
     # Avoid O(n^2) iterations by keeping a map of indexes.
     crates = []
     crates_indexes = {}
+    crates_cfgs = args_crates_cfgs(cfgs)
 
     def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
         crates_indexes[display_name] = len(crates)
@@ -39,13 +49,26 @@ def generate_crates(srctree, objtree, sysroot_src):
             }
         })
 
-    # First, the ones in `rust/` since they are a bit special.
-    append_crate(
-        "core",
-        sysroot_src / "core" / "src" / "lib.rs",
-        [],
-        is_workspace_member=False,
-    )
+    def append_sysroot_crate(
+        display_name,
+        deps,
+        cfg=[],
+    ):
+        append_crate(
+            display_name,
+            sysroot_src / display_name / "src" / "lib.rs",
+            deps,
+            cfg,
+            is_workspace_member=False,
+        )
+
+    # NB: sysroot crates reexport items from one another so setting up our transitive dependencies
+    # here is important for ensuring that rust-analyzer can resolve symbols. The sources of truth
+    # for this dependency graph are `(sysroot_src / crate / "Cargo.toml" for crate in crates)`.
+    append_sysroot_crate("core", [], cfg=crates_cfgs.get("core", []))
+    append_sysroot_crate("alloc", ["core"])
+    append_sysroot_crate("std", ["alloc", "core"])
+    append_sysroot_crate("proc_macro", ["core", "std"])
 
     append_crate(
         "compiler_builtins",
@@ -57,15 +80,16 @@ def generate_crates(srctree, objtree, sysroot_src):
         "alloc",
         srctree / "rust" / "alloc" / "lib.rs",
         ["core", "compiler_builtins"],
+        cfg=crates_cfgs.get("alloc", []),
     )
 
     append_crate(
         "macros",
         srctree / "rust" / "macros" / "lib.rs",
-        [],
+        ["std", "proc_macro"],
         is_proc_macro=True,
     )
-    crates[-1]["proc_macro_dylib_path"] = "rust/libmacros.so"
+    crates[-1]["proc_macro_dylib_path"] = f"{objtree}/rust/libmacros.so"
 
     append_crate(
         "bindings",
@@ -89,16 +113,26 @@ def generate_crates(srctree, objtree, sysroot_src):
         "exclude_dirs": [],
     }
 
+    def is_root_crate(build_file, target):
+        try:
+            return f"{target}.o" in open(build_file).read()
+        except FileNotFoundError:
+            return False
+
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    for folder in ("samples", "drivers"):
-        for path in (srctree / folder).rglob("*.rs"):
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    if external_src is not None:
+        extra_dirs = [external_src]
+    for folder in extra_dirs:
+        for path in folder.rglob("*.rs"):
             logging.info("Checking %s", path)
             name = path.name.replace(".rs", "")
 
             # Skip those that are not crate roots.
-            if f"{name}.o" not in open(path.parent / "Makefile").read():
+            if not is_root_crate(path.parent / "Makefile", name) and \
+               not is_root_crate(path.parent / "Kbuild", name):
                 continue
 
             logging.info("Adding %s", name)
@@ -114,9 +148,11 @@ def generate_crates(srctree, objtree, sysroot_src):
 def main():
     parser = argparse.ArgumentParser()
     parser.add_argument('--verbose', '-v', action='store_true')
+    parser.add_argument('--cfgs', action='append', default=[])
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot_src", type=pathlib.Path)
+    parser.add_argument("exttree", type=pathlib.Path, nargs="?")
     args = parser.parse_args()
 
     logging.basicConfig(
@@ -125,7 +161,7 @@ def main():
     )
 
     rust_project = {
-        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src),
+        "crates": generate_crates(args.srctree, args.objtree, args.sysroot_src, args.exttree, args.cfgs),
         "sysroot_src": str(args.sysroot_src),
     }
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e5e222e74d78..102af43f7442 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10333,6 +10333,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0228, "Infinix ZERO BOOK 13", ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b45ff8f65f5e..77ea8a6c2d6d 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21M5"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M6"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 7434aeeda292..7a74941c608f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -967,7 +967,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending++;
-			priv->out_up_delay += 17;
+			priv->out_up_delay += 17000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -977,7 +977,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			case WM8997:
 				break;
 			default:
-				priv->out_up_delay += 10;
+				priv->out_up_delay += 10000;
 				break;
 			}
 			break;
@@ -999,7 +999,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_up_pending && priv->out_up_delay) {
 				dev_dbg(component->dev, "Power up delay: %d\n",
 					priv->out_up_delay);
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -1017,7 +1017,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -1028,10 +1028,10 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 				break;
 			case WM8998:
 			case WM1814:
-				priv->out_down_delay += 5;
+				priv->out_down_delay += 5000;
 				break;
 			default:
-				priv->out_down_delay++;
+				priv->out_down_delay += 1000;
 				break;
 			}
 			break;
@@ -1053,7 +1053,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_down_pending && priv->out_down_delay) {
 				dev_dbg(component->dev, "Power down delay: %d\n",
 					priv->out_down_delay);
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index b9f19fbd2911..30e680ee1069 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -2322,10 +2322,10 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 	case CS42L92:
 	case CS47L92:
 	case CS47L93:
-		out_up_delay = 6;
+		out_up_delay = 6000;
 		break;
 	default:
-		out_up_delay = 17;
+		out_up_delay = 17000;
 		break;
 	}
 
@@ -2356,7 +2356,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending--;
 			if (!priv->out_up_pending) {
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -2375,7 +2375,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3L_ENA_SHIFT:
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		default:
 			break;
@@ -2392,7 +2392,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending--;
 			if (!priv->out_down_pending) {
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 2e0ed3e68fa5..fc8479d3d285 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -367,7 +367,7 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0, asi_cfg_0 = 0, asi_cfg_1 = 0, asi_cfg_4 = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -376,12 +376,14 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		fallthrough;
 	case SND_SOC_DAIFMT_NB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_RISING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_FALLING;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
 		fallthrough;
 	case SND_SOC_DAIFMT_IB_NF:
 		asi_cfg_1 = TAS2764_TDM_CFG1_RX_FALLING;
+		asi_cfg_4 = TAS2764_TDM_CFG4_TX_RISING;
 		break;
 	}
 
@@ -391,6 +393,12 @@ static int tas2764_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2764_TDM_CFG4,
+					    TAS2764_TDM_CFG4_TX_MASK,
+					    asi_cfg_4);
+	if (ret < 0)
+		return ret;
+
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		asi_cfg_0 ^= TAS2764_TDM_CFG0_FRAME_START;
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 168af772a898..9490f2686e38 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -25,7 +25,7 @@
 
 /* Power Control */
 #define TAS2764_PWR_CTRL		TAS2764_REG(0X0, 0x02)
-#define TAS2764_PWR_CTRL_MASK		GENMASK(1, 0)
+#define TAS2764_PWR_CTRL_MASK		GENMASK(2, 0)
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
@@ -79,6 +79,12 @@
 #define TAS2764_TDM_CFG3_RXS_SHIFT	0x4
 #define TAS2764_TDM_CFG3_MASK		GENMASK(3, 0)
 
+/* TDM Configuration Reg4 */
+#define TAS2764_TDM_CFG4		TAS2764_REG(0X0, 0x0d)
+#define TAS2764_TDM_CFG4_TX_MASK	BIT(0)
+#define TAS2764_TDM_CFG4_TX_RISING	0x0
+#define TAS2764_TDM_CFG4_TX_FALLING	BIT(0)
+
 /* TDM Configuration Reg5 */
 #define TAS2764_TDM_CFG5		TAS2764_REG(0X0, 0x0e)
 #define TAS2764_TDM_CFG5_VSNS_MASK	BIT(6)
diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 8557759acb1f..e284a3a85459 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -508,7 +508,7 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
-static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -12750, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas2770_playback_volume, -10050, 50, 0);
 
 static const struct snd_kcontrol_new tas2770_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Playback Volume", TAS2770_PLAY_CFG_REG2,
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 034a4e858c7e..602fa7cc2c5e 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -951,7 +951,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to set IRQ %d as wake source: %d\n",
 			irq, ret);
-		return ret;
+		goto free_irq;
 	}
 
 	if (spi->max_speed_hz)
@@ -963,9 +963,18 @@ static int wm0010_spi_probe(struct spi_device *spi)
 				     &soc_component_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
 	if (ret < 0)
-		return ret;
+		goto disable_irq_wake;
 
 	return 0;
+
+disable_irq_wake:
+	irq_set_irq_wake(wm0010->irq, 0);
+
+free_irq:
+	if (wm0010->irq)
+		free_irq(wm0010->irq, wm0010);
+
+	return ret;
 }
 
 static void wm0010_spi_remove(struct spi_device *spi)
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e0b971620d0f..6db17349484c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -302,7 +302,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_left_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_left_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -312,7 +312,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_right_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_right_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	default:
@@ -338,7 +338,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG1, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -350,7 +350,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG2, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	default:
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 7e380d71b0f8..0964b4e3fbdf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1694,20 +1694,6 @@ int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io)
 	return 1;
 }
 
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io)
-{
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-
-	if (!runtime) {
-		dev_warn(dev, "Can't update kctrl when idle\n");
-		return 0;
-	}
-
-	return 1;
-}
-
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg)
 {
 	cfg->cfg.val = cfg->val;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index f8ef6836ef84..690f4932357c 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -742,7 +742,6 @@ struct rsnd_kctrl_cfg_s {
 #define rsnd_kctrl_vals(x)	((x).val)	/* = (x).cfg.val[0] */
 
 int rsnd_kctrl_accept_anytime(struct rsnd_dai_stream *io);
-int rsnd_kctrl_accept_runtime(struct rsnd_dai_stream *io);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_m(struct rsnd_kctrl_cfg_m *cfg);
 struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg);
 int rsnd_kctrl_new(struct rsnd_mod *mod,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index f832165e46bc..e985681363e2 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -34,6 +34,7 @@ struct rsnd_src {
 	struct rsnd_mod *dma;
 	struct rsnd_kctrl_cfg_s sen;  /* sync convert enable */
 	struct rsnd_kctrl_cfg_s sync; /* sync convert */
+	u32 current_sync_rate;
 	int irq;
 };
 
@@ -99,7 +100,7 @@ static u32 rsnd_src_convert_rate(struct rsnd_dai_stream *io,
 	if (!rsnd_src_sync_is_enabled(mod))
 		return rsnd_io_converted_rate(io);
 
-	convert_rate = src->sync.val;
+	convert_rate = src->current_sync_rate;
 
 	if (!convert_rate)
 		convert_rate = rsnd_io_converted_rate(io);
@@ -200,13 +201,73 @@ static const u32 chan222222[] = {
 static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 				      struct rsnd_mod *mod)
 {
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_src *src = rsnd_mod_to_src(mod);
+	u32 fin, fout, new_rate;
+	int inc, cnt, rate;
+	u64 base, val;
+
+	if (!runtime)
+		return;
+
+	if (!rsnd_src_sync_is_enabled(mod))
+		return;
+
+	fin	= rsnd_src_get_in_rate(priv, io);
+	fout	= rsnd_src_get_out_rate(priv, io);
+
+	new_rate = src->sync.val;
+
+	if (!new_rate)
+		new_rate = fout;
+
+	/* Do nothing if no diff */
+	if (new_rate == src->current_sync_rate)
+		return;
+
+	/*
+	 * SRCm_IFSVR::INTIFS can change within 1%
+	 * see
+	 *	SRCm_IFSVR::INTIFS Note
+	 */
+	inc = fout / 100;
+	cnt = abs(new_rate - fout) / inc;
+	if (fout > new_rate)
+		inc *= -1;
+
+	/*
+	 * After start running SRC, we can update only SRC_IFSVR
+	 * for Synchronous Mode
+	 */
+	base = (u64)0x0400000 * fin;
+	rate  = fout;
+	for (int i = 0; i < cnt; i++) {
+		val   = base;
+		rate += inc;
+		do_div(val, rate);
+
+		rsnd_mod_write(mod, SRC_IFSVR, val);
+	}
+	val   = base;
+	do_div(val, new_rate);
+
+	rsnd_mod_write(mod, SRC_IFSVR, val);
+
+	/* update current_sync_rate */
+	src->current_sync_rate = new_rate;
+}
+
+static void rsnd_src_init_convert_rate(struct rsnd_dai_stream *io,
+				       struct rsnd_mod *mod)
+{
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
-	u32 ifscr, fsrate, adinr;
+	u32 ifscr, adinr;
 	u32 cr, route;
 	u32 i_busif, o_busif, tmp;
 	const u32 *bsdsr_table;
@@ -244,26 +305,15 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	adinr = rsnd_get_adinr_bit(mod, io) | chan;
 
 	/*
-	 * SRC_IFSCR / SRC_IFSVR
-	 */
-	ifscr = 0;
-	fsrate = 0;
-	if (use_src) {
-		u64 n;
-
-		ifscr = 1;
-		n = (u64)0x0400000 * fin;
-		do_div(n, fout);
-		fsrate = n;
-	}
-
-	/*
+	 * SRC_IFSCR
 	 * SRC_SRCCR / SRC_ROUTE_MODE0
 	 */
+	ifscr	= 0;
 	cr	= 0x00011110;
 	route	= 0x0;
 	if (use_src) {
 		route	= 0x1;
+		ifscr	= 0x1;
 
 		if (rsnd_src_sync_is_enabled(mod)) {
 			cr |= 0x1;
@@ -334,7 +384,6 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	rsnd_mod_write(mod, SRC_SRCIR, 1);	/* initialize */
 	rsnd_mod_write(mod, SRC_ADINR, adinr);
 	rsnd_mod_write(mod, SRC_IFSCR, ifscr);
-	rsnd_mod_write(mod, SRC_IFSVR, fsrate);
 	rsnd_mod_write(mod, SRC_SRCCR, cr);
 	rsnd_mod_write(mod, SRC_BSDSR, bsdsr_table[idx]);
 	rsnd_mod_write(mod, SRC_BSISR, bsisr_table[idx]);
@@ -347,6 +396,9 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 
 	rsnd_adg_set_src_timesel_gen2(mod, io, fin, fout);
 
+	/* update SRC_IFSVR */
+	rsnd_src_set_convert_rate(io, mod);
+
 	return;
 
 convert_rate_err:
@@ -466,7 +518,8 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 	int ret;
 
 	/* reset sync convert_rate */
-	src->sync.val = 0;
+	src->sync.val		=
+	src->current_sync_rate	= 0;
 
 	ret = rsnd_mod_power_on(mod);
 	if (ret < 0)
@@ -474,7 +527,7 @@ static int rsnd_src_init(struct rsnd_mod *mod,
 
 	rsnd_src_activation(mod);
 
-	rsnd_src_set_convert_rate(io, mod);
+	rsnd_src_init_convert_rate(io, mod);
 
 	rsnd_src_status_clear(mod);
 
@@ -492,7 +545,8 @@ static int rsnd_src_quit(struct rsnd_mod *mod,
 	rsnd_mod_power_off(mod);
 
 	/* reset sync convert_rate */
-	src->sync.val = 0;
+	src->sync.val		=
+	src->current_sync_rate	= 0;
 
 	return 0;
 }
@@ -530,6 +584,22 @@ static irqreturn_t rsnd_src_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int rsnd_src_kctrl_accept_runtime(struct rsnd_dai_stream *io)
+{
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+
+	if (!runtime) {
+		struct rsnd_priv *priv = rsnd_io_to_priv(io);
+		struct device *dev = rsnd_priv_to_dev(priv);
+
+		dev_warn(dev, "\"SRC Out Rate\" can use during running\n");
+
+		return 0;
+	}
+
+	return 1;
+}
+
 static int rsnd_src_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -584,7 +654,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       "SRC Out Rate Switch" :
 			       "SRC In Rate Switch",
 			       rsnd_kctrl_accept_anytime,
-			       rsnd_src_set_convert_rate,
+			       rsnd_src_init_convert_rate,
 			       &src->sen, 1);
 	if (ret < 0)
 		return ret;
@@ -593,7 +663,7 @@ static int rsnd_src_pcm_new(struct rsnd_mod *mod,
 			       rsnd_io_is_play(io) ?
 			       "SRC Out Rate" :
 			       "SRC In Rate",
-			       rsnd_kctrl_accept_runtime,
+			       rsnd_src_kctrl_accept_runtime,
 			       rsnd_src_set_convert_rate,
 			       &src->sync, 192000);
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index b27e89ff6a16..b4cfc34d00ee 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -336,7 +336,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < 0)
 		return -EINVAL;
 	val = ucontrol->value.integer.value[0];
-	if (mc->platform_max && ((int)val + min) > mc->platform_max)
+	if (mc->platform_max && val > mc->platform_max)
 		return -EINVAL;
 	if (val > max - min)
 		return -EINVAL;
@@ -349,7 +349,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		if (ucontrol->value.integer.value[1] < 0)
 			return -EINVAL;
 		val2 = ucontrol->value.integer.value[1];
-		if (mc->platform_max && ((int)val2 + min) > mc->platform_max)
+		if (mc->platform_max && val2 > mc->platform_max)
 			return -EINVAL;
 		if (val2 > max - min)
 			return -EINVAL;
@@ -502,17 +502,16 @@ int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int platform_max;
-	int min = mc->min;
+	int max;
 
-	if (!mc->platform_max)
-		mc->platform_max = mc->max;
-	platform_max = mc->platform_max;
+	max = mc->max - mc->min;
+	if (mc->platform_max && mc->platform_max < max)
+		max = mc->platform_max;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = platform_max - min;
+	uinfo->value.integer.max = max;
 
 	return 0;
 }
diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index a0dfd7de431f..a75f81116643 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -282,6 +282,7 @@ int hda_codec_i915_exit(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_i915_exit, SND_SOC_SOF_HDA_AUDIO_CODEC_I915);
 
+MODULE_SOFTDEP("pre: snd-hda-codec-hdmi");
 #endif
 
 MODULE_LICENSE("Dual BSD/GPL");

