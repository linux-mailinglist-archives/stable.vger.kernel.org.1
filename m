Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4503726B17
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFGUW0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjFGUWZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E072716
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C37616A7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31896C433D2;
        Wed,  7 Jun 2023 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169321;
        bh=ubkwShuMRsrLDZ9OUH3IuRz6+tnhoAH3goOW1Z80uzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KGmWK7dCH6y/VMBRnQ/nDzlDNRF893s9h1AwUHAuRlmwiIPYa7FL4jnVPArY42AG2
         4os1OKFmtqCkLxFw72YNftc9HhdSNURKi3HOipsZoCVPeT8ro9d/5uLp1+iaKGF4sw
         g8QBduWGqmxGfKsyHzn8dEsuV4xU/Hs/NKphXU5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 008/286] RDMA/bnxt_re: Fix a possible memory leak
Date:   Wed,  7 Jun 2023 22:11:47 +0200
Message-ID: <20230607200923.268483348@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 349e3c0cf239cc01d58a1e6c749e171de014cd6a ]

Inside bnxt_qplib_create_cq(), when the check for NULL DPI fails, driver
returns directly without freeing the memory allocated inside
bnxt_qplib_alloc_init_hwq() routine.

Fixed this by moving the check for NULL DPI before invoking
bnxt_qplib_alloc_init_hwq().

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1684397461-23082-2-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 96e581ced50e2..ab2cc1c67f70b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2043,6 +2043,12 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	u32 pg_sz_lvl;
 	int rc;
 
+	if (!cq->dpi) {
+		dev_err(&rcfw->pdev->dev,
+			"FP: CREATE_CQ failed due to NULL DPI\n");
+		return -EINVAL;
+	}
+
 	hwq_attr.res = res;
 	hwq_attr.depth = cq->max_wqe;
 	hwq_attr.stride = sizeof(struct cq_base);
@@ -2054,11 +2060,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 	RCFW_CMD_PREP(req, CREATE_CQ, cmd_flags);
 
-	if (!cq->dpi) {
-		dev_err(&rcfw->pdev->dev,
-			"FP: CREATE_CQ failed due to NULL DPI\n");
-		return -EINVAL;
-	}
 	req.dpi = cpu_to_le32(cq->dpi->dpi);
 	req.cq_handle = cpu_to_le64(cq->cq_handle);
 	req.cq_size = cpu_to_le32(cq->hwq.max_elements);
-- 
2.39.2



