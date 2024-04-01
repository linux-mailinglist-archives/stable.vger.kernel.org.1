Return-Path: <stable+bounces-34985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F08941C9
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303122832D2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59604644C;
	Mon,  1 Apr 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HD6k+oix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317447A76;
	Mon,  1 Apr 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989960; cv=none; b=YsdUCqT4TjwwRoJejxnMAZotNF9FGOpGw4rSmtJNiCHaXqogN2ur6fcuUTv0ermG5v5b1utjQAajr5LFZdLQajhH+feffyF6CcGIPEey+DMi49TAdDSI3gWb62JJ7ReZH3mJWrg5XL1/ENFWPCctgr/hK0X8iXKolzFEA0JEuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989960; c=relaxed/simple;
	bh=dea3SN8eJfLt8XHiOS4w1nzxanlrEAchloLorrMeLo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFhtanHM0HSq3zAIrBptYh/V1MCNU4xlNLxjCxMCJKoEr40SrzjI6ECbrlyW8W4gJvwYQ4pUGtSlmCY6uXBlm10dftq143i/81NUSlHsMH50NbKrddBCtH5hqdl6O7kOM2+rE62VJcYWlvXb4A1YJfkv7QOw+L2cHUqI4srK6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HD6k+oix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F9C433C7;
	Mon,  1 Apr 2024 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989960;
	bh=dea3SN8eJfLt8XHiOS4w1nzxanlrEAchloLorrMeLo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HD6k+oixIncoEaqS/oHfJ5g4sZJ/NVaDbNeTJ+MJKASadR9exY63xeG6f5PufHx9Y
	 HEbZcefhcDQ+bw2iAijHgJO16OPo9l6FGcJCsQIm3CY7mg+Bo5oxgUQlGNtTRl0UII
	 41J2WQ29cTFgU13mEHQqSevv6pQCI31pefspk4Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.6 204/396] crypto: sun8i-ce - Fix use after free in unprepare
Date: Mon,  1 Apr 2024 17:44:13 +0200
Message-ID: <20240401152554.012035632@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Skvortsov <andrej.skvortzov@gmail.com>

commit 183420038444547c149a0fc5f58e792c2752860c upstream.

sun8i_ce_cipher_unprepare should be called before
crypto_finalize_skcipher_request, because client callbacks may
immediately free memory, that isn't needed anymore. But it will be
used by unprepare after free. Before removing prepare/unprepare
callbacks it was handled by crypto engine in crypto_finalize_request.

Usually that results in a pointer dereference problem during a in
crypto selftest.
 Unable to handle kernel NULL pointer dereference at
                                      virtual address 0000000000000030
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=000000004716d000
 [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] SMP

This problem is detected by KASAN as well.
 ==================================================================
 BUG: KASAN: slab-use-after-free in sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
 Read of size 8 at addr ffff00000dcdc040 by task 1c15000.crypto-/373

 Hardware name: Pine64 PinePhone (1.2) (DT)
 Call trace:
  dump_backtrace+0x9c/0x128
  show_stack+0x20/0x38
  dump_stack_lvl+0x48/0x60
  print_report+0xf8/0x5d8
  kasan_report+0x90/0xd0
  __asan_load8+0x9c/0xc0
  sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
  crypto_pump_work+0x354/0x620 [crypto_engine]
  kthread_worker_fn+0x244/0x498
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Allocated by task 379:
  kasan_save_stack+0x3c/0x68
  kasan_set_track+0x2c/0x40
  kasan_save_alloc_info+0x24/0x38
  __kasan_kmalloc+0xd4/0xd8
  __kmalloc+0x74/0x1d0
  alg_test_skcipher+0x90/0x1f0
  alg_test+0x24c/0x830
  cryptomgr_test+0x38/0x60
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Freed by task 379:
  kasan_save_stack+0x3c/0x68
  kasan_set_track+0x2c/0x40
  kasan_save_free_info+0x38/0x60
  __kasan_slab_free+0x100/0x170
  slab_free_freelist_hook+0xd4/0x1e8
  __kmem_cache_free+0x15c/0x290
  kfree+0x74/0x100
  kfree_sensitive+0x80/0xb0
  alg_test_skcipher+0x12c/0x1f0
  alg_test+0x24c/0x830
  cryptomgr_test+0x38/0x60
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 The buggy address belongs to the object at ffff00000dcdc000
  which belongs to the cache kmalloc-256 of size 256
 The buggy address is located 64 bytes inside of
  freed 256-byte region [ffff00000dcdc000, ffff00000dcdc100)

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 4136212ab18e ("crypto: sun8i-ce - Remove prepare/unprepare request")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 1262a7773ef3..de50c00ba218 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -299,22 +299,6 @@ static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req
 	return err;
 }
 
-static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
-{
-	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
-	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
-	struct sun8i_ce_dev *ce = op->ce;
-	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
-	int flow, err;
-
-	flow = rctx->flow;
-	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
-	local_bh_disable();
-	crypto_finalize_skcipher_request(engine, breq, err);
-	local_bh_enable();
-}
-
 static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 				      void *async_req)
 {
@@ -360,6 +344,23 @@ static void sun8i_ce_cipher_unprepare(struct crypto_engine *engine,
 	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 }
 
+static void sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ce_dev *ce = op->ce;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
+	int flow, err;
+
+	flow = rctx->flow;
+	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
+	sun8i_ce_cipher_unprepare(engine, areq);
+	local_bh_disable();
+	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
+}
+
 int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 {
 	int err = sun8i_ce_cipher_prepare(engine, areq);
@@ -368,7 +369,6 @@ int sun8i_ce_cipher_do_one(struct crypto_engine *engine, void *areq)
 		return err;
 
 	sun8i_ce_cipher_run(engine, areq);
-	sun8i_ce_cipher_unprepare(engine, areq);
 	return 0;
 }
 
-- 
2.44.0




