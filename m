Return-Path: <stable+bounces-169808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B423B285C1
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C20CAA575D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81F1FECB1;
	Fri, 15 Aug 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bTMaKFkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7603176E2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282031; cv=none; b=kGjGyJMofBRMPLDF63dT3irW5SQJ5ccAHrAw96yot+jVDiriKFJu2rBe3Xh942msfWqJjv7CTVeZ4QcOPpFVO/doJ22gEY0XTjjQyExwYQScwKmbuKDAoKmumNVn3wSyQv1mkpIFlPoxcM163ap+MEvdElDIWexqQpxMJrf1deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282031; c=relaxed/simple;
	bh=FEFtSajkmx7KLfKXQN86Qf/7ZWSFWA+PMzgEzAHxh0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCMGO1A9tBA28ZtlwCF6l1d0hOPWhIX6C+RY3uOZQyi6nL4Y367uk0whamQNmPTvBYR7vvQl8FbKk2/IXXJrKtxfvmPuUe20SlqJgPnceM0xzeqETnwkApVFJEr1chIqSki+yCO1DRODtln08r4DYQDzw4ZYI/wZB0vKZEuhrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bTMaKFkJ; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281979;
	bh=BR0JLRFqpvP5NUzDfkGD/i3BjoGsEKH0Gaa1fAUzP5I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bTMaKFkJTa/38Vd2QqVAONiAXtY08FzT8uhFAlVjH6knZMgHo4vHC/nynMGPpGp8D
	 HY9WaMsj31US6yWNvztrHiuTZeAlU41A/uIFkmSvqHZrCzvsYHwhhhuULukLnTDWHw
	 KMFBsYrHMJMKdJH1YTqn7YZvfVXl7E+L7JFmHSRg=
X-QQ-mid: esmtpgz10t1755281973t9b96873f
X-QQ-Originating-IP: PvF/E/ctRdEkanQcOsSgle3J/HAmeQlV57ZyiC6DxBQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17419943528175665224
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 6/8] arm64/amu: Use capacity_ref_freq() to set AMU ratio
Date: Sat, 16 Aug 2025 02:16:16 +0800
Message-Id: <20250815181618.3199442-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MRiFTjyIbtS1UkCEKGDbjcDaIv5LeGJhdxOqzQ1al0+Ql1taRS5Ryxzu
	Rt7YBDQqOLN0VXBcxZrhpzDhG/eDEbIn6VdP9FwTNE+PNb4o1vPTS1t3g2A6GdDc2PHUnEq
	wlBsORVYAxPPDNleLJ3YoRz00ig6+d4Sq6z8oR7U0X1nXTyq2UW4PqvgU7wH5WHOo3s+VTn
	nmzl23FlaQBzNgdI/gpFyX9Js6tRxbpbhy2y8dxWHxAJgXgwpoCtzyp66Xxp04zoFiEO859
	sYFGVwnHL02LlzbaiJTVsG7COe/eUWiA75OSiDB0gARGct/vNphfg0wGDuTN/31HIc1O6JG
	AcUuYWUFLuz4WuzqX/JSwTuofHG1YyTuRalQfIDpRZnAbms4GFLvUBcpJTZd2kv8l9GKYDJ
	hWccQwXOxRou4yXvsScWjs7IK+TtJR/xA2pUVVvwmu1SmIk3UNp+mcJsMII4J5/8NoGaZno
	06G1KeyFaEhvw6VgPx9eMUkCWU5WmNYWsL9KATRF7Jtf3/lxmEYuD1+f/fKpj/1/uM/wHbd
	fxbeO/iBl3RMCYJunKbCr8FUiPbmIiOZkEHrVkyRSt1tOLvhZHBbGnLYiquph64mnXPDxkG
	+oy6WlLKwbETQ/yTv5KUvHm3WM5+eFD3OZJ+ZQUpS52jWOps5kFiKkQL0zLvmnOjEXLzXuS
	WWnHcVMPY67RBV7kXklLp9XEK+qr64MRtAgDqOeHyEJvI4c0YJpIxLQ8qb6GyjOuFFpkSyH
	2jzmxWVG/JySVZ+fO32LSUm7YgrVJ0jETxDI2QSu3X69G2xwdae6Jg1fX3+O2Pw/PYnPlL8
	S2FOCp7fGQGUkNCnwQ3QH4FGpdCRefAdPbZbrkn32RqCn8StZGWpVAqF0doZyEkn4sKPv0b
	5uUQfkN7hkgZO3M9XyjdvgwZJqSPg6JQ6FPliMBUc8mrv4bl3I6SNrA55CUBQxjR3MKQHbh
	N85BdzAE/QwD2RP0s6S0ai/4/XNJjMffexexay5LNkNTMYwlhk51X9UIHF/4z77fFtEY1bV
	oH1uTv0jh5Xek4scHJyBKuu0JhVN6KdMD0a2IOLnXSTn85oBh6UIuf3s9kPe4HaplidjZ1f
	fi56gpr3x+EBLteD5mT32RO8vFJrDNV5A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

