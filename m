Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5DB775BD0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjHILVT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjHILVT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EAFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DF0631E9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240ABC433C8;
        Wed,  9 Aug 2023 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580077;
        bh=azFdnCS3jyTNdP/1tSeIKUlJvjuWYdvw1GZDgXT8/TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oreXhXa2BeQbzJHIgEm9qqjAT4aamrOUtBsjhdOnxj0+QK2VNrHY+DL+IYN98r4MV
         I2rpC18raz94BEPqEjY72S746rAdVetFlyoTz8fuSxReoROrX63CdH3XDfYczNbi7v
         l+xccsRUlUFl4THfeQHTVufahuUr+dZLjL6AjcmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Coly Li <colyli@suse.de>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 219/323] bcache: remove int n from parameter list of bch_bucket_alloc_set()
Date:   Wed,  9 Aug 2023 12:40:57 +0200
Message-ID: <20230809103708.123026676@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 17e4aed8309ff28670271546c2c3263eb12f5eb6 ]

The parameter 'int n' from bch_bucket_alloc_set() is not cleared
defined. From the code comments n is the number of buckets to alloc, but
from the code itself 'n' is the maximum cache to iterate. Indeed all the
locations where bch_bucket_alloc_set() is called, 'n' is alwasy 1.

This patch removes the confused and unnecessary 'int n' from parameter
list of  bch_bucket_alloc_set(), and explicitly allocates only 1 bucket
for its caller.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 80fca8a10b60 ("bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/alloc.c  | 35 +++++++++++++++--------------------
 drivers/md/bcache/bcache.h |  4 ++--
 drivers/md/bcache/btree.c  |  2 +-
 drivers/md/bcache/super.c  |  2 +-
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index a1df0d95151c6..5310e1f4a2826 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -49,7 +49,7 @@
  *
  * bch_bucket_alloc() allocates a single bucket from a specific cache.
  *
- * bch_bucket_alloc_set() allocates one or more buckets from different caches
+ * bch_bucket_alloc_set() allocates one  bucket from different caches
  * out of a cache set.
  *
  * free_some_buckets() drives all the processes described above. It's called
@@ -488,34 +488,29 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k)
 }
 
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait)
+			   struct bkey *k, bool wait)
 {
-	int i;
+	struct cache *ca;
+	long b;
 
 	/* No allocation if CACHE_SET_IO_DISABLE bit is set */
 	if (unlikely(test_bit(CACHE_SET_IO_DISABLE, &c->flags)))
 		return -1;
 
 	lockdep_assert_held(&c->bucket_lock);
-	BUG_ON(!n || n > c->caches_loaded || n > MAX_CACHES_PER_SET);
 
 	bkey_init(k);
 
-	/* sort by free space/prio of oldest data in caches */
-
-	for (i = 0; i < n; i++) {
-		struct cache *ca = c->cache_by_alloc[i];
-		long b = bch_bucket_alloc(ca, reserve, wait);
+	ca = c->cache_by_alloc[0];
+	b = bch_bucket_alloc(ca, reserve, wait);
+	if (b == -1)
+		goto err;
 
-		if (b == -1)
-			goto err;
+	k->ptr[0] = MAKE_PTR(ca->buckets[b].gen,
+			     bucket_to_sector(c, b),
+			     ca->sb.nr_this_dev);
 
-		k->ptr[i] = MAKE_PTR(ca->buckets[b].gen,
-				bucket_to_sector(c, b),
-				ca->sb.nr_this_dev);
-
-		SET_KEY_PTRS(k, i + 1);
-	}
+	SET_KEY_PTRS(k, 1);
 
 	return 0;
 err:
@@ -525,12 +520,12 @@ int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
 }
 
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait)
+			 struct bkey *k, bool wait)
 {
 	int ret;
 
 	mutex_lock(&c->bucket_lock);
-	ret = __bch_bucket_alloc_set(c, reserve, k, n, wait);
+	ret = __bch_bucket_alloc_set(c, reserve, k, wait);
 	mutex_unlock(&c->bucket_lock);
 	return ret;
 }
@@ -638,7 +633,7 @@ bool bch_alloc_sectors(struct cache_set *c,
 
 		spin_unlock(&c->data_bucket_lock);
 
-		if (bch_bucket_alloc_set(c, watermark, &alloc.key, 1, wait))
+		if (bch_bucket_alloc_set(c, watermark, &alloc.key, wait))
 			return false;
 
 		spin_lock(&c->data_bucket_lock);
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 6a380ed4919a0..e81d783109847 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -952,9 +952,9 @@ void bch_bucket_free(struct cache_set *c, struct bkey *k);
 
 long bch_bucket_alloc(struct cache *ca, unsigned int reserve, bool wait);
 int __bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			   struct bkey *k, int n, bool wait);
+			   struct bkey *k, bool wait);
 int bch_bucket_alloc_set(struct cache_set *c, unsigned int reserve,
-			 struct bkey *k, int n, bool wait);
+			 struct bkey *k, bool wait);
 bool bch_alloc_sectors(struct cache_set *c, struct bkey *k,
 		       unsigned int sectors, unsigned int write_point,
 		       unsigned int write_prio, bool wait);
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ca0c6592a425e..40eea56b9c900 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1129,7 +1129,7 @@ struct btree *__bch_btree_node_alloc(struct cache_set *c, struct btree_op *op,
 
 	mutex_lock(&c->bucket_lock);
 retry:
-	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, wait))
+	if (__bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, wait))
 		goto err;
 
 	bkey_put(c, &k.key);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 43bedd3795fc8..4b076f7f184be 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -423,7 +423,7 @@ static int __uuid_write(struct cache_set *c)
 	closure_init_stack(&cl);
 	lockdep_assert_held(&bch_register_lock);
 
-	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, 1, true))
+	if (bch_bucket_alloc_set(c, RESERVE_BTREE, &k.key, true))
 		return 1;
 
 	SET_KEY_SIZE(&k.key, c->sb.bucket_size);
-- 
2.39.2



