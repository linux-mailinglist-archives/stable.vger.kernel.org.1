Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D78755147
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGPTyp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGPTym (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59BE5A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D96B260E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA017C433C8;
        Sun, 16 Jul 2023 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537275;
        bh=Iu740PoVzo3na45GxGFvqSuKG39MHTjEG+BZiZNJ+so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pA7F/dL1FD4p1oqzRJGicHnW4R+LSi/oj2W+9+UbE9hPhC3y1EkIPZgM/E7ODHEYt
         IrBeLVuW5aIRawmj7Rjcb2boJ/1WEMmJp43nKGz/RmFpvnV3BG91am6gzoMkL9L+xj
         vg26a2ZPcxAPJaea/SoyzMbPB9ncr6mVFNN91oFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 038/800] md/raid1-10: factor out a helper to add bio to plug
Date:   Sun, 16 Jul 2023 21:38:11 +0200
Message-ID: <20230716194949.979112500@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit 5ec6ca140a034682e421e2e808ef5ddfdfd65242 ]

The code in raid1 and raid10 is identical, prepare to limit the number
of plugged bios.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230529131106.2123367-3-yukuai1@huaweicloud.com
Stable-dep-of: 7db922bae3ab ("md/raid1-10: submit write io directly if bitmap is not enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1-10.c | 16 ++++++++++++++++
 drivers/md/raid1.c    | 12 +-----------
 drivers/md/raid10.c   | 11 +----------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index e61f6cad4e08e..9bf19a3409cef 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -109,3 +109,19 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
+
+static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
+				      blk_plug_cb_fn unplug)
+{
+	struct raid1_plug_cb *plug = NULL;
+	struct blk_plug_cb *cb = blk_check_plugged(unplug, mddev,
+						   sizeof(*plug));
+
+	if (!cb)
+		return false;
+
+	plug = container_of(cb, struct raid1_plug_cb, cb);
+	bio_list_add(&plug->pending, bio);
+
+	return true;
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b2..131d8fd5ccaab 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1343,8 +1343,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct bitmap *bitmap = mddev->bitmap;
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
 	bool write_behind = false;
@@ -1573,15 +1571,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					      r1_bio->sector);
 		/* flush_pending_writes() needs access to the rdev so...*/
 		mbio->bi_bdev = (void *)rdev;
-
-		cb = blk_check_plugged(raid1_unplug, mddev, sizeof(*plug));
-		if (cb)
-			plug = container_of(cb, struct raid1_plug_cb, cb);
-		else
-			plug = NULL;
-		if (plug) {
-			bio_list_add(&plug->pending, mbio);
-		} else {
+		if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c059533b890f9..eb0c1d019958e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1290,8 +1290,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
 	int devnum = r10_bio->devs[n_copy].devnum;
@@ -1331,14 +1329,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
 	atomic_inc(&r10_bio->remaining);
 
-	cb = blk_check_plugged(raid10_unplug, mddev, sizeof(*plug));
-	if (cb)
-		plug = container_of(cb, struct raid1_plug_cb, cb);
-	else
-		plug = NULL;
-	if (plug) {
-		bio_list_add(&plug->pending, mbio);
-	} else {
+	if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.39.2



