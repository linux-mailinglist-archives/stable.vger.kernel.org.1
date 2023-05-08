Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF776FA953
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjEHKuH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjEHKth (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586626761
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B4EE628DE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEC2C433D2;
        Mon,  8 May 2023 10:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542945;
        bh=CTLkxeQd8cmp8Mar/37Fn0j7B0XGUe51oyEXN7btVZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCk3QTPlxoClNwCFo/hLtDfvIrA+0If1m+Zwmos5DIopzb5Z+jiUXIJmdG+L8YDJg
         A96J4YHZydoIeGLSgWcixtQe/Lqr/keRsnd4YcKTBZ8f4RfHaMBV2Nly+j954bmxvh
         irKEu7mTt2SoQGw0chwfvBXOL3TRB9yCO9fAyRy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 564/663] RDMA/rxe: Convert tasklet args to queue pairs
Date:   Mon,  8 May 2023 11:46:30 +0200
Message-Id: <20230508094447.473882677@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 3946fc2a42b18cf0b675121158a2625825ce27b5 ]

Originally is was thought that the tasklet machinery in rxe_task.c would
be used in other applications but that has not happened for years. This
patch replaces the 'void *arg' by struct 'rxe_qp *qp' in the parameters to
the tasklet calls. This change will have no affect on performance but may
make the code a little clearer.

Link: https://lore.kernel.org/r/20230304174533.11296-2-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: b2b1ddc45745 ("RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |    3 +--
 drivers/infiniband/sw/rxe/rxe_loc.h  |    6 +++---
 drivers/infiniband/sw/rxe/rxe_req.c  |    3 +--
 drivers/infiniband/sw/rxe/rxe_resp.c |    3 +--
 drivers/infiniband/sw/rxe/rxe_task.c |   11 ++++++-----
 drivers/infiniband/sw/rxe/rxe_task.h |    9 +++++----
 6 files changed, 17 insertions(+), 18 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -571,9 +571,8 @@ static void free_pkt(struct rxe_pkt_info
 	ib_device_put(dev);
 }
 
-int rxe_completer(void *arg)
+int rxe_completer(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_send_wqe *wqe = NULL;
 	struct sk_buff *skb = NULL;
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -171,9 +171,9 @@ void rxe_srq_cleanup(struct rxe_pool_ele
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
-int rxe_completer(void *arg);
-int rxe_requester(void *arg);
-int rxe_responder(void *arg);
+int rxe_completer(struct rxe_qp *qp);
+int rxe_requester(struct rxe_qp *qp);
+int rxe_responder(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
 int rxe_icrc_init(struct rxe_dev *rxe);
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -635,9 +635,8 @@ static int rxe_do_local_ops(struct rxe_q
 	return 0;
 }
 
-int rxe_requester(void *arg)
+int rxe_requester(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1439,9 +1439,8 @@ static void rxe_drain_req_pkts(struct rx
 		queue_advance_consumer(q, q->type);
 }
 
-int rxe_responder(void *arg)
+int rxe_responder(struct rxe_qp *qp)
 {
-	struct rxe_qp *qp = (struct rxe_qp *)arg;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -11,7 +11,7 @@ int __rxe_do_task(struct rxe_task *task)
 {
 	int ret;
 
-	while ((ret = task->func(task->arg)) == 0)
+	while ((ret = task->func(task->qp)) == 0)
 		;
 
 	task->ret = ret;
@@ -29,7 +29,7 @@ static void do_task(struct tasklet_struc
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
-	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
+	struct rxe_qp *qp = (struct rxe_qp *)task->qp;
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->lock);
@@ -54,7 +54,7 @@ static void do_task(struct tasklet_struc
 
 	do {
 		cont = 0;
-		ret = task->func(task->arg);
+		ret = task->func(task->qp);
 
 		spin_lock_bh(&task->lock);
 		switch (task->state) {
@@ -91,9 +91,10 @@ static void do_task(struct tasklet_struc
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *))
 {
-	task->arg	= arg;
+	task->qp	= qp;
 	task->func	= func;
 	task->destroyed	= false;
 
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -22,18 +22,19 @@ struct rxe_task {
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		lock;
-	void			*arg;
-	int			(*func)(void *arg);
+	struct rxe_qp		*qp;
+	int			(*func)(struct rxe_qp *qp);
 	int			ret;
 	bool			destroyed;
 };
 
 /*
  * init rxe_task structure
- *	arg  => parameter to pass to fcn
+ *	qp  => parameter to pass to func
  *	func => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
+int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
+		  int (*func)(struct rxe_qp *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);


