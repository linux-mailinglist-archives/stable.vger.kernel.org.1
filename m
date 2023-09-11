Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9618979BC70
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348545AbjIKV1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbjIKOa2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6177E4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF69C433CB;
        Mon, 11 Sep 2023 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442622;
        bh=uW6CodLHXziK1OJuopCdIWBEcfeG/0LQHYfUWzsifEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQCA/GNi8fWTfbXeau9mZb1NkeY9bZqIsVzYoxoHqa9oM3oeqco8JniFkdMYvaNnt
         oHyzggAjXdIZBPFcd3HLUbMUIhzQVwpr5R1PWUV9OTXi/TZaIkcubZMllsKcQYfU1N
         AMLSwhzCqRnUdWKDclJrNPJjktBFhvFLyOZtcPRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jian Shen <shenjian15@huawei.com>,
        Peiyang Wang <wangpeiyang1@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 062/737] net: hns3: restore user pause configure when disable autoneg
Date:   Mon, 11 Sep 2023 15:38:41 +0200
Message-ID: <20230911134652.233822304@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit 15159ec0c831b565820c2de05114ea1b4cf07681 ]

Restore the mac pause state to user configuration when autoneg is disabled

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230807113452.474224-2-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 ++++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h   | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c3e94598f3983..0876890798ba4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10936,9 +10936,12 @@ int hclge_cfg_flowctrl(struct hclge_dev *hdev)
 	u32 rx_pause, tx_pause;
 	u8 flowctl;
 
-	if (!phydev->link || !phydev->autoneg)
+	if (!phydev->link)
 		return 0;
 
+	if (!phydev->autoneg)
+		return hclge_mac_pause_setup_hw(hdev);
+
 	local_advertising = linkmode_adv_to_lcl_adv_t(phydev->advertising);
 
 	if (phydev->pause)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index de509e5751a7c..c58c312217628 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1553,7 +1553,7 @@ static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 	return 0;
 }
 
-static int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
 {
 	bool tx_en, rx_en;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 45dcfef3f90cc..53eec6df51946 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -245,6 +245,7 @@ int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
 			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
 void hclge_pfc_tx_stats_get(struct hclge_dev *hdev, u64 *stats);
 int hclge_tm_qs_shaper_cfg(struct hclge_vport *vport, int max_tx_rate);
-- 
2.40.1



