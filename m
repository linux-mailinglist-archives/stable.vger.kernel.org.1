Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A127A3D36
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjIQUkD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjIQUjl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A1115
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:39:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E63C433C8;
        Sun, 17 Sep 2023 20:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983175;
        bh=RhH9SAjMcJOMLwFi9dAja4Y1YwTY1fJxpRqkO0MRHX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZrt9yjZ2nZd6pMoIg4pGOr982NWCS7z8GB0OvivhunghBhBK3U1NFBpnLp0IUpdv
         ITiIBHpq6X4tgmxzM4/dDF0jFWUmus5j0yiVp+OHesSYoNwGlLogStzX85T4imfn8E
         97GwfgjMLYG7n2OF7332KCOZFc7gn4vTA0R8jQZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 459/511] net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue
Date:   Sun, 17 Sep 2023 21:14:46 +0200
Message-ID: <20230917191124.837928507@linuxfoundation.org>
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

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit fa5564945f7d15ae2390b00c08b6abaef0165cda ]

We hope that tc qdisc and dcb ets commands can not be used crosswise.
If we want to use any of the commands to configure tc,
We must use the other command to clear the existing configuration.

However, when we configure a single tc with tc qdisc,
we can still configure it with dcb ets.
Because we use mqprio_active as the tag of tc qdisc configuration,
but with dcb ets, we do not check mqprio_active.

This patch fix this issue by check mqprio_active before
executing the dcb ets command. and add dcb_ets_active to
replace HCLGE_FLAG_DCB_ENABLE and HCLGE_FLAG_MQPRIO_ENABLE
at the hclge layer,

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 20 +++++--------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  5 +++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  2 --
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 9204f5ecd4151..695e299f534d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -757,6 +757,7 @@ struct hnae3_tc_info {
 	u16 tqp_offset[HNAE3_MAX_TC];
 	u8 num_tc; /* Total number of enabled TCs */
 	bool mqprio_active;
+	bool dcb_ets_active;
 };
 
 struct hnae3_knic_private_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 87640a2e1794b..a15f2ed268a8d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -251,7 +251,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	int ret;
 
 	if (!(hdev->dcbx_cap & DCB_CAP_DCBX_VER_IEEE) ||
-	    hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	    h->kinfo.tc_info.mqprio_active)
 		return -EINVAL;
 
 	ret = hclge_ets_validate(hdev, ets, &num_tc, &map_changed);
@@ -267,10 +267,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	}
 
 	hclge_tm_schd_info_update(hdev, num_tc);
-	if (num_tc > 1)
-		hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
+	h->kinfo.tc_info.dcb_ets_active = num_tc > 1;
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
@@ -376,7 +373,7 @@ static u8 hclge_getdcbx(struct hnae3_handle *h)
 	struct hclge_vport *vport = hclge_get_vport(h);
 	struct hclge_dev *hdev = vport->back;
 
-	if (hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	if (h->kinfo.tc_info.mqprio_active)
 		return 0;
 
 	return hdev->dcbx_cap;
@@ -500,7 +497,8 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (!test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state))
 		return -EBUSY;
 
-	if (hdev->flag & HCLGE_FLAG_DCB_ENABLE)
+	kinfo = &vport->nic.kinfo;
+	if (kinfo->tc_info.dcb_ets_active)
 		return -EINVAL;
 
 	ret = hclge_mqprio_qopt_check(hdev, mqprio_qopt);
@@ -514,7 +512,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		return ret;
 
-	kinfo = &vport->nic.kinfo;
 	memcpy(&old_tc_info, &kinfo->tc_info, sizeof(old_tc_info));
 	hclge_sync_mqprio_qopt(&kinfo->tc_info, mqprio_qopt);
 	kinfo->tc_info.mqprio_active = tc > 0;
@@ -523,13 +520,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		goto err_out;
 
-	hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
-
-	if (tc > 1)
-		hdev->flag |= HCLGE_FLAG_MQPRIO_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_MQPRIO_ENABLE;
-
 	return hclge_notify_init_up(hdev);
 
 err_out:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1d424b1ee6cd3..a415760505ab4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11187,6 +11187,7 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 
 static void hclge_info_show(struct hclge_dev *hdev)
 {
+	struct hnae3_handle *handle = &hdev->vport->nic;
 	struct device *dev = &hdev->pdev->dev;
 
 	dev_info(dev, "PF info begin:\n");
@@ -11203,9 +11204,9 @@ static void hclge_info_show(struct hclge_dev *hdev)
 	dev_info(dev, "This is %s PF\n",
 		 hdev->flag & HCLGE_FLAG_MAIN ? "main" : "not main");
 	dev_info(dev, "DCB %s\n",
-		 hdev->flag & HCLGE_FLAG_DCB_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.dcb_ets_active ? "enable" : "disable");
 	dev_info(dev, "MQPRIO %s\n",
-		 hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.mqprio_active ? "enable" : "disable");
 	dev_info(dev, "Default tx spare buffer size: %u\n",
 		 hdev->tx_spare_buf_size);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 4d6dbfe0be7a2..a716027df0ed1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -902,8 +902,6 @@ struct hclge_dev {
 
 #define HCLGE_FLAG_MAIN			BIT(0)
 #define HCLGE_FLAG_DCB_CAPABLE		BIT(1)
-#define HCLGE_FLAG_DCB_ENABLE		BIT(2)
-#define HCLGE_FLAG_MQPRIO_ENABLE	BIT(3)
 	u32 flag;
 
 	u32 pkt_buf_size; /* Total pf buf size for tx/rx */
-- 
2.40.1



