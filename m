Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8F7A3C44
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbjIQU2v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbjIQU2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEE3101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C480C433C7;
        Sun, 17 Sep 2023 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982506;
        bh=my+2GnHzx5yQ/+wyiAgEnWoX6SAXVKHlUiMRx9H1SYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWYjKYGXcYLSx04qlbXniuYjuJimzCJAPIYrLjU19j0C+HBQbupy2C4zi9WC7mo44
         09/tUBcK1nldac2fpp3lKKbfE8cphR9BSqQUPR/E31Vh5wxQJ+pQVY/QpT9fUIU0rL
         CM4wryIlWF/0W3WOZA97/vfTeanATZKyvccpNxNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 270/511] RDMA/hns: Fix CQ and QP cache affinity
Date:   Sun, 17 Sep 2023 21:11:37 +0200
Message-ID: <20230917191120.362675615@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 9e03dbea2b0634b21a45946b4f8097e0dc86ebe1 ]

Currently, the affinity between QP cache and CQ cache is not
considered when assigning QPN, it will affect the message rate of HW.

Allocate QPN from QP cache with better CQ affinity to get better
performance.

Fixes: 71586dd20010 ("RDMA/hns: Create QP with selected QPN for bank load balance")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20230804012711.808069-5-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 28 ++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c94991356a2e8..e02107123c970 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -121,6 +121,7 @@
 #define HNS_ROCE_CQ_BANK_NUM 4
 
 #define CQ_BANKID_SHIFT 2
+#define CQ_BANKID_MASK GENMASK(1, 0)
 
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5d50d2d1deca9..00dade1cfff20 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -172,14 +172,29 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
-static u8 get_least_load_bankid_for_qp(struct hns_roce_bank *bank)
+static u8 get_affinity_cq_bank(u8 qp_bank)
 {
-	u32 least_load = bank[0].inuse;
+	return (qp_bank >> 1) & CQ_BANKID_MASK;
+}
+
+static u8 get_least_load_bankid_for_qp(struct ib_qp_init_attr *init_attr,
+					struct hns_roce_bank *bank)
+{
+#define INVALID_LOAD_QPNUM 0xFFFFFFFF
+	struct ib_cq *scq = init_attr->send_cq;
+	u32 least_load = INVALID_LOAD_QPNUM;
+	unsigned long cqn = 0;
 	u8 bankid = 0;
 	u32 bankcnt;
 	u8 i;
 
-	for (i = 1; i < HNS_ROCE_QP_BANK_NUM; i++) {
+	if (scq)
+		cqn = to_hr_cq(scq)->cqn;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
+			continue;
+
 		bankcnt = bank[i].inuse;
 		if (bankcnt < least_load) {
 			least_load = bankcnt;
@@ -211,7 +226,8 @@ static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
 
 	return 0;
 }
-static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		     struct ib_qp_init_attr *init_attr)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned long num = 0;
@@ -229,7 +245,7 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		hr_qp->doorbell_qpn = 1;
 	} else {
 		mutex_lock(&qp_table->bank_mutex);
-		bankid = get_least_load_bankid_for_qp(qp_table->bank);
+		bankid = get_least_load_bankid_for_qp(init_attr, qp_table->bank);
 
 		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
 					    &num);
@@ -1067,7 +1083,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_buf;
 	}
 
-	ret = alloc_qpn(hr_dev, hr_qp);
+	ret = alloc_qpn(hr_dev, hr_qp, init_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
 		goto err_qpn;
-- 
2.40.1



