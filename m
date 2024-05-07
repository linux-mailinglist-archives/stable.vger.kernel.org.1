Return-Path: <stable+bounces-43209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB38BEFBA
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 00:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5388EB211AA
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925BB132817;
	Tue,  7 May 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JXGlQy0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44FE71B3B
	for <stable@vger.kernel.org>; Tue,  7 May 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715120445; cv=none; b=d73+N2kcDpRSiz5jIJloSeiBin5egMVYZZHJ5f//0LlQwoWEJ2s/l6xd4c7YiDdouwQGDYACQjHVzJYAnURoNPUBefKHQbT8pHF7x4yppBDS8iwbNbn7uBZagVDc7MJOecm0JD1GT5w3HgXcJakR0n7jgOftit7ao5g76PW1hOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715120445; c=relaxed/simple;
	bh=T3YxmS1P3fHsToK2vUwzwob1KHJ9hl8VFWYufrJgNXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBX52gqU+OahfXzPB0ee5jE3VJ1qjQJe+Z0TdaT5NR9u3V1LAIwmSGC4g+xYcaEEZXq4+NTXyroa26iJxlwmfrIz2lXz6tA1bwlRrhqSjPmfWksULEZlMeWIx58qc4hiu2T4tkH+xG9LaIcXUXLV3juRcA7RfVCiGzgWooZr1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JXGlQy0x; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715120444; x=1746656444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUqp75YtJBX4fSe5a0mSJC7/ac4mrrDygdT0/YCVmA4=;
  b=JXGlQy0xR4YLJF8tYipJY3ikHtSq9geWB9phv/vAb3+rkXfJGVWtAqyp
   senuLoO8COjYlVC2UAVxU1vZtpSeiaiwiCpMEWbg31BYm1GspFeR4IYnN
   6UqJwSxK/0nLKkDKQACnYcYOZoyCVgDOPyH04InKYPx+2yA+pLvD4Nssv
   k=;
X-IronPort-AV: E=Sophos;i="6.08,143,1712620800"; 
   d="scan'208";a="395085691"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 22:20:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:60878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.241:2525] with esmtp (Farcaster)
 id c23cf66a-5a89-447c-b281-a76ab6c8a58e; Tue, 7 May 2024 22:20:41 +0000 (UTC)
X-Farcaster-Flow-ID: c23cf66a-5a89-447c-b281-a76ab6c8a58e
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:20:34 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 7 May 2024 22:20:34 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, <sd@queasysnail.net>, <kuba@kernel.org>, Simon Horman
	<horms@kernel.org>, "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 5/5] net: tls: handle backlogging of crypto requests
Date: Tue, 7 May 2024 22:18:06 +0000
Message-ID: <20240507221806.30480-6-shaoyi@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Jakub Kicinski <kuba@kernel.org>

commit 8590541473188741055d27b955db0777569438e3 upstream.

Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
 -EBUSY instead of -EINPROGRESS in valid situations. For example, when
the cryptd queue for AESNI is full (easy to trigger with an
artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
to the backlog but still processed. In that case, the async callback
will also be called twice: first with err == -EINPROGRESS, which it
seems we can just ignore, then with err == 0.

Compared to Sabrina's original patch this version uses the new
tls_*crypt_async_wait() helpers and converts the EBUSY to
EINPROGRESS to avoid having to modify all the error handling
paths. The handling is identical.

Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[v5.15: fixed contextual merge-conflicts in tls_decrypt_done and tls_encrypt_done]
Cc: <stable@vger.kernel.org> # 5.15
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 net/tls/tls_sw.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 40b96780e13d..90f6cbe5cd5d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -175,6 +175,17 @@ static void tls_decrypt_done(struct crypto_async_request *req, int err)
 	struct sk_buff *skb;
 	unsigned int pages;
 
+	/* If requests get too backlogged crypto API returns -EBUSY and calls
+	 * ->complete(-EINPROGRESS) immediately followed by ->complete(0)
+	 * to make waiting for backlog to flush with crypto_wait_req() easier.
+	 * First wait converts -EBUSY -> -EINPROGRESS, and the second one
+	 * -EINPROGRESS -> 0.
+	 * We have a single struct crypto_async_request per direction, this
+	 * scheme doesn't help us, so just ignore the first ->complete().
+	 */
+	if (err == -EINPROGRESS)
+		return;
+
 	skb = (struct sk_buff *)req->data;
 	tls_ctx = tls_get_ctx(skb->sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
@@ -273,6 +284,10 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EBUSY) {
+		ret = tls_decrypt_async_wait(ctx);
+		ret = ret ?: -EINPROGRESS;
+	}
 	if (ret == -EINPROGRESS) {
 		if (darg->async)
 			return 0;
@@ -455,6 +470,9 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct tls_rec *rec;
 	bool ready = false;
 
+	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
+		return;
+
 	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
 
@@ -551,6 +569,10 @@ static int tls_do_encryption(struct sock *sk,
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
+	if (rc == -EBUSY) {
+		rc = tls_encrypt_async_wait(ctx);
+		rc = rc ?: -EINPROGRESS;
+	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
 		sge->offset -= prot->prepend_size;
-- 
2.40.1


