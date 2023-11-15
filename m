Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC27ED0FC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjKOT6k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343960AbjKOT6i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239D19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC3CC433CA;
        Wed, 15 Nov 2023 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078314;
        bh=KFImAHLIefGUwpxZr+bqxoMcwkUNIO78FNeENTboe4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gupAUxAln1TuVJ7aU50WRQS4YZ5BOiMQJ/6FDqFR8WKJ2XoDRNm5JWhrQnfHvAZHE
         arGAN4BgULniMw7SOTeUwP6Sb15craz90QFyLewZj42lX5qJyNakIjtwOa8Tq/YSqi
         ZTnM05iv65IiNP8BqLsR4hccNiE+43q/eVmsB8Rg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luoyouming <luoyouming@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 222/379] RDMA/hns: The UD mode can only be configured with DCQCN
Date:   Wed, 15 Nov 2023 14:24:57 -0500
Message-ID: <20231115192658.256437998@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luoyouming <luoyouming@huawei.com>

[ Upstream commit 27c5fd271d8b8730fc0bb1b6cae953ad7808a874 ]

Due to hardware limitations, only DCQCN is supported for UD. Therefore, the
default algorithm for UD is set to DCQCN.

Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
Signed-off-by: Luoyouming <luoyouming@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20231017125239.164455-6-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 56da0a469882d..8a9d28f81149a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4883,6 +4883,9 @@ static int check_cong_type(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 
+	if (ibqp->qp_type == IB_QPT_UD)
+		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+
 	/* different congestion types match different configurations */
 	switch (hr_dev->caps.cong_type) {
 	case CONG_TYPE_DCQCN:
-- 
2.42.0



