Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5A7545B0
	for <lists+stable@lfdr.de>; Sat, 15 Jul 2023 02:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGOArZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 20:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOArY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 20:47:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4626E5C
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:22 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3466725f0beso12046645ab.1
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689382041; x=1691974041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxUOCiEfT9raIIdPrR3d8zdLP542ALuyDuBFd34baao=;
        b=UiXW+v8lmnuo+wy+J2hBrP4Q3f3KwP91xYnVqsV7MPnpSBIYtRyTTwgnn/oUvocLvZ
         ceDU5v0mHqNLZu2God1EPj1QCCSJySTwj5waZXwHTxr1amRK8PTvracc2cbcSlDz/GPl
         Xe5GR3tmplv7Y2ieogJy3d7jPbAhxZD0KwO3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382041; x=1691974041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxUOCiEfT9raIIdPrR3d8zdLP542ALuyDuBFd34baao=;
        b=DXWztqCD+6JDthiUG1UwGu27+csTVvrTmY1iFeDkFp7/2FW4U4UGNYRRimme47uD1i
         PYf1a8r6G2SFqxNKSejsJB4MAe4nv4uotUdjE4W7phMpNcgzFAEDp60WXoI4zf+0DO8V
         QozRDGU/edDrGU9ZI69fFLEEsqfJzSubUg78OjkPrKbckfpukovNIlLtW7LRxLA/2pUm
         Fqfs/hKmNzTHR2z78C7MP2AWn6A7H2egP8WLt93USKYuEG8/R5LRkdQmGboUi7wYAFHV
         LUAl+e+YzrrrA69tHxVmQN1Sejd/WMzxJwusrgVVnLd4HwK1p6ZYPgmxcYOv974eBOp5
         JPNA==
X-Gm-Message-State: ABy/qLZsXdAp39RlhWLDFa6FC6OS1Sck7djtkY2UU872Z9FFhtVctXsc
        L17QUTICcyFN0FSSi4w7n+Fnq5p2e4sv+2tn+NI=
X-Google-Smtp-Source: APBJJlFUUBquV3Z6rvqIdGkreQfQSL+gDjEu8L/rDBesD+Z38erqs0EZvhGjHDIMtIwTqJytM7dWSQ==
X-Received: by 2002:a05:6e02:b25:b0:348:7982:ffbc with SMTP id e5-20020a056e020b2500b003487982ffbcmr111973ilu.3.1689382041502;
        Fri, 14 Jul 2023 17:47:21 -0700 (PDT)
Received: from rcubot2.c.googlers.com.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x16-20020a92d310000000b003486fa3e78csm643420ila.11.2023.07.14.17.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 17:47:20 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH -stable v5.10 3/3] rcu-tasks: Simplify trc_read_check_handler() atomic operations
Date:   Sat, 15 Jul 2023 00:47:11 +0000
Message-ID: <20230715004711.2938489-4-joel@joelfernandes.org>
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

[ Upstream commit 96017bf9039763a2e02dcc6adaa18592cd73a39d ]

Currently, trc_wait_for_one_reader() atomically increments
the trc_n_readers_need_end counter before sending the IPI
invoking trc_read_check_handler().  All failure paths out of
trc_read_check_handler() and also from the smp_call_function_single()
within trc_wait_for_one_reader() must carefully atomically decrement
this counter.  This is more complex than it needs to be.

This commit therefore simplifies things and saves a few lines of
code by dispensing with the atomic decrements in favor of having
trc_read_check_handler() do the atomic increment only in the success case.
In theory, this represents no change in functionality.

Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tasks.h | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index aef2e96c3854..23101ebbbe1e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -841,32 +841,24 @@ static void trc_read_check_handler(void *t_in)
 
 	// If the task is no longer running on this CPU, leave.
 	if (unlikely(texp != t)) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
 		goto reset_ipi; // Already on holdout list, so will check later.
 	}
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
 	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
-		// Mark as checked after decrement to avoid false
-		// positives on the above WARN_ON_ONCE().
 		WRITE_ONCE(t->trc_reader_checked, true);
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0)) {
-		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
-			wake_up(&trc_wait);
+	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0))
 		goto reset_ipi;
-	}
 	WRITE_ONCE(t->trc_reader_checked, true);
 
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
+	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
@@ -960,21 +952,15 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		if (per_cpu(trc_ipi_to_cpu, cpu) || t->trc_ipi_to_cpu >= 0)
 			return;
 
-		atomic_inc(&trc_n_readers_need_end);
 		per_cpu(trc_ipi_to_cpu, cpu) = true;
 		t->trc_ipi_to_cpu = cpu;
 		rcu_tasks_trace.n_ipis++;
-		if (smp_call_function_single(cpu,
-					     trc_read_check_handler, t, 0)) {
+		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
 			rcu_tasks_trace.n_ipis_fails++;
 			per_cpu(trc_ipi_to_cpu, cpu) = false;
 			t->trc_ipi_to_cpu = cpu;
-			if (atomic_dec_and_test(&trc_n_readers_need_end)) {
-				WARN_ON_ONCE(1);
-				wake_up(&trc_wait);
-			}
 		}
 	}
 }
-- 
2.41.0.255.g8b1d071c50-goog

