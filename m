Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61256735440
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjFSKyE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjFSKxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:53:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB32105
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3545E60B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAAAC433C8;
        Mon, 19 Jun 2023 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171936;
        bh=tNWHf3/P/W6vR94VOLieI6eO3dxtn/XkWHR5Jv73e94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7s5szuRyC4OcRuhnNlUxmxJzXu+jnWx9+Vn8qzrkdm+ngkt7RbA0rrhGZ2KRu/n/
         C+iK8JIt5nBnYO8RhbtVYfqCwyrkq3chMESTssBeToMQ9xPsc3dTO98iIJCQFnKX20
         prEBNFTkfSlvNBuk4rFbXVnoHoQKb02h8Ay4wBdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Ziemba <ian.ziemba@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 42/64] RDMA/rxe: Removed unused name from rxe_task struct
Date:   Mon, 19 Jun 2023 12:30:38 +0200
Message-ID: <20230619102135.093905312@linuxfoundation.org>
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

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit de669ae8af49ceed0eed44f5b3d51dc62affc5e4 ]

The name field in struct rxe_task is never used. This patch removes it.

Link: https://lore.kernel.org/r/20221021200118.2163-4-rpearsonhpe@gmail.com
Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: 2a62b6210ce8 ("RDMA/rxe: Fix the use-before-initialization error of resp_pkts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 9 +++------
 drivers/infiniband/sw/rxe/rxe_task.c | 4 +---
 drivers/infiniband/sw/rxe/rxe_task.h | 4 +---
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 5b59907594f75..c36000e08f65d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -278,10 +278,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(&qp->req.task, qp,
-		      rxe_requester, "req");
-	rxe_init_task(&qp->comp.task, qp,
-		      rxe_completer, "comp");
+	rxe_init_task(&qp->req.task, qp, rxe_requester);
+	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
 	if (init->qp_type == IB_QPT_RC) {
@@ -327,8 +325,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(&qp->resp.task, qp,
-		      rxe_responder, "resp");
+	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
 	qp->resp.msn		= 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index ea7d5a69eb2a3..39b3adda16550 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -114,12 +114,10 @@ void rxe_do_task(unsigned long data)
 	task->ret = ret;
 }
 
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name)
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *))
 {
 	task->arg	= arg;
 	task->func	= func;
-	snprintf(task->name, sizeof(task->name), "%s", name);
 	task->destroyed	= false;
 
 	tasklet_init(&task->tasklet, rxe_do_task, (unsigned long)task);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index e87ee072e3179..ecd81b1d1a8cb 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -52,7 +52,6 @@ struct rxe_task {
 	void			*arg;
 	int			(*func)(void *arg);
 	int			ret;
-	char			name[16];
 	bool			destroyed;
 };
 
@@ -61,8 +60,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	fcn  => function to call until it returns != 0
  */
-int rxe_init_task(struct rxe_task *task,
-		  void *arg, int (*func)(void *), char *name);
+int rxe_init_task(struct rxe_task *task, void *arg, int (*func)(void *));
 
 /* cleanup task */
 void rxe_cleanup_task(struct rxe_task *task);
-- 
2.39.2



