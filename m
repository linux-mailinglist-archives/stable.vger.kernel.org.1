Return-Path: <stable+bounces-177578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4426B417FA
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991335E203C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69B2EBB81;
	Wed,  3 Sep 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yYhhpIlf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KjdlbL2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3C2EA177;
	Wed,  3 Sep 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886720; cv=none; b=Rku/uuzEwAS2k+aoXyk29tKJtSOUhj1Sxs+HpMYEubmysixj1c2GeUwconigwCtNKMmffMnlCXSLcMbu/F7+cGZeomKiKXbLISmKZg5vCNK65k9y0ik9ZU6pEHvBkYbg8gU0Uqj939fIxxvWFTNWnGAYOqkl+HRmOjU1lJ7r3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886720; c=relaxed/simple;
	bh=vAKMzthvTmNzP83D+Oo4xnVUd1DxYI3MOi0i/ReSx+U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k08fkBy0nmiJe9viJygqIOyeB0G6iWJcztxHWX+MRM4ydIGUWAcZMJQI/kTfClSpOUDqVdOXmFwRCEVUVbS5+hmBoUAcfyGJJp/O3p7P3mY592/F8M6cDcl/qZaQZfDBmgzKcqrq1Rfn/4FUR4CxTxXigMoWTKICDMzhhIxyRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yYhhpIlf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KjdlbL2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rdgIMEA4RB3bTpHF1svAS5TamVoQVCAqRA+g/XO6+8=;
	b=yYhhpIlfadJAhHkOM9LsfNIAdAZki8fbXWzfeUqYRfuLPjzg/LK2NaEC3fA9LAi2k4HZe2
	73nFOmdxHIrNRyKP6Ci84XACF8zHRO0DdbNIBXXeqABoYw40mPPaa7bVjlNsGPmMXITCHR
	8E4g95/VkWu3Ilalqm8oHQPjxb2TBfL6unsZuMhw2mDFuYCiAMzyPxw+krELHmJbkmjTsx
	CsD5N16uV2lTjk9pU0FYxmKXBB6bezC4vUesHADqQClpjbX/V7RmknoA+EtEW9LK6e20Ur
	D6PdNMtg+mtEgmsjR2syQeD99ciEyjRt3QhPNUTJaD6pk1cuoPLR5lxzShq31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rdgIMEA4RB3bTpHF1svAS5TamVoQVCAqRA+g/XO6+8=;
	b=5KjdlbL2nSbuoUUknNPcN/TTks05HIzqhVYYHIPCE+J1eVh0wVldYSkosAybDFc97uGJRq
	14M5Gs5NhTbgGlAA==
From: "tip-bot2 for Harshit Agarwal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix race in push_dl_task()
Cc: Harshit Agarwal <harshit@nutanix.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250408045021.3283624-1-harshit@nutanix.com>
References: <20250408045021.3283624-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688671542.1920.13477788815006763572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8fd5485fb4f3d9da3977fd783fcb8e5452463420
Gitweb:        https://git.kernel.org/tip/8fd5485fb4f3d9da3977fd783fcb8e54524=
63420
Author:        Harshit Agarwal <harshit@nutanix.com>
AuthorDate:    Tue, 08 Apr 2025 04:50:21=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:12 +02:00

sched/deadline: Fix race in push_dl_task()

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
---
 kernel/sched/deadline.c | 73 ++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f253012..5b64bc6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2580,6 +2580,25 @@ static int find_later_rq(struct task_struct *task)
 	return -1;
 }
=20
+static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_dl_tasks(rq))
+		return NULL;
+
+	p =3D __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
+
+	WARN_ON_ONCE(rq->cpu !=3D task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <=3D 1);
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
@@ -2607,12 +2626,37 @@ static struct rq *find_lock_later_rq(struct task_stru=
ct *task, struct rq *rq)
=20
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
-			if (unlikely(task_rq(task) !=3D rq ||
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
+				      (task_rq(task) !=3D rq ||
+				       task_on_cpu(rq, task) ||
+				       !dl_task(task) ||
+				       !task_on_rq_queued(task))) ||
+				     (!task->dl.dl_throttled &&
+				      task !=3D pick_next_pushable_dl_task(rq)))) {
+
 				double_unlock_balance(rq, later_rq);
 				later_rq =3D NULL;
 				break;
@@ -2635,25 +2679,6 @@ static struct rq *find_lock_later_rq(struct task_struc=
t *task, struct rq *rq)
 	return later_rq;
 }
=20
-static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
-{
-	struct task_struct *p;
-
-	if (!has_pushable_dl_tasks(rq))
-		return NULL;
-
-	p =3D __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
-
-	WARN_ON_ONCE(rq->cpu !=3D task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <=3D 1);
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

