Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A67ECB91
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjKOTXG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjKOTXF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49544A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD81AC433C9;
        Wed, 15 Nov 2023 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076181;
        bh=IW7EPkEu2275zpTaqvvs1A7De5cz7MpCs5Xr5Fk26MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2Lu12QfITRj4NL1cr41Y7YLG46hDrIy3LdxMHxsiG6vK4mD/Sp3q7dXcAJ/HwFe7
         kJepLbI9grkRQFcTL6f4IiolRcvrduhIYVJfIDXpBXYCJp3qxiANqi3elY0s9sW6/V
         /LBh7i06Iw6T/IBAGn2pJ+51VGPM3d8YjyFlm7tY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 127/550] wifi: mac80211: Fix setting vif links
Date:   Wed, 15 Nov 2023 14:11:51 -0500
Message-ID: <20231115191609.492767673@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit e7182c4e6bbeafa272612e6c06fa92b42ad107ad ]

When setting the interface links, ignore the change iff both the
valid links and the dormant links did not change. This is needed
to support cases where the valid links didn't change but the dormant
links did.

Fixes: 6d543b34dbcf ("wifi: mac80211: Support disabled links during association")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230928172905.0357b6306587.I7dbfec347949b629fea680d246a650d6207ff217@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 6148208b320e3..16cbaea93fc32 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -195,7 +195,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 
 	memset(to_free, 0, sizeof(links));
 
-	if (old_links == new_links)
+	if (old_links == new_links && dormant_links == sdata->vif.dormant_links)
 		return 0;
 
 	/* if there were no old links, need to clear the pointers to deflink */
-- 
2.42.0



