Return-Path: <stable+bounces-106888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFCCA02924
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F26C161C46
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EB1474A0;
	Mon,  6 Jan 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDXzhZMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E58200A3;
	Mon,  6 Jan 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176811; cv=none; b=XJdxezfm59d7j7Te8N2kqaEQQxq3VftXsHmuZwCLqTSAUSqFCl8PYVfvx2NaNO4sNbeEh2KZb7cE/B49pIIX5vcyAHtLOCHHk79zQEUa3P0mhvz7F2qUzpQBpXuQW+K6wzxry9iFfMeyJv1emIRR2zq7O6JBB4m9dJkkzUq+Ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176811; c=relaxed/simple;
	bh=RBkzNnStlNIWu3ATZurQG9/xhkQ3zZwr/NKzr4P9fdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkYRal1i2p/q3CYa4jrjIUggzAMOYuOAQdetPy6DzJGePMxKk9aVj+esVSzmRH4mShaQGjhJ5gF6+9sl/22WZeegZX/iaMzXeotgdZtH5+PiWVXaHxD4X6UTFyaMbWFNn5ozmw9wewEPWF3r7FQGSsV2YFiDatT+EL+PLXqN6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDXzhZMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFCEC4CED2;
	Mon,  6 Jan 2025 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176811;
	bh=RBkzNnStlNIWu3ATZurQG9/xhkQ3zZwr/NKzr4P9fdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDXzhZMdLF8/cTPy5e6I7wPVJuR2tLmC9vFoldDdsEjOULKa1yR4EalASiNVy8rWG
	 tKZtmH4tNOwM2XiaWSfKeOqGEL2dIXxC/OtAX5nFSYMZD6FXF+6s9/fbwTKBgmkXHe
	 f4QJFeb/avj0IFxpqZ4Wu9fqcbr7ylzFF5EVB5kg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 21/81] RDMA/hns: Refactor mtr find
Date: Mon,  6 Jan 2025 16:15:53 +0100
Message-ID: <20250106151130.236380304@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit a4ca341080758d847db155b97887bff6f84016a4 ]

hns_roce_mtr_find() is a collection of multiple functions, and the
return value is also difficult to understand, which is not conducive
to modification and maintenance.

Separate the function of obtaining MTR root BA from this function.
And some adjustments has been made to improve readability.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240113085935.2838701-2-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 8673a6c2d9e4 ("RDMA/hns: Fix mapping error of zero-hop WQE buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  11 +--
 drivers/infiniband/hw/hns/hns_roce_device.h |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 102 ++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  86 +++++++++++------
 4 files changed, 121 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 9b91731a6207..5e0d78f4e545 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -133,14 +133,12 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle;
 	int ret;
 
-	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts),
-				&dma_handle);
-	if (!ret) {
+	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find CQ mtr, ret = %d.\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
@@ -157,7 +155,8 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		goto err_put;
 	}
 
-	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts, dma_handle);
+	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts,
+				  hns_roce_get_mtr_ba(&hr_cq->mtr));
 	if (ret)
 		goto err_xa;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5b8b68b2d69c..461008bf0fcf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1117,8 +1117,13 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev);
 
 /* hns roce hw need current block and next block addr from mtt */
 #define MTT_MIN_COUNT	 2
+static inline dma_addr_t hns_roce_get_mtr_ba(struct hns_roce_mtr *mtr)
+{
+	return mtr->hem_cfg.root_ba;
+}
+
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
+		      u32 offset, u64 *mtt_buf, int mtt_max);
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			struct hns_roce_buf_attr *buf_attr,
 			unsigned int page_shift, struct ib_udata *udata,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 54df6c6e4cac..105ad0aec922 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3289,21 +3289,22 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 	u64 pages[HNS_ROCE_V2_MAX_INNER_MTPT_NUM] = { 0 };
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t pbl_ba;
-	int i, count;
+	int ret;
+	int i;
 
-	count = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
-				  min_t(int, ARRAY_SIZE(pages), mr->npages),
-				  &pbl_ba);
-	if (count < 1) {
-		ibdev_err(ibdev, "failed to find PBL mtr, count = %d.\n",
-			  count);
-		return -ENOBUFS;
+	ret = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
+				min_t(int, ARRAY_SIZE(pages), mr->npages));
+	if (ret) {
+		ibdev_err(ibdev, "failed to find PBL mtr, ret = %d.\n", ret);
+		return ret;
 	}
 
 	/* Aligned to the hardware address access unit */
