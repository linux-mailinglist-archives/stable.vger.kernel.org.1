Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1D47613AE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjGYLMy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjGYLMi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:12:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F921990
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636A861648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762BBC433C7;
        Tue, 25 Jul 2023 11:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283508;
        bh=ujNJwtKgp6WEqNJma+MjV/pPjwzs9uhEoRnPwlEnJTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nh8PUKVndS1sjaLc/REXpBYP9dxfWCWxuJf71tEE8+Evx6FWAEfZ30yu8HToZxWZc
         SwW4c9RMwL/kyi7SGn64rJOAE1w5ev9RZRKKbfTPrhNhBHEBalf8NaXTJOcUcCvRGm
         XRpx7RXvNWAkEp3vy6QLZ5paWZeqOIYGwMunkTnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/509] posix-timers: Prevent RT livelock in itimer_delete()
Date:   Tue, 25 Jul 2023 12:39:21 +0200
Message-ID: <20230725104554.664415546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 9d9e522010eb5685d8b53e8a24320653d9d4cbbf ]

itimer_delete() has a retry loop when the timer is concurrently expired. On
non-RT kernels this just spin-waits until the timer callback has completed,
except for posix CPU timers which have HAVE_POSIX_CPU_TIMERS_TASK_WORK
enabled.

In that case and on RT kernels the existing task could live lock when
preempting the task which does the timer delivery.

Replace spin_unlock() with an invocation of timer_wait_running() to handle
it the same way as the other retry loops in the posix timer code.

Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchronization on PREEMPT_RT")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87v8g7c50d.ffs@tglx
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 43 +++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d089627f2f2b4..6d12a724d2b6b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1037,27 +1037,52 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 }
 
 /*
- * return timer owned by the process, used by exit_itimers
+ * Delete a timer if it is armed, remove it from the hash and schedule it
+ * for RCU freeing.
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-retry_delete:
-	spin_lock_irq(&timer->it_lock);
+	unsigned long flags;
+
+	/*
+	 * irqsave is required to make timer_wait_running() work.
+	 */
+	spin_lock_irqsave(&timer->it_lock, flags);
 
+retry_delete:
+	/*
+	 * Even if the timer is not longer accessible from other tasks
+	 * it still might be armed and queued in the underlying timer
+	 * mechanism. Worse, that timer mechanism might run the expiry
+	 * function concurrently.
+	 */
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		spin_unlock_irq(&timer->it_lock);
+		/*
+		 * Timer is expired concurrently, prevent livelocks
+		 * and pointless spinning on RT.
+		 *
+		 * timer_wait_running() drops timer::it_lock, which opens
+		 * the possibility for another task to delete the timer.
+		 *
+		 * That's not possible here because this is invoked from
+		 * do_exit() only for the last thread of the thread group.
+		 * So no other task can access and delete that timer.
+		 */
+		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+			return;
+
 		goto retry_delete;
 	}
 	list_del(&timer->list);
 
-	spin_unlock_irq(&timer->it_lock);
+	spin_unlock_irqrestore(&timer->it_lock, flags);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
 /*
- * This is called by do_exit or de_thread, only when nobody else can
- * modify the signal->posix_timers list. Yet we need sighand->siglock
- * to prevent the race with /proc/pid/timers.
+ * Invoked from do_exit() when the last thread of a thread group exits.
+ * At that point no other task can access the timers of the dying
+ * task anymore.
  */
 void exit_itimers(struct task_struct *tsk)
 {
@@ -1067,10 +1092,12 @@ void exit_itimers(struct task_struct *tsk)
 	if (list_empty(&tsk->signal->posix_timers))
 		return;
 
+	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
 	list_replace_init(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
+	/* The timers are not longer accessible via tsk::signal */
 	while (!list_empty(&timers)) {
 		tmr = list_first_entry(&timers, struct k_itimer, list);
 		itimer_delete(tmr);
-- 
2.39.2



