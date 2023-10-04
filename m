Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF37B8847
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbjJDSOg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjJDSOg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD39E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6479CC433C7;
        Wed,  4 Oct 2023 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443272;
        bh=cluHQzLWox9Ye5QXUiZ4MAxIWBpPuO/FVa2KRwDZYJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwbUdUXTRsHerVwu5Utl8oRThmP+pQE6TtgL5jxiCqgpP+3g27CmoH9l24xt+ydlz
         pHlCnZhsgFXZLfDR+aG97Hl5U9REfMiAL59cJ7dVxnWCyLWQp9pBruPiL/ad8Ff85A
         SqpgWmExicO3BT5YFdmfvD5Ft4kwbS8Qhe13XVHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jie Wang <wangjie125@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/259] net: hns3: add cmdq check for vf periodic service task
Date:   Wed,  4 Oct 2023 19:54:02 +0200
Message-ID: <20231004175220.569034043@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit bd3caddf299a640efb66c6022efed7fe744db626 ]

When the vf cmdq is disabled, there is no need to keep these task running.
So this patch skip these task when the cmdq is disabled.

Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b1b14850e958f..72cf5145e15a2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1909,7 +1909,8 @@ static void hclgevf_periodic_service_task(struct hclgevf_dev *hdev)
 	unsigned long delta = round_jiffies_relative(HZ);
 	struct hnae3_handle *handle = &hdev->nic;
 
-	if (test_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state))
+	if (test_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state) ||
+	    test_bit(HCLGE_COMM_STATE_CMD_DISABLE, &hdev->hw.hw.comm_state))
 		return;
 
 	if (time_is_after_jiffies(hdev->last_serv_processed + HZ)) {
-- 
2.40.1



