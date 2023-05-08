Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532936FA544
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjEHKHg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjEHKHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E131B29
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219126236E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3789DC4339B;
        Mon,  8 May 2023 10:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540453;
        bh=nd+7R1HnPhDhNn21mSKN+YCnOS7hvvaXL+Z+wWcHlEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAk+qyJW8WEujtF/7ygvEQ11jwAOdc6nLpnwlxb6Zle45LIprQarA7iFgtpVOCHhg
         GpuEuYkzViX4R4/UCNZixGYNVVFkzayVH1Ssl3ao0eNOthgo7BPL4pMQiZBZEwKAfM
         v0hJyLNI6pgXmkOrQ5gFx8VvnP109cb1IzZExnpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 370/611] wifi: mt76: connac: fix txd multicast rate setting
Date:   Mon,  8 May 2023 11:43:32 +0200
Message-Id: <20230508094434.389003930@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 3d2892e05086d09aecf14ea64b2debbf495e313c ]

The vif->bss_conf.mcast_rate should be applied to multicast data frame
only.

Fixes: 182071cdd594 ("mt76: connac: move connac2_mac_write_txwi in mt76_connac module")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 46ede1b72bbee..19f02b632a204 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -539,7 +539,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
 		/* Fixed rata is available just for 802.11 txd */
 		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-		bool multicast = is_multicast_ether_addr(hdr->addr1);
+		bool multicast = ieee80211_is_data(hdr->frame_control) &&
+				 is_multicast_ether_addr(hdr->addr1);
 		u16 rate = mt76_connac2_mac_tx_rate_val(mphy, vif, beacon,
 							multicast);
 		u32 val = MT_TXD6_FIXED_BW;
-- 
2.39.2



