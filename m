Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44CC761422
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjGYLQo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjGYLQa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBD19BB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421A861600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DEBC433C8;
        Tue, 25 Jul 2023 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283768;
        bh=srdNW3KA/ESxDiAPCZBwlNGf3naUGBD9A8JBzCbZTHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0HXAhjdZtwkxImyEDsZBJrnTimqKZgHyhnMwzM033OSOtquQ5g57L7P9A3gXpnYg
         L+SBiII/bfRaOPeZ8XP0a9j3jEKWhTCxKcK7GYvzWFbkWd6skKODLbngq1f3wuoLeh
         9Njdk55csnnxZ/aXPkc2KPb59vH8L/FwcrSaV0pI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 115/509] RDMA/bnxt_re: Fix to remove unnecessary return labels
Date:   Tue, 25 Jul 2023 12:40:54 +0200
Message-ID: <20230725104558.959551499@linuxfoundation.org>
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

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 9b3ee47796f529e5bc31a355d6cb756d68a7079a ]

If there is no cleanup needed then just return directly.  This cleans up
the code and improve readability.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1684478897-12247-3-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 9eba4b39c7032..b4b180652c0a0 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1603,7 +1603,7 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 		il_src = (void *)wqe->sg_list[indx].addr;
 		t_len += len;
 		if (t_len > qp->max_inline_data)
-			goto bad;
+			return -ENOMEM;
 		while (len) {
 			if (pull_dst) {
 				pull_dst = false;
@@ -1627,8 +1627,6 @@ static int bnxt_qplib_put_inline(struct bnxt_qplib_qp *qp,
 	}
 
 	return t_len;
-bad:
-	return -ENOMEM;
 }
 
 static u32 bnxt_qplib_put_sges(struct bnxt_qplib_hwq *hwq,
@@ -2058,7 +2056,7 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 	hwq_attr.sginfo = &cq->sg_info;
 	rc = bnxt_qplib_alloc_init_hwq(&cq->hwq, &hwq_attr);
 	if (rc)
-		goto exit;
+		return rc;
 
 	RCFW_CMD_PREP(req, CREATE_CQ, cmd_flags);
 
@@ -2099,7 +2097,6 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
 
 fail:
 	bnxt_qplib_free_hwq(res, &cq->hwq);
-exit:
 	return rc;
 }
 
-- 
2.39.2



