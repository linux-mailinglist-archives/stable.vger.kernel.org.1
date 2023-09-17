Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6857A37E2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbjIQT0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbjIQTZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F8133
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:25:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60450C433CA;
        Sun, 17 Sep 2023 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978749;
        bh=6r5mxmOLArxovufaUjCEVjjVyWyCOeB8fT0wgy59X7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqBvw70KsrYdG9zg2aRFgqCXwOo2M2GcQvLq4uqrhqCpivsRM2+otxt2tgO1RNQkO
         YvhwSvFLCo7zcT2qYUVPvVcsUtC3dc/mzh5mDdQJWOlNEpdW5gQjGWwdgRvQr7nB8f
         1heegooRGIGrgPVMs7QUZa17CAFfnvTWR6OLpsfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 150/406] md/md-bitmap: hold reconfig_mutex in backlog_store()
Date:   Sun, 17 Sep 2023 21:10:04 +0200
Message-ID: <20230917191105.128222692@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 44abfa6a95df425c0660d56043020b67e6d93ab8 ]

Several reasons why 'reconfig_mutex' should be held:

1) rdev_for_each() is not safe to be called without the lock, because
   rdev can be removed concurrently.
2) mddev_destroy_serial_pool() and mddev_create_serial_pool() should not
   be called concurrently.
3) mddev_suspend() from mddev_destroy/create_serial_pool() should be
   protected by the lock.

Fixes: 10c92fca636e ("md-bitmap: create and destroy wb_info_pool with the change of backlog")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20230706083727.608914-3-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index eb8a2d5ba83f4..d18ca119929e1 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2484,6 +2484,10 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 
+	rv = mddev_lock(mddev);
+	if (rv)
+		return rv;
+
 	/*
 	 * Without write mostly device, it doesn't make sense to set
 	 * backlog for max_write_behind.
@@ -2497,6 +2501,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!has_write_mostly) {
 		pr_warn_ratelimited("%s: can't set backlog, no write mostly device available\n",
 				    mdname(mddev));
+		mddev_unlock(mddev);
 		return -EINVAL;
 	}
 
@@ -2514,6 +2519,8 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
+
+	mddev_unlock(mddev);
 	return len;
 }
 
-- 
2.40.1



