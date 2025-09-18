Return-Path: <stable+bounces-179117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C5FB50414
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90BB4E2467
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27B36208A;
	Tue,  9 Sep 2025 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVRPovWo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9635A28C;
	Tue,  9 Sep 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437864; cv=none; b=N1/JVtTtGlepeHcKLUFX8X4wcS8hmd4LR5Mx9UG6nvIYPN8uEzqCTx4DCvya5tKy909VBGXcGYlLNstbmokLSySiqqWfsehV34oDNDUGlQQbqqmzsSNCAAo13cC62gWqJebOmO3g3U1+1ldWcbJ1D4hyzj61yXvCaWnTBZLj2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437864; c=relaxed/simple;
	bh=KuSP83zunMnFMwC7HCTePPM6BdE4wLWkc0Sk0sClxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnBOcuDyRWBxSpqgndUIbkxWocV+obX7r5LLP/e4t7KQ6Gnokq6CKYge/PtsTaMXSBJFpMe51HOT9C4XF+1EE0NY/cfdXCE2Yi1UzBFFWj2E+II+jDxFETYWlxIJY6BZYBse0u/7sHIIcVKp53Tzj8l6mIKBm+YRLwX3VyD+Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVRPovWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F6BC4CEF4;
	Tue,  9 Sep 2025 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757437864;
	bh=KuSP83zunMnFMwC7HCTePPM6BdE4wLWkc0Sk0sClxzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVRPovWoWEMDlEz7xQxRQmULQ9U/n51hrgekiflOaiQUMWLVg3J2SScgeknXJ/DLF
	 xL9koD9QCjY9ez/Gt0TLF2DnnY88oj0jcDzhFn1kphKaHi+Pb0JkCfVgbqPVVNn8/n
	 Lb27rV+6dFuyADcTOFJN3GjqQxRNygg0TLgctG9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.151
Date: Tue,  9 Sep 2025 19:10:48 +0200
Message-ID: <2025090948-defacing-chute-7efa@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090948-gravitate-scurvy-b0f7@gregkh>
References: <2025090948-gravitate-scurvy-b0f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index e1704e10c654..565d019f9de0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 150
+SUBLEVEL = 151
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
index 0f13ee362771..2fd50b5890af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
@@ -508,6 +508,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
 	bus-width = <4>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 3d7b82e921f6..fa3e1aaae974 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -977,6 +977,7 @@ spiflash: flash@0 {
 		reg = <0>;
 		m25p,fast-read;
 		spi-max-frequency = <10000000>;
+		vcc-supply = <&vcc_3v0>;
 	};
 };
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 6c7f7c526450..96d95d1ed15d 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -40,6 +40,9 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() 0
 #endif /* CONFIG_X86_5LEVEL */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9d75b89fa257..339bf2195486 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,24 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+/*
+ * Make kernel mappings visible in all page tables in the system.
+ * This is necessary except when the init task populates kernel mappings
+ * during the boot process. In that case, all processes originating from
+ * the init task copies the kernel mappings, so there is no issue.
+ * Otherwise, missing synchronization could lead to kernel crashes due
+ * to missing page table entries for certain kernel mappings.
+ *
+ * Synchronization is performed at the top level, which is the PGD in
+ * 5-level paging systems. But in 4-level paging systems, however,
+ * pgd_populate() is a no-op, so synchronization is done at the P4D level.
+ * sync_global_pgds() handles this difference between paging levels.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3a6cf5675e60..93bb3e8a5bc0 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -928,8 +928,10 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
 
 	new_sids = krealloc_array(sids, count + new_count,
 				  sizeof(*new_sids), GFP_KERNEL);
-	if (!new_sids)
+	if (!new_sids) {
+		kfree(sids);
 		return NULL;
+	}
 
 	for (i = count; i < total_count; i++)
 		new_sids[i] = id_start++;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ee676ae1bc48..3ded51db833d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -172,7 +172,6 @@ struct vid_data {
  *			based on the MSR_IA32_MISC_ENABLE value and whether or
  *			not the maximum reported turbo P-state is different from
  *			the maximum reported non-turbo one.
- * @turbo_disabled_mf:	The @turbo_disabled value reflected by cpuinfo.max_freq.
  * @min_perf_pct:	Minimum capacity limit in percent of the maximum turbo
  *			P-state capacity.
  * @max_perf_pct:	Maximum capacity limit in percent of the maximum turbo
@@ -181,7 +180,6 @@ struct vid_data {
 struct global_params {
 	bool no_turbo;
 	bool turbo_disabled;
-	bool turbo_disabled_mf;
 	int max_perf_pct;
 	int min_perf_pct;
 };
@@ -559,16 +557,16 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
-static inline void update_turbo_state(void)
+static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
-	struct cpudata *cpu;
 
-	cpu = all_cpu_data[0];
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	global.turbo_disabled =
-		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
-		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
+
+	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
 static int min_perf_pct_min(void)
@@ -1123,40 +1121,16 @@ static void intel_pstate_update_policies(void)
 static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
 					   struct cpufreq_policy *policy)
 {
-	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
+	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
 	refresh_frequency_limits(policy);
 }
 
-static void intel_pstate_update_max_freq(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-
-	if (!policy)
-		return;
-
-	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
-
-	cpufreq_cpu_release(policy);
-}
-
 static void intel_pstate_update_limits(unsigned int cpu)
 {
 	mutex_lock(&intel_pstate_driver_lock);
 
-	update_turbo_state();
-	/*
-	 * If turbo has been turned on or off globally, policy limits for
-	 * all CPUs need to be updated to reflect that.
-	 */
-	if (global.turbo_disabled_mf != global.turbo_disabled) {
-		global.turbo_disabled_mf = global.turbo_disabled;
-		arch_set_max_freq_ratio(global.turbo_disabled);
-		for_each_possible_cpu(cpu)
-			intel_pstate_update_max_freq(cpu);
-	} else {
-		cpufreq_update_policy(cpu);
-	}
+	cpufreq_update_policy(cpu);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 }
@@ -1256,11 +1230,7 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 		return -EAGAIN;
 	}
 
