Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB279AEFB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358106AbjIKWHt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbjIKPOT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0CFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF28DC433C7;
        Mon, 11 Sep 2023 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445255;
        bh=gk/VvbyfazW5ljzD4b+4KoRjRd55L8GHQGH24vTOUFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyoZVfFmkAAerhSE1Mj4Lpo+BFpfIUYAxMam9Ayqgbko8HMRwEoJulVW7V93nzZt3
         SZtUKqPBEkEraYc/iV8MSp/Q2QUvrEz2lNtnGoHY/WXThHA+Dw5UD2hJqCsFYMK7HG
         EI/WLX/NqhPpyd04sGCNQmM5/8kHUuYf6S1zWxYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 281/600] md/md-bitmap: hold reconfig_mutex in backlog_store()
Date:   Mon, 11 Sep 2023 15:45:14 +0200
Message-ID: <20230911134641.901896917@linuxfoundation.org>
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
index 8553f028825a1..5200bba63708e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2481,6 +2481,10 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 
+	rv = mddev_lock(mddev);
+	if (rv)
+		return rv;
+
 	/*
 	 * Without write mostly device, it doesn't make sense to set
 	 * backlog for max_write_behind.
@@ -2494,6 +2498,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!has_write_mostly) {
 		pr_warn_ratelimited("%s: can't set backlog, no write mostly device available\n",
 				    mdname(mddev));
+		mddev_unlock(mddev);
 		return -EINVAL;
 	}
 
@@ -2509,6 +2514,8 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
+
+	mddev_unlock(mddev);
 	return len;
 }
 
-- 
2.40.1



