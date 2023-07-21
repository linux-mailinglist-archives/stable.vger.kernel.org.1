Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73075D252
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjGUS6Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGUS6U (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB51F30D4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696C361D8F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C28C433C8;
        Fri, 21 Jul 2023 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965898;
        bh=YBPEbkGjtXHN5VuWFP98yKGj0vsWjX0RZ0I1ElHJio4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzJX751OpLuddGhl/JHWX+u2IHBQaUEYXC8FBxND4JMFToilLSWoCQdS5Z1aULbLa
         dpK7OXyxkg5Ne8S6B8XX5OEnXLkDbjfVTNbU4FnP41wxBJ2g0qIvzKiq+Tjl80iKmp
         F3Orrma5kGS6tNs9p5RWmFSb4go6JAuAK3SLkoIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chengchang Tang <tangchengchang@huawei.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/532] RDMA/hns: Fix hns_roce_table_get return value
Date:   Fri, 21 Jul 2023 18:00:57 +0200
Message-ID: <20230721160622.728305008@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
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

[ Upstream commit cf5b608fb0e369c473a8303cad6ddb386505e5b8 ]

The return value of set_hem has been fixed to ENODEV, which will lead a
diagnostic information missing.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Link: https://lore.kernel.org/r/20230523121641.3132102-3-huangjunxian6@hisilicon.com
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index fa15d79eabb36..267474070f271 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -597,11 +597,12 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Set HEM base address(128K/page, pa) to Hardware */
-	if (hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT)) {
+	ret = hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT);
+	if (ret) {
 		hns_roce_free_hem(hr_dev, table->hem[i]);
 		table->hem[i] = NULL;
-		ret = -ENODEV;
-		dev_err(dev, "set HEM base address to HW failed.\n");
+		dev_err(dev, "set HEM base address to HW failed, ret = %d.\n",
+			ret);
 		goto out;
 	}
 
-- 
2.39.2



