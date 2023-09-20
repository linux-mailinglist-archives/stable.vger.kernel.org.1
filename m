Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C97A7AD5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjITLqg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjITLqe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:46:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F2AD7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:46:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD412C433C7;
        Wed, 20 Sep 2023 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210388;
        bh=uYzYNOlCqgCXbSgIvd5rPQP2YjGgm9YbAD2w1ZuAS+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPyJjkRMD1Ro9SFK9wwWMnbtnDzpDF2mNxfXz5nNMVqYvq6H2Sg9berrJqRfGUVn3
         AIuQMc0KAAUFALfwHKh+AiwTLE7oKH+kU9glzn8vzAryGRr/zbrEDVKhAnbiygEfm0
         3oERJmuwwfQ3QwC+FGg/whDD8oZPGOFlAq10sSq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 057/211] Revert "wifi: mac80211_hwsim: check the return value of nla_put_u32"
Date:   Wed, 20 Sep 2023 13:28:21 +0200
Message-ID: <20230920112847.541223501@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

[ Upstream commit 1b78dd34560e9962f8e917fe4adde6f2ab0eb89f ]

This reverts commit b970ac68e0c4 ("wifi: mac80211_hwsim: check the
return value of nla_put_u32") since it introduced a memory leak in
the error path, which seems worse than sending an incomplete skb,
and the put can't fail anyway since the SKB was just allocated.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index dd516cec41973..23307c8baea21 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -582,9 +582,8 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiphy *wiphy,
 		 */
 
 		/* Add vendor data */
-		err = nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
-		if (err)
-			return err;
+		nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 1);
+
 		/* Send the event - this will call nla_nest_end() */
 		cfg80211_vendor_event(skb, GFP_KERNEL);
 	}
-- 
2.40.1



