Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EB79B190
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376549AbjIKWT4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbjIKOPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:15:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C70DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:15:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AA0C433C8;
        Mon, 11 Sep 2023 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441725;
        bh=hAvH60x8nTtIkWJ784yfG4sOZCPJAplmrFQzQQtwHJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dy4MUD4LMzUrvWWN2r9yxAobfjHLyCJ02YkJUSm+AkZH7dD5fp6nJUy4Nd5URv2x9
         pTFpEToieGvZIbYa44tSktccS6sEV3DlWH2A4OiLnHQx40LWudlZ96QuhkCj9j9ibj
         5Ydsx1zOiMgmR2WhwIrIcvZMKG/zB13vdxNJFONQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 514/739] RDMA/hns: Fix port active speed
Date:   Mon, 11 Sep 2023 15:45:13 +0200
Message-ID: <20230911134705.478047366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit df1bcf90a66a10967a3a43510b42cb3566208011 ]

HW supports a variety of different speed, but the current speed
is fixed.

The real speed should be querried from ethernet.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20230804012711.808069-2-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 485e110ca4333..9141eadf33d2a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -219,6 +219,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 	unsigned long flags;
 	enum ib_mtu mtu;
 	u32 port;
+	int ret;
 
 	port = port_num - 1;
 
@@ -231,8 +232,10 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 				IB_PORT_BOOT_MGMT_SUP;
 	props->max_msg_sz = HNS_ROCE_MAX_MSG_LEN;
 	props->pkey_tbl_len = 1;
-	props->active_width = IB_WIDTH_4X;
-	props->active_speed = 1;
+	ret = ib_get_eth_speed(ib_dev, port_num, &props->active_speed,
+			       &props->active_width);
+	if (ret)
+		ibdev_warn(ib_dev, "failed to get speed, ret = %d.\n", ret);
 
 	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
 
-- 
2.40.1



