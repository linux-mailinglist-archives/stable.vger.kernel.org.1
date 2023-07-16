Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DEF7554F2
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGPUfk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjGPUfj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA99BE45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6706A60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F6C433C9;
        Sun, 16 Jul 2023 20:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539736;
        bh=EPWRXqSDPv9b75ybHKIRxjmotL1GG7f8C8IQhOtXUoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5nyiKr2/3WMoee7emrtkb7g6QD1kiOWXgEczrT3CPrZbBFQh4cg8z359DcI9fa5P
         5bSEfudcEmZKo52tDhjopCjVZ+38aWq5MI0PHN0MfMamo/4Dm8SRs0tT9XChRc5EKn
         6vBgnXIin67k/wT7mr0qK7X1vlCzUTxr6GyigGRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/591] wifi: cfg80211: fix regulatory disconnect with OCB/NAN
Date:   Sun, 16 Jul 2023 21:44:13 +0200
Message-ID: <20230716194926.828312608@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit e8c2af660ba0790afd14d5cbc2fd05c6dc85e207 ]

Since regulatory disconnect was added, OCB and NAN interface
types were added, which made it completely unusable for any
driver that allowed OCB/NAN. Add OCB/NAN (though NAN doesn't
do anything, we don't have any info) and also remove all the
logic that opts out, so it won't be broken again if/when new
interface types are added.

Fixes: 6e0bd6c35b02 ("cfg80211: 802.11p OCB mode handling")
Fixes: cb3b7d87652a ("cfg80211: add start / stop NAN commands")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20230616222844.2794d1625a26.I8e78a3789a29e6149447b3139df724a6f1b46fc3@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/regulatory.h | 13 +------------
 net/wireless/core.c      | 16 ----------------
 net/wireless/reg.c       | 14 ++++++++++----
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 896191f420d50..b2cb4a9eb04dc 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -140,17 +140,6 @@ struct regulatory_request {
  *      otherwise initiating radiation is not allowed. This will enable the
  *      relaxations enabled under the CFG80211_REG_RELAX_NO_IR configuration
  *      option
- * @REGULATORY_IGNORE_STALE_KICKOFF: the regulatory core will _not_ make sure
- *	all interfaces on this wiphy reside on allowed channels. If this flag
- *	is not set, upon a regdomain change, the interfaces are given a grace
- *	period (currently 60 seconds) to disconnect or move to an allowed
- *	channel. Interfaces on forbidden channels are forcibly disconnected.
- *	Currently these types of interfaces are supported for enforcement:
- *	NL80211_IFTYPE_ADHOC, NL80211_IFTYPE_STATION, NL80211_IFTYPE_AP,
- *	NL80211_IFTYPE_AP_VLAN, NL80211_IFTYPE_MONITOR,
- *	NL80211_IFTYPE_P2P_CLIENT, NL80211_IFTYPE_P2P_GO,
- *	NL80211_IFTYPE_P2P_DEVICE. The flag will be set by default if a device
- *	includes any modes unsupported for enforcement checking.
  * @REGULATORY_WIPHY_SELF_MANAGED: for devices that employ wiphy-specific
  *	regdom management. These devices will ignore all regdom changes not
  *	originating from their own wiphy.
@@ -177,7 +166,7 @@ enum ieee80211_regulatory_flags {
 	REGULATORY_COUNTRY_IE_FOLLOW_POWER	= BIT(3),
 	REGULATORY_COUNTRY_IE_IGNORE		= BIT(4),
 	REGULATORY_ENABLE_RELAX_NO_IR           = BIT(5),
-	REGULATORY_IGNORE_STALE_KICKOFF         = BIT(6),
+	/* reuse bit 6 next time */
 	REGULATORY_WIPHY_SELF_MANAGED		= BIT(7),
 };
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index b3ec9eaec36b3..609b79fe4a748 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -721,22 +721,6 @@ int wiphy_register(struct wiphy *wiphy)
 			return -EINVAL;
 	}
 
-	/*
-	 * if a wiphy has unsupported modes for regulatory channel enforcement,
-	 * opt-out of enforcement checking
-	 */
-	if (wiphy->interface_modes & ~(BIT(NL80211_IFTYPE_STATION) |
-				       BIT(NL80211_IFTYPE_P2P_CLIENT) |
-				       BIT(NL80211_IFTYPE_AP) |
-				       BIT(NL80211_IFTYPE_MESH_POINT) |
-				       BIT(NL80211_IFTYPE_P2P_GO) |
-				       BIT(NL80211_IFTYPE_ADHOC) |
-				       BIT(NL80211_IFTYPE_P2P_DEVICE) |
-				       BIT(NL80211_IFTYPE_NAN) |
-				       BIT(NL80211_IFTYPE_AP_VLAN) |
-				       BIT(NL80211_IFTYPE_MONITOR)))
-		wiphy->regulatory_flags |= REGULATORY_IGNORE_STALE_KICKOFF;
-
 	if (WARN_ON((wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) &&
 		    (wiphy->regulatory_flags &
 					(REGULATORY_CUSTOM_REG |
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 522180919a1a3..3b44fa59dbbab 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2429,9 +2429,17 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		case NL80211_IFTYPE_P2P_DEVICE:
 			/* no enforcement required */
 			break;
+		case NL80211_IFTYPE_OCB:
+			if (!wdev->u.ocb.chandef.chan)
+				continue;
+			chandef = wdev->u.ocb.chandef;
+			break;
+		case NL80211_IFTYPE_NAN:
+			/* we have no info, but NAN is also pretty universal */
+			continue;
 		default:
 			/* others not implemented for now */
-			WARN_ON(1);
+			WARN_ON_ONCE(1);
 			break;
 		}
 
@@ -2490,9 +2498,7 @@ static void reg_check_chans_work(struct work_struct *work)
 	rtnl_lock();
 
 	list_for_each_entry(rdev, &cfg80211_rdev_list, list)
-		if (!(rdev->wiphy.regulatory_flags &
-		      REGULATORY_IGNORE_STALE_KICKOFF))
-			reg_leave_invalid_chans(&rdev->wiphy);
+		reg_leave_invalid_chans(&rdev->wiphy);
 
 	rtnl_unlock();
 }
-- 
2.39.2



