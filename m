Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D858977A4D7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHMDQZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 23:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHMDQY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 23:16:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D88E8
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-790cadee81bso96154039f.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691896586; x=1692501386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o49fspG7HzEt4DVaXaU/T79Cc75UvXkqxg+7cH6wGbY=;
        b=wXDzLwpLE+S0b/8HZZzTiolZeKzlGZWn8YkrhioOAJ67TJve+ETt/QfSKeK7Hn9oO5
         Ki2AEoIqKgfZcAxxHwasGU69f/t5ezt0nfZAEKRs2CkNLq4OME+eX9w+NPcGogbdi967
         v4sQ9bLJDrLBhKUX73uKTWTd/r2x8Hr1cSTF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896586; x=1692501386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o49fspG7HzEt4DVaXaU/T79Cc75UvXkqxg+7cH6wGbY=;
        b=WjMPnqQzciJWH2Bfh6C2yeOAhLbv0Wrjvk19FLkaNEJ70Zjl9qLUUPdLU37ZMJom2T
         JYO0Yed7iubS4O17nSXt7ifWbArsQVIAV7QEdXZxtWsZOi/07QZLQ7siKQF1gDKIZRDB
         f+lR8iNOe+LZd/d4cGHJ/PvQTBoyXVgOyltb03wvwu6h1ED8BKJIneS+TL3vl+YuZoQA
         6SEQWbSmtAgCfN3N6BZ/794bcRhmNWe+/+OCT8uckJyOp2PaVaKmhSOUWmtPAOjzo4UE
         wZxqI8cwjpTRjNz1DirG7rn0/B3HicjFxbPzlC1DMyYSKnFQay08F8Xjj9y4YTzBOCqq
         99Sg==
X-Gm-Message-State: AOJu0Yxd1MG8n7HY6Qi0Hd6lXRe1FlsHtgNYL8xsRVKSM74X/E8xBLU6
        Y8IDGAUTWkZSq+dZE8BweaaH/DKVuE69omB5uW0=
X-Google-Smtp-Source: AGHT+IGt7+/oqolFoJORg6Ox/xx+yA7yc3IdY3gLLEDySfPm+obspHKIScVCLrq+j0fo7bV5FnhxFA==
X-Received: by 2002:a92:c5ab:0:b0:348:cd6b:d593 with SMTP id r11-20020a92c5ab000000b00348cd6bd593mr7155465ilt.27.1691896586620;
        Sat, 12 Aug 2023 20:16:26 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id em6-20020a0566384da600b0042b0a6d899fsm2106263jab.60.2023.08.12.20.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:16:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.15 1/3] tick: Detect and fix jiffies update stall
Date:   Sun, 13 Aug 2023 03:16:18 +0000
Message-ID: <20230813031620.2218302-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
---
 kernel/time/tick-sched.c | 17 +++++++++++++++++
 kernel/time/tick-sched.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f42d0776bc84..7701c720dc1f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -180,6 +180,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -207,6 +209,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
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
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index d952ae393423..504649513399 100644
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
-- 
2.41.0.640.ga95def55d0-goog

