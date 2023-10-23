Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3E7D345D
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjJWLjB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjJWLjB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:39:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980DE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:38:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A71C433CB;
        Mon, 23 Oct 2023 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061139;
        bh=bZCnZ0+kfzlCAooFhuLOgjk2PStaNXOFTijyABwCnoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK4trWdzUKCyjkuaUhAiyUXYGD/gwTMwWzQ8FVIFIMazJpDgVQEUn6u4PCO862wyo
         xNNggFttG6J1YB3QHRPFbOddihshWghWq7+iX0rG6cTvVFd4rxUchknfNjIJyQchuB
         imrL/PTT3h5Qb1VE9KNRrggyOAjqqtIda0NIXo7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 086/137] wifi: cfg80211: avoid leaking stack data into trace
Date:   Mon, 23 Oct 2023 12:57:23 +0200
Message-ID: <20231023104823.804461039@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 334bf33eec5701a1e4e967bcb7cc8611a998334b ]

If the structure is not initialized then boolean types might be copied
into the tracing data without being initialised. This causes data from
the stack to leak into the trace and also triggers a UBSAN failure which
can easily be avoided here.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://lore.kernel.org/r/20230925171855.a9271ef53b05.I8180bae663984c91a3e036b87f36a640ba409817@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ed3ec7e320ced..82b93380afec4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7664,7 +7664,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct mesh_config cfg;
+	struct mesh_config cfg = {};
 	u32 mask;
 	int err;
 
-- 
2.40.1



