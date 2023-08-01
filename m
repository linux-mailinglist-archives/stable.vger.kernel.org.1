Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368776AF91
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjHAJsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjHAJsg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583ABE7C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F0761500
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343EC433C7;
        Tue,  1 Aug 2023 09:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883226;
        bh=Rg/tJd4BXlFdldG/BrS7MEaH0pDGOAi2q6vmb5a7uhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8cXHvXLCXD53+8qMrcIzzd2Y1oQ6h+XUbpV6w8/jx82se2oaCBNSjOe+LLPXh6gI
         unhpWP+/ubul1uoOpKQmdI+TSzId6tu6irHtEd/QmyHVJaQWKTAhxHWcZpOdXNZI/A
         hlbFl1GuXlyJWBe8HxP9q9A6SZffYaSeumfC+juk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 131/239] RDMA/irdma: Fix op_type reporting in CQEs
Date:   Tue,  1 Aug 2023 11:19:55 +0200
Message-ID: <20230801091930.431611854@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

[ Upstream commit 3bfb25fa2b5bb9c29681e6ac861808f4be1331a9 ]

The op_type field CQ poll info structure is incorrectly
filled in with the queue type as opposed to the op_type
received in the CQEs. The wrong opcode could be decoded
and returned to the ULP.

Copy the op_type field received in the CQE in the CQ poll
info structure.

Fixes: 24419777e943 ("RDMA/irdma: Fix RQ completion opcode")
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Link: https://lore.kernel.org/r/20230725155439.1057-1-shiraz.saleem@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/uk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index ea2c07751245a..280d633d4ec4f 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1161,7 +1161,7 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 	}
 	wqe_idx = (u32)FIELD_GET(IRDMA_CQ_WQEIDX, qword3);
 	info->qp_handle = (irdma_qp_handle)(unsigned long)qp;
-	info->op_type = (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
+	info->op_type = (u8)FIELD_GET(IRDMACQ_OP, qword3);
 
 	if (info->q_type == IRDMA_CQE_QTYPE_RQ) {
 		u32 array_idx;
-- 
2.40.1



