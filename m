Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7F79BBF6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjIKWtS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjIKN7r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:59:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A09CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:59:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF70C433C7;
        Mon, 11 Sep 2023 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440783;
        bh=D9kERBqc1W21zkaYNu1lRL1+406AT24ykVpoM4jrg6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGCU3wNz3AA5CYIyP/q7KlfJkF2tIW6RS9APBWH9sKvqslkppFaL8IPidLv1C2Dkq
         TqcvG5vbVa0WWmc3Gh7q+PwOgZIq1V4jBpnLs1NI49mCos462lgq0w2Y15vEvXf5lJ
         4ijz+OvYS1uFUiLABzeGRXgG4ZCWx3SEPX4l2gNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 166/739] wifi: mac80211: fix puncturing bitmap handling in CSA
Date:   Mon, 11 Sep 2023 15:39:25 +0200
Message-ID: <20230911134655.810869958@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 927521170c4a18c620f97865f7bad48f17c48967 ]

Code inspection reveals that we switch the puncturing bitmap
before the real channel switch, since that happens only in
the second round of the worker after the channel context is
switched by ieee80211_link_use_reserved_context().

Fixes: 2cc25e4b2a04 ("wifi: mac80211: configure puncturing bitmap")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e7ac246038925..d354b32a20f8f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3648,12 +3648,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
-	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
-		sdata->vif.bss_conf.eht_puncturing =
-					sdata->vif.bss_conf.csa_punct_bitmap;
-		changed |= BSS_CHANGED_EHT_PUNCTURING;
-	}
-
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
 	 * with multi-vif. once reservation is complete it will re-schedule the
@@ -3683,6 +3677,12 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
+	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
+		sdata->vif.bss_conf.eht_puncturing =
+					sdata->vif.bss_conf.csa_punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+
 	ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
 
 	if (sdata->deflink.csa_block_tx) {
-- 
2.40.1



