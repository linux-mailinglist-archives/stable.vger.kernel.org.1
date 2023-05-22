Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB170C995
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjEVTtl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjEVTtl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9CB95
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 305A862AD4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCDCC433D2;
        Mon, 22 May 2023 19:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784979;
        bh=Lu2vEbmgehuO1flA7GGJ+e4RsNsF0qo4lbRnXUQ5d90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oh4C3NR3f4doPUbw69sU3cArs0cUNyCd5+TOsMHAa3DBjLB+iHWAXD6wahrzsLPqh
         QS8QoORnaEV1mEB9vaEEgSgE1MdMXW2RtHDNwbD2JRrU4uB4HJlTXRMZrvVBSQzkm1
         /XPTbhIp/huJu9oqqAcmCFurPSH/as/31h1G/QBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 268/364] wifi: mac80211: Fix puncturing bitmap handling in __ieee80211_csa_finalize()
Date:   Mon, 22 May 2023 20:09:33 +0100
Message-Id: <20230522190419.415590983@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 13ad2b1eeacd48ec0f31f55964e6dc7dfc2c0299 ]

'changed' can be OR'ed with BSS_CHANGED_EHT_PUNCTURING which is larger than
an u32.
So, turn 'changed' into an u64 and update ieee80211_set_after_csa_beacon()
accordingly.

In the commit in Fixes, only ieee80211_start_ap() was updated.

Fixes: 2cc25e4b2a04 ("wifi: mac80211: configure puncturing bitmap")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/e84a3f80fe536787f7a2c7180507efc36cd14f95.1682358088.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d3d861911ed65..fb8d80ebe8bbb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3502,7 +3502,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
 static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
-					  u32 *changed)
+					  u64 *changed)
 {
 	int err;
 
@@ -3545,7 +3545,7 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
 
 	sdata_assert_lock(sdata);
-- 
2.39.2



