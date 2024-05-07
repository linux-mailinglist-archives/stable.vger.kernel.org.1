Return-Path: <stable+bounces-43206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF58BEFB6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EC61C2145F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F4D77F2C;
	Tue,  7 May 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n6a506qV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37877658
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120368; cv=none; b=tnlZwkgZ718ozf99J+zsStkVnupX5Wiby/PSQEhZPYeJpAW4lYZ8bu33hYJ5rKlcG/haH6lPfTVywF20eIUDcOK2sKKwIlcvJFeaUuBDjn+64XtE3VXSI54A+ZrWw2PWnTQnx8RVZOKAmWEa+Ydcd8MUzwm8881fObQyHtDCCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120368; c=relaxed/simple;
	bh=KBr9k4EEzIzf9AmScp1Ropx6VraCQCLYHU/o0R428KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKsMqdaVUw1eQTZps5gzfRZMlgncX+J2LyBVTpiLbv3aS3PwpG8fASOk+2UiUQeI5O8DFQccEl4ux6Fv4jixFbaqzOt4jxfPFZQas0fI8t85t2+0wJ4TEp3TLv0b1my1AAKBVKD6QxarV2vZtQlC6wXhN9HIBHi6GGxovtSutvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n6a506qV; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120367; x=1746656367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM6PSCE9J2+ETleQjeqtSFOVkNl87WD48HhXawRAvSc=;
  b=n6a506qVeBhResjodl/NSzn5FajZh4ZHorgxnIgIJCw33vz13BD1Bik6
   fyCvuZMRcNiBlpY7mNQxDmMX8xYh1aNVzN7aaJRnmjJ8zz3Z3oVySwtUw
   puIX5QHEq8NgwAAUc72UFB+AKdtXwgxr1Pr7nrvMqBMsMrxl0Acm9aQBG
   c=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="203766624"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:19:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:32703]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.78:2525] with esmtp (Farcaster)
 id c81584fa-22a7-44c0-bac1-7192313ee9c2; Tue, 7 May 2024 22:19:24 +0000 (UTC)
X-Farcaster-Flow-ID: c81584fa-22a7-44c0-bac1-7192313ee9c2
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:19:23 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:19:23 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>, "David S .
 Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 2/5] tls: extract context alloc/initialization out of tls_set_sw_offload
Date: Tue, 7 May 2024 22:18:03 +0000
Message-ID: <20240507221806.30480-3-shaoyi@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Sabrina Dubroca <sd@queasysnail.net>

commit 615580cbc99af0da2d1c7226fab43a3d5003eb97 upstream.

Simplify tls_set_sw_offload a bit.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aec7961916f3 ("tls: fix race between async notify and socket close")
[v5.15: fixed contextual conflicts from unavailable init_waitqueue_head and
skb_queue_head_init calls in tls_set_sw_offload and init_ctx_rx]
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 net/tls/tls_sw.c | 82 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9c443646417e..40d1f205c92f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2291,6 +2291,46 @@ void tls_sw_strparser_arm(struct sock *sk, struct tls_context *tls_ctx)
 	strp_check_rcv(&rx_ctx->strp);
 }
 
+static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct sock *sk)
+{
+	struct tls_sw_context_tx *sw_ctx_tx;
+
+	if (!ctx->priv_ctx_tx) {
+		sw_ctx_tx = kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
+		if (!sw_ctx_tx)
+			return NULL;
+	} else {
+		sw_ctx_tx = ctx->priv_ctx_tx;
+	}
+
+	crypto_init_wait(&sw_ctx_tx->async_wait);
+	spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
+	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
+	sw_ctx_tx->tx_work.sk = sk;
+
+	return sw_ctx_tx;
+}
+
+static struct tls_sw_context_rx *init_ctx_rx(struct tls_context *ctx)
+{
+	struct tls_sw_context_rx *sw_ctx_rx;
+
+	if (!ctx->priv_ctx_rx) {
+		sw_ctx_rx = kzalloc(sizeof(*sw_ctx_rx), GFP_KERNEL);
+		if (!sw_ctx_rx)
+			return NULL;
+	} else {
+		sw_ctx_rx = ctx->priv_ctx_rx;
+	}
+
+	crypto_init_wait(&sw_ctx_rx->async_wait);
+	spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
+	skb_queue_head_init(&sw_ctx_rx->rx_list);
+
+	return sw_ctx_rx;
+}
+
 int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2317,46 +2357,22 @@ int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
 	}
 
 	if (tx) {
-		if (!ctx->priv_ctx_tx) {
-			sw_ctx_tx = kzalloc(sizeof(*sw_ctx_tx), GFP_KERNEL);
-			if (!sw_ctx_tx) {
-				rc = -ENOMEM;
-				goto out;
-			}
-			ctx->priv_ctx_tx = sw_ctx_tx;
-		} else {
-			sw_ctx_tx =
-				(struct tls_sw_context_tx *)ctx->priv_ctx_tx;
-		}
-	} else {
-		if (!ctx->priv_ctx_rx) {
-			sw_ctx_rx = kzalloc(sizeof(*sw_ctx_rx), GFP_KERNEL);
-			if (!sw_ctx_rx) {
-				rc = -ENOMEM;
-				goto out;
-			}
-			ctx->priv_ctx_rx = sw_ctx_rx;
-		} else {
-			sw_ctx_rx =
-				(struct tls_sw_context_rx *)ctx->priv_ctx_rx;
-		}
-	}
+		ctx->priv_ctx_tx = init_ctx_tx(ctx, sk);
+		if (!ctx->priv_ctx_tx)
+			return -ENOMEM;
 
-	if (tx) {
-		crypto_init_wait(&sw_ctx_tx->async_wait);
-		spin_lock_init(&sw_ctx_tx->encrypt_compl_lock);
+		sw_ctx_tx = ctx->priv_ctx_tx;
 		crypto_info = &ctx->crypto_send.info;
 		cctx = &ctx->tx;
 		aead = &sw_ctx_tx->aead_send;
-		INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
-		INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
-		sw_ctx_tx->tx_work.sk = sk;
 	} else {
-		crypto_init_wait(&sw_ctx_rx->async_wait);
-		spin_lock_init(&sw_ctx_rx->decrypt_compl_lock);
+		ctx->priv_ctx_rx = init_ctx_rx(ctx);
+		if (!ctx->priv_ctx_rx)
+			return -ENOMEM;
+
+		sw_ctx_rx = ctx->priv_ctx_rx;
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
-		skb_queue_head_init(&sw_ctx_rx->rx_list);
 		aead = &sw_ctx_rx->aead_recv;
 	}
 
-- 
2.40.1


