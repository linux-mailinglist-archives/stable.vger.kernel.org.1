Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31197039EB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbjEORqt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbjEORq2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB4615619
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AEC62EAC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02B1C4339B;
        Mon, 15 May 2023 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172697;
        bh=dGqlbA4JVBWEKBUfKuqgr5W1OIXPAstWd/9/8l09y50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDyP9Xol7S2LSYsOcj0yvDmoEeo+Sl+dw/6tGDgjiy8h+5HrvVX7pDyzqQq53zcKe
         T2kqASCKLLf/elOtEaVM0Kdayu/GvrLlm066DkH/T5VJs7BYyqO/bo7XxJwsBftQBw
         asqhEdP9TrUMPkzDtOFDIZ5Io1Q7n+tEaF/7bPAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 238/381] workqueue: Rename "delayed" (delayed by active management) to "inactive"
Date:   Mon, 15 May 2023 18:28:09 +0200
Message-Id: <20230515161747.452551021@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Lai Jiangshan <laijs@linux.alibaba.com>

[ Upstream commit f97a4a1a3f8769e3452885967955e21c88f3f263 ]

There are two kinds of "delayed" work items in workqueue subsystem.

One is for timer-delayed work items which are visible to workqueue users.
The other kind is for work items delayed by active management which can
not be directly visible to workqueue users.  We mixed the word "delayed"
for both kinds and caused somewhat ambiguity.

This patch renames the later one (delayed by active management) to
"inactive", because it is used for workqueue active management and
most of its related symbols are named with "active" or "activate".

