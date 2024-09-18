Return-Path: <stable+bounces-76708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC997BFAE
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1A283824
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E391CA6B8;
	Wed, 18 Sep 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHzaJILX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2651C9EC3;
	Wed, 18 Sep 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680663; cv=none; b=SlpzaoZFO8G8JkHfpkOsrMNXvkLUhC1VDHjQbcvAHIMnVsRptrRk2f2Qpx2084iQsSUlkeDuj8JdQb/S8TZJsXn/sSir8U7nbWpQo55VZXCcFIgasodCaiApY0RUXvQBGR5JJyWScVXKoHEekw1/CtsueOH3jVc2nyGP1sW5PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680663; c=relaxed/simple;
	bh=n/txWSa+ONxcMIHrs6SnrxkIbdLLFfJG3+95wKFkphI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St33smeUsmMudqb2I7woffgEPpQgOLyu5dcdLiseRkmoJbSux8l/5FnPgJWYpNeFxNKyubGtaTbcOr9ocDvQF5ikDMA599zO9BuA1ql4ETK+muis7HoUENb/jmwNlxtxvjxKTzy50P5mz3Ex8b6LcefvXjpmzjwRbiOEqNTPqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHzaJILX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE6FC4CEC2;
	Wed, 18 Sep 2024 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726680663;
	bh=n/txWSa+ONxcMIHrs6SnrxkIbdLLFfJG3+95wKFkphI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHzaJILXKYaYneiuaHptQAKXuyAOg0XL6l4/Jg0/V0pbNfzWrSSdwuHEOPStrYdJe
	 l0Lxya0qokWG1aCkYpIchOc+13rwMHe+hdQ7Fwt/YkwwXGSNmmNXNYfbgf5HYIcJm5
	 PKtnJKuEklN9ufq8VKnF3/o5Gi09qbrNmq4lKUZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.11
Date: Wed, 18 Sep 2024 19:30:51 +0200
Message-ID: <2024091850-skating-jolly-ac05@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024091849-crease-jovial-ff9d@gregkh>
References: <2024091849-crease-jovial-ff9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index af525ed29792..30d8342cacc8 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -109,7 +109,6 @@ attribute-sets:
       -
         name: port
         type: u16
-        byte-order: big-endian
       -
         name: flags
         type: u32
