Return-Path: <stable+bounces-105370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813249F86DD
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FF618964A4
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C51A9B27;
	Thu, 19 Dec 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiLFYh2n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48E1A0AFE
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643482; cv=none; b=p61vIHMMsWePCxYRpocttPkMeZlaemcO/QYCeDcX1+AC2X7U1SIRY6DS18NxCtvNVH3a4ItwwUdyU/7sZQd0Lpmao/3bokeF6W+wBFbfUe73p1faJzQl5jA6fS0Ch2QdZdfO3YUUvuzfe5s6oK/ggS4+OVdMWOhGKhgWMKPuWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643482; c=relaxed/simple;
	bh=cefdfB1yGhxUINcQUilu5D19OlaisDnr306U1LVHeRU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uqOHeeEPgBAUV2jlkufJzcz3CsKoUQsqhixsf5aTski4vC4W3+cgMi607YvdD7DMv8BM0oxQzK2NRPoFdLPFdqA996UzfucPpoWdquJG3y0F6LXGXBN02zGAnl6vta4joY651bparTwtoL15DXXw6N0WxKGZM4vpVmhY8MCl1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiLFYh2n; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-801d5add29eso808605a12.3
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734643480; x=1735248280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7O8GUIoD1UZG/rG8KBOAiEwEk9YL8KfYsJ7/2RZcq0=;
        b=WiLFYh2nXT8NtrnJfC0+8sBbhttr//Ghmza4c0IRoN1PeHCnnplANERUX1iAG/JLOG
         TLqQX8/68goFwqACbKPlCKVsbr3a4ev3ZMe8pj8J7KgZhFc/UwnH8sWznGpSG8Vb1ufO
         2ux/efkC2vaw1GBb5TOJn0+X0BMBazo0mNU1yv6+alt2Yk4mriFW0MFXHsqJZOhE3nut
         UmD3hQI87RVbMzN1AaFg+NZe1oqLO6WSKpgfyYpX6UeCCL4Op/2vBlO4r5XgY9f1o0Cd
         d4Gh2czp9gMYWIQriRhu71tVHeb21qwUp1hPCROIQX/k6WZBmMJZpdupo3nlW5JUpHqp
         sRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734643480; x=1735248280;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7O8GUIoD1UZG/rG8KBOAiEwEk9YL8KfYsJ7/2RZcq0=;
        b=dZZZCodGsGuPZnFkT3bomBZLouvxxTgnSO8jjX/+MoJyZblO35XEf+Uj1S95jocHS8
         /6YeYWuXsxLWh/Qk9vazgvEPZYom9IEHvdq4dj3aOca/vFLUbS4S7zsG32U1EcvH88vW
         a3400cWxXJQ5etSZ3y4H2AsmslcaWmQS59uLb2gj8Hu+fcXc3k2u4WdoY8P6+WH35sKY
         RTi6BtwkIjcFfun4D8MNVpqVxnlKifKkvXkFVyT4ouPlTlI0PcPnSYYln0SHc4CxM3WI
         O/6CqyEPZO6XlwFMPy6zwHMvZGg4ed/lE6+8SuG64E/WQ9k0ExJDgtNc4JdQybcCbpkV
         jsDA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0LKAnqbAMrHl9/jLlkxyt3hqLTL70jFxZg0OfoDQGCcl6jP8sMHsnpRdMqqDe1CJrgRoS4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJgACTX/zlncnKc3eQgvPsLePei+rao14WU4fsuCgBPOfIiKL
	I+IfCCbqc0GnJcAsRALvyaQb4URrszOVEWZoJqUHk65hNrtjgj1l4CquGeIVMH7PzBTrKg/wCpA
	qgeyOEzFMOu4ApZY/xQ==
X-Google-Smtp-Source: AGHT+IFnH6UQrf3C3P3rhQlihyUOrX9sGtuPFMiRoQuLliycrZpnMFxS2E+N7rAXPa1MSWZDj7o1ChPfPBNiASrl
X-Received: from pgbfu11.prod.google.com ([2002:a05:6a02:4a8b:b0:7fd:5569:7b79])
 (user=yosryahmed job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7487:b0:1e1:ab63:c5ed with SMTP id adf61e73a8af0-1e5e048b22emr887197637.23.1734643480234;
 Thu, 19 Dec 2024 13:24:40 -0800 (PST)
Date: Thu, 19 Dec 2024 21:24:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219212437.2714151-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
current CPU at the beginning of the operation is retrieved and used
throughout. However, since neither preemption nor migration are
disabled, it is possible that the operation continues on a different
CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as the resources attached to the acomp_ctx are
freed during hotunplug in zswap_cpu_comp_dead().

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
use crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure
the CPU cannot go away from under us. Preemption cannot be disabled with
the crypto_acomp API as a sleepable context is needed.

Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
per-acomp_ctx") increased the UAF surface area by making the per-CPU
buffers dynamic, adding yet another resource that can be freed from
under zswap compression/decompression by CPU hotunplug.

There are a few ways to fix this:
(a) Add a refcount for acomp_ctx.
(b) Disable migration while using the per-CPU acomp_ctx.
(c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
the CPUs read lock.

Implement (c) since it's simpler than (a), and (b) involves using
migrate_disable() which is apparently undesired (see huge comment in
include/linux/preempt.h).

Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb236..5a27af8d86ea9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -880,6 +880,18 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/* Prevent CPU hotplug from freeing up the per-CPU acomp_ctx resources */
+static struct crypto_acomp_ctx *acomp_ctx_get_cpu(struct crypto_acomp_ctx __percpu *acomp_ctx)
+{
+	cpus_read_lock();
+	return raw_cpu_ptr(acomp_ctx);
+}
+
+static void acomp_ctx_put_cpu(void)
+{
+	cpus_read_unlock();
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -893,8 +905,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	gfp_t gfp;
 	u8 *dst;
 
-	acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
-
+	acomp_ctx = acomp_ctx_get_cpu(pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	dst = acomp_ctx->buffer;
@@ -950,6 +961,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 		zswap_reject_alloc_fail++;
 
 	mutex_unlock(&acomp_ctx->mutex);
+	acomp_ctx_put_cpu();
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
@@ -960,7 +972,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
 
-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	acomp_ctx = acomp_ctx_get_cpu(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
@@ -990,6 +1002,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	acomp_ctx_put_cpu();
 }
 
 /*********************************
-- 
2.47.1.613.gc27f4b7a9f-goog


