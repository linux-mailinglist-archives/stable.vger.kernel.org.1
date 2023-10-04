Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5567B8277
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242886AbjJDOfP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbjJDOfL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:35:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFCA10A
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:35:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD096C433C9;
        Wed,  4 Oct 2023 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696430102;
        bh=D60E0d92O7jHKrcvlNM+ewLdJwI585Cdp2Cb7VclGDw=;
        h=Subject:To:Cc:From:Date:From;
        b=usxrBd/73kOmHQK4PR/oV6Pv183SySroGhVpis/v3RfNMYN5B2cz9BJTTFYnUu8IX
         dZGy88uYmekYZ/PsuoiTR6N94DX7AEhqBMKv/ID1Zjf/dwOJedydXJLRzsfgb3ousd
         pCIK2Sl/sCjxfXzkd8kfRoB3ma6iOTuVIN8Ok+Yo=
Subject: FAILED: patch "[PATCH] kernel/sched: Modify initial boot task idle setup" failed to apply to 4.19-stable tree
To:     Liam.Howlett@oracle.com, peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:34:54 +0200
Message-ID: <2023100454-crawlers-crinkle-fea4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x cff9b2332ab762b7e0586c793c431a8f2ea4db04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100454-crawlers-crinkle-fea4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cff9b2332ab762b7e0586c793c431a8f2ea4db04 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Fri, 15 Sep 2023 13:44:44 -0400
Subject: [PATCH] kernel/sched: Modify initial boot task idle setup

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

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..802551e0009b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..5007b25c5bc6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)

