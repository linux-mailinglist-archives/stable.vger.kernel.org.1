Return-Path: <stable+bounces-169804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B660B285BE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E826A1C26B81
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261FC2192E4;
	Fri, 15 Aug 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mUmZF0r/"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C031FECB1
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282004; cv=none; b=pr2hm4miyJqEPbyST0n/AUOJ61RUSgZwVJrlAOTFDQPl5VAyMwc/+KNnQMufJF6rKcOQntNVBuW2o7qgjQk/ZHnUIIfOwulGTdWeD8DN42DwoSeP9JIacfv121/n+pyAeT52M9n33r0sivP1YvRHAxGOxqfQWZhlUVRnTfRGbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282004; c=relaxed/simple;
	bh=+QVrOyZxRylSNQdNpejN43TJjy71j6pAbhnobDZDjSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0c4cdLlzpBL92wQ6Xf7YFpsTrkWLCIjgMsDYXIUJ8Qer9jywf4DZ5e4UWXsPDbUiZl+li6psTsjBV7cPs5OWFaaZMXA4+RLtbfcIxvQBXGVlVaHumZLviI+NoNPOp0A+FvpecEsNsKObH0UhoVyiIRA8AeOAU8GCW0OPFsSUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mUmZF0r/; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281958;
	bh=5zJ0bQIEGrgxQVbFkVJO1a2vBCWS1CL75sU0MSrpGTQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mUmZF0r/lJuPKrl3yMZzqY+mo4br+NVlFgUa7QEcAdpJfYUU+pTI5+hpTcK4R1wn7
	 HEfws2UKAagCygi5Q8hHfuc6UFzZ206eB6I20xEw44ftf3F6oX/rnDcK2XnpWoGVoY
	 KndV+iW0oq3SXdRT24yrGNgNPRqWXv0apyc3DYWs=
X-QQ-mid: esmtpgz10t1755281952t23693263
X-QQ-Originating-IP: xkXXcw32uYXwySydTJ/fS7VdKu/PJR1ZhNO+3GhFn90=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6031573621495913118
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 1/8] sched/topology: Add a new arch_scale_freq_ref() method
Date: Sat, 16 Aug 2025 02:16:11 +0800
Message-Id: <20250815181618.3199442-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250815181618.3199442-1-guanwentao@uniontech.com>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: ODm/QSITZk1PYhEq3nvbeUV2A+JDA97RiOdSK3JcVZbmFppEyJfJBMQK
	t8CnOEKgQu88qbQuggwYn0tWtrXOLdaB0MeMmU31O3N4KZCOkGP6fDMhmP3rFuV+9dmumci
	euBfDrjUXd+ffhaaVaS1DNWSphM7dd0/nkxPUzfMXYNmZf51b2EE05190HEUfMoZ8qQDDTI
	YkrEJC46ifk5pLMhpdTb0ppf072TzaHZryximqFiSK6HFylJGkSonWaD127ezm+2qpy13dA
	m9SpxN0siBUq5N4jGKcjJtERodCB0wkywqrT0aSrRgLM9SwbP2NwYhkaMdiB7mAT1bEBQMe
	tcIglrIGiyH52QVeL4wmP4IM9zTVJN3/ecPhlwqi3KKgB2IvHOBxoZXNeoW9eWq5IWqJv3H
	cMYmw1dZ/zA9YvbnbihRLqeYsoeUghePiCl1PVKdPHnYBNtuKvKe69A8hcYAPPx5ovvki+R
	SumDA2kbSyNrThaEObOU4uZQkHKPvHOo09uqAyqkewKcC1w8SqTbuC6Frgjj6CV26mcdmIx
	O2toZRkEOpW5wWNaW3O2W6gD1okWRD1zXaY7s6FKeDET5QH54CndOl243uM+7Kiz7f9wI8O
	hH4tx9k+8NgRwPuZNyOOUPJC1i4xC7vAwOutjMrIaoDZpRZT8MwsEIx2oaYJZC5yiX98FIF
	cwhj6i8iyhxV+JgBgjM5260FrD33aDQ71Xr+U8KLLP8bwjjK5mHk9PFNM7QVT/pEEr/1S5x
	mDQEF6sBY9rCwwuHoZ8XMKciCmO9Jj7l8MnA4lBxVETcBx03Fampq2QuEcOOVTq54hV3hL9
	wDpDyiDX/Ar8ha/hmpY+mRTAUdEPpJhtmePmptcKj4uCgdD7bAU7rEbD8cNUjqwznqrmKFO
	BrSLCWvP6CGCZ181TCqJLiC56F7vMPxAz/JZgJlu5LFKjUYUn5sCCjliWLqSIWfnzBqhLwZ
	MgeRALhEVl7rmsRwuVKsrYFgxJn/oLfWtUw0/QAGL9IUbaGgQn3s9M092byxloJZCpd5sDs
	6bYSXiDBBM+MTbPe1VC+YJx0rz7sN7avqZX/Ic7jgo9iCnvjO8+efP6s6PnYoQBtE8BilXj
	UJDTW+3+vF+P1SnvEUiUMk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

