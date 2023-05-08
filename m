Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FB6FA68E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjEHKV3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjEHKU3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6732931
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7012624EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D38C433EF;
        Mon,  8 May 2023 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541221;
        bh=D3GOjQKvS4ma1wVRj35uiG85TriTrBR8VC89pstoyks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/ZDFrTXC1nyBQ8HSpgs2+fcZ64d8e+ORqbvTQQrvEqFNXLHYn/NJTkQwyNgG+XvC
         bGqZVHKg94Hk6EgAx8+sSh6RSDC29HFycAg3zS+IUhAxDXPVxk/fhJ4e1O9AvvG62A
         Sx9R/VXipDWc4vsZs6oZmz7/+b7VOAHvsScHJlIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.2 045/663] blk-crypto: make blk_crypto_evict_key() return void
Date:   Mon,  8 May 2023 11:37:51 +0200
Message-Id: <20230508094429.934230249@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 70493a63ba04f754f7a7dd53a4fcc82700181490 upstream.

blk_crypto_evict_key() is only called in contexts such as inode eviction
where failure is not an option.  So there is nothing the caller can do
with errors except log them.  (dm-table.c does "use" the error code, but
only to pass on to upper layers, so it doesn't really count.)

Just make blk_crypto_evict_key() return void and log errors itself.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-crypto.c         |   20 +++++++++-----------
 drivers/md/dm-table.c      |   19 +++++--------------
 include/linux/blk-crypto.h |    4 ++--
 3 files changed, 16 insertions(+), 27 deletions(-)

--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-crypto-profile.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -408,21 +409,18 @@ int blk_crypto_start_using_key(struct bl
  * Upper layers (filesystems) must call this function to ensure that a key is
  * evicted from any hardware that it might have been programmed into.  The key
  * must not be in use by any in-flight IO when this function is called.
- *
- * Return: 0 on success or if the key wasn't in any keyslot; -errno on error.
  */
-int blk_crypto_evict_key(struct block_device *bdev,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct block_device *bdev,
+			  const struct blk_crypto_key *key)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
+	int err;
 
 	if (blk_crypto_config_supported_natively(bdev, &key->crypto_cfg))
-		return __blk_crypto_evict_key(q->crypto_profile, key);
-
-	/*
-	 * If the block_device didn't support the key, then blk-crypto-fallback
-	 * may have been used, so try to evict the key from blk-crypto-fallback.
-	 */
-	return blk_crypto_fallback_evict_key(key);
+		err = __blk_crypto_evict_key(q->crypto_profile, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("%pg: error %d evicting key\n", bdev, err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1203,21 +1203,12 @@ struct dm_crypto_profile {
 	struct mapped_device *md;
 };
 
-struct dm_keyslot_evict_args {
-	const struct blk_crypto_key *key;
-	int err;
-};
-
 static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
-	struct dm_keyslot_evict_args *args = data;
-	int err;
+	const struct blk_crypto_key *key = data;
 
-	err = blk_crypto_evict_key(dev->bdev, args->key);
-	if (!args->err)
-		args->err = err;
-	/* Always try to evict the key from all devices. */
+	blk_crypto_evict_key(dev->bdev, key);
 	return 0;
 }
 
@@ -1230,7 +1221,6 @@ static int dm_keyslot_evict(struct blk_c
 {
 	struct mapped_device *md =
 		container_of(profile, struct dm_crypto_profile, profile)->md;
-	struct dm_keyslot_evict_args args = { key };
 	struct dm_table *t;
 	int srcu_idx;
 
@@ -1243,11 +1233,12 @@ static int dm_keyslot_evict(struct blk_c
 
 		if (!ti->type->iterate_devices)
 			continue;
-		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback,
+					  (void *)key);
 	}
 
 	dm_put_live_table(md, srcu_idx);
-	return args.err;
+	return 0;
 }
 
 static int
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -95,8 +95,8 @@ int blk_crypto_init_key(struct blk_crypt
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
 
-int blk_crypto_evict_key(struct block_device *bdev,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct block_device *bdev,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported_natively(struct block_device *bdev,
 					  const struct blk_crypto_config *cfg);