diff --git a/Makefile b/Makefile
index 9b4614c0fcbb..447856c43b32 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index a608a219543e..3e08e2fd0a78 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -387,7 +387,7 @@ led_pin: led-pin {
 
 	pmic {
 		pmic_int_l: pmic-int-l {
-			rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index ccbe3a7a1d2c..d24444cdf54a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -154,6 +154,22 @@ bios-disable-hog {
 	};
 };
 
+&gpio3 {
+	/*
+	 * The Qseven BIOS_DISABLE signal on the RK3399-Q7 keeps the on-module
+	 * eMMC and SPI flash powered-down initially (in fact it keeps the
+	 * reset signal asserted). BIOS_DISABLE_OVERRIDE pin allows to override
+	 * that signal so that eMMC and SPI can be used regardless of the state
+	 * of the signal.
+	 */
+	bios-disable-override-hog {
+		gpios = <RK_PD5 GPIO_ACTIVE_LOW>;
+		gpio-hog;
+		line-name = "bios_disable_override";
+		output-high;
+	};
+};
+
 &gmac {
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
@@ -409,6 +425,7 @@ vdd_cpu_b: regulator@60 {
 
 &i2s0 {
 	pinctrl-0 = <&i2s0_2ch_bus>;
+	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
 	rockchip,playback-channels = <2>;
 	rockchip,capture-channels = <2>;
 	status = "okay";
@@ -417,8 +434,8 @@ &i2s0 {
 /*
  * As Q7 does not specify neither a global nor a RX clock for I2S these
  * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
- * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
- * conflicts.
+ * Therefore we have to redefine the i2s0_2ch_bus and i2s0_2ch_bus_bclk_off
+ * definitions to prevent conflicts.
  */
 &i2s0_2ch_bus {
 	rockchip,pins =
@@ -428,6 +445,14 @@ &i2s0_2ch_bus {
 		<3 RK_PD7 1 &pcfg_pull_none>;
 };
 
+&i2s0_2ch_bus_bclk_off {
+	rockchip,pins =
+		<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+		<3 RK_PD2 1 &pcfg_pull_none>,
+		<3 RK_PD3 1 &pcfg_pull_none>,
+		<3 RK_PD7 1 &pcfg_pull_none>;
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;
@@ -449,9 +474,14 @@ &pcie_clkreqn_cpm {
 
 &pinctrl {
 	pinctrl-names = "default";
-	pinctrl-0 = <&q7_thermal_pin>;
+	pinctrl-0 = <&q7_thermal_pin &bios_disable_override_hog_pin>;
 
 	gpios {
+		bios_disable_override_hog_pin: bios-disable-override-hog-pin {
+			rockchip,pins =
+				<3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
 		q7_thermal_pin: q7-thermal-pin {
 			rockchip,pins =
 				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4bd2f87616ba..943430077375 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -959,6 +959,7 @@ void __init setup_arch(char **cmdline_p)
 	mem_topology_setup();
 	/* Set max_mapnr before paging_init() */
 	set_max_mapnr(max_pfn);
+	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
 
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d325217ab201..da21cb018984 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -290,8 +290,6 @@ void __init mem_init(void)
 	swiotlb_init(ppc_swiotlb_enable, ppc_swiotlb_flags);
 #endif
 
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-
 	kasan_late_init();
 
 	memblock_free_all();
diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 68d16717db8c..51d85f447626 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -354,6 +354,12 @@ spi_dev0: spi@0 {
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
+			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-rates = <500000000>, <1500000000>;
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index a03c994eed3b..b81672729887 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -158,6 +158,7 @@ void __init riscv_init_cbo_blocksizes(void)
 #ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
+	int cpu = get_cpu();
 	cpumask_t *mask;
 	bool stale_cpu;
 
@@ -168,10 +169,11 @@ static void set_icache_stale_mask(void)
 	 * concurrently on different harts.
 	 */
 	mask = &current->mm->context.icache_stale_mask;
-	stale_cpu = cpumask_test_cpu(smp_processor_id(), mask);
+	stale_cpu = cpumask_test_cpu(cpu, mask);
 
 	cpumask_setall(mask);
-	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
+	cpumask_assign_cpu(cpu, mask, stale_cpu);
+	put_cpu();
 }
 #endif
 
@@ -239,14 +241,12 @@ int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long scope)
 	case PR_RISCV_CTX_SW_FENCEI_OFF:
 		switch (scope) {
 		case PR_RISCV_SCOPE_PER_PROCESS:
-			current->mm->context.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->mm->context.force_icache_flush = false;
 			break;
 		case PR_RISCV_SCOPE_PER_THREAD:
-			current->thread.force_icache_flush = false;
-
 			set_icache_stale_mask();
+			current->thread.force_icache_flush = false;
 			break;
 		default:
 			return -EINVAL;
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c59d2b54df49..4f7ed0cd12cc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -602,6 +602,19 @@ config RANDOMIZE_BASE
 	  as a security feature that deters exploit attempts relying on
 	  knowledge of the location of kernel internals.
 
+config RANDOMIZE_IDENTITY_BASE
+	bool "Randomize the address of the identity mapping base"
+	depends on RANDOMIZE_BASE
+	default DEBUG_VM
+	help
+	  The identity mapping base address is pinned to zero by default.
+	  Allow randomization of that base to expose otherwise missed
+	  notion of physical and virtual addresses of data structures.
+	  That does not have any impact on the base address at which the
+	  kernel image is loaded.
+
+	  If unsure, say N
+
 config KERNEL_IMAGE_BASE
 	hex "Kernel image base address"
 	range 0x100000 0x1FFFFFE0000000 if !KASAN
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 66ee97ac803d..90c51368f933 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -333,7 +333,8 @@ static unsigned long setup_kernel_memory_layout(unsigned long kernel_size)
 	BUILD_BUG_ON(MAX_DCSS_ADDR > (1UL << MAX_PHYSMEM_BITS));
 	max_mappable = max(ident_map_size, MAX_DCSS_ADDR);
 	max_mappable = min(max_mappable, vmemmap_start);
-	__identity_base = round_down(vmemmap_start - max_mappable, rte_size);
+	if (IS_ENABLED(CONFIG_RANDOMIZE_IDENTITY_BASE))
+		__identity_base = round_down(vmemmap_start - max_mappable, rte_size);
 
 	return asce_limit;
 }
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..95eada2994e1 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -35,7 +35,6 @@
 #include <clocksource/hyperv_timer.h>
 #include <linux/highmem.h>
 
-int hyperv_init_cpuhp;
 u64 hv_current_partition_id = ~0ull;
 EXPORT_SYMBOL_GPL(hv_current_partition_id);
 
@@ -607,8 +606,6 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
-	hyperv_init_cpuhp = cpuhp;
-
 	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
 
@@ -637,7 +634,7 @@ void __init hyperv_init(void)
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
-	cpuhp_remove_state(cpuhp);
+	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
 free_vp_assist_page:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 390c4d13956d..5f0bc6a6d025 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -40,7 +40,6 @@ static inline unsigned char hv_get_nmi_reason(void)
 }
 
 #if IS_ENABLED(CONFIG_HYPERV)
-extern int hyperv_init_cpuhp;
 extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..41632fb57796 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -199,8 +199,8 @@ static void hv_machine_shutdown(void)
 	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
 	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
 	 */
-	if (kexec_in_progress && hyperv_init_cpuhp > 0)
-		cpuhp_remove_state(hyperv_init_cpuhp);
+	if (kexec_in_progress)
+		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 
 	/* The function calls stop_other_cpus(). */
 	native_machine_shutdown();
@@ -449,9 +449,23 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-				/* To be supported: more work is required.  */
+				/*
+				 * Mark the Hyper-V TSC page feature as disabled
+				 * in a TDX VM without paravisor so that the
+				 * Invariant TSC, which is a better clocksource
+				 * anyway, is used instead.
+				 */
 				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
 
+				/*
+				 * The Invariant TSC is expected to be available
+				 * in a TDX VM without paravisor, but if not,
+				 * print a warning message. The slower Hyper-V MSR-based
+				 * Ref Counter should end up being the clocksource.
+				 */
+				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+					pr_warn("Hyper-V: Invariant TSC is unavailable\n");
+
 				/* HV_MSR_CRASH_CTL is unsupported. */
 				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
index 805f561725ae..b186e64d4813 100644
--- a/drivers/clk/sophgo/clk-cv18xx-ip.c
+++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
@@ -613,7 +613,7 @@ static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
 			return i;
 	}
 
-	unreachable();
+	BUG();
 }
 
 static int mmux_enable(struct clk_hw *hw)
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..99177835cade 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -137,7 +137,21 @@ static int hv_stimer_init(unsigned int cpu)
 	ce->name = "Hyper-V clockevent";
 	ce->features = CLOCK_EVT_FEAT_ONESHOT;
 	ce->cpumask = cpumask_of(cpu);
-	ce->rating = 1000;
+
+	/*
+	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
+	 * so the local APIC timer (lapic_clockevent) is the default timer in
+	 * such a VM. The Hyper-V timer is not preferred in such a VM because
+	 * it depends on the slow VM Reference Counter MSR (the Hyper-V TSC
+	 * page is not enbled in such a VM because the VM uses Invariant TSC
+	 * as a better clocksource and it's challenging to mark the Hyper-V
+	 * TSC page shared in very early boot).
+	 */
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_tdx())
+		ce->rating = 90;
+	else
+		ce->rating = 1000;
+
 	ce->set_state_shutdown = hv_ce_shutdown;
 	ce->set_state_oneshot = hv_ce_set_oneshot;
 	ce->set_next_event = hv_ce_set_next_event;
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..6b6ae9c81368 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
 	return cxlrd->cxlsd.target[n];
 }
 
+static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
+{
+	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
+	int hbiw = cxlrd->cxlsd.nr_targets;
+	u64 val;
+	int pos;
+
+	/* No xormaps for host bridge interleave ways of 1 or 3 */
+	if (hbiw == 1 || hbiw == 3)
+		return hpa;
+
+	/*
+	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
+	 * the position bit to its value before the xormap was applied at
+	 * HPA->DPA translation.
+	 *
+	 * pos is the lowest set bit in an XORMAP
+	 * val is the XORALLBITS(HPA & XORMAP)
+	 *
+	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
+	 * as an operation that outputs a single bit by XORing all the
+	 * bits in the input (hpa & xormap). Implement XORALLBITS using
+	 * hweight64(). If the hamming weight is even the XOR of those
+	 * bits results in val==0, if odd the XOR result is val==1.
+	 */
+
+	for (int i = 0; i < cximsd->nr_maps; i++) {
+		if (!cximsd->xormaps[i])
+			continue;
+		pos = __ffs(cximsd->xormaps[i]);
+		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
+		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
+	}
+
+	return hpa;
+}
+
 struct cxl_cxims_context {
 	struct device *dev;
 	struct cxl_root_decoder *cxlrd;
@@ -434,6 +471,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxlrd->qos_class = cfmws->qtg_id;
 
+	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR)
+		cxlrd->hpa_to_spa = cxl_xor_hpa_to_spa;
+
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0e30e0a29d40..3345ccbade0b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2830,20 +2830,13 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
 	return ctx.cxlr;
 }
 
-static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int gran = p->interleave_granularity;
 	int ways = p->interleave_ways;
 	u64 offset;
 
-	/* Is the hpa within this region at all */
-	if (hpa < p->res->start || hpa > p->res->end) {
-		dev_dbg(&cxlr->dev,
-			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
-		return false;
-	}
-
 	/* Is the hpa in an expected chunk for its pos(-ition) */
 	offset = hpa - p->res->start;
 	offset = do_div(offset, gran * ways);
@@ -2859,6 +2852,7 @@ static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
 static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 			  struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
 	struct cxl_region_params *p = &cxlr->params;
 	int pos = cxled->pos;
@@ -2898,7 +2892,18 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
 	/* Apply the hpa_offset to the region base address */
 	hpa = hpa_offset + p->res->start;
 
-	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+	/* Root decoder translation overrides typical modulo decode */
+	if (cxlrd->hpa_to_spa)
+		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return ULLONG_MAX;
+	}
+
+	/* Simple chunk check, by pos & gran, only applies to modulo decodes */
+	if (!cxlrd->hpa_to_spa && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
 		return ULLONG_MAX;
 
 	return hpa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6613a6f8923..b8e16e8697e2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -436,12 +436,14 @@ struct cxl_switch_decoder {
 struct cxl_root_decoder;
 typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
 					    int pos);
+typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
 
 /**
  * struct cxl_root_decoder - Static platform CXL address decoder
  * @res: host / parent resource for region allocations
  * @region_id: region id for next region provisioning event
  * @calc_hb: which host bridge covers the n'th position by granularity
+ * @hpa_to_spa: translate CXL host-physical-address to Platform system-physical-address
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
  * @qos_class: QoS performance class cookie
@@ -451,6 +453,7 @@ struct cxl_root_decoder {
 	struct resource *res;
 	atomic_t region_id;
 	cxl_calc_hb_fn calc_hb;
+	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
 	struct mutex range_lock;
 	int qos_class;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index af8169ccdbc0..feb1106559d2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -563,7 +563,7 @@ enum cxl_opcode {
 		  0x3b, 0x3f, 0x17)
 
 #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
-	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
+	UUID_INIT(0x5e1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
 struct cxl_mbox_get_supported_logs {
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 4a63567e93ba..20dbe9265ad7 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -165,7 +165,7 @@ static vm_fault_t cma_heap_vm_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct cma_heap_buffer *buffer = vma->vm_private_data;
 
-	if (vmf->pgoff > buffer->pagecount)
+	if (vmf->pgoff >= buffer->pagecount)
 		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_pfn(vma, vmf->address, page_to_pfn(buffer->pages[vmf->pgoff]));
diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index bc550ad0dbe0..68b2c09ed22c 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -786,6 +786,10 @@ static int qcuefi_set_reference(struct qcuefi_client *qcuefi)
 static struct qcuefi_client *qcuefi_acquire(void)
 {
 	mutex_lock(&__qcuefi_lock);
+	if (!__qcuefi) {
+		mutex_unlock(&__qcuefi_lock);
+		return NULL;
+	}
 	return __qcuefi;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 1a5439abd1a0..c87d68d4be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -461,8 +461,11 @@ struct amdgpu_vcn5_fw_shared {
 	struct amdgpu_fw_shared_unified_queue_struct sq;
 	uint8_t pad1[8];
 	struct amdgpu_fw_shared_fw_logging fw_log;
+	uint8_t pad2[20];
 	struct amdgpu_fw_shared_rb_setup rb_setup;
-	uint8_t pad2[4];
+	struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
+	struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
+	uint8_t pad3[9];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 77595e9622da..7ac0228fe532 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "vcn_v1_0.h"
@@ -34,6 +35,9 @@
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring);
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib);
 
 static void jpeg_v1_0_decode_ring_patch_wreg(struct amdgpu_ring *ring, uint32_t *ptr, uint32_t reg_offset, uint32_t val)
 {
@@ -300,7 +304,10 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID), 0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0, 0, PACKETJ_TYPE0));
@@ -554,6 +561,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
 	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
 	.set_wptr = jpeg_v1_0_decode_ring_set_wptr,
+	.parse_cs = jpeg_v1_dec_ring_parse_cs,
 	.emit_frame_size =
 		6 + 6 + /* hdp invalidate / flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
@@ -612,3 +620,69 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 
 	vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
 }
+
+/**
+ * jpeg_v1_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib)
+{
+	u32 i, reg, res, cond, type;
+	int ret = 0;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res || cond != PACKETJ_CONDITION_CHECK0) /* only allow 0 for now */
+			return -EINVAL;
+
+		if (reg >= JPEG_V1_REG_RANGE_START && reg <= JPEG_V1_REG_RANGE_END)
+			continue;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_REG_CTX_INDEX &&
+			    reg != JPEG_V1_REG_CTX_DATA) {
+				ret = -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE1:
+			if (reg != JPEG_V1_REG_CTX_DATA)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE3:
+			if (reg != JPEG_V1_REG_SOFT_RESET)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] != CP_PACKETJ_NOP)
+				ret = -EINVAL;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		if (ret) {
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
index bbf33a6a3972..9654d22e0376 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
@@ -29,4 +29,15 @@ int jpeg_v1_0_sw_init(void *handle);
 void jpeg_v1_0_sw_fini(void *handle);
 void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
 
+#define JPEG_V1_REG_RANGE_START	0x8000
+#define JPEG_V1_REG_RANGE_END	0x803f
+
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH	0x8238
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW	0x8239
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH	0x825a
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW	0x825b
+#define JPEG_V1_REG_CTX_INDEX			0x8328
+#define JPEG_V1_REG_CTX_DATA			0x8329
+#define JPEG_V1_REG_SOFT_RESET			0x83a0
+
 #endif /*__JPEG_V1_0_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 63f84ef6dfcf..9e9bcf184df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -543,7 +544,11 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -769,6 +774,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -816,3 +822,58 @@ const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.rev = 0,
 		.funcs = &jpeg_v2_0_ip_funcs,
 };
+
+/**
+ * jpeg_v2_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			      struct amdgpu_job *job,
+			      struct amdgpu_ib *ib)
+{
+	u32 i, reg, res, cond, type;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START ||
+			    reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START ||
+			    reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			return -EINVAL;
+		default:
+			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83e2c..63fadda7a673 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -45,6 +45,9 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
@@ -57,6 +60,9 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
+int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			      struct amdgpu_job *job,
+			      struct amdgpu_ib *ib);
 
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index afeaf3c64e27..c27f2d30ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -664,6 +664,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -693,6 +694,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 1c7cf4800bf7..5cdd3897358e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -567,6 +567,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 237fe5df5a8f..0115f83bbde6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -729,6 +729,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
index 07d36c2abd6b..47638fd4d4e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
@@ -32,5 +32,4 @@ enum amdgpu_jpeg_v4_0_sub_block {
 };
 
 extern const struct amdgpu_ip_block_version jpeg_v4_0_ip_block;
-
 #endif /* __JPEG_V4_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index d24d06f6d682..dfce56d672ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -23,9 +23,9 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "jpeg_v2_0.h"
 #include "jpeg_v4_0_3.h"
 #include "mmsch_v4_0_3.h"
 
@@ -1068,7 +1068,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1233,56 +1233,3 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.ras = &jpeg_v4_0_3_ras;
 }
-
-/**
- * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
- *
- * @parser: Command submission parser context
- * @job: the job to parse
- * @ib: the IB to parse
- *
- * Parse the command stream, return -EINVAL for invalid packet,
- * 0 otherwise
- */
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			     struct amdgpu_job *job,
-			     struct amdgpu_ib *ib)
-{
-	uint32_t i, reg, res, cond, type;
-	struct amdgpu_device *adev = parser->adev;
-
-	for (i = 0; i < ib->length_dw ; i += 2) {
-		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
-		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
-		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
-		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
-
-		if (res) /* only support 0 at the moment */
-			return -EINVAL;
-
-		switch (type) {
-		case PACKETJ_TYPE0:
-			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE3:
-			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE6:
-			if (ib->ptr[i] == CP_PACKETJ_NOP)
-				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-			return -EINVAL;
-		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 71c54b294e15..747a3e5f6856 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,9 +46,6 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-#define JPEG_REG_RANGE_START						0x4000
-#define JPEG_REG_RANGE_END						0x41c2
-
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
@@ -65,7 +62,5 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					uint32_t val, uint32_t mask);
-int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-				  struct amdgpu_job *job,
-				  struct amdgpu_ib *ib);
+
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 4c8f9772437b..713cedd57c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -772,6 +772,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 90299f66a444..1036867d35c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -26,6 +26,7 @@
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
+#include "jpeg_v2_0.h"
 #include "jpeg_v4_0_3.h"
 
 #include "vcn/vcn_5_0_0_offset.h"
@@ -523,7 +524,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
+	.parse_cs = jpeg_v2_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 872f994dd356..422eb1d2c5d3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3223,15 +3223,19 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 	 * as well.
 	 */
 	for (i = 0; i < num_pipes; i++) {
-		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
-			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
-				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-					pipe_ctx[i]->stream_res.tg, &params);
+		/* dc_state_destruct() might null the stream resources, so fetch tg
+		 * here first to avoid a race condition. The lifetime of the pointee
+		 * itself (the timing_generator object) is not a problem here.
+		 */
+		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
+
+		if ((tg != NULL) && tg->funcs) {
+			if (tg->funcs->set_drr)
+				tg->funcs->set_drr(tg, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
-					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-						pipe_ctx[i]->stream_res.tg,
-						event_triggers, num_frames);
+				if (tg->funcs->set_static_screen_control)
+					tg->funcs->set_static_screen_control(
+						tg, event_triggers, num_frames);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index f829ff82797e..4f0e9e0f701d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1371,7 +1371,13 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 	params.vertical_total_mid_frame_num = adjust.v_total_mid_frame_num;
 
 	for (i = 0; i < num_pipes; i++) {
-		if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs) {
+		/* dc_state_destruct() might null the stream resources, so fetch tg
+		 * here first to avoid a race condition. The lifetime of the pointee
+		 * itself (the timing_generator object) is not a problem here.
+		 */
+		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
+
+		if ((tg != NULL) && tg->funcs) {
 			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
 			struct dc *dc = pipe_ctx[i]->stream->ctx->dc;
 
@@ -1384,14 +1390,12 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 					num_frames = 2 * (frame_rate % 60);
 				}
 			}
-			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
-				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-					pipe_ctx[i]->stream_res.tg, &params);
+			if (tg->funcs->set_drr)
+				tg->funcs->set_drr(tg, &params);
 			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
-					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-						pipe_ctx[i]->stream_res.tg,
-						event_triggers, num_frames);
+				if (tg->funcs->set_static_screen_control)
+					tg->funcs->set_static_screen_control(
+						tg, event_triggers, num_frames);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 2fa4e64e2430..bafa52a0165a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -147,32 +147,25 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
+	if (link_enc->funcs->fec_set_ready == NULL)
+		return DC_NOT_SUPPORTED;
 
-	if (!dp_should_enable_fec(link))
-		return status;
-
-	if (link_enc->funcs->fec_set_ready &&
-			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
-		if (ready) {
-			fec_config = 1;
-			status = core_link_write_dpcd(link,
-					DP_FEC_CONFIGURATION,
-					&fec_config,
-					sizeof(fec_config));
-			if (status == DC_OK) {
-				link_enc->funcs->fec_set_ready(link_enc, true);
-				link->fec_state = dc_link_fec_ready;
-			} else {
-				link_enc->funcs->fec_set_ready(link_enc, false);
-				link->fec_state = dc_link_fec_not_ready;
-				dm_error("dpcd write failed to set fec_ready");
-			}
-		} else if (link->fec_state == dc_link_fec_ready) {
+	if (ready && dp_should_enable_fec(link)) {
+		fec_config = 1;
+
+		status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+				&fec_config, sizeof(fec_config));
+
+		if (status == DC_OK) {
+			link_enc->funcs->fec_set_ready(link_enc, true);
+			link->fec_state = dc_link_fec_ready;
+		}
+	} else {
+		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			status = core_link_write_dpcd(link,
-					DP_FEC_CONFIGURATION,
-					&fec_config,
-					sizeof(fec_config));
+			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+				&fec_config, sizeof(fec_config));
+
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
 		}
@@ -187,14 +180,12 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
-
-	if (!dp_should_enable_fec(link))
+	if (link_enc->funcs->fec_set_enable == NULL)
 		return;
 
-	if (link_enc->funcs->fec_set_enable &&
-			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
-		if (link->fec_state == dc_link_fec_ready && enable) {
-			/* Accord to DP spec, FEC enable sequence can first
+	if (enable && dp_should_enable_fec(link)) {
+		if (link->fec_state == dc_link_fec_ready) {
+			/* According to DP spec, FEC enable sequence can first
 			 * be transmitted anytime after 1000 LL codes have
 			 * been transmitted on the link after link training
 			 * completion. Using 1 lane RBR should have the maximum
@@ -204,7 +195,9 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 			udelay(7);
 			link_enc->funcs->fec_set_enable(link_enc, true);
 			link->fec_state = dc_link_fec_enabled;
-		} else if (link->fec_state == dc_link_fec_enabled && !enable) {
+		}
+	} else {
+		if (link->fec_state == dc_link_fec_enabled) {
 			link_enc->funcs->fec_set_enable(link_enc, false);
 			link->fec_state = dc_link_fec_ready;
 		}
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 09cbc3afd6d8..b0fc22383e28 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1038,7 +1038,7 @@ struct display_object_info_table_v1_4
   uint16_t  supporteddevices;
   uint8_t   number_of_path;
   uint8_t   reserved;
-  struct    atom_display_object_path_v2 display_path[8];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
+  struct    atom_display_object_path_v2 display_path[];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
 };
 
 struct display_object_info_table_v1_5 {
@@ -1048,7 +1048,7 @@ struct display_object_info_table_v1_5 {
 	uint8_t reserved;
 	// the real number of this included in the structure is calculated by using the
 	// (whole structure size - the header size- number_of_path)/size of atom_display_object_path
-	struct atom_display_object_path_v3 display_path[8];
+	struct atom_display_object_path_v3 display_path[];
 };
 
 /* 
diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 903f4bfea7e8..70c9bd25f78d 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index a0e94217b511..4fcfc0b9b386 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1464,6 +1464,7 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	struct drm_syncobj *syncobj;
 	struct eventfd_ctx *ev_fd_ctx;
 	struct syncobj_eventfd_entry *entry;
+	int ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
 		return -EOPNOTSUPP;
@@ -1479,13 +1480,15 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 		return -ENOENT;
 
 	ev_fd_ctx = eventfd_ctx_fdget(args->fd);
-	if (IS_ERR(ev_fd_ctx))
-		return PTR_ERR(ev_fd_ctx);
+	if (IS_ERR(ev_fd_ctx)) {
+		ret = PTR_ERR(ev_fd_ctx);
+		goto err_fdget;
+	}
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
-		eventfd_ctx_put(ev_fd_ctx);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_kzalloc;
 	}
 	entry->syncobj = syncobj;
 	entry->ev_fd_ctx = ev_fd_ctx;
@@ -1496,6 +1499,12 @@ drm_syncobj_eventfd_ioctl(struct drm_device *dev, void *data,
 	drm_syncobj_put(syncobj);
 
 	return 0;
+
+err_kzalloc:
+	eventfd_ctx_put(ev_fd_ctx);
+err_fdget:
+	drm_syncobj_put(syncobj);
+	return ret;
 }
 
 int
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 0eaa1064242c..f8e189a73a79 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -2842,9 +2842,9 @@ static void prepare_context_registration_info_v70(struct intel_context *ce,
 		ce->parallel.guc.wqi_tail = 0;
 		ce->parallel.guc.wqi_head = 0;
 
-		wq_desc_offset = i915_ggtt_offset(ce->state) +
+		wq_desc_offset = (u64)i915_ggtt_offset(ce->state) +
 				 __get_parent_scratch_offset(ce);
-		wq_base_offset = i915_ggtt_offset(ce->state) +
+		wq_base_offset = (u64)i915_ggtt_offset(ce->state) +
 				 __get_wq_offset(ce);
 		info->wq_desc_lo = lower_32_bits(wq_desc_offset);
 		info->wq_desc_hi = upper_32_bits(wq_desc_offset);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 56f409ad7f39..ab2bace792e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -539,8 +539,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	}
 
 	/* IGT will check if the cursor size is configured */
-	drm->mode_config.cursor_width = drm->mode_config.max_width;
-	drm->mode_config.cursor_height = drm->mode_config.max_height;
+	drm->mode_config.cursor_width = 512;
+	drm->mode_config.cursor_height = 512;
 
 	/* Use OVL device for all DMA memory allocations */
 	crtc = drm_crtc_from_index(drm, 0);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 074fb498706f..b93ed15f04a3 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -99,7 +99,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		 * was a bad idea, and is only provided for backwards
 		 * compatibility for older targets.
 		 */
-		return -ENODEV;
+		return -ENOENT;
 	}
 
 	if (IS_ERR(fw)) {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
index 50f0c1914f58..4c3f74396579 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h
@@ -46,6 +46,8 @@ u32 gm107_ram_probe_fbp(const struct nvkm_ram_func *,
 u32 gm200_ram_probe_fbp_amount(const struct nvkm_ram_func *, u32,
 			       struct nvkm_device *, int, int *);
 
+int gp100_ram_init(struct nvkm_ram *);
+
 /* RAM type-specific MR calculation routines */
 int nvkm_sddr2_calc(struct nvkm_ram *);
 int nvkm_sddr3_calc(struct nvkm_ram *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
index 378f6fb70990..8987a21e81d1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp100.c
@@ -27,7 +27,7 @@
 #include <subdev/bios/init.h>
 #include <subdev/bios/rammap.h>
 
-static int
+int
 gp100_ram_init(struct nvkm_ram *ram)
 {
 	struct nvkm_subdev *subdev = &ram->fb->subdev;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
index 8550f5e47347..b6b6ee59019d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgp102.c
@@ -5,6 +5,7 @@
 
 static const struct nvkm_ram_func
 gp102_ram = {
+	.init = gp100_ram_init,
 };
 
 int
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
index cd4632276141..68ade1a05ca9 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
@@ -96,7 +96,7 @@ static inline struct drm_i915_private *kdev_to_i915(struct device *kdev)
 #define HAS_GMD_ID(xe) GRAPHICS_VERx100(xe) >= 1270
 
 /* Workarounds not handled yet */
-#define IS_DISPLAY_STEP(xe, first, last) ({u8 __step = (xe)->info.step.display; first <= __step && __step <= last; })
+#define IS_DISPLAY_STEP(xe, first, last) ({u8 __step = (xe)->info.step.display; first <= __step && __step < last; })
 
 #define IS_LP(xe) (0)
 #define IS_GEN9_LP(xe) (0)
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index b6f3a43d637f..f5e3012eff20 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1539,7 +1539,7 @@ struct xe_bo *xe_bo_create_from_data(struct xe_device *xe, struct xe_tile *tile,
 	return bo;
 }
 
-static void __xe_bo_unpin_map_no_vm(struct drm_device *drm, void *arg)
+static void __xe_bo_unpin_map_no_vm(void *arg)
 {
 	xe_bo_unpin_map_no_vm(arg);
 }
@@ -1554,7 +1554,7 @@ struct xe_bo *xe_managed_bo_create_pin_map(struct xe_device *xe, struct xe_tile
 	if (IS_ERR(bo))
 		return bo;
 
-	ret = drmm_add_action_or_reset(&xe->drm, __xe_bo_unpin_map_no_vm, bo);
+	ret = devm_add_action_or_reset(xe->drm.dev, __xe_bo_unpin_map_no_vm, bo);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1602,7 +1602,7 @@ int xe_managed_bo_reinit_in_vram(struct xe_device *xe, struct xe_tile *tile, str
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
-	drmm_release_action(&xe->drm, __xe_bo_unpin_map_no_vm, *src);
+	devm_release_action(xe->drm.dev, __xe_bo_unpin_map_no_vm, *src);
 	*src = bo;
 
 	return 0;
diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 08f0b7c95901..ee15daa21507 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "xe_assert.h"
 #include "xe_bo.h"
 #include "xe_bo_types.h"
 #include "xe_device_types.h"
@@ -93,10 +94,13 @@ void xe_drm_client_add_bo(struct xe_drm_client *client,
  */
 void xe_drm_client_remove_bo(struct xe_bo *bo)
 {
+	struct xe_device *xe = ttm_to_xe_device(bo->ttm.bdev);
 	struct xe_drm_client *client = bo->client;
 
+	xe_assert(xe, !kref_read(&bo->ttm.base.refcount));
+
 	spin_lock(&client->bos_lock);
-	list_del(&bo->client_link);
+	list_del_init(&bo->client_link);
 	spin_unlock(&client->bos_lock);
 
 	xe_drm_client_put(client);
@@ -108,6 +112,8 @@ static void bo_meminfo(struct xe_bo *bo,
 	u64 sz = bo->size;
 	u32 mem_type;
 
+	xe_bo_assert_held(bo);
+
 	if (bo->placement.placement)
 		mem_type = bo->placement.placement->mem_type;
 	else
@@ -138,6 +144,7 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	struct xe_drm_client *client;
 	struct drm_gem_object *obj;
 	struct xe_bo *bo;
+	LLIST_HEAD(deferred);
 	unsigned int id;
 	u32 mem_type;
 
@@ -148,7 +155,20 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	idr_for_each_entry(&file->object_idr, obj, id) {
 		struct xe_bo *bo = gem_to_xe_bo(obj);
 
-		bo_meminfo(bo, stats);
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			xe_bo_get(bo);
+			spin_unlock(&file->table_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			xe_bo_put(bo);
+			spin_lock(&file->table_lock);
+		}
 	}
 	spin_unlock(&file->table_lock);
 
@@ -157,11 +177,28 @@ static void show_meminfo(struct drm_printer *p, struct drm_file *file)
 	list_for_each_entry(bo, &client->bos_list, client_link) {
 		if (!kref_get_unless_zero(&bo->ttm.base.refcount))
 			continue;
-		bo_meminfo(bo, stats);
-		xe_bo_put(bo);
+
+		if (dma_resv_trylock(bo->ttm.base.resv)) {
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+		} else {
+			spin_unlock(&client->bos_lock);
+
+			xe_bo_lock(bo, false);
+			bo_meminfo(bo, stats);
+			xe_bo_unlock(bo);
+
+			spin_lock(&client->bos_lock);
+			/* The bo ref will prevent this bo from being removed from the list */
+			xe_assert(xef->xe, !list_empty(&bo->client_link));
+		}
+
+		xe_bo_put_deferred(bo, &deferred);
 	}
 	spin_unlock(&client->bos_lock);
 
+	xe_bo_put_commit(&deferred);
+
 	for (mem_type = XE_PL_SYSTEM; mem_type < TTM_NUM_MEM_TYPES; ++mem_type) {
 		if (!xe_mem_type_to_name[mem_type])
 			continue;
diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 95c17b72fa57..c9a4ffcfdcca 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -256,7 +256,7 @@ static int gsc_upload_and_init(struct xe_gsc *gsc)
 	struct xe_tile *tile = gt_to_tile(gt);
 	int ret;
 
-	if (XE_WA(gt, 14018094691)) {
+	if (XE_WA(tile->primary_gt, 14018094691)) {
 		ret = xe_force_wake_get(gt_to_fw(tile->primary_gt), XE_FORCEWAKE_ALL);
 
 		/*
@@ -274,7 +274,7 @@ static int gsc_upload_and_init(struct xe_gsc *gsc)
 
 	ret = gsc_upload(gsc);
 
-	if (XE_WA(gt, 14018094691))
+	if (XE_WA(tile->primary_gt, 14018094691))
 		xe_force_wake_put(gt_to_fw(tile->primary_gt), XE_FORCEWAKE_ALL);
 
 	if (ret)
diff --git a/drivers/gpu/drm/xe/xe_wa.c b/drivers/gpu/drm/xe/xe_wa.c
index 66dafe980b9c..1f7699d7fffb 100644
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@ -542,6 +542,16 @@ static const struct xe_rtp_entry_sr engine_was[] = {
 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
 	},
 
+	/* Xe2_LPM */
+
+	{ XE_RTP_NAME("16021639441"),
+	  XE_RTP_RULES(MEDIA_VERSION(2000)),
+	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
+			     GHWSP_CSB_REPORT_DIS |
+			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
+			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
+	},
+
 	/* Xe2_HPM */
 
 	{ XE_RTP_NAME("16021639441"),
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 37e6d25593c2..a282388b7aa5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1248,6 +1248,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
 	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 72d56ee7ce1b..781c5aa29859 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -210,6 +210,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3	0x1a30
 #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
+#define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X		0x1b4c
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
 
@@ -520,6 +521,8 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
 #define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01E8	0x01e8
+#define I2C_DEVICE_ID_GOODIX_01E9	0x01e9
 #define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
 
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 56fc78841f24..99812c0f830b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1441,6 +1441,30 @@ static int mt_event(struct hid_device *hid, struct hid_field *field,
 	return 0;
 }
 
+static __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
+			     unsigned int *size)
+{
+	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
+	    (hdev->product == I2C_DEVICE_ID_GOODIX_01E8 ||
+	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9)) {
+		if (rdesc[607] == 0x15) {
+			rdesc[607] = 0x25;
+			dev_info(
+				&hdev->dev,
+				"GT7868Q report descriptor fixup is applied.\n");
+		} else {
+			dev_info(
+				&hdev->dev,
+				"The byte is not expected for fixing the report descriptor. \
+It's possible that the touchpad firmware is not suitable for applying the fix. \
+got: %x\n",
+				rdesc[607]);
+		}
+	}
+
+	return rdesc;
+}
+
 static void mt_report(struct hid_device *hid, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hid);
@@ -2035,6 +2059,14 @@ static const struct hid_device_id mt_devices[] = {
 		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
 			USB_DEVICE_ID_GAMETEL_MT_MODE) },
 
+	/* Goodix GT7868Q devices */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E8) },
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
+		     I2C_DEVICE_ID_GOODIX_01E8) },
+
 	/* GoodTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,
@@ -2270,6 +2302,7 @@ static struct hid_driver mt_driver = {
 	.feature_mapping = mt_feature_mapping,
 	.usage_table = mt_grabbed_usages,
 	.event = mt_event,
+	.report_fixup = mt_report_fixup,
 	.report = mt_report,
 	.suspend = pm_ptr(mt_suspend),
 	.reset_resume = pm_ptr(mt_reset_resume),
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index fb442fae7b3e..0bea603994e7 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -418,6 +418,12 @@ enum pmbus_sensor_classes {
 enum pmbus_data_format { linear = 0, ieee754, direct, vid };
 enum vrm_version { vr11 = 0, vr12, vr13, imvp9, amd625mv };
 
+/* PMBus revision identifiers */
+#define PMBUS_REV_10 0x00	/* PMBus revision 1.0 */
+#define PMBUS_REV_11 0x11	/* PMBus revision 1.1 */
+#define PMBUS_REV_12 0x22	/* PMBus revision 1.2 */
+#define PMBUS_REV_13 0x33	/* PMBus revision 1.3 */
+
 struct pmbus_driver_info {
 	int pages;		/* Total number of pages */
 	u8 phases[PMBUS_PAGES];	/* Number of phases per page */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cb4c65a7f288..e592446b2665 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -85,6 +85,8 @@ struct pmbus_data {
 
 	u32 flags;		/* from platform data */
 
+	u8 revision;	/* The PMBus revision the device is compliant with */
+
 	int exponent[PMBUS_PAGES];
 				/* linear mode: exponent for output voltages */
 
@@ -1095,9 +1097,14 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
 
 	regval = status & mask;
 	if (regval) {
-		ret = _pmbus_write_byte_data(client, page, reg, regval);
-		if (ret)
-			goto unlock;
+		if (data->revision >= PMBUS_REV_12) {
+			ret = _pmbus_write_byte_data(client, page, reg, regval);
+			if (ret)
+				goto unlock;
+		} else {
+			pmbus_clear_fault_page(client, page);
+		}
+
 	}
 	if (s1 && s2) {
 		s64 v1, v2;
@@ -2640,6 +2647,10 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 			data->flags |= PMBUS_WRITE_PROTECTED | PMBUS_SKIP_STATUS_CHECK;
 	}
 
+	ret = i2c_smbus_read_byte_data(client, PMBUS_REVISION);
+	if (ret >= 0)
+		data->revision = ret;
+
 	if (data->info->pages)
 		pmbus_clear_faults(client);
 	else
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a303a9d6bf7..cff3393f0dd0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -189,6 +189,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index e9eb9554dd7b..bad238f69a7a 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -627,6 +627,15 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
 	},
+	{
+		/* Fujitsu Lifebook E756 */
+		/* https://bugzilla.suse.com/show_bug.cgi?id=1229056 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E756"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Fujitsu Lifebook E5411 */
 		.matches = {
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4d13db13b9e5..b42096c797bf 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -805,7 +805,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 		m = &ts->msg[msg_idx];
 		error = spi_sync(ts->spi, m);
 		if (error) {
-			dev_err(&ts->spi->dev, "spi_sync --> %d\n", error);
+			dev_err_ratelimited(&ts->spi->dev, "spi_sync --> %d\n", error);
 			packet->ignore = true;
 			return;
 		}
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 06ec0f2e18ae..b0b5b6241b44 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1474,6 +1474,10 @@ static const struct edt_i2c_chip_data edt_ft6236_data = {
 	.max_support_points = 2,
 };
 
+static const struct edt_i2c_chip_data edt_ft8201_data = {
+	.max_support_points = 10,
+};
+
 static const struct edt_i2c_chip_data edt_ft8719_data = {
 	.max_support_points = 10,
 };
@@ -1485,6 +1489,7 @@ static const struct i2c_device_id edt_ft5x06_ts_id[] = {
 	{ .name = "ft5452", .driver_data = (long)&edt_ft5452_data },
 	/* Note no edt- prefix for compatibility with the ft6236.c driver */
 	{ .name = "ft6236", .driver_data = (long)&edt_ft6236_data },
+	{ .name = "ft8201", .driver_data = (long)&edt_ft8201_data },
 	{ .name = "ft8719", .driver_data = (long)&edt_ft8719_data },
 	{ /* sentinel */ }
 };
@@ -1499,6 +1504,7 @@ static const struct of_device_id edt_ft5x06_of_match[] = {
 	{ .compatible = "focaltech,ft5452", .data = &edt_ft5452_data },
 	/* Note focaltech vendor prefix for compatibility with ft6236.c */
 	{ .compatible = "focaltech,ft6236", .data = &edt_ft6236_data },
+	{ .compatible = "focaltech,ft8201", .data = &edt_ft8201_data },
 	{ .compatible = "focaltech,ft8719", .data = &edt_ft8719_data },
 	{ /* sentinel */ }
 };
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 417fddebe367..a74c22cb0f53 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2173,6 +2173,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 	unsigned int journal_section, journal_entry;
 	unsigned int journal_read_pos;
+	sector_t recalc_sector;
 	struct completion read_comp;
 	bool discard_retried = false;
 	bool need_sync_io = ic->internal_hash && dio->op == REQ_OP_READ;
@@ -2313,6 +2314,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 			goto lock_retry;
 		}
 	}
+	recalc_sector = le64_to_cpu(ic->sb->recalc_sector);
 	spin_unlock_irq(&ic->endio_wait.lock);
 
 	if (unlikely(journal_read_pos != NOT_FOUND)) {
@@ -2367,7 +2369,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 	if (need_sync_io) {
 		wait_for_completion_io(&read_comp);
 		if (ic->sb->flags & cpu_to_le32(SB_FLAG_RECALCULATING) &&
-		    dio->range.logical_sector + dio->range.n_sectors > le64_to_cpu(ic->sb->recalc_sector))
+		    dio->range.logical_sector + dio->range.n_sectors > recalc_sector)
 			goto skip_check;
 		if (ic->mode == 'B') {
 			if (!block_bitmap_op(ic, ic->recalc_bitmap, dio->range.logical_sector,
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index f1f766b70965..4eddc5ba1af9 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -42,7 +42,7 @@ static void digsy_mtc_op_finish(void *p)
 }
 
 struct eeprom_93xx46_platform_data digsy_mtc_eeprom_data = {
-	.flags		= EE_ADDR8,
+	.flags		= EE_ADDR8 | EE_SIZE1K,
 	.prepare	= digsy_mtc_op_prepare,
 	.finish		= digsy_mtc_op_finish,
 };
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 85952d841f28..bd061997618d 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1474,10 +1474,13 @@ static int vsc9959_qos_port_tas_set(struct ocelot *ocelot, int port,
 	/* Hardware errata -  Admin config could not be overwritten if
 	 * config is pending, need reset the TAS module
 	 */
-	val = ocelot_read(ocelot, QSYS_PARAM_STATUS_REG_8);
-	if (val & QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING) {
-		ret = -EBUSY;
-		goto err_reset_tc;
+	val = ocelot_read_rix(ocelot, QSYS_TAG_CONFIG, port);
+	if (val & QSYS_TAG_CONFIG_ENABLE) {
+		val = ocelot_read(ocelot, QSYS_PARAM_STATUS_REG_8);
+		if (val & QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING) {
+			ret = -EBUSY;
+			goto err_reset_tc;
+		}
 	}
 
 	ocelot_rmw_rix(ocelot,
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 63b3e02fab16..4968f6f0bdbc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -84,7 +84,7 @@
 			    FTGMAC100_INT_RPKT_BUF)
 
 /* All the interrupts we care about */
-#define FTGMAC100_INT_ALL (FTGMAC100_INT_RPKT_BUF  |  \
+#define FTGMAC100_INT_ALL (FTGMAC100_INT_RXTX  |  \
 			   FTGMAC100_INT_BAD)
 
 /*
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 946c3d3b69d9..669fb5804d3b 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2285,12 +2285,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
-	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
 	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
+	bool nonlinear;
 	int offset = 0;
 	int err = 0;
 
@@ -2300,6 +2300,13 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 
 	qm_fd_clear_fd(&fd);
 
+	/* Packet data is always read as 32-bit words, so zero out any part of
+	 * the skb which might be sent if we have to pad the packet
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		goto enomem;
+
+	nonlinear = skb_is_nonlinear(skb);
 	if (!nonlinear) {
 		/* We're going to store the skb backpointer at the beginning
 		 * of the data buffer, so we need a privately owned skb
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 465f0d582283..6c33195a1168 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11456,7 +11456,7 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
 	pci_free_irq_vectors(pdev);
-	pci_release_mem_regions(pdev);
+	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7076a7738864..c2ba58659347 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2413,13 +2413,6 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	struct ice_pf *pf = vsi->back;
 	int err;
 
-	/* The Rx rule will only exist to remove if the LLDP FW
-	 * engine is currently stopped
-	 */
-	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF &&
-	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
-		ice_cfg_sw_lldp(vsi, false, false);
-
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	err = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
 	if (err)
@@ -2764,6 +2757,14 @@ int ice_vsi_release(struct ice_vsi *vsi)
 		ice_rss_clean(vsi);
 
 	ice_vsi_close(vsi);
+
+	/* The Rx rule will only exist to remove if the LLDP FW
+	 * engine is currently stopped
+	 */
+	if (!ice_is_safe_mode(pf) && vsi->type == ICE_VSI_PF &&
+	    !test_bit(ICE_FLAG_FW_LLDP_AGENT, pf->flags))
+		ice_cfg_sw_lldp(vsi, false, false);
+
 	ice_vsi_decfg(vsi);
 
 	/* retain SW VSI data structure since it is needed to unregister and
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index ffd6c42bda1e..0b85b3653a68 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3219,7 +3219,7 @@ ice_add_update_vsi_list(struct ice_hw *hw,
 
 		/* A rule already exists with the new VSI being added */
 		if (test_bit(vsi_handle, m_entry->vsi_list_info->vsi_map))
-			return 0;
+			return -EEXIST;
 
 		/* Update the previously created VSI list set with
 		 * the new VSI ID passed in
@@ -3289,7 +3289,7 @@ ice_find_vsi_list_entry(struct ice_hw *hw, u8 recp_id, u16 vsi_handle,
 
 	list_head = &sw->recp_list[recp_id].filt_rules;
 	list_for_each_entry(list_itr, list_head, list_entry) {
-		if (list_itr->vsi_list_info) {
+		if (list_itr->vsi_count == 1 && list_itr->vsi_list_info) {
 			map_info = list_itr->vsi_list_info;
 			if (test_bit(vsi_handle, map_info->vsi_map)) {
 				*vsi_list_id = map_info->vsi_list_id;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a27d0a4d3d9c..6dc5c11aebbd 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -33,6 +33,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/pm_runtime.h>
 #include <linux/etherdevice.h>
+#include <linux/lockdep.h>
 #ifdef CONFIG_IGB_DCA
 #include <linux/dca.h>
 #endif
@@ -2915,8 +2916,11 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+/* This function assumes __netif_tx_lock is held by the caller. */
 static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
+	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
 	 */
@@ -3001,11 +3005,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -8865,12 +8869,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8998,7 +9004,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..d8be0e4dcb07 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 35834687e40f..96a7b23428be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -318,6 +318,7 @@ struct nix_mark_format {
 
 /* smq(flush) to tl1 cir/pir info */
 struct nix_smq_tree_ctx {
+	u16 schq;
 	u64 cir_off;
 	u64 cir_val;
 	u64 pir_off;
@@ -327,8 +328,6 @@ struct nix_smq_tree_ctx {
 /* smq flush context */
 struct nix_smq_flush_ctx {
 	int smq;
-	u16 tl1_schq;
-	u16 tl2_schq;
 	struct nix_smq_tree_ctx smq_tree_ctx[NIX_TXSCH_LVL_CNT];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 3dc828cf6c5a..10f8efff7843 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2259,14 +2259,13 @@ static void nix_smq_flush_fill_ctx(struct rvu *rvu, int blkaddr, int smq,
 	schq = smq;
 	for (lvl = NIX_TXSCH_LVL_SMQ; lvl <= NIX_TXSCH_LVL_TL1; lvl++) {
 		smq_tree_ctx = &smq_flush_ctx->smq_tree_ctx[lvl];
+		smq_tree_ctx->schq = schq;
 		if (lvl == NIX_TXSCH_LVL_TL1) {
-			smq_flush_ctx->tl1_schq = schq;
 			smq_tree_ctx->cir_off = NIX_AF_TL1X_CIR(schq);
 			smq_tree_ctx->pir_off = 0;
 			smq_tree_ctx->pir_val = 0;
 			parent_off = 0;
 		} else if (lvl == NIX_TXSCH_LVL_TL2) {
-			smq_flush_ctx->tl2_schq = schq;
 			smq_tree_ctx->cir_off = NIX_AF_TL2X_CIR(schq);
 			smq_tree_ctx->pir_off = NIX_AF_TL2X_PIR(schq);
 			parent_off = NIX_AF_TL2X_PARENT(schq);
@@ -2301,8 +2300,8 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
 {
 	struct nix_txsch *txsch;
 	struct nix_hw *nix_hw;
+	int tl2, tl2_schq;
 	u64 regoff;
-	int tl2;
 
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
 	if (!nix_hw)
@@ -2310,16 +2309,17 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
 
 	/* loop through all TL2s with matching PF_FUNC */
 	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_TL2];
+	tl2_schq = smq_flush_ctx->smq_tree_ctx[NIX_TXSCH_LVL_TL2].schq;
 	for (tl2 = 0; tl2 < txsch->schq.max; tl2++) {
 		/* skip the smq(flush) TL2 */
-		if (tl2 == smq_flush_ctx->tl2_schq)
+		if (tl2 == tl2_schq)
 			continue;
 		/* skip unused TL2s */
 		if (TXSCH_MAP_FLAGS(txsch->pfvf_map[tl2]) & NIX_TXSCHQ_FREE)
 			continue;
 		/* skip if PF_FUNC doesn't match */
 		if ((TXSCH_MAP_FUNC(txsch->pfvf_map[tl2]) & ~RVU_PFVF_FUNC_MASK) !=
-		    (TXSCH_MAP_FUNC(txsch->pfvf_map[smq_flush_ctx->tl2_schq] &
+		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq] &
 				    ~RVU_PFVF_FUNC_MASK)))
 			continue;
 		/* enable/disable XOFF */
@@ -2361,10 +2361,12 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 			 int smq, u16 pcifunc, int nixlf)
 {
 	struct nix_smq_flush_ctx *smq_flush_ctx;
+	int err, restore_tx_en = 0, i;
 	int pf = rvu_get_pf(pcifunc);
 	u8 cgx_id = 0, lmac_id = 0;
-	int err, restore_tx_en = 0;
-	u64 cfg;
+	u16 tl2_tl3_link_schq;
+	u8 link, link_level;
+	u64 cfg, bmap = 0;
 
 	if (!is_rvu_otx2(rvu)) {
 		/* Skip SMQ flush if pkt count is zero */
@@ -2388,16 +2390,38 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, true);
 	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, false);
 
-	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
-	/* Do SMQ flush and set enqueue xoff */
-	cfg |= BIT_ULL(50) | BIT_ULL(49);
-	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
-
 	/* Disable backpressure from physical link,
 	 * otherwise SMQ flush may stall.
 	 */
 	rvu_cgx_enadis_rx_bp(rvu, pf, false);
 
+	link_level = rvu_read64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL) & 0x01 ?
+			NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
+	tl2_tl3_link_schq = smq_flush_ctx->smq_tree_ctx[link_level].schq;
+	link = smq_flush_ctx->smq_tree_ctx[NIX_TXSCH_LVL_TL1].schq;
+
+	/* SMQ set enqueue xoff */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
+	cfg |= BIT_ULL(50);
+	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
+
+	/* Clear all NIX_AF_TL3_TL2_LINK_CFG[ENA] for the TL3/TL2 queue */
+	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
+		cfg = rvu_read64(rvu, blkaddr,
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+		if (!(cfg & BIT_ULL(12)))
+			continue;
+		bmap |= (1 << i);
+		cfg &= ~BIT_ULL(12);
+		rvu_write64(rvu, blkaddr,
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+	}
+
+	/* Do SMQ flush and set enqueue xoff */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
+	cfg |= BIT_ULL(50) | BIT_ULL(49);
+	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
+
 	/* Wait for flush to complete */
 	err = rvu_poll_reg(rvu, blkaddr,
 			   NIX_AF_SMQX_CFG(smq), BIT_ULL(49), true);
@@ -2406,6 +2430,17 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 			 "NIXLF%d: SMQ%d flush failed, txlink might be busy\n",
 			 nixlf, smq);
 
+	/* Set NIX_AF_TL3_TL2_LINKX_CFG[ENA] for the TL3/TL2 queue */
+	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
+		if (!(bmap & (1 << i)))
+			continue;
+		cfg = rvu_read64(rvu, blkaddr,
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+		cfg |= BIT_ULL(12);
+		rvu_write64(rvu, blkaddr,
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+	}
+
 	/* clear XOFF on TL2s */
 	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, true);
 	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 58eb96a68853..9d2d67e24205 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -139,6 +139,10 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100GBASE_LR4, legacy,
 				       ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100BASE_TX, legacy,
+				       ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1000BASE_T, legacy,
+				       ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_10GBASE_T, legacy,
 				       ETHTOOL_LINK_MODE_10000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_25GBASE_CR, legacy,
@@ -204,6 +208,12 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_400GAUI_8_400GBASE_CR8, ext,
+				       ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100GAUI_1_100GBASE_CR_KR, ext,
 				       ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
 				       ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 255bc8b749f9..8587cd572da5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -319,7 +319,7 @@ int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting)
 		return -EPERM;
 
 	mutex_lock(&esw->state_lock);
-	if (esw->mode != MLX5_ESWITCH_LEGACY) {
+	if (esw->mode != MLX5_ESWITCH_LEGACY || !mlx5_esw_is_fdb_created(esw)) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
@@ -339,7 +339,7 @@ int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting)
 	if (!mlx5_esw_allowed(esw))
 		return -EPERM;
 
-	if (esw->mode != MLX5_ESWITCH_LEGACY)
+	if (esw->mode != MLX5_ESWITCH_LEGACY || !mlx5_esw_is_fdb_created(esw))
 		return -EOPNOTSUPP;
 
 	*setting = esw->fdb_table.legacy.vepa_uplink_rule ? 1 : 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d2ebe56c3977..02a3563f51ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -312,6 +312,25 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 	return err;
 }
 
+static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
+{
+	switch (type) {
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_TSAR;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_VPORT;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_VPORT_TC;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
+		return MLX5_CAP_QOS(dev, esw_element_type) &
+		       ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
+	}
+	return false;
+}
+
 static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 					      struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
@@ -323,6 +342,9 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	void *vport_elem;
 	int err;
 
+	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT))
+		return -EOPNOTSUPP;
+
 	parent_tsar_ix = group ? group->tsar_ix : esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
@@ -421,6 +443,7 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
+	__be32 *attr;
 	u32 divider;
 	int err;
 
@@ -428,6 +451,12 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	*attr = cpu_to_be32(TSAR_ELEMENT_TSAR_TYPE_DWRR << 16);
+
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 esw->qos.root_tsar_ix);
 	err = mlx5_create_scheduling_element_cmd(esw->dev,
@@ -526,25 +555,6 @@ static int esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
 	return err;
 }
 
-static bool esw_qos_element_type_supported(struct mlx5_core_dev *dev, int type)
-{
-	switch (type) {
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_TASR;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_VPORT_TC;
-	case SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC:
-		return MLX5_CAP_QOS(dev, esw_element_type) &
-		       ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
-	}
-	return false;
-}
-
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
@@ -555,7 +565,8 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR))
+	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR) ||
+	    !(MLX5_CAP_QOS(dev, esw_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 3e55a6c6a7c9..211194df9619 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2215,6 +2215,7 @@ static const struct pci_device_id mlx5_core_pci_table[] = {
 	{ PCI_VDEVICE(MELLANOX, 0x101f) },			/* ConnectX-6 LX */
 	{ PCI_VDEVICE(MELLANOX, 0x1021) },			/* ConnectX-7 */
 	{ PCI_VDEVICE(MELLANOX, 0x1023) },			/* ConnectX-8 */
+	{ PCI_VDEVICE(MELLANOX, 0x1025) },			/* ConnectX-9 */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d2) },			/* BlueField integrated ConnectX-5 network controller */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d3), MLX5_PCI_DEV_IS_VF},	/* BlueField integrated ConnectX-5 network controller VF */
 	{ PCI_VDEVICE(MELLANOX, 0xa2d6) },			/* BlueField-2 integrated ConnectX-6 Dx network controller */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
index 8bce730b5c5b..db2bd3ad63ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qos.c
@@ -28,6 +28,9 @@ int mlx5_qos_create_leaf_node(struct mlx5_core_dev *mdev, u32 parent_id,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 
+	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP))
+		return -EOPNOTSUPP;
+
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP);
@@ -44,6 +47,10 @@ int mlx5_qos_create_inner_node(struct mlx5_core_dev *mdev, u32 parent_id,
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {0};
 	void *attr;
 
+	if (!(MLX5_CAP_QOS(mdev, nic_element_type) & ELEMENT_TYPE_CAP_MASK_TSAR) ||
+	    !(MLX5_CAP_QOS(mdev, nic_tsar_type) & TSAR_TYPE_CAP_MASK_DWRR))
+		return -EOPNOTSUPP;
+
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_id);
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 0df7f5712b6f..9f98f5749064 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -424,9 +424,9 @@ enum WX_MSCA_CMD_value {
 #define WX_MIN_RXD                   128
 #define WX_MIN_TXD                   128
 
-/* Number of Transmit and Receive Descriptors must be a multiple of 8 */
-#define WX_REQ_RX_DESCRIPTOR_MULTIPLE   8
-#define WX_REQ_TX_DESCRIPTOR_MULTIPLE   8
+/* Number of Transmit and Receive Descriptors must be a multiple of 128 */
+#define WX_REQ_RX_DESCRIPTOR_MULTIPLE   128
+#define WX_REQ_TX_DESCRIPTOR_MULTIPLE   128
 
 #define WX_MAX_JUMBO_FRAME_SIZE      9432 /* max payload 9414 */
 #define VMDQ_P(p)                    p
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index efeb643c1373..fc247f479257 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -271,8 +271,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
 				DP83822_ENERGY_DET_INT_EN |
 				DP83822_LINK_QUAL_INT_EN);
 
-		/* Private data pointer is NULL on DP83825 */
-		if (!dp83822 || !dp83822->fx_enabled)
+		if (!dp83822->fx_enabled)
 			misr_status |= DP83822_ANEG_COMPLETE_INT_EN |
 				       DP83822_DUP_MODE_CHANGE_INT_EN |
 				       DP83822_SPEED_CHANGED_INT_EN;
@@ -292,8 +291,7 @@ static int dp83822_config_intr(struct phy_device *phydev)
 				DP83822_PAGE_RX_INT_EN |
 				DP83822_EEE_ERROR_CHANGE_INT_EN);
 
-		/* Private data pointer is NULL on DP83825 */
-		if (!dp83822 || !dp83822->fx_enabled)
+		if (!dp83822->fx_enabled)
 			misr_status |= DP83822_ANEG_ERR_INT_EN |
 				       DP83822_WOL_PKT_INT_EN;
 
@@ -691,10 +689,9 @@ static int dp83822_read_straps(struct phy_device *phydev)
 	return 0;
 }
 
-static int dp83822_probe(struct phy_device *phydev)
+static int dp8382x_probe(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822;
-	int ret;
 
 	dp83822 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
 			       GFP_KERNEL);
@@ -703,6 +700,20 @@ static int dp83822_probe(struct phy_device *phydev)
 
 	phydev->priv = dp83822;
 
+	return 0;
+}
+
+static int dp83822_probe(struct phy_device *phydev)
+{
+	struct dp83822_private *dp83822;
+	int ret;
+
+	ret = dp8382x_probe(phydev);
+	if (ret)
+		return ret;
+
+	dp83822 = phydev->priv;
+
 	ret = dp83822_read_straps(phydev);
 	if (ret)
 		return ret;
@@ -717,14 +728,11 @@ static int dp83822_probe(struct phy_device *phydev)
 
 static int dp83826_probe(struct phy_device *phydev)
 {
-	struct dp83822_private *dp83822;
-
-	dp83822 = devm_kzalloc(&phydev->mdio.dev, sizeof(*dp83822),
-			       GFP_KERNEL);
-	if (!dp83822)
-		return -ENOMEM;
+	int ret;
 
-	phydev->priv = dp83822;
+	ret = dp8382x_probe(phydev);
+	if (ret)
+		return ret;
 
 	dp83826_of_init(phydev);
 
@@ -795,6 +803,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		PHY_ID_MATCH_MODEL(_id),			\
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
+		.probe          = dp8382x_probe,		\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp8382x_config_init,		\
 		.get_wol = dp83822_get_wol,			\
diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 897b979ec03c..3b5fcaf0dd36 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -237,16 +237,6 @@ static int vsc739x_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int vsc73xx_config_aneg(struct phy_device *phydev)
-{
-	/* The VSC73xx switches does not like to be instructed to
-	 * do autonegotiation in any way, it prefers that you just go
-	 * with the power-on/reset defaults. Writing some registers will
-	 * just make autonegotiation permanently fail.
-	 */
-	return 0;
-}
-
 /* This adds a skew for both TX and RX clocks, so the skew should only be
  * applied to "rgmii-id" interfaces. It may not work as expected
  * on "rgmii-txid", "rgmii-rxid" or "rgmii" interfaces.
@@ -444,7 +434,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -453,7 +442,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc738x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -462,7 +450,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
@@ -471,7 +458,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask    = 0x000ffff0,
 	/* PHY_GBIT_FEATURES */
 	.config_init    = vsc739x_config_init,
-	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
 }, {
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 6eeef10edada..46afb95ffabe 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -286,10 +286,11 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 		return;
 	}
 
-	if (urb->actual_length <= IPHETH_IP_ALIGN) {
-		dev->net->stats.rx_length_errors++;
-		return;
-	}
+	/* iPhone may periodically send URBs with no payload
+	 * on the "bulk in" endpoint. It is safe to ignore them.
+	 */
+	if (urb->actual_length == 0)
+		goto rx_submit;
 
 	/* RX URBs starting with 0x00 0x01 do not encapsulate Ethernet frames,
 	 * but rather are control frames. Their purpose is not documented, and
@@ -298,7 +299,8 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	 * URB received from the bulk IN endpoint.
 	 */
 	if (unlikely
-		(((char *)urb->transfer_buffer)[0] == 0 &&
+		(urb->actual_length == 4 &&
+		 ((char *)urb->transfer_buffer)[0] == 0 &&
 		 ((char *)urb->transfer_buffer)[1] == 1))
 		goto rx_submit;
 
@@ -306,7 +308,6 @@ static void ipheth_rcvbulk_callback(struct urb *urb)
 	if (retval != 0) {
 		dev_err(&dev->intf->dev, "%s: callback retval: %d\n",
 			__func__, retval);
-		return;
 	}
 
 rx_submit:
@@ -354,13 +355,14 @@ static int ipheth_carrier_set(struct ipheth_device *dev)
 			0x02, /* index */
 			dev->ctrl_buf, IPHETH_CTRL_BUF_SIZE,
 			IPHETH_CTRL_TIMEOUT);
-	if (retval < 0) {
+	if (retval <= 0) {
 		dev_err(&dev->intf->dev, "%s: usb_control_msg: %d\n",
 			__func__, retval);
 		return retval;
 	}
 
-	if (dev->ctrl_buf[0] == IPHETH_CARRIER_ON) {
+	if ((retval == 1 && dev->ctrl_buf[0] == IPHETH_CARRIER_ON) ||
+	    (retval >= 2 && dev->ctrl_buf[1] == IPHETH_CARRIER_ON)) {
 		netif_carrier_on(dev->net);
 		if (dev->tx_urb->status != -EINPROGRESS)
 			netif_wake_queue(dev->net);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 3e3ad3518d85..cca7132ed6ab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1182,7 +1182,7 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw *hw,
 				    struct inet6_dev *idev)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mvif->phy->dev;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct inet6_ifaddr *ifa;
 	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
 	struct sk_buff *skb;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 11c7c85047ed..765bda7924f7 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1368,11 +1368,15 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	/* SBI PMU Snapsphot is only available in SBI v2.0 */
 	if (sbi_v2_available) {
+		int cpu;
+
 		ret = pmu_sbi_snapshot_alloc(pmu);
 		if (ret)
 			goto out_unregister;
 
-		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
+		cpu = get_cpu();
+
+		ret = pmu_sbi_snapshot_setup(pmu, cpu);
 		if (ret) {
 			/* Snapshot is an optional feature. Continue if not available */
 			pmu_sbi_snapshot_free(pmu);
@@ -1386,6 +1390,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 			 */
 			static_branch_enable(&sbi_pmu_snapshot_available);
 		}
+		put_cpu();
 	}
 
 	register_sysctl("kernel", sbi_pmu_sysctl_table);
diff --git a/drivers/pinctrl/intel/pinctrl-meteorlake.c b/drivers/pinctrl/intel/pinctrl-meteorlake.c
index cc44890c6699..885fa3b0d6d9 100644
--- a/drivers/pinctrl/intel/pinctrl-meteorlake.c
+++ b/drivers/pinctrl/intel/pinctrl-meteorlake.c
@@ -584,6 +584,7 @@ static const struct intel_pinctrl_soc_data mtls_soc_data = {
 };
 
 static const struct acpi_device_id mtl_pinctrl_acpi_match[] = {
+	{ "INTC105E", (kernel_ulong_t)&mtlp_soc_data },
 	{ "INTC1083", (kernel_ulong_t)&mtlp_soc_data },
 	{ "INTC1082", (kernel_ulong_t)&mtls_soc_data },
 	{ }
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 1c4d74db08c9..a23dff35f8ca 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -265,16 +265,34 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
-	&ssam_node_tmp_perf_profile,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
+	&ssam_node_hid_main_keyboard,
+	&ssam_node_hid_main_touchpad,
+	&ssam_node_hid_main_iid5,
+	&ssam_node_hid_sam_ucm_ucsi,
+	NULL,
+};
+
+/* Devices for Surface Laptop 6. */
+static const struct software_node *ssam_node_group_sl6[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
 	&ssam_node_hid_main_keyboard,
 	&ssam_node_hid_main_touchpad,
 	&ssam_node_hid_main_iid5,
+	&ssam_node_hid_sam_sensors,
 	&ssam_node_hid_sam_ucm_ucsi,
 	NULL,
 };
 
-/* Devices for Surface Laptop Studio. */
-static const struct software_node *ssam_node_group_sls[] = {
+/* Devices for Surface Laptop Studio 1. */
+static const struct software_node *ssam_node_group_sls1[] = {
 	&ssam_node_root,
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
@@ -289,6 +307,22 @@ static const struct software_node *ssam_node_group_sls[] = {
 	NULL,
 };
 
+/* Devices for Surface Laptop Studio 2. */
+static const struct software_node *ssam_node_group_sls2[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_tmp_sensors,
+	&ssam_node_fan_speed,
+	&ssam_node_pos_tablet_switch,
+	&ssam_node_hid_sam_keyboard,
+	&ssam_node_hid_sam_penstash,
+	&ssam_node_hid_sam_sensors,
+	&ssam_node_hid_sam_ucm_ucsi,
+	NULL,
+};
+
 /* Devices for Surface Laptop Go. */
 static const struct software_node *ssam_node_group_slg1[] = {
 	&ssam_node_root,
@@ -324,7 +358,7 @@ static const struct software_node *ssam_node_group_sp8[] = {
 	NULL,
 };
 
-/* Devices for Surface Pro 9 */
+/* Devices for Surface Pro 9 and 10 */
 static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_root,
 	&ssam_node_hub_kip,
@@ -365,6 +399,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Pro 9 */
 	{ "MSHW0343", (unsigned long)ssam_node_group_sp9 },
 
+	/* Surface Pro 10 */
+	{ "MSHW0510", (unsigned long)ssam_node_group_sp9 },
+
 	/* Surface Book 2 */
 	{ "MSHW0107", (unsigned long)ssam_node_group_gen5 },
 
@@ -389,14 +426,23 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop 5 */
 	{ "MSHW0350", (unsigned long)ssam_node_group_sl5 },
 
+	/* Surface Laptop 6 */
+	{ "MSHW0530", (unsigned long)ssam_node_group_sl6 },
+
 	/* Surface Laptop Go 1 */
 	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
 
 	/* Surface Laptop Go 2 */
 	{ "MSHW0290", (unsigned long)ssam_node_group_slg1 },
 
-	/* Surface Laptop Studio */
-	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
+	/* Surface Laptop Go 3 */
+	{ "MSHW0440", (unsigned long)ssam_node_group_slg1 },
+
+	/* Surface Laptop Studio 1 */
+	{ "MSHW0123", (unsigned long)ssam_node_group_sls1 },
+
+	/* Surface Laptop Studio 2 */
+	{ "MSHW0360", (unsigned long)ssam_node_group_sls2 },
 
 	{ },
 };
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index bc9c5db38324..5fe5149549cc 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -146,6 +146,20 @@ static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
+static const struct dmi_system_id asus_ally_mcu_quirk[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
+		},
+	},
+	{ },
+};
+
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -4650,7 +4664,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
 	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_match(DMI_BOARD_NAME, "RC71L");
+						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..ebd81846e2d5 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -337,7 +337,8 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		pr_err("SQTY reports bad SINF length\n");
+		pr_err("SQTY reports bad SINF length SQTY: %lu SINF-pkg-count: %u\n",
+		       pcc->num_sifr, hkey->package.count);
 		status = AE_ERROR;
 		goto end;
 	}
@@ -773,6 +774,24 @@ static DEVICE_ATTR_RW(dc_brightness);
 static DEVICE_ATTR_RW(current_brightness);
 static DEVICE_ATTR_RW(cdpower);
 
+static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (attr == &dev_attr_mute.attr)
+		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_eco_mode.attr)
+		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_current_brightness.attr)
+		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
 	&dev_attr_lcdtype.attr,
@@ -787,8 +806,9 @@ static struct attribute *pcc_sysfs_entries[] = {
 };
 
 static const struct attribute_group pcc_attr_group = {
-	.name	= NULL,		/* put in device directory */
-	.attrs	= pcc_sysfs_entries,
+	.name		= NULL,		/* put in device directory */
+	.attrs		= pcc_sysfs_entries,
+	.is_visible	= pcc_sysfs_is_visible,
 };
 
 
@@ -941,12 +961,15 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
-	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
+	if (pcc->num_sifr > SINF_MUTE)
+		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
 	acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, pcc->ac_brightness);
 	acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, pcc->dc_brightness);
-	acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
 
 	return 0;
 }
@@ -963,11 +986,21 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	num_sifr = acpi_pcc_get_sqty(device);
 
-	if (num_sifr < 0 || num_sifr > 255) {
-		pr_err("num_sifr out of range");
+	/*
+	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
+	 * Accesses to higher SINF entries are checked against num_sifr.
+	 */
+	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
+		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);
 		return -ENODEV;
 	}
 
+	/*
+	 * Some DSDT-s have an off-by-one bug where the SINF package count is
+	 * one higher than the SQTY reported value, allocate 1 entry extra.
+	 */
+	num_sifr++;
+
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
 		pr_err("Couldn't allocate mem for pcc");
@@ -1020,11 +1053,14 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
 	pcc->sticky_key = 0;
 
-	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
-	pcc->mute = pcc->sinf[SINF_MUTE];
 	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
 	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
-	pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
+	if (pcc->num_sifr > SINF_MUTE)
+		pcc->mute = pcc->sinf[SINF_MUTE];
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00191b1d2260..4e9e7d2a942d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1286,18 +1286,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	unsigned long mask;
+	u8 num_ports;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		mask = slave->prop.source_ports;
+		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		mask = slave->prop.sink_ports;
+		num_ports = hweight32(slave->prop.sink_ports);
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for_each_set_bit(i, &mask, 32) {
+	for (i = 0; i < num_ports; i++) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 37ef8c40b276..6f4057330444 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1110,25 +1110,27 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spin_lock_init(&mas->lock);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	if (device_property_read_bool(&pdev->dev, "spi-slave"))
 		spi->target = true;
 
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 	/* Set the bus quota to a reasonable value for register access */
 	mas->se.icc_paths[GENI_TO_CORE].avg_bw = Bps_to_icc(CORE_2X_50_MHZ);
 	mas->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
 
 	ret = geni_icc_set_bw(&mas->se);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 
 	ret = spi_geni_init(mas);
 	if (ret)
-		goto spi_geni_probe_runtime_disable;
+		return ret;
 
 	/*
 	 * check the mode supported and set_cs for fifo mode only
@@ -1157,8 +1159,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	free_irq(mas->irq, spi);
 spi_geni_release_dma:
 	spi_geni_release_dma_chan(mas);
-spi_geni_probe_runtime_disable:
-	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -1170,10 +1170,9 @@ static void spi_geni_remove(struct platform_device *pdev)
 	/* Unregister _before_ disabling pm_runtime() so we stop transfers */
 	spi_unregister_controller(spi);
 
-	spi_geni_release_dma_chan(mas);
-
 	free_irq(mas->irq, spi);
-	pm_runtime_disable(&pdev->dev);
+
+	spi_geni_release_dma_chan(mas);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 88397f712a3b..6585b19a4866 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -805,14 +805,15 @@ static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
 	if (i < op->data.nbytes) {
 		u32 data = 0;
 		int j;
+		int remaining = op->data.nbytes - i;
 		/* Wait for TXFIFO empty */
 		ret = fspi_readl_poll_tout(f, f->iobase + FSPI_INTR,
 					   FSPI_INTR_IPTXWE, 0,
 					   POLL_TOUT, true);
 		WARN_ON(ret);
 
-		for (j = 0; j < ALIGN(op->data.nbytes - i, 4); j += 4) {
-			memcpy(&data, buf + i + j, 4);
+		for (j = 0; j < ALIGN(remaining, 4); j += 4) {
+			memcpy(&data, buf + i + j, min_t(int, 4, remaining - j));
 			fspi_writel(f, data, base + FSPI_TFDR + j);
 		}
 		fspi_writel(f, FSPI_INTR_IPTXWE, base + FSPI_INTR);
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 99524a3c9f38..558c466135a5 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1033,6 +1033,18 @@ static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static unsigned long zynqmp_qspi_timeout(struct zynqmp_qspi *xqspi, u8 bits,
+					 unsigned long bytes)
+{
+	unsigned long timeout;
+
+	/* Assume we are at most 2x slower than the nominal bus speed */
+	timeout = mult_frac(bytes, 2 * 8 * MSEC_PER_SEC,
+			    bits * xqspi->speed_hz);
+	/* And add 100 ms for scheduling delays */
+	return msecs_to_jiffies(timeout + 100);
+}
+
 /**
  * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
  * @mem: The SPI memory
@@ -1049,6 +1061,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 {
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
 				    (mem->spi->controller);
+	unsigned long timeout;
 	int err = 0, i;
 	u32 genfifoentry = 0;
 	u16 opcode = op->cmd.opcode;
@@ -1077,8 +1090,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+		timeout = zynqmp_qspi_timeout(xqspi, op->cmd.buswidth,
+					      op->cmd.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
+						 timeout)) {
 			err = -ETIMEDOUT;
 			goto return_err;
 		}
@@ -1104,8 +1119,10 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 				   GQSPI_IER_TXEMPTY_MASK |
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
+		timeout = zynqmp_qspi_timeout(xqspi, op->addr.buswidth,
+					      op->addr.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
+						 timeout)) {
 			err = -ETIMEDOUT;
 			goto return_err;
 		}
@@ -1173,8 +1190,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 						   GQSPI_IER_RXEMPTY_MASK);
 			}
 		}
-		if (!wait_for_completion_timeout
-		    (&xqspi->data_completion, msecs_to_jiffies(1000)))
+		timeout = zynqmp_qspi_timeout(xqspi, op->data.buswidth,
+					      op->data.nbytes);
+		if (!wait_for_completion_timeout(&xqspi->data_completion, timeout))
 			err = -ETIMEDOUT;
 	}
 
diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index 8f08df5c88cc..569a2f59e551 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -30,12 +30,24 @@
 #define uISP_VAL_MAX		      ((unsigned int)((1 << uISP_REG_BIT) - 1))
 
 /* a:fraction bits for 16bit precision, b:fraction bits for ISP precision */
-#define sDIGIT_FITTING(v, a, b) \
-	min_t(int, max_t(int, (((v) >> sSHIFT) >> max(sFRACTION_BITS_FITTING(a) - (b), 0)), \
-	  sISP_VAL_MIN), sISP_VAL_MAX)
-#define uDIGIT_FITTING(v, a, b) \
-	min((unsigned int)max((unsigned)(((v) >> uSHIFT) \
-	>> max((int)(uFRACTION_BITS_FITTING(a) - (b)), 0)), \
-	  uISP_VAL_MIN), uISP_VAL_MAX)
+static inline int sDIGIT_FITTING(int v, int a, int b)
+{
+	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
+
+	v >>= sSHIFT;
+	v >>= fit_shift > 0 ? fit_shift : 0;
+
+	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
+}
+
+static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
+{
+	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
+
+	v >>= uSHIFT;
+	v >>= fit_shift > 0 ? fit_shift : 0;
+
+	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
+}
 
 #endif /* __SH_CSS_FRAC_H */
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 45e91d065b3b..8e00f21c7d13 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -817,10 +817,11 @@ static int ucsi_check_altmodes(struct ucsi_connector *con)
 	/* Ignoring the errors in this case. */
 	if (con->partner_altmode[0]) {
 		num_partner_am = ucsi_get_num_altmode(con->partner_altmode);
-		if (num_partner_am > 0)
-			typec_partner_set_num_altmodes(con->partner, num_partner_am);
+		typec_partner_set_num_altmodes(con->partner, num_partner_am);
 		ucsi_altmode_update_active(con);
 		return 0;
+	} else {
+		typec_partner_set_num_altmodes(con->partner, 0);
 	}
 
 	return ret;
@@ -914,10 +915,20 @@ static void ucsi_unregister_plug(struct ucsi_connector *con)
 
 static int ucsi_register_cable(struct ucsi_connector *con)
 {
+	struct ucsi_cable_property cable_prop;
 	struct typec_cable *cable;
 	struct typec_cable_desc desc = {};
+	u64 command;
+	int ret;
+
+	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
+	ret = ucsi_send_command(con->ucsi, command, &cable_prop, sizeof(cable_prop));
+	if (ret < 0) {
+		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n", ret);
+		return ret;
+	}
 
-	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
+	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(cable_prop.flags)) {
 	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
 		desc.type = USB_PLUG_TYPE_A;
 		break;
@@ -933,10 +944,10 @@ static int ucsi_register_cable(struct ucsi_connector *con)
 	}
 
 	desc.identity = &con->cable_identity;
-	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
-			 con->cable_prop.flags);
-	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
-	    con->cable_prop.flags);
+	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE & cable_prop.flags);
+
+	if (con->ucsi->version >= UCSI_VERSION_2_1)
+		desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(cable_prop.flags);
 
 	cable = typec_register_cable(con->port, &desc);
 	if (IS_ERR(cable)) {
@@ -1142,21 +1153,11 @@ static int ucsi_check_connection(struct ucsi_connector *con)
 
 static int ucsi_check_cable(struct ucsi_connector *con)
 {
-	u64 command;
-	int ret;
+	int ret, num_plug_am;
 
 	if (con->cable)
 		return 0;
 
-	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
-	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop,
-				sizeof(con->cable_prop));
-	if (ret < 0) {
-		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = ucsi_register_cable(con);
 	if (ret < 0)
 		return ret;
@@ -1175,6 +1176,13 @@ static int ucsi_check_cable(struct ucsi_connector *con)
 		ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_SOP_P);
 		if (ret < 0)
 			return ret;
+
+		if (con->plug_altmode[0]) {
+			num_plug_am = ucsi_get_num_altmode(con->plug_altmode);
+			typec_plug_set_num_altmodes(con->plug, num_plug_am);
+		} else {
+			typec_plug_set_num_altmodes(con->plug, 0);
+		}
 	}
 
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f66224a270bc..46c37643b59c 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -444,7 +444,6 @@ struct ucsi_connector {
 
 	struct ucsi_connector_status status;
 	struct ucsi_connector_capability cap;
-	struct ucsi_cable_property cable_prop;
 	struct power_supply *psy;
 	struct power_supply_desc psy_desc;
 	u32 rdo;
diff --git a/fs/bcachefs/extents.c b/fs/bcachefs/extents.c
index 410b8bd81b5a..7582e8ee6c21 100644
--- a/fs/bcachefs/extents.c
+++ b/fs/bcachefs/extents.c
@@ -932,8 +932,29 @@ bool bch2_extents_match(struct bkey_s_c k1, struct bkey_s_c k2)
 			bkey_for_each_ptr_decode(k2.k, ptrs2, p2, entry2)
 				if (p1.ptr.dev		== p2.ptr.dev &&
 				    p1.ptr.gen		== p2.ptr.gen &&
+
+				    /*
+				     * This checks that the two pointers point
+				     * to the same region on disk - adjusting
+				     * for the difference in where the extents
+				     * start, since one may have been trimmed:
+				     */
 				    (s64) p1.ptr.offset + p1.crc.offset - bkey_start_offset(k1.k) ==
-				    (s64) p2.ptr.offset + p2.crc.offset - bkey_start_offset(k2.k))
+				    (s64) p2.ptr.offset + p2.crc.offset - bkey_start_offset(k2.k) &&
+
+				    /*
+				     * This additionally checks that the
+				     * extents overlap on disk, since the
+				     * previous check may trigger spuriously
+				     * when one extent is immediately partially
+				     * overwritten with another extent (so that
+				     * on disk they are adjacent) and
+				     * compression is in use:
+				     */
+				    ((p1.ptr.offset >= p2.ptr.offset &&
+				      p1.ptr.offset  < p2.ptr.offset + p2.crc.compressed_size) ||
+				     (p2.ptr.offset >= p1.ptr.offset &&
+				      p2.ptr.offset  < p1.ptr.offset + p1.crc.compressed_size)))
 					return true;
 
 		return false;
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 54873ecc635c..98c1e26a313a 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -802,8 +802,7 @@ static noinline void folios_trunc(folios *fs, struct folio **fi)
 static int __bch2_buffered_write(struct bch_inode_info *inode,
 				 struct address_space *mapping,
 				 struct iov_iter *iter,
-				 loff_t pos, unsigned len,
-				 bool inode_locked)
+				 loff_t pos, unsigned len)
 {
 	struct bch_fs *c = inode->v.i_sb->s_fs_info;
 	struct bch2_folio_reservation res;
@@ -828,15 +827,6 @@ static int __bch2_buffered_write(struct bch_inode_info *inode,
 
 	BUG_ON(!fs.nr);
 
-	/*
-	 * If we're not using the inode lock, we need to lock all the folios for
-	 * atomiticity of writes vs. other writes:
-	 */
-	if (!inode_locked && folio_end_pos(darray_last(fs)) < end) {
-		ret = -BCH_ERR_need_inode_lock;
-		goto out;
-	}
-
 	f = darray_first(fs);
 	if (pos != folio_pos(f) && !folio_test_uptodate(f)) {
 		ret = bch2_read_single_folio(f, mapping);
@@ -931,10 +921,8 @@ static int __bch2_buffered_write(struct bch_inode_info *inode,
 	end = pos + copied;
 
 	spin_lock(&inode->v.i_lock);
-	if (end > inode->v.i_size) {
-		BUG_ON(!inode_locked);
+	if (end > inode->v.i_size)
 		i_size_write(&inode->v, end);
-	}
 	spin_unlock(&inode->v.i_lock);
 
 	f_pos = pos;
@@ -978,68 +966,12 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct bch_inode_info *inode = file_bch_inode(file);
-	loff_t pos;
-	bool inode_locked = false;
-	ssize_t written = 0, written2 = 0, ret = 0;
-
-	/*
-	 * We don't take the inode lock unless i_size will be changing. Folio
-	 * locks provide exclusion with other writes, and the pagecache add lock
-	 * provides exclusion with truncate and hole punching.
-	 *
-	 * There is one nasty corner case where atomicity would be broken
-	 * without great care: when copying data from userspace to the page
-	 * cache, we do that with faults disable - a page fault would recurse
-	 * back into the filesystem, taking filesystem locks again, and
-	 * deadlock; so it's done with faults disabled, and we fault in the user
-	 * buffer when we aren't holding locks.
-	 *
-	 * If we do part of the write, but we then race and in the userspace
-	 * buffer have been evicted and are no longer resident, then we have to
-	 * drop our folio locks to re-fault them in, breaking write atomicity.
-	 *
-	 * To fix this, we restart the write from the start, if we weren't
-	 * holding the inode lock.
-	 *
-	 * There is another wrinkle after that; if we restart the write from the
-	 * start, and then get an unrecoverable error, we _cannot_ claim to
-	 * userspace that we did not write data we actually did - so we must
-	 * track (written2) the most we ever wrote.
-	 */
-
-	if ((iocb->ki_flags & IOCB_APPEND) ||
-	    (iocb->ki_pos + iov_iter_count(iter) > i_size_read(&inode->v))) {
-		inode_lock(&inode->v);
-		inode_locked = true;
-	}
-
-	ret = generic_write_checks(iocb, iter);
-	if (ret <= 0)
-		goto unlock;
-
-	ret = file_remove_privs_flags(file, !inode_locked ? IOCB_NOWAIT : 0);
-	if (ret) {
-		if (!inode_locked) {
-			inode_lock(&inode->v);
-			inode_locked = true;
-			ret = file_remove_privs_flags(file, 0);
-		}
-		if (ret)
-			goto unlock;
-	}
-
-	ret = file_update_time(file);
-	if (ret)
-		goto unlock;
-
-	pos = iocb->ki_pos;
+	loff_t pos = iocb->ki_pos;
+	ssize_t written = 0;
+	int ret = 0;
 
 	bch2_pagecache_add_get(inode);
 
-	if (!inode_locked &&
-	    (iocb->ki_pos + iov_iter_count(iter) > i_size_read(&inode->v)))
-		goto get_inode_lock;
-
 	do {
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		unsigned bytes = iov_iter_count(iter);
@@ -1064,17 +996,12 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 			}
 		}
 
-		if (unlikely(bytes != iov_iter_count(iter) && !inode_locked))
-			goto get_inode_lock;
-
 		if (unlikely(fatal_signal_pending(current))) {
 			ret = -EINTR;
 			break;
 		}
 
-		ret = __bch2_buffered_write(inode, mapping, iter, pos, bytes, inode_locked);
-		if (ret == -BCH_ERR_need_inode_lock)
-			goto get_inode_lock;
+		ret = __bch2_buffered_write(inode, mapping, iter, pos, bytes);
 		if (unlikely(ret < 0))
 			break;
 
@@ -1095,46 +1022,50 @@ static ssize_t bch2_buffered_write(struct kiocb *iocb, struct iov_iter *iter)
 		}
 		pos += ret;
 		written += ret;
-		written2 = max(written, written2);
-
-		if (ret != bytes && !inode_locked)
-			goto get_inode_lock;
 		ret = 0;
 
 		balance_dirty_pages_ratelimited(mapping);
-
-		if (0) {
-get_inode_lock:
-			bch2_pagecache_add_put(inode);
-			inode_lock(&inode->v);
-			inode_locked = true;
-			bch2_pagecache_add_get(inode);
-
-			iov_iter_revert(iter, written);
-			pos -= written;
-			written = 0;
-			ret = 0;
-		}
 	} while (iov_iter_count(iter));
-	bch2_pagecache_add_put(inode);
-unlock:
-	if (inode_locked)
-		inode_unlock(&inode->v);
 
-	iocb->ki_pos += written;
+	bch2_pagecache_add_put(inode);
 
-	ret = max(written, written2) ?: ret;
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
-	return ret;
+	return written ? written : ret;
 }
 
-ssize_t bch2_write_iter(struct kiocb *iocb, struct iov_iter *iter)
+ssize_t bch2_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	ssize_t ret = iocb->ki_flags & IOCB_DIRECT
-		? bch2_direct_write(iocb, iter)
-		: bch2_buffered_write(iocb, iter);
+	struct file *file = iocb->ki_filp;
+	struct bch_inode_info *inode = file_bch_inode(file);
+	ssize_t ret;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = bch2_direct_write(iocb, from);
+		goto out;
+	}
+
+	inode_lock(&inode->v);
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto unlock;
+
+	ret = file_remove_privs(file);
+	if (ret)
+		goto unlock;
+
+	ret = file_update_time(file);
+	if (ret)
+		goto unlock;
+
+	ret = bch2_buffered_write(iocb, from);
+	if (likely(ret > 0))
+		iocb->ki_pos += ret;
+unlock:
+	inode_unlock(&inode->v);
 
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+out:
 	return bch2_err_class(ret);
 }
 
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index fa1fee05cf8f..162f7836ca79 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -177,6 +177,14 @@ static unsigned bch2_inode_hash(subvol_inum inum)
 	return jhash_3words(inum.subvol, inum.inum >> 32, inum.inum, JHASH_INITVAL);
 }
 
