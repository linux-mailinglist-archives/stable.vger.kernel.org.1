Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0A755491
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGPUbz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjGPUbr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F210E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9726760EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5410C433C7;
        Sun, 16 Jul 2023 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539501;
        bh=7iwqvDcAl4XOxCy4m6VmfSQYeYbVcfe62f0UTSZy+O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eWZJRU9yznjuUl6n1dDHtQ6FAt+sLntwAYfX4d2uhwx+4fvrR3VMQmAwPxaMXNnA3
         u3M8xHw03/D6dcBPFXGt7XdvoAj0o3cIh6jm3LdkeF2GcAPl1J4mBorcpznp/tUfsO
         yklIqCcENDDergxdB7x4mGWKipJNu+DurKKXx/ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/591] md/raid1-10: factor out a helper to submit normal write
Date:   Sun, 16 Jul 2023 21:42:49 +0200
Message-ID: <20230716194924.646731144@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 8295efbe68c080047e98d9c0eb5cb933b238a8cb ]

There are multiple places to do the same thing, factor out a helper to
prevent redundant code, and the helper will be used in following patch
as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230529131106.2123367-4-yukuai1@huaweicloud.com
Stable-dep-of: 7db922bae3ab ("md/raid1-10: submit write io directly if bitmap is not enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1-10.c | 17 +++++++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 26 ++++----------------------
 3 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 9bf19a3409cef..506299bd55cb6 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -110,6 +110,23 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
 
+
+static inline void raid1_submit_write(struct bio *bio)
+{
+	struct md_rdev *rdev = (struct md_rdev *)bio->bi_bdev;
+
+	bio->bi_next = NULL;
+	bio_set_dev(bio, rdev->bdev);
+	if (test_bit(Faulty, &rdev->flags))
+		bio_io_error(bio);
+	else if (unlikely(bio_op(bio) ==  REQ_OP_DISCARD &&
+			  !bdev_max_discard_sectors(bio->bi_bdev)))
+		/* Just ignore it */
+		bio_endio(bio);
+	else
+		submit_bio_noacct(bio);
+}
+
 static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 				      blk_plug_cb_fn unplug)
 {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f3f2078d69e77..ac64c587191b9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -799,17 +799,8 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
-		struct md_rdev *rdev = (void *)bio->bi_bdev;
-		bio->bi_next = NULL;
-		bio_set_dev(bio, rdev->bdev);
-		if (test_bit(Faulty, &rdev->flags)) {
-			bio_io_error(bio);
-		} else if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
-				    !bdev_max_discard_sectors(bio->bi_bdev)))
-			/* Just ignore it */
-			bio_endio(bio);
-		else
-			submit_bio_noacct(bio);
+
+		raid1_submit_write(bio);
 		bio = next;
 		cond_resched();
 	}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 14001cceb6186..ea6228ff3bb5e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -917,17 +917,8 @@ static void flush_pending_writes(struct r10conf *conf)
 
 		while (bio) { /* submit pending writes */
 			struct bio *next = bio->bi_next;
-			struct md_rdev *rdev = (void*)bio->bi_bdev;
-			bio->bi_next = NULL;
-			bio_set_dev(bio, rdev->bdev);
-			if (test_bit(Faulty, &rdev->flags)) {
-				bio_io_error(bio);
-			} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-					    !bdev_max_discard_sectors(bio->bi_bdev)))
-				/* Just ignore it */
-				bio_endio(bio);
-			else
-				submit_bio_noacct(bio);
+
+			raid1_submit_write(bio);
 			bio = next;
 		}
 		blk_finish_plug(&plug);
@@ -1136,17 +1127,8 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
-		struct md_rdev *rdev = (void*)bio->bi_bdev;
-		bio->bi_next = NULL;
-		bio_set_dev(bio, rdev->bdev);
-		if (test_bit(Faulty, &rdev->flags)) {
-			bio_io_error(bio);
-		} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-				    !bdev_max_discard_sectors(bio->bi_bdev)))
-			/* Just ignore it */
-			bio_endio(bio);
-		else
-			submit_bio_noacct(bio);
+
+		raid1_submit_write(bio);
 		bio = next;
 	}
 	kfree(plug);
-- 
2.39.2



