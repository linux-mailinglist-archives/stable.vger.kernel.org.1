Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15B76143C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjGYLR1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjGYLRM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C110D2114
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4861061691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A67C433C8;
        Tue, 25 Jul 2023 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283827;
        bh=+g1KtJZPYvQnsKfW2VvX7Skejnpihu9cHCDFZ+mSDd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2uABFO9Akg+oB/7SfZQLDR2TM0Gzh4ijc/VYAitdJZX78ibOcmW7yWIWQldOQCLb
         ZhSbOqLk94fA/iF8MNwwBD/jyS4WgaBDikUFSKsyjEZ7WuuFwiLBVBTHEM3sKD7zfb
         7pROWvk4UKCuJZHswwO6aJS+aMyFdzk4ACW5Bfdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 137/509] RDMA/hns: Fix coding style issues
Date:   Tue, 25 Jul 2023 12:41:16 +0200
Message-ID: <20230725104600.020109562@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Lang Cheng <chenglang@huawei.com>

[ Upstream commit dc93a0d987fcfe93b132871e72d4ea5aff36dd5c ]

Just format the code without modifying anything, including fixing some
redundant and missing blanks and spaces and changing the variable
definition order.

Link: https://lore.kernel.org/r/1607650657-35992-8-git-send-email-liweihang@huawei.com
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: cf5b608fb0e3 ("RDMA/hns: Fix hns_roce_table_get return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c   | 27 +++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_cmd.h   |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 20 ++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hem.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  9 +++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  6 ++---
 drivers/infiniband/hw/hns/hns_roce_main.c  |  6 ++---
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  2 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  1 -
 13 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 455d533dd7c4a..c493d7644b577 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -36,9 +36,9 @@
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 
-#define CMD_POLL_TOKEN		0xffff
-#define CMD_MAX_NUM		32
-#define CMD_TOKEN_MASK		0x1f
+#define CMD_POLL_TOKEN 0xffff
+#define CMD_MAX_NUM 32
+#define CMD_TOKEN_MASK 0x1f
 
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
 				     u64 out_param, u32 in_modifier,
@@ -93,8 +93,8 @@ static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev, u64 in_param,
 void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 			u64 out_param)
 {
-	struct hns_roce_cmd_context
-		*context = &hr_dev->cmd.context[token & hr_dev->cmd.token_mask];
+	struct hns_roce_cmd_context *context =
+		&hr_dev->cmd.context[token % hr_dev->cmd.max_cmds];
 
 	if (token != context->token)
 		return;
@@ -164,8 +164,8 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 	int ret;
 
 	down(&hr_dev->cmd.event_sem);
-	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
-				       in_modifier, op_modifier, op, timeout);
+	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param, in_modifier,
+				       op_modifier, op, timeout);
 	up(&hr_dev->cmd.event_sem);
 
 	return ret;
@@ -231,9 +231,8 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
 	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
 	int i;
 
-	hr_cmd->context = kmalloc_array(hr_cmd->max_cmds,
-					sizeof(*hr_cmd->context),
-					GFP_KERNEL);
+	hr_cmd->context =
+		kcalloc(hr_cmd->max_cmds, sizeof(*hr_cmd->context), GFP_KERNEL);
 	if (!hr_cmd->context)
 		return -ENOMEM;
 
@@ -262,8 +261,8 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 	hr_cmd->use_events = 0;
 }
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmd_mailbox *mailbox;
 
@@ -271,8 +270,8 @@ struct hns_roce_cmd_mailbox
 	if (!mailbox)
 		return ERR_PTR(-ENOMEM);
 
-	mailbox->buf = dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL,
-				      &mailbox->dma);
+	mailbox->buf =
+		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
 	if (!mailbox->buf) {
 		kfree(mailbox);
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.h b/drivers/infiniband/hw/hns/hns_roce_cmd.h
index 1915bacaded0a..8e63b827f28cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.h
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.h
@@ -143,8 +143,8 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 		      unsigned long in_modifier, u8 op_modifier, u16 op,
 		      unsigned long timeout);
 
