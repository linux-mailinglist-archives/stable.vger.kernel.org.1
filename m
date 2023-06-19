Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B347352E8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFSKjY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFSKjW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E17C6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A6DA60B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1C2C433C0;
        Mon, 19 Jun 2023 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171160;
        bh=U8cqqUwwZx1u9yAoqLL8HzTJq7jMDHptyOB6V5l+v3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eI/OE1Che3XGy+N8qJkCXOsVB6jEec70paY+UTxV8FIFwt9itNenNQj+o1E3ekxHj
         KvR2460vGYcNJguqRbgOKbBuA1+dF2LJHlGglDeCgbechw8NCEPuGOO3MO1EG6fQer
         +6iTvXPBVK9TQl0ZpnWdF0bx+7R7trGc/TUXLR5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 169/187] RDMA/rxe: Fix rxe_cq_post
Date:   Mon, 19 Jun 2023 12:29:47 +0200
Message-ID: <20230619102205.824964917@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

[ Upstream commit 0c7e314a6352664e12ec465f576cf039e95f8369 ]

A recent patch replaced a tasklet execution of cq->comp_handler by a
direct call. While this made sense it let changes to cq->notify state be
unprotected and assumed that the cq completion machinery and the ulp done
callbacks were reentrant. The result is that in some cases completion
events can be lost. This patch moves the cq->comp_handler call inside of
the spinlock in rxe_cq_post which solves both issues. This is compatible
with the matching code in the request notify verb.

Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
Link: https://lore.kernel.org/r/20230612155032.17036-1-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 519ddec29b4ba..d6113329fee61 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -112,8 +112,6 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
-
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
@@ -121,6 +119,8 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 	}
 
+	spin_unlock_irqrestore(&cq->cq_lock, flags);
+
 	return 0;
 }
 
-- 
2.39.2



