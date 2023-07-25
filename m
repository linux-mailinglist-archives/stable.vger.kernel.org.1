Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E4761440
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGYLRg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjGYLRS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB1999
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 845DC6168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCEBC433C8;
        Tue, 25 Jul 2023 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283835;
        bh=BVCPr4Imzrla/KICgdzBNMaMPlM+bQZa3bEdj+AlQIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icj018NtUH14gBZ63Pm3uEqCBtlHzSWtZeom6VEQVJhxo9DeH63fBCcgayOCiZg6I
         EEoOD2aKcTu0gBTgUfJSAl0pEd/3hUrsOmljMYD0N1k0hKhQAZ3MTq2edE716gdsjX
         MdRhPi6dzseIy2jbOk510tJXdFJOGZllC8AJ91uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xi Wang <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 139/509] RDMA/hns: Clean the hardware related code for HEM
Date:   Tue, 25 Jul 2023 12:41:18 +0200
Message-ID: <20230725104600.111730502@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit 68e11a6086b10e1a88d2b2c8432299f595db748d ]

Move the HIP06 related code to the hw v1 source file for HEM.

Link: https://lore.kernel.org/r/1621589395-2435-6-git-send-email-liweihang@huawei.com
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: cf5b608fb0e3 ("RDMA/hns: Fix hns_roce_table_get return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 -
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 82 +--------------------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  9 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 77 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  5 ++
 5 files changed, 85 insertions(+), 90 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d9aa7424d2902..09b5e4935c2ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -46,8 +46,6 @@
 
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
 
-#define HNS_ROCE_BA_SIZE			(32 * 4096)
-
 #define BA_BYTE_LEN				8
 
 /* Hardware specification only for v1 engine */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 831e9476c6284..3c3187f22216a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -36,9 +36,6 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_common.h"
 
-#define DMA_ADDR_T_SHIFT		12
-#define BT_BA_SHIFT			32
-
 #define HEM_INDEX_BUF			BIT(0)
 #define HEM_INDEX_L0			BIT(1)
 #define HEM_INDEX_L1			BIT(2)
@@ -326,81 +323,6 @@ void hns_roce_free_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem *hem)
 	kfree(hem);
 }
 
-static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_hem_table *table, unsigned long obj)
-{
-	spinlock_t *lock = &hr_dev->bt_cmd_lock;
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_hem_iter iter;
-	void __iomem *bt_cmd;
-	__le32 bt_cmd_val[2];
-	__le32 bt_cmd_h = 0;
-	unsigned long flags;
-	__le32 bt_cmd_l;
-	int ret = 0;
-	u64 bt_ba;
-	long end;
-
-	/* Find the HEM(Hardware Entry Memory) entry */
-	unsigned long i = (obj & (table->num_obj - 1)) /
-			  (table->table_chunk_size / table->obj_size);
-
-	switch (table->type) {
-	case HEM_TYPE_QPC:
-	case HEM_TYPE_MTPT:
-	case HEM_TYPE_CQC:
-	case HEM_TYPE_SRQC:
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
-		break;
-	default:
-		return ret;
-	}
-
-	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
-		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
-
-	/* Currently iter only a chunk */
-	for (hns_roce_hem_first(table->hem[i], &iter);
-	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
-		bt_ba = hns_roce_hem_addr(&iter) >> DMA_ADDR_T_SHIFT;
-
-		spin_lock_irqsave(lock, flags);
-
-		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
-
-		end = HW_SYNC_TIMEOUT_MSECS;
-		while (end > 0) {
-			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
-				break;
-
-			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
-			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
-		}
-
-		if (end <= 0) {
-			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
-			spin_unlock_irqrestore(lock, flags);
-			return -EBUSY;
-		}
-
-		bt_cmd_l = cpu_to_le32(bt_ba);
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
-			       bt_ba >> BT_BA_SHIFT);
-
-		bt_cmd_val[0] = bt_cmd_l;
-		bt_cmd_val[1] = bt_cmd_h;
-		hns_roce_write64_k(bt_cmd_val,
-				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
-		spin_unlock_irqrestore(lock, flags);
-	}
-
-	return ret;
-}
-
 static int calc_hem_config(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_table *table, unsigned long obj,
 			   struct hns_roce_hem_mhop *mhop,
@@ -666,7 +588,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Set HEM base address(128K/page, pa) to Hardware */
-	if (hns_roce_set_hem(hr_dev, table, obj)) {
+	if (hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT)) {
 		hns_roce_free_hem(hr_dev, table->hem[i]);
 		table->hem[i] = NULL;
 		ret = -ENODEV;
@@ -771,7 +693,7 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 					 &table->mutex))
 		return;
 