-	update_turbo_state();
-	if (global.turbo_disabled)
-		ret = sprintf(buf, "%u\n", global.turbo_disabled);
-	else
-		ret = sprintf(buf, "%u\n", global.no_turbo);
+	ret = sprintf(buf, "%u\n", global.no_turbo);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1271,32 +1241,39 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 			      const char *buf, size_t count)
 {
 	unsigned int input;
-	int ret;
+	bool no_turbo;
 
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
+	if (sscanf(buf, "%u", &input) != 1)
 		return -EINVAL;
 
 	mutex_lock(&intel_pstate_driver_lock);
 
 	if (!intel_pstate_driver) {
-		mutex_unlock(&intel_pstate_driver_lock);
-		return -EAGAIN;
+		count = -EAGAIN;
+		goto unlock_driver;
 	}
 
-	mutex_lock(&intel_pstate_limits_lock);
+	no_turbo = !!clamp_t(int, input, 0, 1);
 
-	update_turbo_state();
-	if (global.turbo_disabled) {
-		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
-		mutex_unlock(&intel_pstate_limits_lock);
-		mutex_unlock(&intel_pstate_driver_lock);
-		return -EPERM;
+	WRITE_ONCE(global.turbo_disabled, turbo_is_disabled());
+	if (global.turbo_disabled && !no_turbo) {
+		pr_notice("Turbo disabled by BIOS or unavailable on processor\n");
+		count = -EPERM;
+		if (global.no_turbo)
+			goto unlock_driver;
+		else
+			no_turbo = 1;
 	}
 
-	global.no_turbo = clamp_t(int, input, 0, 1);
+	if (no_turbo == global.no_turbo) {
+		goto unlock_driver;
+	}
 
-	if (global.no_turbo) {
+	WRITE_ONCE(global.no_turbo, no_turbo);
+
+	mutex_lock(&intel_pstate_limits_lock);
+
+	if (no_turbo) {
 		struct cpudata *cpu = all_cpu_data[0];
 		int pct = cpu->pstate.max_pstate * 100 / cpu->pstate.turbo_pstate;
 
@@ -1308,8 +1285,9 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 	mutex_unlock(&intel_pstate_limits_lock);
 
 	intel_pstate_update_policies();
-	arch_set_max_freq_ratio(global.no_turbo);
+	arch_set_max_freq_ratio(no_turbo);
 
+unlock_driver:
 	mutex_unlock(&intel_pstate_driver_lock);
 
 	return count;
@@ -1757,7 +1735,7 @@ static u64 atom_get_val(struct cpudata *cpudata, int pstate)
 	u32 vid;
 
 	val = (u64)pstate << 8;
-	if (global.no_turbo && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
 		val |= (u64)1 << 32;
 
 	vid_fp = cpudata->vid.min + mul_fp(
@@ -1927,7 +1905,7 @@ static u64 core_get_val(struct cpudata *cpudata, int pstate)
 	u64 val;
 
 	val = (u64)pstate << 8;
-	if (global.no_turbo && !global.turbo_disabled)
+	if (READ_ONCE(global.no_turbo) && !READ_ONCE(global.turbo_disabled))
 		val |= (u64)1 << 32;
 
 	return val;
@@ -1988,14 +1966,6 @@ static void intel_pstate_set_min_pstate(struct cpudata *cpu)
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
 }
 
-static void intel_pstate_max_within_limits(struct cpudata *cpu)
-{
-	int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
-
-	update_turbo_state();
-	intel_pstate_set_pstate(cpu, pstate);
-}
-
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = pstate_funcs.get_max_physical(cpu->cpu);
@@ -2221,7 +2191,7 @@ static inline int32_t get_target_pstate(struct cpudata *cpu)
 
 	sample->busy_scaled = busy_frac * 100;
 
-	target = global.no_turbo || global.turbo_disabled ?
+	target = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
 	target += target >> 2;
 	target = mul_fp(target, busy_frac);
@@ -2265,8 +2235,6 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 	struct sample *sample;
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = get_target_pstate(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
@@ -2492,7 +2460,7 @@ static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 
 static int intel_pstate_get_max_freq(struct cpudata *cpu)
 {
-	return global.turbo_disabled || global.no_turbo ?
+	return READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 }
 
@@ -2577,12 +2545,14 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
+
 		/*
 		 * NOHZ_FULL CPUs need this as the governor callback may not
 		 * be invoked on them.
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
-		intel_pstate_max_within_limits(cpu);
+		intel_pstate_set_pstate(cpu, pstate);
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}
@@ -2625,10 +2595,9 @@ static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
 {
 	int max_freq;
 
-	update_turbo_state();
 	if (hwp_active) {
 		intel_pstate_get_hwp_cap(cpu);
-		max_freq = global.no_turbo || global.turbo_disabled ?
+		max_freq = READ_ONCE(global.no_turbo) ?
 				cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 	} else {
 		max_freq = intel_pstate_get_max_freq(cpu);
@@ -2722,8 +2691,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_freq;
-	update_turbo_state();
-	global.turbo_disabled_mf = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
@@ -2889,8 +2856,6 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	int target_pstate;
 
-	update_turbo_state();
-
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
@@ -2912,8 +2877,6 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
@@ -2931,7 +2894,6 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
 
-	update_turbo_state();
 	cap_pstate = global.turbo_disabled ? HWP_GUARANTEED_PERF(hwp_cap) :
 					     HWP_HIGHEST_PERF(hwp_cap);
 
@@ -3121,6 +3083,10 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
+	global.turbo_disabled = turbo_is_disabled();
+	global.no_turbo = global.turbo_disabled;
+
+	arch_set_max_freq_ratio(global.turbo_disabled);
 
 	intel_pstate_driver = driver;
 	ret = cpufreq_register_driver(intel_pstate_driver);
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 9ae92b8940ef..661521064c34 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -421,15 +421,11 @@ static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
 {
 	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
 	struct virt_dma_desc *vd;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cvc->pc->lock, flags);
 	list_for_each_entry(vd, &cvc->pc->queue, node)
 		if (vd->tx.cookie == cookie) {
-			spin_unlock_irqrestore(&cvc->pc->lock, flags);
 			return vd;
 		}
-	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
 		if (vd->tx.cookie == cookie)
@@ -453,9 +449,11 @@ static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
-	spin_lock_irqsave(&cvc->vc.lock, flags);
+	spin_lock_irqsave(&cvc->pc->lock, flags);
+	spin_lock(&cvc->vc.lock);
 	vd = mtk_cqdma_find_active_desc(c, cookie);
-	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+	spin_unlock(&cvc->vc.lock);
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
 
 	if (vd) {
 		cvd = to_cqdma_vdesc(vd);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ae6643c8ade6..0bc21106d9e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -222,21 +222,22 @@ static int psp_memory_training_init(struct psp_context *psp)
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
 
 	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
-		DRM_DEBUG("memory training is not supported!\n");
+		dev_dbg(psp->adev->dev, "memory training is not supported!\n");
 		return 0;
 	}
 
 	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
 	if (ctx->sys_cache == NULL) {
-		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
+		dev_err(psp->adev->dev, "alloc mem_train_ctx.sys_cache failed!\n");
 		ret = -ENOMEM;
 		goto Err_out;
 	}
 
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
-		  ctx->train_data_size,
-		  ctx->p2c_train_data_offset,
-		  ctx->c2p_train_data_offset);
+	dev_dbg(psp->adev->dev,
+		"train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+		ctx->train_data_size,
+		ctx->p2c_train_data_offset,
+		ctx->c2p_train_data_offset);
 	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
 	return 0;
 
@@ -371,8 +372,8 @@ static int psp_sw_init(void *handle)
 
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
-		DRM_ERROR("Failed to allocate memory to command buffer!\n");
-		ret = -ENOMEM;
+		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
+		return -ENOMEM;
 	}
 
 	if (amdgpu_sriov_vf(adev))
@@ -392,7 +393,7 @@ static int psp_sw_init(void *handle)
 	if ((psp_get_runtime_db_entry(adev,
 				PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS,
 				&scpm_entry)) &&
-	    (SCPM_DISABLE != scpm_entry.scpm_status)) {
+	    (scpm_entry.scpm_status != SCPM_DISABLE)) {
 		adev->scpm_enabled = true;
 		adev->scpm_status = scpm_entry.scpm_status;
 	} else {
@@ -426,23 +427,22 @@ static int psp_sw_init(void *handle)
 	if (mem_training_ctx->enable_mem_training) {
 		ret = psp_memory_training_init(psp);
 		if (ret) {
-			DRM_ERROR("Failed to initialize memory training!\n");
+			dev_err(adev->dev, "Failed to initialize memory training!\n");
 			return ret;
 		}
 
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
 		if (ret) {
-			DRM_ERROR("Failed to process memory training!\n");
+			dev_err(adev->dev, "Failed to process memory training!\n");
 			return ret;
 		}
 	}
 
 	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
-		ret= psp_sysfs_init(adev);
-		if (ret) {
+		ret = psp_sysfs_init(adev);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
@@ -641,7 +641,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	skip_unsupport = (psp->cmd_buf_mem->resp.status == TEE_ERROR_NOT_SUPPORTED ||
 		psp->cmd_buf_mem->resp.status == PSP_ERR_UNKNOWN_COMMAND) && amdgpu_sriov_vf(psp->adev);
 
-	memcpy((void*)&cmd->resp, (void*)&psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
+	memcpy(&cmd->resp, &psp->cmd_buf_mem->resp, sizeof(struct psp_gfx_resp));
 
 	/* In some cases, psp response status is not 0 even there is no
 	 * problem while the command is submitted. Some version of PSP FW
@@ -652,9 +652,11 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
-			DRM_WARN("failed to load ucode %s(0x%X) ",
-				  amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
-		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
+			dev_warn(psp->adev->dev,
+				 "failed to load ucode %s(0x%X) ",
+				 amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
+		dev_warn(psp->adev->dev,
+			 "psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
 			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
 		/* If any firmware (including CAP) load fails under SRIOV, it should
@@ -698,8 +700,13 @@ static void psp_prep_tmr_cmd_buf(struct psp_context *psp,
 				 uint64_t tmr_mc, struct amdgpu_bo *tmr_bo)
 {
 	struct amdgpu_device *adev = psp->adev;
-	uint32_t size = amdgpu_bo_size(tmr_bo);
-	uint64_t tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+	uint32_t size = 0;
+	uint64_t tmr_pa = 0;
+
+	if (tmr_bo) {
+		size = amdgpu_bo_size(tmr_bo);
+		tmr_pa = amdgpu_gmc_vram_pa(adev, tmr_bo);
+	}
 
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_SETUP_VMR;
@@ -744,6 +751,16 @@ static int psp_load_toc(struct psp_context *psp,
 	return ret;
 }
 
+static bool psp_boottime_tmr(struct psp_context *psp)
+{
+	switch (psp->adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 6):
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* Set up Trusted Memory Region */
 static int psp_tmr_init(struct psp_context *psp)
 {
@@ -769,7 +786,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	    psp->fw_pri_buf) {
 		ret = psp_load_toc(psp, &tmr_size);
 		if (ret) {
-			DRM_ERROR("Failed to load toc\n");
+			dev_err(psp->adev->dev, "Failed to load toc\n");
 			return ret;
 		}
 	}
@@ -811,8 +828,9 @@ static int psp_tmr_load(struct psp_context *psp)
 	cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
-	DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
-		 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
+	if (psp->tmr_bo)
+		dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP TMR\n",
+			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -823,7 +841,7 @@ static int psp_tmr_load(struct psp_context *psp)
 }
 
 static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
-				        struct psp_gfx_cmd_resp *cmd)
+					struct psp_gfx_cmd_resp *cmd)
 {
 	if (amdgpu_sriov_vf(psp->adev))
 		cmd->cmd_id = GFX_CMD_ID_DESTROY_VMR;
@@ -994,6 +1012,8 @@ int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
+	context->resp_status = cmd->resp.status;
+
 	release_psp_cmd_buf(psp);
 
 	return ret;
@@ -1038,7 +1058,7 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
-		DRM_ERROR("PSP failed to program reg id %d", reg);
+		dev_err(psp->adev->dev, "PSP failed to program reg id %d\n", reg);
 
 	release_psp_cmd_buf(psp);
 
@@ -1050,7 +1070,7 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     struct ta_context *context)
 {
 	cmd->cmd_id				= context->ta_load_type;
-	cmd->cmd.cmd_load_ta.app_phy_addr_lo 	= lower_32_bits(ta_bin_mc);
+	cmd->cmd.cmd_load_ta.app_phy_addr_lo	= lower_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
@@ -1156,9 +1176,8 @@ int psp_ta_load(struct psp_context *psp, struct ta_context *context)
 
 	context->resp_status = cmd->resp.status;
 
-	if (!ret) {
+	if (!ret)
 		context->session_id = cmd->resp.session_id;
-	}
 
 	release_psp_cmd_buf(psp);
 
@@ -1450,22 +1469,22 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 	switch (ras_cmd->ras_status) {
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_IP:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: cmd failed due to unsupported ip\n");
+			 "RAS WARNING: cmd failed due to unsupported ip\n");
 		break;
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: cmd failed due to unsupported error injection\n");
+			 "RAS WARNING: cmd failed due to unsupported error injection\n");
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
 	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
 		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR)
 			dev_warn(psp->adev->dev,
-					"RAS WARNING: Inject error to critical region is not allowed\n");
+				 "RAS WARNING: Inject error to critical region is not allowed\n");
 		break;
 	default:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
+			 "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
 		break;
 	}
 }
@@ -1488,9 +1507,8 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_ras_intr_triggered())
 		return ret;
 
-	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER)
-	{
-		DRM_WARN("RAS: Unsupported Interface");
+	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
+		dev_warn(psp->adev->dev, "RAS: Unsupported Interface\n");
 		return -EINVAL;
 	}
 
@@ -1499,8 +1517,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 			dev_warn(psp->adev->dev, "ECC switch disabled\n");
 
 			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
-		}
-		else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+		} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
 			dev_warn(psp->adev->dev,
 				 "RAS internal register access blocked\n");
 
@@ -1596,11 +1613,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 				if (ret)
 					dev_warn(adev->dev, "PSP set boot config failed\n");
 				else
-					dev_warn(adev->dev, "GECC will be disabled in next boot cycle "
-						 "if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
+					dev_warn(adev->dev, "GECC will be disabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
 			}
 		} else {
-			if (1 == boot_cfg) {
+			if (boot_cfg == 1) {
 				dev_info(adev->dev, "GECC is enabled\n");
 			} else {
 				/* enable GECC in next boot cycle if it is disabled
@@ -1619,7 +1635,7 @@ static int psp_ras_initialize(struct psp_context *psp)
 	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
 	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->ras_context.context.initialized) {
+	if (!psp->ras_context.context.mem_context.shared_buf) {
 		ret = psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
 		if (ret)
 			return ret;
@@ -1639,8 +1655,10 @@ static int psp_ras_initialize(struct psp_context *psp)
 		psp->ras_context.context.initialized = true;
 	else {
 		if (ras_cmd->ras_status)
-			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
-		amdgpu_ras_fini(psp->adev);
+			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
+
+		/* fail to load RAS TA */
+		psp->ras_context.context.initialized = false;
 	}
 
 	return ret;
@@ -2021,7 +2039,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
 			if (ret) {
-				DRM_ERROR("PSP load kdb failed!\n");
+				dev_err(adev->dev, "PSP load kdb failed!\n");
 				return ret;
 			}
 		}
@@ -2030,7 +2048,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_spl != NULL)) {
 			ret = psp_bootloader_load_spl(psp);
 			if (ret) {
-				DRM_ERROR("PSP load spl failed!\n");
+				dev_err(adev->dev, "PSP load spl failed!\n");
 				return ret;
 			}
 		}
@@ -2039,7 +2057,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sysdrv != NULL)) {
 			ret = psp_bootloader_load_sysdrv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load sys drv failed!\n");
+				dev_err(adev->dev, "PSP load sys drv failed!\n");
 				return ret;
 			}
 		}
@@ -2048,7 +2066,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_soc_drv != NULL)) {
 			ret = psp_bootloader_load_soc_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load soc drv failed!\n");
+				dev_err(adev->dev, "PSP load soc drv failed!\n");
 				return ret;
 			}
 		}
@@ -2057,7 +2075,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_intf_drv != NULL)) {
 			ret = psp_bootloader_load_intf_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load intf drv failed!\n");
+				dev_err(adev->dev, "PSP load intf drv failed!\n");
 				return ret;
 			}
 		}
@@ -2066,7 +2084,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_dbg_drv != NULL)) {
 			ret = psp_bootloader_load_dbg_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load dbg drv failed!\n");
+				dev_err(adev->dev, "PSP load dbg drv failed!\n");
 				return ret;
 			}
 		}
@@ -2075,7 +2093,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_ras_drv != NULL)) {
 			ret = psp_bootloader_load_ras_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load ras_drv failed!\n");
+				dev_err(adev->dev, "PSP load ras_drv failed!\n");
 				return ret;
 			}
 		}
@@ -2084,7 +2102,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
 			if (ret) {
-				DRM_ERROR("PSP load sos failed!\n");
+				dev_err(adev->dev, "PSP load sos failed!\n");
 				return ret;
 			}
 		}
