Return-Path: <stable+bounces-43207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79B8BEFB7
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE751F23875
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6F77F2C;
	Tue,  7 May 2024 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="orMq5oZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BDB71B3B
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120390; cv=none; b=brq+c15uSlmIBhmSJ65GTOqYcVjGEDwjTEsaLDLJqJ0CPlw/kWkJEp4f7XwGFdzpFiobWkUgXWd7v9lvqepR8fe9I/bL91tD88zDNjql7WiDQWZ7gWVwu2mXTqCnye7XMNq9easz/BQRkwxiwMO+FBkNOY2z6dsI77UELhV4IH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120390; c=relaxed/simple;
	bh=jo2+LKgcGQPi+/KqVeamSn2CJXRgsgdBAIgfcsl/qgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0WaH0zcVOfbRN+0vdLSOI0TKGh8r47oA+YseAU1LIILH2U5ZXkCA7lw2/GPNH5WC9g1DqFsv5lBzGHzjmkusZ0AX34Gz2o1XCgBLDQXRAL2TFInxsmgSIaA5JKVio0i5Z1aJYYbR3KUSQ6maAjprkEHF+utmOBWLD0PpPElNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=orMq5oZ9; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120389; x=1746656389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pilBR6sjUaGlqq8D0PR+8A4Ba24hcuWCDjOJGigAlXs=;
  b=orMq5oZ9jvflG7b8VdNzcnlxCpQiOPAniYJB7Fd6VrsHFFWKdW50f/Fd
   9uuJ7lvfG0Wd8qUQa8jdyKuDo8ASuSsFJtidj+CiM9Quwzwy1xdx84C1a
   nID0MurfqqTISewTU0jyYzVaHOZ2yqfjx3g252fvbdxq3Jy8x+LvBDJw/
   E=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="203766697"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:19:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:47932]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.241:2525] with esmtp (Farcaster)
 id 8d3c9a4c-1e0d-4293-aad4-b29bb3285bc9; Tue, 7 May 2024 22:19:47 +0000 (UTC)
X-Farcaster-Flow-ID: 8d3c9a4c-1e0d-4293-aad4-b29bb3285bc9
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:19:47 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:19:46 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 3/5] net: tls: factor out tls_*crypt_async_wait()
Date: Tue, 7 May 2024 22:18:04 +0000
Message-ID: <20240507221806.30480-4-shaoyi@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Jakub Kicinski <kuba@kernel.org>

commit c57ca512f3b68ddcd62bda9cc24a8f5584ab01b1 upstream.

Factor out waiting for async encrypt and decrypt to finish.
There are already multiple copies and a subsequent fix will
need more. No functional changes.

Note that crypto_wait_req() returns wait->err

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aec7961916f3 ("tls: fix race between async notify and socket close")
[v5.15: removed changes in tls_sw_splice_eof and adjusted waiting factor out for
async descrypt in tls_sw_recvmsg]
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 net/tls/tls_sw.c | 90 ++++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 40d1f205c92f..614cb30dae13 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -226,6 +226,20 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 	spin_unlock_bh(&ctx->decrypt_compl_lock);
 }
 
+static int tls_decrypt_async_wait(struct tls_sw_context_rx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->decrypt_compl_lock);
+	reinit_completion(&ctx->async_wait.completion);
+	pending = atomic_read(&ctx->decrypt_pending);
+	spin_unlock_bh(&ctx->decrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_decryption(struct sock *sk,
 			     struct sk_buff *skb,
 			     struct scatterlist *sgin,
@@ -496,6 +510,28 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
+static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+{
+	int pending;
+
+	spin_lock_bh(&ctx->encrypt_compl_lock);
+	ctx->async_notify = true;
+
+	pending = atomic_read(&ctx->encrypt_pending);
+	spin_unlock_bh(&ctx->encrypt_compl_lock);
+	if (pending)
+		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	else
+		reinit_completion(&ctx->async_wait.completion);
+
+	/* There can be no concurrent accesses, since we have no
+	 * pending encrypt operations
+	 */
+	WRITE_ONCE(ctx->async_notify, false);
+
+	return ctx->async_wait.err;
+}
+
 static int tls_do_encryption(struct sock *sk,
 			     struct tls_context *tls_ctx,
 			     struct tls_sw_context_tx *ctx,
@@ -946,7 +982,6 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int num_zc = 0;
 	int orig_size;
 	int ret = 0;
-	int pending;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			       MSG_CMSG_COMPAT))
@@ -1115,24 +1150,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	if (!num_async) {
 		goto send_end;
 	} else if (num_zc) {
-		/* Wait for pending encryptions to get completed */
-		spin_lock_bh(&ctx->encrypt_compl_lock);
-		ctx->async_notify = true;
-
-		pending = atomic_read(&ctx->encrypt_pending);
-		spin_unlock_bh(&ctx->encrypt_compl_lock);
-		if (pending)
-			crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-		else
-			reinit_completion(&ctx->async_wait.completion);
-
-		/* There can be no concurrent accesses, since we have no
-		 * pending encrypt operations
-		 */
-		WRITE_ONCE(ctx->async_notify, false);
+		int err;
 
-		if (ctx->async_wait.err) {
-			ret = ctx->async_wait.err;
+		/* Wait for pending encryptions to get completed */
+		err = tls_encrypt_async_wait(ctx);
+		if (err) {
+			ret = err;
 			copied = 0;
 		}
 	}
@@ -1910,22 +1933,14 @@ int tls_sw_recvmsg(struct sock *sk,
 
 recv_end:
 	if (async) {
-		int pending;
-
 		/* Wait for all previously submitted records to be decrypted */
-		spin_lock_bh(&ctx->decrypt_compl_lock);
-		reinit_completion(&ctx->async_wait.completion);
-		pending = atomic_read(&ctx->decrypt_pending);
-		spin_unlock_bh(&ctx->decrypt_compl_lock);
-		if (pending) {
-			err = crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
-			if (err) {
-				/* one of async decrypt failed */
-				tls_err_abort(sk, err);
-				copied = 0;
-				decrypted = 0;
-				goto end;
-			}
+		err = tls_decrypt_async_wait(ctx);
+		if (err) {
+			/* one of async decrypt failed */
+			tls_err_abort(sk, err);
+			copied = 0;
+			decrypted = 0;
+			goto end;
 		}
 
 		/* Drain records from the rx_list & copy if required */
@@ -2144,16 +2159,9 @@ void tls_sw_release_resources_tx(struct sock *sk)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
 	struct tls_rec *rec, *tmp;
-	int pending;
 
 	/* Wait for any pending async encryptions to complete */
-	spin_lock_bh(&ctx->encrypt_compl_lock);
-	ctx->async_notify = true;
-	pending = atomic_read(&ctx->encrypt_pending);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
-
-	if (pending)
-		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
+	tls_encrypt_async_wait(ctx);
 
 	tls_tx_records(sk, -1);
 
-- 
2.40.1


