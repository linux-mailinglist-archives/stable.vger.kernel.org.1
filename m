Return-Path: <stable+bounces-43208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F518BEFB8
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965711C21268
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892D77F2C;
	Tue,  7 May 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oiiqPEwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3D71B3B
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120413; cv=none; b=ZJAFhRp08uMBlN4n4PnI6ze6SPFGLk0BhgoyWfqG3i7uEeXnNg8pHW0+JpODUaohJAYj8KWwjAKFzyvnTSAk9zJOoQ+jSbHus5FXV6x7jxb3esXqFp6YH+ijHIwzETaNMAKyp5U45ICqubRVjyDK0n3atp3+82go2LNws6YEOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120413; c=relaxed/simple;
	bh=OpKKbbIRNJ88a6U77/yAvkEYCvZCIpynYQeYTAW+5y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fervWTqUpQIod4nfWsGqG51SI86G36py6ottq2O7rKflU7JGQVZwP2UYAenlyws5vfdf5133Rn8kvb1xiAUVHNDDdVNdmpGy//p0npd3vm9CXQOc+BMiBFe3s2qPmSmK7CYRghdtChvApBDEJyjei1D5Cw3cEWJcUJc5ujzmzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oiiqPEwl; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120412; x=1746656412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROO7ctBB4C21iBrSWhEmmTi3HFTNAwA1l7hE9hyEXqs=;
  b=oiiqPEwl6UA4GGbWjAhFWBzyFADW2ICem7S8CLxwv1F9I+fuMQzSVDbZ
   U03HLaib+xRk1vM54xlCPD9dlHDM1H0DX23MmF7lHLyT/i9nOZhZSyKZU
   I+4m161aRye1FhbrxCM14DxX6xE2dGi2XA9NmdSs1dLIlhciP5c/HWpng
   0=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="87621856"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:20:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:18396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.164:2525] with esmtp (Farcaster)
 id a7259f85-f99f-4fc6-a73c-30cc58f1919d; Tue, 7 May 2024 22:20:11 +0000 (UTC)
X-Farcaster-Flow-ID: a7259f85-f99f-4fc6-a73c-30cc58f1919d
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:20:11 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:20:11 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>, valis
	<sec@valis.email>, Simon Horman <horms@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 4/5] tls: fix race between async notify and socket close
Date: Tue, 7 May 2024 22:18:05 +0000
Message-ID: <20240507221806.30480-5-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240507221806.30480-1-shaoyi@amazon.com>
References: <20240507221806.30480-1-shaoyi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Jakub Kicinski <kuba@kernel.org>

commit aec7961916f3f9e88766e2688992da6980f11b8d upstream.

The submitting thread (one which called recvmsg/sendmsg)
may exit as soon as the async crypto handler calls complete()
so any code past that point risks touching already freed data.

Try to avoid the locking and extra flags altogether.
Have the main thread hold an extra reference, this way
we can depend solely on the atomic ref counter for
synchronization.

Don't futz with reiniting the completion, either, we are now
tightly controlling when completion fires.

Reported-by: valis <sec@valis.email>
Fixes: 0cada33241d9 ("net/tls: fix race condition causing kernel panic")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[v5.15: fixed contextual conflicts in struct tls_sw_context_rx and func
init_ctx_rx; replaced DEBUG_NET_WARN_ON_ONCE with BUILD_BUG_ON_INVALID
since they're equivalent when DEBUG_NET is not defined]
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 include/net/tls.h |  5 -----
 net/tls/tls_sw.c  | 43 ++++++++++---------------------------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index dcd6aa08c067..59ff5c901ab5 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -128,9 +128,6 @@ struct tls_sw_context_tx {
 	struct tls_rec *open_rec;
 	struct list_head tx_list;
 	atomic_t encrypt_pending;
-	/* protect crypto_wait with encrypt_pending */
-	spinlock_t encrypt_compl_lock;
-	int async_notify;
 	u8 async_capable:1;
 
 #define BIT_TX_SCHEDULED	0
@@ -148,8 +145,6 @@ struct tls_sw_context_rx {
 	struct sk_buff *recv_pkt;
 	u8 async_capable:1;
 	atomic_t decrypt_pending;
-	/* protect crypto_wait with decrypt_pending*/
-	spinlock_t decrypt_compl_lock;
 };
 
 struct tls_record_info {
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 614cb30dae13..40b96780e13d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -220,22 +220,15 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 
 	kfree(aead_req);
 
-	spin_lock_bh(&ctx->decrypt_compl_lock);
-	if (!atomic_dec_return(&ctx->decrypt_pending))
+	if (atomic_dec_and_test(&ctx->decrypt_pending))
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
 
 static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
 {
-	int pending;
-
-	spin_lock_bh(&ctx->decrypt_compl_lock);
-	reinit_completion(&ctx->async_wait.completion);
-	pending = atomic_read(&ctx->decrypt_pending);
-	spin_unlock_bh(&ctx->decrypt_compl_lock);
-	if (pending)
+	if (!atomic_dec_and_test(&ctx->decrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	atomic_inc(&ctx->decrypt_pending);
 
 	return ctx->async_wait.err;
 }
@@ -271,6 +264,7 @@ static int tls_do_decryption(struct sock *sk,
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
 					  tls_decrypt_done, skb);
+		BUILD_BUG_ON_INVALID(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
 		aead_request_set_callback(aead_req,
@@ -460,7 +454,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
 	bool ready = false;
-	int pending;
 
 	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
@@ -495,12 +488,8 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 			ready = true;
 	}
 
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	pending = atomic_dec_return(&ctx->encrypt_pending);
-
-	if (!pending && ctx->async_notify)
+	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
 
 	if (!ready)
 		return;
@@ -512,22 +501,9 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
 {
-	int pending;
-
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-	if (pending)
+	if (!atomic_dec_and_test(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-	else
-		reinit_completion(&ctx->async_wait.completion);
-
-	/* There can be no concurrent accesses, since we have no
-	 * pending encrypt operations
-	 */
-	WRITE_ONCE(ctx->async_notify, false);
+	atomic_inc(&ctx->encrypt_pending);
 
 	return ctx->async_wait.err;
 }
@@ -571,6 +547,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Add the record in tx_list */
 	list_add_tail((struct list_head *)&rec->list, &ctx->tx_list);
+	BUILD_BUG_ON_INVALID(atomic_read(&ctx->encrypt_pending) < 1);
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
@@ -2312,7 +2289,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
 	}
 
 	crypto_init_wait(&sw_ctx_tx->async_wait);
-	spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
 	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
 	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
 	sw_ctx_tx->tx_work.sk = sk;
@@ -2333,7 +2310,7 @@ static struct tls_sw_context_rx *init_ctx_rx(struct tls_context *ctx)
 	}
 
 	crypto_init_wait(&sw_ctx_rx->async_wait);
-	spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
+	atomic_set(&sw_ctx_rx->decrypt_pending, 1);
 	skb_queue_head_init(&sw_ctx_rx->rx_list);
 
 	return sw_ctx_rx;
-- 
2.40.1


