Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AF75548F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjGPUbu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGPUbr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E0D10D1
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBAEF60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1B1C433C8;
        Sun, 16 Jul 2023 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539498;
        bh=vtBiAe7PE2rvv2FqZE7ixk10KdHHakHL1S10okaIx+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfVhYaihvqVKXCGvavOPSPSn5erKd3BxGkbuGK1AHIO1GAd4DHz2GmiwyHH0YbGbM
         qFngZ3/s/Rg/IUKU6Rh+68iJSCwbbromTI5w+/GZjzFZgtxJOo+HVuP2z2qIgcmvoy
         YR4EgCcZUMThrHLgbMmLCbATdBFpTKCu+cKxvskY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/591] md/raid1-10: factor out a helper to add bio to plug
Date:   Sun, 16 Jul 2023 21:42:48 +0200
Message-ID: <20230716194924.621007471@linuxfoundation.org>
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
index 58f705f429480..f3f2078d69e77 100644
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
index 386c16c398269..14001cceb6186 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1288,8 +1288,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
 	int devnum = r10_bio->devs[n_copy].devnum;
@@ -1329,14 +1327,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
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



