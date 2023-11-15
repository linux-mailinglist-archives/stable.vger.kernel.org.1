Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037537ECF11
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjKOTqO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjKOTqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0BAD4B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB7FC433C9;
        Wed, 15 Nov 2023 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077563;
        bh=k3TMa1dRtSBDIOwj9fxSxj6Z43XwT/7YxlX8gs4K0jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdnI1CY+atVCXqZ/gsnJHG/8JvpQiknleXCcSH3p6vayNzVueOIQ9sR5oeJ+NgZ2c
         pQZEERnf+u0N0WDMQyO0M7pE8wKW83AbZHpw7xXKYLUOkprpf0L8Uh+ry4aznAhAFg
         CjQDJDlCqza2jeICtMjzxP7rI4lR1+8jgvZj0aTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luoyouming <luoyouming@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 380/603] RDMA/hns: Add check for SL
Date:   Wed, 15 Nov 2023 14:15:25 -0500
Message-ID: <20231115191639.661211822@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luoyouming <luoyouming@huawei.com>

[ Upstream commit 5e617c18b1f34ec57ad5dce44f09de603cf6bd6c ]

SL set by users may exceed the capability of devices. So add check
for this situation.

Fixes: fba429fcf9a5 ("RDMA/hns: Fix missing fields in address vector")
Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Fixes: f0cb411aad23 ("RDMA/hns: Use new interface to modify QP context")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20231017125239.164455-5-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c    | 13 +++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 23 ++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index e77fcc74f15c4..3df032ddda189 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -33,7 +33,9 @@
 #include <linux/pci.h>
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_device.h"
+#include "hns_roce_hw_v2.h"
 
 static inline u16 get_ah_udp_sport(const struct rdma_ah_attr *ah_attr)
 {
@@ -57,6 +59,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibah->device);
 	struct hns_roce_ah *ah = to_hr_ah(ibah);
 	int ret = 0;
+	u32 max_sl;
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata)
 		return -EOPNOTSUPP;
@@ -70,9 +73,17 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.hop_limit = grh->hop_limit;
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
-	ah->av.sl = rdma_ah_get_sl(ah_attr);
 	ah->av.tclass = get_tclass(grh);
 
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
+	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
+	if (unlikely(ah->av.sl > max_sl)) {
+		ibdev_err_ratelimited(&hr_dev->ib_dev,
+				      "failed to set sl, sl (%u) shouldn't be larger than %u.\n",
+				      ah->av.sl, max_sl);
+		return -EINVAL;
+	}
+
 	memcpy(ah->av.dgid, grh->dgid.raw, HNS_ROCE_GID_SIZE);
 	memcpy(ah->av.mac, ah_attr->roce.dmac, ETH_ALEN);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3daa684f88362..b7faf5c8f6ba8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4821,22 +4821,32 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	const struct ib_gid_attr *gid_attr = NULL;
+	u8 sl = rdma_ah_get_sl(&attr->ah_attr);
 	int is_roce_protocol;
 	u16 vlan_id = 0xffff;
 	bool is_udp = false;
+	u32 max_sl;
 	u8 ib_port;
 	u8 hr_port;
 	int ret;
 
+	max_sl = min_t(u32, MAX_SERVICE_LEVEL, hr_dev->caps.sl_num - 1);
+	if (unlikely(sl > max_sl)) {
+		ibdev_err_ratelimited(ibdev,
+				      "failed to fill QPC, sl (%u) shouldn't be larger than %u.\n",
+				      sl, max_sl);
+		return -EINVAL;
+	}
+
 	/*
 	 * If free_mr_en of qp is set, it means that this qp comes from
 	 * free mr. This qp will perform the loopback operation.
 	 * In the loopback scenario, only sl needs to be set.
 	 */
 	if (hr_qp->free_mr_en) {
-		hr_reg_write(context, QPC_SL, rdma_ah_get_sl(&attr->ah_attr));
+		hr_reg_write(context, QPC_SL, sl);
 		hr_reg_clear(qpc_mask, QPC_SL);
-		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+		hr_qp->sl = sl;
 		return 0;
 	}
 
@@ -4903,14 +4913,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
 
-	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
-	if (unlikely(hr_qp->sl > MAX_SERVICE_LEVEL)) {
-		ibdev_err(ibdev,
-			  "failed to fill QPC, sl (%u) shouldn't be larger than %d.\n",
-			  hr_qp->sl, MAX_SERVICE_LEVEL);
-		return -EINVAL;
-	}
-
+	hr_qp->sl = sl;
 	hr_reg_write(context, QPC_SL, hr_qp->sl);
 	hr_reg_clear(qpc_mask, QPC_SL);
 
-- 
2.42.0



