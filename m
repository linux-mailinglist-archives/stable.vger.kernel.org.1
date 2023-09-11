Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C142E79B4DC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjIKWJQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbjIKOOs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:14:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1795DC433C7;
        Mon, 11 Sep 2023 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441683;
        bh=O3v4fMQLZLi/mAdmWZ3/DHqjC5pFqYnktSoPz1E3pLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bRPClsHM/ndX6+f6Jb9tISWqupKYBgFGmBUdMrcVg/BFP4TXCWK4GN0+LQ7BvtZUG
         +WItwBujceX5s4G6e5YtjFr4yQHsI6Bs0jVV9WqA5Gk5szntOoW1sEKnuBQ1FfkdRQ
         /O8EezHqHciWQT7ofNZMj/J9ToBEeJ87wANsp8vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 492/739] RDMA/rxe: Fix unsafe drain work queue code
Date:   Mon, 11 Sep 2023 15:44:51 +0200
Message-ID: <20230911134704.871675222@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 5993b75d0bc71cd2b441d174b028fc36180f032c ]

If create_qp does not fully succeed it is possible for qp cleanup
code to attempt to drain the send or recv work queues before the
queues have been created causing a seg fault. This patch checks
to see if the queues exist before attempting to drain them.

Link: https://lore.kernel.org/r/20230620135519.9365-3-rpearsonhpe@gmail.com
Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 ++++
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 5111735aafaed..d0bdc2d8adc82 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -597,6 +597,10 @@ static void flush_send_queue(struct rxe_qp *qp, bool notify)
 	struct rxe_queue *q = qp->sq.queue;
 	int err;
 
+	/* send queue never got created. nothing to do. */
+	if (!qp->sq.queue)
+		return;
+
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
 			err = flush_send_wqe(qp, wqe);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 64c64f5f36a81..da470a925efc7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1469,6 +1469,10 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
 		return;
 	}
 
+	/* recv queue not created. nothing to do. */
+	if (!qp->rq.queue)
+		return;
+
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
 			err = flush_recv_wqe(qp, wqe);
-- 
2.40.1



