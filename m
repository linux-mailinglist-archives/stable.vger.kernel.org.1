Return-Path: <stable+bounces-51343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A3F906F6D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457A31C23608
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E4146A61;
	Thu, 13 Jun 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjJPeyu8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7A1465B0;
	Thu, 13 Jun 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281018; cv=none; b=QUuLHtgWkPrbAggj2jlFp7EastZHap/STs8DYxRXm2fug9ZNeJ6NKbD2YOE1gvXztBnpBqp8vmECCB/lMdP2XZ8keqARPxa3+NSQk/je0rZRoKwRJu9GYb0ItdIgbQlTcerOKZGTM4PuhgYBlcQrfqla8FkFJZHtofrv5CkWIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281018; c=relaxed/simple;
	bh=uMRNMjYVWZy/WnNRamBYHw+rT9DdtaxhDOeTDEB4rEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P74PkvhUs/DWNytQnuAbE35An2m3E5e/A1tpvRwGtTmhS/BxX7Ke4aVFpCTyYhX8hHQvWzFuIxm/gcXnPJLixNPdwQjU/3/+ooeWaeXVdf3ATX8onXXB7dLtECYz8A7dBPvTtYQ0PHdfPAO8PpXDsFLKtDIa6Jq9XRhTfjqvbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjJPeyu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BFC32786;
	Thu, 13 Jun 2024 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281018;
	bh=uMRNMjYVWZy/WnNRamBYHw+rT9DdtaxhDOeTDEB4rEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjJPeyu861kEa2Dtb1sl5m4zxoXFeyHSJBKj9daQAcWt13UB8UyIqFTsDcJj0nrMM
	 W+kzR9ki6os5fL2LJjAHtujhPqbX0GtEODGquM7F41j48rtcVC6D5QPPHJwnROzBoc
	 U88I4JT20TBm6Z1Gml7/UF+xEHiDHYGkn3TwMtRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenpeng Liang <liangwenpeng@huawei.com>,
	Weihang Li <liweihang@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 113/317] RDMA/hns: Fix incorrect symbol types
Date: Thu, 13 Jun 2024 13:32:11 +0200
Message-ID: <20240613113251.921024544@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenpeng Liang <liangwenpeng@huawei.com>

[ Upstream commit dcdc366acf8ffc29f091a09e08b4e46caa0a0f21 ]

Types of some fields, variables and parameters of some functions should be
unsigned.

Link: https://lore.kernel.org/r/1607650657-35992-10-git-send-email-liweihang@huawei.com
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: 203b70fda634 ("RDMA/hns: Fix return value in hns_roce_map_mr_sg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 10 ++--
 drivers/infiniband/hw/hns/hns_roce_cmd.h    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_common.h | 14 +++---
 drivers/infiniband/hw/hns/hns_roce_db.c     |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h | 53 +++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 30 ++++++------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 11 ++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  8 ++--
 10 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index c493d7644b577..339e3fd98b0b4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -60,7 +60,7 @@ static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	int ret;
@@ -78,7 +78,7 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -108,7 +108,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				    u64 out_param, unsigned long in_modifier,
 				    u8 op_modifier, u16 op,
-				    unsigned long timeout)
+				    unsigned int timeout)
 {
 	struct hns_roce_cmdq *cmd = &hr_dev->cmd;
 	struct hns_roce_cmd_context *context;
@@ -159,7 +159,7 @@ static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
-				  u8 op_modifier, u16 op, unsigned long timeout)
+				  u8 op_modifier, u16 op, unsigned int timeout)
 {
 	int ret;
 
@@ -173,7 +173,7 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout)
+		      unsigned int timeout)
 {
 	int ret;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 8e63b827f28cc..8025e7f657fa6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -141,7 +141,7 @@ enum {
 
 int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
-		      unsigned long timeout);
+		      unsigned int timeout);
 
 struct hns_roce_cmd_mailbox *
 hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff8cfebc..e57e812b1546d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -38,19 +38,19 @@
 #define roce_raw_write(value, addr) \
 	__raw_writel((__force u32)cpu_to_le32(value), (addr))
 
-#define roce_get_field(origin, mask, shift) \
-	(((le32_to_cpu(origin)) & (mask)) >> (shift))
+#define roce_get_field(origin, mask, shift)                                    \
+	((le32_to_cpu(origin) & (mask)) >> (u32)(shift))
 
 #define roce_get_bit(origin, shift) \
 	roce_get_field((origin), (1ul << (shift)), (shift))
 
