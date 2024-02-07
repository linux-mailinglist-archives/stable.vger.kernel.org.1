Return-Path: <stable+bounces-19064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30A84C940
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CDB1F27862
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB5199B4;
	Wed,  7 Feb 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVld9eVk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4B1D522;
	Wed,  7 Feb 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304176; cv=none; b=GAcDJDx0cSZSC8RRPRCPk8ed+aIrajC6iFRIpUJY4CRCzo05ykJ0mXXkEIsMQqkfuRteXOd0hOz99SbxGJnbLHXAI5aoq7tOWMYsL01HajNt4F7hFhj4ll9VlYYvyVnK/MO0/w3ur67gutQ8g/HbJwnJAlmYFULtbLi7/bAr/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304176; c=relaxed/simple;
	bh=w8IEyZYgI+PlGkveewllJkxeD/SQ1nwitaxnspS5aag=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Y0OnCbPWhQJCRtpfIy3j55l64kno3JU9f3gZhc48i8Rfc04HMxOPyrAbjMe7ycDnLCV0r735KXC5yV1rbIModpX1gmlzzPCRdMj1SKuXqTMpI4NxBXX2dRukDYv/voNvFxeXu9RuJoi8DHa5paGymSZfHr8yGxlpF2slkiKnPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVld9eVk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8df34835aso404371a12.0;
        Wed, 07 Feb 2024 03:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707304173; x=1707908973; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSl+NodxA/S/Pr7QXlyQqY5IrblTGYv36N9WC5Iz9bs=;
        b=TVld9eVkGbcstcfR2S0GjARiHna8eGb0LVEgIlo9pAVV+dPOjxIRaBGIWkoBuplpsD
         6gDkd1tB3jMgskKsTFUIDjwcxUwgobkFOrsgcv7Rcwhly0KGKph3hGX30qsSUKWjW8qk
         lD6zfokzp3zlUNsp4HyHYpNWbLaF0Iuol2HHlcxkRVetWwwH5k0Va7vr8zvl2DIAbb8Z
         cup4nUwnmsN+bReAXxwa9+UlyCPiotwCy1k/Ns7NLk0lcWYUOWgrvENpPKtVl2Pfskh6
         PTFg8ZmQGMELhnV9FdBjuRik5U8jD5YU1qXlbQ9mKp5aKpbTz3cVHNZ4wLwhKDMpfmko
         j98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707304173; x=1707908973;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSl+NodxA/S/Pr7QXlyQqY5IrblTGYv36N9WC5Iz9bs=;
        b=cW4KdM4eL0Ru7N0GPH9NWeuM7lnoYfujdmRHflDpAYTfmt3e8t3TyrmeLMjcusWssA
         Lq6pJIqQdjVedzNka/tLt/xaPEUrvWOi+09Q3XvDlxfv5Cw39VT9JIfWvZNK/cfddf08
         xUcH/PLu31oHEPGrvIb0JziaG/hylvbyhHhd4dlCcjlNuC4CVyBU95gPPB44bUJBM25l
         585GMplp1ai1mn+QLchJwtJA39eeyQrlV5iPLK52f2+UdGxNJomApxWznDNExMefWZ1n
         5u7xCrkO3DB3AC2WexV2zwAW7bzA4tMswHblg0qTvpYTB0RCE0YKCrpDu4jnN9a/h/0n
         owtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzyXaZy1cqjUkCqWC2pOr3ncFqYArKhUdoYSHw3TJ/11sDsMX5HZMrZwWpjk5MHBXiudwZ1hZhz/vZLAg/ShyKr844A8aP
X-Gm-Message-State: AOJu0YwpQL/zMv0nSWTBWY63kq3nRKokItkRnhF1UX+O5nanknCnnldk
	0PU8+VwBXEfgggEKZOkA0cYwlC0k67owwBb+j4PsdT6Y8IfmMwQo
X-Google-Smtp-Source: AGHT+IGD4jMRQuxMXkhEMGe7RvY0Ffe6vAj8HgzJkuThxpa0fJu+l4r4U4nZVGFZhCgx6DmV9yRr8A==
X-Received: by 2002:a05:6a20:d48e:b0:19e:a637:6162 with SMTP id im14-20020a056a20d48e00b0019ea6376162mr1782620pzb.26.1707304172518;
        Wed, 07 Feb 2024 03:09:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ3EHD7Ds81swo/q2/AYJZJABKwyL975Wze4JdJDxPpHlw69huF8QTPxbA0vX2ry+xj0mM/MqnO/zNuZl1mFqXETkuw3otf/p/24E8rN9JIgZReiGDKiyA3Jzcf6NLTlbQGlo6yjLLjW2RgLVLB9LXcAskUOddz3NqsUHzwS8LSIBiQUuxdQk12ySTLrhYmfgmFVzlEHRSJOJWPJVcFJgvo+p+BB4P4bEjj54wLQY=
