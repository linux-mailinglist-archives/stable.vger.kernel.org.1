Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59CF75D22B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGUS4x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGUS4x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EF30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DB161D5E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF8C433C8;
        Fri, 21 Jul 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965799;
        bh=S5liufIbx0xVtt7IlZVld1tvwFxLnQnLZCP0+Kiires=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El6m9zfErpqXwEqRRHUs1neEHPFeTgojz29ErhMsOUp5zekaGqAJUAzNV2YF5EZz5
         gOheYiypqeW5MK/kVuT8bgv0nDdBL7bVkUFPKYpVwD7pddx59jWU1O9E/xdFXwnG3H
         Yo7gMvMKDhNHRBOiyv737i1fiV97dpjjcPikYQ3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 118/532] RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
Date:   Fri, 21 Jul 2023 18:00:22 +0200
Message-ID: <20230721160620.895026504@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit ab112ee7899d6171da5acd77a7ed7ae103f488de ]

When the ulp hook to start the IRQ fails because the rings are not
available, tasklets are not enabled. In this case when the driver is
unloaded, driver calls CREQ tasklet_kill. This causes an indefinite hang
as the tasklet is not enabled.

Driver shouldn't call tasklet_kill if it is not enabled. So using the
creq->requested and nq->requested flags to identify if both tasklets/irqs
are registered. Checking this flag while scheduling the tasklet from
ISR. Also, added a cleanup for disabling tasklet, in case request_irq
fails during start_irq.

Check for return value for bnxt_qplib_rcfw_start_irq and in case the
bnxt_qplib_rcfw_start_irq fails, return bnxt_re_start_irq without
attempting to start NQ IRQs.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1684478897-12247-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c       | 12 +++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 16 ++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 14 +++++++++-----
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 66268e41b470e..634e81b288454 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -331,15 +331,21 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	for (indx = 0; indx < rdev->num_msix; indx++)
 		rdev->msix_entries[indx].vector = ent[indx].vector;
 
-	bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
-				  false);
+	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
+				       false);
+	if (rc) {
+		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
+		return;
+	}
 	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
 		nq = &rdev->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
-		if (rc)
+		if (rc) {
 			ibdev_warn(&rdev->ibdev, "Failed to reinit NQ index %d\n",
 				   indx - 1);
+			return;
+		}
 	}
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index b26a89187a192..9eba4b39c7032 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -404,6 +404,9 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
+	if (!nq->requested)
+		return;
+
 	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
 	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, false);
@@ -411,11 +414,10 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 	synchronize_irq(nq->msix_vec);
 	if (kill)
 		tasklet_kill(&nq->nq_tasklet);
-	if (nq->requested) {
-		irq_set_affinity_hint(nq->msix_vec, NULL);
-		free_irq(nq->msix_vec, nq);
-		nq->requested = false;
-	}
+
+	irq_set_affinity_hint(nq->msix_vec, NULL);
+	free_irq(nq->msix_vec, nq);
+	nq->requested = false;
 }
 
 void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
@@ -454,8 +456,10 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 
 	snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
 	rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
-	if (rc)
+	if (rc) {
+		tasklet_disable(&nq->nq_tasklet);
 		return rc;
+	}
 
 	cpumask_clear(&nq->mask);
 	cpumask_set_cpu(nq_indx, &nq->mask);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index d2d39126f1852..2be30068574ce 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -637,6 +637,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
+
+	if (!creq->requested)
+		return;
+
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
@@ -645,10 +649,8 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	if (kill)
 		tasklet_kill(&creq->creq_tasklet);
 
-	if (creq->requested) {
-		free_irq(creq->msix_vec, rcfw);
-		creq->requested = false;
-	}
+	free_irq(creq->msix_vec, rcfw);
+	creq->requested = false;
 }
 
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
@@ -694,8 +696,10 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
 		tasklet_enable(&creq->creq_tasklet);
 	rc = request_irq(creq->msix_vec, bnxt_qplib_creq_irq, 0,
 			 "bnxt_qplib_creq", rcfw);
-	if (rc)
+	if (rc) {
+		tasklet_disable(&creq->creq_tasklet);
 		return rc;
+	}
 	creq->requested = true;
 
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, true);
-- 
2.39.2