@@ -2092,17 +2110,19 @@ static int psp_hw_start(struct psp_context *psp)
 
 	ret = psp_ring_create(psp, PSP_RING_TYPE__KM);
 	if (ret) {
-		DRM_ERROR("PSP create ring failed!\n");
+		dev_err(adev->dev, "PSP create ring failed!\n");
 		return ret;
 	}
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
 		goto skip_pin_bo;
 
-	ret = psp_tmr_init(psp);
-	if (ret) {
-		DRM_ERROR("PSP tmr init failed!\n");
-		return ret;
+	if (!psp_boottime_tmr(psp)) {
+		ret = psp_tmr_init(psp);
+		if (ret) {
+			dev_err(adev->dev, "PSP tmr init failed!\n");
+			return ret;
+		}
 	}
 
 skip_pin_bo:
@@ -2119,7 +2139,7 @@ static int psp_hw_start(struct psp_context *psp)
 
 	ret = psp_tmr_load(psp);
 	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
+		dev_err(adev->dev, "PSP load tmr failed!\n");
 		return ret;
 	}
 
@@ -2366,7 +2386,8 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 	}
 }
 
-static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
+static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
+				       struct amdgpu_firmware_info *ucode,
 				       struct psp_gfx_cmd_resp *cmd)
 {
 	int ret;
@@ -2379,18 +2400,18 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 
 	ret = psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
-		DRM_ERROR("Unknown firmware type\n");
+		dev_err(psp->adev->dev, "Unknown firmware type\n");
 
 	return ret;
 }
 
 static int psp_execute_non_psp_fw_load(struct psp_context *psp,
-			          struct amdgpu_firmware_info *ucode)
+				  struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
+	ret = psp_prep_load_ip_fw_cmd_buf(psp, ucode, cmd);
 	if (!ret) {
 		ret = psp_cmd_submit_buf(psp, ucode, cmd,
 					 psp->fence_buf_mc_addr);
@@ -2424,15 +2445,14 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	     (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 4) ||
 	      adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 2)))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
-		if (ret) {
-			DRM_WARN("Failed to set MP1 state prepare for reload\n");
-		}
+		if (ret)
+			dev_err(adev->dev, "Failed to set MP1 state prepare for reload\n");
 	}
 
 	ret = psp_execute_non_psp_fw_load(psp, ucode);
 
 	if (ret)
-		DRM_ERROR("PSP load smu failed!\n");
+		dev_err(adev->dev, "PSP load smu failed!\n");
 
 	return ret;
 }
@@ -2527,7 +2547,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		    adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
-				DRM_ERROR("Failed to start rlc autoload\n");
+				dev_err(adev->dev, "Failed to start rlc autoload\n");
 				return ret;
 			}
 		}
@@ -2549,7 +2569,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 		ret = psp_ring_init(psp, PSP_RING_TYPE__KM);
 		if (ret) {
-			DRM_ERROR("PSP ring init failed!\n");
+			dev_err(adev->dev, "PSP ring init failed!\n");
 			goto failed;
 		}
 	}
@@ -2564,13 +2584,13 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		DRM_ERROR("PSP load asd failed!\n");
+		dev_err(adev->dev, "PSP load asd failed!\n");
 		goto failed1;
 	}
 
 	ret = psp_rl_load(adev);
 	if (ret) {
-		DRM_ERROR("PSP load RL failed!\n");
+		dev_err(adev->dev, "PSP load RL failed!\n");
 		goto failed1;
 	}
 
@@ -2590,7 +2610,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		ret = psp_ras_initialize(psp);
 		if (ret)
 			dev_err(psp->adev->dev,
-					"RAS: Failed to initialize RAS\n");
+				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
@@ -2643,7 +2663,7 @@ static int psp_hw_init(void *handle)
 
 	ret = psp_load_fw(adev);
 	if (ret) {
-		DRM_ERROR("PSP firmware loading failed\n");
+		dev_err(adev->dev, "PSP firmware loading failed\n");
 		goto failed;
 	}
 
@@ -2690,7 +2710,7 @@ static int psp_suspend(void *handle)
 	    psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate xgmi ta\n");
+			dev_err(adev->dev, "Failed to terminate xgmi ta\n");
 			goto out;
 		}
 	}
@@ -2698,47 +2718,46 @@ static int psp_suspend(void *handle)
 	if (psp->ta_fw) {
 		ret = psp_ras_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate ras ta\n");
+			dev_err(adev->dev, "Failed to terminate ras ta\n");
 			goto out;
 		}
 		ret = psp_hdcp_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate hdcp ta\n");
+			dev_err(adev->dev, "Failed to terminate hdcp ta\n");
 			goto out;
 		}
 		ret = psp_dtm_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate dtm ta\n");
+			dev_err(adev->dev, "Failed to terminate dtm ta\n");
 			goto out;
 		}
 		ret = psp_rap_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate rap ta\n");
+			dev_err(adev->dev, "Failed to terminate rap ta\n");
 			goto out;
 		}
 		ret = psp_securedisplay_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate securedisplay ta\n");
+			dev_err(adev->dev, "Failed to terminate securedisplay ta\n");
 			goto out;
 		}
 	}
 
 	ret = psp_asd_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to terminate asd\n");
+		dev_err(adev->dev, "Failed to terminate asd\n");
 		goto out;
 	}
 
 	ret = psp_tmr_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to terminate tmr\n");
+		dev_err(adev->dev, "Failed to terminate tmr\n");
 		goto out;
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
-	if (ret) {
-		DRM_ERROR("PSP ring stop failed\n");
-	}
+	if (ret)
+		dev_err(adev->dev, "PSP ring stop failed\n");
 
 out:
 	return ret;
@@ -2750,12 +2769,12 @@ static int psp_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
-	DRM_INFO("PSP is resuming...\n");
+	dev_info(adev->dev, "PSP is resuming...\n");
 
 	if (psp->mem_train_ctx.enable_mem_training) {
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
 		if (ret) {
-			DRM_ERROR("Failed to process memory training!\n");
+			dev_err(adev->dev, "Failed to process memory training!\n");
 			return ret;
 		}
 	}
@@ -2772,7 +2791,7 @@ static int psp_resume(void *handle)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		DRM_ERROR("PSP load asd failed!\n");
+		dev_err(adev->dev, "PSP load asd failed!\n");
 		goto failed;
 	}
 
@@ -2796,7 +2815,7 @@ static int psp_resume(void *handle)
 		ret = psp_ras_initialize(psp);
 		if (ret)
 			dev_err(psp->adev->dev,
-					"RAS: Failed to initialize RAS\n");
+				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
@@ -2824,7 +2843,7 @@ static int psp_resume(void *handle)
 	return 0;
 
 failed:
-	DRM_ERROR("PSP resume failed\n");
+	dev_err(adev->dev, "PSP resume failed\n");
 	mutex_unlock(&adev->firmware.mutex);
 	return ret;
 }
@@ -2898,9 +2917,11 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 		write_frame = ring_buffer_start + (psp_write_ptr_reg / rb_frame_size_dw);
 	/* Check invalid write_frame ptr address */
 	if ((write_frame < ring_buffer_start) || (ring_buffer_end < write_frame)) {
-		DRM_ERROR("ring_buffer_start = %p; ring_buffer_end = %p; write_frame = %p\n",
-			  ring_buffer_start, ring_buffer_end, write_frame);
-		DRM_ERROR("write_frame is pointing to address out of bounds\n");
+		dev_err(adev->dev,
+			"ring_buffer_start = %p; ring_buffer_end = %p; write_frame = %p\n",
+			ring_buffer_start, ring_buffer_end, write_frame);
+		dev_err(adev->dev,
+			"write_frame is pointing to address out of bounds\n");
 		return -EINVAL;
 	}
 
@@ -3011,7 +3032,7 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->sos.fw_version        = le32_to_cpu(desc->fw_version);
 		psp->sos.feature_version   = le32_to_cpu(desc->fw_version);
 		psp->sos.size_bytes        = le32_to_cpu(desc->size_bytes);
-		psp->sos.start_addr 	   = ucode_start_addr;
+		psp->sos.start_addr	   = ucode_start_addr;
 		break;
 	case PSP_FW_TYPE_PSP_SYS_DRV:
 		psp->sys.fw_version        = le32_to_cpu(desc->fw_version);
@@ -3412,7 +3433,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	int ret;
 
 	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
+		dev_info(adev->dev, "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
 
@@ -3421,7 +3442,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	mutex_unlock(&adev->psp.mutex);
 
 	if (ret) {
-		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to read USBC PD FW, err = %d\n", ret);
 		return ret;
 	}
 
@@ -3443,7 +3464,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	void *fw_pri_cpu_addr;
 
 	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
+		dev_err(adev->dev, "PSP block is not ready yet.");
 		return -EBUSY;
 	}
 
@@ -3476,7 +3497,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	release_firmware(usbc_pd_fw);
 fail:
 	if (ret) {
-		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to load USBC PD FW, err = %d", ret);
 		count = ret;
 	}
 
@@ -3497,7 +3518,7 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 	drm_dev_exit(idx);
 }
 
-static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(usbc_pd_fw, 0644,
 		   psp_usbc_pd_fw_sysfs_read,
 		   psp_usbc_pd_fw_sysfs_write);
 
@@ -3518,7 +3539,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 
 	/* Safeguard against memory drain */
 	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
-		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
+		dev_err(adev->dev, "File size cannot exceed %u\n", AMD_VBIOS_FILE_MAX_SIZE_B);
 		kvfree(adev->psp.vbflash_tmp_buf);
 		adev->psp.vbflash_tmp_buf = NULL;
 		adev->psp.vbflash_image_size = 0;
@@ -3537,7 +3558,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size += count;
 	mutex_unlock(&adev->psp.mutex);
 
-	dev_info(adev->dev, "VBIOS flash write PSP done");
+	dev_dbg(adev->dev, "IFWI staged for update\n");
 
 	return count;
 }
@@ -3557,7 +3578,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	if (adev->psp.vbflash_image_size == 0)
 		return -EINVAL;
 
-	dev_info(adev->dev, "VBIOS flash to PSP started");
+	dev_dbg(adev->dev, "PSP IFWI flash process initiated\n");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
 					AMDGPU_GPU_PAGE_SIZE,
@@ -3582,11 +3603,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size = 0;
 
 	if (ret) {
-		dev_err(adev->dev, "Failed to load VBIOS FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to load IFWI, err = %d\n", ret);
 		return ret;
 	}
 
-	dev_info(adev->dev, "VBIOS flash to PSP done");
+	dev_dbg(adev->dev, "PSP IFWI flash process done\n");
 	return 0;
 }
 
@@ -3682,8 +3703,7 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
 }
 
-const struct amdgpu_ip_block_version psp_v3_1_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v3_1_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 3,
 	.minor = 1,
@@ -3691,8 +3711,7 @@ const struct amdgpu_ip_block_version psp_v3_1_ip_block =
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v10_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v10_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 10,
 	.minor = 0,
@@ -3700,8 +3719,7 @@ const struct amdgpu_ip_block_version psp_v10_0_ip_block =
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v11_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v11_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 11,
 	.minor = 0,
@@ -3717,8 +3735,7 @@ const struct amdgpu_ip_block_version psp_v11_0_8_ip_block = {
 	.funcs = &psp_ip_funcs,
 };
 
