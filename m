Return-Path: <stable+bounces-134806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3528FA95208
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE59E18842E9
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1C265CB6;
	Mon, 21 Apr 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBvsTeNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DE26560B
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243657; cv=none; b=LS59MlfwYItTzmN68PINvu5YKFaLu0tRHFBAOAyFPHfIisDp+g+Abmud/eDadyy5AQWewCLh2Q8fiIDbh75eihc5ftNtwAUttTedZaecb9tnWkNgDsvwZPTDMXYFpPWv2muN5iQm9e99r0lepPfDqR0iEv7qJbfjG/goynHG14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243657; c=relaxed/simple;
	bh=WRORKf8PLMSrGsLctZC5J1IiaI+vUF0ru8bZxnwL0v4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FvZOQT0sUsnq74rBEVOFlWVdUfiuxqQt2wULURBfq9K1wza8Akl18qWwuc6sYdD62zJwLq9iCFnCPcVmcfLxBSCVswGqgfwgycwAKnqN4ODcldaa+wfGh43/Sewgqmc3GeMtXwsmsTKjTvPTldEzvGlGz4kvducQOvFOc0HK7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBvsTeNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C1C4CEE4;
	Mon, 21 Apr 2025 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243656;
	bh=WRORKf8PLMSrGsLctZC5J1IiaI+vUF0ru8bZxnwL0v4=;
	h=Subject:To:Cc:From:Date:From;
	b=wBvsTeNr4wQeDhkRbO8lJvcceNol5Wa/K0VvWeAMTYh/KQutlxPPblgYB7R2eLOW8
	 IR8s7i+8AGVlT1ycFje1zJJPdazNrJ8SaewXuKnwZANluZ8o97Osw5hMXshsgowlFP
	 Tz9PFpwanbPsitlD+YnUfDkjZdfn/C+mMTyUU+50=
Subject: FAILED: patch "[PATCH] cpufreq: Avoid using inconsistent policy->min and policy->max" failed to apply to 5.15-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,stable@vger.kernel.org,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:54:14 +0200
Message-ID: <2025042114-outmost-landlord-98cc@gregkh>
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
git cherry-pick -x 7491cdf46b5cbdf123fc84fbe0a07e9e3d7b7620
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042114-outmost-landlord-98cc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7491cdf46b5cbdf123fc84fbe0a07e9e3d7b7620 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 16 Apr 2025 16:12:37 +0200
Subject: [PATCH] cpufreq: Avoid using inconsistent policy->min and policy->max

Since cpufreq_driver_resolve_freq() can run in parallel with
cpufreq_set_policy() and there is no synchronization between them,
the former may access policy->min and policy->max while the latter
is updating them and it may see intermediate values of them due
to the way the update is carried out.  Also the compiler is free
to apply any optimizations it wants both to the stores in
cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
which may result in additional inconsistencies.

To address this, use WRITE_ONCE() when updating policy->min and
policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
in cpufreq_set_policy() to avoid storing intermediate values in
policy->min and policy->max with the help of the observation that
their new values are expected to be properly ordered upfront.

Also modify cpufreq_driver_resolve_freq() to take the possible reverse
ordering of policy->min and policy->max, which may happen depending on
the ordering of operations when this function and cpufreq_set_policy()
run concurrently, into account by always honoring the max when it
turns out to be less than the min (in case it comes from thermal
throttling or similar).

Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/5907080.DvuYhMxLoT@rjwysocki.net

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3841c9da6cac..acf19b0042bb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -540,8 +540,6 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 {
 	unsigned int idx;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-
 	if (!policy->freq_table)
 		return target_freq;
 
@@ -565,7 +563,22 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
+	unsigned int min = READ_ONCE(policy->min);
+	unsigned int max = READ_ONCE(policy->max);
+
+	/*
+	 * If this function runs in parallel with cpufreq_set_policy(), it may
+	 * read policy->min before the update and policy->max after the update
+	 * or the other way around, so there is no ordering guarantee.
+	 *
+	 * Resolve this by always honoring the max (in case it comes from
+	 * thermal throttling or similar).
+	 */
+	if (unlikely(min > max))
+		min = max;
+
+	return __resolve_freq(policy, clamp_val(target_freq, min, max),
+			      CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2384,6 +2397,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (cpufreq_disabled())
 		return -ENODEV;
 
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	target_freq = __resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
@@ -2708,11 +2722,15 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * Resolve policy min/max to available frequencies. It ensures
 	 * no frequency resolution will neither overshoot the requested maximum
 	 * nor undershoot the requested minimum.
+	 *
+	 * Avoid storing intermediate values in policy->max or policy->min and
+	 * compiler optimizations around them because they may be accessed
+	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	policy->min = new_data.min;
-	policy->max = new_data.max;
-	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
-	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
+	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
+	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+
 	trace_cpu_frequency_limits(policy);
 
 	cpufreq_update_pressure(policy);


