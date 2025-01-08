Return-Path: <stable+bounces-108019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E02A06187
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E45F7A2EA6
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5C1FF61E;
	Wed,  8 Jan 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2xXlwx3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01031FF610
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352950; cv=none; b=QDLwLWjkTcXpWfO2y7iuqvCg2QzwIZscEJ2uvah1qbagHwdZfA5nIzV4mgX8ZtFNaIJRksLwx1biDcOLhLaNKAqFJUVao6x0rQia2bNUkUj0gX9YMpqYeMmvQQTTa9WZpVfT0W+Kp7LNgGzd/M5npfzMI/ugLRMMLlwFBuarUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352950; c=relaxed/simple;
	bh=+983KWKXqfGI3nElqTlik+NrJJOPAKwXQ1YKQSWvrkU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iIqWxnfMv6BU9SH4SwJObs4adjmJ8Kt4fDr+wec0JJepzunreQ/fwWnTELIHqjzAsCL/qGYDCBtGsZD81DvqNUP4f2Bjd/U0R75gceh8K0UU4xVpiVYJe1guVj9KWscBZ+aBihpgE76vAXNTXGlAISvXg0edQ4a8/rSmDF+tnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2xXlwx3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216405eea1fso235101925ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736352948; x=1736957748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sk3nztKTZL3vCOZPF5M7nt11YZ4zTaONZRd3xxpiShI=;
        b=Z2xXlwx3hIvbxgqDCd01fH3MhNSHq2MyJnKTBzT+eED7GeAjcynJTVpVSXGETpfotb
         i5ygRPjy9baj3bCodCnxRHG/meZHmMYCsBCglo4ZsUzsWBxgufbF2eIlMNH+K0Vt1/RE
         COS8E7wPNunsdtpeKXZ701RlWcuo6BOfRMqcPEgz1EbHpyRrxIveVmF5VEfvWymfxVWd
         bTkOyBknHWsRngwTVvawkSNMR2U4qnidehH4ZZU7XY1ig7bX5XP45hqorD315YvrGeFH
         s5//hvQLvT+dgWPs+5yyUrHB2Q9kfEyDCOEv8yPDOCdf4lrBsobkKDDvOS+3wOwOsBox
         5cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352948; x=1736957748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sk3nztKTZL3vCOZPF5M7nt11YZ4zTaONZRd3xxpiShI=;
        b=vac4VP3oZd7JZzWPKZoOWdSbRx58ZLEeX2nrUgavP/rUmMCCYefonA59atYXyBQk1O
         MQDw5Ewto1/J4gwDYx+nBNtUVx+1HGEtKQt1XMQNfcyIXXKctavpK3ltKCde42RVE3yn
         6sEsXAYmsxeUyBSkcePZOuLVAPtVffrtXLwRnpwyvZ6fFX7dynNFDsj8wIzHUYvcH0jq
         Go6TSyIHjtxhI3wis0TdQ2RPW4LnfRwQai540LJ/Gl2OeHsZ1llrm2M9UDTY3T0GiwF3
         oHc5ItqzlLrIikM7gRwAzgQLFfOTHbX/UAWYf3hTbzFX34Dp+12u6oSohYkm6YwwL7Vf
         Da+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNP5oY4lVSz6N47rN5hTg57dMZYOmUO/ZRq+Ky4xCxRBcE7p0cXQ6xcCBzQvFHoGgH9Y4Ugis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzagi8JWRURi5XksdxQ7C5GXuowW3yZn6ELy5nSs0ves3VEu/6m
	i42ciT7H8wjJKJAjHgShCMIYq7uGsunhZ+URtGMG73xXOuWXd/e+WujQsySbN9iRGqUYjwk6OlL
	4dofAKXkA8P4Qe5JiaA==
X-Google-Smtp-Source: AGHT+IF+k0kNGMCgpb1rjKQ5TUAYhvnPEovTtKxpvrG0ZZM5AKCuXp007gpJWla3EMSjurP1+7JDiP7gWOWXbJ0b
X-Received: from plbko14.prod.google.com ([2002:a17:903:7ce:b0:206:fee5:fffa])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec82:b0:216:2dc5:2310 with SMTP id d9443c01a7336-21a83fcf8bcmr50554015ad.48.1736352948066;
 Wed, 08 Jan 2025 08:15:48 -0800 (PST)
Date: Wed,  8 Jan 2025 16:15:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108161529.3193825-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: properly synchronize freeing resources during CPU hotunplug
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
are freed during hotunplug in zswap_cpu_comp_dead().

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
use crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure
the CPU cannot go away from under us.  Preemption cannot be disabled
with the crypto_acomp API as a sleepable context is needed.

During CPU hotunplug, hold the acomp_ctx.mutex before freeing any
resources, and set acomp_ctx.req to NULL when it is freed. In the
compress/decompress paths, after acquiring the acomp_ctx.mutex make sure
that acomp_ctx.req is not NULL (i.e. acomp_ctx resources were not freed
by CPU hotunplug). Otherwise, retry with the acomp_ctx from the new CPU.

This adds proper synchronization to ensure that the acomp_ctx resources
are not freed from under compress/decompress paths.

Note that the per-CPU acomp_ctx itself (including the mutex) is not
freed during CPU hotunplug, only acomp_ctx.req, acomp_ctx.buffer, and
acomp_ctx.acomp. So it is safe to acquire the acomp_ctx.mutex of a CPU
after it is hotunplugged.

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

---
 mm/zswap.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..4e3148050e093 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -869,17 +869,46 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
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
 
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu_lock(
+		struct crypto_acomp_ctx __percpu *acomp_ctx)
+{
+	struct crypto_acomp_ctx *ctx;
+
+	for (;;) {
+		ctx = raw_cpu_ptr(acomp_ctx);
+		mutex_lock(&ctx->mutex);
+		if (likely(ctx->req))
+			return ctx;
+		/*
+		 * It is possible that we were migrated to a different CPU after
+		 * getting the per-CPU ctx but before the mutex was acquired. If
+		 * the old CPU got offlined, zswap_cpu_comp_dead() could have
+		 * already freed ctx->req (among other things) and set it to
+		 * NULL. Just try again on the new CPU that we ended up on.
+		 */
+		mutex_unlock(&ctx->mutex);
+	}
+}
+
+static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
+{
+	mutex_unlock(&ctx->mutex);
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -893,10 +922,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(pool->acomp_ctx);
 	dst = acomp_ctx->buffer;
 	sg_init_table(&input, 1);
 	sg_set_page(&input, page, PAGE_SIZE, 0);
@@ -949,7 +975,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	else if (alloc_ret)
 		zswap_reject_alloc_fail++;
 
-	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_unlock(acomp_ctx);
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -960,9 +986,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(&acomp_ctx->mutex);
-
+	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool->acomp_ctx);
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 	/*
 	 * If zpool_map_handle is atomic, we cannot reliably utilize its mapped buffer
@@ -986,10 +1010,10 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
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


