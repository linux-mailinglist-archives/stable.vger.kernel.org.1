Return-Path: <stable+bounces-88466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DC99B2618
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668E42820A2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3A18F2DD;
	Mon, 28 Oct 2024 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qo/jWgVj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4BD18F2DB;
	Mon, 28 Oct 2024 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097396; cv=none; b=OKtfscm4vbEWJ3rrTCEy+gkTlD9mOVIGjy+EalCnJKIZ8icFtYDACadSHhhuLo4JfyX1odbeyd+dSmiqkpmcMbEgbO9ixto5uPIXXPB/zIlUhYCfgVcKkkxoewF5JMI1o/0QsYaUcpMakCybd42ADbKWNu8BuVb6n5ovSLQFXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097396; c=relaxed/simple;
	bh=i6VagJgHolxwB82sYsMOoo60Fkjp+b3G4PSWknClNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugHhng3ulWrbwZMpDQfZfxA4gTHsAYoV4nmW4tnez8AatuVYJt6Ya8CKhR0rSfCBSYRj8QMnfFm+0Am4TeR5x6XTfK5iPvXd89FoWsgKC4n7gGU3iA8s6vVCz0e7bqnitKQ3OmANb9VYKcYWg1X3iZgGDfQXhgEH36ZwwsL3iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qo/jWgVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD74BC4CEC3;
	Mon, 28 Oct 2024 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097396;
	bh=i6VagJgHolxwB82sYsMOoo60Fkjp+b3G4PSWknClNJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo/jWgVjITkvMhMSzT8csc27ndACyTDbTGTnYDGyRTlDeq4J5gg5kHPWtDc8IgAlG
	 FCYPxOHCVqI19eijnKOWxP4KFF+lNdYP5aPx1yoEpewiNORp8aGTpTutW/iX4AAUTy
	 SdlHwBjaMa3PtinjJIWgGj14IGmzYanCiuHpKX7c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 113/137] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}()
Date: Mon, 28 Oct 2024 07:25:50 +0100
Message-ID: <20241028062301.870194127@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 50b813b147e9eb6546a1fc49d4e703e6d23691f2 ]

Move and rename cppc_cpufreq_perf_to_khz() and cppc_cpufreq_khz_to_perf() to
use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().

Modify the interface to use struct cppc_perf_caps *caps instead of
struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps.

cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
before using them. We move this conversion inside cppc_perf_to_khz and
cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.

No functional change

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20231211104855.558096-6-vincent.guittot@linaro.org
Stable-dep-of: d93df29bdab1 ("cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
 include/acpi/cppc_acpi.h       |   2 +
 3 files changed, 123 insertions(+), 122 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 12296d85a7196..8d4b72488eb5e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,9 @@
 #include <linux/rwsem.h>
 #include <linux/wait.h>
 #include <linux/topology.h>
+#include <linux/dmi.h>
+#include <linux/units.h>
+#include <asm/unaligned.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -1664,3 +1667,104 @@ unsigned int cppc_get_transition_latency(int cpu_num)
 	return latency_ns;
 }
 EXPORT_SYMBOL_GPL(cppc_get_transition_latency);
