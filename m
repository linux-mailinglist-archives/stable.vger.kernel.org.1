Return-Path: <stable+bounces-106817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F1A023A3
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324CE18854ED
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605F1DC982;
	Mon,  6 Jan 2025 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WdMwZDFc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCA1DC745
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161111; cv=none; b=IKj4e0IXmEvPruC9jSunN/whSCsgbzTok2jmQ2lOt6grDk7FW2PXoG6ANErayOaHGOkr1SDdZFGV5H8OGnaaZrSpbgzhFRs/bTwrmzFuWzh2gsu7HAIqpaGq/0dpU32kpfUQetIyL7g88jzE0T8j9yw8Lg+9gMWJ7he+DDko2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161111; c=relaxed/simple;
	bh=XwoeI1hVvp+6SEo1jhsrvQ4grGizuU2B2On8BPnOPl8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MK3E0xZcrwwqakRbm2qOaBBBRQ//7itUtdXJlNSpNXe+E+CGfPJhJr9WXFitLlqqf2Uu9SuzGxIi6ZIICbs2sITAbc7GVKsdlSrJ7YR1V1HFgmBQQaCeLE19s2h8chSGkLnCJQERK92Ir74Jl7pfoZxti9dCoLMtS4YRuKMPDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WdMwZDFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4741AC4CED2;
	Mon,  6 Jan 2025 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736161110;
	bh=XwoeI1hVvp+6SEo1jhsrvQ4grGizuU2B2On8BPnOPl8=;
	h=Subject:To:Cc:From:Date:From;
	b=WdMwZDFcn0OPTVtXQoH2G7i9Ir2MRcWG9TBKx0PtoPCnwb0eZwJgFKS04iABLHKVu
	 kDL0V1N92H76MNDLEQPA9m653M2YOLQNu9NWB1kQwbs6fgn64KWVDcFOCPAuwmeV6h
	 h7/RFC6YOzJFKmg6CxhPD1eqq9lk4Mp+N9rcV85M=
Subject: FAILED: patch "[PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug" failed to apply to 6.12-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,baohua@kernel.org,chengming.zhou@linux.dev,hannes@cmpxchg.org,nphamcs@gmail.com,samsun1006219@gmail.com,stable@vger.kernel.org,vitalywool@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:58:28 +0100
Message-ID: <2025010627-retry-detached-672f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x eaebeb93922ca6ab0dd92027b73d0112701706ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010627-retry-detached-672f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eaebeb93922ca6ab0dd92027b73d0112701706ef Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 19 Dec 2024 21:24:37 +0000
Subject: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug

In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
current CPU at the beginning of the operation is retrieved and used
throughout.  However, since neither preemption nor migration are disabled,
it is possible that the operation continues on a different CPU.

If the original CPU is hotunplugged while the acomp_ctx is still in use,
we run into a UAF bug as the resources attached to the acomp_ctx are freed
during hotunplug in zswap_cpu_comp_dead().

The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to use
crypto_acomp API for hardware acceleration") when the switch to the
crypto_acomp API was made.  Prior to that, the per-CPU crypto_comp was
retrieved using get_cpu_ptr() which disables preemption and makes sure the
CPU cannot go away from under us.  Preemption cannot be disabled with the
crypto_acomp API as a sleepable context is needed.

Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
per-acomp_ctx") increased the UAF surface area by making the per-CPU
buffers dynamic, adding yet another resource that can be freed from under
zswap compression/decompression by CPU hotunplug.

There are a few ways to fix this:
(a) Add a refcount for acomp_ctx.
(b) Disable migration while using the per-CPU acomp_ctx.
(c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
the CPUs read lock.

Implement (c) since it's simpler than (a), and (b) involves using
migrate_disable() which is apparently undesired (see huge comment in
include/linux/preempt.h).

Link: https://lkml.kernel.org/r/20241219212437.2714151-1-yosryahmed@google.com
Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org/
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv4OcuruL4tPg6OaQ@mail.gmail.com/
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Barry Song <baohua@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: Vitaly Wool <vitalywool@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..5a27af8d86ea 100644
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


