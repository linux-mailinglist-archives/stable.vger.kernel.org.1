Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998927A7FB1
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjITM3f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjITM3d (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:29:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0046A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:29:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16515C433CB;
        Wed, 20 Sep 2023 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212967;
        bh=ACDLIMlfNmdckQiVDwnCTyD1gMBdX0AMEp2RKsYqc9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JU51HnUMWBk8pzbsjGgZjlXxgnnS1JIdTYktM0h9X0ofRsDAJjsHIR7oUGawJ8NTw
         C9pBcDIk8/pg8RtZgCQqeBx79/emyUjjXEXxqWmKUuF7dsy59GP3LiNeS3TeD7obbd
         gTRT1U2pjKKa1wwonY6elkdc/o63uUjJp3GNiyh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 112/367] md/md-bitmap: hold reconfig_mutex in backlog_store()
Date:   Wed, 20 Sep 2023 13:28:09 +0200
Message-ID: <20230920112901.507609332@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index a549662ff4e51..843139447a964 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2488,6 +2488,10 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
 
+	rv = mddev_lock(mddev);
+	if (rv)
+		return rv;
+
 	/*
 	 * Without write mostly device, it doesn't make sense to set
 	 * backlog for max_write_behind.
@@ -2501,6 +2505,7 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	if (!has_write_mostly) {
 		pr_warn_ratelimited("%s: can't set backlog, no write mostly device available\n",
 				    mdname(mddev));
+		mddev_unlock(mddev);
 		return -EINVAL;
 	}
 
@@ -2518,6 +2523,8 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
+
+	mddev_unlock(mddev);
 	return len;
 }
 
-- 
2.40.1



