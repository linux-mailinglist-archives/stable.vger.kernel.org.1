Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D917353C1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjFSKsk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFSKsR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383FA173B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C939160B85
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE891C433C0;
        Mon, 19 Jun 2023 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171674;
        bh=Xczp+ZfrSXGOXpagvieR6Ep1+x09Ah3Ba7uJBYgakiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sw320fFRg1jhP1FQNiq1FSqTT1++PIirT7aJNA4EnLqih5wo3A/rByELjhVXn5vXo
         JPTWwTeFON0LNgH+RYwHwI7CiMGcyh3GxDs6QJ0eL6nHkS+fN5RyC6OZi3rO9p9ykN
         0MYNcEh/BzXUJR7pTHxqWG4w+OfseL+jiv8XUPyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 108/166] wifi: mac80211: fix link activation settings order
Date:   Mon, 19 Jun 2023 12:29:45 +0200
Message-ID: <20230619102200.053210317@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 01605ad6c3e8608d7e147c9b75d67eb8a3d27d88 ]

In the normal MLME code we always call
ieee80211_mgd_set_link_qos_params() before
ieee80211_link_info_change_notify() and some drivers,
notably iwlwifi, rely on that as they don't do anything
(but store the data) in their conf_tx.

Fix the order here to be the same as in the normal code
paths, so this isn't broken.

Fixes: 3d9011029227 ("wifi: mac80211: implement link switching")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.a2a86bba2f80.Iac97e04827966d22161e63bb6e201b4061e9651b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index a1b3031fefce2..a85b44c1bc995 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -2,7 +2,7 @@
 /*
  * MLO link handling
  *
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -387,6 +387,7 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						 IEEE80211_CHANCTX_SHARED);
 		WARN_ON_ONCE(ret);
 
+		ieee80211_mgd_set_link_qos_params(link);
 		ieee80211_link_info_change_notify(sdata, link,
 						  BSS_CHANGED_ERP_CTS_PROT |
 						  BSS_CHANGED_ERP_PREAMBLE |
@@ -401,7 +402,6 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 						  BSS_CHANGED_TWT |
 						  BSS_CHANGED_HE_OBSS_PD |
 						  BSS_CHANGED_HE_BSS_COLOR);
-		ieee80211_mgd_set_link_qos_params(link);
 	}
 
 	old_active = sdata->vif.active_links;
-- 
2.39.2



