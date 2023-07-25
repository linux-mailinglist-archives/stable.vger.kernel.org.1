Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7477761529
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjGYL0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjGYL0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C9199D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6CD61683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518AAC433C7;
        Tue, 25 Jul 2023 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284366;
        bh=gAolTunx6FQ0Dp1sP/7Ictd6qUQpdnAddEoJOcU0ZQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO5r3hrNkMpNRafst6YYNJGQSZqNOtJlwY4fQYSgQ6gga4AI6UZ7sooY1r6ajsBm5
         9pBv3gFa+65qXAsktOqy1BrdNuWt7Z0GUcX1rQf6BMakJ+JWg0URmnkZ2OF/v25v00
         3I1iSMcTEC0pHslzeoL2cRNLJ7IBFxmgLeTmq+ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 5.10 330/509] rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
Date:   Tue, 25 Jul 2023 12:44:29 +0200
Message-ID: <20230725104608.810799637@linuxfoundation.org>
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

[ Upstream commit f8ab3fad80dddf3f2cecb53983063c4431058ca1 ]

There are several ->trc_reader_special.b.need_qs data races that are
too low-probability for KCSAN to notice, but which will happen sooner
or later.  This commit therefore marks these accesses.

Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/rcu/tasks.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -801,7 +801,7 @@ static DEFINE_IRQ_WORK(rcu_tasks_trace_i
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	int nq = t->trc_reader_special.b.need_qs;
+	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
 
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
 	    t->trc_reader_special.b.need_mb)
@@ -867,7 +867,7 @@ static void trc_read_check_handler(void
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
@@ -919,7 +919,7 @@ static bool trc_inspect_reader(struct ta
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
@@ -1048,7 +1048,7 @@ static void show_stalled_task_trace(stru
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
 		 READ_ONCE(t->trc_reader_nesting),
-		 " N"[!!t->trc_reader_special.b.need_qs],
+		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
 	sched_show_task(t);
 }


