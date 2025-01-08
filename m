Return-Path: <stable+bounces-108041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB1CA06837
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 23:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726C4160B38
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2C51F3D3A;
	Wed,  8 Jan 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shzNonx+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5019D8A3
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375085; cv=none; b=uKI/Ael6z5vE49Vl6p9cklN1K0GwnPaRGOzkXMB/dM63ID57FFfmKKhFitheTzcg/aMUkH5mRG9gWMDMrL335Cnpgim1ZujwqwIRv98Kw8P5CMW+t+XR6YJueqoayaQz0I/Yah3ygRFGhjVosH0kgHENWbRFLGvm+Z3ae5o/ChQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375085; c=relaxed/simple;
	bh=zKRWmYSQh7/mygX2OG41P26wplAwEwtrJGI+gtCvvec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X+rEUl26WFCYWc5/IVdVBND3mGAknLuW+6cMmE02YTYdYUXMURGQpkldpRQ7XXJ/4CijKPrtP+L4/TLl6ORa7oszI2+iyffK5w/IkMEyej7JqtO5W4GO8fJ7FKliaZASm2IjKXJOwFUWdMDEzn21+u9lX1ddIc4CJIgTXIP1U3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shzNonx+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9743093so490571a91.3
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736375083; x=1736979883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=endIA1QywE9kx/kEQSL+BrbQ7PfliQ5dUNVoyyBb53c=;
        b=shzNonx++Z/NZ+um6I05BR/YKQ7dImgRkyz2fdaHtTCqGHlJNuYqGT6muCTKHYbNPi
         ShRj8qyzuo7s+Eb1gbORioeop94VmqOLf4SsLdIs3ioCZrD51goWi0STnCBE/YAj4Ytr
         EVa9QDRCsI5eBGafcpg911RK6ebbQDNo2AtCEXNUnGsJFKkTqUixPTBuUngaKGmYvR1W
         NylzwBLC4M5ArT0z9AvI7Vc+UylEXVUrfiA6B52ot64HmbLKF/U8SFwu8kVntr5GMflw
         Y9tjiBn0PkYBB0p7Hzx4SefAnUcTVfdZB9bSYkvaiFSyDxVxzZ7xvJaaaFhIgdPubmgl
         H14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736375083; x=1736979883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=endIA1QywE9kx/kEQSL+BrbQ7PfliQ5dUNVoyyBb53c=;
        b=w9DTh+ncfkVMQPHihIR64P0HuuEyqk5iYORNqserptXk/EnYqzmgp8C8A284TxhZFl
         Cp4uHTKzo5wcVh96BDLzQZHQkWZZWl/p5ly5Vja1RbluXiy0PRSCyR2oRukigHK64tSj
         tq6lHF4RxSzOpxBY2fTim5Et0nR/L9zYyIGlI1vGBcLGt0BwmszkBa5NvUEHm9KWgNdb
         BExAAYAmhuGez3EuQaUOZ2F6KlpeUBm7dyvqGidBSes0sD9+i89ag0uRfrcX4iudgBl5
         mpqqI1NRkulsb3QEx810jfMye4QkAfzAUL2EJyq7X1llxdRFH+9RRMhEAiGj5+QwEPvs
         E6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrYIaUGRsvxfYXfbqzQ07Pfq52cCtIc2O+s1CSNwkxh2mNqyDgIsRSNGiArrFy8b7/+gi/nbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySi1U5ZcE9RZUS8RdE++6VunJSJzAAKlSi2QR6Kmn3rFA5mlJF
	xGx4RZBTjew126+sOlEQpWRpXXo84ACyrrWGr9V8yU8DBVeyZ8ak57VlFCWLfqOkmPbe2bJg48G
	cEi+8ZHbSbS4UvTBXKQ==
