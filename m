Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7FC70C6E9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjEVTXy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjEVTXp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6C102
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCEF6201A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDF6C433EF;
        Mon, 22 May 2023 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783420;
        bh=PNIokpclxdAzimCydZBKPG3yelQqnCeelkzUmquiXA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhi8mXVXG6M5VIVjyleitjutGt1LzU53IKtP8qzvUK8lGXdYsYSQXvnHm4w//aASO
         dMaEJ7WUvha/WCrsNEAbcuVd4elODByHmK/+8dOFYQuTcUYnK3GW/ROazcKGYUOIma
         W5pti0u08fjjVgSaitS06xEl4SJKcgCu/tQkSohI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zqiang <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/292] rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
Date:   Mon, 22 May 2023 20:06:35 +0100
Message-Id: <20230522190406.849783762@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

[ Upstream commit 3c1566bca3f8349f12b75d0a2d5e4a20ad6262ec ]

For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario can
result in a NULL-pointer dereference:

           CPU1                                           CPU2
rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
  if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
    raw_spin_lock_rcu_node
    np = rcu_next_node_entry(t, rnp)
    if (&t->rcu_node_entry == rnp->exp_tasks)
      WRITE_ONCE(rnp->exp_tasks, np)
      ....
      raw_spin_unlock_irqrestore_rcu_node
                                                    raw_spin_lock_irqsave_rcu_node
                                                    t = list_entry(rnp->exp_tasks->prev,
                                                        struct task_struct, rcu_node_entry)
                                                    (if rnp->exp_tasks is NULL, this
                                                       will dereference a NULL pointer)

The problem is that CPU2 accesses the rcu_node structure's->exp_tasks
field without holding the rcu_node structure's ->lock and CPU2 did
not observe CPU1's change to rcu_node structure's ->exp_tasks in time.
Therefore, if CPU1 sets rcu_node structure's->exp_tasks pointer to NULL,
then CPU2 might dereference that NULL pointer.

This commit therefore holds the rcu_node structure's ->lock while
accessing that structure's->exp_tasks field.

[ paulmck: Apply Frederic Weisbecker feedback. ]

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 60732264a7d0b..e25321dbb068e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -800,9 +800,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	int ndetected = 0;
 	struct task_struct *t;
 
-	if (!READ_ONCE(rnp->exp_tasks))
-		return 0;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!rnp->exp_tasks) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return 0;
+	}
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-- 
2.39.2



