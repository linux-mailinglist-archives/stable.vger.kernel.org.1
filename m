Return-Path: <stable+bounces-120945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17679A5091C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9381A17519F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7ED2512C9;
	Wed,  5 Mar 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTKqX/hY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0622517AA;
	Wed,  5 Mar 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198430; cv=none; b=G3sGAA8XWPqOT7tJaNTdPswUws08Xfa+MV1LgW23pvevVwmE7TZQurIIhzBv/W8+qiewOFyPxKw53hZMbJVN3Js7Sd0XpvxfJEspsgIZQsA0BBZLFfxLnz1XCYf32pdv3NEmltfhv/Ylzj2kNPBNKho4/j8EYLAycw9p7jdoyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198430; c=relaxed/simple;
	bh=dRWm01FvYYd50EhwyjoCsEn/DJ6sw6p6g8x7lD9Rc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8+75ZWzLS6ixtMTM+cJTay+/JqT0uZKELQ8tpYZsfJm9GmyMFJukSc/ZW0CeVyWuRK1EH+MOFp13W4TfvpGayAyOSxZQRrMJZ5NsQz0Fi4/2Zw+WHfFsHsCavHUqtANuxIlEeWdYf++x0CO1SRp6z1VqFCQS/EXVQi6k4lSlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTKqX/hY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01748C4CED1;
	Wed,  5 Mar 2025 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198430;
	bh=dRWm01FvYYd50EhwyjoCsEn/DJ6sw6p6g8x7lD9Rc0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTKqX/hYTNRfqcScXIGFJUm/mzHPLJ1WD9ZAOZvtr2HnnFnVD45NN+iStsTmTpXe/
	 1rpuIWtxsiw7IjeTYy7wPxqN8nSTswh4DQ4jTAzWd8r+79JzbkIpgAxptwv+uWgH7F
	 O0hvfkGERueRQeEeYwv0Q8Yo4Wy5uNlQt2BtdtGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 008/157] RDMA/bnxt_re: Allocate dev_attr information dynamically
Date: Wed,  5 Mar 2025 18:47:24 +0100
Message-ID: <20250305174505.613450353@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 9264cd6aa8f194753507cb6e1f444141e7c79f48 ]

In order to optimize the size of driver private structure,
the memory for dev_attr is allocated dynamically during the
chip context initialization. In order to make certain runtime
decisions, store dev_attr in the qplib_res structure.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://patch.msgid.link/1736446693-6692-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 8238c7bd8420 ("RDMA/bnxt_re: Fix the statistics for Gen P7 VF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  2 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c    | 38 ++++++++++-----------
 drivers/infiniband/hw/bnxt_re/main.c        | 36 ++++++++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_res.c   |  7 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  4 +--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  3 +-
 8 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2975b11b79bf7..22c98c155bd3c 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -204,7 +204,7 @@ struct bnxt_re_dev {
 	struct bnxt_re_nq_record	*nqr;
 
 	/* Device Resources */
-	struct bnxt_qplib_dev_attr	dev_attr;
+	struct bnxt_qplib_dev_attr	*dev_attr;
 	struct bnxt_qplib_ctx		qplib_ctx;
 	struct bnxt_qplib_res		qplib_res;
 	struct bnxt_qplib_dpi		dpi_privileged;
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 1e63f80917483..656c150e38e6f 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -357,7 +357,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 			goto done;
 		}
 		bnxt_re_copy_err_stats(rdev, stats, err_s);
