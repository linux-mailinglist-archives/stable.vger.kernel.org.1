Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7956F63C3
	for <lists+stable@lfdr.de>; Thu,  4 May 2023 05:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEDDzD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 23:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEDDy5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 23:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF931FFF;
        Wed,  3 May 2023 20:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F46263168;
        Thu,  4 May 2023 03:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3B1C4339E;
        Thu,  4 May 2023 03:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683172489;
        bh=UUdVYK3NIGsNWCXCXmoJWWUaXuVnxz9Eu6l2VyH3l0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEICZO2gxzqGthL+A1161/7Hca7ksKf5i9GWxRNMJd2FPk08niY8XtA7oNQD9wlqd
         lFUUUsz8LFbwHYv6DC7RGOZrSPWS9+LBkcx13zUQjs+Iwm6ArNFhRjI9WZMaTrcJKC
         DNf/EC0NIOS9BBOSGTcZ9ggGdFnWBaMtPikBnup1TmGSVRXOrAj+oIvSNY6E137GWN
         QjQgEBTkhXG4RBW4mN+nTS/TlruUMtqAXGmPCkl2zCxZgoYM4iYeUnsNzQarZwb7/m
         T3kImZebdCUooLzpFfOFqpMiak/3t9ViCFHJXARZRjPsA1PyPyosxK89Mxr6AVi5RW
         sb1S6ZNORCH6Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 7/7] blk-crypto: make blk_crypto_evict_key() more robust
Date:   Wed,  3 May 2023 20:54:17 -0700
Message-Id: <20230504035417.61435-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 5c7cb94452901a93e90c2230632e2c12a681bc92 upstream.

If blk_crypto_evict_key() sees that the key is still in-use (due to a
bug) or that ->keyslot_evict failed, it currently just returns while
leaving the key linked into the keyslot management structures.

However, blk_crypto_evict_key() is only called in contexts such as inode
eviction where failure is not an option.  So actually the caller
proceeds with freeing the blk_crypto_key regardless of the return value
of blk_crypto_evict_key().

These two assumptions don't match, and the result is that there can be a
use-after-free in blk_crypto_reprogram_all_keys() after one of these
errors occurs.  (Note, these errors *shouldn't* happen; we're just
talking about what happens if they do anyway.)

Fix this by making blk_crypto_evict_key() unlink the key from the
keyslot management structures even on failure.

Also improve some comments.

Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-crypto-profile.c | 46 +++++++++++++++++---------------------
 block/blk-crypto.c         | 28 ++++++++++++++++-------
 2 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 0307fb0d95d34..3290c03c9918d 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -354,28 +354,16 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 	return true;
 }
 
-/**
- * __blk_crypto_evict_key() - Evict a key from a device.
- * @profile: the crypto profile of the device
- * @key: the key to evict.  It must not still be used in any I/O.
- *
- * If the device has keyslots, this finds the keyslot (if any) that contains the
- * specified key and calls the driver's keyslot_evict function to evict it.
- *
- * Otherwise, this just calls the driver's keyslot_evict function if it is
- * implemented, passing just the key (without any particular keyslot).  This
- * allows layered devices to evict the key from their underlying devices.
- *
- * Context: Process context. Takes and releases profile->lock.
- * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
- *	   if the keyslot is still in use, or another -errno value on other
- *	   error.
+/*
+ * This is an internal function that evicts a key from an inline encryption
+ * device that can be either a real device or the blk-crypto-fallback "device".
+ * It is used only by blk_crypto_evict_key(); see that function for details.
  */
 int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 			   const struct blk_crypto_key *key)
 {
 	struct blk_crypto_keyslot *slot;
-	int err = 0;
+	int err;
 
 	if (profile->num_slots == 0) {
 		if (profile->ll_ops.keyslot_evict) {
@@ -389,22 +377,30 @@ int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
 
 	blk_crypto_hw_enter(profile);
 	slot = blk_crypto_find_keyslot(profile, key);
-	if (!slot)
-		goto out_unlock;
+	if (!slot) {
+		/*
+		 * Not an error, since a key not in use by I/O is not guaranteed
+		 * to be in a keyslot.  There can be more keys than keyslots.
+		 */
+		err = 0;
+		goto out;
+	}
 
 	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
+		/* BUG: key is still in use by I/O */
 		err = -EBUSY;
-		goto out_unlock;
+		goto out_remove;
 	}
 	err = profile->ll_ops.keyslot_evict(profile, key,
 					    blk_crypto_keyslot_index(slot));
-	if (err)
-		goto out_unlock;
-
+out_remove:
+	/*
+	 * Callers free the key even on error, so unlink the key from the hash
+	 * table and clear slot->key even on error.
+	 */
 	hlist_del(&slot->hash_node);
 	slot->key = NULL;
-	err = 0;
-out_unlock:
+out:
 	blk_crypto_hw_exit(profile);
 	return err;
 }
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 099381d221542..6733286d506f6 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -394,15 +394,19 @@ int blk_crypto_start_using_key(struct block_device *bdev,
 }
 
 /**
- * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
- *			    it may have been programmed into
- * @bdev: The block_device who's associated inline encryption hardware this key
- *     might have been programmed into
- * @key: The key to evict
+ * blk_crypto_evict_key() - Evict a blk_crypto_key from a block_device
+ * @bdev: a block_device on which I/O using the key may have been done
+ * @key: the key to evict
  *
- * Upper layers (filesystems) must call this function to ensure that a key is
- * evicted from any hardware that it might have been programmed into.  The key
- * must not be in use by any in-flight IO when this function is called.
+ * For a given block_device, this function removes the given blk_crypto_key from
+ * the keyslot management structures and evicts it from any underlying hardware
+ * keyslot(s) or blk-crypto-fallback keyslot it may have been programmed into.
+ *
+ * Upper layers must call this before freeing the blk_crypto_key.  It must be
+ * called for every block_device the key may have been used on.  The key must no
+ * longer be in use by any I/O when this function is called.
+ *
+ * Context: May sleep.
  */
 void blk_crypto_evict_key(struct block_device *bdev,
 			  const struct blk_crypto_key *key)
@@ -414,6 +418,14 @@ void blk_crypto_evict_key(struct block_device *bdev,
 		err = __blk_crypto_evict_key(q->crypto_profile, key);
 	else
 		err = blk_crypto_fallback_evict_key(key);
+	/*
+	 * An error can only occur here if the key failed to be evicted from a
+	 * keyslot (due to a hardware or driver issue) or is allegedly still in
+	 * use by I/O (due to a kernel bug).  Even in these cases, the key is
+	 * still unlinked from the keyslot management structures, and the caller
+	 * is allowed and expected to free it right away.  There's nothing
+	 * callers can do to handle errors, so just log them and return void.
+	 */
 	if (err)
 		pr_warn_ratelimited("%pg: error %d evicting key\n", bdev, err);
 }
-- 
2.40.1