-	if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
+	if (hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT))
 		dev_warn(dev, "failed to clear HEM base address.\n");
 
 	hns_roce_free_hem(hr_dev, table->hem[i]);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 03d44e2efa473..b7617786b1005 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -34,9 +34,7 @@
 #ifndef _HNS_ROCE_HEM_H
 #define _HNS_ROCE_HEM_H
 
-#define HW_SYNC_SLEEP_TIME_INTERVAL	20
-#define HW_SYNC_TIMEOUT_MSECS           (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
-#define BT_CMD_SYNC_SHIFT		31
+#define HEM_HOP_STEP_DIRECT 0xff
 
 enum {
 	/* MAP HEM(Hardware Entry Memory) */
@@ -73,11 +71,6 @@ enum {
 	(type >= HEM_TYPE_MTT && hop_num == 1) || \
 	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
 
-enum {
-	 HNS_ROCE_HEM_PAGE_SHIFT = 12,
-	 HNS_ROCE_HEM_PAGE_SIZE  = 1 << HNS_ROCE_HEM_PAGE_SHIFT,
-};
-
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
 	int			 npages;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index cec705b58a847..6f9b024d4ff7c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -450,6 +450,82 @@ static void hns_roce_set_db_event_mode(struct hns_roce_dev *hr_dev,
 	roce_write(hr_dev, ROCEE_GLB_CFG_REG, val);
 }
 
+static int hns_roce_v1_set_hem(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_hem_table *table, int obj,
+			       int step_idx)
+{
+	spinlock_t *lock = &hr_dev->bt_cmd_lock;
+	struct device *dev = hr_dev->dev;
+	struct hns_roce_hem_iter iter;
+	void __iomem *bt_cmd;
+	__le32 bt_cmd_val[2];
+	__le32 bt_cmd_h = 0;
+	unsigned long flags;
+	__le32 bt_cmd_l;
+	int ret = 0;
+	u64 bt_ba;
+	long end;
+
+	/* Find the HEM(Hardware Entry Memory) entry */
+	unsigned long i = (obj & (table->num_obj - 1)) /
+			  (table->table_chunk_size / table->obj_size);
+
+	switch (table->type) {
+	case HEM_TYPE_QPC:
+	case HEM_TYPE_MTPT:
+	case HEM_TYPE_CQC:
+	case HEM_TYPE_SRQC:
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
+			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
+		break;
+	default:
+		return ret;
+	}
+
+	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
+		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
+
+	/* Currently iter only a chunk */
+	for (hns_roce_hem_first(table->hem[i], &iter);
+	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
+		bt_ba = hns_roce_hem_addr(&iter) >> HNS_HW_PAGE_SHIFT;
+
+		spin_lock_irqsave(lock, flags);
+
+		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
+
+		end = HW_SYNC_TIMEOUT_MSECS;
+		while (end > 0) {
+			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
+				break;
+
+			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
+			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
+		}
+
+		if (end <= 0) {
+			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
+			spin_unlock_irqrestore(lock, flags);
+			return -EBUSY;
+		}
+
+		bt_cmd_l = cpu_to_le32(bt_ba);
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
+			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
+			       upper_32_bits(bt_ba));
+
+		bt_cmd_val[0] = bt_cmd_l;
+		bt_cmd_val[1] = bt_cmd_h;
+		hns_roce_write64_k(bt_cmd_val,
+				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
+		spin_unlock_irqrestore(lock, flags);
+	}
+
+	return ret;
+}
+
 static void hns_roce_set_db_ext_mode(struct hns_roce_dev *hr_dev, u32 sdb_mode,
 				     u32 odb_mode)
 {
@@ -4358,6 +4434,7 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.set_mtu = hns_roce_v1_set_mtu,
 	.write_mtpt = hns_roce_v1_write_mtpt,
 	.write_cqc = hns_roce_v1_write_cqc,
+	.set_hem = hns_roce_v1_set_hem,
 	.clear_hem = hns_roce_v1_clear_hem,
 	.modify_qp = hns_roce_v1_modify_qp,
 	.query_qp = hns_roce_v1_query_qp,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index 46ab0a321d211..9ff1a41ddec3f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -1042,6 +1042,11 @@ struct hns_roce_db_table {
 	struct hns_roce_ext_db *ext_db;
 };
 
+#define HW_SYNC_SLEEP_TIME_INTERVAL 20
+#define HW_SYNC_TIMEOUT_MSECS (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
+#define BT_CMD_SYNC_SHIFT 31
+#define HNS_ROCE_BA_SIZE (32 * 4096)
+
 struct hns_roce_bt_table {
 	struct hns_roce_buf_list qpc_buf;
 	struct hns_roce_buf_list mtpt_buf;
-- 
2.39.2



