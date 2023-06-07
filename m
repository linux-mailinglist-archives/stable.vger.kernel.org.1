Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24695726F45
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFGU5C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjFGU5B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3691721
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AE7E64860
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E83C433EF;
        Wed,  7 Jun 2023 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171414;
        bh=Uv8bA0kQy+2cnX7Ytg4uQ9Hv5Sl8d17ax+D6XsFribo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/AWsFAHDuN4UwK0n2UdGocPhr80y2XcM3kwBSUQxrexTQAS6ChvhVUHlm7St+ACa
         he7FaMkOSPqsi4xLhWGWYNXwHL20MA/6Qr3vUSF5GB0J3TlxI4QCVJY1dL69609vYE
         83ad/29csENJe8yV8rYeBC1TeRemBXsqBZEyICcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 001/159] RDMA/bnxt_re: Fix the page_size used during the MR creation
Date:   Wed,  7 Jun 2023 22:15:04 +0200
Message-ID: <20230607200903.706359803@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit 08c7f09356e45d093d1867c7a3c6ac6526e2f98b ]

Driver populates the list of pages used for Memory region wrongly when
page size is more than system page size. This is causing a failure when
some of the applications that creates MR with page size as 2M.  Since HW
can support multiple page sizes, pass the correct page size while creating
the MR.

Also, driver need not adjust the number of pages when HW Queues are
created with user memory. It should work with the number of dma blocks
returned by ib_umem_num_dma_blocks. Fix this calculation also.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Fixes: f6919d56388c ("RDMA/bnxt_re: Code refactor while populating user MRs")
Link: https://lore.kernel.org/r/1683484169-9539-1-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 12 ++----------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  7 +++----
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 44282a8cdd4f2..384d41072c63c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -215,17 +215,9 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			return -EINVAL;
 		hwq_attr->sginfo->npages = npages;
 	} else {
-		unsigned long sginfo_num_pages = ib_umem_num_dma_blocks(
-			hwq_attr->sginfo->umem, hwq_attr->sginfo->pgsize);
-
+		npages = ib_umem_num_dma_blocks(hwq_attr->sginfo->umem,
+						hwq_attr->sginfo->pgsize);
 		hwq->is_user = true;
-		npages = sginfo_num_pages;
-		npages = (npages * PAGE_SIZE) /
-			  BIT_ULL(hwq_attr->sginfo->pgshft);
-		if ((sginfo_num_pages * PAGE_SIZE) %
-		     BIT_ULL(hwq_attr->sginfo->pgshft))
-			if (!npages)
-				npages++;
 	}
 
 	if (npages == MAX_PBL_LVL_0_PGS) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 3d9259632eb3d..a161e0d3cb444 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -680,16 +680,15 @@ int bnxt_qplib_reg_mr(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mr,
 		/* Free the hwq if it already exist, must be a rereg */
 		if (mr->hwq.max_elements)
 			bnxt_qplib_free_hwq(res, &mr->hwq);
-		/* Use system PAGE_SIZE */
 		hwq_attr.res = res;
 		hwq_attr.depth = pages;
-		hwq_attr.stride = buf_pg_size;
+		hwq_attr.stride = sizeof(dma_addr_t);
 		hwq_attr.type = HWQ_TYPE_MR;
 		hwq_attr.sginfo = &sginfo;
 		hwq_attr.sginfo->umem = umem;
 		hwq_attr.sginfo->npages = pages;
-		hwq_attr.sginfo->pgsize = PAGE_SIZE;
-		hwq_attr.sginfo->pgshft = PAGE_SHIFT;
+		hwq_attr.sginfo->pgsize = buf_pg_size;
+		hwq_attr.sginfo->pgshft = ilog2(buf_pg_size);
 		rc = bnxt_qplib_alloc_init_hwq(&mr->hwq, &hwq_attr);
 		if (rc) {
 			dev_err(&res->pdev->dev,
-- 
2.39.2



