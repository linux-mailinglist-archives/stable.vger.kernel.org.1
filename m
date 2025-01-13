Return-Path: <stable+bounces-108359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EFAA0ADB1
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 04:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BFC1886563
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1A13DBA0;
	Mon, 13 Jan 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oGzznF93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F44315A;
	Mon, 13 Jan 2025 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737457; cv=none; b=l1PCSIJV4zwX81qjJ614/EIyzsru7VdNL9ZsB3a+Gk1bm2f4mVfScDNaGy/WiLBI+/91+lhjK1+QxyES1Yd7jyW1O3YSi2DY6cAD7MI8V9gF+3g7NBpJD4OJimKzZ9GObzMaXxgmE3a96qzM1xJeqmgM/E6j6nlCZafPdv+cduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737457; c=relaxed/simple;
	bh=tmzR19mvKpNt8tDh/ZQHYIyXj1CnCUGk0K6P64NQBso=;
	h=Date:To:From:Subject:Message-Id; b=avnV1f0DoBtcY8Qo6jkOTEkxk89jBrClF4ehGj0AXS+G7c6trxgQucxXeaRRv7UcLUhSPQWNhgjhhdLvjsF+KrCTbZUBapGuKoBAdp5agufys0Su5sKIZ+IQlxEmUVImqYTjh5m5wziXCgnXhz1tfszRISxcVOYH00cNiqMd4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oGzznF93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7EFC4CEE3;
	Mon, 13 Jan 2025 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736737457;
	bh=tmzR19mvKpNt8tDh/ZQHYIyXj1CnCUGk0K6P64NQBso=;
	h=Date:To:From:Subject:From;
	b=oGzznF93EUvQGGbyDbAjLmeBdanBe73iQ+wEnv/Pk2UCmn53xQ+BKPnGATmmfWxQH
	 mVI4AJG3HOdqzKI9lkkDpZW57+GiGXa5svvd6DokdvUeIN74d/Ol+dippHsTqs8qQB
	 PKH2Co+6EjPxvt6vuOXojsB0O0z5Zw8DlkNtsVsk=
Date: Sun, 12 Jan 2025 19:04:16 -0800
To: mm-commits@vger.kernel.org,vitalywool@gmail.com,stable@vger.kernel.org,samsun1006219@gmail.com,nphamcs@gmail.com,kanchana.p.sridhar@intel.com,hannes@cmpxchg.org,chengming.zhou@linux.dev,baohua@kernel.org,yosryahmed@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-zswap-properly-synchronize-freeing-resources-during-cpu-hotunplug.patch removed from -mm tree
Message-Id: <20250113030417.1F7EFC4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: zswap: properly synchronize freeing resources during CPU hotunplug
has been removed from the -mm tree.  Its filename was
     mm-zswap-properly-synchronize-freeing-resources-during-cpu-hotunplug.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Yosry Ahmed <yosryahmed@google.com>
Subject: mm: zswap: properly synchronize freeing resources during CPU hotunplug
Date: Wed, 8 Jan 2025 22:24:41 +0000

In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
current CPU at the beginning of the operation is retrieved and used
throughout.  However, since neither preemption nor migration are disabled,
it is possible that the operation continues on a different CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as some of the resources attached to the acomp_ctx
are freed during hotunplug in zswap_cpu_comp_dead() (i.e. 
acomp_ctx.buffer, acomp_ctx.req, or acomp_ctx.acomp).

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure the
CPU cannot go away from under us.  Preemption cannot be disabled with the
crypto_acomp API as a sleepable context is needed.

Use the acomp_ctx.mutex to synchronize CPU hotplug callbacks allocating
and freeing resources with compression/decompression paths.  Make sure
that acomp_ctx.req is NULL when the resources are freed.  In the
compression/decompression paths, check if acomp_ctx.req is NULL after
acquiring the mutex (meaning the CPU was offlined) and retry on the new
CPU.

The initialization of acomp_ctx.mutex is moved from the CPU hotplug
callback to the pool initialization where it belongs (where the mutex is
allocated).  In addition to adding clarity, this makes sure that CPU
hotplug cannot reinitialize a mutex that is already locked by
compression/decompression.

Previously a fix was attempted by holding cpus_read_lock() [1].  This
would have caused a potential deadlock as it is possible for code already
holding the lock to fall into reclaim and enter zswap (causing a
deadlock).  A fix was also attempted using SRCU for synchronization, but
Johannes pointed out that synchronize_srcu() cannot be used in CPU hotplug
notifiers [2].

