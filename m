Return-Path: <stable+bounces-186470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF43BE971E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B33E1A66476
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2620132E156;
	Fri, 17 Oct 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ip0lmH3g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4636CDE8;
	Fri, 17 Oct 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713334; cv=none; b=Vo+e69mXpu9b0Nth5tx8FkGZNPS40GeR7jZDC6oCXdFHfjucwaWvIrsdJI9pc7KFPSVA2mI55Y8OysoLh0pFqpKWrqpWiYiCMFF3r2KAvYPns8xs64GSL/9s+gMgBA1PWs+aSMYPRzWSlDeb4f6v0CJxrYZzHntPO8QoM5XGCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713334; c=relaxed/simple;
	bh=bi3kwH8Aaud1UiuVf7CqGSPvHfcxbgvzTJtZ2kS3qjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB0oCRlsNJ1LD5ZI3GMk6exXdAkggUrRxeBmITopMCxrlFpYNy4wsDX1jtl/3C8DcJxI1J5qjbUz18bDDBP3nbSYWSaqj0vQJLQkmd6Ko28Q7UiVScCCfbAw5TZKTksL8D5ZrPt7tbmHvS8tf0WV+TQFMr/NDEW6uBndhjd4Low=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ip0lmH3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F61C4CEE7;
	Fri, 17 Oct 2025 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713334;
	bh=bi3kwH8Aaud1UiuVf7CqGSPvHfcxbgvzTJtZ2kS3qjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ip0lmH3gheOVOxiFK4h3u6+Hq5IPzFbWUMNrZccZ55+QcFARz2mUGgDhKHCPEWOgx
	 Ku/WsLlWIskIfR4Na2oCq8VRg7vwsEjjGza8Nq7xULghL56gvsAzU2hHJZu2CwGCHz
	 4dLWJPryXz5xodkzC28YMF/JJ3PyfczAr3S9J9j4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harshit Agarwal <harshit@nutanix.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.1 096/168] sched/deadline: Fix race in push_dl_task()
Date: Fri, 17 Oct 2025 16:52:55 +0200
Message-ID: <20251017145132.563747660@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Agarwal <harshit@nutanix.com>

commit 8fd5485fb4f3d9da3977fd783fcb8e5452463420 upstream.

When a CPU chooses to call push_dl_task and picks a task to push to
another CPU's runqueue then it will call find_lock_later_rq method
which would take a double lock on both CPUs' runqueues. If one of the
locks aren't readily available, it may lead to dropping the current
runqueue lock and reacquiring both the locks at once. During this window
it is possible that the task is already migrated and is running on some
other CPU. These cases are already handled. However, if the task is
migrated and has already been executed and another CPU is now trying to
wake it up (ttwu) such that it is queued again on the runqeue
(on_rq is 1) and also if the task was run by the same CPU, then the
current checks will pass even though the task was migrated out and is no
longer in the pushable tasks list.
Please go through the original rt change for more details on the issue.

To fix this, after the lock is obtained inside the find_lock_later_rq,
it ensures that the task is still at the head of pushable tasks list.
Also removed some checks that are no longer needed with the addition of
this new check.
However, the new check of pushable tasks list only applies when
find_lock_later_rq is called by push_dl_task. For the other caller i.e.
dl_task_offline_migration, existing checks are used.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250408045021.3283624-1-harshit@nutanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/deadline.c |   73 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 24 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2217,6 +2217,25 @@ static int find_later_rq(struct task_str
 	return -1;
 }
 
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
+
+	return p;
+}
+
 /* Locks the rq it finds */
 static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 {
@@ -2244,12 +2263,37 @@ static struct rq *find_lock_later_rq(str
 
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) != rq ||
+			/*
+			 * double_lock_balance had to release rq->lock, in the
+			 * meantime, task may no longer be fit to be migrated.
+			 * Check the following to ensure that the task is
+			 * still suitable for migration:
+			 * 1. It is possible the task was scheduled,
+			 *    migrate_disabled was set and then got preempted,
+			 *    so we must check the task migration disable
+			 *    flag.
+			 * 2. The CPU picked is in the task's affinity.
+			 * 3. For throttled task (dl_task_offline_migration),
+			 *    check the following:
+			 *    - the task is not on the rq anymore (it was
+			 *      migrated)
+			 *    - the task is not on CPU anymore
+			 *    - the task is still a dl task
+			 *    - the task is not queued on the rq anymore
+			 * 4. For the non-throttled task (push_dl_task), the
+			 *    check to ensure that this task is still at the
+			 *    head of the pushable tasks list is enough.
+			 */
+			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_on_cpu(rq, task) ||
-				     !dl_task(task) ||
-				     is_migration_disabled(task) ||
-				     !task_on_rq_queued(task))) {
+				     (task->dl.dl_throttled &&
+				      (task_rq(task) != rq ||
+				       task_on_cpu(rq, task) ||
+				       !dl_task(task) ||
+				       !task_on_rq_queued(task))) ||
+				     (!task->dl.dl_throttled &&
+				      task != pick_next_pushable_dl_task(rq)))) {
+
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
 				break;
@@ -2272,25 +2316,6 @@ static struct rq *find_lock_later_rq(str
 	return later_rq;
 }
 
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu != task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
-
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
-
-	return p;
-}
-
 /*
  * See if the non running -deadline tasks on this rq
  * can be sent to some other CPU where they can preempt



