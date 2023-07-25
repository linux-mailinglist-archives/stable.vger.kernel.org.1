Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4C3761436
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjGYLRR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjGYLQ7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDC11A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D422961697
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF8C433C8;
        Tue, 25 Jul 2023 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283816;
        bh=sxe4xyPujOsgC73xIQuidt22+7GCj5b5oNjICd44H8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TITfQwhWtKR2V1w6WwjX0qzitXvu9O8NmEInrL333yhwYGRDOgTSdRvwWTzuKMtwG
         8y3m9uyqz2x/ezjkIelnsJfZY6VBNcwM2P/VsG9Nhv+Ocsr3vfiaxLi1GfIgQzHV5D
         c2g0v76PldZmoqWtAIWi1zQXl0/sDzfvA3PeaoL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 133/509] IB/hfi1: Use bitmap_zalloc() when applicable
Date:   Tue, 25 Jul 2023 12:41:12 +0200
Message-ID: <20230725104559.811517393@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit f86dbc9fc5d83384eae7eda0de17f823e8c81ca0 ]

Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid
some open-coded arithmetic in allocator arguments.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Link: https://lore.kernel.org/r/d46c6bc1869b8869244fa71943d2cad4104b3668.1637869925.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: c9358de193ec ("IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 1eb5a44a4ae6a..3f49633bf9855 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -202,9 +202,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 	if (!pq->reqs)
 		goto pq_reqs_nomem;
 
-	pq->req_in_use = kcalloc(BITS_TO_LONGS(hfi1_sdma_comp_ring_size),
-				 sizeof(*pq->req_in_use),
-				 GFP_KERNEL);
+	pq->req_in_use = bitmap_zalloc(hfi1_sdma_comp_ring_size, GFP_KERNEL);
 	if (!pq->req_in_use)
 		goto pq_reqs_no_in_use;
 
@@ -251,7 +249,7 @@ int hfi1_user_sdma_alloc_queues(struct hfi1_ctxtdata *uctxt,
 cq_nomem:
 	kmem_cache_destroy(pq->txreq_cache);
 pq_txreq_nomem:
-	kfree(pq->req_in_use);
+	bitmap_free(pq->req_in_use);
 pq_reqs_no_in_use:
 	kfree(pq->reqs);
 pq_reqs_nomem:
@@ -298,7 +296,7 @@ int hfi1_user_sdma_free_queues(struct hfi1_filedata *fd,
 			pq->wait,
 			!atomic_read(&pq->n_reqs));
 		kfree(pq->reqs);
-		kfree(pq->req_in_use);
+		bitmap_free(pq->req_in_use);
 		kmem_cache_destroy(pq->txreq_cache);
 		flush_pq_iowait(pq);
 		kfree(pq);
-- 
2.39.2



