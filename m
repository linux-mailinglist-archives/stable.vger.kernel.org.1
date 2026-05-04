Return-Path: <stable+bounces-243377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIKlGPqq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D22BE4BF141
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791B63044F15
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB393B19D1;
	Mon,  4 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZDzved9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BD40DFD4;
	Mon,  4 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903729; cv=none; b=i8IB/2obVMYz943k4pwZNJYGQPCGoEW6t1M/7sOIsaBthjODHngeiNkQOndNbUzyxUAZEDi6u/Qh8Z+gqbLeC7JBahXM7fMMMxhvvKp7cRhFzHcGYg6qAUt2iPeDBKaxGduQ1gVMRPsOPiR8lMQYo8Bqmg5S4pQ/GKXh0oPMnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903729; c=relaxed/simple;
	bh=E9nRFzuHYQuY+ibly1LgQVxu0jQq5HyGi+kZ9xBtomM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF279ocj3I6V/iwJiGWGsH5LcISf/gk3oQs1W3wHHZFjZBvP1Hn2Kzcg3lKcsNgP4fsWjD/uNDAe7srCN4tq4gmuMdxrXTwTq8tBWm8S2zCtAjqUYQJJC0ON7FwhGbYxRhe5ajG/c24eQQa+eJ/gOBrddZi/bwZN/Fa+ie1PtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZDzved9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E356C2BCB8;
	Mon,  4 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903729;
	bh=E9nRFzuHYQuY+ibly1LgQVxu0jQq5HyGi+kZ9xBtomM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZDzved9+ikzFpW2CnvooumCClUNLKFxOyeVVB6UTTVVGxgRST2CdHZbjqYpox4tO
	 UFe9tMQ/j6/U2jqKNzgERKhczjzalDnZwfGAuDVOY5ZR9Gv3SA3LxfXdfBiEC5VYHH
	 HCoNct0GM1sWWVd7RkVHTyO2H76tKPVJCW1bbx50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Luxing Yin <tr0jan@lzu.edu.cn>,
	Yucheng Lu <kanolyc@gmail.com>,
	Douya Le <ldy3087146292@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 039/275] crypto: algif_aead - snapshot IV for async AEAD requests
Date: Mon,  4 May 2026 15:49:39 +0200
Message-ID: <20260504135144.390722573@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D22BE4BF141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243377-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,gondor.apana.org.au];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douya Le <ldy3087146292@gmail.com>

commit 5aa58c3a572b3e3b6c786953339f7978b845cc52 upstream.

AF_ALG AEAD AIO requests currently use the socket-wide IV buffer during
request processing.  For async requests, later socket activity can
update that shared state before the original request has fully
completed, which can lead to inconsistent IV handling.

Snapshot the IV into per-request storage when preparing the AEAD
request, so in-flight operations no longer depend on mutable socket
state.

Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
Tested-by: Yucheng Lu <kanolyc@gmail.com>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/algif_aead.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -72,8 +72,10 @@ static int _aead_recvmsg(struct socket *
 	struct af_alg_ctx *ctx = ask->private;
 	struct crypto_aead *tfm = pask->private;
 	unsigned int as = crypto_aead_authsize(tfm);
+	unsigned int ivsize = crypto_aead_ivsize(tfm);
 	struct af_alg_async_req *areq;
 	struct scatterlist *rsgl_src, *tsgl_src = NULL;
+	void *iv;
 	int err = 0;
 	size_t used = 0;		/* [in]  TX bufs to be en/decrypted */
 	size_t outlen = 0;		/* [out] RX bufs produced by kernel */
@@ -125,10 +127,14 @@ static int _aead_recvmsg(struct socket *
 
 	/* Allocate cipher request for current operation. */
 	areq = af_alg_alloc_areq(sk, sizeof(struct af_alg_async_req) +
-				     crypto_aead_reqsize(tfm));
+				     crypto_aead_reqsize(tfm) + ivsize);
 	if (IS_ERR(areq))
 		return PTR_ERR(areq);
 
+	iv = (u8 *)aead_request_ctx(&areq->cra_u.aead_req) +
+	     crypto_aead_reqsize(tfm);
+	memcpy(iv, ctx->iv, ivsize);
+
 	/* convert iovecs of output buffers into RX SGL */
 	err = af_alg_get_rsgl(sk, msg, flags, areq, outlen, &usedpages);
 	if (err)
@@ -187,7 +193,7 @@ static int _aead_recvmsg(struct socket *
 
 	/* Initialize the crypto operation */
 	aead_request_set_crypt(&areq->cra_u.aead_req, tsgl_src,
-			       areq->first_rsgl.sgl.sgt.sgl, used, ctx->iv);
+			       areq->first_rsgl.sgl.sgt.sgl, used, iv);
 	aead_request_set_ad(&areq->cra_u.aead_req, ctx->aead_assoclen);
 	aead_request_set_tfm(&areq->cra_u.aead_req, tfm);
 



