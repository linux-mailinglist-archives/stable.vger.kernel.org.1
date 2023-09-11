Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D979B65F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353625AbjIKVry (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbjIKPWB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BFD3
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:21:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD91FC433C8;
        Mon, 11 Sep 2023 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445716;
        bh=ojVLxq0Dbrl6OeP7yrXqqvzPiyYcHj3YYNQ24I3FCUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poKCY/OqzLa7IO9eo5PzqFQnSTrv40u/xVgummCwFAD5uBTY3d4JbL0Op6gK1h4Ro
         hhZvulJ0lg1STsvJ7dnE9IkYshi6Ga5dlsnuIMg3YWC7SZj+kdflv9c3D/4oCrbnaZ
         jF6SL1uCV5e+oJXhGZLzT0sDqc9bOTrWO8BGNLHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 446/600] RDMA/hns: Fix inaccurate error label name in init instance
Date:   Mon, 11 Sep 2023 15:47:59 +0200
Message-ID: <20230911134646.810586332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit c9c0bd3c177d93d80968f720304087ba83fe8f74 ]

This patch fixes inaccurate error label name in init instance.

Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20230804012711.808069-4-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index e9a1985f7f17c..33980485ef5ba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6865,14 +6865,14 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 	ret = hns_roce_init(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev, "RoCE Engine init failed!\n");
-		goto error_failed_cfg;
+		goto error_failed_roce_init;
 	}
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
 		ret = free_mr_init(hr_dev);
 		if (ret) {
 			dev_err(hr_dev->dev, "failed to init free mr!\n");
-			goto error_failed_roce_init;
+			goto error_failed_free_mr_init;
 		}
 	}
 
@@ -6880,10 +6880,10 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 
 	return 0;
 
-error_failed_roce_init:
+error_failed_free_mr_init:
 	hns_roce_exit(hr_dev);
 
-error_failed_cfg:
+error_failed_roce_init:
 	kfree(hr_dev->priv);
 
 error_failed_kzalloc:
-- 
2.40.1