-const struct amdgpu_ip_block_version psp_v12_0_ip_block =
-{
+const struct amdgpu_ip_block_version psp_v12_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 12,
 	.minor = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f8305afa59c9..16be61abd998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2024,11 +2024,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					true, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return drm_sched_entity_flush(&vm->delayed, timeout);
+	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 288fce7dc0ed..efc85aa157dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1464,17 +1464,12 @@ static int dce_v10_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index cbe5250b31cb..91a7f9a4faea 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1506,17 +1506,12 @@ static int dce_v11_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index b1c44fab074f..6376a252e3f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1375,17 +1375,12 @@ static int dce_v6_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a22b45c92792..e93931655243 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1427,17 +1427,12 @@ static int dce_v8_0_audio_init(struct amdgpu_device *adev)
 
 static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
 {
-	int i;
-
 	if (!amdgpu_audio)
 		return;
 
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
-
 	adev->mode_info.audio.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 09260c23c3bd..85926d230044 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -897,13 +897,13 @@ void dce110_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
@@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
 						enc110->base.id, &bp_cap_info);
 
 	/* Override features with DCE-specific values */
-	if (BP_RESULT_OK == result) {
+	if (result == BP_RESULT_OK) {
 		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
 				bp_cap_info.DP_HBR2_EN;
 		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
 				bp_cap_info.DP_HBR3_EN;
 		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
-	} else {
+	} else if (result != BP_RESULT_NORECORD) {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
 				__func__,
 				result);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 153a88381f2c..fd9809b17882 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -29,6 +29,8 @@
 #include "dc_link_dp.h"
 #include "clk_mgr.h"
 
+#define DC_LOGGER link->ctx->logger
+
 static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 {
 	switch (link->link_enc->transmitter) {
@@ -224,6 +226,11 @@ static void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment)) {
 		disable_hpo_dp_fpga_link_output(link, link_res, signal);
 	} else {
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6595f954135a..d31bb9153f4f 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -375,6 +375,17 @@ static int __maybe_unused ti_sn65dsi86_resume(struct device *dev)
 
 	gpiod_set_value(pdata->enable_gpio, 1);
 
+	/*
+	 * After EN is deasserted and an external clock is detected, the bridge
+	 * will sample GPIO3:1 to determine its frequency. The driver will
+	 * overwrite this setting in ti_sn_bridge_set_refclk_freq(). But this is
+	 * racy. Thus we have to wait a couple of us. According to the datasheet
+	 * the GPIO lines has to be stable at least 5 us (td5) but it seems that
+	 * is not enough and the refclk frequency value is still lost or
+	 * overwritten by the bridge itself. Waiting for 20us seems to work.
+	 */
+	usleep_range(20, 30);
+
 	/*
 	 * If we have a reference clock we can enable communication w/ the
 	 * panel (including the aux channel) w/out any need for an input clock
diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index 96017cc8da7e..7514d5766104 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -551,15 +551,14 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
 		if (!pwm->connected)
 			continue;
 		pwm->fan = fan;
+		/* Set minimal PWM speed. */
+		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
 		pwm->cdev = devm_thermal_of_cooling_device_register(dev, NULL, mlxreg_fan_name[i],
 								    pwm, &mlxreg_fan_cooling_ops);
 		if (IS_ERR(pwm->cdev)) {
 			dev_err(dev, "Failed to register cooling device\n");
 			return PTR_ERR(pwm->cdev);
 		}
-
-		/* Set minimal PWM speed. */
-		pwm->last_hwmon_state = MLXREG_FAN_PWM_DUTY2STATE(MLXREG_FAN_MIN_DUTY);
 	}
 
 	return 0;
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 61d7a27aa070..55f7ab3eddf3 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -337,9 +337,11 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU) {
 		dev->slave = i2c_new_ccgx_ucsi(&dev->adapter, dev->irq, &dgpu_node);
-		if (IS_ERR(dev->slave))
+		if (IS_ERR(dev->slave)) {
+			i2c_del_adapter(&dev->adapter);
 			return dev_err_probe(dev->dev, PTR_ERR(dev->slave),
 					     "register UCSI failed\n");
+		}
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index e9857d93b307..70c92cbfc9f1 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <asm/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 9d1d803af1cb..2496363dfe43 100644
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
diff --git a/drivers/isdn/mISDN/dsp_hwec.c b/drivers/isdn/mISDN/dsp_hwec.c
index 0b3f29195330..0cd216e28f00 100644
--- a/drivers/isdn/mISDN/dsp_hwec.c
+++ b/drivers/isdn/mISDN/dsp_hwec.c
@@ -51,14 +51,14 @@ void dsp_hwec_enable(struct dsp *dsp, const char *arg)
 		goto _do;
 
 	{
-		char *dup, *tok, *name, *val;
+		char *dup, *next, *tok, *name, *val;
 		int tmp;
 
-		dup = kstrdup(arg, GFP_ATOMIC);
+		dup = next = kstrdup(arg, GFP_ATOMIC);
 		if (!dup)
 			return;
 
-		while ((tok = strsep(&dup, ","))) {
+		while ((tok = strsep(&next, ","))) {
 			if (!strlen(tok))
 				continue;
 			name = strsep(&tok, "=");
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 495a1cb0bc18..1ea7c86f7501 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1174,11 +1174,12 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	u16 queue_index = queue - bp->queues;
+	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
 	int packets = 0;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = queue->tx_head;
 	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
@@ -1241,7 +1242,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	    CIRC_CNT(queue->tx_head, queue->tx_tail,
 		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->dev, queue_index);
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return packets;
 }
@@ -1657,8 +1658,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	if (queue->tx_head == queue->tx_tail)
 		goto out_tx_ptr_unlock;
@@ -1670,19 +1672,20 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
 	bool retval = false;
+	unsigned long flags;
 
-	spin_lock(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	if (queue->tx_head != queue->tx_tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1690,7 +1693,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
-	spin_unlock(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	return retval;
 }
 
@@ -2258,6 +2261,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct macb_queue *queue = &bp->queues[queue_index];
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	unsigned int hdrlen;
+	unsigned long flags;
 	bool is_lso;
 	netdev_tx_t ret = NETDEV_TX_OK;
 
@@ -2312,7 +2316,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		desc_cnt += DIV_ROUND_UP(frag_size, bp->max_tx_length);
 	}
 
-	spin_lock_bh(&queue->tx_ptr_lock);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
@@ -2334,15 +2338,15 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	wmb();
 	skb_tx_timestamp(skb);
 
-	spin_lock_irq(&bp->lock);
+	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock_irq(&bp->lock);
+	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
 		netif_stop_subqueue(dev, queue_index);
 
 unlock:
-	spin_unlock_bh(&queue->tx_ptr_lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 8c955eefc7e4..bb70afae10c4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1492,13 +1492,17 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * this cortina phy, for which there is no driver
 		 * support, ignore it.
 		 */
-		if (phy_np &&
-		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
-			/* Wait until the phy drivers are available */
-			pd = of_phy_find_device(phy_np);
-			if (!pd)
-				goto defer;
-			bgx->lmac[lmac].phydev = pd;
+		if (phy_np) {
+			if (!of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {
+				/* Wait until the phy drivers are available */
+				pd = of_phy_find_device(phy_np);
+				if (!pd) {
+					of_node_put(phy_np);
+					goto defer;
+				}
+				bgx->lmac[lmac].phydev = pd;
+			}
+			of_node_put(phy_np);
 		}
 
 		lmac++;
@@ -1514,11 +1518,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	 * for phy devices we may have already found.
 	 */
 	while (lmac) {
+		lmac--;
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
 	of_node_put(node);
 	return -EPROBE_DEFER;
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 51a5afe9df2f..40de9f689331 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -559,12 +559,12 @@ static int e1000_set_eeprom(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
+	size_t total_len, max_len;
 	u16 *eeprom_buff;
-	void *ptr;
-	int max_len;
+	int ret_val = 0;
 	int first_word;
 	int last_word;
-	int ret_val = 0;
+	void *ptr;
 	u16 i;
 
 	if (eeprom->len == 0)
@@ -579,6 +579,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
+	if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
+	    total_len > max_len)
+		return -EFBIG;
+
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a289f1bb3dbf..86fd82412e9e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -362,8 +362,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
 		goto free_cdev;
 
-	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
-			       struct netdev_hw_addr, list);
+	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
+				       struct netdev_hw_addr, list);
 	if (mac)
 		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
 	else
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fecf3dd22dfa..3f2f725ccceb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1375,6 +1375,13 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool gso = false;
 	int tx_num;
 
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_proto_is_802_3(eth_hdr(skb)->h_proto)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			goto dropped;
+	}
+
 	/* normally we can rely on the stack not calling this more than once,
 	 * however we have 2 queues running on the same ring so we need to lock
 	 * the ring access
@@ -1420,8 +1427,9 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 drop:
 	spin_unlock(&eth->page_lock);
-	stats->tx_dropped++;
 	dev_kfree_skb_any(skb);
+dropped:
+	stats->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/ethernet/xircom/xirc2ps_cs.c b/drivers/net/ethernet/xircom/xirc2ps_cs.c
index 9f505cf02d96..2dc1cfcd7ce9 100644
--- a/drivers/net/ethernet/xircom/xirc2ps_cs.c
+++ b/drivers/net/ethernet/xircom/xirc2ps_cs.c
@@ -1578,7 +1578,7 @@ do_reset(struct net_device *dev, int full)
 	    msleep(40);			/* wait 40 msec to let it complete */
 	}
 	if (full_duplex)
-	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR | FullDuplex));
+	    PutByte(XIRCREG1_ECR, GetByte(XIRCREG1_ECR) | FullDuplex);
     } else {  /* No MII */
 	SelectPage(0);
 	value = GetByte(XIRCREG_ESR);	 /* read the ESR */
diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 847ab37f1367..2d5dd90fc8f3 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -18,7 +18,7 @@
 #define MIIC_PRCMD			0x0
 #define MIIC_ESID_CODE			0x4
 
-#define MIIC_MODCTRL			0x20
+#define MIIC_MODCTRL			0x8
 #define MIIC_MODCTRL_SW_MODE		GENMASK(4, 0)
 
 #define MIIC_CONVCTRL(port)		(0x100 + (port) * 4)
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index 1f6237705b44..939a8a17595e 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -455,12 +455,12 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		*p++ = (reg >> 24) & 0xff;
 	}
 
-	len = skb_queue_len(&ptp->tx_queue);
+	len = skb_queue_len_lockless(&ptp->tx_queue);
 	if (len < 1)
 		return;
 
 	while (len--) {
-		skb = __skb_dequeue(&ptp->tx_queue);
+		skb = skb_dequeue(&ptp->tx_queue);
 		if (!skb)
 			return;
 
@@ -485,7 +485,7 @@ static void vsc85xx_dequeue_skb(struct vsc85xx_ptp *ptp)
 		 * packet in the FIFO right now, reschedule it for later
 		 * packets.
 		 */
-		__skb_queue_tail(&ptp->tx_queue, skb);
+		skb_queue_tail(&ptp->tx_queue, skb);
 	}
 }
 
@@ -1067,6 +1067,7 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 	case HWTSTAMP_TX_ON:
 		break;
 	case HWTSTAMP_TX_OFF:
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 		break;
 	default:
 		return -ERANGE;
@@ -1091,9 +1092,6 @@ static int vsc85xx_hwtstamp(struct mii_timestamper *mii_ts, struct ifreq *ifr)
 
 	mutex_lock(&vsc8531->ts_lock);
 
-	__skb_queue_purge(&vsc8531->ptp->tx_queue);
-	__skb_queue_head_init(&vsc8531->ptp->tx_queue);
-
 	/* Disable predictor while configuring the 1588 block */
 	val = vsc85xx_ts_read_csr(phydev, PROCESSOR,
 				  MSCC_PHY_PTP_INGR_PREDICTOR);
@@ -1179,9 +1177,7 @@ static void vsc85xx_txtstamp(struct mii_timestamper *mii_ts,
 
 	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
-	mutex_lock(&vsc8531->ts_lock);
-	__skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
-	mutex_unlock(&vsc8531->ts_lock);
+	skb_queue_tail(&vsc8531->ptp->tx_queue, skb);
 	return;
 
 out:
@@ -1547,6 +1543,7 @@ void vsc8584_ptp_deinit(struct phy_device *phydev)
 	if (vsc8531->ptp->ptp_clock) {
 		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
 		skb_queue_purge(&vsc8531->rx_skbs_list);
+		skb_queue_purge(&vsc8531->ptp->tx_queue);
 	}
 }
 
@@ -1570,7 +1567,7 @@ irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 	if (rc & VSC85XX_1588_INT_FIFO_ADD) {
 		vsc85xx_get_tx_ts(priv->ptp);
 	} else if (rc & VSC85XX_1588_INT_FIFO_OVERFLOW) {
-		__skb_queue_purge(&priv->ptp->tx_queue);
+		skb_queue_purge(&priv->ptp->tx_queue);
 		vsc85xx_ts_reset_fifo(phydev);
 	}
 
@@ -1590,6 +1587,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
 	skb_queue_head_init(&vsc8531->rx_skbs_list);
+	skb_queue_head_init(&vsc8531->ptp->tx_queue);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index cbf1c1f23281..f184368d5c5e 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1753,7 +1753,6 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		 */
 		if (net_ratelimit())
 			netdev_err(ppp->dev, "ppp: compressor dropped pkt\n");
-		kfree_skb(skb);
 		consume_skb(new_skb);
 		new_skb = NULL;
 	}
