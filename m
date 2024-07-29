Return-Path: <stable+bounces-62387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4093EF09
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A931C21B65
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AA12C522;
	Mon, 29 Jul 2024 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7+iqaWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3684A2F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239514; cv=none; b=ahD/Ronm+j3KuJ5eVyqZI6EwaodOwP9p7fDK2MD2JEoSzMxBdBIaPefSjI2CCqpGqV/sIh31VFluHpg/qhFniTInWttkXy1D3ZurIgOGaxBDEN4ByhgGC2+foqXd+xXXgKN8zZ8DSJ7V1IT7t0aCJw5XfkZTBNRx7aOElXGIBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239514; c=relaxed/simple;
	bh=aw5/HWggUmAQi2sGBuIECjtj5Lgei3Z/WGnzY4tVbdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ims1Egs80kMEyhSdsNOV+oB3crirw426XptZkLGpqndCHBd5loBHjhFPHjsXGQ6WGRjFf6c1OGcX35HUfq+BxvqkntavG5sSTZcAKRWAWWIv5EPJst1gz36qq4JHjAN1sm9YNDIRlnfdC8BPloeh8mFr+SiY7xXwS9MEewapujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7+iqaWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC811C32786;
	Mon, 29 Jul 2024 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239514;
	bh=aw5/HWggUmAQi2sGBuIECjtj5Lgei3Z/WGnzY4tVbdg=;
	h=Subject:To:Cc:From:Date:From;
	b=b7+iqaWQDd/BMhZQAuavfYCz0RDmmsAR9Iru9BLSKAQYTMjR58rD9Di7tim4XrEQ2
	 J5fbLYkG7GfNvEBudZHiJmaOQ/bW5vwiAp4DVTArWmNrHkph29FdEl+BFG6LUF5Io8
	 FVvLJQIw51awumnMokp/ARKDxszM2sv0WQR5UBJ0=
Subject: FAILED: patch "[PATCH] sched/fair: set_load_weight() must also call reweight_task()" failed to apply to 5.4-stable tree
To: tj@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:51:50 +0200
Message-ID: <2024072950-swab-uncharted-cf85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d329605287020c3d1c3b0dadc63d8208e7251382
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072950-swab-uncharted-cf85@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d32960528702 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")
0dacee1bfa70 ("sched/pelt: Remove unused runnable load average")
fe71bbb21ee1 ("sched/fair: calculate delta runnable load only when it's needed")

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


