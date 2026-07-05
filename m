Return-Path: <stable+bounces-272106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 25F7ADTUSmo9IQEAu9opvQ
	(envelope-from <stable+bounces-272106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 00:01:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAA70B8A9
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 00:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CSVja2Qd;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272106-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8AF0300C327
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A261359A90;
	Sun,  5 Jul 2026 22:01:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A72FE56E
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 22:01:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783288882; cv=none; b=k6WP4WhrH6KIs74mY5nD/1q63EJBd0HbnEegeNPdDFHWQ5NKcOSwcDZC3XHRiTbKiu9eCbGAQmuI6crGDl7kN4PgQtWgmmGANjTEmZn1sQmrF4JEPWOaubiJbevSvJ+d38UEJJWw+yUSs0IqqiZwfyhhYfhM0Td82SZnrucJ2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783288882; c=relaxed/simple;
	bh=J4FjOshJ6RBO/3MOt+VmllNZWiRL7HFHiixP5bQuZpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5iLNTkgmqONgQbc09P9W/xoDO/uhxwZ0WZM0QYGQkhdZPs6wTYNQonJmDiNWLelaHXfeUD3cGW6kHl36DjA/D/QdeMemo75nqTSFnshnibznfjK+qUJECz0XALbk/qqUJCIEmaZMpHflhIC9Yx2KtnPWkcIyVPRzNa8Py0SpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSVja2Qd; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c83474ddso22113005e9.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783288879; x=1783893679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YvlYxiNAfYjqJ5SupCEKeoITyZXsujlTXQzFGXeco6M=;
        b=CSVja2Qd2GVOBY8yspmioTVFtOKkhfQDERDH08vdH/sskCSTGK53XUr9g4Y3rY50/h
         ipwBnXRE/OjGi9nQdRmHp+f5VwdzOsiF32GElB54z6GvYwTGfkkMAc/m5xlQAQbDC6/1
         bBEaSBUyeYbd8hJqoL3zGJhr9aUDAcdYsBIkw4nhdcohNhjWq7PwxFEVkA9lBM6Qm+Ur
         BgGmmtRy1Uflo/zXO2Zxn1IGfR7V3rXJmOv0+DVESiirWUFmSVcjR2Nlo0QqJSPMByT5
         9fDWW5td9iuFzD0zD2FJJB6e0S2STpycg3LgsRYjcOa0oPitIY9UfpxQiJ4odppQ1PZc
         Ld3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783288879; x=1783893679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvlYxiNAfYjqJ5SupCEKeoITyZXsujlTXQzFGXeco6M=;
        b=ib+Oa2NEElW6mD8hrZoX01qzBXpaayBLBawenyhwiL+JMKgnAJAJVA/Kiib3oJFqo5
         J7OEM+kL8eqYwx2zuN9qSGLE9mSRihZ90DcLqXjo5QURRYAT2vuB3IM8yJZ2lomiw61n
         RxjLsFlcKpPGGpcmX20k+Q+YY0FcaC8OmMFbS2sTXiAZYVVMEMa6i5bms/ESKyCh++3A
         BRQoyDgxTw8qgAG6y91RBkZNHYe3YfcE07QHEdYs6jG9geiSxks9QO75M1bFznzNDDdt
         FbnScl6e7HquO86ZlmCUagzVZ7hUnDDKwqIgvIzPRl9WLgp2+00Sygaom+zPwr7i7dI3
         zqEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpopocnjCSlMbBHph5qeI1Rhi/pML0BtaNdO065ISuIsIq5aQMFE2L+UsyDefiw7fdo633GuIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/tBcZ7UhvRvNPPLXJzfj8bmaKP6pnspWJnTFQG4AEihToMNU
	m+DCSEf+IESMXtkOOPRJA/z1XSnvVr0SOiRrF8sV2qg8rnULCqxpAjCA
X-Gm-Gg: AfdE7ckhxq9Oza4ARevUq2oVdHoC+770xgBng44L+R897g73rr0frWuZHd+Apdht8oO
	R07/CwjLOC6Fte+wpxA0u/q7vraQ1hzGquo6US9VZQu2jEz6cP7P/hCbzvxx/3WKRLvzbSnwyt+
	JicEnEgFcvaZQporRqizgDCwVy39qfgjpEEVYRh43t+54x0WsRmL97XGrGaOxtCls+PvWHzZfCT
	ZrIJPlEHz9cYOoQPyhvjquOpog7JWKRxeu+bJZ7PwafmbfVqUzFCFTS7VcVq+ZH6D58VmHJWNbI
	5i3Ca3jRL3RBxafkVbQgcs9nADQzevNd/wjjhLl59lpTOQSrPTecROefgp8XMugIXUjj4gxUW5B
	kkh4RA9xOsLqf8E7aszBYkWLY6KM/cm5r3bSBPtr+Emp1uIgPRB7/1adFj4zaYq7yKuiNgM2dth
	DwOhq7hulRuObJw/5LhbgO64UC6w==
X-Received: by 2002:a05:600c:190e:b0:490:469c:556b with SMTP id 5b1f17b1804b1-493d4ee52d9mr64705305e9.12.1783288879237;
        Sun, 05 Jul 2026 15:01:19 -0700 (PDT)
Received: from tt.. ([31.223.44.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm544853265e9.0.2026.07.05.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 15:01:18 -0700 (PDT)
From: =?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
To: herbert@gondor.apana.org.au,
	ebiggers@kernel.org
Cc: linux-crypto@vger.kernel.org,
	stable@vger.kernel.org,
	sashal@kernel.org,
	=?UTF-8?q?Muhammet=20Kaan=20KILIN=C3=87?= <muhammetkaankilinc@gmail.com>
Subject: [PATCH 2/2] crypto: algif_skcipher - force synchronous processing on trees without ctx->state
Date: Sun,  5 Jul 2026 22:01:11 +0000
Message-ID: <20260705220112.2522-3-muhammetkaankilinc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705220112.2522-1-muhammetkaankilinc@gmail.com>
References: <20260705220112.2522-1-muhammetkaankilinc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272106-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[muhammetkaankilinc@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:muhammetkaankilinc@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammetkaankilinc@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71BAA70B8A9

The AIO/async path in skcipher_recvmsg() passes the socket-wide ctx->iv
directly into the skcipher request. After io_submit() the socket lock is
dropped and the request is processed asynchronously, so a concurrent
sendmsg(ALG_SET_IV) can overwrite ctx->iv and make the in-flight request
run under an attacker-controlled IV. For CTR/stream modes this is
IV/keystream reuse and lets an unprivileged user recover the plaintext of
a concurrent operation.

Newer trees snapshot ctx->iv per request and rely on ctx->state
(crypto_skcipher_import/export) to carry the chained IV. These trees lack
ctx->state and chain the IV in-place, so a per-request snapshot alone
would break MSG_MORE chaining, and a snapshot plus completion-time
writeback would reintroduce a race on ctx->iv outside the socket lock.

Make the operation synchronous instead, which removes both the IV race and
any writeback race. This mirrors the upstream resolution, commit
fcc77d33a34c ("net: Remove support for AIO on sockets"), which removed the
AIO socket path entirely. io_submit() now completes synchronously; AF_ALG
async is rarely used in practice.

Tested on 6.6.y: attacker IV injection dropped from 2296/200000 to 0/200000
after the change; MSG_MORE chunked CTR output bit-identical to single-shot.

Reported-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muhammet Kaan KILINÇ <muhammetkaankilinc@gmail.com>
---
 crypto/algif_skcipher.c | 49 +++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index e31b1da58..b12df4544 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -109,33 +109,20 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 
-	if (msg->msg_iocb && !is_sync_kiocb(msg->msg_iocb)) {
-		/* AIO operation */
-		sock_hold(sk);
-		areq->iocb = msg->msg_iocb;
-
-		/* Remember output size that will be generated. */
-		areq->outlen = len;
-
-		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
-					      CRYPTO_TFM_REQ_MAY_SLEEP,
-					      af_alg_async_cb, areq);
-		err = ctx->enc ?
-			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
-			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req);
-
-		/* AIO operation in progress */
-		if (err == -EINPROGRESS)
-			return -EIOCBQUEUED;
-
-		sock_put(sk);
-	} else {
-		/* Synchronous operation */
-		skcipher_request_set_callback(&areq->cra_u.skcipher_req,
-					      CRYPTO_TFM_REQ_MAY_SLEEP |
-					      CRYPTO_TFM_REQ_MAY_BACKLOG,
-					      crypto_req_done, &ctx->wait);
-		err = crypto_wait_req(ctx->enc ?
-			crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
-			crypto_skcipher_decrypt(&areq->cra_u.skcipher_req),
-						 &ctx->wait);
-	}
+	/*
+	 * Force synchronous processing.  The async (AIO) path passed the
+	 * socket-wide ctx->iv into the request, which the worker
+	 * dereferenced after the socket lock was dropped, letting a
+	 * concurrent sendmsg(ALG_SET_IV) inject an attacker IV.  Mainline
+	 * removed the AIO socket path in commit fcc77d33a34c ("net: Remove
+	 * support for AIO on sockets"); these stable trees lack the
+	 * per-request ctx->state used by newer kernels, so the minimal safe
+	 * fix is to always complete synchronously.
+	 */
+	skcipher_request_set_callback(&areq->cra_u.skcipher_req,
+				      CRYPTO_TFM_REQ_MAY_SLEEP |
+				      CRYPTO_TFM_REQ_MAY_BACKLOG,
+				      crypto_req_done, &ctx->wait);
+	err = crypto_wait_req(ctx->enc ?
+		crypto_skcipher_encrypt(&areq->cra_u.skcipher_req) :
+		crypto_skcipher_decrypt(&areq->cra_u.skcipher_req),
+				      &ctx->wait);
 
-- 
2.43.0


