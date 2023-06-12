Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED672C0EA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjFLKzY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbjFLKyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE7295F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BF161BD9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942C0C433D2;
        Mon, 12 Jun 2023 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566503;
        bh=gUz7u2rjJu321GiDK3r3TFK+SzdqOfYtLcmuy/8ZDgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDK+Sbl52UOxCyG8xbSy1Cmstb1hgFjkix/H6VirqvDhBzyb8c4ozUG4Kn+BQ0dYf
         ijwdpgjZ/9a22+oaMWZcNNW7j46C5ixYBG+ByNyhwZwmlDUNpEO/99bFXEwyyMT3Xl
         6DwBGA+rBC8IpRzd9G0lSJjIzefQMiNc2luSZjTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/132] wifi: mac80211: dont translate beacon/presp addrs
Date:   Mon, 12 Jun 2023 12:26:03 +0200
Message-ID: <20230612101711.562832923@linuxfoundation.org>
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

[ Upstream commit 47c171a426e305f2225b92ed7b5e0a990c95f6d4 ]

Don't do link address translation for beacons and probe responses,
this leads to reporting multiple scan list entries for the same AP
(one with the MLD address) which just breaks things.

We might need to extend this in the future for some other (action)
frames that aren't MLD addressed.

Fixes: 42fb9148c078 ("wifi: mac80211: do link->MLD address translation on RX")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.62adead1b43a.Ifc25eed26ebf3b269f60b1ec10060156d0e7ec0d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 44e407e1a14c7..0f81492da0b46 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4857,7 +4857,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	}
 
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
-	    is_unicast_ether_addr(hdr->addr1)) {
+	    is_unicast_ether_addr(hdr->addr1) &&
+	    !ieee80211_is_probe_resp(hdr->frame_control) &&
+	    !ieee80211_is_beacon(hdr->frame_control)) {
 		/* translate to MLD addresses */
 		if (ether_addr_equal(link->conf->addr, hdr->addr1))
 			ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);
-- 
2.39.2



