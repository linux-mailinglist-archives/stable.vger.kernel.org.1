Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F47ECD76
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjKOTgn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjKOTgl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E412C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C528C433C9;
        Wed, 15 Nov 2023 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076997;
        bh=AD0gUP+1uVYI5KNS3IOv5zVBr62vv8QFIh5uqhaO9cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiBGLL/N0pO3kEyuVgCHwcyjFAfVig8StdWn4UlPO3SnGrQU4eHgzBcqiyxBfxP8t
         gOTl3ERnwOGmn9RCDdlVQNf/VhJ1AJu6W3cGjuifBDTliX25BTdSiwsWJFxMtsq/Nn
         qJLR+AtIIFjGvabYQq0Gb/qE6FVxBaZqutzoZ3N4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, MeiChia Chiu <meichia.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 093/603] wifi: mt76: mt7915: fix beamforming availability check
Date:   Wed, 15 Nov 2023 14:10:38 -0500
Message-ID: <20231115191619.594790496@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: MeiChia Chiu <meichia.chiu@mediatek.com>

[ Upstream commit ced1a0b8f3944e44e7f4eb3772dea1bada25d38a ]

Without this patch, when ap sets the tx stream number to 2,
ap won't send any beamforming packet.

Fixes: f89f297aef28 ("mt76: mt7915: fix txbf starec TLV issues")
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 92a341aa58228..5d8e985cd7d45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1015,13 +1015,13 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
 {
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
-	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
+	int sts = hweight16(phy->mt76->chainmask);
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
 	    vif->type != NL80211_IFTYPE_AP)
 		return false;
 
-	if (!bfee && tx_ant < 2)
+	if (!bfee && sts < 2)
 		return false;
 
 	if (sta->deflink.he_cap.has_he) {
-- 
2.42.0