-#define roce_set_field(origin, mask, shift, val) \
-	do { \
-		(origin) &= ~cpu_to_le32(mask); \
-		(origin) |= cpu_to_le32(((u32)(val) << (shift)) & (mask)); \
+#define roce_set_field(origin, mask, shift, val)                               \
+	do {                                                                   \
+		(origin) &= ~cpu_to_le32(mask);                                \
+		(origin) |= cpu_to_le32(((u32)(val) << (u32)(shift)) & (mask));     \
 	} while (0)
 
-#define roce_set_bit(origin, shift, val) \
+#define roce_set_bit(origin, shift, val)                                       \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index bff6abdccfb0c..5cb7376ce9789 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -95,8 +95,8 @@ static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 static int hns_roce_alloc_db_from_pgdir(struct hns_roce_db_pgdir *pgdir,
 					struct hns_roce_db *db, int order)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	for (o = order; o <= 1; ++o) {
 		i = find_first_bit(pgdir->bits[o], HNS_ROCE_DB_PER_PAGE >> o);
@@ -154,8 +154,8 @@ int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 
 void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 {
-	int o;
-	int i;
+	unsigned long o;
+	unsigned long i;
 
 	mutex_lock(&hr_dev->pgdir_mutex);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5f16173566614..db78bc2d44c21 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -315,7 +315,7 @@ struct hns_roce_hem_table {
 };
 
 struct hns_roce_buf_region {
-	int offset; /* page offset */
+	u32 offset; /* page offset */
 	u32 count; /* page count */
 	int hopnum; /* addressing hop num */
 };
@@ -335,10 +335,10 @@ struct hns_roce_buf_attr {
 		size_t	size;  /* region size */
 		int	hopnum; /* multi-hop addressing hop num */
 	} region[HNS_ROCE_MAX_BT_REGION];
-	int region_count; /* valid region count */
+	unsigned int region_count; /* valid region count */
 	unsigned int page_shift;  /* buffer page shift */
 	bool fixed_page; /* decide page shift is fixed-size or maximum size */
-	int user_access; /* umem access flag */
+	unsigned int user_access; /* umem access flag */
 	bool mtt_only; /* only alloc buffer-required MTT memory */
 };
 
@@ -349,7 +349,7 @@ struct hns_roce_hem_cfg {
 	unsigned int	buf_pg_shift; /* buffer page shift */
 	unsigned int	buf_pg_count;  /* buffer page count */
 	struct hns_roce_buf_region region[HNS_ROCE_MAX_BT_REGION];
-	int		region_count;
+	unsigned int	region_count;
 };
 
 /* memory translate region */
@@ -397,7 +397,7 @@ struct hns_roce_wq {
 	u64		*wrid;     /* Work request ID */
 	spinlock_t	lock;
 	u32		wqe_cnt;  /* WQE num */
-	int		max_gs;
+	u32		max_gs;
 	int		offset;
 	int		wqe_shift;	/* WQE size */
 	u32		head;
@@ -463,8 +463,8 @@ struct hns_roce_db {
 	} u;
 	dma_addr_t	dma;
 	void		*virt_addr;
-	int		index;
-	int		order;
+	unsigned long	index;
+	unsigned long	order;
 };
 
 struct hns_roce_cq {
@@ -512,8 +512,8 @@ struct hns_roce_srq {
 	u64		       *wrid;
 	struct hns_roce_idx_que idx_que;
 	spinlock_t		lock;
-	int			head;
-	int			tail;
+	u16			head;
+	u16			tail;
 	struct mutex		mutex;
 	void (*event)(struct hns_roce_srq *srq, enum hns_roce_event event);
 };
@@ -751,11 +751,11 @@ struct hns_roce_eq {
 	int				type_flag; /* Aeq:1 ceq:0 */
 	int				eqn;
 	u32				entries;
-	int				log_entries;
+	u32				log_entries;
 	int				eqe_size;
 	int				irq;
 	int				log_page_size;
-	int				cons_index;
+	u32				cons_index;
 	struct hns_roce_buf_list	*buf_list;
 	int				over_ignore;
 	int				coalesce;
@@ -763,7 +763,7 @@ struct hns_roce_eq {
 	int				hop_num;
 	struct hns_roce_mtr		mtr;
 	u16				eq_max_cnt;
-	int				eq_period;
+	u32				eq_period;
 	int				shift;
 	int				event_type;
 	int				sub_type;
@@ -786,8 +786,8 @@ struct hns_roce_caps {
 	u32		max_sq_inline;
 	u32		max_rq_sg;
 	u32		max_extend_sg;
-	int		num_qps;
-	u32             reserved_qps;
+	u32		num_qps;
+	u32		reserved_qps;
 	int		num_qpc_timer;
 	int		num_cqc_timer;
 	int		num_srqs;
@@ -799,7 +799,7 @@ struct hns_roce_caps {
 	u32		max_srq_desc_sz;
 	int		max_qp_init_rdma;
 	int		max_qp_dest_rdma;
-	int		num_cqs;
+	u32		num_cqs;
 	u32		max_cqes;
 	u32		min_cqes;
 	u32		min_wqes;
@@ -808,7 +808,7 @@ struct hns_roce_caps {
 	int		num_aeq_vectors;
 	int		num_comp_vectors;
 	int		num_other_vectors;
-	int		num_mtpts;
+	u32		num_mtpts;
 	u32		num_mtt_segs;
 	u32		num_cqe_segs;
 	u32		num_srqwqe_segs;
@@ -919,7 +919,7 @@ struct hns_roce_hw {
 	int (*post_mbox)(struct hns_roce_dev *hr_dev, u64 in_param,
 			 u64 out_param, u32 in_modifier, u8 op_modifier, u16 op,
 			 u16 token, int event);
-	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned long timeout);
+	int (*chk_mbox)(struct hns_roce_dev *hr_dev, unsigned int timeout);
 	int (*rst_prc_mbox)(struct hns_roce_dev *hr_dev);
 	int (*set_gid)(struct hns_roce_dev *hr_dev, u8 port, int gid_index,
 		       const union ib_gid *gid, const struct ib_gid_attr *attr);
@@ -1090,15 +1090,16 @@ static inline struct hns_roce_qp
 	return xa_load(&hr_dev->qp_table_xa, qpn & (hr_dev->caps.num_qps - 1));
 }
 
-static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf, int offset)
+static inline void *hns_roce_buf_offset(struct hns_roce_buf *buf,
+					unsigned int offset)
 {
 	return (char *)(buf->trunk_list[offset >> buf->trunk_shift].buf) +
 			(offset & ((1 << buf->trunk_shift) - 1));
 }
 
-static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, int idx)
+static inline dma_addr_t hns_roce_buf_page(struct hns_roce_buf *buf, u32 idx)
 {
-	int offset = idx << buf->page_shift;
+	unsigned int offset = idx << buf->page_shift;
 
 	return buf->trunk_list[offset >> buf->trunk_shift].map +
 			(offset & ((1 << buf->trunk_shift) - 1));
@@ -1173,7 +1174,7 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 void hns_roce_mtr_destroy(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_mtr *mtr);
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt);
+		     dma_addr_t *pages, unsigned int page_cnt);
 
 int hns_roce_init_pd_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
@@ -1256,10 +1257,10 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata);
 void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n);
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n);
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n);
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n);
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq);
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state);
 void hns_roce_lock_cqs(struct hns_roce_cq *send_cq,
@@ -1289,7 +1290,7 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn);
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type);
 void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type);
 void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type);
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index);
 void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev);
 int hns_roce_init(struct hns_roce_dev *hr_dev);
 void hns_roce_exit(struct hns_roce_dev *hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 6f9b024d4ff7c..ea8d7154d0e17 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -288,7 +288,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 					ret = -EINVAL;
 					*bad_wr = wr;
 					dev_err(dev, "inline len(1-%d)=%d, illegal",
-						ctrl->msg_length,
+						le32_to_cpu(ctrl->msg_length),
 						hr_dev->caps.max_sq_inline);
 					goto out;
 				}
