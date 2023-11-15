Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95D7ECD52
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKOTft (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjKOTfs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E0F130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A217C433C7;
        Wed, 15 Nov 2023 19:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076945;
        bh=6jYHnS2kp8Oa1oT5B/PKX4BUJA95FTkryg7t/cIMSDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxF2SVUHQAxYBncJkmPaP1qRerwB4bpDRbRyyINzQZwIOPBRdNlMyzHBJKmUB63P1
         9QO1s0YdV28wSZ8AtE8zeZyJFcxJzwmGPK0tUuiHACFn9RY+0uSuXjjvt4T0RIPMhc
         AhuATzZ+FM4D2xLbAOIkkNH6TVfaKTN0eOamFKAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/603] wifi: mac80211: fix check for unusable RX result
Date:   Wed, 15 Nov 2023 14:10:21 -0500
Message-ID: <20231115191618.363677733@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 583058542f46e3e2b0c536316fbd641f62d91dc6 ]

If we just check "result & RX_DROP_UNUSABLE", this really only works
by accident, because SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE got to
have the value 1, and SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR is 2.

Fix this to really check the entire subsys mask for the value, so it
doesn't matter what the subsystem value is.

Fixes: 7f4e09700bdc ("wifi: mac80211: report all unusable beacon frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/drop.h | 3 +++
 net/mac80211/rx.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/drop.h b/net/mac80211/drop.h
index 49dc809cab290..1570fac8411f4 100644
--- a/net/mac80211/drop.h
+++ b/net/mac80211/drop.h
@@ -53,4 +53,7 @@ enum mac80211_drop_reason {
 #undef DEF
 };
 
+#define RX_RES_IS_UNUSABLE(result)	\
+	(((__force u32)(result) & SKB_DROP_REASON_SUBSYS_MASK) == ___RX_DROP_UNUSABLE)
+
 #endif /* MAC80211_DROP_H */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8f6b6f56b65b4..26ca2f5dc52b2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2112,7 +2112,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	/* either the frame has been decrypted or will be dropped */
 	status->flag |= RX_FLAG_DECRYPTED;
 
-	if (unlikely(ieee80211_is_beacon(fc) && (result & RX_DROP_UNUSABLE) &&
+	if (unlikely(ieee80211_is_beacon(fc) && RX_RES_IS_UNUSABLE(result) &&
 		     rx->sdata->dev))
 		cfg80211_rx_unprot_mlme_mgmt(rx->sdata->dev,
 					     skb->data, skb->len);
-- 
2.42.0