Alternative fixes that were considered/attempted and could have worked:
- Refcounting the per-CPU acomp_ctx. This involves complexity in
  handling the race between the refcount dropping to zero in
  zswap_[de]compress() and the refcount being re-initialized when the
  CPU is onlined.
- Disabling migration before getting the per-CPU acomp_ctx [3], but
  that's discouraged and is a much bigger hammer than needed, and could
  result in subtle performance issues.

[1]https://lkml.kernel.org/20241219212437.2714151-1-yosryahmed@google.com/
[2]https://lkml.kernel.org/20250107074724.1756696-2-yosryahmed@google.com/
[3]https://lkml.kernel.org/20250107222236.2715883-2-yosryahmed@google.com/

[yosryahmed@google.com: remove comment]
  Link: https://lkml.kernel.org/r/CAJD7tkaxS1wjn+swugt8QCvQ-rVF5RZnjxwPGX17k8x9zSManA@mail.gmail.com
Link: https://lkml.kernel.org/r/20250108222441.3622031-1-yosryahmed@google.com
Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
Cc: Barry Song <baohua@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zswap.c |   58 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 14 deletions(-)

--- a/mm/zswap.c~mm-zswap-properly-synchronize-freeing-resources-during-cpu-hotunplug
+++ a/mm/zswap.c
@@ -251,7 +251,7 @@ static struct zswap_pool *zswap_pool_cre
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	int ret;
+	int ret, cpu;
 
 	if (!zswap_has_pool) {
 		/* if either are unset, pool initialization failed, and we
@@ -285,6 +285,9 @@ static struct zswap_pool *zswap_pool_cre
 		goto error;
 	}
 
+	for_each_possible_cpu(cpu)
+		mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
+
 	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
 				       &pool->node);
 	if (ret)
@@ -821,11 +824,12 @@ static int zswap_cpu_comp_prepare(unsign
 	struct acomp_req *req;
 	int ret;
 
-	mutex_init(&acomp_ctx->mutex);
-
+	mutex_lock(&acomp_ctx->mutex);
 	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer)
-		return -ENOMEM;
+	if (!acomp_ctx->buffer) {
+		ret = -ENOMEM;
+		goto buffer_fail;
+	}
 
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
@@ -855,12 +859,15 @@ static int zswap_cpu_comp_prepare(unsign
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
+	mutex_unlock(&acomp_ctx->mutex);
 	return 0;
 
 req_fail:
 	crypto_free_acomp(acomp_ctx->acomp);
 acomp_fail:
 	kfree(acomp_ctx->buffer);
+buffer_fail:
+	mutex_unlock(&acomp_ctx->mutex);
 	return ret;
 }
 
@@ -869,17 +876,45 @@ static int zswap_cpu_comp_dead(unsigned
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 
+	mutex_lock(&acomp_ctx->mutex);
 	if (!IS_ERR_OR_NULL(acomp_ctx)) {
 		if (!IS_ERR_OR_NULL(acomp_ctx->req))
 			acomp_request_free(acomp_ctx->req);
+		acomp_ctx->req = NULL;
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
 		kfree(acomp_ctx->buffer);
 	}
+	mutex_unlock(&acomp_ctx->mutex);
 
 	return 0;
 }
 
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(struct zswap_pool *pool)
+{
+	struct crypto_acomp_ctx *acomp_ctx;
+
+	for (;;) {
+		acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
+		mutex_lock(&acomp_ctx->mutex);
+		if (likely(acomp_ctx->req))
+			return acomp_ctx;
+		/*
+		 * It is possible that we were migrated to a different CPU after
+		 * getting the per-CPU ctx but before the mutex was acquired. If
+		 * the old CPU got offlined, zswap_cpu_comp_dead() could have
+		 * already freed ctx->req (among other things) and set it to
+		 * NULL. Just try again on the new CPU that we ended up on.
+		 */
+		mutex_unlock(&acomp_ctx->mutex);
+	}
+}
+
+static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
+{
+	mutex_unlock(&acomp_ctx->mutex);
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -893,10 +928,7 @@ static bool zswap_compress(struct page *
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(pool);
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
@@ -949,7 +981,7 @@ unlock:
 	else if (alloc_ret)
 		zswap_reject_alloc_fail++;
 
-	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_unlock(acomp_ctx);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -960,9 +992,7 @@ static void zswap_decompress(struct zswa
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	/*
 	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
@@ -986,10 +1016,10 @@ static void zswap_decompress(struct zswa
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_unlock(acomp_ctx);
 }
 
 /*********************************
_

Patches currently in -mm which might be from yosryahmed@google.com are



