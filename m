Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B27F52BE
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 22:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKVVkL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjKVVkK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 16:40:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD61A4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 13:40:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E00C433C8;
        Wed, 22 Nov 2023 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700689206;
        bh=36MqXDZ/tC1rQRu3Vuag07OlEDcpEAoDwilDtG4dx/I=;
        h=Subject:To:Cc:From:Date:From;
        b=hD8umyne8aQwDHvI2qgSp/tp1kYeHuZGsmNC7NrADz6dY49LothBHKaniabk825YG
         /WmQ2B3KKC+4NGu3bClZjkXZvN/FkQPfEMuSkeUzB3FXicaCeE+FJE7avtlnOBJ41q
         iifGA9vYCKf2BYVYyCYI5JY1RnaL+3rcBnWrdxM4=
Subject: FAILED: patch "[PATCH] rcutorture: Fix stuttering races and other issues" failed to apply to 6.5-stable tree
To:     joel@joelfernandes.org, frederic@kernel.org, paulmck@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 21:40:01 +0000
Message-ID: <2023112201-parakeet-trustless-649e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x cca42bd8eb1b54a4c9bbf48c79d120e66619a3e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112201-parakeet-trustless-649e@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

cca42bd8eb1b ("rcutorture: Fix stuttering races and other issues")
10af43671e8b ("torture: Move stutter_wait() timeouts to hrtimers")
5d248bb39fe1 ("torture: Add lock_torture writer_fifo module parameter")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cca42bd8eb1b54a4c9bbf48c79d120e66619a3e4 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Sat, 29 Jul 2023 14:27:31 +0000
Subject: [PATCH] rcutorture: Fix stuttering races and other issues

The stuttering code isn't functioning as expected. Ideally, it should
pause the torture threads for a designated period before resuming. Yet,
it fails to halt the test for the correct duration. Additionally, a race
condition exists, potentially causing the stuttering code to pause for
an extended period if the 'spt' variable is non-zero due to the stutter
orchestration thread's inadequate CPU time.

Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
This happens as the stuttering code may run within a softirq due to RCU
callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
thus obstructing RCU's progress. This situation triggers a warning
message in the logs:

[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9

This warning suggests that an RCU torture object, although invisible to
RCU readers, couldn't make it past the pipe array and be freed -- a
strong indication that there weren't enough grace periods during the
stutter interval.

To address these issues, this patch sets the "stutter end" time to an
absolute point in the future set by the main stutter thread. This is
then used for waiting in stutter_wait(). While the stutter thread still
defines this absolute time, the waiters' waiting logic doesn't rely on
the stutter thread receiving sufficient CPU time to halt the stuttering
as the halting is now self-controlled.

Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/torture.c b/kernel/torture.c
index 6ba62e5993e7..fd353f98162f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -720,7 +720,7 @@ static void torture_shutdown_cleanup(void)
  * suddenly applied to or removed from the system.
  */
 static struct task_struct *stutter_task;
-static int stutter_pause_test;
+static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
@@ -730,30 +730,16 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	unsigned int i = 0;
 	bool ret = false;
-	int spt;
+	ktime_t till_ns;
 
 	cond_resched_tasks_rcu_qs();
-	spt = READ_ONCE(stutter_pause_test);
-	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret && !rt_task(current)) {
-			sched_set_normal(current, MAX_NICE);
-			ret = true;
-		}
-		if (spt == 1) {
-			torture_hrtimeout_jiffies(1, NULL);
-		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff))
-					torture_hrtimeout_us(10, 0, NULL);
-				cond_resched();
-			}
-		} else {
-			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
-		}
-		torture_shutdown_absorb(title);
+	till_ns = READ_ONCE(stutter_till_abs_time);
+	if (till_ns && ktime_before(ktime_get(), till_ns)) {
+		torture_hrtimeout_ns(till_ns, 0, HRTIMER_MODE_ABS, NULL);
+		ret = true;
 	}
+	torture_shutdown_absorb(title);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
@@ -764,23 +750,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	DEFINE_TORTURE_RANDOM(rand);
-	int wtime;
+	ktime_t till_ns;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
-			wtime = stutter;
-			if (stutter > 2) {
-				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - 3;
-				torture_hrtimeout_jiffies(wtime, &rand);
-				wtime = 2;
-			}
-			WRITE_ONCE(stutter_pause_test, 2);
-			torture_hrtimeout_jiffies(wtime, NULL);
+			till_ns = ktime_add_ns(ktime_get(),
+					       jiffies_to_nsecs(stutter));
+			WRITE_ONCE(stutter_till_abs_time, till_ns);
+			torture_hrtimeout_jiffies(stutter - 1, NULL);
 		}
-		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
 			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");