@@ -1855,9 +1854,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 					   "down - pkt dropped.\n");
 			goto drop;
 		}
-		skb = pad_compress_skb(ppp, skb);
-		if (!skb)
+		new_skb = pad_compress_skb(ppp, skb);
+		if (!new_skb)
 			goto drop;
+		skb = new_skb;
 	}
 
 	/*
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 9eb3c6b66a38..c3b1e9af922b 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -2042,6 +2042,13 @@ static const struct usb_device_id cdc_devs[] = {
 	  .driver_info = (unsigned long)&wwan_info,
 	},
 
+	/* Intel modem (label from OEM reads Fibocom L850-GL) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x8087, 0x095a,
+		USB_CLASS_COMM,
+		USB_CDC_SUBCLASS_NCM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&wwan_info,
+	},
+
 	/* DisplayLink docking stations */
 	{ .match_flags = USB_DEVICE_ID_MATCH_INT_INFO
 		| USB_DEVICE_ID_MATCH_VENDOR,
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 8714e4900484..86b913d5ac5b 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3315,8 +3315,6 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 	struct vmxnet3_adapter *adapter = netdev_priv(netdev);
 	int err = 0;
 
-	netdev->mtu = new_mtu;
-
 	/*
 	 * Reset_work may be in the middle of resetting the device, wait for its
 	 * completion.
@@ -3330,6 +3328,7 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 
 		/* we need to re-create the rx queue based on the new mtu */
 		vmxnet3_rq_destroy_all(adapter);
+		netdev->mtu = new_mtu;
 		vmxnet3_adjust_rx_ring_size(adapter);
 		err = vmxnet3_rq_create_all(adapter);
 		if (err) {
@@ -3346,6 +3345,8 @@ vmxnet3_change_mtu(struct net_device *netdev, int new_mtu)
 				   "Closing it\n", err);
 			goto out;
 		}
+	} else {
+		netdev->mtu = new_mtu;
 	}
 
 out:
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 3e065cbb0af9..5f0fef67fa84 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1101,10 +1101,13 @@ static int lbs_associate(struct lbs_private *priv,
 	/* add SSID TLV */
 	rcu_read_lock();
 	ssid_eid = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
-	if (ssid_eid)
-		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_eid[1]);
-	else
+	if (ssid_eid) {
+		u32 ssid_len = min(ssid_eid[1], IEEE80211_MAX_SSID_LEN);
+
+		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_len);
+	} else {
 		lbs_deb_assoc("no SSID\n");
+	}
 	rcu_read_unlock();
 
 	/* add DS param TLV */
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3cde6fc3bb81..5e25060647b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4316,8 +4316,9 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
 	 * additional active scan request for hidden SSIDs on passive channels.
 	 */
 	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
-	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
-						 adapter->num_in_chan_stats));
+	adapter->chan_stats = kcalloc(adapter->num_in_chan_stats,
+				      sizeof(*adapter->chan_stats),
+				      GFP_KERNEL);
 
 	if (!adapter->chan_stats)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 59225fcacd59..987bb87834ec 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -664,7 +664,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	goto done;
 
 err_add_intf:
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 err_init_chan_scan:
 	wiphy_unregister(adapter->wiphy);
 	wiphy_free(adapter->wiphy);
@@ -1486,7 +1486,7 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 	wiphy_free(adapter->wiphy);
 	adapter->wiphy = NULL;
 
-	vfree(adapter->chan_stats);
+	kfree(adapter->chan_stats);
 	mwifiex_free_cmd_buffers(adapter);
 }
 
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 8ef1d06b9bbd..121d810c8839 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1290,7 +1290,7 @@ static void cw1200_do_join(struct cw1200_common *priv)
 		rcu_read_lock();
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 		if (ssidie) {
-			join.ssid_len = ssidie[1];
+			join.ssid_len = min(ssidie[1], IEEE80211_MAX_SSID_LEN);
 			memcpy(join.ssid, &ssidie[2], join.ssid_len);
 		}
 		rcu_read_unlock();
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c5cc3e453fd0..7110aed956c7 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -534,6 +534,9 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
 
 		if (desc.pci.msi_attrib.can_mask) {
 			addr = pci_msix_desc_addr(&desc);
+			/* Workaround for SUN NIU insanity, which requires write before read */
+			if (dev->dev_flags & PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST)
+				writel(0, addr + PCI_MSIX_ENTRY_DATA);
 			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index d3f827d4224a..e22a752052f2 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -215,6 +215,8 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
 	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 8bda75990bce..0a4e439d4609 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
 
 	if (validate && !s->fake_cis) {
 		/* move it to the validated data set */
-		add_interval(&s_data->mem_db_valid, base, size);
+		ret = add_interval(&s_data->mem_db_valid, base, size);
+		if (ret)
+			return ret;
 		sub_interval(&s_data->mem_db, base, size);
 	}
 
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 1c64da3b2e9f..d4e74690ba9b 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1243,7 +1243,7 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_async_xchg_ctx *ctxp =
 		container_of(rsp, struct lpfc_async_xchg_ctx, hdlrctx.fcp_req);
-	struct rqb_dmabuf *nvmebuf = ctxp->rqb_buffer;
+	struct rqb_dmabuf *nvmebuf;
 	struct lpfc_hba *phba = ctxp->phba;
 	unsigned long iflag;
 
@@ -1251,13 +1251,18 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 	lpfc_nvmeio_data(phba, "NVMET DEFERRCV: xri x%x sz %d CPU %02x\n",
 			 ctxp->oxid, ctxp->size, raw_smp_processor_id());
 
+	spin_lock_irqsave(&ctxp->ctxlock, iflag);
+	nvmebuf = ctxp->rqb_buffer;
 	if (!nvmebuf) {
+		spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_IOERR,
 				"6425 Defer rcv: no buffer oxid x%x: "
 				"flg %x ste %x\n",
 				ctxp->oxid, ctxp->flag, ctxp->state);
 		return;
 	}
+	ctxp->rqb_buffer = NULL;
+	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 
 	tgtp = phba->targetport->private;
 	if (tgtp)
@@ -1265,9 +1270,6 @@ lpfc_nvmet_defer_rcv(struct nvmet_fc_target_port *tgtport,
 
 	/* Free the nvmebuf since a new buffer already replaced it */
 	nvmebuf->hrq->rqbp->rqb_free_buffer(phba, nvmebuf);
-	spin_lock_irqsave(&ctxp->ctxlock, iflag);
-	ctxp->rqb_buffer = NULL;
-	spin_unlock_irqrestore(&ctxp->ctxlock, iflag);
 }
 
 /**
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 246d13323882..c0e15d8a913d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,8 +3,9 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -71,7 +72,7 @@
 #define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
-#define CFGR1_PCSPOL	BIT(8)
+#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
 #define FSR_TXCOUNT	(0xFF)
@@ -395,7 +396,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
-		temp |= CFGR1_PCSPOL;
+		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
+				   BIT(fsl_lpspi->config.chip_select));
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
@@ -702,12 +705,10 @@ static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
 	ret = fsl_lpspi_wait_for_completion(controller);
-	if (ret)
-		return ret;
 
 	fsl_lpspi_reset(fsl_lpspi);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
@@ -755,7 +756,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d9be80e3e1bc..12085f4621a0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,27 +723,23 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	struct spi_delay *setup = &spi->cs_setup;
 	struct spi_delay *hold = &spi->cs_hold;
 	struct spi_delay *inactive = &spi->cs_inactive;
-	u8 setup_dly, hold_dly, inactive_dly;
+	u8 setup_dly, hold_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
-	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
-	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+	if ((setup->value && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->value && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->value && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
 		return -EINVAL;
 	}
 
-	setup_dly = setup ? setup->value : 0;
-	hold_dly = hold ? hold->value : 0;
-	inactive_dly = inactive ? inactive->value : 0;
-
-	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
-	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
+	setup_dly = min_t(u8, setup->value, MAX_SETUP_HOLD_CYCLES);
+	hold_dly = min_t(u8, hold->value, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
 		setup_hold = SPI_SETUP_HOLD(setup_dly - 1, hold_dly - 1);
 		spi_cs_timing = SPI_CS_SETUP_HOLD(tspi->spi_cs_timing1,
@@ -755,7 +751,7 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 		}
 	}
 
-	inactive_cycles = min_t(u8, inactive_dly, MAX_INACTIVE_CYCLES);
+	inactive_cycles = min_t(u8, inactive->value, MAX_INACTIVE_CYCLES);
 	if (inactive_cycles)
 		inactive_cycles--;
 	cs_state = inactive_cycles ? 0 : 1;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index b8ba360e863e..927c3d7947f9 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -653,7 +653,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
  * with a matching configuration.
  */
 
-static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
+static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
@@ -804,7 +804,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	ffa_ops = ffa_dev->ops;
 
-	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 27295bda3e0b..15299334cf57 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -506,9 +506,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
  */
 void tee_shm_put(struct tee_shm *shm)
 {
-	struct tee_device *teedev = shm->ctx->teedev;
+	struct tee_device *teedev;
 	bool do_release = false;
 
+	if (!shm || !shm->ctx || !shm->ctx->teedev)
+		return;
+
+	teedev = shm->ctx->teedev;
 	mutex_lock(&teedev->mutex);
 	if (refcount_dec_and_test(&shm->refcount)) {
 		/*
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 54c2ccb36b61..f3a3a31477a5 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -164,7 +164,7 @@ struct btrfs_inode {
 		u64 new_delalloc_bytes;
 		/*
 		 * The offset of the last dir index key that was logged.
-		 * This is used only for directories.
+		 * This is used only for directories. Protected by 'log_mutex'.
 		 */
 		u64 last_dir_index_offset;
 	};
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5552875f872..516d40f707a6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2807,7 +2807,7 @@ static int submit_eb_subpage(struct page *page,
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&page->mapping->private_lock);
-			bit_start++;
+			bit_start += sectors_per_node;
 			continue;
 		}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 469a622b440b..78cd7b8ccfc8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8926,6 +8926,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_sub_trans = 0;
 	ei->logged_trans = 0;
 	ei->delalloc_bytes = 0;
