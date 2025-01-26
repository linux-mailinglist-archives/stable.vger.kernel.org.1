Return-Path: <stable+bounces-110477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219D9A1C913
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294431882233
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1918B476;
	Sun, 26 Jan 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaTlOw3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F818A6D7;
	Sun, 26 Jan 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903018; cv=none; b=H7lokUMKilqQI+/sqEtw2/HpDdPsU8LgD2LE9SSMlvlqjqZPEAaf9+vX4L34LfGKvZV9YwcRKULJW3J3DXJIGG9CnPX7pdatdcZNjZ1jNZYdZJJ1jtnawJ11L+TrcxYUUt52mbviWJ1yneMu8a48mRVj4p1gLVaeStmxdzsbrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903018; c=relaxed/simple;
	bh=AFSpZhjdOPj6ygK4i9Ey/csETPk22L8PmJqr6ee6tEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5P+bLbkEkSxABKouHy7T7iISRTtQhdfrFjovxhmIJ1puPrf/pC3Nq7M7+ZMjxEVC8EO4pjZ5/+50AMW48m4DvaAJvz6BjHCjrG1AYFTuR5taJ3ppd1A1qL9HK9wKnAms4vhvKgkahh29gkKnJPhI4SNd4jUYFxoQZNK3pD/7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaTlOw3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7649CC4CEE3;
	Sun, 26 Jan 2025 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903016;
	bh=AFSpZhjdOPj6ygK4i9Ey/csETPk22L8PmJqr6ee6tEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TaTlOw3OjLQFPoOu1PuAR1XPtdJ7zoGvHSSPjYpW9rFPwvFm2XPPC2+p8ShKRdx4i
	 fekhIWbANEm5qPcMtHypG9aUxEXR0bak4bZDkd8r43zQ678wtgT8HDaMMG0quJM8Za
	 4IL6IB8QuFs5dTxpv+nhhnCvTc0cU+uCSSp7ILXAGIk1gVusDjEZ+SK0AK8mXsDtJs
	 RhWLx6lNRbCmr/1X+vCo/KPRmvlL+3UYNAI6CFjuKMu3T96jvoLWrjIlHlbAd0PmXO
	 M8VywuuMCn6+Pjj7dindW9zuOCidNN8taL0MVNMAkE6KxsxmBuniPlgQBs8xro7GRf
	 FyL7x5CYnGsSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.13 3/7] sched/deadline: Check bandwidth overflow earlier for hotplug
Date: Sun, 26 Jan 2025 09:50:06 -0500
Message-Id: <20250126145011.925720-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145011.925720-1-sashal@kernel.org>
References: <20250126145011.925720-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit 53916d5fd3c0b658de3463439dd2b7ce765072cb ]

Currently we check for bandwidth overflow potentially due to hotplug
operations at the end of sched_cpu_deactivate(), after the cpu going
offline has already been removed from scheduling, active_mask, etc.
This can create issues for DEADLINE tasks, as there is a substantial
race window between the start of sched_cpu_deactivate() and the moment
we possibly decide to roll-back the operation if dl_bw_deactivate()
returns failure in cpuset_cpu_inactive(). An example is a throttled
task that sees its replenishment timer firing while the cpu it was
previously running on is considered offline, but before
dl_bw_deactivate() had a chance to say no and roll-back happened.

Fix this by directly calling dl_bw_deactivate() first thing in
sched_cpu_deactivate() and do the required calculation in the former
function considering the cpu passed as an argument as offline already.

By doing so we also simplify sched_cpu_deactivate(), as there is no need
anymore for any kind of roll-back if we fail early.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     | 22 +++++++---------------
 kernel/sched/deadline.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f823942c9e11a..ed95861e9887c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8182,19 +8182,14 @@ static void cpuset_cpu_active(void)
 	cpuset_update_active_cpus();
 }
 
-static int cpuset_cpu_inactive(unsigned int cpu)
+static void cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_deactivate(cpu);
-
-		if (ret)
-			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
 		partition_sched_domains(1, NULL, NULL);
 	}
-	return 0;
 }
 
 static inline void sched_smt_present_inc(int cpu)
@@ -8256,6 +8251,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	int ret;
 
+	ret = dl_bw_deactivate(cpu);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
@@ -8301,15 +8301,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		return 0;
 
 	sched_update_numa(cpu, false);
-	ret = cpuset_cpu_inactive(cpu);
-	if (ret) {
-		sched_smt_present_inc(cpu);
-		sched_set_rq_online(rq, cpu);
-		balance_push_set(cpu, false);
-		set_cpu_active(cpu, true);
-		sched_update_numa(cpu, true);
-		return ret;
-	}
+	cpuset_cpu_inactive(cpu);
 	sched_domains_numa_masks_clear(cpu);
 	return 0;
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b078014273d9e..b6781ddea7650 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3488,6 +3488,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		}
 		break;
 	case dl_bw_req_deactivate:
+		/*
+		 * cpu is not off yet, but we need to do the math by
+		 * considering it off already (i.e., what would happen if we
+		 * turn cpu off?).
+		 */
+		cap -= arch_scale_cpu_capacity(cpu);
+
 		/*
 		 * cpu is going offline and NORMAL tasks will be moved away
 		 * from it. We can thus discount dl_server bandwidth
@@ -3505,9 +3512,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
-			 * wise thing to do.
+			 * wise thing to do. As said above, cpu is not offline
+			 * yet, so account for that.
 			 */
-			if (dl_bw_cpus(cpu))
+			if (dl_bw_cpus(cpu) - 1)
 				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
 			else
 				overflow = 1;
-- 
2.39.5


