Return-Path: <stable+bounces-62388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AD793EF0A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7441C21B2B
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7612C522;
	Mon, 29 Jul 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efD7HN48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F484A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239523; cv=none; b=HJkp+/YgtCJX2CnxSFismrjH9lbQiktvepMnahU0qGYZy4wTW0NIPK9ZZhPPoDMfWxTNxGZ1faqIKgmf2yoB4ozwRTZD8fsP0lb5uXBGlFdlJ07g8nHiBse/ReOO4XXgnvWn0WIqNBZN+PcSf3YK1/dx4CHJaBQsL9wI2yZ1HFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239523; c=relaxed/simple;
	bh=4XXgWxkzDknpCLvvrtvdccGPhjZgAHYHMy2fQ7SQJPY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MtXdYtCwB4xdF+Lmh3tuf7vvbOK2jymEjjT+SLjBZdqQDATVKOtcOaIEZT2qjPOrMpRn0q3hs91lqY+vTJOUuj0yIK8GEfR7G71Y2U6UfRz0CznK0FGgOmuXxO6E95a66bBNBANFVxW8ctgLM3w5+RrG6C8S55+qAGvAbE7BD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efD7HN48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B999CC32786;
	Mon, 29 Jul 2024 07:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239523;
	bh=4XXgWxkzDknpCLvvrtvdccGPhjZgAHYHMy2fQ7SQJPY=;
	h=Subject:To:Cc:From:Date:From;
	b=efD7HN48GiJhSwAiZSRYY8uhg3DWziB/ucA6xahHnHA/nDi6llm3CT3iuvV+jEOx5
	 pAQrfS/07drmtfVabCzm3tI7wjH04hTmEJE6TCqoB2wJvpIrrlKMA4dE2f4GdYDutH
	 I+XSEllJgUMau5GwXR12VGIagwfs/55/Mq47TBoE=
Subject: FAILED: patch "[PATCH] sched/fair: set_load_weight() must also call reweight_task()" failed to apply to 4.19-stable tree
To: tj@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:51:52 +0200
Message-ID: <2024072951-crimson-ashamed-1d63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d329605287020c3d1c3b0dadc63d8208e7251382
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072951-crimson-ashamed-1d63@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d32960528702 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")
0dacee1bfa70 ("sched/pelt: Remove unused runnable load average")
fe71bbb21ee1 ("sched/fair: calculate delta runnable load only when it's needed")
8de6242cca17 ("sched/debug: Add new tracepoint to track PELT at se level")
ba19f51fcb54 ("sched/debug: Add new tracepoints to track PELT at rq level")
039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
5d299eabea5a ("sched/fair: Add tmp_alone_branch assertion")
23127296889f ("sched/fair: Update scale invariance of PELT")
c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
dfcb245e2848 ("sched: Fix various typos in comments")
1da1843f9f03 ("sched/core: Create task_has_idle_policy() helper")
4a465e3ebbc8 ("sched/fair: Remove setting task's se->runnable_weight during PELT update")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d329605287020c3d1c3b0dadc63d8208e7251382 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 25 Jun 2024 15:29:58 -1000
Subject: [PATCH] sched/fair: set_load_weight() must also call reweight_task()
 for SCHED_IDLE tasks

When a task's weight is being changed, set_load_weight() is called with
@update_load set. As weight changes aren't trivial for the fair class,
set_load_weight() calls fair.c::reweight_task() for fair class tasks.

However, set_load_weight() first tests task_has_idle_policy() on entry and
skips calling reweight_task() for SCHED_IDLE tasks. This is buggy as
SCHED_IDLE tasks are just fair tasks with a very low weight and they would
incorrectly skip load, vlag and position updates.

Fix it by updating reweight_task() to take struct load_weight as idle weight
can't be expressed with prio and making set_load_weight() call
reweight_task() for SCHED_IDLE tasks too when @update_load is set.

Fixes: 9059393e4ec1 ("sched/fair: Use reweight_entity() for set_user_nice()")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org # v4.15+
Link: http://lkml.kernel.org/r/20240624102331.GI31592@noisy.programming.kicks-ass.net

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..747683487be7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1328,27 +1328,24 @@ int tg_nop(struct task_group *tg, void *data)
 void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
-	struct load_weight *load = &p->se.load;
+	struct load_weight lw;
 
-	/*
-	 * SCHED_IDLE tasks get minimal weight:
-	 */
 	if (task_has_idle_policy(p)) {
-		load->weight = scale_load(WEIGHT_IDLEPRIO);
-		load->inv_weight = WMULT_IDLEPRIO;
-		return;
+		lw.weight = scale_load(WEIGHT_IDLEPRIO);
+		lw.inv_weight = WMULT_IDLEPRIO;
+	} else {
+		lw.weight = scale_load(sched_prio_to_weight[prio]);
+		lw.inv_weight = sched_prio_to_wmult[prio];
 	}
 
 	/*
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
-	} else {
-		load->weight = scale_load(sched_prio_to_weight[prio]);
-		load->inv_weight = sched_prio_to_wmult[prio];
-	}
+	if (update_load && p->sched_class == &fair_sched_class)
+		reweight_task(p, &lw);
+	else
+		p->se.load = lw;
 }
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..f205e2482690 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,15 +3835,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
-	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight);
-	load->inv_weight = sched_prio_to_wmult[prio];
+	reweight_entity(cfs_rq, se, lw->weight);
+	load->inv_weight = lw->inv_weight;
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..9ab53435debd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2509,7 +2509,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);


