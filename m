Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6F7038F4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbjEORgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244445AbjEORgf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E01FEF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1E462D97
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A5C433D2;
        Mon, 15 May 2023 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172045;
        bh=ZjsgIJLsIXwmuUIjaC1TAkaeNGyaxxzkRGsceUABVSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7xtvx6s7C93+7azpCemlzcW+namHga0foTUPDIRs1MjRuRBd2Wil6XAhR81OBkwT
         zx3XC6Hv9LXLexYNHKRKAEoDq4S5X9wURVbcyo5r79fhMZWgro2k/HR5Sw+FqPT8Mk
         AV5bBhdOgnmR5WQ7xHAoM/wOyDfmrXpfI2TIjvZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Biggers <ebiggers@google.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 026/381] blk-crypto: make blk_crypto_evict_key() more robust
Date:   Mon, 15 May 2023 18:24:37 +0200
Message-Id: <20230515161737.968056959@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-crypto.c      |   29 +++++++++++++++++++++--------
 block/keyslot-manager.c |   43 +++++++++++++++++++++----------------------
 2 files changed, 42 insertions(+), 30 deletions(-)

--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -385,15 +385,20 @@ int blk_crypto_start_using_key(const str
 }
 
 /**
- * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
- *			    it may have been programmed into
- * @q: The request queue who's associated inline encryption hardware this key
- *     might have been programmed into
- * @key: The key to evict
+ * blk_crypto_evict_key() - Evict a blk_crypto_key from a request_queue
+ * @q: a request_queue on which I/O using the key may have been done
+ * @key: the key to evict
  *
- * Upper layers (filesystems) must call this function to ensure that a key is
- * evicted from any hardware that it might have been programmed into.  The key
- * must not be in use by any in-flight IO when this function is called.
+ * For a given request_queue, this function removes the given blk_crypto_key
+ * from the keyslot management structures and evicts it from any underlying
+ * hardware keyslot(s) or blk-crypto-fallback keyslot it may have been
+ * programmed into.
+ *
+ * Upper layers must call this before freeing the blk_crypto_key.  It must be
+ * called for every request_queue the key may have been used on.  The key must
+ * no longer be in use by any I/O when this function is called.
+ *
+ * Context: May sleep.
  */
 void blk_crypto_evict_key(struct request_queue *q,
 			  const struct blk_crypto_key *key)
@@ -404,6 +409,14 @@ void blk_crypto_evict_key(struct request
 		err = blk_ksm_evict_key(q->ksm, key);
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
 		pr_warn_ratelimited("error %d evicting key\n", err);
 }
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -305,44 +305,43 @@ bool blk_ksm_crypto_cfg_supported(struct
 	return true;
 }
 
-/**
- * blk_ksm_evict_key() - Evict a key from the lower layer device.
- * @ksm: The keyslot manager to evict from
- * @key: The key to evict
- *
- * Find the keyslot that the specified key was programmed into, and evict that
- * slot from the lower layer device. The slot must not be in use by any
- * in-flight IO when this function is called.
- *
- * Context: Process context. Takes and releases ksm->lock.
- * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
- *	   if the keyslot is still in use, or another -errno value on other
- *	   error.
+/*
+ * This is an internal function that evicts a key from an inline encryption
+ * device that can be either a real device or the blk-crypto-fallback "device".
+ * It is used only by blk_crypto_evict_key(); see that function for details.
  */
 int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 		      const struct blk_crypto_key *key)
 {
 	struct blk_ksm_keyslot *slot;
-	int err = 0;
+	int err;
 
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
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
 	err = ksm->ksm_ll_ops.keyslot_evict(ksm, key,
 					    blk_ksm_get_slot_idx(slot));
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
 	blk_ksm_hw_exit(ksm);
 	return err;
 }