@@ -1715,7 +1715,7 @@ static int hns_roce_v1_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v1_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	u8 __iomem *hcr = hr_dev->reg_base + ROCEE_MB1_REG;
 	unsigned long end;
@@ -3674,10 +3674,10 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	return 0;
 }
 
-static void set_eq_cons_index_v1(struct hns_roce_eq *eq, int req_not)
+static void set_eq_cons_index_v1(struct hns_roce_eq *eq, u32 req_not)
 {
 	roce_raw_write((eq->cons_index & HNS_ROCE_V1_CONS_IDX_M) |
-		      (req_not << eq->log_entries), eq->doorbell);
+		       (req_not << eq->log_entries), eq->doorbell);
 }
 
 static void hns_roce_v1_wq_catas_err_handle(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 518b38e9158d4..10ffad061f94a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -650,7 +650,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
 	void *wqe = NULL;
-	int nreq;
+	u32 nreq;
 	int ret;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
@@ -828,7 +828,7 @@ static void *get_srq_wqe(struct hns_roce_srq *srq, int n)
 	return hns_roce_buf_offset(srq->buf_mtr.kmem, n << srq->wqe_shift);
 }
 
-static void *get_idx_buf(struct hns_roce_idx_que *idx_que, int n)
+static void *get_idx_buf(struct hns_roce_idx_que *idx_que, unsigned int n)
 {
 	return hns_roce_buf_offset(idx_que->mtr.kmem,
 				   n << idx_que->entry_shift);
@@ -869,12 +869,12 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_v2_db srq_db;
 	unsigned long flags;
+	unsigned int ind;
 	__le32 *srq_idx;
 	int ret = 0;
 	int wqe_idx;
 	void *wqe;
 	int nreq;
-	int ind;
 	int i;
 
 	spin_lock_irqsave(&srq->lock, flags);
@@ -1128,7 +1128,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
 	} else {
@@ -1136,7 +1136,7 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
 		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
 			   upper_32_bits(dma));
 		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