-		if (_is_ext_stats_supported(rdev->dev_attr.dev_cap_flags) &&
+		if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags) &&
 		    !rdev->is_virtfn) {
 			rc = bnxt_re_get_ext_stat(rdev, stats);
 			if (rc) {
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1ff2e176b0369..4b61867188c4c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -161,7 +161,7 @@ static int __qp_access_flags_to_ib(struct bnxt_qplib_chip_ctx *cctx, u8 qflags)
 static void bnxt_re_check_and_set_relaxed_ordering(struct bnxt_re_dev *rdev,
 						   struct bnxt_qplib_mrw *qplib_mr)
 {
-	if (_is_relaxed_ordering_supported(rdev->dev_attr.dev_cap_flags2) &&
+	if (_is_relaxed_ordering_supported(rdev->dev_attr->dev_cap_flags2) &&
 	    pcie_relaxed_ordering_enabled(rdev->en_dev->pdev))
 		qplib_mr->flags |= CMDQ_REGISTER_MR_FLAGS_ENABLE_RO;
 }
@@ -186,7 +186,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 			 struct ib_udata *udata)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 
 	memset(ib_attr, 0, sizeof(*ib_attr));
 	memcpy(&ib_attr->fw_ver, dev_attr->fw_ver,
@@ -275,7 +275,7 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 		       struct ib_port_attr *port_attr)
 {
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	int rc;
 
 	memset(port_attr, 0, sizeof(*port_attr));
@@ -333,8 +333,8 @@ void bnxt_re_query_fw_str(struct ib_device *ibdev, char *str)
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 
 	snprintf(str, IB_FW_VERSION_NAME_MAX, "%d.%d.%d.%d",
-		 rdev->dev_attr.fw_ver[0], rdev->dev_attr.fw_ver[1],
-		 rdev->dev_attr.fw_ver[2], rdev->dev_attr.fw_ver[3]);
+		 rdev->dev_attr->fw_ver[0], rdev->dev_attr->fw_ver[1],
+		 rdev->dev_attr->fw_ver[2], rdev->dev_attr->fw_ver[3]);
 }
 
 int bnxt_re_query_pkey(struct ib_device *ibdev, u32 port_num,
@@ -585,7 +585,7 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
 	mr->qplib_mr.pd = &pd->qplib_pd;
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_PMR;
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to alloc fence-HW-MR\n");
@@ -1057,7 +1057,7 @@ static int bnxt_re_setup_swqe_size(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	align = sizeof(struct sq_send_hdr);
 	ilsize = ALIGN(init_attr->cap.max_inline_data, align);
@@ -1277,7 +1277,7 @@ static int bnxt_re_init_rq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	rq = &qplqp->rq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (init_attr->srq) {
 		struct bnxt_re_srq *srq;
@@ -1314,7 +1314,7 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		qplqp->rq.max_sge = dev_attr->max_qp_sges;
@@ -1340,7 +1340,7 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
 	sq = &qplqp->sq;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	sq->max_sge = init_attr->cap.max_send_sge;
 	entries = init_attr->cap.max_send_wr;
@@ -1393,7 +1393,7 @@ static void bnxt_re_adjust_gsi_sq_attr(struct bnxt_re_qp *qp,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
 		entries = bnxt_re_init_depth(init_attr->cap.max_send_wr + 1, uctx);
@@ -1442,7 +1442,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rdev = qp->rdev;
 	qplqp = &qp->qplib_qp;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 
 	/* Setup misc params */
 	ether_addr_copy(qplqp->smac, rdev->netdev->dev_addr);
@@ -1612,7 +1612,7 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	ib_pd = ib_qp->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
@@ -1840,7 +1840,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	ib_pd = ib_srq->pd;
 	pd = container_of(ib_pd, struct bnxt_re_pd, ib_pd);
 	rdev = pd->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	srq = container_of(ib_srq, struct bnxt_re_srq, ib_srq);
 
 	if (srq_init_attr->attr.max_wr >= dev_attr->max_srq_wqes) {
@@ -2044,7 +2044,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 {
 	struct bnxt_re_qp *qp = container_of(ib_qp, struct bnxt_re_qp, ib_qp);
 	struct bnxt_re_dev *rdev = qp->rdev;
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	enum ib_qp_state curr_qp_state, new_qp_state;
 	int rc, entries;
 	unsigned int flags;
@@ -3091,7 +3091,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct ib_udata *udata = &attrs->driver_udata;
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
 	int cqe = attr->cqe;
 	int rc, entries;
@@ -3226,7 +3226,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 
 	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
-	dev_attr = &rdev->dev_attr;
+	dev_attr = rdev->dev_attr;
 	if (!ibcq->uobject) {
 		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
 		return -EOPNOTSUPP;
@@ -4199,7 +4199,7 @@ static struct ib_mr *__bnxt_re_user_reg_mr(struct ib_pd *ib_pd, u64 length, u64
 	mr->qplib_mr.access_flags = __from_ib_access_flags(mr_access_flags);
 	mr->qplib_mr.type = CMDQ_ALLOCATE_MRW_MRW_FLAGS_MR;
 
-	if (!_is_alloc_mr_unified(rdev->dev_attr.dev_cap_flags)) {
+	if (!_is_alloc_mr_unified(rdev->dev_attr->dev_cap_flags)) {
 		rc = bnxt_qplib_alloc_mrw(&rdev->qplib_res, &mr->qplib_mr);
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to allocate MR rc = %d", rc);
@@ -4291,7 +4291,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	struct bnxt_re_ucontext *uctx =
 		container_of(ctx, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
-	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
+	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_user_mmap_entry *entry;
 	struct bnxt_re_uctx_resp resp = {};
 	struct bnxt_re_uctx_req ureq = {};
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 7368b0482bb87..b29687ec2ea31 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -153,6 +153,10 @@ static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 
 	if (!rdev->chip_ctx)
 		return;
+
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
 	rdev->rcfw.res = NULL;
@@ -166,7 +170,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx;
 	struct bnxt_en_dev *en_dev;
-	int rc;
+	int rc = -ENOMEM;
 
 	en_dev = rdev->en_dev;
 
@@ -182,7 +186,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	rdev->qplib_res.cctx = rdev->chip_ctx;
 	rdev->rcfw.res = &rdev->qplib_res;
-	rdev->qplib_res.dattr = &rdev->dev_attr;
+	rdev->dev_attr = kzalloc(sizeof(*rdev->dev_attr), GFP_KERNEL);
+	if (!rdev->dev_attr)
+		goto free_chip_ctx;
+	rdev->qplib_res.dattr = rdev->dev_attr;
 	rdev->qplib_res.is_vf = BNXT_EN_VF(en_dev);
 	rdev->qplib_res.en_dev = en_dev;
 
@@ -190,16 +197,20 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev)
 
 	bnxt_re_set_db_offset(rdev);
 	rc = bnxt_qplib_map_db_bar(&rdev->qplib_res);
-	if (rc) {
-		kfree(rdev->chip_ctx);
-		rdev->chip_ctx = NULL;
-		return rc;
-	}
+	if (rc)
+		goto free_dev_attr;
 
 	if (bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
 	return 0;
+free_dev_attr:
+	kfree(rdev->dev_attr);
+	rdev->dev_attr = NULL;
+free_chip_ctx:
+	kfree(rdev->chip_ctx);
+	rdev->chip_ctx = NULL;
+	return rc;
 }
 
 /* SR-IOV helper functions */
@@ -221,7 +232,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	struct bnxt_qplib_ctx *ctx;
 	int i;
 
-	attr = &rdev->dev_attr;
+	attr = rdev->dev_attr;
 	ctx = &rdev->qplib_ctx;
 
 	ctx->qpc_count = min_t(u32, BNXT_RE_MAX_QPC_COUNT,
@@ -235,7 +246,7 @@ static void bnxt_re_limit_pf_res(struct bnxt_re_dev *rdev)
 	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
 		for (i = 0; i < MAX_TQM_ALLOC_REQ; i++)
 			rdev->qplib_ctx.tqm_ctx.qcount[i] =
-			rdev->dev_attr.tqm_alloc_reqs[i];
+			rdev->dev_attr->tqm_alloc_reqs[i];
 }
 
 static void bnxt_re_limit_vf_res(struct bnxt_qplib_ctx *qplib_ctx, u32 num_vf)
@@ -1631,12 +1642,11 @@ static int bnxt_re_alloc_res(struct bnxt_re_dev *rdev)
 
 	/* Configure and allocate resources for qplib */
 	rdev->qplib_res.rcfw = &rdev->rcfw;
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto fail;
 
-	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->en_dev->pdev,
-				  rdev->netdev, &rdev->dev_attr);
+	rc = bnxt_qplib_alloc_res(&rdev->qplib_res, rdev->netdev);
 	if (rc)
 		goto fail;
 
@@ -2036,7 +2046,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			rdev->pacing.dbr_pacing = false;
 		}
 	}
-	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr);
+	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto disable_rcfw;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 96ceec1e8199a..02922a0987ad7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -876,14 +876,13 @@ void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
 }
 
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr)
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev)
 {
+	struct bnxt_qplib_dev_attr *dev_attr;
 	int rc;
 
-	res->pdev = pdev;
 	res->netdev = netdev;
+	dev_attr = res->dattr;
 
 	rc = bnxt_qplib_alloc_sgid_tbl(res, &res->sgid_tbl, dev_attr->max_sgid);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index cbfc49a1a56d7..be5d907a036b6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -424,9 +424,7 @@ int bnxt_qplib_dealloc_dpi(struct bnxt_qplib_res *res,
 void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
-int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
-			 struct net_device *netdev,
-			 struct bnxt_qplib_dev_attr *dev_attr);
+int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev);
 void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 9df3e3271577d..2e09616736bc7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -88,9 +88,9 @@ static void bnxt_qplib_query_version(struct bnxt_qplib_rcfw *rcfw,
 	fw_ver[3] = resp.fw_rsvd;
 }
 
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr)
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 {
+	struct bnxt_qplib_dev_attr *attr = rcfw->res->dattr;
 	struct creq_query_func_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct creq_query_func_resp_sb *sb;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e6beeb514b7dd..a1878eec7ba62 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -325,8 +325,7 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
-			    struct bnxt_qplib_dev_attr *attr);
+int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
 				  struct bnxt_qplib_ctx *ctx);
-- 
2.39.5




