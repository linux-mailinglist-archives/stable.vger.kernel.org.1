Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E873533E
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFSKnV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjFSKm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA51E9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F201060B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4AC433C8;
        Mon, 19 Jun 2023 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171364;
        bh=7Zti3rLSbg2i7TwjMSBLBCiPLgHQh4iBf3OgBaEUygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUaaxk2v92PG0WBVGI116GMM/giZ/BwonouEarqacAE4v3xguuGDPJnw5uEWZ8bTP
         6CM3UqkBBPV2m40CxBZ1aM7KqOZs9A/SFIFLfW6uW9WCbkWzFhqiuOZ1ZCCEI9lg0T
         xMaT5X6IgWfQsuUvDFeMirxwcnXwnoA8aY3u6QoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/49] RDMA/rxe: Remove the unused variable obj
Date:   Mon, 19 Jun 2023 12:30:07 +0200
Message-ID: <20230619102131.408374788@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
References: <20230619102129.856988902@linuxfoundation.org>
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

[ Upstream commit f07853582d1f6ed282f8d9a0b1209a87dd761f58 ]

The member variable obj in struct rxe_task is not needed.
So remove it to save memory.

Link: https://lore.kernel.org/r/20220822011615.805603-4-yanjun.zhu@linux.dev
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 2a62b6210ce8 ("RDMA/rxe: Fix the use-before-initialization error of resp_pkts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c | 3 +--
 drivers/infiniband/sw/rxe/rxe_task.h | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 2cae62ae6c64a..a797b5d23f507 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -268,9 +268,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->req_pkts);
 
-	rxe_init_task(rxe, &qp->req.task, qp,
+	rxe_init_task(&qp->req.task, qp,
 		      rxe_requester, "req");
-	rxe_init_task(rxe, &qp->comp.task, qp,
+	rxe_init_task(&qp->comp.task, qp,
 		      rxe_completer, "comp");
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
@@ -317,7 +317,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	skb_queue_head_init(&qp->resp_pkts);
 
-	rxe_init_task(rxe, &qp->resp.task, qp,
+	rxe_init_task(&qp->resp.task, qp,
 		      rxe_responder, "resp");
 
 	qp->resp.opcode		= OPCODE_NONE;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 08f05ac5f5d52..ea7d5a69eb2a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -114,10 +114,9 @@ void rxe_do_task(unsigned long data)
 	task->ret = ret;
 }
 
-int rxe_init_task(void *obj, struct rxe_task *task,
+int rxe_init_task(struct rxe_task *task,
 		  void *arg, int (*func)(void *), char *name)
 {
-	task->obj	= obj;
 	task->arg	= arg;
 	task->func	= func;
 	snprintf(task->name, sizeof(task->name), "%s", name);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 08ff42d451c62..e87ee072e3179 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -46,7 +46,6 @@ enum {
  * called again.
  */
 struct rxe_task {
-	void			*obj;
 	struct tasklet_struct	tasklet;
 	int			state;
 	spinlock_t		state_lock; /* spinlock for task state */
@@ -62,7 +61,7 @@ struct rxe_task {
  *	arg  => parameter to pass to fcn
  *	fcn  => function to call until it returns != 0
  */
-int rxe_init_task(void *obj, struct rxe_task *task,
+int rxe_init_task(struct rxe_task *task,
 		  void *arg, int (*func)(void *), char *name);
 
 /* cleanup task */
-- 
2.39.2



