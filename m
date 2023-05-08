Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27B6FAE68
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjEHLoe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbjEHLoO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF43CD9C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2285C6216E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173EBC433D2;
        Mon,  8 May 2023 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546214;
        bh=bikC4lPE0OXTRkmshnXGw3uVqeoIm2PX5Du9TDYgYa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdIuEZ3/wrnYdQoTPVBi+LV1jBKEUNj8RL8wT8A/+jUWZql97MjJm9ZxGdIICzW0e
         FsVk8g7c0mZCXlNfHvpb0zamR7GuVyRg5+R4bWBiY/LyNRJblwPLxNG7VZQTuxye4h
         3ZBGb5vPFeRiRANIvM9Qi+SEhNDMnLpwcOrDLm2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imran Khan <imran.f.khan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 295/371] workqueue: Introduce show_one_worker_pool and show_one_workqueue.
Date:   Mon,  8 May 2023 11:48:16 +0200
Message-Id: <20230508094823.738091132@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Imran Khan <imran.f.khan@oracle.com>

[ Upstream commit 55df0933be74bd2e52aba0b67eb743ae0feabe7e ]

Currently show_workqueue_state shows the state of all workqueues and of
all worker pools. In certain cases we may need to dump state of only a
specific workqueue or worker pool. For example in destroy_workqueue we
only need to show state of the workqueue which is getting destroyed.

So rename show_workqueue_state to show_all_workqueues(to signify it
dumps state of all busy workqueues) and divide it into more granular
functions (show_one_workqueue and show_one_worker_pool), that would show
states of individual workqueues and worker pools and can be used in
cases such as the one mentioned above.

Also, as mentioned earlier, make destroy_workqueue dump data pertaining
to only the workqueue that is being destroyed and make user(s) of
earlier interface(show_workqueue_state), use new interface
(show_all_workqueues).

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 335a42ebb0ca ("workqueue: Fix hung time report of worker pools")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/sysrq.c       |   2 +-
 include/linux/workqueue.h |   3 +-
 kernel/power/process.c    |   2 +-
 kernel/workqueue.c        | 172 +++++++++++++++++++++-----------------
 4 files changed, 100 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6b445ece83395..4ffed77f80018 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -301,7 +301,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 static void sysrq_handle_showstate(int key)
 {
 	show_state();
-	show_workqueue_state();
+	show_all_workqueues();
 }
 static const struct sysrq_key_op sysrq_showstate_op = {
 	.handler	= sysrq_handle_showstate,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 74d3c1efd9bb5..7fee9b6cfedef 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -469,7 +469,8 @@ extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
-extern void show_workqueue_state(void);
+extern void show_all_workqueues(void);
+extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
 /**
diff --git a/kernel/power/process.c b/kernel/power/process.c
index ee78a39463e63..11b570fcf0494 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -94,7 +94,7 @@ static int try_to_freeze_tasks(bool user_only)
 		       todo - wq_busy, wq_busy);
 
 		if (wq_busy)
-			show_workqueue_state();
+			show_all_workqueues();
 
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f5fa7be8d17ea..de6463b931762 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -375,6 +375,7 @@ EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
+static void show_one_worker_pool(struct worker_pool *pool);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
@@ -4454,7 +4455,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 			raw_spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
 			mutex_unlock(&wq_pool_mutex);
-			show_workqueue_state();
+			show_one_workqueue(wq);
 			return;
 		}
 		raw_spin_unlock_irq(&pwq->pool->lock);
@@ -4804,97 +4805,116 @@ static void show_pwq(struct pool_workqueue *pwq)
 }
 
 /**
- * show_workqueue_state - dump workqueue state
- *
- * Called from a sysrq handler or try_to_freeze_tasks() and prints out
- * all busy workqueues and pools.
+ * show_one_workqueue - dump state of specified workqueue
+ * @wq: workqueue whose state will be printed
  */
-void show_workqueue_state(void)
+void show_one_workqueue(struct workqueue_struct *wq)
 {
-	struct workqueue_struct *wq;
-	struct worker_pool *pool;
+	struct pool_workqueue *pwq;
+	bool idle = true;
 	unsigned long flags;
-	int pi;
-
-	rcu_read_lock();
 
-	pr_info("Showing busy workqueues and worker pools:\n");
-
-	list_for_each_entry_rcu(wq, &workqueues, list) {
-		struct pool_workqueue *pwq;
-		bool idle = true;
-
-		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				idle = false;
-				break;
-			}
+	for_each_pwq(pwq, wq) {
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+			idle = false;
+			break;
 		}
-		if (idle)
-			continue;
+	}
+	if (idle) /* Nothing to print for idle workqueue */
+		return;
 
-		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
+	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
-		for_each_pwq(pwq, wq) {
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				/*
-				 * Defer printing to avoid deadlocks in console
-				 * drivers that queue work while holding locks
-				 * also taken in their write paths.
-				 */
-				printk_deferred_enter();
-				show_pwq(pwq);
-				printk_deferred_exit();
-			}
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	for_each_pwq(pwq, wq) {
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 			/*
-			 * We could be printing a lot from atomic context, e.g.
-			 * sysrq-t -> show_workqueue_state(). Avoid triggering
-			 * hard lockup.
+			 * Defer printing to avoid deadlocks in console
+			 * drivers that queue work while holding locks
+			 * also taken in their write paths.
 			 */
-			touch_nmi_watchdog();
-		}
-	}
-
-	for_each_pool(pool, pi) {
-		struct worker *worker;
-		bool first = true;
-
-		raw_spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
-		/*
-		 * Defer printing to avoid deadlocks in console drivers that
-		 * queue work while holding locks also taken in their write
-		 * paths.
-		 */
-		printk_deferred_enter();
-		pr_info("pool %d:", pool->id);
-		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
-		if (pool->manager)
-			pr_cont(" manager: %d",
-				task_pid_nr(pool->manager->task));
-		list_for_each_entry(worker, &pool->idle_list, entry) {
-			pr_cont(" %s%d", first ? "idle: " : "",
-				task_pid_nr(worker->task));
-			first = false;
+			printk_deferred_enter();
+			show_pwq(pwq);
+			printk_deferred_exit();
 		}
-		pr_cont("\n");
-		printk_deferred_exit();
-	next_pool:
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
-		 * sysrq-t -> show_workqueue_state(). Avoid triggering
+		 * sysrq-t -> show_all_workqueues(). Avoid triggering
 		 * hard lockup.
 		 */
 		touch_nmi_watchdog();
 	}
 
