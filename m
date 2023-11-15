Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3D7ED41A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjKOU4v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344523AbjKOU4u (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D8B0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244C8C4E77B;
        Wed, 15 Nov 2023 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081807;
        bh=xCO7M638w8iGPLr8PvmxaUs+cqdLblU8cdO0z6SpOKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1XpKUc9PgXteamGV8rL1G+Fw3UOIng8Z+1ASdHUHnO2nnRn7MdcT7O934osmiaEz
         huxTbMN4yO2Xs+eURkUliVVzEOc+bEPYUbjJFTUJfQiKPXgVlIfSl6vLPfNTp1uZWE
         LQviI1VTAJvYCX3B+M9Q/JQ4kH9zGRiimcJT4yRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 102/191] RDMA/hns: Fix signed-unsigned mixed comparisons
Date:   Wed, 15 Nov 2023 15:46:17 -0500
Message-ID: <20231115204650.698305205@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit b5f9efff101b06fd06a5e280a2b00b1335f5f476 ]

The ib_mtu_enum_to_int() and uverbs_attr_get_len() may returns a negative
value. In this case, mixed comparisons of signed and unsigned types will
throw wrong results.

This patch adds judgement for this situation.

Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20231017125239.164455-4-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 322f341f41458..518b38e9158d4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -247,7 +247,7 @@ static bool check_inl_data_len(struct hns_roce_qp *qp, unsigned int len)
 	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	int mtu = ib_mtu_enum_to_int(qp->path_mtu);
 
-	if (len > qp->max_inline_data || len > mtu) {
+	if (mtu < 0 || len > qp->max_inline_data || len > mtu) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "invalid length of data, data len = %u, max inline len = %u, path mtu = %d.\n",
 			  len, qp->max_inline_data, mtu);
-- 
2.42.0