-			   ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
 		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
 		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
 	}
@@ -1907,8 +1907,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	}
 }
 
-static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
-		       int *buf_page_size, int *bt_page_size, u32 hem_type)
+static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
+		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type)
 {
 	u64 obj_per_chunk;
 	u64 bt_chunk_size = PAGE_SIZE;
@@ -2382,10 +2382,10 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 	u32 buf_chk_sz;
 	dma_addr_t t;
 	int func_num = 1;
-	int pg_num_a;
-	int pg_num_b;
-	int pg_num;
-	int size;
+	u32 pg_num_a;
+	u32 pg_num_b;
+	u32 pg_num;
+	u32 size;
 	int i;
 
 	switch (type) {
@@ -2549,7 +2549,7 @@ static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_mbox_status *mb_st =
 				       (struct hns_roce_mbox_status *)desc.data;
-	enum hns_roce_cmd_return_status status;
+	int status;
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_MB_ST, true);
 
@@ -2620,7 +2620,7 @@ static int hns_roce_v2_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
 }
 
 static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
-				unsigned long timeout)
+				unsigned int timeout)
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long end;
@@ -2970,7 +2970,7 @@ static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
 }
 
-static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
+static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 {
 	struct hns_roce_v2_cqe *cqe = get_cqe_v2(hr_cq, n & hr_cq->ib_cq.cqe);
 
@@ -3314,7 +3314,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
-	int qpn;
+	u32 qpn;
 	int ret;
 
 	/* Find cqe according to consumer index */
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 90cbd15f64415..f62162771db51 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -53,7 +53,7 @@
  *		GID[0][0], GID[1][0],.....GID[N - 1][0],
  *		And so on
  */
-int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
+u8 hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
 {
 	return gid_index * hr_dev->caps.num_ports + port;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 13c7ac6ea3127..3d432a6918a78 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -508,7 +508,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
 		ret = 0;
 	} else {
-		mr->pbl_mtr.hem_cfg.buf_pg_shift = ilog2(ibmr->page_size);
+		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
 		ret = mr->npages;
 	}
 
@@ -827,12 +827,12 @@ static int mtr_get_pages(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 }
 
 int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		     dma_addr_t *pages, int page_cnt)
+		     dma_addr_t *pages, unsigned int page_cnt)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_region *r;
+	unsigned int i;
 	int err;
-	int i;
 
 	/*
 	 * Only use the first page address as root ba when hopnum is 0, this
@@ -869,13 +869,12 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
 {
 	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	int mtt_count, left;
 	int start_index;
-	int mtt_count;
 	int total = 0;
 	__le64 *mtts;
-	int npage;
+	u32 npage;
 	u64 addr;
-	int left;
 
 	if (!mtt_buf || mtt_max < 1)
 		goto done;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8323de2c4bf9a..3ed43a5c7596b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1318,22 +1318,22 @@ static inline void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
 }
 
-void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->rq.offset + (n << hr_qp->rq.wqe_shift));
 }
 
-void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sq.offset + (n << hr_qp->sq.wqe_shift));
 }
 
-void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n)
+void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, unsigned int n)
 {
 	return get_wqe(hr_qp, hr_qp->sge.offset + (n << hr_qp->sge.sge_shift));
 }
 
-bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
+bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, u32 nreq,
 			  struct ib_cq *ib_cq)
 {
 	struct hns_roce_cq *hr_cq;
-- 
2.43.0




