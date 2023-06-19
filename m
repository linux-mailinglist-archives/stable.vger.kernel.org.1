Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C598B7353D5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFSKtE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFSKsw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5119C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A95E560B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA512C433C8;
        Mon, 19 Jun 2023 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171727;
        bh=GegH/2qlEnd850B3ci3jzMWYTzWyclhfivXC/H4/hAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOj8fVkB5xuV4vrca1pQKUgFNhOzjzssobbACV3HLdo60t1nzTXFUisaW+HrsUIKs
         hjHLbuAfOd61LWJXdQl0CPux9yfiLqZqSSOnhA1ZRvHfpvZi85RC5CdkxSonh/PLj+
         eTe5ENYnTA+oBUnC41Mjtq4biRwYeBpw4cFxSSFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/166] wifi: mac80211: take lock before setting vif links
Date:   Mon, 19 Jun 2023 12:29:47 +0200
Message-ID: <20230619102200.160548333@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 15846f95ab01b71fdb1cef8df73680aad41edf70 ]

ieee80211_vif_set_links requires the sdata->local->mtx lock to be held.
Add the appropriate locking around the calls in both the link add and
remove handlers.

This causes a warning when e.g. ieee80211_link_release_channel is called
via ieee80211_link_stop from ieee80211_vif_update_links.

Fixes: 0d8c4a3c8688 ("wifi: mac80211: implement add/del interface link callbacks")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.fa0c6597fdad.I83dd70359f6cda30f86df8418d929c2064cf4995@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 06b9df2fbcd77..23a44edcb11f7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4732,11 +4732,16 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 				   unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	int res;
 
 	if (wdev->use_4addr)
 		return -EOPNOTSUPP;
 
-	return ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_lock(&sdata->local->mtx);
+	res = ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
+
+	return res;
 }
 
 static void ieee80211_del_intf_link(struct wiphy *wiphy,
@@ -4745,7 +4750,9 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+	mutex_lock(&sdata->local->mtx);
 	ieee80211_vif_set_links(sdata, wdev->valid_links);
+	mutex_unlock(&sdata->local->mtx);
 }
 
 static int sta_add_link_station(struct ieee80211_local *local,
-- 
2.39.2



