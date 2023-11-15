Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D67ECB8F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjKOTXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjKOTXC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AFD19D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB63BC433C9;
        Wed, 15 Nov 2023 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076179;
        bh=1h+EUXxf1RGqBdWq/pkM5FMzd7Lr9jEfnw4lfn0dr0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zf5cfTT2h6PVyj/vLuG6gbbom0Ufr2e+a6ru5Fth80OVLxNtBWieqSgWjjM15x+we
         Ptymq6Kh9R29gxRO3TueOs05n0eCeGSbXpDTVe84pjO2Uht8MMi4LawNHImBuHzIeq
         QLoLCgw8RVHIjZ5xhxxcVU1WNX0j1r6aGYXr8rMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 125/550] wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK
Date:   Wed, 15 Nov 2023 14:11:49 -0500
Message-ID: <20231115191609.355551641@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 63ef576c9facf5d92702e249ad213fa73eb434bf ]

We don't (yet) send the IGTK down to the firmware, but when
we do it needs to be with the broadcast station ID, not the
multicast station ID. Same for the BIGTK, which we may send
already if firmware advertises it (but it doesn't yet.)

Fixes: a5de7de7e78e ("wifi: iwlwifi: mvm: enable TX beacon protection")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230926110319.dbc653913353.I82e90c86010f0b9588a180d9835fd11f666f5196@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 2c9f2f71b083a..f498206470410 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -24,10 +24,15 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 			return 0;
 	}
 
-	/* AP group keys are per link and should be on the mcast STA */
+	/* AP group keys are per link and should be on the mcast/bcast STA */
 	if (vif->type == NL80211_IFTYPE_AP &&
-	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
+		/* IGTK/BIGTK to bcast STA */
+		if (keyconf->keyidx >= 4)
+			return BIT(link_info->bcast_sta.sta_id);
+		/* GTK for data to mcast STA */
 		return BIT(link_info->mcast_sta.sta_id);
+	}
 
 	/* for client mode use the AP STA also for group keys */
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
-- 
2.42.0



