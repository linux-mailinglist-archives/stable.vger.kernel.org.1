Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEB7DD561
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjJaRuK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjJaRuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:50:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6CB4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE1C433C7;
        Tue, 31 Oct 2023 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774606;
        bh=AtY9GNfqnzVs/Hy40qumy8bYxuMywspGmOVLkCy9JTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJ7UIoGijVJPDgCilgZjrykcBWXbc5aaAd+6VB1aLgq9a5KvY3U63ocu1H/9BkRx4
         rsrcdMgaJbfK6SMO75ihXrceDGCCEGPkPfeK8NZp5AGEJJCpNhSd/iaUY5qHVuic5V
         60TkoPeqeYhohNvhbl1NFyqOSOBBJ+O0gJ8C9LrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 067/112] wifi: cfg80211: pass correct pointer to rdev_inform_bss()
Date:   Tue, 31 Oct 2023 18:01:08 +0100
Message-ID: <20231031165903.432831007@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 3e3929ef889e650dd585dc0f4f7f18240688811a ]

Confusing struct member names here resulted in passing
the wrong pointer, causing crashes. Pass the correct one.

Fixes: eb142608e2c4 ("wifi: cfg80211: use a struct for inform_single_bss data")
Signed-off-by: Ben Greear <greearb@candelatech.com>
Link: https://lore.kernel.org/r/20231021154827.1142734-1-greearb@candelatech.com
[rewrite commit message, add fixes]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 939deecf0bbef..8210a6090ac16 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2125,7 +2125,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!res)
 		goto drop;
 
-	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
+	rdev_inform_bss(rdev, &res->pub, ies, drv_data->drv_data);
 
 	if (data->bss_source == BSS_SOURCE_MBSSID) {
 		/* this is a nontransmitting bss, we need to add it to
-- 
2.42.0



