Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECA3755149
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGPTyq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGPTym (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA4E5C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9777260E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD148C433C8;
        Sun, 16 Jul 2023 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537278;
        bh=awzMB/r3Y9XZqkwP1IBC0lg9iq1dPx2W0phMbkkH0ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mH+e1A9jORG+OvdM/p2OjIBRJhUA6Gx7OzMU/cU+UMlIWqnM0K7vHAJlqsmYSYRG4
         5OyXmuAIID4mYU/4XWZDX3lASvrtbZ+Zprqiv9MCu456x7dQMbnl57+y0uvOJv1Bnv
         em8dVL9IMSH+vCMmlJPYlZmAvDYdLRARfe9aGJts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 039/800] md/raid1-10: factor out a helper to submit normal write
Date:   Sun, 16 Jul 2023 21:38:12 +0200
Message-ID: <20230716194950.002173492@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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
index 131d8fd5ccaab..e51b77a3a8397 100644
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
index eb0c1d019958e..9d11a52367d17 100644
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
@@ -1138,17 +1129,8 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
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



