Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F45726D2F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjFGUkE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjFGUjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556782722
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:39:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77E0645DB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C7C433D2;
        Wed,  7 Jun 2023 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170367;
        bh=3qj6rJ3uvCLuNrY1Hd+24d/bu7yQq7OqvEZSE4B87lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh5JyC9Cg/SrTjXreAyGlJeBtDDMwuN3qdOx8+X5iMUCmGZX5MmQVoyeAHLWWPcW9
         4OlO8HrfWYA1eLfumcNvo4iTdHACunfROv2CAc3BG2f0I7ZOBMeqEyfnjzJv4tRwIG
         knTbPCHrKwn+t/7QM5GfSLc+6uCiB+B6vgBDQFTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/225] RDMA/irdma: Prevent QP use after free
Date:   Wed,  7 Jun 2023 22:13:41 +0200
Message-ID: <20230607200915.241753518@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Mustafa Ismail <mustafa.ismail@intel.com>

[ Upstream commit c8f304d75f6c6cc679a73f89591f9a915da38f09 ]

There is a window where the poll cq may use a QP that has been freed.
This can happen if a CQE is polled before irdma_clean_cqes() can clear the
CQE's related to the QP and the destroy QP races to free the QP memory.
then the QP structures are used in irdma_poll_cq.  Fix this by moving the
clearing of CQE's before the reference is removed and the QP is destroyed.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Link: https://lore.kernel.org/r/20230522155654.1309-3-shiraz.saleem@intel.com
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda7..1c5a61f51a67a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -522,11 +522,6 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (!iwqp->user_mode)
 		cancel_delayed_work_sync(&iwqp->dwork_flush);
 
-	irdma_qp_rem_ref(&iwqp->ibqp);
-	wait_for_completion(&iwqp->free_qp);
-	irdma_free_lsmm_rsrc(iwqp);
-	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
-
 	if (!iwqp->user_mode) {
 		if (iwqp->iwscq) {
 			irdma_clean_cqes(iwqp, iwqp->iwscq);
@@ -534,6 +529,12 @@ static int irdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 				irdma_clean_cqes(iwqp, iwqp->iwrcq);
 		}
 	}
+
+	irdma_qp_rem_ref(&iwqp->ibqp);
+	wait_for_completion(&iwqp->free_qp);
+	irdma_free_lsmm_rsrc(iwqp);
+	irdma_cqp_qp_destroy_cmd(&iwdev->rf->sc_dev, &iwqp->sc_qp);
+
 	irdma_remove_push_mmap_entries(iwqp);
 	irdma_free_qp_rsrc(iwqp);
 
-- 
2.39.2



