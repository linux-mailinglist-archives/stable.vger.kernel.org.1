Return-Path: <stable+bounces-16117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726983F07D
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7307AB242EF
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790A1B954;
	Sat, 27 Jan 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlYphKg7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A11B80E
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393259; cv=none; b=XWbAXGBvAVAiQsvto+ii4MI/kjNksDLyL113AtN2IvIG8F05eLZyBWjEIdl2jUwQ1tWiN5dZuhEqnBLJPFFEOYHdm1kPXOnEE7wkTRswZRbw5FkYBKZSemAsu6nzgfezwXeg7/Uqz0x8bcW0yP1vo/C4xveqh4MM7oV8JTUi0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393259; c=relaxed/simple;
	bh=N0VCXoG2g+hwgdtfkyX6gxpweM7XvDiPJYjboewX9mM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QxySbipW9W5jpsVavBlFSth3zlEzvP0QOaepE1k28JLWtQOYMZZuxg+gyfoeaInP3En2DCsz50V679V7zvtlK9pzkGe5wjEvosMW0TDrU9g0fYyqu78BQ/yPE2ZOM8kVyrta8T3LcHwEW64YAt75XZuAfOeYzXhC0Wm7o2OzAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlYphKg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB61AC433C7;
	Sat, 27 Jan 2024 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706393259;
	bh=N0VCXoG2g+hwgdtfkyX6gxpweM7XvDiPJYjboewX9mM=;
	h=Subject:To:Cc:From:Date:From;
	b=rlYphKg7p2f5tmOGnmrLfASdnLnFcAyfYJdgLZ0C94WxEiQrMq6wsZlfgdndrXezP
	 oO4Y31caIZi35cQuaKbVMvtFliVsKr0jjr5ozFvMf5wQfjVlNQdKK1slZ4O1rd3DBT
	 L6OsdDpnbPcgxJoMTuefDbL13sbYSrsTyXLAdPqo=
Subject: FAILED: patch "[PATCH] cpufreq: intel_pstate: Refine computation of P-state for" failed to apply to 5.15-stable tree
To: rafael.j.wysocki@intel.com,srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:07:37 -0800
Message-ID: <2024012737-lavish-haziness-80cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 192cdb1c907fd8df2d764c5bb17496e415e59391
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012737-lavish-haziness-80cc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

192cdb1c907f ("cpufreq: intel_pstate: Refine computation of P-state for given frequency")
458b03f81afb ("cpufreq: intel_pstate: Drop redundant intel_pstate_get_hwp_cap() call")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 192cdb1c907fd8df2d764c5bb17496e415e59391 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Mon, 22 Jan 2024 15:18:11 +0100
Subject: [PATCH] cpufreq: intel_pstate: Refine computation of P-state for
 given frequency

On systems using HWP, if a given frequency is equal to the maximum turbo
frequency or the maximum non-turbo frequency, the HWP performance level
corresponding to it is already known and can be used directly without
any computation.

Accordingly, adjust the code to use the known HWP performance levels in
the cases mentioned above.

This also helps to avoid limiting CPU capacity artificially in some
cases when the BIOS produces the HWP_CAP numbers using a different
E-core-to-P-core performance scaling factor than expected by the kernel.

Fixes: f5c8cf2a4992 ("cpufreq: intel_pstate: hybrid: Use known scaling factor for P-cores")
Cc: 6.1+ <stable@vger.kernel.org> # 6.1+
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2ca70b0b5fdc..ca94e60e705a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -529,6 +529,30 @@ static int intel_pstate_cppc_get_scaling(int cpu)
 }
 #endif /* CONFIG_ACPI_CPPC_LIB */
 
+static int intel_pstate_freq_to_hwp_rel(struct cpudata *cpu, int freq,
+					unsigned int relation)
+{
+	if (freq == cpu->pstate.turbo_freq)
+		return cpu->pstate.turbo_pstate;
+
+	if (freq == cpu->pstate.max_freq)
+		return cpu->pstate.max_pstate;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		return freq / cpu->pstate.scaling;
+	case CPUFREQ_RELATION_C:
+		return DIV_ROUND_CLOSEST(freq, cpu->pstate.scaling);
+	}
+
+	return DIV_ROUND_UP(freq, cpu->pstate.scaling);
+}
+
+static int intel_pstate_freq_to_hwp(struct cpudata *cpu, int freq)
+{
+	return intel_pstate_freq_to_hwp_rel(cpu, freq, CPUFREQ_RELATION_L);
+}
+
 /**
  * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
@@ -546,6 +570,7 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
 	int scaling = cpu->pstate.scaling;
+	int freq;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
@@ -559,16 +584,16 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
 					 perf_ctl_scaling);
 
-	cpu->pstate.max_pstate_physical =
-			DIV_ROUND_UP(perf_ctl_max_phys * perf_ctl_scaling,
-				     scaling);
+	freq = perf_ctl_max_phys * perf_ctl_scaling;
+	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
-	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	freq = cpu->pstate.min_pstate * perf_ctl_scaling;
+	cpu->pstate.min_freq = freq;
 	/*
 	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
 	 * the effective range of HWP performance levels.
 	 */
-	cpu->pstate.min_pstate = DIV_ROUND_UP(cpu->pstate.min_freq, scaling);
+	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
 static inline void update_turbo_state(void)
@@ -2528,13 +2553,12 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
 	 * abstract values to represent performance rather than pure ratios.
 	 */
 	if (hwp_active && cpu->pstate.scaling != perf_ctl_scaling) {
-		int scaling = cpu->pstate.scaling;
 		int freq;
 
 		freq = max_policy_perf * perf_ctl_scaling;
-		max_policy_perf = DIV_ROUND_UP(freq, scaling);
+		max_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
 		freq = min_policy_perf * perf_ctl_scaling;
-		min_policy_perf = DIV_ROUND_UP(freq, scaling);
+		min_policy_perf = intel_pstate_freq_to_hwp(cpu, freq);
 	}
 
 	pr_debug("cpu:%d min_policy_perf:%d max_policy_perf:%d\n",
@@ -2908,18 +2932,7 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 
-	switch (relation) {
-	case CPUFREQ_RELATION_L:
-		target_pstate = DIV_ROUND_UP(freqs.new, cpu->pstate.scaling);
-		break;
-	case CPUFREQ_RELATION_H:
-		target_pstate = freqs.new / cpu->pstate.scaling;
-		break;
-	default:
-		target_pstate = DIV_ROUND_CLOSEST(freqs.new, cpu->pstate.scaling);
-		break;
-	}
-
+	target_pstate = intel_pstate_freq_to_hwp_rel(cpu, freqs.new, relation);
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, false);
 
 	freqs.new = target_pstate * cpu->pstate.scaling;
@@ -2937,7 +2950,7 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 	update_turbo_state();
 
-	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 


