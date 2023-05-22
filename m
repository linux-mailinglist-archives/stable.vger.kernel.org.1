Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB770C7C8
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbjEVTcc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjEVTcW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:32:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F513E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3A26292E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7188DC4339B;
        Mon, 22 May 2023 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783932;
        bh=d0qDdDGbiLrFmJua8/hH1F3y4GKnKStL7u34TP8zoO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBIHrDM/TQLEelHc4SaD+WYI8x8uj29Cc65NBNLqI+jybrCD2xrZyP6HtIpkuNTjm
         QGUGuFOUqOwM9ecifBgJO7ZvuWN+dBehy10YAcIIAdvXjrSOTCzbYJEGn7QsdmY9Gq
         C5k1kkazZRCJgspMEpAR65gF1T6I3j99vji2LLS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jijie Shao <shaojijie@huawei.com>,
        Hao Lan <lanhao@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 182/292] net: hns3: fix sending pfc frames after reset issue
Date:   Mon, 22 May 2023 20:08:59 +0100
Message-Id: <20230522190410.512687239@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit f14db07064727dd3bc0906c77a6d2759c1bbb395 ]

To prevent the system from abnormally sending PFC frames after an
abnormal reset. The hns3 driver notifies the firmware to disable pfc
before reset.

Fixes: 35d93a30040c ("net: hns3: adjust the process of PF reset")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |  4 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  5 +++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 07ad5f35219e2..50e956d6c3b25 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -8053,12 +8053,15 @@ static void hclge_ae_stop(struct hnae3_handle *handle)
 	/* If it is not PF reset or FLR, the firmware will disable the MAC,
 	 * so it only need to stop phy here.
 	 */
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) &&
-	    hdev->reset_type != HNAE3_FUNC_RESET &&
-	    hdev->reset_type != HNAE3_FLR_RESET) {
-		hclge_mac_stop_phy(hdev);
-		hclge_update_link_status(hdev);
-		return;
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
+		hclge_pfc_pause_en_cfg(hdev, HCLGE_PFC_TX_RX_DISABLE,
+				       HCLGE_PFC_DISABLE);
+		if (hdev->reset_type != HNAE3_FUNC_RESET &&
+		    hdev->reset_type != HNAE3_FLR_RESET) {
+			hclge_mac_stop_phy(hdev);
+			hclge_update_link_status(hdev);
+			return;
+		}
 	}
 
 	hclge_reset_tqp(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 4a33f65190e2b..922c0da3660c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -171,8 +171,8 @@ int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx)
 	return hclge_cmd_send(&hdev->hw, &desc, 1);
 }
 
-static int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
-				  u8 pfc_bitmap)
+int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
+			   u8 pfc_bitmap)
 {
 	struct hclge_desc desc;
 	struct hclge_pfc_en_cmd *pfc = (struct hclge_pfc_en_cmd *)desc.data;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 68f28a98e380b..dd6f1fd486cf2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -164,6 +164,9 @@ struct hclge_bp_to_qs_map_cmd {
 	u32 rsvd1;
 };
 
+#define HCLGE_PFC_DISABLE	0
+#define HCLGE_PFC_TX_RX_DISABLE	0
+
 struct hclge_pfc_en_cmd {
 	u8 tx_rx_en_bitmap;
 	u8 pri_en_bitmap;
@@ -235,6 +238,8 @@ void hclge_tm_schd_info_update(struct hclge_dev *hdev, u8 num_tc);
 void hclge_tm_pfc_info_update(struct hclge_dev *hdev);
 int hclge_tm_dwrr_cfg(struct hclge_dev *hdev);
 int hclge_tm_init_hw(struct hclge_dev *hdev, bool init);
+int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
+			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
-- 
2.39.2



