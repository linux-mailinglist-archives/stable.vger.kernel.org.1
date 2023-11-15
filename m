Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE787ECD12
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjKOTeS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjKOTeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD019D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15289C433CA;
        Wed, 15 Nov 2023 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076846;
        bh=1NpV2/Kmw6c7n/dw9CP7rUUMkexIPnIdYaLuChlozUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsOzxFMP0PnZOcJAm+1nXJ0m2QTSZe1Ph6rUskj7EX/raspwh5238C5vVM0/p1WgV
         w3JwQT9y+5jcqp8VByFrZEJlfQIPPNEQwUVVuf8DKVqVMyDHQ/Gj8aUU5URDOqI2A+
         tUtsoqedOoMj+cvNgR/DfmFeb7CCx63Ke7uGeIGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/603] wifi: mac80211: fix # of MSDU in A-MSDU calculation
Date:   Wed, 15 Nov 2023 14:09:49 -0500
Message-ID: <20231115191616.221638698@linuxfoundation.org>
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

[ Upstream commit 428e8976a15f849ad92b1c1e38dda2a684350ff7 ]

During my refactoring I wanted to get rid of the switch,
but replaced it with the wrong calculation. Fix that.

Fixes: 175ad2ec89fe ("wifi: mac80211: limit A-MSDU subframes for client too")
Reported-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230827135854.51bf1b8b0adb.Iffbd337fdad2b86ae12f5a39c69fb82b517f7486@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 7751f8ba960ee..0c5cc75857e4f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2990,7 +2990,7 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 				   WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB) << 1;
 
 	if (val)
-		sta->sta.max_amsdu_subframes = 4 << val;
+		sta->sta.max_amsdu_subframes = 4 << (4 - val);
 }
 
 #ifdef CONFIG_LOCKDEP
-- 
2.42.0



