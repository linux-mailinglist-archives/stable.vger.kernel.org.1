Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2E78D1A1
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 03:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjH3BOy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 21:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjH3BOc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 21:14:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F683
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 18:14:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7926b7f8636so10385239f.1
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693358069; x=1693962869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7ZS08nXKQyRY+dg29nXS56o4Do5DvAaZ35fmdWjMgk=;
        b=NsYGhDobrdEhcEKi6kLvUxEAQ2nKW5CzqE7tM2FMligt9HR0H370z139+Vm7FNwe5N
         YpWm3nGRfn09UtF80PZY0h2YXGMXDTiyCW54otyYlmjYMU4/X0jVJB7NFl7gK80C4CRU
         4KV3KEYBaU0d0fSrk3Xmt8xs5bMjrS60bMkdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693358069; x=1693962869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7ZS08nXKQyRY+dg29nXS56o4Do5DvAaZ35fmdWjMgk=;
        b=XrorWfRW6r3SejfNTklag1vEdl7OcnLm2jtgiVlDtqJ+NZZz5vn+CtNVe59pwvyD4/
         57kixpmSvizjCMJ0HH1xjcsV3DYJkfH+PMJnabxNor2Wpn7elrxhwdzLbSdifBJil95T
         8GBt5Df/zRa47rrIzA82hLdBuzUDpoD0VIhKbAnwoK/1aOhdMJMfnK72Fg6wEvuBpGrA
         bHN1PLeDGeCKUWDmIZ5HZCTAkPcZsRD/NZUguE0QXUnPry+tK5FaZMzH117MBgOHktcW
         UiaHGlztyfdNUkbEu+YfyvaPA4LjeHg7/M+utPsoo92zFcnbcKrMSd7fhu/TtAyXVPjd
         GGZQ==
X-Gm-Message-State: AOJu0Ywr2LHjOAoo+lDkh2UJCpjWf8vqMTV92KZm8VvkKUqFx041lNi2
        xFpuoBh3IGe8ATZweNGIIqEB3g==
X-Google-Smtp-Source: AGHT+IFQpXTDn2mT+79saqVpsdHKijvjstGIS+cFMDZpnLnOBvGoysvA72uh3n5Ivkb/YIt1OoJKPg==
X-Received: by 2002:a05:6602:335a:b0:792:82f8:73fe with SMTP id c26-20020a056602335a00b0079282f873femr798534ioz.3.1693358069507;
        Tue, 29 Aug 2023 18:14:29 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id z3-20020a6be003000000b007911db1e6f4sm3625736iog.44.2023.08.29.18.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 18:14:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH] rcu/tree: Defer setting of jiffies during stall reset
Date:   Wed, 30 Aug 2023 01:14:22 +0000
Message-ID: <20230830011424.45839-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

There are instances where rcu_cpu_stall_reset() is called when jiffies
did not get a chance to update for a long time. Before jiffies is
updated, the CPU stall detector can go off triggering false-positives
where a just-started grace period appears to be ages old. In the past,
we disabled stall detection in rcu_cpu_stall_reset() however this got
changed [1]. This is resulting in false-positives in KGDB usecase [2].

Fix this by deferring the update of jiffies to the third run of the FQS
loop. This is more robust, as, even if rcu_cpu_stall_reset() is called
just before jiffies is read, we would end up pushing out the jiffies
read by 3 more FQS loops. Meanwhile the CPU stall detection will be
delayed and we will not get any false positives.

[1] https://lore.kernel.org/all/20210521155624.174524-2-senozhatsky@chromium.org/
[2] https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/

Tested with rcutorture.cpu_stall option as well to verify stall behavior
with/without patch.

Tested-by: Huacai Chen <chenhuacai@loongson.cn>
Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Closes: https://lore.kernel.org/all/20230814020045.51950-2-chenhuacai@loongson.cn/
Suggested-by: Paul  McKenney <paulmck@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: a80be428fbc1 ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c       | 12 ++++++++++++
 kernel/rcu/tree.h       |  4 ++++
 kernel/rcu/tree_stall.h | 20 ++++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1449cb69a0e0..b695c0eb515a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1552,10 +1552,22 @@ static bool rcu_gp_fqs_check_wake(int *gfp)
  */
 static void rcu_gp_fqs(bool first_time)
 {
+	int nr_fqs = READ_ONCE(rcu_state.nr_fqs_jiffies_stall);
 	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
+
+	WARN_ON_ONCE(nr_fqs > 3);
+	/* Only countdown nr_fqs for stall purposes if jiffies moves. */
+	if (nr_fqs) {
+		if (nr_fqs == 1) {
+			WRITE_ONCE(rcu_state.jiffies_stall,
+				   jiffies + rcu_jiffies_till_stall_check());
+		}
+		WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, --nr_fqs);
+	}
+
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
 		force_qs_rnp(dyntick_save_progress_counter);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..e9821a8422db 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,6 +386,10 @@ struct rcu_state {
 						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
+	int nr_fqs_jiffies_stall;		/* Number of fqs loops after
+						 * which read jiffies and set
+						 * jiffies_stall. Stall
+						 * warnings disabled if !0. */
 	unsigned long jiffies_resched;		/* Time at which to resched */
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..a2fa6b22e248 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -149,12 +149,17 @@ static void panic_on_rcu_stall(void)
 /**
  * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
  *
+ * To perform the reset request from the caller, disable stall detection until
+ * 3 fqs loops have passed. This is required to ensure a fresh jiffies is
+ * loaded.  It should be safe to do from the fqs loop as enough timer
+ * interrupts and context switches should have passed.
+ *
  * The caller must disable hard irqs.
  */
 void rcu_cpu_stall_reset(void)
 {
-	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + rcu_jiffies_till_stall_check());
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
+	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -170,6 +175,7 @@ static void record_gp_stall_check_time(void)
 	WRITE_ONCE(rcu_state.gp_start, j);
 	j1 = rcu_jiffies_till_stall_check();
 	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
+	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 0);
 	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
@@ -725,6 +731,16 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
+
+	/*
+	 * Check if it was requested (via rcu_cpu_stall_reset()) that the FQS
+	 * loop has to set jiffies to ensure a non-stale jiffies value. This
+	 * is required to have good jiffies value after coming out of long
+	 * breaks of jiffies updates. Not doing so can cause false positives.
+	 */
+	if (READ_ONCE(rcu_state.nr_fqs_jiffies_stall) > 0)
+		return;
+
 	j = jiffies;
 
 	/*
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

