Return-Path: <stable+bounces-177957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A700B46DFF
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596D15A273B
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF62F0C44;
	Sat,  6 Sep 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko+JZK+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA82F0688
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164937; cv=none; b=ts13ghJ/+7OLRgWtAmLkWQXSL0OjHL+k8saw2HpBhBa/4uyi7m9iAKjqeB77dznBD3H6Ow6x/j3M0ATvRUcHJDLZ4HwI7jxqwQ5X1oZnozCRKvBuov0zXKL53ZZcGMx7KvklGC1ezry2sVHhKCAE3IhoEhLHpydmBPctnopnqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164937; c=relaxed/simple;
	bh=Z1hZ9DEsKgpYpOQLeybgvxj8+QNx0yMWT4KayQexrJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxi22/NOEwO8YwjDNG8QjbJUo9dCW7/OQU5dqgWrwMqK+7rnh/n4LA8fYy4DQjNdxbyGP5DTmIY1qJdH5RysslyVk1JusyZEIc0XLVb8gBYSUl79zL0Aw7TSnzOXpyDijR09aT5LqrSInmEDkcYa/LZG+xGBo3t4LDZw+eX5KZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko+JZK+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8100C4CEE7;
	Sat,  6 Sep 2025 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164934;
	bh=Z1hZ9DEsKgpYpOQLeybgvxj8+QNx0yMWT4KayQexrJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ko+JZK+a2+o1xzgBcTrNvaiy+Xm+ulscsbjmYL6oaQLhRY/MIyoqZXUikvbVp5Cyk
	 cn+z8CVwpth+g9fcjijSMgaBYYuam9zLdibtPo39ssSy6Aq0lqZFjnlD4WyqmbB4zQ
	 AeOeWWhso7K9EEbldPic4EB5uVOjq9KXGc7YdhomGece2sqOgixQhHUnO0xu2xKOW1
	 JsS4+yCApJdKRrySb8ZlECzxxmr0tiI7MSTHEcdJ8Mocjv/1c8H3o0VfwqMkId/Zuj
	 4M1qMdh+ugvHp+6XCxkDkEs+VmdYM4XTOMQkrwKSv7mNKnJ93X/mF/6Q1W06+bns9/
	 nZwxynU7LmtYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] cpufreq: intel_pstate: Do not update global.turbo_disabled after initialization
Date: Sat,  6 Sep 2025 09:22:09 -0400
Message-ID: <20250906132210.3888723-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906132210.3888723-1-sashal@kernel.org>
References: <2025050515-constrain-banter-97de@gregkh>
 <20250906132210.3888723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 0940f1a8011fd69be5082015068e0dc31c800c20 ]

The global.turbo_disabled is updated quite often, especially in the
passive mode in which case it is updated every time the scheduler calls
into the driver.  However, this is generally not necessary and it adds
MSR read overhead to scheduler code paths (and that particular MSR is
slow to read).

For this reason, make the driver read MSR_IA32_MISC_ENABLE_TURBO_DISABLE
just once at the cpufreq driver registration time and remove all of the
in-flight updates of global.turbo_disabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Stable-dep-of: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 51 ++++++----------------------------
 1 file changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 39af2970a4297..1918cceca6cea 100644
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
@@ -559,12 +557,13 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
-static inline void update_turbo_state(void)
+static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
-	global.turbo_disabled = misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
+
+	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 }
 
 static int min_perf_pct_min(void)
@@ -1119,40 +1118,16 @@ static void intel_pstate_update_policies(void)
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
@@ -1252,7 +1227,6 @@ static ssize_t show_no_turbo(struct kobject *kobj,
 		return -EAGAIN;
 	}
 
-	update_turbo_state();
 	if (global.turbo_disabled)
 		ret = sprintf(buf, "%u\n", global.turbo_disabled);
 	else
@@ -1282,7 +1256,6 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 
 	mutex_lock(&intel_pstate_limits_lock);
 
-	update_turbo_state();
 	if (global.turbo_disabled) {
 		pr_notice_once("Turbo disabled by BIOS or unavailable on processor\n");
 		mutex_unlock(&intel_pstate_limits_lock);
@@ -2253,8 +2226,6 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 	struct sample *sample;
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = get_target_pstate(cpu);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
@@ -2572,7 +2543,6 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 		 * be invoked on them.
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
-		update_turbo_state();
 		intel_pstate_set_pstate(cpu, pstate);
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
@@ -2616,7 +2586,6 @@ static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
 {
 	int max_freq;
 
-	update_turbo_state();
 	if (hwp_active) {
 		intel_pstate_get_hwp_cap(cpu);
 		max_freq = global.no_turbo || global.turbo_disabled ?
@@ -2713,8 +2682,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_freq;
-	update_turbo_state();
-	global.turbo_disabled_mf = global.turbo_disabled;
 	policy->cpuinfo.max_freq = global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
@@ -2880,8 +2847,6 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	int target_pstate;
 
-	update_turbo_state();
-
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
@@ -2903,8 +2868,6 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int target_pstate;
 
-	update_turbo_state();
-
 	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
@@ -2922,7 +2885,6 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
 
-	update_turbo_state();
 	cap_pstate = global.turbo_disabled ? HWP_GUARANTEED_PERF(hwp_cap) :
 					     HWP_HIGHEST_PERF(hwp_cap);
 
@@ -3112,6 +3074,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
+	global.turbo_disabled = turbo_is_disabled();
+
+	arch_set_max_freq_ratio(global.turbo_disabled);
 
 	intel_pstate_driver = driver;
 	ret = cpufreq_register_driver(intel_pstate_driver);
-- 
2.51.0


