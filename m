Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842377353D1
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjFSKtC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjFSKsv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074619BB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FOrV2GZDyhDum3plnn0iORPwufFaAVXanhNOBDzly5E=;
        t=1687171725; x=1688381325; b=YGzQnPx3StWYT3ECW2rbZMT1AueoPqG69MTmR4pEM2F2q41
        1zw58mjly3doYpP8YZsrygl5VKiyVCtSZoLPQOdT2+VfyXyQSYlS3IRLkaRhGybqV33xuypj//kAh
        2gLKoCwxzjLcQqD5TFSnnRDGJD0Xjbv9B5n0istrBfJmUvNuKHinyf+TzmRXKmSjTh6aBbHyq+XSC
        GXcJvSSMZLR6AowkcjExQYcqU+j4k9DRLBCQTNxBX2KM5nDfXNiRkn8qnngO18fkydw46RlrMCO+l
        5XJmVoBFupA0qiVHfxyzEb/TpeZfPp8w41u+Kr4yiH+iwu+QQG5DmWlNUNgN8PEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBCRA-00BIi2-0G;
        Mon, 19 Jun 2023 12:48:44 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 5.15 2/2] wifi: cfg80211: fix double lock bug in reg_wdev_chan_valid()
Date:   Mon, 19 Jun 2023 12:48:43 +0200
Message-ID: <20230619104841.246408-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619124841.39b6657ef396.Ia02b23f436d5efa82bde2c64f9d6376f5dc8f62a@changeid>
References: <20230619124841.39b6657ef396.Ia02b23f436d5efa82bde2c64f9d6376f5dc8f62a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 996c3117dae4c02b38a3cb68e5c2aec9d907ec15 upstream.

The locking was changed recently so now the caller holds the wiphy_lock()
lock.  Taking the lock inside the reg_wdev_chan_valid() function will
lead to a deadlock.

Fixes: f7e60032c661 ("wifi: cfg80211: fix locking in regulatory disconnect")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/40c4114a-6cb4-4abf-b013-300b598aba65@moroto.mountain
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/reg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0e49264ce1f6..9944abe710b3 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2398,9 +2398,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_ADHOC:
-		wiphy_lock(wiphy);
 		ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
-		wiphy_unlock(wiphy);
 
 		return ret;
 	case NL80211_IFTYPE_STATION:
-- 
2.41.0

