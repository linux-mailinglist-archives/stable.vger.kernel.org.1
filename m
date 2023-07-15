Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4607545AE
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGOArX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGOArW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 20:47:22 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0DE65
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3465ec72cc8so12103385ab.0
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689382038; x=1691974038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1zzKzgVRY9zmHgPSop4Tyduic2XprYhiiyL/nFZ/2A=;
        b=Q/+9z5x0kf00bfBR/cKdonGau8zV5auPbIcL0Ss/M7oDKSleeoqg9jzN23YpqwIuXB
         CWDNpw9IlZqPeSX5R5gGK7vXzlZcDSC20LaW8BYO5ya7VBImbunLCdEWVBEc3EwFS+DP
         99x8QPDqhnUeJsnT+OTMbvQndxjWzEpS3q+pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382038; x=1691974038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1zzKzgVRY9zmHgPSop4Tyduic2XprYhiiyL/nFZ/2A=;
        b=XLKQCNgEpURuUpr/5QwuZ4BfViVsp1jTO2l8QqDvDPv+miV3QmHWC16nSzhvG79BBO
         MYpadoE6xpiGhxxkoKHQwV6F3F0HuOMeTH9UCVbuUVckhGgcTx9y6Sp55K2HTX6lLu2Z
         9xXweKV+hvmDIa4WgZF7OhCWt9bJsacMpIV5M5uZPu/SugegbvTOuqJUMNUl7BGSGGAU
         Lqvtv8Dp2zBPm7//GOt2Ouw6Ii+kQBoZ6RMBIwCfk/AKc6mro2wm4U+4Q2ANpqNR7gAS
         pOjlBgUyioq5xwAJX7YFU5YQq5CnTCfl+OGZ2ynmOGlJelXNin7+jMRGYB8aZBi0c5gz
         CT1Q==
X-Gm-Message-State: ABy/qLZWlzkxzwxRiOARlNJjOa9nIUewTucTXLcRPaNSkSPln6FDLM8R
        lZYSV2IaB9JtXUQB5UavVkNWAti00DFo7YPETQM=
X-Google-Smtp-Source: APBJJlH+qoM9kODr//WYPAW3UlWJDwTUaOMqfhJJCx9By6wP1/Y4F8F3MFZ3Qk6eCeUE46r/WTuRoQ==
X-Received: by 2002:a05:6e02:809:b0:346:6550:d30 with SMTP id u9-20020a056e02080900b0034665500d30mr6406116ilm.20.1689382038372;
        Fri, 14 Jul 2023 17:47:18 -0700 (PDT)
Received: from rcubot2.c.googlers.com.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d310000000b003486fa3e78csm643420ila.11.2023.07.14.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 17:47:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH -stable v5.10 1/3] rcu-tasks: Mark ->trc_reader_nesting data races
Date:   Sat, 15 Jul 2023 00:47:09 +0000
Message-ID: <20230715004711.2938489-2-joel@joelfernandes.org>
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

[ Upstream commit bdb0cca0d11060fce8a8a44588ac1470c25d62bc ]

There are several ->trc_reader_nesting data races that are too
low-probability for KCSAN to notice, but which will happen sooner or
later.  This commit therefore marks these accesses, and comments one
that cannot race.

Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tasks.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c66d47685b28..2b16a86163af 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -848,7 +848,7 @@ static void trc_read_check_handler(void *t_in)
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
-	if (likely(!t->trc_reader_nesting)) {
+	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		// Mark as checked after decrement to avoid false
@@ -857,7 +857,7 @@ static void trc_read_check_handler(void *t_in)
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(t->trc_reader_nesting < 0)) {
+	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0)) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		goto reset_ipi;
@@ -904,6 +904,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
+		// The task is not running, so C-language access is safe.
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
@@ -936,7 +937,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	// The current task had better be in a quiescent state.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		WARN_ON_ONCE(t->trc_reader_nesting);
+		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 		return;
 	}
 
@@ -1046,7 +1047,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
-		 t->trc_reader_nesting,
+		 READ_ONCE(t->trc_reader_nesting),
 		 " N"[!!t->trc_reader_special.b.need_qs],
 		 cpu);
 	sched_show_task(t);
@@ -1141,7 +1142,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
-	WARN_ON_ONCE(t->trc_reader_nesting);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
 		rcu_read_unlock_trace_special(t, 0);
-- 
2.41.0.255.g8b1d071c50-goog