+struct bch_inode_info *__bch2_inode_hash_find(struct bch_fs *c, subvol_inum inum)
+{
+	return to_bch_ei(ilookup5_nowait(c->vfs_sb,
+					 bch2_inode_hash(inum),
+					 bch2_iget5_test,
+					 &inum));
+}
+
 static struct bch_inode_info *bch2_inode_insert(struct bch_fs *c, struct bch_inode_info *inode)
 {
 	subvol_inum inum = inode_inum(inode);
diff --git a/fs/bcachefs/fs.h b/fs/bcachefs/fs.h
index c3af7225ff69..990ec43e0365 100644
--- a/fs/bcachefs/fs.h
+++ b/fs/bcachefs/fs.h
@@ -56,6 +56,8 @@ static inline subvol_inum inode_inum(struct bch_inode_info *inode)
 	};
 }
 
+struct bch_inode_info *__bch2_inode_hash_find(struct bch_fs *, subvol_inum);
+
 /*
  * Set if we've gotten a btree error for this inode, and thus the vfs inode and
  * btree inode may be inconsistent:
@@ -194,6 +196,11 @@ int bch2_vfs_init(void);
 
 #define bch2_inode_update_after_write(_trans, _inode, _inode_u, _fields)	({ do {} while (0); })
 
+static inline struct bch_inode_info *__bch2_inode_hash_find(struct bch_fs *c, subvol_inum inum)
+{
+	return NULL;
+}
+
 static inline void bch2_evict_subvolume_inodes(struct bch_fs *c,
 					       snapshot_id_list *s) {}
 static inline void bch2_vfs_exit(void) {}
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 921bcdb3e5e4..08d0eb39e7d6 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -8,6 +8,7 @@
 #include "darray.h"
 #include "dirent.h"
 #include "error.h"
+#include "fs.h"
 #include "fs-common.h"
 #include "fsck.h"
 #include "inode.h"
@@ -948,6 +949,22 @@ static int check_inode_dirent_inode(struct btree_trans *trans, struct bkey_s_c i
 	return ret;
 }
 
+static bool bch2_inode_open(struct bch_fs *c, struct bpos p)
+{
+	subvol_inum inum = {
+		.subvol = snapshot_t(c, p.snapshot)->subvol,
+		.inum	= p.offset,
+	};
+
+	/* snapshot tree corruption, can't safely delete */
+	if (!inum.subvol) {
+		bch_err_ratelimited(c, "%s(): snapshot %u has no subvol", __func__, p.snapshot);
+		return true;
+	}
+
+	return __bch2_inode_hash_find(c, inum) != NULL;
+}
+
 static int check_inode(struct btree_trans *trans,
 		       struct btree_iter *iter,
 		       struct bkey_s_c k,
@@ -1025,6 +1042,7 @@ static int check_inode(struct btree_trans *trans,
 	}
 
 	if (u.bi_flags & BCH_INODE_unlinked &&
+	    !bch2_inode_open(c, k.k->p) &&
 	    (!c->sb.clean ||
 	     fsck_err(c, inode_unlinked_but_clean,
 		      "filesystem marked clean, but inode %llu unlinked",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2951aa0039fc..5d23421b6243 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4213,6 +4213,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
  	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6bace5fece04..ed362d291b90 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -624,6 +624,9 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 				prev = delegation;
 			continue;
 		}
+		inode = nfs_delegation_grab_inode(delegation);
+		if (inode == NULL)
+			continue;
 
 		if (prev) {
 			struct inode *tmp = nfs_delegation_grab_inode(prev);
@@ -634,12 +637,6 @@ static int nfs_server_return_marked_delegations(struct nfs_server *server,
 			}
 		}
 
-		inode = nfs_delegation_grab_inode(delegation);
-		if (inode == NULL) {
-			rcu_read_unlock();
-			iput(to_put);
-			goto restart;
-		}
 		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
 		rcu_read_unlock();
 
@@ -1161,7 +1158,6 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 	struct inode *inode;
 restart:
 	rcu_read_lock();
-restart_locked:
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		if (test_bit(NFS_DELEGATION_INODE_FREEING,
 					&delegation->flags) ||
@@ -1172,7 +1168,7 @@ static int nfs_server_reap_unclaimed_delegations(struct nfs_server *server,
 			continue;
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
-			goto restart_locked;
+			continue;
 		delegation = nfs_start_delegation_return_locked(NFS_I(inode));
 		rcu_read_unlock();
 		if (delegation != NULL) {
@@ -1295,7 +1291,6 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 
 restart:
 	rcu_read_lock();
-restart_locked:
 	list_for_each_entry_rcu(delegation, &server->delegations, super_list) {
 		if (test_bit(NFS_DELEGATION_INODE_FREEING,
 					&delegation->flags) ||
@@ -1307,7 +1302,7 @@ static int nfs_server_reap_expired_delegations(struct nfs_server *server,
 			continue;
 		inode = nfs_delegation_grab_inode(delegation);
 		if (inode == NULL)
-			goto restart_locked;
+			continue;
 		spin_lock(&delegation->lock);
 		cred = get_cred_rcu(delegation->cred);
 		nfs4_stateid_copy(&stateid, &delegation->stateid);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bff9d6600741..3b76e89b6d02 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9873,13 +9873,16 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 		fallthrough;
 	default:
 		task->tk_status = 0;
+		lrp->res.lrs_present = 0;
 		fallthrough;
 	case 0:
 		break;
 	case -NFS4ERR_DELAY:
-		if (nfs4_async_handle_error(task, server, NULL, NULL) != -EAGAIN)
-			break;
-		goto out_restart;
+		if (nfs4_async_handle_error(task, server, NULL, NULL) ==
+		    -EAGAIN)
+			goto out_restart;
+		lrp->res.lrs_present = 0;
+		break;
 	}
 	return;
 out_restart:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b5834728f31b..d1e3c17dcceb 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1172,10 +1172,9 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 	LIST_HEAD(freeme);
 
 	spin_lock(&inode->i_lock);
-	if (!pnfs_layout_is_valid(lo) ||
-	    !nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
+	if (!nfs4_stateid_match_other(&lo->plh_stateid, arg_stateid))
 		goto out_unlock;
-	if (stateid) {
+	if (stateid && pnfs_layout_is_valid(lo)) {
 		u32 seq = be32_to_cpu(arg_stateid->seqid);
 
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 6322f0f68a17..b0473c2567fe 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -129,7 +129,7 @@ static ssize_t cifs_shash_xarray(const struct iov_iter *iter, ssize_t maxsize,
 			for (j = foffset / PAGE_SIZE; j < npages; j++) {
 				len = min_t(size_t, maxsize, PAGE_SIZE - offset);
 				p = kmap_local_page(folio_page(folio, j));
-				ret = crypto_shash_update(shash, p, len);
+				ret = crypto_shash_update(shash, p + offset, len);
 				kunmap_local(p);
 				if (ret < 0)
 					return ret;
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index e0a6b758094f..d8d03070ae44 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -15,6 +15,7 @@
 #include "share_config.h"
 #include "user_config.h"
 #include "user_session.h"
+#include "../connection.h"
 #include "../transport_ipc.h"
 #include "../misc.h"
 
@@ -120,12 +121,13 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 	return 0;
 }
 
-static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
+static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 						       const char *name)
 {
 	struct ksmbd_share_config_response *resp;
 	struct ksmbd_share_config *share = NULL;
 	struct ksmbd_share_config *lookup;
+	struct unicode_map *um = work->conn->um;
 	int ret;
 
 	resp = ksmbd_ipc_share_config_request(name);
@@ -181,7 +183,14 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
 				      resp->veto_list_sz);
 		if (!ret && share->path) {
+			if (__ksmbd_override_fsids(work, share)) {
+				kill_share(share);
+				share = NULL;
+				goto out;
+			}
+
 			ret = kern_path(share->path, 0, &share->vfs_path);
+			ksmbd_revert_fsids(work);
 			if (ret) {
 				ksmbd_debug(SMB, "failed to access '%s'\n",
 					    share->path);
@@ -214,7 +223,7 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 	return share;
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+struct ksmbd_share_config *ksmbd_share_config_get(struct ksmbd_work *work,
 						  const char *name)
 {
 	struct ksmbd_share_config *share;
@@ -227,7 +236,7 @@ struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
 
 	if (share)
 		return share;
-	return share_config_request(um, name);
+	return share_config_request(work, name);
 }
 
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
diff --git a/fs/smb/server/mgmt/share_config.h b/fs/smb/server/mgmt/share_config.h
index 5f591751b923..d4ac2dd4de20 100644
--- a/fs/smb/server/mgmt/share_config.h
+++ b/fs/smb/server/mgmt/share_config.h
@@ -11,6 +11,8 @@
 #include <linux/path.h>
 #include <linux/unicode.h>
 
+struct ksmbd_work;
+
 struct ksmbd_share_config {
 	char			*name;
 	char			*path;
@@ -68,7 +70,7 @@ static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
 	__ksmbd_share_config_put(share);
 }
 
-struct ksmbd_share_config *ksmbd_share_config_get(struct unicode_map *um,
+struct ksmbd_share_config *ksmbd_share_config_get(struct ksmbd_work *work,
 						  const char *name);
 bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
 			       const char *filename);
diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index d2c81a8a11dd..94a52a75014a 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -16,17 +16,18 @@
 #include "user_session.h"
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			const char *share_name)
+ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 {
 	struct ksmbd_tree_conn_status status = {-ENOENT, NULL};
 	struct ksmbd_tree_connect_response *resp = NULL;
 	struct ksmbd_share_config *sc;
 	struct ksmbd_tree_connect *tree_conn = NULL;
 	struct sockaddr *peer_addr;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
 	int ret;
 
-	sc = ksmbd_share_config_get(conn->um, share_name);
+	sc = ksmbd_share_config_get(work, share_name);
 	if (!sc)
 		return status;
 
@@ -61,7 +62,7 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 		struct ksmbd_share_config *new_sc;
 
 		ksmbd_share_config_del(sc);
-		new_sc = ksmbd_share_config_get(conn->um, share_name);
+		new_sc = ksmbd_share_config_get(work, share_name);
 		if (!new_sc) {
 			pr_err("Failed to update stale share config\n");
 			status.ret = -ESTALE;
diff --git a/fs/smb/server/mgmt/tree_connect.h b/fs/smb/server/mgmt/tree_connect.h
index 6377a70b811c..a42cdd051041 100644
--- a/fs/smb/server/mgmt/tree_connect.h
+++ b/fs/smb/server/mgmt/tree_connect.h
@@ -13,6 +13,7 @@
 struct ksmbd_share_config;
 struct ksmbd_user;
 struct ksmbd_conn;
+struct ksmbd_work;
 
 enum {
 	TREE_NEW = 0,
@@ -50,8 +51,7 @@ static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
 struct ksmbd_session;
 
 struct ksmbd_tree_conn_status
-ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
-			const char *share_name);
+ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name);
 void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 39dfecf082ba..adfd6046275a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1959,7 +1959,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
 		    name, treename);
 
-	status = ksmbd_tree_conn_connect(conn, sess, name);
+	status = ksmbd_tree_conn_connect(work, name);
 	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
 		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
 	else
@@ -3714,7 +3714,7 @@ int smb2_open(struct ksmbd_work *work)
 	kfree(name);
 	kfree(lc);
 
-	return 0;
+	return rc;
 }
 
 static int readdir_info_level_struct_sz(int info_level)
@@ -5601,6 +5601,11 @@ int smb2_query_info(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "GOT query info request\n");
 
+	if (ksmbd_override_fsids(work)) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
@@ -5619,6 +5624,7 @@ int smb2_query_info(struct ksmbd_work *work)
 			    req->InfoType);
 		rc = -EOPNOTSUPP;
 	}
+	ksmbd_revert_fsids(work);
 
 	if (!rc) {
 		rsp->StructureSize = cpu_to_le16(9);
@@ -5628,6 +5634,7 @@ int smb2_query_info(struct ksmbd_work *work)
 					le32_to_cpu(rsp->OutputBufferLength));
 	}
 
+err_out:
 	if (rc < 0) {
 		if (rc == -EACCES)
 			rsp->hdr.Status = STATUS_ACCESS_DENIED;
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 474dadf6b7b8..13818ecb6e1b 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -732,10 +732,10 @@ bool is_asterisk(char *p)
 	return p && p[0] == '*';
 }
 
-int ksmbd_override_fsids(struct ksmbd_work *work)
+int __ksmbd_override_fsids(struct ksmbd_work *work,
+		struct ksmbd_share_config *share)
 {
 	struct ksmbd_session *sess = work->sess;
-	struct ksmbd_share_config *share = work->tcon->share_conf;
 	struct cred *cred;
 	struct group_info *gi;
 	unsigned int uid;
@@ -775,6 +775,11 @@ int ksmbd_override_fsids(struct ksmbd_work *work)
 	return 0;
 }
 
+int ksmbd_override_fsids(struct ksmbd_work *work)
+{
+	return __ksmbd_override_fsids(work, work->tcon->share_conf);
+}
+
 void ksmbd_revert_fsids(struct ksmbd_work *work)
 {
 	const struct cred *cred;
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index f1092519c0c2..4a3148b0167f 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -447,6 +447,8 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
+int __ksmbd_override_fsids(struct ksmbd_work *work,
+			   struct ksmbd_share_config *share);
 int ksmbd_override_fsids(struct ksmbd_work *work);
 void ksmbd_revert_fsids(struct ksmbd_work *work);
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index d45bfb7cf81d..6ffafd596d39 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1027,7 +1027,8 @@ struct mlx5_ifc_qos_cap_bits {
 
 	u8         max_tsar_bw_share[0x20];
 
-	u8         reserved_at_100[0x20];
+	u8         nic_element_type[0x10];
+	u8         nic_tsar_type[0x10];
 
 	u8         reserved_at_120[0x3];
 	u8         log_meter_aso_granularity[0x5];
@@ -3912,10 +3913,11 @@ enum {
 };
 
 enum {
-	ELEMENT_TYPE_CAP_MASK_TASR		= 1 << 0,
+	ELEMENT_TYPE_CAP_MASK_TSAR		= 1 << 0,
 	ELEMENT_TYPE_CAP_MASK_VPORT		= 1 << 1,
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
+	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
 };
 
 struct mlx5_ifc_scheduling_context_bits {
@@ -4623,6 +4625,12 @@ enum {
 	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
 };
 
+enum {
+	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
+	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
+	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+};
+
 struct mlx5_ifc_tsar_element_bits {
 	u8         reserved_at_0[0x8];
 	u8         tsar_type[0x8];
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6c395a2600e8..276ca543ef44 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->csum_offset != offsetof(struct tcphdr, check))
+			if (skb->ip_summed == CHECKSUM_PARTIAL &&
+			    skb->csum_offset != offsetof(struct tcphdr, check))
 				return -EINVAL;
 			break;
 		}
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e8f24483e05f..c03a2bc106d4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -223,6 +223,13 @@ static cpumask_var_t	isolated_cpus;
 /* List of remote partition root children */
 static struct list_head remote_children;
 
+/*
+ * A flag to force sched domain rebuild at the end of an operation while
+ * inhibiting it in the intermediate stages when set. Currently it is only
+ * set in hotplug code.
+ */
+static bool force_sd_rebuild;
+
 /*
  * Partition root states:
  *
@@ -1442,7 +1449,7 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
-	if (rebuild_domains)
+	if (rebuild_domains && !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -1805,7 +1812,7 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
 			remote_partition_disable(child, tmp);
 			disable_cnt++;
 		}
-	if (disable_cnt)
+	if (disable_cnt && !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -2415,7 +2422,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD))
+	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD) &&
+	    !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -3077,7 +3085,8 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
 
-	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
+	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed &&
+	    !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 
 	if (spread_flag_changed)
@@ -4478,11 +4487,9 @@ hotplug_update_tasks(struct cpuset *cs,
 		update_tasks_nodemask(cs);
 }
 
-static bool force_rebuild;
-
 void cpuset_force_rebuild(void)
 {
-	force_rebuild = true;
+	force_sd_rebuild = true;
 }
 
 /**
@@ -4630,15 +4637,9 @@ static void cpuset_handle_hotplug(void)
 		       !cpumask_empty(subpartitions_cpus);
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
-	/*
-	 * In the rare case that hotplug removes all the cpus in
-	 * subpartitions_cpus, we assumed that cpus are updated.
-	 */
-	if (!cpus_updated && !cpumask_empty(subpartitions_cpus))
-		cpus_updated = true;
-
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
+		cpuset_force_rebuild();
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
@@ -4694,8 +4695,8 @@ static void cpuset_handle_hotplug(void)
 	}
 
 	/* rebuild sched domains if cpus_allowed has changed */
-	if (cpus_updated || force_rebuild) {
-		force_rebuild = false;
+	if (force_sd_rebuild) {
+		force_sd_rebuild = false;
 		rebuild_sched_domains_cpuslocked();
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 0d88922f8763..4481f8913dcc 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -794,6 +794,24 @@ static int validate_module_probe_symbol(const char *modname, const char *symbol)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
+/* Return NULL if the module is not loaded or under unloading. */
+static struct module *try_module_get_by_name(const char *name)
+{
+	struct module *mod;
+
+	rcu_read_lock_sched();
+	mod = find_module(name);
+	if (mod && !try_module_get(mod))
+		mod = NULL;
+	rcu_read_unlock_sched();
+
+	return mod;
+}
+#else
+#define try_module_get_by_name(name)	(NULL)
+#endif
+
 static int validate_probe_symbol(char *symbol)
 {
 	struct module *mod = NULL;
@@ -805,12 +823,7 @@ static int validate_probe_symbol(char *symbol)
 		modname = symbol;
 		symbol = p + 1;
 		*p = '\0';
-		/* Return 0 (defer) if the module does not exist yet. */
-		rcu_read_lock_sched();
-		mod = find_module(modname);
-		if (mod && !try_module_get(mod))
-			mod = NULL;
-		rcu_read_unlock_sched();
+		mod = try_module_get_by_name(modname);
 		if (!mod)
 			goto out;
 	}
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5b06f67879f5..461b4ab60b50 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -228,6 +228,11 @@ static inline struct osnoise_variables *this_cpu_osn_var(void)
 	return this_cpu_ptr(&per_cpu_osnoise_var);
 }
 
+/*
+ * Protect the interface.
+ */
+static struct mutex interface_lock;
+
 #ifdef CONFIG_TIMERLAT_TRACER
 /*
  * Runtime information for the timer mode.
@@ -252,11 +257,6 @@ static inline struct timerlat_variables *this_cpu_tmr_var(void)
 	return this_cpu_ptr(&per_cpu_timerlat_var);
 }
 
-/*
- * Protect the interface.
- */
-static struct mutex interface_lock;
-
 /*
  * tlat_var_reset - Reset the values of the given timerlat_variables
  */
diff --git a/mm/memory.c b/mm/memory.c
index 72d00a38585d..7a898b85788d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2581,11 +2581,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-/*
- * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
- * must have pre-validated the caching bits of the pgprot_t.
- */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
@@ -2638,6 +2634,27 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 	return 0;
 }
 
+/*
+ * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
+ * must have pre-validated the caching bits of the pgprot_t.
+ */
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
+
+	if (!error)
+		return 0;
+
+	/*
+	 * A partial pfn range mapping is dangerous: it does not
+	 * maintain page reference counts, and callers may free
+	 * pages due to the error. So zap it early.
+	 */
+	zap_page_range_single(vma, addr, size, NULL);
+	return error;
+}
+
 /**
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e6904288d40d..b3191968e53a 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -73,9 +73,15 @@ static void hsr_check_announce(struct net_device *hsr_dev)
 			mod_timer(&hsr->announce_timer, jiffies +
 				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
 		}
+
+		if (hsr->redbox && !timer_pending(&hsr->announce_proxy_timer))
+			mod_timer(&hsr->announce_proxy_timer, jiffies +
+				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL) / 2);
 	} else {
 		/* Deactivate the announce timer  */
 		timer_delete(&hsr->announce_timer);
+		if (hsr->redbox)
+			timer_delete(&hsr->announce_proxy_timer);
 	}
 }
 
@@ -279,10 +285,11 @@ static struct sk_buff *hsr_init_skb(struct hsr_port *master)
 	return NULL;
 }
 
-static void send_hsr_supervision_frame(struct hsr_port *master,
-				       unsigned long *interval)
+static void send_hsr_supervision_frame(struct hsr_port *port,
+				       unsigned long *interval,
+				       const unsigned char *addr)
 {
-	struct hsr_priv *hsr = master->hsr;
+	struct hsr_priv *hsr = port->hsr;
 	__u8 type = HSR_TLV_LIFE_CHECK;
 	struct hsr_sup_payload *hsr_sp;
 	struct hsr_sup_tlv *hsr_stlv;
@@ -296,9 +303,9 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 		hsr->announce_count++;
 	}
 
-	skb = hsr_init_skb(master);
+	skb = hsr_init_skb(port);
 	if (!skb) {
-		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
+		netdev_warn_once(port->dev, "HSR: Could not send supervision frame\n");
 		return;
 	}
 
@@ -321,11 +328,12 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 	hsr_stag->tlv.HSR_TLV_length = hsr->prot_version ?
 				sizeof(struct hsr_sup_payload) : 12;
 
-	/* Payload: MacAddressA */
+	/* Payload: MacAddressA / SAN MAC from ProxyNodeTable */
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
-	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
+	ether_addr_copy(hsr_sp->macaddress_A, addr);
 
-	if (hsr->redbox) {
+	if (hsr->redbox &&
+	    hsr_is_node_in_db(&hsr->proxy_node_db, addr)) {
 		hsr_stlv = skb_put(skb, sizeof(struct hsr_sup_tlv));
 		hsr_stlv->HSR_TLV_type = PRP_TLV_REDBOX_MAC;
 		hsr_stlv->HSR_TLV_length = sizeof(struct hsr_sup_payload);
@@ -340,13 +348,14 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 		return;
 	}
 
-	hsr_forward_skb(skb, master);
+	hsr_forward_skb(skb, port);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
 
 static void send_prp_supervision_frame(struct hsr_port *master,
-				       unsigned long *interval)
+				       unsigned long *interval,
+				       const unsigned char *addr)
 {
 	struct hsr_priv *hsr = master->hsr;
 	struct hsr_sup_payload *hsr_sp;
@@ -396,7 +405,7 @@ static void hsr_announce(struct timer_list *t)
 
 	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
-	hsr->proto_ops->send_sv_frame(master, &interval);
+	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
 
 	if (is_admin_up(master->dev))
 		mod_timer(&hsr->announce_timer, jiffies + interval);
@@ -404,6 +413,41 @@ static void hsr_announce(struct timer_list *t)
 	rcu_read_unlock();
 }
 
+/* Announce (supervision frame) timer function for RedBox
+ */
+static void hsr_proxy_announce(struct timer_list *t)
+{
+	struct hsr_priv *hsr = from_timer(hsr, t, announce_proxy_timer);
+	struct hsr_port *interlink;
+	unsigned long interval = 0;
+	struct hsr_node *node;
+
+	rcu_read_lock();
+	/* RedBOX sends supervisory frames to HSR network with MAC addresses
+	 * of SAN nodes stored in ProxyNodeTable.
+	 */
+	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (!interlink)
+		goto done;
+
+	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
+		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+			continue;
+		hsr->proto_ops->send_sv_frame(interlink, &interval,
+					      node->macaddress_A);
+	}
+
+	if (is_admin_up(interlink->dev)) {
+		if (!interval)
+			interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
+
+		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
+	}
+
+done:
+	rcu_read_unlock();
+}
+
 void hsr_del_ports(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
@@ -590,6 +634,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
 	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
+	timer_setup(&hsr->announce_proxy_timer, hsr_proxy_announce, 0);
 
 	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
 	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 05a61b8286ec..960ef386bc3a 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -117,6 +117,35 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 	return true;
 }
 
+static bool is_proxy_supervision_frame(struct hsr_priv *hsr,
+				       struct sk_buff *skb)
+{
+	struct hsr_sup_payload *payload;
+	struct ethhdr *eth_hdr;
+	u16 total_length = 0;
+
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Get the HSR protocol revision. */
+	if (eth_hdr->h_proto == htons(ETH_P_HSR))
+		total_length = sizeof(struct hsrv1_ethhdr_sp);
+	else
+		total_length = sizeof(struct hsrv0_ethhdr_sp);
+
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_payload)))
+		return false;
+
+	skb_pull(skb, total_length);
+	payload = (struct hsr_sup_payload *)skb->data;
+	skb_push(skb, total_length);
+
+	/* For RedBox (HSR-SAN) check if we have received the supervision
+	 * frame with MAC addresses from own ProxyNodeTable.
+	 */
+	return hsr_is_node_in_db(&hsr->proxy_node_db,
+				 payload->macaddress_A);
+}
+
 static struct sk_buff *create_stripped_skb_hsr(struct sk_buff *skb_in,
 					       struct hsr_frame_info *frame)
 {
@@ -499,7 +528,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 					   frame->sequence_nr))
 			continue;
 
