Return-Path: <stable+bounces-110483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C72A1C94D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D131888664
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870281D61B5;
	Sun, 26 Jan 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNlZJdlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E651D61A1;
	Sun, 26 Jan 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903031; cv=none; b=Q2kn4jg/PCyqy0FsySOyjVAAjwwZvfnvuvvuRFw+qNhsQFUK1FaS9vHl3GpN/VEqYLSq7v0UUiE/8tePt+EToOPbBG/I6/DWtbTgtrMDkNH1FQG4rThEethwZb5ZEYfM5VGRjZwSuau4+sW17IHt1wgWyeKYZrKDOwPvbwB4UQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903031; c=relaxed/simple;
	bh=bkgMEZHfMyBTSjenIv0WjdCUzz1m4C1D2r/uDQoJkAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APMBG0eWRBhtH7jxTQVhEmtb55jpYmALBs5uVPycj4ObqGIIR8U+DNGldMvdm3eM1xBfcAv5jIWWLGC6PNBDf6RJO7kL23aJwE55388uf4YvzbWN1UQ9C8VxDv5fn1BFoKPljjMs+mp/bwGYpemyrPAM1WqllVHab+HLrYauNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNlZJdlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B3DC4CED3;
	Sun, 26 Jan 2025 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903031;
	bh=bkgMEZHfMyBTSjenIv0WjdCUzz1m4C1D2r/uDQoJkAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNlZJdlVcV7ADE58q+g0p8mMbsAzvgvt0Tz4NiDpQUHFm4zR+oihLB+JTIhc59tDo
	 udo973XaMnSVvoFzgufTrXivr4QJhP/blvbpgi10RB616QY7qU1yw2pHxySsdlLNvM
	 pA/T8S8Kw6211KffebHQKgSAoZrnECSXAkBIWq08/SlmNmKG5H7Xzk1o3THUTV3YQi
	 lxjucSuRDvFYp9P7Rp32O34jOiF1Gu3mSsQoI2upkpozX+DTzIe+siuBoa2Oe1WPQa
	 zk9iuDwGxLVCJAjI0TZWWfMsbcAiS4nakAGOzaRBLfT0tfn2Mw/CbuapHETmcx4qEp
	 714iI8u2MOxtg==
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
Subject: [PATCH AUTOSEL 6.12 2/7] sched/deadline: Correctly account for allocated bandwidth during hotplug
Date: Sun, 26 Jan 2025 09:50:21 -0500
Message-Id: <20250126145027.925851-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145027.925851-1-sashal@kernel.org>
References: <20250126145027.925851-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit d4742f6ed7ea6df56e381f82ba4532245fa1e561 ]

For hotplug operations, DEADLINE needs to check that there is still enough
bandwidth left after removing the CPU that is going offline. We however
fail to do so currently.

Restore the correct behavior by restructuring dl_bw_manage() a bit, so
that overflow conditions (not enough bandwidth left) are properly
checked. Also account for dl_server bandwidth, i.e. discount such
bandwidth in the calculation since NORMAL tasks will be anyway moved
away from the CPU as a result of the hotplug operation.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20241114142810.794657-3-juri.lelli@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 48 +++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h    |  2 +-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9015c792830c2..7bac05aa3d6c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8081,7 +8081,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_check_overflow(cpu);
+		int ret = dl_bw_deactivate(cpu);
 
 		if (ret)
 			return ret;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a17c23b53049c..36fd501ad9958 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3464,29 +3464,31 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 }
 
 enum dl_bw_request {
-	dl_bw_req_check_overflow = 0,
+	dl_bw_req_deactivate = 0,
 	dl_bw_req_alloc,
 	dl_bw_req_free
 };
 
 static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags;
+	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
+	u64 fair_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
 
-	if (req == dl_bw_req_free) {
+	cap = dl_bw_capacity(cpu);
+	switch (req) {
+	case dl_bw_req_free:
 		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
-	} else {
-		unsigned long cap = dl_bw_capacity(cpu);
-
+		break;
+	case dl_bw_req_alloc:
 		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
 
-		if (req == dl_bw_req_alloc && !overflow) {
+		if (!overflow) {
 			/*
 			 * We reserve space in the destination
 			 * root_domain, as we can't fail after this point.
@@ -3495,6 +3497,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 			 */
 			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
 		}
+		break;
+	case dl_bw_req_deactivate:
+		/*
+		 * cpu is going offline and NORMAL tasks will be moved away
+		 * from it. We can thus discount dl_server bandwidth
+		 * contribution as it won't need to be servicing tasks after
+		 * the cpu is off.
+		 */
+		if (cpu_rq(cpu)->fair_server.dl_server)
+			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+
+		/*
+		 * Not much to check if no DEADLINE bandwidth is present.
+		 * dl_servers we can discount, as tasks will be moved out the
+		 * offlined CPUs anyway.
+		 */
+		if (dl_b->total_bw - fair_server_bw > 0) {
+			/*
+			 * Leaving at least one CPU for DEADLINE tasks seems a
+			 * wise thing to do.
+			 */
+			if (dl_bw_cpus(cpu))
+				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+			else
+				overflow = 1;
+		}
+
+		break;
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -3503,9 +3533,9 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	return overflow ? -EBUSY : 0;
 }
 
-int dl_bw_check_overflow(int cpu)
+int dl_bw_deactivate(int cpu)
 {
-	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
 }
 
 int dl_bw_alloc(int cpu, u64 dl_bw)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f2ef520513c4a..0a8ed2948e5e0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -362,7 +362,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_bw_check_overflow(int cpu);
+extern int  dl_bw_deactivate(int cpu);
 extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec);
 /*
  * SCHED_DEADLINE supports servers (nested scheduling) with the following
-- 
2.39.5


