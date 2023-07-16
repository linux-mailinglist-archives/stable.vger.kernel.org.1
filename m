Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63300755538
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjGPUim (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjGPUil (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16B9560EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D0C433C8;
        Sun, 16 Jul 2023 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539919;
        bh=JWXS6jErpeXi+JEzl+x0XNhfuTEEi5lbiBjSm6aQ+mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM4lxvXVZp4kf8j+Vh/OMYJgtHmbRawOBGaPxmaAw6a8vIc2Ls5H36tYGEHLTDYju
         nweVVfVeUX1QDafeOIw948TkQKA+vX/6+bzl1FltEyaAmVFAN0heNZka2BzNBf15pA
         oEo2j893ffTCFclPd/vVvF9ODzhwAW46eRmPIoGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/591] RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
Date:   Sun, 16 Jul 2023 21:45:18 +0200
Message-ID: <20230716194928.497010568@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8c0c80a8d3384..1589b1105f2ec 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -333,15 +333,21 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
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
index ab2cc1c67f70b..a143bd3580a27 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -405,6 +405,9 @@ static irqreturn_t bnxt_qplib_nq_irq(int irq, void *dev_instance)
 
 void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
 {
+	if (!nq->requested)
+		return;
+
 	tasklet_disable(&nq->nq_tasklet);
 	/* Mask h/w interrupt */
 	bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, false);
@@ -412,11 +415,10 @@ void bnxt_qplib_nq_stop_irq(struct bnxt_qplib_nq *nq, bool kill)
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
@@ -455,8 +457,10 @@ int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
 
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
index 061b2895dd9b5..e28f0eb5b55d4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -635,6 +635,10 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
 	struct bnxt_qplib_creq_ctx *creq;
 
 	creq = &rcfw->creq;
+
+	if (!creq->requested)
+		return;
+
 	tasklet_disable(&creq->creq_tasklet);
 	/* Mask h/w interrupts */
 	bnxt_qplib_ring_nq_db(&creq->creq_db.dbinfo, rcfw->res->cctx, false);
@@ -643,10 +647,8 @@ void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill)
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
@@ -692,8 +694,10 @@ int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
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