+	/* new_delalloc_bytes and last_dir_index_offset are in a union. */
 	ei->new_delalloc_bytes = 0;
 	ei->defrag_bytes = 0;
 	ei->disk_i_size = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de2b22a56c06..6e8e90bce046 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3302,6 +3302,31 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static bool mark_inode_as_not_logged(const struct btrfs_trans_handle *trans,
+				     struct btrfs_inode *inode)
+{
+	bool ret = false;
+
+	/*
+	 * Do this only if ->logged_trans is still 0 to prevent races with
+	 * concurrent logging as we may see the inode not logged when
+	 * inode_logged() is called but it gets logged after inode_logged() did
+	 * not find it in the log tree and we end up setting ->logged_trans to a
+	 * value less than trans->transid after the concurrent logging task has
+	 * set it to trans->transid. As a consequence, subsequent rename, unlink
+	 * and link operations may end up not logging new names and removing old
+	 * names from the log.
+	 */
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == 0)
+		inode->logged_trans = trans->transid - 1;
+	else if (inode->logged_trans == trans->transid)
+		ret = true;
+	spin_unlock(&inode->lock);
+
+	return ret;
+}
+
 /*
  * Check if an inode was logged in the current transaction. This correctly deals
  * with the case where the inode was logged but has a logged_trans of 0, which
@@ -3319,15 +3344,32 @@ static int inode_logged(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	int ret;
 
-	if (inode->logged_trans == trans->transid)
+	/*
+	 * Quick lockless call, since once ->logged_trans is set to the current
+	 * transaction, we never set it to a lower value anywhere else.
+	 */
+	if (data_race(inode->logged_trans) == trans->transid)
 		return 1;
 
 	/*
-	 * If logged_trans is not 0, then we know the inode logged was not logged
-	 * in this transaction, so we can return false right away.
+	 * If logged_trans is not 0 and not trans->transid, then we know the
+	 * inode was not logged in this transaction, so we can return false
+	 * right away. We take the lock to avoid a race caused by load/store
+	 * tearing with a concurrent btrfs_log_inode() call or a concurrent task
+	 * in this function further below - an update to trans->transid can be
+	 * teared into two 32 bits updates for example, in which case we could
+	 * see a positive value that is not trans->transid and assume the inode
+	 * was not logged when it was.
 	 */
-	if (inode->logged_trans > 0)
+	spin_lock(&inode->lock);
+	if (inode->logged_trans == trans->transid) {
+		spin_unlock(&inode->lock);
+		return 1;
+	} else if (inode->logged_trans > 0) {
+		spin_unlock(&inode->lock);
 		return 0;
+	}
+	spin_unlock(&inode->lock);
 
 	/*
 	 * If no log tree was created for this root in this transaction, then
@@ -3336,10 +3378,8 @@ static int inode_logged(struct btrfs_trans_handle *trans,
 	 * transaction's ID, to avoid the search below in a future call in case
 	 * a log tree gets created after this.
 	 */
-	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state)) {
-		inode->logged_trans = trans->transid - 1;
-		return 0;
-	}
+	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &inode->root->state))
+		return mark_inode_as_not_logged(trans, inode);
 
 	/*
 	 * We have a log tree and the inode's logged_trans is 0. We can't tell
@@ -3393,8 +3433,7 @@ static int inode_logged(struct btrfs_trans_handle *trans,
 		 * Set logged_trans to a value greater than 0 and less then the
 		 * current transaction to avoid doing the search in future calls.
 		 */
-		inode->logged_trans = trans->transid - 1;
-		return 0;
+		return mark_inode_as_not_logged(trans, inode);
 	}
 
 	/*
@@ -3402,20 +3441,9 @@ static int inode_logged(struct btrfs_trans_handle *trans,
 	 * the current transacion's ID, to avoid future tree searches as long as
 	 * the inode is not evicted again.
 	 */
+	spin_lock(&inode->lock);
 	inode->logged_trans = trans->transid;
-
-	/*
-	 * If it's a directory, then we must set last_dir_index_offset to the
-	 * maximum possible value, so that the next attempt to log the inode does
-	 * not skip checking if dir index keys found in modified subvolume tree
-	 * leaves have been logged before, otherwise it would result in attempts
-	 * to insert duplicate dir index keys in the log tree. This must be done
-	 * because last_dir_index_offset is an in-memory only field, not persisted
-	 * in the inode item or any other on-disk structure, so its value is lost
-	 * once the inode is evicted.
-	 */
-	if (S_ISDIR(inode->vfs_inode.i_mode))
-		inode->last_dir_index_offset = (u64)-1;
+	spin_unlock(&inode->lock);
 
 	return 1;
 }
@@ -3986,7 +4014,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 
 /*
  * If the inode was logged before and it was evicted, then its
- * last_dir_index_offset is (u64)-1, so we don't the value of the last index
+ * last_dir_index_offset is 0, so we don't know the value of the last index
  * key offset. If that's the case, search for it and update the inode. This
  * is to avoid lookups in the log tree every time we try to insert a dir index
  * key from a leaf changed in the current transaction, and to allow us to always
@@ -4002,7 +4030,7 @@ static int update_last_dir_index_offset(struct btrfs_inode *inode,
 
 	lockdep_assert_held(&inode->log_mutex);
 
-	if (inode->last_dir_index_offset != (u64)-1)
+	if (inode->last_dir_index_offset != 0)
 		return 0;
 
 	if (!ctx->logged_before) {
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index be2d329843d4..41f8ae8a416f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2514,10 +2514,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			wakeup_bdi = inode_io_list_move_locked(inode, wb,
 							       dirty_list);
 
-			spin_unlock(&wb->list_lock);
-			spin_unlock(&inode->i_lock);
-			trace_writeback_dirty_inode_enqueue(inode);
-
 			/*
 			 * If this is the first dirty inode for this bdi,
 			 * we have to wake-up the corresponding bdi thread
@@ -2527,6 +2523,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (wakeup_bdi &&
 			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
 				wb_wakeup_delayed(wb);
+
+			spin_unlock(&wb->list_lock);
+			spin_unlock(&inode->i_lock);
+			trace_writeback_dirty_inode_enqueue(inode);
+
 			return;
 		}
 	}
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec..dd5bc6ffae85 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -51,10 +51,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f.handle.handle_bytes >> 2;
 
 	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f.handle.handle_type = ret;
 	f.handle.handle_bytes = size * sizeof(u32);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index bb116c39b581..a1f3b25ce612 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1205,6 +1205,9 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
+	if (!osb->journal)
+		return;
+
 	jbd2_journal_release_jbd_inode(osb->journal->j_journal,
 				       &oi->ip_jinode);
 }
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 203b88293f6b..ced56696beeb 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -361,9 +361,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index c3a809e1d719..c96c884208a9 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -363,6 +363,25 @@ static const struct inode_operations proc_dir_inode_operations = {
 	.setattr	= proc_notify_change,
 };
 
+static void pde_set_flags(struct proc_dir_entry *pde)
+{
+	const struct proc_ops *proc_ops = pde->proc_ops;
+
+	if (!proc_ops)
+		return;
+
+	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
+		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
+	if (proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp)
@@ -370,6 +389,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
+	pde_set_flags(dp);
+
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
@@ -558,20 +579,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
-{
-	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
-		pde->flags |= PROC_ENTRY_PERMANENT;
-	if (pde->proc_ops->proc_read_iter)
-		pde->flags |= PROC_ENTRY_proc_read_iter;
-#ifdef CONFIG_COMPAT
-	if (pde->proc_ops->proc_compat_ioctl)
-		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
-#endif
-	if (pde->proc_ops->proc_lseek)
-		pde->flags |= PROC_ENTRY_proc_lseek;
-}
-
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		const struct proc_ops *proc_ops, void *data)
@@ -582,7 +589,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -633,7 +639,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -664,7 +669,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index e7582dd79179..f0c4d630b6d1 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -619,6 +619,9 @@ cifs_strndup_to_utf16(const char *src, const int maxlen, int *utf16_len,
 	int len;
 	__le16 *dst;
 
+	if (!src)
+		return NULL;
+
 	len = cifs_local_to_utf16_bytes(src, maxlen, cp);
 	len += 2; /* NULL */
 	dst = kmalloc(len, GFP_KERNEL);
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..429c766310c0 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -72,9 +72,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_enabled_key[atype])
 
-#define for_each_cgroup_storage_type(stype) \
-	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
-
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -506,8 +503,6 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
 
-#define for_each_cgroup_storage_type(stype) for (; false; )
-
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e9c1338851e3..5f01845627d4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -181,6 +181,20 @@ enum bpf_kptr_type {
 	BPF_KPTR_REF,
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+};
+
+#ifdef CONFIG_CGROUP_BPF
+# define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+#else
+# define for_each_cgroup_storage_type(stype) for (; false; )
+#endif /* CONFIG_CGROUP_BPF */
+
 struct bpf_map_value_off_desc {
 	u32 offset;
 	enum bpf_kptr_type type;
@@ -203,6 +217,19 @@ struct bpf_map_off_arr {
 	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
 };
 
+/* 'Ownership' of program-containing map is claimed by the first program
+ * that is going to use this map or by the first program which FD is
+ * stored in the map to make sure that all callers and callees have the
+ * same prog type, JITed flag and xdp_has_frags flag.
+ */
+struct bpf_map_owner {
+	enum bpf_prog_type type;
+	bool jited;
+	bool xdp_has_frags;
+	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
+	const struct btf_type *attach_func_proto;
+};
+
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -244,22 +271,13 @@ struct bpf_map {
 	};
 	struct mutex freeze_mutex;
 	atomic64_t writecnt;
-	/* 'Ownership' of program-containing map is claimed by the first program
-	 * that is going to use this map or by the first program which FD is
-	 * stored in the map to make sure that all callers and callees have the
-	 * same prog type, JITed flag and xdp_has_frags flag.
-	 */
-	struct {
-		const struct btf_type *attach_func_proto;
-		spinlock_t lock;
-		enum bpf_prog_type type;
-		bool jited;
-		bool xdp_has_frags;
-	} owner;
+	spinlock_t owner_lock;
+	struct bpf_map_owner *owner;
 	bool bypass_spec_v1;
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
 	s64 __percpu *elem_count;
+	u64 cookie; /* write-once */
 };
 
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
@@ -793,14 +811,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
@@ -1488,6 +1498,16 @@ static inline bool bpf_map_flags_access_ok(u32 access_flags)
 	       (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
 }
 
