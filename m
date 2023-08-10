Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A77783AA
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjHJWbq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHJWbp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 18:31:45 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8A273D
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3490cf176feso5296295ab.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691706704; x=1692311504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6LNT5bSHHNBOuFl8YfqtswMbbK7njZVoFvNZ5Ia9qk=;
        b=ZAwUfUVd8JslkW70c159cAuq9K69kcZ/bo8hqRvAIiVUyd3q0tbUvKgHCHiiQCqj4m
         dmwrGHzweYz7FKe/CB0bO1MdtPe45MTn766KA1Nm6gpY0hdyaTKgkTtxb1yCmos4O36B
         zBo2vHofp4j1MnkwMYmtApGvLAGuyB/I0R80Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691706704; x=1692311504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6LNT5bSHHNBOuFl8YfqtswMbbK7njZVoFvNZ5Ia9qk=;
        b=HetJDZQryt6y3hIyKQxld/l+eIViweZXwuAr58oiQ/N5z4HnLOPraVywYsupM20XBc
         rLxywEJgUo6al3RqU57aRJtQtSpZeN2gq8LN0GlKXiol7aOPd7+sGTkGfvPu++yb/SnE
         Af9UG8WptHuaNCmFyyVoHDFF7W4cZvmbiCZ9oCJ3ovSZcQpHPSEl44YjOmF2o7P7XJG8
         ZsWGaLgJlF+Lcc7pzNPIbwS+cuLqLDWjYI17tPkH5msVP7kJmA08VaA2JKIwyqNvKuga
         WxwkRE1TVbHN0piRmsGEjCdgcSjp1tKTFWd1cByguiIto9fcpVVrzWEkZe47ti4LVF7j
         l/Nw==
X-Gm-Message-State: AOJu0YyCwpKKHo2u72hvf+QkM7Gt8k3FQXE1eYKMU9pOuc7Tn+zxqpZP
        JYef368bD3wyBPMZLxcVqXbKCfGih3folCgkeO4=
X-Google-Smtp-Source: AGHT+IGxj8jac3J7VCUUQqrsBltRh6Y2mpF3XFFr2r6zl9AexStWITPSjeU16dLciZVLEW6skcYwCg==
X-Received: by 2002:a05:6e02:20e9:b0:349:978e:78d8 with SMTP id q9-20020a056e0220e900b00349978e78d8mr104649ilv.2.1691706704455;
        Thu, 10 Aug 2023 15:31:44 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id t4-20020a02c484000000b0042b6cb44429sm676604jam.46.2023.08.10.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:31:43 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 5.15 3/3] timers/nohz: Last resort update jiffies on nohz_full IRQ entry
Date:   Thu, 10 Aug 2023 22:31:37 +0000
Message-ID: <20230810223137.596671-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
In-Reply-To: <20230810223137.596671-1-joel@joelfernandes.org>
References: <20230810223137.596671-1-joel@joelfernandes.org>
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

[ Upstream commit 53e87e3cdc155f20c3417b689df8d2ac88d79576 ]

When at least one CPU runs in nohz_full mode, a dedicated timekeeper CPU
is guaranteed to stay online and to never stop its tick.

Meanwhile on some rare case, the dedicated timekeeper may be running
with interrupts disabled for a while, such as in stop_machine.

If jiffies stop being updated, a nohz_full CPU may end up endlessly
programming the next tick in the past, taking the last jiffies update
monotonic timestamp as a stale base, resulting in an tick storm.

Here is a scenario where it matters:

0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.

1) A stop machine callback is queued to execute somewhere.

2) CPU 0 reaches MULTI_STOP_DISABLE_IRQ while CPU 1 is still in
   MULTI_STOP_PREPARE. Hence CPU 0 can't do its timekeeping duty. CPU 1
   can still take IRQs.

3) CPU 1 receives an IRQ which queues a timer callback one jiffy forward.

4) On IRQ exit, CPU 1 schedules the tick one jiffy forward, taking
   last_jiffies_update as a base. But last_jiffies_update hasn't been
   updated for 2 jiffies since the timekeeper has interrupts disabled.

5) clockevents_program_event(), which relies on ktime_get(), observes
   that the expiration is in the past and therefore programs the min
   delta event on the clock.

6) The tick fires immediately, goto 3)

7) Tick storm, the nohz_full CPU is drown and takes ages to reach
   MULTI_STOP_DISABLE_IRQ, which is the only way out of this situation.

Solve this with unconditionally updating jiffies if the value is stale
on nohz_full IRQ entry. IRQs and other disturbances are expected to be
rare enough on nohz_full for the unconditional call to ktime_get() to
actually matter.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20211026141055.57358-2-frederic@kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/softirq.c         | 3 ++-
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d45676..41f470929e99 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -595,7 +595,8 @@ void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
 
-	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
+	if (tick_nohz_full_cpu(smp_processor_id()) ||
+	    (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET)))
 		tick_irq_enter();
 
 	account_hardirq_enter(current);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 5786e2794ae1..7f5310d1a4d6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1420,6 +1420,13 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
+	/*
+	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
+	 * alive but it might be busy looping with interrupts disabled in some
+	 * rare case (typically stop machine). So we must make sure we have a
+	 * last resort.
+	 */
 	if (ts->tick_stopped)
 		tick_nohz_update_jiffies(now);
 }
-- 
2.41.0.640.ga95def55d0-goog