All "delayed" and "DELAYED" are carefully checked and renamed one by
one to avoid accidentally changing the name of the other kind for
timer-delayed.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 335a42ebb0ca ("workqueue: Fix hung time report of worker pools")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/workqueue.h |  4 +--
 kernel/workqueue.c        | 58 +++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a8..2fa9b311e5663 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -29,7 +29,7 @@ void delayed_work_timer_fn(struct timer_list *t);
 
 enum {
 	WORK_STRUCT_PENDING_BIT	= 0,	/* work item is pending execution */
-	WORK_STRUCT_DELAYED_BIT	= 1,	/* work item is delayed */
+	WORK_STRUCT_INACTIVE_BIT= 1,	/* work item is inactive */
 	WORK_STRUCT_PWQ_BIT	= 2,	/* data points to pwq */
 	WORK_STRUCT_LINKED_BIT	= 3,	/* next work is linked to this one */
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
@@ -42,7 +42,7 @@ enum {
 	WORK_STRUCT_COLOR_BITS	= 4,
 
 	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
-	WORK_STRUCT_DELAYED	= 1 << WORK_STRUCT_DELAYED_BIT,
+	WORK_STRUCT_INACTIVE	= 1 << WORK_STRUCT_INACTIVE_BIT,
 	WORK_STRUCT_PWQ		= 1 << WORK_STRUCT_PWQ_BIT,
 	WORK_STRUCT_LINKED	= 1 << WORK_STRUCT_LINKED_BIT,
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0cc2a62e88f9e..7f57fed719957 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -207,7 +207,7 @@ struct pool_workqueue {
 						/* L: nr of in_flight works */
 	int			nr_active;	/* L: nr of active works */
 	int			max_active;	/* L: max active works */
-	struct list_head	delayed_works;	/* L: delayed works */
+	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
@@ -1145,7 +1145,7 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
-static void pwq_activate_delayed_work(struct work_struct *work)
+static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 
@@ -1153,16 +1153,16 @@ static void pwq_activate_delayed_work(struct work_struct *work)
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
-	__clear_bit(WORK_STRUCT_DELAYED_BIT, work_data_bits(work));
+	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
 	pwq->nr_active++;
 }
 
-static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
+static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->delayed_works,
+	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_delayed_work(work);
+	pwq_activate_inactive_work(work);
 }
 
 /**
@@ -1185,10 +1185,10 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 	pwq->nr_in_flight[color]--;
 
 	pwq->nr_active--;
-	if (!list_empty(&pwq->delayed_works)) {
-		/* one down, submit a delayed one */
+	if (!list_empty(&pwq->inactive_works)) {
+		/* one down, submit an inactive one */
 		if (pwq->nr_active < pwq->max_active)
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 	}
 
 	/* is flush in progress and are we at the flushing tip? */
@@ -1290,14 +1290,14 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		debug_work_deactivate(work);
 
 		/*
-		 * A delayed work item cannot be grabbed directly because
+		 * An inactive work item cannot be grabbed directly because
 		 * it might have linked NO_COLOR work items which, if left
-		 * on the delayed_list, will confuse pwq->nr_active
+		 * on the inactive_works list, will confuse pwq->nr_active
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_DELAYED)
-			pwq_activate_delayed_work(work);
+		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
+			pwq_activate_inactive_work(work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, get_work_color(work));
@@ -1496,8 +1496,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		if (list_empty(worklist))
 			pwq->pool->watchdog_ts = jiffies;
 	} else {
-		work_flags |= WORK_STRUCT_DELAYED;
-		worklist = &pwq->delayed_works;
+		work_flags |= WORK_STRUCT_INACTIVE;
+		worklist = &pwq->inactive_works;
 	}
 
 	debug_work_activate(work);
@@ -2534,7 +2534,7 @@ static int rescuer_thread(void *__rescuer)
 			/*
 			 * The above execution of rescued work items could
 			 * have created more to rescue through
-			 * pwq_activate_first_delayed() or chained
+			 * pwq_activate_first_inactive() or chained
 			 * queueing.  Let's put @pwq back on mayday list so
 			 * that such back-to-back work items, which may be
 			 * being used to relieve memory pressure, don't
@@ -2960,7 +2960,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->delayed_works);
+		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -3714,7 +3714,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
  * @pwq: target pool_workqueue
  *
  * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate delayed work items
+ * workqueue's saved_max_active and activate inactive work items
  * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
  */
 static void pwq_adjust_max_active(struct pool_workqueue *pwq)
@@ -3743,9 +3743,9 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 
 		pwq->max_active = wq->saved_max_active;
 
-		while (!list_empty(&pwq->delayed_works) &&
+		while (!list_empty(&pwq->inactive_works) &&
 		       pwq->nr_active < pwq->max_active) {
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 			kick = true;
 		}
 
@@ -3776,7 +3776,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	pwq->wq = wq;
 	pwq->flush_color = -1;
 	pwq->refcnt = 1;
-	INIT_LIST_HEAD(&pwq->delayed_works);
+	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
 	INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
@@ -4363,7 +4363,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 		return true;
 
 	return false;
@@ -4559,7 +4559,7 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	else
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
-	ret = !list_empty(&pwq->delayed_works);
+	ret = !list_empty(&pwq->inactive_works);
 	preempt_enable();
 	rcu_read_unlock();
 
@@ -4755,11 +4755,11 @@ static void show_pwq(struct pool_workqueue *pwq)
 		pr_cont("\n");
 	}
 
-	if (!list_empty(&pwq->delayed_works)) {
+	if (!list_empty(&pwq->inactive_works)) {
 		bool comma = false;
 
-		pr_info("    delayed:");
-		list_for_each_entry(work, &pwq->delayed_works, entry) {
+		pr_info("    inactive:");
+		list_for_each_entry(work, &pwq->inactive_works, entry) {
 			pr_cont_work(comma, work);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
@@ -4789,7 +4789,7 @@ void show_workqueue_state(void)
 		bool idle = true;
 
 		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works)) {
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 				idle = false;
 				break;
 			}
@@ -4801,7 +4801,7 @@ void show_workqueue_state(void)
 
 		for_each_pwq(pwq, wq) {
 			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 				show_pwq(pwq);
 			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
@@ -5176,7 +5176,7 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe);
  * freeze_workqueues_begin - begin freezing workqueues
  *
  * Start freezing workqueues.  After this function returns, all freezable
- * workqueues will queue new works to their delayed_works list instead of
+ * workqueues will queue new works to their inactive_works list instead of
  * pool->worklist.
  *
  * CONTEXT:
-- 
2.39.2



