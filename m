Return-Path: <stable+bounces-177997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F7B476EC
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF179A42CC3
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601672848A7;
	Sat,  6 Sep 2025 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8IREwRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008810E0
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757188164; cv=none; b=YtuYJVZyd1jlPTppTjTo+DgI+XGhx3LOnCAd6NgM2iGWzkTl3zExsocMgZaWgCaLH4XJxQ0V6TMDt9wr54PvBMqjzgBACgS7d28ieqwJlcpfTf0/eNWOBO4qT3YFe4LSCL35Wfa1ESpuK/kifTAzLKbWjIbB2JrCjICsTzSf1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757188164; c=relaxed/simple;
	bh=ypHx4x2gl8hnL4LwTsCpAvEwdS0YkcMsU8iWNST3p5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHDku0Sg6A3Rx7sXl4+/eKTy6ynD8dJjZO5sOsq6m+/umsZoRvO3BhXg2QUQhyEvYc8Q6H5KFMnH/Xe0LcNZKRH03hIIxqp/NZd6FhDQ3HfMtpNzC/GRrx0bjQdhNdugyc4VfFDyIoGOSFnEetsMFTuozu02b2jzCB01pZ+xkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8IREwRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF6C4CEE7;
	Sat,  6 Sep 2025 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757188163;
	bh=ypHx4x2gl8hnL4LwTsCpAvEwdS0YkcMsU8iWNST3p5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8IREwRwUNdf+lzHpLUDRlcEJkmQZT3YLZd57bZ2s3NCsy4MvxsIp0aFwHRBxQ2KD
	 gNouCLgweMjKKwviYmPvp5QEjUAJlZAu0OJ+ipgBICG2wLdhOU/pMrexXKh7700qaC
	 6rZdhX2ZT1BeW9YXMxwLujb9C4+Ryrri+aWCiN+sLygROZEcIGcBXdxoe4DjEptgj9
	 ZNxmG4NR1M0tACT5KMCk+Gh4Wm4IgaLU4leTJtu34R3ffOrYKdLXCK/zYq5fmgxEPw
	 l7MnLL6w4ggpfVtR2GegY/Bu6eSlMwmZZhnnQ6k25/7cugyhUF5Y37EXmyVgBrU/Dc
	 PEH+zuupeieIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] cpufreq/sched: Explicitly synchronize limits_changed flag handling
Date: Sat,  6 Sep 2025 15:49:21 -0400
Message-ID: <20250906194921.208829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042158-trimness-alike-3083@gregkh>
References: <2025042158-trimness-alike-3083@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 79443a7e9da3c9f68290a8653837e23aba0fa89f ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c1307bbdc291b..af29114f7d360 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -88,9 +88,20 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
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
 
@@ -443,7 +454,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -891,7 +902,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
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
-- 
2.51.0