-struct hns_roce_cmd_mailbox
-	*hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
+struct hns_roce_cmd_mailbox *
+hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev);
 void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmd_mailbox *mailbox);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 8a6bded9c11cb..9200e6477e1ed 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -41,9 +41,9 @@
 
 static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 {
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_cmd_mailbox *mailbox;
 	struct hns_roce_cq_table *cq_table;
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	dma_addr_t dma_handle;
 	int ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c880a8be7e3cd..edc287a0a91a1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -198,9 +198,9 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	u32 chunk_ba_num;
+	u32 chunk_size;
 	u32 table_idx;
 	u32 bt_num;
-	u32 chunk_size;
 
 	if (get_hem_table_config(hr_dev, mhop, table->type))
 		return -EINVAL;
@@ -332,15 +332,15 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 {
 	spinlock_t *lock = &hr_dev->bt_cmd_lock;
 	struct device *dev = hr_dev->dev;
-	long end;
-	unsigned long flags;
 	struct hns_roce_hem_iter iter;
 	void __iomem *bt_cmd;
 	__le32 bt_cmd_val[2];
 	__le32 bt_cmd_h = 0;
+	unsigned long flags;
 	__le32 bt_cmd_l;
-	u64 bt_ba;
 	int ret = 0;
+	u64 bt_ba;
+	long end;
 
 	/* Find the HEM(Hardware Entry Memory) entry */
 	unsigned long i = (obj & (table->num_obj - 1)) /
@@ -640,8 +640,8 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		       struct hns_roce_hem_table *table, unsigned long obj)
 {
 	struct device *dev = hr_dev->dev;
-	int ret = 0;
 	unsigned long i;
+	int ret = 0;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type))
 		return hns_roce_table_mhop_get(hr_dev, table, obj);
@@ -789,14 +789,14 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_chunk *chunk;
 	struct hns_roce_hem_mhop mhop;
 	struct hns_roce_hem *hem;
-	void *addr = NULL;
 	unsigned long mhop_obj = obj;
 	unsigned long obj_per_chunk;
 	unsigned long idx_offset;
 	int offset, dma_offset;
+	void *addr = NULL;
+	u32 hem_idx = 0;
 	int length;
 	int i, j;
-	u32 hem_idx = 0;
 
 	if (!table->lowmem)
 		return NULL;
@@ -966,8 +966,8 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_hem_mhop mhop;
 	u32 buf_chunk_size;
-	int i;
 	u64 obj;
+	int i;
 
 	if (hns_roce_calc_hem_mhop(hr_dev, table, NULL, &mhop))
 		return;
@@ -1298,8 +1298,8 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 				  const struct hns_roce_buf_region *regions,
 				  int region_cnt)
 {
-	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	struct list_head temp_list[HNS_ROCE_MAX_BT_REGION];
+	struct roce_hem_item *hem, *temp_hem, *root_hem;
 	const struct hns_roce_buf_region *r;
 	struct list_head temp_root;
 	struct list_head temp_btm;
@@ -1404,8 +1404,8 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
-	int ret;
 	int unit;
+	int ret;
 	int i;
 
 	if (region_cnt > HNS_ROCE_MAX_BT_REGION) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index b34c940077bb5..112243d112c23 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -174,4 +174,4 @@ static inline dma_addr_t hns_roce_hem_addr(struct hns_roce_hem_iter *iter)
 	return sg_dma_address(&iter->chunk->mem[iter->page_idx]);
 }
 
-#endif /*_HNS_ROCE_HEM_H*/
+#endif /* _HNS_ROCE_HEM_H */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index b3d5ba8ef439a..cec705b58a847 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -239,7 +239,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				break;
 			}
 
-			/*Ctrl field, ctrl set type: sig, solic, imm, fence */
+			/* Ctrl field, ctrl set type: sig, solic, imm, fence */
 			/* SO wait for conforming application scenarios */
 			ctrl->flag |= (wr->send_flags & IB_SEND_SIGNALED ?
 				      cpu_to_le32(HNS_ROCE_WQE_CQ_NOTIFY) : 0) |
@@ -300,7 +300,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 				}
 				ctrl->flag |= cpu_to_le32(HNS_ROCE_WQE_INLINE);
 			} else {
-				/*sqe num is two */
+				/* sqe num is two */
 				for (i = 0; i < wr->num_sge; i++)
 					set_data_seg(dseg + i, wr->sg_list + i);
 
@@ -1165,7 +1165,7 @@ static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 	}
 	raq->e_raq_buf->map = addr;
 
-	/* Configure raq extended address. 48bit 4K align*/
+	/* Configure raq extended address. 48bit 4K align */
 	roce_write(hr_dev, ROCEE_EXT_RAQ_REG, raq->e_raq_buf->map >> 12);
 
 	/* Configure raq_shift */
@@ -2760,7 +2760,6 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_field(context->qpc_bytes_16,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_M,
 			       QP_CONTEXT_QPC_BYTES_16_QP_NUM_S, hr_qp->qpn);
