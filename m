Return-Path: <stable+bounces-177999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43376B4771C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CC01BC2F9D
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BF2BE65A;
	Sat,  6 Sep 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBd+XZOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09892BE64A
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189960; cv=none; b=eHyZ7GCzPmD59hbKAXw2FYuoxhyFrEpglIDrfChmkx5EJFcyGLnb08ZYEyN2/x066uBRD9XGyyimakJ2x1FhXoBUIhPn3U1EMHpzSP16NdguFZ4q4MSY3ZY3we4lE5IwzXndsN8rz+d7ZL8DbIrZCx1JbHzFifvEqv0Xz9lo/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189960; c=relaxed/simple;
	bh=bVpYwaj0DdhCZYbSS2cMMncHu8G/gaHPnecVaaBYuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNl2ldXjUSRB8e7e+ALRwbo+GZhcDdSq3dBuO98K5H8bq/704T/z1dBf6MIx6F1OfokFZn6ojBgrVouRDHDkjtqw33EYueH8ap/D9pT+eTn9yBuIDD5QTc6xsRCvR1WT4ZLFDvHxw/+gv8NbU5cFAOlTVILwPIPsqPp3CdYCkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBd+XZOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01472C4CEE7;
	Sat,  6 Sep 2025 20:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189960;
	bh=bVpYwaj0DdhCZYbSS2cMMncHu8G/gaHPnecVaaBYuX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBd+XZOqCvrKd37Kl1CQNyahmZ6pN4LPxEjpN5+hfE1txCXNkhJq84V46PCR9Cu3F
	 9UF/a3LaqZ0YrI5PPy5pBzfwXZsT1/ilG7vHwq+dzBXJYB0KiRsk4NC/79tU5zWqd3
	 Bh0FRI5T6U7OutBy2oZ4qlBiAKLpADf4RX5UG6so8xWcdiSsVAcFuA1D8xEuXT/ugX
	 XqWslGt83vZ0N3tybG75O97gUKILSAD2WjhjxHw8IIfptbRqNO/7Yt/ze74KjVu30Y
	 8dg1s125yfwYSoacmTLBaNQ48C95zWSs87AlqOcUxLiNV+5YPKbGmhpo9ggW68YAws
	 9g3/evG3KMoAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] cpufreq/sched: Explicitly synchronize limits_changed flag handling
Date: Sat,  6 Sep 2025 16:19:18 -0400
Message-ID: <20250906201918.261460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025042158-motivator-rummage-0678@gregkh>
References: <2025042158-motivator-rummage-0678@gregkh>
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
index 831fee509404e..babdfed7f24c1 100644
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
 
@@ -444,7 +455,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->limits_changed = true;
+		WRITE_ONCE(sg_policy->limits_changed, true);
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -894,7 +905,16 @@ static void sugov_limits(struct cpufreq_policy *policy)
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