Received: from localhost.localdomain ([120.244.140.254])
        by smtp.gmail.com with ESMTPSA id ka5-20020a056a00938500b006e0381923f9sm1277675pfb.143.2024.02.07.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 03:09:32 -0800 (PST)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	joel@joelfernandes.org,
	gregkh@linuxfoundation.org,
	chenzhongjin@huawei.com
Cc: rcu@vger.kernel.org,
	stable@vger.kernel.org,
	qiang.zhang1211@gmail.com
Subject: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
Date: Wed,  7 Feb 2024 19:08:46 +0800
Message-Id: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
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
 kernel/rcu/update.c   | 65 ++++++++++++++++++++++++++++++-------------
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fd4899236037..0b555d8e9d5e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -679,6 +679,7 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	struct list_head                rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index 994ffe018120..f741cbfd891c 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -139,6 +139,7 @@ struct task_struct init_task
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
diff --git a/kernel/fork.c b/kernel/fork.c
index b65871600507..d416d16df62f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1626,6 +1626,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 }
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 81688a133552..5227cb5c1bea 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -527,7 +527,8 @@ static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
 static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
 
 /* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
+static LIST_HEAD(rtp_exit_list);
+static DEFINE_RAW_SPINLOCK(rtp_exit_list_lock);
 
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
@@ -661,6 +662,17 @@ static void check_holdout_task(struct task_struct *t,
 	sched_show_task(t);
 }
 
+static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
+{
+	if (t != current && READ_ONCE(t->on_rq) &&
+			!is_idle_task(t)) {
+		get_task_struct(t);
+		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+		WRITE_ONCE(t->rcu_tasks_holdout, true);
+		list_add(&t->rcu_tasks_holdout_list, hop);
+	}
+}
+
 /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
@@ -726,14 +738,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 */
 		rcu_read_lock();
 		for_each_process_thread(g, t) {
-			if (t != current && READ_ONCE(t->on_rq) &&
-			    !is_idle_task(t)) {
-				get_task_struct(t);
-				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-				WRITE_ONCE(t->rcu_tasks_holdout, true);
-				list_add(&t->rcu_tasks_holdout_list,
-					 &rcu_tasks_holdouts);
-			}
+			rcu_tasks_pertask(t, &rcu_tasks_holdouts);
 		}
 		rcu_read_unlock();
 
@@ -744,8 +749,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * where they have disabled preemption, allowing the
 		 * later synchronize_sched() to finish the job.
 		 */
-		synchronize_srcu(&tasks_rcu_exit_srcu);
-
+		raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+		list_for_each_entry(t, &rtp_exit_list, rcu_tasks_exit_list) {
+			if (list_empty(&t->rcu_tasks_holdout_list))
+				rcu_tasks_pertask(t, &rcu_tasks_holdouts);
+		}
+		raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
 		/*
 		 * Each pass through the following loop scans the list
 		 * of holdout tasks, removing any that are no longer
@@ -802,8 +811,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 *
 		 * In addition, this synchronize_sched() waits for exiting
 		 * tasks to complete their final preempt_disable() region
-		 * of execution, cleaning up after the synchronize_srcu()
-		 * above.
+		 * of execution.
 		 */
 		synchronize_sched();
 
@@ -834,20 +842,39 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+/*
+ * Protect against tasklist scan blind spot while the task is exiting and
+ * may be removed from the tasklist.  Do this by adding the task to yet
+ * another list.
+ */
 void exit_tasks_rcu_start(void)
 {
+	unsigned long flags;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
+	get_task_struct(t);
 	preempt_disable();
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+	list_add(&t->rcu_tasks_exit_list, &rtp_exit_list);
+	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
 	preempt_enable();
 }
 
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+/*
+ * Remove the task from the "yet another list" because do_exit() is now
+ * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
+ */
 void exit_tasks_rcu_finish(void)
 {
-	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
-	preempt_enable();
+	unsigned long flags;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
+	raw_spin_lock_irqsave(&rtp_exit_list_lock, flags);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_irqrestore(&rtp_exit_list_lock, flags);
+	put_task_struct(t);
 }
 
 #endif /* #ifdef CONFIG_TASKS_RCU */
-- 
2.17.1


