Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE6761528
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjGYL0M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjGYL0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B9613D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E25F6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6FFC433C7;
        Tue, 25 Jul 2023 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284363;
        bh=To+As4hegon161/ypJ+gwuV+tijZnXofBCZiSPcj788=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bfik9yxmOUq0XdlhsLyngXYWCWoUeqn/YGE5GgAv63RX7U199U21SI2iYuAZ1Np/t
         4xdNQbm9pkn6upiNpI5Q/cCDNTFSPH13lY5I4B5U+HqiCRFMUbsfJ7+UD/V+ZU1chk
         Cyc4GLTsAmfI90NpB9r+VeezEbgsbfq/NiDvR2Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 5.10 329/509] rcu-tasks: Mark ->trc_reader_nesting data races
Date:   Tue, 25 Jul 2023 12:44:28 +0200
Message-ID: <20230725104608.760429177@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tasks.h |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -848,7 +848,7 @@ static void trc_read_check_handler(void
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
-	if (likely(!t->trc_reader_nesting)) {
+	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		// Mark as checked after decrement to avoid false
@@ -857,7 +857,7 @@ static void trc_read_check_handler(void
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(t->trc_reader_nesting < 0)) {
+	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0)) {
 		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
 			wake_up(&trc_wait);
 		goto reset_ipi;
@@ -904,6 +904,7 @@ static bool trc_inspect_reader(struct ta
 			n_heavy_reader_ofl_updates++;
 		in_qs = true;
 	} else {
+		// The task is not running, so C-language access is safe.
 		in_qs = likely(!t->trc_reader_nesting);
 	}
 
@@ -936,7 +937,7 @@ static void trc_wait_for_one_reader(stru
 	// The current task had better be in a quiescent state.
 	if (t == current) {
 		t->trc_reader_checked = true;
-		WARN_ON_ONCE(t->trc_reader_nesting);
+		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 		return;
 	}
 
@@ -1046,7 +1047,7 @@ static void show_stalled_task_trace(stru
 		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
-		 t->trc_reader_nesting,
+		 READ_ONCE(t->trc_reader_nesting),
 		 " N"[!!t->trc_reader_special.b.need_qs],
 		 cpu);
 	sched_show_task(t);
@@ -1141,7 +1142,7 @@ static void rcu_tasks_trace_postgp(struc
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
 	WRITE_ONCE(t->trc_reader_checked, true);
-	WARN_ON_ONCE(t->trc_reader_nesting);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 	WRITE_ONCE(t->trc_reader_nesting, 0);
 	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
 		rcu_read_unlock_trace_special(t, 0);


