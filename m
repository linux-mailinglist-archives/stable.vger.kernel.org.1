Return-Path: <stable+bounces-134802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463AAA95203
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C73D171FF4
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D5265CB6;
	Mon, 21 Apr 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhzd4daN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A3264A74
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243642; cv=none; b=RPSWfxY4d3uHQvwb0YbY2IIP1HEWDqOo4Y2ng8E5R4ATxHRU5wp5a5KXCiNh+IZM0wimbXBkxRZws6ZAtEpl9P5stA6XmqswMLl6LQP3AplleZBzxq265ugh5QensIeDmvfY/tfLwohFlTe+0jsZqkofi0VOXhL6kmOYZ6DoAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243642; c=relaxed/simple;
	bh=f87RZgO8aQYFz6LkRIAmSIpQm2Ro5ZKPamRGsUJfHWM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qLdEtFLbpoxuYb4ADcLlytqnDYsPzWwpPC4FCjIoaROLh46yZsechaDRaDTP3MLGii/L4OFWx+pzLGAvCpp0Q4gjYbAR5rr8Zw/hQvj0NRenrD89qNvzxag1W1lAHiQDNHz7/mC3NRMMrecmokhQ6bkVWx3swLxbs8sI+Lm6R5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhzd4daN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B12C4CEE4;
	Mon, 21 Apr 2025 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243641;
	bh=f87RZgO8aQYFz6LkRIAmSIpQm2Ro5ZKPamRGsUJfHWM=;
	h=Subject:To:Cc:From:Date:From;
	b=fhzd4daNMIZ40jEYanEi84/cUQUfBMjAkS5i50qMSGmTMUrL7nqKLUz0TRBm3ZzCY
	 TumRVtrgnDCaXfK5pnBF+/yhSSgzr/Dqd6I1NEvm2W209Mk/0AKg5L/svjkapAGReH
	 HulIa8QrQ0i3vaHwrJ6B12jpt+RwPS2C05NdGCY4=
Subject: FAILED: patch "[PATCH] cpufreq/sched: Explicitly synchronize limits_changed flag" failed to apply to 6.1-stable tree
To: rafael.j.wysocki@intel.com,christian.loehle@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:53:56 +0200
Message-ID: <2025042156-uncurled-citizen-ae9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 79443a7e9da3c9f68290a8653837e23aba0fa89f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042156-uncurled-citizen-ae9a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79443a7e9da3c9f68290a8653837e23aba0fa89f Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Tue, 15 Apr 2025 11:59:15 +0200
Subject: [PATCH] cpufreq/sched: Explicitly synchronize limits_changed flag
 handling

The handling of the limits_changed flag in struct sugov_policy needs to
be explicitly synchronized to ensure that cpufreq policy limits updates
will not be missed in some cases.

Without that synchronization it is theoretically possible that
the limits_changed update in sugov_should_update_freq() will be
reordered with respect to the reads of the policy limits in
cpufreq_driver_resolve_freq() and in that case, if the limits_changed
update in sugov_limits() clobbers the one in sugov_should_update_freq(),
the new policy limits may not take effect for a long time.

Likewise, the limits_changed update in sugov_limits() may theoretically
get reordered with respect to the updates of the policy limits in
cpufreq_set_policy() and if sugov_should_update_freq() runs between
them, the policy limits change may be missed.

To ensure that the above situations will not take place, add memory
barriers preventing the reordering in question from taking place and
add READ_ONCE() and WRITE_ONCE() annotations around all of the
limits_changed flag updates to prevent the compiler from messing up
with that code.

Fixes: 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when limits change")
Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/3376719.44csPzL39Z@rjwysocki.net

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b713ce0a5702..bcab867575bb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -81,9 +81,20 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
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
 
@@ -377,7 +388,7 @@ static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
-		sg_cpu->sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_cpu->sg_policy->limits_changed, true);
 }
 
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
@@ -883,7 +894,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
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


