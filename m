Return-Path: <stable+bounces-19065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78EC84C941
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A3D1F276BB
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782A18AF8;
	Wed,  7 Feb 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bESrqk8y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42B17BD4;
	Wed,  7 Feb 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304209; cv=none; b=gP8XK7fXiSjZ/L6+wMcVxjH7HFNMFgBSwL4gsXG3+L0HO4+onLNsHnAmG6VSwzCLAWsMN9L4oRI/nVg37z9+D9X/1qVUoB0ebc3QSZNOWdjCZwL70nIMHB+ug0JdcAyLX31G8IqXcFOcI2+JcTv3e13TeCl+faQR8rw45e9saN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304209; c=relaxed/simple;
	bh=QGDDFiRLu0F/98O5NrMXrdMlehOelnIMOU3kJPMX74g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WyfkKCXMKuFjixOjcO6qV1raOPLffpe0OluT/wvFeJGrEWUW2JmEPXSkJ0RYXcKFwz0BNnsDdk6/z/Itt775QYnytExkktdCVJuyM2lclNy8Y4z3RaTetudUqKaAg12OUHPnTwnNGXZYQ43eeXW/WKYDOwDWAXR+n1MUtgz3V24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bESrqk8y; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bda4bd14e2so457808b6e.2;
        Wed, 07 Feb 2024 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304206; x=1707909006; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE7wtR9piNj1B9Bs/eMA0RXAOLCFKk3Ra2ncKtbRckI=;
        b=bESrqk8ysY95Fp+PO8MyJJi/mrTX5KToqEtm1+LhXhzdyInlcOWZyM204fJgpNlBH1
         THQWRvb3FePA3NuNpwxWo0Cyg7wAQA5YzTblpLbd5l9M9/y/o6PNzL7i6oh9Pw5gM0q6
         +6X9l7NKcLC6zbhmgZq66RNF2U2xO5APUYPqoNxUqFqYBHd5NrG9wsNIhiwELuawECPV
         Ba1pj9gYu1+DR08UE7jLgL8Eb6xN81IItgfAcAqEKO4DBdvsao9CiFWcsrwTstyWW/lj
         TnCRZrE6XNJhKdw7yFKj4eiC+TuYbbP2Ldw50w8eoERQGlCVNTNx4DRIsBC+EwbP842d
         rAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304206; x=1707909006;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE7wtR9piNj1B9Bs/eMA0RXAOLCFKk3Ra2ncKtbRckI=;
        b=bmKA/f5rsSJWiGNili4SLzadm8rSy5pVpa+BBiPfk422fDa/P565YlsYzHucqfAP+Y
         sZ+URotTwtCltS+KaIGrB6yydhne8/j0KlWJz8ssnhm0VFdLERkZOAuhagTSJ+bAnG6r
         8p6edWuQKsAnqJ1b8mF7jGbfJj4hlLznACCsgvEfGMpuJTHKAfiTsSj6Dobiyrq3fCJk
         7Gc1tGyNU3cKQ5d8HUOAq+y9woxFYPVTrBwJ+YmBhorVbyyxJu3cZSMv+mIn+goohgUv
         m9UUr9p0qW327kozgdJvs6UTWxFWRWVkv9mkj3Adq7o6z3vp5S6x8UIt0pveM7ogvc3f
         90OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwflLZfWdnns9S+p+UoF9c/vQKt1aBo4S9qRETMREVaKA0OqnYApB2TfISLdxul14RPW1BQpv8cjzSf8eOnaJ9dct2LUsg
X-Gm-Message-State: AOJu0YwL41xHYKw2mZ4IWbAZoTjr2lSimdEiCWS0Rsy01Wad24ywuB4y
	Bz32QPyCT9bI8Ow2ZdjzFBRAyF8K95qbhjSxoniolkbkkuU80kN3CXUF03cIZD4=
X-Google-Smtp-Source: AGHT+IER295jDBh8TIaFeeSC3WtvxqYaDBOBfYOw3NNtNrRFpf4XUl+8ihPT3xKkHmwS2HZ+CRb7ow==
X-Received: by 2002:aca:1b1a:0:b0:3bf:e05b:e29b with SMTP id b26-20020aca1b1a000000b003bfe05be29bmr4865779oib.35.1707304206553;
        Wed, 07 Feb 2024 03:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0Eq4GsACfZEQdoS+qcUckPYy2BiwDVDirRaFIesSYE8YHvksRnNvITGoE6X7Yr4v7u/9tTHMpD7PeT+epG2ZiLCNerN/N9A5Xn8L5dCpxgdSBnLCUdsevHSCfkNs2P3Ai0VZC/61WbyQ8qJ6Ykpwpxz8uB0ZieMe7JYPkXFtPPKQ3U91UKY2b03kyiMetg3Wl2X3H4shexR5plnAnnbzrV2hjyZ5Vv1kBYx8vEGU=
Received: from localhost.localdomain ([120.244.140.254])
        by smtp.gmail.com with ESMTPSA id u2-20020a056a00098200b006dde1337d31sm1223906pfg.186.2024.02.07.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:10:05 -0800 (PST)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	joel@joelfernandes.org,
	gregkh@linuxfoundation.org,
	chenzhongjin@huawei.com
