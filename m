Return-Path: <stable+bounces-88524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DE79B265B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DB42823CB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676918FC85;
	Mon, 28 Oct 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNq7zHIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197218F2CF;
	Mon, 28 Oct 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097528; cv=none; b=cEj98J3RfpeNqFrtwqX8YO3JTSfQjy+QgKK2yAmZmEJBo2+TVLd3lWYV4pDjNoxkhPGNEZ0M4sA9U4Wsd86lkzf6fzjYG2edsnChfZdHUmwjWP+GD9mOvbYQaIWh3UzBeBJHh8PzZ9rvIYjV3B/FMin+ZcKXmX+OV0FzquSWRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097528; c=relaxed/simple;
	bh=WVKk1wuYl0zIWZrE76JXuYsHsHDOt/KNUWgkjFuwerk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrKeCLlccDHMbR5CA379GWl/JhXyxB1ODX3tcQOb9OKJ83zum0gtCUdJbCjKA2xpoXUZEatC9iPg6lEbFqxI+jPOdIxlaNbWKChrnVA/09077o2ZPi82cpEV9uNYbxSGaVrNguKYjpiPscku7+sGFGMxju/7Qu0Ha2IXh1jwq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNq7zHIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01379C4CEC3;
	Mon, 28 Oct 2024 06:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097528;
	bh=WVKk1wuYl0zIWZrE76JXuYsHsHDOt/KNUWgkjFuwerk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNq7zHIbbbIgRi25CrhzR1Zyg1E56G1dXLMYBEcY+OZc3XAbepqUHDT6ty92Y5WML
	 T6Of+LyqBjCT/miesaFc/1z8LBpQKSoHGG4WRiKDQM5x5f/L6741jObpBuKVkcXl/d
	 8kPIfEW93CKO++qF1Qi1pHHdTgke+RBkfLwWgAUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 033/208] RDMA/bnxt_re: Support new 5760X P7 devices
Date: Mon, 28 Oct 2024 07:23:33 +0100
Message-ID: <20241028062307.473380287@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit 1801d87b3598b173bce3fbf15c5517796f38db96 ]

Add basic support for 5760X P7 devices. Add new chip
revisions. The first version support is similar to
the existing P5 adapters. Extend the current support
for P5 adapters to P7 also.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1701946060-13931-2-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: ac6df53738b4 ("RDMA/bnxt_re: Fix the max CQ WQEs for older adapters")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  4 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 10 +++++-----
 drivers/infiniband/hw/bnxt_re/main.c        | 14 +++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c    |  4 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c  |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h   | 20 +++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  6 +++---
 8 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 93572405d6fae..128651c015956 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -371,7 +371,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	}
 
 done:
-	return bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 		BNXT_RE_NUM_EXT_COUNTERS : BNXT_RE_NUM_STD_COUNTERS;
 }
 
@@ -381,7 +381,7 @@ struct rdma_hw_stats *bnxt_re_ib_alloc_hw_port_stats(struct ib_device *ibdev,
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	int num_counters = 0;
 
-	if (bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		num_counters = BNXT_RE_NUM_EXT_COUNTERS;
 	else
 		num_counters = BNXT_RE_NUM_STD_COUNTERS;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b4d3e7dfc939f..f2eaecef7570c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1023,7 +1023,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 	bytes = (qplib_qp->sq.max_wqe * qplib_qp->sq.wqe_size);
 	/* Consider mapping PSN search memory only for RC QPs. */
 	if (qplib_qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 						   sizeof(struct sq_psn_search_ext) :
 						   sizeof(struct sq_psn_search);
 		psn_nume = (qplib_qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
@@ -1234,7 +1234,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
 		if (qplqp->rq.max_sge > dev_attr->max_qp_sges)
 			qplqp->rq.max_sge = dev_attr->max_qp_sges;
@@ -1301,7 +1301,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 	qplqp = &qp->qplib_qp;
 	dev_attr = &rdev->dev_attr;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
 		qplqp->sq.max_wqe = min_t(u32, entries,
 					  dev_attr->max_qp_wqes + 1);
@@ -1328,7 +1328,7 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 		goto out;
 	}
 
-	if (bnxt_qplib_is_chip_gen_p5(chip_ctx) &&
+	if (bnxt_qplib_is_chip_gen_p5_p7(chip_ctx) &&
 	    init_attr->qp_type == IB_QPT_GSI)
 		qptype = CMDQ_CREATE_QP_TYPE_GSI;
 out:
@@ -1527,7 +1527,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		goto fail;
 
 	if (qp_init_attr->qp_type == IB_QPT_GSI &&
-	    !(bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))) {
+	    !(bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))) {
 		rc = bnxt_re_create_gsi_qp(qp, pd, qp_init_attr);
 		if (rc == -ENODEV)
 			goto qp_destroy;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c173d0ffc6293..594cc6aa7b79d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -128,7 +128,7 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 	struct bnxt_qplib_chip_ctx *cctx;
 
 	cctx = rdev->chip_ctx;
-	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
@@ -218,7 +218,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	ctx->srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
 				attr->max_srq);
 	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_ctx.qcount[i] =
 			rdev->dev_attr.tqm_alloc_reqs[i];
@@ -267,7 +267,7 @@ static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
 	memset(&rdev->qplib_ctx.vf_res, 0, sizeof(struct bnxt_qplib_vf_res));
 	bnxt_re_limit_pf_res(rdev);
 
-	num_vfs =  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	num_vfs =  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 			BNXT_RE_GEN_P5_MAX_VF : rdev->num_vfs;
 	if (num_vfs)
 		bnxt_re_limit_vf_res(&rdev->qplib_ctx, num_vfs);
@@ -279,7 +279,7 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return;
 	rdev->num_vfs = pci_sriov_get_totalvfs(rdev->en_dev->pdev);
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		bnxt_re_set_resource_limits(rdev);
 		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
 					      &rdev->qplib_ctx);
@@ -1074,7 +1074,7 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 #define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
 static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
 {
-	return bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ?
 		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
 				   BNXT_RE_GEN_P5_PF_NQ_DB) :
 				   rdev->en_dev->msix_entries[indx].db_offset;
@@ -1539,7 +1539,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
-				  bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx));
+				  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx));
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate QPLIB context: %#x\n", rc);
@@ -1662,7 +1662,7 @@ static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
 		return;
 
 	/* Currently enabling only for GenP5 adapters */
