Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B2726B11
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjFGUWQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjFGUWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A56FC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E1A643CA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D90C433EF;
        Wed,  7 Jun 2023 20:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169311;
        bh=mAZ03XoKWAxJOGFoCwWUOwbs7FEWGHQAv87DoxX5Z38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPQqbD8baDTvpGA9Riu9jV2a26ra0hUx21xqtO1Tw+tRZSPPDSSvE8H8ji8ScsvcX
         +o0O76jWBw51b4VXpQCIHbbLmrvaDq3bXEp6SjXxpAU1HIuTgRAC2im741d4wMiTDs
         3exMGEMLQw13h1o/GL5dkW/OuUEBSRkVQTI56JKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 004/286] RDMA/hns: Fix timeout attr in query qp for HIP08
Date:   Wed,  7 Jun 2023 22:11:43 +0200
Message-ID: <20230607200923.133593902@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 58caa2a51ad4fd21763696cc6c4defc9fc1b4b4f ]

On HIP08, the queried timeout attr is different from the timeout attr
configured by the user.

It is found by rdma-core testcase test_rdmacm_async_traffic:

======================================================================
FAIL: test_rdmacm_async_traffic (tests.test_rdmacm.CMTestCase)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "./tests/test_rdmacm.py", line 33, in test_rdmacm_async_traffic
    self.two_nodes_rdmacm_traffic(CMAsyncConnection, self.rdmacm_traffic,
  File "./tests/base.py", line 382, in two_nodes_rdmacm_traffic
    raise(res)
AssertionError

Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
Link: https://lore.kernel.org/r/20230512092245.344442-2-huangjunxian6@hisilicon.com
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 ++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dbf97fe5948ff..79954d99dc7a3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5093,7 +5093,6 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 {
 #define QP_ACK_TIMEOUT_MAX_HIP08 20
-#define QP_ACK_TIMEOUT_OFFSET 10
 #define QP_ACK_TIMEOUT_MAX 31
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
@@ -5102,7 +5101,7 @@ static bool check_qp_timeout_cfg_range(struct hns_roce_dev *hr_dev, u8 *timeout)
 				   "local ACK timeout shall be 0 to 20.\n");
 			return false;
 		}
-		*timeout += QP_ACK_TIMEOUT_OFFSET;
+		*timeout += HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
 	} else if (hr_dev->pci_dev->revision > PCI_REVISION_ID_HIP08) {
 		if (*timeout > QP_ACK_TIMEOUT_MAX) {
 			ibdev_warn(&hr_dev->ib_dev,
@@ -5388,6 +5387,18 @@ static int hns_roce_v2_query_qpc(struct hns_roce_dev *hr_dev, u32 qpn,
 	return ret;
 }
 
+static u8 get_qp_timeout_attr(struct hns_roce_dev *hr_dev,
+			      struct hns_roce_v2_qp_context *context)
+{
+	u8 timeout;
+
+	timeout = (u8)hr_reg_read(context, QPC_AT);
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		timeout -= HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08;
+
+	return timeout;
+}
+
 static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 				int qp_attr_mask,
 				struct ib_qp_init_attr *qp_init_attr)
@@ -5465,7 +5476,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->max_dest_rd_atomic = 1 << hr_reg_read(&context, QPC_RR_MAX);
 
 	qp_attr->min_rnr_timer = (u8)hr_reg_read(&context, QPC_MIN_RNR_TIME);
-	qp_attr->timeout = (u8)hr_reg_read(&context, QPC_AT);
+	qp_attr->timeout = get_qp_timeout_attr(hr_dev, &context);
 	qp_attr->retry_cnt = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
 	qp_attr->rnr_retry = hr_reg_read(&context, QPC_RNR_NUM_INIT);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index af9d00225cdf5..b5a336e182f83 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -72,6 +72,8 @@
 #define HNS_ROCE_V2_IDX_ENTRY_SZ		4
 
 #define HNS_ROCE_V2_SCCC_SZ			32
+#define HNS_ROCE_V2_QP_ACK_TIMEOUT_OFS_HIP08    10
+
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
-- 
2.39.2



