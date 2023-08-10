Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64877783A8
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjHJWbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHJWbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 18:31:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF78273D
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34986ae4fa3so4941225ab.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691706702; x=1692311502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o49fspG7HzEt4DVaXaU/T79Cc75UvXkqxg+7cH6wGbY=;
        b=At3/XhFO1WDvvjqlRkufbzV8ayUWCQyaZZp/9joPH+o1ARfuWA8CtL8QJVu+WM2qyQ
         eDJLME9s1e7RFkVxITqOEVtwRlhPZVUFikBneJfBzL90Df7gtCQrQNAHiGIXbuDHjWov
         jUzBxrwu4sjAItWd99yGremoWyv/wr1U8dAx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706702; x=1692311502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o49fspG7HzEt4DVaXaU/T79Cc75UvXkqxg+7cH6wGbY=;
        b=IbtRnJn2QlaDYziKs+6KNPNZnt1mps5rSNPVRYN7mRLzfmJAAzvohOULVS5KgdLrXP
         aqECSxHLT1DuDmi3MaMhcpytFZnjeo7g6I1lbGSVIKzsXOP4zxip2ZEBHkfPS99uP3CP
         P7k4OhpNoH1F1dS+mzN+7JArDf3WorsEh408XE7QxLKlOjVe+2IOris8XTFsVIdRO/7z
         eBkHL3Ptgsm1be6c0ij5u8IsnXOjJAZhttEiaO3WFOHzTEMmbeeRY25R3p0GwLV4uWw9
         /yL8Qc7Sy0eDpEbqnMZxtx0Xjxz5IkQOU9cKqho+0kcv/lRuESIuUGZUo2k2oa/Bre4a
         0OHg==
X-Gm-Message-State: AOJu0YyLGelSiUPMtqJfTPrdF/KFV8eKISQ5BDkIW3fsdIyehPsFCOeP
        cZIKIepwppW3iqGPTol2TLwI74iBuZ4PygMXsIA=
X-Google-Smtp-Source: AGHT+IFKdQl7UzAvZJGffDNhL/zkR/MaqGpGI7dTfSWhX/ssN5HCDbDTyH808LxrRSiIHCJchApTdA==
X-Received: by 2002:a05:6e02:1907:b0:349:849d:bdf7 with SMTP id w7-20020a056e02190700b00349849dbdf7mr115902ilu.17.1691706702048;
        Thu, 10 Aug 2023 15:31:42 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c484000000b0042b6cb44429sm676604jam.46.2023.08.10.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:31:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.15 1/3] tick: Detect and fix jiffies update stall
Date:   Thu, 10 Aug 2023 22:31:35 +0000
Message-ID: <20230810223137.596671-1-joel@joelfernandes.org>
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

