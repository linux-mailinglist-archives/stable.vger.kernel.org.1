Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB9177ABBE
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHMVZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHMVZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4AF1700
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AFF62924
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F97CC433CA;
        Sun, 13 Aug 2023 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961914;
        bh=GN5vOEh1YtzbzrWPL6NrR2likInKwIa/wgfGZkI4IMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frkbR9PPecQELONu73ErYw5a71zoMgpwxwCyScccDgjPwdBBFTVWkrpAzrzDCKXR4
         2WDxDgkwQjlW7rRfApu3rgZYjYMs7XAZRdapjCLrRDCR0eplOM2TkQnySc4HyCj4eT
         A9gNMGqoQ7mDi9eRQYg5oxd+JKMutMUVdWbwxUGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dusty Mabe <dusty@dustymabe.com>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 027/206] zram: take device and not only bvec offset into account
Date:   Sun, 13 Aug 2023 23:16:37 +0200
Message-ID: <20230813211725.776479410@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christoph Hellwig <hch@lst.de>

commit 95848dcb9d676738411a8ff70a9704039f1b3982 upstream.

Commit af8b04c63708 ("zram: simplify bvec iteration in
__zram_make_request") changed the bio iteration in zram to rely on the
implicit capping to page boundaries in bio_for_each_segment.  But it
failed to care for the fact zram not only care about the page alignment
of the bio payload, but also the page alignment into the device.  For
buffered I/O and swap those are the same, but for direct I/O or kernel
internal I/O like XFS log buffer writes they can differ.

Fix this by open coding bio_for_each_segment and limiting the bvec len
so that it never crosses over a page alignment boundary in the device
in addition to the payload boundary already taken care of by
bio_iter_iovec.

Cc: stable@vger.kernel.org
Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
Reported-by: Dusty Mabe <dusty@dustymabe.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://lore.kernel.org/r/20230805055537.147835-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/zram/zram_drv.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1870,15 +1870,16 @@ static void zram_bio_discard(struct zram
 
 static void zram_bio_read(struct zram *zram, struct bio *bio)
 {
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	unsigned long start_time;
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
 
-	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bv, bio, iter) {
+	do {
 		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_reads);
@@ -1890,22 +1891,26 @@ static void zram_bio_read(struct zram *z
 		zram_slot_lock(zram, index);
 		zram_accessed(zram, index);
 		zram_slot_unlock(zram, index);
-	}
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
 }
 
 static void zram_bio_write(struct zram *zram, struct bio *bio)
 {
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	unsigned long start_time;
+	unsigned long start_time = bio_start_io_acct(bio);
+	struct bvec_iter iter = bio->bi_iter;
 
-	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bv, bio, iter) {
+	do {
 		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
+		struct bio_vec bv = bio_iter_iovec(bio, iter);
+
+		bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
 			atomic64_inc(&zram->stats.failed_writes);
@@ -1916,7 +1921,10 @@ static void zram_bio_write(struct zram *
 		zram_slot_lock(zram, index);
 		zram_accessed(zram, index);
 		zram_slot_unlock(zram, index);
-	}
+
+		bio_advance_iter_single(bio, &iter, bv.bv_len);
+	} while (iter.bi_size);
+
 	bio_end_io_acct(bio, start_time);
 	bio_endio(bio);
 }


