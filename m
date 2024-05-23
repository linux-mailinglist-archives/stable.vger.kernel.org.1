Return-Path: <stable+bounces-45763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DEC8CD3C2
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6246728356F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F2E14A4F0;
	Thu, 23 May 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPJN5VJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083A81E497;
	Thu, 23 May 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470292; cv=none; b=VNQDMp79V8nkW4ys1A+QkEJZce4W7KD06yynge6cSjFWAj2E+0DTZcTQgp6t2tzKIPROnKZhqyCx0dehqugvy4CdZILrvU5goDhostAlv5Yq8FZTAwumZPLHaNK4ar7bi0j9mPsANWh4txt1EzWQ/zD/fQ7AvU3DXrIOnTC5wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470292; c=relaxed/simple;
	bh=qyc0NXrU59JpXoUwAJxg2Tu6GugVSO4+qbdbpJQskWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHdaZZyPp+vy9zzzc41yJFKRtmsNYh6invoi8Ex2WHRd4Rzg/gw3rjbMLawulndEm71k3+CNF+y14TlywV7zT5N9WYDwrnWLP4hH5JN/YK80fWLj/SwJvyNy0KjdIpEVmflJvuIpwoW7Bwkx2TytsZdTtw9cS02kpUkYFwpcAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPJN5VJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBCDC2BD10;
	Thu, 23 May 2024 13:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470291;
	bh=qyc0NXrU59JpXoUwAJxg2Tu6GugVSO4+qbdbpJQskWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPJN5VJmOk0z35OBxbESRzZ9+vt03aTj49X6Ohbw/0tNxzQy15UHiS9uyb07R3up0
	 EkyL1B5TuaUU/IPDAbTJTR0sXoNFdWMH76zm6T3McE7QEd3da2xn18yky2Zqj3vjsu
	 YwhxAhHmZLCrlZCCmhAdxTumS0jojUKDLhPnjHZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Shaoying Xu <shaoyi@amazon.com>
Subject: [PATCH 5.15 10/23] net: tls: factor out tls_*crypt_async_wait()
Date: Thu, 23 May 2024 15:13:06 +0200
Message-ID: <20240523130328.342478955@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
References: <20240523130327.956341021@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |   90 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -226,6 +226,20 @@ static void tls_decrypt_done(struct cryp
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
@@ -496,6 +510,28 @@ static void tls_encrypt_done(struct cryp
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
@@ -946,7 +982,6 @@ int tls_sw_sendmsg(struct sock *sk, stru
 	int num_zc = 0;
 	int orig_size;
 	int ret = 0;
-	int pending;
 
 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
 			       MSG_CMSG_COMPAT))
@@ -1115,24 +1150,12 @@ trim_sgl:
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
+		int err;
 
-		/* There can be no concurrent accesses, since we have no
-		 * pending encrypt operations
-		 */
-		WRITE_ONCE(ctx->async_notify, false);
-
-		if (ctx->async_wait.err) {
-			ret = ctx->async_wait.err;
+		/* Wait for pending encryptions to get completed */
+		err = tls_encrypt_async_wait(ctx);
+		if (err) {
+			ret = err;
 			copied = 0;
 		}
 	}
@@ -1910,22 +1933,14 @@ pick_next_record:
 
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
@@ -2144,16 +2159,9 @@ void tls_sw_release_resources_tx(struct
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
 