-	for (i = 0; i < count; i++)
+	for (i = 0; i < ARRAY_SIZE(pages); i++)
 		pages[i] >>= 6;
 
+	pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
+
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> 3);
 	hr_reg_write(mpt_entry, MPT_PBL_BA_H, upper_32_bits(pbl_ba >> 3));
@@ -3402,18 +3403,12 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
 				       void *mb_buf, struct hns_roce_mr *mr)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
 	struct hns_roce_v2_mpt_entry *mpt_entry;
-	dma_addr_t pbl_ba = 0;
 
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
 
-	if (hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, NULL, 0, &pbl_ba) < 0) {
-		ibdev_err(ibdev, "failed to find frmr mtr.\n");
-		return -ENOBUFS;
-	}
-
 	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_FREE);
 	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
 
@@ -4496,17 +4491,20 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 {
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	u64 wqe_sge_ba;
-	int count;
+	int ret;
 
 	/* Search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
-				  MTT_MIN_COUNT, &wqe_sge_ba);
-	if (hr_qp->rq.wqe_cnt && count < 1) {
+	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
+				MTT_MIN_COUNT);
+	if (hr_qp->rq.wqe_cnt && ret) {
 		ibdev_err(&hr_dev->ib_dev,
-			  "failed to find RQ WQE, QPN = 0x%lx.\n", hr_qp->qpn);
-		return -EINVAL;
+			  "failed to find QP(0x%lx) RQ WQE buf, ret = %d.\n",
+			  hr_qp->qpn, ret);
+		return ret;
 	}
 
+	wqe_sge_ba = hns_roce_get_mtr_ba(&hr_qp->mtr);
+
 	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
 
@@ -4570,23 +4568,23 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 sge_cur_blk = 0;
 	u64 sq_cur_blk = 0;
-	int count;
+	int ret;
 
 	/* search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
-	if (count < 1) {
-		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf.\n",
-			  hr_qp->qpn);
-		return -EINVAL;
+	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->sq.offset,
+				&sq_cur_blk, 1);
+	if (ret) {
+		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ WQE buf, ret = %d.\n",
+			  hr_qp->qpn, ret);
+		return ret;
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
-		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset,
-					  &sge_cur_blk, 1, NULL);
-		if (count < 1) {
-			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
-				  hr_qp->qpn);
-			return -EINVAL;
+		ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+					hr_qp->sge.offset, &sge_cur_blk, 1);
+		if (ret) {
+			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf, ret = %d.\n",
+				  hr_qp->qpn, ret);
+			return ret;
 		}
 	}
 
@@ -5689,18 +5687,20 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 	struct ib_device *ibdev = srq->ibsrq.device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	u64 mtts_idx[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle_idx = 0;
+	dma_addr_t dma_handle_idx;
 	int ret;
 
 	/* Get physical address of idx que buf */
 	ret = hns_roce_mtr_find(hr_dev, &idx_que->mtr, 0, mtts_idx,
-				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
-	if (ret < 1) {
+				ARRAY_SIZE(mtts_idx));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
 			  ret);
-		return -ENOBUFS;
+		return ret;
 	}
 
+	dma_handle_idx = hns_roce_get_mtr_ba(&idx_que->mtr);
+
 	hr_reg_write(ctx, SRQC_IDX_HOP_NUM,
 		     to_hr_hem_hopnum(hr_dev->caps.idx_hop_num, srq->wqe_cnt));
 
@@ -5732,20 +5732,22 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_srq_context *ctx = mb_buf;
 	u64 mtts_wqe[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle_wqe = 0;
+	dma_addr_t dma_handle_wqe;
 	int ret;
 
 	memset(ctx, 0, sizeof(*ctx));
 
 	/* Get the physical address of srq buf */
 	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
-				ARRAY_SIZE(mtts_wqe), &dma_handle_wqe);
-	if (ret < 1) {
+				ARRAY_SIZE(mtts_wqe));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ WQE, ret = %d.\n",
 			  ret);
-		return -ENOBUFS;
+		return ret;
 	}
 
+	dma_handle_wqe = hns_roce_get_mtr_ba(&srq->buf_mtr);
+
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
 	hr_reg_write_bool(ctx, SRQC_SRQ_TYPE,
 			  srq->ibsrq.srq_type == IB_SRQT_XRC);
