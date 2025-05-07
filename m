Return-Path: <stable+bounces-142503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FFAAEAEC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538A35259C1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1E28D85C;
	Wed,  7 May 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZ+8xiSC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E411E22E9;
	Wed,  7 May 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644456; cv=none; b=G+si7oI30OXqSv7mZZuHm1KlXZXckp+Et8m6rWtG7hza/xpux/E8cWmrGImP0WDmcZFUFXL4ivwJSCe2EfSvwaUJu1IQgnBBBi6Um46YoFF8L9VjUQff8m4cd3YI28ZU3J6eMS96WZE/Tl5Ybs9OSAb4B4PaDEbRsBiuXKuBDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644456; c=relaxed/simple;
	bh=K66dXPMQqdF+e96zprjejr4MgyPCW36i1IB7erSU1lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuDg9ee+Czf2Be617T88jx1uqB258E2X24XHk8eeK2Q5b0aNiVRypMjBl/YhYVxQyZE2cVvenTQbsjB5hSRB1+7gL40G+2lUlaefK6wpdEJ4YlYvQUzDywjZ0UXiDg5nle15CRmssoLxFAMl8IJ+KjBW36zhom1zzIFqCc00Tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZ+8xiSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF66EC4CEE2;
	Wed,  7 May 2025 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644454;
	bh=K66dXPMQqdF+e96zprjejr4MgyPCW36i1IB7erSU1lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZ+8xiSCQZVOAVwysSE0gyTXjIgHAGEx63M+t0KTWpJRxRGauBZBE4ENz+XE+X411
	 s8bOYrI8ZbfhgC8GaNe0RReW6OWl4sh9HL+GnLVLPvAaS/D8KV7X/S9q79MADaa3UV
	 Mn2lzIrVlSuxsn866Mev66OoG5NlGRw7beYopmeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.12 048/164] cpufreq: Avoid using inconsistent policy->min and policy->max
Date: Wed,  7 May 2025 20:38:53 +0200
Message-ID: <20250507183822.827001194@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 7491cdf46b5cbdf123fc84fbe0a07e9e3d7b7620 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -538,8 +538,6 @@ static unsigned int __resolve_freq(struc
 {
 	unsigned int idx;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-
 	if (!policy->freq_table)
 		return target_freq;
 
@@ -563,7 +561,22 @@ static unsigned int __resolve_freq(struc
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
 
@@ -2323,6 +2336,7 @@ int __cpufreq_driver_target(struct cpufr
 	if (cpufreq_disabled())
 		return -ENODEV;
 
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	target_freq = __resolve_freq(policy, target_freq, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
@@ -2647,11 +2661,15 @@ static int cpufreq_set_policy(struct cpu
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



