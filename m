Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7918D6FA9BC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbjEHKzK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjEHKyZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B82271C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E5D56297D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46330C433D2;
        Mon,  8 May 2023 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543225;
        bh=M5Kcmpnpwm1+RnsAiVIKaAWpAWXV7fxXkG0s86o9yL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJOF5mmEI4IesEHHYQXZbqtjvlEIif2QPbi2HIFWqBEKGybUox4Wqqj54yBMOeYym
         YfoCrELWA1X95PgDUNHUbCAwcAYJnliLyDW/s036XuWSaZIF501xCn+qq58rc7HpQc
         6upUhGHhK1IfJk4hwoGhiuUGEmn3QgYvJXTZmdOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Huckleberry <nhuck@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@google.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.3 023/694] blk-mq: release crypto keyslot before reporting I/O complete
Date:   Mon,  8 May 2023 11:37:38 +0200
Message-Id: <20230508094433.386537977@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

commit 9cd1e566676bbcb8a126acd921e4e194e6339603 upstream.

Once all I/O using a blk_crypto_key has completed, filesystems can call
blk_crypto_evict_key().  However, the block layer currently doesn't call
blk_crypto_put_keyslot() until the request is being freed, which happens
after upper layers have been told (via bio_endio()) the I/O has
completed.  This causes a race condition where blk_crypto_evict_key()
can see 'slot_refs != 0' without there being an actual bug.

This makes __blk_crypto_evict_key() hit the
'WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)' and return without
doing anything, eventually causing a use-after-free in
blk_crypto_reprogram_all_keys().  (This is a very rare bug and has only
been seen when per-file keys are being used with fscrypt.)

There are two options to fix this: either release the keyslot before
bio_endio() is called on the request's last bio, or make
__blk_crypto_evict_key() ignore slot_refs.  Let's go with the first
solution, since it preserves the ability to report bugs (via
WARN_ON_ONCE) where a key is evicted while still in-use.

Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
Cc: stable@vger.kernel.org
Reviewed-by: Nathan Huckleberry <nhuck@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20230315183907.53675-2-ebiggers@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-crypto-internal.h |   25 +++++++++++++++++++++----
 block/blk-crypto.c          |   24 ++++++++++++------------
 block/blk-merge.c           |    2 ++
 block/blk-mq.c              |   15 ++++++++++++++-
 4 files changed, 49 insertions(+), 17 deletions(-)

--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -65,6 +65,11 @@ static inline bool blk_crypto_rq_is_encr
 	return rq->crypt_ctx;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return rq->crypt_keyslot;
+}
+
 blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
 				    const struct blk_crypto_key *key,
 				    struct blk_crypto_keyslot **slot_ptr);
@@ -119,6 +124,11 @@ static inline bool blk_crypto_rq_is_encr
 	return false;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -153,14 +163,21 @@ static inline bool blk_crypto_bio_prep(s
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq);
-static inline blk_status_t blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
+static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	if (blk_crypto_rq_is_encrypted(rq))
-		return __blk_crypto_init_request(rq);
+		return __blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
+void __blk_crypto_rq_put_keyslot(struct request *rq);
+static inline void blk_crypto_rq_put_keyslot(struct request *rq)
+{
+	if (blk_crypto_rq_has_keyslot(rq))
+		__blk_crypto_rq_put_keyslot(rq);
+}
+
 void __blk_crypto_free_request(struct request *rq);
 static inline void blk_crypto_free_request(struct request *rq)
 {
@@ -199,7 +216,7 @@ static inline blk_status_t blk_crypto_in
 {
 
 	if (blk_crypto_rq_is_encrypted(rq))
-		return blk_crypto_init_request(rq);
+		return blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -224,27 +224,27 @@ static bool bio_crypt_check_alignment(st
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	return blk_crypto_get_keyslot(rq->q->crypto_profile,
 				      rq->crypt_ctx->bc_key,
 				      &rq->crypt_keyslot);
 }
 
-/**
- * __blk_crypto_free_request - Uninitialize the crypto fields of a request.
- *
- * @rq: The request whose crypto fields to uninitialize.
- *
- * Completely uninitializes the crypto fields of a request. If a keyslot has
- * been programmed into some inline encryption hardware, that keyslot is
- * released. The rq->crypt_ctx is also freed.
- */
-void __blk_crypto_free_request(struct request *rq)
+void __blk_crypto_rq_put_keyslot(struct request *rq)
 {
 	blk_crypto_put_keyslot(rq->crypt_keyslot);
+	rq->crypt_keyslot = NULL;
+}
+
+void __blk_crypto_free_request(struct request *rq)
+{
+	/* The keyslot, if one was needed, should have been released earlier. */
+	if (WARN_ON_ONCE(rq->crypt_keyslot))
+		__blk_crypto_rq_put_keyslot(rq);
+
 	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
-	blk_crypto_rq_set_defaults(rq);
+	rq->crypt_ctx = NULL;
 }
 
 /**
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -867,6 +867,8 @@ static struct request *attempt_merge(str
 	if (!blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
+	blk_crypto_rq_put_keyslot(next);
+
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -840,6 +840,12 @@ static void blk_complete_request(struct
 		req->q->integrity.profile->complete_fn(req, total_bytes);
 #endif
 
+	/*
+	 * Upper layers may call blk_crypto_evict_key() anytime after the last
+	 * bio_endio().  Therefore, the keyslot must be released before that.
+	 */
+	blk_crypto_rq_put_keyslot(req);
+
 	blk_account_io_completion(req, total_bytes);
 
 	do {
@@ -905,6 +911,13 @@ bool blk_update_request(struct request *
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
+	/*
+	 * Upper layers may call blk_crypto_evict_key() anytime after the last
+	 * bio_endio().  Therefore, the keyslot must be released before that.
+	 */
+	if (blk_crypto_rq_has_keyslot(req) && nr_bytes >= blk_rq_bytes(req))
+		__blk_crypto_rq_put_keyslot(req);
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)) &&
 		     !test_bit(GD_DEAD, &req->q->disk->state)) {
@@ -2965,7 +2978,7 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
-	ret = blk_crypto_init_request(rq);
+	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
 		bio->bi_status = ret;
 		bio_endio(bio);


