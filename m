Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642AD77B033
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 05:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjHNDjs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjHNDii (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 23:38:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607812E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34977c2dc27so19248105ab.2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691984282; x=1692589082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J9injJR5W5WwMf7tK7oNt+jxPRk5x1zTEV5R+ridKA=;
        b=c3Y+62dch4h1MISLx3nc2K9sNOXh9J2r0pAsEvYgk8BAALGfrqwKAGsPhAZQ+75BfC
         5RlWoFjtzY1Yn7otY0kv7xYOkTmrfDuc0rGOZMY0i5uKZolRIrudrDHL9RKGZNi/OqvL
         bp3wPdThGV8r18B2h3Ha4b4iUl+yKt60eWOos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691984282; x=1692589082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J9injJR5W5WwMf7tK7oNt+jxPRk5x1zTEV5R+ridKA=;
        b=XNh1pSaRDK1F724kJwFgUcbKE4rxG9yTAFxke+LqecRAuXbrkBhCj0BZ1W/KAYhy5a
         pfC2upHPSckw452qIt7vN+rvX0MKNUZJHwxPYmlnisBZj+okFcW9ZS7/2HrZtemi4iO/
         ItiEgmVN4FJ0HpxUtEuhfC5JpFmAuQAVP6G2wRN1LtdmQ0VfJZYDnXn0FjFb3/pk1RIn
         ar3CoYr/4uGmXBoBpO4JiM5wxHll8S2VU9bhspi65FLh+KJiyGT1pNHKQFMnf3WhWrqj
         0oQu1PgzYX5SHGpVpFwHcIKCwdqGDTmjF7VAvaeiFZ/upOG03m02W19r40XeQK5VKe8s
         5zoQ==
X-Gm-Message-State: AOJu0YzcPaLC5bmkUwt1UIE7JJQMwC/d8EebHAUsLsb3Uaj5Pa/+KLSI
        A7izhjjvMBXFl+guOlQ9pYt73mnlgxjTBKGTQX4=
X-Google-Smtp-Source: AGHT+IFxpYWtQO2Y5lkthMzCymSUWKW4yboVfVNkn6JzYotGHEFJLCsEX/ud9qHZ6nxQnSkBbGljtg==
X-Received: by 2002:a05:6e02:1c2f:b0:349:36e1:10fb with SMTP id m15-20020a056e021c2f00b0034936e110fbmr12727617ilh.18.1691984282324;
        Sun, 13 Aug 2023 20:38:02 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id f3-20020a02b783000000b0042b2d43ee3fsm2829449jam.82.2023.08.13.20.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:38:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     paulmck@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/3] tick: Detect and fix jiffies update stall
Date:   Mon, 14 Aug 2023 03:37:58 +0000
Message-ID: <20230814033759.1163527-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230814033759.1163527-1-joel@joelfernandes.org>
References: <20230814033759.1163527-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit a1ff03cd6fb9c501fff63a4a2bface9adcfa81cd ]

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
index d07de3ff42ac..bb51619c9b63 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -148,6 +148,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -175,6 +177,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
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
index 4fb06527cf64..1e7ec5c968a5 100644
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

