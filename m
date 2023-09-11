Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93279BC66
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378735AbjIKWg6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjIKPD7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D7125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95540C433C8;
        Mon, 11 Sep 2023 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444635;
        bh=LGbbjATeWdEp4gMxefJSjlaSL7zpsYZ7sn2Ui7FznZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GveQFNWS4WABaU9Kw0f2UaR2Chs+dF4xeBM0I6qdYm56z9d4/X228K35V/IqKnmCV
         c4JCxjQFm4GGRDhiyLA9X7tN90sxeaq/4T8f4n9p7jr3VG8ukID7BFNJV+pDyY1v4N
         hvPiqBASWx3RMwZ6m75v48n9p7zcgxk+GJs25/2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 062/600] wifi: cfg80211: remove links only on AP
Date:   Mon, 11 Sep 2023 15:41:35 +0200
Message-ID: <20230911134635.455105206@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 34d4e3eb67fed9c19719bedb748e5a8b6ccc97a5 ]

Since links are only controlled by userspace via cfg80211
in AP mode, also only remove them from the driver in that
case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.ed65b94916fa.I2458c46888284cc5ce30715fe642bc5fc4340c8f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 39680e7bad45a..f433f3fdd9e94 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -2479,6 +2479,13 @@ void cfg80211_remove_links(struct wireless_dev *wdev)
 {
 	unsigned int link_id;
 
+	/*
+	 * links are controlled by upper layers (userspace/cfg)
+	 * only for AP mode, so only remove them here for AP
+	 */
+	if (wdev->iftype != NL80211_IFTYPE_AP)
+		return;
+
 	wdev_lock(wdev);
 	if (wdev->valid_links) {
 		for_each_valid_link(wdev, link_id)
-- 
2.40.1



