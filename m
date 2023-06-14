Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA4726EC4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjFGUwh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjFGUwg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238331FCC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D34464774
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99298C433EF;
        Wed,  7 Jun 2023 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171153;
        bh=9fowYMTtq3ibDtbeNWZhasOxvxm1sZuWmRQy6iCPSes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmORArZ80u9MqObIjgXwKrnLthEYAVmdpXk/towl3IM5I424ORWeogHaWpbcdo1Ur
         ZIi//O6kYDRABIbNDZFaEIGj6QXWr3pGuXbTbg/vbGuRuHXWVRdU+ExbLUcgWJUOWa
         9X1gnNe8+fXuzdFfr9Bwk65duktCFkB7cOYV4EPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 02/99] RDMA/bnxt_re: Enable SRIOV VF support on Broadcoms 57500 adapter series
Date:   Wed,  7 Jun 2023 22:15:54 +0200
Message-ID: <20230607200900.287119101@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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

From: Devesh Sharma <devesh.sharma@broadcom.com>

[ Upstream commit 39c48c514601d76f8750d1739928c9577b1785d9 ]

Broadcom's 575xx adapter series has support for SRIOV VFs.  Making changes
to enable SRIOV VF support. There are two major area where changes are
done:

 - Added new DB location for control-path and data-path DB ring

 - New devices do not need to issue the sriov-config slow-path command
   thus, skipping to call that firmware command.

For now enabling support for 64 RoCE VFs.

