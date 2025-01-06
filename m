Return-Path: <stable+bounces-107078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388DAA02A05
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B01643F9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C7157E82;
	Mon,  6 Jan 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFSVav5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799286359;
	Mon,  6 Jan 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177385; cv=none; b=cIh8AusqZN8CG9D+anKQ6FxMLJ0fH1dRB+JcxGjJ8bXSZoLawWbkp/2BGs0SwKrcX99SMXCYPLWjfnuAUWdcT0WE8Rl1I+4ukvk1m99+5x1OdqFZFFmeAG/cTAvGDvDcogXXIyqu3dzx7CVGPxrNWrORFu46wr3kipHsH0eYino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177385; c=relaxed/simple;
	bh=S99MyrepeCpOGGfYcAIlUIoQu7eiQztcZIFjsxdyr8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbE3pH4MkSd1RU04gobj8Ukuamk9M1a1T17nHscD24awVOQKjkXOtIL6K8oET5DU0N2/L0JC/EkNxHBkEqdzz8YqnonS/CmiBj8JUBgfN0JpE1tVW2x3YKEH9u2mJwgwDgBouaoe/9jQW1vlPvi0nXjALyN2Zmnm1nQGYLfGM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFSVav5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5825C4CEE1;
	Mon,  6 Jan 2025 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177385;
	bh=S99MyrepeCpOGGfYcAIlUIoQu7eiQztcZIFjsxdyr8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFSVav5LKpsl5xv6fka0d6NLIrGl4YkgRgye1oVC89FnFNvJMYU7v5dKjQ/PjYjbl
	 p2hSgLh+9N27QPnwsZfPAH/Xi1O/eQx1HEQyG/FV8H+vXXCruiywfwhpDFbS8VrjSf
	 4XRIAylZ78iHJinlZAz6ZtyP01PDYip16xrjQJH4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 146/222] RDMA/hns: Remove unused parameters and variables
Date: Mon,  6 Jan 2025 16:15:50 +0100
Message-ID: <20250106151156.292498125@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit f4caa864af84f801a5821ea2ba6c1cc46f8252c1 ]

