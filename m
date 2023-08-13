Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E351477A4D4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHMDQI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHMDQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 23:16:06 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C78E9
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790f0276911so140464139f.2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691896568; x=1692501368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56T8+A6IRHJH9+E79bo0itXjoBiwatvZolX0wUJO2nU=;
        b=Wz38fPkwoCZPiuCUuKYzZnpk3JvfANQlx8JqVwAbxKRDXXywamZilcHKFY3bdYqxwk
         8Tx+cTFMFWKTMW//gULchb7k3DIjCs5Uqs3jvHE/DXvDfTmIhoASpa6oKzqvvnoO1SGH
         Xg3XtExOXjObQKg1koRzMJvIbsBm/MG90+0Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691896568; x=1692501368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56T8+A6IRHJH9+E79bo0itXjoBiwatvZolX0wUJO2nU=;
        b=CSw9vWzogzGFQr4XHgTRpWSPUn0inOu6pF8xx9BfBdXq5LwagCj7Pdiw1EGCWTi+76
         lFoh+BsDGydrmX/hReq7jTNE7OnnxzDwpGj7k9wgM42n+Ka+7E5IJzaIU/WjzyuR0aoD
         46u46lCKeTrT6IGkFFuNV/d6CEMtZAgf4/h+cokZ9zxNS3iNM/p7UVzCRok3IAev9f9q
         kprvSerXhWXDGLv52lqOyKWK4a0Eoh6DZ3viH6dAKJEdFbbpiA6uQ5dv3XU77VlmVnsI
         hLQJpKZ1yTBh5BIRycUMQqodHkbobi5kO5soAMfa7rgWOkjWq3wxpDYpRNDadoHQh5I6
         Ceyw==
X-Gm-Message-State: AOJu0YwH1SPFgwGu2GN66SHiJmAsT5fDzSYeDrzImoIpCy1VTKtk0f8Y
        rDdTmpmfYXlVgWlL5UI1exdV61Qg642NzIV/Hsw=
X-Google-Smtp-Source: AGHT+IFNLqXjKvLH3RS0oGXz7pjL18QgFUX9Od6NDzc+wWI59Y0FPPBsRMpbSu2/rkgr7Lzfybjg1Q==
X-Received: by 2002:a5e:d605:0:b0:787:1a8f:1d08 with SMTP id w5-20020a5ed605000000b007871a8f1d08mr8175479iom.15.1691896567900;
        Sat, 12 Aug 2023 20:16:07 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id y19-20020a02a393000000b0042b0f3f9367sm2169737jak.129.2023.08.12.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 20:16:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.10 2/3] tick: Detect and fix jiffies update stall
Date:   Sun, 13 Aug 2023 03:15:35 +0000
Message-ID: <20230813031536.2166337-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230813031536.2166337-1-joel@joelfernandes.org>
References: <20230813031536.2166337-1-joel@joelfernandes.org>
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