@@ -6466,7 +6468,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	u64 eqe_ba[MTT_MIN_COUNT] = { 0 };
 	struct hns_roce_eq_context *eqc;
 	u64 bt_ba = 0;
-	int count;
+	int ret;
 
 	eqc = mb_buf;
 	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
@@ -6474,13 +6476,15 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	init_eq_config(hr_dev, eq);
 
 	/* if not multi-hop, eqe buffer only use one trunk */
-	count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba, MTT_MIN_COUNT,
-				  &bt_ba);
-	if (count < 1) {
-		dev_err(hr_dev->dev, "failed to find EQE mtr\n");
-		return -ENOBUFS;
+	ret = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba,
+				ARRAY_SIZE(eqe_ba));
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to find EQE mtr, ret = %d\n", ret);
+		return ret;
 	}
 
+	bt_ba = hns_roce_get_mtr_ba(&eq->mtr);
+
 	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
 	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
 	hr_reg_write(eqc, EQC_OVER_IGNORE, eq->over_ignore);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7f29a55d378f..7b59b95f87c2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -802,47 +802,53 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return ret;
 }
 
-int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
+static int hns_roce_get_direct_addr_mtt(struct hns_roce_hem_cfg *cfg,
+					u32 start_index, u64 *mtt_buf,
+					int mtt_cnt)
 {
-	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
-	int mtt_count, left;
-	u32 start_index;
+	int mtt_count;
 	int total = 0;
-	__le64 *mtts;
 	u32 npage;
 	u64 addr;
 
-	if (!mtt_buf || mtt_max < 1)
-		goto done;
-
-	/* no mtt memory in direct mode, so just return the buffer address */
-	if (cfg->is_direct) {
-		start_index = offset >> HNS_HW_PAGE_SHIFT;
-		for (mtt_count = 0; mtt_count < cfg->region_count &&
-		     total < mtt_max; mtt_count++) {
-			npage = cfg->region[mtt_count].offset;
-			if (npage < start_index)
-				continue;
+	if (mtt_cnt > cfg->region_count)
+		return -EINVAL;
 
-			addr = cfg->root_ba + (npage << HNS_HW_PAGE_SHIFT);
-			mtt_buf[total] = addr;
+	for (mtt_count = 0; mtt_count < cfg->region_count && total < mtt_cnt;
+	     mtt_count++) {
+		npage = cfg->region[mtt_count].offset;
+		if (npage < start_index)
+			continue;
 
-			total++;
-		}
+		addr = cfg->root_ba + (npage << HNS_HW_PAGE_SHIFT);
+		mtt_buf[total] = addr;
 
-		goto done;
+		total++;
 	}
 
-	start_index = offset >> cfg->buf_pg_shift;
-	left = mtt_max;
+	if (!total)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int hns_roce_get_mhop_mtt(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_mtr *mtr, u32 start_index,
+				 u64 *mtt_buf, int mtt_cnt)
+{
+	int left = mtt_cnt;
+	int total = 0;
+	int mtt_count;
+	__le64 *mtts;
+	u32 npage;
+
 	while (left > 0) {
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  start_index + total,
 						  &mtt_count);
 		if (!mtts || !mtt_count)
-			goto done;
+			break;
 
 		npage = min(mtt_count, left);
 		left -= npage;
@@ -850,11 +856,33 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			mtt_buf[total++] = le64_to_cpu(mtts[mtt_count]);
 	}
 
-done:
-	if (base_addr)
-		*base_addr = cfg->root_ba;
+	if (!total)
+		return -ENOENT;
+
+	return 0;
+}
+
+int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		      u32 offset, u64 *mtt_buf, int mtt_max)
+{
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	u32 start_index;
+	int ret;
+
+	if (!mtt_buf || mtt_max < 1)
+		return -EINVAL;
 
-	return total;
+	/* no mtt memory in direct mode, so just return the buffer address */
+	if (cfg->is_direct) {
+		start_index = offset >> HNS_HW_PAGE_SHIFT;
+		ret = hns_roce_get_direct_addr_mtt(cfg, start_index,
+						   mtt_buf, mtt_max);
+	} else {
+		start_index = offset >> cfg->buf_pg_shift;
+		ret = hns_roce_get_mhop_mtt(hr_dev, mtr, start_index,
+					    mtt_buf, mtt_max);
+	}
+	return ret;
 }
 
 static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
-- 
2.39.5




