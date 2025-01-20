Return-Path: <stable+bounces-109519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A915A16D81
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631DD168B31
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529951E1A25;
	Mon, 20 Jan 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xgNuP1aG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FA1FC8
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380293; cv=none; b=XRyfcXSYGoj4BMvv/zc9ecHiuamLr3Ozslvq3p6WfaGtOI2Kv1CPhcljb9sAGLZyOx/tKfpomcyVuogFPGjHk8gd7mYxbv5ac8+di/wMvsA2R4cH0JdTTh5GBLEhKlxN+m3bGdV2TCXPRKDkA4DbmBo7fi/bpHJCKZTIJl5EETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380293; c=relaxed/simple;
	bh=Xk+sqN6RCbXrJq0jaAWaW1gMg5nBVFxZ/OSoTf6fn/c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BM7PEvZm5syNLyZW1TriOGDDE7PZuXQTtZBqfo3a9KJR8VDPQAoLaKJrbDM4gICfQ6WKqR1MlHjRgOB5X2/v+Bu7Ygp7e2MmWLn5erwIOuZb5wiz1VbhEf18gjGWbWpZhGYjG5P0WR10CleuR39RlqfHcZ0Vcv4OuHJq2K/I8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xgNuP1aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733B3C4CEDD;
	Mon, 20 Jan 2025 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380292;
	bh=Xk+sqN6RCbXrJq0jaAWaW1gMg5nBVFxZ/OSoTf6fn/c=;
	h=Subject:To:Cc:From:Date:From;
	b=xgNuP1aG/ITfLPSre30NOYI4FnWhc9DaDBsnOFTRUAURZixJ47GX6rytn+6MANOxT
	 i/x+CDWsmVPMyVDOJJQye48SrlXfTaMovw+i75sm2uUZVYLVXGwEpiRuRaQ/HbRtFC
	 gMhp9eKZ8/a+j45ecgxrFYST7vd09/QteVByhwKc=
Subject: FAILED: patch "[PATCH] mm: zswap: move allocations during CPU init outside the lock" failed to apply to 5.15-stable tree
To: yosryahmed@google.com,akpm@linux-foundation.org,chengming.zhou@linux.dev,hannes@cmpxchg.org,nphamcs@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:38:02 +0100
Message-ID: <2025012002-spent-fervor-ada9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 779b9955f64327c339a16f68055af98252fd3315
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012002-spent-fervor-ada9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 779b9955f64327c339a16f68055af98252fd3315 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 13 Jan 2025 21:44:58 +0000
Subject: [PATCH] mm: zswap: move allocations during CPU init outside the lock

In zswap_cpu_comp_prepare(), allocations are made and assigned to various
members of acomp_ctx under acomp_ctx->mutex.  However, allocations may
recurse into zswap through reclaim, trying to acquire the same mutex and
deadlocking.

Move the allocations before the mutex critical section.  Only the
initialization of acomp_ctx needs to be done with the mutex held.

Link: https://lkml.kernel.org/r/20250113214458.2123410-1-yosryahmed@google.com
Fixes: 12dcb0ef5406 ("mm: zswap: properly synchronize freeing resources during CPU hotunplug")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/zswap.c b/mm/zswap.c
index 30f5a27a6862..b84c20d889b1 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -820,15 +820,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
-	struct crypto_acomp *acomp;
-	struct acomp_req *req;
+	struct crypto_acomp *acomp = NULL;
+	struct acomp_req *req = NULL;
+	u8 *buffer = NULL;
 	int ret;
 
-	mutex_lock(&acomp_ctx->mutex);
-	acomp_ctx->buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
-	if (!acomp_ctx->buffer) {
+	buffer = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buffer) {
 		ret = -ENOMEM;
-		goto buffer_fail;
+		goto fail;
 	}
 
 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
@@ -836,21 +836,25 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
 		ret = PTR_ERR(acomp);
-		goto acomp_fail;
+		goto fail;
 	}
-	acomp_ctx->acomp = acomp;
-	acomp_ctx->is_sleepable = acomp_is_async(acomp);
 
-	req = acomp_request_alloc(acomp_ctx->acomp);
+	req = acomp_request_alloc(acomp);
 	if (!req) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
 		ret = -ENOMEM;
-		goto req_fail;
+		goto fail;
 	}
-	acomp_ctx->req = req;
 
+	/*
+	 * Only hold the mutex after completing allocations, otherwise we may
+	 * recurse into zswap through reclaim and attempt to hold the mutex
+	 * again resulting in a deadlock.
+	 */
+	mutex_lock(&acomp_ctx->mutex);
 	crypto_init_wait(&acomp_ctx->wait);
+
 	/*
 	 * if the backend of acomp is async zip, crypto_req_done() will wakeup
 	 * crypto_wait_req(); if the backend of acomp is scomp, the callback
@@ -859,15 +863,17 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);
 
+	acomp_ctx->buffer = buffer;
+	acomp_ctx->acomp = acomp;
+	acomp_ctx->is_sleepable = acomp_is_async(acomp);
+	acomp_ctx->req = req;
 	mutex_unlock(&acomp_ctx->mutex);
 	return 0;
 
-req_fail:
-	crypto_free_acomp(acomp_ctx->acomp);
-acomp_fail:
-	kfree(acomp_ctx->buffer);
-buffer_fail:
-	mutex_unlock(&acomp_ctx->mutex);
+fail:
+	if (acomp)
+		crypto_free_acomp(acomp);
+	kfree(buffer);
 	return ret;
 }
 


