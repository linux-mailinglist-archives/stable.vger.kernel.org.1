Return-Path: <stable+bounces-17237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B1841060
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F37D1C23B1F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE515F31E;
	Mon, 29 Jan 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fO3DVaus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87115A49A;
	Mon, 29 Jan 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548611; cv=none; b=pBpzR1Zp5+whdfwN/r7Fl3Dp0+8hrH8lUb0udS5lELHzM0S868OzebdvQNqbBsyh2iuKD+kIZLOtDHJAK5CLxj+bAKAAz+PXlLj3MtzkUzZVvJ1uOCti4kudkdydlUOU/+TvR3TzU5QsA/soJ+6k4HzvYjHVThwitMpRDpUoTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548611; c=relaxed/simple;
	bh=ghHoW/Imrv8uxOVIn32zrkgHXUF25ApByZ+bekLqtIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWisQnczblCrgq8019YAJIMEHr2FhpWoEbRDIj+UiiDMCM6F1wb5WoVR16PX8oFnOBTDxXgs4mDt3xzIDxBimm75FGKxumo8j/GSxzqBhCWCPlYdSexZ2SwkO8sA6LPczM2BofonfbDgd92nC0wrUoUeWUP/1sMcz2jzXvKTO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fO3DVaus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061D5C43390;
	Mon, 29 Jan 2024 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548611;
	bh=ghHoW/Imrv8uxOVIn32zrkgHXUF25ApByZ+bekLqtIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fO3DVausAcjm9Y9uQGOjiDr0YdqETLfcbbAiKXwS18zpxUsYC2PYvFkoYTHORtkly
	 M3Z31oOC2H753W9X9oZV5tQhmct/c0DeeLdyY+C7WTIIvJbQM3/NHjv129aVI7BxF+
	 qSGPcrZ6z3iBuhuJzCcOxtQXlFkU7LlT7MCBIc94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 253/331] cpufreq: intel_pstate: Refine computation of P-state for given frequency
Date: Mon, 29 Jan 2024 09:05:17 -0800
Message-ID: <20240129170022.285436050@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 192cdb1c907fd8df2d764c5bb17496e415e59391 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/intel_pstate.c |   55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -526,6 +526,30 @@ static int intel_pstate_cppc_get_scaling
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
@@ -543,6 +567,7 @@ static void intel_pstate_hybrid_hwp_adju
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
 	int scaling = cpu->pstate.scaling;
+	int freq;
 
 	pr_debug("CPU%d: perf_ctl_max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
 	pr_debug("CPU%d: perf_ctl_turbo = %d\n", cpu->cpu, perf_ctl_turbo);
@@ -556,16 +581,16 @@ static void intel_pstate_hybrid_hwp_adju
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
@@ -2528,13 +2553,12 @@ static void intel_pstate_update_perf_lim
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
@@ -2908,18 +2932,7 @@ static int intel_cpufreq_target(struct c
 
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
@@ -2937,7 +2950,7 @@ static unsigned int intel_cpufreq_fast_s
 
 	update_turbo_state();
 
-	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
+	target_pstate = intel_pstate_freq_to_hwp(cpu, target_freq);
 
 	target_pstate = intel_cpufreq_update_pstate(policy, target_pstate, true);
 