-
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
 		roce_set_field(context->qpc_bytes_4,
 			       QP_CONTEXT_QPC_BYTES_4_TRANSPORT_SERVICE_TYPE_M,
@@ -3793,7 +3792,6 @@ static int hns_roce_v1_aeq_int(struct hns_roce_dev *hr_dev,
 	int event_type;
 
 	while ((aeqe = next_aeqe_sw_v1(eq))) {
-
 		/* Make sure we read the AEQ entry after we have checked the
 		 * ownership bit
 		 */
@@ -3898,7 +3896,6 @@ static int hns_roce_v1_ceq_int(struct hns_roce_dev *hr_dev,
 	u32 cqn;
 
 	while ((ceqe = next_ceqe_sw_v1(eq))) {
-
 		/* Make sure we read CEQ entry after we have checked the
 		 * ownership bit
 		 */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index ffd0156080f52..46ab0a321d211 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -419,7 +419,7 @@ struct hns_roce_wqe_data_seg {
 
 struct hns_roce_wqe_raddr_seg {
 	__le32 rkey;
-	__le32 len;/* reserved */
+	__le32 len; /* reserved */
 	__le64 raddr;
 };
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 76ed547b76ea7..322f341f41458 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1028,8 +1028,8 @@ static int hns_roce_v2_rst_process_cmd(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long instance_stage;	/* the current instance stage */
-	unsigned long reset_stage;	/* the current reset stage */
+	unsigned long instance_stage; /* the current instance stage */
+	unsigned long reset_stage; /* the current reset stage */
 	unsigned long reset_cnt;
 	bool sw_resetting;
 	bool hw_resetting;
@@ -2434,7 +2434,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 		if (i < (pg_num - 1))
 			entry[i].blk_ba1_nxt_ptr |=
 				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
-
 	}
 	link_tbl->npages = pg_num;
 	link_tbl->pg_sz = buf_chk_sz;
@@ -5540,16 +5539,14 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW:
 			hns_roce_cq_event(hr_dev, cqn, event_type);
 			break;
-		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_MB:
 			hns_roce_cmd_event(hr_dev,
 					le16_to_cpu(aeqe->event.cmd.token),
 					aeqe->event.cmd.status,
 					le64_to_cpu(aeqe->event.cmd.out_param));
 			break;
+		case HNS_ROCE_EVENT_TYPE_DB_OVERFLOW:
 		case HNS_ROCE_EVENT_TYPE_CEQ_OVERFLOW:
-			break;
 		case HNS_ROCE_EVENT_TYPE_FLR:
 			break;
 		default:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 8a92faeb3d237..8948d2b5577d5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -440,7 +440,7 @@ struct hns_roce_srq_context {
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_S 1
 #define SRQC_BYTE_60_SRQ_DB_RECORD_ADDR_M GENMASK(31, 1)
 
-enum{
+enum {
 	V2_MPT_ST_VALID = 0x1,
 	V2_MPT_ST_FREE	= 0x2,
 };
@@ -1076,9 +1076,9 @@ struct hns_roce_v2_ud_send_wqe {
 	__le32	dmac;
 	__le32	byte_48;
 	u8	dgid[GID_LEN_V2];
-
 };
-#define	V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
+
+#define V2_UD_SEND_WQE_BYTE_4_OPCODE_S 0
 #define V2_UD_SEND_WQE_BYTE_4_OPCODE_M GENMASK(4, 0)
 
 #define	V2_UD_SEND_WQE_BYTE_4_OWNER_S 7
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8cc2dae269aff..90cbd15f64415 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -582,8 +582,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	ret = hns_roce_init_hem_table(hr_dev, &hr_dev->mr_table.mtpt_table,
 				      HEM_TYPE_MTPT, hr_dev->caps.mtpt_entry_sz,
@@ -723,8 +723,8 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
  */
 static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	spin_lock_init(&hr_dev->sm_lock);
 	spin_lock_init(&hr_dev->bt_cmd_lock);
@@ -847,8 +847,8 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
-	int ret;
 	struct device *dev = hr_dev->dev;
+	int ret;
 
 	if (hr_dev->hw->reset) {
 		ret = hr_dev->hw->reset(hr_dev, true);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 1c342a7bd7dff..d5b3b10e0a807 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -167,10 +167,10 @@ static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
 static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_mr *mr)
 {
-	int ret;
 	unsigned long mtpt_idx = key_to_hw_index(mr->key);
-	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
+	struct device *dev = hr_dev->dev;
+	int ret;
 
 	/* Allocate mailbox memory */
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6fe98af7741b5..c42c6761382d1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -114,8 +114,8 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 				 enum hns_roce_event type)
 {
-	struct ib_event event;
 	struct ib_qp *ibqp = &hr_qp->ibqp;
+	struct ib_event event;
 
 	if (ibqp->event_handler) {
 		event.device = ibqp->device;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 08df97e0a6654..02e2416b5fed6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -245,7 +245,6 @@ static int alloc_srq_idx(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 			err = -ENOMEM;
 			goto err_idx_mtr;
 		}
-
 	}
 
 	return 0;
-- 
2.39.2