+
+/* Minimum struct length needed for the DMI processor entry we want */
+#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
+
+/* Offset in the DMI processor structure for the max frequency */
+#define DMI_PROCESSOR_MAX_SPEED		0x14
+
+/* Callback function used to retrieve the max frequency from DMI */
+static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	const u8 *dmi_data = (const u8 *)dm;
+	u16 *mhz = (u16 *)private;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR &&
+	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
+		u16 val = (u16)get_unaligned((const u16 *)
+				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
+		*mhz = val > *mhz ? val : *mhz;
+	}
+}
+
+/* Look up the max frequency in DMI */
+static u64 cppc_get_dmi_max_khz(void)
+{
+	u16 mhz = 0;
+
+	dmi_walk(cppc_find_dmi_mhz, &mhz);
+
+	/*
+	 * Real stupid fallback value, just in case there is no
+	 * actual value set.
+	 */
+	mhz = mhz ? mhz : 1;
+
+	return KHZ_PER_MHZ * mhz;
+}
+
+/*
+ * If CPPC lowest_freq and nominal_freq registers are exposed then we can
+ * use them to convert perf to freq and vice versa. The conversion is
+ * extrapolated as an affine function passing by the 2 points:
+ *  - (Low perf, Low freq)
+ *  - (Nominal perf, Nominal freq)
+ */
+unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64 mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		mul = caps->nominal_freq - caps->lowest_freq;
+		mul *= KHZ_PER_MHZ;
+		div = caps->nominal_perf - caps->lowest_perf;
+		offset = caps->nominal_freq * KHZ_PER_MHZ -
+			 div64_u64(caps->nominal_perf * mul, div);
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = max_khz;
+		div = caps->highest_perf;
+	}
+
+	retval = offset + div64_u64(perf * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_to_khz);
+
+unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq)
+{
+	s64 retval, offset = 0;
+	static u64 max_khz;
+	u64  mul, div;
+
+	if (caps->lowest_freq && caps->nominal_freq) {
+		mul = caps->nominal_perf - caps->lowest_perf;
+		div = caps->nominal_freq - caps->lowest_freq;
+		/*
+		 * We don't need to convert to kHz for computing offset and can
+		 * directly use nominal_freq and lowest_freq as the div64_u64
+		 * will remove the frequency unit.
+		 */
+		offset = caps->nominal_perf -
+			 div64_u64(caps->nominal_freq * mul, div);
+		/* But we need it for computing the perf level. */
+		div *= KHZ_PER_MHZ;
+	} else {
+		if (!max_khz)
+			max_khz = cppc_get_dmi_max_khz();
+		mul = caps->highest_perf;
+		div = max_khz;
+	}
+
+	retval = offset + div64_u64(freq * mul, div);
+	if (retval >= 0)
+		return retval;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_khz_to_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8791a88c7741c..0050242d382e7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/dmi.h>
 #include <linux/irq_work.h>
 #include <linux/kthread.h>
 #include <linux/time.h>
@@ -27,12 +26,6 @@
 
 #include <acpi/cppc_acpi.h>
 
-/* Minimum struct length needed for the DMI processor entry we want */
-#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
-
-/* Offset in the DMI processor structure for the max frequency */
-#define DMI_PROCESSOR_MAX_SPEED		0x14
-
 /*
  * This list contains information parsed from per CPU ACPI _CPC and _PSD
  * structures: e.g. the highest and lowest supported performance, capabilities,
@@ -288,97 +281,9 @@ static inline void cppc_freq_invariance_exit(void)
 }
 #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
 
-/* Callback function used to retrieve the max frequency from DMI */
-static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
-{
-	const u8 *dmi_data = (const u8 *)dm;
-	u16 *mhz = (u16 *)private;
-
-	if (dm->type == DMI_ENTRY_PROCESSOR &&
-	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
-		u16 val = (u16)get_unaligned((const u16 *)
-				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
-		*mhz = val > *mhz ? val : *mhz;
-	}
-}
-
-/* Look up the max frequency in DMI */
-static u64 cppc_get_dmi_max_khz(void)
-{
-	u16 mhz = 0;
-
-	dmi_walk(cppc_find_dmi_mhz, &mhz);
-
-	/*
-	 * Real stupid fallback value, just in case there is no
-	 * actual value set.
-	 */
-	mhz = mhz ? mhz : 1;
-
-	return (1000 * mhz);
-}
-
-/*
- * If CPPC lowest_freq and nominal_freq registers are exposed then we can
- * use them to convert perf to freq and vice versa. The conversion is
- * extrapolated as an affine function passing by the 2 points:
- *  - (Low perf, Low freq)
- *  - (Nominal perf, Nominal perf)
- */
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
-					     unsigned int perf)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64 mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_freq - caps->lowest_freq;
-		div = caps->nominal_perf - caps->lowest_perf;
-		offset = caps->nominal_freq - div64_u64(caps->nominal_perf * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = max_khz;
-		div = caps->highest_perf;
-	}
-
-	retval = offset + div64_u64(perf * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
-static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
-					     unsigned int freq)
-{
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	s64 retval, offset = 0;
-	static u64 max_khz;
-	u64  mul, div;
-
-	if (caps->lowest_freq && caps->nominal_freq) {
-		mul = caps->nominal_perf - caps->lowest_perf;
-		div = caps->nominal_freq - caps->lowest_freq;
-		offset = caps->nominal_perf - div64_u64(caps->nominal_freq * mul, div);
-	} else {
-		if (!max_khz)
-			max_khz = cppc_get_dmi_max_khz();
-		mul = caps->highest_perf;
-		div = max_khz;
-	}
-
-	retval = offset + div64_u64(freq * mul, div);
-	if (retval >= 0)
-		return retval;
-	return 0;
-}
-
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
-
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
@@ -386,7 +291,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret = 0;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	/* Return if it is exactly the same perf */
 	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
 		return ret;
@@ -414,7 +319,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	u32 desired_perf;
 	int ret;
 
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
+	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 
@@ -527,7 +432,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	min_step = min_cap / CPPC_EM_CAP_STEP;
 	max_step = max_cap / CPPC_EM_CAP_STEP;
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, *KHz);
 	step = perf_prev / perf_step;
 
 	if (step > max_step)
@@ -547,8 +452,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 			perf = step * perf_step;
 	}
 
-	*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-	perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+	*KHz = cppc_perf_to_khz(perf_caps, perf);
+	perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 	step_check = perf_check / perf_step;
 
 	/*
@@ -558,8 +463,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	 */
 	while ((*KHz == prev_freq) || (step_check != step)) {
 		perf++;
-		*KHz = cppc_cpufreq_perf_to_khz(cpu_data, perf);
-		perf_check = cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
+		*KHz = cppc_perf_to_khz(perf_caps, perf);
+		perf_check = cppc_khz_to_perf(perf_caps, *KHz);
 		step_check = perf_check / perf_step;
 	}
 
@@ -588,7 +493,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
 
-	perf_prev = cppc_cpufreq_khz_to_perf(cpu_data, KHz);
+	perf_prev = cppc_khz_to_perf(perf_caps, KHz);
 	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
 	step = perf_prev / perf_step;
 
@@ -676,10 +581,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
-	/* Convert the lowest and nominal freq from MHz to KHz */
-	cpu_data->perf_caps.lowest_freq *= 1000;
-	cpu_data->perf_caps.nominal_freq *= 1000;
-
 	list_add(&cpu_data->node, &cpu_data_list);
 
 	return cpu_data;
@@ -721,20 +622,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-					       caps->nominal_perf);
+	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
+	policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
-	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
-							    caps->nominal_perf);
+	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
+	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -770,7 +667,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_perf);
+	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -865,7 +762,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
@@ -880,11 +777,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	}
 
 	if (state)
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->highest_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-						       caps->nominal_perf);
+		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
@@ -944,7 +839,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret < 0)
 		return -EIO;
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
+	return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
 }
 
 static void cppc_check_hisi_workaround(void)
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index b097bd57b2e47..2d1ec0e6ee018 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -143,6 +143,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
 extern bool cppc_perf_ctrs_in_pcc(void);
+extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
+extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
-- 
2.43.0