Use the new capacity_ref_freq() method to set the ratio that is used by AMU for
computing the arch_scale_freq_capacity().
This helps to keep everything aligned using the same reference for
computing CPUs capacity.

The default value of the ratio (stored in per_cpu(arch_max_freq_scale))
ensures that arch_scale_freq_capacity() returns max capacity until it is
set to its correct value with the cpu capacity and capacity_ref_freq().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20231211104855.558096-8-vincent.guittot@linaro.org
(cherry picked from commit 1f023007f5e782bda19ad9104830c404fd622c5d)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/arm64/kernel/topology.c  | 26 +++++++++++++-------------
 drivers/base/arch_topology.c  | 12 +++++++++++-
 include/linux/arch_topology.h |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..1a2c72f3e7f8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
 #undef pr_fmt
 #define pr_fmt(fmt) "AMU: " fmt
 
-static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
+/*
+ * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SCALE until
+ * the CPU capacity and its associated frequency have been correctly
+ * initialized.
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
@@ -112,14 +117,14 @@ static inline bool freq_counters_valid(int cpu)
 	return true;
 }
 
-static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
+void freq_inv_set_max_ratio(int cpu, u64 max_rate)
 {
-	u64 ratio;
+	u64 ratio, ref_rate = arch_timer_get_rate();
 
 	if (unlikely(!max_rate || !ref_rate)) {
-		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
+		WARN_ONCE(1, "CPU%d: invalid maximum or reference frequency.\n",
 			 cpu);
-		return -EINVAL;
+		return;
 	}
 
 	/*
@@ -139,12 +144,10 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 	ratio = div64_u64(ratio, max_rate);
 	if (!ratio) {
 		WARN_ONCE(1, "Reference frequency too low.\n");
-		return -EINVAL;
+		return;
 	}
 
-	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
-
-	return 0;
+	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
 }
 
 static void amu_scale_freq_tick(void)
@@ -195,10 +198,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 		return;
 
 	for_each_cpu(cpu, cpus) {
-		if (!freq_counters_valid(cpu) ||
-		    freq_inv_set_max_ratio(cpu,
-					   cpufreq_get_hw_max_freq(cpu) * 1000ULL,
-					   arch_timer_get_rate()))
+		if (!freq_counters_valid(cpu))
 			return;
 	}
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1aa76b5c96c2..5aaa0865625d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -344,6 +344,10 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+void __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
+{
+}
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
@@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
 	}
 
 	for_each_possible_cpu(cpu) {
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+
 		capacity = raw_capacity[cpu];
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 				     capacity_scale);
@@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus)
+	for_each_cpu(cpu, policy->related_cpus) {
 		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ);
+	}
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 32c24ff4f2a8..a63d61ca55af 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+void freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.20.1


