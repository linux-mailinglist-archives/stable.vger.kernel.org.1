Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961A57554D5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGPUeq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjGPUep (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4DD2
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55E4860EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A29C433C7;
        Sun, 16 Jul 2023 20:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539683;
        bh=DoUKZe7V7nrkZAHSUp1Xsa2lFT2+akblQ3WtZWCpMHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xtpaBrKxU2djUFr6T3PclKfWBcSGsH++B6XwchQZdnXpoujWUiK6yz05rXVjqg1Pu
         iRiopj1zNsv+UF9NWsUqNxzwxRMS8WJMUArcahr6Ds6R5Vq/obasGdUuJMkk2QmnPX
         Ve/6+5vkxcf2TLU/4Gm4mr/sXrx6u5GMgFsP+zFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/591] wifi: mac80211: recalc min chandef for new STA links
Date:   Sun, 16 Jul 2023 21:43:53 +0200
Message-ID: <20230716194926.309186226@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

[ Upstream commit ba7af2654e3b7b810c750b3c6106f6f20b81cc88 ]

When adding a new link to a station, this needs to cause a
recalculation of the minimum chandef since otherwise we can
have a higher bandwidth station connected on that link than
the link is operating at. Do the appropriate recalc.

Fixes: cb71f1d136a6 ("wifi: mac80211: add sta link addition/removal")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.377adf3c789a.I91bf28f399e16e6ac1f83bacd1029a698b4e6685@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 30efa26f977f6..b8c6f6a668fc9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2861,6 +2861,8 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 	if (!test_sta_flag(sta, WLAN_STA_INSERTED))
 		goto hash;
 
+	ieee80211_recalc_min_chandef(sdata, link_id);
+
 	/* Ensure the values are updated for the driver,
 	 * redone by sta_remove_link on failure.
 	 */
-- 
2.39.2