+static inline struct bpf_map_owner *bpf_map_owner_alloc(struct bpf_map *map)
+{
+	return kzalloc(sizeof(*map->owner), GFP_ATOMIC);
+}
+
+static inline void bpf_map_owner_free(struct bpf_map *map)
+{
+	kfree(map->owner);
+}
+
 struct bpf_event_entry {
 	struct perf_event *event;
 	struct file *perf_file;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index df36df4695ed..59dfa59d6d59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -244,6 +244,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
+	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5f0d7d0b9471..b8dd98edca99 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1472,6 +1472,22 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..07843967bc52 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -175,22 +175,6 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
 
-/*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2ed1d00bede0..3136af6559a8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2120,28 +2120,44 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
-	bool ret;
 	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
+	bool ret = false;
+	u64 cookie;
 
 	if (fp->kprobe_override)
-		return false;
+		return ret;
 
-	spin_lock(&map->owner.lock);
-	if (!map->owner.type) {
-		/* There's no owner yet where we could check for
-		 * compatibility.
-		 */
-		map->owner.type  = prog_type;
-		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = aux->xdp_has_frags;
-		map->owner.attach_func_proto = aux->attach_func_proto;
+	spin_lock(&map->owner_lock);
+	/* There's no owner yet where we could check for compatibility. */
+	if (!map->owner) {
+		map->owner = bpf_map_owner_alloc(map);
+		if (!map->owner)
+			goto err;
+		map->owner->type  = prog_type;
+		map->owner->jited = fp->jited;
+		map->owner->xdp_has_frags = aux->xdp_has_frags;
+		map->owner->attach_func_proto = aux->attach_func_proto;
+		for_each_cgroup_storage_type(i) {
+			map->owner->storage_cookie[i] =
+				aux->cgroup_storage[i] ?
+				aux->cgroup_storage[i]->cookie : 0;
+		}
 		ret = true;
 	} else {
-		ret = map->owner.type  == prog_type &&
-		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		ret = map->owner->type  == prog_type &&
+		      map->owner->jited == fp->jited &&
+		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		for_each_cgroup_storage_type(i) {
+			if (!ret)
+				break;
+			cookie = aux->cgroup_storage[i] ?
+				 aux->cgroup_storage[i]->cookie : 0;
+			ret = map->owner->storage_cookie[i] == cookie ||
+			      !cookie;
+		}
 		if (ret &&
-		    map->owner.attach_func_proto != aux->attach_func_proto) {
+		    map->owner->attach_func_proto != aux->attach_func_proto) {
 			switch (prog_type) {
 			case BPF_PROG_TYPE_TRACING:
 			case BPF_PROG_TYPE_LSM:
@@ -2154,8 +2170,8 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 			}
 		}
 	}
-	spin_unlock(&map->owner.lock);
-
+err:
+	spin_unlock(&map->owner_lock);
 	return ret;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b145f3ef3695..c15d243bfe38 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/cookie.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -47,6 +48,7 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
+DEFINE_COOKIE(bpf_map_cookie);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
@@ -629,6 +631,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	security_bpf_map_free(map);
 	kfree(map->off_arr);
 	bpf_map_release_memcg(map);
+	bpf_map_owner_free(map);
 	/* implementation dependent freeing, map_free callback also does
 	 * bpf_map_free_kptr_off_tab, if needed.
 	 */
@@ -736,12 +739,12 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 	struct bpf_map *map = filp->private_data;
 	u32 type = 0, jited = 0;
 
-	if (map_type_contains_progs(map)) {
-		spin_lock(&map->owner.lock);
-		type  = map->owner.type;
-		jited = map->owner.jited;
-		spin_unlock(&map->owner.lock);
+	spin_lock(&map->owner_lock);
+	if (map->owner) {
+		type  = map->owner->type;
+		jited = map->owner->jited;
 	}
+	spin_unlock(&map->owner_lock);
 
 	seq_printf(m,
 		   "map_type:\t%u\n"
@@ -1152,10 +1155,14 @@ static int map_create(union bpf_attr *attr)
 	if (err < 0)
 		goto free_map;
 
+	preempt_disable();
+	map->cookie = gen_cookie_next(&bpf_map_cookie);
+	preempt_enable();
+
 	atomic64_set(&map->refcnt, 1);
 	atomic64_set(&map->usercnt, 1);
 	mutex_init(&map->freeze_mutex);
-	spin_lock_init(&map->owner.lock);
+	spin_lock_init(&map->owner_lock);
 
 	map->spin_lock_off = -EINVAL;
 	map->timer_off = -EINVAL;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4dcb48973318..3221bafb799d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -82,9 +82,20 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
+	if (unlikely(READ_ONCE(sg_policy->limits_changed))) {
+		WRITE_ONCE(sg_policy->limits_changed, false);
 		sg_policy->need_freq_update = true;
+
+		/*
+		 * The above limits_changed update must occur before the reads
+		 * of policy limits in cpufreq_driver_resolve_freq() or a policy
+		 * limits update might be missed, so use a memory barrier to
+		 * ensure it.
+		 *
+		 * This pairs with the write memory barrier in sugov_limits().
+		 */
+		smp_mb();
+
 		return true;
 	}
 
@@ -318,7 +329,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_cpu->sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
@@ -825,7 +836,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->limits_changed = true;
+	/*
+	 * The limits_changed update below must take place before the updates
+	 * of policy limits in cpufreq_set_policy() or a policy limits update
+	 * might be missed, so use a memory barrier to ensure it.
+	 *
+	 * This pairs with the memory barrier in sugov_should_update_freq().
+	 */
+	smp_wmb();
+
+	WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 struct cpufreq_governor schedutil_gov = {
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..5428a41d70eb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -726,19 +726,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
 }
 
 #ifdef CONFIG_STACKDEPOT
-static noinline depot_stack_handle_t set_track_prepare(void)
+static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	depot_stack_handle_t handle;
 	unsigned long entries[TRACK_ADDRS_COUNT];
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
-	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+	handle = stack_depot_save(entries, nr_entries, gfp_flags);
 
 	return handle;
 }
 #else
-static inline depot_stack_handle_t set_track_prepare(void)
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
 {
 	return 0;
 }
@@ -760,9 +760,9 @@ static void set_track_update(struct kmem_cache *s, void *object,
 }
 
 static __always_inline void set_track(struct kmem_cache *s, void *object,
-				      enum track_item alloc, unsigned long addr)
+				      enum track_item alloc, unsigned long addr, gfp_t gfp_flags)
 {
-	depot_stack_handle_t handle = set_track_prepare();
+	depot_stack_handle_t handle = set_track_prepare(gfp_flags);
 
 	set_track_update(s, object, alloc, addr, handle);
 }
@@ -927,7 +927,12 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	slab_bug(s, "%s", reason);
-	print_trailer(s, slab, object);
+	if (!object || !check_valid_pointer(s, slab, object)) {
+		print_slab_info(slab);
+		pr_err("Invalid pointer 0x%p\n", object);
+	} else {
+		print_trailer(s, slab, object);
+	}
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
@@ -1363,7 +1368,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
 	return 1;
 }
 
-static noinline int alloc_debug_processing(struct kmem_cache *s,
+static noinline bool alloc_debug_processing(struct kmem_cache *s,
 			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -1375,7 +1380,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 	trace(s, slab, object, 1);
 	set_orig_size(s, object, orig_size);
 	init_object(s, object, SLUB_RED_ACTIVE);
-	return 1;
+	return true;
 
 bad:
 	if (folio_test_slab(slab_folio(slab))) {
@@ -1388,7 +1393,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 		slab->inuse = slab->objects;
 		slab->freelist = NULL;
 	}
-	return 0;
+	return false;
 }
 
 static inline int free_consistency_checks(struct kmem_cache *s,
@@ -1641,19 +1646,19 @@ static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
 static inline
 void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
 
-static inline int alloc_debug_processing(struct kmem_cache *s,
-	struct slab *slab, void *object, int orig_size) { return 0; }
+static inline bool alloc_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *object, int orig_size) { return true; }
 
-static inline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr) {}
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle) { return true; }
 
 static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
 static inline int check_object(struct kmem_cache *s, struct slab *slab,
 			void *object, u8 val) { return 1; }
+static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags) { return 0; }
 static inline void set_track(struct kmem_cache *s, void *object,
-			     enum track_item alloc, unsigned long addr) {}
+			     enum track_item alloc, unsigned long addr, gfp_t gfp_flags) {}
 static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
@@ -2828,38 +2833,28 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 }
 
 /* Supports checking bulk free of a constructed freelist */
-static noinline void free_debug_processing(
-	struct kmem_cache *s, struct slab *slab,
-	void *head, void *tail, int bulk_cnt,
-	unsigned long addr)
+static inline bool free_debug_processing(struct kmem_cache *s,
+	struct slab *slab, void *head, void *tail, int *bulk_cnt,
+	unsigned long addr, depot_stack_handle_t handle)
 {
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	struct slab *slab_free = NULL;
+	bool checks_ok = false;
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags;
-	bool checks_ok = false;
-	depot_stack_handle_t handle = 0;
-
-	if (s->flags & SLAB_STORE_USER)
-		handle = set_track_prepare();
-
-	spin_lock_irqsave(&n->list_lock, flags);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, slab))
 			goto out;
 	}
 
-	if (slab->inuse < bulk_cnt) {
+	if (slab->inuse < *bulk_cnt) {
 		slab_err(s, slab, "Slab has %d allocated objects but %d are to be freed\n",
-			 slab->inuse, bulk_cnt);
+			 slab->inuse, *bulk_cnt);
 		goto out;
 	}
 
 next_object:
 
-	if (++cnt > bulk_cnt)
+	if (++cnt > *bulk_cnt)
 		goto out_cnt;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
@@ -2881,57 +2876,18 @@ static noinline void free_debug_processing(
 	checks_ok = true;
 
 out_cnt:
-	if (cnt != bulk_cnt)
+	if (cnt != *bulk_cnt) {
 		slab_err(s, slab, "Bulk free expected %d objects but found %d\n",
-			 bulk_cnt, cnt);
-
-out:
-	if (checks_ok) {
-		void *prior = slab->freelist;
-
-		/* Perform the actual freeing while we still hold the locks */
-		slab->inuse -= cnt;
-		set_freepointer(s, tail, prior);
-		slab->freelist = head;
-
-		/*
-		 * If the slab is empty, and node's partial list is full,
-		 * it should be discarded anyway no matter it's on full or
-		 * partial list.
-		 */
-		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
-			slab_free = slab;
-
-		if (!prior) {
-			/* was on full list */
-			remove_full(s, n, slab);
-			if (!slab_free) {
-				add_partial(n, slab, DEACTIVATE_TO_TAIL);
-				stat(s, FREE_ADD_PARTIAL);
-			}
-		} else if (slab_free) {
-			remove_partial(n, slab);
-			stat(s, FREE_REMOVE_PARTIAL);
-		}
+			 *bulk_cnt, cnt);
+		*bulk_cnt = cnt;
 	}
 
-	if (slab_free) {
-		/*
-		 * Update the counters while still holding n->list_lock to
-		 * prevent spurious validation warnings
-		 */
-		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
-	}
-
-	spin_unlock_irqrestore(&n->list_lock, flags);
+out:
 
 	if (!checks_ok)
 		slab_fix(s, "Object at 0x%p not freed", object);
 
-	if (slab_free) {
-		stat(s, FREE_SLAB);
-		free_slab(s, slab_free);
-	}
+	return checks_ok;
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
@@ -3173,8 +3129,26 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
-	if (freelist)
-		goto check_new_slab;
+	if (freelist) {
+		if (kmem_cache_debug(s)) {
+			/*
+			 * For debug caches here we had to go through
+			 * alloc_single_from_partial() so just store the
+			 * tracking info and return the object.
+			 *
+			 * Due to disabled preemption we need to disallow
+			 * blocking. The flags are further adjusted by
+			 * gfp_nested_mask() in stack_depot itself.
+			 */
+			if (s->flags & SLAB_STORE_USER)
+				set_track(s, freelist, TRACK_ALLOC, addr,
+					  gfpflags & ~(__GFP_DIRECT_RECLAIM));
+
+			return freelist;
+		}
+
+		goto retry_load_slab;
+	}
 
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, gfpflags, node);
@@ -3194,7 +3168,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 
 		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
+			set_track(s, freelist, TRACK_ALLOC, addr,
+				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
 
 		return freelist;
 	}
@@ -3210,20 +3185,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-check_new_slab:
-
-	if (kmem_cache_debug(s)) {
-		/*
-		 * For debug caches here we had to go through
-		 * alloc_single_from_partial() so just store the tracking info
-		 * and return the object
-		 */
-		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
-
-		return freelist;
-	}
-
 	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