Link: https://lore.kernel.org/r/1570081715-14301-1-git-send-email-devesh.sharma@broadcom.com
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Stable-dep-of: 349e3c0cf239 ("RDMA/bnxt_re: Fix a possible memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   1 +
 drivers/infiniband/hw/bnxt_re/main.c       | 133 ++++++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   5 +-
 3 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index e55a1666c0cd6..725b2350e3498 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -108,6 +108,7 @@ struct bnxt_re_sqp_entries {
 #define BNXT_RE_MAX_MSIX		9
 #define BNXT_RE_AEQ_IDX			0
 #define BNXT_RE_NQ_IDX			1
+#define BNXT_RE_GEN_P5_MAX_VF		64
 
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index cfe5f47d9890e..41fc05d531183 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -119,61 +119,76 @@ static void bnxt_re_get_sriov_func_type(struct bnxt_re_dev *rdev)
  * reserved for the function. The driver may choose to allocate fewer
  * resources than the firmware maximum.
  */
-static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
+static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 {
-	u32 vf_qps = 0, vf_srqs = 0, vf_cqs = 0, vf_mrws = 0, vf_gids = 0;
-	u32 i;
-	u32 vf_pct;
-	u32 num_vfs;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *attr;
+	struct bnxt_qplib_ctx *ctx;
+	int i;
 
-	rdev->qplib_ctx.qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
-					  dev_attr->max_qp);
+	attr = &rdev->dev_attr;
+	ctx = &rdev->qplib_ctx;
 
-	rdev->qplib_ctx.mrw_count = BNXT_RE_MAX_MRW_COUNT_256K;
+	ctx->qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
+			       attr->max_qp);
+	ctx->mrw_count = BNXT_RE_MAX_MRW_COUNT_256K;
 	/* Use max_mr from fw since max_mrw does not get set */
-	rdev->qplib_ctx.mrw_count = min_t(u32, rdev->qplib_ctx.mrw_count,
-					  dev_attr->max_mr);
-	rdev->qplib_ctx.srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
-					   dev_attr->max_srq);
-	rdev->qplib_ctx.cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT,
-					 dev_attr->max_cq);
-
-	for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
-		rdev->qplib_ctx.tqm_count[i] =
-		rdev->dev_attr.tqm_alloc_reqs[i];
-
-	if (rdev->num_vfs) {
-		/*
-		 * Reserve a set of resources for the PF. Divide the remaining
-		 * resources among the VFs
-		 */
-		vf_pct = 100 - BNXT_RE_PCT_RSVD_FOR_PF;
-		num_vfs = 100 * rdev->num_vfs;
-		vf_qps = (rdev->qplib_ctx.qpc_count * vf_pct) / num_vfs;
-		vf_srqs = (rdev->qplib_ctx.srqc_count * vf_pct) / num_vfs;
-		vf_cqs = (rdev->qplib_ctx.cq_count * vf_pct) / num_vfs;
-		/*
-		 * The driver allows many more MRs than other resources. If the
-		 * firmware does also, then reserve a fixed amount for the PF
-		 * and divide the rest among VFs. VFs may use many MRs for NFS
-		 * mounts, ISER, NVME applications, etc. If the firmware
-		 * severely restricts the number of MRs, then let PF have
-		 * half and divide the rest among VFs, as for the other
-		 * resource types.
-		 */
-		if (rdev->qplib_ctx.mrw_count < BNXT_RE_MAX_MRW_COUNT_64K)
-			vf_mrws = rdev->qplib_ctx.mrw_count * vf_pct / num_vfs;
-		else
-			vf_mrws = (rdev->qplib_ctx.mrw_count -
-				   BNXT_RE_RESVD_MR_FOR_PF) / rdev->num_vfs;
-		vf_gids = BNXT_RE_MAX_GID_PER_VF;
+	ctx->mrw_count = min_t(u32, ctx->mrw_count, attr->max_mr);
+	ctx->srqc_count = min_t(u32, BNXT_RE_MAX_SRQC_COUNT,
+				attr->max_srq);
+	ctx->cq_count = min_t(u32, BNXT_RE_MAX_CQ_COUNT, attr->max_cq);
+	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx))
+		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
+			rdev->qplib_ctx.tqm_count[i] =
+			rdev->dev_attr.tqm_alloc_reqs[i];
+}
+
+static void bnxt_re_limit_vf_res(struct bnxt_qplib_ctx *qplib_ctx, u32 num_vf)
+{
+	struct bnxt_qplib_vf_res *vf_res;
+	u32 mrws = 0;
+	u32 vf_pct;
+	u32 nvfs;
+
+	vf_res = &qplib_ctx->vf_res;
+	/*
+	 * Reserve a set of resources for the PF. Divide the remaining
+	 * resources among the VFs
+	 */
+	vf_pct = 100 - BNXT_RE_PCT_RSVD_FOR_PF;
+	nvfs = num_vf;
+	num_vf = 100 * num_vf;
+	vf_res->max_qp_per_vf = (qplib_ctx->qpc_count * vf_pct) / num_vf;
+	vf_res->max_srq_per_vf = (qplib_ctx->srqc_count * vf_pct) / num_vf;
+	vf_res->max_cq_per_vf = (qplib_ctx->cq_count * vf_pct) / num_vf;
+	/*
+	 * The driver allows many more MRs than other resources. If the
+	 * firmware does also, then reserve a fixed amount for the PF and
+	 * divide the rest among VFs. VFs may use many MRs for NFS
+	 * mounts, ISER, NVME applications, etc. If the firmware severely
+	 * restricts the number of MRs, then let PF have half and divide
+	 * the rest among VFs, as for the other resource types.
+	 */
+	if (qplib_ctx->mrw_count < BNXT_RE_MAX_MRW_COUNT_64K) {
+		mrws = qplib_ctx->mrw_count * vf_pct;
+		nvfs = num_vf;
+	} else {
+		mrws = qplib_ctx->mrw_count - BNXT_RE_RESVD_MR_FOR_PF;
 	}
-	rdev->qplib_ctx.vf_res.max_mrw_per_vf = vf_mrws;
-	rdev->qplib_ctx.vf_res.max_gid_per_vf = vf_gids;
-	rdev->qplib_ctx.vf_res.max_qp_per_vf = vf_qps;
-	rdev->qplib_ctx.vf_res.max_srq_per_vf = vf_srqs;
-	rdev->qplib_ctx.vf_res.max_cq_per_vf = vf_cqs;
+	vf_res->max_mrw_per_vf = (mrws / nvfs);
+	vf_res->max_gid_per_vf = BNXT_RE_MAX_GID_PER_VF;
+}
+
+static void bnxt_re_set_resource_limits(struct bnxt_re_dev *rdev)
+{
+	u32 num_vfs;
+
+	memset(&rdev->qplib_ctx.vf_res, 0, sizeof(struct bnxt_qplib_vf_res));
+	bnxt_re_limit_pf_res(rdev);
+
+	num_vfs =  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
+			BNXT_RE_GEN_P5_MAX_VF : rdev->num_vfs;
+	if (num_vfs)
+		bnxt_re_limit_vf_res(&rdev->qplib_ctx, num_vfs);
 }
 
 /* for handling bnxt_en callbacks later */
