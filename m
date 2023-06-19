Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F173543F
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjFSKyD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjFSKxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AD210E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27D860B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0201BC433C0;
        Mon, 19 Jun 2023 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171939;
        bh=E3WtD4ri3V2ev/KycjV8WF81HPd9edQPoBnOSKGwN44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpvob5Ulox7jloU8NGeQEhVKNAW+F5xf7cBEEnd2PMVsnpDNWcBFwUKOxEVjPw/Hr
         3Od4GLrpx+zYKZwtVT63rlTSb9TBBq+K+ETk8t90nc8qrdtbstwt6iHgSXQNtXGlHE
         GzFBLsfhBfTP9OK9glO0VtoDEHZEh12PDm9YiKhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 43/64] RDMA/rxe: Fix the use-before-initialization error of resp_pkts
Date:   Mon, 19 Jun 2023 12:30:39 +0200
Message-ID: <20230619102135.147004562@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
References: <20230619102132.808972458@linuxfoundation.org>
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

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit 2a62b6210ce876c596086ab8fd4c8a0c3d10611a ]

In the following:

  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
   assign_lock_key kernel/locking/lockdep.c:982 [inline]
   register_lock_class+0xdb6/0x1120 kernel/locking/lockdep.c:1295
   __lock_acquire+0x10a/0x5df0 kernel/locking/lockdep.c:4951
   lock_acquire kernel/locking/lockdep.c:5691 [inline]
   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
   skb_dequeue+0x20/0x180 net/core/skbuff.c:3639
   drain_resp_pkts drivers/infiniband/sw/rxe/rxe_comp.c:555 [inline]
   rxe_completer+0x250d/0x3cc0 drivers/infiniband/sw/rxe/rxe_comp.c:652
   rxe_qp_do_cleanup+0x1be/0x820 drivers/infiniband/sw/rxe/rxe_qp.c:761
   execute_in_process_context+0x3b/0x150 kernel/workqueue.c:3473
   __rxe_cleanup+0x21e/0x370 drivers/infiniband/sw/rxe/rxe_pool.c:233
   rxe_create_qp+0x3f6/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:583

This is a use-before-initialization problem.

It happens because rxe_qp_do_cleanup is called during error unwind before
the struct has been fully initialized.

Move the initialization of the skb earlier.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/20230602035408.741534-1-yanjun.zhu@intel.com
Reported-by: syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c36000e08f65d..d93ed04276ac1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -219,6 +219,9 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
+	skb_queue_head_init(&qp->req_pkts);
+	skb_queue_head_init(&qp->resp_pkts);
+
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
@@ -276,8 +279,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
 	rxe_init_task(&qp->req.task, qp, rxe_requester);
 	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
@@ -323,8 +324,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
-
 	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
-- 
2.39.2