Create a new method to get a unique and fixed max frequency. Currently
cpuinfo.max_freq or the highest (or last) state of performance domain are
used as the max frequency when computing the frequency for a level of
utilization, but:

  - cpuinfo_max_freq can change at runtime. boost is one example of
    such change.

  - cpuinfo.max_freq and last item of the PD can be different leading to
    different results between cpufreq and energy model.

We need to save the reference frequency that has been used when computing
the CPUs capacity and use this fixed and coherent value to convert between
frequency and CPU's capacity.

In fact, we already save the frequency that has been used when computing
the capacity of each CPU. We extend the precision to save kHz instead of
MHz currently and we modify the type to be aligned with other variables
used when converting frequency to capacity and the other way.

[ mingo: Minor edits. ]

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20231211104855.558096-2-vincent.guittot@linaro.org
(cherry picked from commit 9942cb22ea458c34fa17b73d143ea32d4df1caca)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 29 ++++++++++++++---------------
 include/linux/arch_topology.h     |  7 +++++++
 include/linux/sched/topology.h    |  8 ++++++++
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index c7d2510e5a78..853c4f81ba4a 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -13,6 +13,7 @@
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 #endif
 
 /* Replace task scheduler's default cpu-invariant accounting */
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 9fab663dd2de..a323b109b9c4 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
index e316ab3b77f3..61183688bdd5 100644
--- a/arch/riscv/include/asm/topology.h
+++ b/arch/riscv/include/asm/topology.h
@@ -9,6 +9,7 @@
 #define arch_set_freq_scale		topology_set_freq_scale
 #define arch_scale_freq_capacity	topology_get_freq_scale
 #define arch_scale_freq_invariant	topology_scale_freq_invariant
+#define arch_scale_freq_ref		topology_get_freq_ref
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity	topology_get_cpu_scale
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..0c9ae5b157b1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal_pressure.h>
@@ -26,7 +27,8 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-static DEFINE_PER_CPU(u32, freq_factor) = 1;
+DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
+EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -170,9 +172,9 @@ DEFINE_PER_CPU(unsigned long, thermal_pressure);
  * operating on stale data when hot-plug is used for some CPUs. The
  * @capped_freq reflects the currently allowed max CPUs frequency due to
  * thermal capping. It might be also a boost frequency value, which is bigger
- * than the internal 'freq_factor' max frequency. In such case the pressure
- * value should simply be removed, since this is an indication that there is
- * no thermal throttling. The @capped_freq must be provided in kHz.
+ * than the internal 'capacity_freq_ref' max frequency. In such case the
+ * pressure value should simply be removed, since this is an indication that
+ * there is no thermal throttling. The @capped_freq must be provided in kHz.
  */
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
@@ -183,10 +185,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	cpu = cpumask_first(cpus);
 	max_capacity = arch_scale_cpu_capacity(cpu);
-	max_freq = per_cpu(freq_factor, cpu);
-
-	/* Convert to MHz scale which is used in 'freq_factor' */
-	capped_freq /= 1000;
+	max_freq = arch_scale_freq_ref(cpu);
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
@@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
@@ -321,15 +320,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			cpu_node, raw_capacity[cpu]);
 
 		/*
-		 * Update freq_factor for calculating early boot cpu capacities.
+		 * Update capacity_freq_ref for calculating early boot CPU capacities.
 		 * For non-clk CPU DVFS mechanism, there's no way to get the
 		 * frequency value now, assuming they are running at the same
-		 * frequency (by keeping the initial freq_factor value).
+		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
 		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
-			per_cpu(freq_factor, cpu) =
-				clk_get_rate(cpu_clk) / 1000;
+			per_cpu(capacity_freq_ref, cpu) =
+				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
 		}
 	} else {
@@ -411,7 +410,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
+		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..32c24ff4f2a8 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+DECLARE_PER_CPU(unsigned long, capacity_freq_ref);
+
+static inline unsigned long topology_get_freq_ref(int cpu)
+{
+	return per_cpu(capacity_freq_ref, cpu);
+}
+
 DECLARE_PER_CPU(unsigned long, arch_freq_scale);
 
 static inline unsigned long topology_get_freq_scale(int cpu)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 67b573d5bf28..9671b7234684 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -275,6 +275,14 @@ void arch_update_thermal_pressure(const struct cpumask *cpus,
 { }
 #endif
 
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.20.1