-		if (frame->is_supervision && port->type == HSR_PT_MASTER) {
+		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
+		    !frame->is_proxy_supervision) {
 			hsr_handle_sup_frame(frame);
 			continue;
 		}
@@ -637,6 +667,9 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 
 	memset(frame, 0, sizeof(*frame));
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
+	if (frame->is_supervision && hsr->redbox)
+		frame->is_proxy_supervision =
+			is_proxy_supervision_frame(port->hsr, skb);
 
 	n_db = &hsr->node_db;
 	if (port->type == HSR_PT_INTERLINK)
@@ -688,7 +721,7 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	/* Gets called for ingress frames as well as egress from master port.
 	 * So check and increment stats for master port only here.
 	 */
-	if (port->type == HSR_PT_MASTER) {
+	if (port->type == HSR_PT_MASTER || port->type == HSR_PT_INTERLINK) {
 		port->dev->stats.tx_packets++;
 		port->dev->stats.tx_bytes += skb->len;
 	}
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 614df9649794..73bc6f659812 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -36,6 +36,14 @@ static bool seq_nr_after(u16 a, u16 b)
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
 
+bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
+{
+	if (!hsr->redbox || !is_valid_ether_addr(hsr->macaddress_redbox))
+		return false;
+
+	return ether_addr_equal(addr, hsr->macaddress_redbox);
+}
+
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr)
 {
 	struct hsr_self_node *sn;
@@ -591,6 +599,10 @@ void hsr_prune_proxy_nodes(struct timer_list *t)
 
 	spin_lock_bh(&hsr->list_lock);
 	list_for_each_entry_safe(node, tmp, &hsr->proxy_node_db, mac_list) {
+		/* Don't prune RedBox node. */
+		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
+			continue;
+
 		timestamp = node->time_in[HSR_PT_INTERLINK];
 
 		/* Prune old entries */
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 7619e31c1d2d..993fa950d814 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -22,6 +22,7 @@ struct hsr_frame_info {
 	struct hsr_node *node_src;
 	u16 sequence_nr;
 	bool is_supervision;
+	bool is_proxy_supervision;
 	bool is_vlan;
 	bool is_local_dest;
 	bool is_local_exclusive;
@@ -35,6 +36,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 			      enum hsr_port_type rx_port);
 void hsr_handle_sup_frame(struct hsr_frame_info *frame);
 bool hsr_addr_is_self(struct hsr_priv *hsr, unsigned char *addr);
+bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr);
 
 void hsr_addr_subst_source(struct hsr_node *node, struct sk_buff *skb);
 void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 23850b16d1ea..ab1f8d35d9dc 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -170,7 +170,8 @@ struct hsr_node;
 
 struct hsr_proto_ops {
 	/* format and send supervision frame */
-	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval);
+	void (*send_sv_frame)(struct hsr_port *port, unsigned long *interval,
+			      const unsigned char addr[ETH_ALEN]);
 	void (*handle_san_frame)(bool san, enum hsr_port_type port,
 				 struct hsr_node *node);
 	bool (*drop_frame)(struct hsr_frame_info *frame, struct hsr_port *port);
@@ -197,6 +198,7 @@ struct hsr_priv {
 	struct list_head	proxy_node_db;	/* RedBox HSR proxy nodes */
 	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
 	struct timer_list	announce_timer;	/* Supervision frame dispatch */
+	struct timer_list	announce_proxy_timer;
 	struct timer_list	prune_timer;
 	struct timer_list	prune_proxy_timer;
 	int announce_count;
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 898f18c6da53..f6ff0b61e08a 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -131,6 +131,7 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 	del_timer_sync(&hsr->prune_timer);
 	del_timer_sync(&hsr->prune_proxy_timer);
 	del_timer_sync(&hsr->announce_timer);
+	timer_delete_sync(&hsr->announce_proxy_timer);
 
 	hsr_debugfs_term(hsr);
 	hsr_del_ports(hsr);
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 78b869b31492..3e30745e2c09 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -336,11 +336,11 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	skb_gro_remcsum_init(&grc);
+
 	if (!fou)
 		goto out;
 
-	skb_gro_remcsum_init(&grc);
-
 	off = skb_gro_offset(skb);
 	len = off + sizeof(*guehdr);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f891bc714668..ad935d34c973 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -334,15 +334,21 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1462,7 +1468,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		list_del(&entry->list);
 		kfree(entry);
 		return true;
 	}
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index f30163e2ca62..765ffd6e06bc 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -110,13 +110,13 @@ static void nft_socket_eval(const struct nft_expr *expr,
 			*dest = READ_ONCE(sk->sk_mark);
 		} else {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		break;
 	case NFT_SOCKET_WILDCARD:
 		if (!sk_fullsock(sk)) {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		nft_socket_wildcard(pkt, regs, sk, dest);
 		break;
@@ -124,7 +124,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 	case NFT_SOCKET_CGROUPV2:
 		if (!nft_sock_get_eval_cgroupv2(dest, sk, pkt, priv->level)) {
 			regs->verdict.code = NFT_BREAK;
-			return;
+			goto out_put_sk;
 		}
 		break;
 #endif
@@ -133,6 +133,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		regs->verdict.code = NFT_BREAK;
 	}
 
+out_put_sk:
 	if (sk != skb->sk)
 		sock_gen_put(sk);
 }
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 902eb429b9db..0b7952471c18 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -167,6 +167,8 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 			sed -i "/$CFG[ =]/d" $MERGE_FILE
 		fi
 	done
+	# In case the previous file lacks a new line at the end
+	echo >> $TMP_FILE
 	cat $MERGE_FILE >> $TMP_FILE
 done
 
diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 5dec69be0acb..06c83d2042f3 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -229,7 +229,8 @@ static int peb2466_reg_read(void *context, unsigned int reg, unsigned int *val)
 	case PEB2466_CMD_XOP:
 	case PEB2466_CMD_SOP:
 		ret = peb2466_read_byte(peb2466, reg, &tmp);
-		*val = tmp;
+		if (!ret)
+			*val = tmp;
 		break;
 	default:
 		dev_err(&peb2466->spi->dev, "Not a XOP or SOP command\n");
diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
index e6ffcd5be6c5..edfb668d0580 100644
--- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
@@ -208,6 +208,7 @@ static const struct snd_soc_acpi_link_adr lnl_cs42l43_l0[] = {
 		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
 		.adr_d = cs42l43_0_adr,
 	},
+	{}
 };
 
 static const struct snd_soc_acpi_link_adr lnl_rvp[] = {
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 8e0ae3635a35..d4435a34a3a3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -674,6 +674,7 @@ static const struct snd_soc_acpi_link_adr mtl_cs42l43_l0[] = {
 		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
 		.adr_d = cs42l43_0_adr,
 	},
+	{}
 };
 
 static const struct snd_soc_acpi_link_adr mtl_cs42l43_cs35l56[] = {
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 8c5605c1e34e..eb0302f20740 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -104,7 +104,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 				     int *index)
 {
 	struct meson_card *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai_link *pad = &card->dai_link[*index];
+	struct snd_soc_dai_link *pad;
 	struct snd_soc_dai_link *lb;
 	struct snd_soc_dai_link_component *dlc;
 	int ret;
@@ -114,6 +114,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	if (ret)
 		return ret;
 
+	pad = &card->dai_link[*index];
 	lb = &card->dai_link[*index + 1];
 
 	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index e91b59366030..c075d376fcab 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -1828,7 +1828,7 @@ static void unix_inet_redir_to_connected(int family, int type,
 	if (err)
 		return;
 
-	if (socketpair(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0, sfd))
+	if (socketpair(AF_UNIX, type | SOCK_NONBLOCK, 0, sfd))
 		goto close_cli0;
 	c1 = sfd[0], p1 = sfd[1];
 
@@ -1840,7 +1840,6 @@ static void unix_inet_redir_to_connected(int family, int type,
 close_cli0:
 	xclose(c0);
 	xclose(p0);
-
 }
 
 static void unix_inet_skb_redir_to_connected(struct test_sockmap_listen *skel,
diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
index b9f3fc3c3426..e0a34e5e8dd5 100644
--- a/tools/testing/selftests/net/lib/csum.c
+++ b/tools/testing/selftests/net/lib/csum.c
@@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int len)
 {
 	struct iphdr *iph = nh;
 	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
+	uint16_t ip_len;
 
 	if (len < sizeof(*iph) || iph->protocol != proto)
 		return -1;
 
+	ip_len = ntohs(iph->tot_len);
+	if (ip_len > len || ip_len < sizeof(*iph))
+		return -1;
+
+	len = ip_len;
 	iph_addr_p = &iph->saddr;
 	if (proto == IPPROTO_TCP)
 		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
@@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int len)
 {
 	struct ipv6hdr *ip6h = nh;
 	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
+	uint16_t ip_len;
 
 	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
 		return -1;
 
+	ip_len = ntohs(ip6h->payload_len);
+	if (ip_len > len - sizeof(*ip6h))
+		return -1;
+
+	len = ip_len;
 	iph_addr_p = &ip6h->saddr;
 
 	if (proto == IPPROTO_TCP)
-		return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6h));
+		return recv_verify_packet_tcp(ip6h + 1, len);
 	else
-		return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6h));
+		return recv_verify_packet_udp(ip6h + 1, len);
 }
 
 /* return whether auxdata includes TP_STATUS_CSUM_VALID */
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4762c49a878..cde041c93906 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3064,7 +3064,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3