@@ -3448,6 +3409,71 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
+static noinline void free_to_partial_list(
+	struct kmem_cache *s, struct slab *slab,
+	void *head, void *tail, int bulk_cnt,
+	unsigned long addr)
+{
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
+	struct slab *slab_free = NULL;
+	int cnt = bulk_cnt;
+	unsigned long flags;
+	depot_stack_handle_t handle = 0;
+
+	/*
+	 * We cannot use GFP_NOWAIT as there are callsites where waking up
+	 * kswapd could deadlock
+	 */
+	if (s->flags & SLAB_STORE_USER)
+		handle = set_track_prepare(__GFP_NOWARN);
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	if (free_debug_processing(s, slab, head, tail, &cnt, addr, handle)) {
+		void *prior = slab->freelist;
+
+		/* Perform the actual freeing while we still hold the locks */
+		slab->inuse -= cnt;
+		set_freepointer(s, tail, prior);
+		slab->freelist = head;
+
+		/*
+		 * If the slab is empty, and node's partial list is full,
+		 * it should be discarded anyway no matter it's on full or
+		 * partial list.
+		 */
+		if (slab->inuse == 0 && n->nr_partial >= s->min_partial)
+			slab_free = slab;
+
+		if (!prior) {
+			/* was on full list */
+			remove_full(s, n, slab);
+			if (!slab_free) {
+				add_partial(n, slab, DEACTIVATE_TO_TAIL);
+				stat(s, FREE_ADD_PARTIAL);
+			}
+		} else if (slab_free) {
+			remove_partial(n, slab);
+			stat(s, FREE_REMOVE_PARTIAL);
+		}
+	}
+
+	if (slab_free) {
+		/*
+		 * Update the counters while still holding n->list_lock to
+		 * prevent spurious validation warnings
+		 */
+		dec_slabs_node(s, slab_nid(slab_free), slab_free->objects);
+	}
+
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	if (slab_free) {
+		stat(s, FREE_SLAB);
+		free_slab(s, slab_free);
+	}
+}
+
 /*
  * Slow path handling. This may still be called frequently since objects
  * have a longer lifetime than the cpu slabs in most processing loads.
@@ -3474,7 +3500,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 
 	if (kmem_cache_debug(s)) {
-		free_debug_processing(s, slab, head, tail, cnt, addr);
+		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
 	}
 
diff --git a/net/atm/resources.c b/net/atm/resources.c
index b19d851e1f44..7c6fdedbcf4e 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -112,7 +112,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 
 	if (atm_proc_dev_register(dev) < 0) {
 		pr_err("atm_proc_dev_register failed for dev %s\n", type);
-		goto out_fail;
+		mutex_unlock(&atm_dev_mutex);
+		kfree(dev);
+		return NULL;
 	}
 
 	if (atm_register_sysfs(dev, parent) < 0) {
@@ -128,7 +130,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 	return dev;
 
 out_fail:
-	kfree(dev);
+	put_device(&dev->class_dev);
 	dev = NULL;
 	goto out;
 }
diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index 1cac25aca637..f2d66af86359 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -433,6 +433,10 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 int ax25_kiss_rcv(struct sk_buff *skb, struct net_device *dev,
 		  struct packet_type *ptype, struct net_device *orig_dev)
 {
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb)
+		return NET_RX_DROP;
+
 	skb_orphan(skb);
 
 	if (!net_eq(dev_net(dev), &init_net)) {
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 5f4aeeb60dc4..b8380a28b341 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1687,7 +1687,12 @@ batadv_nc_skb_decode_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	coding_len = ntohs(coded_packet_tmp.coded_len);
 
-	if (coding_len > skb->len)
+	/* ensure dst buffer is large enough (payload only) */
+	if (coding_len + h_size > skb->len)
+		return NULL;
+
+	/* ensure src buffer is large enough (payload only) */
+	if (coding_len + h_size > nc_packet->skb->len)
 		return NULL;
 
 	/* Here the magic is reversed:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 965b0f2b43a7..a2c3b58db54c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3287,7 +3287,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 * advertising data. This also applies to the case
 	 * where BR/EDR was toggled during the AUTO_OFF phase.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	    list_empty(&hdev->adv_instances)) {
 		if (ext_adv_capable(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c89277848ca8..7b822445f8ce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1442,7 +1442,10 @@ static int l2cap_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	lock_sock_nested(sk, L2CAP_NESTING_PARENT);
 	l2cap_sock_cleanup_listen(sk);
+	release_sock(sk);
+
 	bt_sock_unlink(&l2cap_sk_list, sk);
 
 	err = l2cap_sock_shutdown(sock, SHUT_RDWR);
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index b4d661fe7886..c4765691e781 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -648,9 +648,6 @@ static unsigned int br_nf_local_in(void *priv,
 		break;
 	}
 
-	ct = container_of(nfct, struct nf_conn, ct_general);
-	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
-
 	return ret;
 }
 #endif
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 429250298ac4..d58bcd16d597 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -69,7 +69,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
 }
@@ -103,8 +108,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
 
@@ -135,10 +141,16 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	unsigned int port;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 
 	/* Extra 4-bytes PTP timestamp */
 	if (tag[0] & KSZ9477_PTP_TAG_INDICATION)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1738cc2bfc7f..fee0a0b83d27 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -335,14 +335,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 static int __init inet_blackhole_dev_init(void)
 {
-	int err = 0;
+	struct in_device *in_dev;
 
 	rtnl_lock();
-	if (!inetdev_init(blackhole_netdev))
-		err = -ENOMEM;
+	in_dev = inetdev_init(blackhole_netdev);
 	rtnl_unlock();
 
-	return err;
+	return PTR_ERR_OR_ZERO(in_dev);
 }
 late_initcall(inet_blackhole_dev_init);
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 94501bb30c43..b17549c4e5de 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -801,11 +801,12 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	struct sk_buff *cloned_skb = NULL;
 	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmp_send(skb_in, type, code, info, &opts);
 		return;
 	}
@@ -820,7 +821,8 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 		goto out;
 
 	orig_ip = ip_hdr(skb_in)->saddr;
-	ip_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.ip;
+	dir = CTINFO2DIR(ctinfo);
+	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
 	__icmp_send(skb_in, type, code, info, &opts);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 9e3574880cb0..233914b63bdb 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -54,11 +54,12 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 	struct inet6_skb_parm parm = { 0 };
 	struct sk_buff *cloned_skb = NULL;
 	enum ip_conntrack_info ctinfo;
+	enum ip_conntrack_dir dir;
 	struct in6_addr orig_ip;
 	struct nf_conn *ct;
 
 	ct = nf_ct_get(skb_in, &ctinfo);
-	if (!ct || !(ct->status & IPS_SRC_NAT)) {
+	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
 		__icmpv6_send(skb_in, type, code, info, &parm);
 		return;
 	}
@@ -73,7 +74,8 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 		goto out;
 
 	orig_ip = ipv6_hdr(skb_in)->saddr;
-	ipv6_hdr(skb_in)->saddr = ct->tuplehash[0].tuple.src.u3.in6;
+	dir = CTINFO2DIR(ctinfo);
+	ipv6_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.in6;
 	__icmpv6_send(skb_in, type, code, info, &parm);
 	ipv6_hdr(skb_in)->saddr = orig_ip;
 out:
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 0f49b41570f5..8f241c92e03d 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -346,7 +346,7 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 		return 0;
 	}
 
-	return -EINVAL;
+	return -ENOPROTOOPT;
 }
 
 static int mctp_ioctl_alloctag(struct mctp_sock *msk, unsigned long arg)
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index bf09a1e06248..5545016c107d 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -371,7 +371,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 			    (cur->tuple.src.l3num == NFPROTO_UNSPEC ||
 			     cur->tuple.src.l3num == me->tuple.src.l3num) &&
 			    cur->tuple.dst.protonum == me->tuple.dst.protonum) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
@@ -382,7 +382,7 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 		hlist_for_each_entry(cur, &nf_ct_helper_hash[h], hnode) {
 			if (nf_ct_tuple_src_mask_cmp(&cur->tuple, &me->tuple,
 						     &mask)) {
-				ret = -EEXIST;
+				ret = -EBUSY;
 				goto out;
 			}
 		}
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index a48fdc83fe6b..6ed77f02ceac 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -422,8 +422,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 {
 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
 
-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
-		return false;
 	if (hdr->version == SMC_V1) {
 		if (ntohs(hdr->length) != sizeof(struct smc_clc_msg_decline))
 			return false;
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 6de53431629c..8e41034d8d96 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -743,6 +743,9 @@ bool smc_ib_is_sg_need_sync(struct smc_link *lnk,
 	unsigned int i;
 	bool ret = false;
 
+	if (!lnk->smcibdev->ibdev->dma_device)
+		return ret;
+
 	/* for now there is just one DMA address */
 	for_each_sg(buf_slot->sgt[lnk->link_idx].sgl, sg,
 		    buf_slot->sgt[lnk->link_idx].nents, i) {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 810293f160a8..7369172819fd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1785,7 +1785,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			 */
 
 			f = rcu_access_pointer(new->pub.beacon_ies);
-			kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
+			if (!new->pub.hidden_beacon_bss)
+				kfree_rcu((struct cfg80211_bss_ies *)f, rcu_head);
 			return false;
 		}
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index e35c3c29cec7..ed16e852133e 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -886,13 +886,16 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!wdev->u.client.ssid_len) {
 		rcu_read_lock();
 		for_each_valid_link(cr, link) {
+			u32 ssid_len;
+
 			ssid = ieee80211_bss_get_elem(cr->links[link].bss,
 						      WLAN_EID_SSID);
 
 			if (!ssid || !ssid->datalen)
 				continue;
 
-			memcpy(wdev->u.client.ssid, ssid->data, ssid->datalen);
+			ssid_len = min(ssid->datalen, IEEE80211_MAX_SSID_LEN);
+			memcpy(wdev->u.client.ssid, ssid->data, ssid_len);
 			wdev->u.client.ssid_len = ssid->datalen;
 			break;
 		}
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3388e407e44e..57055c600d16 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1991,6 +1991,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 static const struct snd_pci_quirk force_connect_list[] = {
 	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
 	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
+	SND_PCI_QUIRK(0x103c, 0x845a, "HP EliteDesk 800 G4 DM 65W", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa1519254c3d..503e7376558a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10093,6 +10093,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e1d, "HP ZBook X Gli 16 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10436,6 +10439,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x300f, "TongFang X6AR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x3019, "TongFang X6FR5xxY", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f2cce15be4e2..68c82e344d3b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3631,9 +3631,11 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
 	/* lowest playback value is muted on some devices */
+	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
 	case USB_ID(0x0d8c, 0x000c): /* C-Media */
 	case USB_ID(0x0d8c, 0x0014): /* C-Media */
 	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
+	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
 		break;
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index d29c9c49e251..342e056c8c66 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -77,8 +77,8 @@ $(OUTPUT)gpio-watch: $(GPIO_WATCH_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -f $(OUTPUT)include/linux/gpio.h
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	rm -rf $(OUTPUT)include
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(bindir);		\
diff --git a/tools/testing/selftests/net/bind_bhash.c b/tools/testing/selftests/net/bind_bhash.c
index 57ff67a3751e..da04b0b19b73 100644
--- a/tools/testing/selftests/net/bind_bhash.c
+++ b/tools/testing/selftests/net/bind_bhash.c
@@ -75,7 +75,7 @@ static void *setup(void *arg)
 	int *array = (int *)arg;
 
 	for (i = 0; i < MAX_CONNECTIONS; i++) {
-		sock_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+		sock_fd = bind_socket(SO_REUSEPORT, setup_addr);
 		if (sock_fd < 0) {
 			ret = sock_fd;
 			pthread_exit(&ret);
@@ -103,7 +103,7 @@ int main(int argc, const char *argv[])
 
 	setup_addr = use_v6 ? setup_addr_v6 : setup_addr_v4;
 
-	listener_fd = bind_socket(SO_REUSEADDR | SO_REUSEPORT, setup_addr);
+	listener_fd = bind_socket(SO_REUSEPORT, setup_addr);
 	if (listen(listener_fd, 100) < 0) {
 		perror("listen failed");
 		return -1;

