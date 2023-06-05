Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D42723394
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFEXNz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 19:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFEXNw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 19:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B78FA7
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 16:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F0E622DE
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 23:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B7C433EF
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686006830;
        bh=PdUZWL4nl3Ce++5+Titv8pBvh678L57VRg8u9FLqXaQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yw/032WNqs8++M/WWmNj+JFHnzHDtrTneindoo6r2EHAOKTSaOMX2mywcTdmjjjZl
         /Dy3I0H3q3h3fiZDMfWxkWRn0RsS5AQ465G04ZmS/qoDdE19GyIZtIXU/mCfQMER1W
         yp+t8j4o3/hOGiIWlR/VNcZHxF7orwIREjVIU6vNJpZriVgG8Sd8gyFi4iMDLjlnlo
         INyMm7mJuNXg0LLuoaJMjYUkWV7OgAiz+gNhpcNqZTQ6NW84Ca7F2Ck3zEwk00Jgwx
         q5ngVxLYELWeCgEHDWZ/2urdZK3aqJG1KUu6BvpQwU8dUPrUyYneKsKdlVBDiQU8t0
         U8xSZyRdC+7XQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     stable@vger.kernel.org
Subject: [PATCH 5.15.y] block: fix revalidate performance regression
Date:   Tue,  6 Jun 2023 08:13:49 +0900
Message-Id: <20230605231349.1326266-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023060549-smolder-human-a813@gregkh>
References: <2023060549-smolder-human-a813@gregkh>
MIME-Version: 1.0
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

commit 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc upstream.

The scsi driver function sd_read_block_characteristics() always calls
blk_queue_set_zoned() to set a disk zoned model correctly, in case the
device model changed. This is done even for regular disks to set the
zoned model to BLK_ZONED_NONE and free any zone related resources if the
drive previously was zoned.

This behavior significantly impact the time it takes to revalidate disks
on a large system as the call to blk_queue_clear_zone_settings() done
from blk_queue_set_zoned() for the BLK_ZONED_NONE case results in the
device request queued to be frozen, even if there are no zone resources
to free.

Avoid this overhead for non-zoned devices by not calling
blk_queue_clear_zone_settings() in blk_queue_set_zoned() if the device
model was already set to BLK_ZONED_NONE, which is always the case for
regular devices.

Reported by: Brian Bunker <brian@purestorage.com>
Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230529073237.1339862-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b880c70e22e4..73a80895e3ae 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -875,6 +875,7 @@ static bool disk_has_partitions(struct gendisk *disk)
 void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int old_model = q->limits.zoned;
 
 	switch (model) {
 	case BLK_ZONED_HM:
@@ -912,7 +913,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 		 */
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
-	} else {
+	} else if (old_model != BLK_ZONED_NONE) {
 		blk_queue_clear_zone_settings(q);
 	}
 }
-- 
2.40.1