Remove unused parameters and variables.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240412091616.370789-3-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: 8673a6c2d9e4 ("RDMA/hns: Fix mapping error of zero-hop WQE buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  3 +--
 drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++---
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 13 +++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +++++++-------------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  4 +---
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  4 ++--
 7 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 11a78ceae568..950c133d4220 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -153,8 +153,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	return total;
 }
 
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, struct ib_umem *umem,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs, int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift)
 {
 	struct ib_block_iter biter;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a835368548e5..03b6546f63cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -892,8 +892,7 @@ struct hns_roce_hw {
 	int (*rereg_write_mtpt)(struct hns_roce_dev *hr_dev,
 				struct hns_roce_mr *mr, int flags,
 				void *mb_buf);
-	int (*frmr_write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
-			       struct hns_roce_mr *mr);
+	int (*frmr_write_mtpt)(void *mb_buf, struct hns_roce_mr *mr);
 	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
 	void (*write_cqc)(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
@@ -1193,7 +1192,7 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, struct hns_roce_buf *buf,
 			   unsigned int page_shift);
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs,
 			   int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 0ab514c49d5e..d3fabf64e390 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1043,15 +1043,13 @@ static void hem_list_free_all(struct hns_roce_dev *hr_dev,
 	}
 }
 
-static void hem_list_link_bt(struct hns_roce_dev *hr_dev, void *base_addr,
-			     u64 table_addr)
+static void hem_list_link_bt(void *base_addr, u64 table_addr)
 {
 	*(u64 *)(base_addr) = table_addr;
 }
 
 /* assign L0 table address to hem from root bt */
-static void hem_list_assign_bt(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_hem_item *hem, void *cpu_addr,
+static void hem_list_assign_bt(struct hns_roce_hem_item *hem, void *cpu_addr,
 			       u64 phy_addr)
 {
 	hem->addr = cpu_addr;
@@ -1222,8 +1220,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 		if (level > 1) {
 			pre = hem_ptrs[level - 1];
 			step = (cur->start - pre->start) / step * BA_BYTE_LEN;
-			hem_list_link_bt(hr_dev, pre->addr + step,
-					 cur->dma_addr);
+			hem_list_link_bt(pre->addr + step, cur->dma_addr);
 		}
 	}
 
@@ -1281,7 +1278,7 @@ static int alloc_fake_root_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	if (!hem)
 		return -ENOMEM;
 
-	hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
+	hem_list_assign_bt(hem, cpu_base, phy_base);
 	list_add(&hem->list, branch_head);
 	list_add(&hem->sibling, leaf_head);
 
@@ -1304,7 +1301,7 @@ static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	/* if exist mid bt, link L1 to L0 */
 	list_for_each_entry_safe(hem, temp_hem, branch_head, list) {
 		offset = (hem->start - r->offset) / step * BA_BYTE_LEN;
-		hem_list_link_bt(hr_dev, cpu_base + offset, hem->dma_addr);
+		hem_list_link_bt(cpu_base + offset, hem->dma_addr);
 		total++;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a396ba85cdce..aed9c403f3be 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3292,8 +3292,7 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
-				       void *mb_buf, struct hns_roce_mr *mr)
+static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 {
 	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
 	struct hns_roce_v2_mpt_entry *mpt_entry;
@@ -4208,8 +4207,7 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 }
 
 static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
-			    struct hns_roce_v2_qp_context *context,
-			    struct hns_roce_v2_qp_context *qpc_mask)
+			    struct hns_roce_v2_qp_context *context)
 {
 	hr_reg_write(context, QPC_SGE_SHIFT,
 		     to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
@@ -4231,7 +4229,6 @@ static inline int get_pdn(struct ib_pd *ib_pd)
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
-				    const struct ib_qp_attr *attr,
 				    struct hns_roce_v2_qp_context *context,
 				    struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4250,7 +4247,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 
 	hr_reg_write(context, QPC_RQWS, ilog2(hr_qp->rq.max_gs));
 
-	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
+	set_qpc_wqe_cnt(hr_qp, context);
 
 	/* No VLAN need to set 0xFFF */
 	hr_reg_write(context, QPC_VLAN_ID, 0xfff);
@@ -4291,7 +4288,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
-				   const struct ib_qp_attr *attr,
 				   struct hns_roce_v2_qp_context *context,
 				   struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4612,8 +4608,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	return 0;
 }
 
-static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
-				const struct ib_qp_attr *attr, int attr_mask,
+static int modify_qp_rtr_to_rts(struct ib_qp *ibqp, int attr_mask,
 				struct hns_roce_v2_qp_context *context,
 				struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4982,15 +4977,14 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
-		modify_qp_reset_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_reset_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_init_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
 					    qpc_mask, udata);
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
-		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
-					   qpc_mask);
+		ret = modify_qp_rtr_to_rts(ibqp, attr_mask, context, qpc_mask);
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7b59b95f87c2..acdcd5c9f42f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -154,7 +154,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	if (mr->type != MR_TYPE_FRMR)
 		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr);
 	else
-		ret = hr_dev->hw->frmr_write_mtpt(hr_dev, mailbox->buf, mr);
+		ret = hr_dev->hw->frmr_write_mtpt(mailbox->buf, mr);
 	if (ret) {
 		dev_err(dev, "failed to write mtpt, ret = %d.\n", ret);
 		goto err_page;
@@ -714,7 +714,7 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		return -ENOMEM;
 
 	if (mtr->umem)
-		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count,
+		npage = hns_roce_get_umem_bufs(pages, page_count,
 					       mtr->umem, page_shift);
 	else
 		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 88a4777d29f8..97d79c8d5cd0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1075,7 +1075,6 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 }
 
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
-				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
@@ -1229,7 +1228,6 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 	struct ib_device *ibdev = qp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_qp *hr_qp = to_hr_qp(qp);
-	struct ib_pd *pd = qp->pd;
 	int ret;
 
 	ret = check_qp_type(hr_dev, init_attr->qp_type, !!udata);
@@ -1244,7 +1242,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 	}
 
-	ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, hr_qp);
+	ret = hns_roce_create_qp_common(hr_dev, init_attr, udata, hr_qp);
 	if (ret)
 		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 652508b660a0..80fcb1b0e8fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -249,7 +249,7 @@ static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
 }
 
-static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static int alloc_srq_wrid(struct hns_roce_srq *srq)
 {
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
 	if (!srq->wrid)
@@ -365,7 +365,7 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_idx;
 
 	if (!udata) {
-		ret = alloc_srq_wrid(hr_dev, srq);
+		ret = alloc_srq_wrid(srq);
 		if (ret)
 			goto err_wqe_buf;
 	}
-- 
2.39.5




