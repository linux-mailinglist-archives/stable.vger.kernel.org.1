Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E67ED018
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjKOTws (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjKOTwr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1866B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AC6C433C7;
        Wed, 15 Nov 2023 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077964;
        bh=aTBjXioSps0FItiwzO7VJ9BxGuu92PCPBB8ounLx6kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHHpFor3QuZg2xFeS12u3P2v11fCr2kTuGNpGslJ4gIIUGyX2/QSgW0wh0wJ+ggpT
         NQ8Z/pfsVZMyA6DjD8ux/m646JEEen3FdZHCC9nRd4enebHW4hzTNAIzIQ1IMVaeJz
         C923YEem3Ymgq7J2nepz3C+mKSXmcGuV+HezK2XU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/379] wifi: mac80211: fix # of MSDU in A-MSDU calculation
Date:   Wed, 15 Nov 2023 14:21:40 -0500
Message-ID: <20231115192646.646267659@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b8c6f6a668fc9..49b71453dec37 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2918,7 +2918,7 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 				   WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB) << 1;
 
 	if (val)
-		sta->sta.max_amsdu_subframes = 4 << val;
+		sta->sta.max_amsdu_subframes = 4 << (4 - val);
 }
 
 #ifdef CONFIG_LOCKDEP
-- 
2.42.0