+}
+
+/**
+ * show_one_worker_pool - dump state of specified worker pool
+ * @pool: worker pool whose state will be printed
+ */
+static void show_one_worker_pool(struct worker_pool *pool)
+{
+	struct worker *worker;
+	bool first = true;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+	if (pool->nr_workers == pool->nr_idle)
+		goto next_pool;
+	/*
+	 * Defer printing to avoid deadlocks in console drivers that
+	 * queue work while holding locks also taken in their write
+	 * paths.
+	 */
+	printk_deferred_enter();
+	pr_info("pool %d:", pool->id);
+	pr_cont_pool_info(pool);
+	pr_cont(" hung=%us workers=%d",
+		jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
+		pool->nr_workers);
+	if (pool->manager)
+		pr_cont(" manager: %d",
+			task_pid_nr(pool->manager->task));
+	list_for_each_entry(worker, &pool->idle_list, entry) {
+		pr_cont(" %s%d", first ? "idle: " : "",
+			task_pid_nr(worker->task));
+		first = false;
+	}
+	pr_cont("\n");
+	printk_deferred_exit();
+next_pool:
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	/*
+	 * We could be printing a lot from atomic context, e.g.
+	 * sysrq-t -> show_all_workqueues(). Avoid triggering
+	 * hard lockup.
+	 */
+	touch_nmi_watchdog();
+
+}
+
+/**
+ * show_all_workqueues - dump workqueue state
+ *
+ * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * all busy workqueues and pools.
+ */
+void show_all_workqueues(void)
+{
+	struct workqueue_struct *wq;
+	struct worker_pool *pool;
+	int pi;
+
+	rcu_read_lock();
+
+	pr_info("Showing busy workqueues and worker pools:\n");
+
+	list_for_each_entry_rcu(wq, &workqueues, list)
+		show_one_workqueue(wq);
+
+	for_each_pool(pool, pi)
+		show_one_worker_pool(pool);
+
 	rcu_read_unlock();
 }
 
@@ -5883,7 +5903,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	rcu_read_unlock();
 
 	if (lockup_detected)
-		show_workqueue_state();
+		show_all_workqueues();
 
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
-- 
2.39.2