X-Google-Smtp-Source: AGHT+IHQNDoBQkyxuqotK+6pIB3Qh6vv4RAvnvdTxtTdy7eLuD2HWyiqxTPks8H9syShFTKOer6bMy+2RWSSHlc3
X-Received: from pjbsu4.prod.google.com ([2002:a17:90b:5344:b0:2f4:47fc:7f17])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e41:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f548eb25cfmr8199419a91.12.1736375083149;
 Wed, 08 Jan 2025 14:24:43 -0800 (PST)
Date: Wed,  8 Jan 2025 22:24:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108222441.3622031-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: zswap: properly synchronize freeing resources during
 CPU hotunplug
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
current CPU at the beginning of the operation is retrieved and used
throughout.  However, since neither preemption nor migration are
disabled, it is possible that the operation continues on a different
CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as some of the resources attached to the acomp_ctx
are freed during hotunplug in zswap_cpu_comp_dead() (i.e.
acomp_ctx.buffer, acomp_ctx.req, or acomp_ctx.acomp).

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
use crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure
the CPU cannot go away from under us.  Preemption cannot be disabled
with the crypto_acomp API as a sleepable context is needed.

Use the acomp_ctx.mutex to synchronize CPU hotplug callbacks allocating
and freeing resources with compression/decompression paths. Make sure
that acomp_ctx.req is NULL when the resources are freed. In the
compression/decompression paths, check if acomp_ctx.req is NULL after
acquiring the mutex (meaning the CPU was offlined) and retry on the new
CPU.

The initialization of acomp_ctx.mutex is moved from the CPU hotplug
callback to the pool initialization where it belongs (where the mutex is
allocated). In addition to adding clarity, this makes sure that CPU
hotplug cannot reinitialize a mutex that is already locked by
compression/decompression.

Previously a fix was attempted by holding cpus_read_lock() [1]. This
would have caused a potential deadlock as it is possible for code
already holding the lock to fall into reclaim and enter zswap (causing a
deadlock). A fix was also attempted using SRCU for synchronization, but
Johannes pointed out that synchronize_srcu() cannot be used in CPU
hotplug notifiers [2].

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

Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
---

This applies on top of the latest mm-hotfixes-unstable on top of 'Revert
"mm: zswap: fix race between [de]compression and CPU hotunplug"' and
after 'mm: zswap: disable migration while using per-CPU acomp_ctx' was
dropped.

v1 -> v2:
- Move the initialization of the mutex to pool initialization.
- Use the mutex to also synchronize with the CPU hotplug callback (i.e.
  zswap_cpu_comp_prep()).
- Naming cleanups.

---
 mm/zswap.c | 60 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..4d7e564732267 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -251,7 +251,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	int ret;
+	int ret, cpu;
 
 	if (!zswap_has_pool) {
 		/* if either are unset, pool initialization failed, and we
@@ -285,6 +285,9 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 		goto error;
 	}
 
+	for_each_possible_cpu(cpu)
+		mutex_init(&per_cpu_ptr(pool->acomp_ctx, cpu)->mutex);
+
 	ret = cpuhp_state_add_instance(CPUHP_MM_ZSWP_POOL_PREPARE,
 				       &pool->node);
 	if (ret)
@@ -821,11 +824,12 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
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
@@ -844,6 +848,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		ret = -ENOMEM;
 		goto req_fail;
 	}
+
+	/* acomp_ctx->req must be NULL if the acomp_ctx is not fully initialized */
 	acomp_ctx->req = req;
 
 	crypto_init_wait(&acomp_ctx->wait);
@@ -855,12 +861,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
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
 
@@ -869,17 +878,45 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
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
@@ -893,10 +930,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
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
@@ -949,7 +983,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	else if (alloc_ret)
 		zswap_reject_alloc_fail++;
 
-	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_unlock(acomp_ctx);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -960,9 +994,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	/*
 	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
@@ -986,10 +1018,10 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
 	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
-	mutex_unlock(&acomp_ctx->mutex);
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_unlock(acomp_ctx);
 }
 
 /*********************************
-- 
2.47.1.613.gc27f4b7a9f-goog


