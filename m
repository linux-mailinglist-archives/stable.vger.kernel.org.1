Return-Path: <stable+bounces-12912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355518379A9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A791F2786E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737DC5690;
	Tue, 23 Jan 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yfYkKAS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236D5680;
	Tue, 23 Jan 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968396; cv=none; b=O0cvKMZDm8AV3LisCLTlzZU3c3E3cp4S80P48/IA//fd5iqGWqwARpLvqvjHN47Jc/VhHRCsFwztqnUBEfOP4MijH9qwtto5dpVohv955HReDUIrFo7NjTSzXdIA0PXnZ34c4CBZACorRahnjMz+X1cjLeDPj3KHcN3+7+L65cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968396; c=relaxed/simple;
	bh=egmw9To/JGmm8wAft4e1p3V6eIbc9rK2vYeI7sgANN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rO/F9bbQGkqxi3a6osa27PFnd0BEq3V1grfujR09NtYkTSgIwPEv+/RtmpnivRnBrevB08FWY1mJhmjmyaaDCOx0SBc8eDymfjraqqeMjmBxMa+PpVHifWuTqdmrEiKQRZ8tjTgYYxqhf1Y1YxZ7bFvHtW6eBFuELUGeRpIYVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yfYkKAS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B54C433F1;
	Tue, 23 Jan 2024 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968396;
	bh=egmw9To/JGmm8wAft4e1p3V6eIbc9rK2vYeI7sgANN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yfYkKAS0hAhmE32Xq3etUJtV+gwGb63PcX2nODUCfE7dKaU4BFK7IR+zIdyNmxuWI
	 P07MUTnaoXRmjZdlUFn2IoQKnaHKmG/Br/yzviJpc/GgbIlfvx2yXE6kDazuy1So2s
	 SKom/EHVi1JiHnt23efYnU+PIWA8KlZr6uNLkeFc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/148] crypto: scompress - Use per-CPU struct instead multiple variables
Date: Mon, 22 Jan 2024 15:56:56 -0800
Message-ID: <20240122235714.836442629@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 71052dcf4be70be4077817297dcde7b155e745f2 ]

Two per-CPU variables are allocated as pointer to per-CPU memory which
then are used as scratch buffers.
We could be smart about this and use instead a per-CPU struct which
contains the pointers already and then we need to allocate just the
scratch buffers.
Add a lock to the struct. By doing so we can avoid the get_cpu()
statement and gain lockdep coverage (if enabled) to ensure that the lock
is always acquired in the right context. On non-preemptible kernels the
lock vanishes.
It is okay to use raw_cpu_ptr() in order to get a pointer to the struct
since it is protected by the spinlock.

The diffstat of this is negative and according to size scompress.o:
   text    data     bss     dec     hex filename
   1847     160      24    2031     7ef dbg_before.o
   1754     232       4    1990     7c6 dbg_after.o
   1799      64      24    1887     75f no_dbg-before.o
   1703      88       4    1795     703 no_dbg-after.o

The overall size increase difference is also negative. The increase in
the data section is only four bytes without lockdep.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 744e1885922a ("crypto: scomp - fix req->dst buffer overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/scompress.c | 125 ++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 15641c96ff99..3702f1648ea8 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -29,9 +29,17 @@
 #include <crypto/internal/scompress.h>
 #include "internal.h"
 
+struct scomp_scratch {
+	spinlock_t	lock;
+	void		*src;
+	void		*dst;
+};
+
+static DEFINE_PER_CPU(struct scomp_scratch, scomp_scratch) = {
+	.lock = __SPIN_LOCK_UNLOCKED(scomp_scratch.lock),
+};
+
 static const struct crypto_type crypto_scomp_type;
-static void * __percpu *scomp_src_scratches;
-static void * __percpu *scomp_dst_scratches;
 static int scomp_scratch_users;
 static DEFINE_MUTEX(scomp_lock);
 
@@ -65,76 +73,53 @@ static void crypto_scomp_show(struct seq_file *m, struct crypto_alg *alg)
 	seq_puts(m, "type         : scomp\n");
 }
 
-static void crypto_scomp_free_scratches(void * __percpu *scratches)
+static void crypto_scomp_free_scratches(void)
 {
+	struct scomp_scratch *scratch;
 	int i;
 
-	if (!scratches)
-		return;
-
-	for_each_possible_cpu(i)
-		vfree(*per_cpu_ptr(scratches, i));
+	for_each_possible_cpu(i) {
+		scratch = raw_cpu_ptr(&scomp_scratch);
 
-	free_percpu(scratches);
+		vfree(scratch->src);
+		vfree(scratch->dst);
+		scratch->src = NULL;
+		scratch->dst = NULL;
+	}
 }
 
