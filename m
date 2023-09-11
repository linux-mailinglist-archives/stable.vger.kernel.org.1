Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197B79B495
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjIKVNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbjIKOl1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:41:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85259E6
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:41:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC37EC433C7;
        Mon, 11 Sep 2023 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443282;
        bh=dgQHAwIsE17afQZcqUWDFxeXdYajhjq/vVkbBUbEXKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/HnYe/8eWfTjIV4dNkQrc2badcv+2BD+97l7zE8F6RtQL2l5E9syqdYeZ0V8K7W1
         /QJ2qzqKjFibpXIssLC0T9secm1xy+YeEjzIf60anTBKhrCB0ZiuNCnwaVj6dGYPl0
         NRbCRc/aRT1vwf8s/aL3VeK2zaNs58Oy9Zdc2l/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 322/737] block: dont allow enabling a cache on devices that dont support it
Date:   Mon, 11 Sep 2023 15:43:01 +0200
Message-ID: <20230911134659.550490012@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 43c9835b144c7ce29efe142d662529662a9eb376 ]

Currently the write_cache attribute allows enabling the QUEUE_FLAG_WC
flag on devices that never claimed the capability.

Fix that by adding a QUEUE_FLAG_HW_WC flag that is set by
blk_queue_write_cache and guards re-enabling the cache through sysfs.

Note that any rescan that calls blk_queue_write_cache will still
re-enable the write cache as in the current code.

Fixes: 93e9d8e836cb ("block: add ability to flag write back caching on a device")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230707094239.107968-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c   |  7 +++++--
 block/blk-sysfs.c      | 11 +++++++----
 include/linux/blkdev.h |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4dd59059b788e..0046b447268f9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -830,10 +830,13 @@ EXPORT_SYMBOL(blk_set_queue_depth);
  */
 void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 {
-	if (wc)
+	if (wc) {
+		blk_queue_flag_set(QUEUE_FLAG_HW_WC, q);
 		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else
+	} else {
+		blk_queue_flag_clear(QUEUE_FLAG_HW_WC, q);
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
+	}
 	if (fua)
 		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
 	else
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 50a0094300f2d..b7fc4cf3f992c 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -517,13 +517,16 @@ static ssize_t queue_wc_show(struct request_queue *q, char *page)
 static ssize_t queue_wc_store(struct request_queue *q, const char *page,
 			      size_t count)
 {
-	if (!strncmp(page, "write back", 10))
+	if (!strncmp(page, "write back", 10)) {
+		if (!test_bit(QUEUE_FLAG_HW_WC, &q->queue_flags))
+			return -EINVAL;
 		blk_queue_flag_set(QUEUE_FLAG_WC, q);
-	else if (!strncmp(page, "write through", 13) ||
-		 !strncmp(page, "none", 4))
+	} else if (!strncmp(page, "write through", 13) ||
+		 !strncmp(page, "none", 4)) {
 		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	return count;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 67e942d776bd8..2e2cd4b824e7f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -546,6 +546,7 @@ struct request_queue {
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
+#define QUEUE_FLAG_HW_WC	18	/* Write back caching supported */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
 #define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
-- 
2.40.1



