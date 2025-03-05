Return-Path: <stable+bounces-120782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627AA50848
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37057A24F1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE42512F2;
	Wed,  5 Mar 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZObfjGUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF7250BFB;
	Wed,  5 Mar 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197957; cv=none; b=U6hQ8fnX1AGYEySTO38lFcFADr3TkzQjEoJTHYkV3MYrUQKx/kAunLQmPykdFI7FHr6BIaYD/6kuiH3Hd6p0dmfQxh6QcpjNAxN4SfgnnZa9NecjSQDmqKyIRe3Q4TEO07sx6/oik2s+0d1Q45jNxaX+RvBxT7K+FWE+Ro3F3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197957; c=relaxed/simple;
	bh=NsieWwOK8IKjU6I8SsyMrMS4Mr83sda9eUheCek9fWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAGtBaZel/VPdnsaYr63Nrvk0CLGIIiZyR619ctmKffPhXLCMRrMUgu2C4bI63Hyxnl2YvTveiQJ+Q1+Yf8KiveDXwGAm6LwXyCAvGDPx425KLB5jA8bv9pM77H9X6Tl5VV3ILvhG5rRNLCxpXFi3D5Wu1coj9NsmDsjJYDTwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZObfjGUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABF6C4CEE2;
	Wed,  5 Mar 2025 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197957;
	bh=NsieWwOK8IKjU6I8SsyMrMS4Mr83sda9eUheCek9fWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZObfjGUtJg2G1jYWIEdnYYzW8TI2uSpbkuUlMX74NJRA8oT5kJR3MtHG1I+KO8NVb
	 HKV6nXrUzJLAn25l8n3Ayg02sRJVlF5UrVHOQ0jmo0PuyYLl1vuge68bqUuopNj71D
	 2GZfZns/WYegnSSwt5Re1EgIlG8LGKOnKpXR+QCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 008/150] RDMA/bnxt_re: Refactor NQ allocation
Date: Wed,  5 Mar 2025 18:47:17 +0100
Message-ID: <20250305174504.141461223@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 30b871338c3ebab4c5efb74f6b23b59f1ac4ca1f ]

Move NQ related data structures from rdev to a new structure
named "struct bnxt_re_nq_record" by keeping a pointer to in
the rdev structure. Allocate the memory for it dynamically.
This change is needed for subsequent patches in the series.

Also, removed the nq_task variable from rdev structure as it
is redundant and no longer used.

