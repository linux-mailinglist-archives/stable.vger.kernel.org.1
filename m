Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF97DD53D
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376512AbjJaRsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbjJaRs3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01E123
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E5FC433CA;
        Tue, 31 Oct 2023 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774504;
        bh=GMZYQ7y+RxYZJnZcv28QOo9jsdHX23yMdlF8e19ozHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbewEmYfEr7Rurd3sIC7/6RjCfIr6G2QcIkSIGeWxNZIm0cSMOBIGBccJimxwctNt
         1CU9oNswR6ozsBMaizlUaciiMuf31/cFt9teYeN3xF1dnD4ZEQAbo4B7tJjiwT1d3Q
         ft76ZgrujQnaeukh3H5a5zJ590Qwa5rpPViNtgYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 069/112] wifi: mac80211: dont drop all unprotected public action frames
Date:   Tue, 31 Oct 2023 18:01:10 +0100
Message-ID: <20231031165903.493949756@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 91535613b6090fc968c601d11d4e2f16b333713c ]

Not all public action frames have a protected variant. When MFP is
enabled drop only public action frames that have a dual protected
variant.

Fixes: 76a3059cf124 ("wifi: mac80211: drop some unprotected action frames")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231016145213.2973e3c8d3bb.I6198b8d3b04cf4a97b06660d346caec3032f232a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 29 +++++++++++++++++++++++++++++
 net/mac80211/rx.c         |  3 +--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 4b998090898e3..1d7aea6342171 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4236,6 +4236,35 @@ static inline bool ieee80211_is_public_action(struct ieee80211_hdr *hdr,
 	return mgmt->u.action.category == WLAN_CATEGORY_PUBLIC;
 }
 
+/**
+ * ieee80211_is_protected_dual_of_public_action - check if skb contains a
+ * protected dual of public action management frame
+ * @skb: the skb containing the frame, length will be checked
+ *
+ * Return: true if the skb contains a protected dual of public action
+ * management frame, false otherwise.
+ */
+static inline bool
+ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
+{
+	u8 action;
+
+	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
+	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
+		return false;
+
+	action = *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
+
+	return action != WLAN_PUB_ACTION_20_40_BSS_COEX &&
+		action != WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
+		action != WLAN_PUB_ACTION_MSMT_PILOT &&
+		action != WLAN_PUB_ACTION_TDLS_DISCOVER_RES &&
+		action != WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
+		action != WLAN_PUB_ACTION_FTM_REQUEST &&
+		action != WLAN_PUB_ACTION_FTM_RESPONSE &&
+		action != WLAN_PUB_ACTION_FILS_DISCOVERY;
+}
+
 /**
  * _ieee80211_is_group_privacy_action - check if frame is a group addressed
  * privacy action frame
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e751cda5eef69..8f6b6f56b65b4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2468,8 +2468,7 @@ static int ieee80211_drop_unencrypted_mgmt(struct ieee80211_rx_data *rx)
 
 		/* drop unicast public action frames when using MPF */
 		if (is_unicast_ether_addr(mgmt->da) &&
-		    ieee80211_is_public_action((void *)rx->skb->data,
-					       rx->skb->len))
+		    ieee80211_is_protected_dual_of_public_action(rx->skb))
 			return -EACCES;
 	}
 
-- 
2.42.0