Cc: rcu@vger.kernel.org,
	stable@vger.kernel.org,
	qiang.zhang1211@gmail.com
Subject: [PATCH] linux-5.10/rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
Date: Wed,  7 Feb 2024 19:09:51 +0800
Message-Id: <20240207110951.27831-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Paul E. McKenney <paulmck@kernel.org>

commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.

Holding a mutex across synchronize_rcu_tasks() and acquiring
that same mutex in code called from do_exit() after its call to
exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
results in deadlock.  This is by design, because tasks that are far
enough into do_exit() are no longer present on the tasks list, making
it a bit difficult for RCU Tasks to find them, let alone wait on them
to do a voluntary context switch.  However, such deadlocks are becoming
more frequent.  In addition, lockdep currently does not detect such
deadlocks and they can be difficult to reproduce.

In addition, if a task voluntarily context switches during that time
(for example, if it blocks acquiring a mutex), then this task is in an
RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
just as well take advantage of that fact.

This commit therefore eliminates these deadlock by replacing the
SRCU-based wait for do_exit() completion with per-CPU lists of tasks
currently exiting.  A given task will be on one of these per-CPU lists for
the same period of time that this task would previously have been in the
previous SRCU read-side critical section.  These lists enable RCU Tasks
to find the tasks that have already been removed from the tasks list,
but that must nevertheless be waited upon.

The RCU Tasks grace period gathers any of these do_exit() tasks that it
must wait on, and adds them to the list of holdouts.  Per-CPU locking
and get_task_struct() are used to synchronize addition to and removal
from these lists.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 include/linux/sched.h |  1 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  1 +
 kernel/rcu/tasks.h    | 54 ++++++++++++++++++++++++++++---------------
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa015416c569..80499f7ab39a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -740,6 +740,7 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	struct list_head                rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/init/init_task.c b/init/init_task.c
index 5fa18ed59d33..59454d6e2c2a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -151,6 +151,7 @@ struct task_struct init_task
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
diff --git a/kernel/fork.c b/kernel/fork.c
index 633b0af1d1a7..86803165aa00 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1699,6 +1699,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c5624ab0580c..901cd7bc78ed 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -81,9 +81,6 @@ static struct rcu_tasks rt_name =					\
 	.kname = #rt_name,						\
 }
 
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
-
 /* Avoid IPIing CPUs early in the grace period. */
 #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
@@ -383,6 +380,9 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
 
+static LIST_HEAD(rtp_exit_list);
+static DEFINE_RAW_SPINLOCK(rtp_exit_list_lock);
+
 /* Pre-grace-period preparation. */
 static void rcu_tasks_pregp_step(void)
 {
@@ -416,15 +416,18 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	unsigned long flags;
+	struct task_struct *t;
+
 	/*
 	 * Exiting tasks may escape the tasklist scan. Those are vulnerable
 	 * until their final schedule() with TASK_DEAD state. To cope with
 	 * this, divide the fragile exit path part in two intersecting
 	 * read side critical sections:
 	 *
-	 * 1) An _SRCU_ read side starting before calling exit_notify(),
-	 *    which may remove the task from the tasklist, and ending after
-	 *    the final preempt_disable() call in do_exit().
+	 * 1) A task_struct list addition before calling exit_notify(),
+	 *    which may remove the task from the tasklist, with the
+	 *    removal after the final preempt_disable() call in do_exit().
 	 *
 	 * 2) An _RCU_ read side starting with the final preempt_disable()
 	 *    call in do_exit() and ending with the final call to schedule()
@@ -433,7 +436,12 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * This handles the part 1). And postgp will handle part 2) with a
 	 * call to synchronize_rcu().
 	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+	list_for_each_entry(t, &rtp_exit_list, rcu_tasks_exit_list) {
+		if (list_empty(&t->rcu_tasks_holdout_list))
+			rcu_tasks_pertask(t, hop);
+	}
+	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
 }
 
 /* See if tasks are still holding out, complain if so. */
@@ -498,7 +506,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	 *
 	 * In addition, this synchronize_rcu() waits for exiting tasks
 	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
 	 * enforcing the whole region before tasklist removal until
 	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
 	 * read side critical section.
@@ -591,25 +598,36 @@ static void show_rcu_tasks_classic_gp_kthread(void)
 #endif /* #ifndef CONFIG_TINY_RCU */
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Protect against tasklist scan blind spot while the task is exiting and
+ * may be removed from the tasklist.  Do this by adding the task to yet
+ * another list.
  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_start(void)
 {
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	unsigned long flags;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
+	get_task_struct(t);
+	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+	list_add(&t->rcu_tasks_exit_list, &rtp_exit_list);
+	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
 }
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Remove the task from the "yet another list" because do_exit() is now
+ * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_stop(void)
 {
+	unsigned long flags;
 	struct task_struct *t = current;
 
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
+	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
+	put_task_struct(t);
 }
 
 /*
-- 
2.17.1


