Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2566FAD04
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjEHLaP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjEHLaA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A30C3DEBA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A68962C3B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A089C433EF;
        Mon,  8 May 2023 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545385;
        bh=l378MXetJiWgLdBsW/kLT5wiMh1ZMwu3VmD8NWPd4Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKXo998x9lCPYsfc38nGCzfKut1kUqyAKjn4QOOJHxkOxo7f/RIUrzHHCM0sWlhOm
         ArXVFuwUgE/ZKsIeUkkIt1mA2nnP5vw8xlnp+fL3jRoYzwBcn+bkGk/OfVLWS/u+7A
         13BH97PSQGA8F+j+ykgVhQRecrJSIDbCDkDTwWhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 022/371] blk-crypto: make blk_crypto_evict_key() return void
Date:   Mon,  8 May 2023 11:43:43 +0200
Message-Id: <20230508094813.008804921@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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
 block/blk-crypto.c         |   22 ++++++++++------------
 drivers/md/dm-table.c      |   19 +++++--------------
 include/linux/blk-crypto.h |    4 ++--
 3 files changed, 17 insertions(+), 28 deletions(-)

--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/keyslot-manager.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -393,20 +394,17 @@ int blk_crypto_start_using_key(const str
  * Upper layers (filesystems) must call this function to ensure that a key is
  * evicted from any hardware that it might have been programmed into.  The key
  * must not be in use by any in-flight IO when this function is called.
- *
- * Return: 0 on success or if key is not present in the q's ksm, -err on error.
  */
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key)
 {
-	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
-		return blk_ksm_evict_key(q->ksm, key);
+	int err;
 
-	/*
-	 * If the request queue's associated inline encryption hardware didn't
-	 * have support for the key, then the key might have been programmed
-	 * into the fallback keyslot manager, so try to evict from there.
-	 */
-	return blk_crypto_fallback_evict_key(key);
+	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		err = blk_ksm_evict_key(q->ksm, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("error %d evicting key\n", err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1191,21 +1191,12 @@ struct dm_keyslot_manager {
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
 
-	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
-	if (!args->err)
-		args->err = err;
-	/* Always try to evict the key from all devices. */
+	blk_crypto_evict_key(bdev_get_queue(dev->bdev), key);
 	return 0;
 }
 
@@ -1220,7 +1211,6 @@ static int dm_keyslot_evict(struct blk_k
 						       struct dm_keyslot_manager,
 						       ksm);
 	struct mapped_device *md = dksm->md;
-	struct dm_keyslot_evict_args args = { key };
 	struct dm_table *t;
 	int srcu_idx;
 	int i;
@@ -1233,10 +1223,11 @@ static int dm_keyslot_evict(struct blk_k
 		ti = dm_table_get_target(t, i);
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
 
 static const struct blk_ksm_ll_ops dm_ksm_ll_ops = {
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -97,8 +97,8 @@ int blk_crypto_init_key(struct blk_crypt
 int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 			       struct request_queue *q);
 
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported(struct request_queue *q,
 				 const struct blk_crypto_config *cfg);