-static void * __percpu *crypto_scomp_alloc_scratches(void)
+static int crypto_scomp_alloc_scratches(void)
 {
-	void * __percpu *scratches;
+	struct scomp_scratch *scratch;
 	int i;
 
-	scratches = alloc_percpu(void *);
-	if (!scratches)
-		return NULL;
-
 	for_each_possible_cpu(i) {
-		void *scratch;
-
-		scratch = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
-		if (!scratch)
-			goto error;
-		*per_cpu_ptr(scratches, i) = scratch;
-	}
-
-	return scratches;
-
-error:
-	crypto_scomp_free_scratches(scratches);
-	return NULL;
-}
+		void *mem;
 
-static void crypto_scomp_free_all_scratches(void)
-{
-	if (!--scomp_scratch_users) {
-		crypto_scomp_free_scratches(scomp_src_scratches);
-		crypto_scomp_free_scratches(scomp_dst_scratches);
-		scomp_src_scratches = NULL;
-		scomp_dst_scratches = NULL;
-	}
-}
+		scratch = raw_cpu_ptr(&scomp_scratch);
 
-static int crypto_scomp_alloc_all_scratches(void)
-{
-	if (!scomp_scratch_users++) {
-		scomp_src_scratches = crypto_scomp_alloc_scratches();
-		if (!scomp_src_scratches)
-			return -ENOMEM;
-		scomp_dst_scratches = crypto_scomp_alloc_scratches();
-		if (!scomp_dst_scratches) {
-			crypto_scomp_free_scratches(scomp_src_scratches);
-			scomp_src_scratches = NULL;
-			return -ENOMEM;
-		}
+		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
+		if (!mem)
+			goto error;
+		scratch->src = mem;
+		mem = vmalloc_node(SCOMP_SCRATCH_SIZE, cpu_to_node(i));
+		if (!mem)
+			goto error;
+		scratch->dst = mem;
 	}
 	return 0;
+error:
+	crypto_scomp_free_scratches();
+	return -ENOMEM;
 }
 
 static int crypto_scomp_init_tfm(struct crypto_tfm *tfm)
 {
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&scomp_lock);
-	ret = crypto_scomp_alloc_all_scratches();
+	if (!scomp_scratch_users++)
+		ret = crypto_scomp_alloc_scratches();
 	mutex_unlock(&scomp_lock);
 
 	return ret;
@@ -146,31 +131,28 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 	void **tfm_ctx = acomp_tfm_ctx(tfm);
 	struct crypto_scomp *scomp = *tfm_ctx;
 	void **ctx = acomp_request_ctx(req);
-	const int cpu = get_cpu();
-	u8 *scratch_src = *per_cpu_ptr(scomp_src_scratches, cpu);
-	u8 *scratch_dst = *per_cpu_ptr(scomp_dst_scratches, cpu);
+	struct scomp_scratch *scratch;
 	int ret;
 
-	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
+		return -EINVAL;
 
-	if (req->dst && !req->dlen) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (req->dst && !req->dlen)
+		return -EINVAL;
 
 	if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
 		req->dlen = SCOMP_SCRATCH_SIZE;
 
-	scatterwalk_map_and_copy(scratch_src, req->src, 0, req->slen, 0);
+	scratch = raw_cpu_ptr(&scomp_scratch);
+	spin_lock(&scratch->lock);
+
+	scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, 0);
 	if (dir)
-		ret = crypto_scomp_compress(scomp, scratch_src, req->slen,
-					    scratch_dst, &req->dlen, *ctx);
+		ret = crypto_scomp_compress(scomp, scratch->src, req->slen,
+					    scratch->dst, &req->dlen, *ctx);
 	else
-		ret = crypto_scomp_decompress(scomp, scratch_src, req->slen,
-					      scratch_dst, &req->dlen, *ctx);
+		ret = crypto_scomp_decompress(scomp, scratch->src, req->slen,
+					      scratch->dst, &req->dlen, *ctx);
 	if (!ret) {
 		if (!req->dst) {
 			req->dst = sgl_alloc(req->dlen, GFP_ATOMIC, NULL);
@@ -179,11 +161,11 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 				goto out;
 			}
 		}
-		scatterwalk_map_and_copy(scratch_dst, req->dst, 0, req->dlen,
+		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
 					 1);
 	}
 out:
-	put_cpu();
+	spin_unlock(&scratch->lock);
 	return ret;
 }
 
@@ -204,7 +186,8 @@ static void crypto_exit_scomp_ops_async(struct crypto_tfm *tfm)
 	crypto_free_scomp(*ctx);
 
 	mutex_lock(&scomp_lock);
-	crypto_scomp_free_all_scratches();
+	if (!--scomp_scratch_users)
+		crypto_scomp_free_scratches();
 	mutex_unlock(&scomp_lock);
 }
 
-- 
2.43.0




