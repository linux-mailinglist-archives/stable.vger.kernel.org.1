Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4007B88A9
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjJDSSY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjJDSJN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F44EA7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D90C433C9;
        Wed,  4 Oct 2023 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442950;
        bh=Tcwq+xGKcpVCWOPbN8uBW2q2ldL/23NronKrL9DoNek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2UM0Gn4nUjEP3bFDtt2oWOT+IzWvnN46vbpUSTgHQtqgn//5f+2MPONu8Cr6gFot
         im9Z6xGdi/rM5JbRi8sJZog5lu+Urlumsw2QDvvoUiZcBxY330rrooKfEirftZriVl
         WXMMZDar06MeGMW/9pas4N9rKx4Uk1MnLxWb7wTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 167/183] kernel/sched: Modify initial boot task idle setup
Date:   Wed,  4 Oct 2023 19:56:38 +0200
Message-ID: <20231004175211.028740732@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit cff9b2332ab762b7e0586c793c431a8f2ea4db04 upstream.

Initial booting is setting the task flag to idle (PF_IDLE) by the call
path sched_init() -> init_idle().  Having the task idle and calling
call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
set.  Subsequent calls to any cond_resched() will enable IRQs,
potentially earlier than the IRQ setup has completed.  Recent changes
have caused just this scenario and IRQs have been enabled early.

This causes a warning later in start_kernel() as interrupts are enabled
before they are fully set up.

Fix this issue by setting the PF_IDLE flag later in the boot sequence.

Although the boot task was marked as idle since (at least) d80e4fda576d,
I am not sure that it is wrong to do so.  The forced context-switch on
idle task was introduced in the tiny_rcu update, so I'm going to claim
this fixes 5f6130fa52ee.

Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |    2 +-
 kernel/sched/idle.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8725,7 +8725,7 @@ void __init init_idle(struct task_struct
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,6 +397,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)


