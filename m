Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0D7352D2
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFSKig (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjFSKiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CECD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C2D60B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669D8C433C8;
        Mon, 19 Jun 2023 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171102;
        bh=LFhSZaWrLkPi69TGqTKhasEZ06KWUxtIGozV4/e72Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mK1xEAbssmnvTW3AFYkT6fgV+c6DtAwRqqbT2/r7PxydnWOgFezvl6M8m4ovt2Dz/
         2iZKD1GE8MpTB1p+sxP70gTZi0zxPnPXTWj9nk05tMS55uR+bpjJl6/WLfz0YFdXbH
         Uti1IXbGQmcegvPr11Brbo8ZSySrx01sCBA4kaLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 148/187] wifi: mac80211: fragment per STA profile correctly
Date:   Mon, 19 Jun 2023 12:29:26 +0200
Message-ID: <20230619102204.798771389@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit d094482c9974a543851a18a1c587a7d132a81659 ]

When fragmenting the ML per STA profile, the element ID should be
IEEE80211_MLE_SUBELEM_PER_STA_PROFILE rather than WLAN_EID_FRAGMENT.

Change the helper function to take the to be used element ID and pass
the appropriate value for each of the fragmentation levels.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230611121219.9b5c793d904b.I7dad952bea8e555e2f3139fbd415d0cd2b3a08c3@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 5 +++--
 net/mac80211/util.c        | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eba7ae63fac45..347030b9bb9e3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2272,7 +2272,7 @@ ieee802_11_parse_elems(const u8 *start, size_t len, bool action,
 	return ieee802_11_parse_elems_crc(start, len, action, 0, 0, bss);
 }
 
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos);
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id);
 
 extern const int ieee802_1d_to_ac[8];
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 7a970b6dda640..d28a35c538bac 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1372,10 +1372,11 @@ static void ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 		ieee80211_add_non_inheritance_elem(skb, outer_present_elems,
 						   link_present_elems);
 
-		ieee80211_fragment_element(skb, subelem_len);
+		ieee80211_fragment_element(skb, subelem_len,
+					   IEEE80211_MLE_SUBELEM_FRAGMENT);
 	}
 
-	ieee80211_fragment_element(skb, ml_elem_len);
+	ieee80211_fragment_element(skb, ml_elem_len, WLAN_EID_FRAGMENT);
 }
 
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index d7b382866b260..1a0d38cd46337 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4955,7 +4955,7 @@ u8 *ieee80211_ie_build_eht_cap(u8 *pos,
 	return pos;
 }
 
-void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
+void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id)
 {
 	unsigned int elem_len;
 
@@ -4975,7 +4975,7 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos)
 		memmove(len_pos + 255 + 3, len_pos + 255 + 1, elem_len);
 		/* place the fragment ID */
 		len_pos += 255 + 1;
-		*len_pos = WLAN_EID_FRAGMENT;
+		*len_pos = frag_id;
 		/* and point to fragment length to update later */
 		len_pos++;
 	}
-- 
2.39.2



