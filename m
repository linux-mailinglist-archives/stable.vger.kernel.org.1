Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8670396B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbjEORmY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbjEORlv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F5106C2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB1B62E0D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A7CC433EF;
        Mon, 15 May 2023 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172365;
        bh=627qYvQNFw9V9sbptJ4sxMHV571wznNetJ2c2u32ARs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDtKB937IRbbVT385d2Sj3RQ9ILiSB8R8Cj1OUfr9ipSP6psDy1ejq2zr13RgVtNQ
         XwEGvXG7jc/WmtUbURME/Wou69insltClrnv2AsCCzPR8GphW9DKWsjBWfg4puLSCx
         JWEr83aCitEEz6O6yZ6ozoHJTY328B6rR5Hg/UFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/381] tick: Get rid of tick_period
Date:   Mon, 15 May 2023 18:26:19 +0200
Message-Id: <20230515161742.606276309@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit b996544916429946bf4934c1c01a306d1690972c ]

The variable tick_period is initialized to NSEC_PER_TICK / HZ during boot
and never updated again.

If NSEC_PER_TICK is not an integer multiple of HZ this computation is less
accurate than TICK_NSEC which has proper rounding in place.

Aside of the inaccuracy there is no reason for having this variable at
all. It's just a pointless indirection and all usage sites can just use the
TICK_NSEC constant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.766643526@linutronix.de
Stable-dep-of: e9523a0d8189 ("tick/common: Align tick period with the HZ tick.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/tick-broadcast.c |  2 +-
 kernel/time/tick-common.c    |  8 +++-----
 kernel/time/tick-internal.h  |  1 -
 kernel/time/tick-sched.c     | 22 +++++++++++-----------
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 36d7464c89625..a9530e866e5f1 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -331,7 +331,7 @@ static void tick_handle_periodic_broadcast(struct clock_event_device *dev)
 	bc_local = tick_do_periodic_broadcast();
 
 	if (clockevent_state_oneshot(dev)) {
-		ktime_t next = ktime_add(dev->next_event, tick_period);
+		ktime_t next = ktime_add_ns(dev->next_event, TICK_NSEC);
 
 		clockevents_program_event(dev, next, true);
 	}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 6c9c342dd0e53..92bf99d558b48 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -30,7 +30,6 @@ DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
  * Tick next event: keeps track of the tick time
  */
 ktime_t tick_next_period;
-ktime_t tick_period;
 
 /*
  * tick_do_timer_cpu is a timer core internal variable which holds the CPU NR
@@ -88,7 +87,7 @@ static void tick_periodic(int cpu)
 		write_seqcount_begin(&jiffies_seq);
 
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		tick_next_period = ktime_add_ns(tick_next_period, TICK_NSEC);
 
 		do_timer(1);
 		write_seqcount_end(&jiffies_seq);
@@ -127,7 +126,7 @@ void tick_handle_periodic(struct clock_event_device *dev)
 		 * Setup the next period for devices, which do not have
 		 * periodic mode:
 		 */
-		next = ktime_add(next, tick_period);
+		next = ktime_add_ns(next, TICK_NSEC);
 
 		if (!clockevents_program_event(dev, next, false))
 			return;
@@ -173,7 +172,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 		for (;;) {
 			if (!clockevents_program_event(dev, next, false))
 				return;
-			next = ktime_add(next, tick_period);
+			next = ktime_add_ns(next, TICK_NSEC);
 		}
 	}
 }
@@ -220,7 +219,6 @@ static void tick_setup_device(struct tick_device *td,
 			tick_do_timer_cpu = cpu;
 
 			tick_next_period = ktime_get();
-			tick_period = NSEC_PER_SEC / HZ;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5294f5b1f9550..e61c1244e7d46 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -15,7 +15,6 @@
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
-extern ktime_t tick_period;
 extern int tick_do_timer_cpu __read_mostly;
 
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5c3d4355266db..17dc3f53efef8 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -92,17 +92,17 @@ static void tick_do_update_jiffies64(ktime_t now)
 	write_seqcount_begin(&jiffies_seq);
 
 	delta = ktime_sub(now, tick_next_period);
-	if (unlikely(delta >= tick_period)) {
+	if (unlikely(delta >= TICK_NSEC)) {
 		/* Slow path for long idle sleep times */
-		s64 incr = ktime_to_ns(tick_period);
+		s64 incr = TICK_NSEC;
 
 		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
 	} else {
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   TICK_NSEC);
 	}
 
 	do_timer(ticks);
@@ -112,7 +112,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 	 * pairs with the READ_ONCE() in the lockless quick check above.
 	 */
 	WRITE_ONCE(tick_next_period,
-		   ktime_add(last_jiffies_update, tick_period));
+		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
 
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
@@ -688,7 +688,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
 	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
 		hrtimer_start_expires(&ts->sched_timer,
@@ -1250,7 +1250,7 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	if (unlikely(ts->tick_stopped))
 		return;
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
@@ -1287,7 +1287,7 @@ static void tick_nohz_switch_to_nohz(void)
 	next = tick_init_jiffy_update();
 
 	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, tick_period);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
@@ -1353,7 +1353,7 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-	hrtimer_forward(timer, now, tick_period);
+	hrtimer_forward(timer, now, TICK_NSEC);
 
 	return HRTIMER_RESTART;
 }
@@ -1387,13 +1387,13 @@ void tick_setup_sched_timer(void)
 
 	/* Offset the tick to avert jiffies_lock contention. */
 	if (sched_skew_tick) {
-		u64 offset = ktime_to_ns(tick_period) >> 1;
+		u64 offset = TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
 		offset *= smp_processor_id();
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
-- 
2.39.2



