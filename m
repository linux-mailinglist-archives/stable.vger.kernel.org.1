Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620C0726F4B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjFGU5S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjFGU5J (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:57:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62691BE4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDAA61E86
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC07C433D2;
        Wed,  7 Jun 2023 20:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171426;
        bh=KOeXA22bMnHuqoAcnMaDevC121E48LyJ6l8G9Qs8GUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/mwh4TFu9Zx4Mf7WDuLTJ+1RD5luj3XGrphlQI1+OQFKDimAcK3idQzHX5CnVwMY
         /RKwEWgLImbjxX764WGchpzMQbCn1ekJWBLi/2M6EBY5oTU0fZM8KEi/GCblAaTguS
         SBQCPF9z91LNe2LnwPXp2e0s8P/oKb7usTaT2Ky0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 003/159] RDMA/hns: Fix base address table allocation
Date:   Wed,  7 Jun 2023 22:15:06 +0200
Message-ID: <20230607200903.783226615@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
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

[ Upstream commit 7f3969b14f356dd65fa95b3528eb05c32e68bc06 ]

For hns, the specification of an entry like resource (E.g. WQE/CQE/EQE)
depends on BT page size, buf page size and hopnum. For user mode, the buf
page size depends on UMEM. Therefore, the actual specification is
controlled by BT page size and hopnum.

The current BT page size and hopnum are obtained from firmware. This makes
the driver inflexible and introduces unnecessary constraints.  Resource
allocation failures occur in many scenarios.

This patch will calculate whether the BT page size set by firmware is
sufficient before allocating BT, and increase the BT page size if it is
insufficient.

Fixes: 1133401412a9 ("RDMA/hns: Optimize base address table config flow for qp buffer")
Link: https://lore.kernel.org/r/20230512092245.344442-3-huangjunxian6@hisilicon.com
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index a593c142cd6ba..12c482f4a1c48 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 #include <rdma/ib_umem.h>
+#include <linux/math.h>
 #include "hns_roce_device.h"
 #include "hns_roce_cmd.h"
 #include "hns_roce_hem.h"
@@ -938,6 +939,44 @@ static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
 	return page_cnt;
 }
 
+static u64 cal_pages_per_l1ba(unsigned int ba_per_bt, unsigned int hopnum)
+{
+	return int_pow(ba_per_bt, hopnum - 1);
+}
+
+static unsigned int cal_best_bt_pg_sz(struct hns_roce_dev *hr_dev,
+				      struct hns_roce_mtr *mtr,
+				      unsigned int pg_shift)
+{
+	unsigned long cap = hr_dev->caps.page_size_cap;
+	struct hns_roce_buf_region *re;
+	unsigned int pgs_per_l1ba;
+	unsigned int ba_per_bt;
+	unsigned int ba_num;
+	int i;
+
+	for_each_set_bit_from(pg_shift, &cap, sizeof(cap) * BITS_PER_BYTE) {
+		if (!(BIT(pg_shift) & cap))
+			continue;
+
+		ba_per_bt = BIT(pg_shift) / BA_BYTE_LEN;
+		ba_num = 0;
+		for (i = 0; i < mtr->hem_cfg.region_count; i++) {
+			re = &mtr->hem_cfg.region[i];
+			if (re->hopnum == 0)
+				continue;
+
+			pgs_per_l1ba = cal_pages_per_l1ba(ba_per_bt, re->hopnum);
+			ba_num += DIV_ROUND_UP(re->count, pgs_per_l1ba);
+		}
+
+		if (ba_num <= ba_per_bt)
+			return pg_shift;
+	}
+
+	return 0;
+}
+
 static int mtr_alloc_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			 unsigned int ba_page_shift)
 {
@@ -946,6 +985,10 @@ static int mtr_alloc_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 
 	hns_roce_hem_list_init(&mtr->hem_list);
 	if (!cfg->is_direct) {
+		ba_page_shift = cal_best_bt_pg_sz(hr_dev, mtr, ba_page_shift);
+		if (!ba_page_shift)
+			return -ERANGE;
+
 		ret = hns_roce_hem_list_request(hr_dev, &mtr->hem_list,
 						cfg->region, cfg->region_count,
 						ba_page_shift);
-- 
2.39.2