-	if (!bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		return;
 
 	if (enable) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 3b28878f62062..4ee11cb4f2bd3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -995,7 +995,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* SQ */
 	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
-		psn_sz = bnxt_qplib_is_chip_gen_p5(res->cctx) ?
+		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
 			 sizeof(struct sq_psn_search_ext) :
 			 sizeof(struct sq_psn_search);
 
@@ -1649,7 +1649,7 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
 	flg_npsn = ((swq->next_psn << SQ_PSN_SEARCH_NEXT_PSN_SFT) &
 		     SQ_PSN_SEARCH_NEXT_PSN_MASK);
 
-	if (bnxt_qplib_is_chip_gen_p5(qp->cctx)) {
+	if (bnxt_qplib_is_chip_gen_p5_p7(qp->cctx)) {
 		psns_ext->opcode_start_psn = cpu_to_le32(op_spsn);
 		psns_ext->flags_next_psn = cpu_to_le32(flg_npsn);
 		psns_ext->start_slot_idx = cpu_to_le16(swq->slot_idx);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5680fe8b890ad..3ffaef0c26519 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -852,7 +852,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	 */
 	if (is_virtfn)
 		goto skip_ctx_setup;
-	if (bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
 		goto config_vf_res;
 
 	lvl = ctx->qpc_tbl.level;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 47406ab8879c1..1fdffd6a0f480 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -807,7 +807,7 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res *res,
 	dpit = &res->dpi_tbl;
 	reg = &dpit->wcreg;
 
-	if (!bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+	if (!bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
 		/* Offest should come from L2 driver */
 		dbr_offset = dev_attr->l2_db_size;
 		dpit->ucreg.offset = dbr_offset;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 534db462216ac..f9e7aa3757cfb 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -44,6 +44,9 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 #define CHIP_NUM_57508		0x1750
 #define CHIP_NUM_57504		0x1751
 #define CHIP_NUM_57502		0x1752
+#define CHIP_NUM_58818          0xd818
+#define CHIP_NUM_57608          0x1760
+
 
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
@@ -296,6 +299,12 @@ struct bnxt_qplib_res {
 	struct bnxt_qplib_db_pacing_data *pacing_data;
 };
 
+static inline bool bnxt_qplib_is_chip_gen_p7(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return (cctx->chip_num == CHIP_NUM_58818 ||
+		cctx->chip_num == CHIP_NUM_57608);
+}
+
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 {
 	return (cctx->chip_num == CHIP_NUM_57508 ||
@@ -303,15 +312,20 @@ static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
 		cctx->chip_num == CHIP_NUM_57502);
 }
 
+static inline bool bnxt_qplib_is_chip_gen_p5_p7(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return bnxt_qplib_is_chip_gen_p5(cctx) || bnxt_qplib_is_chip_gen_p7(cctx);
+}
+
 static inline u8 bnxt_qplib_get_hwq_type(struct bnxt_qplib_res *res)
 {
-	return bnxt_qplib_is_chip_gen_p5(res->cctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
 					HWQ_TYPE_QUEUE : HWQ_TYPE_L2_CMPL;
 }
 
 static inline u8 bnxt_qplib_get_ring_type(struct bnxt_qplib_chip_ctx *cctx)
 {
-	return bnxt_qplib_is_chip_gen_p5(cctx) ?
+	return bnxt_qplib_is_chip_gen_p5_p7(cctx) ?
 	       RING_ALLOC_REQ_RING_TYPE_NQ :
 	       RING_ALLOC_REQ_RING_TYPE_ROCE_CMPL;
 }
@@ -488,7 +502,7 @@ static inline void bnxt_qplib_ring_nq_db(struct bnxt_qplib_db_info *info,
 	u32 type;
 
 	type = arm ? DBC_DBC_TYPE_NQ_ARM : DBC_DBC_TYPE_NQ;
-	if (bnxt_qplib_is_chip_gen_p5(cctx))
+	if (bnxt_qplib_is_chip_gen_p5_p7(cctx))
 		bnxt_qplib_ring_db(info, type);
 	else
 		bnxt_qplib_ring_db32(info, arm);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index a27b685151647..c580bf78d4c13 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -59,7 +59,7 @@ static bool bnxt_qplib_is_atomic_cap(struct bnxt_qplib_rcfw *rcfw)
 {
 	u16 pcie_ctl2 = 0;
 
-	if (!bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
 		return false;
 
 	pcie_capability_read_word(rcfw->pdev, PCI_EXP_DEVCTL2, &pcie_ctl2);
@@ -133,7 +133,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * reporting the max number
 	 */
 	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
-	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx) ?
+	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx) ?
 			    6 : sb->max_sge;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
 	attr->max_cq_wqes = le32_to_cpu(sb->max_cqe);
@@ -934,7 +934,7 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 	req->inactivity_th = cpu_to_le16(cc_param->inact_th);
 
 	/* For chip gen P5 onwards fill extended cmd and header */
-	if (bnxt_qplib_is_chip_gen_p5(res->cctx)) {
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
 		struct roce_tlv *hdr;
 		u32 payload;
 		u32 chunks;
-- 
2.43.0




