Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5672872C1BD
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjFLLAK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjFLK7o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EE8127E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478CF62475
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA11C433EF;
        Mon, 12 Jun 2023 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566803;
        bh=9xHM3ixLZZBJtNM/kIArIDVog9YyMwqEuEs6QnsdVaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgobJVpfdjUi/qKMhDgig74XahLTb9aqXCxFjq+fagGQQxZ+p2Ue9KB1VRRWyy0dc
         dV8PzrkN/UY/BTcBjTjNpql+iYl5VPx3rxxoIocBoU6GMi5jHc2+zfRYqOThh0t6nm
         8GO0I8cBfffLvOTeYtiS3aslW0WUE4FH7+EhvJp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 037/160] wifi: cfg80211: fix locking in sched scan stop work
Date:   Mon, 12 Jun 2023 12:26:09 +0200
Message-ID: <20230612101716.752056851@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

[ Upstream commit 3e54ed8247c94c8bdf370bd872bd9dfe72b1b12b ]

This should use wiphy_lock() now instead of acquiring the
RTNL, since cfg80211_stop_sched_scan_req() now needs that.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf5..b3ec9eaec36b3 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -368,12 +368,12 @@ static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_stop_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->nl_owner_dead)
 			cfg80211_stop_sched_scan_req(rdev, req, false);
 	}
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_propagate_radar_detect_wk(struct work_struct *work)
-- 
2.39.2



