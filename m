Return-Path: <stable+bounces-43205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503738BEFB5
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56C3B20F25
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E677F2C;
	Tue,  7 May 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GqXyXcKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471D73163
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120343; cv=none; b=kMGH2XXP6tGT3oYBYuPTIvcQWtTglwIa4LWU4lWHYAkKxzYGna0aWPk9UQKz7B1TVsQNX0v7UJB76aHxWDSBBAqFEJCA/7M18yo04FARYP3Od0y/8cr7ljQQ74SRXCHS7FdMGO23hcgWmq3yJnE3Lfk5LOjN1Esk4cbSHWHEgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120343; c=relaxed/simple;
	bh=bJ41lMeSiCTufLzD3Gjc6VzPyCtiweL1l7ZVoA5e2Ok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2NArYm6sYYJGWi3W6mATlQ3xrZpWe4MGjYBiRrX3bQ9InN95/bpVgAXERY2azy4kunGE7+yIKh9StKX8PFJx2owCm9fRB6XHEdEDJtQjd3f9Vlfnv7ZUDicnROzyr7w/TlXSvQtpaN+NE7JzXYqAIguZdS+qyWmgDdKOkReLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GqXyXcKz; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120343; x=1746656343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJ8isHZ4PBcp+ubMItm06XKGdsZlchU5SlZ6zYPECvs=;
  b=GqXyXcKzHsvgL7vpl7BgLQTsmQU/XC/tMycWwUfG0g28UxTlvO1hwGLk
   sk5wWEkDSjAlqCBq2seyRWXWthWWNzGtsHl1t0g+yLRpZWPo23YjUufSr
   dBdR6h6qpTxJvZGm/ecUPYr1l4dub+khhjVqXkmUp+qlQOQJfqCbEAskk
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="203766596"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:19:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.36:2525] with esmtp (Farcaster)
 id fdbdb1f6-ff11-4265-ae43-9c5b054c2656; Tue, 7 May 2024 22:19:00 +0000 (UTC)
X-Farcaster-Flow-ID: fdbdb1f6-ff11-4265-ae43-9c5b054c2656
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:19:00 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:18:59 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 1/5] tls: rx: simplify async wait
Date: Tue, 7 May 2024 22:18:02 +0000
Message-ID: <20240507221806.30480-2-shaoyi@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Jakub Kicinski <kuba@kernel.org>

commit 37943f047bfb88ba4dfc7a522563f57c86d088a0 upstream.

Since we are protected from async completions by decrypt_compl_lock
we can drop the async_notify and reinit the completion before we
start waiting.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aec7961916f3 ("tls: fix race between async notify and socket close")
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 include/net/tls.h |  1 -
 net/tls/tls_sw.c  | 14 ++------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index ea0aeae26cf7..dcd6aa08c067 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -150,7 +150,6 @@ struct tls_sw_context_rx {
 	atomic_t decrypt_pending;
 	/* protect crypto_wait with decrypt_pending*/
 	spinlock_t decrypt_compl_lock;
-	bool async_notify;
 };
 
 struct tls_record_info {
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc55b65695e5..9c443646417e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -174,7 +174,6 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sg;
 	struct sk_buff *skb;
 	unsigned int pages;
-	int pending;
 
 	skb = (struct sk_buff *)req->data;
 	tls_ctx = tls_get_ctx(skb->sk);
@@ -222,9 +221,7 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 	kfree(aead_req);
 
 	spin_lock_bh(&ctx->decrypt_compl_lock);
-	pending = atomic_dec_return(&ctx->decrypt_pending);
-
-	if (!pending && ctx->async_notify)
+	if (!atomic_dec_return(&ctx->decrypt_pending))
 		complete(&ctx->async_wait.completion);
 	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
@@ -1917,7 +1914,7 @@ int tls_sw_recvmsg(struct sock *sk,
 
 		/* Wait for all previously submitted records to be decrypted */
 		spin_lock_bh(&ctx->decrypt_compl_lock);
-		ctx->async_notify = true;
+		reinit_completion(&ctx->async_wait.completion);
 		pending = atomic_read(&ctx->decrypt_pending);
 		spin_unlock_bh(&ctx->decrypt_compl_lock);
 		if (pending) {
@@ -1929,15 +1926,8 @@ int tls_sw_recvmsg(struct sock *sk,
 				decrypted = 0;
 				goto end;
 			}
-		} else {
-			reinit_completion(&ctx->async_wait.completion);
 		}
 
-		/* There can be no concurrent accesses, since we have no
-		 * pending decrypt operations
-		 */
-		WRITE_ONCE(ctx->async_notify, false);
-
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
 			err = process_rx_list(ctx, msg, &control, copied,
-- 
2.40.1


