Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009A72C0DB
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjFLKzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjFLKy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143501726
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54FA61BD9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F62C433EF;
        Mon, 12 Jun 2023 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566446;
        bh=4M0+dbfsOnb9keDdUw9UKuAZJ5LO9Aj/VXio5sziWjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7xyjtY8tZ7Yca//Lgn/J7iDHl+X+fE+S1sLmqrNSprEAxpzR9cTu2aTWXI/vhrkl
         4T0eWwQpesqks74Yd2SIhovVeHGH1DXdEPE9D1M/tCZHmfe49tNNtxhK+IIGbvfogV
         i8VBsNOIvT+JGIeMmMNFBuvFICbTJWN0Lkb4SIaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/132] wifi: cfg80211: reject bad AP MLD address
Date:   Mon, 12 Jun 2023 12:26:01 +0200
Message-ID: <20230612101711.469582282@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

[ Upstream commit 727073ca5e55ab6a07df316250be8a12606e8677 ]

When trying to authenticate, if the AP MLD address isn't
a valid address, mac80211 can throw a warning. Avoid that
by rejecting such addresses.

Fixes: d648c23024bd ("wifi: nl80211: support MLO in auth/assoc")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.89188912bd1d.I8dbc6c8ee0cb766138803eec59508ef4ce477709@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7320d676ce3a5..087c0c442e231 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10542,6 +10542,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		if (!info->attrs[NL80211_ATTR_MLD_ADDR])
 			return -EINVAL;
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+		if (!is_valid_ether_addr(req.ap_mld_addr))
+			return -EINVAL;
 	}
 
 	req.bss = cfg80211_get_bss(&rdev->wiphy, chan, bssid, ssid, ssid_len,
-- 
2.39.2



