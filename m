Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667797A3BCF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbjIQUW7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbjIQUWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7C6CD8
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD32C433C8;
        Sun, 17 Sep 2023 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982136;
        bh=hjfVfaaTjMiAJwbGL1rUjvBHYc5i2L0Kpt8W2dPMh00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHWvryIw4TPywpqDVKFBq1ftvSyp7TRJO4ZqWuq8uYeACipRpEIJ66JG3eNKLrYWK
         xCD3bFWRlXFTTiPj5G1yOIBgTsJIXmQe/lAsnYZWWNC5bjluPe3pzfZN+UnS9RKTRu
         31Seq+VjEvUoBAEAayqCH94NAqzW91Tgtdj1+eTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guoqing Jiang <guoqing.jiang@linux.dev>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 163/511] md/bitmap: dont set max_write_behind if there is no write mostly device
Date:   Sun, 17 Sep 2023 21:09:50 +0200
Message-ID: <20230917191117.781429046@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <guoqing.jiang@linux.dev>

[ Upstream commit 8c13ab115b577bd09097b9d77916732e97e31b7b ]

We shouldn't set it since write behind IO should only happen to write
mostly device.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Song Liu <songliubraving@fb.com>
Stable-dep-of: 44abfa6a95df ("md/md-bitmap: hold 'reconfig_mutex' in backlog_store()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-bitmap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index adada558a1b09..daedd9fcc4e5e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2476,11 +2476,30 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	unsigned long backlog;
 	unsigned long old_mwb = mddev->bitmap_info.max_write_behind;
+	struct md_rdev *rdev;
+	bool has_write_mostly = false;
 	int rv = kstrtoul(buf, 10, &backlog);
 	if (rv)
 		return rv;
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
+
+	/*
+	 * Without write mostly device, it doesn't make sense to set
+	 * backlog for max_write_behind.
+	 */
+	rdev_for_each(rdev, mddev) {
+		if (test_bit(WriteMostly, &rdev->flags)) {
+			has_write_mostly = true;
+			break;
+		}
+	}
+	if (!has_write_mostly) {
+		pr_warn_ratelimited("%s: can't set backlog, no write mostly device available\n",
+				    mdname(mddev));
+		return -EINVAL;
+	}
+
 	mddev->bitmap_info.max_write_behind = backlog;
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
-- 
2.40.1