This change would help to reduce the size of the driver private
structure as well.

Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://patch.msgid.link/1731577748-1804-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: f0df225d12fc ("RDMA/bnxt_re: Add sanity checks on rdev validity")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 13 +++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  6 +-
 drivers/infiniband/hw/bnxt_re/main.c     | 74 ++++++++++++++++--------
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 7a1acad232c5e..2a5cb66402860 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -155,6 +155,11 @@ struct bnxt_re_pacing {
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
 #define BNXT_RE_MIN_MSIX		2
+#define BNXT_RE_MAX_MSIX		BNXT_MAX_ROCE_MSIX
+struct bnxt_re_nq_record {
+	struct bnxt_qplib_nq	nq[BNXT_RE_MAX_MSIX];
+	int			num_msix;
+};
 
 #define MAX_CQ_HASH_BITS		(16)
 #define MAX_SRQ_HASH_BITS		(16)
@@ -176,21 +181,17 @@ struct bnxt_re_dev {
 	unsigned int			version, major, minor;
 	struct bnxt_qplib_chip_ctx	*chip_ctx;
 	struct bnxt_en_dev		*en_dev;
-	int				num_msix;
 
 	int				id;
 
 	struct delayed_work		worker;
 	u8				cur_prio_map;
 
-	/* FP Notification Queue (CQ & SRQ) */
-	struct tasklet_struct		nq_task;
-
 	/* RCFW Channel */
 	struct bnxt_qplib_rcfw		rcfw;
 
-	/* NQ */
-	struct bnxt_qplib_nq		nq[BNXT_MAX_ROCE_MSIX];
+	/* NQ record */
+	struct bnxt_re_nq_record	*nqr;
 
 	/* Device Resources */
 	struct bnxt_qplib_dev_attr	dev_attr;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a7067c3c06797..11e2b3dee2a53 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1814,8 +1814,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size(dev_attr->max_srq_sges);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
-	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
-	nq = &rdev->nq[0];
+	srq->qplib_srq.eventq_hw_ring_id = rdev->nqr->nq[0].ring_id;
+	nq = &rdev->nqr->nq[0];
 
 	if (udata) {
 		rc = bnxt_re_init_user_srq(rdev, pd, srq, udata);
@@ -3070,7 +3070,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * used for getting the NQ index.
 	 */
 	nq_alloc_cnt = atomic_inc_return(&rdev->nq_alloc_cnt);
-	nq = &rdev->nq[nq_alloc_cnt % (rdev->num_msix - 1)];
+	nq = &rdev->nqr->nq[nq_alloc_cnt % (rdev->nqr->num_msix - 1)];
 	cq->qplib_cq.max_wqe = entries;
 	cq->qplib_cq.cnq_hw_ring_id = nq->ring_id;
 	cq->qplib_cq.nq	= nq;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 32ecc802afd13..310a80962d0eb 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -316,8 +316,8 @@ static void bnxt_re_stop_irq(void *handle)
 	rdev = en_info->rdev;
 	rcfw = &rdev->rcfw;
 
-	for (indx = BNXT_RE_NQ_IDX; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		bnxt_qplib_nq_stop_irq(nq, false);
 	}
 
@@ -349,7 +349,7 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	/* Vectors may change after restart, so update with new vectors
 	 * in device sctructure.
 	 */
-	for (indx = 0; indx < rdev->num_msix; indx++)
+	for (indx = 0; indx < rdev->nqr->num_msix; indx++)
 		rdev->en_dev->msix_entries[indx].vector = ent[indx].vector;
 
 	rc = bnxt_qplib_rcfw_start_irq(rcfw, msix_ent[BNXT_RE_AEQ_IDX].vector,
@@ -358,8 +358,8 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 		ibdev_warn(&rdev->ibdev, "Failed to reinit CREQ\n");
 		return;
 	}
-	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->num_msix; indx++) {
-		nq = &rdev->nq[indx - 1];
+	for (indx = BNXT_RE_NQ_IDX ; indx < rdev->nqr->num_msix; indx++) {
+		nq = &rdev->nqr->nq[indx - 1];
 		rc = bnxt_qplib_nq_start_irq(nq, indx - 1,
 					     msix_ent[indx].vector, false);
 		if (rc) {
@@ -943,7 +943,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 	addrconf_addr_eui48((u8 *)&ibdev->node_guid, rdev->netdev->dev_addr);
 
-	ibdev->num_comp_vectors	= rdev->num_msix - 1;
+	ibdev->num_comp_vectors	= rdev->nqr->num_msix - 1;
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
@@ -1276,8 +1276,8 @@ static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
 {
 	int i;
 
-	for (i = 1; i < rdev->num_msix; i++)
-		bnxt_qplib_disable_nq(&rdev->nq[i - 1]);
+	for (i = 1; i < rdev->nqr->num_msix; i++)
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i - 1]);
 
 	if (rdev->qplib_res.rcfw)
 		bnxt_qplib_cleanup_res(&rdev->qplib_res);
@@ -1291,9 +1291,9 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 
 	bnxt_qplib_init_res(&rdev->qplib_res);
 
-	for (i = 1; i < rdev->num_msix ; i++) {
+	for (i = 1; i < rdev->nqr->num_msix ; i++) {
 		db_offt = rdev->en_dev->msix_entries[i].db_offset;
-		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nq[i - 1],
+		rc = bnxt_qplib_enable_nq(rdev->en_dev->pdev, &rdev->nqr->nq[i - 1],
 					  i - 1, rdev->en_dev->msix_entries[i].vector,
 					  db_offt, &bnxt_re_cqn_handler,
 					  &bnxt_re_srqn_handler);
@@ -1307,20 +1307,22 @@ static int bnxt_re_init_res(struct bnxt_re_dev *rdev)
 	return 0;
 fail:
 	for (i = num_vec_enabled; i >= 0; i--)
-		bnxt_qplib_disable_nq(&rdev->nq[i]);
+		bnxt_qplib_disable_nq(&rdev->nqr->nq[i]);
 	return rc;
 }
 
 static void bnxt_re_free_nq_res(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_nq *nq;
 	u8 type;
 	int i;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
-		rdev->nq[i].res = NULL;
+		nq = &rdev->nqr->nq[i];
+		bnxt_re_net_ring_free(rdev, nq->ring_id, type);
+		bnxt_qplib_free_nq(nq);
+		nq->res = NULL;
 	}
 }
 
@@ -1362,12 +1364,12 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 	if (rc)
 		goto dealloc_res;
 
-	for (i = 0; i < rdev->num_msix - 1; i++) {
+	for (i = 0; i < rdev->nqr->num_msix - 1; i++) {
 		struct bnxt_qplib_nq *nq;
 
-		nq = &rdev->nq[i];
+		nq = &rdev->nqr->nq[i];
 		nq->hwq.max_elements = BNXT_QPLIB_NQE_MAX_CNT;
-		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, &rdev->nq[i]);
+		rc = bnxt_qplib_alloc_nq(&rdev->qplib_res, nq);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Alloc Failed NQ%d rc:%#x",
 				  i, rc);
@@ -1375,7 +1377,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 		}
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		rattr.dma_arr = nq->hwq.pbl[PBL_LVL_0].pg_map_arr;
-		rattr.pages = nq->hwq.pbl[rdev->nq[i].hwq.level].pg_count;
+		rattr.pages = nq->hwq.pbl[rdev->nqr->nq[i].hwq.level].pg_count;
 		rattr.type = type;
 		rattr.mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		rattr.depth = BNXT_QPLIB_NQE_MAX_CNT - 1;
@@ -1385,7 +1387,7 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 			ibdev_err(&rdev->ibdev,
 				  "Failed to allocate NQ fw id with rc = 0x%x",
 				  rc);
-			bnxt_qplib_free_nq(&rdev->nq[i]);
+			bnxt_qplib_free_nq(nq);
 			goto free_nq;
 		}
 		num_vec_created++;
@@ -1394,8 +1396,8 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 free_nq:
 	for (i = num_vec_created - 1; i >= 0; i--) {
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
-		bnxt_re_net_ring_free(rdev, rdev->nq[i].ring_id, type);
-		bnxt_qplib_free_nq(&rdev->nq[i]);
+		bnxt_re_net_ring_free(rdev, rdev->nqr->nq[i].ring_id, type);
+		bnxt_qplib_free_nq(&rdev->nqr->nq[i]);
 	}
 	bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
 			       &rdev->dpi_privileged);
@@ -1584,6 +1586,21 @@ static int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static int bnxt_re_alloc_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
+	if (!rdev->nqr)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
+{
+	kfree(rdev->nqr);
+	rdev->nqr = NULL;
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -1611,11 +1628,12 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 		bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 	}
 
-	rdev->num_msix = 0;
+	rdev->nqr->num_msix = 0;
 
 	if (rdev->pacing.dbr_pacing)
 		bnxt_re_deinitialize_dbr_pacing(rdev);
 
+	bnxt_re_free_nqr_mem(rdev);
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (op_type == BNXT_RE_COMPLETE_REMOVE) {
 		if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
@@ -1663,7 +1681,6 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	}
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->en_dev->ulp_tbl->msix_requested);
-	rdev->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
 
 	rc = bnxt_re_setup_chip_ctx(rdev);
 	if (rc) {
@@ -1673,6 +1690,15 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		return -EINVAL;
 	}
 
+	rc = bnxt_re_alloc_nqr_mem(rdev);
+	if (rc) {
+		bnxt_re_destroy_chip_ctx(rdev);
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return rc;
+	}
+	rdev->nqr->num_msix = rdev->en_dev->ulp_tbl->msix_requested;
+
 	/* Check whether VF or PF */
 	bnxt_re_get_sriov_func_type(rdev);
 
-- 
2.39.5




