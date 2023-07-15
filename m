Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9E7545AF
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 02:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGOArX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOArX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 20:47:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890419A7
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:21 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34637362297so11088725ab.2
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689382040; x=1691974040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEcZ4WqiAaVw4tGJiVOerXYOOYYg2/iiUqs8J2NiRq4=;
        b=vZahncqYmeYPjFmGoXuYLXktZ9r10DhNlZYk5tHBhcOKZ4xBNnTRoBe/MoorE6WrvX
         XPALfmb88MafacbEOQwdyuauH/9rRM2nzp5sFlr/iou1IhiGWJqP6hdHxD3zSLekfKpM
         bDNFrwWFg2TcWBaiZloliO2NjNVv4lTxjgwO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382040; x=1691974040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEcZ4WqiAaVw4tGJiVOerXYOOYYg2/iiUqs8J2NiRq4=;
        b=UcKhOESutavGEFLeIqp7NZCDR1HeUWfBkvXV8Cr7xY2/P7OwBIOFtbM5w5VwpwQzmr
         iuwK9Xiy3IzCGNrfH9mDqcYcKdECyb/a5+aAyBDrT2JnJ2xPFMw4ufLHQ8miHRgAGBmF
         oOHgoTVShZWTmz9oP5UeCZqJ/1NVi5RZpto9s1jnphRICMnoD+KK6YYlKkhcH3gKaY6O
         wsiQ0BHSnb4qYI+1MoQL0y+LgaV08am/SwDos5qzQMtCjmkkr/Q2JvIXRgBj/Monx1Ur
         1d4FRYyBCHlj+59GzH4xnuGpZfOmzJ3ADQK8q1w0yojzAk/Rh7hUDSI1WuJV5OK3GS3y
         NhOA==
X-Gm-Message-State: ABy/qLblCwc2pNQO14B+Wu8fsN6v73jjCeGoPPzCr0AAwjZv07vT6mTd
        hG2g0ZHPid4qk9e28oHbeDwoc64YCcifyo0AP34=
X-Google-Smtp-Source: APBJJlGVqD1LiGjihnAu04afYv5XvKBQdS1m/CwrqhrIf/CK5eWc87Kg2cQ9Tt4mgVn+pFC28UC2Dg==
X-Received: by 2002:a05:6e02:4ca:b0:346:77f5:87ee with SMTP id f10-20020a056e0204ca00b0034677f587eemr5088476ils.11.1689382040000;
        Fri, 14 Jul 2023 17:47:20 -0700 (PDT)
Received: from rcubot2.c.googlers.com.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d310000000b003486fa3e78csm643420ila.11.2023.07.14.17.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 17:47:18 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH -stable v5.10 2/3] rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
Date:   Sat, 15 Jul 2023 00:47:10 +0000
Message-ID: <20230715004711.2938489-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230715004711.2938489-1-joel@joelfernandes.org>
References: <20230715004711.2938489-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit f8ab3fad80dddf3f2cecb53983063c4431058ca1 ]

There are several ->trc_reader_special.b.need_qs data races that are
too low-probability for KCSAN to notice, but which will happen sooner
or later.  This commit therefore marks these accesses.

Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tasks.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b16a86163af..aef2e96c3854 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -801,7 +801,7 @@ static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	int nq = t->trc_reader_special.b.need_qs;
+	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
 
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
 	    t->trc_reader_special.b.need_mb)
@@ -867,7 +867,7 @@ static void trc_read_check_handler(void *t_in)
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
@@ -919,7 +919,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
@@ -1048,7 +1048,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
 		 READ_ONCE(t->trc_reader_nesting),
-		 " N"[!!t->trc_reader_special.b.need_qs],
+		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
 	sched_show_task(t);
 }
-- 
2.41.0.255.g8b1d071c50-goog

