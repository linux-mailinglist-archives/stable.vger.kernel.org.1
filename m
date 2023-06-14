Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C4726B39
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjFGUX5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjFGUXd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616D26B0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08CE9643FB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCBAC433D2;
        Wed,  7 Jun 2023 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169340;
        bh=7ptuenahrdkEQ4aFp/LLeeqYa2ll3otV6xsPHZffqjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzqseigtVh3D6nCR4MwutvTqi2rcWCtTJ4ECds5bePhPyVz8L8wnLCpGt6bz86owj
         B9pupb8WkyhBvXvKY+yAJiHi2Sbesfkk1N/jELTikZ90SNmfQc7XuWVk7AQWzUSuaE
         +73cWZwD8tf9zmAftj6CLuqW7CbvLtAJkHsqJTpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 044/286] RDMA/irdma: Prevent QP use after free
Date:   Wed,  7 Jun 2023 22:12:23 +0200
Message-ID: <20230607200924.490495902@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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
index 1b2e3e800c9a6..446a0ab3faaa5 100644
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



