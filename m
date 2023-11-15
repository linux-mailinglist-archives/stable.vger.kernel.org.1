Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5398E7ECB90
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjKOTXF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjKOTXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50CE19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463D5C433C7;
        Wed, 15 Nov 2023 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076180;
        bh=X2fI2rxDfAcCrDoPtNKOG2x6mfY0izgMjl90dyhB1xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNIDKtDDoery+iya5v9v+ddq97O/VTRxtQ6oG7oVoW8ndNlcUcI6d3v/6xI/rs38H
         vj9lijQHA7+/j06gHG5USh2RiIioyZmi3O8Pmg9sxhZgWFlmIL010G8UbfZ6FfYCSC
         5LABlrXJGnDA3he3mq7efLGplD2mzYFW4Kj0AWXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 126/550] wifi: mac80211: dont recreate driver link debugfs in reconfig
Date:   Wed, 15 Nov 2023 14:11:50 -0500
Message-ID: <20231115191609.423398091@linuxfoundation.org>
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

[ Upstream commit 822cab1987a0e028e38b60aecd98af0289b46e7b ]

We can delete any that we want to remove, but we can't
recreate the links as they already exist.

Fixes: 170cd6a66d9a ("wifi: mac80211: add netdev per-link debugfs data and driver hook")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230928172905.3d0214838421.I512a0ff86f631ff42bf25ea0cb2e8e8616794a94@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/driver-ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 30cd0c905a24f..aa37a1410f377 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -510,10 +510,13 @@ int drv_change_vif_links(struct ieee80211_local *local,
 	if (ret)
 		return ret;
 
-	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
-		link = rcu_access_pointer(sdata->link[link_id]);
+	if (!local->in_reconfig) {
+		for_each_set_bit(link_id, &links_to_add,
+				 IEEE80211_MLD_MAX_NUM_LINKS) {
+			link = rcu_access_pointer(sdata->link[link_id]);
 
-		ieee80211_link_debugfs_drv_add(link);
+			ieee80211_link_debugfs_drv_add(link);
+		}
 	}
 
 	return 0;
-- 
2.42.0



