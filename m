Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5670C967
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjEVTrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjEVTro (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B44D99
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC6262AB4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E23C433EF;
        Mon, 22 May 2023 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784863;
        bh=7sG3qalha1xhNGipSnhZPjI9JikH2aXgQbyJG0AhEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLfOlbQzswjmAvmqfwAY9zRAgySQyV0NLH+x+C6/nME+2C2yal8QsgYrdn9zZGClB
         Sc3qxDZe73rqSiln+CBTCk9Hyjjb3ws7hkW7k1vRX7QSOWwZl3n5lBvmxU6p0vVRQB
         pNoCYYBmbMY/O4GfwlZ1iFGbdWP1jMpSuW3zVSm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 227/364] wifi: mt76: connac: fix stats->tx_bytes calculation
Date:   Mon, 22 May 2023 20:08:52 +0100
Message-Id: <20230522190418.376429735@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit c7ab7a29ef5c0779574120d922256ce4651555d3 ]

The stats->tx_bytes shall subtract retry byte from tx byte.

Fixes: 43eaa3689507 ("wifi: mt76: add PPDU based TxS support for WED device")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/b3cd45596943cf5a06b2e08e2fe732ab0b51311b.1682285873.git.ryder.lee@mediatek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index f33171bcd3432..c3b692eac6f65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -163,7 +163,7 @@ enum {
 #define MT_TXS5_MPDU_TX_CNT		GENMASK(31, 23)
 
 #define MT_TXS6_MPDU_FAIL_CNT		GENMASK(31, 23)
-
+#define MT_TXS7_MPDU_RETRY_BYTE		GENMASK(22, 0)
 #define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 23)
 
 /* RXD DW1 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 82aac0a04655f..e57eade24ae56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -576,7 +576,8 @@ bool mt76_connac2_mac_fill_txs(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	/* PPDU based reporting */
 	if (FIELD_GET(MT_TXS0_TXS_FORMAT, txs) > 1) {
 		stats->tx_bytes +=
-			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE);
+			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_BYTE) -
+			le32_get_bits(txs_data[7], MT_TXS7_MPDU_RETRY_BYTE);
 		stats->tx_packets +=
 			le32_get_bits(txs_data[5], MT_TXS5_MPDU_TX_CNT);
 		stats->tx_failed +=
-- 
2.39.2



