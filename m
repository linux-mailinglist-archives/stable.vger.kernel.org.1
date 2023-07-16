Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AC755588
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGPUlu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGPUlt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:41:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0CBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B360260E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B4C433C8;
        Sun, 16 Jul 2023 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540107;
        bh=2ted/eJLqgxXXbao25Kces2KMcpmj+UtsjKnYVJA2ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQlqg1vGwj752ZGeyWHZQdDP+CA63myw/O3urQleGM6dhu0zF6AOZ6GS3ZSHr5i0z
         ESQsJh6QuuAyuO/yOwSgFDgaNgMXMuiQliA62zwpXsH14PMnKN94wThXMwpEg1X8Z9
         eL8rRwQs1g9K0hMK9JTbn9DquTKskn9ULUET6fqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 245/591] RDMA/rxe: Fix access checks in rxe_check_bind_mw
Date:   Sun, 16 Jul 2023 21:46:24 +0200
Message-ID: <20230716194930.208203565@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit 425e1c9018fdf25cb4531606cc92d9d01a55534f ]

The subroutine rxe_check_bind_mw() in rxe_mw.c performs checks on the mw
access flags before they are set so they always succeed.  This patch
instead checks the access flags passed in the send wqe.

Fixes: 32a577b4c3a9 ("RDMA/rxe: Add support for bind MW work requests")
Link: https://lore.kernel.org/r/20230530221334.89432-4-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_mw.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 70252991320a0..cebc9f0f428d8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -48,7 +48,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 }
 
 static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-			 struct rxe_mw *mw, struct rxe_mr *mr)
+			 struct rxe_mw *mw, struct rxe_mr *mr, int access)
 {
 	if (mw->ibmw.type == IB_MW_TYPE_1) {
 		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
@@ -58,7 +58,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 
 		/* o10-36.2.2 */
-		if (unlikely((mw->access & IB_ZERO_BASED))) {
+		if (unlikely((access & IB_ZERO_BASED))) {
 			rxe_dbg_mw(mw, "attempt to bind a zero based type 1 MW\n");
 			return -EINVAL;
 		}
@@ -104,7 +104,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	/* C10-74 */
-	if (unlikely((mw->access &
+	if (unlikely((access &
 		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
 		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
 		rxe_dbg_mw(mw,
@@ -113,7 +113,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	/* C10-75 */
-	if (mw->access & IB_ZERO_BASED) {
+	if (access & IB_ZERO_BASED) {
 		if (unlikely(wqe->wr.wr.mw.length > mr->ibmr.length)) {
 			rxe_dbg_mw(mw,
 				"attempt to bind a ZB MW outside of the MR\n");
@@ -133,12 +133,12 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 }
 
 static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-		      struct rxe_mw *mw, struct rxe_mr *mr)
+		      struct rxe_mw *mw, struct rxe_mr *mr, int access)
 {
 	u32 key = wqe->wr.wr.mw.rkey & 0xff;
 
 	mw->rkey = (mw->rkey & ~0xff) | key;
-	mw->access = wqe->wr.wr.mw.access;
+	mw->access = access;
 	mw->state = RXE_MW_STATE_VALID;
 	mw->addr = wqe->wr.wr.mw.addr;
 	mw->length = wqe->wr.wr.mw.length;
@@ -169,6 +169,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 mw_rkey = wqe->wr.wr.mw.mw_rkey;
 	u32 mr_lkey = wqe->wr.wr.mw.mr_lkey;
+	int access = wqe->wr.wr.mw.access;
 
 	mw = rxe_pool_get_index(&rxe->mw_pool, mw_rkey >> 8);
 	if (unlikely(!mw)) {
@@ -198,11 +199,11 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	spin_lock_bh(&mw->lock);
 
-	ret = rxe_check_bind_mw(qp, wqe, mw, mr);
+	ret = rxe_check_bind_mw(qp, wqe, mw, mr, access);
 	if (ret)
 		goto err_unlock;
 
-	rxe_do_bind_mw(qp, wqe, mw, mr);
+	rxe_do_bind_mw(qp, wqe, mw, mr, access);
 err_unlock:
 	spin_unlock_bh(&mw->lock);
 err_drop_mr:
-- 
2.39.2



