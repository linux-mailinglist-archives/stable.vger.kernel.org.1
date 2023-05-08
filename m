Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501446FADEE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjEHLjj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjEHLjY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E704387C9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14AE36335B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294F8C433D2;
        Mon,  8 May 2023 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545935;
        bh=IH71y335sO8l8kQSRE4UyCathdSrk4YJ7efd52tG4o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfkLOf8d4OpuerB3tnyAbu3IK/pFmm0Zt9+Y5Urdyd5FI0rZS3bFh/vHaJgZ9tcKJ
         33fxYSjUq37meTUvyj6CCBQW7e3kIPREfOOb8zWFVojBvpuntPaTi11ULHPm9ptnUg
         xjOPw8Wn5OGcjockuWEDK3tbyI2JOti4ZgNJ0naY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 203/371] md: drop queue limitation for RAID1 and RAID10
Date:   Mon,  8 May 2023 11:46:44 +0200
Message-Id: <20230508094820.153354639@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

[ Upstream commit a92ce0feffeed8b91f02dac85246d1205e4a64b6 ]

As suggested by Neil Brown[1], this limitation seems to be
deprecated.

With plugging in use, writes are processed behind the raid thread
and conf->pending_count is not increased. This limitation occurs only
if caller doesn't use plugs.

It can be avoided and often it is (with plugging). There are no reports
that queue is growing to enormous size so remove queue limitation for
non-plugged IOs too.

[1] https://lore.kernel.org/linux-raid/162496301481.7211.18031090130574610495@noble.neil.brown.name

Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: 72c215ed8731 ("md/raid10: fix task hung in raid10d")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1-10.c | 6 ------
 drivers/md/raid1.c    | 7 -------
 drivers/md/raid10.c   | 7 -------
 3 files changed, 20 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 54db341639687..83f9a4f3d82e0 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -22,12 +22,6 @@
 
 #define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
 
-/* When there are this many requests queue to be written by
- * the raid thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 /* for managing resync I/O pages */
 struct resync_pages {
 	void		*raid_bio;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 783763f6845f4..47997a9a3ca18 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1358,12 +1358,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
 
-	if (conf->pending_count >= max_queued_requests) {
-		md_wakeup_thread(mddev->thread);
-		raid1_log(mddev, "wait queued");
-		wait_event(conf->wait_barrier,
-			   conf->pending_count < max_queued_requests);
-	}
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -3413,4 +3407,3 @@ MODULE_ALIAS("md-personality-3"); /* RAID1 */
 MODULE_ALIAS("md-raid1");
 MODULE_ALIAS("md-level-1");
 
-module_param(max_queued_requests, int, S_IRUGO|S_IWUSR);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c4c1a3a7d7abc..69708b455295b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1387,12 +1387,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		conf->reshape_safe = mddev->reshape_position;
 	}
 
-	if (conf->pending_count >= max_queued_requests) {
-		md_wakeup_thread(mddev->thread);
-		raid10_log(mddev, "wait queued");
-		wait_event(conf->wait_barrier,
-			   conf->pending_count < max_queued_requests);
-	}
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -5246,4 +5240,3 @@ MODULE_ALIAS("md-personality-9"); /* RAID10 */
 MODULE_ALIAS("md-raid10");
 MODULE_ALIAS("md-level-10");
 
-module_param(max_queued_requests, int, S_IRUGO|S_IWUSR);
-- 
2.39.2



