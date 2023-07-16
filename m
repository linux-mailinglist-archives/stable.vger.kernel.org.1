Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4C755200
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGPUCj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGPUCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88046FD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD3960EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A51C433C8;
        Sun, 16 Jul 2023 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537756;
        bh=T7QuHIQQWefRsr/dZ7kQb+KcdXHGLck2qkZhhNoJOtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RP8PKAsRMurlqS0tNGa9RctBH74tzsGwHjvM1XLVexOkut7bnYg4jcrUUOkS+uU/F
         4BkDgfMgTSxzn3I8SQB1aBAt1JX0TepMOwkBmZRhTcNkWt7hoDpUeMALidy9uiZAFL
         fRlYU6I76tJ3b/mENYSTh0oSrps5QHXLohSXKTJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 180/800] wifi: cfg80211: fix regulatory disconnect with OCB/NAN
Date:   Sun, 16 Jul 2023 21:40:33 +0200
Message-ID: <20230716194953.284867596@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 26f11e4746c05..c8a1b925413b3 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2391,9 +2391,17 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
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
 
@@ -2452,9 +2460,7 @@ static void reg_check_chans_work(struct work_struct *work)
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



