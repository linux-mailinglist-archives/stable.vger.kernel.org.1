Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A8726FE7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjFGVDN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbjFGVCz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6C2D56
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BB664969
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5DC433D2;
        Wed,  7 Jun 2023 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171738;
        bh=fTAbgeYGcm8/oBVFE8zh5uiwmKb3Y1ytnxJB+vcW7cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHxkRqqdaOaU77gNZawM7mCMAocZ2joW4tmnGLNJssF4hYlT4WkBGqDAjhVDFxnxf
         lqHGUScsxl0PqYjG9vtGkfcEifLdq+h/Fb1+fdrBmJAnNBiRHYSel+DbgmPbb8gY+6
         J7KgozSyhGE+FTNzFmmVZRxwqUeapiRVFwOiQYxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 130/159] block: fix revalidate performance regression
Date:   Wed,  7 Jun 2023 22:17:13 +0200
Message-ID: <20230607200907.930100361@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

commit 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc upstream.

The scsi driver function sd_read_block_characteristics() always calls
disk_set_zoned() to a disk zoned model correctly, in case the device
model changed. This is done even for regular disks to set the zoned
model to BLK_ZONED_NONE and free any zone related resources if the drive
previously was zoned.

This behavior significantly impact the time it takes to revalidate disks
on a large system as the call to disk_clear_zone_settings() done from
disk_set_zoned() for the BLK_ZONED_NONE case results in the device
request queued to be frozen, even if there are no zone resources to
free.

Avoid this overhead for non-zoned devices by not calling
disk_clear_zone_settings() in disk_set_zoned() if the device model
was already set to BLK_ZONED_NONE, which is always the case for regular
devices.

Reported by: Brian Bunker <brian@purestorage.com>

Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230529073237.1339862-1-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-settings.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -875,6 +875,7 @@ static bool disk_has_partitions(struct g
 void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
 {
 	struct request_queue *q = disk->queue;
+	unsigned int old_model = q->limits.zoned;
 
 	switch (model) {
 	case BLK_ZONED_HM:
@@ -912,7 +913,7 @@ void blk_queue_set_zoned(struct gendisk
 		 */
 		blk_queue_zone_write_granularity(q,
 						queue_logical_block_size(q));
-	} else {
+	} else if (old_model != BLK_ZONED_NONE) {
 		blk_queue_clear_zone_settings(q);
 	}
 }


