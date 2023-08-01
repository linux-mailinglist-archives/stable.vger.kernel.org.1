Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D676AE29
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjHAJgf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjHAJgG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4030CD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D952614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7D8C433C8;
        Tue,  1 Aug 2023 09:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882466;
        bh=C6S3t9K1J8+mYPfxizhKkb9eFRUqcE+P5hs9d9gOoF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLUYu8LuswrCHIE/IZnABWtWeFhC0szacDQSxu3K/rtD4OlTtc+ulmyTirDH9LvT1
         jstZ4B2wdmc/VuRWKufKf/FwdZumcexVvSpY1SwJcaWqfcGf/rK4KU3DrN6uI5lWqQ
         B0X+fqV0dqcDaTk1VchXUTTvsy13d0aDenjnSecE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jie Wang <wangjie125@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/228] net: hns3: fix wrong bw weight of disabled tc issue
Date:   Tue,  1 Aug 2023 11:19:05 +0200
Message-ID: <20230801091926.004801872@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 882481b1c55fc44861d7e2d54b4e0936b1b39f2c ]

In dwrr mode, the default bandwidth weight of disabled tc is set to 0.
If the bandwidth weight is 0, the mode will change to sp.
Therefore, disabled tc default bandwidth weight need changed to 1,
and 0 is returned when query the bandwidth weight of disabled tc.
In addition, driver need stop configure bandwidth weight if tc is disabled.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 17 ++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   |  3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index c4aded65e848b..09362823140d5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -52,7 +52,10 @@ static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		ets->prio_tc[i] = hdev->tm_info.prio_tc[i];
-		ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		if (i < hdev->tm_info.num_tc)
+			ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		else
+			ets->tc_tx_bw[i] = 0;
 
 		if (hdev->tm_info.tc_info[i].tc_sch_mode ==
 		    HCLGE_SCH_MODE_SP)
@@ -123,7 +126,8 @@ static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
 }
 
 static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
-				       struct ieee_ets *ets, bool *changed)
+				       struct ieee_ets *ets, bool *changed,
+				       u8 tc_num)
 {
 	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
@@ -137,6 +141,13 @@ static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
 				*changed = true;
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
+			if (i >= tc_num) {
+				dev_err(&hdev->pdev->dev,
+					"tc%u is disabled, cannot set ets bw\n",
+					i);
+				return -EINVAL;
+			}
+
 			/* The hardware will switch to sp mode if bandwidth is
 			 * 0, so limit ets bandwidth must be greater than 0.
 			 */
@@ -176,7 +187,7 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (ret)
 		return ret;
 
-	ret = hclge_ets_sch_mode_validate(hdev, ets, changed);
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed, tc_num);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 922c0da3660c7..150f146fa24fb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -785,6 +785,7 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 {
 #define BW_PERCENT	100
+#define DEFAULT_BW_WEIGHT	1
 
 	u8 i;
 
@@ -806,7 +807,7 @@ static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 		for (k = 0; k < hdev->tm_info.num_tc; k++)
 			hdev->tm_info.pg_info[i].tc_dwrr[k] = BW_PERCENT;
 		for (; k < HNAE3_MAX_TC; k++)
-			hdev->tm_info.pg_info[i].tc_dwrr[k] = 0;
+			hdev->tm_info.pg_info[i].tc_dwrr[k] = DEFAULT_BW_WEIGHT;
 	}
 }
 
-- 
2.39.2



