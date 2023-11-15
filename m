Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8722B7ECB70
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjKOTWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjKOTWT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C571BE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF9CC433C9;
        Wed, 15 Nov 2023 19:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076131;
        bh=dxzohK9rl0MfCfjUYEUkPOxPPlo6ohtz0SRcTHp28Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZduuqld6OLZVkOG04AdwLIdNagiVDPmAQqN6zT+i57jS8JB89R+JDw1MhuqG7RYA
         o+gMWQtZYMUsZIXW+nzZ+g3qeSfhijEoBhzJ2N2cDMDZIoR6jHgFwPlKMShBYNO+jM
         JFMFDxm24V0Q947T6KXooUiGw5/MjWePIVs9yC5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Evelyn Tsai <evelyn.tsai@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 094/550] wifi: mt76: get rid of false alamrs of tx emission issues
Date:   Wed, 15 Nov 2023 14:11:18 -0500
Message-ID: <20231115191607.234103735@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit 413f05d68d11981f5984b49214d3a5a0d88079b1 ]

When the set_chan_info command is set with CH_SWITCH_NORMAL reason,
even if the action is UNI_CHANNEL_RX_PATH, it'll still generate some
unexpected tones, which might confuse DFS CAC tests that there are some
tone leakages. To get rid of these kinds of false alarms, always bypass
DPD calibration when IEEE80211_CONF_IDLE is set.

Reviewed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: c685034cabc5 ("wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 411157e93865b..fa0f938f03a32 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2702,10 +2702,10 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	if (mt76_connac_spe_idx(phy->mt76->antenna_mask))
 		req.tx_path_num = fls(phy->mt76->antenna_mask);
 
-	if (cmd == MCU_EXT_CMD(SET_RX_PATH) ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 60cc3fdca9463..c4492803ec16e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2873,10 +2873,10 @@ int mt7996_mcu_set_chan_info(struct mt7996_phy *phy, u16 tag)
 		.channel_band = ch_band[chandef->chan->band],
 	};
 
-	if (tag == UNI_CHANNEL_RX_PATH ||
-	    dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
+	if (dev->mt76.hw->conf.flags & IEEE80211_CONF_MONITOR)
 		req.switch_reason = CH_SWITCH_NORMAL;
-	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+	else if (phy->mt76->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL ||
+		 phy->mt76->hw->conf.flags & IEEE80211_CONF_IDLE)
 		req.switch_reason = CH_SWITCH_SCAN_BYPASS_DPD;
 	else if (!cfg80211_reg_can_beacon(phy->mt76->hw->wiphy, chandef,
 					  NL80211_IFTYPE_AP))
-- 
2.42.0



