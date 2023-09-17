Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154167A3B81
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjIQUSm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjIQUSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:18:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8DF4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:18:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8BAC433C8;
        Sun, 17 Sep 2023 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981892;
        bh=o/ZVIrgLUUr7lIW8utgRGf3xcye5To6rGi2uHe/P8Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXaSXCj645Hl0QK3Qie1Fft1bwRX/V/zttOFBDYbYtSaDJ1tTUQkEzmtm/UYMrMbZ
         owCWt7HZ/bWICpSRHZjfTKKBdnvD4iI8KsTzGIFln8+8jeFyYHzOkw6X55fZr7VFe0
         HXhahd40lcELvTDoEoBX5m2mi9Sdk9SFxNq90SgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chad Monroe <chad.monroe@smartrg.com>,
        Allen Ye <allen.ye@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/511] wifi: mt76: mt7915: fix power-limits while chan_switch
Date:   Sun, 17 Sep 2023 21:08:38 +0200
Message-ID: <20230917191116.068011249@linuxfoundation.org>
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

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 6c0570bc21ec2073890aa252c8420ca7bec402e4 ]

If user changes the channel without completely disabling the interface the
txpower_sku values reported track the old channel the device was operating on.
If user bounces the interface the correct power tables are applied.

mt7915_sku_group_len array gets updated before the channel switch happens so it
uses data from the old channel.

Fixes: ecb187a74e18 ("mt76: mt7915: rework the flow of txpower setting")
Fixes: f1d962369d56 ("mt76: mt7915: implement HE per-rate tx power support")
Reported-By: Chad Monroe <chad.monroe@smartrg.com>
Tested-by: Chad Monroe <chad.monroe@smartrg.com>
Signed-off-by: Allen Ye <allen.ye@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7a4f277a16223..09ea97a81fb4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -441,7 +441,8 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+	if (changed & (IEEE80211_CONF_CHANGE_POWER |
+		       IEEE80211_CONF_CHANGE_CHANNEL)) {
 		ret = mt7915_mcu_set_txpower_sku(phy);
 		if (ret)
 			return ret;
-- 
2.40.1



