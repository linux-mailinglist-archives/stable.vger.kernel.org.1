Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253717CA284
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjJPIu7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJPIu6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:50:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9FE6
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:50:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374AFC433C9;
        Mon, 16 Oct 2023 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446256;
        bh=A/8p6tcMQGJIoXO8r43NTI1S5R9Si3JGRNQy+H15JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MavFkskaLdYDzz1w+a4jhmxtEi/CJx6DB7DKhsN/2MK0CI6RiXST74PajrkDn5n5p
         8A6eC68cT4dgdIdqmwwiAZkrE5mNC7+dxjkr4Oo9wEPHskSDPCKvJ0tO+aboFKY5qJ
         czt3U+fZfZD5ounjrX00lqp4/MyOYXJit6HuesGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joel Fernandes <joel@joelfernandes.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 5.15 100/102] Revert "kernel/sched: Modify initial boot task idle setup"
Date:   Mon, 16 Oct 2023 10:41:39 +0200
Message-ID: <20231016083956.370044054@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 3569ad59664f9fa3ba1d02a78810773b7f49702b which is
commit cff9b2332ab762b7e0586c793c431a8f2ea4db04 upstream.

Joel writes:
	Let us drop this patch because it caused new tasks-RCU warnings (both
	normal and rude tasks RCU) in my stable test rig. We are discussing
	the "right fix" and at that time a backport can be done.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |    2 +-
 kernel/sched/idle.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8725,7 +8725,7 @@ void __init init_idle(struct task_struct
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,7 +397,6 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)