@@ -193,9 +208,11 @@ static void bnxt_re_sriov_config(void *p, int num_vfs)
 		return;
 
 	rdev->num_vfs = num_vfs;
-	bnxt_re_set_resource_limits(rdev);
-	bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
-				      &rdev->qplib_ctx);
+	if (!bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx)) {
+		bnxt_re_set_resource_limits(rdev);
+		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
+					      &rdev->qplib_ctx);
+	}
 }
 
 static void bnxt_re_shutdown(void *p)
@@ -897,10 +914,14 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 	return 0;
 }
 
+#define BNXT_RE_GEN_P5_PF_NQ_DB		0x10000
+#define BNXT_RE_GEN_P5_VF_NQ_DB		0x4000
 static u32 bnxt_re_get_nqdb_offset(struct bnxt_re_dev *rdev, u16 indx)
 {
 	return bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx) ?
-				0x10000 : rdev->msix_entries[indx].db_offset;
+		(rdev->is_virtfn ? BNXT_RE_GEN_P5_VF_NQ_DB :
+				   BNXT_RE_GEN_P5_PF_NQ_DB) :
+				   rdev->msix_entries[indx].db_offset;
 }
 
 static void bnxt_re_cleanup_res(struct bnxt_re_dev *rdev)
@@ -1410,8 +1431,8 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 				     rdev->is_virtfn);
 	if (rc)
 		goto disable_rcfw;
-	if (!rdev->is_virtfn)
-		bnxt_re_set_resource_limits(rdev);
+
+	bnxt_re_set_resource_limits(rdev);
 
 	rc = bnxt_qplib_alloc_ctx(rdev->en_dev->pdev, &rdev->qplib_ctx, 0,
 				  bnxt_qplib_is_chip_gen_p5(&rdev->chip_ctx));
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 60c8f76aab33d..5cdfa84faf85e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -494,8 +494,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	 * shall setup this area for VF. Skipping the
 	 * HW programming
 	 */
-	if (is_virtfn || bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+	if (is_virtfn)
 		goto skip_ctx_setup;
+	if (bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx))
+		goto config_vf_res;
 
 	level = ctx->qpc_tbl.level;
 	req.qpc_pg_size_qpc_lvl = (level << CMDQ_INITIALIZE_FW_QPC_LVL_SFT) |
@@ -540,6 +542,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	req.number_of_srq = cpu_to_le32(ctx->srqc_tbl.max_elements);
 	req.number_of_cq = cpu_to_le32(ctx->cq_tbl.max_elements);
 
+config_vf_res:
 	req.max_qp_per_vf = cpu_to_le32(ctx->vf_res.max_qp_per_vf);
 	req.max_mrw_per_vf = cpu_to_le32(ctx->vf_res.max_mrw_per_vf);
 	req.max_srq_per_vf = cpu_to_le32(ctx->vf_res.max_srq_per_vf);
-- 
2.39.2



