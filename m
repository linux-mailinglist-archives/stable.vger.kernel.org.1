Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818277AD35
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjHMVsN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHMVqz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB02D57
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFBFE60B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EE5C433C7;
        Sun, 13 Aug 2023 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963214;
        bh=KRX/t8PFG6skDqH2WM10mDazglIzsOQBl4IZ2Kzwuqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3VgFbiSrR5CFBY2zMw7EwvhkX6KxyyyaHk27de6W3aZtUj9AfyCxB8g4lopXLVSC
         Sbsil391QHKrEr+bZPm4zQC9BoS22KPEY9TZenOTaIgb33/+wX30v/rbycF3ySAMgH
         sRxIQ28uO6Tso6K3dh84vFgPkg7oB30Hco2Kdvxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 5.15 87/89] tick: Detect and fix jiffies update stall
Date:   Sun, 13 Aug 2023 23:20:18 +0200
Message-ID: <20230813211713.367727818@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd ]

tick: Detect and fix jiffies update stall

On some rare cases, the timekeeper CPU may be delaying its jiffies
update duty for a while. Known causes include:

* The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
  or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
  updates while waiting for the target CPU to complete its
  stop_machine() callback.

* The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
  on the host.

Detect and fix these situations with emergency timekeeping catchups.

Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/tick-sched.c |   17 +++++++++++++++++
 kernel/time/tick-sched.h |    4 ++++
 2 files changed, 21 insertions(+)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -180,6 +180,8 @@ static ktime_t tick_init_jiffy_update(vo
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -207,6 +209,21 @@ static void tick_sched_do_timer(struct t
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies != jiffies) {
+		ts->stalled_jiffies = 0;
+		ts->last_tick_jiffies = READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies = 0;
+			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick = 1;
 }
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);


